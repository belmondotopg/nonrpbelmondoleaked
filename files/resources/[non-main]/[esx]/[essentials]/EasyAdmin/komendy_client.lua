RegisterNetEvent('EasyAdmin:GetCurrentCar')
AddEventHandler('EasyAdmin:GetCurrentCar', function(a)
	local veh = GetVehiclePedIsUsing(PlayerPedId())
	local vehProperties = ESX.Game.GetVehicleProperties(veh)
	TriggerServerEvent('EasyAdmin:SaveCar', vehProperties, a)
	TriggerServerEvent('ashbjkfvavshjkfvhjkl2178t3412', vehProperties, veh, 0, 'vehicle')
end)

RegisterNetEvent('EasyAdmin:Slap')
AddEventHandler('EasyAdmin:Slap', function()
	local ped = PlayerPedId()
	ApplyForceToEntity(ped, 1, 9500.0, 3.0, 7100.0, 1.0, 0.0, 0.0, 1, false, true, false, false)
end)

RegisterNetEvent('EasyAdmin:Slay')
AddEventHandler('EasyAdmin:Slay', function()
	local ped = PlayerPedId()
	SetEntityHealth(ped, 0)
end)

RegisterNetEvent('EasyAdmin:adminList')
AddEventHandler('EasyAdmin:adminList', function(list)
	ESX.UI.Menu.Open('default',GetCurrentResourceName(),"adminlist",
	{ 
	title = "Administratorzy online ("..#list..")", 
	align = "center", 
	elements = list 
	}, function(data, menu)
		
	end, function(data, menu) 
	menu.close() 
	end)
end)

RegisterNetEvent('falszywyy:setSpawn')
AddEventHandler('falszywyy:setSpawn', function(player)
	local target = GetPlayerFromServerId(player)
	local ped = GetPlayerPed(target)
	SetEntityCoords(ped, -428.93957519531, 1110.84375, 327.69595336914,false, false, false, true)
end)