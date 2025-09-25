RegisterNetEvent('non-anims:syncAccepted', function(requester, id)
    local accepted = source
    
    TriggerClientEvent('non-anims:playSynced', accepted, requester, id, 'Accepter')
    TriggerClientEvent('non-anims:playSynced', requester, accepted, id, 'Requester')
end)

RegisterNetEvent('non-anims:requestSynced', function(target, id)
    local requester = source

	TriggerClientEvent('non:showNotification', requester, 'Wysłano propozycję animacji do '..target, 'success')
	TriggerClientEvent('non-anims:syncRequest', target, requester, id)
end)

RegisterNetEvent('non-anims:cancelSync', function(requester)
	TriggerClientEvent('non:showNotification', requester, 'Osoba odrzuciła propozycję wspólnej animacji', 'info')
end)

RegisterNetEvent('non-anims:requestSyncedCarry', function(target, carryType)
    TriggerClientEvent('non-anims:requestClientSyncedCarry', target, source, carryType)
end)

RegisterNetEvent('non-anims:answerSyncedCarry', function(sender, carryType)
    TriggerClientEvent('non-anims:playSyncedCarry', sender, source, carryType, 'sender')
    TriggerClientEvent('non-anims:playSyncedCarry', source, sender, carryType)
end)

RegisterNetEvent('non-anims:cancelSyncedCarry', function(target)
    TriggerClientEvent('non-anims:cancelClientSyncedCarry', target)
end)