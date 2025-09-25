local CharCount, VehCount, LiczbaMandatowPrzezMiesiac, LiczbaMandatowPrzezTydzien, PhoneNumber, KartotekaSearch, Police, OstatnieMandatySelect, VehiclesByPlate, VehiclesByIdentifier, NotepadSelect, NotepadInsert, NotepadUpdate, OgloszeniaSelect, OgloszeniaInsert, OgloszeniaDelete, RaportySelect, RaportyInsert, RaportDelete, JudgmentsSelect, JudgmentsInsert, JudgmentsDelete, PoszukiwaniaSelect, PoszukiwaniaInsert, PoszukiwaniaDelete, KartotekaNotatkiSelect, KartotekaNotatkiInsert, KartotekaNotatkiDelete, IdentifierFromPhoneNumber = -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1
local array = nil
ESX = exports["es_extended"]:getSharedObject()

MySQL.ready(function()
    CharCount = MySQL.Sync.store("SELECT COUNT(*) FROM `users`");
    VehCount = MySQL.Sync.store("SELECT COUNT(*) FROM `owned_vehicles`");
    LiczbaMandatowPrzezMiesiac = MySQL.Sync.store("SELECT COUNT(*) FROM `lspdmdt_judgments`WHERE date between date_sub(now(),INTERVAL 1 MONTH) and now();")
    LiczbaMandatowPrzezTydzien = MySQL.Sync.store("SELECT COUNT(*) FROM `lspdmdt_judgments` WHERE date between date_sub(now(),INTERVAL 1 WEEK) and now();")
    PhoneNumber = MySQL.Sync.store("SELECT `phone_number` FROM `users` WHERE `identifier` = ?")
    IdentifierFromPhoneNumber = MySQL.Sync.store("SELECT `identifier` FROM `users` WHERE `phone_number` = ?")
    MySQL.Async.store("SELECT `identifier`, `digit`, `name`, `dateofbirth`, `phone_number` FROM `users` WHERE `name` = ?", function(storeId)
        KartotekaSearch = storeId
    end)
    MySQL.Async.store("SELECT * FROM `lspdmdt_judgments` WHERE date between date_sub(now(),INTERVAL 1 WEEK) and now() ORDER BY id DESC;", function(storeId)
		OstatnieMandatySelect = storeId
	end)
    MySQL.Async.store('SELECT users.name, users.phone_number, owned_vehicles.vehicle, owned_vehicles.plate FROM owned_vehicles INNER JOIN users ON owned_vehicles.identifier = users.identifier WHERE owned_vehicles.plate LIKE ?;', function(storeId)
		VehiclesByPlate = storeId
	end)
    MySQL.Async.store('SELECT `vehicle`, `plate` FROM `owned_vehicles` WHERE `identifier` = ?', function(storeId)
		VehiclesByIdentifier = storeId
	end)
    MySQL.Async.store("SELECT `notatka` FROM `lspdmdt_notatki` WHERE `identifier` = ?", function(storeId)
		NotepadSelect = storeId
	end)
    MySQL.Async.store('INSERT INTO `lspdmdt_notatki`(`identifier`, `notatka`) VALUES (?,?)', function(storeId)
        NotepadInsert = storeId
    end)
    MySQL.Async.store('UPDATE `lspdmdt_notatki` SET `notatka` = ? WHERE `identifier` = ?', function(storeId)
        NotepadUpdate = storeId
    end)
    MySQL.Async.store("SELECT * FROM `lspdmdt_ogloszenia`", function(storeId)
		OgloszeniaSelect = storeId
	end)
    MySQL.Async.store('INSERT INTO `lspdmdt_ogloszenia`(`fp`, `ogloszenie`) VALUES (?,?)', function(storeId)
        OgloszeniaInsert = storeId
    end)
    MySQL.Async.store('DELETE FROM `lspdmdt_ogloszenia` WHERE `fp` = ? AND `ogloszenie` = ?', function(stroeId)
        OgloszeniaDelete = stroeId
    end)
    MySQL.Async.store("SELECT * FROM `lspdmdt_raporty`", function(storeId)
		RaportySelect = storeId
	end)
    MySQL.Async.store('INSERT INTO `lspdmdt_raporty`(`fp`, `raport`) VALUES (?,?)', function(storeId)
        RaportyInsert = storeId
    end)
    MySQL.Async.store('DELETE FROM `lspdmdt_raporty` WHERE `fp` = ? AND `raport` = ?', function(stroeId)
        RaportDelete = stroeId
    end)
    MySQL.Async.store("SELECT * FROM `lspdmdt_judgments` WHERE `identifier` = ?", function(storeId)
		JudgmentsSelect = storeId
	end)
    MySQL.Async.store('INSERT INTO `lspdmdt_judgments`(`identifier`, `fp`, `reason`, `fee`, `length`) VALUES (?,?,?,?,?)', function(storeId)
        JudgmentsInsert = storeId
    end)
    MySQL.Async.store('DELETE FROM `lspdmdt_judgments` WHERE `id` = ? AND `identifier` = ?', function(storeId)
        JudgmentsDelete = storeId
    end)
    MySQL.Async.store("SELECT * FROM `lspdmdt_poszukiwani` WHERE `identifier` = ?", function(storeId)
		PoszukiwaniaSelect = storeId
	end)
    MySQL.Async.store('INSERT INTO `lspdmdt_poszukiwani`(`identifier`, `fp`, `reason`) VALUES (?,?,?)', function(storeId)
        PoszukiwaniaInsert = storeId
    end)
    MySQL.Async.store('DELETE FROM `lspdmdt_poszukiwani` WHERE `identifier` = ? AND `reason` = ?', function(storeId)
        PoszukiwaniaDelete = storeId
    end)
    MySQL.Async.store("SELECT * FROM `lspdmdt_kartoteka_notatki` WHERE `identifier` = ?", function(storeId)
		KartotekaNotatkiSelect = storeId
	end)
    MySQL.Async.store('INSERT INTO `lspdmdt_kartoteka_notatki`(`identifier`, `notatka`, `fp`) VALUES (?,?,?)', function(storeId)
        KartotekaNotatkiInsert = storeId
    end)
    MySQL.Async.store('DELETE FROM `lspdmdt_kartoteka_notatki` WHERE `identifier` = ? AND `notatka` = ?', function(storeId)
        KartotekaNotatkiDelete = storeId
    end)
    Polices = MySQL.Sync.fetchAll("SELECT `identifier`, `name`, `phone_number` FROM `users` WHERE `job` = ?", {"police"})
    
	for k,v in pairs(Polices) do
        v.duty_status = 1
        v.color = "red"
    end
end)

