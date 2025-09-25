ServerDebugPrint = function(options, ...)
	if options.type == 'error' then
		print(('\27[41m^0^4NON^0RP\27[0m^0 [^1ERROR^7] ' .. options.message):format(...))
		return
	elseif options.type == 'warning' then
		print(('\27[43m^0^4NON^0RP\27[0m^0 [^3WARNING^7] ' .. options.message):format(...))
		return
	elseif options.type == 'info' then
		print(('\27[42m^0^4NON^0RP\27[0m^0 [^2INFO^7] ' .. options.message):format(...))
		return
	else
		print(('\27[44m^0^4NON^0RP\27[0m^0 [^4DEBUG^7] ' .. options.message):format(...))
	end
end

exports('ServerDebugPrint', ServerDebugPrint)

ESX.RegisterCommand("clearmap", 'mod', function(xPlayer, args, showError)
    local countCars, countObjects, countPeds = 0, 0, 0
    for index,vehicle in ipairs(GetAllVehicles()) do
        if DoesEntityExist(vehicle) and GetPedInVehicleSeat(vehicle, -1) == 0 and GetPedInVehicleSeat(vehicle, 0) == 0 and GetPedInVehicleSeat(vehicle, 1) == 0 and GetPedInVehicleSeat(vehicle, 2) == 0 then
            DeleteEntity(vehicle)
            countCars += 1
        end
    end
	for index, object in ipairs(GetAllObjects()) do
		if DoesEntityExist(object) then
			local objectModel = GetEntityModel(object)
			if objectModel == GetHashKey("ex_prop_adv_case_sm") then
				-- Ignoruj ten obiekt
			else
				DeleteEntity(object)
				countObjects = countObjects + 1
			end
		end
	end
    for index,ped in ipairs(GetAllPeds()) do
        if DoesEntityExist(ped) and not IsPedAPlayer(ped) then
            DeleteEntity(ped)
            countPeds += 1
        end
    end
    if xPlayer then
        -- xPlayer.showNotification('Wyczyszczono mapę z ('..countCars..' pojazdów, '..countObjects..' obiektów, '..countPeds..' pedów)')
		TriggerClientEvent('non:showNotification', -1, {
			type = 'success',
			duration = 5000,
			title = 'CZYSZCZENIE POJAZDÓW',
			text = 'Wyczyszczono mapę z ('..countCars..' pojazdów, '..countObjects..' obiektów, '..countPeds..' pedów)'
		})
		exports['non']:SendLog(xPlayer.source, 'Użył komendy /clearmap', 'admin_commands')
    else
		exports['non']:ServerDebugPrint({type = "info", message = "Wyczyszczono mapę z ("..countCars.." pojazdów, "..countObjects.." obiektów, "..countPeds.." pedów)"})
    end
end, true)

ESX.RegisterCommand("clearcars", 'mod', function(xPlayer, args, showError)
    local countCars = 0
    for index,vehicle in ipairs(GetAllVehicles()) do
        if DoesEntityExist(vehicle) and GetPedInVehicleSeat(vehicle, -1) == 0 and GetPedInVehicleSeat(vehicle, 0) == 0 and GetPedInVehicleSeat(vehicle, 1) == 0 and GetPedInVehicleSeat(vehicle, 2) == 0 then
            DeleteEntity(vehicle)
            countCars += 1
        end
    end
    if xPlayer then
        xPlayer.showNotification('Wyczyszczono mapę z ('..countCars..' pojazdów)')
		exports['non']:SendLog(xPlayer.source, 'Użył komendy /clearcars', 'admin_commands')
    else
		exports['non']:ServerDebugPrint({type = "info", message = "Wyczyszczono mapę z ("..countCars.." pojazdów"})
    end
end, true)


