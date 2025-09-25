-- FUNCTIONS

GetProximity = function()
    for k,v in pairs(Config['hud'].proximityModes) do
        if v[1] == NetworkGetTalkerProximity() then
            return v[2]
        end
    end
    return 0
end

-- EXPORTS

exports('ToggleHUD', function()
    Config['hud'].ShowHud = not Config['hud'].ShowHud
    SendNUIMessage({ action = 'UPDATE_HUD', show = Config['hud'].ShowHud })
end)

-- MAIN LOOP

CreateThread(function()
    while true do
        local Ped = GetPlayerPed()
        local PedID = PlayerPedId()
        local PlayerID = PlayerId()
        local health = GetEntityHealth(PedID)
        local armor = GetPedArmour(PedID)
        local PedCar = GetVehiclePedIsUsing(PlayerPedId(), false)
        local carSpeed = math.floor(GetEntitySpeed(PedCar) * 3.6 + 0.5)
        local rpm = 0
        local pedCoords = GetEntityCoords(playerPed)
        if(IsPedInAnyVehicle(PedID, false)) and not IsPauseMenuActive() then
            rpm = GetVehicleCurrentRpm(PedCar) * 100
            Config['hud'].Carhud = true
        else
            Config['hud'].Carhud = false
        end
        
        SendNUIMessage({
            action = 'UPDATE_HUD',
            health = health,
            armor = armor,
            carhud = Config['hud'].Carhud,
            speed = carSpeed,
            rpmbar = rpm,
            voice = GetProximity(),
            state = NetworkIsPlayerTalking(PlayerID),
            show = Config['hud'].ShowHud,
        })

        Wait(Config['hud'].Wait)
    end
end)

-- UI

RegisterNUICallback('hideHUDSettings', function(data, cb)
    SetNuiFocus(false, false)
    SendNUIMessage({action = 'HIDE_HUDSETTINGS'})
    cb('ok')
end)

-- COMMANDS

RegisterCommand("hudshow", function()
    Config['hud'].ShowHud = not Config['hud'].ShowHud
    DisplayRadar(Config['hud'].ShowHud)
    SendNUIMessage({action = 'UPDATE_HUD', show = Config['hud'].ShowHud})
end)
  
RegisterKeyMapping('hudshow', 'Ukryj/Pokaż Hud', 'MOUSE_BUTTON', 'MOUSE_MIDDLE')
