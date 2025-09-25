-- local HasAlreadyEnteredMarker, IsInShopMenu = false, false
-- local CurrentAction, CurrentActionMsg, LastZone, currentDisplayVehicle, CurrentVehicleData
-- local CurrentActionData, Vehicles, Categories = {}, {}, {}

-- local NumberCharset = {}
-- local Charset = {}

-- for i = 48,  57 do table.insert(NumberCharset, string.char(i)) end

-- for i = 65,  90 do table.insert(Charset, string.char(i)) end
-- for i = 97, 122 do table.insert(Charset, string.char(i)) end

-- function GeneratePlate()
-- 	local generatedPlate
-- 	local doBreak = false

-- 	while true do
-- 		Wait(0)
-- 		math.randomseed(GetGameTimer())
-- 		if Config['skleplimitki'].PlateUseSpace then
-- 			generatedPlate = string.upper(GetRandomLetter(Config['skleplimitki'].PlateLetters) .. ' ' .. GetRandomNumber(Config['skleplimitki'].PlateNumbers))
-- 		else
-- 			generatedPlate = string.upper(GetRandomLetter(Config['skleplimitki'].PlateLetters) .. GetRandomNumber(Config['skleplimitki'].PlateNumbers))
-- 		end

-- 		ESX.TriggerServerCallback('non-skleplimitki:isPlateTaken', function(isPlateTaken)
-- 			if not isPlateTaken then
-- 				doBreak = true
-- 			end
-- 		end, generatedPlate)

-- 		if doBreak then
-- 			break
-- 		end
-- 	end

-- 	return generatedPlate
-- end

-- -- mixing async with sync tasks
-- function IsPlateTaken(plate)
-- 	local callback = 'waiting'

-- 	ESX.TriggerServerCallback('non-skleplimitki:isPlateTaken', function(isPlateTaken)
-- 		callback = isPlateTaken
-- 	end, plate)

-- 	while type(callback) == 'string' do
-- 		Wait(0)
-- 	end

-- 	return callback
-- end

