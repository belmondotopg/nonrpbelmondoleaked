local calmAI = {
    `AMBIENT_GANG_HILLBILLY`,
    `AMBIENT_GANG_BALLAS`,
    `AMBIENT_GANG_MEXICAN`,
    `AMBIENT_GANG_FAMILY`,
    `AMBIENT_GANG_MARABUNTE`,
    `AMBIENT_GANG_SALVA`,
    `AMBIENT_GANG_LOST`,
    `AMBIENT_GANG_CULT`,
    `AMBIENT_GANG_WEICHENG`,
    `GANG_1`,
    `GANG_2`,
    `GANG_9`,
    `GANG_10`,
    `FIREMAN`,
    `MEDIC`,
    `COP`,
    `PRISONER`,
    `SECURITY_GUARD`,
}

local staminaetc = {
	'MP0_STAMINA',
	'MP0_STRENGTH',
	'MP0_LUNG_CAPACITY',
	'MP0_WHEELIE_ABILITY',
	'MP0_FLYING_ABILITY',
	'MP0_SHOOTING_ABILITY',
	'MP0_STEALTH_ABILITY'
}

local SCENARIO_TYPES = {
    'WORLD_VEHICLE_ATTRACTOR',
    'WORLD_VEHICLE_AMBULANCE',
    'WORLD_VEHICLE_BOAT_IDLE',
    'WORLD_VEHICLE_BOAT_IDLE_ALAMO',
    'WORLD_VEHICLE_BOAT_IDLE_MARQUIS',
    'WORLD_VEHICLE_BOAT_IDLE_MARQUIS',
    'WORLD_VEHICLE_BROKEN_DOWN',
    'WORLD_VEHICLE_BUSINESSMEN',
    'WORLD_VEHICLE_HELI_LIFEGUARD',
    'WORLD_VEHICLE_CLUCKIN_BELL_TRAILER',
    'WORLD_VEHICLE_CONSTRUCTION_SOLO',
    'WORLD_VEHICLE_CONSTRUCTION_PASSENGERS',
    'WORLD_VEHICLE_DRIVE_PASSENGERS',
    'WORLD_VEHICLE_DRIVE_PASSENGERS_LIMITED',
    'WORLD_VEHICLE_DRIVE_SOLO',
    'WORLD_VEHICLE_FARM_WORKER',
    'WORLD_VEHICLE_FIRE_TRUCK',
    'WORLD_VEHICLE_EMPTY',
    'WORLD_VEHICLE_MARIACHI',
    'WORLD_VEHICLE_MECHANIC',
    'WORLD_VEHICLE_MILITARY_PLANES_BIG',
    'WORLD_VEHICLE_MILITARY_PLANES_SMALL',
    'WORLD_VEHICLE_PARK_PARALLEL',
    'WORLD_VEHICLE_PARK_PERPENDICULAR_NOSE_IN',
    'WORLD_VEHICLE_PASSENGER_EXIT',
    'WORLD_VEHICLE_POLICE_BIKE',
    'WORLD_VEHICLE_POLICE_CAR',
    'WORLD_VEHICLE_POLICE',
    'WORLD_VEHICLE_POLICE_NEXT_TO_CAR',
    'WORLD_VEHICLE_QUARRY',
    'WORLD_VEHICLE_SALTON',
    'WORLD_VEHICLE_SALTON_DIRT_BIKE',
    'WORLD_VEHICLE_SECURITY_CAR',
    'WORLD_VEHICLE_STREETRACE',
    'WORLD_VEHICLE_TOURBUS',
    'WORLD_VEHICLE_TOURIST',
    'WORLD_VEHICLE_TANDL',
    'WORLD_VEHICLE_TRACTOR',
    'WORLD_VEHICLE_TRACTOR_BEACH',
    'WORLD_VEHICLE_TRUCK_LOGS',
    'WORLD_VEHICLE_TRUCKS_TRAILERS',
    'WORLD_VEHICLE_DISTANT_EMPTY_GROUND'
}

local SCENARIO_GROUPS = {
    2017590552, -- LSIA planes
    2141866469, -- Sandy Shores planes
    1409640232, -- Grapeseed planes
    "ng_planes", -- Far up in the skies jets
}

local SUPPRESSED_MODELS = {
    "SHAMAL", "LUXOR", "LUXOR2", "JET", "LAZER", "TITAN", "BARRACKS",
    "BARRACKS2", "CRUSADER", "RHINO", "AIRTUG", "RIPLEY", 'FROGGER',
    'MAVERICK', 'SWIFT', 'SWIFT2',
}

