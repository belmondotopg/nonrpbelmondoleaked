-- FUNCTIONS

HelpNotification = function(message)
    SendNUIMessage({
        action = "HelpNotification",
        message = message,
    })
end

HideHelpNotification = function()
    SendNUIMessage({
        action = "HideHelpNotification",
    })
end

-- EXPORTS

exports('HelpNotification', HelpNotification)
exports('HideHelpNotification', HideHelpNotification)