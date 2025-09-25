showNotification = function(data)
    if not data or not data.type then
        print("Błąd (showNotification): Nieprawidłowe dane wejściowe")
        return
    end

    local notificationType = data.type

    SendNUIMessage({
        type = 'info',
        action = 'notification',
        notification = data
    })

    if notificationType == "error" then
        -- PlaySoundFrontend(-1, "Bomb_Disarmed", "GTAO_Speed_Convoy_Soundset", 1)
    else
        -- PlaySoundFrontend(-1, "Menu_Accept", "Phone_SoundSet_Default", 1)
    end
end

showAdminNotification = function(data)
    if not data then
        print("Błąd (showNotification): Nieprawidłowe dane wejściowe")
        return
    end

    local notificationType = data.type

    SendNUIMessage({
        type = 'info',
        action = 'sendAdminNotification',
        notification = data
    })

    if notificationType == "error" then
        PlaySoundFrontend(-1, "Bomb_Disarmed", "GTAO_Speed_Convoy_Soundset", 1)
    else
        PlaySoundFrontend(-1, "Menu_Accept", "Phone_SoundSet_Default", 1)
    end
end

RegisterNetEvent('non:showAdminNotification')
AddEventHandler('non:showAdminNotification', function(data)
    showAdminNotification(data)
end)

RegisterNetEvent('non:showNotification')
AddEventHandler('non:showNotification', function(data)
    showNotification(data)
end)

exports('showNotification', showNotification)

