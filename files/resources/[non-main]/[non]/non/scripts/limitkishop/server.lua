-- local categories, vehicles = {}, {}

-- CreateThread(function()
-- 	local char = Config['skleplimitki'].PlateLetters
-- 	char = char + Config['skleplimitki'].PlateNumbers
-- 	if Config['skleplimitki'].PlateUseSpace then char = char + 1 end

-- 	if char > 8 then
-- 		print(('[non-skleplimitki] [^3WARNING^7] Plate character count reached, %s/8 characters!'):format(char))
-- 	end
-- end)

-- AddEventHandler('onResourceStart', function(resourceName)
-- 	if resourceName == GetCurrentResourceName() then
-- 		SQLVehiclesAndCategories()
-- 	end
-- end)

-- function SQLVehiclesAndCategories()
-- 	categories = MySQL.query.await('SELECT * FROM vehicle_categories_limitki')
-- 	vehicles = MySQL.query.await('SELECT * FROM vehicles_limitki')

-- 	GetVehiclesAndCategories(categories, vehicles)
-- end

-- function GetVehiclesAndCategories(categories, vehicles)
-- 	for i = 1, #vehicles do
-- 		local vehicle = vehicles[i]
-- 		for j = 1, #categories do
-- 			local category = categories[j]
-- 			if category.name == vehicle.category then
-- 				vehicle.categoryLabel = category.label
-- 				break
-- 			end
-- 		end
-- 	end

-- 	TriggerClientEvent('non-skleplimitki:sendCategories', -1, categories)
-- 	TriggerClientEvent('non-skleplimitki:sendVehicles', -1, vehicles)
-- end

-- function getVehicleFromModel(model)
-- 	for i = 1, #vehicles do
-- 		local vehicle = vehicles[i]
-- 		if vehicle.model == model then
-- 			return vehicle
-- 		end
-- 	end

-- 	return
-- end

-- ESX.RegisterServerCallback('non-skleplimitki:getCategories', function(source, cb)
-- 	cb(categories)
-- end)

-- ESX.RegisterServerCallback('non-skleplimitki:getVehicles', function(source, cb)
-- 	cb(vehicles)
-- end)

-- local getBonItem = "boniklimitowanyez"
-- ESX.RegisterServerCallback('non-skleplimitki:buyVehicle', function(source, cb, model, plate)
-- 	local xPlayer = ESX.GetPlayerFromId(source)
-- 	local modelPrice = getVehicleFromModel(model).price
-- 	local getItem = xPlayer.getInventoryItem(getBonItem).count
-- 	local useItem = false

-- 	if modelPrice then
-- 		if getItem >= tonumber(modelPrice)then
-- 			useItem = true
-- 		end

-- 		if useItem then
-- 			xPlayer.removeInventoryItem(getBonItem, modelPrice)

-- 			MySQL.insert('INSERT INTO owned_vehicles (identifier, owner, plate, vehicle) VALUES (?, ?, ?, ?)', {xPlayer.identifier, xPlayer.discord.name, plate, json.encode({name = model, model = joaat(model), plate = plate})}, function(id)
-- 				exports['non-ui']:addPlayerVehicle(xPlayer.identifier, {
-- 					id = id,
-- 					model = joaat(model),
-- 					type = "home",
-- 					image = model,
-- 					owner = xPlayer.discord.name,
-- 					plate = plate,
-- 					state = 1,
-- 					subowners = json.encode({}),
-- 					subownersSlots = 3,
-- 					engineValue = 1000.0,
-- 					bodyValue = 1000.0,
-- 					vehicle = json.encode({name = model, model = joaat(model), plate = plate}),
-- 				})
-- 				xPlayer.showNotification('Pojazd z rejestracją '..plate..' teraz należy do ciebie', 'success')
-- 				cb(true)
-- 			end)
-- 			exports['non']:SendLog(xPlayer.source, string.format('Zakupiono pojazd limitowany\nModel pojazdu: %s\nRejestracja: %s\nKwota: %s', model, plate, modelPrice), 'cardealer')
-- 		else
-- 			cb(false)
-- 		end
-- 	end
-- end)

-- ESX.RegisterServerCallback('non-skleplimitki:payTest', function (source, cb)
-- 	local _source = source
-- 	local xPlayer = ESX.GetPlayerFromId(_source)
	
-- 	if xPlayer.getMoney() >= 25000 then
-- 		xPlayer.removeMoney(25000)
-- 		cb(true)
-- 	else
-- 		cb(false)
-- 	end
-- end)

-- ESX.RegisterServerCallback('non-skleplimitki:isPlateTaken', function(source, cb, plate)
-- 	MySQL.scalar('SELECT plate FROM owned_vehicles WHERE plate = ?', {plate},
-- 	function(result)
-- 		cb(result ~= nil)
-- 	end)
-- end)