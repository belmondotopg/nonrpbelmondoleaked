Config = {}

Config['skleplimitki'] = {}
Config['skleplimitki'].PlateLetters = 3
Config['skleplimitki'].PlateNumbers = 3
Config['skleplimitki'].PlateUseSpace = true
Config['skleplimitki'].Zones = {
	ShopEntering = {Pos = vector3(989.0391, 32.0534, 70.4661)},
	ShopInside = {Pos = vector3(975.9160, 40.3109, 71.1523), Heading = -20.0, Type = -1},
	ShopOutside = {Pos = vector3(934.5317, -1.8681, 77.7639), Heading = 330.0, Type = -1},
}

Config['randomteleports'] = {
    TimeToDraw = 60,
    Teleports = {
        vector3(2041.0238, 3188.5984, 45.1690-.95),
        vector3(1008.4584, -2529.9966, 28.3021-.95)
    },
    Locations = {

        ['Szopa'] = {
            vector4(1551.9854, 2193.9490, 77.9731, 180.0976)
        },
        ['Kościół'] = {
            vector4(-331.6634, 2789.6516, 59.2754, 309.2680)
        },
        ['Wiatraki'] = {
            vector4(2287.7515, 1986.4004, 131.7119, 69.9822) 
        },
        ['jacht'] = {
            vector4(872.5193, 2868.8804, 56.8701, 331.6002) 
        },
        ['domki'] = {
            vector4(489.0938, 2602.0977, 43.1755, 8.9138)  
        },
        ['losty'] = {
            vector4(86.2666, 3736.7522, 39.6891, 200.6792) 
        },
        ['lesniczowka'] = {
            vector4(-687.9019, 5779.2144, 17.3309, 295.3298) 
        },
        ['okrag'] = {
            vector4(-1630.3483, 4739.7437, 53.0264, 142.2748) 
        },
        ['lafuenta'] = {
            vector4(1460.6603, 1112.9364, 114.3338, 268.1655) 
        },        
        

    }
}

Config['Nolootzones'] = {
    Zones = {
        ["doczki"] = {
            Coords = vec3(-139.2984, -2660.1797, 6.0002),
            Radius = 450.0,
            osoba3 = false,
            radius_AntyVDM = 0.0,
            blip = {
                addblip = true,
            },
        },

        ["s1"] = {
            Coords = vec3(1473.9674, 2178.0923, 86.0773),
            Radius = 275.0,
            osoba3 = false,
            radius_AntyVDM = 0.0,
            blip = {
                addblip = true,
            },
        },
    }
}

Config['amulety'] = {
    ["amulet_predkosci"] = {
        interval = 60000,
        action = function(playerPed, playerId)
            ResetPlayerStamina(playerId)
            SetRunSprintMultiplierForPlayer(playerId, 1.4)
        end,
        remove = function(playerPed, playerId)
            SetRunSprintMultiplierForPlayer(playerId, 1.0)
        end
    },
}

Config["gps"] = {
    police = {
        color = 3,
        label = "SASP"
    }
}

Config["Strefy"] = {
    ["elektrownia"] = {
        Coords = vec3(2853.4185, 1469.5251, 24.5554-.95),
        Nagroda = math.random(50000, 100000),
		Nazwa = "Elektrownia",
		Zostawic = 0,
		przejeciestrefy = false
	},

    ["Zlom"] = {
        Coords = vec3(2349.9585, 3133.8518, 48.2088-.95),
        Nagroda = math.random(50000, 100000),
        Nazwa = "Zlom",
        Zostawic = 0,
        przejeciestrefy = false
    },
    
    ["S1"] = {
        Coords = vec3(1552.0565, 2198.5266, 78.8330-.95),
        Nagroda = math.random(50000, 100000),
        Nazwa = "S1",
        Zostawic = 0,
        przejeciestrefy = false
    },

    ["Doki"] = {
        Coords = vec3(140.2631, -2447.3926, 5.9996-.95),
        Nagroda = math.random(50000, 100000),
        Nazwa = "Doki",
        Zostawic = 0,
        przejeciestrefy = false
    },

    ["Miasto"] = {
        Coords = vec3(1202.0134, -1323.1427, 35.2268-.95),
        Nagroda = math.random(50000, 100000),
        Nazwa = "Miasto",
        Zostawic = 0,
        przejeciestrefy = false
    },
}

Config['napady'] = {}
Config['napady'].HackingItem = 'rob_laptop'
Config['napady'].Banks = {
    ["Lifeinvader"] = {
        coords = vector3(-1052.65, -232.69, 44.02),
        money = {min = 500000, max = 750000},
        bankName = "Lifeinvader",
        secondsRemaining = 300,
        PoliceRequired = 4,
        Blip = {
            name = 'Napad na Lifeinvader',
            sprite = 521,
            colour = 1,
            scale = 0.6,
        },
        RequiredItems = {
            {name = 'rob_lifeinvader', count = 1}
        },
        Drop = {
            {name = 'rob_lifeinvader', countMin = 1, countMax = 1, chance = 70},
            {name = 'datadrive', countMin = 1, countMax = 1, chance = 50},
            {name = 'rob_laptop', countMin = 1, countMax = 1, chance = 10},
        }
    },
    ["Liquidy"] = {
        coords = vector3(-163.3943, 6318.6738, 31.5951),
        money = {min = 120000, max = 300000},
        bankName = "Liquidy",
        secondsRemaining = 300,
        PoliceRequired = 2,
        Blip = {
            name = 'Napad na Liquidy',
            sprite = 93,
            colour = 5,
            scale = 0.6,
        },
        RequiredItems = {
            {name = 'rob_lifeinvader', count = 1}
        },
        Drop = {
            {name = 'rob_lifeinvader', countMin = 1, countMax = 1, chance = 70},
            {name = 'mdma', countMin = 1, countMax = 15, chance = 40},
            {name = 'energydrink', countMin = 1, countMax = 15, chance = 40},
        }
    },
    ["Jubiler"] = {
        coords = vector3(-630.79, -229.19, 38.06),
        money = {min = 800000, max = 1000000},
        bankName = "Jubiler",
        secondsRemaining = 300,
        PoliceRequired = 4,
        Blip = {
            name = 'Napad na Jubilera',
            sprite = 727,
            colour = 1,
            scale = 0.6,
        },
        RequiredItems = {
            {name = 'rob_lifeinvader', count = 1}
        },
        Drop = {
            {name = 'rob_laptop', countMin = 1, countMax = 1, chance = 60},
            {name = 'goldring', countMin = 1, countMax = 1, chance = 50},
            {name = 'oldpainting', countMin = 1, countMax = 1, chance = 20},
            {name = 'rob_card_pacific', countMin = 1, countMax = 1, chance = 15},
            {name = 'ruby', countMin = 1, countMax = 1, chance = 10},
            {name = 'rob_lifeinvader', countMin = 1, countMax = 1, chance = 5},
        }
    },
    ["FleecaVespucciBoulevard"] = {
        coords = vector3(147.0, -1044.86, 29.47),
        money = {min = 1150000, max = 1500000},
        bankName = "Fleeca Bank (Vespucci Boulevard)",
        secondsRemaining = 300,
        PoliceRequired = 1,
        Blip = {
            name = 'Napad na bank',
            sprite = 618,
            colour = 1,
            scale = 0.6,
        },
        RequiredItems = {
            {name = 'rob_laptop', count = 1}
        },
        Drop = {
            {name = 'rob_card_pacific', countMin = 1, countMax = 1, chance = 60},
            {name = 'debentures', countMin = 1, countMax = 1, chance = 50},
            {name = 'rob_lifeinvader', countMin = 1, countMax = 1, chance = 15},
            {name = 'rob_pendrive_casino', countMin = 1, countMax = 1, chance = 5},
        }
    },
    ["FleecaBoulevardDelPerro"] = {
        coords = vector3(-1211.65, -335.63, 37.79),
        money = {min = 1150000, max = 1500000},
        bankName = "Fleeca Bank (Boulevard Del Perro)",
        secondsRemaining = 300,
        PoliceRequired = 5,
        Blip = {
            name = 'Napad na bank',
            sprite = 618,
            colour = 1,
            scale = 0.6,
        },
        RequiredItems = {
            {name = 'rob_laptop', count = 1}
        },
        Drop = {
            {name = 'rob_card_pacific', countMin = 1, countMax = 1, chance = 60},
            {name = 'debentures', countMin = 1, countMax = 1, chance = 50},
            {name = 'rob_lifeinvader', countMin = 1, countMax = 1, chance = 15},
            {name = 'rob_pendrive_casino', countMin = 1, countMax = 1, chance = 5},
        }
    },
    ["FleecaGreatOceanHighway"] = {
        coords = vector3(-2957.52, 481.71, 15.7),
        money = {min = 1150000, max = 1500000},
        bankName = "Fleeca Bank (Great Ocean Highway)",
        secondsRemaining = 300,
        PoliceRequired = 5,
        Blip = {
            name = 'Napad na bank',
            sprite = 618,
            colour = 1,
            scale = 0.6,
        },
        RequiredItems = {
            {name = 'rob_laptop', count = 1}
        },
        Drop = {
            {name = 'rob_card_pacific', countMin = 1, countMax = 1, chance = 60},
            {name = 'debentures', countMin = 1, countMax = 1, chance = 50},
            {name = 'rob_lifeinvader', countMin = 1, countMax = 1, chance = 15},
            {name = 'rob_pendrive_casino', countMin = 1, countMax = 1, chance = 5},
        }
    },
    ["FleecaHawickAvenue"] = {
        coords = vector3(-353.57, -54.08, 49.04),
        money = {min = 1150000, max = 1500000},
        bankName = "Fleeca Bank (Hawick Avenue)",
        secondsRemaining = 300,
        PoliceRequired = 5,
        Blip = {
            name = 'Napad na bank',
            sprite = 618,
            colour = 1,
            scale = 0.6,
        },
        RequiredItems = {
            {name = 'rob_laptop', count = 1}
        },
        Drop = {
            {name = 'rob_card_pacific', countMin = 1, countMax = 1, chance = 60},
            {name = 'debentures', countMin = 1, countMax = 1, chance = 50},
            {name = 'rob_lifeinvader', countMin = 1, countMax = 1, chance = 15},
            {name = 'rob_pendrive_casino', countMin = 1, countMax = 1, chance = 5},
        }
    },
    ["FleecaHawickAvenue2"] = {
        coords = vector3(311.4, -283.19, 54.16),
        money = {min = 1150000, max = 1500000},
        bankName = "Fleeca Bank (Hawick Avenue 2)",
        secondsRemaining = 300,
        PoliceRequired = 5,
        Blip = {
            name = 'Napad na bank',
            sprite = 618,
            colour = 1,
            scale = 0.6,
        },
        RequiredItems = {
            {name = 'rob_laptop', count = 1}
        },
        Drop = {
            {name = 'rob_card_pacific', countMin = 1, countMax = 1, chance = 60},
            {name = 'debentures', countMin = 1, countMax = 1, chance = 50},
            {name = 'rob_lifeinvader', countMin = 1, countMax = 1, chance = 15},
            {name = 'rob_pendrive_casino', countMin = 1, countMax = 1, chance = 5},
        }
    },
    ["FleecaRoute68"] = {
        coords = vector3(1176.28, 2711.66, 38.09),
        money = {min = 1150000, max = 1500000},
        bankName = "Fleeca Bank (Route 68)",
        secondsRemaining = 300,
        PoliceRequired = 5,
        Blip = {
            name = 'Napad na bank',
            sprite = 618,
            colour = 1,
            scale = 0.6,
        },
        RequiredItems = {
            {name = 'rob_laptop', count = 1}
        },
        Drop = {
            {name = 'rob_card_pacific', countMin = 1, countMax = 1, chance = 60},
            {name = 'debentures', countMin = 1, countMax = 1, chance = 50},
            {name = 'rob_lifeinvader', countMin = 1, countMax = 1, chance = 15},
            {name = 'rob_pendrive_casino', countMin = 1, countMax = 1, chance = 5},
        }
    },
    ["BlaineCounty"] = {
        coords = vector3(-103.77, 6477.87, 31.63),
        money = {min = 1150000, max = 1500000},
        bankName = "Blaine County Savings Bank",
        secondsRemaining = 300,
        PoliceRequired = 5,
        Blip = {
            name = 'Napad na bank',
            sprite = 618,
            colour = 1,
            scale = 0.6,
        },
        RequiredItems = {
            {name = 'rob_laptop', count = 1}
        },
        Drop = {
            {name = 'rob_card_pacific', countMin = 1, countMax = 1, chance = 60},
            {name = 'debentures', countMin = 1, countMax = 1, chance = 50},
            {name = 'rob_lifeinvader', countMin = 1, countMax = 1, chance = 15},
            {name = 'rob_pendrive_casino', countMin = 1, countMax = 1, chance = 5},
        }
    },
    ["PacificBank"] = {
        coords = vector3(255.69, 225.27, 101.88),
        money = {min = 1700000, max = 2200000},
        bankName = "Pacific Standard Bank",
        secondsRemaining = 480,
        PoliceRequired = 6,
        Blip = {
            name = 'Napad na Pacific',
            sprite = 618,
            colour = 1,
            scale = 0.6,
        },
        RequiredItems = {
            {name = 'rob_card_pacific', count = 1}
        },
        Drop = {
            {name = 'rob_lifeinvader', countMin = 1, countMax = 1, chance = 50},
            {name = 'goldnecklace', countMin = 1, countMax = 1, chance = 50},
            {name = 'rob_laptop', countMin = 1, countMax = 1, chance = 20},
            {name = 'smallgoldbar', countMin = 1, countMax = 1, chance = 15},
            {name = 'rob_pendrive_casino', countMin = 1, countMax = 1, chance = 10},
        }
    },
    ["Humane"] = {
        coords = vector3(3540.97, 3667.24, 28.12),
        money = {min = 4500000, max = 6000000},
        bankName = "Humane Labs",
        secondsRemaining = 600,
        PoliceRequired = 10,
        Blip = {
            name = 'Napad na Humane Labs',
            sprite = 618,
            colour = 1,
            scale = 0.8,
        },
        RequiredItems = {
            {name = 'rob_laptop_humane', count = 1}
        },
        Drop = {
            {name = 'vials', countMin = 1, countMax = 1, chance = 60},
            {name = 'rob_blowpipe_hangar', countMin = 1, countMax = 1, chance = 30},
            {name = 'documentshumane', countMin = 1, countMax = 1, chance = 5},
        }
    },
    -- ["Hangar"] = {
    --     coords = vector3(590.1, -3281.13, 6.07),
    --     money = {min = 5500000, max = 7500000},
    --     bankName = "Hangar",
    --     secondsRemaining = 600,
    --     PoliceRequired = 10,
    --     Blip = {
    --         name = 'Napad na Hangar',
    --         sprite = 618,
    --         colour = 1,
    --         scale 6 0.8,
    --     },
    --     RequiredItems = {
    --         {name = 'rob_blowpipe_hangar', count = 1}
    --     },
    --     Drop = {
    --         {name = 'laptopwithdata', countMin = 1, countMax = 1, chance = 50},
    --         {name = 'rob_pendrive_casino', countMin = 1, countMax = 1, chance = 20},
    --         {name = 'weaponchest', countMin = 1, countMax = 1, chance = 15},
    --         {name = 'rob_laptop_humane', countMin = 1, countMax = 1, chance = 10},
    --         {name = 'documentscode', countMin = 1, countMax = 1, chance = 10},
    --         {name = 'empcrate', countMin = 1, countMax = 1, chance = 5},
    --         {name = 'anziosniper', countMin = 1, countMax = 1, chance = 5},
    --     }
    -- },
}

Config["prace"] = {}
Config["prace"].Jail = {
    coords = vec3(1693.8465576172, 2585.1259765625, 45.564846038818),
    radius = 120.0,
}

Config["prace"].JailSpawn = vec3(1679.9174804688, 2513.3332519531, 45.564861297607)
Config["prace"].AfterJailSpawn = vec3(2052.6382, 3182.6848, 45.1689-0.9)

Config["prace"].PraceSpoleczne = {
    vec3(1691.894775, 2516.672852, 45.564888-0.9),
    vec3(1663.928345, 2517.940674, 45.564888-0.9),
    vec3(1658.281616, 2498.062500, 45.564888-0.9),
    vec3(1628.027466, 2502.552002, 45.564888-0.9),
    vec3(1630.792480, 2532.129639, 45.564888-0.9),
    vec3(1647.367920, 2559.983398, 45.564888-0.9),
    vec3(1621.707520, 2564.772949, 45.564877-0.9),
    vec3(1702.622070, 2560.808350, 45.564892-0.9),
    vec3(1752.205933, 2560.914307, 45.564980-0.9),
    vec3(1766.044434, 2537.213379, 45.565033-0.9),
    vec3(1742.210205, 2510.793701, 45.565018-0.9),
}

Config["newplr"] = {
    skin = {
        ["m"] = {
            sex = 0,
            mom = 43,
            dad = 29,
            face_md_weight = 61,
            skin_md_weight = 27,
            nose_1 = -5,
            nose_2 = 6,
            nose_3 = 5,
            nose_4 = 8,
            nose_5 = 10,
            nose_6 = 0,
            cheeks_1 = 0,
            cheeks_2 = 0,
            cheeks_3 = 0,
            lip_thickness = 0,
            jaw_1 = 0,
            jaw_2 = 0,
            chin_1 = 0,
            chin_2 = 0,
            chin_13 = 0,
            chin_4 = 0,
            neck_thickness = 0,
            hair_1 = 0,
            hair_2 = 0,
            hair_color_1 = 0,
            hair_color_2 = 0,
            tshirt_1 = 15,
            tshirt_2 = 0,
            torso_1 = 0,
            torso_2 = 0,
            decals_1 = 0,
            decals_2 = 0,
            arms = 0,
            arms_2 = 0,
            pants_1 = 7,
            pants_2 = 0,
            shoes_1 = 149,
            shoes_2 = 2,
            mask_1 = 0,
            mask_2 = 0,
            bproof_1 = 0,
            bproof_2 = 0,
            chain_1 = 0,
            chain_2 = 0,
            helmet_1 = -1,
            helmet_2 = 0,
            glasses_1 = 0,
            glasses_2 = 0,
            watches_1 = -1,
            watches_2 = 0,
            bracelets_1 = -1,
            bracelets_2 = 0,
            bags_1 = 0,
            bags_2 = 0,
            eye_color = 0,
            eye_squint = 0,
            eyebrows_2 = 0,
            eyebrows_1 = 0,
            eyebrows_3 = 0,
            eyebrows_4 = 0,
            eyebrows_5 = 0,
            eyebrows_6 = 0,
            makeup_1 = 0,
            makeup_2 = 0,
            makeup_3 = 0,
            makeup_4 = 0,
            lipstick_1 = 0,
            lipstick_2 = 0,
            lipstick_3 = 0,
            lipstick_4 = 0,
            ears_1 = -1,
            ears_2 = 0,
            chest_1 = 0,
            chest_2 = 0,
            chest_3 = 0,
            bodyb_1 = -1,
            bodyb_2 = 0,
            bodyb_3 = -1,
            bodyb_4 = 0,
            age_1 = 0,
            age_2 = 0,
            blemishes_1 = 0,
            blemishes_2 = 0,
            blush_1 = 0,
            blush_2 = 0,
            blush_3 = 0,
            complexion_1 = 0,
            complexion_2 = 0,
            sun_1 = 0,
            sun_2 = 0,
            moles_1 = 0,
            moles_2 = 0,
            beard_1 = 0,
            beard_2 = 0,
            beard_3 = 0,
            beard_4 = 0
        },
    },
}


Config['healer'] = {}
Config['healer'].HealerPrice = 10000
Config['healer'].Healers = {
    vector4(2062.7375, 3197.0903, 44.1865, 148.3685), -- sandy
    vector4(2670.2277, 3286.5056, 54.2405, 67.2564), -- SENORA
    vector4(1017.2622, -2529.2080, 28.3014-9, 86.6641)
}

Config['gps'] = {
    police = {
        color = 3,
        label = 'SASP'
    },
}