ESX.RegisterCommand("giveallitem", 'wlasciciel', function(xPlayer, args, showError)
	local xPlayers = ESX.GetExtendedPlayers()
	for i=1, #(xPlayers) do 
		local xPlayer = xPlayers[i]
		xPlayer.addInventoryItem(args.item, args.count)
	end
	exports['non']:SendLog(xPlayer.source, string.format('Użył komendy /giveallitem, item: %s, ilość: %s', args.item, args.count), 'admin_commands')
end, false, {help = 'Daj przedmiot dla wszystkich graczy', validate = true, arguments = {
	{name = 'item', help = 'Przedmiot', type = 'string'},
	{name = 'count', help = 'Ilość', type = 'number'}
}})

ESX.RegisterCommand('revivedist', 'admin', function(xPlayer, args, showError)
	local maxDist = 500
    if args.distance then
        if args.distance <= maxDist then
            local adminCoords = GetEntityCoords(GetPlayerPed(xPlayer.source))
            for k, v in pairs(GetPlayers()) do
                local playerCoords = GetEntityCoords(GetPlayerPed(v))
                local distance = #(adminCoords - playerCoords)
                if distance < args.distance then
                    TriggerClientEvent('esx_ambulancejob:revive', v)
                end
            end

			exports['non']:SendLog(xPlayer.source, string.format('Użyto komendy /revivedist %s', args.distance), 'revive')
        else
			xPlayer.showNotification('Maksymalna odległość wynosi: '..maxDist, 'error')
        end
	end
end, false, {help = 'Ożyw graczy w danym dystansie', validate = true, arguments = {
    {name = 'distance', help = 'Odległość', type = 'number'},
}})

ESX.RegisterCommand('heal', 'trialsupport', function(xPlayer, args, showError)
	if args.playerId then
		args.playerId.triggerEvent('non:onHealCommand')
		exports['non']:SendLog(xPlayer.source, string.format('Użyto komendy /heal %s', args.playerId.source), 'revive')
	else
		xPlayer.triggerEvent('non:onHealCommand')
		exports['non']:SendLog(xPlayer.source, 'Użyto komendy /heal', 'revive')
	end
end, false, {help = 'Ulecz gracza lub siebie', validate = false, arguments = {
    {name = 'playerId', validate = false, help = 'ID gracza', type = 'player'},
}})

ESX.RegisterCommand('vanish', 'admin', function(xPlayer, args, showError)
	xPlayer.triggerEvent('non:onVanishCommand')
	exports['non']:SendLog(xPlayer.source, 'Użyto komendy /vanish', 'admin_commands')
end, false)

ESX.RegisterCommand('kick', 'admin', function(xPlayer, args, showError)
	DropPlayer(args.playerId.source, xPlayer.name..' wyrzucił Cię z serwera! Powód: '..args.reason)
	exports['non']:SendLog(xPlayer.source, string.format('Użyto komendy /kick %s %s', args.playerId.source, args.reason), 'admin_commands')
end, false, {help = 'Wyrzuć gracza', validate = true, arguments = {
    {name = 'playerId', help = 'ID gracza', type = 'player'},
	{name = 'reason', help = 'Powód -> użyj cudzysłowia', type = 'string'},
}})

local addCarResponse = {}

ESX.RegisterCommand('addcar', {'wlasciciel'}, function(xPlayer, args, showError)
	args.playerId.triggerEvent('non:onAddcarCommand', args.car, xPlayer.source)
	addCarResponse[args.playerId.source] = true
	exports['non']:SendLog(xPlayer.source, string.format('Użyto komendy /addcar %s %s', args.playerId.source, args.car), 'admin_commands')
end, true, {help = 'Nadaj pojazd dla gracza', validate = true, arguments = {
    {name = 'playerId', help = 'ID gracza', type = 'player'},
	{name = 'car', help = 'Nazwa modelu', type = 'string'},
}})

