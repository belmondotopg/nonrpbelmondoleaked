local checkGZ = false
local checkOczko = false 
local teleportCooldowns = {}
local insideGZ = {}
local blipsGZ = {}
local gz = {
    ["1"] = {
        Oczko = false,
        coords = vector3(2052.6382, 3182.6848, 45.1689),
        r = 0,
        g = 255,
        b = 0,
        a = 0.2,
        radius = 53.0,
        bucket = true,
        label = "Sandy",
        blip = {
            title = "GreenZone",
            color = 2,
            sprite = 492,
            scale = 1.0,
            spread = true,
        },
    },
        ["777"] = {
        Oczko = false,
        coords = vector3(1008.8753, -2521.4507, 28.3067),
        r = 0,
        g = 255,
        b = 0,
        a = 0.2,
        radius = 53.0,
        bucket = true,
        label = "Doki",
        blip = {
            title = "GreenZone",
            color = 2,
            sprite = 492,
            scale = 1.0,
            spread = true,
        },
    },

    ["2"] = {
        Oczko = false,
        coords = vector3(1840.7261, 3685.0762, 38.9293),
        r = 217,
        g = 178,
        b = 137,
        a = 0.2,
        radius = 35.0,
        bucket = false,
    },
    
    ["3"] = {
        Oczko = false,
        coords = vector3(1225.2556, 2716.8162, 38.0058),
        r = 255,
        g = 119,
        b = 51,
        a = 0.2,
        radius = 26.0,
        label = "Auta",
        bucket = false,
    },

    ["4"] = {
        Oczko = false,
        coords = vector3(1693.8465576172, 2585.1259765625, 45.564846038818),
        r = 255,
        g = 119,
        b = 51,
        a = 0.0,
        radius = 160.0,
        bucket = false,
        blip = {
                title = "Wiezienie",
                color = 76,
                sprite = 253,
                scale = 1.0,
                spread = false,
            },
    },

    ["5"] = {
        Oczko = false,
        coords = vector3(1175.6056, 2639.6033, 37.7538),
        r = 255,
        g = 119,
        b = 51,
        a = 0.0,
        radius = 16.0,
        bucket = false,
    },
}
    
local gzTeleport = {
    vector4(2059.1868, 3169.1401, 44.1690, 34.2889),
    vector4(1003.7952, -2514.6506, 28.3014-.9, 253.4527)
}

-- FUNCTIONS

StartTeleportWithProgress = function(targetCoords)
    local playerPed = PlayerPedId()
    local playerId = GetPlayerServerId(PlayerId())
    local initialCoords = GetEntityCoords(playerPed)
    local isMoving = false

    local currentTime = GetGameTimer()
    if teleportCooldowns[playerId] and currentTime < teleportCooldowns[playerId] then
        local remainingTime = math.ceil((teleportCooldowns[playerId] - currentTime) / 1000)
        ESX.ShowNotification("Musisz poczekać jeszcze " .. remainingTime .. " sekund przed kolejnym teleportem!")
        return
    end

    showProgress({title = 'Teleportowanie...', time = 5 * 1000}, function(isDone)
        if isDone then
            local currentCoords = GetEntityCoords(playerPed)
            if #(currentCoords - initialCoords) > 1.0 then
                ESX.ShowNotification("Teleport anulowany - poruszyłeś się!")
            else
                teleportCooldowns[playerId] = GetGameTimer() + 60 * 1000
                ESX.Game.Teleport(playerPed, targetCoords)
                ESX.ShowNotification("Teleport udany!")
                Wait(500)
                EnteredGZ()
            end
        else
            cancelProgress()
            ESX.ShowNotification("Teleport anulowany!")
        end
    end)
end


RegisterCommand("tpmenu", function()
    GreenZoneTeleport()
end, false)

for k, v in pairs(gzTeleport) do
    NON.RegisterPlace(v, {size = vector3(2.0, 2.0, 0.3)}, "przeteleportowac sie na innego GZ",
    function()
        if not IsPedInAnyVehicle(PlayerPedId(), false) then
            GreenZoneTeleport()
        end
    end,
    function()
        ESX.UI.Menu.CloseAll()
    end)    
end    

GreenZoneTeleport = function()
    local elements = {}

    for k, v in pairs(gz) do
        if v.label then
            elements[#elements+1] = {label = v.label, value = v.coords}
        end
    end

    ESX.UI.Menu.CloseAll()

    ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'non-teleports', {
        title    = 'Wybierz greenzone',
        align    = 'center',
        elements = elements
    }, function(data, menu)
        menu.close()
        if data.current.value then
            StartTeleportWithProgress(data.current.value)
        end
    end, function(data, menu)
        menu.close()
    end)
end

notify = function(msg)
    ESX.ShowNotification(msg)
end

EnteredGZ = function()
    checkGZ = true
    notify("Znajdujesz sie w bezpieczniej strefie")
    -- cancelProgress()
    SetGhostedEntityAlpha(254)
    SetLocalPlayerAsGhost(true)
end

