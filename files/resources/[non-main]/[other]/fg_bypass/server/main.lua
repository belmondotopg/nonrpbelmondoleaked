ESX = exports["es_extended"]:getSharedObject()
local categorys = {
    "Client",
    "Weapon",
    "Vehicle",
    "Blacklist",
    "Misc",
}

AddEventHandler("esx:playerLoaded", function(player, xPlayer)
    if xPlayer == nil then 
        return 
    end

    local groupConfig = Config[xPlayer.getGroup()]

    if groupConfig ~= nil then
        if GetResourceState(FiveGuard) ~= "started" then 
            return 
        end

        for k, v in ipairs(categorys) do
            local category = tostring(v)

            if groupConfig[category] ~= nil then
                for m, n in ipairs(groupConfig[category]) do
                    local permission = n

                    Wait(5000)
                    SetTempPermission(player, category, permission)
                end
            end
        end
    end
end)

function SetTempPermission(player, category, permission)
    local success = exports[FiveGuard]:SetTempPermission(player, category, permission, true, true)

    if not success then
        Wait(1000)
        SetTempPermission(player, category, permission)
    end
end