GetIdCard = function(identifier)
	if identifier == nil then
		return 'Brak danych'
	end
	
	local xPlayer = ESX.GetPlayerFromIdentifier(identifier)
	if xPlayer ~= nil then
		return xPlayer.discord.name
	else
		local data = MySQL.Sync.fetchAll('SELECT name FROM users WHERE identifier = @identifier', {
			['@identifier']	= identifier
		})	
		
		if data[1] ~= nil then
			return data[1].name
		else
			return 'Brak danych'	
		end
	end
end

AddEventHandler('playerDropped', function(reason)
	local playerId = source
	local xPlayer = ESX.GetPlayerFromId(playerId)
    if xPlayer ~= nil and xPlayer.job.name == 'police' then

        if xPlayer.job.name == 'police' then
            array = Polices
        end
		
        for k,v in pairs(array) do
            if xPlayer.identifier == v.identifier then
                v.duty_status = 1
                v.color = "red"
            end
        end
    end
end)

ESX.RegisterServerCallback('esx_lspdmdt:GetVehicleByPlate', function(source, cb, plate)
    local xPlayer = ESX.GetPlayerFromId(source)
    if xPlayer ~= nil and xPlayer.job.name == 'police' then
        MySQL.Async.fetchAll(VehiclesByPlate, {plate..'%'}, function(result)
            local vehdata = {}
            
            for k,v in pairs(result) do
                local vehicle = json.decode(v.vehicle)
                local numer_telefonu = v.phone_number
                local veharray = {
                    ownername = v.name,
                    plate = v.plate,
                    model = vehicle.name,
                    phone_number = v.phone_number
                }
                table.insert(vehdata, veharray)
            end
            cb(vehdata)
        end)
    else
        DropPlayer(source, "esx_lspdmdt: don't touch this!") 
    end
end)


