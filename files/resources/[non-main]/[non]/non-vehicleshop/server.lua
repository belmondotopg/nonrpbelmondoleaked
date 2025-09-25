local categories, vehicles = {}, {}

CreateThread(function()
	local char = Config.PlateLetters
	char = char + Config.PlateNumbers

	if Config.PlateUseSpace then
		char = char + 1
	end

	if char > 8 then
		exports['non']:ServerDebugPrint({type = "WARNING", message = ('Plate character count reached, %s/8 characters!'):format(char)})
	end
end)

AddEventHandler('onResourceStart', function(resourceName)
	if resourceName == GetCurrentResourceName() then
		SQLVehiclesAndCategories()
	end
end)

function SQLVehiclesAndCategories()
	categories = MySQL.query.await('SELECT * FROM vehicle_categories')
	vehicles = MySQL.query.await('SELECT * FROM vehicles')

	GetVehiclesAndCategories(categories, vehicles)
end

function GetVehiclesAndCategories(categories, vehicles)
	for i = 1, #vehicles do
        local vehicle = vehicles[i]
        for j = 1, #categories do
            local category = categories[j]
            if category and vehicle and category.name == vehicle.category then
                vehicle.categoryLabel = category.label
                break
            end
        end
    end

	TriggerClientEvent('esx_vehicleshop:sendCategories', -1, categories)
	TriggerClientEvent('esx_vehicleshop:sendVehicles', -1, vehicles)	
end

function getVehicleFromModel(model)
	for i = 1, #vehicles do
		local vehicle = vehicles[i]
		if vehicle.model == model then
			return vehicle
		end
	end

	return
end

ESX.RegisterServerCallback('esx_vehicleshop:getCategories', function(source, cb)
	cb(categories)
end)

ESX.RegisterServerCallback('esx_vehicleshop:getVehicles', function(source, cb)
	cb(vehicles)
end)

ESX.RegisterServerCallback('esx_vehicleshop:buyVehicle', function(source, cb, model, plate)
	local xPlayer = ESX.GetPlayerFromId(source)
	local modelPrice = getVehicleFromModel(model).price
	local cash, bank = xPlayer.getAccount('money'), xPlayer.getAccount('bank')
	local useBank, useMoney = false, false

	if modelPrice then
		if bank.money >= modelPrice then
			useBank = true
		elseif cash.money >= modelPrice then
			useMoney = true
		end

		if useBank then
			xPlayer.removeAccountMoney('bank', modelPrice)
			exports['non-garages']:addPlayerVehicle(xPlayer.identifier, model, plate)
			xPlayer.showNotification('Pojazd z rejestracją '..plate..' teraz należy do ciebie', 'success')
			cb(true)
			exports['non']:SendLog(source, string.format('Zakupiono pojazd\nModel pojazdu: %s\nRejestracja: %s\nKwota: %s$ (Bank)', model, plate, modelPrice), 'cardealer')
		elseif useMoney then
			xPlayer.removeAccountMoney('money', modelPrice)
			exports['non-garages']:addPlayerVehicle(xPlayer.identifier, model, plate)
			xPlayer.showNotification('Pojazd z rejestracją '..plate..' teraz należy do ciebie', 'success')
			cb(true)
			exports['non']:SendLog(source, string.format('Zakupiono pojazd\nModel pojazdu: %s\nRejestracja: %s\nKwota: %s$ (Gotówka)', model, plate, modelPrice), 'cardealer')
		else
			cb(false)
		end
	end
end)

ESX.RegisterServerCallback('esx_vehicleshop:payTest', function (source, cb)
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	
	if xPlayer.getMoney() >= 5000 then
		xPlayer.removeMoney(5000)
		cb(true)
	else
		cb(false)
	end
end)

ESX.RegisterServerCallback('esx_vehicleshop:isPlateTaken', function(source, cb, plate)
	MySQL.scalar('SELECT plate FROM owned_vehicles WHERE plate = ?', {plate},
	function(result)
		cb(result ~= nil)
	end)
end)