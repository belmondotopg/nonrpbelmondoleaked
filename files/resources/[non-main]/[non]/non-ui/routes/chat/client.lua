RegisterNetEvent('chat:addSuggestion')
RegisterNetEvent('chat:addSuggestions')

local chatEnabled, suggestions, suggestedCommandRegistered = false, {}, {};
local opisy = {}
CreateThread(function()
    SetTextChatEnabled(false)
    DisableMultiplayerChat(true)
end)

local pCoords
CreateThread(function()
	while true do
		local ped = PlayerPedId()
		pCoords = GetEntityCoords(ped)
		
		Citizen.Wait(500)
	end
end)

RegisterCommand("useChat", function()
    if not chatEnabled then
        chatEnabled = true
        SendNUIMessage({
            eventName = "nui:chat:focus"
        })
        SetNuiFocus(true, false)
    end
end)

function closeChat()
    chatEnabled = false
    SetNuiFocus(false, false)
    SendNUIMessage({
        eventName = "nui:chat:defocus"
    })
end

RegisterNUICallback("chat/off", function(data, cb)
    closeChat();
    cb('ok')
end)

RegisterNUICallback("chat/send", function(data, cb)
    local message = data.message;
    if not data.message then return end
    closeChat();
    if message then
        if message:sub(1, 1) == "/" then
            ExecuteCommand(message:sub(2))
        else
            ExecuteCommand("LOOC "..message)
        end
    end
    cb('ok')
end)

RegisterNetEvent("non-chat:addMessage", function(message, messageOwner, messageOwnerCoords)
    ESX.PlayerData = ESX.GetPlayerData();
    local job = "BRAK"
    local command = Config.ChatCommands[message.type];
    if not messageOwner then return end
    if command then
        if command.receivers == "distance" then
            local distance = #(cache.playerCoords - messageOwnerCoords) < 25.0;
            if not distance then return end
        elseif command.receivers == "admins" then
            local isAllowed = command.groups[ESX.PlayerData.group];
            if not isAllowed then return end
        elseif command.receivers == "unemployed" then
            if ESX.PlayerData.job.name == 'police' then return end
        end
    end

    if messageOwner then
        if messageOwner.job then
            if messageOwner.job == "UNEMPLOYED" then
                job = "BRAK"
            else
                job = messageOwner.job
            end
        end
    end

    if command.color then
        SendNUIMessage({
            eventName = "nui:chat:newMessage",
            newMessage = {
                badge = {
                    color = command.color,
                    label = command.icon,
                },
                background = command.background,
                type = string.upper(message.type),
                title = messageOwner.name,
                id = messageOwner.id,
                subtitle = Config.ChatBadges[messageOwner.group].label, 
                content = message.content,
            }
        })
    else
        SendNUIMessage({
            eventName = "nui:chat:newMessage",
            newMessage = {
                badge = Config.ChatBadges[messageOwner.group],
                type = string.upper(message.type),
                title = messageOwner.name,
                id = messageOwner.id,
                subtitle = Config.ChatBadges[messageOwner.group].label, 
                content = message.content,
            }
        })
    end
end)

local font = 4 
local time = 6000 
local nbrDisplaying = 1

RegisterNetEvent('non-chat:narrations')
AddEventHandler('non-chat:narrations', function(id, name, message, type, kolorek)
	local pid = GetPlayerFromServerId(id)

	if pid == -1 then
		return
	end
	
	if pid ~= PlayerId() then
		local ped = Citizen.InvokeNative(0x43A66C31C68491C0, pid)
		if #(pCoords - GetEntityCoords(ped, true)) > 19.99 then
			return
		end
	end
	
	local ped = Citizen.InvokeNative(0x43A66C31C68491C0, pid)
    if IsEntityVisible(ped) then	
        if type == "me" then
            TriggerEvent("non-chat", {
                label = "fa-regular fa-keyboard",
                color = "#fff",
            }, {
                background = kolorek,
                id = name,
                type = "ME",
                name = "Obywatel",
                content = message,
            })
        elseif type == "do" then
            TriggerEvent("non-chat", {
                label = "fa-solid fa-clipboard-list",
                color = "#fff",
            }, {
                background = kolorek,
                id = name,
                type = "DO",
                name = "Obywatel",
                content = message,
            })
        elseif type == "try" then
            TriggerEvent("non-chat", {
                label = "fa-solid fa-masks-theater",
                color = "#fff",
            }, {
                background = kolorek,
                id = name,
                type = "TRY",
                name = "Obywatel",
                content = message,
            })
        end
    
	end
end)