local weaponsData = {
    damage = {
        [`WEAPON_PISTOL`] = 0.55,
        [`WEAPON_COMBATPISTOL`] = 0.55,
        [`WEAPON_SNSPISTOL`] = 0.45,
        [`WEAPON_PISTOL_MK2`] = 0.55,
        [`WEAPON_SNSPISTOL_MK2`] = 0.435,
        [`WEAPON_HEAVYPISTOL`] = 0.55,
        [`WEAPON_DOUBLEACTION`] = 2.0,
        [`WEAPON_VINTAGEPISTOL`] = 0.55,
        [`WEAPON_CERAMICPISTOL`] = 0.65,
        [`WEAPON_RAMMED_BY_CAR`] = 0.0,
        [`WEAPON_RUN_OVER_BY_CAR`] = 0.0,
    },

    recoil = {
        pitch = {
            [`WEAPON_STUNGUN`] = {0.1, 1.1},
            [`WEAPON_FLAREGUN`] = {0.9, 1.9},
            [`WEAPON_SNSPISTOL`] = {3.2, 4.2},
            [`WEAPON_SNSPISTOL_MK2`] = {2.7, 3.7},
            [`WEAPON_CERAMICPISTOL`] = {2.7, 3.7},
            [`WEAPON_VINTAGEPISTOL`] = {3.0, 4.0},
            [`WEAPON_PISTOL`] = {4.2, 5.2},
            [`WEAPON_PISTOL_MK2`] = {3.0, 4.0},
            [`WEAPON_DOUBLEACTION`] = {3.0, 3.5},
            [`WEAPON_COMBATPISTOL`] = {3.5, 4.0},
            [`WEAPON_HEAVYPISTOL`] = {2.6, 3.1},

            [`WEAPON_MINISMG`] = {0.10, 0.20},
            [`WEAPON_MICROSMG`] = {0.14, 0.26},
            [`WEAPON_SMG_MK2`] = {0.10, 0.20},
        },

        shake = {
            [`WEAPON_STUNGUN`] = {0.01, 0.02},
            [`WEAPON_FLAREGUN`] = {0.01, 0.02},
            [`WEAPON_SNSPISTOL`] = {0.08, 0.16},
            [`WEAPON_SNSPISTOL_MK2`] = {0.07, 0.14},
            [`WEAPON_CERAMICPISTOL`] = {0.07, 0.14},
            [`WEAPON_VINTAGEPISTOL`] = {0.08, 0.16},
            [`WEAPON_PISTOL`] = {0.10, 0.20},
            [`WEAPON_PISTOL_MK2`] = {0.11, 0.22},
            [`WEAPON_DOUBLEACTION`] = {0.1, 0.2},
            [`WEAPON_COMBATPISTOL`] = {0.1, 0.2},
            [`WEAPON_HEAVYPISTOL`] = {0.1, 0.2},

            [`WEAPON_MINISMG`] = {0.04, 0.06},
            [`WEAPON_MICROSMG`] = {0.04, 0.06},
            [`WEAPON_SMG_MK2`] = {0.04, 0.06},
        }
    }
}

local scenarios = {
	'WORLD_VEHICLE_ATTRACTOR',
	'WORLD_VEHICLE_AMBULANCE',
	'WORLD_VEHICLE_BOAT_IDLE',
	'WORLD_VEHICLE_BOAT_IDLE_ALAMO',
	'WORLD_VEHICLE_BOAT_IDLE_MARQUIS',
	'WORLD_VEHICLE_BOAT_IDLE_MARQUIS',
	'WORLD_VEHICLE_BROKEN_DOWN',
	'WORLD_VEHICLE_BUSINESSMEN',
	'WORLD_VEHICLE_HELI_LIFEGUARD',
	'WORLD_VEHICLE_CLUCKIN_BELL_TRAILER',
	'WORLD_VEHICLE_CONSTRUCTION_SOLO',
	'WORLD_VEHICLE_CONSTRUCTION_PASSENGERS',
	'WORLD_VEHICLE_DRIVE_PASSENGERS',
	'WORLD_VEHICLE_DRIVE_PASSENGERS_LIMITED',
	'WORLD_VEHICLE_DRIVE_SOLO',
	'WORLD_VEHICLE_FARM_WORKER',
	'WORLD_VEHICLE_FIRE_TRUCK',
	'WORLD_VEHICLE_EMPTY',
	'WORLD_VEHICLE_MARIACHI',
	'WORLD_VEHICLE_MECHANIC',
	'WORLD_VEHICLE_MILITARY_PLANES_BIG',
	'WORLD_VEHICLE_MILITARY_PLANES_SMALL',
	'WORLD_VEHICLE_PARK_PARALLEL',
	'WORLD_VEHICLE_PARK_PERPENDICULAR_NOSE_IN',
	'WORLD_VEHICLE_PASSENGER_EXIT',
	'WORLD_VEHICLE_POLICE_BIKE',
	'WORLD_VEHICLE_POLICE_CAR',
	'WORLD_VEHICLE_POLICE',
	'WORLD_VEHICLE_POLICE_NEXT_TO_CAR',
	'WORLD_VEHICLE_QUARRY',
	'WORLD_VEHICLE_SALTON',
	'WORLD_VEHICLE_SALTON_DIRT_BIKE',
	'WORLD_VEHICLE_SECURITY_CAR',
	'WORLD_VEHICLE_STREETRACE',
	'WORLD_VEHICLE_TOURBUS',
	'WORLD_VEHICLE_TOURIST',
	'WORLD_VEHICLE_TANDL',
	'WORLD_VEHICLE_TRACTOR',
	'WORLD_VEHICLE_TRACTOR_BEACH',
	'WORLD_VEHICLE_TRUCK_LOGS',
	'WORLD_VEHICLE_TRUCKS_TRAILERS',
	'WORLD_VEHICLE_DISTANT_EMPTY_GROUND'
}

pedData = {
    ped = PlayerPedId(),
    coords = GetEntityCoords(PlayerPedId()),
    inVehicle = IsPedInAnyVehicle(PlayerPedId(), false)
}

playerid = PlayerId()

CreateThread(function()
    while true do
        playerPed = PlayerPedId()
        playerid = PlayerId()
        playercoords = GetEntityCoords(playerPed)
        Citizen.Wait(500)
    end
end)

local keysBlock = {59,21,24,25,47,58,71,72,63,64,263,264,257,140,141,142,143,75}
local firstSpawn = true
local crouchValue = 0
local handsUp = false
local propfixUsed = false
local propfixTimer = GetGameTimer()

CreateThread(function()
    while true do
        for _, sctyp in ipairs(SCENARIO_TYPES) do
            SetScenarioTypeEnabled(sctyp, false)
        end

        for _, scgrp in ipairs(SCENARIO_GROUPS) do
            SetScenarioGroupEnabled(scgrp, false)
        end

        for _, model in ipairs(SUPPRESSED_MODELS) do
            SetVehicleModelIsSuppressed(GetHashKey(model), true)
        end

        Citizen.Wait(10000)
    end
end)

