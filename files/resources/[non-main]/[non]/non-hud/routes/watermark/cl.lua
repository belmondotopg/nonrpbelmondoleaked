-- MAIN LOOP
CreateThread(function()
    while true do
        local PlayerID = PlayerId()

        SendNUIMessage({
            action = "UPDATE_WATERMARK",
            id = GetPlayerServerId(PlayerID),
            group = ESX.GetPlayerData().group
        })

        Wait(Config['hud'].Wait)
    end
end)