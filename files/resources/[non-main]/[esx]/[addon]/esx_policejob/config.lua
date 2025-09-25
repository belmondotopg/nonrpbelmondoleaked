Config                            = {}

Config.DrawDistance               = 10.0 -- How close do you need to be for the markers to be drawn (in GTA units).
Config.MarkerType                 = {Cloakrooms = 27, Armories = 21, BossActions = 22, Vehicles = 36, Helicopters = 34}
Config.MarkerSize                 = {x = 1.5, y = 1.5, z = 0.5}
Config.MarkerColor                = {r = 50, g = 50, b = 204}

Config.EnablePlayerManagement     = true -- Enable if you want society managing.
Config.EnableArmoryManagement     = true
Config.EnableESXIdentity          = true -- Enable if you're using esx_identity.
Config.EnableESXOptionalneeds     = false -- Enable if you're using esx_optionalneeds
Config.EnableLicenses             = false -- Enable if you're using esx_license.

Config.EnableHandcuffTimer        = true -- Enable handcuff timer? will unrestrain player after the time ends.
Config.HandcuffTimer              = 10 * 60000 -- 10 minutes.

Config.EnableJobBlip              = false -- Enable blips for cops on duty, requires esx_society.
Config.EnableCustomPeds           = false -- Enable custom peds in cloak room? See Config.CustomPeds below to customize peds.

Config.EnableESXService           = false -- Enable esx service?
Config.MaxInService               = -1 -- How many people can be in service at once? Set as -1 to have no limit

Config.Locale                     = 'pl'

Config.OxInventory                = ESX.GetConfig().OxInventory

