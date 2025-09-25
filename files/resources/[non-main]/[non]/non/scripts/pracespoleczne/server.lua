local playersInCommunityService = {}
local cooldowns = {}

function sendToPrace(target, count, reason)
    local xPlayer = ESX.GetPlayerFromId(target)
    xPlayer.setCommunityService(count);
    TriggerClientEvent('_prace:CommunityService', target, count)     
    playersInCommunityService[target] = count
end

exports('sendToPrace', sendToPrace)

RegisterCommand('prace', function(source, args2, raw)
    local args = {
        playerId = tonumber(args2[1]),
        amount = tonumber(args2[2]),
        reason = table.concat(args2, " ", 3),
    }
    local xPlayer = ESX.GetPlayerFromId(source)

    local currentTime = os.time()
    if cooldowns[source] and cooldowns[source] > currentTime then
        local remainingTime = cooldowns[source] - currentTime
        return xPlayer.showNotification("Musisz poczekać <b style='color:crimson'>"..remainingTime.." sekund</b>, aby ponownie użyć tej komendy!", "error")
    end

    if args.amount > 25 then 
        return xPlayer.showNotification("Nie możesz wystawić więcej niż <b style='color:crimson'>25</b> prac!", "error") 
    end
    if xPlayer.group == "user" or xPlayer.group == "revivator" or xPlayer.group == "media" or xPlayer.group == "trialsupport" or xPlayer.group == "support" then 
        return xPlayer.showNotification("Nie masz do tego <b style='color:crimson'>permisji</b>!", "error") 
    end
    if not GetPlayerName(args.playerId) then 
        return xPlayer.showNotification("Ten <b style='color:crimson'>użytkownik</b> jest <b style='color:crimson'>offline</b>!", "error") 
    end

    xPlayer.showNotification("Wysłano <b style='color:crimson'>["..args.playerId.."] "..GetPlayerName(args.playerId).."</b> na <b style='color:dodgerblue'>"..args.amount.." prac</b> za <b>"..args.reason.."</b>!", "success")
    local xTarget = ESX.GetPlayerFromId(args.playerId)

    exports['non']:SendLog(source, "Gracz został wysłany na "..args.amount.." prac społecznych za "..args.reason.." przez ["..xPlayer.source.."] "..xPlayer.discord.name.."!", 'jail')

    local description = string.format(
        "```Kto: %s\nPowód: %s\nIlosc: %s\nWystawione przez: %s```",
        xTarget.discord.name,
        tostring(args.reason),
        tostring(args.amount),
        xPlayer.discord.name
    )

    local embeds = {{
        ["color"] = "9215743",
        ["title"] = "Prace Spoleczne",
        ["description"] = description,
        ["footer"] = {
            ["text"] = os.date('%H:%M:%S', os.time()) .. " - NonRP.eu",
            ['icon_url'] = "https://r2.fivemanage.com/R7HKRCqENRzbyDq4J7pj1/nonrplogomin.png"
        },
    }}

    local xd = exports['EasyAdmin']:ExtractIdentifiers(args.playerId)
    local discord = "<@" ..xd.discord:gsub("discord:", "")..">"

    PerformHttpRequest("https://discord.com/api/webhooks/1316126136551342161/pxAn5Q1fb-OUIBP57Rf9HTIZ3wlz8DbC9YR81aZITDKaVG3llmZZG40Ot2TnEbTnFuO2", function(err, text, headers) end, 'POST', json.encode({ 
        content = discord,
        username = "NonRP ~ Prace",
        embeds = embeds,
        avatar_url = "https://r2.fivemanage.com/R7HKRCqENRzbyDq4J7pj1/nonrplogomin.png"
    }), { ['Content-Type'] = 'application/json' })

    TriggerClientEvent("non-chat", -1, {
        label = "fa-solid fa-gavel",
        color = "#fff",
    }, {
        background = "#581b1b",
        type = "PRACE",
        name = "SĘDZIA",
        content = "["..args.playerId.."] "..xTarget.discord.name.." został wysłany na "..args.amount.." prac społecznych przez ["..source.."] "..xPlayer.discord.name.." za: "..args.reason..".",
    })
    sendToPrace(args.playerId, args.amount, args.reason)

    cooldowns[source] = currentTime + 30
end)


RegisterCommand("skonczprace", function(source, args2, raw)
    local xPlayer = ESX.GetPlayerFromId(source)
    if xPlayer.group == "user" or xPlayer.group == "revivator" or xPlayer.group == "media" or xPlayer.group == "trialsupport" then return xPlayer.showNotification("Nie masz do tego <b style='color:crimson'>permisji</b>!", "error") end
    local args = {
        playerId = tonumber(args2[1])
    }
    if not GetPlayerName(args.playerId) then return TriggerClientEvent('wczrNotifications:showNotification', source, {type = 'error', title = 'Błąd!', description = "Ten <b style='color:crimson'>użytkownik</b> jest <b style='color:crimson'>offline</b>!"}) end
    TriggerClientEvent('wczrNotifications:showNotification', source, {
        type = 'success',
        title = 'Sukces!',
        description = "Skończono prace dla <b style='color:crimson'>["..args.playerId.."] "..GetPlayerName(args.playerId).."</b>!",
    })
    playersInCommunityService[args.playerId] = nil
    local xTarget = ESX.GetPlayerFromId(args.playerId)
    xTarget.setCommunityService(0);
    TriggerClientEvent('_prace:unCommunityService', args.playerId)
    SendLogToDiscord(GetCurrentResourceName(), {
        category = "pracespoleczne",
        title = "Prace społeczne",
        description = "Gracz skończył **prace społeczne** przez **["..source.."] "..GetPlayerName(source).."**!",
        color = "blue",
        players = {
            [xPlayer.source] = true,
            [xTarget.source] = true,
        },
    })
end)

AddEventHandler('esx:playerDropped', function(playerId, reason)
    playersInCommunityService[playerId] = nil
end)

AddEventHandler('esx:playerLoaded', function(playerId, xPlayer)
    local communityservice = xPlayer.getCommunityServices();
    print(communityservice)
    if communityservice > 0 then
        TriggerClientEvent('_prace:CommunityService', playerId, communityservice)
		playersInCommunityService[playerId] = communityservice
    end
end)

RegisterServerEvent("_prace:unCommunityService", function()
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
    playersInCommunityService[_source] = nil
    xPlayer.setCommunityService(0);
    TriggerClientEvent('_prace:unCommunityService', _source)
    SendLogToDiscord(GetCurrentResourceName(), {
        category = "pracespoleczne",
        title = "Prace społeczne",
        description = "Gracz skończył **prace społeczne**!",
        color = "blue",
        players = {
            [xPlayer.source] = true,
        },
    })
end)