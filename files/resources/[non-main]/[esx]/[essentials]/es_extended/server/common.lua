ESX = {}
ESX.Players = {}
ESX.Jobs = {}
ESX.Items = {}
Core = {}
Core.UsableItemsCallbacks = {}
Core.ServerCallbacks = {}
Core.ClientCallbacks = {}
Core.CurrentRequestId = 0
Core.TimeoutCount = -1
Core.CancelledTimeouts = {}
Core.RegisteredCommands = {}
Core.Pickups = {}
Core.PickupId = 0
Core.PlayerFunctionOverrides = {}

AddEventHandler('esx:getSharedObject', function(cb)
  cb(ESX)
end)

exports('getSharedObject', function()
  return ESX
end)

if GetResourceState('ox_inventory') ~= 'missing' then
  Config.OxInventory = true
  Config.PlayerFunctionOverride = 'OxInventory'
  SetConvarReplicated('inventory:framework', 'esx')
  SetConvarReplicated('inventory:weight', Config.MaxWeight * 1000)
end

local function StartDBSync()
  CreateThread(function()
    while true do
      Wait(10 * 60 * 1000)
      Core.SavePlayers()
    end
  end)
end

MySQL.ready(function()
  if not Config.OxInventory then
    local items = MySQL.query.await('SELECT * FROM items')
    for k, v in ipairs(items) do
      ESX.Items[v.name] = {label = v.label, weight = v.weight, rare = v.rare, canRemove = v.can_remove}
    end
  else
    TriggerEvent('__cfx_export_ox_inventory_Items', function(ref)
      if ref then
        ESX.Items = ref()
      end
    end)

    AddEventHandler('ox_inventory:itemList', function(items)
      ESX.Items = items
    end)

    while not next(ESX.Items) do
      Wait(0)
    end
  end

  local Jobs = {}
  local jobs = MySQL.query.await('SELECT * FROM jobs')
  
  if jobs then
      for i = 1, #jobs do
          Jobs[jobs[i].name] = jobs[i]
  
          -- Check if 'grades' field exists and is not nil
          if jobs[i].grades then
              local decodedGrades, decodeError = json.decode(jobs[i].grades)
  
              if decodedGrades then
                  Jobs[jobs[i].name].grades = decodedGrades
  
                  for j = 1, #Jobs[jobs[i].name].grades do
                      Jobs[jobs[i].name].grades[j].id = j
                  end
              else
                  print("Error decoding 'grades' JSON for job:", jobs[i].name, "Error:", decodeError)
              end
          else
              print("The 'grades' field is nil for job:", jobs[i].name)
          end
      end
  
      ESX.Jobs = Jobs
      Jobs = {}
  else
      print("No jobs found in the database.")
  end
  

  exports['non']:ServerDebugPrint({type = "info", message = "Serwer zostal uruchomiony! mozesz dac like to moze mi zaplacom...."})
  StartDBSync()
  StartPayCheck()
end)

RegisterServerEvent('esx:clientLog')
AddEventHandler('esx:clientLog', function(msg)
  if Config.EnableDebug then
    print(('[^2TRACE^7] %s^7'):format(msg))
  end
end)

RegisterServerEvent('esx:triggerServerCallback')
AddEventHandler('esx:triggerServerCallback', function(name, requestId, ...)
  local playerId = source

  ESX.TriggerServerCallback(name, requestId, playerId, function(...)
    TriggerClientEvent('esx:serverCallback', playerId, requestId, ...)
  end, ...)
end)

RegisterNetEvent("esx:ReturnVehicleType", function(Type, Request)
  if Core.ClientCallbacks[Request] then
    Core.ClientCallbacks[Request](Type)
    Core.ClientCallbacks[Request] = nil
  end
end)
