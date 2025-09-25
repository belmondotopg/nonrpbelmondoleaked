ESX.RegisterCommand('tp', 'admin', function(xPlayer, args, showError)
	xPlayer.setCoords({x = args.x, y = args.y, z = args.z})
end, false, {help = _U('command_setcoords'), validate = true, arguments = {
	{name = 'x', help = _U('command_setcoords_x'), type = 'number'},
	{name = 'y', help = _U('command_setcoords_y'), type = 'number'},
	{name = 'z', help = _U('command_setcoords_z'), type = 'number'}
}})

ESX.RegisterCommand('setjob', 'admin', function(xPlayer, args, showError)
	if ESX.DoesJobExist(args.job, args.grade) then
		args.playerId.setJob(args.job, args.grade)
		exports['non']:SendLog(xPlayer.source, string.format("Użyto komendy /setjob %s %s %s", args.playerId.source, args.job, args.grade), "job")
	else
		showError(_U('command_setjob_invalid'))
	end
end, true, {help = _U('command_setjob'), validate = true, arguments = {
	{name = 'playerId', help = _U('commandgeneric_playerid'), type = 'player'},
	{name = 'job', help = _U('command_setjob_job'), type = 'string'},
	{name = 'grade', help = _U('command_setjob_grade'), type = 'number'}
}})

function IsSpecialOrLimitedCar(car, specialCars, limitedCars, xPlayer)
    for _, specialCar in ipairs(specialCars) do
        if string.lower(car) == string.lower(specialCar) then
            return 'special'
        end
    end

    for _, limitedCar in ipairs(limitedCars) do
        if string.lower(car) == string.lower(limitedCar) then
            if xPlayer.getGroup() == 'owner' then
                return 'owner'
            else
                return 'limited'
            end
        end
    end

    return 'none'
end

local limitedCars = {
	"egzolambo",
}

local specialCars = {
	'rhino', 'akula', 'ruiner3', 'seasparrow2', 'seasparrow3', 'savage', 'phantom2', 'hunter', 'buzzard',
	'deathbike3', 'paragon2', 'comet4', 'buzzard2', 'dukes2', 'mule4', 'patrolboat', 'pounder2', 'dinghy5',
	'maverick', 'cablecar', 'jb700', 'trainmetro', 'seasparrow', 'tug', 'voltic2', 'volatus', 'submersible',
	'submersible2', 'swift', 'swift2', 'handler', 'frogger', 'freight', 'frogger2', 'havok', 'skylift',
	'annihilator', 'annihilator2', 'valkyrie', 'valkyrie2', 'hydra', 'apc', 'vigilante', 'cutter', 'lazer',
	'oppressor', 'mogul', 'barrage', 'khanjali', 'minitank', 'volatol', 'chernobog', 'alkonost', 'baller5',
	'baller6', 'avenger', 'stromberg', 'nightshark', 'besra', 'starling', 'kosatka', 'toreador', 'dump',
	'avisa', 'dune2', 'insurgent', 'cargobob', 'cargobob2', 'cargobob3', 'cargobob4', 'deluxo', 'caracara',
	'menacer', 'scramjet', 'oppressor2', 'revolter', 'viseris', 'savestra', 'thruster', 'trailersmall2',
	'ardent', 'dune3', 'tampa3', 'halftrack', 'nokota', 'strikeforce', 'bombushka', 'molotok', 'pyro',
	'ruiner2', 'limo2', 'technical', 'zhaba', 'technical2', 'technical3', 'jb700w', 'blazer5', 'insurgent3',
	'boxville5', 'bruiser', 'bruiser2', 'bruiser3', 'brutus', 'brutus2', 'brutus3', 'cerberus', 'cerberus2',
	'cerberus3', 'dominator4', 'dominator5', 'dominator6', 'impaler2', 'impaler3', 'impaler4', 'imperator',
	'imperator2', 'imperator3', 'issi4', 'issi5', 'issi6', 'monster3', 'monster4', 'monster5', 'scarab',
	'scarab2', 'scarab3', 'slamvan4', 'slamvan5', 'slamvan6', 'zr380', 'zr3802', 'zr3803', 'alphaz1', 'avenger2',
	'blimp', 'blimp2', 'blimp3', 'cargoplane', 'cuban800', 'dodo', 'duster', 'howard', 'jet', 'luxor', 'luxor2',
	'mammatus', 'microlight', 'miljet', 'nimbus', 'rogue', 'seabreeze', 'shamal', 'stunt', 'titan', 'tula',
	'velum', 'velum2', 'vestra', 'terabyte', 'deathbike2', 'freightcar', 'metrotrain', 'tanker2'
}

