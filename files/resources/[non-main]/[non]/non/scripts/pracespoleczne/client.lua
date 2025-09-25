local count = 0
local isInCommunityServices, unCommunityServices = false, false
local currentCoords = nil
local currentMarkerID = nil

function generateCoords()
    local isDoingCommunityServices = false
    if count <= 0 then
        if currentMarkerID then
            currentMarkerID()
            currentMarkerID = nil
        end
        return TriggerServerEvent("_prace:unCommunityService")
    else
        if currentMarkerID then
            currentMarkerID()
            currentMarkerID = nil
        end
        currentCoords = Config["prace"].PraceSpoleczne[math.random(1, #Config["prace"].PraceSpoleczne)]
        currentMarkerID = NON.RegisterPlace(currentCoords, {size = vector3(5.0, 5.0, 0.5)}, "wykonać prace społeczne", function()
            if not isDoingCommunityServices then
                isDoingCommunityServices = true
                showProgress({title = "Wykonywanie pracy społecznej...", time = 5000}, function(isDone)
                    isDoingCommunityServices = false
                    if isDone then
                        ESX.ShowNotification('Zakończono wykonywanie pracy społecznej!', 'success')
                        count = count - 1
                        generateCoords()
                    else
                        ESX.ShowNotification('Przerwano wykonywanie pracy społecznej!', 'error')
                    end
                end)
            end
        end, function()
            if isDoingCommunityServices then
                cancelProgress()
                isDoingCommunityServices = false
            end
        end)
    end
end

function DisplayHelpText(string)
    BeginTextCommandDisplayHelp("STRING")
    AddTextComponentSubstringPlayerName(string)
    EndTextCommandDisplayHelp(1, false, false, 0)
end

CreateThread(function()
    while true do 
        Wait(0)
        if isInCommunityServices and count > 0 then
            local playerPedd = PlayerPedId()
            DisplayHelpText('Pozostało ~b~'..count..' ~w~prac!')
            SetFloatingHelpTextStyle(0, 2, 2, 0, 3, 0)
            SetFloatingHelpTextToEntity(0, playerPedd, 0, 0)
            DrawLine(GetEntityCoords(playerPedd), currentCoords, 255, 255, 255, 255)
        else
            Wait(500)
        end
    end
end)

RegisterNetEvent("_prace:CommunityService", function(_count)
    count = count + _count
    isInCommunityServices, unCommunityServices = true, false
    local playerPed = PlayerPedId()
	SetPedArmour(playerPed, 0)
	ESX.Game.Teleport(playerPed, Config["prace"].JailSpawn)
    generateCoords()
	while not unCommunityServices do
		playerPed = PlayerPedId()
		if IsPedInAnyVehicle(playerPed, false) then
			ClearPedTasksImmediately(playerPed)
		end
		Wait(10000)
		if #(GetEntityCoords(playerPed) - Config["prace"].Jail.coords) > Config["prace"].Jail.radius then
			ESX.Game.Teleport(playerPed, Config["prace"].JailSpawn)
            ESX.ShowNotification("Nie możesz <b style='color:crimson'>uciec</b> z <b style='color:crimson'>prac społecznych</b>!", "error")
		end         
	end
	ESX.Game.Teleport(playerPed, Config["prace"].AfterJailSpawn)
	isInCommunityServices = false
end)


RegisterNetEvent('_prace:unCommunityService', function()
	unCommunityServices, count = true, 0
end)