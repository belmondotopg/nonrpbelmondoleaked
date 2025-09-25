local czyjestwzoniewmiescie = false
local sprawdzonyloocikooo = false
local czywyszedl = false

playerPed = PlayerPedId()
pCoords = GetEntityCoords(playerPed)
vehicle = GetVehiclePedIsIn(playerPed, false)
weapon = GetSelectedPedWeapon(playerPed);

CreateThread(function ()
    while true do
        Wait(500)
        playerPed = PlayerPedId()
        pCoords = GetEntityCoords(playerPed)
        vehicle = GetVehiclePedIsIn(playerPed, false)
        weapon = GetSelectedPedWeapon(playerPed);
    end
end)


function GetCurrentZone(pCoords)
    for zoneName, zoneData in pairs(Config['Nolootzones'].Zones) do
        local distance = #(pCoords - zoneData.Coords)
        if distance <= zoneData.Radius then
            return zoneName
        end
    end
    return nil
end

CreateThread(function()
    for k, v in pairs(Config['Nolootzones'].Zones) do
        if v.blip.addblip then
            local blip = AddBlipForCoord(v.Coords)

            SetBlipSprite(blip, 487)
            SetBlipColour(blip, 5)
            SetBlipAsShortRange(blip, true)

            BeginTextCommandSetBlipName('STRING')
            AddTextComponentSubstringPlayerName('Strefa Bez Lootowania')
            EndTextCommandSetBlipName(blip)

            local blipRadius = AddBlipForRadius(v.Coords, v.Radius)
            SetBlipColour(blipRadius, 5)
            SetBlipAlpha(blipRadius, 75)
        end
    end
end)

CreateThread(function()
    while true do
        Citizen.Wait(100)
        sleep = true
        wstrefie = false
        for zoneTitel, zoneData in pairs(Config['Nolootzones'].Zones) do
            if #(zoneData.Coords - pCoords) < zoneData.Radius then
                sleep = false
                wstrefie = true
                local currentZone = GetCurrentZone(pCoords)
         
                if sprawdzonyloocikooo == false then
                    Wait(100)
                    EnteredNolootzone()
                end
            end
        end
        if not wstrefie and sprawdzonyloocikooo then
            LeftNolootzone()
        end
        if sleep then
            Wait(200)
        end
    end
end)

-- GZ NO LOOT
CreateThread(function ()
    while true do
        Wait(300)
        sleep = true
        for zoneTitel, zoneData in pairs(Config['Nolootzones'].Zones) do
            if #(zoneData.Coords - pCoords) < 550 then
                sleep = false
                DrawMarker(28, zoneData.Coords.x, zoneData.Coords.y, zoneData.Coords.z, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, zoneData.Radius, zoneData.Radius, zoneData.Radius, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0)
            end
        end
        if sleep then
            Wait(500)
        end
    end
end)


function EnteredNolootzone()
    local ped = PlayerPedId()
    showNotification({
        type = 'info',
        title = 'NOLOOTZONE',
        text = "Wjechałeś do strefy bez lootowania"
    })

    if Config['Nolootzones'].Zones[GetCurrentZone(pCoords)] then
        LocalPlayer.state:set('IsInNoLootZone', true, true)
    end

    PlaySound(-1, "CHARACTER_CHANGE_CHARACTER_01_MASTER", 0, 0, 0, 0)
    DisableControlAction(0, 18, true)
    sprawdzonyloocikooo = true
    czyjestwzoniewmiescie = true
end

function LeftNolootzone()
    showNotification({
        type = 'info',
        title = 'NOLOOTZONE',
        text = "Wyjechałeś ze strefy bez lootowania"
    })



    if LocalPlayer.state.IsInNoLootZone then 
        LocalPlayer.state:set('IsInNoLootZone', false, true)
    end

    EnableControlAction(0, 18, true)
    czyjestwzoniewmiescie = false
    sprawdzonyloocikooo = false
end


function sprawdzloociknie()
    return sprawdzonyloocikooo
end

exports("sprawdzloociknie", sprawdzloociknie)