QuitGZ = function()
    checkGZ = false
    notify("Wychodzisz z bezpiecznej strefy")
    SetLocalPlayerAsGhost(false)
end

GetVehicleOccupants = function(vehicle)
    local occupants = {}
    local maxSeats = GetVehicleModelNumberOfSeats(GetEntityModel(vehicle)) - 1

    for seat = -1, maxSeats do
        local occupant = GetPedInVehicleSeat(vehicle, seat)
        if occupant and occupant ~= 0 then
            table.insert(occupants, GetPlayerServerId(NetworkGetPlayerIndexFromPed(occupant)))
        end
    end

    return occupants
end

GreenZoneTeleport = function()
    local elements = {}
    
    for k, v in pairs(gz) do
        if v.label then
            elements[#elements+1] = {label = v.label, value = v.coords}
        end
    end
    
    ESX.UI.Menu.CloseAll()

    ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'non-teleports', {
        title    = 'Wybierz greenzone',
        align    = 'center',
        elements = elements
    }, function(data, menu)
        menu.close()
        if data.current.value then
            ESX.Game.Teleport(PlayerPedId(), data.current.value)

            Wait(500)

            EnteredGZ()
        end
    end, function(data, menu)
        menu.close()
    end)
end

for k, v in pairs(gzTeleport) do
    NON.RegisterPlace(v, {size = vector3(2.0, 2.0, 0.3)}, "przeteleportowac sie na innego GZ",
	function()
        if not IsPedInAnyVehicle(PlayerPedId(), false) then
            GreenZoneTeleport()
        end
	end,
	function()
		ESX.UI.Menu.CloseAll()
	end)
end

CheckGZ = function()
    return checkGZ
end

CheckOczko = function()
    return checkOczko
end

exports("checkOczko", CheckOczko)

exports("checkGZ", CheckGZ)


-- MAIN LOOP

CreateThread(function()
    while true do
        local playerPed = PlayerPedId()
        local pedCoords = GetEntityCoords(playerPed)
        local msec = 500

        for k, v in pairs(gz) do
            local distance = #(pedCoords - v.coords)

            if distance < v.radius + 60.0 then
                msec = 0
            end

            for _, player in ipairs(GetActivePlayers()) do
                local otherPed = GetPlayerPed(player)
                if playerPed ~= otherPed then
                    SetEntityNoCollisionEntity(playerPed, otherPed, true)
                end
            end

            if distance < v.radius then
                if not insideGZ[k] then
                    insideGZ[k] = true
                    if v.bucket then
                        if IsPedInAnyVehicle(playerPed, false) then
                            local vehicle = GetVehiclePedIsIn(playerPed, false)
                            local occupants = GetVehicleOccupants(vehicle)

                            TriggerServerEvent("non-greenzones:setbucket", 10, NetworkGetNetworkIdFromEntity(vehicle), occupants)
                        else
                            TriggerServerEvent("non-greenzones:setbucket", 10, nil, {GetPlayerServerId(PlayerId())})
                        end
                    end
                    EnteredGZ()
                end
            else
                if insideGZ[k] then
                    insideGZ[k] = false
                    if not SprawdzDuel() then
                        if v.bucket then
                            if IsPedInAnyVehicle(playerPed, false) then
                                local vehicle = GetVehiclePedIsIn(playerPed, false)
                                local occupants = GetVehicleOccupants(vehicle)

                                TriggerServerEvent("non-greenzones:setbucket", 0, NetworkGetNetworkIdFromEntity(vehicle), occupants)
                            else
                                TriggerServerEvent("non-greenzones:setbucket", 0, nil, {GetPlayerServerId(PlayerId())})
                            end
                        end
                    end
                    QuitGZ()
                end
            end
        end

        Wait(msec)
    end
end)


CreateThread(function()
    for k, v in pairs(gz) do
        if v.blip then
            local blip = AddBlipForCoord(v.coords)
            SetBlipSprite(blip, v.blip.sprite)
            SetBlipDisplay(blip, 4)
            SetBlipScale(blip, v.blip.scale)
            SetBlipColour(blip, v.blip.color)
            SetBlipAsShortRange(blip, true)
            BeginTextCommandSetBlipName("STRING")
            AddTextComponentString(v.blip.title)
            EndTextCommandSetBlipName(blip)
            blipsGZ[k] = blip

            if v.blip.spread then
                local blipRadius = AddBlipForRadius(v.coords, v.radius)
                SetBlipColour(blipRadius, v.blip.color)
                SetBlipAlpha(blipRadius, 128)
            end
        end
    end
    while true do
        local playerPed = PlayerPedId()
        local pedCoords = GetEntityCoords(playerPed)
        local msec = 100
        for k, v in pairs(gz) do
            local distance = #(pedCoords - v.coords)

            if GetDistanceBetweenCoords(pedCoords, v.coords) < v.radius + 60.0 then
                DrawSphere(v.coords, v.radius, v.r, v.g, v.b, v.a)
                msec = 0
            elseif GetDistanceBetweenCoords(pedCoords, v.coords) < v.radius + 60.0 then
                msec = 100
            end
        end

        Wait(msec)
    end
end)