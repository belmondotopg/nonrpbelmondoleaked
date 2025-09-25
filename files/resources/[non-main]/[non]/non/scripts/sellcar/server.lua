ESX.RegisterServerCallback('non_sellvehicle:requestPlayerCars', function(source, cb, plate)
    local xPlayer = ESX.GetPlayerFromId(source)

    if not xPlayer then
        print("Gracz nie znaleziony.")
        return
    end

    if not plate or plate == "" then
        print("Numer rejestracyjny pojazdu nieprawidłowy.")
        return
    end

    MySQL.Async.fetchAll(
        'SELECT * FROM owned_vehicles WHERE owner = @identifier AND owner_type = 1',
        {
            ['@identifier'] = xPlayer.identifier
        },
        function(result)
            if not result then
                print("Nie znaleziono pojazdów dla gracza.")
                return
            end

            local found = false

            for i=1, #result, 1 do
                local vehicleProps = json.decode(result[i].vehicle)

                if vehicleProps and vehicleProps.plate and ESX.Math.Trim(vehicleProps.plate) == ESX.Math.Trim(plate) then
                    found = true
                    break
                end
            end

            cb(found)
        end
    )
end)


RegisterServerEvent('non_sellvehicle:denysell')
AddEventHandler('non_sellvehicle:denysell', function (seller)
	TriggerClientEvent('esx:showNotification', seller, '~r~Obywatel odrzucił twoją ofertę sprzedaży')
	TriggerClientEvent('esx:showNotification', source, '~r~Odrzuciłeś ofertę sprzedaży')
end)

RegisterServerEvent('non_sellvehicle:acceptsell')
AddEventHandler('non_sellvehicle:acceptsell', function(playerId, vehicleProps, price)
	newsource = source
	local xPlayer = ESX.GetPlayerFromId(newsource)
	local xPlayerplayerId = ESX.GetPlayerFromId(playerId)
	local account = xPlayer.getAccount('bank')

	if account.money >= price then
		MySQL.Async.execute('UPDATE owned_vehicles SET identifier = @identifier WHERE plate = @plate',
		{
			['@identifier']   = xPlayer.identifier,
			['@plate']   = vehicleProps.plate
		},
		function(rowsChanged)
			TriggerClientEvent('esx:showNotification', playerId, '~g~Gratulacje, sprzedałeś pojazd')
			TriggerClientEvent('non_sellvehicle:finish', playerId, newsource)
			TriggerClientEvent('esx:showNotification', newsource, '~g~Gratulacje, kupiłeś ten pojazd')
			xPlayerplayerId.addAccountMoney('bank', price)
			xPlayer.removeAccountMoney('bank', price)
			exports['non']:SendLog(xPlayer.source, string.format('Sprzedał pojazd dla\nID: %s\nNick: %s\nLicencja: %s\nza kwotę: %s$\nRejestracja: %s', xPlayer.source, xPlayer.name, xPlayer.identifier, price, vehicleProps.plate), 'sellcar')
		end)
	else
		TriggerClientEvent('esx:showNotification', newsource, '~r~Nie masz wystarczająco pieniędzy aby zakupić ten pojazd!')
		TriggerClientEvent('esx:showNotification', playerId, '~r~Obywatel nie miał wystarczająco pieniędzy aby zakupić twój pojazd!')
	end
end)

RegisterServerEvent('non_sellvehicle:requestserver')
AddEventHandler('non_sellvehicle:requestserver', function (playerId, vehicleProps, money)
	local _source = source
	TriggerClientEvent('non_sellvehicle:requestclient', playerId, vehicleProps, money, _source)
	TriggerClientEvent('esx:showNotification', _source, '~g~Wysłano ofertę sprzedaży pojazdu')
end)

RegisterServerEvent('non_sellvehicle:menuinput')
AddEventHandler('non_sellvehicle:menuinput', function (price)
	TriggerClientEvent('non_sellvehicle:begin', source, price)
end)

ESX.RegisterCommand('sprzedajpojazd', 'user', function(xPlayer, args, showError)
	xPlayer.triggerEvent('non_sellvehicle:menuinput')
end, false)