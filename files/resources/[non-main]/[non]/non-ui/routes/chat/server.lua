local reportTable = {}
local adminList = {}
local opisy = {}
local cooldowns = {
    ['local'] = {
        time = 3,
        players = {},
    },
    ['report'] = {
        time = 30,
        players = {},
    },
    ['global'] = {
        time = 5,
        players = {},
    },
    ['rynek'] = {
        time = 120,
        players = {},
    },
    ['orgchat'] = {
        time = 10,
        players = {},
    },
    ['ooc'] = {
        time = 120,
        players = {},
    },
    ['msg'] = {
        time = 3,
        players = {},
    },
    ['narrations'] = {
        time = 2,
        players = {},
    },
}

MySQL.ready(function()
    MySQL.query('SELECT * FROM reportsystem', {}, function(data)
        for _, value in pairs(data) do
            reportTable[value.license] = value.count
        end
    end)
end)

CreateThread(function()
    for k, v in pairs(Config.ChatCommands) do
        RegisterCommand(k, function(source, args, raw)
            if not args[1] then return end;
            local xPlayer = ESX.GetPlayerFromId(source);
            local receivers = -1;
            if v.groups then 
                if not v.groups[xPlayer.group] then 
                    return xPlayer.showNotification("Nie posiadasz permisji!");
                end 
            end
            local content = table.concat(args, " ", 1);
            if not getChatCooldown(xPlayer.source) then
                addChatCooldown(xPlayer.source, xPlayer.getGroup())
                exports['non']:SendLog(xPlayer.source, k..': '..content, 'chat')
                TriggerClientEvent("non-chat:addMessage", receivers, {
                    type = k,
                    content = content,
                }, {
                    group = xPlayer.group,
                    name = xPlayer.discord.name,
                    id = source,
                    job = string.upper(xPlayer.job.label), 
                }, (v.receivers == "distance" and GetEntityCoords(GetPlayerPed(source)) or nil))
            end
        end)
    end
end)

