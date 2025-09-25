setBinds = function(binds)
    local data = {};
    for i = 1, 5, 1 do
        if binds[i] then
            data[i] = {
                slot = i,
                image = "./items/"..binds[i].name..".png",
            }
        else
            data[i] = {
                slot = i,
            }
        end
    end

    SendNUIMessage({
        eventName = "nui:binds:update",
        data = data
    })
end

exports("setBinds", setBinds)

CreateThread(function()
    Wait(2500)
    local Binds = exports['es_extended']:GetBinds()
    setBinds(Binds)
end)
