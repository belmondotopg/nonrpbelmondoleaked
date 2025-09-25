ESX = exports['es_extended']:getSharedObject()

local Cooldown = false
local Active = 0


function Cooldown_fnc()
    Citizen.CreateThread(function()
        SetPlayerCanDoDriveBy(PlayerId(), false)
        ESX.ShowNotification("Regenerowanie sił...")
        Cooldown = true
        Wait(10000)
        Active = 0
        Cooldown = false
    end)
end

Citizen.CreateThread(function()
  while true do
    Citizen.Wait(1000)
    if IsPedSittingInAnyVehicle(PlayerPedId()) then
        if (Active >= 5 and Cooldown == false) then
            Cooldown_fnc()
        end
        
        if (Cooldown == true) then
            SetPlayerCanDoDriveBy(PlayerId(), false)
        else 
            if (IsPlayerFreeAiming(PlayerId(PlayerPedId()))) then
                Active = Active + 1
            else
                Active = Active - 1

                if ( 0 >= Active) then
                    Active = 0
                end

            end
            SetPlayerCanDoDriveBy(PlayerId(), false)
        end
    end
  end
end)