ESX.RegisterServerCallback('esx_lspdmdt:GetWeaponBySerial', function(source, cb, serial)
    local xPlayer = ESX.GetPlayerFromId(source)
    if xPlayer ~= nil and xPlayer.job.name == 'police' then
        local Items = ESX.GetItems()
        number = tonumber(serial)
        
        if number ~= nil then
            number = tostring(number)
            
            local Weapon = Items[number]
            if Weapon then
                local numer_telefonu = MySQL.Sync.fetchScalar(PhoneNumber, {Weapon.data.identifier})
                local weaponarray = {
                    ownername = ESX.GetIdCard(Weapon.data.identifier),
                    serial = serial,
                    model = Weapon.label,
                    phone_number = v.phone_number
                }	
                cb(weaponarray)
            end
        end
    else
        DropPlayer(source, "esx_lspdmdt: don't touch this!") 
    end
end)

ESX.RegisterServerCallback('esx_lspdmdt:SearchNumber', function(source, cb, numer)
    local xPlayer = ESX.GetPlayerFromId(source)
    if xPlayer ~= nil and xPlayer.job.name == 'police' then		
        local identifier = MySQL.Sync.fetchScalar(IdentifierFromPhoneNumber, {numer})
        exports['non']:ServerDebugPrint({type = "info", message = identifier})
        local numerarray = {
            ownername = v.name,
            phone_number = numer
        }
        cb(numerarray)
    else
        DropPlayer(source, "esx_lspdmdt: don't touch this!") 
    end
end)

ESX.RegisterServerCallback('esx_lspdmdt:SearchPersonKartoteka', function(source, cb, data)
    local xPlayer = ESX.GetPlayerFromId(source)
    if xPlayer ~= nil and xPlayer.job.name == 'police' then
        MySQL.Async.fetchAll(KartotekaSearch, {data.name}, function(result)
            cb(result)
        end)
    else
        DropPlayer(source, "esx_lspdmdt: don't touch this!") 
    end
end)


RegisterServerEvent('esx_lspdmdt:WystawMandat')
AddEventHandler('esx_lspdmdt:WystawMandat', function(data)
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
    local xTarget = ESX.GetPlayerFromId(data.id)
    if xPlayer ~= nil and xPlayer.job.name == 'police' then
        local ped = GetPlayerPed(_source)
        local xped = GetPlayerPed(data.id)
        local playerCoords = GetEntityCoords(ped)
        local xplayerCoords = GetEntityCoords(xped)
        local distance = #(playerCoords - xplayerCoords)
        if distance > 20 then 
            TriggerEvent("wieczor:Event", _source, GetCurrentResourceName(), "triggered with distance!") 
            CancelEvent()
        else
            local fp = ""..xPlayer.discord.name
            local name = xTarget.discord.name
            local mandat = tonumber(data.fee)
            MySQL.Async.execute(JudgmentsInsert, {xTarget.identifier, fp, data.text, mandat, 0})
                
            xTarget.removeAccountMoney('bank', mandat)

            -- TriggerEvent('esx_addonaccount:getSharedAccount', 'society_police', function(account)
                -- account.addAccountMoney(math.floor(mandat * 70 / 100))
                -- xPlayer.addAccountMoney('bank', math.floor(mandat * 30 / 100))
            -- end)
            TriggerClientEvent('chat:addMessage1', -1, "Sędzia", {0, 0, 0, 0.4}, name..' ^*^2 dostał mandat o wartości ^*^7'..mandat..'$ ^*^1| ^*^2Powód: ^*^7'..data.text..' ^*^1| ^*^2Funkcjonariusz: ^*^7'..fp..'^*^1', "fas fa-clipboard", {255, 255, 255}, "#02ab02")
            exports['non']:SendLog(_source, "Wystawiono mandat\nOsoba: [" .. xTarget.source .. "] " .. GetPlayerName(xTarget.source) .."\nPowód: "..data.text.."\nMandat: "..mandat, 'jail', '15844367')
        end
    else
        TriggerEvent("wieczor:Event", _source, GetCurrentResourceName(), "triggered without job!") 
        DropPlayer(_source, "esx_lspdmdt: don't touch this!")
    end
end)