Config.PoliceStations = {

	-- LSPD = { --miasto

	-- 	Blip = {
	-- 		Coords  = vector3(439.0654, -981.9346, 30.6895),
	-- 		Sprite  = 60,
	-- 		Display = 4,
	-- 		Scale   = 1.0,
	-- 		Colour  = 29
	-- 	},

	-- 	Cloakrooms = {
	-- 		vector3(-313.2003, -1060.7400, 27.3405), --1838.2440, 3678.9351, 38.9392, 38.5160
	-- 	},

	-- 	Armories = {
	-- 		vector3(-308.0455, -1064.3782, 28.3406),
	-- 	},

	-- 	Vehicles = {
	-- 		{
	-- 			Spawner = vector3(-338.1885, -1053.2677, 23.0270),
	-- 			SpawnPoint = vector3(452.3395, -991.4359, 25.6998),
	-- 			Deleter = vector3(450.0774, -977.7103, 25.6998-.95),
	-- 			Heading = 188.1176,
	-- 		}
	-- 	},

	-- 	Helicopters = {
	-- 		{
	-- 			Spawner = vector3(-330.8835, -1050.4164, 23.0270),
	-- 			SpawnPoint = vector3(-327.4420, -1072.7561, 43.7212),
	-- 			Deleter = vector3(-327.4420, -1072.7561, 42.8212)
	-- 		}
	-- 	},

	-- 	BossActions = {
	-- 		vector3(-303.3775, -1045.3826, 31.2609),
	-- 	}

	-- },

	LSPD2 = { --sandy
		Blip = {
			Coords  = vector3(1855.27, 3695.13, 34.27),
			Sprite  = 60,
			Display = 4,
			Scale   = 1.0,
			Colour  = 21
		},

		Cloakrooms = {
			vector3(1827.5652, 3685.1990, 33.3261),
		},

		Armories = {
			vector3(1846.3911, 3690.6316, 34.3261),
		},

		Vehicles = {
			{
				Spawner = vector3(1850.8573, 3697.0537, 34.2127),
				SpawnPoint = vector3(1863.6429, 3697.1709, 33.7441),
				Deleter = vector3(1868.6345, 3688.9160, 32.7016),
				Heading = 113.3816,
			}
		},

		Helicopters = {
			{
				Spawner = vector3(1827.3384, 3673.0574, 34.3368),
				SpawnPoint = vector3(1833.5122, 3668.9463, 38.9306),
				Deleter = vector3(1866.2827, 3651.3938, 32.9190),
			}
		},

		BossActions = {
			vector3(1831.2371, 3682.3757, 34.3359),
		}
	},

	-- LSPD3 = {
	-- 	Blip = {
	-- 		Coords  = vector3(-1077.43, -818.09, 31.26),
	-- 		Sprite  = 60,
	-- 		Display = 4,
	-- 		Scale   = 1.0,
	-- 		Colour  = 29
	-- 	},

	-- 	Cloakrooms = {
	-- 		vector3(-1130.1613, -863.3688, 12.6402),
	-- 	},

	-- 	Armories = {
	-- 		vector3(-1126.7446, -867.9037, 13.5359),
	-- 	},

	-- 	Vehicles = {
	-- 		{
	-- 			Spawner = vector3(-1116.5217, -846.3061, 13.3892),
	-- 			SpawnPoint = vector3(-1130.1617, -842.1761, 12.7657),
	-- 			Deleter = vector3(-1130.1617, -842.1761, 12.7657),
	-- 			Heading = 124.86,
	-- 		}
	-- 	},

	-- 	Helicopters = {
	-- 		{
	-- 			Spawner = vector3(-1081.7080, -866.7573, 5.0418),
	-- 			SpawnPoint = vector3(-1066.7465, -862.9468, 3.9681),
	-- 			Deleter = vector3(-1066.7465, -862.9468, 3.9681)
	-- 		}
	-- 	},

	-- 	BossActions = {
	-- 		vector3(-1116.8317, -860.5684, 13.5648)
	-- 	}
    -- },
	
	-- LSPD4 = {
	-- 	Blip = {
	-- 		Coords  = vector3(-443.75, 6008.48, 39.52),
	-- 		Sprite  = 60,
	-- 		Display = 4,
	-- 		Scale   = 1.0,
	-- 		Colour  = 21
	-- 	},

	-- 	Cloakrooms = {
	-- 		vector3(-447.15, 5996.16, 30.44),
	-- 	},

	-- 	Armories = {
	-- 		vector3(-447.04, 5992.34, 31.44),
	-- 	},

	-- 	Vehicles = {
	-- 		{
	-- 			Spawner = vector3(-459.86, 6015.53, 31.59),
	-- 			SpawnPoint = vector3(-457.64, 6025.05, 30.09),
	-- 			Deleter = vector3(-471.79, 6022.67, 30.44),
	-- 			Heading = 313.62,
	-- 		}
	-- 	},

	-- 	Helicopters = {
	-- 		{
	-- 			Spawner = vector3(-477.49, 6005.61, 31.41),
	-- 			SpawnPoint = vector3(-475.36, 5991.93, 30.44),
	-- 			Deleter = vector3(-475.38, 5988.06, 30.44)
	-- 		}
	-- 	},

	-- 	BossActions = {
	-- 		vector3(-450.98, 5989.32, 31.44),
	-- 	}
    -- },

	-- LSPD5 = {
	-- 	Blip = {
	-- 		Coords  = vector3(373.5136, -1610.5288, 29.2920),
	-- 		Sprite  = 60,
	-- 		Display = 4,
	-- 		Scale   = 1.0,
	-- 		Colour  = 29
	-- 	},

	-- 	Cloakrooms = {
	-- 		vector3(370.3497, -1608.5413, 28.3919),
	-- 	},

	-- 	Armories = {
	-- 		vector3(373.4890, -1612.9430, 29.2920),
	-- 	},

	-- 	Vehicles = {
	-- 		{
	-- 			Spawner = vector3(383.9365, -1613.6776, 29.2919),
	-- 			SpawnPoint = vector3(392.3318, -1620.8447, 28.3919),
	-- 			Deleter = vector3(387.2695, -1621.3284, 28.3919),
	-- 			Heading = 313.62,
	-- 		}
	-- 	},

	-- 	Helicopters = {
	-- 		{
	-- 			Spawner = vector3(366.3581, -1621.7462, 29.2919),
	-- 			SpawnPoint = vector3(362.9659, -1598.3722, 36.0488),
	-- 			Deleter = vector3(363.1578, -1598.7783, 36.0488)
	-- 		}
	-- 	},

	-- 	BossActions = {
	-- 		vector3(364.9200, -1615.1410, 29.2919),
	-- 	}
    -- },

	-- LSPD6 = {
	-- 	Blip = {
	-- 		Coords  = vector3(640.4902, 0.8666, 82.7864),
	-- 		Sprite  = 60,
	-- 		Display = 4,
	-- 		Scale   = 1.0,
	-- 		Colour  = 29
	-- 	},

	-- 	Cloakrooms = {
	-- 		vector3(639.3691, -3.8279, 81.8878),
	-- 	},

	-- 	Armories = {
	-- 		vector3(640.5916, 1.1869, 82.7864),
	-- 	},

	-- 	Vehicles = {
	-- 		{
	-- 			Spawner = vector3(535.3596, -22.2368, 70.6294),
	-- 			SpawnPoint = vector3(537.2992, -42.3632, 69.9177),
	-- 			Deleter = vector3(529.4360, -27.8809, 69.7294),
	-- 			Heading = 313.62,
	-- 		}
	-- 	},

	-- 	Helicopters = {
	-- 		{
	-- 			Spawner = vector3(635.5764, -18.8442, 81.7581),
	-- 			SpawnPoint = vector3(580.1168, 12.2960, 102.3336),
	-- 			Deleter = vector3(580.1168, 12.2960, 102.3336)
	-- 		}
	-- 	},

	-- 	BossActions = {
	-- 		vector3(643.8657, 8.9115, 82.6969),
	-- 	}
    -- },
}