-- function GetRandomNumber(length)
-- 	Wait(0)
-- 	if length > 0 then
-- 		return GetRandomNumber(length - 1) .. NumberCharset[math.random(1, #NumberCharset)]
-- 	else
-- 		return ''
-- 	end
-- end

-- function GetRandomLetter(length)
-- 	Wait(0)
-- 	if length > 0 then
-- 		return GetRandomLetter(length - 1) .. Charset[math.random(1, #Charset)]
-- 	else
-- 		return ''
-- 	end
-- end

-- exports('GeneratePlate', GeneratePlate)

-- function getVehicleFromModel(model)
-- 	for i = 1, #Vehicles do
-- 		local vehicle = Vehicles[i]
-- 		if vehicle.model == model then
-- 			return vehicle
-- 		end
-- 	end
-- end

-- function getVehicles()
-- 	ESX.TriggerServerCallback('non-skleplimitki:getCategories', function(categories)
-- 		Categories = categories
-- 	end)

-- 	ESX.TriggerServerCallback('non-skleplimitki:getVehicles', function(vehicles)
-- 		Vehicles = vehicles
-- 	end)
-- end

-- RegisterNetEvent('esx:playerLoaded')
-- AddEventHandler('esx:playerLoaded', function(xPlayer)
-- 	ESX.PlayerData = xPlayer

-- 	getVehicles()
-- end)

-- RegisterNetEvent('non-skleplimitki:sendCategories')
-- AddEventHandler('non-skleplimitki:sendCategories', function(categories)
-- 	Categories = categories
-- end)

-- RegisterNetEvent('non-skleplimitki:sendVehicles')
-- AddEventHandler('non-skleplimitki:sendVehicles', function(vehicles)
-- 	Vehicles = vehicles
-- end)

-- function DeleteDisplayVehicleInsideShop()
-- 	local attempt = 0

-- 	if currentDisplayVehicle and DoesEntityExist(currentDisplayVehicle) then
-- 		while DoesEntityExist(currentDisplayVehicle) and not NetworkHasControlOfEntity(currentDisplayVehicle) and attempt < 100 do
-- 			Wait(100)
-- 			NetworkRequestControlOfEntity(currentDisplayVehicle)
-- 			attempt = attempt + 1
-- 		end

-- 		if DoesEntityExist(currentDisplayVehicle) and NetworkHasControlOfEntity(currentDisplayVehicle) then
-- 			ESX.Game.DeleteVehicle(currentDisplayVehicle)
-- 		end
-- 	end
-- end

-- function StartShopRestriction()
-- 	CreateThread(function()
-- 		while IsInShopMenu do
-- 			Wait(0)

-- 			DisableControlAction(0, 75,  true) -- Disable exit vehicle
-- 			DisableControlAction(27, 75, true) -- Disable exit vehicle
-- 		end
-- 	end)
-- end

-- function FormatTime(seconds)
--     local minutes = math.floor(seconds / 60)
--     local remainingSeconds = seconds % 60

--     if minutes == 1 then
--         return string.format("%d minuta %d sekund", minutes, remainingSeconds)
--     elseif minutes > 1 then
--         return string.format("%d minuty %d sekund", minutes, remainingSeconds)
--     else
--         return string.format("%d sekund", remainingSeconds)
--     end
-- end

-- local timer = 180
-- local timerMax = timer
-- local isTesting = false
-- local cenaJazdy = 25000

-- function OpenShopMenulimitki()
-- 	if #Vehicles == 0 then
-- 		print('[non-skleplimitki] [^3ERROR^7] No vehicles found')
-- 		return
-- 	end

-- 	IsInShopMenu = true

-- 	StartShopRestriction()
-- 	ESX.UI.Menu.CloseAll()

-- 	local playerPed = PlayerPedId()

-- 	FreezeEntityPosition(playerPed, true)
-- 	SetEntityVisible(playerPed, false)
-- 	SetEntityCoords(playerPed, Config['skleplimitki'].Zones.ShopInside.Pos)

-- 	local vehiclesByCategory = {}
-- 	local elements           = {}
-- 	local firstVehicleData   = nil

-- 	for i=1, #Categories, 1 do
-- 		vehiclesByCategory[Categories[i].name] = {}
-- 	end

-- 	for i=1, #Vehicles, 1 do
-- 		if IsModelInCdimage(joaat(Vehicles[i].model)) then
-- 			table.insert(vehiclesByCategory[Vehicles[i].category], Vehicles[i])
-- 		else
-- 			print(('[non-skleplimitki] [^3ERROR^7] Vehicle "%s" does not exist'):format(Vehicles[i].model))
-- 		end
-- 	end

-- 	for k,v in pairs(vehiclesByCategory) do
-- 		table.sort(v, function(a, b)
-- 			return a.price < b.price
-- 		end)
-- 	end

-- 	for i=1, #Categories, 1 do
-- 		local category         = Categories[i]
-- 		local categoryVehicles = vehiclesByCategory[category.name]
-- 		local options          = {}

-- 		for j=1, #categoryVehicles, 1 do
-- 			local vehicle = categoryVehicles[j]

-- 			if i == 1 and j == 1 then
-- 				firstVehicleData = vehicle
-- 			end

-- 			table.insert(options, ('%s <span style="color:purple;">%s BON</span>'):format(vehicle.name, ESX.Math.GroupDigits(vehicle.price)))
-- 		end

-- 		table.insert(elements, {
-- 			name    = category.name,
-- 			label   = category.label,
-- 			value   = 0,
-- 			type    = 'slider',
-- 			max     = #Categories[i],
-- 			options = options
-- 		})
-- 	end

-- 	ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'vehicle_shop', {
-- 		title    = 'Auta Limitowane',
-- 		align    = 'center',
-- 		elements = elements
-- 	}, function(data, menu)
-- 		local vehicleData = vehiclesByCategory[data.current.name][data.current.value + 1]

-- 		ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'shop_confirm', {
-- 			title = 'Czy chcesz kupić '..vehicleData.name..' za '..ESX.Math.GroupDigits(vehicleData.price)..' BON?',
-- 			align = 'center',
-- 			elements = {
-- 				{label = 'Tak', value = 'yes'},
-- 				{label = ('Przetestuj <font color=green>'..cenaJazdy..'</font>$'), value = 'test'},
-- 				{label = 'Nie',  value = 'no'}
-- 		}}, function(data2, menu2)
-- 			if data2.current.value == 'test' then
--                 if not isTesting then
--                     menu2.close()
--                     ESX.TriggerServerCallback('non-skleplimitki:payTest', function (status)
--                         if status then
--                             menu.close()
--                             IsInShopMenu = false
--                             DeleteDisplayVehicleInsideShop()
                            
--                             ESX.TriggerServerCallback('non:requestCarSpawn', function(netVehicle)
--                                 if netVehicle then
--                                     local vehicle = NetworkGetEntityFromNetworkId(netVehicle)
--                                     SetVehicleNumberPlateText(vehicle, 'TEST')
--                                     SetVehicleDoorsLocked(vehicle, 4)
                
--                                     isTesting = true
--                                     local notificationTimer = 0
--                                     local remainingTime = timerMax

--                                     ESX.ShowNotification('Rozpoczął się 3 minutowy test pojazdu. Nie opuszczaj pojazdu!', 'info')

--                                     local function Countdown()
--                                         notificationTimer = notificationTimer + 10
--                                         remainingTime = timerMax - notificationTimer

--                                         ESX.ShowNotification('Pozostało Ci ' .. FormatTime(remainingTime) .. ' testu pojazdu.', 'info')

--                                         if not IsPedSittingInAnyVehicle(playerPed) then
--                                             ESX.ShowNotification('Zakończono test, opuściłeś pojazd!', 'info')
--                                             isTesting = false
--                                             remainingTime = 0
--                                             ESX.Game.DeleteVehicle(vehicle)                        
--                                         elseif IsEntityDead(playerPed) then
--                                             ESX.ShowNotification('Zakończono test, zostałeś obezwładniony!', 'info')
--                                             isTesting = false
--                                             remainingTime = 0
--                                             ESX.Game.DeleteVehicle(vehicle)
--                                         elseif remainingTime == 0 then
--                                             ESX.ShowNotification('Zakończono test pojazdu!', 'info')
--                                             isTesting = false
--                                             ESX.Game.DeleteVehicle(vehicle)
--                                             SetEntityCoords(playerPed, Config['skleplimitki'].Zones.ShopEntering.Pos.x, Config['skleplimitki'].Zones.ShopEntering.Pos.y, Config['skleplimitki'].Zones.ShopEntering.Pos.z)
-- 										elseif GetVehicleBodyHealth(vehicle) < 900 then
-- 											ESX.ShowNotification('Zakończono test, uszkodzona karoseria!', 'info')
-- 											isTesting = false
-- 											remainingTime = 0
-- 											ESX.Game.DeleteVehicle(vehicle)
-- 											SetEntityCoords(playerPed, Config['skleplimitki'].Zones.ShopEntering.Pos.x, Config['skleplimitki'].Zones.ShopEntering.Pos.y, Config['skleplimitki'].Zones.ShopEntering.Pos.z)
-- 										else
--                                             SetTimeout(10000, Countdown)
--                                         end
--                                     end

--                                     Countdown()

--                                     FreezeEntityPosition(playerPed, false)
--                                     SetEntityVisible(playerPed, true)
--                                 end
--                             end, vehicleData.model, Config['skleplimitki'].Zones.ShopOutside.Pos, Config['skleplimitki'].Zones.ShopOutside.Heading)
--                         else
--                             ESX.ShowNotification('Nie posiadasz wystarczającej ilości pieniędzy', 'error')
--                         end
--                     end)
--                 end
-- 			elseif data2.current.value == 'yes' then
-- 				local generatedPlate = GeneratePlate()

-- 				ESX.TriggerServerCallback('non-skleplimitki:buyVehicle', function(success)
-- 					if success then
-- 						IsInShopMenu = false
-- 						menu2.close()
-- 						menu.close()
-- 						DeleteDisplayVehicleInsideShop()
						
-- 						ESX.TriggerServerCallback('non:requestCarSpawn', function(netVehicle)
-- 							if netVehicle then
-- 								local vehicle = NetworkGetEntityFromNetworkId(netVehicle)
-- 								SetVehicleNumberPlateText(vehicle, generatedPlate)

-- 								FreezeEntityPosition(playerPed, false)
-- 								SetEntityVisible(playerPed, true)
-- 							end
-- 						end, vehicleData.model, Config['skleplimitki'].Zones.ShopOutside.Pos, Config['skleplimitki'].Zones.ShopOutside.Heading)
-- 					else
-- 						ESX.ShowNotification('Nie posidasz wystarczającej ilości bonów.', 'error')
-- 					end
-- 				end, vehicleData.model, generatedPlate)
-- 			else
-- 				menu2.close()
-- 			end
-- 		end, function(data2, menu2)
-- 			menu2.close()
-- 		end)
-- 	end, function(data, menu)
-- 		menu.close()
-- 		DeleteDisplayVehicleInsideShop()
-- 		local playerPed = PlayerPedId()

-- 		CurrentAction     = 'shop_menu'
-- 		CurrentActionMsg  = 'Wcisnij [E] aby wejść do menu'
-- 		CurrentActionData = {}

-- 		FreezeEntityPosition(playerPed, false)
-- 		SetEntityVisible(playerPed, true)
-- 		SetEntityCoords(playerPed, Config['skleplimitki'].Zones.ShopEntering.Pos)

-- 		IsInShopMenu = false
-- 	end, function(data, menu)
-- 		local vehicleData = vehiclesByCategory[data.current.name][data.current.value + 1]
-- 		local playerPed   = PlayerPedId()

-- 		menu.close()
-- 		DeleteDisplayVehicleInsideShop()
-- 		WaitForVehicleToLoad(vehicleData.model)

-- 		ESX.Game.SpawnLocalVehicle(vehicleData.model, Config['skleplimitki'].Zones.ShopInside.Pos, Config['skleplimitki'].Zones.ShopInside.Heading, function(vehicle)
-- 			currentDisplayVehicle = vehicle
-- 			TaskWarpPedIntoVehicle(playerPed, vehicle, -1)
-- 			FreezeEntityPosition(vehicle, true)
-- 			SetModelAsNoLongerNeeded(vehicleData.model)
-- 			menu.open()
-- 		end)
-- 	end)

-- 	DeleteDisplayVehicleInsideShop()
-- 	WaitForVehicleToLoad(firstVehicleData.model)

-- 	ESX.Game.SpawnLocalVehicle(firstVehicleData.model, Config['skleplimitki'].Zones.ShopInside.Pos, Config['skleplimitki'].Zones.ShopInside.Heading, function(vehicle)
-- 		currentDisplayVehicle = vehicle
-- 		TaskWarpPedIntoVehicle(playerPed, vehicle, -1)
-- 		FreezeEntityPosition(vehicle, true)
-- 		SetModelAsNoLongerNeeded(firstVehicleData.model)
-- 	end)
-- end

-- function WaitForVehicleToLoad(modelHash)
-- 	modelHash = (type(modelHash) == 'number' and modelHash or joaat(modelHash))

-- 	if not HasModelLoaded(modelHash) then
-- 		RequestModel(modelHash)

-- 		BeginTextCommandBusyspinnerOn('STRING')
-- 		AddTextComponentSubstringPlayerName('Pojazd jest w trakcie ładowania, proszę czekać')
-- 		EndTextCommandBusyspinnerOn(4)

-- 		while not HasModelLoaded(modelHash) do
-- 			Wait(0)
-- 			DisableAllControlActions(0)
-- 		end

-- 		BusyspinnerOff()
-- 	end
-- end

-- AddEventHandler('non-skleplimitki:hasEnteredMarker', function(zone)
-- 	if zone == 'ShopEntering' then
-- 		CurrentAction     = 'shop_menu'
-- 		CurrentActionMsg  = 'Wcisnij [E] aby wejść do menu'
-- 		CurrentActionData = {}
-- 	end
-- end)

-- AddEventHandler('non-skleplimitki:hasExitedMarker', function(zone)
-- 	if not IsInShopMenu then
-- 		ESX.UI.Menu.CloseAll()
-- 	end
-- 	ESX.HideUI()
-- 	CurrentAction = nil
-- end)

-- AddEventHandler("onResourceStart", getVehicles)

-- AddEventHandler('onResourceStop', function(resource)
-- 	if resource == GetCurrentResourceName() then
-- 		if IsInShopMenu then
-- 			ESX.UI.Menu.CloseAll()

-- 			local playerPed = PlayerPedId()

-- 			FreezeEntityPosition(playerPed, false)
-- 			SetEntityVisible(playerPed, true)
-- 			SetEntityCoords(playerPed, Config['skleplimitki'].Zones.ShopEntering.Pos)
-- 		end

-- 		DeleteDisplayVehicleInsideShop()
-- 	end
-- end)

-- -- Create Blips
-- CreateThread(function()
-- 	if true then
-- 		local blip = AddBlipForCoord(Config['skleplimitki'].Zones.ShopEntering.Pos)

-- 		SetBlipSprite (blip, 523)
-- 		SetBlipDisplay(blip, 4)
-- 		SetBlipScale  (blip, 0.8)
-- 		SetBlipColour (blip, 5)
-- 		SetBlipAsShortRange(blip, true)

-- 		BeginTextCommandSetBlipName('STRING')
-- 		AddTextComponentSubstringPlayerName('Auta Limitowane')
-- 		EndTextCommandSetBlipName(blip)
-- 	end
-- end)

-- -- Enter / Exit marker events & Draw Markers
-- CreateThread(function()
-- 	while true do
-- 		Wait(0)
-- 		local playerCoords = GetEntityCoords(PlayerPedId())
-- 		local isInMarker, letSleep, currentZone = false, true, nil

-- 		for k,v in pairs(Config['skleplimitki'].Zones) do
-- 			local distance = #(playerCoords - v.Pos)

-- 			if distance < 10 then
-- 				letSleep = false

-- 				if v.Type ~= -1 then
-- 					DrawMarker(27, v.Pos, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 1.5, 1.5, 1.0, 135, 76, 255, 255, false, true, 2, false, nil, nil, false)
-- 				end

-- 				if distance < 1.5 then
-- 					isInMarker, currentZone = true, k
-- 				end
-- 			end
-- 		end

-- 		if (isInMarker and not HasAlreadyEnteredMarker) or (isInMarker and LastZone ~= currentZone) then
-- 			HasAlreadyEnteredMarker, LastZone = true, currentZone
-- 			LastZone = currentZone
-- 			TriggerEvent('non-skleplimitki:hasEnteredMarker', currentZone)
-- 		end

-- 		if not isInMarker and HasAlreadyEnteredMarker then
-- 			HasAlreadyEnteredMarker = false
-- 			TriggerEvent('non-skleplimitki:hasExitedMarker', LastZone)
-- 		end

-- 		if letSleep then
-- 			Wait(500)
-- 		end
-- 	end
-- end)

-- -- Key controls
-- CreateThread(function()
-- 	while true do
-- 		Wait(0)
-- 		if CurrentAction then
-- 			ESX.TextUI(CurrentActionMsg)
-- 			if IsControlJustReleased(0, 38) then
-- 				if CurrentAction == 'shop_menu' then
-- 					OpenShopMenulimitki()
-- 				end
-- 				ESX.HideUI()
-- 				CurrentAction = nil
-- 			end
-- 		else
-- 			Wait(500)
-- 		end
-- 	end
-- end)