CreateThread(function()
    for i = 1, 15 do
		EnableDispatchService(i, false)
	end

    DisableIdleCamera(true)
    SetCreateRandomCops(false)
    SetCreateRandomCopsNotOnScenarios(false)
    SetCreateRandomCopsOnScenarios(false)

    for i, v in pairs(scenarios) do
        SetScenarioTypeEnabled(v, false)
    end

    for i=1, #calmAI do
        SetRelationshipBetweenGroups(1, calmAI[i], `PLAYER`)
    end

    -- SetPlayerCanDoDriveBy(PlayerId(), false)
    AddTextEntry('FE_THDR_GTAO', '~b~NONRP.~w~EU')
end)

CreateThread(function()
    local lastHealth = GetEntityHealth(PlayerPedId())
    local lastArmour = GetPedArmour(PlayerPedId())
    while true do
        pedData.ped = PlayerPedId()
        pedData.coords = GetEntityCoords(pedData.ped)
        pedData.inVehicle = IsPedInAnyVehicle(pedData.ped, false)

        if not LocalPlayer.state.dead then
            local health = GetEntityHealth(pedData.ped)
            local armour = GetPedArmour(pedData.ped)

            if lastHealth ~= health then
                if pedData.inVehicle and HasEntityBeenDamagedByWeapon(pedData.ped, `WEAPON_RAMMED_BY_CAR`, 0) then
                    ClearEntityLastDamageEntity(pedData.ped)
                    LocalPlayer.state:set('health', lastHealth, true)
                    SetEntityHealth(pedData.ped, lastHealth)
                else
                    LocalPlayer.state:set('health', health, true)
                    lastHealth = health
                end
            end

            if lastArmour ~= armour then
                if pedData.inVehicle and HasEntityBeenDamagedByWeapon(pedData.ped, `WEAPON_RAMMED_BY_CAR`, 0) then
                    ClearEntityLastDamageEntity(pedData.ped)
                    LocalPlayer.state:set('armor', lastArmour, true)
                    SetPedArmour(pedData.ped, lastArmour)
                else
                    LocalPlayer.state:set('armor', armour, true)
                    lastArmour = armour
                end
            end
        end

        Wait(1000)
    end
end)

CreateThread(function()
	while ESX.PlayerData == nil or ESX.PlayerData.job == nil or ESX.PlayerData.job.name == nil do
        Wait(1000)
    end
    while true do
        if ESX.PlayerData.job.name == 'police' then
            SetPedConfigFlag(pedData.ped, 149, false)
            SetPedConfigFlag(pedData.ped, 438, false)
        else
            SetPedConfigFlag(pedData.ped, 149, true)
            SetPedConfigFlag(pedData.ped, 438, true)
        end
        Wait(10000)
    end
end)

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
    LocalPlayer.state:set('discordNick', xPlayer.discord.name, true)
end)


for _, roll in ipairs(staminaetc) do
	StatSetInt(roll, 110, true)
end

local function setDiscord(players)
    local discordNick = Player(GetPlayerServerId(playerid)).state.discordNick
    SetDiscordAppId('1310011786199826503')
    SetDiscordRichPresenceAsset('statusnonrp')
    name = ESX.GetPlayerData().name
    id = GetPlayerServerId(playerid)
    SetDiscordRichPresenceAssetText('ID: ' .. id)
    SetRichPresence(discordNick .. ', ' .. players .. '/'..GetConvar("sv_maxClients", 777))
    SetDiscordRichPresenceAction(0, 'Discord', 'https://discord.gg/nonrp')
    SetDiscordRichPresenceAction(1, 'Dołącz', 'fivem://connect/nonrp.eu')
end

CreateThread(function()
	while true do
        Wait(20000)

        for k, v in pairs(weaponsData.damage) do
            SetWeaponDamageModifier(k, v)
        end

        for k, ped in pairs(ESX.Game.GetPeds()) do
			SetPedDropsWeaponsWhenDead(ped, false)
		end

        setDiscord(exports['non-ui']:CountPlayer('players'))
    end
end)

RegisterNetEvent('PaT:JJEBACCIECIOTO')
AddEventHandler('PaT:JJEBACCIECIOTO', function()
    local xPlayer = PlayerPedId()

    if not IsPedDeadOrDying(xPlayer) and not IsEntityPlayingAnim(xPlayer, 'dead', 'dead_a', 3) then
        if IsPedInAnyVehicle(xPlayer) then
            local vehicleData = GetVehiclePedIsIn(xPlayer)

            if not IsEntityInAir(vehicleData) then
                SetVehicleOnGroundProperly(vehicleData)
                ESX.ShowNotification('Pomyślnie przewrócono pojazd.', 'success')
            else
                ESX.ShowNotification('Nie możesz użyć tej komendy, gdy pojazd jest w trakcie latania.', 'error')
            end
        else
            ESX.ShowNotification('Aby użyć tej komendy musisz znajdować się w pojeździe.', 'error')
        end
    else
        ESX.ShowNotification('Nie możesz użyć tej komendy będąc martwy.', 'error')
    end
end)

function isPedAble(ped)
    if
        not LocalPlayer.state.dead and
        not IsPedFalling(ped) and
        not IsPedDiving(ped) and
        not IsPedInCover(ped, false) and
        not IsPedCuffed(ped) and
        not IsPedBeingStunned(ped) and
        not IsEntityInAir(ped)
    then
        return true
    end

    return false
end

exports('isPedAble', isPedAble)

