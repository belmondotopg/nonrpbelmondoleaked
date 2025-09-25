cache = {
    playerPed = PlayerPedId(),
    clientId = PlayerId(),
    serverId = GetPlayerServerId(PlayerId()),
    inVehicle = IsPedInAnyVehicle(PlayerPedId(), false),
    playerCoords = GetEntityCoords(PlayerPedId()),
    playerHeading = GetEntityHeading(PlayerPedId()),
};

ESX.PlayerData = ESX.GetPlayerData();

CreateThread(function()
    while true do
        Wait(600)
        cache.playerPed = PlayerPedId()
        cache.clientId = PlayerId()
        cache.serverId = GetPlayerServerId(cache.clientId)
        cache.inVehicle = IsPedInAnyVehicle(cache.playerPed, false)
        cache.playerCoords = GetEntityCoords(cache.playerPed)
        cache.playerHeading = GetEntityHeading(cache.playerPed)
    end
end)

