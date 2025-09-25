local PlaceTable = {}
local MarkerData = {}
local isInMarker = nil
local isInGreenZone = nil
local NearestHelp = {}
local PlayerPedid = PlayerPedId()

local NON = {}

local clearMarkerData = false

CreateThread(function()
    while true do
        local coords = GetEntityCoords(PlayerPedid)
        PlayerPedid = PlayerPedId()
        NearestHelp = {}
        for i = 1, #PlaceTable do
            local dist = #(coords - PlaceTable[i].coords) - PlaceTable[i].MarkerProperties.isInMarkerSize
            if dist < PlaceTable[i].MarkerProperties.dist and CheckJob(PlaceTable[i].Jobs) then

                MarkerData[i] = {coords = PlaceTable[i].coords, DrawMarker = PlaceTable[i].DrawMarker, MarkerProperties = PlaceTable[i].MarkerProperties, text = PlaceTable[i].txt3d}

                -- floating 3d text nad pedy
                if PlaceTable[i].txt3d then
                    if NearestHelp.txt then
                        if #(coords - NearestHelp.coords) > dist then
                            if dist < 0 then
                                NearestHelp.txt = "Naciśnij [~b~E~w~], aby "..PlaceTable[i].txt3d
                                NearestHelp.coords = PlaceTable[i].coords
                            elseif dist < 7 then
                                NearestHelp.txt = "Podejdź bliżej, aby "..PlaceTable[i].txt3d
                                NearestHelp.coords = PlaceTable[i].coords
                            end
                        end
                    else
                        if dist < 0 then
                            NearestHelp.txt = "Naciśnij [~b~E~w~], aby "..PlaceTable[i].txt3d
                            NearestHelp.coords = PlaceTable[i].coords
                        elseif dist < PlaceTable[i].MarkerProperties.dist / 2 then
                            NearestHelp.txt = "Podejdź bliżej, aby "..PlaceTable[i].txt3d
                            NearestHelp.coords = PlaceTable[i].coords
                        end
                    end
                end
            else
                MarkerData[i] = nil
            end

            if PlaceTable[i].MarkerProperties.greenzone then
                if dist < 0 then
                    if isInGreenZone ~= i and PlaceTable[i].EnterMarkercb then
                        PlaceTable[i].EnterMarkercb()
                    end
                    isInGreenZone = i
                else
                    if isInGreenZone == i then
                        isInGreenZone = nil
                        if PlaceTable[i].ExitMarkercb then
                            PlaceTable[i].ExitMarkercb()
                        end
                    end
                end
            else
                if dist < 0 then
                    if isInMarker ~= i and PlaceTable[i].EnterMarkercb then
                        PlaceTable[i].EnterMarkercb()
                        PlaySoundFrontend(-1, "Boss_Blipped", "GTAO_Magnate_Hunt_Boss_SoundSet", 1)
                    end
                    isInMarker = i
                else
                    if isInMarker == i then
                        isInMarker = nil
                        if PlaceTable[i].ExitMarkercb then
                            PlaceTable[i].ExitMarkercb()
                        end
                    end
                end
            end
        end
        Wait(500)
        if clearMarkerData then
            clearMarkerData = false
            MarkerData = {}
        end
    end
end)

local red, green, blue = 0, 0, 0
local targetRed, targetGreen, targetBlue = 140, 158, 255  

CreateThread(function()
    while true do

        for i = 0, 255, 5 do
    
            red = math.floor(i * (targetRed / 255))
            green = math.floor(i * (targetGreen / 255))
            blue = math.floor(i * (targetBlue / 255))
            Wait(10) 
        end
        Wait(200) 

        for i = 255, 0, -5 do
            red = math.floor(i * (targetRed / 255))
            green = math.floor(i * (targetGreen / 255))
            blue = math.floor(i * (targetBlue / 255))
            Wait(10) 
        end
        Wait(1000) 
    end
end)

CreateThread(function()
    while true do
        for _, data in pairs(MarkerData) do
            if data.DrawMarker then
                local dist = #(GetEntityCoords(PlayerPedid) - data.coords) - data.MarkerProperties.isInMarkerSize

                -- jasność markera
                if data.MarkerProperties.type == 28 and not data.MarkerProperties.greenzone then
                    dist = math.abs(dist)^1.7
                else
                    if dist < 0 then
                        dist = 0
                    end
                end

                local multiplier = 1 - (dist / data.MarkerProperties.dist)

                if multiplier > 0 then
                    if data.MarkerProperties.color then
                        DrawMarker(data.MarkerProperties.type, data.coords, 0.0, 0.0, 0.0, 0, 0.0, 0.0, data.MarkerProperties.size.x, data.MarkerProperties.size.y, data.MarkerProperties.size.z, data.MarkerProperties.color.r, data.MarkerProperties.color.g, data.MarkerProperties.color.b, math.floor(data.MarkerProperties.color.a * multiplier), false, true, 2, false, false, false, false)
                    else
                        DrawMarker(data.MarkerProperties.type, data.coords, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, data.MarkerProperties.size.x, data.MarkerProperties.size.y, data.MarkerProperties.size.z, red, green, blue, math.floor(150 * multiplier), false, true, 2, false, false, false, false)
                    end
                end
            end
        end
        if NearestHelp.txt then
            ESX.ShowFloatingHelpNotification(NearestHelp.txt, vector3(NearestHelp.coords.x, NearestHelp.coords.y, NearestHelp.coords.z + 2.0))
        end
        Wait(0)
    end
end)


