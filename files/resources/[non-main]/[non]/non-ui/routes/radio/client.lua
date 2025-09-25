local DrawRadioText = true

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
	ESX.PlayerData = xPlayer
	
	InitRestrictedFrequencies()
end)

RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)
	ESX.PlayerData.job = job

	RefreshRestrictedFrequenciesAccess()
end)

local Radio = {
	Has = false,
	Open = false,
	On = false,
	Enabled = true,
	Handle = nil,
	Prop = GetHashKey('prop_cs_hand_radio'), -- only ran once and doesn't break my syntax viewer
	Bone = 28422,
	Offset = vector3(0.0, 0.0, 0.0),
	Rotation = vector3(0.0, 0.0, 0.0),
	Dictionary = {
		"cellphone@",
		"cellphone@in_car@ds",
		"cellphone@str",
		"random@arrests",
	},
	Animation = {
		"cellphone_text_in",
		"cellphone_text_out",
		"cellphone_call_listen_a",
		"generic_radio_chatter",
	},
	Players = 0, -- Radio players count
	Clicks = true, -- Radio clicks
}
Radio.Labels = {
	{ "FRZL_RADIO_HELP", "~s~" .. (radioConfig.Controls.Secondary.Enabled and "~" .. radioConfig.Controls.Secondary.Name .. "~ + ~" .. radioConfig.Controls.Activator.Name .. "~" or "~" .. radioConfig.Controls.Activator.Name .. "~") .. " to hide.~n~~" .. radioConfig.Controls.Toggle.Name .. "~ to turn radio ~g~on~s~.~n~~" .. radioConfig.Controls.Decrease.Name .. "~ or ~" .. radioConfig.Controls.Increase.Name .. "~ to switch frequency~n~~" .. radioConfig.Controls.Input.Name .. "~ to choose frequency~n~~" .. radioConfig.Controls.ToggleClicks.Name .. "~ to ~a~ mic clicks~n~Frequency: ~1~ MHz" },
	{ "FRZL_RADIO_HELP2", "~s~" .. (radioConfig.Controls.Secondary.Enabled and "~" .. radioConfig.Controls.Secondary.Name .. "~ + ~" .. radioConfig.Controls.Activator.Name .. "~" or "~" .. radioConfig.Controls.Activator.Name .. "~") .. " to hide.~n~~" .. radioConfig.Controls.Toggle.Name .. "~ to turn radio ~r~off~s~.~n~~" .. radioConfig.Controls.Broadcast.Name .. "~ to broadcast.~n~Frequency: ~1~ MHz" },
	{ "FRZL_RADIO_INPUT", "Enter Frequency" },
}
local unarmed = GetHashKey('weapon_unarmed')
Radio.Commands = {
	{
		Enabled = false, -- Add a command to be able to open/close the radio
		Name = "radio", -- Command name
		Help = "Toggle hand radio", -- Command help shown in chatbox when typing the command
		Params = {},
		Handler = function(src, args, raw)
			local playerPed = PlayerPedId()
			local isFalling = IsPedFalling(playerPed)
			local isDead = LocalPlayer.state.dead

			if not isFalling and Radio.Enabled and Radio.Has and not isDead then
				Radio:Toggle(not Radio.Open)
			elseif (Radio.Open or Radio.On) and ((not Radio.Enabled) or (not Radio.Has) or isDead) then
				Radio:Toggle(false)
				Radio.On = false
				Radio:Remove()
				exports["non-voice"]:setVoiceProperty("radioEnabled", false)
			elseif Radio.Open and isFalling then
				Radio:Toggle(false)
			end
		end,
	},
	{
		Enabled = false, -- Add a command to choose radio frequency
		Name = "frequency", -- Command name
		Help = "Change radio frequency", -- Command help shown in chatbox when typing the command
		Params = {
			{name = "number", "Enter frequency"}
		},
		Handler = function(src, args, raw)
			if Radio.Has then
				if args[1] then
					local newFrequency = tonumber(args[1])
					if newFrequency then
						local minFrequency = radioConfig.Frequency.List[1]
						if newFrequency >= minFrequency and newFrequency <= radioConfig.Frequency.List[#radioConfig.Frequency.List] and newFrequency == math.floor(newFrequency) then
							if not radioConfig.Frequency.Private[newFrequency] or radioConfig.Frequency.Access[newFrequency] then
								local idx = nil

								for i = 1, #radioConfig.Frequency.List do
									if radioConfig.Frequency.List[i] == newFrequency then
										idx = i
										break
									end
								end

								if idx ~= nil then
									if Radio.Enabled then
										Radio:Remove()
									end

									radioConfig.Frequency.CurrentIndex = idx
									radioConfig.Frequency.Current = newFrequency

									if Radio.On then
										Radio:Add(radioConfig.Frequency.Current)
									end
								end
							end
						end
					end
				end
			end
		end,
	},
}

-- Setup each radio command if enabled
for i = 1, #Radio.Commands do
	if Radio.Commands[i].Enabled then
		RegisterCommand(Radio.Commands[i].Name, Radio.Commands[i].Handler, false)
		TriggerEvent("chat:addSuggestion", Radio.Commands[i].Name, Radio.Commands[i].Help, Radio.Commands[i].Params)
	end
end

-- Create/Destroy handheld radio object
--[[function Radio:Toggle(toggle)
	local playerPed = PlayerPedId()
	local count = 0

	if not self.Has or IsEntityDead(playerPed) then
		self.Open = false

		DetachEntity(self.Handle, true, false)
		DeleteEntity(self.Handle)

		return
	end

	if self.Open == toggle then
		return
	end

	self.Open = toggle

	if self.On and not radioConfig.AllowRadioWhenClosed then
		exports["non-voice"]:setVoiceProperty("radioEnabled", toggle)
	end

	local dictionaryType = 1 + (IsPedInAnyVehicle(playerPed, false) and 1 or 0)
	local animationType = 1 + (self.Open and 0 or 1)
	local dictionary = self.Dictionary[dictionaryType]
	local animation = self.Animation[animationType]

	RequestAnimDict(dictionary)

	while not HasAnimDictLoaded(dictionary) do
		Citizen.Wait(150)
	end

	if self.Open then
		RequestModel(self.Prop)

		while not HasModelLoaded(self.Prop) do
			Citizen.Wait(150)
		end

		self.Handle = CreateObject(self.Prop, 0.0, 0.0, 0.0, true, true, false)

		local bone = GetPedBoneIndex(playerPed, self.Bone)

		SetCurrentPedWeapon(playerPed, unarmed, true)
		AttachEntityToEntity(self.Handle, playerPed, bone, self.Offset.x, self.Offset.y, self.Offset.z, self.Rotation.x, self.Rotation.y, self.Rotation.z, true, false, false, false, 2, true)

		SetModelAsNoLongerNeeded(self.Handle)

		TaskPlayAnim(playerPed, dictionary, animation, 4.0, -1, -1, 50, 0, false, false, false)
	else
		TaskPlayAnim(playerPed, dictionary, animation, 4.0, -1, -1, 50, 0, false, false, false)

		Citizen.Wait(700)

		StopAnimTask(playerPed, dictionary, animation, 1.0)

		NetworkRequestControlOfEntity(self.Handle)

		while not NetworkHasControlOfEntity(self.Handle) and count < 5000 do
			Citizen.Wait(0)
			count = count + 1
		end

		DetachEntity(self.Handle, true, false)
		DeleteEntity(self.Handle)
	end
end]]

-- Add player to radio channel
function Radio:Add(id)
	TriggerServerEvent("non-radio:registerChannel", id)
	exports["non-voice"]:setRadioChannel(id)
end

-- Remove player from radio channel
function Radio:Remove()
	TriggerServerEvent("non-radio:unregisterChannel")
	exports["non-voice"]:setRadioChannel(0)
	--TriggerEvent('non-radiolist:hidelist')
end

-- Increase radio frequency
function Radio:Decrease()
	if self.On then
		if radioConfig.Frequency.CurrentIndex - 1 < 1 and radioConfig.Frequency.List[radioConfig.Frequency.CurrentIndex] == radioConfig.Frequency.Current then
			self:Remove()
			radioConfig.Frequency.CurrentIndex = #radioConfig.Frequency.List
			radioConfig.Frequency.Current = radioConfig.Frequency.List[radioConfig.Frequency.CurrentIndex]
			self:Add(radioConfig.Frequency.Current)
		elseif radioConfig.Frequency.CurrentIndex - 1 < 1 and radioConfig.Frequency.List[radioConfig.Frequency.CurrentIndex] ~= radioConfig.Frequency.Current then
			self:Remove()
			radioConfig.Frequency.Current = radioConfig.Frequency.List[radioConfig.Frequency.CurrentIndex]
			self:Add(radioConfig.Frequency.Current)
		else
			self:Remove()
			radioConfig.Frequency.CurrentIndex = radioConfig.Frequency.CurrentIndex - 1
			radioConfig.Frequency.Current = radioConfig.Frequency.List[radioConfig.Frequency.CurrentIndex]
			self:Add(radioConfig.Frequency.Current)
		end
	else
		if radioConfig.Frequency.CurrentIndex - 1 < 1 and radioConfig.Frequency.List[radioConfig.Frequency.CurrentIndex] == radioConfig.Frequency.Current then
			radioConfig.Frequency.CurrentIndex = #radioConfig.Frequency.List
			radioConfig.Frequency.Current = radioConfig.Frequency.List[radioConfig.Frequency.CurrentIndex]
		elseif radioConfig.Frequency.CurrentIndex - 1 < 1 and radioConfig.Frequency.List[radioConfig.Frequency.CurrentIndex] ~= radioConfig.Frequency.Current then
			radioConfig.Frequency.Current = radioConfig.Frequency.List[radioConfig.Frequency.CurrentIndex]
		else
			radioConfig.Frequency.CurrentIndex = radioConfig.Frequency.CurrentIndex - 1

			if radioConfig.Frequency.List[radioConfig.Frequency.CurrentIndex] == radioConfig.Frequency.Current then
				radioConfig.Frequency.CurrentIndex = radioConfig.Frequency.CurrentIndex - 1
			end

			radioConfig.Frequency.Current = radioConfig.Frequency.List[radioConfig.Frequency.CurrentIndex]
		end
	end
end

-- Decrease radio frequency
function Radio:Increase()
	if self.On then
		if radioConfig.Frequency.CurrentIndex + 1 > #radioConfig.Frequency.List then
			self:Remove()
			radioConfig.Frequency.CurrentIndex = 1
			radioConfig.Frequency.Current = radioConfig.Frequency.List[radioConfig.Frequency.CurrentIndex]
			self:Add(radioConfig.Frequency.Current)
		else
			self:Remove()
			radioConfig.Frequency.CurrentIndex = radioConfig.Frequency.CurrentIndex + 1
			radioConfig.Frequency.Current = radioConfig.Frequency.List[radioConfig.Frequency.CurrentIndex]
			self:Add(radioConfig.Frequency.Current)
		end
	else
		if #radioConfig.Frequency.List == radioConfig.Frequency.CurrentIndex + 1 then
			if radioConfig.Frequency.List[radioConfig.Frequency.CurrentIndex + 1] == radioConfig.Frequency.Current then
				radioConfig.Frequency.CurrentIndex = radioConfig.Frequency.CurrentIndex + 1
			end
		end

		if radioConfig.Frequency.CurrentIndex + 1 > #radioConfig.Frequency.List then
			radioConfig.Frequency.CurrentIndex = 1
			radioConfig.Frequency.Current = radioConfig.Frequency.List[radioConfig.Frequency.CurrentIndex]
		else
			radioConfig.Frequency.CurrentIndex = radioConfig.Frequency.CurrentIndex + 1
			radioConfig.Frequency.Current = radioConfig.Frequency.List[radioConfig.Frequency.CurrentIndex]
		end
	end
end

function Radio:IncreaseRestricted()
	local nextFrequency = nil

	for i=(radioConfig.Frequency.CurrentIndex + 1), #radioConfig.Frequency.List do
		local frequency = radioConfig.Frequency.List[i]
		if radioConfig.Frequency.Access[frequency] then
			nextFrequency = i

			break
		end
	end

	if nextFrequency then
		if self.On then
			self:Remove()
			radioConfig.Frequency.CurrentIndex = nextFrequency
			radioConfig.Frequency.Current = radioConfig.Frequency.List[radioConfig.Frequency.CurrentIndex]
			self:Add(radioConfig.Frequency.Current)
		else
			radioConfig.Frequency.CurrentIndex = nextFrequency
			radioConfig.Frequency.Current = radioConfig.Frequency.List[radioConfig.Frequency.CurrentIndex]
		end
	end
end

function Radio:DecreaseRestricted()
    local nextFrequency = nil

    for i=(radioConfig.Frequency.Current - 1), 0, -1 do
        if radioConfig.Frequency.Access[i] then
            nextFrequency = i

            break
        end
    end

    if nextFrequency then
        local frequencyIndex = nil

        for i = 1, #radioConfig.Frequency.List do
            if radioConfig.Frequency.List[i] == nextFrequency then
                frequencyIndex = i

                break
            end
        end

        if frequencyIndex then
            if self.On then
                self:Remove()
                radioConfig.Frequency.CurrentIndex = frequencyIndex
                radioConfig.Frequency.Current = radioConfig.Frequency.List[radioConfig.Frequency.CurrentIndex]
                self:Add(radioConfig.Frequency.Current)
            else
                radioConfig.Frequency.CurrentIndex = frequencyIndex
                radioConfig.Frequency.Current = radioConfig.Frequency.List[radioConfig.Frequency.CurrentIndex]
            end
        end
    end
end

-- Generate list of available frequencies
function GenerateFrequencyList()
	radioConfig.Frequency.List = {}

	for i = radioConfig.Frequency.Min, radioConfig.Frequency.Max do
		if not radioConfig.Frequency.Private[i] or radioConfig.Frequency.Access[i] then
			radioConfig.Frequency.List[#radioConfig.Frequency.List + 1] = i
		end
	end
end

-- Check if radio is open
function IsRadioOpen()
	return Radio.Open
end

-- Check if radio is switched on
function IsRadioOn()
	return Radio.On
end

-- Check if player has radio
function IsRadioAvailable()
	return Radio.Has
end

-- Check if radio is enabled or not
function IsRadioEnabled()
	return not Radio.Enabled
end

-- Check if radio can be used
function CanRadioBeUsed()
	return Radio.Has and Radio.On and Radio.Enabled
end

-- Set if the radio is enabled or not
function SetRadioEnabled(value)
	if type(value) == "string" then
		value = value == "true"
	elseif type(value) == "number" then
		value = value == 1
	end

	Radio.Enabled = value and true or false
end

-- Set if player has a radio or not
function SetRadio(value)
	if type(value) == "string" then
		value = value == "true"
	elseif type(value) == "number" then
		value = value == 1
	end

	Radio.Has = value and true or false
end

-- Set if player has access to use the radio when closed
function SetAllowRadioWhenClosed(value)
	radioConfig.AllowRadioWhenClosed = value

	if Radio.On and not Radio.Open and radioConfig.AllowRadioWhenClosed then
		exports["non-voice"]:setVoiceProperty("radioEnabled", true)
	end
end

-- Has private frequency exist
function HasPrivateFrequencyExist(value)
	local frequency = tonumber(value)

	if frequency ~= nil then
		return radioConfig.Frequency.Private[frequency] ~= nil
	end
end

-- Add new frequency
function AddPrivateFrequency(value)
	local frequency = tonumber(value)

	if frequency ~= nil then
		if not radioConfig.Frequency.Private[frequency] then -- Only add new frequencies
			radioConfig.Frequency.Private[frequency] = true

			GenerateFrequencyList()
		end
	end
end

-- Remove private frequency
function RemovePrivateFrequency(value)
	local frequency = tonumber(value)

	if frequency ~= nil then
		if radioConfig.Frequency.Private[frequency] then -- Only remove existing frequencies
			radioConfig.Frequency.Private[frequency] = nil

			GenerateFrequencyList()
		end
	end
end

-- Give access to a frequency
function GivePlayerAccessToFrequency(value)
	local frequency = tonumber(value)

	if frequency ~= nil then
		if radioConfig.Frequency.Private[frequency] then -- Check if frequency exists
			if not radioConfig.Frequency.Access[frequency] then -- Only add new frequencies
				radioConfig.Frequency.Access[frequency] = true

				GenerateFrequencyList()
			end
		end
	end
end

-- Remove access to a frequency
function RemovePlayerAccessToFrequency(value)
	local frequency = tonumber(value)

	if frequency ~= nil then
		if radioConfig.Frequency.Access[frequency] then -- Check if player has access to frequency
			radioConfig.Frequency.Access[frequency] = nil

			GenerateFrequencyList()
		end
	end
end

-- Give access to multiple frequencies
function GivePlayerAccessToFrequencies(...)
	local frequencies = { ... }
	local newFrequencies = {}

	for i = 1, #frequencies do
		local frequency = tonumber(frequencies[i])

		if frequency ~= nil then
			if radioConfig.Frequency.Private[frequency] then -- Check if frequency exists
				if not radioConfig.Frequency.Access[frequency] then -- Only add new frequencies
					newFrequencies[#newFrequencies + 1] = frequency
				end
			end
		end
	end

	if #newFrequencies > 0 then
		for i = 1, #newFrequencies do
			radioConfig.Frequency.Access[newFrequencies[i]] = true
		end

		GenerateFrequencyList()
	end
end

-- Remove access to multiple frequencies
function RemovePlayerAccessToFrequencies(...)
	local frequencies = { ... }
	local removedFrequencies = {}

	for i = 1, #frequencies do
		local frequency = tonumber(frequencies[i])

		if frequency ~= nil then
			if radioConfig.Frequency.Access[frequency] then -- Check if player has access to frequency
				removedFrequencies[#removedFrequencies + 1] = frequency
			end
		end
	end

	if #removedFrequencies > 0 then
		for i = 1, #removedFrequencies do
			radioConfig.Frequency.Access[removedFrequencies[i]] = nil
		end

		GenerateFrequencyList()
	end
end

-- Define exports
exports("IsRadioOpen", IsRadioOpen)
exports("IsRadioOn", IsRadioOn)
exports("IsRadioAvailable", IsRadioAvailable)
exports("IsRadioEnabled", IsRadioEnabled)
exports("CanRadioBeUsed", CanRadioBeUsed)
exports("SetRadioEnabled", SetRadioEnabled)
exports("SetRadio", SetRadio)
exports("SetAllowRadioWhenClosed", SetAllowRadioWhenClosed)
exports("AddPrivateFrequency", AddPrivateFrequency)
exports("RemovePrivateFrequency", RemovePrivateFrequency)
exports("GivePlayerAccessToFrequency", GivePlayerAccessToFrequency)
exports("RemovePlayerAccessToFrequency", RemovePlayerAccessToFrequency)
exports("GivePlayerAccessToFrequencies", GivePlayerAccessToFrequencies)
exports("RemovePlayerAccessToFrequencies", RemovePlayerAccessToFrequencies)

local isBroadcasting = false

AddEventHandler('non-voice:radioActive', function(broadCasting)
	isBroadcasting = broadCasting
end)

Citizen.CreateThread(function()
	-- Add Labels
	--[[for i = 1, #Radio.Labels do
		AddTextEntry(Radio.Labels[i][1], Radio.Labels[i][2])
	end]]

	GenerateFrequencyList()

	while true do
		if IsRadioOn() then
			Citizen.Wait(0)
		else
			Citizen.Wait(250)
		end
		-- Init local vars
		local minFrequency = radioConfig.Frequency.List[100]

		-- Remove player from private frequency that they don't have access to
		if not radioConfig.Frequency.Access[radioConfig.Frequency.Current] and radioConfig.Frequency.Private[radioConfig.Frequency.Current] then
			if Radio.On then
				Radio:Remove()
			end

			radioConfig.Frequency.CurrentIndex = 100
			radioConfig.Frequency.Current = minFrequency

			if Radio.On then
				Radio:Add(radioConfig.Frequency.Current)
			end
		end

		if Radio.Has then
			if IsControlPressed(0, 21) and IsControlJustPressed(0, 174) then
				Radio:DecreaseRestricted()
			end

			if IsControlPressed(0, 21) and IsControlJustPressed(0, 175) then
				Radio:IncreaseRestricted()
			end
		end
	end
end)

AddEventHandler("onClientResourceStart", function(resName)
	if GetCurrentResourceName() ~= resName and "non-voice" ~= resName then
		return
	end

	exports["non-voice"]:setVoiceProperty("radioEnabled", false) -- Disable radio control

	--[[if Radio.Open then
		Radio:Toggle(false)
	end]]

	Radio.On = false
end)

RegisterNetEvent("Radio.Toggle")
AddEventHandler("Radio.Toggle", function()
	local playerPed = PlayerPedId()
	local isFalling = IsPedFalling(playerPed)
	local isDead = LocalPlayer.state.dead

	if not isFalling and not isDead and Radio.Enabled and Radio.Has then
		Radio:Toggle(not Radio.Open)
	end
end)

RegisterNetEvent("Radio.Set")
AddEventHandler("Radio.Set", function(value)
	if type(value) == "string" then
		value = value == "true"
	elseif type(value) == "number" then
		value = value == 1
	end

	Radio.Has = value and true or false
end)

RegisterNetEvent("non-radio:item")
AddEventHandler("non-radio:item", function()
	Radio.Has = not Radio.Has
	if Radio.Has then
		Radio.On = true
		exports["non-voice"]:setVoiceProperty("radioEnabled", true)
		Radio:Add(radioConfig.Frequency.Current)
		ESX.ShowNotification('~g~Włączyłeś/aś radio')
		SendNUIMessage({
			eventName = "nui:radio:update",
			show = true,
		})
	else
		Radio.On = false
		exports["non-voice"]:setVoiceProperty("radioEnabled", false)
		Radio:Remove()
		SendNUIMessage({
			eventName = "nui:radio:update",
			show = false,
		})
		ESX.ShowNotification('~r~Wyłączyłeś/aś radio')
	end
end)

RegisterCommand('frequency', function()
	if Radio.On then
		if not radioConfig.Controls.Input.Pressed then
			radioConfig.Controls.Input.Pressed = true
			Citizen.CreateThread(function()
				AddTextEntry('non-radio_HELP', "Wprowadź częstotliwość")
				DisplayOnscreenKeyboard(1, 'non-radio_HELP', "", radioConfig.Frequency.Current, "", "", "", 3)

				while UpdateOnscreenKeyboard() ~= 1 and UpdateOnscreenKeyboard() ~= 2 do
					Citizen.Wait(150)
				end

				local input = nil

				if UpdateOnscreenKeyboard() ~= 2 then
					input = GetOnscreenKeyboardResult()
				end

				Citizen.Wait(500)

				input = tonumber(input)

				if input ~= nil then
					if input >= 1 and input <= radioConfig.Frequency.List[#radioConfig.Frequency.List] and input == math.floor(input) then
						if not radioConfig.Frequency.Private[input] or radioConfig.Frequency.Access[input] then
							local idx = nil

							for i = 1, #radioConfig.Frequency.List do
								if radioConfig.Frequency.List[i] == input then
									idx = i
									break
								end
							end

							if idx ~= nil then
								if Radio.Enabled then
									Radio:Remove()
								end

								radioConfig.Frequency.CurrentIndex = idx
								radioConfig.Frequency.Current = input

								if Radio.On then
									Radio:Add(radioConfig.Frequency.Current)
									ESX.ShowNotification('~y~Ustawiono częstotliwość na '..radioConfig.Frequency.Current)
								end
							end
						else
							ESX.ShowNotification('~y~Ta częstotliwość jest szyfrowana')
						end
					end
				end

				radioConfig.Controls.Input.Pressed = false
			end)
		end
	end
end, false)

RegisterKeyMapping('frequency', 'Wybór częstotliwości (radio)', 'keyboard', 'EQUALS')

RegisterNetEvent('esx:removeInventoryItem')
AddEventHandler('esx:removeInventoryItem', function(item, count)
	if item == 'radiocrime' or item == 'radio' then
		if count == 0 then
			Radio.Has = false
			Radio.On = false
			exports["non-voice"]:setVoiceProperty("radioEnabled", false)
			Radio:Remove()
		end
	end
end)

--[[Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)

		if Radio.Has and DrawRadioText then
			local label = ("Kanał: %s (%s)"):format(radioConfig.Frequency.Current, Radio.Players)

			for i=1, #radioConfig.Frequencyname do
				local freq = radioConfig.Frequencyname[i]

				if freq.id == radioConfig.Frequency.Current then
					label = ("Kanał: %s (%s)"):format(freq.name, Radio.Players)
					break
				end
			end

			if LocalPlayer.state.oldhud then
				if IsRadarHidden() then
					drawTxt(0.515, 1.447, 1.0, 1.0, 0.20, label, 255, 255, 255, 255)
				else
					drawTxt(0.515, 1.447, 1.0, 1.0, 0.20, label, 255, 255, 255, 255)
				end
			else
				if IsRadarHidden() then
					drawTxt(0.513, 1.431, 1.0, 1.0, 0.20, label, 255, 255, 255, 255)
				else
					drawTxt(0.553, 1.431, 1.0, 1.0, 0.20, label, 255, 255, 255, 255)
				end
			end
		else
			Citizen.Wait(500)
		end
	end
end)]]

function drawTxt(x, y, width, height, scale, text, r, g, b, a)
	SetTextFont(0);
	SetTextScale(scale, scale);
	SetTextColour(r, g, b, a);
	SetTextOutline();
	SetTextEntry("STRING");
	AddTextComponentString(text);
	DrawText(x - width / 2, y - height / 2 + 0.005);
end

--[[ Radio player count ]]--
RegisterNetEvent("pma-voice:syncRadioData")
AddEventHandler("pma-voice:syncRadioData", function()
	Citizen.SetTimeout(1000, function ()
		local players = exports["non-voice"]:getRadioData()
		if not players or type(players) ~= "table" then
			return
		end

		local count = 0
		for id in pairs(players) do
			count = count+1
		end

		Radio.Players = count
	end)
end)

RegisterNetEvent("pma-voice:addPlayerToRadio")
AddEventHandler("pma-voice:addPlayerToRadio", function()
	Citizen.SetTimeout(1000, function ()
		local players = exports["non-voice"]:getRadioData()
		if not players or type(players) ~= "table" then
			return
		end

		local count = 0
		for id in pairs(players) do
			count = count+1
		end

		Radio.Players = count
	end)
end)

RegisterNetEvent("pma-voice:removePlayerFromRadio")
AddEventHandler("pma-voice:removePlayerFromRadio", function()
	Citizen.SetTimeout(1000, function ()
		local players = exports["non-voice"]:getRadioData()
		if not players or type(players) ~= "table" then
			return
		end

		local count = 0
		for id in pairs(players) do
			count = count+1
		end

		Radio.Players = count
	end)
end)

--[[ Restricted frequencies ]]--
InitRestrictedFrequencies = function ()
	local offset = radioConfig.RestrictedOffset

	for _,frequencies in pairs(radioConfig.RestrictedFrequencies) do
		for _,frequency in ipairs(frequencies) do
			frequency = (offset + frequency)

			if not HasPrivateFrequencyExist(frequency) then
				AddPrivateFrequency(frequency)
			end
		end
	end

	RefreshRestrictedFrequenciesAccess()
end

RefreshRestrictedFrequenciesAccess = function ()
	local offset = radioConfig.RestrictedOffset
	local job = ESX.PlayerData.job.name
	--local secondjob = ESX.PlayerData.secondjob.name

	radioConfig.Frequency.Access = {}
	GenerateFrequencyList()

	if radioConfig.RestrictedFrequencies[job] then
		for _,frequency in ipairs(radioConfig.RestrictedFrequencies[job]) do
			frequency = (offset + frequency)

			if HasPrivateFrequencyExist(frequency) then
				GivePlayerAccessToFrequency(frequency)
			end
		end
	end
	--[[if radioConfig.RestrictedFrequencies[secondjob] then
		for _,frequency in ipairs(radioConfig.RestrictedFrequencies[secondjob]) do
			frequency = (offset + frequency)

			if HasPrivateFrequencyExist(frequency) then
				GivePlayerAccessToFrequency(frequency)
			end
		end
	end]]
end

RegisterNetEvent("non-radio:hideradiotext")
AddEventHandler("non-radio:hideradiotext", function()
	DrawRadioText = not DrawRadioText
	if DrawRadioText then
		ESX.ShowNotification('~g~Włączono pokazywanie numeru radia')
	else
		ESX.ShowNotification('~r~Wyłączono pokazywanie numeru radia')
	end
end)

RegisterCommand('radiolist', function()
	if Radio.On then
		local players = exports["non-voice"]:getRadioData()
		local elements = {}
		ESX.TriggerServerCallback('non-radio:crimeRadioList', function(result)
			for k, v in pairs(result) do
				table.insert(elements, {label = '['..v.playerid..'] '..v.names})
			end
			table.insert(elements, {label = 'Łączna liczba osób: '..Radio.Players})
			ESX.UI.Menu.CloseAll()
			ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'non_radiolist', {
				title = 'Lista osób na radiu: '..radioConfig.Frequency.Current,
				align = 'center',
				elements = elements
			}, function(data, menu)
			end, function(data, menu)
				menu.close()
			end)
		end, players)
	end
end)

--wieczor

RegisterNetEvent("non-radio:addTalking", function(channel, radioinfo)
    SendNUIMessage({
        eventName = "nui:radio:update",
		data = {
			name = channel,
			members = radioinfo,
		}
    })
end)

RegisterNetEvent("non-radio:addTalking2", function(channel, radioinfo)
    SendNUIMessage({
        eventName = "nui:radio:update",
		data = {
			name = channel,
			members = radioinfo,
		}
    })
end)

RegisterNetEvent("non-radio:stopTalking", function(channel, radioinfo)
    SendNUIMessage({
        eventName = "nui:radio:update",
		data = {
			name = channel,
			members = radioinfo,
		}
    })
end)

RegisterNetEvent("non-radio:stopTalking2", function()
    SendNUIMessage({
        eventName = "nui:radio:update",
    })
end)

RegisterNetEvent("non-radio:setTalking", function(playerid)
    SendNUIMessage({
        eventName = "setTalking",
        id = playerid,
    })
end)

RegisterNetEvent("non-radio:setNotTalking", function(playerid)
    SendNUIMessage({
        eventName = "nui:radio:update",
        id = playerid,
    })
end)

RegisterNetEvent("non-radio:setPlayerDead", function(channel, radioinfo)
	SendNUIMessage({
        eventName = "nui:radio:update",
		data = {
			name = channel,
			members = radioinfo,
		}
    })
end)

RegisterNetEvent("non-radio:setTalking", function(channel, radioinfo)
	SendNUIMessage({
        eventName = "nui:radio:update",
		data = {
			name = channel,
			members = radioinfo,
		}
    })
end)

RegisterNetEvent("non-radio:setNotTalking", function(channel, radioinfo)
	SendNUIMessage({
        eventName = "nui:radio:update",
		data = {
			name = channel,
			members = radioinfo,
		}
    })
end)