-- local jobTimer = 0
-- local payChecks = {}
-- local routeBlip
-- local takedPlace

-- CreateThread(function()
--     while true do
--         if jobTimer > 0 then
--             jobTimer = jobTimer - 1
--         end
--         Wait(1000)
--     end
-- end)

-- function math.randomchoice(table)
--     local keys = {}
--     for key, value in pairs(table) do
--         keys[#keys+1] = key
--     end
--     local index = keys[math.random(1, #keys)]
--     return table[index]
-- end

-- function math.randomkey(table)
--     local keys = {}
--     for key, value in pairs(table) do
--         keys[#keys+1] = key
--     end
--     local index = keys[math.random(1, #keys)]
--     return index
-- end

-- -- ################################################################ FORKLIFT ######################################################################

-- local forkliftJobStarted = false
-- local currentPalette
-- local drawPaletteMarker = false
-- local drawDeliveryMarker

-- local function getPalletHeight(entity)
--     local min, max = GetModelDimensions(GetEntityModel(entity))
--     return max.z
-- end

-- local function deliverParcel()
--     local place = math.randomchoice(Config['jobs'].forklift.to)
--     RemoveBlip(routeBlip)

--     routeBlip = AddBlipForCoord(place.x, place.y, place.z)
--     SetBlipSprite(routeBlip, 1)
--     SetBlipColour(routeBlip, 2)
--     SetBlipRoute(routeBlip, true)
--     SetBlipRouteColour(routeBlip, 2)
--     PlaySoundFrontend(-1, "WAYPOINT_SET", "HUD_FRONTEND_DEFAULT_SOUNDSET", 1)

--     TriggerEvent('non:showNotification', {
--         type = 'info',
--         title = 'Praca',
--         text = "Dostarcz przesyłkę w wyznaczone miejsce"
--     })

--     drawDeliveryMarker = vector3(place.x, place.y, place.z - 1)

--     while drawDeliveryMarker do
--         local veh = GetVehiclePedIsIn(PlayerPedId(), false)
--         if GetEntityModel(veh) == `forklift2` and GetEntityAttachedTo(currentPalette) == veh then
--             local distance = #(drawDeliveryMarker - GetWorldPositionOfEntityBone(veh, GetEntityBoneIndexByName(veh, "forks_attach")))
--             if distance < 50 then
--                 if distance < 1.5 then
--                     DrawMarker(0, place.x, place.y, place.z+1.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 1.0, 1.0, 0.6, 255, 255, 0, 100, true, true, 2, false, false, false, false)
--                 else
--                     DrawMarker(0, place.x, place.y, place.z+1.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 1.0, 1.0, 0.6, 16, 16, 16, 100, false, true, 2, false, false, false, false)
--                 end
--                 Wait(0)
--             else
--                 Wait(1000)
--             end
--         else
--             Wait(1000)
--         end
--     end
-- end

-- local function newForkliftDelivery()
--     local place = math.randomchoice(Config['jobs'].forklift.from)

--     RemoveBlip(routeBlip)
--     routeBlip = AddBlipForCoord(place.x, place.y, place.z)
--     SetBlipSprite(routeBlip, 1)
--     SetBlipColour(routeBlip, 3)
--     SetBlipRoute(routeBlip, true)
--     SetBlipRouteColour(routeBlip, 3)
--     PlaySoundFrontend(-1, "WAYPOINT_SET", "HUD_FRONTEND_DEFAULT_SOUNDSET", 1)

--     TriggerEvent('non:showNotification', {
--         type = 'info',
--         title = 'Praca',
--         text = "Nowy towar został oznaczony"
--     })

--     local prop = math.randomchoice(Config['jobs'].forklift.props)

--     RequestModel(prop.model)
--     while not HasModelLoaded(prop.model) do
--         Wait(10)
--     end

--     currentPalette = CreateObject(prop.model, place.x, place.y, place.z - 1, false, true, false)
--     SetEntityHeading(currentPalette, place.w)
--     SetModelAsNoLongerNeeded(prop.model)

--     while #(vector3(place.x, place.y, place.z) - GetEntityCoords(PlayerPedId())) > 50 do
--         Wait(250)
--     end

--     drawPaletteMarker = true
--     local showHelp = true
--     local height = getPalletHeight(currentPalette)
--     while drawPaletteMarker do
--         local veh = GetVehiclePedIsIn(PlayerPedId(), false)
--         if veh ~= 0 and GetEntityModel(veh) == `forklift2` then
--             local coords = GetEntityCoords(currentPalette)
--             if #(GetEntityCoords(currentPalette) - GetWorldPositionOfEntityBone(veh, GetEntityBoneIndexByName(veh, "forks_attach"))) < 0.5 then
--                 DrawMarker(0, coords.x, coords.y, coords.z + height + 0.6, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 1.0, 1.0, 0.6, 255, 255, 0, 100, true, true, 2, false, false, false, false)
--                 if showHelp then
--                     showHelp = false
--                     TriggerEvent('non:showNotification', {
--                         type = 'info',
--                         title = 'Praca',
--                         text = "Naciśnij [E], aby podnieść palete"
--                     })
--                 end
--             else
--                 DrawMarker(0, coords.x, coords.y, coords.z + height + 0.6, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 1.0, 1.0, 0.6, 16, 16, 16, 100, false, true, 2, false, false, false, false)
--             end
--             Wait(0)
--         else
--             Wait(1000)
--         end
--     end
-- end

-- local function spawnForklift()
--     jobTimer = 300
--     ESX.TriggerServerCallback("jobs:SpawnVehicle", function(netVehicle)
--         local vehicle = NetworkGetEntityFromNetworkId(netVehicle)
--         forkliftJobStarted = true

--         CreateThread(function()
--             while forkliftJobStarted do
--                 if GetVehiclePedIsIn(PlayerPedId(), false) ~= vehicle then
--                     TriggerEvent('non:showNotification', {
--                         type = 'error',
--                         title = 'Praca',
--                         text = "Masz 5s na powrót do pojazdu"
--                     })
--                     Wait(5000)
--                     if GetVehiclePedIsIn(PlayerPedId(), false) ~= vehicle then
--                         forkliftJobStarted = false
--                         TriggerEvent('non:showNotification', {
--                             type = 'error',
--                             title = 'Praca',
--                             text = "Zlecenie zostało anulowane"
--                         })
--                     end
--                 end
--                 Wait(1000)
--             end
--         end)

--         SetEntityInvincible(vehicle, true)
--         SetVehicleTyresCanBurst(vehicle, false)
--         SetVehicleCanBeVisiblyDamaged(vehicle, false)
--         SetEntityCanBeDamaged(vehicle, false)

--         newForkliftDelivery()
--     end, `forklift2`, Config['jobs'].forklift.vehPos)
-- end

-- NON.RegisterButton("E", function()
--     local veh = GetVehiclePedIsIn(PlayerPedId(), false)
--     if forkliftJobStarted and currentPalette and drawPaletteMarker and veh ~= 0 and GetEntityModel(veh) == `forklift2` and #(GetEntityCoords(currentPalette) - GetWorldPositionOfEntityBone(veh, GetEntityBoneIndexByName(veh, "forks_attach"))) < 0.5 then
--         drawPaletteMarker = false

--         local model = GetEntityModel(currentPalette)
--         local coords = GetEntityCoords(currentPalette)
--         local heading = GetEntityHeading(currentPalette)

--         DeleteObject(currentPalette)
--         Wait(100)
--         for _, obj in pairs(GetGamePool('CObject')) do
-- 			if #(coords - GetEntityCoords(obj)) < 2.5 then
--                 DeleteObject(obj)
--             end
-- 		end

--         ESX.TriggerServerCallback("jobs:SpawnObj", function(obj)
--             currentPalette = NetworkGetEntityFromNetworkId(obj)
--             Wait(250)
--             local offset
--             local offsetHeading = GetEntityHeading(currentPalette) - GetEntityHeading(veh)
--             for i = 1, #Config['jobs'].forklift.props do
--                 if Config['jobs'].forklift.props[i].model == model then
--                     offset = Config['jobs'].forklift.props[i].offsets
--                 end
--             end

--             CreateThread(function()
--                 for i = 1, 40 do
--                     if GetEntityAttachedTo(currentPalette) ~= veh then
--                         AttachEntityToEntity(currentPalette, veh, GetEntityBoneIndexByName(veh, "forks_attach"), offset.x, offset.y, offset.z, 0.0, 0.0, offsetHeading, false, false, false, false, 0.0, true)
--                     end
--                     Wait(100)
--                 end
--             end)

--             deliverParcel()
--         end, model, coords, heading)
--     elseif forkliftJobStarted and currentPalette and drawDeliveryMarker and veh ~= 0 and GetEntityModel(veh) == `forklift2` and GetEntityAttachedTo(currentPalette) == veh and #(drawDeliveryMarker - GetWorldPositionOfEntityBone(veh, GetEntityBoneIndexByName(veh, "forks_attach"))) < 1.5 then
--         drawDeliveryMarker = nil
--         DetachEntity(currentPalette, true, true)
--         TriggerServerEvent("jobs:RemoveEntityFromWhiteList", NetworkGetNetworkIdFromEntity(currentPalette))
--         Wait(3000)
--         DeleteObject(currentPalette)
--         currentPalette = nil

--         local salary = math.random(Config['jobs'].forklift.salary[1], Config['jobs'].forklift.salary[2])

--         payChecks[#payChecks+1] = salary

--         RemoveBlip(routeBlip)

--         routeBlip = AddBlipForCoord(Config['jobs'].forklift.vehPos.x, Config['jobs'].forklift.vehPos.y, Config['jobs'].forklift.vehPos.z)
--         SetBlipSprite(routeBlip, 1)
--         SetBlipColour(routeBlip, 1)
--         SetBlipRoute(routeBlip, true)
--         SetBlipRouteColour(routeBlip, 1)
--         PlaySoundFrontend(-1, "WAYPOINT_SET", "HUD_FRONTEND_DEFAULT_SOUNDSET", 1)


--         TriggerEvent('non:showNotification', {
--             type = 'success',
--             title = 'Praca',
--             text = "Dostarczono przesyłkę na wyznaczone miejsce, zarobiłeś: "..salary.."$"
--         })
--         TriggerEvent('non:showNotification', {
--             type = 'info',
--             title = 'Praca',
--             text = "Odstaw wózek widłowy, lub naciśnij [E] aby kontynuować"
--         })

--     elseif forkliftJobStarted and currentPalette == nil and veh ~= 0 and GetEntityModel(veh) == `forklift2` and not drawDeliveryMarker and not drawPaletteMarker then
--         Wait(500)
--         if forkliftJobStarted then
--             newForkliftDelivery()
--         end
--     end
-- end)

-- NON.RegisterPlace(Config['jobs'].forklift.startPos, {}, "rozpocząć pracę", function()
--     if forkliftJobStarted then
--         TriggerEvent('non:showNotification', {
--             type = 'error',
--             title = 'Praca',
--             text = "Rozpocząłeś już prace"
--         })
--     elseif jobTimer > 0 then
--         TriggerEvent('non:showNotification', {
--             type = 'error',
--             title = 'Praca',
--             text = "Nie możesz tak szybko rozpocząć kolejnej pracy, zostało: "..jobTimer.."s"
--         })
--     else
--         spawnForklift()
--     end
-- end)

-- NON.RegisterPlace(Config['jobs'].forklift.vehPos, {size = vector3(4.5, 4.5, 1.0)}, nil, function()
--     local veh = GetVehiclePedIsIn(PlayerPedId(), false)
--     if veh ~= 0 and GetEntityModel(veh) == `forklift2` then
--         RemoveBlip(routeBlip)
--         DeleteVehicle(veh)
--         forkliftJobStarted = false
--         DeleteObject(currentPalette)
--         if #payChecks > 0 then
--             ESX.TriggerServerCallback("jobs:getReward", function()
--             end, "Wózek widłowy", payChecks)
--             payChecks = {}
--         end
--     else
--         TriggerEvent('non:showNotification', {
--             type = 'error',
--             title = 'Praca',
--             text = "Nie jesteś w właściwym pojeździe"
--         })
--     end
-- end,
-- function ()
--     ESX.HideUI()
-- end,
-- function ()
--     ESX.TextUI("Naciśnij [E], aby schować wózek i odebrać wypłate")
-- end)

-- CreateThread(function ()
--     local blip = AddBlipForCoord(Config['jobs'].forklift.startPos)

--     SetBlipSprite (blip, 527)
--     SetBlipColour(blip, 5)
-- 	SetBlipAsShortRange(blip, true)

-- 	BeginTextCommandSetBlipName('STRING')
-- 	AddTextComponentSubstringPlayerName('Praca: Wózek widłowy')
-- 	EndTextCommandSetBlipName(blip)

--     RequestModel(`s_m_y_construct_02`)
--     while not HasModelLoaded(`s_m_y_construct_02`) do
--         Wait(10)
--     end

--     local ped = CreatePed(1, `s_m_y_construct_02`, Config['jobs'].forklift.startPos, false, true)
--     FreezeEntityPosition(ped, true)
--     SetEntityInvincible(ped, true)
--     SetBlockingOfNonTemporaryEvents(ped, true)
--     SetPedCanRagdollFromPlayerImpact(ped, false)
--     SetModelAsNoLongerNeeded(`s_m_y_construct_02`)
-- end)

-- -- ################################################################ TRUCKER ######################################################################
-- local truckerJobStarted = false
-- local truckerDelivery = false
-- local haltMarker = false

-- local function trailerMarkerLoop(truck, trailer)
--     local markerFix = GetEntityModel(trailer) == `docktrailer` or GetEntityModel(trailer) ==  `tr4`
--     while truckerDelivery do
--         local isConnected, connectedTrailer = GetVehicleTrailerVehicle(truck)

--         if isConnected and connectedTrailer == trailer then
--             Wait(250)
--         else
--             Wait(0)

--             local coords = GetEntityCoords(trailer)
--             local rot = GetEntityRotation(trailer)
--             if not haltMarker then
--                 if markerFix then
--                     DrawMarker(43, coords.x, coords.y, coords.z - 2.5,  0.0, 0.0, 0.0, rot.x, rot.y, rot.z, 4.5, 14.0, 2.5, 255, 255, 0, 100, true, false, 2, false, false, false, false)
--                 else
--                     DrawMarker(43, coords.x, coords.y, coords.z - 3.5,  0.0, 0.0, 0.0, rot.x, rot.y, rot.z, 4.5, 14.0, 2.5, 255, 255, 0, 100, true, false, 2, false, false, false, false)
--                 end
--             end
--         end
--     end
-- end

-- local function deliverTrailer(toCoords, truck, trailer, type)
--     routeBlip = AddBlipForCoord(toCoords.x, toCoords.y, toCoords.z)
--     SetBlipSprite(routeBlip, 1)
--     SetBlipColour(routeBlip, 2)
--     SetBlipRoute(routeBlip, true)
--     SetBlipRouteColour(routeBlip, 2)
--     PlaySoundFrontend(-1, "WAYPOINT_SET", "HUD_FRONTEND_DEFAULT_SOUNDSET", 1)

--     if type and type == "tanker" then
--         TriggerEvent('non:showNotification', {
--             type = 'info',
--             title = 'Praca',
--             text = "Odstaw naczepe w wyznaczone miejsce"
--         })
--     else
--         TriggerEvent('non:showNotification', {
--             type = 'info',
--             title = 'Praca',
--             text = "Dostarcz ładunek w wyznaczone miejsce"
--         })
--     end

--     Wait(5000)

--     local routeLength = GetGpsBlipRouteLength() / 1000
--     if type and type == "special" then
--         routeLength = routeLength * 2
--     end

--     while #(GetEntityCoords(truck) - vector3(toCoords.x, toCoords.y, toCoords.z)) > 100 do
--         Wait(250)
--     end

--     local showHelp = true
--     while truckerDelivery do
--         if #(vector3(toCoords.x, toCoords.y, toCoords.z) - GetEntityCoords(trailer)) < 3.0 then
--             DrawMarker(43, toCoords.x, toCoords.y, toCoords.z - 1.5,  0.0, 0.0, 0.0, 0.0, 0.0, toCoords.w, 4.5, 14.0, 2.5, 255, 255, 0, 100, true, false, 2, false, false, false, false)
--             if showHelp then
--                 showHelp = false
--                 TriggerEvent('non:showNotification', {
--                     type = 'info',
--                     title = 'Praca',
--                     text = "Przytrzymaj [H], aby odczepić ładunek"
--                 })
--             elseif not IsVehicleAttachedToTrailer(truck) then
--                 truckerDelivery = false
--                 local salary = math.ceil(routeLength * math.random(Config['jobs'].trucker.salary[1], Config['jobs'].trucker.salary[2]))

--                 payChecks[#payChecks+1] = salary

--                 RemoveBlip(routeBlip)

--                 routeBlip = AddBlipForCoord(Config['jobs'].trucker.vehPos.x, Config['jobs'].trucker.vehPos.y, Config['jobs'].trucker.vehPos.z)
--                 SetBlipSprite(routeBlip, 1)
--                 SetBlipColour(routeBlip, 1)
--                 SetBlipRoute(routeBlip, true)
--                 SetBlipRouteColour(routeBlip, 1)
--                 PlaySoundFrontend(-1, "WAYPOINT_SET", "HUD_FRONTEND_DEFAULT_SOUNDSET", 1)


--                 TriggerEvent('non:showNotification', {
--                     type = 'success',
--                     title = 'Praca',
--                     text = "Dostarczono ładunek na wyznaczone miejsce, zarobiłeś: "..salary.."$"
--                 })
--                 TriggerEvent('non:showNotification', {
--                     type = 'info',
--                     title = 'Praca',
--                     text = "Odstaw ciągnik, lub naciśnij [E] aby kontynuować"
--                 })

--                 ESX.TriggerServerCallback("jobs:freeUpPlace", function()
--                 end, takedPlace)

--                 FreezeEntityPosition(trailer, true)
--                 TriggerServerEvent("jobs:RemoveEntityFromWhiteList", NetworkGetNetworkIdFromEntity(trailer))
--                 Wait(10*1000)
--                 DeleteVehicle(trailer)
--             end
--         else
--             DrawMarker(43, toCoords.x, toCoords.y, toCoords.z - 1.5,  0.0, 0.0, 0.0, 0.0, 0.0, toCoords.w, 4.5, 14.0, 2.5, 16, 16, 16, 100, false, false, 2, false, false, false, false)
--         end
--         Wait(0)
--     end
-- end

-- local function deliverTanker(truck, trailer, deliveries)
--     local isFree
--     local toCoords

--     while true do
--         isFree = nil
--         local gasStations = Config['jobs'].trucker.missions.tanker.to

--         local deliveryMissionKey = math.randomkey(gasStations)
--         local preTakedPlace = "truckertankerto"..deliveryMissionKey

--         while preTakedPlace == takedPlace do
--             deliveryMissionKey = math.randomkey(gasStations)
--             preTakedPlace = "truckertankerto"..deliveryMissionKey
--             Wait(0)
--         end

--         ESX.TriggerServerCallback("jobs:isPlaceTaked", function(bool)
--             isFree = bool
--         end, "truckertankerto"..deliveryMissionKey)

--         while isFree == nil do
--             Wait(50)
--         end

--         if isFree then
--             toCoords = gasStations[deliveryMissionKey]
--             takedPlace = "truckertankerto"..deliveryMissionKey
--             break
--         end
--         Wait(0)
--     end

--     routeBlip = AddBlipForCoord(toCoords.x, toCoords.y, toCoords.z)
--     SetBlipSprite(routeBlip, 1)
--     SetBlipColour(routeBlip, 2)
--     SetBlipRoute(routeBlip, true)
--     SetBlipRouteColour(routeBlip, 2)
--     PlaySoundFrontend(-1, "WAYPOINT_SET", "HUD_FRONTEND_DEFAULT_SOUNDSET", 1)

--     TriggerEvent('non:showNotification', {
--         type = 'info',
--         title = 'Praca',
--         text = "Następna stacja został oznaczona"
--     })

--     Wait(5000)

--     local routeLength = (GetGpsBlipRouteLength() / 1000) * 0.75

--     while #(GetEntityCoords(truck) - vector3(toCoords.x, toCoords.y, toCoords.z)) > 100 do
--         Wait(250)
--     end

--     local showHelp = true

--     while true do
--         local isConnected, connectedTrailer = GetVehicleTrailerVehicle(truck)

--         if #(vector3(toCoords.x, toCoords.y, toCoords.z) - GetEntityCoords(trailer)) < 3.0 then
--             DrawMarker(43, toCoords.x, toCoords.y, toCoords.z - 1.5,  0.0, 0.0, 0.0, 0.0, 0.0, toCoords.w, 4.5, 14.0, 2.5, 255, 255, 0, 100, true, false, 2, false, false, false, false)
--             if showHelp then
--                 showHelp = false
--                 TriggerEvent('non:showNotification', {
--                     type = 'info',
--                     title = 'Praca',
--                     text = "Naciśnij [E], aby przepompować część paliwa"
--                 })
--             elseif isConnected and IsControlJustReleased(0, 38) and connectedTrailer == trailer then

--                 RemoveBlip(routeBlip)

--                 ESX.TriggerServerCallback("jobs:freeUpPlace", function()
--                 end, takedPlace)

--                 FreezeEntityPosition(truck, true)
--                 showProgress({title = 'Przepompowywanie paliwa', time = 30*1000}, function(isDone)
--                     FreezeEntityPosition(truck, false)
--                 end)

--                 Wait(31*1000)
--                 break
--             end
--         else
--             DrawMarker(43, toCoords.x, toCoords.y, toCoords.z - 1.5,  0.0, 0.0, 0.0, 0.0, 0.0, toCoords.w, 4.5, 14.0, 2.5, 16, 16, 16, 100, false, false, 2, false, false, false, false)
--         end
--         Wait(0)
--     end

--     local salary = math.ceil(routeLength * math.random(Config['jobs'].trucker.salary[1], Config['jobs'].trucker.salary[2]))
--     payChecks[#payChecks+1] = salary

--     if deliveries > 0 then
--         TriggerEvent('non:showNotification', {
--             type = 'success',
--             title = 'Praca',
--             text = "Zakończono przepompowywanie paliwa (zarobiłeś: "..salary.."$), jedź na kolejną stacje"
--         })
--         deliverTanker(truck, trailer, deliveries - 1)
--     else
--         local missionKey
--         while true do
--             isFree = nil
--             missionKey = math.randomkey(Config['jobs'].trucker.missions.tanker.from)
--             ESX.TriggerServerCallback("jobs:isPlaceTaked", function(bool)
--                 isFree = bool
--             end, "truckertankerfrom"..missionKey)

--             while isFree == nil do
--                 Wait(50)
--             end

--             if isFree then
--                 toCoords = Config['jobs'].trucker.missions.tanker.from[missionKey]
--                 takedPlace = "truckertankerfrom"..missionKey
--                 break
--             end
--             Wait(0)
--         end
--         deliverTrailer(toCoords, truck, trailer, "tanker")
--     end
-- end

-- local function newTruckerDelivery(truck)
--     RemoveBlip(routeBlip)
--     truckerDelivery = true
--     local type = math.randomchoice({"classic", "classic", "classic", "classic", "classic", "classic", "tanker", "tanker", "tanker", "special"})
--     local missions = Config['jobs'].trucker.missions[type]

--     TriggerEvent('non:showNotification', {
--         type = 'info',
--         title = 'Praca',
--         text = "Wyszukiwanie zlecenia..."
--     })

--     Wait(5000)
--     local isFree
--     local missionKey

--     local fromCoords
--     local toCoords
--     local trailerModel

--     if type == "classic" then
--         while true do
--             isFree = nil
--             missionKey = math.randomkey(missions)
--             ESX.TriggerServerCallback("jobs:isPlaceTaked", function(bool)
--                 isFree = bool
--             end, "trucker"..type..missionKey)

--             while isFree == nil do
--                 Wait(250)
--             end

--             if isFree then
--                 fromCoords = missions[missionKey]
--                 takedPlace = "trucker"..type..missionKey
--                 trailerModel = math.randomchoice({`tvtrailer`, `trailers`, `trailers2`, `trailers3`, `trailers4`, `trailers`, `trailers2`, `trailers3`, `trailers4`})
--                 break
--             end
--             Wait(0)
--         end
--     elseif type == "tanker" then
--         while true do
--             isFree = nil
--             missionKey = math.randomkey(missions.from)
--             ESX.TriggerServerCallback("jobs:isPlaceTaked", function(bool)
--                 isFree = bool
--             end, "trucker"..type.."from"..missionKey)

--             while isFree == nil do
--                 Wait(250)
--             end

--             if isFree then
--                 fromCoords = missions.from[missionKey]
--                 takedPlace = "trucker"..type.."from"..missionKey
--                 trailerModel = math.randomchoice({`tanker`, `tanker`, `tanker`, `tanker`, `tanker2`})
--                 break
--             end
--             Wait(0)
--         end
--     elseif type == "special" then
--         while true do
--             isFree = nil
--             missionKey = math.randomkey(missions)
--             ESX.TriggerServerCallback("jobs:isPlaceTaked", function(bool)
--                 isFree = bool
--             end, "trucker"..type..missionKey)

--             while isFree == nil do
--                 Wait(250)
--             end

--             if isFree then
--                 fromCoords = missions[missionKey].from
--                 toCoords = missions[missionKey].to
--                 takedPlace = "trucker"..type..missionKey
--                 trailerModel = missions[missionKey].model
--                 break
--             end
--             Wait(0)
--         end
--     end

--     if GetVehiclePedIsIn(PlayerPedId(), false) ~= truck then
--         return
--     end

--     routeBlip = AddBlipForCoord(fromCoords.x, fromCoords.y, fromCoords.z)
--     SetBlipSprite(routeBlip, 1)
--     SetBlipColour(routeBlip, 3)
--     SetBlipRoute(routeBlip, true)
--     SetBlipRouteColour(routeBlip, 3)
--     PlaySoundFrontend(-1, "WAYPOINT_SET", "HUD_FRONTEND_DEFAULT_SOUNDSET", 1)

--     if type == "special" then
--         TriggerEvent('non:showNotification', {
--             type = 'info',
--             title = 'Praca',
--             text = "Specialne zlecenie został oznaczone (Kasa x2)"
--         })
--     else
--         TriggerEvent('non:showNotification', {
--             type = 'info',
--             title = 'Praca',
--             text = "Zlecenie został oznaczone"
--         })
--     end


--     while #(vector3(fromCoords.x, fromCoords.y, fromCoords.z) - GetEntityCoords(PlayerPedId())) > 100 do
--         Wait(250)
--     end

--     ESX.TriggerServerCallback("jobs:SpawnTrailer", function(netTrailer)
--         local trailer = NetworkGetEntityFromNetworkId(netTrailer)

--         SetEntityInvincible(trailer, true)
--         SetVehicleTyresCanBurst(trailer, false)
--         SetVehicleCanBeVisiblyDamaged(trailer, false)
--         SetEntityCanBeDamaged(trailer, false)

--         CreateThread(function()
--             while truckerDelivery do
--                 local roll = GetEntityRoll(trailer)
-- 				if not IsVehicleAttachedToTrailer(truck) and (roll > 30.0 or roll < -30.0) and GetEntitySpeed(trailer) < 2 then
--                     local coords = GetEntityCoords(trailer)
--                     SetEntityCoords(trailer, coords.x, coords.y, coords.z + 1.0)
--                     local rot = GetEntityRotation(trailer)
--                     SetEntityRotation(trailer, 0.0, 0.0, rot.z, 2, true)
-- 				end

--                 for _ = 1, 20 do
--                     if not IsVehicleAttachedToTrailer(truck) and (roll > 30.0 or roll < -30.0) then
--                         haltMarker = true
--                     else
--                         haltMarker = false
--                     end
--                     Wait(50)
--                 end
--             end
--         end)

--         local markerFix = GetEntityModel(trailer) == `docktrailer` or GetEntityModel(trailer) ==  `tr4`
--         while true do
--             local isConnected, connectedTrailer = GetVehicleTrailerVehicle(truck)

--             if isConnected and connectedTrailer == trailer then
--                 break
--             else
--                 local coords = GetEntityCoords(trailer)
--                 local rot = GetEntityRotation(trailer)
--                 if markerFix then
--                     DrawMarker(43, coords.x, coords.y, coords.z - 2.5,  0.0, 0.0, 0.0, rot.x, rot.y, rot.z, 4.5, 14.0, 2.5, 255, 255, 0, 100, true, false, 2, false, false, false, false)
--                 else
--                     DrawMarker(43, coords.x, coords.y, coords.z - 3.5,  0.0, 0.0, 0.0, rot.x, rot.y, rot.z, 4.5, 14.0, 2.5, 255, 255, 0, 100, true, false, 2, false, false, false, false)
--                 end
--             end
--             Wait(0)
--         end

--         RemoveBlip(routeBlip)

--         ESX.TriggerServerCallback("jobs:freeUpPlace", function()
--         end, takedPlace)

--         CreateThread(function()
--             if type == "classic" then
--                 while true do
--                     isFree = nil
--                     local deliveryMissionKey = math.randomkey(missions)

--                     while deliveryMissionKey == missionKey do
--                         deliveryMissionKey = math.randomkey(missions)
--                         Wait(0)
--                     end

--                     ESX.TriggerServerCallback("jobs:isPlaceTaked", function(bool)
--                         isFree = bool
--                     end, "trucker"..type..deliveryMissionKey)

--                     while isFree == nil do
--                         Wait(50)
--                     end

--                     if isFree then
--                         toCoords = missions[deliveryMissionKey]
--                         takedPlace = "trucker"..type..deliveryMissionKey
--                         break
--                     end
--                     Wait(0)
--                 end
--                 deliverTrailer(toCoords, truck, trailer)
--             elseif type == "tanker" then
--                 local deliveries = math.random(2, 5)
--                 deliverTanker(truck, trailer, deliveries)
--             elseif type == "special" then
--                 deliverTrailer(toCoords, truck, trailer, type)
--             end
--         end)
--         trailerMarkerLoop(truck, trailer)
--     end, trailerModel, fromCoords)
-- end

-- NON.RegisterButton("E", function()
--     if truckerJobStarted and not truckerDelivery then
--         newTruckerDelivery(GetVehiclePedIsIn(PlayerPedId(), false))
--     end
-- end)

-- local function spawnTruck()
--     jobTimer = 300
--     ESX.TriggerServerCallback("jobs:SpawnVehicle", function(netVehicle)
--         local vehicle = NetworkGetEntityFromNetworkId(netVehicle)
--         truckerJobStarted = true

--         CreateThread(function()
--             while truckerJobStarted do
--                 if GetVehiclePedIsIn(PlayerPedId(), false) ~= vehicle then
--                     TriggerEvent('non:showNotification', {
--                         type = 'error',
--                         title = 'Praca',
--                         text = "Masz 5s na powrót do pojazdu"
--                     })
--                     Wait(5000)
--                     if GetVehiclePedIsIn(PlayerPedId(), false) ~= vehicle then
--                         truckerJobStarted = false
--                         TriggerEvent('non:showNotification', {
--                             type = 'error',
--                             title = 'Praca',
--                             text = "Zlecenie zostało anulowane"
--                         })
--                     end
--                 end
--                 Wait(1000)
--             end
--         end)

--         SetEntityInvincible(vehicle, true)
--         SetVehicleTyresCanBurst(vehicle, false)
--         SetVehicleCanBeVisiblyDamaged(vehicle, false)
--         SetEntityCanBeDamaged(vehicle, false)

--         newTruckerDelivery(vehicle)
--     end, math.randomchoice(Config['jobs'].trucker.trucks), Config['jobs'].trucker.vehPos)
-- end


-- NON.RegisterPlace(Config['jobs'].trucker.startPos, {}, "rozpocząć pracę", function()
--     if truckerJobStarted then
--         TriggerEvent('non:showNotification', {
--             type = 'error',
--             title = 'Praca',
--             text = "Rozpocząłeś już prace"
--         })
--     elseif jobTimer > 0 then
--         TriggerEvent('non:showNotification', {
--             type = 'error',
--             title = 'Praca',
--             text = "Nie możesz tak szybko rozpocząć kolejnej pracy, zostało: "..jobTimer.."s"
--         })
--     else
--         spawnTruck()
--     end
-- end)

-- NON.RegisterPlace(Config['jobs'].trucker.vehPos, {size = vector3(10.0, 10.0, 1.0)}, nil, function()
--     local veh = GetVehiclePedIsIn(PlayerPedId(), false)
--     local isTruck = false

--     for _, truckModel in ipairs(Config['jobs'].trucker.trucks) do
--         if GetEntityModel(veh) == truckModel then
--             isTruck = true
--         end
--     end

--     if veh ~= 0 and isTruck then
--         RemoveBlip(routeBlip)
--         DeleteVehicle(veh)
--     end

--     if truckerJobStarted then
--         RemoveBlip(routeBlip)
--         truckerJobStarted = false
--         if #payChecks > 0 and payChecks[1] > 0 then
--             ESX.TriggerServerCallback("jobs:getReward", function()
--             end, "Trucker", payChecks)
--             payChecks = {}
--         end
--     else
--         TriggerEvent('non:showNotification', {
--             type = 'error',
--             title = 'Praca',
--             text = "Nie jesteś w właściwym pojeździe"
--         })
--     end
-- end,
-- function ()
--     ESX.HideUI()
-- end,
-- function ()
--     ESX.TextUI("Naciśnij [E], aby schować ciężarówkę i odebrać wypłate")
-- end)

-- CreateThread(function()
--     local blip = AddBlipForCoord(Config['jobs'].trucker.startPos)

--     SetBlipSprite (blip, 477)
--     SetBlipColour(blip, 5)
-- 	SetBlipAsShortRange(blip, true)

-- 	BeginTextCommandSetBlipName('STRING')
-- 	AddTextComponentSubstringPlayerName('Praca: Kierowca ciężarówki')
-- 	EndTextCommandSetBlipName(blip)

--     RequestModel(`s_m_y_dockwork_01`)
--     while not HasModelLoaded(`s_m_y_dockwork_01`) do
--         Wait(10)
--     end

--     local ped = CreatePed(1, `s_m_y_dockwork_01`, Config['jobs'].trucker.startPos, false, true)
--     FreezeEntityPosition(ped, true)
--     SetEntityInvincible(ped, true)
--     SetBlockingOfNonTemporaryEvents(ped, true)
--     SetPedCanRagdollFromPlayerImpact(ped, false)
--     SetModelAsNoLongerNeeded(`s_m_y_dockwork_01`)
-- end)

-- function IsPlayerInAnyJob()
--     return truckerJobStarted or forkliftJobStarted
-- end