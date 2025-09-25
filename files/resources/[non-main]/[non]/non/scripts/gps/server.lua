players_blips = {}

ESX.RegisterUsableItem('gps', function(source)
    local xPlayer = ESX.GetPlayerFromId(source)
    if players_blips[source] == nil then
        TriggerEvent('non-gps:addgps', xPlayer)
        TriggerClientEvent('esx:showNotification', source, "~g~Połączono z nadajnikiem GPS")
    else
        TriggerEvent('non-gps:removegps', source)
    end
end)

AddEventHandler('esx:onRemoveInventoryItem', function(source, item, count)
    if item == 'gps' then
        if count == 0 then
            TriggerEvent('non-gps:removegps', source)
        end
    end
end)

AddEventHandler('playerDropped', function ()
    if players_blips[source] ~= nil then
        players_blips[source] = nil
    end
    TriggerClientEvent('non-gps:removegpsall', -1, source)
    TriggerClientEvent('esx:showNotification', source, "~r~Rozłączono z nadajnikiem GPS")
end)

RegisterServerEvent('non-gps:removegps')
AddEventHandler('non-gps:removegps', function(source)
    if players_blips[source] ~= nil then
        players_blips[source] = nil
    end
    TriggerClientEvent('non-gps:removegpsall', -1, source)
    TriggerClientEvent('non-gps:removegpsforplayer', source)
    TriggerClientEvent('esx:showNotification', source, "~r~Rozłączono z nadajnikiem GPS")
end)

RegisterServerEvent('non-gps:addgps')
AddEventHandler('non-gps:addgps', function(xplayer)
    local ped = GetPlayerPed(xplayer.source)
    local imieGracza = xplayer.discord.name
    local praca = xplayer.job.grade_name
    local nazwapracy = xplayer.job.label
    if players_blips[xplayer.source] == nil then
        if xplayer.job.name == 'police' then
            badge = xplayer.data and xplayer.data.numerodznaki or "BRAK"
            players_blips[xplayer.source] = { source = xplayer.source, job = xplayer.job.name, ped = ped, coords = GetEntityCoords(ped), heading = GetEntityHeading(ped), badge = '[' .. nazwapracy.. '] ('.. badge ..') ' ..imieGracza.. ' - ' ..praca }
        end
        TriggerClientEvent('non-gps:refresh', -1, players_blips)
    end
end)

CreateThread(function()
    while players_blips do
        for k, v in pairs(players_blips) do
            if GetPlayerPed(v.source) ~= 0 then
                v.coords = GetEntityCoords(v.ped)
                v.heading = GetEntityHeading(v.ped)
            end
        end
        TriggerClientEvent('non-gps:refresh', -1, players_blips)
        Wait(1000)
    end
end)