RegisterNetEvent('non-chat:triggerDisplay')
AddEventHandler('non-chat:triggerDisplay', function(text, source, color)
	local player = GetPlayerFromServerId(source)
    if player ~= -1 then
		local offset = 0 + (nbrDisplaying*0.14)
		Display(GetPlayerFromServerId(source), text, offset, color)
	end
end)

function Display(mePlayer, text, offset, color)
    local displaying = true
    CreateThread(function()
        Wait(time)
        displaying = false
    end)
    CreateThread(function()
        nbrDisplaying = nbrDisplaying + 1
        while displaying do
            Wait(0)
			local ped = Citizen.InvokeNative(0x43A66C31C68491C0, mePlayer)
            local coordsMe = GetEntityCoords(ped, false)
            local coords = GetEntityCoords(PlayerPedId(), false)
			
			if #(coordsMe - coords) < 19.99 then
				if IsEntityVisible(Citizen.InvokeNative(0x43A66C31C68491C0, mePlayer)) then
					DrawText3DChat(coordsMe['x'], coordsMe['y'], coordsMe['z'] + 0.75 + offset, text, color)
				end			
			end
        end
        nbrDisplaying = nbrDisplaying - 1
    end)
end

function DrawText3DChat(x,y,z, text, color)
    local onScreen,_x,_y = World3dToScreen2d(x,y,z)
    local px,py,pz = table.unpack(GetGameplayCamCoord())
    local dist = #(vec3(px, py, pz) - vec3(x, y, z))

    local scale = (1/dist)*1.7
    local fov = (1/GetGameplayCamFov())*100
    local scale = scale*fov

    if onScreen then
        SetTextScale(0.0*scale, 0.55*scale)
        SetTextFont(font)
        SetTextProportional(1)
        SetTextColour(255, 255, 255, 255)
        SetTextDropshadow(0, 0, 0, 0, 255)
        SetTextEdge(2, 0, 0, 0, 150)
        SetTextDropShadow()
        SetTextCentre(true)


        BeginTextCommandWidth("STRING")
        AddTextComponentString(text)
        local height = GetTextScaleHeight(0.55*scale, font)
        local width = EndTextCommandGetWidth(font)

        -- Diplay the text
        SetTextEntry("STRING")
        AddTextComponentString(text)
        EndTextCommandDisplayText(_x, _y)
		DrawRect(_x+0.0011, _y+scale/50, width*1.1, height*1.2, color.r, color.g, color.b, 100)
    end
end

local displayOpisHeight = -0.1

RegisterNetEvent('non-chat:opis')
AddEventHandler('non-chat:opis', function(player, opis)
    local info = opis
    local ajdi = player
    opisy[ajdi] = info
end)

CreateThread(function()
    while true do
        Citizen.Wait(0)
		local found = false
        for _, player in ipairs(GetActivePlayers()) do
			local ajdi = GetPlayerServerId(player)
            if (opisy[ajdi] ~= nil and tostring(opisy[ajdi]) ~= '') then

				local ped = Citizen.InvokeNative(0x43A66C31C68491C0, player)
				local playerCoords = pCoords
				local targetCoords = GetEntityCoords(ped, true)
				local targetheading = GetEntityHeading(ped)
				local distance2 = #(playerCoords - targetCoords)

				if distance2 < 20 and IsEntityVisible(ped) then
					local veh = GetVehiclePedIsIn(ped, false)
					found = true
					local x, y, z = targetCoords.x, targetCoords.y, targetCoords.z
					if veh ~= 0 then
						for i = -1, 6 do
							PedInVeh = GetPedInVehicleSeat(veh, i)
							if PedInVeh == ped then
								if i == -1 then
									cord = GetObjectOffsetFromCoords(x, y, z, targetheading, -0.45, 0.5, 0.5)
								elseif i == 0 then
									cord = GetObjectOffsetFromCoords(x, y, z, targetheading, 0.45, 0.5, 0.5)
								elseif i == 1 then
									cord = GetObjectOffsetFromCoords(x, y, z, targetheading, -0.45, -0.3, 0.5)
								elseif i == 2 then
									cord = GetObjectOffsetFromCoords(x, y, z, targetheading, 0.45, -0.3, 0.5)
								elseif i == 3 then
									cord = GetObjectOffsetFromCoords(x, y, z, targetheading, -0.45, 0.5, 0.5)
								elseif i == 4 then
									cord = GetObjectOffsetFromCoords(x, y, z, targetheading, 0.45, 0.5, 0.5)
								elseif i == 5 then
									cord = GetObjectOffsetFromCoords(x, y, z, targetheading, -0.45, -0.3, 0.5)
								elseif i == 6 then
									cord = GetObjectOffsetFromCoords(x, y, z, targetheading, 0.45, -0.3, 0.5)
								end
								if cord then
									x, y, z = cord.x, cord.y, cord.z
								end
							end
						end
					end
					local tekst = tostring(opisy[ajdi])
					DrawText3DOpis(x, y, z + displayOpisHeight, tekst)
				end
            end
        end
		if not found then
			Citizen.Wait(400)
		end
    end
end)