function CheckJob(job)
    if job and ESX.PlayerData.job then
        if string.find(job, "org") then
            if string.find(ESX.PlayerData.job.name, "org") then
                return true
            else
                return false
            end
        else
            if job == ESX.PlayerData.job.name then
                return true
            else
                return false
            end
        end
    else
        return true
    end
end

function Draw3dtxt(coords, text)
    coords = vector3(coords.x, coords.y, coords.z + 1.0)
    local camCoords = GetFinalRenderedCamCoord()
    local distance = #(coords - camCoords)

    local scale = (1 / distance) * 2
    local fov = (1 / GetGameplayCamFov()) * 100
    scale = scale * fov

    SetTextScale(0.0 * scale, 0.55 * scale)
    SetTextFont(4)
    SetTextProportional(1)
    SetTextColour(255, 255, 255, 215)
    BeginTextCommandDisplayText('STRING')
    SetTextOutline()
    SetTextCentre(true)
    AddTextComponentSubstringPlayerName(text)
    SetDrawOrigin(coords, 0)
    EndTextCommandDisplayText(0.0, 0.0)
    ClearDrawOrigin()
end

NON.RegisterPlace = function(coords, Marker, txt3d, PressEcb, ExitMarkercb, EnterMarkercb, jobs)
    local DrawMarker = false
    local MarkerProperties = {}
    if coords.w then
        coords = vector3(coords.x, coords.y, coords.z)
    end
    if type(Marker) == "boolean" then
        if Marker then
            DrawMarker = true
            MarkerProperties.type = 1
            MarkerProperties.size = vector3(2.0, 2.0, 1.0)
            MarkerProperties.color = nil
            MarkerProperties.dist = 20.0
            MarkerProperties.greenzone = false
        end
    else
        DrawMarker = true
        MarkerProperties.type = Marker.type or 1
        MarkerProperties.size = Marker.size or vector3(2.0, 2.0, 1.0)
        MarkerProperties.color = Marker.color or nil
        MarkerProperties.dist = Marker.dist or 20.0
        MarkerProperties.greenzone = Marker.greenzone or false
    end

    if MarkerProperties.type == 1 and MarkerProperties.size.x >= 5.0 then
        MarkerProperties.isInMarkerSize = MarkerProperties.size.x/1.7
    elseif MarkerProperties.type == 27 then -- garage
        MarkerProperties.isInMarkerSize = MarkerProperties.size.x/2
    else
        MarkerProperties.isInMarkerSize = MarkerProperties.size.x
    end

    PlaceTable[#PlaceTable+1] = {coords = coords, DrawMarker = DrawMarker, MarkerProperties = MarkerProperties, txt3d = txt3d, PressEcb = PressEcb, ExitMarkercb = ExitMarkercb, EnterMarkercb = EnterMarkercb, Jobs = jobs}

    return function()
        local crd = coords
        for i = 1, #PlaceTable do
            if PlaceTable[i].coords == crd then
                clearMarkerData = true
                isInMarker = nil
                table.remove(PlaceTable, i)
                break
            end
        end
    end
end

local registeredButtons = {}

NON.RegisterButton = function(key, PressCallBack, ReleaseCallBack)
    local upperKey = string.upper(key)
    if registeredButtons[upperKey] then
        registeredButtons[upperKey].press[#registeredButtons[upperKey].press+1] = PressCallBack
        if ReleaseCallBack then
            registeredButtons[upperKey].release[#registeredButtons[upperKey].release+1] = ReleaseCallBack
        end
    else
        local command_name = "Zjarus-classes-bind-"..upperKey
        registeredButtons[upperKey] = {
            press = {PressCallBack},
            release = {ReleaseCallBack}
        }

        RegisterCommand("+"..command_name, function()
            for i = 1, #registeredButtons[upperKey].press do
                registeredButtons[upperKey].press[i]()
            end
        end, false)
        RegisterCommand("-"..command_name, function()
            for i = 1, #registeredButtons[upperKey].release do
                registeredButtons[upperKey].release[i]()
            end
        end, false)

        RegisterKeyMapping("+"..command_name, "Zjarus-classes", "KEYBOARD", key)

        CreateThread(function()
            Wait(1000)

            TriggerEvent('chat:removeSuggestion', '/+'..command_name)
            TriggerEvent('chat:removeSuggestion', '/-'..command_name)
        end)
    end
end

exports('getSharedObject', function()
	return NON
end)

NON.RegisterButton("E", function()
    if isInMarker then
        PlaceTable[isInMarker].PressEcb()
    end
end)

--NON.RegisterPlace(vector3(0.0, 0.0, 0.0), true --[[DrawMarker]], "Nacinij E aby rozpocząć interakcje" --[[set nil if you doesn't need 3dtext]],
--function()
--    print("nadusił e")
--end,
--function()
--    print("wyszedł z markera")
--end,
--function()
--    print("wszedł do markera")
--end)

--NON.RegisterButton("E" --[[key]], true --[[onHolding]], function(isReleasing)
--    if isReleasing then
--        print("Puścił przycisk")
--    else
--        print("wcisnął przycisk")
--    end
--end)

--test

--[[for i = 0, 11, 1 do
    SwitchTrainTrack(i, true)
    SetTrainTrackSpawnFrequency(i, 10000)
end
SetRandomTrains(true)]]