RegisterNetEvent('esx_lspdmdt:WystawWiezienie')
AddEventHandler('esx_lspdmdt:WystawWiezienie', function(data)
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
    local xTarget = ESX.GetPlayerFromId(data.id)

    if xPlayer ~= nil and xPlayer.job.name == 'police' then
        local ped = GetPlayerPed(_source)
        local xped = GetPlayerPed(data.id)
        local playerCoords = GetEntityCoords(ped)
        local xplayerCoords = GetEntityCoords(xped)
        local distance = #(playerCoords - xplayerCoords)
        if distance > 20 then
            DropPlayer(_source, "esx_lspdmdt: don't touch this!")
            CancelEvent()
        else
            local fp = ""..xPlayer.discord.name
            local name = xTarget.discord.name
            local mandat = tonumber(data.fee)

            MySQL.Async.execute(JudgmentsInsert, {xTarget.identifier, fp, data.text, mandat, data.length})

            xTarget.removeAccountMoney('bank', mandat)
            xPlayer.addAccountMoney('bank', math.floor(mandat * 30 / 100))

            exports['non']:sendToPrace(xTarget.source, math.floor(data.length / 3))
            -- TriggerEvent('fineeaszekwsadzkoegedowiezeiniaplcomeu123123', xTarget.source, data.length * 60)
            -- TriggerClientEvent('chat:addMessage1', -1, "Sędzia", {0, 0, 0, 0.4}, name..' ^*^2 dostał wyrok na ^*^7'..data.length..' miesięcy ^*^2 z grzywną ^*^7'..mandat..'$ ^*^1| ^*^2Powód: ^*^7'..data.text..' ^*^1| ^*^2Funkcjonariusz: ^*^7'..fp..'^*^1', "fas fa-clipboard", {255, 255, 255}, "#02ab02")
            exports['non']:SendLog(_source, "Wrzucono do więzienia\nOsoba: [" .. xTarget.source .. "] " .. GetPlayerName(xTarget.source) .."\nPowód: "..data.text.."\nMiesięcy: "..data.length.."\nGrzywna: "..mandat, 'jail', '15844367')
                exports['non']:SendLog(_source, "Wrzucono do więzienia\nOsoba: [" .. xTarget.source .. "] " .. GetPlayerName(xTarget.source) .."\nPowód: "..data.text.."\nMiesięcy: "..data.length.."\nGrzywna: "..mandat, 'jailpd', '15844367')
        end
    else
        TriggerEvent("wieczor:Event", _source, GetCurrentResourceName(), "triggered without job!") 
        DropPlayer(_source, "esx_lspdmdt: don't touch this!")
    end
end)


RegisterServerEvent("esx_lspdmdt:SendMdtData")
AddEventHandler("esx_lspdmdt:SendMdtData", function()
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	
	if xPlayer ~= nil then
        if xPlayer.job.name == 'police' then
    
            if xPlayer.job.name == 'police' then
                array = Polices
            end
			
            local MdtData = {
                charCount = MySQL.Sync.fetchScalar(CharCount),
                vehCount = MySQL.Sync.fetchScalar(VehCount),
                mandatyMiesiac = MySQL.Sync.fetchScalar(LiczbaMandatowPrzezMiesiac);
                mandatyTydzien = MySQL.Sync.fetchScalar(LiczbaMandatowPrzezTydzien);
                OstatnieMandaty = MySQL.Sync.fetchAll(OstatnieMandatySelect),
                Player = {
                    firstname = xPlayer.discord.name,
                    job = xPlayer.job,
                },
                Police = array,
                Notepad = MySQL.Sync.fetchScalar(NotepadSelect, {xPlayer.identifier}),
                Ogloszenia = MySQL.Sync.fetchAll(OgloszeniaSelect),
                Raporty = MySQL.Sync.fetchAll(RaportySelect),
                Taryfikator = Config.Taryfikator
            }	
            TriggerClientEvent("esx_lspdmdt:SendMdtData", _source, MdtData)
        else
            TriggerEvent("wieczor:Event", _source, GetCurrentResourceName(), "touched mdt data!") 
            DropPlayer(_source, "esx_lspdmdt: don't touch this!") 
        end
	end
end)

