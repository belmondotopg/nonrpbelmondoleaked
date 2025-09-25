local currentHour
local usedStrefa = {}

function GetOrgExtendedPlayers()
    local xPlayers =  ESX.GetExtendedPlayers()
    local orgPlayers = {}
    for i = 1, #xPlayers do
        if string.find(xPlayers[i].job.name, "org") then
            orgPlayers[#orgPlayers+1] = xPlayers[i]
        end
    end

    return orgPlayers
end

CreateThread(function()
    currentHour = tonumber(os.date("%H"))
    Wait(5000)
    while true do
        TriggerClientEvent("strefy:currentHour", -1, tonumber(os.date("%H")), usedStrefa)

        if currentHour ~= tonumber(os.date("%H")) then
            usedStrefa = {}
            currentHour = tonumber(os.date("%H"))
        end

        Wait(30*1000)
    end
end)

local playersWhoCapture = {}

ESX.RegisterServerCallback('strefy:captureStrefa', function(src, cb, strefaID)
    if not usedStrefa[strefaID] and not playersWhoCapture[strefaID] then
        local xPlayers = GetOrgExtendedPlayers()
        local xPlayer = ESX.GetPlayerFromId(src)
        for i = 1, #xPlayers do
            if xPlayer.job.name == xPlayers[i].job.name then
                TriggerClientEvent('non:showNotification', xPlayers[i].source, {
                    type = 'error',
                    title = 'Strefy',
                    text = 'Twoja org przejmuje strefę: ['..Config['strefy'].Zones[strefaID].name..']'
                })
            else
                TriggerClientEvent('non:showNotification', xPlayers[i].source, {
                    type = 'error',
                    title = 'Strefy',
                    text = 'Org: ['..xPlayer.job.label..'] przejmuje strefę: ['..Config['strefy'].Zones[strefaID].name..']'
                })
            end
        end

        playersWhoCapture[strefaID] = src
        cb()
    end
end)

local nagroda = {100000, 150000}

ESX.RegisterServerCallback('strefy:finishCaptureStrefa', function(src, cb, strefaID)
    if not usedStrefa[strefaID] then
        local xPlayer = ESX.GetPlayerFromId(src)

        if playersWhoCapture[strefaID] and playersWhoCapture[strefaID] == src then
            -- AddCapturedStrefa(xPlayer.job.name, Config['strefy'].Zones[strefaID].name)
            local money = math.floor(math.random(nagroda[1], nagroda[2]) * math.sqrt(#GetOrgExtendedPlayers()))

            ManipulateOrgMoney(xPlayer.job.name, money)
            xPlayer.showNotification("Na konto twojej organizacji trafiło "..money.."$ i 5 punktow", "success")
            -- xPlayer.addInventoryItem('pisanka1312pozdro', math.random(5,10))
        end

        playersWhoCapture[strefaID] = nil
        usedStrefa[strefaID] = true

        TriggerClientEvent("strefy:UsedStrefa", -1, usedStrefa)
        cb()
    end
end)

ESX.RegisterServerCallback('strefy:emptyCaptureStrefa', function(src, cb, strefaID)
    if not usedStrefa[strefaID] and playersWhoCapture[strefaID] == src then
        playersWhoCapture[strefaID] = nil
    end
    cb()
end)