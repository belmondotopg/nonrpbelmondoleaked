local robbers = {}
local playersInHacking = {}

AddEventHandler('esx:playerDropped', function(source)
    if playersInHacking[source] then
        TriggerEvent('non:setBusyPolice', 'remove', playersInHacking[source])
        playersInHacking[source] = nil
    end
end)

MySQL.ready(function()
    local Items = {}
	local items = MySQL.Sync.fetchAll('SELECT name, label FROM items')

	for i=1, #items, 1 do
		Items[items[i].name] = items[i].label
	end

    for bankName, v in pairs(Config['napady'].Banks) do
        for k2, v2 in pairs(Config['napady'].Banks[bankName].Drop) do
            v2.label = Items[v2.name]
        end
    end
end)

RegisterServerEvent('non-robberies:requestConfig')
AddEventHandler('non-robberies:requestConfig', function()
	local _source = source
	TriggerClientEvent('non-robberies:sendConfig', _source, Config['napady'].Banks)
end)

RegisterServerEvent('non-robberies:requestRob')
AddEventHandler('non-robberies:requestRob', function(bank, copsCount)

    local xPlayer = ESX.GetPlayerFromId(source)

    local hackingItem = xPlayer.getInventoryItem(Config['napady'].HackingItem)
    
    local canStart = true
    if hackingItem.count < 1 then
        xPlayer.showNotification('Nie posiadasz '..hackingItem.label, 'error')
        canStart = false
    end

    if Config['napady'].Banks[bank] then
        for k, v in pairs(Config['napady'].Banks[bank].RequiredItems) do
            local inventoryItem = xPlayer.getInventoryItem(v.name)

            if not inventoryItem or inventoryItem.count < v.count then
                if inventoryItem then
                    xPlayer.showNotification('Nie posiadasz '..v.count..'x '..inventoryItem.label, 'error')
                end
                canStart = false
                break
            end
        end
    end

    if canStart then
        if copsCount >= Config['napady'].Banks[bank].PoliceRequired then
            local realPoliceCount = copsCount - exports['non']:getBusyPoliceCount()
            if realPoliceCount < 0 then realPoliceCount = 0 end
            if realPoliceCount >= Config['napady'].Banks[bank].PoliceRequired then

                robbers[xPlayer.source] = true
                playersInHacking[xPlayer.source] = Config['napady'].Banks[bank].PoliceRequired

                TriggerEvent('non:setBusyPolice', 'add', Config['napady'].Banks[bank].PoliceRequired)

                xPlayer.removeInventoryItem(Config['napady'].HackingItem, 1)
                TriggerClientEvent('non-robberies:requestMinigame', xPlayer.source, bank)
            else
                xPlayer.showNotification('Brak wolnych funkcjonariuszy (aktualnie wolnych: '..realPoliceCount..')', 'error')
            end
        else
            xPlayer.showNotification('Wymagana liczba funkcjonariuszy do rozpoczęcia rabunku wynosi: '..Config['napady'].Banks[bank].PoliceRequired, 'error')
        end
    end
end)

RegisterServerEvent('non-robberies:startRob')
AddEventHandler('non-robberies:startRob', function(bank)
    local xPlayer = ESX.GetPlayerFromId(source)

    for k, v in pairs(Config['napady'].Banks[bank].RequiredItems) do
        xPlayer.removeInventoryItem(v.name, v.count)
    end

    PoliceAlert('start', Config['napady'].Banks[bank].bankName, Config['napady'].Banks[bank].coords)

    TriggerClientEvent('non-robberies:robberyState', xPlayer.source, true, bank)

    exports['non']:SendLog(xPlayer.source, string.format('Rozpoczęto napad\nRozpoczęto napad na %s', Config['napady'].Banks[bank].bankName), 'napady')

    playersInHacking[xPlayer.source] = nil
    robbers[xPlayer.source] = ESX.SetTimeout(Config['napady'].Banks[bank].secondsRemaining * 1000, function()
        xPlayer = ESX.GetPlayerFromId(xPlayer.source)
        if xPlayer then
            local finalMoney = math.random(Config['napady'].Banks[bank].money.min, Config['napady'].Banks[bank].money.max)
            xPlayer.addAccountMoney('money', finalMoney)

            if Config['napady'].Banks[bank].Drop then
                local skipNext = false
                for k, v in pairs(Config['napady'].Banks[bank].Drop) do
                    if not skipNext then
                        local chance = math.random(1, 100)
                        if v.chance >= chance then
                            local itemCount = math.random(v.countMin, v.countMax)
                            local itemName = xPlayer.getInventoryItem(v.name).label
                            xPlayer.addInventoryItem(v.name, itemCount)
                            if v.skipNextDrop then
                                skipNext = true
                            end
                        end
                    else
                        if not v.skipNextDrop then
                            skipNext = false
                        end
                    end
                end
            end

            robbers[xPlayer.source] = nil
            
            xPlayer.showNotification('Skradziono '..finalMoney..'$', 'success')

            TriggerClientEvent('non-robberies:robberyState', xPlayer.source, false)
            exports['non']:SendLog(xPlayer.source, string.format('Zakończono napad\nZakończono napad na %s\nZarobek: %d$', Config['napady'].Banks[bank].bankName, finalMoney), 'napady')
        end
        PoliceAlert('end', Config['napady'].Banks[bank].bankName, Config['napady'].Banks[bank].coords)
        SetTimeout(1200 * 1000, function()
            TriggerEvent('non:setBusyPolice', 'remove', Config['napady'].Banks[bank].PoliceRequired)
        end)
    end)
end)

RegisterServerEvent('non-robberies:cancelRobbery')
AddEventHandler('non-robberies:cancelRobbery', function(bank, afterMinigame)
    if robbers[source] then
        ESX.ClearTimeout(robbers[source])
        robbers[source] = nil
        TriggerEvent('non:setBusyPolice', 'remove', Config['napady'].Banks[bank].PoliceRequired)
        if not afterMinigame then
            PoliceAlert('end', Config['napady'].Banks[bank].bankName, Config['napady'].Banks[bank].coords)
            local xPlayer = ESX.GetPlayerFromId(source)
            exports['non']:SendLog(xPlayer.source, string.format('Anulowany napad\nAnulowany napad na %s', Config['napady'].Banks[bank].bankName), 'napady')
        else
            if playersInHacking[source] then
                playersInHacking[source] = nil
            end
        end
    end
end)

function PoliceAlert(stage, bankName, bankCoords)
    local xPlayers = ESX.GetExtendedPlayers('job', 'police')
    for i=1, #(xPlayers) do 
        local xPlayer = xPlayers[i]
        if stage == 'start' then
            TriggerClientEvent('esx:showAdvancedNotification', xPlayer.source, 'Centrala', '~r~Rozpoczęto rabunek', '~r~Rozpoczęto rabunek:~w~ '..bankName, 'CHAR_CALL911')
            TriggerClientEvent('non-robberies:setPoliceBlip', xPlayer.source, true, bankCoords, bankName)
        else
            TriggerClientEvent('esx:showAdvancedNotification', xPlayer.source, 'Centrala', '~g~Zakończono rabunek', '~g~Zakończono rabunek:~w~ '..bankName, 'CHAR_CALL911')
            TriggerClientEvent('non-robberies:setPoliceBlip', xPlayer.source, false, false, bankName)
        end
    end
end