RegisterServerEvent("esx_lspdmdt:UpdatePoliceStatus")
AddEventHandler("esx_lspdmdt:UpdatePoliceStatus", function(type)
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
    -- print(xPlayer.job.label)
	
	if xPlayer ~= nil then

		local jestwtablicy = false
        local array = {}

        if xPlayer.job.name == 'offpolice' or xPlayer.job.name == 'police' then
            array = Polices
        end
		
		if type == 'insert' then
			for k,v in pairs(array) do
				if xPlayer.identifier == v.identifier then
					v.duty_status = 2
					v.color = "green"
					jestwtablicy = true
					break
				end
			end
			if not jestwtablicy then
				table.insert(array, {
					identifier = xPlayer.identifier,
					firstname = xPlayer.discord.name,
					grade = xPlayer.job.label,
					duty_status = 2,
					color = "green"
				})
			end
		elseif type == 'remove' then
			for k,v in pairs(array) do
				if xPlayer.identifier == v.identifier then
					if xPlayer.job.name == 'offpolice' then
						v.duty_status = 1
						v.color = "red"
						break
					else
						table.remove(array, k)
						break
					end
				end
			end
		end
		
        table.sort(array, function(a, b)
            if a ~= nil and b ~= nil and a.duty_status ~= b.duty_status then
                return tonumber(a.duty_status) > tonumber(b.duty_status)
            end
        end)
	end
end)


RegisterServerEvent("esx_lspdmdt:UpdateNotepad")
AddEventHandler("esx_lspdmdt:UpdateNotepad", function(note)
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)

    if xPlayer ~= nil and xPlayer.job.name == 'police' then
        if note ~= nil then        
            MySQL.Async.fetchAll(NotepadSelect, {
                xPlayer.identifier,
            }, function(notepad)
                if notepad[1] then
                    MySQL.Async.execute(NotepadUpdate, {note, xPlayer.identifier})
                else
                    MySQL.Async.execute(NotepadInsert, {xPlayer.identifier, note})
                end		
            end)
        end
    else
        TriggerEvent("wieczor:Event", _source, GetCurrentResourceName(), "touched mdt notepad data!") 
        DropPlayer(_source, "esx_lspdmdt: don't touch this!")
    end
end)


ESX.RegisterServerCallback('esx_lspdmdt:SendAnnounce', function(source, cb, text)
    local xPlayer = ESX.GetPlayerFromId(source)
    if xPlayer ~= nil and xPlayer.job.name == 'police' and xPlayer.job.grade == 1 then
        if(text ~= nil and text ~= "") then
            local announcedata = {
                owner = ""..xPlayer.discord.name,
                text = text,
                date = os.time(os.date("!*t"))
            }
            MySQL.Async.execute(OgloszeniaInsert, {announcedata.owner, announcedata.text})
            cb(announcedata)
        end
    else
        TriggerEvent("wieczor:Event", source, GetCurrentResourceName(), "touched mdt announce data!")
        DropPlayer(source, "esx_lspdmdt: don't touch this!") 
    end
end)

RegisterServerEvent("esx_lspdmdt:RemoveAnnounce")
AddEventHandler("esx_lspdmdt:RemoveAnnounce", function(data)
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)

    if xPlayer ~= nil and xPlayer.job.name == 'police' and xPlayer.job.grade == 1 then
        if(data.fp ~= nil and data.ogloszenie ~= nil) then
            MySQL.Async.execute(OgloszeniaDelete, {data.fp, data.ogloszenie})
        end
    else
        TriggerEvent("wieczor:Event", _source, GetCurrentResourceName(), "touched mdt announce data!") 
        DropPlayer(_source, "esx_lspdmdt: don't touch this!") 
    end

end)

ESX.RegisterServerCallback('esx_lspdmdt:SendRaport', function(source, cb, text)
    local xPlayer = ESX.GetPlayerFromId(source)
    if xPlayer ~= nil and xPlayer.job.name == 'police' then
        if(text ~= nil and text ~= "") then
            local raportdata = {
                owner = ""..xPlayer.discord.name,
                text = text,
                date = os.time(os.date("!*t"))
            }
            MySQL.Async.execute(RaportyInsert, {raportdata.owner, raportdata.text})
            cb(raportdata)
        end
    else
        TriggerEvent("wieczor:Event", source, GetCurrentResourceName(), "touched mdt raport data!")
        DropPlayer(source, "esx_lspdmdt: don't touch this!") 
    end
end)

