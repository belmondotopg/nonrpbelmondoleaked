local robbers = {}

RegisterServerEvent('esx_holdup:tooFar')
AddEventHandler('esx_holdup:tooFar', function(currentStore)
	local source = source
	for _, xPlayer in pairs(ESX.GetExtendedPlayers('job', 'police')) do
		xPlayer.showNotification(_U('robbery_cancelled_at', Stores[currentStore].nameOfStore), 'police')
		TriggerClientEvent('esx_holdup:killBlip', xPlayer.source, Stores[currentStore].nameOfStore)
	end
	if robbers[source] then
		TriggerClientEvent('esx_holdup:tooFar', source)
		ESX.ClearTimeout(robbers[source])
        robbers[source] = nil
		TriggerEvent('non:setBusyPolice', 'remove', Config.PoliceNumberRequired)
		local xPlayer = ESX.GetPlayerFromId(source)
		xPlayer.showNotification(_U('robbery_cancelled_at', Stores[currentStore].nameOfStore), 'police')
		exports['non']:SendLog(xPlayer.source, string.format('Anulowano napad na sklep\nAnulowano napad na %s', Stores[currentStore].nameOfStore), 'napady')
	else
		exports['non']:SendLog(xPlayer.source, string.format('Anulowano napad na sklep\nAnulowano napad na %s', Stores[currentStore].nameOfStore), 'napady')
	end
end)

RegisterServerEvent('esx_holdup:robberyStarted')
AddEventHandler('esx_holdup:robberyStarted', function(currentStore, copsCount)
	local source  = source
	local xPlayer  = ESX.GetPlayerFromId(source)

	if Stores[currentStore] then
		local store = Stores[currentStore]
		if (os.time() - store.lastRobbed) < Config.TimerBeforeNewRob and store.lastRobbed ~= 0 then
			xPlayer.showNotification(_U('recently_robbed', Config.TimerBeforeNewRob - (os.time() - store.lastRobbed)))
			return
		end
		if copsCount >= Config.PoliceNumberRequired then
			local realPoliceCount = copsCount - exports['non']:getBusyPoliceCount()
			if realPoliceCount < 0 then realPoliceCount = 0 end
			if realPoliceCount >= Config.PoliceNumberRequired then
				local xPlayers = ESX.GetExtendedPlayers('job', 'police')
				for i=1, #(xPlayers) do 
					local xPlayer = xPlayers[i]
					xPlayer.showNotification(_U('rob_in_prog', store.nameOfStore))
					TriggerClientEvent('esx_holdup:setBlip', xPlayer.source, Stores[currentStore].position, store.nameOfStore)
				end
				xPlayer.showNotification(_U('started_to_rob', store.nameOfStore))
				xPlayer.showNotification(_U('alarm_triggered'))
				TriggerClientEvent('esx_holdup:currentlyRobbing', source, currentStore)
				TriggerClientEvent('esx_holdup:startTimer', source)
				TriggerEvent('non:setBusyPolice', 'add', Config.PoliceNumberRequired)

				exports['non']:SendLog(xPlayer.source, string.format('Rozpoczęto napad na sklep\nRozpoczęto napad na %s', store.nameOfStore), 'napady')

				Stores[currentStore].lastRobbed = os.time()
				robbers[source] = ESX.SetTimeout(store.secondsRemaining * 1000, function()
					xPlayer = ESX.GetPlayerFromId(source)
					if xPlayer then
						TriggerClientEvent('esx_holdup:robberyComplete', source, store.reward)
						if Config.GiveBlackMoney then
							xPlayer.addAccountMoney('black_money', store.reward, "Robbery")
						else
							xPlayer.addMoney(store.reward, "Robbery")
						end
						xPlayer.addInventoryItem('easterbasket', math.random(2))
						exports['non']:SendLog(xPlayer.source, string.format('Zakończono napad na sklep\nZakończono napad na %s\nZarobek: %s$', store.nameOfStore, store.reward), 'napady')

						robbers[source] = nil
					end
					local xPlayers = ESX.GetExtendedPlayers('job', 'police')
					for i=1, #(xPlayers) do 
						local xPlayer = xPlayers[i]
						xPlayer.showNotification(_U('robbery_complete_at', store.nameOfStore), 'police')
						TriggerClientEvent('esx_holdup:killBlip', xPlayer.source, store.nameOfStore)
					end
					SetTimeout(600 * 1000, function()
						TriggerEvent('non:setBusyPolice', 'remove', Config.PoliceNumberRequired)
					end)
				end)
			else
				xPlayer.showNotification('Brak wolnych funkcjonariuszy (aktualnie wolnych: '..realPoliceCount..')', 'error')
			end
		else
			xPlayer.showNotification(_U('min_police', Config.PoliceNumberRequired))
		end
	end
end)