ESX.RegisterCommand('car', 'mod', function(xPlayer, args, showError)

	if not args.car then
        showError("Podany model pojazdu nie jest prawidłowy.")
        return
    end

	local GameBuild = tonumber(GetConvar("sv_enforceGameBuild", 1604))
	local carType = IsSpecialOrLimitedCar(args.car, specialCars, limitedCars, xPlayer)
	local playerPed = GetPlayerPed(xPlayer.source)
	local coords = xPlayer.getCoords(true)

	local upgrades = Config.MaxAdminVehicles and {
		plate = "nonrp",
		modEngine = 3,
		modBrakes = 2,
		modTransmission = 2,
		modSuspension = 3,
		modArmor = true,
		windowTint = 1,
	} or {}

	if GameBuild >= 2699 then
		if carType == 'special' then
			showError("Nie możesz zrespić pojazdu " .. args.car)
			exports['non']:SendLog(xPlayer.source, string.format('Próbował zrespić /car %s', args.car), 'car')
		elseif carType == 'limited' then
			showError("Nie możesz zrespić pojazdu limitowanego " .. args.car .. ", możesz go zakupić na naszym sklepie!")
			exports['non']:SendLog(xPlayer.source, string.format('Próbował zrespić /car %s', args.car), 'car')
		elseif carType == 'owner' then
			ESX.OneSync.SpawnVehicle(args.car, coords - vector3(0.0, 0.0, 0.9), GetEntityHeading(playerPed), upgrades, function(networkId)
				local vehicle = NetworkGetEntityFromNetworkId(networkId)
				Wait(250)
				TaskWarpPedIntoVehicle(playerPed, vehicle, -1)
			end)
			exports['non']:SendLog(xPlayer.source, string.format('Użyto komendy /car %s', args.car), 'car')
		else
			ESX.OneSync.SpawnVehicle(args.car, coords - vector3(0.0, 0.0, 0.9), GetEntityHeading(playerPed), upgrades, function(networkId)
				local vehicle = NetworkGetEntityFromNetworkId(networkId)
				Wait(250)
				TaskWarpPedIntoVehicle(playerPed, vehicle, -1)
			end)
			exports['non']:SendLog(xPlayer.source, string.format('Użyto komendy /car %s', args.car), 'car')
		end
	else
		showError("BŁĄD: " .. GameBuild)
	end
end, false, {help = _U('command_car'), validate = false, arguments = {
    {name = 'car', validate = false, help = _U('command_car_car'), type = 'string'}
}})

ESX.RegisterCommand({'dv'}, 'support', function(xPlayer, args, showError)
	local PedVehicle = GetVehiclePedIsIn(GetPlayerPed(xPlayer.source), false)
	if DoesEntityExist(PedVehicle) then
		DeleteEntity(PedVehicle)
	end
	local Vehicles = ESX.OneSync.GetVehiclesInArea(GetEntityCoords(GetPlayerPed(xPlayer.source)), tonumber(args.radius) or 5.0)
	for i=1, #Vehicles do 
		local Vehicle = NetworkGetEntityFromNetworkId(Vehicles[i])
		if DoesEntityExist(Vehicle) then
			DeleteEntity(Vehicle)
		end
	end
	if args.radius then
		exports['non']:SendLog(xPlayer.source, string.format('Użyto komendy /dv %s', args.radius), 'dv')
	else
		exports['non']:SendLog(xPlayer.source, 'Użyto komendy /dv', 'dv')
	end
end, false, {help = _U('command_cardel'), validate = false, arguments = {
	{name = 'radius',validate = false, help = _U('command_cardel_radius'), type = 'number'}
}})