RegisterServerEvent('esx_lspdmdt:RemoveRaport')
AddEventHandler('esx_lspdmdt:RemoveRaport', function(data)
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)

    if xPlayer ~= nil and xPlayer.job.name == 'police' and xPlayer.job.grade == 1 then
        if(data.fp ~= nil and data.raport ~= nil) then
            MySQL.Async.execute(RaportDelete, {data.fp, data.raport})
        end

    else 
        TriggerEvent("wieczor:Event", source, GetCurrentResourceName(), "tried to remove raport!")
        DropPlayer(_source, "esx_lspdmdt: don't touch this!") -- Trigger do esx_lspdmdt: don't touch this!a
    end
end)

ESX.RegisterServerCallback('esx_lspdmdt:PersonMoreInfo', function(source, cb, data)
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)

    if xPlayer ~= nil and xPlayer.job.name == 'police' then
        local identifier = data.identifier
        local vehdata = {}
        MySQL.Async.fetchAll(VehiclesByIdentifier, {identifier}, function(result)
            for k,v in pairs(result) do
                local vehicle = json.decode(v.vehicle)
                table.insert(vehdata, {
                    model = vehicle.model,
                    plate = v.plate
                })
            end
        end)
        TriggerEvent('esx_license:getLicenses', {identifier = identifier}, function(tempdata)
            if tempdata then
                licenses = tempdata
            end
        end)
        local houses = {}
        
        local temphouse = {}
        local moreinfodata = {
            mandaty = MySQL.Sync.fetchAll(JudgmentsSelect, {identifier}),
            poszukiwania = MySQL.Sync.fetchAll(PoszukiwaniaSelect, {identifier}),
            pojadzy = vehdata,
            mieszkania = temphouse,
            notatki = MySQL.Sync.fetchAll(KartotekaNotatkiSelect, {identifier}),
            licenses = licenses
        }
        cb(moreinfodata)
    else
        DropPlayer(source, "esx_lspdmdt: don't touch this!") 
    end
end)

ESX.RegisterServerCallback('esx_lspdmdt:AddPoszukiwaniaKartoteka', function(source, cb, data)
    local xPlayer = ESX.GetPlayerFromId(source)
    if xPlayer ~= nil and xPlayer.job.name == 'police' then
        local identifier = data.identifier
        local poszukiwaniadata = {
            reason = data.reasonarea,
            fp = ""..xPlayer.discord.name,
            date = os.time(os.date("!*t"))
        }
        cb(poszukiwaniadata)
        MySQL.Async.execute(PoszukiwaniaInsert, {identifier, poszukiwaniadata.fp, poszukiwaniadata.reason})
    else
        TriggerEvent("wieczor:Event", source, GetCurrentResourceName(), "tried to add poszukiwania kartoteka!")
        DropPlayer(source, "esx_lspdmdt: don't touch this!") 
    end
end)

ESX.RegisterServerCallback('esx_lspdmdt:AddNotatkaKartoteka', function(source, cb, data)
    local xPlayer = ESX.GetPlayerFromId(source)
    if xPlayer ~= nil and xPlayer.job.name == 'police' then
        local identifier = data.identifier
        local notedata = {
            notatka = data.note,
            fp = ""..xPlayer.discord.name,
            date = os.time(os.date("!*t"))
        }
        cb(notedata)
        MySQL.Async.execute(KartotekaNotatkiInsert, {identifier, notedata.notatka, notedata.fp})
    else
        TriggerEvent("wieczor:Event", source, GetCurrentResourceName(), "tried to add notatka kartoteka!")
        DropPlayer(source, "esx_lspdmdt: don't touch this!") 
    end

end)


