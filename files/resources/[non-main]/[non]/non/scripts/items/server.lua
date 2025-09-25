ESX.RegisterUsableItem('energydrink', function(source)
    local xPlayer = ESX.GetPlayerFromId(source)
    TriggerClientEvent('non:onEnergyDrink', xPlayer.source)
	xPlayer.removeInventoryItem('energydrink', 1)
end)

ESX.RegisterUsableItem('mdma', function(source)
    local xPlayer = ESX.GetPlayerFromId(source)
    local playerId = xPlayer.source

    TriggerClientEvent('non:onMethPooch', playerId)
    xPlayer.removeInventoryItem('mdma', 1)
end)

ESX.RegisterUsableItem('handcuffs', function(source)
    TriggerClientEvent('non:onHandcuffs', source)
end)

ESX.RegisterUsableItem('repairkit', function(source)
    TriggerClientEvent('non:onRepairKit', source)
end)

RegisterServerEvent('non:repairKitAction')
AddEventHandler('non:repairKitAction', function(action)
    local xPlayer = ESX.GetPlayerFromId(source)
    if action == 'give' then
        xPlayer.addInventoryItem('repairkit', 1)  
    elseif action == 'remove' then
        xPlayer.removeInventoryItem('repairkit', 1)
    end
end)

local vestTypes = {
    ['vest_light'] = 25,
    ['vest_medium'] = 50,
    ['vest_heavy'] = 100,
}

for itemName, value in pairs(vestTypes) do
    ESX.RegisterUsableItem(itemName, function(source)
        local xPlayer = ESX.GetPlayerFromId(source)
        TriggerClientEvent('non:useVest', xPlayer.source, value)
        xPlayer.removeInventoryItem(itemName, 1)
    end)
end