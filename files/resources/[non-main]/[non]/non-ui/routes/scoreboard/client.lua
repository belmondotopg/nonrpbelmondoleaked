local Scoreboard = {
    time = 0,
    active = false,
    notAllowed = {
        ['user'] = false,
        ['revivator'] = false,
        ['media'] = false,
    },
}

local data = {
    players = 0;
    slots = 0;
    police = 0;
    admins = 0;
    firstJob = "brak",
}

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
    LocalPlayer.state:set('hex', xPlayer.identifier, true)
    LocalPlayer.state:set('name', xPlayer.name, true)
    LocalPlayer.state:set('group', xPlayer.group, true)
end)

-- firstJob

CanUseFeature = function(group)
    if Scoreboard.notAllowed[group] == nil then
        return true
    else
        return false
    end
end

beginCancellationThread = function()
    while true do
        if not Scoreboard.active then
            RemoveMpGamerTag(gamerTagId)
            Scoreboard.active = false
            SendNUIMessage({
                eventName = 'nui:scoreboard:update',
                show = false,
            })
            LocalPlayer.state:set('usingBoard', false, true)
            break 
        end
        Wait(100)
    end
end

renderPlayerSpace = function(player, ped)
    local playerServerId = GetPlayerServerId(player)
    local coords = GetWorldPositionOfEntityBone(ped, GetPedBoneIndex(ped, 0x796E))
    local adminTag = Player(playerServerId).state.group
    local adminTagObj = adminTag and Config.Scoreboard.nazwy[adminTag] or nil
    local customTag = Config.Scoreboard.hexy[Player(playerServerId).state.hex]
    local playerDisabledTag = Player(playerServerId).state.customTagDisabled

    if not playerDisabledTag then
        if customTag then
            DrawText3D(vec3(coords.x, coords.y, coords.z + 0.5), customTag.label, 0.8, 2, customTag.label, 0.8, customTag.color)
        elseif adminTagObj then
            DrawText3D(vec3(coords.x, coords.y, coords.z + 0.5), adminTagObj.label, 0.8, 2, adminTagObj.label, 0.8, adminTagObj.color)
        end
    end

    DrawText3D(vec3(coords.x, coords.y, coords.z + 0.75), playerServerId, 2.0, 2, playerServerId, 2.0, NetworkIsPlayerTalking(player) and {140, 158, 255, 255} or {255, 255, 255, 255})
end




function DrawText3D(coords, text, size, distance, text2, size2, color)
	local PozycjaGracza = GetEntityCoords(PlayerPedId())
	local onScreen, x, y = World3dToScreen2d(coords.x, coords.y, coords.z)
	local camCoords = GetGameplayCamCoords()
	local dist = #(camCoords - vec3(coords.x, coords.y, coords.z))
	local size = size
	local size2 = size2
	if size == nil then size = 1 end
	if not (color) then color = {255,255,255,255} end
	local scale = (size / dist) * 2
	local fov   = (1 / GetGameplayCamFov()) * 100
	local scale = scale * fov
	local scale2
	local fov2
	if distance ~= nil then
		scale2 = (size2 / dist) * 2
		fov2   = (1 / GetGameplayCamFov()) * 100
		scale2 = scale2 * fov2
    end
	if onScreen then
		if distance == nil then
			SetTextScale(0.0 * scale, 0.55 * scale)
			SetTextFont(0)
			SetTextProportional(1)
			SetTextColour(color[1], color[2], color[3], 255)
            SetTextDropshadow(0, 0, 5, 0, 255)
            SetTextDropShadow()
            SetTextOutline()
            SetTextCentre(1)
			SetTextEntry('STRING')
			SetTextCentre(1)
			AddTextComponentString(text)
			DrawText(x, y)
		else
			if #(PozycjaGracza - vec3(coords.x, coords.y, coords.z)) <= distance then
				SetTextScale(0.0 * scale, 0.55 * scale)
				SetTextFont(0)
				SetTextProportional(1)
				SetTextColour(color[1], color[2], color[3], color[4])
                SetTextDropshadow(0, 0, 5, 0, 255)
                SetTextDropShadow()
                SetTextOutline()
                SetTextCentre(1)
				SetTextEntry('STRING')
				SetTextCentre(1)
				AddTextComponentString(text)
				DrawText(x, y)
			elseif #(PozycjaGracza - vec3(coords.x, coords.y, coords.z)) > distance then
				SetTextScale(0.0 * scale2, 0.55 * scale2)
				SetTextFont(0)
				SetTextProportional(1)
				SetTextColour(color[1], color[2], color[3], color[4])
                SetTextDropshadow(0, 0, 5, 0, 255)
                SetTextDropShadow()
                SetTextOutline()
                SetTextCentre(1)
				SetTextEntry('STRING')
				SetTextCentre(1)
				AddTextComponentString(text2)
				DrawText(x, y)
			end
		end
	end
