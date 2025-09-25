ESX.RegisterCommand('konkurs', 'wlasciciel', function(xPlayer, args, showError)
    if xPlayer then return end
    local type = args[1]
    local ilosc = tonumber(args[2])
    local cotakiego = args[3]
    
    if not type or not ilosc or not cotakiego then
        exports['non']:ServerDebugPrint({type = "info", message = "Poprawne użycie: /konkurs <coins/ranga> <ilosc wygranych> <ilosc/ranga>"})
        return
    end

    local players = ESX.GetPlayers()
    print("Aktualna liczba graczy na serwerze:", #players)
    exports['non']:ServerDebugPrint({type = "info", message = "Aktualna liczba graczy na serwerze: ".. #players})

    if #players < ilosc then
        exports['non']:ServerDebugPrint({type = "info", message = "Na serwerze nie ma wystarczającej liczby graczy"})
        return
    end

    local winners = {}
    while #winners < ilosc do
        local randomPlayer = players[math.random(1, #players)]
        table.insert(winners, randomPlayer)
    end

    for _, winner in ipairs(winners) do
        local xTarget = ESX.GetPlayerFromId(winner)
        exports['non']:ServerDebugPrint({type = "info", message = "Przyznawanie nagrody dla gracza ID: ".. winner})
        if type == "coins" then
            -- local CurrentCoins = GetPlayerCoins(xTarget.source)
            -- local NewCoins = CurrentCoins + tonumber(cotakiego)

            xTarget.showNotification('Gratulacje! Wygrales ' .. tonumber(cotakiego) .. ' coinow.')
        elseif type == "ranga" then
            xTarget.showNotification('Gratulacje! Wygrales rangę: ' .. cotakiego .. '.')
        end
    end

    local Ziutekktorywygralpozdro = {}
    for _, winner in ipairs(winners) do
        local discordnamedlaziomka = ESX.GetPlayerFromId(winner)
        table.insert(Ziutekktorywygralpozdro, discordnamedlaziomka.discord.name)
    end

    TriggerClientEvent("non-chat", -1, {
        label = "fa-solid fa-gift",
        color = "#fff",
    }, {
        background = "#237d23",
        type = "Konkurs",
        name = "Losowanie",
        content = "wygral/li: " .. table.concat(Ziutekktorywygralpozdro, ', ').. ", Zglos sie po nagrode na discord (discord.gg/nonrp)"
    })
end, true)

CreateThread(function()
    while true do
        Wait(5 * 60 * 1000)
        local players = ESX.GetPlayers()
        for _, playerId in ipairs(players) do
            TriggerClientEvent('txcl:showAnnouncement', playerId, "Przypominamy że na naszym serwerze jest wymagana inicjacja oraz zapraszamy na elektrownie!", "NonRP")
        end
    end
end)
