notWhitelistedMessage = "Musisz wbic na naszego discord'a \n https://discord.gg/nonrp" -- Message displayed when they are not whitelist with the role

whitelistRoles = {
    -- "913692176574214183",
    "1204156127244324935", -- Beta Tester
}
bot = ""
idserwera = "913692176540655627"

local FormattedToken = "Bot "..bot

function DiscordRequest(method, endpoint, jsondata)
    local data = nil
    PerformHttpRequest("https://discordapp.com/api/"..endpoint, function(errorCode, resultData, resultHeaders)
		data = {data=resultData, code=errorCode, headers=resultHeaders}
    end, method, #jsondata > 0 and json.encode(jsondata) or "", {["Content-Type"] = "application/json", ["Authorization"] = FormattedToken})

    while data == nil do
        Citizen.Wait(0)
    end
	
    return data
end

function GetRoles(user)
	local discordId = nil
	for _, id in ipairs(GetPlayerIdentifiers(user)) do
		if string.match(id, "discord:") then
			discordId = string.gsub(id, "discord:", "")
			break
		end
	end

	if discordId then
		local endpoint = ("guilds/%s/members/%s"):format(idserwera, discordId)
		local member = DiscordRequest("GET", endpoint, {})
		if member.code == 200 then
			local data = json.decode(member.data)
			local roles = data.roles
			local found = true
			return roles
		else
			-- print("An error occured, maybe they arent in the discord? Error: "..member.data)
			return false
		end
	else
		return false
	end
end

function IsRolePresent(user, role)
	local discordId = nil
	for _, id in ipairs(GetPlayerIdentifiers(user)) do
		if string.match(id, "discord:") then
			discordId = string.gsub(id, "discord:", "")
			break
		end
	end

	local theRole = nil
	if type(role) == "number" then
		theRole = tostring(role)
	else
		theRole = whitelistRoles[role]
	end

	if discordId then
		local endpoint = ("guilds/%s/members/%s"):format(idserwera, discordId)
		local member = DiscordRequest("GET", endpoint, {})
		if member.code == 200 then
			local data = json.decode(member.data)
			local roles = data.roles
			local found = true
			for i=1, #roles do
				if roles[i] == theRole then
					return true
				end
			end
			return false
		else
			return false
		end
	else
		return false
	end
end

Citizen.CreateThread(function()
	local guild = DiscordRequest("GET", "guilds/"..idserwera, {})
	if guild.code == 200 then
		local data = json.decode(guild.data)
		-- print("SERVER DISCORD: "..data.name.." ("..data.id..")")
	else
		-- print("An error occured, please check your config and ensure everything is correct. Error: "..(guild.data or guild.code)) 
	end
end)

local qetsweyw34634673rgrd363463erfgsdfsddeyweywyewergfsdfyhedryeryerdfg = "Bot " .. ''
local GuildIdd = "913692176540655627"

function DiscordRequest(method, endpoint, jsondata)
    local data = nil
    PerformHttpRequest("https://discordapp.com/api/"..endpoint, function(errorCode, resultData, resultHeaders)
        data = {data=resultData, code=errorCode, headers=resultHeaders}
    end, method, #jsondata > 0 and json.encode(jsondata) or "", {["Content-Type"] = "application/json", ["Authorization"] = qetsweyw34634673rgrd363463erfgsdfsddeyweywyewergfsdfyhedryeryerdfg})

    while data == nil do
        Citizen.Wait(0)
    end
    
    return data
end

function GetRoles(user)
    local discordId = nil
    for _, id in ipairs(GetPlayerIdentifiers(user)) do
        if string.match(id, "discord:") then
            discordId = string.gsub(id, "discord:", "")
            -- print("Found discord id: "..discordId)
            break
        end
    end

    if discordId then
        local endpoint = ("guilds/%s/members/%s"):format(GuildIdd, discordId)
        local member = DiscordRequest("GET", endpoint, {})
        if member.code == 200 then
            local data = json.decode(member.data)
            local roles = data.roles
            local found = true
            return roles
        else
            -- print("An error occured, maybe they arent in the discord? Error: "..member.data)
            return false
        end
    else
        -- print("missing identifier")
        return false
    end
end

function IsRolePresent(user, role)
    local discordId = nil
    for _, id in ipairs(GetPlayerIdentifiers(user)) do
        if string.match(id, "discord:") then
            discordId = string.gsub(id, "discord:", "")
            -- print("Found discord id: "..discordId)
            break
        end
    end

    local theRole = nil
    if type(role) == "number" then
        theRole = tostring(role)
    else
        theRole = Config.Roles[role]
    end

    if discordId then
        local endpoint = ("guilds/%s/members/%s"):format(GuildIdd, discordId)
        local member = DiscordRequest("GET", endpoint, {})
        if member.code == 200 then
            local data = json.decode(member.data)
            local roles = data.roles
            local found = true
            for i=1, #roles do
                if roles[i] == theRole then
                    -- print("Found role")
                    return true
                end
            end
            -- print("Not found!")
            return false
        else
            -- print("An error occured, maybe they arent in the discord? Error: "..member.data)
            return false
        end
    else
        -- print("missing identifier")
        return false
    end
end

Citizen.CreateThread(function()
    local guild = DiscordRequest("GET", "guilds/"..GuildIdd, {})
    if guild.code == 200 then
        local data = json.decode(guild.data)
        -- print("Permission system guild set to: "..data.name.." ("..data.id..")")
    else
        -- print("An error occured, please check your config and ensure everything is correct. Error: "..(guild.data or guild.code)) 
    end
end)


exports('GetRoles', GetRoles)
exports('IsRolePresent', IsRolePresent)