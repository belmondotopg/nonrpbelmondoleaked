--[[local Timeouts, OpenedMenus, MenuType = {}, {}, 'dialog'

local function openMenu(namespace, name, data)
	for i=1, #Timeouts, 1 do
		ESX.ClearTimeout(Timeouts[i])
	end

	OpenedMenus[namespace .. '_' .. name] = true

	SendNUIMessage({
		action = 'openMenu',
		namespace = namespace,
		name = name,
		data = data
	})

	local timeoutId = ESX.SetTimeout(200, function()
		SetNuiFocus(true, true)
	end)

	table.insert(Timeouts, timeoutId)
end

local function closeMenu(namespace, name)
	OpenedMenus[namespace .. '_' .. name] = nil

	SendNUIMessage({
		action = 'closeMenu',
		namespace = namespace,
		name = name,
	})

	if ESX.Table.SizeOf(OpenedMenus) == 0 then
		SetNuiFocus(false)
	end

end

ESX.UI.Menu.RegisterType(MenuType, openMenu, closeMenu)

AddEventHandler('esx_menu_dialog:message:menu_submit', function(data)
	local menu = ESX.UI.Menu.GetOpened(MenuType, data._namespace, data._name)
	local cancel = false

	if menu.submit then
		-- is the submitted data a number?
		if tonumber(data.value) then
			data.value = ESX.Math.Round(tonumber(data.value))

			-- check for negative value
			if tonumber(data.value) <= 0 then
				cancel = true
			end
		end

		data.value = ESX.Math.Trim(data.value)

		-- don't submit if the value is negative or if it's 0
		if cancel then
			ESX.ShowNotification('That input is not allowed!')
		else
			menu.submit(data, menu)
		end
	end
end)

AddEventHandler('esx_menu_dialog:message:menu_cancel', function(data)
	local menu = ESX.UI.Menu.GetOpened(MenuType, data._namespace, data._name)

	if menu.cancel ~= nil then
		menu.cancel(data, menu)
	end
end)

AddEventHandler('esx_menu_dialog:message:menu_change', function(data)
	local menu = ESX.UI.Menu.GetOpened(MenuType, data._namespace, data._name)

	if menu.change ~= nil then
		menu.change(data, menu)
	end
end)

CreateThread(function()
	while true do
		Wait(0)

		if ESX.Table.SizeOf(OpenedMenus) > 0 then
			DisableControlAction(0, 1,   true) -- LookLeftRight
			DisableControlAction(0, 2,   true) -- LookUpDown
			DisableControlAction(0, 142, true) -- MeleeAttackAlternate
			DisableControlAction(0, 106, true) -- VehicleMouseControlOverride
			DisableControlAction(0, 12, true) -- WeaponWheelUpDown
			DisableControlAction(0, 14, true) -- WeaponWheelNext
			DisableControlAction(0, 15, true) -- WeaponWheelPrev
			DisableControlAction(0, 16, true) -- SelectNextWeapon
			DisableControlAction(0, 17, true) -- SelectPrevWeapon
		else
			Wait(500)
		end
	end
end)]]

Citizen.CreateThread(function()

    local Timeouts = {}
    local OpenedMenus = {}

    local openDialogMenu = function(namespace, name, data)

        for i = 1, #Timeouts, 1 do
            ESX.ClearTimeout(Timeouts[i])
        end

        OpenedMenus[namespace .. '_' .. name] = true

        local dialogTitle = data.title or "Enter value"  
        local input = lib.inputDialog(dialogTitle, {
            {type = 'input', required = true}
        })

        if not input or not input[1] then
            TriggerEvent('menu_cancel', { _namespace = namespace, _name = name })
        else
            TriggerEvent('menu_submit', { _namespace = namespace, _name = name, value = input[1] })
        end
    end

    local closeMenu = function(namespace, name)
        OpenedMenus[namespace .. '_' .. name] = nil
        local OpenedMenuCount = 0

        for k, v in pairs(OpenedMenus) do
            if v == true then
                OpenedMenuCount = OpenedMenuCount + 1
            end
        end
    end

    ESX.UI.Menu.RegisterType('dialog', openDialogMenu, closeMenu)

    RegisterNetEvent('menu_submit')
    AddEventHandler('menu_submit', function(data)
        local menu = ESX.UI.Menu.GetOpened('dialog', data._namespace, data._name)

        if menu and menu.submit then
            menu.submit({value = data.value}, menu)
        end
    end)

    RegisterNetEvent('menu_cancel')
    AddEventHandler('menu_cancel', function(data)
        local menu = ESX.UI.Menu.GetOpened('dialog', data._namespace, data._name)

        if menu and menu.cancel then
            menu.cancel(data, menu)
        end
    end)
end)