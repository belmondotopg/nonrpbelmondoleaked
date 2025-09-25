local usedComponents = {}
local equippedComponents = {}

RegisterNetEvent('non:useComponent')
AddEventHandler('non:useComponent', function(component, count)
    if not usedComponents[component] then
        usedComponents[component] = 0
    end

    local ped = PlayerPedId()
    local currentWeapon = GetSelectedPedWeapon(ped)
    local canEquip = false
    for weaponName, componentHash in pairs(Config['weaponcomponents'].componentsList[component]) do
        if weaponName == currentWeapon then
            canEquip = true
            if not HasPedGotWeaponComponent(ped, currentWeapon, componentHash) then
                if usedComponents[component] and usedComponents[component] >= count then
                    ESX.ShowNotification('Nie posiadasz więcej tego dodatku', 'error')
                else
                    GiveWeaponComponentToPed(ped, weaponName, componentHash)
                    usedComponents[component] = usedComponents[component] + 1
                    equippedComponents[currentWeapon] = equippedComponents[currentWeapon] or {}
                    equippedComponents[currentWeapon][component] = (equippedComponents[currentWeapon][component] or 0) + 1
                end
            else
                RemoveWeaponComponentFromPed(ped, currentWeapon, componentHash)
                usedComponents[component] = usedComponents[component] - 1
                if equippedComponents[currentWeapon] then
                    equippedComponents[currentWeapon][component] = (equippedComponents[currentWeapon][component] or 1) - 1
                    if equippedComponents[currentWeapon][component] <= 0 then
                        equippedComponents[currentWeapon][component] = nil
                    end
                end
            end
            PlaySoundFrontend(-1, "WEAPON_ATTACHMENT_UNEQUIP", "HUD_AMMO_SHOP_SOUNDSET", 1)
            break
        end
    end

    if not canEquip then
        ESX.ShowNotification('Ta broń nie pasuje do tego dodatku', 'error')
    end
end)

RegisterNetEvent('esx:removeInventoryItem', function(item, count)
    if Config['weaponcomponents'].componentsList[item] then
        if count == 0 then
            local ped = PlayerPedId()
            for weaponName, componentHash in pairs(Config['weaponcomponents'].componentsList[item]) do
                if HasPedGotWeapon(ped, weaponName, false) and HasPedGotWeaponComponent(ped, weaponName, componentHash) then
                    RemoveWeaponComponentFromPed(ped, weaponName, componentHash)
                end
            end
            usedComponents[item] = 0
            for weaponName, components in pairs(equippedComponents) do
                if components[item] then
                    components[item] = nil
                end
            end
        end
    end
end)

CreateThread( function()
    while equippedComponents do
        Wait(1000)
        local ped = PlayerPedId()
        local currentWeapon = GetSelectedPedWeapon(ped)
        
        if equippedComponents[currentWeapon] then
            for component, _ in pairs(equippedComponents[currentWeapon]) do
                for weaponName, componentHash in pairs(Config['weaponcomponents'].componentsList[component]) do
                    if weaponName == currentWeapon and not HasPedGotWeaponComponent(ped, currentWeapon, componentHash) then
                        GiveWeaponComponentToPed(ped, weaponName, componentHash)
                    end
                end
            end
        end
    end
end)
