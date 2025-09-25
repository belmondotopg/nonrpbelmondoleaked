for itemName, value in pairs(Config['weaponcomponents'].componentsList) do
    ESX.RegisterUsableItem(itemName, function(source)
        local xPlayer = ESX.GetPlayerFromId(source)
        local compItem = xPlayer.getInventoryItem(itemName)
        TriggerClientEvent('non:useComponent', xPlayer.source, itemName, compItem.count)
    end)
end