RegisterServerEvent('non:addCarResponse')
AddEventHandler('non:addCarResponse', function(plate, model, sender)
	local xPlayer = ESX.GetPlayerFromId(source)
	if addCarResponse[xPlayer.source] then
		local xTarget = ESX.GetPlayerFromId(sender)
		exports['non-garages']:addPlayerVehicle(xPlayer.identifier, model, plate)
		xTarget.showNotification('Nadano pojazd z rejestracja '..plate..' dla '..xPlayer.discord.name..' ('..xPlayer.source..')', 'success')
		xPlayer.showNotification('Otrzymano pojazd z rejestracja '..plate, 'success')
		addCarResponse[xPlayer.source] = nil
	else
		exports["non-afk"]:fg_BanPlayer(src, "non:addCarResponse", true)
	end
end)

local chujcieto = {}

ESX.RegisterCommand('chujcieto', {'wlasciciel'}, function(xPlayer, args, showError)
    args.playerId.triggerEvent('non:chujcieto2', args.car, args.rejka, xPlayer.source)
    chujcieto[args.playerId.source] = true
	exports['non']:SendLog(xPlayer.source, string.format('Użyto komendy /chujcieto (addcar2) %s %s', args.playerId.source, args.car), 'admin_commands')
end, true, {help = 'Nadaj pojazd dla gracza', validate = true, arguments = {
    {name = 'playerId', help = 'ID gracza', type = 'player'},
    {name = 'car', help = 'Nazwa modelu', type = 'string'},
    {name = 'rejka', help = 'Nazwa rejestracji', type = 'string'},
}})

RegisterServerEvent('non:chujcieto')
AddEventHandler('non:chujcieto', function(plate, model, sender)
    local xPlayer = ESX.GetPlayerFromId(source)
    local is = chujcieto[xPlayer.source]

    if is then
        MySQL.Async.fetchScalar('SELECT COUNT(*) FROM owned_vehicles WHERE plate = @plate', {
            ['@plate'] = plate
        }, function(result)
            if result == 0 then
                local xTarget = ESX.GetPlayerFromId(sender)
				MySQL.insert('INSERT INTO owned_vehicles (identifier, owner, plate, vehicle) VALUES (?, ?, ?, ?)', {xPlayer.identifier, xPlayer.discord.name, plate, json.encode({name = model, model = model, plate = plate})}, function(id)
					exports['non-ui']:addPlayerVehicle(xPlayer.identifier, {
						id = id,
						model = model,
						type = "home",
						image = model,
						owner = xPlayer.discord.name,
						plate = plate,
						state = 1,
						subowners = json.encode({}),
						subownersSlots = 3,
						engineValue = 1000.0,
						bodyValue = 1000.0,
						vehicle = json.encode({name = model, model = model, plate = plate}),
					})
                    xTarget.showNotification('Nadano pojazd z rejestracją ' .. plate .. ' dla ' .. xPlayer.name .. ' (' .. xPlayer.source .. ')', 'success')
                    xPlayer.showNotification('Otrzymano pojazd z rejestracją ' .. plate, 'success')
				end)
            else
                xPlayer.showNotification('Ta rejestracja już istnieje w bazie danych.', 'error')
            end
        end)

        is = nil
    else
        exports["non-afk"]:fg_BanPlayer(xPlayer.source, "non:chujcieto", true)
    end
end)

ESX.RegisterCommand('removecar', {'wlasciciel'}, function(xPlayer, args, showError)
	local plate = args.plate:gsub("%-", " ")
	local deletedResults = 0
	MySQL.query('SELECT plate FROM owned_vehicles WHERE plate = ?', {plate}, function(data)
        if data then
			for k, v in pairs(data) do
				deletedResults = deletedResults + 1
				MySQL.update('DELETE FROM owned_vehicles WHERE plate = ?', {v.plate})
			end
			if xPlayer then
				xPlayer.showNotification('Usunięto: '..deletedResults..' rekordów ('..plate..')', 'success')
				exports['non']:SendLog(xPlayer.source, string.format('Użyto komendy /removecar %s', plate), 'admin_commands')
			else
				exports['non']:ServerDebugPrint({type = "warning", message = 'Usunięto: '..deletedResults..' rekordów ('..plate..')'})
			end
        end
	end)
end, true, {help = 'Usuń pojazd z bazy danych', validate = true, arguments = {
	{name = 'plate', help = 'Rejestracja (spacje zastąp "-")', type = 'string'},
}})

