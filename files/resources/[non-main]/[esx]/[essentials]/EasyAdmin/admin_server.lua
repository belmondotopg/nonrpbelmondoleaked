
ESX = exports['es_extended']:getSharedObject()
permissions = {
	ban = false,
	kick = false,
	revive = false,
	spectate = false,
	unban = false,
	teleport = false,
	manageserver = false,
	slap = false,
	freeze = false,
	invisible = false,
	invincible = false,
	modifyspeed = false,
	noclip = false,
	vehicles = false
}

local LastPlayers = {}

RegisterServerEvent('EasyAdmin:amiadmin')
AddEventHandler("EasyAdmin:amiadmin", function()	
	local identifiers = GetPlayerIdentifiers(source)
	local perms = {}
	for perm, val in pairs(permissions) do
		local thisPerm = DoesPlayerHavePermission(source, "easyadmin."..perm)
		
		perms[perm] = thisPerm
	end
	
	TriggerClientEvent("EasyAdmin:SetPermissions", source, perms)
	
	if GetConvar("ea_alwaysShowButtons", "false") == "true" then
		TriggerClientEvent("EasyAdmin:SetSetting", source, "forceShowGUIButtons", true)
	else
		TriggerClientEvent("EasyAdmin:SetSetting", source, "forceShowGUIButtons", false)
	end
	
end)

function DoesPlayerHavePermission(player, object)
	local haspermission = false
	if (player == 0 or player == "") then
		return true
	end
	
	if IsPlayerAceAllowed(player,object) then -- check if the player has access to this permission
		haspermission = true
	else
		haspermission = false
	end

	return haspermission
end

CreateThread(function()	
	RegisterServerEvent("EasyAdmin:kickPlayer")
	AddEventHandler('EasyAdmin:kickPlayer', function(playerId,reason)
		if DoesPlayerHavePermission(source,"easyadmin.kick") then
			DropPlayer(playerId, string.format('Wyrzucony przez %s, Powód: %s', GetPlayerName(source), reason) )
		end
	end)

	RegisterServerEvent("non-easyadmin:callRzadowy", function(playerId) 
		local xPlayer = ESX.GetPlayerFromId(playerId)
		if DoesPlayerHavePermission(source,"easyadmin.spectate") then 
			xPlayer.setCoords(vec3(405.2235, -963.4158, -99.0041-.95))
			TriggerClientEvent('InteractSound_CL:PlayOnOne', xPlayer.source, 'unloko', 1.0)
			xPlayer.triggerEvent('InteractSound_SV:PlayOnSource', 'unloko', 1.0)
			xPlayer.showNotification("Zapraszam na sprawdzanie | QUIT = PERM | 1 MIN", 'kill', 60000)
			xPlayer.showNotification("Zapraszam na sprawdzanie | QUIT = PERM | 1 MIN", 'kill', 60000)
			xPlayer.showNotification("Zapraszam na sprawdzanie | QUIT = PERM | 1 MIN", 'kill', 60000)
			xPlayer.showNotification("Zapraszam na sprawdzanie | QUIT = PERM | 1 MIN", 'kill', 60000)
			xPlayer.showNotification("Zapraszam na sprawdzanie | QUIT = PERM | 1 MIN", 'kill', 60000)
			TriggerClientEvent("txcl:showWarning", playerId, GetPlayerName(source), "Zapraszam na sprawdzanie | QUIT = PERM | 1 MIN")
			FreezeEntityPosition(GetPlayerPed(xPlayer.source), true)
			Wait(60000)
			FreezeEntityPosition(GetPlayerPed(xPlayer.source), false)
		end
	end)
	
	RegisterServerEvent("EasyAdmin:RequestSpectate")
	AddEventHandler('EasyAdmin:RequestSpectate', function(playerId)
		if DoesPlayerHavePermission(source,"easyadmin.spectate") then			
			local xPlayer = ESX.GetPlayerFromId(playerId)
			if xPlayer ~= nil then
				local coords = GetEntityCoords(GetPlayerPed(playerId))
				TriggerClientEvent("EasyAdmin:requestSpectate", source, playerId, coords)
				
				local czas = os.date("%Y/%m/%d %X")
				exports['non']:SendLog(source, "Administrator: "..GetPlayerName(source).."\n Administrator ID: " ..source.. " \nGracz: "..GetPlayerName(playerId).. "\nGracz ID: "..playerId.."\nData: "..czas, 'admin_commands', '5793266')
			end
		end
	end)
	
	RegisterServerEvent("EasyAdmin:FreezePlayer")
	AddEventHandler('EasyAdmin:FreezePlayer', function(playerId,toggle)
		if DoesPlayerHavePermission(source,"easyadmin.freeze") then
			TriggerClientEvent("EasyAdmin:FreezePlayer", playerId, toggle)
		end
	end)
	
	RegisterServerEvent('EasyAdmin:TeleportPlayerToSource')
	AddEventHandler('EasyAdmin:TeleportPlayerToSource', function(playerId, secondId, state)	
		if DoesPlayerHavePermission(source, "easyadmin.teleport") then	
			if playerId ~= source and secondId ~= source then
				exports["non-afk"]:fg_BanPlayer(source, "Tried to teleports players by trigger.", true)
				return
			end	
			local coords = GetEntityCoords(GetPlayerPed(playerId))
			local coords2 = GetEntityCoords(GetPlayerPed(secondId))
			local xPlayer = ESX.GetPlayerFromId(playerId)
			local xTarget = ESX.GetPlayerFromId(secondId)

			local event = 'EasyAdmin:TeleportRequestScoped'
			if #(coords - coords2) < 430 then
				event = 'EasyAdmin:TeleportRequest'
			end
			
			if state then
				xTarget.showNotification("Administrator: "..xPlayer.discord.name.. ", Przeteleportowal cie do siebie")
				TriggerClientEvent(event, secondId, playerId, coords)
			else
				xTarget.showNotification("Administrator: "..xPlayer.discord.name.. ", Przeteleportowal cie do siebie")
				TriggerClientEvent(event, secondId, playerId, coords)
			end
		else
			exports["non-afk"]:fg_BanPlayer(source, "Tried to teleports players without permissions", true)
		end
	end)
	Wait(15000)
	TriggerClientEvent("EasyAdmin:restartkurwa", -1)
end)