Config['greenzone'] = {
    Zones = {
        ['greenzone1'] = {
            size = 50.0,
            coords = vector3(-1355.2723, 57.5843, 56.7119),
            name = "Greenzone",
            r = 135,
            g = 75,
            b = 255,
            color = 50,
            sprite = 487,
            opacity = 75,
            addRadius = true, 
            addBlip = true
        },
        ['greenzone2'] = {
            size = 50.0,
            coords = vector3(2643.1401, 3273.1853, 55.2205),
            name = "Greenzone",
            r = 135,
            g = 75,
            b = 255,
            color = 50,
            sprite = 487,
            opacity = 75,
            addRadius = true,
            addBlip = true
        },

        ['greenzone4'] = {
            size = 18.0,
            coords = vector3(-413.0354, -2799.2358, 6.0004),
            name = "",
            r = 24,
            g = 255,
            b = 8,
            color = 2,
            sprite = 487,
            opacity = 35,
            addRadius = true,
        },    
        ['wiezienie'] = {
            size = 150.0,
            coords = vector3(1718.5960693359, 2565.2028808594, 45.564910888672),
            name = "Wiezienie",
            r = 255,
            g = 75,
            b = 0,
            color = 1,
            sprite = 237,
            opacity = 55,
            addRadius = true,
            addBlip = true
        },
        ['policja2'] = {
            size = 55.0,
            coords = vector3(1841.1799, 3684.6179, 42.7221), 
            name = "Komenda Policji",
            r = 8,
            g = 86,
            b = 255,
            color = 38,
            sprite = 487,
            opacity = 50,
            addRadius = true,
            addBlip = true
        },
        ['cardealer'] = { -- Sprzedawca Aut
            size = 25.0,
            coords = vector3(1224.6292, 2728.2085, 37.0048),
            name = "Car Dealer",
            r = 245,
            g = 141,
            b = 66,
            color = 5,
            sprite = 488,
            opacity = 50,
            addRadius = true,
            addBlip = true
        },

    }
}

Config['duelki'] = {}
Config['duelki'].awaitingPeople = 0
Config['duelki'] = {
    duel = {
        vector4(2039.0078, 3189.1504, 45.1689-0.95, 259.1194),
    },
    spawn = {
        vector3(2039.0078, 3189.1504, 45.1689-0.95),
    },
    arena = {
        {
            arenaName = 'Arena Losty',
            arenaMarker = vector3(2337.0928, 2540.0686, 46.6674),
            arenaRadius = 50.0,
            spawnpoints = {
                [1] = vector3(2326.9233, 2513.5061, 46.6677-.95),
                [2] = vector3(2337.2244, 2580.7288, 46.6676-.95),
            },
        },
        {
            arenaName = 'Arena Elektrownia',
            arenaMarker = vector3(2449.8640, 1533.2047, 35.2247),
            arenaRadius = 40.0,
            spawnpoints = {
                [1] = vector3(2482.9194, 1533.6399, 34.8363-.95),
                [2] = vector3(2418.7539, 1530.3372, 34.9398-.95),
            },
        },
        {
            arenaName = "Arena S1",
            arenaMarker = vec3(1553.3791503906, 2174.8005371094, 79.997268676758),
            arenaRadius = 70.0,
            spawnpoints = {
                [1] = vec3(1551.7551269531, 2150.7856445313, 78.807807922363-.95),
                [2] = vec3(1552.7907714844, 2192.1752929688, 78.8666229248050-.95),
            },
        },
    },
}

Config['shops'] = {
    coords = {
        shop = {
            vector3(374.9206, 326.1583, 103.5664-0.90),
            vector3(2556.8171, 383.3371, 108.6230-0.90),
            vector3(-3040.4226, 586.6751, 7.9089-0.90),
            vector3(-3242.4260, 1002.4668, 12.8307-0.90),
            vector3(546.6525, 2670.7144, 42.1565-0.90),
            vector3(1962.1230, 3741.5156, 32.3437-0.90),
            vector3(2678.9941, 3281.7520, 55.2411-0.90),
            vector3(1730.2571, 6414.2749, 35.0372-0.90),
            vector3(26.9792, -1347.0518, 29.4970-0.90),
            vector3(162.5157, 6640.0479, 31.6989-0.90),
            vector3(-48.3971, -1756.7395, 29.4210-0.90),
            vector3(1162.5979, -323.0528, 69.2052-0.90),
            vector3(-708.1859, -913.5256, 19.2156-0.90),
            vector3(-1821.6212, 792.7845, 138.1285-0.90),
            vector3(1699.2975, 4924.6387, 42.0637-0.90)
        },
        shopGreenzone = {
            vector4(2070.8794, 3191.3936, 44.1865, 114.5942), -- SANDY
            -- vector4(1017.9815, -2522.7595, 27.3014, 78.2599), -- DOKI 1017.9815, -2522.7595, 28.3014, 78.2599
        },
    }
}

Config['shops'].items = {
    shop = {
        {label = 'Energetyk', item = 'energydrink', price = 5000},
        {label = 'Krótkofalówka', item = 'radiocrime', price = 17000},
        {label = 'Zestaw naprawczy', item = 'repairkit', price = 15000},
        {label = 'Kajdanki', item = 'handcuffs', price = 25000},
        {label = 'Laptop do hackowania', item = 'rob_laptop', price = 70000},
        {label = 'Łom do napadu', item = 'rob_lifeinvader', price = 90000},
    },
    shopGreenzone = {
        {label = 'Energetyk', item = 'energydrink', price = 5000},
        {label = 'Krótkofalówka', item = 'radiocrime', price = 17000},
        {label = 'Magazynek do pistoletu', item = 'pistol_ammo_box', price = 1000},
        {label = 'Zestaw naprawczy', item = 'repairkit', price = 15000},
        {label = 'Kajdanki', item = 'handcuffs', price = 25000},
        {label = 'Laptop do hackowania', item = 'rob_laptop', price = 70000},
        {label = 'Łom do napadu', item = 'rob_lifeinvader', price = 90000},
        {label = 'Latarka do broni', item = 'flashlight', price = 35000},
        {label = 'Tlumik', item = 'suppressor', price = 70000},
        {label = 'Pistolet', item = 'pistol', price = 20000},
        {label = 'Pistolet Mk.II', item = 'pistol_mk2', price = 30000},
        {label = 'Pistolet SNS Mk.II', item = 'snspistol_mk2', price = 50000},
        {label = 'Pistolet Vintage', item = 'vintagepistol', price = 50000},
        {label = 'Pistolet Ceramiczny', item = 'ceramicpistol', price = 120000},
        {label = 'Pistolet Heavy', item = 'heavypistol', price = 200000},
    },
    sell = {
        {label = 'Energetyk', item = 'energydrink', price = 2500},
        {label = 'Krótkofalówka', item = 'radiocrime', price = 6000},
        {label = 'Magazynek do pistoletu', item = 'pistol_ammo_box', price = 250},
        {label = 'Zestaw naprawczy', item = 'repairkit', price = 5000},
        {label = 'Kajdanki', item = 'handcuffs', price = 11000},
        {label = 'Laptop do hackowania', item = 'rob_laptop', price = 30000},
        {label = 'Łom do napadu', item = 'rob_lifeinvader', price = 44000},
        {label = 'Latarka do broni', item = 'flashlight', price = 12000},
        {label = 'Tlumik', item = 'suppressor', price = 20000},
        {label = 'Pistolet', item = 'pistol', price = 10000},
        {label = 'Pistolet Mk.II', item = 'pistol_mk2', price = 14000},
        {label = 'Pistolet SNS Mk.II', item = 'snspistol_mk2', price = 25000},
        {label = 'Pistolet Vintage', item = 'vintagepistol', price = 25000},
        {label = 'Pistolet Ceramiczny', item = 'ceramicpistol', price = 28000},
        {label = 'Pistolet Heavy', item = 'heavypistol', price = 100000},
    },
    -- darkshop = {
    --     {label = 'Energetyk', item = 'energydrink', price = 1250},
    --     {label = 'Krótkofalówka', item = 'radiocrime', price = 5000},
    --     {label = 'Magazynek do pistoletu', item = 'pistol_ammo_box', price = 6250},
    --     {label = 'Magazynek do karabinu', item = 'rifle_ammo_box', price = 500000},
    --     {label = 'Magazynek do smg', item = 'smg_ammo_box', price = 250000},
    --     {label = 'Kajdanki', item = 'handcuffs', price = 10000},
    --     {label = 'Laptop do hackowania', item = 'rob_laptop', price = 25000},
    --     {label = 'Łom do napadu', item = 'rob_lifeinvader', price = 30000},
    --     {label = 'Standardowy magazynek', item = 'clip_default', price = 15000},
    --     {label = 'Rozszerzony magazynek', item = 'clip_extended', price = 20000},
    --     {label = 'Latarka do broni', item = 'flashlight', price = 15000},
    --     {label = 'Tlumik', item = 'suppressor', price = 25000},
    --     {label = 'Pistolet', item = 'pistol', price = 50000},
    --     {label = 'Pistolet (MK II)', item = 'pistol_mk2', price = 70000},
    --     {label = 'Pistolet SNS (MK II)', item = 'snspistol_mk2', price = 125000},
    --     {label = 'Pistolet Vintage', item = 'vintagepistol', price = 125000},
    --     {label = 'Pistolet Ceramiczny', item = 'ceramicpistol', price = 140000},
    --     {label = 'Pistolet Heavy', item = 'heavypistol', price = 500000},
    -- },
}

Config['clotheshop'] = {
    Price = 1000,
    Shops = {
        vector3(75.3675, -1398.3821, 29.3785-0.90),
        vector3(-710.3318, -161.6475, 37.4153-0.90),
        vector3(-156.4907, -297.4386, 39.7334-0.90),
        vector3(425.2813, -800.7861, 29.4935-0.90),
        vector3(-827.0078, -1075.9574, 11.3304-0.90),
        vector3(-1458.8124, -239.7576, 49.8013-0.90),
        vector3(9.0692, 6515.7617, 31.8801-0.90),
        vector3(124.3844, -219.1595, 54.5577-0.90),
        vector3(1693.7871, 4828.1216, 42.0655-0.90),
        vector3(617.4639, 2759.2559, 42.0883-0.90),
        vector3(1191.4226, 2710.5498, 38.2250-0.90),
        vector3(-1194.4746, -772.3811, 17.3235-0.90),
        vector3(-3171.5891, 1048.3875, 20.8634-0.90),
        vector3(-1105.3882, 2707.1033, 19.1102-0.90)
    }
}

Config['barbershop'] = {
    Price = 300,
    Shops = {
        -- vector3(-814.2688, -183.7940, 37.5741-0.90),
        -- vector3(136.7658, -1708.3912, 29.2919-0.90),
        -- vector3(-1281.9149, -1117.4049, 6.9904-0.90),
        vector3(1931.4818, 3731.4314, 32.8446-0.90)
        -- vector3(1213.3481, -473.4205, 66.2082-0.90)
        -- vector3(-33.7514, -153.5050, 57.0768-0.90),
        -- vector3(-277.8112, 6227.0718, 31.6958-0.90)
    }
}

Config['deposit'] = {}
Config['deposit'].Zones = {
    vector4(2053.8901, 3202.1567, 44.1865, 160.5008), -- SANDY
    vector4(1017.6010, -2529.2217, 28.3014-.95, 86.2859), -- DOKI
}

Config['extras'] = {}
Config['extras'].Zones = {
    vector3(456.47, -1024.22, 27.44), -- komenda pd
    vector3(1856.71, 3705.40, 32.71), -- sandy
    vector3(-478.92, 6020.98, 30.44), -- paleto
}

Config['orgs'] = {}
Config['orgs'] = {
    Zones = {
        vector4(2046.1876, 3204.7234, 44.1865, 192.6900), -- GREENZONE SANDY
        vector4(1017.5738, -2511.4224, 28.4482-.95, 131.8560), -- GREENZONE DOKI
    },
    upgrades = {
        handcuffs = {label = 'Kajdanki', price = 2000000, f6menu = true, time = 7*24*60*60},
        repairkit = {label = 'Naprawka', price = 800000, f6menu = true, time = 7*24*60*60},
    },
}

Config['strefy'] = {}
Config['strefy'].Zones = {
    {name = "Lotnisko Grapeseed", coords = vector3(2134.29, 4784.87, 39.95), size = 10.0, hours = {14, 20, 23, 2}},
    {name = "Wiatraki", coords = vector3(2300.58, 1969.98, 130.12), size = 10.0, hours = {16, 19, 22, 1}},
    {name = "Tartak", coords = vector3(-572.04, 5341.61, 69.32), size = 10.0, hours = {18, 21, 0, 3}},
    {name = "Losty", coords = vector3(53.3, 3708.43, 38.86), size = 10.0, hours = {16, 19, 22, 1}},
    {name = "Mini Losty", coords = vector3(2329.85, 2557.35, 45.77), size = 10.0, hours = {17, 20, 23, 2}},
    {name = "Kościół", coords = vector3(-299.61, 2802.09, 58.26), size = 10.0, hours = {18, 21, 0, 3}},
}

Config['jobs'] = {
    forklift = {
        salary = {7000, 9000},
        startPos = vector4(890.3096, -2339.2317, 29.3407, 244.8064),
        vehPos = vector4(857.0834, -2354.1597, 29.1367, 37.7945),
        props = {
            {model = `prop_boxpile_05a`, offsets = vector3(0.0, 0.35, -0.1)},
            {model = `prop_boxpile_06a`, offsets = vector3(0.0, 0.35, -0.1)},
            {model = `prop_boxpile_06b`, offsets = vector3(0.0, 0.35, -0.1)},
            {model = `prop_boxpile_08a`, offsets = vector3(0.0, 0.35, -0.1)},
        },
        from = {
            vector4(842.5024, -2291.2383, 30.5118, 172.9452),
            vector4(978.3046, -2405.8330, 30.5096, 181.7824),
            vector4(999.7780, -2411.6089, 30.5090, 354.4273),
            vector4(988.1561, -2273.3364, 30.5095, 184.2363),
            vector4(994.3903, -2239.2075, 30.5517, 56.1378),
            vector4(951.3035, -2180.5691, 30.5516, 49.3159),
            vector4(951.9077, -2111.4470, 30.5523, 357.7855),
            vector4(856.2604, -2129.0137, 30.5877, 182.5681),
            vector4(832.2172, -2138.3989, 29.4404, 286.5756),
            vector4(889.4974, -2214.6367, 30.5097, 56.4141),
            vector4(810.3619, -2402.4492, 23.6577, 111.6169),
            vector4(886.7855, -2374.6052, 28.0678, 72.5467),
            vector4(883.8558, -2176.4683, 30.5193, 64.5750),
            vector4(805.3841, -2223.5037, 29.5229, 80.9962),
            vector4(873.3281, -2198.2732, 30.5194, 268.8375),
            vector4(871.7912, -2134.7935, 30.5744, 5.7287),
            vector4(801.9562, -2133.1614, 29.4489, 236.1185),
            vector4(994.8274, -2374.2532, 30.5316, 356.8832),
            vector4(941.9114, -2166.5305, 30.5446, 93.9618),
            vector4(930.6682, -2256.2993, 30.5096, 35.4843),
            vector4(874.7456, -2050.9900, 30.4535, 350.2134),
            vector4(1090.6476, -2280.4851, 30.1588, 88.8690),
            vector4(1091.1750, -2276.9614, 30.1642, 91.6281),
            vector4(1021.1329, -2270.4238, 30.5018, 81.2621),
            vector4(1059.9592, -2409.9263, 29.9460, 263.8707),
            vector4(1074.6866, -2444.3135, 29.3043, 279.4186),
            vector4(985.8066, -2288.2412, 30.5095, 84.4437),
            vector4(834.8708, -2089.8201, 29.9465, 177.0674),
            vector4(789.6063, -2192.8105, 29.5482, 275.1080),
            vector4(927.6157, -2492.0396, 29.5712, 175.6673)
        },
        to = {
            vector3(866.0005, -2356.9758, 31.5155),
            vector3(838.0111, -2430.5886, 27.9819),
            vector3(976.9747, -2220.7502, 31.5466),
            vector3(960.2709, -2105.7932, 31.9527),
            vector3(1097.7413, -2228.0762, 31.3040),
            vector3(1039.7272, -2170.2998, 31.5217),
            vector3(922.8155, -2031.7886, 30.3852),
            vector3(1040.1335, -2203.2158, 31.8884)
        },
    },
    trucker = {
        salary = {13000, 15000}, -- per kilometr (x2 jeśli specialny ładunek, 3/4 jeśli tanker)
        trucks = {`hauler`, `hauler`, `packer`, `phantom`, `phantom3`},
        startPos = vector4(1190.8571, -3252.9617, 5.0288, 49.3610),
        vehPos = vector4(1186.1365, -3200.6614, 5.0220, 89.8464),
        missions = {
            classic = {
                vector4(607.3640, -2996.9221, 6.0452, 180.00),
                vector4(209.9916, -3326.8369, 5.7936, 267.4590),
                vector4(-498.6792, -2735.8037, 6.0002, 314.3535),
                vector4(-1191.9778, -2154.0151, 13.1953, 134.1842),
                vector4(-731.0346, 5814.9731, 17.3774, 271.8192),
                vector4(-262.5296, 6041.4907, 31.8779, 51.9289),
                vector4(39.7656, 6535.9473, 31.4676, 76.0936),
                vector4(-60.9929, 6538.1294, 31.4908, 223.0757),
                vector4(-2175.8098, 4269.7803, 48.9851, 323.4333),
                vector4(276.0698, 2857.3716, 43.6424, 302.4147),
                vector4(350.1084, 3417.4866, 36.4037, 111.6568),
                vector4(1958.1570, 3766.4863, 32.2011, 120.7159),
                vector4(2917.2534, 4342.5781, 50.3035, 18.7911),
                vector4(3574.8213, 3665.1204, 33.8929, 82.5414),
                vector4(1776.2816, 4592.7661, 37.7353, 186.2077),
                vector4(2986.4063, 3504.9316, 71.3818, 290.8155),
                vector4(2354.4102, 3161.1208, 48.1232, 115.3398),
                vector4(1569.1591, -1681.4037, 88.1698, 200.0994),
                vector4(539.3951, -2737.3457, 6.0563, 332.7749),
                vector4(522.9597, -2107.6978, 5.9847, 193.5402),
                vector4(-389.1099, -2282.3325, 7.6081, 271.9233),
                vector4(-1228.3540, -2350.8247, 13.9451, 240.8446),
                vector4(-572.5042, -1786.1061, 22.5719, 142.8810),
                vector4(-740.0598, -1500.6355, 5.0005, 111.3432),
                vector4(2681.5525, 2808.1843, 40.4846, 359.0283),
                vector4(874.3199, 2340.1194, 51.6807, 314.8961),
                vector4(2936.0413, 2798.3242, 40.8415, 299.6329),
                vector4(1374.2998, -739.5914, 67.2328, 77.8153),
                vector4(-748.7315, -2577.7490, 13.8398, 240.2334),
                vector4(-1171.0497, -1771.1201, 3.8579, 302.6873),
                vector4(201.3128, 1247.2950, 225.4598, 266.7689),
                vector4(1531.7406, 788.6993, 77.4511, 59.8403),
            },
            tanker = {
                from = {
                    vector4(1696.7732, -1453.7588, 112.6727, 170.3730),
                    vector4(1681.2053, -1857.0042, 108.0796, 164.3849),
                    vector4(1513.4393, -1741.6927, 78.5909, 345.3297),
                    vector4(2785.3669, 1710.5214, 24.6283, 88.3378),
                    vector4(536.2256, 2868.1770, 43.3354, 211.5320),
                    vector4(496.7534, 2974.9971, 41.6478, 350.0106),
                    vector4(1704.6636, -1922.9375, 115.2161, 128.8149),
                    vector4(1528.3058, -2058.1880, 77.2701, 25.3782),
                },
                to = {
                    vector4(-41.3752, -1742.9253, 29.1302, 52.2758),
                    vector4(-528.6430, -1209.5024, 18.1848, 63.2551),
                    vector4(-729.3237, -915.0656, 19.0140, 174.2238),
                    vector4(806.9131, -1043.8743, 26.5895, 95.4534),
                    vector4(1185.8971, -314.4765, 69.1778, 276.6314),
                    vector4(-358.4698, -1453.0265, 29.3630, 355.8746),
                    vector4(2566.1743, 386.0435, 108.4628, 358.5215),
                    vector4(-2552.3408, 2322.0945, 33.0601, 273.0183),
                    vector4(243.6884, 2599.5876, 45.1201, 278.9438),
                    vector4(-1802.4338, 799.4047, 138.5133, 41.1462),
                    vector4(1026.3660, 2660.7456, 39.5511, 0.6487),
                    vector4(1780.2085, 3338.3325, 41.0288, 298.5201),
                    vector4(1990.1962, 3761.9399, 32.1804, 296.3390),
                    vector4(1711.4967, 4942.1064, 42.1282, 54.0912),
                    vector4(1691.3223, 6422.6694, 32.6076, 160.3700),
                    vector4(202.9715, 6599.1875, 31.6454, 183.8492),
                    vector4(-80.9089, 6431.2485, 31.4905, 43.6427),
                    vector4(-2071.0461, -303.7185, 13.1548, 86.2085),
                }
            },
            special = {
                {from = vector4(-801.6084, 5407.1606, 33.9519, 56.6685), to = vector4(2703.4055, 2779.2458, 37.8780, 120.00), model = `trailerlogs`},
                {from = vector4(-581.8106, 5250.9189, 70.4675, 153.9264), to = vector4(314.2983, -2758.2588, 5.9923, 91.5401), model = `trailerlogs`},
                {from = vector4(-623.2517, 5503.6230, 51.2166, 125.4951), to = vector4(1631.2722, -2237.7754, 107.2153, 199.2088), model = `trailerlogs`},

                {from = vector4(-438.8511, -2269.0322, 7.6081, 270.7429), to = vector4(1170.6531, -2967.8477, 5.9021, 271.9323), model = `docktrailer`},
                {from = vector4(938.6440, -2915.1011, 5.9021, 89.8493), to = vector4(-916.6487, -2769.3994, 13.9445, 149.5904), model = `docktrailer`},

                {from = vector4(1371.5837, -2224.7773, 60.7107, 71.0070), to = vector4(-2388.4531, 3348.6030, 32.8262, 237.6520), model = `armytanker`},

                {from = vector4(-1059.6901, -2014.0186, 13.1616, 135.00), to = vector4(-17.4218, -1101.7736, 26.6721, 161.0289), model = `tr4`},
                {from = vector4(-840.6275, -2669.1265, 13.8121, 236.2197), to = vector4(1216.4861, -3003.5017, 5.8654, 177.0383), model = `tr4`},
            }
        }
    }
}

