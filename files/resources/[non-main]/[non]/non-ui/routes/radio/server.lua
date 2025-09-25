local radioItems = {
    'radio',
    'radiocrime'
}

local PlayerChannels = {}

local wieczorChannels = {}
local wieczorPlayersInChannels = {}

for k, v in pairs(radioItems) do
    ESX.RegisterUsableItem(v, function(source)	
        TriggerClientEvent('non-radio:item', source)
    end)
end

ESX.RegisterServerCallback('non-radio:crimeRadioList', function(source, cb, data)
    local newtable = {}
    if data then
        for id, value in pairs(data) do
            local xPlayer = ESX.GetPlayerFromId(id)
            table.insert(newtable, {playerid = id, names = xPlayer.discord.name})
        end
    end
    cb(newtable)
end)

function RegisterInChannel(id, channel, label)
    if not wieczorChannels[channel] then wieczorChannels[channel] = {} end
    if not wieczorPlayersInChannels[id] then
        wieczorPlayersInChannels[id] = {
            channel = channel,
            status = false,
        }
    end
    if not wieczorPlayersInChannels[id].status then
        wieczorPlayersInChannels[id] = {
            channel = channel,
            status = true,
        }

        local xPlayer = ESX.GetPlayerFromId(source)

        table.insert(wieczorChannels[channel], {
            id = id,
            name = xPlayer.discord.name,
            isTalking = false,
            isDead = false,
        })
        for k, v in ipairs(wieczorChannels[channel]) do
            if v.id == id then
                TriggerClientEvent("non-radio:addTalking2", id, channel, wieczorChannels[channel])
            else
                TriggerClientEvent("non-radio:addTalking", v.id, channel, wieczorChannels[channel])
            end
        end
    else
        for k, v in ipairs(wieczorChannels[channel]) do
            if v.id == id then
                table.remove(wieczorChannels[channel], k)
                TriggerClientEvent("non-radio:stopTalking2", id)
            end
        end
        for k, v in ipairs(wieczorChannels[channel]) do
            TriggerClientEvent("non-radio:stopTalking", v.id, channel, wieczorChannels[channel])
        end
        wieczorPlayersInChannels[id] = nil
    end
end

RegisterServerEvent("non-radio:registerChannel", function(channel)
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
    RegisterInChannel(_source, channel)
end)

function UnregisterInChannel(_source)
    if wieczorPlayersInChannels[_source] then
        if wieczorPlayersInChannels[_source].status then
            local channel = wieczorPlayersInChannels[_source].channel
            for k, v in ipairs(wieczorChannels[channel]) do
                if v.id == _source then
                    table.remove(wieczorChannels[channel], k)
                    TriggerClientEvent("non-radio:stopTalking2", _source)
                end
            end
            for k, v in ipairs(wieczorChannels[channel]) do
                TriggerClientEvent("non-radio:stopTalking", v.id, channel, wieczorChannels[channel])
            end
            wieczorPlayersInChannels[_source] = {
                channel = 0,
                status = false,
            }
        end
    end
end

RegisterServerEvent("non-radio:unregisterChannel", function()
    local _source = source
    if wieczorPlayersInChannels[_source] then
        if wieczorPlayersInChannels[_source].status then
            UnregisterInChannel(_source)
        end
    end
end)

AddEventHandler('playerDropped', function()
    local _source = source
    if wieczorPlayersInChannels[_source] then
        if wieczorPlayersInChannels[_source].status then
            UnregisterInChannel(_source)
        end
    end
end)

function SendStartTalking(id, channel) 
    if wieczorChannels[channel] then
        for k, v in pairs(wieczorChannels[channel]) do 
            if v.id == id then
                wieczorChannels[channel][k].isTalking = true
            end
            TriggerClientEvent("non-radio:setTalking", v.id, channel, wieczorChannels[channel])
        end    
    end  
end

function SendStopTalking(id, channel) 
    if wieczorChannels[channel] then
        for k, v in pairs(wieczorChannels[channel]) do 
            if v.id == id then
                wieczorChannels[channel][k].isTalking = false
            end
            TriggerClientEvent("non-radio:setNotTalking", v.id, channel, wieczorChannels[channel])
        end    
    end  
end

RegisterServerEvent("pma-voice:setTalkingOnRadio", function(isTalking)
    local _source = source
    if wieczorPlayersInChannels[_source] then
        if wieczorPlayersInChannels[_source].status then
            if not isTalking then return SendStopTalking(_source, wieczorPlayersInChannels[_source].channel) end
            SendStartTalking(_source, wieczorPlayersInChannels[_source].channel)
        end
    end
end)

RegisterServerEvent('esx_ambulancejob:setDeathStatus', function(isDead)
    local deadResult = false;
    if isDead then
        deadResult = true;
    end
    if wieczorPlayersInChannels[source] ~= nil then
        local channel = wieczorPlayersInChannels[source].channel
        if wieczorChannels[channel] ~= nil then
            for k, v in pairs(wieczorChannels[channel]) do 
                if v.id == source then
                    wieczorChannels[channel][k].isDead = deadResult
                end
                TriggerClientEvent("non-radio:setPlayerDead", v.id, channel, wieczorChannels[channel])
            end
        end
    end
end)