if not Config.OxInventory then
	local itemInfo = {
		['non_ump45'] = 'UMP',
		['non_m270d'] = 'm270',
		['non_m16'] = 'm16',
		["non_m9"] = 'm9',
		["non_mxcvirtus"] = 'virtus',
		["non_xm7"] = 'm7',
		["non_sw"] = 'sw',
	}

	ESX.RegisterCommand('giveitem', 'wspolwlasciciel', function(xPlayer, args, showError)
		local logItem = itemInfo[args.item] or args.item

		if xPlayer then
			args.playerId.addInventoryItem(args.item, args.count)
			exports['non']:SendLog(xPlayer.source, string.format("Użyto komendy /giveitem %s %s %s", args.playerId.source, logItem, args.count), "giveitem")
		elseif args.playerId then
			args.playerId.addInventoryItem(args.item, args.count)
		else
			showError('cos nie trybi')
		end
	end, true, {
		help = _U('command_giveitem'),
		validate = true,
		arguments = {
			{name = 'playerId', help = _U('commandgeneric_playerid'), type = 'player'},
			{name = 'item', help = _U('command_giveitem_item'), type = 'item'},
			{name = 'count', help = _U('command_giveitem_count'), type = 'number'}
		}
	})

	--[[ESX.RegisterCommand('giveweapon', 'admin', function(xPlayer, args, showError)
		if args.playerId.hasWeapon(args.weapon) then
			showError(_U('command_giveweapon_hasalready'))
		else
			args.playerId.addWeapon(args.weapon, args.ammo)
		end
	end, true, {help = _U('command_giveweapon'), validate = true, arguments = {
		{name = 'playerId', help = _U('commandgeneric_playerid'), type = 'player'},
		{name = 'weapon', help = _U('command_giveweapon_weapon'), type = 'weapon'},
		{name = 'ammo', help = _U('command_giveweapon_ammo'), type = 'number'}
	}})

	ESX.RegisterCommand('giveweaponcomponent', 'admin', function(xPlayer, args, showError)
		if args.playerId.hasWeapon(args.weaponName) then
			local component = ESX.GetWeaponComponent(args.weaponName, args.componentName)

			if component then
				if args.playerId.hasWeaponComponent(args.weaponName, args.componentName) then
					showError(_U('command_giveweaponcomponent_hasalready'))
				else
					args.playerId.addWeaponComponent(args.weaponName, args.componentName)
				end
			else
				showError(_U('command_giveweaponcomponent_invalid'))
			end
		else
			showError(_U('command_giveweaponcomponent_missingweapon'))
		end
	end, true, {help = _U('command_giveweaponcomponent'), validate = true, arguments = {
		{name = 'playerId', help = _U('commandgeneric_playerid'), type = 'player'},
		{name = 'weaponName', help = _U('command_giveweapon_weapon'), type = 'weapon'},
		{name = 'componentName', help = _U('command_giveweaponcomponent_component'), type = 'string'}
	}})]]
end

ESX.RegisterCommand({'clear'}, 'user', function(xPlayer, args, showError)
	xPlayer.triggerEvent('chat:clear')
end, false, {help = _U('command_clear')})

ESX.RegisterCommand({'clearall', 'clsall'}, 'support', function(xPlayer, args, showError)
	TriggerClientEvent('chat:clear', -1)
end, true, {help = _U('command_clearall')})

ESX.RegisterCommand("refreshjobs", 'zarzad', function(xPlayer, args, showError)
	ESX.RefreshJobs()
end, true, {help = _U('command_clearall')})

