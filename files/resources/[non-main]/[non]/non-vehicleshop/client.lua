local HasAlreadyEnteredMarker, IsInShopMenu = false, false
local CurrentAction, CurrentActionMsg, LastZone, currentDisplayVehicle, CurrentVehicleData
local CurrentActionData, Vehicles, Categories = {}, {}, {}

local NumberCharset = {}
local Charset = {}

for i = 48,  57 do table.insert(NumberCharset, string.char(i)) end

for i = 65,  90 do table.insert(Charset, string.char(i)) end
for i = 97, 122 do table.insert(Charset, string.char(i)) end

function GeneratePlate()
	local generatedPlate
	local doBreak = false

	while true do
		Wait(0)
		math.randomseed(GetGameTimer())
		if Config.PlateUseSpace then
			generatedPlate = string.upper(GetRandomLetter(Config.PlateLetters) .. ' ' .. GetRandomNumber(Config.PlateNumbers))
		else
			generatedPlate = string.upper(GetRandomLetter(Config.PlateLetters) .. GetRandomNumber(Config.PlateNumbers))
		end

		ESX.TriggerServerCallback('esx_vehicleshop:isPlateTaken', function(isPlateTaken)
			if not isPlateTaken then
				doBreak = true
			end
		end, generatedPlate)

		if doBreak then
			break
		end
	end

	return generatedPlate
end

-- mixing async with sync tasks
function IsPlateTaken(plate)
	local callback = 'waiting'

	ESX.TriggerServerCallback('esx_vehicleshop:isPlateTaken', function(isPlateTaken)
		callback = isPlateTaken
	end, plate)

	while type(callback) == 'string' do
		Wait(0)
	end

	return callback
end