function checkIsAdmin(src) 
	local is = false
	if DoesPlayerHavePermission(src,"easyadmin.spectate") then
		is = true
	end
	return is
end

RegisterServerEvent("EasyAdmin:RequestAdmin")
AddEventHandler('EasyAdmin:RequestAdmin', function(playerId, green)
	local _source = playerId
	if DoesPlayerHavePermission(source,"easyadmin.spectate") or DoesPlayerHavePermission(source,"easyadmin.hounds") then
		local xPlayer = ESX.GetPlayerFromId(_source)
		local xd = ExtractIdentifiers(playerId)
		local pedal = "https://fiveproxy.lol/api/webhooks/1314256875415666799/xnjI99mQNyT93B_drIFKck9qg8WjfXvjn78JS6PyVakiXyg_pi2KbbABEjYUUmLzvilM"
		local name = GetPlayerName(source)
		local kekwpedalessa = ExtractIdentifiers(playerId)
		local kurwa = ExtractIdentifiers(source)
		local name = GetPlayerName(source)
		local discord ="<@" ..xd.discord:gsub("discord:", "")..">" 
		local admpedal ="<@" ..kurwa.discord:gsub("discord:", "")..">"
		local _source = playerId
		
		TriggerClientEvent('InteractSound_CL:PlayOnOne', xPlayer.source, 'quit', 1.0)
		xPlayer.triggerEvent('InteractSound_SV:PlayOnSource', 'quit', 1.0)
		TriggerClientEvent("txcl:showWarning", playerId, GetPlayerName(_source), "Zapraszam na kanał pomocy")

		PerformHttpRequest(pedal, function(f,o,h) end,'POST', json.encode({username = 'NONRP.EU - Wezwania', content = "Administrator: **"..admpedal .."** Zaprasza Gracza: **"..discord.."** Na Poczekalnie -‘๑’-"}), { ['Content-Type'] = 'application/json' })
	end
end)



function ExtractIdentifiers(playerId)

	local identifiers = {
	steam = "",
	discord = "",
	license = "",
	xbl = "",
	live = ""
}

for i = 0, GetNumPlayerIdentifiers(playerId) - 1 do
	local id = GetPlayerIdentifier(playerId, i)

	if string.find(id, "steam") then
		identifiers.steam = id
	elseif string.find(id, "discord") then
		identifiers.discord = id
	elseif string.find(id, "license") then
		identifiers.license = id
	elseif string.find(id, "xbl") then
		identifiers.xbl = id
	elseif string.find(id, "live") then
		identifiers.live = id
	end
end

return identifiers
end

exports("ExtractIdentifiers", ExtractIdentifiers)

function DoesPlayerHavePermission(player, object)
	local haspermission = false
	if (player == 0 or player == "") then
		return true
	end
	
	if IsPlayerAceAllowed(player,object) then
		haspermission = true
	else
		haspermission = false
	end
	
	if not DoesPlayerHavePermission then
		local numIds = GetPlayerIdentifiers(player)
		for i,admin in pairs(admins) do
			for i,theId in pairs(numIds) do
				if admin == theId then
					haspermission = true
				end
			end
		end
	end
	return haspermission
end

GetDiscordID = function(src)	
	local sid = 'Brak'
	
	for k,v in ipairs(GetPlayerIdentifiers(src)) do
		if string.sub(v, 1, string.len("discord:")) == "discord:" then
			sid = v
		end
	end	

	return sid
end

GetRockstar = function(src)	
	local sid = 'Brak'
	
	for k,v in ipairs(GetPlayerIdentifiers(src)) do
		if string.sub(v, 1, string.len("license:")) == "license:" then
			sid = v
		end
	end	

	return sid
end

ESX.RegisterServerCallback('EasyAdmin:players', function(source, cb, cached)	
	if not cached then
		cb(LastPlayers)
	else
		LastPlayers = {}
		
		for _, playerId in ipairs(GetPlayers()) do					
			table.insert(LastPlayers, {
				id = tonumber(playerId),
				name = GetPlayerName(playerId),
				admin = checkIsAdmin(playerId),
				discord = GetDiscordID(playerId),
				rockstar = GetRockstar(playerId)
			})
		end
		
		table.sort(LastPlayers, function(a, b)
			if a.id ~= b.id then
				return a.id < b.id
			end
		end)
		
		cb(LastPlayers)
	end
end)

ESX.RegisterServerCallback('EasyAdmin:daneInnegoGracza', function(source, cb, target)

    local xPlayer = ESX.GetPlayerFromId(target)
    if xPlayer ~= nil then
		local data = {
			name = GetPlayerName(target),
			idd = xPlayer.source,
			group = xPlayer.getGroup(),
			inventory = xPlayer.inventory,
			accounts  = xPlayer.accounts,
			firstname = firstname,
			lastname  = lastname,
			sex       = sex,
			dob       = dob,
			height    = height,
			money     = xPlayer.getMoney(),
			bank = xPlayer.getAccount('bank').money,
			job = xPlayer.job,
			third = xPlayer.third,
			hex = xPlayer.identifier,
		}
		cb(data)
    end
end)