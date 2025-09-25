local queue = {}
local duel = false

local locations = {}
for key, value in pairs(Config['randomteleports'].Locations) do
    locations[#locations+1] = key
end

local function startBattle(player1, player2)
    if not GetPlayerName(player1) or not GetPlayerName(player2) then
        return
    end

    local place = locations[math.random(#locations)]

    TriggerClientEvent('non:showNotification', player1, {
        type = 'duel',
        title = 'Teparki',
        text = 'Arena: '..place..', Przeciwnik: '..GetPlayerName(player2)
    })

    TriggerClientEvent('non:showNotification', player2, {
        type = 'duel',
        title = 'Teparki',
        text = 'Arena: '..place..', Przeciwnik: '..GetPlayerName(player1)
    })

    duel = true
    
    TriggerClientEvent('randomteleports:drawOtherPlayer', player1, player2)
    TriggerClientEvent('randomteleports:drawOtherPlayer', player2, player1)
    
    local player1Coords = GetEntityCoords(GetPlayerPed(player1))
    local player2Coords = GetEntityCoords(GetPlayerPed(player2))
    
    SetEntityCoords(GetPlayerPed(player1), Config['randomteleports'].Locations[place][1])
    SetEntityCoords(GetPlayerPed(player2), Config['randomteleports'].Locations[place][1])
    SetEntityHeading(GetPlayerPed(player1), Config['randomteleports'].Locations[place][1].w)
    SetEntityHeading(GetPlayerPed(player2), Config['randomteleports'].Locations[place][1].w)
    Wait(1)

    local InstanceId = AddPlayersToInstance({player1, player2})

    Wait(1000)
    

    local xPlayer1 = ESX.GetPlayerFromId(player1)
    local xPlayer2 = ESX.GetPlayerFromId(player2)

    local winner
    CreateThread(function()
        Wait(Config['randomteleports'].TimeToDraw * 1000)
        if not winner then
            winner = true
        end
    end)

    while not winner do
        if GetEntityHealth(GetPlayerPed(player1)) == 0 then
            winner = player2
        end
        if GetEntityHealth(GetPlayerPed(player2)) == 0 then
            winner = player1
        end
        Wait(0)
    end

    if type(winner) == 'boolean' then
        TriggerClientEvent('non:showNotification', player1, {
            type = 'duel',
            title = 'Teparki',
            text = 'Biliście się przez lata świetlne więc doszło do remisu...'
        })
        duel = false
        TriggerClientEvent('non:showNotification', player2, {
            type = 'duel',
            title = 'Teparki',
            text = 'Biliście się przez lata świetlne więc doszło do remisu...'
        })
    else
        TriggerClientEvent('non:showNotification', winner, {
            type = 'duel',
            title = 'Teparki',
            text = 'Zwyciężono na arenie: '..place..' z przeciwnikiem: '..(GetPlayerName(winner == player1 and player2 or player1) or 'N/A')
        })
        duel = false
        TriggerClientEvent('non:showNotification', winner == player1 and player2 or player1, {
            type = 'duel',
            title = 'Teparki',
            text = 'Przegrano na arenie: '..place..' z przeciwnikiem: '..(GetPlayerName(winner) or 'N/A')
        })
    end

    Wait(200)
    TriggerClientEvent("esx_ambulancejob:revive", player1, player1Coords)
    TriggerClientEvent("esx_ambulancejob:revive", player2, player2Coords)
    ReturnPlayersToMainInstance(InstanceId)
end

ESX.RegisterServerCallback('randomteleports:start', function(src, cb)
    if queue[src] then
        queue[src] = nil
        TriggerClientEvent('non:showNotification', src, {
            type = 'duel',
            title = 'Teparki',
            text = 'Opuszczono kolejkę'
        })
    else
        local foundOponent
        for player in pairs(queue) do
            foundOponent = player
        end

        if foundOponent then
            queue[foundOponent] = nil

            local seed = math.random(100) > 50
            local player1 = seed and src or foundOponent
            local player2 = seed and foundOponent or src
            startBattle(player1, player2)
        else
            queue[src] = true
            TriggerClientEvent('non:showNotification', src, {
                type = 'duel',
                title = 'Teparki',
                text = 'Dołączono do kolejki'
            })
        end
    end
end)

RegisterNetEvent('randomteleports:exitQueue', function()
    local src = source
    if queue[src] then
        queue[src] = nil
        TriggerClientEvent('non:showNotification', src, {
            type = 'duel',
            title = 'Teparki',
            text = 'Opuszczono kolejkę'
        })
    end
end)