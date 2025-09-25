RegisterCommand('ogloszenia', function(src, args, raw)
    local disabled = GetResourceKvpString('non-aa:toggled') == 'true'
    disabled = not disabled

    ESX.ShowNotification(disabled and 'Wyłączono automatyczne ogłoszenia' or 'Włączono automatyczne ogłoszenia', 'info')

    SetResourceKvp('non-aa:toggled', tostring(disabled))
    TriggerServerEvent('non-announcements:SetPlayerUnsubscribed', disabled)
end)

CreateThread(function()
    TriggerServerEvent('non-announcements:SetPlayerUnsubscribed', GetResourceKvpString('non-aa:toggled') == 'true')
    TriggerEvent('chat:addSuggestion', 'ogloszenia', 'Włącz/Wyłącz automatyczne ogłoszenia na czacie')
end)