Config['nigger'] = {
    {coords = vector4(-1203.2854, -1309.2472, 3.8899, 120.2210), model = `s_m_m_scientist_01`, items = {
        ["ruby"] = 600000,
        ["oldpainting"] = 200000,
        ["goldring"] = 50000,
        ["goldnecklace"] = 100000,
        ["cosmicweaponpart"] = 1000000,
        ["documentscode"] = 750000,
        ["goldencat"] = 450000,
        ["diamondcrown"] = 950000,
        ["debentures"] = 55000,
    }},
    {coords = vector4(706.7609, 4184.7070, 39.7092, 104.0351), model = `s_m_y_blackops_01`, items = {
        ["datadrive"] = 50000,
        ["mayanmask"] = 250000,
        ["largegoldbar"] = 650000,
        ["image17a"] = 450000,
        ["cosmicweaponpart2"] = 2000000,
        ["documentshumane"] = 750000,
        ["laptopwithdata"] = 450000,
        ["empcrate"] = 350000,
    }},
    {coords = vector4(-1600.7914, 5205.2466, 3.3101, 290.3232), model = `s_m_y_blackops_03`, items = {
        ["mammothbone"] = 250000,
        ["oldmusket"] = 150000,
        ["goldenmap"] = 600000,
        ["vials"] = 250000,
        ["anziosniper"] = 3500000,
        ["cosmicweaponpart3"] = 2500000,
        ["weaponchest"] = 550000,
        ["smallgoldbar"] = 250000,
        ["diamond"] = 500000,
    }},
    {coords = vector4(351.0528, -7.9418, 90.2642, 338.7268), model = `s_m_y_dealer_01`, items = {
        ["cosmicweapon"] = 10000000,
    }},
    {coords = vector4(2818.3240, 5971.9604, 349.5145, 226.3176), model = `a_c_rhesus`},
}

Config['weaponcomponents'] = {}
Config['weaponcomponents'].componentsList = {
    suppressor = {
        [`WEAPON_PISTOL`] = `COMPONENT_AT_PI_SUPP_02`,
        [`WEAPON_PISTOL_MK2`] = `COMPONENT_AT_PI_SUPP_02`,
        [`WEAPON_COMBATPISTOL`] = `COMPONENT_AT_PI_SUPP`,
        [`WEAPON_SNSPISTOL_MK2`] = `COMPONENT_AT_PI_SUPP_02`,
        [`WEAPON_HEAVYPISTOL`] = `COMPONENT_AT_PI_SUPP`,

        [`WEAPON_ASSAULTRIFLE`] = `COMPONENT_AT_AR_SUPP_02`,

        [`WEAPON_VINTAGEPISTOL`] = `COMPONENT_AT_PI_SUPP`,
        [`WEAPON_CERAMICPISTOL`] = `COMPONENT_CERAMICPISTOL_SUPP`,
        [`WEAPON_UMP45`] = `w_at_sb_ump45_supp`,
    },
    suppressor2 = {
        [`WEAPON_MICROSMG`] = `COMPONENT_AT_AR_SUPP_02`,
        [`WEAPON_SMG_MK2`] = `COMPONENT_AT_PI_SUPP`,
    },
    clip_extended = {
        [`WEAPON_UMP45`] = `w_sb_ump45_mag2`,
        [`WEAPON_SNSPISTOL`] = `COMPONENT_SNSPISTOL_CLIP_02`,
        [`WEAPON_SNSPISTOL_MK2`] = `COMPONENT_SNSPISTOL_MK2_CLIP_02`,
        [`WEAPON_VINTAGEPISTOL`] = `COMPONENT_VINTAGEPISTOL_CLIP_02`,
        [`WEAPON_PISTOL`] = `COMPONENT_PISTOL_CLIP_02`,
        [`WEAPON_PISTOL_MK2`] = `COMPONENT_PISTOL_MK2_CLIP_02`,
        [`WEAPON_COMBATPISTOL`] = `COMPONENT_COMBATPISTOL_CLIP_02`,
        [`WEAPON_HEAVYPISTOL`] = `COMPONENT_HEAVYPISTOL_CLIP_02`,
        [`WEAPON_CERAMICPISTOL`] = `COMPONENT_CERAMICPISTOL_CLIP_02`,
    },
    extendedclip2 = {
        [`WEAPON_MINISMG`] = `COMPONENT_MINISMG_CLIP_02`,
        [`WEAPON_MICROSMG`] = `COMPONENT_MICROSMG_CLIP_02`,
        [`WEAPON_SMG_MK2`] = `COMPONENT_SMG_MK2_CLIP_02`,
    },
    flashlight = {
        [`WEAPON_SNSPISTOL_MK2`] = `COMPONENT_AT_PI_FLSH_03`,
        [`WEAPON_PISTOL`] = `COMPONENT_AT_PI_FLSH`,
        [`WEAPON_PISTOL_MK2`] = `COMPONENT_AT_PI_FLSH_02`,
        [`WEAPON_COMBATPISTOL`] = `COMPONENT_AT_PI_FLSH`,
        [`WEAPON_HEAVYPISTOL`] = `COMPONENT_AT_PI_FLSH`,
    },
    scope = {
        [`WEAPON_UMP45`] = `w_at_sb_ump45_scope`,
        [`WEAPON_MICROSMG`] = `COMPONENT_AT_SCOPE_MACRO`,
        [`WEAPON_SMG_MK2`] = `COMPONENT_AT_SCOPE_MACRO_02_SMG_MK2`,
    },
    scope2 = {
        [`WEAPON_SMG_MK2`] = `COMPONENT_AT_SCOPE_SMALL_SMG_MK2`,
    },
    grip = {
        [`WEAPON_UMP45`] = `w_at_sb_ump45_grip`,
    },
}

Config['drugs'] = {
    weed = {
        field = {
            coords = vector3(-109.33, 1910.48, 196.2),
            title = 'Marihuana',
            text = 'zebrać marihuane',
            item = 'weed',
            blip = {
                sprite = 469,
                colour = 2,
                scale = 0.8,
            }
        },
        process = {
            coords = vector3(2224.36, 5576.92, 52.95),
            title = 'Marihuana',
            text = 'przerobić marihuane',
            item = 'weed_pooch',
            blip = {
                sprite = 469,
                colour = 2,
                scale = 0.8,
            }
        }
    },
    coke = {
        field = {
            coords = vector3(-336.14, -2437.95, 5.1),
            title = 'Kokaina',
            text = 'zebrać kokaine',
            item = 'coke',
            blip = {
                sprite = 514,
                scale = 0.8,
            }
        },
        process = {
            coords = vector3(1500.5876, -2133.5471, 75.3660),
            title = 'Kokaina',
            text = 'przerobić kokaine',
            item = 'coke_pooch',
            blip = {
                sprite = 514,
                scale = 0.8,
            }
        }
    },
    meth = {
        field = {
            coords = vector3(4863.3613, -4627.9639, 13.8607),
            title = 'Metamfetamina',
            text = 'zebrać metamfetamine',
            item = 'meth',
            blip = {
                sprite = 499,
                colour = 47,
                scale = 0.8,
            }
        },
        process = {
            coords = vector3(4900.7778, -5344.7666, 9.2469),
            title = 'Metamfetamina',
            text = 'przerobić metamfetamine',
            item = 'meth_pooch',
            blip = {
                sprite = 499,
                colour = 47,
                scale = 0.8,
            }
        }
    },
    fentanyl = {
        field = {
            coords = vector3(2813.9634, 1430.0619, 23.5877),
            title = 'Fentanyl',
            text = 'zebrać fentanyl',
            item = 'fentanyl',
            blip = {
                sprite = 51,
                colour = 26,
                scale = 0.8,
            }
        },
        process = {
            coords = vector3(3316.1228, 5190.6221, 17.5153),
            title = 'Fentanyl',
            text = 'przerobić fentanyl',
            item = 'fentanyl_pooch',
            blip = {
                sprite = 51,
                colour = 26,
                scale = 0.8,
            }
        }
    },
    heroin = {
        field = {
            coords = vector3(1552.3999, 2234.7886, 76.5477),
            title = 'Heroina',
            text = 'zebrać heroine',
            item = 'heroin',
            blip = {
                sprite = 497,
                colour = 35,
                scale = 0.8,
            }
        },
        process = {
            coords = vector3(2435.87, 4966.84, 41.45),
            title = 'Heroina',
            text = 'przerobić heroine',
            item = 'heroin_pooch',
            blip = {
                sprite = 497,
                colour = 35,
                scale = 0.8,
            }
        }
    },
}

Config['drugsSell'] = {
    coords = vec3(2443.1519, 4971.1567, 51.5649 - 0.95),
    text   = 'Sprzedaj narkotyki',               
    color  = { r = 227, g = 204, b = 246, a = 150 }, 

    blip = {
        sprite = 788,
        colour = 13,
        scale  = 0.8,
        text   = 'Skup narkotyków' 
    }
}


Config['licenses'] = {
    ['seu_pd'] = 'Licencja SEU',
    ['heli_pd'] = 'Licencja ASU',
    ['mr_pd'] = 'Licencja Motocykle',
    ['cs_pd'] = 'Licencja Zarząd',
    ['hwp_pd'] = 'Licencja HWP',
    ['cttf_pd'] = 'Licencja C.T.T.F'
}

Config['announcements'] = {
    Messages = {
        'Pamiętaj, że możesz odebrać /kit vip co 30 minut',
        'Skrzynki znajdziesz pod komendą /skrzynki',
        -- 'Zapraszamy do zakupu na naszym sklepie: indrop.gg/s/nonrp',
        'Pamiętaj, że często organizujemy dropy coinów na naszym discordzie.',
        'Dołącz na naszego discorda! discord.gg/nonrp'
    }
}

