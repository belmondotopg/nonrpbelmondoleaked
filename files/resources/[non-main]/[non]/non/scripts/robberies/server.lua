local busyPoliceCount = 0

RegisterServerEvent('non:setBusyPolice')
AddEventHandler('non:setBusyPolice', function(actionType, count)
	if actionType == 'add' then
		busyPoliceCount = busyPoliceCount + count
	elseif actionType == 'remove' then
		busyPoliceCount = busyPoliceCount - count
	end
end)

function getBusyPoliceCount()
	return busyPoliceCount
end

exports('getBusyPoliceCount', getBusyPoliceCount)

ESX.RegisterCommand('pd', 'user', function(xPlayer, args, showError)
	local pdCount = exports['non-ui']:CountPlayer('police') - busyPoliceCount
	if pdCount < 0 then pdCount = 0 end
	xPlayer.showNotification('Aktualna ilość wolnych PD: '..pdCount, 'info')
end, false, {help = 'Sprawdzenie ilości wolnych PD'})