if not Config.OxInventory then
	ESX.RegisterCommand('clearinventory', 'zarzad', function(xPlayer, args, showError)
		for k,v in ipairs(args.playerId.inventory) do
			if v.count > 0 then
				args.playerId.setInventoryItem(v.name, 0)
			end
		end
		TriggerEvent('esx:playerInventoryCleared',args.playerId)
	end, true, {help = _U('command_clearinventory'), validate = true, arguments = {
		{name = 'playerId', help = _U('commandgeneric_playerid'), type = 'player'}
	}})

	--[[ESX.RegisterCommand('clearloadout', 'admin', function(xPlayer, args, showError)
		for i=#args.playerId.loadout, 1, -1 do
			args.playerId.removeWeapon(args.playerId.loadout[i].name)
		end
		TriggerEvent('esx:playerLoadoutCleared',args.playerId)
	end, true, {help = _U('command_clearloadout'), validate = true, arguments = {
		{name = 'playerId', help = _U('commandgeneric_playerid'), type = 'player'}
	}})]]
end

function tableContains(table, element)
    for _, value in pairs(table) do
        if value == element then
            return true
        end
    end
    return false
end

local rangi = {
	'wlasciciel',
    'wspolwlasciciel',
    'glownyopiekun',
    'nadzorserwera',
    'opiekunadm',
    'zarzad',
    'management',
    'developer',
    'headadmin',
    'admin',
    'junioradm',
    'smod',
    'mod',
    'support',
    'trialsupport',
    'media',
    'vip',
    'user',
}

ESX.RegisterCommand('setgroup', 'opiekunadm', function(xPlayer, args, showError)
    if not args.playerId then args.playerId = xPlayer.source end

    if args.playerId and args.group then
        local isGroupValid = tableContains(rangi, args.group)

        if isGroupValid then
            args.playerId.setGroup(args.group)
			if source == 0 or source == nil then
				exports['non']:ServerDebugPrint({type = "info", message = "Nadales Permisje Dla: " .. args.playerId.source .. " ranga: " .. args.group .. ""})
			end
			if not source == 0 or not source == nil then
				exports['non']:SendLog(xPlayer.source, string.format("Użyto komendy /setgroup %s %s", args.playerId.source, args.group), "permisje")
			end
        else
            showError("Błąd: Nie można ustawić grupy " .. args.group .. " za pomocą tej komendy.")
        end
    else
        showError("Błąd: Nieprawidłowe argumenty komendy /setgroup")
    end
end, true, {
    help = _U('command_setgroup'),
    validate = true,
    arguments = {
        {name = 'playerId', help = _U('commandgeneric_playerid'), type = 'player'},
        {name = 'group', help = _U('command_setgroup_group'), type = 'string'},
    }
})

ESX.RegisterCommand('save', 'zarzad', function(xPlayer, args, showError)
	Core.SavePlayer(args.playerId)
	exports['non']:ServerDebugPrint({type = "info", message = "Saved Player!"})
end, true, {
	help = _U('command_save'),
	validate = true,
	arguments = {
		{name = 'playerId', help = _U('commandgeneric_playerid'), type = 'player'}
	}
})

ESX.RegisterCommand('saveall', 'zarzad', function(xPlayer, args, showError)
	Core.SavePlayers()
end, true, {help = _U('command_saveall')})

ESX.RegisterCommand('group', {"user", "admin"}, function(xPlayer, args, showError)
	exports['non']:ServerDebugPrint({type = "error", message = "(xPlayer.getName().. You are currently: ^5".. xPlayer.getGroup() .. "^0"})
end, true)

ESX.RegisterCommand('job', {"user", "admin"}, function(xPlayer, args, showError)
	exports['non']:ServerDebugPrint({type = "info", message = xPlayer.getName().. "You are currently: ^5".. xPlayer.getJob().name.. "^0 - ^5".. xPlayer.getJob().grade_name .. "^0"})
end, true)

ESX.RegisterCommand('info', {"user", "admin"}, function(xPlayer, args, showError)
	local job = xPlayer.getJob().name
	local jobgrade = xPlayer.getJob().grade_name
	exports['non']:ServerDebugPrint({type = "info", message = "Id: "..xPlayer.source..", Nick: "..xPlayer.getName()..", Ranga:"..xPlayer.getGroup()..", Job:".. job..""})
end, true)