function GetRandomNumber(length)
	Wait(0)
	if length > 0 then
		return GetRandomNumber(length - 1) .. NumberCharset[math.random(1, #NumberCharset)]
	else
		return ''
	end
end

function GetRandomLetter(length)
	Wait(0)
	if length > 0 then
		return GetRandomLetter(length - 1) .. Charset[math.random(1, #Charset)]
	else
		return ''
	end
end


function getVehicleFromModel(model)
	for i = 1, #Vehicles do
		local vehicle = Vehicles[i]
		if vehicle.model == model then
			return vehicle
		end
	end
end

function getVehicles()
	ESX.TriggerServerCallback('esx_vehicleshop:getCategories', function(categories)
		Categories = categories
	end)

	ESX.TriggerServerCallback('esx_vehicleshop:getVehicles', function(vehicles)
		Vehicles = vehicles
	end)
end

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
	ESX.PlayerData = xPlayer

	getVehicles()
end)

RegisterNetEvent('esx_vehicleshop:sendCategories')
AddEventHandler('esx_vehicleshop:sendCategories', function(categories)
	Categories = categories
end)

RegisterNetEvent('esx_vehicleshop:sendVehicles')
AddEventHandler('esx_vehicleshop:sendVehicles', function(vehicles)
	Vehicles = vehicles
end)

function DeleteDisplayVehicleInsideShop()
	local attempt = 0

	if currentDisplayVehicle and DoesEntityExist(currentDisplayVehicle) then
		while DoesEntityExist(currentDisplayVehicle) and not NetworkHasControlOfEntity(currentDisplayVehicle) and attempt < 100 do
			Wait(100)
			NetworkRequestControlOfEntity(currentDisplayVehicle)
			attempt = attempt + 1
		end

		if DoesEntityExist(currentDisplayVehicle) and NetworkHasControlOfEntity(currentDisplayVehicle) then
			ESX.Game.DeleteVehicle(currentDisplayVehicle)
		end
	end
end

function StartShopRestriction()
	CreateThread(function()
		while IsInShopMenu do
			Wait(0)

			DisableControlAction(0, 75,  true) -- Disable exit vehicle
			DisableControlAction(27, 75, true) -- Disable exit vehicle
		end
	end)
end

function FormatTime(seconds)
    local minutes = math.floor(seconds / 60)
    local remainingSeconds = seconds % 60

    if minutes == 1 then
        return string.format("%d minuta %d sekund", minutes, remainingSeconds)
    elseif minutes > 1 then
        return string.format("%d minuty %d sekund", minutes, remainingSeconds)
    else
        return string.format("%d sekund", remainingSeconds)
    end
end

local timer = 180
local timerMax = timer
local isTesting = false
local cenaJazdy = 5000

function OpenShopMenu()
	if #Vehicles == 0 then
		print('[esx_vehicleshop] [^3ERROR^7] No vehicles found')
		return
	end

	IsInShopMenu = true
	StartShopRestriction()
	ESX.UI.Menu.CloseAll()

	local playerPed = PlayerPedId()

	FreezeEntityPosition(playerPed, true)
	SetEntityVisible(playerPed, false)
	SetEntityCoords(playerPed, Config.Zones.ShopInside.Pos)

	local vehiclesByCategory = {}
	local elements = {}
	local firstVehicleData = nil

	for i=1, #Categories, 1 do
		vehiclesByCategory[Categories[i].name] = {}
	end

	for i=1, #Vehicles, 1 do
		if IsModelInCdimage(joaat(Vehicles[i].model)) then
			table.insert(vehiclesByCategory[Vehicles[i].category], Vehicles[i])
		else
			print(('[esx_vehicleshop] [^3ERROR^7] Vehicle "%s" does not exist'):format(Vehicles[i].model))
		end
	end

	for k,v in pairs(vehiclesByCategory) do
		table.sort(v, function(a, b)
			return a.price < b.price
		end)
	end

	for i=1, #Categories, 1 do
		local category         = Categories[i]
		local categoryVehicles = vehiclesByCategory[category.name]
		local options          = {}

		for j=1, #categoryVehicles, 1 do
			local vehicle = categoryVehicles[j]

			if i == 1 and j == 1 then
				firstVehicleData = vehicle
			end

			table.insert(options, ('%s <span style="color:green;">$%s</span>'):format(vehicle.name, ESX.Math.GroupDigits(vehicle.price)))
		end

		table.insert(elements, {
			name    = category.name,
			label   = category.label,
			value   = 0,
			type    = 'slider',
			max     = #Categories[i],
			options = options
		})
	end

	ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'vehicle_shop', {
		title    = 'Sprzedawca Aut',
		align    = 'center',
		elements = elements
	}, function(data, menu)
		local vehicleData = vehiclesByCategory[data.current.name][data.current.value + 1]

		ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'shop_confirm', {
			title = 'Czy chcesz kupić '..vehicleData.name..' za $'..ESX.Math.GroupDigits(vehicleData.price)..'?',
			align = 'center',
			elements = {
				{label = 'Tak', value = 'yes'},
				{label = ('Przetestuj <font color=green>'..cenaJazdy..'</font>$'), value = 'test'},
				{label = 'Nie',  value = 'no'}
		}}, function(data2, menu2)
			if data2.current.value == 'test' then
                if not isTesting then
                    menu2.close()
                    ESX.TriggerServerCallback('esx_vehicleshop:payTest', function (status)
                        if status then
                            menu.close()
                            IsInShopMenu = false
                            DeleteDisplayVehicleInsideShop()
                            
                            ESX.TriggerServerCallback('non:requestCarSpawn', function(netVehicle)
                                if netVehicle then
                                    local vehicle = NetworkGetEntityFromNetworkId(netVehicle)
                                    SetVehicleNumberPlateText(vehicle, 'TEST')
                                    SetVehicleDoorsLocked(vehicle, 4)
                
                                    isTesting = true
                                    local notificationTimer = 0
                                    local remainingTime = timerMax

                                    ESX.ShowNotification('Rozpoczął się 3 minutowy test pojazdu. Nie opuszczaj pojazdu!', 'info')

                                    local function Countdown()
                                        notificationTimer = notificationTimer + 10
                                        remainingTime = timerMax - notificationTimer

                                        ESX.ShowNotification('Pozostało Ci ' .. FormatTime(remainingTime) .. ' testu pojazdu.', 'info')

                                        if not IsPedSittingInAnyVehicle(playerPed) then
                                            ESX.ShowNotification('Zakończono test, opuściłeś pojazd!', 'info')
                                            isTesting = false
                                            remainingTime = 0
                                            ESX.Game.DeleteVehicle(vehicle)                        
                                        elseif IsEntityDead(playerPed) then
                                            ESX.ShowNotification('Zakończono test, zostałeś obezwładniony!', 'info')
                                            isTesting = false
                                            remainingTime = 0
                                            ESX.Game.DeleteVehicle(vehicle)
                                        elseif remainingTime == 0 then
                                            ESX.ShowNotification('Zakończono test pojazdu!', 'info')
                                            isTesting = false
                                            ESX.Game.DeleteVehicle(vehicle)
                                            SetEntityCoords(playerPed, Config.Zones.ShopEntering.Pos.x, Config.Zones.ShopEntering.Pos.y, Config.Zones.ShopEntering.Pos.z)
										elseif GetVehicleBodyHealth(vehicle) < 900 then
											ESX.ShowNotification('Zakończono test, uszkodzona karoseria!', 'info')
											isTesting = false
											remainingTime = 0
											ESX.Game.DeleteVehicle(vehicle)
											SetEntityCoords(playerPed, Config.Zones.ShopEntering.Pos.x, Config.Zones.ShopEntering.Pos.y, Config.Zones.ShopEntering.Pos.z)
										else
                                            SetTimeout(10000, Countdown)
                                        end
                                    end

                                    Countdown()

                                    FreezeEntityPosition(playerPed, false)
                                    SetEntityVisible(playerPed, true)
                                end
                            end, vehicleData.model, Config.Zones.ShopOutside.Pos, Config.Zones.ShopOutside.Heading)
                        else
                            ESX.ShowNotification('Nie posiadasz wystarczającej ilości pieniędzy', 'error')
                        end
                    end)
                end
			elseif data2.current.value == 'yes' then
				local generatedPlate = GeneratePlate()

				ESX.TriggerServerCallback('esx_vehicleshop:buyVehicle', function(success)
					if success then
						IsInShopMenu = false
						menu2.close()
						menu.close()
						DeleteDisplayVehicleInsideShop()
						
						ESX.TriggerServerCallback('non:requestCarSpawn', function(netVehicle)
							if netVehicle then
								local vehicle = NetworkGetEntityFromNetworkId(netVehicle)
								SetVehicleNumberPlateText(vehicle, generatedPlate)

								FreezeEntityPosition(playerPed, false)
								SetEntityVisible(playerPed, true)
							end
						end, vehicleData.model, Config.Zones.ShopOutside.Pos, Config.Zones.ShopOutside.Heading)
					else
						ESX.ShowNotification('Nie posiadasz wystarczającej ilości pieniędzy', 'error')
					end
				end, vehicleData.model, generatedPlate)
			else
				menu2.close()
			end
		end, function(data2, menu2)
			menu2.close()
		end)
	end, function(data, menu)
		menu.close()
		DeleteDisplayVehicleInsideShop()
		local playerPed = PlayerPedId()

		CurrentAction     = 'shop_menu'
		CurrentActionMsg  = 'Wcisnij [E] aby wejść do menu'
		CurrentActionData = {}

		FreezeEntityPosition(playerPed, false)
		SetEntityVisible(playerPed, true)
		SetEntityCoords(playerPed, Config.Zones.ShopEntering.Pos)

		IsInShopMenu = false
	end, function(data, menu)
		local vehicleData = vehiclesByCategory[data.current.name][data.current.value + 1]
		local playerPed   = PlayerPedId()

		menu.close()
		DeleteDisplayVehicleInsideShop()
		WaitForVehicleToLoad(vehicleData.model)

		ESX.Game.SpawnLocalVehicle(vehicleData.model, Config.Zones.ShopInside.Pos, Config.Zones.ShopInside.Heading, function(vehicle)
			currentDisplayVehicle = vehicle
			TaskWarpPedIntoVehicle(playerPed, vehicle, -1)
			FreezeEntityPosition(vehicle, true)
			SetModelAsNoLongerNeeded(vehicleData.model)
			menu.open()
		end)
	end)

	DeleteDisplayVehicleInsideShop()
	WaitForVehicleToLoad(firstVehicleData.model)

	ESX.Game.SpawnLocalVehicle(firstVehicleData.model, Config.Zones.ShopInside.Pos, Config.Zones.ShopInside.Heading, function(vehicle)
		currentDisplayVehicle = vehicle
		TaskWarpPedIntoVehicle(playerPed, vehicle, -1)
		FreezeEntityPosition(vehicle, true)
		SetModelAsNoLongerNeeded(firstVehicleData.model)
	end)
end

function WaitForVehicleToLoad(modelHash)
	modelHash = (type(modelHash) == 'number' and modelHash or joaat(modelHash))

	if not HasModelLoaded(modelHash) then
		RequestModel(modelHash)

		BeginTextCommandBusyspinnerOn('STRING')
		AddTextComponentSubstringPlayerName('Pojazd jest w trakcie ładowania, proszę czekać')
		EndTextCommandBusyspinnerOn(4)

		while not HasModelLoaded(modelHash) do
			Wait(0)
			DisableAllControlActions(0)
		end

		BusyspinnerOff()
	end
end

AddEventHandler('esx_vehicleshop:hasEnteredMarker', function(zone)
	if zone == 'ShopEntering' then
		CurrentAction     = 'shop_menu'
		CurrentActionMsg  = 'Wcisnij [E] aby wejść do menu'
		CurrentActionData = {}
	end
end)

AddEventHandler('esx_vehicleshop:hasExitedMarker', function(zone)
	if not IsInShopMenu then
		ESX.UI.Menu.CloseAll()
	end
	ESX.HideUI()
	CurrentAction = nil
end)

AddEventHandler("onResourceStart", getVehicles)

AddEventHandler('onResourceStop', function(resource)
	if resource == GetCurrentResourceName() then
		if IsInShopMenu then
			ESX.UI.Menu.CloseAll()

			local playerPed = PlayerPedId()

			FreezeEntityPosition(playerPed, false)
			SetEntityVisible(playerPed, true)
			SetEntityCoords(playerPed, Config.Zones.ShopEntering.Pos)
		end

		DeleteDisplayVehicleInsideShop()
	end
end)

-- Create Blips
CreateThread(function()
	if true then
		local blip = AddBlipForCoord(Config.Zones.ShopEntering.Pos)

		SetBlipSprite (blip, 669)
		SetBlipColour (blip, 0)
		SetBlipDisplay(blip, 4)
		SetBlipScale  (blip, 1.1)
		SetBlipAsShortRange(blip, true)

		BeginTextCommandSetBlipName('STRING')
		AddTextComponentSubstringPlayerName('Sprzedawca Aut')
		EndTextCommandSetBlipName(blip)
	end
end)

NON.RegisterPlace(Config.Zones.ShopEntering.Pos, {size = vec3(2.0, 2.0, .5)}, "kupic auto", function()
	OpenShopMenu()
end,
function()
end)