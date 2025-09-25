-- LOCAL

local Complete = false
local ActiveProgress = false

-- FUNCTIONS

ProgressBar = function(time, message, icon)
    if ActiveProgress then return end

    local ikonkapozdro = icon or "fa-solid fa-gun"

    SendNUIMessage({
        action = "ProgressBar",
        message = message,
        time = time,
        icon = ikonkapozdro,
    })

    ActiveProgress = true

    while ActiveProgress do
        Citizen.Wait(500)
    end

    return Complete
end

HideProgressBar = function()
    if ActiveProgress then
        ActiveProgress = false
        Complete = false
        SendNUIMessage({
            action = "HideProgressBar",
        })
    end
end

-- UI

RegisterNUICallback('ProgBarComplete', function(data, cb)
    if ActiveProgress then
        Complete = true
        Wait(100)
        ActiveProgress = false
    end
end)

-- EXPORTS

exports('ProgressBar', ProgressBar)
exports('HideProgressBar', HideProgressBar)