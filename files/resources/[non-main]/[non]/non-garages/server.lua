local PlayerVehicles, OrgVehicles, spawningVehicle = {}, {}, {}

local function setPlayerVehicles(identifier, row, state)
    if not identifier then return end
    if not PlayerVehicles[identifier] then
        PlayerVehicles[identifier] = {}
    end
    if state then
        row.state = state;
    end
    local vehProps = json.decode(row.vehProps);
    if not vehProps.engineHealth then
        vehProps.engineHealth = 100000.0;
    end
    if not vehProps.bodyHealth then
        vehProps.bodyHealth = 100000.0;
    end
    PlayerVehicles[identifier][row.plate] = {
        id = row.id,
        vehProps = vehProps,
        state = row.state,
        model = row.vehicleName,
        plate = row.plate,
        engine = vehProps.engineHealth,
        body = vehProps.bodyHealth,
    }
end


local function addPlayerVehicle(identifier, model, plate)
    local vehProps = json.encode({name = model, model = model, plate = plate, engineHealth = 1000.0, bodyHealth = 1000.0})

    MySQL.insert(
        'INSERT INTO owned_vehicles (identifier, plate, vehProps, state, vehicleName) VALUES (?, ?, ?, ?, ?)',
        {identifier, plate, vehProps, "in-garage", model},
        function(id)
            setPlayerVehicles(identifier, {
                id = id,
                vehProps = vehProps,
                plate = plate,
                state = "in-garage",
                vehicleName = model,
            })
        end
    )
end

-- Export funkcji do dodawania pojazdu
exports("addPlayerVehicle", addPlayerVehicle)

local function hasPlayerVehicle(identifier, plate)
    if not PlayerVehicles[identifier] then return false end
    if not PlayerVehicles[identifier][plate] then return false end
    return true
end

local function updateVehicleState(identifier, plate, state)
    PlayerVehicles[identifier][plate].state = state;
end

local function setOrgVehicles(identifier, job)
    if not OrgVehicles[job] then return end
    for k, v in pairs(OrgVehicles[job]) do
        if hasPlayerVehicle(v, k) then
            local veh = PlayerVehicles[v][k];
            setPlayerVehicles(identifier, PlayerVehicles[v][k], "in-org")
        end
    end
end

MySQL.ready(function()
    MySQL.query('SELECT * FROM `owned_vehicles`', {}, function(response)
        if response then
            for i = 1, #response, 1 do
                local row = response[i];
                setPlayerVehicles(row.identifier, row);
            end
        end
    end)
    MySQL.query('SELECT name, vehicles FROM `jobs`', {}, function(response)
        if response then
            for i = 1, #response, 1 do
                local row = response[i];
                OrgVehicles[row.name] = json.decode(row.vehicles);
            end
        end
    end)
end)

ESX.RegisterServerCallback("non-garages:getVehicles", function(source, cb)
    local xPlayer = ESX.GetPlayerFromId(source)
    if not PlayerVehicles[xPlayer.identifier] then return cb({}) end
    cb(PlayerVehicles[xPlayer.identifier] or {})
end)

RegisterServerEvent('non-garages:requestVehicleSpawn', function(plate)
    local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
    if not hasPlayerVehicle(xPlayer.identifier, plate) then return end
    local veh = PlayerVehicles[xPlayer.identifier][plate];
    if spawningVehicle[_source] then return end
    if not veh.state == "in-garage" then return end
    spawningVehicle[_source] = true;
    local coords = GetEntityCoords(GetPlayerPed(_source))
    local vehicle = CreateVehicle(veh.vehProps.model, coords.x, coords.y, coords.z, GetEntityHeading(GetPlayerPed(_source)), true, true)
    while not DoesEntityExist(vehicle) do Wait(10) end
    spawningVehicle[_source] = nil
    updateVehicleState(xPlayer.identifier, plate, "in-tow")
    TriggerClientEvent('non-garages:finishVehicleSpawn', _source, NetworkGetNetworkIdFromEntity(vehicle), veh.vehProps)
end)

ESX.RegisterServerCallback("non-garages:putVehicle", function(source, cb, plate, vehprops)
    local xPlayer = ESX.GetPlayerFromId(source)
    if not hasPlayerVehicle(xPlayer.identifier, plate) then return cb(false) end
    local affectedRows = MySQL.update.await('UPDATE `owned_vehicles` SET `vehProps` = ?, `state` = "in-garage" WHERE `id` = ?', {json.encode(vehprops), PlayerVehicles[xPlayer.identifier][plate].id})
    if affectedRows then
        PlayerVehicles[xPlayer.identifier][plate].vehProps = vehprops;
        PlayerVehicles[xPlayer.identifier][plate].engine = vehprops.engineHealth;
        PlayerVehicles[xPlayer.identifier][plate].body = vehprops.bodyHealth;
        PlayerVehicles[xPlayer.identifier][plate].state = "in-garage";
        cb(true)
    end
    cb(false)
end)

local towingSessions = {};

