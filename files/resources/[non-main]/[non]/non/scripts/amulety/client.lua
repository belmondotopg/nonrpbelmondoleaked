local activeAmulets = {}
local isAmuletActive = false

RegisterNetEvent('non-amulety:useTotem')
AddEventHandler('non-amulety:useTotem', function(amulet)
    ESX.TriggerServerCallback("non-amulety:getAvailableTotems", function(availableTotems)
        if availableTotems[amulet] then
            ESX.ShowNotification("Rozpoczynasz używanie amuletu: " .. amulet)
            ActivateAmulet(amulet)
        else
            ESX.ShowNotification("Nie możesz użyć tego amuletu.")
        end
    end)
end)

function ActivateAmulet(amulet)
    local data = Config['amulety'][amulet]
    if not data then return end

    if isAmuletActive then
        return
    end

    isAmuletActive = true
    Citizen.CreateThread(function()
        while isAmuletActive do
            local playerPed = PlayerPedId()
            local playerId = PlayerId()
            if data.action then
                data.action(playerPed, playerId)
            end
            Citizen.Wait(data.interval)
            RemoveAllAmulets(amulet)
        end
    end)
end

function RemoveAllAmulets(amulet)
    local data = Config['amulety'][amulet]
    local playerPed = PlayerPedId()
    local playerId = PlayerId()

    if data.remove then
        data.remove(playerPed, playerId)
        ESX.ShowNotification("Efekty amuletów zostały usunięte.")
    end

    isAmuletActive = false
end