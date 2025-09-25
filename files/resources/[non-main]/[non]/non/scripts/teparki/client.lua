local lastTimePressed, teleportCooldown = GetGameTimer(), GetGameTimer()
local tepankotako = false
local allowedWeapons = {
    ['snspistol'] = true,
    ['pistol'] = true,
    ['pistol_mk2'] = true,
    ['snspistol_mk2'] = true,
    ['vintagepistol'] = true,
    ['ceramicpistol'] = true,
    ['heavypistol'] = true,
}

SprawdzDuel = function()
    return tepankotako
end

local function checkWeapons()
    for k, v in ipairs(ESX.GetPlayerData('inventory')) do
        if v.count > 0 then
            if ESX.IsItemAWeapon(v.name) and not allowedWeapons[v.name] then
                return ESX.ShowNotification('Posiadasz niedozwoloną broń', 'error')
            end
        end
    end
    return true
end

for i, coords in ipairs(Config['randomteleports'].Teleports) do
    NON.RegisterPlace(coords, {size = vector3(6.0, 6.0, 1.0)}, 'zawalczyć z randomem',
    function()
        if not IsPedInAnyVehicle(PlayerPedId(), false) then
            if checkWeapons() then
                if lastTimePressed < GetGameTimer() and teleportCooldown < GetGameTimer() then
                    lastTimePressed = GetGameTimer() + 3000
                    ESX.TriggerServerCallback('randomteleports:start', function() end)
                end
            end
        end
    end,
    function()
        TriggerServerEvent('randomteleports:exitQueue')
    end,
    function()

    end)
end

RegisterNetEvent('randomteleports:drawOtherPlayer', function(enemyId)
    local displayLine = true
    tepankotako = true

    CreateThread(function()
        while displayLine do
            local playerPed = PlayerPedId()
            local playerCoords = GetEntityCoords(playerPed)
            local enemyPed = GetPlayerPed(GetPlayerFromServerId(enemyId))
            local enemyCoords = GetEntityCoords(enemyPed)
            SetGhostedEntityAlpha(100)
            SetLocalPlayerAsGhost(true)
            DrawLine(playerCoords.x, playerCoords.y, playerCoords.z, enemyCoords.x, enemyCoords.y, enemyCoords.z, 255, 0, 0, 255)

            Wait(0)
        end
    end)

    ESX.ShowNotification("Posiadasz 5 sekund, aby odbiec od przeciwnika.", "duel")
    Wait(5000)
    SetLocalPlayerAsGhost(false)
    displayLine = false
end)
    
RegisterNetEvent('esx_ambulancejob:revive', function()
    tepankotako = false
    teleportCooldown = GetGameTimer() + 3000
end)