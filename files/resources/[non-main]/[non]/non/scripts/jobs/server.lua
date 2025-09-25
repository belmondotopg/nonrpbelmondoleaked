-- ESX.RegisterServerCallback('jobs:getReward', function(src, cb, jobName, payChecks)
--     local xPlayer = ESX.GetPlayerFromId(src)
--     local salary = 0

--     local deliveries = ""

--     for i = 1, #payChecks do
--         salary = salary + payChecks[i]
--         deliveries = deliveries.."**["..i.."]** "..payChecks[i].."$\n"
--     end

--     exports['non']:SendLog(xPlayer.source, string.format('%s\nIlość kursów: %d %s\nŁącznie zarobił %d$', jobName, #payChecks, deliveries, salary), 'jobs')

--     xPlayer.addAccountMoney('bank', salary)
--     TriggerClientEvent('non:showNotification', src, {
--         type = 'success',
--         title = 'Praca',
--         text = "Wypłacono: "..salary.."$"
--     })

-- 	cb()
-- end)

-- ESX.RegisterServerCallback('jobs:SpawnVehicle', function(src, cb, model, coords)
--     local vehicle = CreateVehicle(model, coords, true, true)

--     while not DoesEntityExist(vehicle) do
--         Wait(10)
--     end

--     while GetVehiclePedIsIn(GetPlayerPed(src), false) ~= vehicle do
--         Wait(10)
--         SetPedIntoVehicle(GetPlayerPed(src), vehicle, -1)
--     end

--     SetVehicleDoorsLocked(vehicle, 4)
-- 	cb(NetworkGetNetworkIdFromEntity(vehicle))
-- end)

-- ESX.RegisterServerCallback('jobs:SpawnTrailer', function(src, cb, model, coords)
--     local vehicle = CreateVehicle(model, coords, true, true)

--     while not DoesEntityExist(vehicle) do
--         Wait(10)
--     end

--     WhiteListedEntities[vehicle] = true
--     print("dodano wl: "..vehicle)
-- 	cb(NetworkGetNetworkIdFromEntity(vehicle))
-- end)

-- ESX.RegisterServerCallback('jobs:SpawnObj', function(src, cb, model, coords, heading)
--     local object = CreateObject(model, coords.x, coords.y, coords.z, true, true, false)
--     SetEntityHeading(object, heading)

--     while not DoesEntityExist(object) do
--         Wait(10)
--     end

--     WhiteListedEntities[object] = true
-- 	cb(NetworkGetNetworkIdFromEntity(object))
-- end)


-- local usedPlaces = {}

-- ESX.RegisterServerCallback('jobs:isPlaceTaked', function(src, cb, place)
--     if usedPlaces[place] then
--         cb(false)
--     else
--         usedPlaces[place] = true
--         print("zarezerwowano: "..place)
--         cb(true)
--     end
-- end)

-- ESX.RegisterServerCallback('jobs:freeUpPlace', function(src, cb, place)
--     if place then
--         usedPlaces[place] = nil
--         print("zwolniono: "..place)
--     else
--         print("miejsce było nilem")
--     end
--     cb()
-- end)


-- RegisterNetEvent("jobs:RemoveEntityFromWhiteList", function(netId)
--     print("usunięcie z wl: "..NetworkGetEntityFromNetworkId(netId))
--     WhiteListedEntities[NetworkGetEntityFromNetworkId(netId)] = nil
-- end)