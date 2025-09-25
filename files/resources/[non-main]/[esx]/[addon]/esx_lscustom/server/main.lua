local Vehicles
local Customs = {}

RegisterNetEvent('esx_lscustom:startModing', function(props, netId)
	local src = tostring(source)
	if Customs[src] then
		Customs[src][tostring(props.plate)] = {props = props, netId = netId}
	else
		Customs[src] = {}
		Customs[src][tostring(props.plate)] = {props = props, netId = netId}
	end
end)

RegisterNetEvent('esx_lscustom:stopModing', function(plate)
	local src = tostring(source)
	if Customs[src] then
		Customs[src][tostring(plate)] = nil
	end
end)

AddEventHandler('esx:playerDropped', function(src)
    src = tostring(src)
	local playersCount = #GetPlayers()
    if Customs[src] then
        for k, v in pairs(Customs[src]) do
            local entity = NetworkGetEntityFromNetworkId(v.netId)
            if DoesEntityExist(entity) then
                if playersCount > 0 then
                    TriggerClientEvent('esx_lscustom:restoreMods', -1, v.netId, v.props)
                else
                    DeleteEntity(entity)
                end
            end
        end
        Customs[src] = nil
    end
end)

RegisterServerEvent('esx_lscustom:buyMod')
AddEventHandler('esx_lscustom:buyMod', function(price)
	local source = source
	local xPlayer = ESX.GetPlayerFromId(source)
	price = tonumber(price)

	if Config.IsMechanicJobOnly then
		local societyAccount

		TriggerEvent('esx_addonaccount:getSharedAccount', 'society_mechanic', function(account)
			societyAccount = account
		end)

		if price < societyAccount.money then
			TriggerClientEvent('esx_lscustom:installMod', source)
			TriggerClientEvent('esx:showNotification', source, _U('purchased'))
			societyAccount.removeMoney(price)
		else
			TriggerClientEvent('esx_lscustom:cancelInstallMod', source)
			TriggerClientEvent('esx:showNotification', source, _U('not_enough_money'))
		end
	else
		if price <= xPlayer.getMoney() then
			TriggerClientEvent('esx_lscustom:installMod', source)
			TriggerClientEvent('esx:showNotification', source, _U('purchased'))
			xPlayer.removeMoney(price, "LSC Purchase")
			exports['non']:SendLog(xPlayer.source, string.format("Wykonano tuning, Kwota: %s$ (gotówka)", price), 'tuning')
		elseif price <= xPlayer.getAccount('bank').money then
			TriggerClientEvent('esx_lscustom:installMod', source)
			TriggerClientEvent('esx:showNotification', source, _U('purchased'))
			xPlayer.removeAccountMoney('bank', price, "LSC Purchase")
			exports['non']:SendLog(xPlayer.source, string.format("Wykonano tuning, Kwota: %s$ (bank)", price), 'tuning')
		else
			TriggerClientEvent('esx_lscustom:cancelInstallMod', source)
			TriggerClientEvent('esx:showNotification', source, _U('not_enough_money'))
		end
	end
end)

RegisterServerEvent('esx_lscustom:refreshOwnedVehicle')
AddEventHandler('esx_lscustom:refreshOwnedVehicle', function(vehicleProps, netId)
    local src = tostring(source)
    local xPlayer = ESX.GetPlayerFromId(source)
    MySQL.single('SELECT vehProps FROM owned_vehicles WHERE plate = ?', {vehicleProps.plate}, function(result)
        if result and result.vehProps then
            local vehicle = json.decode(result.vehProps)

            if vehicle and vehicle.model and vehicleProps.model == vehicle.model then
                MySQL.update('UPDATE owned_vehicles SET vehProps = ? WHERE plate = ?', {json.encode(vehicleProps), vehicleProps.plate})

                if Customs[src] then
                    if Customs[src][tostring(vehicleProps.plate)] then
                        Customs[src][tostring(vehicleProps.plate)].props = vehicleProps
                    else
                        Customs[src][tostring(vehicleProps.plate)] = {props = vehicleProps, netId = netId}
                    end
                else
                    Customs[src] = {}
                    Customs[src][tostring(vehicleProps.plate)] = {props = vehicleProps, netId = netId}
                end

                local veh = NetworkGetEntityFromNetworkId(netId)
                if veh and DoesEntityExist(veh) then
                    local Veh_State = Entity(veh).state.VehicleProperties
                    if Veh_State then
                        Entity(veh).state:set("VehicleProperties", vehicleProps, true)
                    end
                end
            else
                exports['non']:ServerDebugPrint({
                    type = "warning",
                    message = ('Player ^5%s^7 attempted to upgrade with mismatching vehicle model'):format(xPlayer.source)
                })
            end
        end
    end)
end)

ESX.RegisterServerCallback('esx_lscustom:getVehiclesPrices', function(source, cb)
	if not Vehicles then
		Vehicles = MySQL.query.await('SELECT model, price FROM vehicles')
	end
	cb(Vehicles)
end)
