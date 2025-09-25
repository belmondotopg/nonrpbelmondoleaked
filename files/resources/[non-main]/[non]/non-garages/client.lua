local garageVehicles = {
    ["in-garage"] = {},
    ["in-tow"] = {},
    ["in-org"] = {},
};

local vehPagesToStattes = {
    ["garage"] = 0,
    ["tow"] = 1,
    ["org"] = 2,
};

local vehicleStates = {
    [0] = "in-garage",
    [1] = "in-tow",
    [2] = "in-org",
}

CreateThread(function()
    for i=1, #Config.Garages do
        NON.RegisterPlace(Config.Garages[i].Marker, {type = 27, size = vec3(4.5, 4.5, 1.0), dist = 35.0}, nil, function()
            if IsPedInAnyVehicle(PlayerPedId()) then
                local vehicle = GetVehiclePedIsIn(PlayerPedId())
                local vehicleProps = ESX.Game.GetVehicleProperties(vehicle)
                ESX.TriggerServerCallback("non-garages:putVehicle", function(isOwned)
                    if isOwned then
                        ESX.Game.DeleteVehicle(vehicle)
                    end
                end, vehicleProps.plate, vehicleProps)
            else
                ESX.TriggerServerCallback("non-garages:getVehicles", function(vehicles)
                    if vehicles then
                        garageVehicles = {
                            ["in-garage"] = {},
                            ["in-tow"] = {},
                            ["in-org"] = {},
                        }
                        for k, v in pairs(vehicles) do
                            local modelName
                            if tonumber(v.model) then
                                modelName = GetDisplayNameFromVehicleModel(tonumber(v.model))
                            else
                                modelName = v.model
                            end
                            table.insert(garageVehicles[v.state], {
                                state = v.state,
                                model = modelName,
                                plate = v.plate,
                                engine = v.engine / 1000,
                                body = v.body / 1000,
                            })
                        end
                    end
                    ESX.PlayerData = ESX.GetPlayerData()
                    SendNUIMessage({
                        eventName = "nui:switch",
                        isOpen = true,
                    })
                    SetNuiFocus(true, true)
                end)
                
            end
        end, function ()
            ESX.HideUI()
        end, function ()
            ESX.TextUI("Nacisnij ~INPUT_CONTEXT~, aby wyciagnac pojazd")
        end)
        
		if Config.Garages[i].Blip then
			local blip = AddBlipForCoord(Config.Garages[i].Marker)
			SetBlipSprite(blip, 357)
			SetBlipDisplay(blip, 4)
			SetBlipScale(blip, 0.5)
			SetBlipColour(blip, 29)
			SetBlipAsShortRange(blip, true)
			BeginTextCommandSetBlipName("STRING")
			AddTextComponentString('Garaż')
			EndTextCommandSetBlipName(blip)
		end
	end
end)

RegisterNUICallback("/nui-close", function(data, cb)
    SetNuiFocus(false, false);
    cb({ ok = true });
end)

RegisterNUICallback("/vehicles", function(data, cb)
    cb({
        vehicles = garageVehicles[vehicleStates[vehPagesToStattes[data.view]]]
    })
end)

RegisterNUICallback("/select-vehicle", function(data, cb)
    if data.view == "garage" then
        TriggerServerEvent('non-garages:requestVehicleSpawn', data.vehicle.plate);
    elseif data.view == "tow" then
        TriggerServerEvent("non-garages:requestTowVehicle", data.vehicle.plate);
    end
    cb({ ok = true });
end)

RegisterNetEvent("non-garages:finishVehicleSpawn", function(vehicle, properties)
	if not vehicle then return end
	local timeout = 0
	NetworkRequestControlOfNetworkId(vehicle)
	while not NetworkHasControlOfNetworkId(vehicle) do
		if timeout > 10 then print("Something goes wrong, this take longer than expected.") break end
		NetworkRequestControlOfNetworkId(vehicle)
		timeout = timeout+1
		Wait(250)
	end
	vehicle = NetToVeh(vehicle)
	if not DoesEntityExist(vehicle) then return end
	timeout = 0
	NetworkRequestControlOfEntity(vehicle)
	while not NetworkHasControlOfEntity(vehicle) do
		if timeout > 10 then print("Something goes wrong, this take longer than expected.") break end
		NetworkRequestControlOfEntity(vehicle)
		timeout = timeout+1
		Wait(250)
	end
	ESX.Game.AssignDefaultVehicleSettings(vehicle)
	ESX.Game.SetVehicleProperties(vehicle, properties)
	local npc = GetPedInVehicleSeat(vehicle, -1)
	if DoesEntityExist(npc) then
		DeletePed(npc)
	end
	exports['non-locksystem']:giveKeys(vehicle)
	TaskWarpPedIntoVehicle(PlayerPedId(), vehicle, -1)
end)

RegisterNetEvent('non-garages:canTow', function(netid, target)
	if NetworkDoesNetworkIdExist(netid) then
		local vehicle = NetToVeh(netid)
		if DoesEntityExist(vehicle) then
			for i=-1, GetVehicleModelNumberOfSeats(GetEntityModel(vehicle))-2 do
				if not IsVehicleSeatFree(vehicle, i) then
					TriggerServerEvent('non-garages:respondToTow', target)
					break
				end
			end
		end
	end
end)