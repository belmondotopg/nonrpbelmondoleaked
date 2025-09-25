local cache = {players = {}}

boardData = {
    players = GetNumPlayerIndices();
    slots = GetConvar("sv_maxClients", 500);
    police = 0;
    admins = 0;
}

GlobalState.scoreboardData = boardData

local scoreboardJobs = {
    ['police'] = true,
}

updateScoreboard = function(key, action)
    if (key == 'players') then
        boardData = GlobalState.scoreboardData
        boardData['players'] = GetNumPlayerIndices()
        GlobalState.scoreboardData = boardData
    elseif (key == 'adminsCount' or scoreboardJobs[key]) then
        boardData = GlobalState.scoreboardData
        boardData[key] = (action == 'increase') and boardData[key] + 1 or boardData[key] - 1
        if (boardData[key] <= 0) then
            boardData[key] = 0
        end 
        GlobalState.scoreboardData = boardData  
    else
        boardData = GlobalState.scoreboardData
        boardData[key] = (action == 'increase') and boardData[key] + 1 or boardData[key] - 1
        if (boardData[key] <= 0) then
            boardData[key] = 0
        end  
        GlobalState.scoreboardData = boardData  
    end
end

local notAdminGroups = {
    ["media"] = true,
    ["revivator"] = true,
    ["user"] = true,
    ["vip"] = true,
}

CreateThread(function()
    local players = GetPlayers()
    for _, playerId in ipairs(players) do
        local xPlayer = ESX.GetPlayerFromId(playerId)
        if not xPlayer then return end
        
        if not (cache.players[xPlayer.source]) then
            cache.players[xPlayer.source] = {
                job = xPlayer.job.name,
                id = xPlayer.source
            }
        end

        local playerJob = xPlayer.job.name
        if scoreboardJobs[playerJob] then
            updateScoreboard(playerJob, 'increase')
        end
        if not notAdminGroups[xPlayer.group] then
            updateScoreboard('admins', 'increase')
        end
    end
end)

AddEventHandler('esx:playerLoaded', function(source, xPlayer)
    updateScoreboard('players', 'increase')
    if not (cache.players[xPlayer.source]) then
        cache.players[xPlayer.source] = {
            job = xPlayer.job.name,
            id = xPlayer.source
        }
    end
    if scoreboardJobs[xPlayer.job.name] then
        updateScoreboard(xPlayer.job.name, 'increase')
    end
    if not notAdminGroups[xPlayer.group] then
        updateScoreboard('admins', 'increase')
    end
end)

AddEventHandler('esx:playerDropped', function(src)
    local xPlayer = ESX.GetPlayerFromId(src)
    updateScoreboard('players', 'decrease')

    if (cache.players[xPlayer.source]) then
        cache.players[xPlayer.source] = nil 
    end

    if scoreboardJobs[xPlayer.job.name] then
        updateScoreboard(xPlayer.job.name, 'decrease')
    end

    if not notAdminGroups[xPlayer.group] then
        updateScoreboard('admins', 'decrease')
    end
end)

AddEventHandler('esx:setJob', function(src, newJob, lastJob)
    cache.players[src].job = newJob.name
    if scoreboardJobs[newJob.name] then
        updateScoreboard(newJob.name, 'increase')
    end
    if scoreboardJobs[lastJob.name] then
        updateScoreboard(lastJob.name, 'decrease')
    end
end)

AddEventHandler('esx:setGroup', function(source, group, lastgroup)
    print(source, group, lastgroup)
    if (notAdminGroups[lastgroup] or not notAdminGroups[group]) then
        updateScoreboard('admins', 'increase')
    elseif (not notAdminGroups[lastgroup] or notAdminGroups[group]) then
        updateScoreboard('admins', 'decrease')
    end
end)

exports('CountPlayer', function(key)
    boardData = GlobalState.scoreboardData
    if key == "players" then
        return boardData.players
    elseif key == "police" then
        return boardData.police
    end
end)

exports('serverCounter', function(name)
    boardData = GlobalState.scoreboardData
    if (name == 'police') then
        return boardData.police
    elseif (name == 'players') then
        return boardData.players
    end
end)

local jobziomka = nil

ESX.RegisterServerCallback('non-scoreboard:orgjob', function(source, cb, data)
    local xPlayer = ESX.GetPlayerFromId(source)
    if string.find(xPlayer.job.name, "org") then
        jobziomka = xPlayer.getJob().label
    else
        jobziomka = false
    end
    cb(jobziomka)
end)