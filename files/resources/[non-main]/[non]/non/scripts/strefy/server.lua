local ktoprzejmuje = {}

sprawdzanko = function(playerCoords, zoneCoords, radius)
    local distance = #(playerCoords - vector3(zoneCoords.x, zoneCoords.y, zoneCoords.z))
    return distance <= radius
end

ESX.RegisterServerCallback('non-strefy:StopPrzejmowanie', function(src, cb, AktualnaStrefa)
    local _source = src
    local xPlayer = ESX.GetPlayerFromId(_source)

    if xPlayer == nil then 
        return 
    end

    if Config["Strefy"][AktualnaStrefa].przejeciestrefy and ktoprzejmuje[AktualnaStrefa] == src then
        Config["Strefy"][AktualnaStrefa].przejeciestrefy = false
        TriggerClientEvent('non-strefy:ZmienKolorBlipa', -1, AktualnaStrefa, 1)
        TriggerClientEvent('non-strefy:StatusPrzejmowanie', _source, false)
        xPlayer.showNotification("Przejmowanie strefy w "..Config["Strefy"][AktualnaStrefa].Nazwa.." zostało przerwane")
    end
end)

ESX.RegisterServerCallback('non-strefy:StartPrzejmowania', function(src, cb, AktualnaStrefa)
    local _source  = src
    local xPlayer  = ESX.GetPlayerFromId(_source)
    local xPlayers = ESX.GetPlayers()
    local strefa = Config["Strefy"][AktualnaStrefa]
    local playerCoords = xPlayer.getCoords(true)

    if xPlayer == nil then 
        return 
    end
    if not sprawdzanko(playerCoords, strefa.Coords, 30.0) then
        ServerDebugPrint({type = "warning", message = "Sprawdz czy gracz znajduje sie w obrebie strefy, jezeli nie to wypierdol mu bana"})
        return
    end
    if strefa.Zostawic < os.time() then
        if not strefa.przejeciestrefy then
            if exports['non-ui']:CountPlayer('players') >= 1 then
                for i=1, #xPlayers, 1 do
                    local xPlayer = ESX.GetPlayerFromId(xPlayers[i])
                    xPlayer.showNotification("Przejmowanie strefy w "..strefa.Nazwa)
                end
                ktoprzejmuje[AktualnaStrefa] = src
                TriggerClientEvent('non-strefy:StatusPrzejmowanie', _source, true)
                TriggerClientEvent('non-strefy:ZmienKolorBlipa', -1, AktualnaStrefa, 5)
                xPlayer.showNotification("Rozpocząłeś przejmowanie strefy "..strefa.Nazwa)
                strefa.przejeciestrefy = true
                TriggerClientEvent("non-chat", -1, {
                    label = "fa-solid fa-virus",
                    color = "#ff8c8c",
                }, {
                    type = "Strefy",
                    name = "NONRP.EU",
                    content = "Gracz: "..xPlayer.discord.name..", Przejmuje strefę: "..strefa.Nazwa,
                })
            else
                xPlayer.showNotification("Wymagana ilość graczy aby rozpocząć przejmowanie strefy to: 10")
            end
        else
            xPlayer.showNotification("Ta strefa jest juz przejmowana")
        end
    else
        xPlayer.showNotification("Musisz chwile odczekac, Ta strefa zostala niedawno przejeta")
    end
end)

ESX.RegisterServerCallback('non-strefy:KoniecPrzejmowania', function(src, cb, AktualnaStrefa)
    local _source = src
    local xPlayer = ESX.GetPlayerFromId(_source)
    local strefa = Config["Strefy"][AktualnaStrefa]
    local playerCoords = xPlayer.getCoords(true)
    local kurwa = math.random(100)
    if xPlayer == nil then 
        return 
    end
    if not strefa or not strefa.przejeciestrefy or ktoprzejmuje[AktualnaStrefa] ~= _source then
        ServerDebugPrint({type = "warning", message = "Sprawdz czy gracz znajduje sie w obrebie strefy, jezeli nie to wypierdol mu bana, "..src})
        return
    end
    if not sprawdzanko(playerCoords, strefa.Coords, 30.0) then
        ServerDebugPrint({type = "warning", message = "Sprawdz czy gracz znajduje sie w obrebie strefy, jezeli nie to wypierdol mu bana, "..src})
        return
    end
    if strefa.przejeciestrefy and ktoprzejmuje[AktualnaStrefa] == src then
        if kurwa > 5 then
            xPlayer.addInventoryItem("amulet_predkosci", 1)
        end

        if strefa.Nagroda > 0 then
            xPlayer.addMoney(strefa.Nagroda)
        else
            ServerDebugPrint({type = "warning", message = "COS SIE WYJEBALO W STREFACH I ZIOMEK NIE DOSTAL SIANA POZDRO 600"})
        end
        strefa.przejeciestrefy = false
        strefa.Zostawic = os.time() + 360
        ktoprzejmuje[AktualnaStrefa] = nil
        TriggerClientEvent('non-strefy:ZmienKolorBlipa', -1, AktualnaStrefa, 1)
        TriggerClientEvent("non-chat", -1, {
            label = "fa-solid fa-virus",
            color = "#8cff8c",
        }, {
            type = "Strefy",
            name = "NONRP.EU",
            content = "Gracz: "..xPlayer.discord.name..", Skończył przejmować strefę: "..strefa.Nazwa,
        })
    end
end)

RegisterNetEvent('esx:playerDropped', function(playerId, reason)
    local xPlayer = ESX.GetPlayerFromId(playerId)

    for strefaId, strefaData in pairs(Config["Strefy"]) do
        if ktoprzejmuje[strefaId] == playerId then
            strefaData.przejeciestrefy = false
            ktoprzejmuje[strefaId] = nil
            TriggerClientEvent('non-strefy:ZmienKolorBlipa', -1, strefaData, 1)
        end
    end
end)