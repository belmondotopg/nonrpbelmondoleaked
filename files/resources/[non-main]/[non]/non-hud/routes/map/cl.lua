-- MAIN LOOP

Citizen.CreateThread(function()
    local minimap = RequestScaleformMovie("minimap")
    SetRadarBigmapEnabled(true, false)
    Wait(1000)
    SetRadarBigmapEnabled(false, true)
    SetRadarZoom(1200)
    while true do
        Wait(1000)
        SetBlipAlpha(GetNorthRadarBlip(), 0)
        BeginScaleformMovieMethod(minimap, "SETUP_HEALTH_ARMOUR")
        SetRadarBigmapEnabled(false, true)
        ScaleformMovieMethodAddParamInt(3)
        EndScaleformMovieMethod()
    end
end)