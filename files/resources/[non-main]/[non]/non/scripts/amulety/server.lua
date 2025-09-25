local activeTotems = {}

ESX.RegisterServerCallback("non-amulety:getAvailableTotems", function(source, cb)
    local xPlayer = ESX.GetPlayerFromId(source)
    local availableTotems = {}

    for totem, data in pairs(Config['amulety']) do
        if xPlayer.getInventoryItem(totem).count > 0 then
            availableTotems[totem] = true
        else
            availableTotems[totem] = false
        end
    end

    cb(availableTotems)
end)

for totem, data in pairs(Config['amulety']) do
    ESX.RegisterUsableItem(totem, function(source)
        local xPlayer = ESX.GetPlayerFromId(source)
        if not activeTotems[xPlayer.source] then activeTotems[xPlayer.source] = {} end

        if activeTotems[xPlayer.source][totem] and activeTotems[xPlayer.source][totem] > os.time() then
            xPlayer.showNotification("Musisz odczekać przed kolejnym użyciem tego amuletu.")
            return
        end

        if xPlayer.getInventoryItem(totem).count > 0 then
            TriggerClientEvent('non-amulety:useTotem', source, totem)
            activeTotems[xPlayer.source][totem] = os.time() + 50
        else
            xPlayer.showNotification("Nie posiadasz tego amuletu.")
        end
    end)
end