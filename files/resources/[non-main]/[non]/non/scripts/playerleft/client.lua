local sleepTime = 1000
local playersLeft = {}

function DrawLeaveMessage(coords, k, v)
    ESX.Game.Utils.DrawText3D(coords, '~w~ID: ~b~'..k..' ('..v.name..')~n~~w~Opuścił/a serwer~w~~n~~b~'..v.date, 1.1, 4)
end

Citizen.CreateThread(function()
    while true do
        local sleep = true

        for k, v in pairs(playersLeft) do
            if #(GetEntityCoords(PlayerPedId()) - v.coords) < 15.0 then
                sleep = false
                DrawLeaveMessage(v.coords, k, v)
            end
        end

        if sleep then
            Citizen.Wait(sleepTime)
        else
            Citizen.Wait(0)
        end
    end
end)

RegisterNetEvent('non:playerLeft')
AddEventHandler('non:playerLeft', function(data)
    playersLeft[data.source] = data

    SetTimeout(120000, function()
        playersLeft[data.source] = nil
    end)
end)