ESX.RegisterCommand({'msg', 'dm', 'w'}, 'user', function(xPlayer, args, showError)
    if not (#args > 1) then 
        return xPlayer.showNotification("Musisz podać id!") 
    end
    local playerID = tonumber(args[1])
    local xTarget = ESX.GetPlayerFromId(playerID)
    table.remove(args, 1)
    if not xTarget then
        return xPlayer.showNotification('Podany gracz jest offline', 'error')
    end
    local content = table.concat(args, ' ');

    if getChatCooldown(xPlayer.source, 'msg') then return end

    if not getChatCooldown(xPlayer.source, 'msg') then
        addChatCooldown(xPlayer.source, xPlayer.getGroup(), 'msg')
        TriggerClientEvent("non-chat:addMessage", xTarget.source, {
            type = "DM",
            content = "Otrzymano wiadomość: "..content,
        }, {
            group = xPlayer.group,
            name = xPlayer.discord.name,
            id = source,
            job = string.upper(xPlayer.job.label), 
        })
        TriggerClientEvent("non-chat:addMessage", xPlayer.source, {
            type = "DM",
            content = "Wysłano wiadomość: "..content..". Do: "..xTarget.discord.name,
        }, {
            group = xPlayer.group,
            name = xPlayer.discord.name,
            id = source,
            job = string.upper(xPlayer.job.label), 
        })
        exports['non']:SendLog(xPlayer.source, 'MSG: '..content, 'chat')
        xPlayer.showNotification('Wysłano wiadomość do: '..xTarget.source, 'info')
    end
end, false)

local requestReport = {}

local function generateReportNumber(source)
    local doBreak = false
    local reportNumber = nil
    while true do
        Wait(0)
        reportNumber = math.random(1111, 9999)
        if not requestReport[reportNumber] then
            doBreak = true
            requestReport[reportNumber] = source
        end

        if doBreak then
            break
        end
    end
    return reportNumber
end

local notAdminGroups = {
    ["user"] = true,
    ["revivator"] = true,
    ["media"] = true,
}

ESX.RegisterCommand('adminlist', 'trialsupport', function(xPlayer, args, showError)
	local xPlayers = ESX.GetExtendedPlayers()
    local adminList = {}
	for i=1, #(xPlayers) do 
		local xPlayer = xPlayers[i]
		if not notAdminGroups[xPlayer.getGroup()] then
            table.insert(adminList, {name = xPlayer.discord.name, id = xPlayer.source, rank = xPlayer.getGroup()})
        end
	end
    xPlayer.triggerEvent('non:adminlist', adminList)
end, false)

ESX.RegisterCommand('ooc', 'headadmin', function(xPlayer, args, showError)
	local xPlayers = ESX.GetExtendedPlayers()
    local content = table.concat(args, ' ')
    if not getChatCooldown(xPlayer.source, 'ooc') then
        for i=1, #(xPlayers) do 
            -- local xPlayer = xPlayers[i]
            addChatCooldown(xPlayer.source, xPlayer.getGroup(), 'ooc')
-- fa-solid fa-star
            TriggerClientEvent("non-chat", xPlayers[i].source, {
                label = "fa-solid fa-star",
                color = "#fff",
            }, {
                subtitle = "OGLOSZENIE",
                background = "#444533",
                id = xPlayer.source,
                type = "OGLOSZENIE",
                name = xPlayer.discord.name,
                content = content
            })

        end
    end
end, false)

AddEventHandler('esx:playerLoaded', function(playerId, xPlayer)
    local playerGroup = xPlayer.getGroup()
    if not notAdminGroups[playerGroup] then
        adminList[xPlayer.source] = true
        local splitIdentifier = SplitId(xPlayer.identifier)
        local discord = ""
        if xPlayer then
            if xPlayer.source then
                for k, v in pairs(GetPlayerIdentifiers(xPlayer.source))do   
                    if string.sub(v, 1, string.len("discord:")) == "discord:" then
                        discord = v
                    end
                end
            end
        end
        if discord ~= "" then
            discord = string.gsub(discord, "discord:", "")
        end
        if not reportTable[splitIdentifier] then
            reportTable[splitIdentifier] = 0
            MySQL.insert.await('INSERT INTO reportsystem (license, discord, name, count) VALUES (?, ?, ?, ?) ', {splitIdentifier, discord, xPlayer.getName(), 0})
        end
    end

    Wait(1000)

    SetPlayerCullingRadius(xPlayer.source, 100)
end)

AddEventHandler('esx:playerDropped', function(playerId, reason)
    if not notAdminGroups[playerGroup] then
        adminList[playerId] = nil
        local xPlayer = ESX.GetPlayerFromId(playerId)
        local splitIdentifier = SplitId(xPlayer.identifier)
        local discord = ""
        if xPlayer then
            if xPlayer.source then
                for k, v in pairs(GetPlayerIdentifiers(xPlayer.source))do   
                    if string.sub(v, 1, string.len("discord:")) == "discord:" then
                        discord = v
                    end
                end
            end
        end
        if discord ~= "" then
            discord = string.gsub(discord, "discord:", "")
        end
        if reportTable[splitIdentifier] then
            MySQL.update.await('UPDATE reportsystem SET discord = ?, name = ?, count = ? WHERE license = ?', {discord, xPlayer.getName(), reportTable[splitIdentifier], splitIdentifier})
        end
    end
end)

RegisterCommand("report", function(source, args, raw)
    local xPlayer = ESX.GetPlayerFromId(source);
    if #args <= 0 then return xPlayer.showNotification("Nie napisano zdarzenia w zgłoszeniu!") end
    local reportNumber = generateReportNumber(xPlayer.source)
    local count = GlobalState.scoreboardData.admins;
    local content = table.concat(args, ' ');
    if count == 0 then return xPlayer.showNotification('Brak dostępnej administracji na serwerze') end
    if not getChatCooldown(xPlayer.source, 'report') then
        for k, v in ipairs(ESX.GetExtendedPlayers()) do
            if not notAdminGroups[v.group] then

                addChatCooldown(xPlayer.source, xPlayer.getGroup(), 'report')
                TriggerClientEvent("non-chat", v.source, {
                    label = "fa-solid fa-clipboard",
                    color = "#fff",
                }, {
                    subtitle = "REPORT",
                    background = "#621e1e",
                    id = "#"..reportNumber,
                    type = "REPORT",
                    name = xPlayer.discord.name,
                    content = "["..xPlayer.source.."] Tresc reporta: "..content
                })

            end
        end

        TriggerClientEvent("non-chat", xPlayer.source, {
            label = "fa-solid fa-clipboard",
            color = "#fff",
        }, {
            subtitle = "REPORT",
            background = "#621e1e",
            id = "#"..reportNumber,
            type = "REPORT",
            name = xPlayer.discord.name,
            content = "Wyslales/as reporta o tresci: "..content..". Do "..count.." adminow",
        })

        exports['non']:SendLog(xPlayer.source, string.format('ZGŁOSZENIE\nWiadomość: %s\nNumer zgłoszenia: %s', content, reportNumber), 'chat')
    end
end)

function SplitId(string)
    local output
    for str in string.gmatch(string, '([^:]+)') do
        output = str
    end
    return output
end

RegisterCommand("cls", function(source, args, raw)
    local xPlayer = ESX.GetPlayerFromId(source);
    if not args[1] then return xPlayer.showNotification("Nie podano id zgłoszenia!") end
    local clsID = tonumber(args[1])
    if notAdminGroups[xPlayer.group] then return xPlayer.showNotification("Nie posiadasz do tego permisji!") end
    if not requestReport[clsID] then return xPlayer.showNotification('Brak zgłoszenia o takim ID', 'error') end
    if requestReport[clsID] == xPlayer.source then
        return xPlayer.showNotification("Nie możesz zaakceptować własnego zgłoszenia!")
    end
    local splitIdentifier = SplitId(xPlayer.identifier)
    if reportTable[splitIdentifier] then
        reportTable[splitIdentifier] = reportTable[splitIdentifier] + 1
        requestReport[clsID] = nil
    else
        requestReport[clsID] = nil
    end
    for k, v in ipairs(ESX.GetExtendedPlayers()) do
        if not notAdminGroups[v.group] then
            TriggerClientEvent("non-chat", v.source, {
                label = "fa-solid fa-clipboard",
                color = "#fff",
            }, {
                subtitle = "REPORT",
                background = "#2e6f22",
                type = "CLS",
                name = xPlayer.discord.name,
                content = "Zgłoszenie #"..clsID.." zaakceptowane przez administratora!",
            })

        end
    end

    TriggerClientEvent("non-chat", requestReport[args.id], {
        label = "fa-solid fa-clipboard",
        color = "#fff",
    }, {
        subtitle = "REPORT",
        background = "#2e6f22",
        type = "CLS",
        name = xPlayer.discord.name,
        content = "Zgłoszenie #"..clsID.." zaakceptowane przez administratora!",
    })

    exports['non']:SendLog(xPlayer.source, string.format('ZAAKCEPTOWANE ZGŁOSZENIE\nNumer zgłoszenia: %s\nIlość zaakceptowanych zgłoszeń: %s', clsID, reportTable[splitIdentifier]), 'cls')
    xPlayer.showNotification(requestReport[clsID])
    Wait(200)
end)

local function lookupify(t)
	local r = {}
	for _, v in pairs(t) do
		r[v] = true
	end
	return r
end

local blockedRanges = {
	{0x0001F601, 0x0001F64F}, {0x00002702, 0x000027B0}, {0x0001F680, 0x0001F6C0}, {0x000024C2, 0x0001F251}, {0x0001F300, 0x0001F5FF},
	{0x00002194, 0x00002199}, {0x000023E9, 0x000023F3}, {0x000025FB, 0x000026FD}, {0x0001F300, 0x0001F5FF}, {0x0001F600, 0x0001F636},
	{0x0001F681, 0x0001F6C5}, {0x0001F30D, 0x0001F567}, {0x0001F980, 0x0001F984}, {0x0001F910, 0x0001F918}, {0x0001F6E0, 0x0001F6E5}, 
    {0x0001F920, 0x0001F927}, {0x0001F919, 0x0001F91E}, {0x0001F933, 0x0001F93A}, {0x0001F93C, 0x0001F93E}, {0x0001F985, 0x0001F98F},
	{0x0001F940, 0x0001F94F}, {0x0001F950, 0x0001F95F}, {0x0001F928, 0x0001F92F}, {0x0001F9D0, 0x0001F9DF}, {0x0001F9E0, 0x0001F9E6},
	{0x0001F992, 0x0001F997}, {0x0001F960, 0x0001F96B}, {0x0001F9B0, 0x0001F9B9}, {0x0001F97C, 0x0001F97F}, {0x0001F9F0, 0x0001F9FF},
	{0x0001F9E7, 0x0001F9EF}, {0x0001F7E0, 0x0001F7EB}, {0x0001FA90, 0x0001FA95}, {0x0001F9A5, 0x0001F9AA}, {0x0001F9BA, 0x0001F9BF},
	{0x0001F9C3, 0x0001F9CA}, {0x0001FA70, 0x0001FA73},
}

local blockedSingles = lookupify {
	0x000000A9, 0x000000AE, 0x0000203C, 0x00002049, 0x000020E3, 0x00002122, 0x00002139, 0x000021A9, 0x000021AA, 0x0000231A, 0x0000231B,
	0x000025AA, 0x000025AB, 0x000025B6, 0x000025C0, 0x00002934, 0x00002935, 0x00002B05, 0x00002B06, 0x00002B07, 0x00002B1B, 0x00002B1C,
	0x00002B50, 0x00002B55, 0x00003030, 0x0000303D, 0x00003297, 0x00003299, 0x0001F004, 0x0001F0CF, 0x0001F6F3, 0x0001F6F4, 0x0001F6E9,
	0x0001F6F0, 0x0001F6CE, 0x0001F6CD, 0x0001F6CF, 0x0001F6CB, 0x00023F8, 0x00023F9, 0x00023FA, 0x0000023, 0x0001F51F, 0x0001F6CC,
	0x0001F9C0, 0x0001F6EB, 0x0001F6EC, 0x0001F6D0, 0x00023CF, 0x000002A, 0x0002328, 0x0001F5A4, 0x0001F471, 0x0001F64D, 0x0001F64E,
	0x0001F645, 0x0001F646, 0x0001F681, 0x0001F64B, 0x0001F647, 0x0001F46E, 0x0001F575, 0x0001F582, 0x0001F477, 0x0001F473, 0x0001F930, 
    0x0001F486, 0x0001F487, 0x0001F6B6, 0x0001F3C3, 0x0001F57A, 0x0001F46F, 0x0001F3CC, 0x0001F3C4, 0x0001F6A3, 0x0001F3CA, 0x00026F9,
	0x0001F3CB, 0x0001F6B5, 0x0001F6B5, 0x0001F468, 0x0001F469, 0x0001F990, 0x0001F991, 0x0001F6F5, 0x0001F6F4, 0x0001F6D1, 0x0001F6F6,
	0x0001F6D2, 0x0002640, 0x0002642, 0x0002695, 0x0001F3F3, 0x0001F1FA, 0x0001F91F, 0x0001F932, 0x0001F931, 0x0001F9F8, 0x0001F9F7, 0x0001F3F4,
    0x0001F970, 0x0001F973, 0x0001F974, 0x0001F97A, 0x0001F975, 0x0001F976, 0x0001F9B5, 0x0001F9B6, 0x0001F468, 0x0001F469, 0x0001F99D, 
    0x0001F999, 0x0001F99B, 0x0001F998, 0x0001F9A1, 0x0001F99A, 0x0001F99C, 0x0001F9A2, 0x0001F9A0, 0x0001F99F, 0x0001F96D, 0x0001F96C,
    0x0001F96F, 0x0001F9C2, 0x0001F96E, 0x0001F99E, 0x0001F9C1, 0x0001F6F9, 0x0001F94E, 0x0001F94F, 0x0001F94D,  0x0000265F, 0x0000267E, 
    0x0001F3F4, 0x0001F971, 0x0001F90E,  0x0001F90D, 0x0001F90F, 0x0001F9CF,  0x0001F9CD, 0x0001F9CE, 0x0001F468, 0x0001F469, 0x0001F9D1, 
    0x0001F91D, 0x0001F46D, 0x0001F46B, 0x0001F46C, 0x0001F9AE,  0x0001F415, 0x0001F6D5, 0x0001F6FA, 0x0001FA82, 0x0001F93F, 0x0001FA80, 
    0x0001FA81, 0x0001F97B, 0x0001F9AF, 0x0001FA78, 0x0001FA79, 0x0001FA7A,
}

function antiemoji(str)
	local codepoints = {}
	for _, codepoint in utf8.codes(str) do
		local insert = true
		if blockedSingles[codepoint] then
			insert = false
		else
			for _, range in ipairs(blockedRanges) do
				if range[1] <= codepoint and codepoint <= range[2] then
					insert = false
					break
				end
			end
		end
		if insert then
			table.insert(codepoints, codepoint)
		end
	end
	return utf8.char(table.unpack(codepoints))
end

RegisterCommand('me', function(source, args, message, rawCommand)
    local xPlayer = ESX.GetPlayerFromId(source)
    local text = ''
    for i = 1, #args do
        text = text .. ' ' .. args[i]
    end

    local text = antiemoji(text)
    if text == "" then return end

    if getChatCooldown(xPlayer.source, 'narrations') then return end

    if not getChatCooldown(xPlayer.source, 'narrations') then
        local color = {r = 0, g = 34, b = 11, alpha = 255}
        addChatCooldown(xPlayer.source, xPlayer.getGroup(), 'narrations')
        TriggerClientEvent("non-chat:narrations", -1, source, source, table.concat(args, " "), "me", "#0B3411")
        exports['non']:SendLog(source, "ME: " .. text, 'chat')
        TriggerClientEvent('non-chat:triggerDisplay', -1, text, source, color)
    end
end, false)

RegisterCommand('do', function(source, args, message, rawCommand)
    local xPlayer = ESX.GetPlayerFromId(source)
    local text = ''
    for i = 1, #args do
        text = text .. ' ' .. args[i]
    end

    local text = antiemoji(text)
    if text == "" then return end

    if getChatCooldown(xPlayer.source, 'narrations') then return end

    if not getChatCooldown(xPlayer.source, 'narrations') then
        local color = {r = 0, g = 17, b = 34, alpha = 255}
        addChatCooldown(xPlayer.source, xPlayer.getGroup(), 'narrations')
        TriggerClientEvent("non-chat:narrations", -1, source, source, table.concat(args, " "), "do", "#0B1734")
        exports['non']:SendLog(source, "DO: " .. text, 'chat')
        TriggerClientEvent('non-chat:triggerDisplay', -1, text, source, color)
    end
end, false)

RegisterCommand('try', function(source, args, message, rawCommand)
    local xPlayer = ESX.GetPlayerFromId(source)
    local szanse = math.random(50)

    if getChatCooldown(xPlayer.source, 'narrations') then return end

    if not getChatCooldown(xPlayer.source, 'narrations') then
        addChatCooldown(xPlayer.source, xPlayer.getGroup(), 'narrations')
        if szanse > 25 then
            color = {r = 43, g = 189, b = 29}
            TriggerClientEvent("non-chat:narrations", -1, source, source, "UDANE", "try", "#0B3134")
            exports['non']:SendLog(source, "[UDANE] TRY: " .. text, 'chat')
            return
        elseif szanse < 25 then
            color = {r = 189, g = 29, b = 29}
            TriggerClientEvent("non-chat:narrations", -1, source, source, "NIEUDANE", "try", "#341C0B")
            exports['non']:SendLog(source, "[NIEUDANE] TRY: " .. text, 'chat')
            return
        end
    end
end, false)

ESX.RegisterServerCallback('non-chat:ZapodajOpisyZPrzedWejscia', function(source, cb)
	cb(opisy)
end)

AddEventHandler('playerDropped', function()
	local _source = source
	if opisy[_source] then
		opisy[_source] = nil
	end
end)

RegisterCommand('opis', function(source, args, rawCommand)
    if args[1] ~= nil then
        local text = table.concat(args, " ")

        if #text > 91 then
			TriggerClientEvent('esx:showNotification', _source, 'Maksymalna długość opisu to 91 znaków!')
        else
			local text = antiemoji(text)
			if text == " " then return end

      		TriggerClientEvent('non-chat:opis', -1, source, ''..text..'')
			
			exports['non']:SendLog(source, "STWORZYŁ OPIS: " .. text, 'chat')
			opisy[source] = text
        end
	else
		TriggerClientEvent('non-chat:opis', -1, source, '')
		opisy[source] = nil
	end
end, false)

RegisterCommand('reportclear', function(source, args)
    if not source == 0 then return end
    for identifier, count in pairs(reportTable) do
        reportTable[identifier] = 0
    end
    MySQL.update.await('UPDATE reportsystem SET count = 0')
    print('Pomyślnie zresetowano reporty')
end, false)

local function refreshCommands(player)
    if GetRegisteredCommands then
        local registeredCommands = GetRegisteredCommands()
        local suggestions = {}
        for _, command in ipairs(registeredCommands) do
            if IsPlayerAceAllowed(player, 'command.'..command.name) then
                table.insert(suggestions, {
                    command = command.name,
                    args = command.params or {},
                    description = command.help or " ",
                })
            end
        end
        TriggerClientEvent('chat:addSuggestions', player, suggestions)
    end
end

AddEventHandler('onServerResourceStart', function(resName)
    Wait(500)
    for _, player in ipairs(GetPlayers()) do
        refreshCommands(player)
    end
end)

RegisterServerEvent('chat:init', function()
    local source = source
    refreshCommands(source)
end)

function addChatCooldown(source, rank, cdType)
    local xPlayer = ESX.GetPlayerFromId(source)

    if notAdminGroups[rank] then
        if not cdType then
            cdType = 'global'
        end
        cooldowns[cdType].players[source] = os.time() + cooldowns[cdType].time
    end
end

function getChatCooldown(source, cdType)
    local xPlayer = ESX.GetPlayerFromId(source)
    local cooldownTime

    if cdType then
        cooldownTime = cooldowns[cdType].players[source]
    else
        for key, cooldown in pairs(cooldowns) do
            if cooldown.players[source] and cooldown.players[source] > os.time() then
                cooldownTime = cooldown.players[source]
                break
            end
        end
    end

    if cooldownTime and cooldownTime > os.time() then
        local remainingTime = cooldownTime - os.time()
        xPlayer.showNotification("Masz jeszcze " .. remainingTime .. " sekund cooldownu.")
        return remainingTime
    else
        return false
    end
end
