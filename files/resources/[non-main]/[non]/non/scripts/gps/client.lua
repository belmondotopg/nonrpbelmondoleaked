local blips = {}

CreateThread(function()
    AddTextEntryByHash('BLIP_OTHPLYR', 'GPS')
end)

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
	ESX.PlayerData = xPlayer
end)

RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)
	ESX.PlayerData.job = job
end)

local function refresh_blips(player_blips)

    if player_blips[GetPlayerServerId(PlayerId())] == nil then
        return
    end

    for k, v in pairs(blips) do
        if not v.isped then
            RemoveBlip(v.blip)
            blips[k] = nil
        end
    end

    if Config["gps"][ESX.PlayerData.job.name] == nil then
        return
    end

    for k, v in pairs(player_blips) do
        if GetPlayerServerId(PlayerId()) ~= v.source then
            local new_entity = GetPlayerPed(GetPlayerFromServerId(v.source))
            if new_entity == PlayerPedId() then
                local blip = AddBlipForCoord(v.coords)
                SetBlipSprite(blip, 1)
                SetBlipColour(blip, Config["gps"][v.job].color)
                SetBlipScale(blip, 0.8)
                SetBlipCategory(blip, 7)
                SetBlipRotation(blip, math.ceil(v.heading))
                ShowHeadingIndicatorOnBlip(blip, true)
                SetBlipAsShortRange(blip, true)
                BeginTextCommandSetBlipName("STRING")
                AddTextComponentString(v.badge)
                EndTextCommandSetBlipName(blip)
                blips[v.source] = { isped = false, blip = blip, ped = v.ped }
            elseif GetBlipFromEntity(new_entity) == 0 then
                local blip = AddBlipForEntity(new_entity)
                SetBlipSprite(blip, 1)
                SetBlipColour(blip, Config["gps"][v.job].color)
                SetBlipScale(blip, 0.8)
                SetBlipCategory(blip, 7)
                SetBlipRotation(blip, math.ceil(v.heading))
                ShowHeadingIndicatorOnBlip(blip, true)
                SetBlipAsShortRange(blip, true)
                BeginTextCommandSetBlipName("STRING")
                AddTextComponentString(v.badge)
                EndTextCommandSetBlipName(blip)
                blips[v.source] = { isped = true, blip = blip, ped = new_entity }
            end
        end
    end
end

RegisterNetEvent('non-gps:refresh')
AddEventHandler('non-gps:refresh', function(table)
    refresh_blips(table)
end)

RegisterNetEvent('non-gps:removegpsall')
AddEventHandler('non-gps:removegpsall', function(source)
    RemoveBlip(GetBlipFromEntity(GetPlayerPed(GetPlayerFromServerId(source))))
end)

RegisterNetEvent('non-gps:removegpsforplayer')
AddEventHandler('non-gps:removegpsforplayer', function()
    for k, v in pairs(blips) do
        RemoveBlip(v.blip)
        blips[k] = nil
    end
end)

RegisterNetEvent('non-gps:alertpolice')
AddEventHandler('non-gps:alertpolice', function(info, coords)
    if ESX.PlayerData.job ~= nil and (ESX.PlayerData.job.name == 'police' or ESX.PlayerData.job.name == 'ambulance') then
        ESX.ShowNotification("~r~Utracono połączenie z nadajnikiem ~w~" .. info)
        local alpha = 250
        local gpsBlip = AddBlipForCoord(coords.x, coords.y, coords.z)
        SetBlipSprite(gpsBlip, 280)
        SetBlipColour(gpsBlip, 1)
        SetBlipAlpha(gpsBlip, alpha)
        SetBlipScale(gpsBlip, 1.2)
        SetBlipAsShortRange(gpsBlip, true)
        BeginTextCommandSetBlipName("STRING")
        AddTextComponentString("! " .. info)
        EndTextCommandSetBlipName(gpsBlip)

        local blipGPS = AddBlipForCoord(coords.x, coords.y, coords.z)
        SetBlipSprite (blipGPS, 161)
        SetBlipDisplay(blipGPS, 4)
        SetBlipScale  (blipGPS, 2.2)
        SetBlipAlpha(blipGPS, alpha)
        SetBlipColour (blipGPS, 1)
        SetBlipAsShortRange(blipGPS, true)
        PulseBlip(blipGPS)
        BeginTextCommandSetBlipName("STRING")
        AddTextComponentString("! " .. info)
        EndTextCommandSetBlipName(blipGPS)

        for i=1, 35, 1 do
            PlaySound(-1, "Bomb_Disarmed", "GTAO_Speed_Convoy_Soundset", 0, 0, 1)
            Wait(300)
            PlaySound(-1, "OOB_Cancel", "GTAO_FM_Events_Soundset", 0, 0, 1)
            Wait(300)
        end

        while alpha ~= 0 do
            Wait(100 * 4)
            alpha = alpha - 1
            SetBlipAlpha(gpsBlip, alpha)
            SetBlipAlpha(blipGPS, alpha)
            if alpha == 0 then
                RemoveBlip(gpsBlip)
                RemoveBlip(blipGPS)
                return
            end
        end
    end
end)