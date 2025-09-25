local ranksTable = {}
local rankTime = 2592000

local allowedRanks = {
    ['vip'] = true
}

local ranksItems = {
    ['vip'] = { 
        { item = 'ticket_vip', duration = 7 },
        { item = 'ticket_vip2', duration = 30 }
    },

    ['svip'] = { 
        { item = 'ticket_svip', duration = 7 },
        { item = 'ticket_svip2', duration = 30 }
    },

    ['sponsor'] = { 
        { item = 'ticket_sponsor', duration = 7 },
        { item = 'ticket_sponsor2', duration = 30 }
    }
}

MySQL.ready(function()
    MySQL.query('SELECT premiumgroup, identifier FROM users', {}, function(data)
        if data then
            for i = 1, #data do
                if data[i].premiumgroup then
                    ranksTable[data[i].identifier] = json.decode(data[i].premiumgroup)
                end
            end
        end
	end)
end)

AddEventHandler('esx:playerLoaded', function(source, xPlayer)
    if ranksTable[xPlayer.identifier] then
        for rankName, time in pairs(ranksTable[xPlayer.identifier]) do
            if time >= os.time() then
                exports['InDropPayments']:NadajJakaChceszRangePozdro(xPlayer.source, {"1276531921211625482"})
                -- exports['InDropPayments']:ZajebRangePozdro(xPlayer.source, {"1276531921211625482"})
                xPlayer.set('premiumgroup', rankName)
            else
                xPlayer.set('premiumgroup', false)
                ranksTable[xPlayer.identifier][rankName] = nil
                if next(ranksTable[xPlayer.identifier]) == nil then
                    exports['InDropPayments']:ZajebRangePozdro(xPlayer.source, {"1276531921211625482"})
                    ranksTable[xPlayer.identifier] = nil
                end
                MySQL.update('UPDATE users SET premiumgroup = ? WHERE identifier = ?', {json.encode(ranksTable[xPlayer.identifier]), xPlayer.identifier})
            end
        end
    else
        xPlayer.set('premiumgroup', false)
    end
end)

RegisterCommand('addPremiumGroup', function(source, args)
    if source == 0 then
        local xPlayer = ESX.GetPlayerFromId(tonumber(args[1]))
        if not xPlayer then return end
        --print("TEST")
        local rank = args[2]
        if allowedRanks[rank] then
            xPlayer.showNotification("Otrzymales Range VIP", "info")
            print("Gracz " .. GetPlayerName(source) .. " (ID: " .. source .. ") otrzymał Range VIP!")
            xPlayer.set('premiumgroup', rank)
            ranksTable[xPlayer.identifier] = {
                [rank] = os.time() + rankTime
            }
            MySQL.update.await('UPDATE users SET premiumgroup = ? WHERE identifier = ?', {json.encode(ranksTable[xPlayer.identifier]), xPlayer.identifier})
        end
    end
end, false)

RegisterCommand('removePremiumGroup', function(source, args)
    if source == 0 then
        local xPlayer = ESX.GetPlayerFromId(tonumber(args[1]))
        if not xPlayer then return end

        xPlayer.set('premiumgroup', false)
        ranksTable[xPlayer.identifier] = nil
        MySQL.update.await('UPDATE users SET premiumgroup = ? WHERE identifier = ?', {nil, xPlayer.identifier})
    end
end, false)


RegisterCommand('vip', function(source, args, rawCommand)
    local xPlayer = ESX.GetPlayerFromId(source)
    if xPlayer then
        local identifier = xPlayer.identifier
        if ranksTable[identifier] then
            for rank, expirationTime in pairs(ranksTable[identifier]) do
                local remainingTime = expirationTime - os.time()
                if remainingTime > 0 then
                    local daysLeft = math.floor(remainingTime / (24 * 60 * 60))
                    local hoursLeft = math.floor((remainingTime % (24 * 60 * 60)) / (60 * 60))
                    xPlayer.showNotification('Pozostało Ci jeszcze '..daysLeft..' dni i '..hoursLeft..' godzin VIP-a.', 'info')
                else
                    xPlayer.showNotification('Twój VIP wygasł.', 'error')
                    ranksTable[identifier][rank] = nil
                    if next(ranksTable[identifier]) == nil then
                        ranksTable[identifier] = nil
                    end
                    MySQL.update.await('UPDATE users SET premiumgroup = ? WHERE identifier = ?', {json.encode(ranksTable[identifier]), identifier})
                end
            end
        else
            xPlayer.showNotification('Nie posiadasz VIP-a.', 'error')
        end
    end
end)

for rank, items in pairs(ranksItems) do
    for _, data in ipairs(items) do
        ESX.RegisterUsableItem(data.item, function(source)
            local xPlayer = ESX.GetPlayerFromId(source)
            xPlayer.removeInventoryItem(data.item, 1)
            xPlayer.set('premiumgroup', rank)
            ranksTable[xPlayer.identifier] = ranksTable[xPlayer.identifier] or {}
            local expirationTime = os.time() + (data.duration * 24 * 60 * 60)
            ranksTable[xPlayer.identifier][rank] = expirationTime
            MySQL.update.await('UPDATE users SET premiumgroup = ? WHERE identifier = ?', {json.encode(ranksTable[xPlayer.identifier]), xPlayer.identifier})
            xPlayer.showNotification('Odebrano rangę: '..rank..'. Ranga wygasa za '..data.duration..' dni.', 'success')
        end)
    end
end