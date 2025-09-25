local function LoadModelAsync(model)
    RequestModel(model)
    while not HasModelLoaded(model) do
        Wait(100)
    end
end

function CreateShopPed(model, coords)
    local ped = CreatePed(5, model, coords.x, coords.y, coords.z, coords.w, false, true)
    FreezeEntityPosition(ped, true)
    SetEntityInvincible(ped, true)
    SetBlockingOfNonTemporaryEvents(ped, true)
    SetPedCanRagdollFromPlayerImpact(ped, false)
end

Citizen.CreateThread(function()
    local shopModel = `a_m_y_juggalo_01`

    LoadModelAsync(shopModel)

    for k, v in pairs(Config['shops'].coords.shopGreenzone) do
        CreateShopPed(shopModel, v)
    end
end)

local function RegisterShopPlaces(coords, menuId, shopType, items)
    for _, v in ipairs(coords) do

        if menuId == "greenzone" then
            -- local blip = AddBlipForCoord(v)

            -- SetBlipSprite(blip, 480)
            -- SetBlipColour(blip, 0)
            -- SetBlipScale(blip, 0.5)
            -- SetBlipDisplay(blip, 5)
            -- SetBlipAsShortRange(blip, true)
    
            -- BeginTextCommandSetBlipName('STRING')
            -- AddTextComponentSubstringPlayerName('sklep')
            -- EndTextCommandSetBlipName(blip)

            NON.RegisterPlace(v, {size = vector3(2.0, 2.0, 0.3)}, 'otworzyć ' .. shopType, function()
                if not IsPedInAnyVehicle(PlayerPedId(), false) then
                    OpenShopInventory(menuId, shopType, items)
                end
            end, function()
                ESX.UI.Menu.CloseAll()
            end)
        end

        if menuId == "sklep" then
            NON.RegisterPlace(v, {size = vector3(2.0, 2.0, 0.3)}, 'otworzyć ' .. shopType, function()
                if not IsPedInAnyVehicle(PlayerPedId(), false) then
                    OpenShopInventory(menuId, shopType, items)
                end
            end, function()
                ESX.UI.Menu.CloseAll()
            end)
        end
    end
end

function OpenShopInventory(menuId, shopType, items)
    if menuId == 'greenzone' then
        ESX.UI.Menu.CloseAll()
        ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'non_'..menuId..'_choice', {
            title    = 'Wybierz',
            align    = 'center',
            elements = {
                {label = 'Kup przedmioty', value = 'buy'},
                {label = 'Sprzedaj przedmioty', value = 'sell'}
            }
        }, function(data, menu)
            local type = data.current.value
            local shop = 'Sklep'
            local elements = {}

            if type == "buy" then
                for k, v in pairs(Config['shops'].items.shopGreenzone) do
                    table.insert(elements, {label = v.label..' - <span style="color:green;">'..v.price..'$</span>', value = v.item})
                    shop = 'Sklep'
                end
            elseif type == "sell" then
                for k, v in pairs(Config['shops'].items.sell) do
                    table.insert(elements, {label = v.label..' - <span style="color:green;">'..v.price..'$</span>', value = v.item})
                    shop = 'Sprzedawca (VIP X2)'
                end
            end

            ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'non_'..menuId, {
                title    = shop,
                align    = 'center',
                elements = elements
            }, function(data2, menu2)
                ESX.UI.Menu.Open('dialog', GetCurrentResourceName(), 'non_'..menuId..'_count', {
                    title = 'Ilość'
                }, function(data3, menu3)
                    local count = tonumber(data3.value)

                    if not count then
                        TriggerEvent('non:showNotification', {
                            type = 'error',
                            title = 'Sklep',
                            text = 'Błędna ilość'
                        })
                    else
                        menu3.close()
                        menu2.close()
                        menu.close()

                        if type == 'buy' then
                            TriggerServerEvent('non_shop:pedalskieitemki', 'cwelbuy', data2.current.value, count)
                        elseif type == 'sell' then
                            TriggerServerEvent('non_shop:pedalskieitemki', 'cwelsell', data2.current.value, count)
                        end
                    end
                end, function(data3, menu3)
                    menu3.close()
                end)
            end, function(data2, menu2)
                menu2.close()
            end)
        end, function(data, menu)
            menu.close()
        end)
    else
        local elements = {}

        if menuId == 'sklep' then
            for k, v in pairs(items) do
                table.insert(elements, {label = v.label..' - <span style="color:green;">'..v.price..'$</span>', value = v.item})
            end
        end

        ESX.UI.Menu.CloseAll()
        ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'non_'..menuId, {
            title    = 'Sklep',
            align    = 'center',
            elements = elements
        }, function(data, menu)
            ESX.UI.Menu.Open('dialog', GetCurrentResourceName(), 'non_'..menuId..'_count', {
                title = 'Ilość'
            }, function(data2, menu2)
                local count = tonumber(data2.value)

                if not count then
                    TriggerEvent('non:showNotification', {
                        type = 'error',
                        title = 'Sklep',
                        text = 'Błędna ilość'
                    })
                else
                    menu2.close()
                    menu.close()
                    TriggerServerEvent('non_shop:pedalskieitemki', 'cwelbuy', data.current.value, count)
                end
            end, function(data2, menu2)
                menu2.close()
            end)
        end, function(data, menu)
            menu.close()
        end)
    end
end

Citizen.CreateThread(function()
    local shopModel = 'mp_m_shopkeep_01'

    LoadModelAsync(shopModel)
    LoadModelAsync(shopModel)

    RegisterShopPlaces(Config['shops'].coords.shop, 'sklep', 'sklep', Config['shops'].items.shop)
    RegisterShopPlaces(Config['shops'].coords.shopGreenzone, 'greenzone', 'sklep')
end)

Citizen.CreateThread(function()
    for _, v in ipairs(Config['shops'].coords.shop) do
        local blip = AddBlipForCoord(v)
        SetBlipSprite(blip, 59)
        SetBlipScale(blip, 0.6)
        SetBlipColour(blip, 25)
        SetBlipAsShortRange(blip, true)
        BeginTextCommandSetBlipName('STRING')
        AddTextComponentSubstringPlayerName('Sklep')
        EndTextCommandSetBlipName(blip)
    end
end)
