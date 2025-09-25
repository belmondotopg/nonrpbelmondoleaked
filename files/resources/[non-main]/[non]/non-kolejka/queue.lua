queue.debuglog = true
local BanList = {}
queue.getIdentifiers = function(player)
    local ids = {
        steam = nil,
        license = nil,
        discord = nil,
        fivem = nil,
        xbl = nil,
        liveid = nil,
        ip = nil,
        tokens = {}
    }

    for i = 1,GetNumPlayerTokens(player) do
        table.insert(ids.tokens, GetPlayerToken(player,i))
    end

    for k,v in pairs(GetPlayerIdentifiers(player))do
        if string.find(v, "steam:") then
            ids.steam = string.gsub(v,"steam:","")
        elseif string.find(v, "license:") then
            ids.license = string.gsub(v,"license:","")
        elseif string.find(v, "discord:") then
            ids.discord = string.gsub(v,"discord:","")
        elseif string.find(v, "fivem:") then
            ids.fivem = string.gsub(v,"fivem:","")
        elseif string.find(v, "xbl:") then
            ids.xbl = string.gsub(v,"xbl:","")
        elseif string.find(v, "liveid:") then
            ids.liveid = string.gsub(v,"liveid:","")
        elseif string.find(v, "ip:") then
            ids.ip = string.gsub(v,"ip:","")
        end
    end
    return ids
end

queue.tableLength = function(tbl)
    local result = 0
    for k, v in pairs(tbl) do
      result = result + 1
    end
    return result
end

-- queue.checkWhitelist = function(discord)
--     return exports[GetCurrentResourceName()]:getWhitelist(discord)
-- end

queue.addToQueue = function(player,steam,discord,def)
    -- local ranks = exports[GetCurrentResourceName()]:getPremiumRanks(discord)
    local priority = 0
    local name = queue.langs[queue.lang]["normal_ticket"]
    -- if ranks then
    --     for i = 1,#ranks do
    --         if queue.priority[ranks[i]] then
    --             if queue.priority[ranks[i]].priority > priority then
    --                 priority = queue.priority[ranks[i]].priority
    --                 name = queue.priority[ranks[i]].name
    --             end
    --         end
    --     end
    -- end
    if priority > 0 then
        if #queue.players > 0 then
            local added = false
            local finish = false
            local newIndex = 0
            local newQueue = {}
            for k,v in pairs(queue.players) do
                if priority > v.priority then
                    newIndex = k
                    if not added then
                        added = true
                        local inx = 1
                        local plrnum = 1
                        for _,value in pairs(queue.players) do
                            if inx == newIndex then
                                if not finish then
                                    finish = true
                                    plrindx = 1 + plrnum
                                    a = queue.players[inx]
                                    newQueue[inx] = {timeInQueue = 0, animation = 1, player = player, def = def, steam = steam, priority = priority, priorityName = name}
                                    newQueue[plrindx] = a
                                end
                            else
                                if not finish then
                                    newQueue[inx] = value
                                else
                                    local plrindx = 1 + plrnum
                                    newQueue[plrindx] = value
                                end
                            end
                            plrnum = plrnum + 1
                            inx = inx + 1
                            if plrnum > #queue.players then
                                queue.players = newQueue
                                return
                            end
                        end
                        queue.players = newQueue
                        return
                    end
                end
            end
            if not finish or not added then
                table.insert(queue.players, {timeInQueue = 0, animation = 1, player = player, def = def, steam = steam, priority = priority, priorityName = name})
                return
            end
            return
        else
            table.insert(queue.players, {timeInQueue = 0, animation = 1, player = player, def = def, steam = steam, priority = priority, priorityName = name})
            return
        end
    else
        table.insert(queue.players, {timeInQueue = 0,animation = 1, player = player, def = def, steam = steam, priority = 0, priorityName = name})
        return
    end
end