RegisterServerEvent("non-garages:requestTowVehicle", function(plate)
    local _source = source;
    local xPlayer = ESX.GetPlayerFromId(_source);
    if towingSessions[_source] then return xPlayer.showNotification("~r~Odczekaj chwilę!") end
    if not hasPlayerVehicle(xPlayer.identifier, plate) then return end
    towingSessions[_source] = { allow = true, numberplate = plate }
	for index,vehicle in ipairs(GetAllVehicles()) do
		if DoesEntityExist(vehicle) then
			if GetVehicleNumberPlateText(vehicle):gsub("%s+", "") == plate:gsub("%s+", "") then
				towingSessions[_source].entity = vehicle
				TriggerClientEvent('non-garages:canTow', -1, NetworkGetNetworkIdFromEntity(vehicle), _source)
				break
			end
		end
	end
    xPlayer.showNotification("~y~Trwa próba sprowadzenia pojazdu...")
    SetTimeout(500, function()
		if towingSessions[_source] then
			if towingSessions[_source].allow then
                xPlayer.showNotification("~g~Odholowano pojazd o rejestracji: "..plate)
                updateVehicleState(xPlayer.identifier, plate, "in-garage")
				if DoesEntityExist(towingSessions[_source].entity) then
					DeleteEntity(towingSessions[_source].entity)
				end	
			else
                xPlayer.showNotification("~r~Nie możesz odholować tego pojazdu!")
			end
			towingSessions[_source] = nil
		end
	end)
end)

RegisterServerEvent("non-garages:respondToTow", function(target)
	if towingSessions[target] then
		towingSessions[target].allow = false
	end
end)

RegisterServerEvent("esx:setJob", function(source, job, lastJob)
    local xPlayer = ESX.GetPlayerFromId(source);
    if job.name ~= lastJob.name then
        if OrgVehicles[lastJob.name] then
            for k, v in pairs(OrgVehicles[lastJob.name]) do
                if hasPlayerVehicle(xPlayer.identifier, k) then
                    PlayerVehicles[xPlayer.identifier][k] = nil;
                end
            end
        end
        setOrgVehicles(xPlayer.identifier, job.name);
    end
end)

RegisterServerEvent("esx:playerLoaded", function(source, xPlayer)
    local job = xPlayer.job.name;
    setOrgVehicles(xPlayer.identifier, job);
end)

RegisterServerEvent("non-garages:addOrgVehicle", function(plate)
    local _source = source;
    local xPlayer = ESX.GetPlayerFromId(_source);
    if not string.find(xPlayer.job.name, "org") then return end
    if not OrgVehicles[xPlayer.job.name] then
        OrgVehicles[xPlayer.job.name] = {};
    end
    OrgVehicles[xPlayer.job.name][plate] = xPlayer.identifier;
    PlayerVehicles[xPlayer.identifier][plate].type = "in-org";
    MySQL.update("UPDATE `jobs` SET `vehicles` = ? WHERE `name` = ?", {json.encode(OrgVehicles[xPlayer.job.name]), xPlayer.job.name}, function(affectedRows)
        if affectedRows then
            local xPlayers = ESX.GetExtendedPlayers("job", xPlayer.job.name);
            for i = 1, #xPlayers do 
                local xPlayer2 = xPlayers[i];
                setOrgVehicles(xPlayer2.identifier, xPlayer.job.name)
            end
        end
    end)
end)

RegisterServerEvent("non-garages:removeOrgVehicle", function(plate)
    local _source = source;
    local xPlayer = ESX.GetPlayerFromId(_source);
    if not string.find(xPlayer.job.name, "org") then return end
    if not hasPlayerVehicle(xPlayer.identifier, plate) then return end
    if not PlayerVehicles[xPlayer.identifier][plate].identifier == xPlayer.identifier then return end
    OrgVehicles[xPlayer.job.name][plate] = nil;
    PlayerVehicles[xPlayer.identifier][plate].type = "in-garage";
    local subowners = PlayerVehicles[xPlayer.identifier][plate].subowners;
    if subowners then
        for k, v in pairs(subowners) do
            PlayerVehicles[v.id][plate] = PlayerVehicles[xPlayer.identifier][plate]
        end
    end
    MySQL.update("UPDATE `jobs` SET `vehicles` = ? WHERE `name` = ?", {json.encode(OrgVehicles[xPlayer.job.name]), xPlayer.job.name}, function(affectedRows)
        if affectedRows then
            local xPlayers = ESX.GetExtendedPlayers("job", xPlayer.job.name);
            for i = 1, #xPlayers do 
                local xPlayer2 = xPlayers[i];
                setOrgVehicles(xPlayer2.identifier, xPlayer.job.name)
            end
        end
    end)
end)

CreateThread(function()
    SetTimeout(5000, function()
        local xPlayers = ESX.GetPlayers();
        for i = 1, #xPlayers do
            local xPlayer = ESX.GetPlayerFromId(xPlayers[i]);
            if not string.find(xPlayer.job.name, "org") then return end
            setOrgVehicles(xPlayer.identifier, xPlayer.job.name)
        end
    end)
end)