ESX.RegisterCommand('spawn', 'mod', function(xPlayer, args, showError)
    if args.targetid then
        local xPlayerTarget = ESX.GetPlayerFromId(args.targetid)
        if xPlayerTarget then
			xPlayerTarget.setCoords({x = 2052.6382, y = 3182.6848, z = 45.2456})
			if xPlayer then
				xPlayerTarget.showNotification('Zostałeś przeteleportowany na spawn przez administratora ' .. GetPlayerName(xPlayer.source) .. '!')
				exports['non']:SendLog(xPlayer.source, string.format('Użyto komendy /spawn2 na graczu: %s', args.targetid), 'spawn')
			end
        end
    end
end, true, {help = "Teleportuj gracza na spawn", validate = true, arguments = {
    {name = 'targetid', help = "ID gracza", type = 'number'}
}})

ESX.RegisterCommand('jobinfo', 'admin', function(xPlayer, args, showError)
    MySQL.query('SELECT job, job_grade FROM users WHERE identifier = @identifier', {
		['@identifier'] = args.license
	}, function(data)
		if data and data[1] then
            if xPlayer then
                xPlayer.showNotification(args.license..' | job: '..data[1].job..' | grade: '..data[1].job_grade, 'info')
            else
                print(args.license..' | job: '..data[1].job..' | grade: '..data[1].job_grade)
            end
        else
            if xPlayer then
                xPlayer.showNotification('Nie znaleziono gracza z taką licencją', 'error')
            else
                print('Nie znaleziono gracza z taką licencją')
            end
		end
	end)
end, true, {help = 'Sprawdź nazwę joba po licencji', validate = true, arguments = {
	{name = 'license', help = 'Licencja (z char:)', type = 'string'}
}})

ESX.RegisterServerCallback('non:requestPlayerStatus', function(source, cb)
	local xPlayer = ESX.GetPlayerFromId(source)

	if xPlayer then
		MySQL.query('SELECT status FROM users WHERE identifier = @identifier', {
			['@identifier'] = xPlayer.identifier
		}, function(data)
			if data and data[1] then
				cb(json.decode(data[1].status))
			end
		end)
	-- else
		-- print("brak xPlayer cwelu")
	end
end)

-- GetSpecificIdentifier = function(playerId, identifier)
-- 	local identifiers = GetPlayerIdentifiers(playerId)
-- 	for i=1, #identifiers do
-- 		if identifiers[i]:match(identifier) then
-- 			return identifiers[i]
-- 		end
-- 	end
-- 	return "Nie wykryto identyfikatora: "..identifier
-- end

local WhiteListedEntities = {
    ["ex_prop_adv_case_sm"] = true,
}
local wlModel = {
	[`metrotrain`] = true,
	[`tankercar`] = true,
	[`freightgrain`] = true,
	[`freightcont2`] = true,
	[`freightcont1`] = true,
	[`freightcar`] = true,
	[`freight`] = true,
	[`titan`] = true
}

local function clearCars()
	CreateThread(function()
		TriggerClientEvent('non:showNotification', -1, {
			type = 'info',
			duration = 5000,
			title = 'CZYSZCZENIE POJAZDÓW',
			text = 'Puste pojazdy zostaną usunięte za minutę'
		})
		Wait(50000)
		TriggerClientEvent('non:showNotification', -1, {
			type = 'info',
			duration = 10000,
			title = 'CZYSZCZENIE POJAZDÓW',
			text = 'Puste pojazdy zostaną usunięte za 10 sekund'
		})
		Wait(10000)
		for index, vehicle in ipairs(GetAllVehicles()) do
			if DoesEntityExist(vehicle) and GetPedInVehicleSeat(vehicle, -1) == 0 and GetPedInVehicleSeat(vehicle, 0) == 0 and GetPedInVehicleSeat(vehicle, 1) == 0 and GetPedInVehicleSeat(vehicle, 2) == 0 and not WhiteListedEntities[vehicle] and not wlModel[GetEntityModel(vehicle)] then
				DeleteEntity(vehicle)
			end
		end
		-- for index, object in ipairs(GetAllObjects()) do
		-- 	if DoesEntityExist(object) and not WhiteListedEntities[object] then
		-- 		DeleteEntity(object)
		-- 	end
		-- end
		TriggerClientEvent('non:showNotification', -1, {
			type = 'success',
			duration = 5000,
			title = 'CZYSZCZENIE POJAZDÓW',
			text = 'Pomyślnie wyczyszczono puste pojazdy'
		})
	end)
