Config = {}

Config['hud'] = {
    debug = true, 
    ShowHud = true,
    Carhud = false,
    Wait = 250,
    Wait2 = 250,
    Diractions = {
        [0] = 'N', 
        [45] = 'NW', 
        [90] = 'W', 
        [135] = 'SW', 
        [180] = 'S', 
        [225] = 'SE', 
        [270] = 'E', 
        [315] = 'NE', 
        [360] = 'N',
    },
    proximityModes = {
        { 1.0, 15 },
        { 6.0, 50 },
        { 12.0, 100 }
    },
}


Config.proximityModes = {
    { 1.0, 25 },
    { 6.0, 50 },
    { 12.0, 100 }
}
