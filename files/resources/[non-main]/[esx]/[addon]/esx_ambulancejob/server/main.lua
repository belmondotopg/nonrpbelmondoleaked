local playersHealing, deadPlayers = {}, {}

if GetResourceState("esx_phone") ~= 'missing' then
TriggerEvent('esx_phone:registerNumber', 'ambulance', _U('alert_ambulance'), true, true)
end

if GetResourceState("esx_society") ~= 'missing' then
TriggerEvent('esx_society:registerSociety', 'ambulance', 'Ambulance', 'society_ambulance', 'society_ambulance', 'society_ambulance', {type = 'public'})
end

RegisterNetEvent('esx_ambulancejob:revive')
AddEventHandler('esx_ambulancejob:revive', function(playerId)
	playerId = tonumber(playerId)
	local xPlayer = source and ESX.GetPlayerFromId(source)

	if xPlayer and xPlayer.job.name == 'ambulance' then
		local xTarget = ESX.GetPlayerFromId(playerId)
		if xTarget then
			if deadPlayers[playerId] then
				if Config.ReviveReward > 0 then
					xPlayer.showNotification(_U('revive_complete_award', xTarget.name, Config.ReviveReward))
					xPlayer.addMoney(Config.ReviveReward, "Revive Reward")
					xTarget.triggerEvent('esx_ambulancejob:revive')
				else
					xPlayer.showNotification(_U('revive_complete', xTarget.name))
					local coords = xTarget.getCoords(true)
					xTarget.triggerEvent('esx_ambulancejob:revive', coords)
				end
				local Ambulance = ESX.GetExtendedPlayers("job", "ambulance")

				for _, xPlayer in pairs(Ambulance) do
					if xPlayer.job.name == 'ambulance' then
						xPlayer.triggerEvent('esx_ambulancejob:PlayerNotDead', playerId)
					end
				end
				deadPlayers[playerId] = nil
			else
				xPlayer.showNotification(_U('player_not_unconscious'))
			end
		else
			xPlayer.showNotification(_U('revive_fail_offline'))
		end
	end
end)

AddEventHandler('txAdmin:events:healedPlayer', function(eventData)
	if GetInvokingResource() ~= "monitor" or type(eventData) ~= "table" or type(eventData.id) ~= "number" then
		return
	end
	if deadPlayers[eventData.id] then
		TriggerClientEvent('esx_ambulancejob:revive', eventData.id)
		local Ambulance = ESX.GetExtendedPlayers("job", "ambulance")

		for _, xPlayer in pairs(Ambulance) do
			if xPlayer.job.name == 'ambulance' then
				xPlayer.triggerEvent('esx_ambulancejob:PlayerNotDead', eventData.id)
			end
		end
		deadPlayers[eventData.id] = nil
	end
end)

RegisterNetEvent('esx:onPlayerDeath')
AddEventHandler('esx:onPlayerDeath', function(data)
	local source = source
	deadPlayers[source] = 'dead'
	local Ambulance = ESX.GetExtendedPlayers("job", "ambulance")

	for _, xPlayer in pairs(Ambulance) do
			xPlayer.triggerEvent('esx_ambulancejob:PlayerDead', source)
	end
end)

RegisterServerEvent('esx_ambulancejob:svsearch')
AddEventHandler('esx_ambulancejob:svsearch', function()
  TriggerClientEvent('esx_ambulancejob:clsearch', -1, source)
end)

RegisterNetEvent('esx_ambulancejob:onPlayerDistress')
AddEventHandler('esx_ambulancejob:onPlayerDistress', function()
	local source = source
	if deadPlayers[source] then
		deadPlayers[source] = 'distress'
		local Ambulance = ESX.GetExtendedPlayers("job", "ambulance")

		for _, xPlayer in pairs(Ambulance) do
			TriggerClientEvent('esx_ambulancejob:PlayerDistressed', xPlayer.source, source)
		end
	end
end)