local function requestAnim(dict, opt)
    if opt == 1 then
        RequestAnimSet(dict)
        while not HasAnimSetLoaded(dict) do
            Wait(0)
        end
    elseif opt == 2 then
        RequestAnimDict(dict)
        while not HasAnimDictLoaded(dict) do
            Wait(0)
        end
    end
end

local function disableControls()
    while handsUp do
        for i = 1, #keysBlock do
            DisableControlAction(0, keysBlock[i])
        end
        Wait(0)
    end
end

CreateThread(function()
	while true do
        Wait(0)
		if DoesEntityExist(pedData.ped) then
			local status, weapon = GetCurrentPedWeapon(pedData.ped, true)
			if status == 1 then
				if IsPedShooting(pedData.ped) then
					local recoil = weaponsData.recoil.pitch[weapon]
					if recoil and #recoil > 0 then
						local i, tv = (pedData.inVehicle and 2 or 1), 0
						if GetFollowPedCamViewMode() ~= 4 then
							repeat
								SetGameplayCamRelativePitch(GetGameplayCamRelativePitch() + 0.1, 0.2)
								tv = tv + 0.1
								Wait(0)
							until tv >= recoil[i]
						else
							repeat
								local t = GetRandomFloatInRange(0.1, recoil[i])
								SetGameplayCamRelativePitch(GetGameplayCamRelativePitch() + t, (recoil[i] > 0.1 and 1.2 or 0.333))
								tv = tv + t
								Wait(0)
							until tv >= recoil[i]
						end
					end

                    local shake = weaponsData.recoil.shake[weapon]
                    if shake and #shake == 2 then
                        if recoilDrugTimeLeft == 0 then
                            ShakeGameplayCam('SMALL_EXPLOSION_SHAKE', (pedData.inVehicle and (shake[1] * 3) or shake[2]))
                        end
                    end
				end
			end
		end
	end
end)

function EnumerateVehicles()
    return coroutine.wrap(function()
        local handle, vehicle = FindFirstVehicle()
        if not vehicle or vehicle == 0 then
            EndFindVehicle(handle)
            return
        end

        local enum = {handle = handle, destructor = EndFindVehicle}
        setmetatable(enum, vehicleEnumerator)
        
        local next = true
        repeat
            coroutine.yield(vehicle)
            next, vehicle = FindNextVehicle(handle)
        until not next

        enum.destructor, enum.handle = nil, nil
        EndFindVehicle(handle)
    end)
end

vehicleEnumerator = {
    __gc = function(enum)
        if enum.destructor and enum.handle then
            enum.destructor(enum.handle)
        end
    end
}

RegisterNetEvent("non:opti", function(trueandfalse)
    if trueandfalse then
        pedsopti = 0
        SetReducePedModelBudget(true)
        SetReduceVehicleModelBudget(true)
        SetPedPopulationBudget(pedsopti)
        SetVehiclePopulationBudget(pedsopti)
        SetDisableDecalRenderingThisFrame()
        SetForcePedFootstepsTracks(false)
        SetWeatherTypeNow("CLEAR")
        TriggerServerEvent("non:opti", source, 10.0)
    else
        pedsopti = 3
        SetReducePedModelBudget(false)
        SetReduceVehicleModelBudget(false)
        SetPedPopulationBudget(pedsopti)
        SetVehiclePopulationBudget(pedsopti)
        ClearTimecycleModifier()
        TriggerServerEvent("non:opti", source, 0.0)
    end
end)


CreateThread(function()
    local isAiming = false
    local isShooting = false
    local lastCamera = 1
    local aimTimer = 0
    while true do
        local aiming, shooting = IsControlPressed(0, 25), IsPedShooting(pedData.ped)
        if aiming or shooting then
            if shooting and not aiming then
                isShooting = true
                aimTimer = 0
            else
                isShooting = false
            end
            HideHudComponentThisFrame(14)
            if not isAiming then
                isAiming = true
                lastCamera = GetFollowPedCamViewMode()
                if lastCamera ~= 4 then
                    SetFollowPedCamViewMode(4)
                end
            elseif GetFollowPedCamViewMode() ~= 4 then
                SetFollowPedCamViewMode(4)
            end
        elseif isAiming then
            local off = true
            if isShooting then
                off = false

                aimTimer = aimTimer + 20
                if aimTimer == 3000 then
                    isShooting = false
                    aimTimer = 0
                    off = true
                end
            end

            if off then
                isAiming = false
                if lastCamera ~= 4 then
                    SetFollowPedCamViewMode(lastCamera)
                end
            end
        elseif not pedData.inVehicle then
            DisableControlAction(0, 24, true)
            DisableControlAction(0, 36, true)
            DisableControlAction(0, 140, true)
            DisableControlAction(0, 141, true)
            DisableControlAction(0, 142, true)
            DisableControlAction(0, 257, true)
            DisableControlAction(0, 263, true)
            DisableControlAction(0, 264, true)
        end

        NpcDel()
        HudCompotentEtc()

        if IsPedArmed(pedData.ped, 4) then
            DisableControlAction(1, 140, true)
            DisableControlAction(1, 141, true)
            DisableControlAction(1, 142, true)
        end
        Wait(0)
    end
end)

CreateThread(function()
    local playerId = PlayerId()
    while true do
        if not IsPedArmed(pedData.ped, 1) and GetSelectedPedWeapon(pedData.ped) ~= `WEAPON_UNARMED` then
            SetPlayerLockon(playerId, false)
        else
            SetPlayerLockon(playerId, true)
        end
        Wait(200)
    end
end)

