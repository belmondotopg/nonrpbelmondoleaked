local KitsUsers = {
    ['start'] = {
        groups = {
            ['user'] = true,
            ['media'] = true,
            ['trialsupport'] = true,
            ['support'] = true,
            ['vip'] = true,
            ['mod'] = true,
            ['smod'] = true,
            ['junioradm'] = true,
            ['admin'] = true,
            ['headadmin'] = true,
            ['management'] = true,
            ['zarzad'] = true,
            ['opiekunadm'] = true,
            ['nadzorserwera'] = true,
            ['glownyopiekun'] = true,
            ['wspolwlasciciel'] = true,
            ['wlasciciel'] = true,
        },
        delay = 15*15*6,
        items = {
            ['handcuffs'] = 1,
            ['radiocrime'] = 1,
            ['energydrink'] = 3,
            ['pistol'] = 1,
            ['pistol_ammo'] = 100,
        }
    },
    ['vip'] = {
        groups = {
            ['user'] = true,
            ['media'] = true,
            ['trialsupport'] = true,
            ['support'] = true,
            ['vip'] = true,
            ['mod'] = true,
            ['smod'] = true,
            ['junioradm'] = true,
            ['admin'] = true,
            ['headadmin'] = true,
            ['management'] = true,
            ['zarzad'] = true,
            ['opiekunadm'] = true,
            ['nadzorserwera'] = true,
            ['glownyopiekun'] = true,
            ['wspolwlasciciel'] = true,
            ['wlasciciel'] = true,
        },
        delay = 15*15*6,
        items = {
            ['handcuffs'] = 1,
            ['radiocrime'] = 2,
            ['energydrink'] = 8,
            ['vintagepistol'] = 1,
            ['snspistol_mk2'] = 1,
            ['pistol_ammo'] = 200,
            ['mdma'] = 15,
            ['vest_medium'] = 2,
        }
    },
    ['media'] = {
        groups = {
            ['media'] = true,
            ['nadzorserwera'] = true,
            ['glownyopiekun'] = true,
            ['wspolwlasciciel'] = true,
            ['wlasciciel'] = true,
        },
        delay = 30*30*6,
        items = {
            ['handcuffs'] = 1,
            ['radiocrime'] = 2,
            ['energydrink'] = 15,
            ['vintagepistol'] = 3,
            ['snspistol_mk2'] = 3,
            ['pistol_ammo'] = 200,
            ['mdma'] = 25,
            ['vest_medium'] = 2,
        }
    },
    ['adm'] = {
        groups = {
            ['opiekunadm'] = true,
            ['nadzorserwera'] = true,
            ['glownyopiekun'] = true,
            ['wspolwlasciciel'] = true,
            ['wlasciciel'] = true,
        },
        delay = 30,
        items = {
            ['handcuffs'] = 1,
            ['mdma'] = 25,
            ['vintagepistol'] = 1,
            ['snspistol_mk2'] = 1,
            ['pistol_ammo'] = 100
        }
    },
}

local KitsTable = {}
local collectingKit = {}

MySQL.ready(function()
	MySQL.query('SELECT * FROM kits', {}, function(data)
        for _, value in ipairs(data) do
            KitsTable[value.identifier] = json.decode(value.data)
        end
    end)
end)

local function GetKitsByIdentifier(id)
    if KitsTable[id] then
        for kitname, values in pairs(KitsUsers) do
            if not KitsTable[id][kitname] then
                KitsTable[id][kitname] = 0
            end
        end
    else
        KitsTable[id] = {}
        for kitname, values in pairs(KitsUsers) do
            KitsTable[id][kitname] = 0
        end

        MySQL.insert.await('INSERT INTO kits (identifier, data) VALUES (?, ?) ', {id, json.encode(KitsTable[id])})
    end
    return KitsTable[id]
end

local function UseKit(id, kit)
    if KitsTable[id][kit] <= os.time() then
        local xPlayer = ESX.GetPlayerFromIdentifier(id, true)
        for item, count in pairs(KitsUsers[kit].items) do
            xPlayer.addInventoryItem(item, count)
        end

        KitsTable[id][kit] = os.time() + KitsUsers[kit].delay

        MySQL.update.await('UPDATE kits SET data = ? WHERE identifier = ? ', {json.encode(KitsTable[id]), id})

        return true
    else
        return {false, KitsTable[id][kit]}
    end
end

function SplitId(string)
    local output
    for str in string.gmatch(string, '([^:]+)') do
        output = str
    end
    return output
end

ESX.RegisterCommand('kit', 'user', function(xPlayer, args, showError)
    if not collectingKit[xPlayer.source] then
        collectingKit[xPlayer.source] = true
        local identifier = SplitId(xPlayer.identifier)
        local ableKits = GetKitsByIdentifier(identifier)
        local playerGroup = xPlayer.getGroup()
        local premiumGroup = xPlayer.get('premiumgroup')
        for kitName, time in pairs(ableKits) do
            if KitsUsers[kitName] and (KitsUsers[kitName].groups[playerGroup] or KitsUsers[kitName].groups[premiumGroup]) then
                local kitToLower = string.lower(args.kitname)
                if kitName == string.lower(kitToLower) then
                    local usedKit = UseKit(identifier, kitName)
                    if type(usedKit) == 'table' then
                        local timeLeft = os.date('%Y-%m-%d %H:%M:%S', usedKit[2])
                        xPlayer.showNotification('Zestaw niedostępny do '..timeLeft, 'error')
                    else
                        xPlayer.showNotification('Odebrano zestaw: '..kitName, 'success')
                        exports['non']:SendLog(xPlayer.source, string.format('Odebrano zestaw! Zestaw: %s', kitName), 'kity')
                    end
                    collectingKit[xPlayer.source] = nil
                    break
                else
                    collectingKit[xPlayer.source] = nil
                end
            else
                collectingKit[xPlayer.source] = nil
            end
        end
    end
end, false, {help = 'Odbierz zestaw', validate = true, arguments = {
	{name = 'kitname', help = 'start/vip/media/adm', type = 'string'}
}})