AddEventHandler('esx:playerDropped', function(playerId, reason)
    local xPlayer = ESX.GetPlayerFromId(playerId)

    TriggerClientEvent('non:playerLeft', -1, {
        source = xPlayer.source,
        name = xPlayer.discord.name,
        coords = GetEntityCoords(GetPlayerPed(xPlayer.source)),
        date = os.date("%Y/%m/%d %H:%M")
    })
end)