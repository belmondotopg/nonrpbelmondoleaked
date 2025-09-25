RegisterNetEvent("non_sellvehicle:menuinput")
AddEventHandler("non_sellvehicle:menuinput", function(money)
	ESX.UI.Menu.Open('dialog', GetCurrentResourceName(), 'sell_vehicle_input', {
		title = 'Podaj kwotę za pojazd'
	}, function(data2, menu)

		local price = tonumber(data2.value)
		if price == nil then
			ESX.ShowNotification('~r~Nieprawidłowa wartość')
		else
			menu.close()
			TriggerServerEvent("non_sellvehicle:menuinput", price)
		end

	end, function(data2,menu)
		menu.close()
	end)
end)

RegisterNetEvent("non_sellvehicle:begin")
AddEventHandler("non_sellvehicle:begin", function(money)
	local playerPed = PlayerPedId()
	local coords    = GetEntityCoords(playerPed)

	if IsPedInAnyVehicle(playerPed,  false) then
        vehicle = GetVehiclePedIsIn(playerPed, false)			
    else
        vehicle = GetClosestVehicle(coords.x, coords.y, coords.z, 7.0, 0, 70)
    end

	local plate = GetVehicleNumberPlateText(vehicle)
	local vehicleProps = ESX.Game.GetVehicleProperties(vehicle)

	ESX.TriggerServerCallback('non_sellvehicle:requestPlayerCars', function(isOwnedVehicle)
		if isOwnedVehicle then
			local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
			if closestPlayer == -1 or closestDistance > 3.0 then
				ESX.ShowNotification('~r~Brak graczy w pobliżu!')
			else
  				TriggerServerEvent('non_sellvehicle:requestserver', GetPlayerServerId(closestPlayer), vehicleProps, money)
			end
		else
			ESX.ShowNotification('~r~Pojazd nie należy do ciebie!')
		end
	end, GetVehicleNumberPlateText(vehicle))
end)

RegisterNetEvent('non_sellvehicle:requestclient')
AddEventHandler('non_sellvehicle:requestclient', function(plate, money, seller)
	ESX.UI.Menu.CloseAll()
	ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'resell', {
		title    = 'Czy chcesz odkupić ten pojazd za $' .. money .. '?',
		align    = 'center',
		elements = {
			{ label = 'Tak', value = true },
			{ label = 'Nie', value = false }
		},
	}, function(data, menu)
		menu.close()
		if data.current.value == true then
			TriggerServerEvent('non_sellvehicle:acceptsell', seller, plate, money)
		else
			TriggerServerEvent('non_sellvehicle:denysell', seller)
		end
	end, nil, function()
		TriggerServerEvent('non_sellvehicle:denysell', seller)
	end)
end)

RegisterNetEvent('non_sellvehicle:finish')
AddEventHandler('non_sellvehicle:finish', function()
	local ped = PlayerPedId()
	TaskLeaveVehicle(ped, GetVehiclePedIsIn(ped, false), 4160)
end)