end

newGroup = function(group)
    LocalPlayer.state:set('group', group, true)
end

disableCustomTag = function()
    local customTag = Config.Scoreboard.hexy[LocalPlayer.state.hex]
    local adminTag = LocalPlayer.state.group
    local adminTagObj = Config.Scoreboard.nazwy[adminTag]
    if CanUseFeature(adminTag) then
        if (customTag or adminTagObj) then
            local customTagDisabled = LocalPlayer.state.customTagDisabled
            if (customTagDisabled == nil) then
                customTagDisabled = false
            end
            LocalPlayer.state:set('customTagDisabled', not customTagDisabled, true)
            customTagDisabled = not customTagDisabled
            -- Włączony
            ESX.ShowNotification(('Przełączyłeś custom-tag. Teraza custom tag będzie: %s'):format((customTagDisabled == true) and 'Włączony' or 'Wyłączony'))
        end
    end
end

CountPlayer = function(key)
    local cwl = GlobalState.scoreboardData
    if not cwl then
        print('BŁĄD: GlobalState.scoreboardData jest nil.')
        return 0
    end
    if key == 'players' then
        return cwl.players or 0
    elseif key == 'admins' then
        return cwl.admins or 0
    elseif key == 'police' then
        return cwl.police or 0
    else
        print('BŁĄD: Coś źle wpisane.')
        return 0
    end
end
exports('CountPlayer', CountPlayer)

AddEventHandler('esx:setGroup', function(group)
    print(group)
end)

RegisterNetEvent('esx:setGroup', newGroup)
RegisterCommand('zblock', disableCustomTag, false)
RegisterCommand('customtagoff', disableCustomTag, false)

drawPlayerIds = function()
    while (Scoreboard.active) do
        Wait(0)
        local players = GetActivePlayers()
        for k, player in ipairs(players) do
            local ped = GetPlayerPed(player)
            local dist = #(GetEntityCoords(ped) - GetEntityCoords(cache.playerPed))

            if (dist) < (CanUseFeature(LocalPlayer.state.group) and 60.0 or 30.0) then
                renderPlayerSpace(player, ped)
            end
        end
    end
end


local function canSee(ped)
    return IsEntityVisible(ped) 
end

CreateThread(function()
    Wait(1000)
    while true do
        local sleep = true
        for _, playerId in ipairs(GetActivePlayers()) do
            local ped = GetPlayerPed(playerId)
            if ped ~= PlayerPedId() then
                local coords = GetWorldPositionOfEntityBone(ped, GetPedBoneIndex(ped, 0x796E))
                if Player(GetPlayerServerId(playerId)).state.usingBoard and canSee(ped) then
                    local dist = #(coords - GetEntityCoords(PlayerPedId()))
                    if dist <= 50.0 and dist > 0.0 then
                        sleep = false
                        if not Scoreboard.active then
                            DrawText3D(vec3(coords.x, coords.y, coords.z + 0.75), '🤓', 2.0, 2, '🤓', 2.0, {255,255,255})
                        end
                    end
                end
            end
        end
        
        if sleep then
            Wait(500)
        else
            Wait(0)
        end
    end
end)

formatPlaytime = function(seconds)
    local hours = math.floor(seconds / 3600)
    local minutes = math.floor((seconds % 3600) / 60)
    return string.format("%2d godzina %2d minut", hours, minutes)
end

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(1000)
        Scoreboard.time = Scoreboard.time + 1
    end
end)

RegisterCommand('+scoreboard', function()
    LocalPlayer.state:set('usingBoard', true, true)
    Scoreboard.active = true
    SendNUIMessage({
        eventName = 'nui:scoreboard:update',
        show = true,
        data = {
            players = CountPlayer('players'),
            admins = CountPlayer('admins'),
            police = CountPlayer('police'),
            firstJob = ESX.PlayerData.job.label .. " ~ " .. ESX.PlayerData.job.grade_name,
            gameTime = formatPlaytime(Scoreboard.time),
        };
    })
    CreateThread(beginCancellationThread)
    CreateThread(drawPlayerIds)
end, false)

RegisterCommand('-scoreboard', function()
    -- lib.func.globalThread(false)
    LocalPlayer.state:set('usingBoard', false, true)
    Scoreboard.active = false
    CreateThread(beginCancellationThread)
    -- CreateThread(drawPlayerIds)
end, false)

RegisterKeyMapping('+scoreboard', 'Przełącz Scoreboard', 'keyboard', 'Z')