RegisterNetEvent('esx:onPlayerSpawn')
AddEventHandler('esx:onPlayerSpawn', function()
	local source = source
	if deadPlayers[source] then
		deadPlayers[source] = nil
		local Ambulance = ESX.GetExtendedPlayers("job", "ambulance")

		for _, xPlayer in pairs(Ambulance) do
				xPlayer.triggerEvent('esx_ambulancejob:PlayerNotDead', source)
		end
	end
end)

AddEventHandler('esx:playerDropped', function(playerId, reason)
	if deadPlayers[playerId] then
		deadPlayers[playerId] = nil
		local Ambulance = ESX.GetExtendedPlayers("job", "ambulance")

		for _, xPlayer in pairs(Ambulance) do
			if xPlayer.job.name == 'ambulance' then
				xPlayer.triggerEvent('esx_ambulancejob:PlayerNotDead', playerId)
			end
		end
	end
end)

RegisterNetEvent('esx_ambulancejob:heal')
AddEventHandler('esx_ambulancejob:heal', function(target, type)
	local xPlayer = ESX.GetPlayerFromId(source)

	if xPlayer.job.name == 'ambulance' then
		TriggerClientEvent('esx_ambulancejob:heal', target, type)
	end
end)

RegisterNetEvent('esx_ambulancejob:putInVehicle')
AddEventHandler('esx_ambulancejob:putInVehicle', function(target)
	local xPlayer = ESX.GetPlayerFromId(source)

	if xPlayer.job.name == 'ambulance' then
		TriggerClientEvent('esx_ambulancejob:putInVehicle', target)
	end
end)

ESX.RegisterServerCallback('esx_ambulancejob:removeItemsAfterRPDeath', function(source, cb)
	print(source, "KOLEGA SE TRIGGERUJE XD?")
	-- exports["non-afk"]:fg_BanPlayer(source, "SIEMA SIEMA WRACAJ TAM SKAD PRZYSZEDLES BAJO !", true)
end)

if Config.EarlyRespawnFine then
	ESX.RegisterServerCallback('esx_ambulancejob:checkBalance', function(source, cb)
		local xPlayer = ESX.GetPlayerFromId(source)
		local bankBalance = xPlayer.getAccount('bank').money

		cb(bankBalance >= Config.EarlyRespawnFineAmount)
	end)

	RegisterNetEvent('esx_ambulancejob:payFine')
	AddEventHandler('esx_ambulancejob:payFine', function()
		local xPlayer = ESX.GetPlayerFromId(source)
		local fineAmount = Config.EarlyRespawnFineAmount

		xPlayer.showNotification(_U('respawn_bleedout_fine_msg', ESX.Math.GroupDigits(fineAmount)))
		xPlayer.removeAccountMoney('bank', fineAmount, "Respawn Fine")
	end)
end

ESX.RegisterServerCallback('esx_ambulancejob:getItemAmount', function(source, cb, item)
	local xPlayer = ESX.GetPlayerFromId(source)
	local quantity = xPlayer.getInventoryItem(item).count

	cb(quantity)
end)

function getPriceFromHash(vehicleHash, jobGrade, type)
	local vehicles = Config.AuthorizedVehicles[type][jobGrade]

	for i = 1, #vehicles do
		local vehicle = vehicles[i]
		if joaat(vehicle.model) == vehicleHash then
			return vehicle.price
		end
	end

	return 0
end

RegisterNetEvent('esx_ambulancejob:removeItem')
AddEventHandler('esx_ambulancejob:removeItem', function(item)
	local xPlayer = ESX.GetPlayerFromId(source)
	xPlayer.removeInventoryItem(item, 1)

	if item == 'bandage' then
		xPlayer.showNotification(_U('used_bandage'))
	elseif item == 'medikit' then
		xPlayer.showNotification(_U('used_medikit'))
	end
end)

