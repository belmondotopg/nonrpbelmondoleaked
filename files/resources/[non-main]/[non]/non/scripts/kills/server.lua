local lastKilled = {}
GlobalPointsTable = {}

MySQL.ready(function()
    MySQL.query('SELECT identifier, name, points FROM users', {}, function(data)
        if data then
            for i = 1, #data do
                GlobalPointsTable[data[i].identifier] = {points = data[i].points, name = data[i].name}
            end
        end
	end)
end)

AddEventHandler('esx:playerLoaded', function(source, xPlayer)
    if not GlobalPointsTable[xPlayer.identifier] then
        GlobalPointsTable[xPlayer.identifier] = {points = 0, name = xPlayer.name}
    end

    xPlayer.set('playerPoints', GlobalPointsTable[xPlayer.identifier].points)
end)

AddEventHandler('esx:playerDropped', function(playerId, reason)
    local xPlayer = ESX.GetPlayerFromId(playerId)
    MySQL.update.await('UPDATE users SET points = ? WHERE identifier = ?', {GlobalPointsTable[xPlayer.identifier].points, xPlayer.identifier})
end)

local function checkLastKill(killerSrc, killedSrc)
    if lastKilled[killerSrc] then
        if lastKilled[killerSrc][killedSrc] then
            if lastKilled[killerSrc][killedSrc] > os.time() then
                return false
            else
                return true
            end
        else
            return true
        end
    else
        return true
    end
end

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

