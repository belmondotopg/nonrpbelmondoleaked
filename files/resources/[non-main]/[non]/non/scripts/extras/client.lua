for k, coords in pairs(Config['extras'].Zones) do
    NON.RegisterPlace(coords, {type = 27, size = vector3(4.5, 4.5, 1.0), dist = 35.0}, nil,
    function()
        if IsPedInAnyVehicle(PlayerPedId(), false) then
            ChooseAction()
        end
    end,
    function()
        ESX.UI.Menu.CloseAll()
        ESX.HideUI()
    end,
    function()
        ESX.UI.Menu.CloseAll()
        ESX.TextUI("Naciśnij [E], aby modyfikować pojazd")
    end, "police")
end

function ChooseAction()
    local elements = {
        {label = 'Extra', value = 'extra'},
        {label = 'Livery', value = 'livery'}
    }

    ESX.UI.Menu.CloseAll()

    ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'non_menu_extras', {
		title    = 'Wybierz kategorie',
		align    = 'center',
		elements = elements
	}, function(data, menu)
		if data.current.value then
			ChoosedAction(data.current.value)
		end
	end, function(data, menu)
		menu.close()
	end)
end

function ChoosedAction(actionType)
    local elements = {}

    local ped = PlayerPedId()
    local veh = GetVehiclePedIsIn(ped, true)

    if actionType == 'extra' then
        SetVehicleAutoRepairDisabled(veh, true)

        for ExtraID = 0, 20 do
            if DoesExtraExist(veh, ExtraID) then
                table.insert(elements, {label = 'Dodatek - '..ExtraID, value = ExtraID})
            end
        end
    elseif actionType == 'livery' then
        local liveryCount = GetVehicleLiveryCount(veh)
        if liveryCount ~= -1 then
            for liveries = 1, liveryCount do
                table.insert(elements, {label = 'Livery - '..liveries, value = liveries})
            end
        end
    end

    if #elements > 0 then
        ESX.UI.Menu.CloseAll()
        ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'non_menu_extras', {
            title    = string.upper(actionType),
            align    = 'left',
            elements = elements
        }, function(data, menu)
            if actionType == 'extra' then
                if IsVehicleExtraTurnedOn(veh, data.current.value) then
					SetVehicleExtra(veh, data.current.value, 1)
				else
					SetVehicleExtra(veh, data.current.value, 0)
				end
            elseif actionType == 'livery' then
                SetVehicleLivery(veh, data.current.value)
            end
        end, function(data, menu)
            menu.close()
        end)
    else
        TriggerEvent('non:showNotification', {
            type = 'error',
            title = 'Pojazd',
            text = "Pojazd tego nie posiada"
        })
    end
end