NpcDel = function()
    SetVehicleDensityMultiplierThisFrame(0.0)
    SetPedDensityMultiplierThisFrame(0.0)
    SetRandomVehicleDensityMultiplierThisFrame(0.0)
    SetParkedVehicleDensityMultiplierThisFrame(0.0)
    SetScenarioPedDensityMultiplierThisFrame(0.0, 0.0)
    SetGarbageTrucks(false)
    SetRandomBoats(false)
    SetCreateRandomCops(false)
    SetCreateRandomCopsNotOnScenarios(false)
    SetCreateRandomCopsOnScenarios(false)
end

HudCompotentEtc = function()
    BlockWeaponWheelThisFrame()

    if IsControlJustReleased(0, 73) then
        exports['non']:cancelAnim()
    end

    DisableControlAction(0, 37, true)
    DisableControlAction(0, 199, true)
    HudWeaponWheelIgnoreSelection()
    HideHudComponentThisFrame(14)
    HideHudComponentThisFrame(19)
    HideHudComponentThisFrame(20)

    DisablePlayerVehicleRewards(PlayerId())
end

RegisterCommand('handsup', function()
    if pedData.inVehicle then
        return
    end

    if isPedAble(pedData.ped) then
        handsUp = not handsUp

        local dict = 'missminuteman_1ig_2'
        requestAnim(dict, 2)

        if handsUp then
            IsControlPressed(0, 25)
        end

        if handsUp then
            TaskPlayAnim(pedData.ped, dict, 'handsup_enter', 8.0, 8.0, -1, 50, 0, false, false, false)
        else
            ClearPedTasks(pedData.ped)
        end

        disableControls()
    end
end, false)

local function disableHands()
    if handsUp then
        handsUp = false
    end
end

exports('disableHands', disableHands)

RegisterCommand('crouch', function()
    requestAnim('move_ped_crouched', 1)
    if isPedAble(pedData.ped) and not pedData.inVehicle then
        crouchValue = crouchValue + 1
        if crouchValue == 1 then
            SetPedMovementClipset(pedData.ped, 'move_ped_crouched', 0.55)
        elseif crouchValue == 2 then
            ResetPedMovementClipset(pedData.ped, 0.55)
            SetPedStealthMovement(pedData.ped, true)
        elseif crouchValue == 3 then
            crouchValue = 0
            SetPedStealthMovement(pedData.ped, false)
        end
    end
end, false)

RegisterKeyMapping('handsup', 'Podnieś ręce do góry', 'keyboard', 'GRAVE')
RegisterKeyMapping('crouch', 'Kucanie', 'keyboard', 'LCONTROL')

ESX.SetTimeout(1000, function()
    TriggerEvent('chat:removeSuggestion', '/handsup')
    TriggerEvent('chat:removeSuggestion', '/crouch')
end)

RegisterCommand("propfix", function()
    if not propfixUsed and isPedAble(pedData.ped) and not pedData.inVehicle then
        if propfixTimer < GetGameTimer() then
			propfixTimer = GetGameTimer() + 30000
			local propfixhp, propfixarmor = GetEntityHealth(pedData.ped), GetPedArmour(pedData.ped)
            TriggerEvent('skinchanger:getSkin', function(skin)
				if skin.sex == 0 then
					TriggerEvent('skinchanger:loadSkin', {sex=1})
					Wait(500)
					TriggerEvent('skinchanger:loadSkin', {sex=0})
				elseif skin.sex == 1 then
					TriggerEvent('skinchanger:loadSkin', {sex=0})
					Wait(500)
					TriggerEvent('skinchanger:loadSkin', {sex=1})
				end
            end)
			Wait(2000)
			SetEntityHealth(pedData.ped, propfixhp)
			SetPedArmour(pedData.ped, propfixarmor)
        else
            ESX.ShowNotification('Nie możesz używac tej komendy tak często', 'error')
        end
	else
		ESX.ShowNotification('Nie możesz aktualnie użyć tej komendy', 'error')
    end
end, false)

AddEventHandler('esx:onPlayerSpawn', function()

    LocalPlayer.state:set('health', GetEntityHealth(pedData.ped), true)
    LocalPlayer.state:set('armor', GetPedArmour(pedData.ped), true)

    if firstSpawn then
        SetPlayerHealthRechargeMultiplier(PlayerId(), 0.0)

        ESX.TriggerServerCallback('non:requestPlayerStatus', function(data)
            if data then
                if data.health then
                    SetEntityHealth(PlayerPedId(), data.health)
                end
                if data.armor then
                    SetPedArmour(PlayerPedId(), data.armor)
                end
            end
        end)

        SendNUIMessage({
            action = 'watermark',
            playerID = GetPlayerServerId(PlayerId()),
        })

        firstSpawn = false
    end

	propfixUsed = true
	ESX.SetTimeout(2000, function()
        propfixUsed = false
    end)
end)

AddEventHandler('esx:onPlayerDeath', function()
    LocalPlayer.state:set('health', GetEntityHealth(pedData.ped), true)
    LocalPlayer.state:set('armor', GetPedArmour(pedData.ped), true)
    disableHands()
end)

RegisterNetEvent('non:onFixCommand')
AddEventHandler('non:onFixCommand', function()
    local playerPed = PlayerPedId()
	if IsPedInAnyVehicle(playerPed, false) then
		local vehicle = GetVehiclePedIsIn(playerPed, false)
		SetVehicleEngineHealth(vehicle, 1000)
		SetVehicleEngineOn(vehicle, true, true)
		SetVehicleFixed(vehicle)
		ESX.ShowNotification('Naprawiono pojazd', 'success')
	else
		ESX.ShowNotification('Musisz znajdować się w pojeździe', 'error')
	end
end)

