RegisterNetEvent("non-greenzones:setbucket")
AddEventHandler("non-greenzones:setbucket", function(bucket, vehicleNetId, occupants)
    if type(occupants) == "table" then
        for _, occupantId in ipairs(occupants) do
            SetPlayerRoutingBucket(occupantId, bucket)
        end
    end
    if vehicleNetId then
        local vehicle = NetworkGetEntityFromNetworkId(vehicleNetId)
        if vehicle and DoesEntityExist(vehicle) then
            SetEntityRoutingBucket(vehicle, bucket)
        end
    end
end)