end

CreateThread(function()
	while true do
		local m = os.date('%M')
		if (m % 30 == 0) then
			clearCars()
		end
		Wait(60000)
	end
end)

ESX.RegisterServerCallback('non:requestCarSpawn', function(source, cb, model, coords, heading)
	local vehicle = CreateVehicle(model, coords, heading, true, true)

    while not DoesEntityExist(vehicle) do
        Wait(50)
    end

	while GetVehiclePedIsIn(GetPlayerPed(source), false) ~= vehicle do
        SetPedIntoVehicle(GetPlayerPed(source), vehicle, -1)
		Wait(100)
    end

	cb(NetworkGetNetworkIdFromEntity(vehicle))
end)

AddEventHandler('weaponDamageEvent', function(source, data)
	if data.weaponType == 911657153 then
		local xPlayer = ESX.GetPlayerFromId(source)
		if xPlayer and xPlayer.job.name ~= 'police' and xPlayer.job.name ~= 'offpolice' then
			local item = xPlayer.getInventoryItem('stungun')
			if item and item.count > 0 then
				xPlayer.removeInventoryItem('stungun', item.count)
				CancelEvent()
			end
		end
	end
end)

RegisterNetEvent('esx:onPlayerDeath')
AddEventHandler('esx:onPlayerDeath', function(data)
    local xPlayer = ESX.GetPlayerFromId(source)

    local WeaponNames = {
		[`WEAPON_UNARMED`] = 'bez broni',

		-- ADDON
		[`WEAPON_UMP45`] = 'Karabinek UMP45',

		-- WEAPON
		[`WEAPON_KNIFE`] = 'noz',
		[`WEAPON_NIGHTSTICK`] = 'palka policyjna',
		[`WEAPON_HAMMER`] = 'mlotek',
		[`WEAPON_BAT`] = 'kij do baseballa',
		[`WEAPON_GOLFCLUB`] = 'kij golfowy',
		[`WEAPON_CROWBAR`] = 'lom',
		[`WEAPON_PISTOL`] = 'pistolet',
		[`WEAPON_PISTOL_MK2`] = 'pistolet mk2',
		[`WEAPON_COMBATPISTOL`] = 'pistolet bojowy',
		[`WEAPON_APPISTOL`] = 'Pistolet przeciwpancerny',
		[`WEAPON_PISTOL50`] = 'Pistolet .50',
		[`WEAPON_MICROSMG`] = 'Micro SMG',
		[`WEAPON_SMG`] = 'SMG',
		[`WEAPON_ASSAULTSMG`] = 'Szturmowe SMG',
		[`WEAPON_ASSAULTRIFLE`] = 'AK-47',
		[`WEAPON_CARBINERIFLE`] = 'm4',
		[`WEAPON_ADVANCEDRIFLE`] = 'Zaawansowany karabin',
		[`WEAPON_MG`] = 'Karabin maszynowy',
		[`WEAPON_COMBATMG`] = 'Bojowy karabin maszynowy',
		[`WEAPON_PUMPSHOTGUN`] = 'strzelba pompowa',
		[`WEAPON_SAWNOFFSHOTGUN`] = 'obrzym',
		[`WEAPON_ASSAULTSHOTGUN`] = 'strzelba szturmowa',
		[`WEAPON_BULLPUPSHOTGUN`] = 'Strzelba bezkolbowa',
		[`WEAPON_STUNGUN`] = 'Paralizator',
		[`WEAPON_SNIPERRIFLE`] = 'Karabin Snajperski',
		[`WEAPON_HEAVYSNIPER`] = 'Ciężki karabin snajperski',
		[`WEAPON_REMOTESNIPER`] = 'Remote Sniper',
		[`WEAPON_GRENADELAUNCHER`] = 'Granatnik',
		[`WEAPON_GRENADELAUNCHER_SMOKE`] = 'Granatnik',
		[`WEAPON_RPG`] = 'RPG',
		[`WEAPON_PASSENGER_ROCKET`] = 'Passenger Rocket',
		[`WEAPON_AIRSTRIKE_ROCKET`] = 'Nalot rakietowy',
		[`WEAPON_STINGER`] = 'Stinger [Vehicle]',
		[`WEAPON_MINIGUN`] = 'Minigun',
		[`WEAPON_GRENADE`] = 'Granat',
		[`WEAPON_STICKYBOMB`] = 'Bomba przylepna',
		[`WEAPON_SMOKEGRENADE`] = 'Gaz lzawiacy',
		[`WEAPON_BZGAS`] = 'Gaz bojowy',
		[`WEAPON_MOLOTOV`] = 'Molotov',
		[`WEAPON_FIREEXTINGUISHER`] = 'Gasnica',
		[`WEAPON_PETROLCAN`] = 'Jerry Can',
		[`OBJECT`] = 'Obiekt',
		[`WEAPON_BALL`] = 'Pilka',
		[`WEAPON_FLARE`] = 'Flara',
		[`VEHICLE_WEAPON_TANK`] = 'Czolg',
		[`VEHICLE_WEAPON_SPACE_ROCKET`] = 'Rakieta Kosmiczna',
		[`VEHICLE_WEAPON_PLAYER_LASER`] = 'Laser',
		[`AMMO_RPG`] = 'Rakieta',
		[`AMMO_TANK`] = 'Czolg',
		[`AMMO_SPACE_ROCKET`] = 'Rakieta Kosmiczna',
		[`AMMO_PLAYER_LASER`] = 'Laser',
		[`AMMO_ENEMY_LASER`] = 'Laser',
		[`WEAPON_RAMMED_BY_CAR`] = 'Staranowany przez samochód',
		[`WEAPON_BOTTLE`] = 'Butelka',
		[`WEAPON_GUSENBERG`] = 'Gusenberg',
		[`WEAPON_SNSPISTOL`] = 'Pukawka',
		[`WEAPON_SNSPISTOL_MK2`] = 'Pukawka MK2',
		[`WEAPON_CERAMICPISTOL`] = 'Pistolet Ceramiczny',
		[`WEAPON_VINTAGEPISTOL`] = 'Pistolet Vintage',
		[`WEAPON_DAGGER`] = 'Zabytkowy sztylet',
		[`WEAPON_FLAREGUN`] = 'Pistolet sygnałowy',
		[`WEAPON_HEAVYPISTOL`] = 'Ciezki pistolet',
		[`WEAPON_SPECIALCARBINE`] = 'Karabinek specjalnyk',
		[`WEAPON_MUSKET`] = 'Muszkiet',
		[`WEAPON_FIREWORK`] = 'Wyrzutnia fajerwerkow',
		[`WEAPON_MARKSMANRIFLE`] = 'Karabin wyborowy',
		[`WEAPON_HEAVYSHOTGUN`] = 'Ciezka strzelba',
		[`WEAPON_PROXMINE`] = 'Mina zbliżeniowa',
		[`WEAPON_HOMINGLAUNCHER`] = 'Wyrzutnia namierzająca',
		[`WEAPON_HATCHET`] = 'Topor',
		[`WEAPON_COMBATPDW`] = 'PDW',
		[`WEAPON_KNUCKLE`] = 'Kastety',
		[`WEAPON_MARKSMANPISTOL`] = 'Pistolet wyborowy',
		[`WEAPON_MACHETE`] = 'Maczeta',
		[`WEAPON_MACHINEPISTOL`] = 'Pistolet maszynowy',
		[`WEAPON_FLASHLIGHT`] = 'Latarka',
		[`WEAPON_DBSHOTGUN`] = 'Dwururka',
		[`WEAPON_COMPACTRIFLE`] = 'Karabin kompaktowy',
		[`WEAPON_SWITCHBLADE`] = 'Noz sprezynowy',
		[`WEAPON_REVOLVER`] = 'Ciężki rewolwer',
		[`WEAPON_FIRE`] = 'Ogien',
		[`WEAPON_HELI_CRASH`] = 'Helikopter',
		[`WEAPON_RUN_OVER_BY_CAR`] = 'Przejechany przez samochod',
		[`WEAPON_HIT_BY_WATER_CANNON`] = 'Trafiony armatka wodna',
		[`WEAPON_EXHAUSTION`] = 'wyczerpanie',
		[`WEAPON_EXPLOSION`] = 'wybuch',
		[`WEAPON_ELECTRIC_FENCE`] = 'Elektryczne ogrodzenie',
		[`WEAPON_BLEEDING`] = 'wykrwawienie',
		[`WEAPON_DROWNING_IN_VEHICLE`] = 'Utoniecie w pojezdzie',
		[`WEAPON_DROWNING`] = 'Utoniecie',
		[`WEAPON_BARBED_WIRE`] = 'Drut kolczasty',
		[`WEAPON_VEHICLE_ROCKET`] = 'Rakieta z samochodu',
		[`WEAPON_BULLPUPRIFLE`] = 'Karabin bezkolbowy',
		[`WEAPON_ASSAULTSNIPER`] = 'Assault Sniper',
		[`VEHICLE_WEAPON_ROTORS`] = 'Rotors',
		[`WEAPON_RAILGUN`] = 'Railgun',
		[`WEAPON_AIR_DEFENCE_GUN`] = 'Air Defence Gun',
		[`WEAPON_AUTOSHOTGUN`] = 'Strzelba automatyczna',
		[`WEAPON_BATTLEAXE`] = 'topor',
		[`WEAPON_COMPACTLAUNCHER`] = 'Granatnik kompaktowy',
		[`WEAPON_MINISMG`] = 'Mini SMG',
		[`WEAPON_PIPEBOMB`] = 'Rurobomba',
		[`WEAPON_POOLCUE`] = 'Kij bilardowy',
		[`WEAPON_WRENCH`] = 'Klucz francuski',
		[`WEAPON_SNOWBALL`] = 'Sniezka',
		[`WEAPON_ANIMAL`] = 'Zwierze',
		[`WEAPON_COUGAR`] = 'Puma'
	}

    local Weapon = (WeaponNames[data.deathCause] or 'Nieznany powód')

	if not xPlayer then return end
    if data.killedByPlayer then
		local xTarget = ESX.GetPlayerFromId(data.killerServerId)
		exports['non']:SendLog(source, 'Gracz (' .. xPlayer.source .. ') ' .. xPlayer.name .. ' umarł. \nZostał zabity przez: (' .. xTarget.source .. ') ' .. xTarget.name .. '\nDystans: ' .. data.distance .. 'm\nBroń: ' .. Weapon, 'death')
		if data.distance > 107 then
			exports['non']:SendLog(source, 'Gracz (' .. xPlayer.source .. ') ' .. xPlayer.name .. ' umarł. \nZostał zabity przez: (' .. xTarget.source .. ') ' .. xTarget.name .. '\nDystans: ' .. data.distance .. 'm\nBroń: ' .. Weapon, 'death')
		end
    else
		exports['non']:SendLog(source, 'Gracz (' .. xPlayer.source .. ') ' .. xPlayer.name .. ' umarł.\nPowód śmierci - ' .. Weapon, 'death')
    end
end)