queue.reloadQueue = function()
    for i = 1,#queue.players do
        if queue.players[i] == nil then
            local locate = false
            local oldIndex = 0
            local index = 0
            for k,v in pairs(queue.players) do
                if locate then
                    local tempInfo = queue.players[k]
                    queue.players[k] = nil
                    queue.players[oldIndex] = tempInfo
                    oldIndex = oldIndex + 1
                else
                    if (k - 1) == i then
                        locate = true
                        oldIndex = k -1
                        local tempInfo = queue.players[k]
                        queue.players[k] = nil
                        queue.players[oldIndex] = tempInfo
                        oldIndex = oldIndex + 1
                    end
                end
            end
        end
    end
end

CreateThread(function()
    while true do
        Wait(queue.refreshInterval)
        if tonumber(queue.tableLength(queue.connectingPlayers)) + tonumber(GetNumPlayerIndices()) < tonumber(GetConvar("sv_maxClients", 2000)) then
            if queue.players[1] then
                if GetPlayerLastMsg(queue.players[1].player) > 30000 then
                    queue.players[1] = nil
                else
                    queue.connectingPlayers[queue.players[1].steam] = {player = queue.players[1].player}
                    queue.players[1].def.done()
                    queue.players[1] = nil
                end
            end
        end
        for k,v in pairs(queue.players) do
            for i = 1,#queue.players do
                if queue.players[i] == nil then
                    queue.reloadQueue()
                end
            end
            if queue.players[k] ~= nil then
                if GetPlayerName(queue.players[k].player) ~= nil then
                    local def = v.def
                    local time = tostring(os.date("!%X",v.timeInQueue))
                    adaptivecards["queue"](k,#queue.players,def,v.animation,string.sub(time,4,string.len(time)),v.priorityName)
                    queue.players[k].animation = queue.players[k].animation + 1
                    queue.players[k].timeInQueue = queue.players[k].timeInQueue + 1
                    if queue.players[k].animation > #adaptivecards.animation then
                        queue.players[k].animation = 1
                    end
                else
                    queue.players[k] = nil
                end
            end

        end
        for k,v in pairs(queue.connectingPlayers) do
            if GetPlayerLastMsg(v.player) > 30000 then
                queue.connectingPlayers[k] = nil
            end
        end
    end
end)

AddEventHandler("playerDropped", function(reason)
    local player = source
    local i = queue.getIdentifiers(player)
    i.steam = i.discord
    if queue.connectingPlayers[i.steam] then
        queue.connectingPlayers[i.steam] = nil
    end
end)

AddEventHandler("playerConnecting", function(nickname,kickReason,def)
    local player = source
    local i = queue.getIdentifiers(player)

    def.defer()
    Wait(0)

    if not i.steam then
        def.done(queue.langs[queue.lang]["no_steam"])
        return
    end

    if not i.discord then
        def.done(queue.langs[queue.lang]["no_discord"])
        return
    end

    -- if queue.whitelist then
    --     local whitelist = queue.checkWhitelist(i.discord)
    --     if not whitelist then
    --         adaptivecards["nowhitelist"](def)
    --         CancelEvent()
    --         return
    --     end
    -- end

    if queue.banlist then
        def.update("Sprawdzanie Banlisty...")
        local Identifiers = ExtractIdentifiers(player)
		local boolen, reason, expired, bannedby = CheckBanlist(def, Identifiers)
        if boolen then
            if tonumber(expired) == 2000000000 then
                kickReason("Zostałeś zbanowany permanentnie na tym serwerze przez "..bannedby.." za "..reason.."\n Twoja licencja: "..Identifiers.license)
                def.done("Zostałeś zbanowany permanentnie na tym serwerze przez "..bannedby.." za "..reason.."\n Twoja licencja: "..Identifiers.license)
                CancelEvent()
                return
            elseif tonumber(expired) > os.time() then
                local unixDuration = tonumber(expired) - os.time()
                local day = string.format("%02.f", math.floor(unixDuration/(60*60*24)))
                local hour = string.format("%02.f", math.floor((unixDuration - day*60*60*24) /(60*60)))
                local min = string.format("%02.f", math.floor(((unixDuration - day*60*60*24) - hour*60*60) /60))
                local sec = string.format("%02.f", math.floor(((unixDuration - day*60*60*24) - hour*60*60) - min*60))
                kickReason("Zostałeś zbanowany na tym serwerze przez "..bannedby.." za "..reason..". Pozostały czas: "..day..":"..hour..":"..min..":"..sec.."\n Twoja licencja: "..Identifiers.license)
                def.done("Zostałeś zbanowany na tym serwerze przez "..bannedby.." za "..reason..". Pozostały czas: "..day..":"..hour..":"..min..":"..sec.."\n Twoja licencja: "..Identifiers.license)
                CancelEvent()
                return
            elseif tonumber(expired) <= os.time() then
                local done = MySQL.update.await('UPDATE bans SET reason = ?, expired = ?, bannedby = ?, isbanned = ? WHERE license = ? ', {nil, nil, nil, 0, Identifiers.license})
                if done then
                    if boolen == "license" then
                        BanList[Identifiers.license].reason = nil
                        BanList[Identifiers.license].expired = nil
                        BanList[Identifiers.license].bannedby = nil
                        BanList[Identifiers.license].isbanned = 0
                    else
                        for license, values in pairs(BanList) do
                            if Identifiers[boolen] == values[boolen] then
                                BanList[license].reason = nil
                                BanList[license].expired = nil
                                BanList[license].bannedby = nil
                                BanList[license].isbanned = 0
                            end
                        end
                    end
                    kickReason("Twój ban dobiegł końca, połącz się ponownie aby wejść na serwer")
                    def.done("Twój ban dobiegł końca, połącz się ponownie aby wejść na serwer")
                    CancelEvent()
                end
            else
                kickReason("Wystąpił błąd")
                def.done("Wystąpił błąd")
                CancelEvent()
                return
            end
        end
    end

    local tempTime = queue.antifloodTime

    while tempTime > 0 do
        adaptivecards["connecting"](def,tempTime)
        tempTime = tempTime - 1
        Wait(1000)
    end
    queue.addToQueue(player,i.steam,i.discord,def)
end)

local tempPlayerSpawned = {}

RegisterNetEvent("a_queue:playerSpawned")
AddEventHandler("a_queue:playerSpawned", function()
    local player = source
    local i = queue.getIdentifiers(player)
    if not tempPlayerSpawned[tostring(player)] then
        tempPlayerSpawned[tostring(player)] = true
        queue.connectingPlayers[i.steam] = nil
    end
end)

-- MySQL.ready(function()
--     MySQL.query('SELECT * FROM `bans`', {}, function(data)
--         if data then
--             for i = 1, #data do
--                 if type(data[i].added) == "number" and type(data[i].expired) == "number" then
--                     BanList[data[i].license] = {
--                         name = data[i].name,
--                         steamhex = data[i].steamhex,
--                         discord = data[i].discord,
--                         hwid = data[i].hwid,
--                         xbl = data[i].xbl,
--                         live = data[i].live,
--                         added = data[i].added / 1000,
--                         expired = data[i].expired / 1000,
--                         bannedby = data[i].bannedby,
--                         reason = data[i].reason,
--                         isbanned = data[i].isbanned,
--                     }
--                 else
--                 --     print("Uwaga: Dane w kolumnach 'added' lub 'expired' nie są liczbami.")
--                 end
--             end
--         end
--     end)
-- end)


function CheckBanlist(deferrals, Identifiers)
	local BanEntriesOveral = EntriesInTable(BanList)
    if deferrals then
        for i = 1, 100 do
            deferrals.presentCard([==[{
                "type": "AdaptiveCard",
                "$schema": "http://adaptivecards.io/schemas/adaptive-card.json",
                "version": "1.5",
                "body": [
                    {
                        "type": "Container",
                        "items": [
                            {
                                "type": "TextBlock",
                                "text": "Dopasowywanie zbanowanych kont ]==]..i..[==[/100 %",
                                "wrap": true,
                                "size": "Medium",
                                "horizontalAlignment": "Left",
                                "weight": "Default"
                            }
                        ],
                        "style": "default",
                        "bleed": true,
                        "height": "stretch"
                    }
                ]
            }]==])
            Wait(0)
        end
    end
	for license, values in pairs(BanList) do
		if values.isbanned == 1 then
			if Identifiers.license == license then
				print("Zbanowany Gracz próbował połączyć się na serwer, wykrycie: Licencja")
				return "license", values.reason, values.expired, values.bannedby
			elseif Identifiers.discord == values.discord then
				print("Zbanowany Gracz próbował połączyć się na serwer, wykrycie: Discord")
				return "discord", values.reason, values.expired, values.bannedby
			elseif Identifiers.steamhex == values.steamhex then
				print("Zbanowany Gracz próbował połączyć się na serwer, wykrycie: steamhex")
				return "steamhex", values.reason, values.expired, values.bannedby
			elseif values.xbl ~= "Brak" and Identifiers.xbl == values.xbl then
				print("Zbanowany Gracz próbował połączyć się na serwer, wykrycie: xbl")
				return "xbl", values.reason, values.expired, values.bannedby
			elseif values.live ~= "Brak" and Identifiers.live == values.live then
				print("Zbanowany Gracz próbował połączyć się na serwer, wykrycie: live")
				return "live", values.reason, values.expired, values.bannedby
			else
                if values.hwid then
                    for _, token in ipairs(values.hwid) do
                        for _2, token2 in ipairs(Identifiers.hwid) do
                            if token == token2 then
                                print("Zbanowany Gracz próbował połączyć się na serwer, wykrycie: hwid")
                                return "hwid", values.reason, values.expired, values.bannedby
                            end
                        end
                    end
                end
			end
		end
	end

	if Identifiers.license ~= "Brak" and BanList[Identifiers.license] then
		MySQL.update('UPDATE `bans` SET `steamhex` = @steamhex, `xbl` = @xbl, `live` = @live, `discord` = @discord, `hwid` = @hwid, `name` = @name, `added` = @added, `isbanned` = @isbanned WHERE license = @license', {
			['@license'] = Identifiers.license,
			['@steamhex'] = Identifiers.steamhex,
			['@xbl'] = Identifiers.xbl,
			['@live'] = Identifiers.live,
			['@discord'] = Identifiers.discord,
			['@hwid'] = json.encode(Identifiers.hwid),
			['@name'] = Identifiers.name,
			['@added'] = os.date("%Y-%m-%d %H:%M:%S", os.time()),
			['@isbanned'] = 0
		}, function(rowsChanged)
			BanList[Identifiers.license] = {
				steamhex = Identifiers.steamhex,
				xbl = Identifiers.xbl,
				live = Identifiers.live,
				discord = Identifiers.discord,
				hwid = json.encode(Identifiers.hwid),
				name = Identifiers.name,
				added = os.time(),
				isbanned = 0
			}
		end)
	elseif Identifiers.license ~= "Brak" then
		--print("Dodano nowy rekord w `bans`")
		MySQL.update('INSERT INTO `bans` (`license`, `steamhex`, `xbl`, `live`, `discord`, `hwid`, `name`, `isbanned`, `added`) VALUES (@license, @steamhex, @xbl, @live, @discord, @hwid, @name, @isbanned, @added)', {
			['@license'] = Identifiers.license,
			['@steamhex'] = Identifiers.steamhex,
			['@xbl'] = Identifiers.xbl,
			['@live'] = Identifiers.live,
			['@discord'] = Identifiers.discord,
			['@hwid'] = json.encode(Identifiers.hwid),
			['@name'] = Identifiers.name,
			['@added'] = os.date("%Y-%m-%d %H:%M:%S", os.time()),
			['@isbanned'] = 0
		}, function(rowsChanged)
			BanList[Identifiers.license] = {
				steamhex = Identifiers.steamhex,
				xbl = Identifiers.xbl,
				live = Identifiers.live,
				discord = Identifiers.discord,
				hwid = json.encode(Identifiers.hwid),
				name = Identifiers.name,
				added = os.time(),
				isbanned = 0
			}
		end)
	end
	return false
end

function SplitId(string)
    local output
    for str in string.gmatch(string, "([^:]+)") do
        output = str
    end
    return output
end

function ExtractIdentifiers(src)
    local identifiers = {
        id = src,
        name = GetPlayerName(src),
        steamhex = "Brak",
        steamid = "Brak",
        ip = "Brak",
        discord = "Brak",
        license = "Brak",
        license2 = "Brak",
        xbl = "Brak",
        live = "Brak",
        fivem = "Brak",
        hwid = {}
    }

    for i = 0, GetNumPlayerIdentifiers(src) - 1 do
        local id = GetPlayerIdentifier(src, i)
        if string.find(id, "steam") then
            identifiers.steamhex = SplitId(id)
            identifiers.steamid = tonumber(SplitId(id), 16)
        elseif string.find(id, "ip") then
            identifiers.ip = SplitId(id)
        elseif string.find(id, "discord") then
            identifiers.discord = SplitId(id)
        elseif string.find(id, "license2") then
            identifiers.license2 = SplitId(id)
        elseif string.find(id, "license") then
            identifiers.license = SplitId(id)
        elseif string.find(id, "xbl") then
            identifiers.xbl = SplitId(id)
        elseif string.find(id, "live") then
            identifiers.live = SplitId(id)
        elseif string.find(id, "fivem") then
            identifiers.fivem = SplitId(id)
        end
    end

    for i = 0, GetNumPlayerTokens(src) - 1 do
        table.insert(identifiers.hwid, GetPlayerToken(src, i))
    end

    return identifiers
end

function EntriesInTable(t)
    local count = 0
    for k, v in pairs(t) do
        if v.isbanned == 1 then
            count += 1
        end
    end
    return count
end

-- ESX.RegisterCommand('banid', 'mod', function(xPlayer, args, showError)
-- 	local xPlayer = xPlayer
-- 	if tonumber(args.id) and tonumber(args.czas) and args.powod then
-- 		local tPlayer = ESX.GetPlayerFromId(tonumber(args.id))
-- 		if tPlayer then
-- 			local bannedby = "Administracja"
-- 			if xPlayer then
--                 bannedby = GetPlayerName(xPlayer.source)
-- 			end

-- 			local reason = args.powod
-- 			local unixDuration
-- 			if tonumber(args.czas) == -1 then
-- 				unixDuration = 2000000000
-- 			else
-- 				unixDuration = os.time() + (tonumber(args.czas) * 3600)
-- 			end

--             local Identifiers = ExtractIdentifiers(tPlayer.source)


-- 			MySQL.update('UPDATE bans SET steamhex=@steamhex, xbl=@xbl, live=@live, discord=@discord, hwid=@hwid, name=@name, reason=@reason, added=@added, expired=@expired, bannedby=@bannedby, isbanned=@isbanned WHERE license=@license', {
-- 				['@license'] = Identifiers.license,
-- 				['@steamhex'] = Identifiers.steamhex,
-- 				['@xbl'] = Identifiers.xbl,
-- 				['@live'] = Identifiers.live,
-- 				['@discord'] = Identifiers.discord,
-- 				['@hwid'] = json.encode(Identifiers.hwid),
-- 				['@name'] = Identifiers.name,
-- 				['@reason'] = reason,
-- 				['@added'] = os.date("%Y-%m-%d %H:%M:%S", os.time()),
-- 				['@expired'] = os.date("%Y-%m-%d %H:%M:%S", unixDuration),
-- 				['@bannedby'] = bannedby,
-- 				['@isbanned'] = 1
-- 			}, function (rowsChanged)
-- 				BanList[Identifiers.license] = {
-- 					steamhex = Identifiers.steamhex,
-- 					xbl = Identifiers.xbl,
-- 					live = Identifiers.live,
-- 					discord = Identifiers.discord,
-- 					hwid = json.encode(Identifiers.hwid),
-- 					name = Identifiers.name,
-- 					reason = reason,
-- 					added = os.time(),
-- 					expired = unixDuration,
-- 					bannedby = bannedby,
-- 					isbanned = 1
-- 				}
-- 				if xPlayer then
-- 					xPlayer.showNotification('[QUEUE] Gracz został zbanowany')
-- 				end
--                 local adminName = xPlayer and xPlayer.name or 'CONSOLE'
--                 exports['toxic']:SendLogToDiscord('WEBHOOK', 'Zbanowano gracza', adminName..' zbanował/a gracza\nNick: '..Identifiers.name..'\nLicencja: '..Identifiers.license..'\nPowód bana: '..reason..'\nBan wygasa: <t:'..unixDuration..':R>', 10038562)
--                 sendLogToBanroom(Identifiers.discord, Identifiers.name, reason, unixDuration, adminName)
-- 			end)

-- 			if args.czas == -1 then
-- 				DropPlayer(tPlayer.source, "Zostałeś zbanowany permanentnie na tym serwerze przez " .. bannedby .. ". Powód: " .. reason)
-- 			else
-- 				DropPlayer(tPlayer.source, "Zostałeś zbanowany przez " .. bannedby .. ". Powód: " .. reason)
-- 			end
-- 		end
-- 	end
-- end, true, {help = "Komenda do banowania gracza po ID na serwerze", validate = true, arguments = {
-- 	{name = 'id', help = "ID na serwerze", type = 'number'},
-- 	{name = 'czas', help = "Czas w godzinach (-1 jeśli perm)", type = 'number'},
-- 	{name = 'powod', help = "Powód -> użyj cudzysłowia", type = 'string'}
-- }})

-- ESX.RegisterCommand('ban', 'mod', function(xPlayer, args, showError)
-- 	local xPlayer = xPlayer
-- 	if args.licencja and tonumber(args.czas) and args.powod then
-- 		local tPlayer = ESX.GetPlayerFromIdentifier(args.licencja, true)
-- 		if tPlayer then

-- 			local bannedby = "Administracja"
-- 			if xPlayer then
--                 bannedby = GetPlayerName(xPlayer.source)
-- 			end

-- 			local reason = args.powod

-- 			local unixDuration
-- 			if tonumber(args.czas) == -1 then
-- 				unixDuration = 2000000000
-- 			else
-- 				unixDuration = os.time() + (tonumber(args.czas) * 3600)
-- 			end

--             local Identifiers = ExtractIdentifiers(tPlayer.source)

-- 			MySQL.update('UPDATE bans SET steamhex=@steamhex, xbl=@xbl, live=@live, discord=@discord, hwid=@hwid, name=@name, reason=@reason, added=@added, expired=@expired, bannedby=@bannedby, isbanned=@isbanned WHERE license=@license', {
-- 				['@license'] = Identifiers.license,
-- 				['@steamhex'] = Identifiers.steamhex,
-- 				['@xbl'] = Identifiers.xbl,
-- 				['@live'] = Identifiers.live,
-- 				['@discord'] = Identifiers.discord,
-- 				['@hwid'] = json.encode(Identifiers.hwid),
-- 				['@name'] = Identifiers.name,
-- 				['@reason'] = reason,
-- 				['@added'] = os.date("%Y-%m-%d %H:%M:%S", os.time()),
-- 				['@expired'] = os.date("%Y-%m-%d %H:%M:%S", unixDuration),
-- 				['@bannedby'] = bannedby,
-- 				['@isbanned'] = 1
-- 			}, function (rowsChanged)
-- 				BanList[Identifiers.license] = {
-- 					steamhex = Identifiers.steamhex,
-- 					xbl = Identifiers.xbl,
-- 					live = Identifiers.live,
-- 					discord = Identifiers.discord,
-- 					hwid = json.encode(Identifiers.hwid),
-- 					name = Identifiers.name,
-- 					reason = reason,
-- 					added = os.time(),
-- 					expired = unixDuration,
-- 					bannedby = bannedby,
-- 					isbanned = 1
-- 				}
-- 				if xPlayer then
-- 					xPlayer.showNotification('[QUEUE] Gracz został zbanowany')
-- 				end
--                 local adminName = xPlayer and xPlayer.name or 'CONSOLE'
--                 exports['toxic']:SendLogToDiscord('WEBHOOK', 'Zbanowano gracza (Licencja online)', adminName..' zbanował/a gracza\nNick: '..Identifiers.name..'\nLicencja: '..Identifiers.license..'\nPowód bana: '..reason..'\nBan wygasa: '..os.date("%Y-%m-%d %H:%M:%S", unixDuration), 10038562)
--                 sendLogToBanroom(Identifiers.discord, Identifiers.name, reason, unixDuration, adminName)
-- 			end)

-- 			if args.czas == -1 then
-- 				DropPlayer(tPlayer.source, "Zostałeś zbanowany permanentnie na tym serwerze przez " .. bannedby .. ". Powód: " .. reason)
-- 			else
-- 				DropPlayer(tPlayer.source, "Zostałeś zbanowany przez " .. bannedby .. ". Powód: " .. reason)
-- 			end
-- 		else
-- 			local bannedby = "Administracja"
-- 			if xPlayer then
--                 bannedby = GetPlayerName(xPlayer.source)
-- 			end

-- 			local reason = args.powod
-- 			local unixDuration
-- 			if tonumber(args.czas) == -1 then
-- 				unixDuration = 2000000000
-- 			else
-- 				unixDuration = os.time() + (tonumber(args.czas) * 3600)
-- 			end

-- 			MySQL.update('UPDATE bans SET reason=@reason, added=@added, expired=@expired, bannedby=@bannedby, isbanned=@isbanned WHERE license=@license', {
-- 				['@license'] = args.licencja,
-- 				['@reason'] = reason,
-- 				['@added'] = os.date("%Y-%m-%d %H:%M:%S", os.time()),
-- 				['@expired'] = os.date("%Y-%m-%d %H:%M:%S", unixDuration),
-- 				['@bannedby'] = bannedby,
-- 				['@isbanned'] = 1

-- 			}, function (rowsChanged)
--                 BanList[args.licencja].reason = reason
--                 BanList[args.licencja].added = os.time()
--                 BanList[args.licencja].expired = unixDuration
--                 BanList[args.licencja].bannedby = bannedby
--                 BanList[args.licencja].isbanned = 1

-- 				if xPlayer then
-- 					xPlayer.showNotification('[QUEUE] Gracz został zbanowany')
-- 				end
--                 local adminName = xPlayer and xPlayer.name or 'CONSOLE'
--                 exports['toxic']:SendLogToDiscord('WEBHOOK', 'Zbanowano gracza (Licencja offline)', adminName..' zbanował/a gracza\nLicencja: '..args.licencja..'\nPowód bana: '..reason..'\nBan wygasa: '..os.date("%Y-%m-%d %H:%M:%S", unixDuration), 10038562)
--                 sendLogToBanroom(BanList[args.licencja].discord, BanList[args.licencja].name, reason, unixDuration, adminName)
-- 			end)
-- 		end
-- 	end
-- end, true, {help = "Komenda do banowania gracza po licencji", validate = true, arguments = {
-- 	{name = 'licencja', help = "Licencja RockStar Games (bez license:)", type = 'string'},
-- 	{name = 'czas', help = "Czas w godzinach (-1 jeśli perm)", type = 'number'},
-- 	{name = 'powod', help = "Powód -> użyj cudzysłowia", type = 'string'}
-- }})

DeleteBanSteam = function(steam)
	MySQL.Async.execute('UPDATE bans SET isBanned=0 WHERE steamhex=@steamhex',
	{
		['@steamhex']  = steam
	},function()
		for i=1, #BanList, 1 do
			if BanList[i] and BanList[i].steamhex and (tostring(BanList[i].steamhex)) == tostring(steam) then
				table.remove(BanList, i)
			end
		end
	end)
end

exports('DeleteBanSteam', DeleteBanSteam)

-- ESX.RegisterCommand('unban', 'mod', function(xPlayer, args, showError)
-- 	if args.licencja then
-- 		MySQL.update('UPDATE bans SET reason = ?, expired = ?, bannedby = ?, isbanned = ? WHERE license = ?', {nil, nil, nil, 0, args.licencja},
--         function()
--             BanList[args.licencja].reason = nil
--             BanList[args.licencja].expired = nil
--             BanList[args.licencja].bannedby = nil
--             BanList[args.licencja].isbanned = 0
-- 			if xPlayer then
-- 				xPlayer.showNotification('[QUEUE] Gracz został odbanowany!')
-- 			else
-- 				print("Gracz został odbanowany!")
-- 			end
--             local adminName = xPlayer and xPlayer.name or 'CONSOLE'
--             exports['toxic']:SendLogToDiscord('WEBHOOK', 'Odbanowano gracza', adminName..' odbanował/a gracza\nLicencja: '..args.licencja, 5763719)
-- 		end)
-- 	end
-- end, true, {help = "Komenda do odbanowywania gracza", validate = true, arguments = {
-- 	{name = 'licencja', help = "Licencja RockStar Games (bez license:)", type = 'string'}
-- }})

function UnbanPlayer(hex)
    if hex then
        local fixedHex = SplitId(hex)
        for license, ids in pairs(BanList) do
            if fixedHex == ids.steamhex then
                MySQL.update('UPDATE bans SET reason = ?, expired = ?, bannedby = ?, isbanned = ? WHERE license = ?', {nil, nil, nil, 0, license},
                function()
                    BanList[license].reason = nil
                    BanList[license].expired = nil
                    BanList[license].bannedby = nil
                    BanList[license].isbanned = 0
                    exports['toxic']:SendLogToDiscord('WEBHOOK', 'Odbanowano gracza (SKLEP)', 'Licencja: '..license, 5763719)
                end)
            end
        end
	end
end

exports('UnbanPlayer', UnbanPlayer)

RegisterServerEvent("toxic:ban", function(src, reason, unixDuration)
    local bannedby = "Ban System"
    local Identifiers = ExtractIdentifiers(src)

    MySQL.update('UPDATE bans SET steamhex=@steamhex, xbl=@xbl, live=@live, discord=@discord, hwid=@hwid, name=@name, reason=@reason, added=@added, expired=@expired, bannedby=@bannedby, isbanned=@isbanned WHERE license=@license', {
        ['@license'] = Identifiers.license,
        ['@steamhex'] = Identifiers.steamhex,
        ['@xbl'] = Identifiers.xbl,
        ['@live'] = Identifiers.live,
        ['@discord'] = Identifiers.discord,
        ['@hwid'] = json.encode(Identifiers.hwid),
        ['@name'] = Identifiers.name,
        ['@reason'] = reason,
        ['@added'] = os.date("%Y-%m-%d %H:%M:%S", os.time()),
        ['@expired'] = os.date("%Y-%m-%d %H:%M:%S", unixDuration),
        ['@bannedby'] = bannedby,
        ['@isbanned'] = 1
    }, function (rowsChanged)
        BanList[Identifiers.license] = {
            steamhex = Identifiers.steamhex,
            xbl = Identifiers.xbl,
            live = Identifiers.live,
            discord = Identifiers.discord,
            hwid = json.encode(Identifiers.hwid),
            name = Identifiers.name,
            reason = reason,
            added = os.time(),
            expired = unixDuration,
            bannedby = bannedby,
            isbanned = 1
        }
    end)

    DropPlayer(src, "Zostałeś zbanowany permanentnie na tym serwerze przez " .. bannedby .. ". Powód: " .. reason)
end)

exports('getIdentifiers', function(license)
    return BanList[license]
end)

local banroomLink = 'WEBHOOK'

function sendLogToBanroom(discord, nick, reason, expireTime, adminName)
    local time = 'Nigdy'
    if expireTime ~= 2000000000 then
        time = '<t:'..expireTime..':R>'
    end
    local discordPing = '<@'..discord..'>'
    local embedContent = '**Nick steam:** '..nick..'\n**Powód bana:** '..reason..'\n**Ban wygasa:** '..time..'\n**Nadany przez:** '..adminName..'\n\n**Masz możliwość wykupu na: [clowns.cool](https://clowns.cool/)**'
    local embeds = {
        {
            ["title"] = "**BAN ROOM**",
            ["type"] = "rich",
            ["color"] = 13370902,
            ["description"] = embedContent,
            ["footer"] = {
                ["text"] = "clowns.cool | "..os.date("%Y/%m/%d %H:%M"),
                ["icon_url"] = "https://cdn.discordapp.com/attachments/1024057617867341844/1066005808724320316/clownscool.png"
            },
        }
    }
    PerformHttpRequest(banroomLink, function(err, text, headers) end, 'POST', json.encode({username = 'clowns.exe', content = discordPing, embeds = embeds}), { ['Content-Type'] = 'application/json' })
end

GetRocade = function()
	return queue.tableLength(queue.players)
end