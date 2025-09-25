local mp_m_freemode_01 = `mp_m_freemode_01`
local mp_f_freemode_01 = `mp_f_freemode_01`

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(playerData, isNew, skin)
    Wait(1000)

    ShutdownLoadingScreen()
    ShutdownLoadingScreenNui()
    TriggerEvent('esx:loadingScreenOff')

    if isNew or not skin then
	
        local finished = false
        local skinData = Config["newplr"].skin['m']
        local model = mp_m_freemode_01

        RequestModel(model)
        while not HasModelLoaded(model) do
            RequestModel(model)
            Wait(0)
        end

        SetPlayerModel(PlayerId(), model)
        SetModelAsNoLongerNeeded(model)

		TriggerEvent('esx_skin:playerRegistered')
        TriggerServerEvent('non:jestemkurwom:nadaj:token', 9999)

		Wait(1000)

        if isNew then
            TriggerEvent('skinchanger:loadSkin', skinData, function()
                local playerPed = PlayerPedId()
                SetPedAoBlobRendering(playerPed, true)
                ResetEntityAlpha(playerPed)
                Wait(5000)
                TriggerEvent('esx_skin:openSaveableMenu', function()
                    finished = true
                    TriggerServerEvent('non:jestemkurwom:nadaj:token', 10)
                    SetNuiFocus(true, true)
                    SendNUIMessage({
                        action = 'welcome-screen',
                        show = true,
                        nickname = ESX.GetPlayerData().discord.name;
                    }) 
                end, function()
                    finished = true
                end)
            end)
        end
    else
        TriggerEvent('skinchanger:loadSkin', skin)
    end

    DoScreenFadeIn(25)
end)

RegisterCommand('pomoc', function ()
    SetNuiFocus(true, true)
    SendNUIMessage({
        action = 'welcome-screen',
        show = true,
        nickname = ESX.GetPlayerData().discord.name;
    })
end, false)

RegisterNUICallback("non-pomoc:shutDown", function()
    SetNuiFocus(false, false)
end)