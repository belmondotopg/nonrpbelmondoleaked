local currentMsgIndex = 0
local unsubscribedIds = {}

RegisterNetEvent('non-announcements:SetPlayerUnsubscribed', function(value)
    local src = tostring(source)
    unsubscribedIds[src] = (value == true and true or nil)
end)

CreateThread(function()
    while true do
        Wait(3 * 60000)
        currentMsgIndex = (currentMsgIndex % #Config['announcements'].Messages) + 1
        local message = Config['announcements'].Messages[currentMsgIndex]

        for k, v in pairs(GetPlayers()) do
            if not unsubscribedIds[v] then
                TriggerClientEvent("non-chat", v, {
                    label = "fa-solid fa-bullhorn",
                    color = "#8C9EFF",
                }, {
                    background = "#15171E",
                    type = "OGŁOSZENIE",
                    title = "fa-solid fa-bullhorn",
                    content = message
                })
            end
        end
    end
end)

AddEventHandler('playerDropped', function()
    local src = tostring(source)
    unsubscribedIds[src] = nil
end)