Config['anims'] = {
    Animations = {
        {
            name = 'Wyrazy twarzy',
            label = 'Wyrazy twarzy',
            items = {
                {label = "Neutralny", type = "faceExpression", data = {anim = "mood_Normal_1", e = "neutralny"}},
                {label = "Szczęśliwy", type = "faceExpression", data = {anim = "mood_Happy_1", e = "szczesliwy"}},
                {label = "Zły", type = "faceExpression", data = {anim = "mood_Angry_1", e = "zly"}},		
                {label = "Podejrzliwy", type = "faceExpression", data = {anim = "mood_Aiming_1", e = "podejrzliwy"}},
                {label = "Ból", type = "faceExpression", data = {anim = "mood_Injured_1", e = "bol"}},
                {label = "Zdenerwowany", type = "faceExpression", data = {anim = "mood_stressed_1", e = "zdenerwowany"}},
                {label = "Zadowolony", type = "faceExpression", data = {anim = "mood_smug_1", e = "zadowolony"}},
                {label = "Podpity", type = "faceExpression", data = {anim = "mood_drunk_1", e = "podpity"}},
                {label = "Zszokowany", type = "faceExpression", data = {anim = "shocked_1", e = "zszokowany"}},
                {label = "Zamknięte oczy", type = "faceExpression", data = {anim = "mood_sleeping_1", e = "oczy"}},
                {label = "Przeżuwanie", type = "faceExpression", data = {anim = "eating_1", e = "zucie"}},
            }
        },

        {
            name = 'Przywitania',
            label = 'Przywitania',
            items = {
                {label = "Machanie ręką", type = "anim", data = {lib = "random@hitch_lift", anim = "come_here_idle_c", loop = 51, e = "machanie"}},
                {label = "Machanie ręką 2", type = "anim", data = {lib = "friends@fra@ig_1", anim = "over_here_idle_a", loop = 51, e = "machanie2"}},
                {label = "Machnięcie ręką 3", type = "anim", data = {lib = "gestures@m@standing@casual", anim = "gesture_hello", loop = 50, e = "machanie3"}},
                {label = "Machnięcie ręką 4", type = "anim", data = {lib = "friends@frj@ig_1", anim = "wave_a", loop = 50, e = "machanie4"}},
                {label = "Machnięcie rękoma", type = "anim", data = {lib = "random@mugging5", anim = "001445_01_gangintimidation_1_female_idle_b", loop = 50, e = "machanie5"}},
                {label = "Machnięcie rękoma 2", type = "anim", data = {lib = "friends@frj@ig_1", anim = "wave_b", loop = 50, e = "machanie6"}},
                {label = "Machnięcie rękoma 3", type = "anim", data = {lib = "friends@frj@ig_1", anim = "wave_d", loop = 50, e = "machanie7"}},
                {label = "Żółwik", type = "anim", data = {lib = "anim@am_hold_up@male", anim = "shoplift_high", loop = 50, e = "zolwik"}},
                {label = "Graba", type = "anim", data = {lib = "mp_ped_interaction", anim = "handshake_guy_a", loop = 1, e = "graba"}},
                {label = "Piąteczka", type = "anim", data = {lib = "anim@arena@celeb@flat@paired@no_props@", anim = "high_five_c_player_b", loop = 50, e = "piateczka"}},            
            }
        },
        
        {
            name = 'Reakcje',
            label = 'Reakcje',
            items = {
                {label = "Facepalm 1", type = "anim", data = {lib = "anim@mp_player_intcelebrationmale@face_palm", anim = "face_palm", loop = 56, e = "facepalm"}},      
                {label = "Facepalm 2", type = "anim", data = {lib = "anim@mp_player_intupperface_palm", anim = "enter", loop = 50, e = "facepalm2"}},   
                {label = "Nie wierze", type = "anim", data = {lib = "anim@mp_player_intcelebrationfemale@face_palm", anim = "face_palm", loop = 56, e = "niewierze"}},
                {label = "Złapanie się za głowę", type = "anim", data = {lib = "mini@dartsoutro", anim = "darts_outro_01_guy2", loop = 56, e = "zaglowe"}},			
                {label = "Tak", type = "anim", data = {lib = "gestures@f@standing@casual", anim = "gesture_pleased", loop = 57, e = "tak"}},
                {label = "Nie", type = "anim", data = {lib = "gestures@f@standing@casual", anim = "gesture_head_no", loop = 57, e = "nie"}},
                {label = "Nie 2", type = "anim", data = {lib = "anim@heists@ornate_bank@chat_manager", anim = "fail", loop = 57, e = "nie2"}},
                {label = "Nie ma mowy", type = "anim", data = {lib = "gestures@f@standing@casual", anim = "gesture_no_way", loop = 56, e = "niemamowy"}},
                {label = "Wzruszenie ramionami", type = "anim", data = {lib = "gestures@f@standing@casual", anim = "gesture_shrug_hard", loop = 56, e = "wzruszenie"}},
                {label = "Wzruszenie ramionami 2", type = "anim", data = {lib = "gestures@m@standing@casual", anim = "gesture_shrug_hard", loop = 56, e = "wzruszenie2"}},
                {label = "Chodź tu", type = "anim", data = {lib = "gestures@f@standing@casual", anim = "gesture_come_here_soft", loop = 57, e = "chodz"}},
                {label = "Chodź tu 2", type = "anim", data = {lib = "misscommon@response", anim = "bring_it_on", loop = 57, e = "chodz2"}},
                {label = "Chodź tu 3", type = "anim", data = {lib = "mini@triathlon", anim = "want_some_of_this", loop = 57, e = "chodz3"}},
                {label = "Co?", type = "anim", data = {lib = "gestures@f@standing@casual", anim = "gesture_what_hard", loop = 56, e = "co"}},
                {label = "Szlag!", type = "anim", data = {lib = "gestures@f@standing@casual", anim = "gesture_damn", loop = 56, e = "szlag"}},
                {label = "Cicho!", type = "anim", data = {lib = "anim@mp_player_intuppershush", anim = "idle_a_fp", loop = 58, e = "cicho"}},	           
                {label = "Halo!", type = "anim", data = {lib = "friends@frj@ig_1", anim = "wave_d", loop = 56, e = "halo"}},
                {label = "Tu jestem!", type = "anim", data = {lib = "friends@frj@ig_1", anim = "wave_c", loop = 56, e = "tujestem"}},
                {label = "To nie ja", type = "anim", data = {lib = "anim@arena@celeb@flat@solo@no_props@", anim = "taunt_b_player_a", loop = 0, e = "tonieja"}},		
                {label = "Przepraszam", type = "anim", data = {lib = "anim@arena@celeb@flat@solo@no_props@", anim = "wow_a_player_b", loop = 0, e = "przepraszam"}},		  
                {label = "Kciuki w górę", type = "anim", data = {lib = "anim@mp_player_intincarthumbs_upbodhi@ps@", anim = "enter", loop = 58, e = "kciuk"}},
                {label = "Kciuk w górę", type = "anim", data = {lib = "anim@mp_player_intincarthumbs_uplow@ds@", anim = "idle_a", loop = 58, e = "kciuk2"}},
                {label = "Kciuk w dół", type = "anim", data = {lib = "anim@arena@celeb@flat@solo@no_props@", anim = "thumbs_down_a_player_b", loop = 0, e = "kciuk3"}},
                {label = "Kciuk jednak w dół", type = "anim", data = {lib = "anim@arena@celeb@flat@solo@no_props@", anim = "thumbs_down_a_player_a", loop = 0, e = "kciuk4"}},			   
                {label = "Uspokój się", type = "anim", data = {lib = "gestures@f@standing@casual", anim = "gesture_easy_now", loop = 56, e = "spokojnie"}},   
                {label = "Brawa 1", type = "anim", data = {lib = "anim@arena@celeb@flat@solo@no_props@", anim = "angry_clap_a_player_a", loop = 0, e = "brawa"}},
                {label = "Brawa 2", type = "anim", data = {lib = "anim@arena@celeb@flat@solo@no_props@", anim = "angry_clap_b_player_a", loop = 0, e = "brawa2"}},
                {label = "Brawa 3", type = "anim", data = {lib = "anim@arena@celeb@flat@solo@no_props@", anim = "angry_clap_b_player_b", loop = 0, e = "brawa3"}},
                {label = "Cieszynka", type = "anim", data = {lib = "anim@arena@celeb@flat@solo@no_props@", anim = "jump_a_player_a", loop = 50, e = "cieszynka"}},
                {label = "Zwycięzca 1", type = "anim", data = {lib = "anim@arena@celeb@podium@no_prop@", anim = "dance_b_1st", loop = 50, e = "zwyciezca"}},
                {label = "Zwycięzca 2", type = "anim", data = {lib = "anim@arena@celeb@podium@no_prop@", anim = "make_noise_a_1st", loop = 50, e = "zwyciezca2"}},
                {label = "Głowa w dół", type = "anim", data = {lib = "mp_sleep", anim = "sleep_intro", loop = 58, e = "glowadol"}},
                {label = "Znudzenie", type = "anim", data = {lib = "friends@fra@ig_1", anim = "base_idle", loop = 56, e = "znudzenie"}},
                {label = "Ukłon", type = "anim", data = {lib = "anim@arena@celeb@podium@no_prop@", anim = "regal_c_1st", loop = 51, e = "uklon"}},
                {label = "Ukłon 2", type = "anim", data = {lib = "anim@arena@celeb@podium@no_prop@", anim = "regal_a_1st", loop = 51, e = "uklon2"}},
                {label = "Zmęczony", type = "anim", data = {lib = "re@construction", anim = "out_of_breath", loop = 1, e = "zmeczony"}},
                {label = "Kaszel", type = "anim", data = {lib = "timetable@gardener@smoking_joint", anim = "idle_cough", loop = 51, e = "kaszel"}},
                {label = "Śmianie się", type = "anim", data = {lib = "anim@arena@celeb@flat@paired@no_props@", anim = "laugh_a_player_b", loop = 1, e = "smianiesie"}}, 
                {label = "Śmianie się 2", type = "anim", data = {lib = "anim@arena@celeb@flat@solo@no_props@", anim = "giggle_a_player_b", loop = 1, e = "smianiesie2"}},
                {label = "Przestraszony", type = "anim", data = {lib = "random@domestic", anim = "f_distressed_loop", loop = 1, e = "przestraszony"}},         
            }
        },
        
        {
            name = 'Postawa',
            label = 'Pozy',
            items = {
                {label = "Ochroniarz 1", type = "scenario", data = {anim = "WORLD_HUMAN_GUARD_STAND", loop = 0, e = "ochroniarz"}},
                {label = "Ochroniarz 2", type = "anim", data = {lib = "amb@world_human_stand_guard@male@base", anim = "base", loop = 51, e = "ochroniarz2"}},
                {label = "Ochroniarz 3", type = "anim", data = {lib = "mini@strip_club@idles@bouncer@stop", anim = "stop", loop = 56, e = "ochroniarz3"}},
                {label = "Policjant 1", type = "scenario", data = {anim = "WORLD_HUMAN_COP_IDLES", loop = 1, e = "policjant"}},
                {label = "Policjant 2", type = "anim", data = {lib = "amb@world_human_cop_idles@male@base", anim = "base", loop = 51, e = "policjant2"}},
                {label = "Policjant 3", type = "anim", data = {lib = "amb@world_human_cop_idles@female@base", anim = "base", loop = 51, e = "policjant3"}},
                {label = "Wypadek 1 - lewy bok", type = "anim", data = {lib = "missheist_jewel", anim = "gassed_npc_customer4", loop = 1, e = "wypadek"}},
                {label = "Wypadek 2 - prawy bok", type = "anim", data = {lib = "missheist_jewel", anim = "gassed_npc_guard", loop = 1, e = "wypadek2"}},
                {label = "Ręce do tyłu", type = "anim", data = {lib = "anim@miss@low@fin@vagos@", anim = "idle_ped06", loop = 49, e = "receztylu"}},
                {label = "Założone ręce 1", type = "anim", data = {lib = "mini@hookers_sp", anim = "idle_reject_loop_c", loop = 57, e = "rece"}},
                {label = "Założone ręce 2", type = "anim", data = {lib = "anim@amb@nightclub@peds@", anim = "rcmme_amanda1_stand_loop_cop", loop = 51, e = "rece2"}},
                {label = "Założone ręce 3", type = "anim", data = {lib = "amb@world_human_hang_out_street@female_arms_crossed@base", anim = "base", loop =51, e = "rece3"}},
                {label = "Założone ręce 4", type = "anim", data = {lib = "anim@heists@heist_corona@single_team", anim = "single_team_loop_boss", loop = 51, e = "rece4"}},
                {label = "Założone ręce 5", type = "anim", data = {lib = "random@street_race", anim = "_car_b_lookout", loop =51, e = "rece5"}},
                {label = "Założone ręce 6", type = "anim", data = {lib = "rcmnigel1a_band_groupies", anim = "base_m2", loop = 51, e = "rece6"}},
                {label = "Ręce na biodrach", type = "anim", data = {lib = "random@shop_tattoo", anim = "_idle", loop = 50, e = "biodra"}},
                {label = "Ręce na biodrach 2", type = "anim", data = {lib = "anim@arena@celeb@podium@no_prop@", anim = "regal_c_3rd", loop = 50, e = "biodra2"}},
                {label = "Ręka na biodrze", type = "anim", data = {lib = "anim@arena@celeb@podium@no_prop@", anim = "shrug_off_a_1st", loop = 50, e = "biodra3"}},
                {label = "Ręka na biodrze 2", type = "anim", data = {lib = "rcmnigel1cnmt_1c", anim = "base", loop = 51, e = "biodra4"}},
                {label = "Obejmowanie", type = "anim", data = {lib = "anim@arena@celeb@flat@paired@no_props@", anim = "this_guy_b_player_a", loop = 50, e = "obejmowanie"}},
                {label = "Obejmowanie 2", type = "anim", data = {lib = "anim@arena@celeb@flat@paired@no_props@", anim = "this_guy_b_player_b", loop = 50, e = "obejmowanie2"}},
                {label = "Poddanie się 1 - na kolanach", type = "anim", data = {lib = "random@arrests@busted", anim = "idle_a", loop = 1, e = "poddanie"}},
                {label = "Poddanie się 2 ", type = "anim", data = {lib = "anim@move_hostages@male", anim = "male_idle", loop = 51, e = "poddanie2"}},
                {label = "Poddanie się 3", type = "anim", data = {lib = "anim@move_hostages@female", anim = "female_idle", loop = 51, e = "poddanie3"}},
                {label = "Niecierpliwosc", type = "anim", data = {lib = "rcmme_tracey1", anim = "nervous_loop", loop = 51, e = "niecierpliwosc"}},
                {label = "Zastanowienie", type = "anim", data = {lib = "amb@world_human_prostitute@cokehead@base", anim = "base", loop = 1, e = "zastanowienie"}},
                {label = "Drążenie butem", type = "anim", data = {lib = "anim@mp_freemode_return@f@idle", anim = "idle_c", loop = 1, e = "drazenie"}},
                {label = "Myślenie", type = "anim", data = {lib = "rcmnigel3_idles", anim = "base_nig", loop = 51, e = "myslenie"}},
                {label = "Myślenie 2", type = "anim", data = {lib = "misscarsteal4@aliens", anim = "rehearsal_base_idle_director", loop = 51, e = "myslenie2"}},
                {label = "Myślenie 3", type = "anim", data = {lib = "timetable@tracy@ig_8@base", anim = "base", loop = 51, e = "myslenie3"}},
                {label = "Myślenie 4", type = "anim", data = {lib = "missheist_jewelleadinout", anim = "jh_int_outro_loop_a", loop = 51, e = "myslenie4"}},
                {label = "Myślenie 5", type = "anim", data = {lib = "mp_cp_stolen_tut", anim = "b_think", loop = 51, e = "myslenie5"}},
                {label = "Superbohater", type = "anim", data = {lib = "rcmbarry", anim = "base", loop = 51, e = "superbohater"}},
                {label = "Znak V", type = "anim", data = {lib = "anim@mp_player_intupperpeace", anim = "idle_a", loop = 51, e = "znakv"}},
            }
        },

        {
            name = 'siedzenie',
            label = 'Siedzenie/Lezenie/Opieranie',
            items = {
                {label = "Siedzenie 1 - na krześle", type = "scenario", data = {anim = "PROP_HUMAN_SEAT_CHAIR_MP_PLAYER", e = "siedzenie"}},	  
                {label = "Siedzenie 2 - na kanapie", type = "anim", data = {lib = "timetable@ron@ig_3_couch", anim = "base", loop = 1, e = "siedzenie2"}},		
                {label = "Siedzenie 3 - na ziemi", type = "anim", data = {lib = "anim@heists@fleeca_bank@ig_7_jetski_owner", anim = "owner_idle", loop = 1, e = "siedzenie3"}},
                {label = "Siedzenie 4 - na pikniku", type = "anim", data = {lib = "amb@world_human_picnic@female@base", anim = "base", loop = 1, e = "siedzenie4"}},
                {label = "Siedzenie 5", type = "anim", data = {lib = "timetable@jimmy@mics3_ig_15@", anim = "idle_a_jimmy", loop = 1, e = "siedzenie5"}},
                {label = "Siedzenie 6 - przecholone", type = "anim", data = {lib = "timetable@amanda@ig_7", anim = "base", loop = 1, e = "siedzenie6"}},
                {label = "Siedzenie 7 - przecholone2", type = "anim", data = {lib = "timetable@tracy@ig_14@", anim = "ig_14_base_tracy", loop = 1, e = "siedzenie7"}},
                {label = "Siedzenie 8 - noga na noge", type = "anim", data = {lib = "timetable@reunited@ig_10", anim = "base_amanda", loop = 1, e = "siedzenie8"}},
                {label = "Siedzenie 9 - załamany", type = "anim", data = {lib = "anim@amb@nightclub@lazlow@lo_alone@", anim = "lowalone_base_laz", loop = 1, e = "siedzenie9"}},
                {label = "Siedzenie 10 - na luzie", type = "anim", data = {lib = "timetable@jimmy@mics3_ig_15@", anim = "mics3_15_base_jimmy", loop = 1, e = "siedzenie10"}},
                {label = "Siedzenie 11 - na luzie 2", type = "anim", data = {lib = "amb@world_human_stupor@male@idle_a", anim = "idle_a", loop = 1, e = "siedzenie11"}},
                {label = "Siedzenie 12 - smutny", type = "anim", data = {lib = "anim@amb@business@bgen@bgen_no_work@", anim = "sit_phone_phoneputdown_sleeping-noworkfemale", loop = 1, e = "siedzenie12"}},
                {label = "Siedzenie 13 - przestraszony", type = "anim", data = {lib = "anim@heists@ornate_bank@hostages@hit", anim = "hit_loop_ped_b", loop = 1, e = "siedzenie13"}},
                {label = "Siedzenie 14 - przestraszony 2", type = "anim", data = {lib = "anim@heists@ornate_bank@hostages@ped_c@", anim = "flinch_loop", loop = 1, e = "siedzenie14"}},
                {label = "Siedzenie 15 - dłoń na dłoni", type = "anim", data = {lib = "timetable@reunited@ig_10", anim = "base_jimmy", loop = 1, e = "siedzenie15"}},
                {label = "Siedzenie 16 - na krześle 2", type = "anim", data = {lib = "timetable@ron@ig_5_p3", anim = "ig_5_p3_base", loop = 1, e = "siedzenie16"}},
                {label = "Siedzenie 17 - na krześle 3", type = "anim", data = {lib = "timetable@maid@couch@", anim = "base", loop = 1, e = "siedzenie17"}}, 
                {label = "Siedzenie 18 - na krześle 4", type = "anim", data = {lib = "timetable@jimmy@mics3_ig_15@", anim = "mics3_15_base_tracy", loop = 1, e = "siedzenie18"}},
                {label = "Siedzenie 19 - na sofie", type = "anim", data = {lib = "timetable@trevor@smoking_meth@base", anim = "base", loop = 1, e = "siedzenie19"}},
                {label = "Siedzenie 20 - na sofie 2", type = "anim", data = {lib = "timetable@michael@on_sofabase", anim = "sit_sofa_base", loop = 1, e = "siedzenie20"}},
                {label = "Leżenie 1 - na brzuchu", type = "scenario", data = {anim = "WORLD_HUMAN_SUNBATHE", loop = 1, e = "lezenie"}},
                {label = "Leżenie 2 - na brzuchu 2", type = "anim", data = {lib = "missfbi3_sniping", anim = "prone_dave", loop = 1, e = "lezenie2"}},
                {label = "Leżenie 3 - na plecach", type = "scenario", data = {anim = "WORLD_HUMAN_SUNBATHE_BACK", loop = 0, e = "lezenie3"}},
                {label = "Leżenie 4 - na kanapie", type = "anim", data = {lib = "timetable@ron@ig_3_couch", anim = "laying", loop = 1, e = "lezenie4"}},
                {label = "Leżenie 5 - lewy bok", type = "anim", data = {lib = "amb@world_human_bum_slumped@male@laying_on_left_side@base", anim = "base", loop = 1, e = "lezenie5"}},
                {label = "Leżenie 6 - prawy bok", type = "anim", data = {lib = "amb@world_human_bum_slumped@male@laying_on_right_side@base", anim = "base", loop = 1, e = "lezenie6"}},
                {label = "Leżenie 6 - prawy bok 2", type = "anim", data = {lib = "switch@trevor@scares_tramp", anim = "trev_scares_tramp_idle_tramp", loop = 1, e = "lezenie7"}},
                {label = "Leżenie 7 - patrzenie w góre", type = "anim", data = {lib = "switch@trevor@annoys_sunbathers", anim = "trev_annoys_sunbathers_loop_girl", loop = 1, e = "lezenie8"}},
                {label = "Leżenie 8 - patrzenie w góre 2", type = "anim", data = {lib = "switch@trevor@annoys_sunbathers", anim = "trev_annoys_sunbathers_loop_guy", loop = 1, e = "lezenie9"}},
                {label = "Opieranie o barierkę 1 - przód", type = "anim", data = {lib = "amb@prop_human_bum_shopping_cart@male@base", anim = "base", loop = 1, e = "opieranie"}},
                {label = "Opieranie o barierkę 2 - przód", type = "anim", data = {lib = "missheistdockssetup1ig_12@base", anim = "talk_gantry_idle_base_worker2", loop = 1, e = "opieranie2"}},
                {label = "Opieranie o barierkę 3 - przód", type = "anim", data = {lib = "misshair_shop@hair_dressers", anim = "assistant_base", loop = 1, e = "opieranie3"}},
                {label = "Opieranie o barierkę 4 - z tyłu", type = "anim", data = {lib = "anim@amb@clubhouse@bar@bartender@", anim = "base_bartender", loop = 1, e = "opieranie4"}},
                {label = "Opieranie o stół 1 - przód", type = "anim", data = {lib = "anim@amb@clubhouse@bar@drink@base", anim = "idle_a", loop = 1, e = "opieranie5"}},
                {label = "Opieranie o stół 2 - przód", type = "anim", data = {lib = "anim@amb@board_room@diagram_blueprints@", anim = "base_amy_skater_01", loop = 1, e = "opieranie6"}},
                {label = "Opieranie o stół 3 - przód", type = "anim", data = {lib = "anim@amb@facility@missle_controlroom@", anim = "idle", loop = 1, e = "opieranie7"}},
                {label = "Opieranie ściana 1 - nogi na ziemi", type = "anim", data = {lib = "amb@world_human_leaning@male@wall@back@hands_together@base", anim = "base", loop = 1, e = "opieranie8"}},
                {label = "Opieranie ściana 2 - noga w górze", type = "anim", data = {lib = "amb@world_human_leaning@male@wall@back@foot_up@base", anim = "base", loop = 1, e = "opieranie9"}},
                {label = "Opieranie ściana 3 - nogi na krzyż", type = "anim", data = {lib = "amb@world_human_leaning@male@wall@back@legs_crossed@base", anim = "base", loop = 1, e = "opieranie10"}},
                {label = "Opieranie ściana 4 - nogi na krzyż 2", type = "anim", data = {lib = "amb@world_human_leaning@female@wall@back@holding_elbow@idle_a", anim = "idle_a", loop = 1, e = "opieranie11"}},
                {label = "Opieranie ściana 5 - głowa w dół", type = "anim", data = {lib = "anim@amb@business@bgen@bgen_no_work@", anim = "stand_phone_phoneputdown_sleeping_nowork", loop = 1, e = "opieranie12"}},
                {label = "Opieranie łokciem 1", type = "anim", data = {lib = "rcmjosh2", anim = "josh_2_intp1_base", loop = 1, e = "opieranie13"}},
                {label = "Opieranie łokciem 2", type = "anim", data = {lib = "timetable@mime@01_gc", anim = "idle_a", loop = 1, e = "opieranie14"}},
                {label = "Opieranie łokciem 3", type = "anim", data = {lib = "misscarstealfinalecar_5_ig_1", anim = "waitloop_lamar", loop = 1, e = "opieranie15"}},
                {label = "Opieranie ręką", type = "anim", data = {lib = "misscarstealfinale", anim = "packer_idle_1_trevor", loop = 1, e = "opieranie16"}},
                {label = "Zimny łokieć [Kierowca]", type = "anim", data = {lib = "anim@veh@lowrider@low@front_ds@arm@base", anim = "sit", loop = 51, e = "zimnylokiec"}},
            }
        },
        
        {
            name = 'Czynności',
            label = 'Czynności',
            items = {
                {label = "Telefon 1", type = "scenario", data = {anim = "world_human_tourist_mobile", loop = 0, e = "telefon"}},
                {label = "Telefon 2", type = "scenario", data = {anim = "WORLD_HUMAN_MOBILE_FILM_SHOCKING", loop = 0, e = "telefon2"}},
                {label = "Fotka - wyimaginowany aparat", type = "anim", data = {lib = "anim@mp_player_intincarphotographylow@ds@", anim = "idle_a", loop = 1, e = "fotka"}},
                {label = "Tłumaczenie", type = "anim", data = {lib = "misscarsteal4@actor", anim = "actor_berating_assistant", loop = 56, e = "tlumaczenie"}},
                {label = "Przyglądanie się broni", type = "anim", data = {lib = "mp_corona@single_team", anim = "single_team_intro_one", loop = 56, e = "bron"}},
                {label = "Zerkanie na zegarek", type = "anim", data = {lib = "oddjobs@taxi@", anim = "idle_a", loop = 56, e = "zegarek"}},
                {label = "Czyszczenie 1 - mycie ścierką", type = "scenario", data = {anim = "world_human_maid_clean", loop = 0, e = "mycie"}},
                {label = "Czyszczenie 2 - mycie maski auta", type = "anim", data = {lib = "switch@franklin@cleaning_car", anim = "001946_01_gc_fras_v2_ig_5_base", loop = 1, e = "mycie2"}},
                {label = "Branie prysznica 1", type = "anim", data = {lib = "mp_safehouseshower@female@", anim = "shower_idle_a", loop = 1, e = "prysznic"}},
                {label = "Branie prysznica 2", type = "anim", data = {lib = "mp_safehouseshower@male@", anim = "male_shower_idle_a", loop = 1, e = "prysznic2"}},
                {label = "Branie prysznica 3", type = "anim", data = {lib = "mp_safehouseshower@male@", anim = "male_shower_idle_d", loop = 1, e = "prysznic3"}},
                {label = "Sięganie do schowka w aucie [Pojazd]", type = "animschowek", data = {lib = "rcmme_amanda1", anim = "drive_mic", loop = 56, e = "schowek"}},
                {label = "Włamywanie do sejfu", type = "anim", data = {lib = "mini@safe_cracking", anim = "dial_turn_anti_normal", loop = 0, e = "sejf"}},
                {label = "Przymierzanie ubrań", type = "anim", data = {lib = "mp_clothing@female@trousers", anim = "try_trousers_neutral_a", loop = 1, e = "ubrania"}},
                {label = "Przymierzanie góry", type = "anim", data = {lib = "mp_clothing@female@shirt", anim = "try_shirt_positive_a", loop = 1, e = "ubrani2"}},
                {label = "Przymierzanie butów", type = "anim", data = {lib = "mp_clothing@female@shoes", anim = "try_shoes_positive_a", loop = 1, e = "ubrania3"}},
                {label = "Pakowanie do torby", type = "anim", data = {lib = "anim@heists@ornate_bank@grab_cash", anim = "grab", loop = 1, e = "torba"}},
                {label = "Oddawaj pieniądze", type = "anim", data = {lib = "mini@prostitutespimp_demands_money", anim = "pimp_demands_money_pimp", loop = 0, e = "oddawaj"}},
                {label = "Samobójstwo", type = "anim", data = {lib = "mp_suicide", anim = "pistol", loop = 2, e = "samobojstwo"}},
                {label = "Salutowanie", type = "anim", data = {lib = "mp_player_int_uppersalute", anim = "mp_player_int_salute", loop = 51, e = "salut"}},
                {label = "Kłótnia", type = "anim", data = {lib = "sdrm_mcs_2-0", anim = "csb_bride_dual-0", loop = 56, e = "klotnia"}},
                {label = "Kucanie", type = "anim", data = {lib = "rcmextreme3", anim = "idle", loop = 1, e = "kucanie"}},
                {label = "Kucanie 2", type = "anim", data = {lib = "amb@world_human_bum_wash@male@low@idle_a", anim = "idle_a", loop = 1, e = "kucanie2"}},
                {label = "Gwizdanie", type = "anim", data = {lib = "rcmnigel1c", anim = "hailing_whistle_waive_a", loop = 51, e = "gwizdanie"}},
                {label = "Gwizdanie 2", type = "anim", data = {lib = "taxi_hail", anim = "hail_taxi", loop = 51, e = "gwizdanie2"}},
                {label = "Celowanie", type = "anim", data = {lib = "random@countryside_gang_fight", anim = "biker_02_stickup_loop", loop = 49, e = "celowanie"}},
                {label = "Celowanie 2", type = "anim", data = {lib = "random@atmrobberygen", anim = "b_atm_mugging", loop = 49, e = "celowanie2"}},
                {label = "Celowanie 3", type = "anim", data = {lib = "move_weapon@pistol@copa", anim = "idle", loop = 49, e = "celowanie3"}},
                {label = "Celowanie 4", type = "anim", data = {lib = "move_weapon@pistol@cope", anim = "idle", loop = 49, e = "celowanie4"}},
                {label = "Celowanie 5", type = "anim", data = {lib = "combat@aim_variations@1h@gang", anim = "aim_variation_b", loop = 51, e = "celowanie5"}},
                {label = "Medytacja", type = "anim", data = {lib = "rcmcollect_paperleadinout@", anim = "meditiate_idle", loop = 1, e = "medytacja"}},
                {label = "Medytacja 2", type = "anim", data = {lib = "rcmepsilonism3", anim = "ep_3_rcm_marnie_meditating", loop = 1, e = "medytacja2"}},
                {label = "Pukanie", type = "anim", data = {lib = "timetable@jimmy@doorknock@", anim = "knockdoor_idle", loop = 51, e = "pukanie"}},
                {label = "Wskazywanie", type = "anim", data = {lib = "gestures@f@standing@casual", anim = "gesture_point", loop = 56, e = "wskazywanie"}},
                {label = "Wskazywanie 2 - Dół", type = "anim", data = {lib = "gestures@f@standing@casual", anim = "gesture_hand_down", loop = 56, e = "wskazywanie2"}},
                {label = "Wskazywanie 3 - Prawo", type = "anim", data = {lib = "mp_gun_shop_tut", anim = "indicate_right", loop = 56, e = "wskazywanie3"}},
                {label = "Trzymanie się za kabure", type = "anim", data = {lib = "move_m@intimidation@cop@unarmed", anim = "idle", loop = 49, e = "kabura"}},
                {label = "Granie w golfa", type = "anim", data = {lib = "rcmnigel1d", anim = "swing_a_mark", loop = 51, e = "golf"}},  
            }	
        },
        
        {
            name = 'Chamskie',
            label = 'Chamskie',
            items = {
                {label = "Mów do ręki", type = "anim", data = {lib = "mini@prostitutestalk", anim = "street_argue_f_a", loop = 56, e = ""}},           
                {label = "Środkowy palec 1", type = "anim", data = {lib = "anim@arena@celeb@podium@no_prop@", anim = "flip_off_a_1st", loop = 56, e = "palec"}},
                {label = "Środkowy palec 2 - z kieszeni", type = "anim", data = {lib = "anim@arena@celeb@podium@no_prop@", anim = "flip_off_b_1st", loop = 56, e = "palec2"}},
                {label = "Środkowy palec 3", type = "anim", data = {lib = "anim@mp_player_intselfiethe_bird", anim = "idle_a", loop = 51, e = "palec3"}},
                {label = "Pokazywanie środkowych palców", type = "anim", data = {lib = "mp_player_int_upperfinger", anim = "mp_player_int_finger_01_enter", loop = 58, e = "palec4"}},
                {label = "Sarkastyczne klaskanie 1", type = "anim", data = {lib = "anim@mp_player_intcelebrationfemale@slow_clap", anim = "slow_clap", loop = 56, e = "klaskanie"}},
                {label = "Sarkastyczne klaskanie 2", type = "anim", data = {lib = "anim@mp_player_intcelebrationmale@slow_clap", anim = "slow_clap", loop = 56, e = "klaskanie2"}},
                {label = "Sarkastyczne klaskanie 3", type = "anim", data = {lib = "anim@mp_player_intupperslow_clap", anim = "idle_a", loop = 57, e = "klaskanie3"}},
                {label = "Sarkastyczne klaskanie 4", type = "anim", data = {lib = "anim@arena@celeb@podium@no_prop@", anim = "regal_b_3rd", loop = 0, e = "klaskanie4"}},          
                {label = "Drapanie sie po kroczu", type = "anim", data = {lib = "mp_player_int_uppergrab_crotch", anim = "mp_player_int_grab_crotch", loop = 57, e = "drapaniepokroczu"}},
                {label = "Dłubanie w nosie - strzał gilem", type = "anim", data = {lib = "anim@mp_player_intuppernose_pick", anim = "exit", loop = 56, e = "dlubanie"}},
                {label = "Dłubanie w nosie 2 - oscentacyjne", type = "anim", data = {lib = "anim@mp_player_intcelebrationfemale@nose_pick", anim = "nose_pick", loop = 0, e = "dlubanie2"}},
                {label = "Ten z tyłu śmierdzi", type = "anim", data = {lib = "anim@arena@celeb@flat@solo@no_props@", anim = "taunt_c_player_b", loop = 0, e = "smierdzi"}},
                {label = "No dawaj!", type = "anim", data = {lib = "gestures@f@standing@casual", anim = "gesture_bring_it_on", loop = 56, e = "dawaj"}},
                {label = "Gotowość na bójkę", type = "anim", data = {lib = "anim@mp_player_intupperknuckle_crunch", anim = "idle_a", loop = 56, e = "bojka"}},
                {label = "Gotowość na bójkę 2", type = "anim", data = {lib = "anim@mp_player_intcelebrationmale@knuckle_crunch", anim = "knuckle_crunch", loop = 56, e = "bojka2"}},
                {label = "Gotowość na bójkę 3", type = "anim", data = {lib = "anim@deathmatch_intros@unarmed", anim = "intro_male_unarmed_c", loop = 1, e = "bojka3"}},           
                {label = "Gotowość na bójkę 4", type = "anim", data = {lib = "anim@deathmatch_intros@unarmed", anim = "intro_male_unarmed_e", loop = 1, e = "bojka4"}},           
                {label = "Spoliczkowanie", type = "anim", data = {lib = "anim@arena@celeb@podium@no_prop@", anim = "air_slap_a_1st", loop = 56, e = "policzek"}},
            }
        },
        
        {
            name = 'Sportowe',
            label = 'Sportowe',
            items = {
                {label = "Jogging", type = "anim", data = {lib = "move_m@jogger", anim = "run", loop = 33, e = "jogging"}},
                {label = "Jogging 2", type = "scenario", data = {anim = "WORLD_HUMAN_JOG_STANDING", loop = 0, e = "jogging2"}},
                {label = "Trucht", type = "anim", data = {lib = "move_m@jog@", anim = "run", loop = 33, e = "trucht"}},
                {label = "Powerwalk", type = "anim", data = {lib = "amb@world_human_power_walker@female@base", anim = "base", loop = 33, e = "powerwalk"}},
                {label = "Napinanie mięśni", type = "anim", data = {lib = "amb@world_human_muscle_flex@arms_at_side@base", anim = "base", loop = 1, e = "napinanie"}},
                {label = "Pompki", type = "anim", data = {lib = "amb@world_human_push_ups@male@base", anim = "base", loop = 1, e = "pompki"}},
                {label = "Brzuszki", type = "anim", data = {lib = "amb@world_human_sit_ups@male@base", anim = "base", loop = 1, e = "brzuszki"}},
                {label = "Salto w tył", type = "anim", data = {lib = "anim@arena@celeb@flat@solo@no_props@", anim = "flip_a_player_a", loop = 0, e = "salto"}},
                {label = "Capoeira", type = "anim", data = {lib = "anim@arena@celeb@flat@solo@no_props@", anim = "cap_a_player_a", loop = 0, e = "capoeira"}},
                {label = "Yoga 1 - przygotowanie", type = "anim", data = {lib = "amb@world_human_yoga@male@base", anim = "base", loop = 1, e = "yoga"}},
                {label = "Yoga 2 - rozciąganie się", type = "anim", data = {lib = "amb@world_human_yoga@female@base", anim = "base_b", loop = 1, e = "yoga2"}},
                {label = "Yoga 3 - stanie na rękach", type = "anim", data = {lib = "amb@world_human_yoga@female@base", anim = "base_c", loop = 1, e = "yoga3"}},
                {label = "Wślizg na kolanach", type = "anim", data = {lib = "anim@arena@celeb@flat@solo@no_props@", anim = "slide_a_player_a", loop = 0, e = "wslizg"}},
                {label = "Skok przez kozła", type = "anim", data = {lib = "anim@arena@celeb@flat@solo@no_props@", anim = "jump_b_player_a", loop = 0, e = "skok"}},
                {label = "Szpagat", type = "anim", data = {lib = "anim@arena@celeb@flat@solo@no_props@", anim = "jump_c_player_a", loop = 0, e = "szpagat"}},
                {label = "Podskok", type = "anim", data = {lib = "anim@arena@celeb@flat@solo@no_props@", anim = "jump_d_player_a", loop = 0, e = "podskok"}},
                {label = "Pajacyki", type = "anim", data = {lib = "timetable@reunited@ig_2", anim = "jimmy_masterbation", loop = 1, e = "pajacyki"}},
                {label = "Rozciąganie się", type = "anim", data = {lib = "mini@triathlon", anim = "idle_e", loop = 1, e = "rozciaganie"}},
                {label = "Rozciąganie się 2", type = "anim", data = {lib = "mini@triathlon", anim = "idle_f", loop = 1, e = "rozciaganie2"}},
                {label = "Rozciąganie się 3", type = "anim", data = {lib = "mini@triathlon", anim = "idle_d", loop = 1, e = "rozciaganie3"}},
                {label = "Rozciąganie się 4", type = "anim", data = {lib = "rcmfanatic1maryann_stretchidle_b", anim = "idle_e", loop = 1, e = "rozciaganie4"}}, 
                {label = "Boks", type = "anim", data = {lib = "anim@mp_player_intcelebrationmale@shadow_boxing", anim = "shadow_boxing", loop = 51, e = "boks"}},
                {label = "Boks 2", type = "anim", data = {lib = "anim@mp_player_intcelebrationfemale@shadow_boxing", anim = "shadow_boxing", loop = 51, e = "boks2"}},
                {label = "Karate", type = "anim", data = {lib = "anim@mp_player_intcelebrationfemale@karate_chops", anim = "karate_chops", loop = 1, e = "karate"}},
                {label = "Karate 2", type = "anim", data = {lib = "anim@mp_player_intcelebrationmale@karate_chops", anim = "karate_chops", loop = 1, e = "karate2"}},      
            }
        },

        {
            name = 'Czynności Pracy',
            label = 'Czynności Pracy',
            items = {
                {label = "Mechanik 1 - maska", type = "anim", data = {lib = "mini@repair", anim = "fixing_a_ped", loop = 1, e = "mechanik"}},
                {label = "Mechanik 2 - maska", type = "anim", data = {lib = "mini@repair", anim = "fixing_a_player", loop = 1, e = "mechanik2"}},
                {label = "Mechanik 3 - pod autem", type = "anim", data = {lib = "amb@world_human_vehicle_mechanic@male@base", anim = "base", loop = 1, e = "mechanik3"}},
                {label = "Mechanik 4 - wyjście spod auta", type = "anim", data = {lib = "amb@world_human_vehicle_mechanic@male@exit", anim = "exit", loop = 0, e = "mechanik4"}},
                {label = "Uderzanie młotkiem", type = "scenario", data = {anim = "WORLD_HUMAN_HAMMERING", loop = 0, e = "mlotek"}},
                {label = "Spawanie", type = "scenario", data = {anim = "WORLD_HUMAN_WELDING", loop = 1, e = "spawanie"}},
                {label = "Pisanie na komputerze", type = "anim", data = {lib = "anim@heists@prison_heistig1_p1_guard_checks_bus", anim = "loop", loop = 1, e = "komputer"}},
                {label = "Ładowanie towaru", type = "anim", data = {lib = "mp_am_hold_up", anim = "purchase_beerbox_shopkeeper", loop = 0, e = "towar"}},
                {label = "Kopanie w ziemi - klękanie", type = "scenario", data = {anim = "world_human_gardener_plant", loop = 0, e = "kopanie2"}},
            }
        },

        {
            name = 'Służbowe',
            label = 'Służbowe',
            items = {
                {label = "Sprawdzanie stanu 1 - klękanie", type = "scenario", data = {anim = "CODE_HUMAN_MEDIC_KNEEL", loop = 0, e = "stan"}},
                {label = "Sprawdzanie stanu 2 - uciskanie", type = "anim", data = {lib = "anim@heists@narcotics@funding@gang_idle", anim = "gang_chatting_idle01", loop = 1, e = "stan2"}},		
                {label = "Ból w klatce piersiowej", type = "anim", data = {lib = "anim@heists@prison_heistig_5_p1_rashkovsky_idle", anim = "idle", loop = 1, e = "klatka"}},
                {label = "Ból nogi", type = "anim", data = {lib = "missfbi5ig_0", anim = "lyinginpain_loop_steve", loop = 1, e = "noga"}},
                {label = "Ból brzucha", type = "anim", data = {lib = "combat@damage@writheidle_a", anim = "writhe_idle_a", loop = 1, e = "brzuch"}},
                {label = "Ból głowy", type = "anim", data = {lib = "combat@damage@writheidle_b", anim = "writhe_idle_f", loop = 1, e = "glowa"}},
                {label = "Ból głowy 2", type = "anim", data = {lib = "misscarsteal4@actor", anim = "dazed_idle", loop = 51, e = "glowa2"}},
                {label = "Drgawki", type = "anim", data = {lib = "missheistfbi3b_ig8_2", anim = "cpr_loop_victim", loop = 1, e = "drgawki"}},
                {label = "Omdlenie 1 - prawy bok", type = "anim", data = {lib = "dam_ko@shot", anim = "ko_shot_head", loop = 2, e = "omdlenie"}},
                {label = "Omdlenie 2 - na plecy", type = "anim", data = {lib = "anim@gangops@hostage@", anim = "perp_success", loop = 2, e = "omdlenie2"}},
                {label = "Omdlenie 3 - leżąc", type = "anim", data = {lib = "mini@cpr@char_b@cpr_def", anim = "cpr_intro", loop = 2, e = "omdlenie3"}},
                {label = "Ocknięcie 1 - ponowne omdlenie", type = "anim", data = {lib = "missfam5_blackout", anim = "pass_out", loop = 2, e = "ockniecie"}},
                {label = "Ocknięcie 2 - wymiotowanie", type = "anim", data = {lib = "missfam5_blackout", anim = "vomit", loop = 0, e = "ockniecie2"}},
                {label = "Ocknięcie 3 - szybko", type = "anim", data = {lib = "safe@trevor@ig_8", anim = "ig_8_wake_up_front_player", loop = 0, e = "ockniecie3"}},
                {label = "Ocknięcie 4 - powoli", type = "anim", data = {lib = "safe@trevor@ig_8", anim = "ig_8_wake_up_right_player", loop = 0, e = "ockniecie4"}},
                {label = "Brak przytomności 1", type = "anim", data = {lib = "mini@cpr@char_b@cpr_def", anim = "cpr_pumpchest_idle", loop = 1, e = "nieprzytomnosc"}},
                {label = "Brak przytomności 2", type = "anim", data = {lib = "missprologueig_6", anim = "lying_dead_brad", loop = 1, e = "nieprzytomnosc2"}},
                {label = "Brak przytomności 3", type = "anim", data = {lib = "missprologueig_6", anim = "lying_dead_player0", loop = 1, e = "nieprzytomnosc3"}},
                {label = "Brak przytomności 4", type = "anim", data = {lib = "random@mugging4", anim = "flee_backward_loop_shopkeeper", loop = 1, e = "nieprzytomnosc4"}},
                {label = "Brak przytomności 5 - na brzuchu", type = "anim", data = {lib = "missarmenian2", anim = "drunk_loop", loop = 1, e = "nieprzytomnosc5"}},
                {label = "RKO 1 - uciskanie", type = "anim", data = {lib = "mini@cpr@char_a@cpr_str", anim = "cpr_pumpchest", loop = 1, e = "rko"}},
                {label = "RKO 2 - wdechy", type = "anim", data = {lib = "mini@cpr@char_a@cpr_str", anim = "cpr_kol", loop = 1, e = "rko2"}},
                {label = "Wzywanie SOS - rękoma", type = "anim", data = {lib = "random@gang_intimidation@", anim = "001445_01_gangintimidation_1_female_wave_loop", loop = 51, e = "sos"}},
                {label = "Sprawdzanie dowodów", type = "anim", data = {lib = "amb@code_human_police_investigate@idle_b", anim = "idle_f", loop = 0, e = "dowody"}},
                {label = "Sprawdzanie dowodów 2", type = "anim", data = {lib = "random@train_tracks", anim = "idle_e", loop = 0, e = "dowody2"}},
            }
        },

        {
            name = 'Tańce',
            label = 'Tańce',
            items = {
                {label = "Twerk", type = "anim", data = {lib = "switch@trevor@mocks_lapdance", anim = "001443_01_trvs_28_idle_stripper", loop = 1, e = "twerk"}},   
                {label = "Taniec 1", type = "anim", data = {lib = "misschinese2_crystalmazemcs1_cs", anim = "dance_loop_tao", loop = 1, e = "taniec"}},           
                {label = "Taniec 2", type = "anim", data = {lib = "anim@amb@nightclub@dancers@crowddance_facedj@hi_intensity", anim = "hi_dance_facedj_09_v1_female^1", loop = 1, e = "taniec2"}},
                {label = "Taniec 3", type = "anim", data = {lib = "anim@amb@nightclub@dancers@crowddance_facedj@hi_intensity", anim = "hi_dance_facedj_09_v1_female^3", loop = 1, e = "taniec3"}},
                {label = "Taniec 4", type = "anim", data = {lib = "anim@amb@nightclub@dancers@crowddance_facedj@hi_intensity", anim = "hi_dance_facedj_09_v1_female^6", loop = 1, e = "taniec4"}},
                {label = "Taniec 5", type = "anim", data = {lib = "anim@amb@nightclub@dancers@crowddance_facedj@med_intensity", anim = "mi_dance_facedj_09_v1_female^1", loop = 1, e = "taniec5"}},
                {label = "Taniec 6", type = "anim", data = {lib = "anim@amb@nightclub@dancers@crowddance_groups@hi_intensity", anim = "hi_dance_crowd_09_v1_female^1", loop = 1, e = "taniec6"}},
                {label = "Taniec 7", type = "anim", data = {lib = "anim@amb@nightclub@lazlow@hi_podium@", anim = "danceidle_hi_11_turnaround_laz", loop = 1, e = "taniec7"}},
                {label = "Taniec 8", type = "anim", data = {lib = "anim@amb@nightclub@lazlow@hi_podium@", anim = "danceidle_hi_17_smackthat_laz", loop = 1, e = "taniec8"}},
                {label = "Taniec 9", type = "anim", data = {lib = "special_ped@mountain_dancer@monologue_3@monologue_3a", anim = "mnt_dnc_buttwag", loop = 1, e = "taniec9"}},
                {label = "Taniec 10", type = "anim", data = {lib = "anim@amb@nightclub@lazlow@hi_podium@", anim = "danceidle_hi_06_base_laz", loop = 1, e = "taniec10"}},
                {label = "Taniec 11", type = "anim", data = {lib = "anim@mp_player_intcelebrationmale@uncle_disco", anim = "uncle_disco", loop = 1, e = "taniec11"}},
                {label = "Taniec 12", type = "anim", data = {lib = "anim@amb@nightclub@dancers@crowddance_groups_transitions@", anim = "trans_dance_crowd_hi_to_mi_09_v1_female^1", loop = 1, e = "taniec12"}},
                {label = "Taniec 13", type = "anim", data = {lib = "rcmnigel1bnmt_1b", anim = "dance_loop_tyler", loop = 1, e = "taniec13"}},
                {label = "Taniec 14", type = "anim", data = {lib = "anim@amb@nightclub@mini@dance@dance_solo@female@var_a@", anim = "low_center", loop = 1, e = "taniec14"}},
                {label = "Taniec 15", type = "anim", data = {lib = "anim@amb@nightclub@lazlow@hi_podium@", anim = "danceidle_mi_15_robot_laz",  loop = 1, e = "taniec15"}},
                {label = "Taniec 16", type = "anim", data = {lib = "anim@amb@nightclub@dancers@solomun_entourage@", anim = "mi_dance_facedj_17_v1_female^1",  loop = 1, e = "taniec16"}},
                {label = "Taniec 17", type = "anim", data = {lib = "anim@amb@nightclub@mini@dance@dance_solo@female@var_a@", anim = "high_center_up",  loop = 1, e = "taniec17"}},
                {label = "Taniec 18", type = "anim", data = {lib = "anim@amb@nightclub@mini@dance@dance_solo@female@var_b@", anim = "low_center",  loop = 1, e = "taniec18"}},
                {label = "Taniec 19", type = "anim", data = {lib = "anim@amb@nightclub@mini@dance@dance_solo@female@var_a@", anim = "med_center_up",  loop = 1, e = "taniec19"}},
                {label = "Taniec 20", type = "anim", data = {lib = "anim@amb@nightclub@dancers@crowddance_facedj@hi_intensity", anim = "hi_dance_facedj_09_v2_female^1",  loop = 1, e = "taniec20"}},
                {label = "Taniec 21", type = "anim", data = {lib = "anim@amb@nightclub@dancers@crowddance_facedj@hi_intensity", anim = "hi_dance_facedj_09_v2_female^3",  loop = 1, e = "taniec21"}},
                {label = "Taniec 22", type = "anim", data = {lib = "anim@amb@nightclub@dancers@crowddance_facedj_transitions@from_med_intensity", anim = "trans_dance_facedj_mi_to_hi_08_v1_female^3",  loop = 1, e = "taniec22"}},
                {label = "Taniec 23", type = "anim", data = {lib = "anim@amb@nightclub@dancers@crowddance_groups_transitions@", anim = "trans_dance_crowd_hi_to_li_09_v1_female^3",  loop = 1, e = "taniec23"}},
                {label = "Taniec 24", type = "anim", data = {lib = "anim@mp_player_intcelebrationmale@thumb_on_ears", anim = "thumb_on_ears",  loop = 1, e = "taniec24"}},
                {label = "Taniec 25", type = "anim", data = {lib = "special_ped@mountain_dancer@monologue_2@monologue_2a", anim = "mnt_dnc_angel",  loop = 1, e = "taniec25"}},
                {label = "Taniec 26", type = "anim", data = {lib = "anim@amb@nightclub@mini@dance@dance_solo@female@var_b@", anim = "high_center",  loop = 1, e = "taniec26"}},
                {label = "Taniec 27", type = "anim", data = {lib = "anim@amb@nightclub@mini@dance@dance_solo@female@var_b@", anim = "high_center_up",  loop = 1, e = "taniec27"}},
                {label = "Taniec 28", type = "anim", data = {lib = "anim@amb@casino@mini@dance@dance_solo@female@var_b@", anim = "high_center",  loop = 1, e = "taniec28"}},
                {label = "Taniec 29", type = "anim", data = {lib = "anim@amb@nightclub@mini@dance@dance_solo@female@var_a@", anim = "low_center_down",  loop = 1, e = "taniec29"}},
                {label = "Taniec 30", type = "anim", data = {lib = "timetable@tracy@ig_8@idle_b", anim = "idle_d",  loop = 1, e = "taniec30"}},
                {label = "Taniec 31", type = "anim", data = {lib = "timetable@tracy@ig_5@idle_a", anim = "idle_a",  loop = 1, e = "taniec31"}},
                {label = "Taniec 32", type = "anim", data = {lib = "anim@amb@nightclub@lazlow@hi_podium@", anim = "danceidle_hi_11_buttwiggle_b_laz",  loop = 1, e = "taniec32"}},
                {label = "Taniec 33", type = "anim", data = {lib = "move_clown@p_m_two_idles@", anim = "fidget_short_dance",  loop = 1, e = "taniec33"}},
                {label = "Taniec 34", type = "anim", data = {lib = "anim@amb@nightclub@mini@dance@dance_solo@techno_monkey@", anim = "high_center",  loop = 1, e = "taniec34"}},
                {label = "Taniec 35", type = "anim", data = {lib = "anim@amb@nightclub@mini@dance@dance_solo@techno_monkey@", anim = "high_center_down",  loop = 1, e = "taniec35"}},
                {label = "Taniec 36", type = "anim", data = {lib = "anim@amb@nightclub@mini@dance@dance_solo@techno_monkey@", anim = "med_center_down",  loop = 1, e = "taniec36"}},
                {label = "Taniec 37", type = "anim", data = {lib = "anim@amb@nightclub_island@dancers@crowddance_single_props@", anim = "mi_dance_prop_13_v1_male^3",  loop = 1, e = "taniec37"}},
                {label = "Taniec 38", type = "anim", data = {lib = "anim@amb@nightclub_island@dancers@crowddance_groups@groupd@", anim = "mi_dance_crowd_13_v2_male^1",  loop = 1, e = "taniec38"}},
                {label = "Taniec 39", type = "anim", data = {lib = "anim@amb@nightclub_island@dancers@crowddance_facedj@", anim = "mi_dance_facedj_17_v2_male^4",  loop = 1, e = "taniec39"}},
                {label = "Taniec 40", type = "anim", data = {lib = "anim@amb@nightclub_island@dancers@crowddance_facedj@", anim = "mi_dance_facedj_15_v2_male^4",  loop = 1, e = "taniec40"}},
                {label = "Taniec 41", type = "anim", data = {lib = "anim@amb@nightclub_island@dancers@crowddance_facedj@", anim = "hi_dance_facedj_hu_15_v2_male^5",  loop = 1, e = "taniec41"}},
                {label = "Taniec 42", type = "anim", data = {lib = "anim@amb@nightclub@mini@dance@dance_solo@shuffle@", anim = "high_right_up",  loop = 1, e = "taniec42"}},
                {label = "Taniec 43", type = "anim", data = {lib = "anim@amb@nightclub@mini@dance@dance_solo@shuffle@", anim = "med_center",  loop = 1, e = "taniec43"}},
                {label = "Taniec 44", type = "anim", data = {lib = "anim@amb@nightclub@mini@dance@dance_solo@shuffle@", anim = "high_right_down",  loop = 1, e = "taniec44"}},
                {label = "Taniec 45", type = "anim", data = {lib = "anim@amb@nightclub_island@dancers@crowddance_groups@groupd@", anim = "mi_dance_crowd_13_v2_male^1",  loop = 1, e = "taniec45"}},
                {label = "Taniec 46", type = "anim", data = {lib = "anim@amb@nightclub@mini@dance@dance_solo@shuffle@", anim = "high_left_down",  loop = 1, e = "taniec46"}},
                {label = "Taniec 47", type = "anim", data = {lib = "anim@amb@nightclub@mini@dance@dance_solo@male@var_b@", anim = "low_center",  loop = 1, e = "taniec47"}},
                {label = "Taniec 48", type = "anim", data = {lib = "anim@amb@nightclub@mini@dance@dance_paired@dance_d@", anim = "ped_a_dance_idle",  loop = 1, e = "taniec48"}},
                {label = "Taniec 49", type = "anim", data = {lib = "anim@amb@nightclub@mini@dance@dance_paired@dance_b@", anim = "ped_a_dance_idle",  loop = 1, e = "taniec49"}},
                {label = "Taniec 50", type = "anim", data = {lib = "anim@amb@nightclub@mini@dance@dance_paired@dance_a@", anim = "ped_a_dance_idle",  loop = 1, e = "taniec50"}},
                {label = "Taniec 51", type = "anim", data = {lib = "anim@mp_player_intuppersalsa_roll", anim = "idle_a",  loop = 1, e = "taniec51"}},
                {label = "Taniec 52", type = "anim", data = {lib = "anim@mp_player_intcelebrationfemale@uncle_disco", anim = "uncle_disco",  loop = 1, e = "taniec52"}},
                {label = "Taniec 53", type = "anim", data = {lib = "anim@amb@nightclub_island@dancers@club@", anim = "hi_idle_a_f02",  loop = 1, e = "taniec53"}},
                {label = "Taniec 54", type = "anim", data = {lib = "anim@amb@nightclub_island@dancers@club@", anim = "hi_idle_b_m03",  loop = 1, e = "taniec54"}},
                {label = "Taniec 55", type = "anim", data = {lib = "anim@amb@nightclub_island@dancers@beachdance@", anim = "hi_idle_b_f01",  loop = 1, e = "taniec55"}},
                {label = "Taniec 56", type = "anim", data = {lib = "anim@amb@nightclub_island@dancers@beachdance@", anim = "hi_idle_a_m02",  loop = 1, e = "taniec56"}},
                {label = "Taniec 57", type = "anim", data = {lib = "anim@amb@nightclub_island@dancers@beachdance@", anim = "hi_idle_a_m05",  loop = 1, e = "taniec57"}},
                {label = "Taniec 58", type = "anim", data = {lib = "anim@amb@nightclub_island@dancers@beachdance@", anim = "hi_idle_a_m03",  loop = 1, e = "taniec58"}},
                {label = "Taniec 59", type = "anim", data = {lib = "anim@amb@nightclub_island@dancers@crowddance_groups@groupd@", anim = "mi_dance_crowd_13_v2_male^1",  loop = 1, e = "taniec59"}},
                {label = "Taniec 60", type = "anim", data = {lib = "anim@amb@nightclub_island@dancers@club@", anim = "hi_idle_d_f01",  loop = 1, e = "taniec60"}},
                {label = "Klubowy 1 (Dla kobiet)", type = "anim", data = {lib = "anim@amb@nightclub@dancers@crowddance_facedj_transitions@from_med_intensity", anim = "trans_dance_facedj_mi_to_hi_08_v1_female^1",  loop = 1, e = "klubowy1"}},
                {label = "Klubowy 2 (Dla mężczyzn)", type = "anim", data = {lib = "anim@amb@nightclub@dancers@crowddance_facedj_transitions@from_med_intensity", anim = "trans_dance_facedj_mi_to_hi_08_v1_male^2",  loop = 1, e = "klubowy2"}},
                {label = "Klubowy 3 (Dla kobiet)", type = "anim", data = {lib = "anim@amb@nightclub@dancers@crowddance_facedj_transitions@from_med_intensity", anim = "trans_dance_facedj_mi_to_hi_08_v1_female^3",  loop = 1, e = "klubowy3"}},
                {label = "Klubowy 4", type = "anim", data = {lib = "anim@amb@nightclub@lazlow@hi_podium@", anim = "danceidle_mi_17_crotchgrab_laz",  loop = 1, e = "klubowy4"}},
            }
        }, 

        {
            name = 'Imprezowe',
            label = 'Imprezowe',
            items = {
                {label = "DJ", type = "anim", data = {lib = "mini@strip_club@idles@dj@idle_02", anim = "idle_02", loop = 1, e = "dj"}},
                {label = "Oglądanie występu", type = "anim", data = {lib = "amb@world_human_strip_watch_stand@male_a@base", anim = "base", loop = 1, e = "ogladanie"}},
                {label = "Gest 1 - Ręce w górze", type = "anim", data = {lib = "mp_player_int_uppergang_sign_a", anim = "mp_player_int_gang_sign_a", loop = 57, e = "gest"}},
                {label = "Gest 2 - Znak V", type = "anim", data = {lib = "mp_player_int_upperv_sign", anim = "mp_player_int_v_sign", loop = 57, e = "gest2"}},
                {label = "Gest 3 - Znak V 2", type = "anim", data = {lib = "anim@mp_player_intupperpeace", anim = "idle_a_fp", loop = 57, e = "gest2"}},
                {label = "Gest 3 - Znak V 3", type = "anim", data = {lib = "anim@mp_player_intincarpeacebodhi@ds@", anim = "idle_a", loop = 57, e = "gest2"}},
                {label = "Bycie pijanym", type = "anim", data = {lib = "amb@world_human_bum_standing@drunk@idle_a", anim = "idle_a", loop = 1, e = "pijany"}},
                {label = "Udawanie gry na gitarze", type = "anim", data = {lib = "anim@mp_player_intcelebrationmale@air_guitar", anim = "air_guitar", loop = 0, e = "udawaniegry"}},
                {label = "Rock'n roll 1", type = "anim", data = {lib = "mp_player_int_upperrock", anim = "mp_player_int_rock_enter", loop = 56, e = "rock"}},
                {label = "Rock'n roll 2", type = "anim", data = {lib = "mp_player_introck", anim = "mp_player_int_rock", loop = 56, e = "rock2"}},           
                {label = "Rzucanie hajsem", type = "anim", data = {lib = "anim@arena@celeb@flat@solo@props@", anim = "make_it_rain_b_player_b", loop = 0, e = "hajs"}},
                {label = "Śmiech", type = "anim", data = {lib = "anim@arena@celeb@flat@solo@no_props@", anim = "taunt_e_player_b", loop = 0, e = "smiech"}},
                {label = "Pozowanie - manekin", type = "scenario", data = {anim = "WORLD_HUMAN_HUMAN_STATUE", loop = 1, e = "manekin"}},
                {label = "Pozowanie - manekin 2", type = "anim", data = {lib = "fra_0_int-1", anim = "cs_lamardavis_dual-1", loop = 49, e = "manekin3"}},
                {label = "Pozowanie - manekin 3", type = "anim", data = {lib = "club_intro2-0", anim = "csb_englishdave_dual-0", loop = 0, e = "manekin3"}},
                {label = "Wymiotowanie w aucie", type = "anim", data = {lib = "oddjobs@taxi@tie", anim = "vomit_outside", loop = 0, e = "wymioty"}},
                {label = "Udawanie ptaka", type = "anim", data = {lib = "random@peyote@bird", anim = "wakeup", loop = 51, e = "ptak"}},
                {label = "Udawanie kurczaka", type = "anim", data = {lib = "random@peyote@chicken", anim = "wakeup", loop = 51, e = "kurczak"}},
                {label = "Udawanie królika", type = "anim", data = {lib = "random@peyote@rabbit", anim = "wakeup", loop = 1, e = "krolik"}},
                {label = "Udawanie klauna 1", type = "anim", data = {lib = "rcm_barry2", anim = "clown_idle_0", loop = 1, e = "klaun"}},           
                {label = "Udawanie klauna 2", type = "anim", data = {lib = "rcm_barry2", anim = "clown_idle_1", loop = 1, e = "klaun2"}},
                {label = "Udawanie klauna 3", type = "anim", data = {lib = "rcm_barry2", anim = "clown_idle_2", loop = 1, e = "klaun3"}},
                {label = "Udawanie klauna 4", type = "anim", data = {lib = "rcm_barry2", anim = "clown_idle_3", loop = 1, e = "klaun4"}},
                {label = "Udawanie klauna 5", type = "anim", data = {lib = "rcm_barry2", anim = "clown_idle_6", loop = 1, e = "klaun5"}},
                {label = "Kontrolowanie umysłu", type = "anim", data = {lib = "rcmbarry", anim = "mind_control_b_loop", loop = 56, e = "kontrolowanie"}},
                {label = "Kontrolowanie umysłu 2", type = "anim", data = {lib = "rcmbarry", anim = "bar_1_attack_idle_aln", loop = 56, e = "kontrolowanie2"}},
            }
        },

        {
            name = 'Miłosne',
            label = 'Miłosne',
            items = {
                {label = "Przytul 1", type = "anim", data = {lib = "mp_ped_interaction", anim = "kisses_guy_a", loop = 0, e = "przytul"}},
                {label = "Przytul 2", type = "anim", data = {lib = "mp_ped_interaction", anim = "kisses_guy_b", loop = 0, e = "przytul2"}},        	
                {label = "Całus 1", type = "anim", data = {lib = "anim@mp_player_intselfieblow_kiss", anim = "exit", loop = 56, e = "calus"}},
                {label = "Całus 2", type = "anim", data = {lib = "mini@hookers_sp", anim = "idle_a", loop = 0, e = "calus2"}},
                {label = "Całus 3", type = "anim", data = {lib = "anim@mp_player_intcelebrationfemale@blow_kiss", anim = "blow_kiss", loop = 56, e = "calus3"}},
                {label = "Uroczo", type = "anim", data = {lib = "mini@hookers_spcokehead", anim = "idle_reject_loop_a", loop = 58, e = "uroczo"}},
                {label = "Zawstydzenie", type = "anim", data = {lib = "anim@arena@celeb@podium@no_prop@", anim = "regal_a_3rd", loop = 0, e = "zawstydzenie"}},
                {label = "Zawstydzenie 2", type = "anim", data = {lib = "amb@world_human_hang_out_street@female_hold_arm@idle_a", anim = "idle_a", loop = 51, e = "zawstydzenie2"}},          
                {label = "Uwodzenie", type = "anim", data = {lib = "mini@strip_club@idles@stripper", anim = "stripper_idle_02", loop = 1, e = "uwodzenie"}},
            }
        },

        {
            name  = 'Style chodzenia',
            label = 'Style chodzenia',
            items = {
                {label = "Normalny [K]", type = "attitude", data = {lib = "move_f@generic", anim = "move_f@generic", e = ""}},
                {label = "Normalny [M]", type = "attitude", data = {lib = "move_m@generic", anim = "move_m@generic", e = ""}},
                {label = "Pewniak [K]", type = "attitude", data = {lib = "move_f@heels@d", anim = "move_f@heels@d", e = ""}},
                {label = "Pewniak [M]", type = "attitude", data = {lib = "move_m@confident", anim = "move_m@confident", e = ""}},
                {label = "Gruby [K]", type = "attitude", data = {lib = "move_f@fat@a", anim = "move_f@fat@a", e = ""}},
                {label = "Gruby [M]", type = "attitude", data = {lib = "move_m@fat@a", anim = "move_m@fat@a", e = ""}},
                {label = "Poszkodowany [K]", type = "attitude", data = {lib = "move_f@injured", anim = "move_f@injured", e = ""}},
                {label = "Poszkodowany [M]", type = "attitude", data = {lib = "move_m@injured", anim = "move_m@injured", e = ""}},
                {label = "Policjant", type = "attitude", data = {lib = "move_m@tool_belt@a", anim = "move_m@tool_belt@a", e = ""}},
                {label = "Policjantka", type = "attitude", data = {lib = "move_f@tool_belt@a", anim = "move_f@tool_belt@a", e = ""}},
                {label = "Zuchwały [K]", type = "attitude", data = {lib = "move_f@sassy", anim = "move_f@sassy", e = ""}},
                {label = "Zuchwały [M]", type = "attitude", data = {lib = "move_m@sassy", anim = "move_m@sassy", e = ""}},
                {label = "Smutny", type = "attitude", data = {lib = "move_m@depressed@a", anim = "move_m@depressed@a", e = ""}},
                {label = "Biznes", type = "attitude", data = {lib = "move_m@business@a", anim = "move_m@business@a", e = ""}},
                {label = "Odważny", type = "attitude", data = {lib = "move_m@brave@a", anim = "move_m@brave@a", e = ""}},
                {label = "Luzak", type = "attitude", data = {lib = "move_m@casual@e", anim = "move_m@casual@e", e = ""}},
                {label = "Hipster", type = "attitude", data = {lib = "move_m@hipster@a", anim = "move_m@hipster@a", e = ""}},
                {label = "Smutny", type = "attitude", data = {lib = "move_m@sad@a", anim = "move_m@sad@a", e = ""}},
                {label = "Siłacz", type = "attitude", data = {lib = "move_m@muscle@a", anim = "move_m@muscle@a", e = ""}},
                {label = "Gangster 1", type = "attitude", data = {lib = "move_m@gangster@generic", anim = "move_m@gangster@generic", e = ""}},
                {label = "Gangster 2", type = "attitude", data = {lib = "move_m@money", anim = "move_m@money", e = ""}},
                {label = "Gangster 3", type = "attitude", data = {lib = "move_m@gangster@ng", anim = "move_m@gangster@ng", e = ""}},
                {label = "Gangster 4", type = "attitude", data = {lib = "move_m@gangster@var_e", anim = "move_m@gangster@var_e", e = ""}},
                {label = "Wspinaczka", type = "attitude", data = {lib = "move_m@hiking", anim = "move_m@hiking", e = ""}},
                {label = "Bezdomny", type = "attitude", data = {lib = "move_m@hobo@a", anim = "move_m@hobo@a", e = ""}},
                {label = "Podpity", type = "attitude", data = {lib = "move_m@buzzed", anim = "move_m@buzzed", e = ""}},
                {label = "Średnio Pijany", type = "attitude", data = {lib = "move_m@drunk@moderatedrunk", anim = "move_m@drunk@moderatedrunk", e = ""}},
                {label = "Bardzo Pijany", type = "attitude", data = {lib = "move_m@drunk@verydrunk", anim = "move_m@drunk@verydrunk", e = ""}},
                {label = "W pośpiechu 1", type = "attitude", data = {lib = "move_m@hurry_butch@b", anim = "move_m@hurry_butch@b", e = ""}},
                {label = "W pośpiechu 2", type = "attitude", data = {lib = "move_m@hurry@b", anim = "move_m@hurry@b", e = ""}},
                {label = "Szybki", type = "attitude", data = {lib = "move_m@quick", anim = "move_m@quick", e = ""}},
                {label = "Dziwny", type = "attitude", data = {lib = "move_m@alien", anim = "move_m@alien", e = ""}},
                {label = "Uzbrojony", type = "attitude", data = {lib = "anim_group_move_ballistic", anim = "anim_group_move_ballistic", e = ""}},
                {label = "Arogancki", type = "attitude", data = {lib = "move_f@arrogant@a", anim = "move_f@arrogant@a", e = ""}},
                {label = "Swagger", type = "attitude", data = {lib = "move_m@swagger", anim = "move_m@swagger", e = ""}},
            }
        }  
    },

    Synced = {
        {
            ['Label'] = 'Przytul',
            ['Requester'] = {
                ['Type'] = 'animation', ['Dict'] = 'mp_ped_interaction', ['Anim'] = 'kisses_guy_a', ['Flags'] = 0,
            },
            ['Accepter'] = {
                ['Type'] = 'animation', ['Dict'] = 'mp_ped_interaction', ['Anim'] = 'kisses_guy_b', ['Flags'] = 0, ['Attach'] = {
                    ['Bone'] = 9816,
                    ['xP'] = 0.05,
                    ['yP'] = 1.15,
                    ['zP'] = -0.05,
    
                    ['xR'] = 0.0,
                    ['yR'] = 0.0,
                    ['zR'] = 180.0,
                }
            }
        },
        {
            ['Label'] = 'Piątka',
            ['Requester'] = {
                ['Type'] = 'animation', ['Dict'] = 'mp_ped_interaction', ['Anim'] = 'highfive_guy_a', ['Flags'] = 0,
            },
            ['Accepter'] = {
                ['Type'] = 'animation', ['Dict'] = 'mp_ped_interaction', ['Anim'] = 'highfive_guy_b', ['Flags'] = 0, ['Attach'] = {
                    ['Bone'] = 9816,
                    ['xP'] = -0.5,
                    ['yP'] = 1.25,
                    ['zP'] = 0.0,
    
                    ['xR'] = 0.9,
                    ['yR'] = 0.3,
                    ['zR'] = 180.0,
                }
            }
        },
        {
            ['Label'] = 'Przytul po przyjacielsku',
            ['Requester'] = {
                ['Type'] = 'animation', ['Dict'] = 'mp_ped_interaction', ['Anim'] = 'hugs_guy_a', ['Flags'] = 0,
            },
            ['Accepter'] = {
                ['Type'] = 'animation', ['Dict'] = 'mp_ped_interaction', ['Anim'] = 'hugs_guy_b', ['Flags'] = 0, ['Attach'] = {
                    ['Bone'] = 9816,
                    ['xP'] = -0.025,
                    ['yP'] = 1.15,
                    ['zP'] = 0.0,
    
                    ['xR'] = 0.0,
                    ['yR'] = 0.0,
                    ['zR'] = 180.0,
                }
            }
        },
        {
            ['Label'] = 'Żółwik',
            ['Requester'] = {
                ['Type'] = 'animation', ['Dict'] = 'anim@mp_player_intcelebrationpaired@f_f_fist_bump', ['Anim'] = 'fist_bump_left', ['Flags'] = 0,
            },
            ['Accepter'] = {
                ['Type'] = 'animation', ['Dict'] = 'anim@mp_player_intcelebrationpaired@f_f_fist_bump', ['Anim'] = 'fist_bump_right', ['Flags'] = 0, ['Attach'] = {
                    ['Bone'] = 9816,
                    ['xP'] = -0.6,
                    ['yP'] = 0.9,
                    ['zP'] = 0.0,
    
                    ['xR'] = 0.0,
                    ['yR'] = 0.0,
                    ['zR'] = 270.0,
                }
            }
        },
        {
            ['Label'] = 'Podaj ręke (koleżeńskie)',
            ['Requester'] = {
                ['Type'] = 'animation', ['Dict'] = 'mp_ped_interaction', ['Anim'] = 'handshake_guy_a', ['Flags'] = 0,
            },
            ['Accepter'] = {
                ['Type'] = 'animation', ['Dict'] = 'mp_ped_interaction', ['Anim'] = 'handshake_guy_b', ['Flags'] = 0, ['Attach'] = {
                    ['Bone'] = 9816,
                    ['xP'] = 0.0,
                    ['yP'] = 1.2,
                    ['zP'] = 0.0,
    
                    ['xR'] = 0.0,
                    ['yR'] = 0.0,
                    ['zR'] = 180.0,
                }
            }
        },
        {
            ['Label'] = 'Podaj ręke (oficjalnie)',
            ['Requester'] = {
                ['Type'] = 'animation', ['Dict'] = 'mp_common', ['Anim'] = 'givetake1_a', ['Flags'] = 0,
            },
            ['Accepter'] = {
                ['Type'] = 'animation', ['Dict'] = 'mp_common', ['Anim'] = 'givetake1_b', ['Flags'] = 0, ['Attach'] = {
                    ['Bone'] = 9816,
                    ['xP'] = 0.075,
                    ['yP'] = 1.0,
                    ['zP'] = 0.0,
    
                    ['xR'] = 0.0,
                    ['yR'] = 0.0,
                    ['zR'] = 180.0,
                }
            }
        },
        {
            ['Label'] = 'Uderz',
            ['Requester'] = {
                ['Type'] = 'animation', ['Dict'] = 'melee@unarmed@streamed_variations', ['Anim'] = 'plyr_takedown_rear_lefthook', ['Flags'] = 0,
            },
            ['Accepter'] = {
                ['Type'] = 'animation', ['Dict'] = 'melee@unarmed@streamed_variations', ['Anim'] = 'victim_takedown_front_cross_r', ['Flags'] = 0, ['Attach'] = {
                    ['Bone'] = 9816,
                    ['xP'] = 0.05,
                    ['yP'] = 1.15,
                    ['zP'] = -0.05,
    
                    ['xR'] = 0.0,
                    ['yR'] = 0.0,
                    ['zR'] = 180.0,
                }
            }
        },
        {
            ['Label'] = 'Uderz z liścia',
            ['Requester'] = {
                ['Type'] = 'animation', ['Dict'] = 'melee@unarmed@streamed_variations', ['Anim'] = 'plyr_takedown_front_slap', ['Flags'] = 0,
            },
            ['Accepter'] = {
                ['Type'] = 'animation', ['Dict'] = 'melee@unarmed@streamed_variations', ['Anim'] = 'victim_takedown_front_backslap', ['Flags'] = 0, ['Attach'] = {
                    ['Bone'] = 9816,
                    ['xP'] = 0.05,
                    ['yP'] = 1.15,
                    ['zP'] = -0.05,
    
                    ['xR'] = 0.0,
                    ['yR'] = 0.0,
                    ['zR'] = 180.0,
                }
            }
        },
        {
            ['Label'] = 'Uderz z główki',
            ['Requester'] = {
                ['Type'] = 'animation', ['Dict'] = 'melee@unarmed@streamed_variations', ['Anim'] = 'plyr_takedown_front_headbutt', ['Flags'] = 0,
            },
            ['Accepter'] = {
                ['Type'] = 'animation', ['Dict'] = 'melee@unarmed@streamed_variations', ['Anim'] = 'victim_takedown_front_headbutt', ['Flags'] = 0, ['Attach'] = {
                    ['Bone'] = 9816,
                    ['xP'] = 0.05,
                    ['yP'] = 1.15,
                    ['zP'] = -0.05,
    
                    ['xR'] = 0.0,
                    ['yR'] = 0.0,
                    ['zR'] = 180.0,
                }
            }
        },
        {
            ['Label'] = 'Gra w baseballa',
            ['Requester'] = {
                ['Type'] = 'animation', ['Dict'] = 'anim@arena@celeb@flat@paired@no_props@', ['Anim'] = 'baseball_a_player_a', ['Flags'] = 0,
            },
            ['Accepter'] = {
                ['Type'] = 'animation', ['Dict'] = 'anim@arena@celeb@flat@paired@no_props@', ['Anim'] = 'baseball_a_player_b', ['Flags'] = 0, ['Attach'] = {
                    ['Bone'] = 9816,
                    ['xP'] = -0.5,
                    ['yP'] = 1.25,
                    ['zP'] = 0.0,
    
                    ['xR'] = 0.9,
                    ['yR'] = 0.3,
                    ['zR'] = 180.0,
                }
            }
        },
        {
            ['Label'] = 'Wspólny taniec 1',
            ['Requester'] = {
                ['Type'] = 'animation', ['Dict'] = 'anim@amb@nightclub@mini@dance@dance_solo@female@var_a@', ['Anim'] = 'low_center', ['Flags'] = 1,
            },
            ['Accepter'] = {
                ['Type'] = 'animation', ['Dict'] = 'anim@amb@nightclub@mini@dance@dance_solo@female@var_a@', ['Anim'] = 'low_center', ['Flags'] = 1, ['Attach'] = {
                    ['Bone'] = 9816,
                    ['xP'] = 0.05,
                    ['yP'] = 1.15,
                    ['zP'] = -0.05,
    
                    ['xR'] = 0.0,
                    ['yR'] = 0.0,
                    ['zR'] = 180.0,
                }
            }
        },
        {
            ['Label'] = 'Wspólny taniec 2',
            ['Requester'] = {
                ['Type'] = 'animation', ['Dict'] = 'anim@amb@nightclub@dancers@crowddance_facedj@hi_intensity', ['Anim'] = 'hi_dance_facedj_09_v1_female^1', ['Flags'] = 1,
            },
            ['Accepter'] = {
                ['Type'] = 'animation', ['Dict'] = 'anim@amb@nightclub@dancers@crowddance_facedj@hi_intensity', ['Anim'] = 'hi_dance_facedj_09_v1_female^1', ['Flags'] = 1, ['Attach'] = {
                    ['Bone'] = 9816,
                    ['xP'] = 0.05,
                    ['yP'] = 1.15,
                    ['zP'] = -0.05,
    
                    ['xR'] = 0.0,
                    ['yR'] = 0.0,
                    ['zR'] = 180.0,
                }
            }
        },
        {
            ['Label'] = 'Wspólny taniec 3',
            ['Requester'] = {
                ['Type'] = 'animation', ['Dict'] = 'anim@amb@nightclub@mini@dance@dance_solo@female@var_b@', ['Anim'] = 'high_center', ['Flags'] = 1,
            },
            ['Accepter'] = {
                ['Type'] = 'animation', ['Dict'] = 'anim@amb@nightclub@mini@dance@dance_solo@female@var_b@', ['Anim'] = 'high_center', ['Flags'] = 1, ['Attach'] = {
                    ['Bone'] = 9816,
                    ['xP'] = 0.05,
                    ['yP'] = 1.15,
                    ['zP'] = -0.05,
    
                    ['xR'] = 0.0,
                    ['yR'] = 0.0,
                    ['zR'] = 180.0,
                }
            }
        },
        {
            ['Label'] = 'Wspólny taniec 4',
            ['Requester'] = {
                ['Type'] = 'animation', ['Dict'] = 'anim@amb@nightclub@dancers@crowddance_facedj@hi_intensity', ['Anim'] = 'hi_dance_facedj_09_v2_female^1', ['Flags'] = 1,
            },
            ['Accepter'] = {
                ['Type'] = 'animation', ['Dict'] = 'anim@amb@nightclub@dancers@crowddance_facedj@hi_intensity', ['Anim'] = 'hi_dance_facedj_09_v2_female^1', ['Flags'] = 1, ['Attach'] = {
                    ['Bone'] = 9816,
                    ['xP'] = 0.05,
                    ['yP'] = 1.15,
                    ['zP'] = -0.05,
    
                    ['xR'] = 0.0,
                    ['yR'] = 0.0,
                    ['zR'] = 180.0,
                }
            }
        },
        {
            ['Label'] = 'Wspólny taniec 5',
            ['Requester'] = {
                ['Type'] = 'animation', ['Dict'] = 'anim@amb@nightclub@dancers@solomun_entourage@', ['Anim'] = 'mi_dance_facedj_17_v1_female^1', ['Flags'] = 1,
            },
            ['Accepter'] = {
                ['Type'] = 'animation', ['Dict'] = 'anim@amb@nightclub@dancers@solomun_entourage@', ['Anim'] = 'mi_dance_facedj_17_v1_female^1', ['Flags'] = 1, ['Attach'] = {
                    ['Bone'] = 9816,
                    ['xP'] = 0.05,
                    ['yP'] = 1.15,
                    ['zP'] = -0.05,
    
                    ['xR'] = 0.0,
                    ['yR'] = 0.0,
                    ['zR'] = 180.0,
                }
            }
        },
        {
            ['Label'] = 'Wspólny taniec 6',
            ['Requester'] = {
                ['Type'] = 'animation', ['Dict'] = 'anim@amb@nightclub@lazlow@hi_podium@', ['Anim'] = 'danceidle_mi_17_crotchgrab_laz', ['Flags'] = 1,
            },
            ['Accepter'] = {
                ['Type'] = 'animation', ['Dict'] = 'anim@amb@nightclub@lazlow@hi_podium@', ['Anim'] = 'danceidle_mi_17_crotchgrab_laz', ['Flags'] = 1, ['Attach'] = {
                    ['Bone'] = 9816,
                    ['xP'] = 0.05,
                    ['yP'] = 1.15,
                    ['zP'] = -0.05,
    
                    ['xR'] = 0.0,
                    ['yR'] = 0.0,
                    ['zR'] = 180.0,
                }
            }
        },
        {
            ['Label'] = 'Wspólny taniec 7',
            ['Requester'] = {
                ['Type'] = 'animation', ['Dict'] = 'anim@mp_player_intcelebrationmale@uncle_disco', ['Anim'] = 'uncle_disco', ['Flags'] = 1,
            },
            ['Accepter'] = {
                ['Type'] = 'animation', ['Dict'] = 'anim@mp_player_intcelebrationmale@uncle_disco', ['Anim'] = 'uncle_disco', ['Flags'] = 1, ['Attach'] = {
                    ['Bone'] = 9816,
                    ['xP'] = 0.05,
                    ['yP'] = 1.15,
                    ['zP'] = -0.05,
    
                    ['xR'] = 0.0,
                    ['yR'] = 0.0,
                    ['zR'] = 180.0,
                }
            }
        },
    
        {
            ['Label'] = 'Wspólny taniec 8',
            ['Requester'] = {
                ['Type'] = 'animation', ['Dict'] = 'anim@amb@casino@mini@dance@dance_solo@female@var_b@', ['Anim'] = 'high_center', ['Flags'] = 1,
            },
            ['Accepter'] = {
                ['Type'] = 'animation', ['Dict'] = 'anim@amb@casino@mini@dance@dance_solo@female@var_b@', ['Anim'] = 'high_center', ['Flags'] = 1, ['Attach'] = {
                    ['Bone'] = 9816,
                    ['xP'] = 0.05,
                    ['yP'] = 1.15,
                    ['zP'] = -0.05,
    
                    ['xR'] = 0.0,
                    ['yR'] = 0.0,
                    ['zR'] = 180.0,
                }
            }
        },
    
        {
            ['Label'] = 'Pocałuj',
            ['Requester'] = {
                ['Type'] = 'animation', ['Dict'] = 'hs3_ext-20', ['Anim'] = 'cs_lestercrest_3_dual-20', ['Flags'] = 1,
            },
            ['Accepter'] = {
                ['Type'] = 'animation', ['Dict'] = 'hs3_ext-20', ['Anim'] = 'csb_georginacheng_dual-20', ['Flags'] = 1, ['Attach'] = {
                    ['Bone'] = 0,
                    ['xP'] = 0.0,
                    ['yP'] = 0.53,
                    ['zP'] = 0.0,
    
                    ['xR'] = 0.0,
                    ['yR'] = 0.0,
                    ['zR'] = 180.0,
                }
            }
        },
    
        {
            ['Label'] = 'Obejmowanie',
            ['Requester'] = {
                ['Type'] = 'animation', ['Dict'] = 'misscarsteal2chad_goodbye', ['Anim'] = 'chad_armsaround_chad', ['Flags'] = 1, ['Attach'] = {
                    ['Bone'] = 9816,
                    ['xP'] = -0.07,
                    ['yP'] = 0.63,
                    ['zP'] = 0.00,
    
                    ['xR'] = 0.0,
                    ['yR'] = 0.53,
                    ['zR'] = 180.0,
                    }
            },
            ['Accepter'] = {
                ['Type'] = 'animation', ['Dict'] = 'misscarsteal2chad_goodbye', ['Anim'] = 'chad_armsaround_girl', ['Flags'] = 1
            },
        },
    
        {
            ['Label'] = 'Zrób loda (na stojąco)',
            ['Requester'] = {
                ['Type'] = 'animation', ['Dict'] = 'misscarsteal2pimpsex', ['Anim'] = 'pimpsex_hooker', ['Flags'] = 1, ['Attach'] = {
                    ['Bone'] = 9816,
                    ['xP'] = 0.0,
                    ['yP'] = 0.65,
                    ['zP'] = 0.0,
    
                    ['xR'] = 120.0,
                    ['yR'] = 0.0,
                    ['zR'] = 180.0,
                }
            },
            ['Accepter'] = {
                ['Type'] = 'animation', ['Dict'] = 'misscarsteal2pimpsex', ['Anim'] = 'pimpsex_punter', ['Flags'] = 1,
            },
        },
        {
            ['Label'] = 'Sex (na stojąco)',
            ['Requester'] = {
                ['Type'] = 'animation', ['Dict'] = 'misscarsteal2pimpsex', ['Anim'] = 'shagloop_hooker', ['Flags'] = 1, ['Attach'] = {
                    ['Bone'] = 9816,
                    ['xP'] = 0.05,
                    ['yP'] = 0.4,
                    ['zP'] = 0.0,
    
                    ['xR'] = 120.0,
                    ['yR'] = 0.0,
                    ['zR'] = 180.0,
                }
            },
            ['Accepter'] = {
                ['Type'] = 'animation', ['Dict'] = 'misscarsteal2pimpsex', ['Anim'] = 'shagloop_pimp', ['Flags'] = 1,
            },
        },
        {
            ['Label'] = 'Anal (na stojąco)', 
            ['Requester'] = {
                ['Type'] = 'animation', ['Dict'] = 'rcmpaparazzo_2', ['Anim'] = 'shag_loop_a', ['Flags'] = 1,
            }, 
            ['Accepter'] = {
                ['Type'] = 'animation', ['Dict'] = 'rcmpaparazzo_2', ['Anim'] = 'shag_loop_poppy', ['Flags'] = 1, ['Attach'] = {
                    ['Bone'] = 9816,
                    ['xP'] = 0.015,
                    ['yP'] = 0.35,
                    ['zP'] = 0.0,
    
                    ['xR'] = 0.9,
                    ['yR'] = 0.3,
                    ['zR'] = 0.0,
                },
            },
        },
        {
            ['Label'] = "Uprawiaj sex (pojazd)", 
            ['Car'] = true,
            ['Requester'] = {
                ['Type'] = 'animation', ['Dict'] = 'oddjobs@assassinate@vice@sex', ['Anim'] = 'frontseat_carsex_loop_m', ['Flags'] = 1,
            }, 
            ['Accepter'] = {
                ['Type'] = 'animation', ['Dict'] = 'oddjobs@assassinate@vice@sex', ['Anim'] = 'frontseat_carsex_loop_f', ['Flags'] = 1,
            },
        },
        {
            ['Label'] = "Uprawiaj sex 2 (pojazd)", 
            ['Car'] = true,
            ['Requester'] = {
                ['Type'] = 'animation', ['Dict'] = 'random@drunk_driver_2', ['Anim'] = 'cardrunksex_loop_f', ['Flags'] = 1,
            }, 
            ['Accepter'] = {
                ['Type'] = 'animation', ['Dict'] = 'random@drunk_driver_2', ['Anim'] = 'cardrunksex_loop_m', ['Flags'] = 1,
            },
        },
        {
            ['Label'] = "Zrób loda (pojazd)", 
            ['Car'] = true,
            ['Requester'] = {
                ['Type'] = 'animation', ['Dict'] = 'oddjobs@towing', ['Anim'] = 'm_blow_job_loop', ['Flags'] = 1,
            }, 
            ['Accepter'] = {
                ['Type'] = 'animation', ['Dict'] = 'oddjobs@towing', ['Anim'] = 'f_blow_job_loop', ['Flags'] = 1,
            },
        },
    }
}