Config.AuthorizedWeapons = {
	{ name = 'combatpistol', label = 'Pistolet Bojowy', price = 0 },
	{ name = 'heavypistol', label = 'Pistolet Heavy', price = 75000 },
	{ name = 'pistol_ammo_box', label = 'Magazynek do pistoletu', price = 5000 },
	{ name = 'stungun', label = 'Tazer', price = 7500 },
	{ name = 'gps', label = 'GPS', price = 0 },
	{ name = 'radio', label = 'Radio', price = 0 },
}

Config.VehiclesGroups = {
	'Zarzad', -- 1
	'Napadowki', -- 2
    'S.W.A.T', -- 3
	'Offroad', -- 4
	'Sportowe', -- 5
}

Config.AuthorizedVehicles = {
	{
		model = 'hp_lambo',
		label = 'Lambo',
		groups = {2},
		license = "seu_pd"
	},
	{
		model = 'pursport',
		label = 'Bugatti pursport',
		groups = {2},
	},
	{
		model = 'verinoicex5bmwfrommcd0nald ',
		label = 'BMW X5',
		groups = {4},
	},
	{
		model = 'vc_polramtrx22',
		label = 'RAM TRX',
		groups = {5},
	},
	{
		model = 'bmwm3bpd',
		label = 'BMW M3',
		groups = {5},
	},
	{
		model = 'hp_911',
		label = 'Porsche 911',
		groups = {2},
		license = "seu_pd"
	},
	{
		model = 'hp_c8',
		label = 'Corvette C8',
		groups = {5},
	},
	{
		model = 'hp_challenger',
		label = 'Challenger',
		groups = {2},
	},
-- 	{
-- 		model = 'pd_viper',
-- 		label = 'Dodge Viper 2018',
-- 		groups = {3},
-- 		license = 'seu_pd'
-- 	},
-- 	{
-- 		model = 'hp_gt17',
-- 		label = 'Ford GT',
-- 		groups = {3},
-- 		license = "seu_pd"
-- 	},
-- 	{
-- 		model = 'hp_laferrari',
-- 		label = 'LaFerrari',
-- 		groups = {1},
-- 		license = "cs_pd"
-- 	},
-- 	{
-- 		model = 'DL_bmwm4',
-- 		label = 'BMW M4',
-- 		groups = {1},
-- 		license = "cs_pd"
-- 	},
-- 	{
-- 		model = 'hp_m8',
-- 		label = 'BMW M8',
-- 		groups = {2},
-- 		license = "hwp_pd"
-- 	},
-- 	{
-- 		model = 'pd_camaro',
-- 		label = 'Chevrolet Camaro',
-- 		groups = {2},
-- 		license = "cs_pd"
-- 	},
-- 	{
-- 		model = 'hp_lambo',
-- 		label = 'Lamborghini',
-- 		groups = {1},
-- 		license = "cs_pd"
-- 	},
-- 	{
-- 		model = 'pd_bronco',
-- 		label = 'Ford Bronco',
-- 		groups = {6},
-- 	},
-- 	{
-- 		model = 'pd_tahoe21',
-- 		label = 'Chevrolet Tahoe',
-- 		groups = {6},
-- 	},
-- 	{
-- 		model = 'pd_durango',
-- 		label = 'Dodge Durango',
-- 		groups = {6},
-- 	},
-- 	{
-- 		model = 'pd_explo',
-- 		label = 'Chevrolet Explorer',
-- 		groups = {6},
-- 	},
-- 	{
-- 		model = 'pd_freecrawler',
-- 		label = 'Freecrawler',
-- 		groups = {3},
-- 		license = 'seu_pd'
-- 	},
-- 	{
-- 		model = 'pd_raptor',
-- 		label = 'Ford Raptor',
-- 		groups = {3},
-- 		license = "seu_pd"
-- 	},
-- 	{
-- 		model = 'swat_jeep',
-- 		label = 'Swat Jeep',
-- 		groups = {4},
-- 		license = "cttf_pd"
-- 	},
-- 	{
-- 		model = 'pd_titan17',
-- 		label = 'Nissan Titan',
-- 		groups = {6},
-- 	},
--         {
-- 		model = 'pitbullbb',
-- 		label = 'Pitbull',
-- 		groups = {4},
-- 		license = "cttf_pd"
-- 	},
--         {
-- 		model = 'bearcat',
-- 		label = 'BearCat',
-- 		groups = {4},
-- 		license = "cttf_pd"
-- 	},
-- 	{
-- 		model = 'pd_h1',
-- 		label = 'H1',
-- 		groups = {4},
-- 		license = "cttf_pd"
-- 	},
-- 	{
-- 		model = 'riot',
-- 		label = 'Riot CTTF',
-- 		groups = {4},
-- 		license = "cttf_pd"
-- 	},
-- 	{
-- 		model = 'hp_bmw',
-- 		label = 'BMW',
-- 		groups = {7},
-- 		license = "mr_pd"
-- 	},
-- 	{
-- 		model = 'pd_r1custom',
-- 		label = 'R1',
-- 		groups = {7},
-- 		license = "mr_pd"
-- 	},
-- 	{
-- 		model = 'hp_rs5',
-- 		label = 'RS5',
-- 		groups = {3},
-- 		license = "seu_pd"
-- 	},
-- 	{
-- 		model = 'pd_response',
-- 		label = 'Medic Car',
-- 		groups = {8},
-- 		license = "cttf_pd"
-- 	},
-- 	{
-- 		model = 'pd_sprinter',
-- 		label = 'Sprinter',
-- 		groups = {8},
-- 		license = "cttf_pd"
-- 	},
-- 	{
-- 		model = 'pd_van',
-- 		label = 'Van',
-- 		groups = {8},
-- 		license = "cttf_pd"
-- 	},
-- 	{
-- 		model = 'pd_camaroSU',
-- 		label = 'SWAT Camaro',
-- 		groups = {4},
-- 		license = "cttf_pd"
-- 	},
-- 	{
-- 		model = 'pd_escalader',
-- 		label = 'Escalader',
-- 		groups = {5},
-- 	},
-- 	{
-- 		model = 'titanwbpd1',
-- 		label = 'CODE BLACK',
-- 		groups = {1},
-- 		license = "cs_pd"
-- 	},
-- 	{
-- 		model = 'pd_hummerSU',
-- 		label = 'Hummer',
-- 		groups = {4},
-- 		license = "cttf_pd"
-- 	},
-- 	{
-- 		model = 'pd_c8',
-- 		label = 'Chevrolet C8',
-- 		groups = {3},
-- 		license = "seu_pd"
-- 	},
-- 	{
-- 		model = 'pd_lexus',
-- 		label = 'Lexus',
-- 		groups = {5},
-- 	},
-- 	{
-- 		model = 'pd_sprinter',
-- 		label = 'Sprinter',
-- 		groups = {8},
-- 		license = "cttf_pd"
-- 	},
-- 	{
-- 		model = 'hp_divo',
-- 		label = 'Bugatti Divo',
-- 		groups = {2},
-- 		license = "hwp_pd"
-- 	},
-- 	{
-- 		model = 'pd_kawasaki',
-- 		label = 'Kawasaki',
-- 		groups = {7},
-- 		license = "mr_pd"
-- 	},
-- 	{
-- 		model = 'hp_wrxp',
-- 		label = 'WRXP',
-- 		groups = {2},
-- 		license = "hwp_pd"
-- 	},
-- 	{
-- 		model = 'pd_caracara',
-- 		label = 'Caracara',
-- 		groups = {6},
-- 	},
-- 	{
-- 		model = 'hp_x6',
-- 		label = 'BMW X6r',
-- 		groups = {2},
-- 		license = "hwp_pd"
-- 	},
-- 	{
-- 		model = 'hp_mustangwb',
-- 		label = 'Mustang WB',
-- 		groups = {2},
-- 		license = "hwp_pd"
-- 	},
-- 	{
-- 		model = 'pd_snake',
-- 		label = 'Shelby Snaker',
-- 		groups = {1},
-- 		license = "cs_pd"
-- 	},
-- 	{
-- 		model = 'pd_impala19',
-- 		label = 'Impala',
-- 		groups = {5},
-- 	},
-- 	{
-- 		model = 'pd_fusion16',
-- 		label = 'Ford Fusion',
-- 		groups = {5},
-- 	},
-- 	{
-- 		model = 'pd_taurus',
-- 		label = 'Taurus',
-- 		groups = {5},
-- 	},
-- 	{
-- 		model = 'pd_sultan',
-- 		label = 'Sultan',
-- 		groups = {3},
-- 		license = "seu_pd"
-- 	},
-- 	{
-- 		model = 'cheburekpd',
-- 		label = 'Cheburek',
-- 		groups = {3},
-- 		license = "seu_pd"
-- 	},
-- 	{
-- 		model = 'hp_911',
-- 		label = 'Porshe 911',
-- 		groups = {2},
-- 		license = "hwp_pd"
-- 	},
-- 	{
-- 		model = 'hp_chiron',
-- 		label = 'Bugatti Chiron',
-- 		groups = {2},
-- 		license = "hwp_pd"
-- 	},
-- 	{
-- 		model = 'pd_harley',
-- 		label = 'Harley',
-- 		groups = {7},
-- 		license = "mr_pd"
-- 	},
-- 	{
-- 		model = 'hp_rs6',
-- 		label = 'Audi RS6',
-- 		groups = {2},
-- 		license = "hwp_pd"
-- 	},
-- 	{
-- 		model = 'hp_r35',
-- 		label = 'Nissan R35',
-- 		groups = {2},
-- 		license = "hwp_pd"
-- 	},
-- 	{
-- 		model = 'vc_poltdf',
-- 		label = 'Ferrari F12',
-- 		groups = {3},
-- 		license = "seu_pd"
-- 	},
-- 	{
-- 		model = 'hp_m8f92',
-- 		label = 'BMW M8F92',
-- 		groups = {3},
-- 		license = "seu_pd"
-- 	},
-- 	{
-- 		model = 'hp_a45',
-- 		label = 'A45 CADET',
-- 		groups = {5},
-- 	},
-- 	{
-- 		model = 'hp_charger18',
-- 		label = 'Dodge Charger 2018',
-- 		groups = {3},
-- 		license = "seu_pd"
-- 	},
-- 	{
-- 		model = 'hp_zr1',
-- 		label = 'Corvette ZR1',
-- 		groups = {3},
-- 		license = "seu_pd"
-- 	},
-- 	{
-- 		model = 'zm_demonhawkk',
-- 		label = 'JEEP Demonhawk',
-- 		groups = {2},
-- 		license = 'seu_pd'
-- 	},
-- 	{
-- 		model = 'polvigerowb',
-- 		label = 'Niggero',
-- 		groups = {1},
-- 		license = "cs_pd"
-- 	},
-- 	{
-- 		model = 'hp_explorer',
-- 		label = 'Ford Explorer',
-- 		groups = {2},
-- 		license = 'seu_pd'
-- 	},
-- }