function DrawText3DOpis(x,y,z, text)
    local onScreen,_x,_y=World3dToScreen2d(x,y,z)
    local px,py,pz=table.unpack(GetGameplayCamCoords())
    local dist = #(vec3(px, py, pz) - vec3(x, y, z))

    local scale = (1/dist)*2
    local fov = (1/GetGameplayCamFov())*100
    local scale = scale*fov*0.6

    if onScreen then
        SetTextScale(0.30, 0.30)
		SetTextFont(4)
		SetTextProportional(1)
		SetTextColour(255, 255, 255, 215)
		SetTextEntry("STRING")
		SetTextCentre(1)
		AddTextComponentString(text)
        DrawText(_x,_y)
    end
end

RegisterNetEvent("non-chat", function(badge, message)
    SendNUIMessage({
        eventName = "nui:chat:newMessage",
        newMessage = {
            background = message.background,
            id = message.id,
            badge = badge,
            type = string.upper(message.type),
            title = message.name,
            subtitle = message.subtitle,
            content = message.content,
        }
    })
end)

RegisterKeyMapping("useChat", "Włącz pisanie na chacie", "keyboard", "T");


local allSuggestions = {}

AddEventHandler('chat:addSuggestion', function(name, help, params)
    local args = {}

    if params then
        for _, param in ipairs(params) do
            if param.help then
                table.insert(args, param.help)
            end
        end
    end

    table.insert(allSuggestions, {
        command = name,
        description = " " .. (help or ""),
        args = args
    })

    SendNUIMessage({
        eventName = 'nui:chat:updateSuggestions',
        suggestions = allSuggestions
    })
end)

AddEventHandler('chat:addSuggestions', function(suggestions)
    for _, suggestion in ipairs(suggestions) do
        SendNUIMessage({
            eventName = 'nui:chat:updateSuggestions',
            suggestions = suggestions
        })
    end
end)

local function refreshCommands()
    if GetRegisteredCommands then
        local registeredCommands = GetRegisteredCommands()

        local suggestions = {}
        for _, command in ipairs(registeredCommands) do
            if IsAceAllowed(('command.%s'):format(command.name)) then
                table.insert(suggestions, {
                    command = command.name,
                    description = command.help or "",
                    args = {}
                })
            end
        end

        TriggerEvent('chat:addSuggestions', suggestions)
    end
end


AddEventHandler('onClientResourceStart', function(resName)
    Wait(500)

    refreshCommands()
end)
  
AddEventHandler('onClientResourceStop', function(resName)
    Wait(500)
  
    refreshCommands()
end)
  
CreateThread(function()
    TriggerServerEvent("chat:init");

    Wait(5000)

    ESX.PlayerData = ESX.GetPlayerData()

    refreshCommands()

	ESX.TriggerServerCallback('non-chat:ZapodajOpisyZPrzedWejscia', function(opis) -- :D 🌘
		opisy = opis
	end)
end)

RegisterNetEvent('non:adminlist')
AddEventHandler('non:adminlist', function(admins)
	local elements = {}
	local adminsCount = 0
	for k, v in pairs(admins) do
		adminsCount = adminsCount + 1
		table.insert(elements, {label = v.name..' [ID: '..v.id..'] ['..string.upper(v.rank)..']', value = nil})
	end
	ESX.UI.Menu.CloseAll()
	ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'admin_list', {
		title    = 'Administratorzy online ('..adminsCount..')',
		align    = 'center',
		elements = elements
	}, function(data, menu)
	end, function(data, menu)
		menu.close()
	end)
end)