local strefka = nil
local przejmuje = false
local blipsStrefy = {}

RegisterNetEvent('non-strefy:StatusPrzejmowanie')
AddEventHandler('non-strefy:StatusPrzejmowanie', function(status, strefa)
	Citizen.CreateThread(function()
        if status then
            przejmuje = true
            showProgress({title = 'Przejmowanie strefy', time = 2*60*1000}, function(isDone)
                if isDone then
                    ESX.TriggerServerCallback('non-strefy:KoniecPrzejmowania', function(strefka) end, strefka)
                else
                    przejmuje = false
                    cancelProgress()
                end
            end)
        elseif not status then
            przejmuje = false
            cancelProgress()
        end
	end)
end)

RegisterNetEvent('non-strefy:ZmienKolorBlipa')
AddEventHandler('non-strefy:ZmienKolorBlipa', function (strefa, kolor)
    SetBlipColour(blipsStrefy[strefa], kolor)
end)

AddEventHandler('esx:onPlayerDeath', function(data)
    if przejmuje then
        ESX.TriggerServerCallback('non-strefy:StopPrzejmowanie', function(k) end, strefka)
    end
end)

Citizen.CreateThread(function()
    for k,v in pairs(Config["Strefy"]) do
		blipsStrefy[k] = AddBlipForCoord(v.Coords.x, v.Coords.y, v.Coords.z)
		SetBlipSprite(blipsStrefy[k], 310)
		SetBlipScale(blipsStrefy[k], 1.0)
		SetBlipAsShortRange(blipsStrefy[k], true)
		SetBlipColour(blipsStrefy[k], 1)
		BeginTextCommandSetBlipName("STRING")
		AddTextComponentString("Strefa - "..v.Nazwa)
		EndTextCommandSetBlipName(blipsStrefy[k])
	end

    for k,v in pairs(Config["Strefy"]) do
        NON.RegisterPlace(v.Coords, { size = vector3(15.0, 15.0, 0.3) }, "przejac strefe!", function()
            if not SprawdzDuel() then
                if not exports['esx_ambulancejob']:isdead() then
                    strefka = k
                    ESX.TriggerServerCallback('non-strefy:StartPrzejmowania', function(k)
                        przejmuje = true
                        print(k)
                    end, k)
                else
                    ESX.ShowNotification("Nie mozesz przejmowac tej strefy bedac martwy.")
                end
            end
        end, function ()
            ESX.TriggerServerCallback('non-strefy:StopPrzejmowanie', function(k) end, k)
            przejmuje = false
        end)
    end
end)