-- Config.AuthorizedHelicopters = {
-- 	{
-- 		model = 'pd_heli',
-- 		label = 'Helikopter',
-- 		license = "heli_pd"
-- 	},
-- 	{
-- 		model = 'sw_heli',
-- 		label = 'SWAT Helikopter',
-- 		license = "heli_pd"
-- 	},
-- 	{
-- 		model = 'polmav',
-- 		label = 'Helikopter Szkoleniowy',
-- 		license = "heli_pd"
-- 	}
}

Config.CustomPeds = {
	shared = {
		{label = 'Sheriff Ped', maleModel = 's_m_y_sheriff_01', femaleModel = 's_f_y_sheriff_01'},
		{label = 'Police Ped', maleModel = 's_m_y_cop_01', femaleModel = 's_f_y_cop_01'}
	},

	recruit = {},

	officer = {},

	sergeant = {},

	lieutenant = {},

	boss = {
		{label = 'SWAT Ped', maleModel = 's_m_y_swat_01', femaleModel = 's_m_y_swat_01'}
	}
}

-- CHECK SKINCHANGER CLIENT MAIN.LUA for matching elements
Config.Uniforms = {
	recruit = {
		male = {
			tshirt_1 = 59,  tshirt_2 = 1,
			torso_1 = 55,   torso_2 = 0,
			decals_1 = 0,   decals_2 = 0,
			arms = 41,
			pants_1 = 25,   pants_2 = 0,
			shoes_1 = 25,   shoes_2 = 0,
			helmet_1 = 46,  helmet_2 = 0,
			chain_1 = 0,    chain_2 = 0,
			ears_1 = 2,     ears_2 = 0
		},
		female = {
			tshirt_1 = 36,  tshirt_2 = 1,
			torso_1 = 48,   torso_2 = 0,
			decals_1 = 0,   decals_2 = 0,
			arms = 44,
			pants_1 = 34,   pants_2 = 0,
			shoes_1 = 27,   shoes_2 = 0,
			helmet_1 = 45,  helmet_2 = 0,
			chain_1 = 0,    chain_2 = 0,
			ears_1 = 2,     ears_2 = 0
		}
	},

	officer = {
		male = {
			tshirt_1 = 58,  tshirt_2 = 0,
			torso_1 = 55,   torso_2 = 0,
			decals_1 = 0,   decals_2 = 0,
			arms = 41,
			pants_1 = 25,   pants_2 = 0,
			shoes_1 = 25,   shoes_2 = 0,
			helmet_1 = -1,  helmet_2 = 0,
			chain_1 = 0,    chain_2 = 0,
			ears_1 = 2,     ears_2 = 0
		},
		female = {
			tshirt_1 = 35,  tshirt_2 = 0,
			torso_1 = 48,   torso_2 = 0,
			decals_1 = 0,   decals_2 = 0,
			arms = 44,
			pants_1 = 34,   pants_2 = 0,
			shoes_1 = 27,   shoes_2 = 0,
			helmet_1 = -1,  helmet_2 = 0,
			chain_1 = 0,    chain_2 = 0,
			ears_1 = 2,     ears_2 = 0
		}
	},

	sergeant = {
		male = {
			tshirt_1 = 58,  tshirt_2 = 0,
			torso_1 = 55,   torso_2 = 0,
			decals_1 = 8,   decals_2 = 1,
			arms = 41,
			pants_1 = 25,   pants_2 = 0,
			shoes_1 = 25,   shoes_2 = 0,
			helmet_1 = -1,  helmet_2 = 0,
			chain_1 = 0,    chain_2 = 0,
			ears_1 = 2,     ears_2 = 0
		},
		female = {
			tshirt_1 = 35,  tshirt_2 = 0,
			torso_1 = 48,   torso_2 = 0,
			decals_1 = 7,   decals_2 = 1,
			arms = 44,
			pants_1 = 34,   pants_2 = 0,
			shoes_1 = 27,   shoes_2 = 0,
			helmet_1 = -1,  helmet_2 = 0,
			chain_1 = 0,    chain_2 = 0,
			ears_1 = 2,     ears_2 = 0
		}
	},

	lieutenant = {
		male = {
			tshirt_1 = 58,  tshirt_2 = 0,
			torso_1 = 55,   torso_2 = 0,
			decals_1 = 8,   decals_2 = 2,
			arms = 41,
			pants_1 = 25,   pants_2 = 0,
			shoes_1 = 25,   shoes_2 = 0,
			helmet_1 = -1,  helmet_2 = 0,
			chain_1 = 0,    chain_2 = 0,
			ears_1 = 2,     ears_2 = 0
		},
		female = {
			tshirt_1 = 35,  tshirt_2 = 0,
			torso_1 = 48,   torso_2 = 0,
			decals_1 = 7,   decals_2 = 2,
			arms = 44,
			pants_1 = 34,   pants_2 = 0,
			shoes_1 = 27,   shoes_2 = 0,
			helmet_1 = -1,  helmet_2 = 0,
			chain_1 = 0,    chain_2 = 0,
			ears_1 = 2,     ears_2 = 0
		}
	},

	boss = {
		male = {
			tshirt_1 = 58,  tshirt_2 = 0,
			torso_1 = 55,   torso_2 = 0,
			decals_1 = 8,   decals_2 = 3,
			arms = 41,
			pants_1 = 25,   pants_2 = 0,
			shoes_1 = 25,   shoes_2 = 0,
			helmet_1 = -1,  helmet_2 = 0,
			chain_1 = 0,    chain_2 = 0,
			ears_1 = 2,     ears_2 = 0
		},
		female = {
			tshirt_1 = 35,  tshirt_2 = 0,
			torso_1 = 48,   torso_2 = 0,
			decals_1 = 7,   decals_2 = 3,
			arms = 44,
			pants_1 = 34,   pants_2 = 0,
			shoes_1 = 27,   shoes_2 = 0,
			helmet_1 = -1,  helmet_2 = 0,
			chain_1 = 0,    chain_2 = 0,
			ears_1 = 2,     ears_2 = 0
		}
	},

	bullet_wear = {
		male = {
			bproof_1 = 11,  bproof_2 = 1
		},
		female = {
			bproof_1 = 13,  bproof_2 = 1
		}
	},

	gilet_wear = {
		male = {
			tshirt_1 = 59,  tshirt_2 = 1
		},
		female = {
			tshirt_1 = 36,  tshirt_2 = 1
		}
	}
}