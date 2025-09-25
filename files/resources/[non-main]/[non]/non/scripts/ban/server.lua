AddEventHandler("fg:BanHandler", function(BanId, data, additional_info, screenshot_url)
    local description = string.format(
        "```Kto: %s\nPowód: %s\nBanId: %s```",
        data.name,
        tostring(data.reason),
        tostring(BanId)
    )

    local embeds = {{
        ["color"] = "9215743",
        ["title"] = "Prace Spoleczne",
        ["description"] = description,
        ["image"] = {
            ["url"] = screenshot_url
        },
        ["footer"] = {
            ["text"] = os.date('%H:%M:%S', os.time()) .. " - NonRP.eu",
            ['icon_url'] = "https://r2.fivemanage.com/R7HKRCqENRzbyDq4J7pj1/nonrplogomin.png"
        },
    }}

    local discord ="<@" ..data.discord..">"

    PerformHttpRequest("https://discord.com/api/webhooks/1316134500991766558/Wetu5dbGSbpNR7sp4Xo4yBrht94F8stbMOnLwK7nCte8n9YPY-Vtuxr5PMv9InN3P5kN", function(err, text, headers) end, 'POST', json.encode({ 
        content = discord,
        username = "NonRP ~ Ban (FG)",
        embeds = embeds,
        avatar_url = "https://r2.fivemanage.com/R7HKRCqENRzbyDq4J7pj1/nonrplogomin.png"
    }), { ['Content-Type'] = 'application/json' })
end)

AddEventHandler("txAdmin:events:playerBanned", function(data)
    local function formatBanDuration(expiration, durationTranslated)
        if expiration == false then
            return "Permanenty"
        elseif durationTranslated then
            return durationTranslated
        end

        local currentTime = os.time()
        local remainingTime = expiration - currentTime

        if remainingTime <= 0 then
            return "Ban wygasł"
        end

        local seconds = remainingTime % 60
        local minutes = math.floor((remainingTime / 60) % 60)
        local hours = math.floor((remainingTime / 3600) % 24)
        local days = math.floor(remainingTime / 86400)

        if days > 0 then
            return string.format("%d dni, %d godzin", days, hours)
        elseif hours > 0 then
            return string.format("%d godzin, %d minut", hours, minutes)
        elseif minutes > 0 then
            return string.format("%d minut", minutes)
        else
            return string.format("%d sekund", seconds)
        end
    end

    local discordId = nil
    for _, identifier in ipairs(data.targetIds or {}) do
        if identifier:find("discord:") then
            discordId = identifier:gsub("discord:", "")
            break
        end
    end

    local banDuration = formatBanDuration(data.expiration, data.durationTranslated)
    local description = string.format(
        "```Gracz: %s\nPowód: %s\nBanId: %s\nCzas bana: %s\nZbanowany przez: %s```",
        data.targetName or "Nieznany",
        tostring(data.reason),
        tostring(data.actionId),
        banDuration,
        data.author
    )

    local embeds = {{
        ["color"] = 9215743,
        ["title"] = "Zbanowano gracza!",
        ["description"] = description,
        ["footer"] = {
            ["text"] = os.date('%H:%M:%S', os.time()) .. " - NonRP.eu",
            ['icon_url'] = "https://r2.fivemanage.com/R7HKRCqENRzbyDq4J7pj1/nonrplogomin.png"
        },
    }}

    local discordMention = discordId and ("<@" .. discordId .. ">") or "Brak identyfikatora Discord"

    PerformHttpRequest(
        "https://discord.com/api/webhooks/1314637451423256577/y6lbdZA-dkXDkhWb9sgaMkMqFx-wpCpWS7uX5Xihq3aX1bZMuckGh7TYm5-YbA8G0jpx", 
        function(err, text, headers) end, 
        'POST', 
        json.encode({ 
            content = discordMention,
            username = "NonRP ~ Ban",
            embeds = embeds,
            avatar_url = "https://r2.fivemanage.com/R7HKRCqENRzbyDq4J7pj1/nonrplogomin.png"
        }), 
        { ['Content-Type'] = 'application/json' }
    )
end)