RegisterNetEvent('esx:onPlayerDeath', function(data)
    if data.killedByPlayer then
        local killedSrc = source
        local killerSrc = data.killerServerId
        local xKilledPlayer = ESX.GetPlayerFromId(killedSrc)
        local xKillerPlayer = ESX.GetPlayerFromId(killerSrc)
        local Weapon = (WeaponNames[data.deathCause] or 'Nieznany powód')
        local killerCoords = GetEntityCoords(GetPlayerPed(killerSrc))
        local victimCoords = GetEntityCoords(GetPlayerPed(killedSrc))
        local distance = math.ceil(#(killerCoords - victimCoords) * 10) / 10
        local playerName = GetPlayerName(killerSrc) or "Nieznany Gracz"
        local weaponName = Weapon or "Nieznana Broń"
        local distanceText = distance and (",<br>Z odległości: <b style='color:dodgerblue'>" .. distance .. "m</b>") or ""

        if killedSrc and killerSrc and not checkLastKill(killerSrc, killedSrc) then
            TriggerClientEvent('non:showNotification', xKillerPlayer.source, {
                type = 'kill',
                duration = 7000,
                title = 'Zabójstwo',
                text = "Zabiłeś: <b style='color:#E13232'>[" .. xKilledPlayer.source .. "] " .. xKilledPlayer.discord.name .. "</b>,<br>Z broni: <b style='color:magentapurple'>" .. weaponName .. "</b>" .. distanceText .. "!"
            })
            if distance > 100 then
                TriggerClientEvent('InteractSound_CL:PlayOnOne', xKillerPlayer.source, 'godlike', 0.5)
            end

            TriggerClientEvent('non-kills:print', xKillerPlayer.source, "kill", xKilledPlayer.discord.name, distance, weaponName)
            TriggerClientEvent('non-kills:print', xKilledPlayer.source, "killed", xKillerPlayer.discord.name, distance, weaponName)


            TriggerClientEvent('non:showNotification', xKilledPlayer.source, {
                type = 'kill',
                duration = 7000,
                title = 'Śmierć',
                text = "Zostałeś zabity przez: <b style='color:#E13232'>["..data.killerServerId.."] "..xKillerPlayer.discord.name.."</b>,<br>Z broni: <b style='color:magentapurple'>"..Weapon.."</b>,<br>Z odległości: <b style='color:dodgerblue'>"..distance.."m</b>"
            })
        end

        if killedSrc and killerSrc and checkLastKill(killerSrc, killedSrc) then

            local xKilledPlayer, xKillerPlayer = ESX.GetPlayerFromId(killedSrc), ESX.GetPlayerFromId(killerSrc)

            if xKilledPlayer and xKillerPlayer then

                local killedPoints, killerPoints = 0, 0
                
                if GlobalPointsTable[xKilledPlayer.identifier] then
                    killedPoints = GlobalPointsTable[xKilledPlayer.identifier].points
                else
                    local result = MySQL.single.await('SELECT name, points FROM users WHERE identifier = ?', {xKilledPlayer.identifier})
                    if result then
                        GlobalPointsTable[xKilledPlayer.identifier] = {points = result.points, name = result.name}
                    else
                        print('zabity ziombel nie jest w bazce kurwen', xKilledPlayer.identifier)
                    end
                end

                if GlobalPointsTable[xKillerPlayer.identifier].points then
                    killerPoints = GlobalPointsTable[xKillerPlayer.identifier].points
                else
                    local result = MySQL.single.await('SELECT name, points FROM users WHERE identifier = ?', {xKillerPlayer.identifier})
                    if result then
                        GlobalPointsTable[xKillerPlayer.identifier] = {points = result.points, name = result.name}
                    else
                        print('zabijający ziombel nie jest w bazce kurwen', xKillerPlayer.identifier)
                    end
                end

                local newkilledPoints, newkillerPoints = nil, nil
                local baseRanking = 100
                local difference = math.abs(killerPoints - killedPoints)

                if killerPoints > killedPoints then
                    newkilledPoints = killedPoints - math.ceil((baseRanking / (difference ^ 0.05)) / 2)
                    newkillerPoints = killerPoints + math.ceil((baseRanking / (difference ^ 0.05)))
                elseif killerPoints < killedPoints then
                    newkilledPoints = killedPoints - math.ceil((baseRanking * (difference ^ 0.1)) / 2)
                    newkillerPoints = killerPoints + math.ceil((baseRanking * (difference ^ 0.1)))
                else
                    newkilledPoints = killedPoints - (baseRanking / 2)
                    newkillerPoints = killerPoints + baseRanking
                end

                newkillerPoints = ESX.Math.Round(newkillerPoints)
                newkilledPoints = ESX.Math.Round(newkilledPoints)

                if newkillerPoints then
                    xKillerPlayer.set('playerPoints', newkillerPoints)
                    GlobalPointsTable[xKillerPlayer.identifier].points = newkillerPoints
                    -- if xPlayer.getGroup() == 'vip' or xPlayer.get('premiumgroup') then
                    local pointsDiff = math.abs(newkillerPoints - killerPoints)
                    local money = math.random(2500,3000)
   
                    TriggerClientEvent('non:showNotification', data.killerServerId, {
                        type = 'kill',
                        duration = 7000,
                        title = 'Zabójstwo',
                        text = "Zabiłeś: <b style='color:#E13232'>[" .. xKilledPlayer.source .. "] " .. xKilledPlayer.discord.name .. "</b>,<br>Z broni: <b style='color:magentapurple'>" .. weaponName .. "</b>" .. distanceText .. "!<br>Ranking + <span style='color: #ffce40'>"..pointsDiff.."</span>"
                    })

                    
                    if distance > 100 then
                        TriggerClientEvent('InteractSound_CL:PlayOnOne', data.killerServerId, 'godlike', 0.5)
                    end

                    TriggerClientEvent('non-kills:print', xKillerPlayer.source, "kill", xKilledPlayer.discord.name, distance, weaponName)
                    -- TUTAJ KURWO JEBANA DODAJ EXPORTS Z ITEMSHOP OKOK? ~ PaT

                    xKillerPlayer.addAccountMoney('money', money)
                end

                if newkilledPoints then
                    xKilledPlayer.set('playerPoints', newkilledPoints)
                    GlobalPointsTable[xKilledPlayer.identifier].points = newkilledPoints
                    local pointsDiff = math.abs(killedPoints - newkilledPoints)

                    TriggerClientEvent('non:showNotification', xKilledPlayer.source, {
                        type = 'kill',
                        duration = 7000,
                        title = 'Śmierć',
                        text = "Zostałeś zabity przez: <b style='color:#E13232'>["..data.killerServerId.."] "..xKillerPlayer.discord.name.."</b>,<br>Z broni: <b style='color:magentapurple'>"..Weapon.."</b>,<br>Z odległości: <b style='color:dodgerblue'>"..distance.."m</b>!<br>Ranking - <span style='color: #ffce40'>"..pointsDiff.."</span>"
                    })

                    TriggerClientEvent('non-kills:print', xKilledPlayer.source, "killed", xKillerPlayer.discord.name, distance, weaponName)

                end

                if not lastKilled[killerSrc] then
                    lastKilled[killerSrc] = {}
                end

                lastKilled[killerSrc][killedSrc] = os.time() + (15 * 60 * 1000)
            else
                print('Nieprawidłowy gracz zabity lub zabijający')
            end
        end
    end
end)

ESX.RegisterCommand('setranking', 'admin', function(xPlayer, args, showError)
    local xTarget = ESX.GetPlayerFromId(tonumber(args.playerId))
    if xTarget then
        xTarget.set('playerPoints', args.ranking)
        GlobalPointsTable[xTarget.identifier].points = args.ranking
        if xPlayer then
            xPlayer.showNotification('Ustawiono ranking gracza '..xTarget.source..' na '..args.ranking, 'info')
        else
            print('Ustawiono ranking gracza '..xTarget.source..' na '..args.ranking)
        end
        exports['non']:SendLog(xPlayer.source, string.format('Użyto komendy /setranking %d %s', xTarget.source, args.ranking), 'ranking')
    else
        if string.len(args.playerId) == 46 then
            GlobalPointsTable[args.playerId].points = args.ranking
            MySQL.update.await('UPDATE users SET points = ? WHERE identifier = ?', {GlobalPointsTable[args.playerId].points, args.playerId})
            if xPlayer then
                xPlayer.showNotification('Ustawiono ranking gracza '..args.playerId..' na '..args.ranking, 'info')
            else
                print('Ustawiono ranking gracza '..args.playerId..' na '..args.ranking)
            end
            exports['non']:SendLog(xPlayer.source, string.format('Użyto komendy /setranking %d %s', args.playerId, args.ranking), 'ranking')
        end
    end
end, true, {help = 'Ustaw ranking gracza', validate = true, arguments = {
    {name = 'playerId', help = 'ID gracza lub licencja (z char:)', type = 'string'},
    {name = 'ranking', help = 'Ilość rankingu', type = 'number'},
}})

ESX.RegisterCommand('ranking', 'user', function(xPlayer, args, showError)
    if args.playerId then
        xPlayer.showNotification('Ranking gracza ['..args.playerId.source..'] wynosi: '..GlobalPointsTable[args.playerId.identifier].points, 'info')
    else
        xPlayer.showNotification('Twój ranking wynosi: '..GlobalPointsTable[xPlayer.identifier].points, 'info')
    end
end, false, {help = 'Sprawdź swój ranking lub innego gracza', arguments = {
    {name = 'playerId', validate = false, help = 'ID gracza', type = 'player'},
}})