ESX.RegisterCommand('coords', "developer", function(xPlayer, args, showError)
    local ped = GetPlayerPed(xPlayer.source)
	local coords = GetEntityCoords(ped, false)
	local heading = GetEntityHeading(ped)
	-- exports['non']:ServerDebugPrint({type = "error", message = "("Coords - Vector3: ^5".. vector3(coords.x,coords.y,coords.z).. "^0")
	-- exports['non']:ServerDebugPrint({type = "error", message = "("Coords - Vector4: ^5".. vector4(coords.x, coords.y, coords.z, heading) .. "^0")
end, true)

ESX.RegisterCommand('tpm', "mod", function(xPlayer, args, showError)
	xPlayer.triggerEvent("esx:tpm")
	exports['non']:SendLog(xPlayer.source, "Użyto komendy /tpm", 'tpm')
end, true)

ESX.RegisterCommand('goto', {'support', 'support'}, function(xPlayer, args, showError)
	local targetCoords = args.playerId.getCoords()
	xPlayer.setCoords(targetCoords)
	exports['non']:SendLog(xPlayer.source, string.format("Użyto komendy /goto %s", args.playerId.source), 'admin_commands')
end, true, {help = _U('command_goto'), validate = true, arguments = {
	{name = 'playerId', help = _U('commandgeneric_playerid'), type = 'player'}
}})

ESX.RegisterCommand('bring', {'support', 'support'}, function(xPlayer, args, showError)
	local playerCoords = xPlayer.getCoords()
	args.playerId.setCoords(playerCoords)
	exports['non']:SendLog(xPlayer.source, string.format("Użyto komendy /bring %s", args.playerId.source), 'admin_commands')
end, true, {help = _U('command_bring'), validate = true, arguments = {
	{name = 'playerId', help = _U('commandgeneric_playerid'), type = 'player'}
}})

ESX.RegisterCommand('kill', "mod", function(xPlayer, args, showError)
	args.playerId.triggerEvent("esx:killPlayer")
end, true, {help = _U('command_kill'), validate = true, arguments = {
	{name = 'playerId', help = _U('commandgeneric_playerid'), type = 'player'}
}})

ESX.RegisterCommand('freeze', {'mod', 'support'}, function(xPlayer, args, showError)
	args.playerId.triggerEvent('esx:freezePlayer', "freeze")
end, true, {help = _U('command_freeze'), validate = true, arguments = {
	{name = 'playerId', help = _U('commandgeneric_playerid'), type = 'player'}
}})

ESX.RegisterCommand('unfreeze', {'mod', 'support'}, function(xPlayer, args, showError)
	args.playerId.triggerEvent('esx:freezePlayer', "unfreeze")
end, true, {help = _U('command_unfreeze'), validate = true, arguments = {
	{name = 'playerId', help = _U('commandgeneric_playerid'), type = 'player'}
}})

-- ESX.RegisterCommand("noclip", 'mod', function(xPlayer, args, showError)
-- 	xPlayer.triggerEvent('esx:noclip')
-- end, false)

ESX.RegisterCommand('players', "admin", function(xPlayer, args, showError)
	local xPlayers = ESX.GetExtendedPlayers() -- Returns all xPlayers
	-- exports['non']:ServerDebugPrint({type = "error", message = "("^5"..#xPlayers.." ^2online player(s)^0")
	for i=1, #(xPlayers) do 
		local xPlayer = xPlayers[i]
		-- exports['non']:ServerDebugPrint({type = "error", message = "("^1[ ^2ID : ^5"..xPlayer.source.." ^0| ^2Name : ^5"..xPlayer.getName().." ^0 | ^2Group : ^5"..xPlayer.getGroup().." ^0 | ^2Identifier : ^5".. xPlayer.identifier .."^1]^0\n")
	end
end, true)

-- ESX.RegisterCommand('spawn', 'admin', function(xPlayer, args, showError)
-- 	args.playerId.setCoords({x = -260.04, y = -976.05, z = 31.22})
-- end, true, {help = "Teleportuj gracza na spawn", validate = true, arguments = {
--     {name = 'playerId', help = "ID gracza", type = 'player'}
-- }})