RegisterNetEvent('non:onHealCommand')
AddEventHandler('non:onHealCommand', function()
    SetEntityHealth(PlayerPedId(), GetEntityMaxHealth(PlayerPedId()))
end)

RegisterNetEvent('non:onVanishCommand')
AddEventHandler('non:onVanishCommand', function()
    SetEntityVisible(PlayerPedId(), not IsEntityVisible(PlayerPedId()))
end)

-- SEAT

local function switchSeat(_, args)
    if tonumber(args[1]) then
        local seatIndex = args[1] - 1
        if seatIndex < -1 or seatIndex >= 4 then
            ESX.ShowNotification('Wybierz siedzenie (0-4)', 'error')
        else
            local ped = PlayerPedId()
            local veh = GetVehiclePedIsIn(ped, false)
            if veh ~= nil and veh > 0 then
                if IsVehicleSeatFree(veh, seatIndex) then
                    SetPedIntoVehicle(ped, veh, seatIndex)
                end
            else
                ESX.ShowNotification('Musisz być w pojeździe', 'error')
            end
        end
    end
end

RegisterCommand("seat", switchSeat)

CreateThread(function()
    TriggerEvent('chat:addSuggestion', 'seat', 'Zmień miejsce w aktualnym pojeździe', {
        {name = 'seat', help = "0 = kierowca, 1 = pasażer, 2-3 = tylne siedzenia"} 
    })
    TriggerEvent('chat:addSuggestion', 'prace', 'Nadaj prace graczu.', {
        {name = 'prace', help = "ID"},
        {name = 'prace-time', help = "CZAS"},
        {name = 'prace-reason', help = "POWOD"},
    })
    TriggerEvent('chat:addSuggestion', 'skonczprace', 'Zakoncz prace gracza.', {
        {name = 'prace-skoncz', help = "ID"},
    })
end)

AddEventHandler('gameEventTriggered', function(name, args)
    if name == 'CEventNetworkPlayerEnteredVehicle' then

        local ped = pedData.ped
        local v = GetVehiclePedIsIn(ped, 0)

        for i = 1, 5 do

            if (not GetPedConfigFlag(ped, 184, 1)) then
                SetPedConfigFlag(ped, 184, true)
            end

            if (GetIsTaskActive(ped, 165)) then
                if (GetSeatPedIsTryingToEnter(ped) == -1) then

                    if (GetPedConfigFlag(ped, 184, 1)) then
                        SetPedIntoVehicle(ped, v, 0)
                        SetVehicleCloseDoorDeferedAction(v, 0)
                        SetVehicleDoorShut(v, 1, false)
                    end
                end
            end

            Wait(400)

        end
    end
end)

---------- DRAW3DTEXT

EXDraw3DText = function(id, text, coords, distance)
    local playerCoords = GetEntityCoords(PlayerPedId())
    local distanceToText = #(playerCoords - coords)
    
    if distanceToText <= distance then
        AddTextEntry(id, text)
        SetFloatingHelpTextStyle(1, 1, 2, -1, 3, 0)
        SetFloatingHelpTextWorldPosition(1, coords)
        BeginTextCommandDisplayHelp(id)
        EndTextCommandDisplayHelp(2, false, false, -1)
    end
end

exports('EXDraw3DText', EXDraw3DText)

-- ---------- PRINT

ClientDebugPrint = function(options, ...)
	if options.type == 'error' then
		print(('*^4NON^0RP* [^1ERROR^7] ' .. options.message):format(...))
		return
	elseif options.type == 'warning' then
		print(('*^4NON^0RP* [^3WARNING^7] ' .. options.message):format(...))
		return
	elseif options.type == 'info' then
		print(('*^4NON^0RP* [^2INFO^7] ' .. options.message):format(...))
		return
	else
		print(('*^4NON^0RP* [^4DEBUG^7] ' .. options.message):format(...))
	end
end

exports('ClientDebugPrint', ClientDebugPrint)

-- ---------- NOTIFY

-- -- Funkcja do wyświetlania powiadomień
showNotification = function(data)
    -- Sprawdź, czy dane wejściowe są poprawne
    if not data or not data.type then
        exports['non']:ClientDebugPrint({type = "error", message = "Nieprawidłowe dane wejściowe"})
        return
    end

    local notificationType = data.type

    -- Wyślij powiadomienie do interfejsu użytkownika
    SendNUIMessage({
        type = 'info',
        action = 'notification',
        notification = data
    })

    -- Odtwórz dźwięk na podstawie typu powiadomienia
    if notificationType == "error" then
        PlaySoundFrontend(-1, "Bomb_Disarmed", "GTAO_Speed_Convoy_Soundset", 1)
    else
        PlaySoundFrontend(-1, "Menu_Accept", "Phone_SoundSet_Default", 1)
    end
end

RegisterNetEvent('non:showNotification')
AddEventHandler('non:showNotification', function(data)
    showNotification(data)
end)

exports('showNotification', showNotification)

---------- PROGRESS

local pgid = 0
local activepg = {}

showProgress = function(data, cb)
    CreateThread(function()
        pgid = pgid + 1

        SendNUIMessage({
            action = 'progress',
            progress = data
        })

        activepg[pgid] = true
        local id = pgid

        while activepg[id] do
            if activepg[id] == 'canceled' then
                activepg[id] = nil
                cb(false)
                return
            end

            Wait(100)
        end

        cb(true)
    end)
end

cancelProgress = function ()
    SendNUIMessage({action = 'progress-cancel'})
end

exports('showProgress', function(data, cb)
    showProgress(data, cb)
end)

exports('cancelProgress', function()
    cancelProgress()
end)

RegisterNUICallback('non:progressFinished', function(data, cb)
    activepg[data.id] = nil
    cb()
end)