RegisterServerEvent('esx_lspdmdt:licencjaDodaj')
AddEventHandler('esx_lspdmdt:licencjaDodaj', function(data)
    local _source = source
    local identifier = data.identifier
    local xPlayer = ESX.GetPlayerFromId(_source)
	local xTarget = ESX.GetPlayerFromIdentifier(identifier)
    if xPlayer ~= nil and xPlayer.job.name == 'police' then
        if xTarget ~= nil then
            TriggerEvent('esx_license:addLicense', xTarget.source, data.type, function()
                --log
                xTarget.showNotification('Otrzymałeś licencje: ' .. changekLicenseName(data.type))
            end)
        else
            TriggerEvent('esx_license:addLicense', {identifier = identifier}, data.type, function()
                --log
            end)
        end
    else
        TriggerEvent("wieczor:Event", source, GetCurrentResourceName(), "tried to add licencja!")
        DropPlayer(source, "esx_lspdmdt: don't touch this!") 
    end
end)

RegisterServerEvent('esx_lspdmdt:licencjaUsun')
AddEventHandler('esx_lspdmdt:licencjaUsun', function(data)
    local _source = source
    local identifier = data.identifier
    local xPlayer = ESX.GetPlayerFromId(_source)
	local xTarget = ESX.GetPlayerFromIdentifier(identifier)
    if xPlayer ~= nil and xPlayer.job.name == 'police' then
        if xTarget ~= nil then
            TriggerEvent('esx_license:removeLicense', xTarget.source, data.type, function()			
                --log
                xTarget.showNotification('Straciłeś licencje: ' .. changekLicenseName(data.type))
            end)
        else
            TriggerEvent('esx_license:removeLicense', {identifier = identifier}, data.type, function()
                --log
            end)
        end	
    else
        TriggerEvent("wieczor:Event", source, GetCurrentResourceName(), "tried to remove licencja!")
        DropPlayer(source, "esx_lspdmdt: don't touch this!") 
    end
end)

RegisterServerEvent('esx_lspdmdt:RemoveMandatKartoteka')
AddEventHandler('esx_lspdmdt:RemoveMandatKartoteka', function(data)
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)

    if xPlayer ~= nil and xPlayer.job.name == 'police' then
        local id = data.id
        local identifier = data.identifier
        MySQL.Async.execute(JudgmentsDelete, {id, identifier})
    else
        TriggerEvent("wieczor:Event", source, GetCurrentResourceName(), "tried to remove mandat kartoteka!")
        DropPlayer(source, "esx_lspdmdt: don't touch this!") 
    end
end)

RegisterServerEvent('esx_lspdmdt:RemovePoszukiwaniaKartoteka')
AddEventHandler('esx_lspdmdt:RemovePoszukiwaniaKartoteka', function(data)
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)

    if xPlayer ~= nil and xPlayer.job.name == 'police' then
        local identifier = data.identifier
        local reason = data.reason
        MySQL.Async.execute(PoszukiwaniaDelete, {identifier, reason})
    else
        TriggerEvent("wieczor:Event", source, GetCurrentResourceName(), "tried to remove poszukiwania kartoteka!")
        DropPlayer(source, "esx_lspdmdt: don't touch this!") 
    end
end)

RegisterServerEvent('esx_lspdmdt:RemoveNotatkiKartoteka')
AddEventHandler('esx_lspdmdt:RemoveNotatkiKartoteka', function(data)
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)

    if xPlayer ~= nil and xPlayer.job.name == 'police' then
        local identifier = data.identifier
        local note = data.note

        MySQL.Async.execute(KartotekaNotatkiDelete, {identifier, note})
    else
        TriggerEvent("wieczor:Event", source, GetCurrentResourceName(), "tried to remove notatki kartoteka!")
        DropPlayer(source, "esx_lspdmdt: don't touch this!") 
    end

end)

function changekLicenseName(licencja)
	local name = "";
	if(licencja == "drive_bike" ) then
		name = "prawo jazdy kat. A"
		return name
	elseif (licencja == "drive" ) then
		name = "prawo jazdy kat. B"
		return name
	elseif (licencja == "drive_truck" ) then
		name = "prawo jazdy kat. C"
		return name
	elseif (licencja == "weapon" ) then
		name = "licencję na broń krótką"
		return name
	elseif (licencja == 'test_psycho') then
		name = "Test psychologiczny:"
		return name		
	end
end