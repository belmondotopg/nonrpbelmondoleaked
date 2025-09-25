RegisterServerEvent('non_shop:pedalskieitemki')
AddEventHandler('non_shop:pedalskieitemki', function(action, item, count)
    if action == 'cwelbuy' then
        handleBuyItem(source, item, count)
    elseif action == 'cwelsell' then
        handleSellItem(source, item, count)
    else
        print('Invalid action: ' .. action)
    end
end)

function handleBuyItem(source, item, count)
    local buyItem, priceItem, labelItem = nil, nil, nil
    local useBank, useMoney = false, false
    local xPlayer = ESX.GetPlayerFromId(source)
    local cash, bank = xPlayer.getAccount('money').money, xPlayer.getAccount('bank').money

    if count <= 0 then
        xPlayer.showNotification('Nie można kupować ujemnej liczby przedmiotów!', 'error')
        return
    end

    local itemFound = false
    for _, shop in pairs(Config['shops'].items) do
        for _, v in pairs(shop) do
            if v.item == item then
                itemFound = true
                buyItem = v.item
                priceItem = v.price * count
                labelItem = v.label
                break
            end
        end
        if itemFound then
            break
        end
    end

    if not itemFound then
        exports["non-afk"]:fg_BanPlayer(source, 'Próba zakupu niedostępnego przedmiotu', true)
        return
    end

    if buyItem and priceItem and labelItem then
        if xPlayer.canCarryItem(buyItem, count) then
            if xPlayer.getAccount('bank').money >= priceItem then
                useBank = true
            elseif xPlayer.getAccount('money').money >= priceItem then
                useMoney = true
            end

            if not useBank and not useMoney then
                xPlayer.showNotification('Nie posiadasz wystarczająco dużo pieniędzy. Brakuje Ci ' .. math.floor(priceItem - cash) .. '$ gotówki lub ' .. math.floor(priceItem - bank) .. '$ na koncie', 'info')
                return
            end

            if useBank then
                xPlayer.removeAccountMoney('bank', priceItem)
            else
                xPlayer.removeAccountMoney('money', priceItem)
            end
            xPlayer.addInventoryItem(buyItem, count)
            xPlayer.showNotification(string.format('Zakupiono %s (%d) za %d$', labelItem, count, priceItem), 'info')
            exports['non']:SendLog(xPlayer.source, string.format('Zakupiony przedmiot: %s (%d)\nKwota: %d$', labelItem, count, priceItem), 'sklepy')
        else
            xPlayer.showNotification('Brak miejsca w ekwipunku', 'error')
        end
    end
end

function handleSellItem(source, item, count)
    local sellItem, priceItem, labelItem = nil, nil, nil
    local hasItem = false
    local xPlayer = ESX.GetPlayerFromId(source)

    if count <= 0 then
        xPlayer.showNotification('Nie można sprzedać ujemnej liczby przedmiotów!', 'error')
        return
    end

    for k, v in pairs(Config['shops'].items.sell) do
        if v.item == item then
            sellItem = v.item
            priceItem = v.price * count
            labelItem = v.label
            break
        end
    end

    if sellItem and priceItem and labelItem then
        local xItem = xPlayer.getInventoryItem(sellItem)

        if xItem.count >= count then
            hasItem = true
        end

        if not hasItem then
            xPlayer.showNotification('Nie posiadasz wystarczającej ilości przedmiotów do sprzedaży.', 'info')
            return
        end

        local totalPrice = priceItem 
        xPlayer.removeInventoryItem(sellItem, count)
        xPlayer.addAccountMoney('money', totalPrice)
        xPlayer.showNotification(string.format('Sprzedano %s (%d) za %d$', labelItem, count, totalPrice), 'info')
        exports['non']:SendLog(xPlayer.source, string.format('Sprzedany przedmiot: %s (%d)\nKwota: %d$', labelItem, count, totalPrice), 'sklepy')
    end
end