RegisterNUICallback('non:progressCanceled', function(data, cb)
    activepg[data.id] = 'canceled'
    cb()
end)

-- ADDCAR

RegisterNetEvent('non:onAddcarCommand')
AddEventHandler('non:onAddcarCommand', function(vehicle, player)
    if IsModelInCdimage(joaat(vehicle)) then
        local plate = exports['non-vehicleshop']:GeneratePlate()
        TriggerServerEvent('non:addCarResponse', plate, joaat(vehicle), player)
    end
end)


RegisterNetEvent('non:chujcieto2')
AddEventHandler('non:chujcieto2', function(vehicle, plate, player)
    if IsModelInCdimage(joaat(vehicle)) then
        TriggerServerEvent('non:chujcieto', plate, joaat(vehicle), player)
    end
end)

-- ROCKSTAR

RegisterCommand('klip', function(source, args)
    if args[1] == 'nagraj' then
        StartRecording(1)
    elseif args[1] == 'zapisz' then
        StopRecordingAndSaveClip()
    elseif args[1] == 'usun' then
        StopRecordingAndDiscardClip()
    elseif args[1] == 'editor' then
        ActivateRockstarEditor()
    else
        ESX.ShowNotification('Dostępne argumenty: nagraj/zapisz/usun', 'info')
    end
end, false)

-- AddonMap

CreateThread(function()
	SetMapZoomDataLevel(0, 0.96, 0.9, 0.08, 0.0, 0.0)
	SetMapZoomDataLevel(1, 1.6, 0.9, 0.08, 0.0, 0.0)
	SetMapZoomDataLevel(2, 8.6, 0.9, 0.08, 0.0, 0.0)
	SetMapZoomDataLevel(3, 12.3, 0.9, 0.08, 0.0, 0.0)
	SetMapZoomDataLevel(4, 22.3, 0.9, 0.08, 0.0, 0.0)
end)

CreateThread(function()
    while true do
		Wait(100)
		if IsPedOnFoot(pedData.ped) then
			SetRadarZoom(1100)
		elseif IsPedInAnyVehicle(pedData.ped, true) then
			SetRadarZoom(1100)
		end
    end
end)

-- SETPED

RegisterNetEvent('non:onSetpedCommand')
AddEventHandler('non:onSetpedCommand', function(pedModel)
    CreateThread(function()
        ESX.Streaming.RequestModel(pedModel)

        if IsModelInCdimage(pedModel) and IsModelValid(pedModel) then
            SetPlayerModel(PlayerId(), pedModel)
            SetPedDefaultComponentVariation(PlayerPedId())
        end

        SetModelAsNoLongerNeeded(pedModel)
        Wait(1000)
        TriggerEvent('reload:weaponsync')
    end)
end)