Config['Synced'] = {
    {
        ['Label'] = 'Przytul',
        ['Requester'] = {
            ['Type'] = 'animation', ['Dict'] = 'mp_ped_interaction', ['Anim'] = 'kisses_guy_a', ['Flags'] = 0,
        },
        ['Accepter'] = {
            ['Type'] = 'animation', ['Dict'] = 'mp_ped_interaction', ['Anim'] = 'kisses_guy_b', ['Flags'] = 0, ['Attach'] = {
                ['Bone'] = 9816,
                ['xP'] = 0.05,
                ['yP'] = 1.15,
                ['zP'] = -0.05,

                ['xR'] = 0.0,
                ['yR'] = 0.0,
                ['zR'] = 180.0,
            }
        }
    },
    {
        ['Label'] = 'Piątka',
        ['Requester'] = {
            ['Type'] = 'animation', ['Dict'] = 'mp_ped_interaction', ['Anim'] = 'highfive_guy_a', ['Flags'] = 0,
        },
        ['Accepter'] = {
            ['Type'] = 'animation', ['Dict'] = 'mp_ped_interaction', ['Anim'] = 'highfive_guy_b', ['Flags'] = 0, ['Attach'] = {
                ['Bone'] = 9816,
                ['xP'] = -0.5,
                ['yP'] = 1.25,
                ['zP'] = 0.0,

                ['xR'] = 0.9,
                ['yR'] = 0.3,
                ['zR'] = 180.0,
            }
        }
    },
    {
        ['Label'] = 'Przytul po przyjacielsku',
        ['Requester'] = {
            ['Type'] = 'animation', ['Dict'] = 'mp_ped_interaction', ['Anim'] = 'hugs_guy_a', ['Flags'] = 0,
        },
        ['Accepter'] = {
            ['Type'] = 'animation', ['Dict'] = 'mp_ped_interaction', ['Anim'] = 'hugs_guy_b', ['Flags'] = 0, ['Attach'] = {
                ['Bone'] = 9816,
                ['xP'] = -0.025,
                ['yP'] = 1.15,
                ['zP'] = 0.0,

                ['xR'] = 0.0,
                ['yR'] = 0.0,
                ['zR'] = 180.0,
            }
        }
    },
    {
        ['Label'] = 'Żółwik',
        ['Requester'] = {
            ['Type'] = 'animation', ['Dict'] = 'anim@mp_player_intcelebrationpaired@f_f_fist_bump', ['Anim'] = 'fist_bump_left', ['Flags'] = 0,
        },
        ['Accepter'] = {
            ['Type'] = 'animation', ['Dict'] = 'anim@mp_player_intcelebrationpaired@f_f_fist_bump', ['Anim'] = 'fist_bump_right', ['Flags'] = 0, ['Attach'] = {
                ['Bone'] = 9816,
                ['xP'] = -0.6,
                ['yP'] = 0.9,
                ['zP'] = 0.0,

                ['xR'] = 0.0,
                ['yR'] = 0.0,
                ['zR'] = 270.0,
            }
        }
    },
    {
        ['Label'] = 'Podaj ręke (koleżeńskie)',
        ['Requester'] = {
            ['Type'] = 'animation', ['Dict'] = 'mp_ped_interaction', ['Anim'] = 'handshake_guy_a', ['Flags'] = 0,
        },
        ['Accepter'] = {
            ['Type'] = 'animation', ['Dict'] = 'mp_ped_interaction', ['Anim'] = 'handshake_guy_b', ['Flags'] = 0, ['Attach'] = {
                ['Bone'] = 9816,
                ['xP'] = 0.0,
                ['yP'] = 1.2,
                ['zP'] = 0.0,

                ['xR'] = 0.0,
                ['yR'] = 0.0,
                ['zR'] = 180.0,
            }
        }
    },
    {
        ['Label'] = 'Podaj ręke (oficjalnie)',
        ['Requester'] = {
            ['Type'] = 'animation', ['Dict'] = 'mp_common', ['Anim'] = 'givetake1_a', ['Flags'] = 0,
        },
        ['Accepter'] = {
            ['Type'] = 'animation', ['Dict'] = 'mp_common', ['Anim'] = 'givetake1_b', ['Flags'] = 0, ['Attach'] = {
                ['Bone'] = 9816,
                ['xP'] = 0.075,
                ['yP'] = 1.0,
                ['zP'] = 0.0,

                ['xR'] = 0.0,
                ['yR'] = 0.0,
                ['zR'] = 180.0,
            }
        }
    },
    {
        ['Label'] = 'Uderz',
        ['Requester'] = {
            ['Type'] = 'animation', ['Dict'] = 'melee@unarmed@streamed_variations', ['Anim'] = 'plyr_takedown_rear_lefthook', ['Flags'] = 0,
        },
        ['Accepter'] = {
            ['Type'] = 'animation', ['Dict'] = 'melee@unarmed@streamed_variations', ['Anim'] = 'victim_takedown_front_cross_r', ['Flags'] = 0, ['Attach'] = {
                ['Bone'] = 9816,
                ['xP'] = 0.05,
                ['yP'] = 1.15,
                ['zP'] = -0.05,

                ['xR'] = 0.0,
                ['yR'] = 0.0,
                ['zR'] = 180.0,
            }
        }
    },
    {
        ['Label'] = 'Uderz z liścia',
        ['Requester'] = {
            ['Type'] = 'animation', ['Dict'] = 'melee@unarmed@streamed_variations', ['Anim'] = 'plyr_takedown_front_slap', ['Flags'] = 0,
        },
        ['Accepter'] = {
            ['Type'] = 'animation', ['Dict'] = 'melee@unarmed@streamed_variations', ['Anim'] = 'victim_takedown_front_backslap', ['Flags'] = 0, ['Attach'] = {
                ['Bone'] = 9816,
                ['xP'] = 0.05,
                ['yP'] = 1.15,
                ['zP'] = -0.05,

                ['xR'] = 0.0,
                ['yR'] = 0.0,
                ['zR'] = 180.0,
            }
        }
    },
    {
        ['Label'] = 'Uderz z główki',
        ['Requester'] = {
            ['Type'] = 'animation', ['Dict'] = 'melee@unarmed@streamed_variations', ['Anim'] = 'plyr_takedown_front_headbutt', ['Flags'] = 0,
        },
        ['Accepter'] = {
            ['Type'] = 'animation', ['Dict'] = 'melee@unarmed@streamed_variations', ['Anim'] = 'victim_takedown_front_headbutt', ['Flags'] = 0, ['Attach'] = {
                ['Bone'] = 9816,
                ['xP'] = 0.05,
                ['yP'] = 1.15,
                ['zP'] = -0.05,

                ['xR'] = 0.0,
                ['yR'] = 0.0,
                ['zR'] = 180.0,
            }
        }
    },
    {
        ['Label'] = 'Gra w baseballa',
        ['Requester'] = {
            ['Type'] = 'animation', ['Dict'] = 'anim@arena@celeb@flat@paired@no_props@', ['Anim'] = 'baseball_a_player_a', ['Flags'] = 0,
        },
        ['Accepter'] = {
            ['Type'] = 'animation', ['Dict'] = 'anim@arena@celeb@flat@paired@no_props@', ['Anim'] = 'baseball_a_player_b', ['Flags'] = 0, ['Attach'] = {
                ['Bone'] = 9816,
                ['xP'] = -0.5,
                ['yP'] = 1.25,
                ['zP'] = 0.0,

                ['xR'] = 0.9,
                ['yR'] = 0.3,
                ['zR'] = 180.0,
            }
        }
    },
    {
        ['Label'] = 'Wspólny taniec 1',
        ['Requester'] = {
            ['Type'] = 'animation', ['Dict'] = 'anim@amb@nightclub@mini@dance@dance_solo@female@var_a@', ['Anim'] = 'low_center', ['Flags'] = 1,
        },
        ['Accepter'] = {
            ['Type'] = 'animation', ['Dict'] = 'anim@amb@nightclub@mini@dance@dance_solo@female@var_a@', ['Anim'] = 'low_center', ['Flags'] = 1, ['Attach'] = {
                ['Bone'] = 9816,
                ['xP'] = 0.05,
                ['yP'] = 1.15,
                ['zP'] = -0.05,

                ['xR'] = 0.0,
                ['yR'] = 0.0,
                ['zR'] = 180.0,
            }
        }
    },
    {
        ['Label'] = 'Wspólny taniec 2',
        ['Requester'] = {
            ['Type'] = 'animation', ['Dict'] = 'anim@amb@nightclub@dancers@crowddance_facedj@hi_intensity', ['Anim'] = 'hi_dance_facedj_09_v1_female^1', ['Flags'] = 1,
        },
        ['Accepter'] = {
            ['Type'] = 'animation', ['Dict'] = 'anim@amb@nightclub@dancers@crowddance_facedj@hi_intensity', ['Anim'] = 'hi_dance_facedj_09_v1_female^1', ['Flags'] = 1, ['Attach'] = {
                ['Bone'] = 9816,
                ['xP'] = 0.05,
                ['yP'] = 1.15,
                ['zP'] = -0.05,

                ['xR'] = 0.0,
                ['yR'] = 0.0,
                ['zR'] = 180.0,
            }
        }
    },
    {
        ['Label'] = 'Wspólny taniec 3',
        ['Requester'] = {
            ['Type'] = 'animation', ['Dict'] = 'anim@amb@nightclub@mini@dance@dance_solo@female@var_b@', ['Anim'] = 'high_center', ['Flags'] = 1,
        },
        ['Accepter'] = {
            ['Type'] = 'animation', ['Dict'] = 'anim@amb@nightclub@mini@dance@dance_solo@female@var_b@', ['Anim'] = 'high_center', ['Flags'] = 1, ['Attach'] = {
                ['Bone'] = 9816,
                ['xP'] = 0.05,
                ['yP'] = 1.15,
                ['zP'] = -0.05,

                ['xR'] = 0.0,
                ['yR'] = 0.0,
                ['zR'] = 180.0,
            }
        }
    },
    {
        ['Label'] = 'Wspólny taniec 4',
        ['Requester'] = {
            ['Type'] = 'animation', ['Dict'] = 'anim@amb@nightclub@dancers@crowddance_facedj@hi_intensity', ['Anim'] = 'hi_dance_facedj_09_v2_female^1', ['Flags'] = 1,
        },
        ['Accepter'] = {
            ['Type'] = 'animation', ['Dict'] = 'anim@amb@nightclub@dancers@crowddance_facedj@hi_intensity', ['Anim'] = 'hi_dance_facedj_09_v2_female^1', ['Flags'] = 1, ['Attach'] = {
                ['Bone'] = 9816,
                ['xP'] = 0.05,
                ['yP'] = 1.15,
                ['zP'] = -0.05,

                ['xR'] = 0.0,
                ['yR'] = 0.0,
                ['zR'] = 180.0,
            }
        }
    },
    {
        ['Label'] = 'Wspólny taniec 5',
        ['Requester'] = {
            ['Type'] = 'animation', ['Dict'] = 'anim@amb@nightclub@dancers@solomun_entourage@', ['Anim'] = 'mi_dance_facedj_17_v1_female^1', ['Flags'] = 1,
        },
        ['Accepter'] = {
            ['Type'] = 'animation', ['Dict'] = 'anim@amb@nightclub@dancers@solomun_entourage@', ['Anim'] = 'mi_dance_facedj_17_v1_female^1', ['Flags'] = 1, ['Attach'] = {
                ['Bone'] = 9816,
                ['xP'] = 0.05,
                ['yP'] = 1.15,
                ['zP'] = -0.05,

                ['xR'] = 0.0,
                ['yR'] = 0.0,
                ['zR'] = 180.0,
            }
        }
    },
    {
        ['Label'] = 'Wspólny taniec 6',
        ['Requester'] = {
            ['Type'] = 'animation', ['Dict'] = 'anim@amb@nightclub@lazlow@hi_podium@', ['Anim'] = 'danceidle_mi_17_crotchgrab_laz', ['Flags'] = 1,
        },
        ['Accepter'] = {
            ['Type'] = 'animation', ['Dict'] = 'anim@amb@nightclub@lazlow@hi_podium@', ['Anim'] = 'danceidle_mi_17_crotchgrab_laz', ['Flags'] = 1, ['Attach'] = {
                ['Bone'] = 9816,
                ['xP'] = 0.05,
                ['yP'] = 1.15,
                ['zP'] = -0.05,

                ['xR'] = 0.0,
                ['yR'] = 0.0,
                ['zR'] = 180.0,
            }
        }
    },
    {
        ['Label'] = 'Wspólny taniec 7',
        ['Requester'] = {
            ['Type'] = 'animation', ['Dict'] = 'anim@mp_player_intcelebrationmale@uncle_disco', ['Anim'] = 'uncle_disco', ['Flags'] = 1,
        },
        ['Accepter'] = {
            ['Type'] = 'animation', ['Dict'] = 'anim@mp_player_intcelebrationmale@uncle_disco', ['Anim'] = 'uncle_disco', ['Flags'] = 1, ['Attach'] = {
                ['Bone'] = 9816,
                ['xP'] = 0.05,
                ['yP'] = 1.15,
                ['zP'] = -0.05,

                ['xR'] = 0.0,
                ['yR'] = 0.0,
                ['zR'] = 180.0,
            }
        }
    },

    {
        ['Label'] = 'Wspólny taniec 8',
        ['Requester'] = {
            ['Type'] = 'animation', ['Dict'] = 'anim@amb@casino@mini@dance@dance_solo@female@var_b@', ['Anim'] = 'high_center', ['Flags'] = 1,
        },
        ['Accepter'] = {
            ['Type'] = 'animation', ['Dict'] = 'anim@amb@casino@mini@dance@dance_solo@female@var_b@', ['Anim'] = 'high_center', ['Flags'] = 1, ['Attach'] = {
                ['Bone'] = 9816,
                ['xP'] = 0.05,
                ['yP'] = 1.15,
                ['zP'] = -0.05,

                ['xR'] = 0.0,
                ['yR'] = 0.0,
                ['zR'] = 180.0,
            }
        }
    },

    {
        ['Label'] = 'Pocałuj',
        ['Requester'] = {
            ['Type'] = 'animation', ['Dict'] = 'hs3_ext-20', ['Anim'] = 'cs_lestercrest_3_dual-20', ['Flags'] = 1,
        },
        ['Accepter'] = {
            ['Type'] = 'animation', ['Dict'] = 'hs3_ext-20', ['Anim'] = 'csb_georginacheng_dual-20', ['Flags'] = 1, ['Attach'] = {
                ['Bone'] = 0,
                ['xP'] = 0.0,
                ['yP'] = 0.53,
                ['zP'] = 0.0,

                ['xR'] = 0.0,
                ['yR'] = 0.0,
                ['zR'] = 180.0,
            }
        }
    },

    {
        ['Label'] = 'Obejmowanie',
        ['Requester'] = {
            ['Type'] = 'animation', ['Dict'] = 'misscarsteal2chad_goodbye', ['Anim'] = 'chad_armsaround_chad', ['Flags'] = 1, ['Attach'] = {
                ['Bone'] = 9816,
                ['xP'] = -0.07,
                ['yP'] = 0.63,
                ['zP'] = 0.00,

                ['xR'] = 0.0,
                ['yR'] = 0.53,
                ['zR'] = 180.0,
                }
        },
        ['Accepter'] = {
            ['Type'] = 'animation', ['Dict'] = 'misscarsteal2chad_goodbye', ['Anim'] = 'chad_armsaround_girl', ['Flags'] = 1
        },
    },

    {
        ['Label'] = 'Zrób loda (na stojąco)',
        ['Requester'] = {
            ['Type'] = 'animation', ['Dict'] = 'misscarsteal2pimpsex', ['Anim'] = 'pimpsex_hooker', ['Flags'] = 1, ['Attach'] = {
                ['Bone'] = 9816,
                ['xP'] = 0.0,
                ['yP'] = 0.65,
                ['zP'] = 0.0,

                ['xR'] = 120.0,
                ['yR'] = 0.0,
                ['zR'] = 180.0,
            }
        },
        ['Accepter'] = {
            ['Type'] = 'animation', ['Dict'] = 'misscarsteal2pimpsex', ['Anim'] = 'pimpsex_punter', ['Flags'] = 1,
        },
    },
    {
        ['Label'] = 'Sex (na stojąco)',
        ['Requester'] = {
            ['Type'] = 'animation', ['Dict'] = 'misscarsteal2pimpsex', ['Anim'] = 'shagloop_hooker', ['Flags'] = 1, ['Attach'] = {
                ['Bone'] = 9816,
                ['xP'] = 0.05,
                ['yP'] = 0.4,
                ['zP'] = 0.0,

                ['xR'] = 120.0,
                ['yR'] = 0.0,
                ['zR'] = 180.0,
            }
        },
        ['Accepter'] = {
            ['Type'] = 'animation', ['Dict'] = 'misscarsteal2pimpsex', ['Anim'] = 'shagloop_pimp', ['Flags'] = 1,
        },
    },
    {
        ['Label'] = 'Anal (na stojąco)', 
        ['Requester'] = {
            ['Type'] = 'animation', ['Dict'] = 'rcmpaparazzo_2', ['Anim'] = 'shag_loop_a', ['Flags'] = 1,
        }, 
        ['Accepter'] = {
            ['Type'] = 'animation', ['Dict'] = 'rcmpaparazzo_2', ['Anim'] = 'shag_loop_poppy', ['Flags'] = 1, ['Attach'] = {
                ['Bone'] = 9816,
                ['xP'] = 0.015,
                ['yP'] = 0.35,
                ['zP'] = 0.0,

                ['xR'] = 0.9,
                ['yR'] = 0.3,
                ['zR'] = 0.0,
            },
        },
    },
    {
        ['Label'] = "Uprawiaj sex (pojazd)", 
        ['Car'] = true,
        ['Requester'] = {
            ['Type'] = 'animation', ['Dict'] = 'oddjobs@assassinate@vice@sex', ['Anim'] = 'frontseat_carsex_loop_m', ['Flags'] = 1,
        }, 
        ['Accepter'] = {
            ['Type'] = 'animation', ['Dict'] = 'oddjobs@assassinate@vice@sex', ['Anim'] = 'frontseat_carsex_loop_f', ['Flags'] = 1,
        },
    },
    {
        ['Label'] = "Uprawiaj sex 2 (pojazd)", 
        ['Car'] = true,
        ['Requester'] = {
            ['Type'] = 'animation', ['Dict'] = 'random@drunk_driver_2', ['Anim'] = 'cardrunksex_loop_f', ['Flags'] = 1,
        }, 
        ['Accepter'] = {
            ['Type'] = 'animation', ['Dict'] = 'random@drunk_driver_2', ['Anim'] = 'cardrunksex_loop_m', ['Flags'] = 1,
        },
    },
    {
        ['Label'] = "Zrób loda (pojazd)", 
        ['Car'] = true,
        ['Requester'] = {
            ['Type'] = 'animation', ['Dict'] = 'oddjobs@towing', ['Anim'] = 'm_blow_job_loop', ['Flags'] = 1,
        }, 
        ['Accepter'] = {
            ['Type'] = 'animation', ['Dict'] = 'oddjobs@towing', ['Anim'] = 'f_blow_job_loop', ['Flags'] = 1,
        },
    },
}