local blipsRobbery = {}
local robberyInProcess = false
local currentBank = nil

local Config = {}
Config['napady'] = {}
Config['napady'].HackingItem = 'rob_laptop'
Config['napady'].Banks = {}

AddEventHandler('onClientResourceStart', function (resourceName)
	if resourceName == GetCurrentResourceName() then
		TriggerServerEvent('non-robberies:requestConfig')
	end
end)

RegisterNetEvent('non-robberies:sendConfig')
AddEventHandler('non-robberies:sendConfig', function(config)
    Config['napady'].Banks = config
    addRobberyBlips()
end)


RegisterNetEvent('non-robberies:setPoliceBlip')
AddEventHandler('non-robberies:setPoliceBlip', function(state, coords, bankName)
    if state then
        blipsRobbery[bankName] = AddBlipForCoord(coords)
        SetBlipSprite(blipsRobbery[bankName], 161)
        SetBlipDisplay(blipsRobbery[bankName], 4)
        SetBlipScale(blipsRobbery[bankName], 1.0)
        SetBlipColour(blipsRobbery[bankName], 1)
        BeginTextCommandSetBlipName("STRING")
        AddTextComponentString('^ Napad ('..bankName..')')
        EndTextCommandSetBlipName(blipsRobbery[bankName])
        PulseBlip(blipsRobbery[bankName])
        PlaySoundFrontend(-1, "Bomb_Disarmed", "GTAO_Speed_Convoy_Soundset", 0)
    else
        if DoesBlipExist(blipsRobbery[bankName]) then
            RemoveBlip(blipsRobbery[bankName])
        end
    end
end)

RegisterNetEvent('non-robberies:requestMinigame')
AddEventHandler('non-robberies:requestMinigame', function(bank)

    TaskStartScenarioInPlace(PlayerPedId(), "WORLD_HUMAN_STAND_MOBILE", 0, false)

    local success = exports["PaT_gierka"]:StartHack12(10, 5, 120, false)

    if success then
        TriggerServerEvent('non-robberies:startRob', bank)
    else
        TriggerServerEvent('non-robberies:cancelRobbery', bank, true)
    end

    ClearPedTasks(PlayerPedId())
end)

RegisterNetEvent('non-robberies:robberyState')
AddEventHandler('non-robberies:robberyState', function(state, bank)
    if state then
        robberyInProcess = true
        currentBank = bank

        exports['non']:showProgress({title = "Otwieranie sejfu", time = Config['napady'].Banks[bank].secondsRemaining*1000}, function(isDone)
            if not isDone then
                cancelRobbery(true, bank)
            end
        end)
    else
        cancelRobbery()
    end
end)


function addRobberyBlips()
    CreateThread(function()
        for k, v in pairs(Config['napady'].Banks) do
            local blip = AddBlipForCoord(v.coords)
            SetBlipSprite(blip, v.Blip.sprite)
            SetBlipScale(blip, v.Blip.scale)
            SetBlipDisplay(blip, 4)
            SetBlipColour(blip, v.Blip.colour)
            SetBlipAsShortRange(blip, true)
            BeginTextCommandSetBlipName("STRING")
            AddTextComponentString(v.Blip.name)
            EndTextCommandSetBlipName(blip)
        end
    end)
end

CreateThread(function()
    while true do
        local ped = PlayerPedId()
        local pedCoords = GetEntityCoords(ped)
        local sleep = 500
        for bank, v in pairs(Config['napady'].Banks) do
            if not robberyInProcess then
                if #(v.coords - pedCoords) < 10.0 then
                    sleep = 1
                    ESX.Game.Utils.DrawText3D(v.coords, '[E] Rabunek na ~r~'..v.bankName..'~n~~w~[G] Zobacz zawartość sejfu', 0.8, 6)
                end
                if #(v.coords - pedCoords) < 1.0 then
                    if IsControlJustReleased(0, 38) then
                        local copsCount = exports['non-ui']:CountPlayer('police')
                        TriggerServerEvent('non-robberies:requestRob', bank, copsCount)
                    end
                    if IsControlJustReleased(0, 47) then
                        checkDrop(bank)
                    end
                end
            end
        end
        if robberyInProcess then
            if #(Config['napady'].Banks[currentBank].coords - pedCoords) > 2.0 then
                cancelRobbery(true, currentBank)
            end
        end
        Wait(sleep)
    end
end)

function cancelRobbery(pushed, bank)
    robberyInProcess = false
    currentBank = nil
    ClearPedTasks(PlayerPedId())
    exports['non']:cancelProgress()
    if pushed then
        ESX.ShowNotification('~r~Anulowano rabunek: '..Config['napady'].Banks[bank].bankName)
        TriggerServerEvent('non-robberies:cancelRobbery', bank)
    end
end

function checkDrop(bank)

    local elements = {}

    table.insert(elements, {label = 'Gotówka: '..Config['napady'].Banks[bank].money.min..' - '..Config['napady'].Banks[bank].money.max..'$'})

    if Config['napady'].Banks[bank].Drop then
        for k, v in pairs(Config['napady'].Banks[bank].Drop) do
            local count = ''
            if v.countMin ~= v.countMax then
                count = '('..v.countMin..'-'..v.countMax..')'
            end
    
            if v.label then
                table.insert(elements, {label = v.label..' '..count..' - '..v.chance..'%'})
            end
        end
    end

    ESX.UI.Menu.CloseAll()
    ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'robberies_drop', {
        title    = 'Zawartość sejfu',
        align    = 'center',
        elements = elements
    }, function(data, menu)
    end, function(data, menu)
        menu.close()
    end)
end

AddEventHandler('esx:onPlayerDeath', function()
    if robberyInProcess then
        cancelRobbery(true, currentBank)
    end
end)