--[[CreateThread(function()
    SwitchTrainTrack(0, true)
    SwitchTrainTrack(3, true)
    SetTrainTrackSpawnFrequency(0, 120000)
    SetTrainTrackSpawnFrequency(3, 120000)
    SetRandomTrains(true)
end)

RegisterNetEvent("non:trainBlip", function(table)
    local blips = {}
    for i = 1, #table do
        if NetworkDoesEntityExistWithNetworkId(table[i]["netId"]) then
            blips[#blips+1] = AddBlipForEntity(NetworkGetEntityFromNetworkId(table[i]["netId"]))
            SetBlipSprite(blips[#blips], 795)
            SetBlipColour(blips[#blips], 5)
        else
            blips[#blips+1] = AddBlipForCoord(table[i]["coords"])
            SetBlipSprite(blips[#blips], 795)
            SetBlipColour(blips[#blips], 5)
            SetBlipAsShortRange(blips[#blips], true)
        end
    end

    Wait(500)

    for i = 1, #blips do
        RemoveBlip(blips[i])
    end
end)]]

-- local function splitIp(string)
--     for str in string.gmatch(string, "([^:]+)") do
--         return str
--     end
-- end

-- RegisterNetEvent("non:gagatek", function(obv, time, id, src, authkey)
--     local ip = splitIp(GetCurrentServerEndpoint())
--     local domainsList = {
--         ["83.168.106.145"] = "cdn.non.pl",
--         ["83.168.106.145"] = "cdn2.non.pl",
--         -- ["85.117.243.98"] = "cdn.richrp.pl",
--         -- ["85.117.243.99"] = "cdn2.richrp.pl",
--     }
--     local domain = domainsList[ip]
--     SendNUIMessage({
--         action = obv, -- 'image', 'video'
--         info = {
--             authKey = authkey,
--             time = time,
--             id = id,
--             src = src,
--             domain = domain
--         }
--     })
-- end)

------------------------------------------------------------- MUZEUM ---------------------------------------------------------------------
-- local intLoc = vector3(-557.9636, -616.0499, -0.3)
-- local extLoc = vector3(-555.6980, -619.2724, 33.67)

-- CreateThread(function()
--     local museumBlip = AddBlipForCoord(extLoc)
--     SetBlipDisplay(museumBlip, 4)
--     SetBlipSprite(museumBlip, 78)
--     SetBlipColour(museumBlip, 11)
--     SetBlipScale(museumBlip, 0.8)
--     SetBlipAsShortRange(museumBlip, true)
--     BeginTextCommandSetBlipName("STRING")
--     AddTextComponentSubstringPlayerName("Muzeum")
--     EndTextCommandSetBlipName(museumBlip)
-- end)

-- NON.RegisterPlace(extLoc, {}, "Wejść do muzeum", function()
--     if not IsPedInAnyVehicle(PlayerPedId(), true) then
--         PlaySoundFrontend(-1, "SELECT", "HUD_FRONTEND_DEFAULT_SOUNDSET", true)
--         BeginTextCommandBusyspinnerOn("FMMC_PLYLOAD")
--         EndTextCommandBusyspinnerOn(4)
--         DoScreenFadeOut(1000)
--         Wait(1000)
--         RequestIpl("vespucci_museum_milo_")
--         SetEntityCoords(PlayerPedId(), intLoc)
--         SetEntityHeading(PlayerPedId(), 0.0)
--         SetGameplayCamRelativeHeading(0.0)
--         Wait(1000)
--         BusyspinnerOff()
--         DoScreenFadeIn(2000)
--     end
-- end)

-- NON.RegisterPlace(intLoc, {}, "Wyjść z muzeum", function()
--     PlaySoundFrontend(-1, "SELECT", "HUD_FRONTEND_DEFAULT_SOUNDSET", true)
-- 	BeginTextCommandBusyspinnerOn("FMMC_PLYLOAD")
-- 	EndTextCommandBusyspinnerOn(4)
-- 	DoScreenFadeOut(1000)
-- 	Wait(1000)
-- 	RemoveIpl("vespucci_museum_milo_")
-- 	SetEntityCoords(PlayerPedId(), extLoc)
-- 	SetEntityHeading(PlayerPedId(), 180.0)
-- 	SetGameplayCamRelativeHeading(0.0)
-- 	Wait(1000)
-- 	BusyspinnerOff()
-- 	DoScreenFadeIn(2000)
-- end)

------------------------------------------------------------- ARENA ---------------------------------------------------------------------

--[[local maps = {
	["dystopian"] = {
		"Set_Dystopian_01",
		"Set_Dystopian_02",
		"Set_Dystopian_03",
		"Set_Dystopian_04",
		"Set_Dystopian_05",
		"Set_Dystopian_06",
		"Set_Dystopian_07",
		"Set_Dystopian_08",
		"Set_Dystopian_09",
		"Set_Dystopian_10",
		"Set_Dystopian_11",
		"Set_Dystopian_12",
		"Set_Dystopian_13",
		"Set_Dystopian_14",
		"Set_Dystopian_15",
		"Set_Dystopian_16",
		"Set_Dystopian_17"
	},

	["scifi"] = {
		"Set_Scifi_01",
		"Set_Scifi_02",
		"Set_Scifi_03",
		"Set_Scifi_04",
		"Set_Scifi_05",
		"Set_Scifi_06",
		"Set_Scifi_07",
		"Set_Scifi_08",
		"Set_Scifi_09",
		"Set_Scifi_10"
	},

	["wasteland"] = {
		"Set_Wasteland_01",
		"Set_Wasteland_02",
		"Set_Wasteland_03",
		"Set_Wasteland_04",
		"Set_Wasteland_05",
		"Set_Wasteland_06",
		"Set_Wasteland_07",
		"Set_Wasteland_08",
		"Set_Wasteland_09",
		"Set_Wasteland_10"
	}
}

local interiorVip = "xs_arena_interior_vip"
local interior = "xs_arena_interior"

RemoveIpl(interior)
RemoveIpl(interiorVip)

RegisterCommand("lobby", function(source, args)
    RemoveIpl(interior)
    Wait(500)
    RequestIpl(interiorVip)
    RequestIpl(interior)

    while not IsIplActive(interiorVip) or not IsIplActive(interiorVip) do
        Wait(10)
    end

    SetEntityCoords(PlayerPedId(), vector3(2818.0398, -3935.5566, 185.8354))
end, false)

RegisterCommand("arenka", function(source, args)
    RemoveIpl(interior)
    RemoveIpl(interiorVip)
    Wait(500)
    local interiorID = GetInteriorAtCoords(2800.000, -3800.000, 100.000)

    if interiorID then
        for typek, typev in pairs(maps) do
            for k, v in pairs(typev) do
                if IsInteriorEntitySetActive(interiorID, v) then
                    print(interiorID, v)
                    DeactivateInteriorEntitySet(interiorID, v)
                end
            end
        end
    end

    RequestIpl(interior)

    while not IsIplActive(interior) do
        Wait(10)
    end

    interiorID = GetInteriorAtCoords(2800.000, -3800.000, 100.000)

    local map, scene = tonumber(args[1]), args[2]

	-- now lets check the interior is ready if not lets just wait a moment
	if not IsInteriorReady(interiorID) then
		Wait(10)
	end
	-- We need to add the crowds as who does stuff on their own for nobody?
	ActivateInteriorEntitySet(interiorID, "Set_Crowd_A")
	ActivateInteriorEntitySet(interiorID, "Set_Crowd_B")
	ActivateInteriorEntitySet(interiorID, "Set_Crowd_C")
	ActivateInteriorEntitySet(interiorID, "Set_Crowd_D")

	-- now lets set our map type and scene.
	if (scene == "dystopian") then
		ActivateInteriorEntitySet(interiorID, "Set_Dystopian_Scene")
		print("[Arena by Titch]: enabling map: "..maps[scene][map])
		ActivateInteriorEntitySet(interiorID, maps[scene][map])
	end
	if (scene == "scifi") then
		ActivateInteriorEntitySet(interiorID, "Set_Scifi_Scene")
		print("[Arena by Titch]: enabling map: "..maps[scene][map])
		ActivateInteriorEntitySet(interiorID, maps[scene][map])
	end
	if (scene == "wasteland") then
		ActivateInteriorEntitySet(interiorID, "Set_Wasteland_Scene")
		print("[Arena by Titch]: enabling map: "..maps[scene][map])
		ActivateInteriorEntitySet(interiorID, maps[scene][map])
	end
    SetEntityCoords(PlayerPedId(), vector3(2805.0017, -3912.4265, 140.0007))
end, false)]]