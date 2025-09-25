ESX = exports['es_extended']:getSharedObject() 

ESX.RegisterCommand('checkplayer', {'wlasciciel'}, function(xPlayer, args, showError)
    if args.id then
        local xTarget = ESX.GetPlayerFromId(args.id)
        if xPlayer and xTarget then
			exports['non']:SendLog(xPlayer.source, "Użyto komendy /checkplayer na graczu: ["..args.id.."] \nINFORMACJE: \nNICK: "..xTarget.name.." \nRANGA: "..xTarget.group.." \nJOB: ".."["..xTarget.job.name.."] " ..xTarget.job.label.." - "..xTarget.job.grade_label.." ["..xTarget.job.grade.."] \nSECONDJOB: ".."["..xTarget.secondjob.name.."] " ..xTarget.secondjob.label.." - "..xTarget.secondjob.grade_label.." ["..xTarget.secondjob.grade.."] \nTHIRDJOB: ".."["..xTarget.thirdjob.name.."] " ..xTarget.thirdjob.label.." - "..xTarget.thirdjob.grade_label.." ["..xTarget.thirdjob.grade.."] \nKASA W EQ: "..xPlayer.getMoney().." \nKASA W BANKU: "..xPlayer.getAccount('bank').money.." \nKASA BRUDNA: "..xPlayer.getAccount('black_money').money.."", "admin_commandsadmin_commands")
			xPlayer.showNotification('Poprawnie pobrano informacje o graczu! Spójrz w logi')
        end
    end
end, true, {help = "Sprawdz informacje o graczu", validate = true, arguments = {
    {name = 'id', help = "ID gracza", type = 'number'},
}})

ESX.RegisterCommand('slap', {'wlasciciel'}, function(xPlayer, args, showError)
    if args.id then
        local xTarget = ESX.GetPlayerFromId(args.id)
        if xPlayer and xTarget then
			local xTarget = ESX.GetPlayerFromId(args.id)
			TriggerClientEvent('EasyAdmin:Slap', xTarget.source)
			exports['non']:SendLog(xPlayer.source, "Użyto komendy /slap na graczu: ["..xTarget.source.."]", "admin_commands")
        end
    end
end, true, {help = "Wyjeb gracza w kosmos", validate = true, arguments = {
    {name = 'id', help = "ID gracza", type = 'number'},
}})

ESX.RegisterCommand('tpp', {'trialsupport'}, function(xPlayer, args, showError)
    if args.steamid and args.targetid then
        local xPlayer = ESX.GetPlayerFromId(args.steamid)
        local xPlayerTarget = ESX.GetPlayerFromId(args.targetid)
        if xPlayer and xPlayerTarget then
            TriggerClientEvent('EasyAdmin:Teleport', xPlayer.source, xPlayerTarget.source)
			exports['non']:SendLog(xPlayer.source, "Użyto komendy /tpp gracza: " .. args.steamid .. " do gracza: " .. args.targetid, "admin_commands")
        end
    end
end, true, {help = "Teleportuj gracza do gracza", validate = true, arguments = {
    {name = 'steamid', help = "ID gracza 1", type = 'number'},
    {name = 'targetid', help = "ID gracza 2", type = 'number'}
}})