RegisterNetEvent('esx_ambulancejob:giveItem')
AddEventHandler('esx_ambulancejob:giveItem', function(itemName, amount)
	local xPlayer = ESX.GetPlayerFromId(source)

	if xPlayer.job.name ~= 'ambulance' then
		print(('[esx_ambulancejob] [^2WARNING^7] "%s" attempted to spawn in an item!'):format(xPlayer.identifier))
		return
	elseif (itemName ~= 'medikit' and itemName ~= 'bandage') then
		print(('[esx_ambulancejob] [^2WARNING^7] "%s" attempted to spawn in an item!'):format(xPlayer.identifier))
		return
	end

	if xPlayer.canCarryItem(itemName, amount) then
		xPlayer.addInventoryItem(itemName, amount)
	else
		xPlayer.showNotification(_U('max_item'))
	end
end)

local lastReviveUsage = {}

ESX.RegisterCommand('revive', 'revivator', function(xPlayer, args, showError)
    local src = xPlayer.source
    local currentTime = os.time()
    local cooldown = 5

	-- if Player(src).state.inBattle or (args.playerId.source and Player(args.playerId.source).state.inBattle) then
	-- 	return xPlayer.showNotification("Nie mozesz uzywac revive podczas bitki.")
	-- end

    if lastReviveUsage[src] then
        local timeSinceLastUse = currentTime - lastReviveUsage[src]
        
        if timeSinceLastUse < cooldown then
            local timeLeft = cooldown - timeSinceLastUse
            xPlayer.showNotification("Musisz odczekać ~r~" .. timeLeft .. "s~w~, zanim ponownie użyjesz ~y~/revive~w~!")
            return
        end
    end

    lastReviveUsage[src] = currentTime

    if xPlayer.getGroup() == 'revivator' then
        if args.playerId then
            xPlayer.showNotification("~r~Nie możesz używać /revive na innych graczach!")
            return
        end
        xPlayer.triggerEvent('esx_ambulancejob:revive')
        exports['non']:SendLog(src, "Użyto komendy /revive na sobie", "revive")
    else
        if args.playerId then
            args.playerId.triggerEvent('esx_ambulancejob:revive')
            exports['non']:SendLog(src, string.format("Użyto komendy /revive %d", args.playerId.source), "revive")
        else
            xPlayer.triggerEvent('esx_ambulancejob:revive')
            exports['non']:SendLog(src, "Użyto komendy /revive", "revive")
        end
    end

end, true, {
    help = _U('revive_help'),
    validate = false,
    arguments = {
        {
            name = 'playerId',
            validate = false,
            help = 'The player id',
            type = 'player'
        }
    }
})


ESX.RegisterUsableItem('medikit', function(source)
	if not playersHealing[source] then
		local xPlayer = ESX.GetPlayerFromId(source)
		xPlayer.removeInventoryItem('medikit', 1)

		playersHealing[source] = true
		TriggerClientEvent('esx_ambulancejob:useItem', source, 'medikit')

		Wait(10000)
		playersHealing[source] = nil
	end
end)

ESX.RegisterUsableItem('bandage', function(source)
	if not playersHealing[source] then
		local xPlayer = ESX.GetPlayerFromId(source)
		xPlayer.removeInventoryItem('bandage', 1)

		playersHealing[source] = true
		TriggerClientEvent('esx_ambulancejob:useItem', source, 'bandage')

		Wait(10000)
		playersHealing[source] = nil
	end
end)

ESX.RegisterServerCallback('esx_ambulancejob:getDeadPlayers', function(source, cb)
	local xPlayer = ESX.GetPlayerFromId(source)
	if xPlayer.job.name == "ambulance" then 
		cb(deadPlayers)
	end
end)

ESX.RegisterServerCallback('esx_ambulancejob:getDeathStatus', function(source, cb)
	local xPlayer = ESX.GetPlayerFromId(source)
	MySQL.scalar('SELECT is_dead FROM users WHERE identifier = ?', {xPlayer.identifier}, function(isDead)
		cb(isDead)
	end)
end)

RegisterNetEvent('esx_ambulancejob:setDeathStatus')
AddEventHandler('esx_ambulancejob:setDeathStatus', function(isDead)
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	Player(_source).state.isDead = isDead
	if xPlayer then
		if type(isDead) == 'boolean' then
			MySQL.update('UPDATE users SET is_dead = ? WHERE identifier = ?', {isDead, xPlayer.identifier})
		end
	end
end)