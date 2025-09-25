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

	LSPD = {

		Blip = {
			Coords  = vector3(446.9, -1007.4, 37.0),
			Sprite  = 60,
			Display = 4,
			Scale   = 1.0,
			Colour  = 29
		},

		Cloakrooms = {
			vector3(461.5956, -996.3054, 30.6895-0.95),
		},

		Armories = {
			vector3(478.9887, -996.4496, 30.6920),
		},

		Vehicles = {
			{
				Spawner = vector3(454.6, -1017.4, 28.4),
				SpawnPoint = vector3(438.4, -1018.3, 27.7),
				Deleter = vector3(462.38, -1019.42, 27.2),
				Heading = 92.93,
			}
		},

		Helicopters = {
			{
				Spawner = vector3(461.1, -981.5, 43.6),
				SpawnPoint = vector3(449.5, -981.2, 43.6),
				Deleter = vector3(449.47, -981.33, 42.79)
			}
		},

		BossActions = {
			vector3(462.9173, -985.1750, 30.7281),
		}

	},

	LSPD2 = {
		Blip = {
			Coords  = vector3(1855.27, 3695.13, 34.27),
			Sprite  = 60,
			Display = 4,
			Scale   = 1.0,
			Colour  = 21
		},

		Cloakrooms = {
			vector3(1850.0850, 3700.1255, 33.3665),
		},

		Armories = {
			vector3(1845.3120, 3697.1907, 34.2665),
		},

		Vehicles = {
			{
				Spawner = vector3(1864.05, 3697.73, 33.72),
				SpawnPoint = vector3(1873.21, 3690.2, 33.57),
				Deleter = vector3(1871.9658, 3688.9067, 32.7408),
				Heading = 212.076,
			}
		},

		Helicopters = {
			{
				Spawner = vector3(1853.9031, 3701.7263, 34.2678),
				SpawnPoint = vector3(1866.04, 3649.66, 32.87),
				Deleter = vector3(1866.2827, 3651.3938, 32.9190),
			}
		},

		BossActions = {
			vector3(1840.7932, 3694.9470, 34.2681),
		}
	},

	LSPD3 = {
		Blip = {
			Coords  = vector3(-1077.43, -818.09, 31.26),
			Sprite  = 60,
			Display = 4,
			Scale   = 1.0,
			Colour  = 29
		},

		Cloakrooms = {
			vector3(-1130.1613, -863.3688, 12.6402),
		},

		Armories = {
			vector3(-1126.7446, -867.9037, 13.5359),
		},

		Vehicles = {
			{
				Spawner = vector3(-1116.5217, -846.3061, 13.3892),
				SpawnPoint = vector3(-1130.1617, -842.1761, 12.7657),
				Deleter = vector3(-1130.1617, -842.1761, 12.7657),
				Heading = 124.86,
			}
		},

		Helicopters = {
			{
				Spawner = vector3(-1081.7080, -866.7573, 5.0418),
				SpawnPoint = vector3(-1066.7465, -862.9468, 3.9681),
				Deleter = vector3(-1066.7465, -862.9468, 3.9681)
			}
		},

		BossActions = {
			vector3(-1116.8317, -860.5684, 13.5648)
		}
    },
	
	LSPD4 = {
		Blip = {
			Coords  = vector3(-443.75, 6008.48, 39.52),
			Sprite  = 60,
			Display = 4,
			Scale   = 1.0,
			Colour  = 21
		},

		Cloakrooms = {
			vector3(-447.15, 5996.16, 30.44),
		},

		Armories = {
			vector3(-447.04, 5992.34, 31.44),
		},

		Vehicles = {
			{
				Spawner = vector3(-459.86, 6015.53, 31.59),
				SpawnPoint = vector3(-457.64, 6025.05, 30.09),
				Deleter = vector3(-471.79, 6022.67, 30.44),
				Heading = 313.62,
			}
		},

		Helicopters = {
			{
				Spawner = vector3(-477.49, 6005.61, 31.41),
				SpawnPoint = vector3(-475.36, 5991.93, 30.44),
				Deleter = vector3(-475.38, 5988.06, 30.44)
			}
		},

		BossActions = {
			vector3(-450.98, 5989.32, 31.44),
		}
    },

	LSPD5 = {
		Blip = {
			Coords  = vector3(373.5136, -1610.5288, 29.2920),
			Sprite  = 60,
			Display = 4,
			Scale   = 1.0,
			Colour  = 29
		},

		Cloakrooms = {
			vector3(370.3497, -1608.5413, 28.3919),
		},

		Armories = {
			vector3(373.4890, -1612.9430, 29.2920),
		},

		Vehicles = {
			{
				Spawner = vector3(383.9365, -1613.6776, 29.2919),
				SpawnPoint = vector3(392.3318, -1620.8447, 28.3919),
				Deleter = vector3(387.2695, -1621.3284, 28.3919),
				Heading = 313.62,
			}
		},

		Helicopters = {
			{
				Spawner = vector3(366.3581, -1621.7462, 29.2919),
				SpawnPoint = vector3(362.9659, -1598.3722, 36.0488),
				Deleter = vector3(363.1578, -1598.7783, 36.0488)
			}
		},

		BossActions = {
			vector3(364.9200, -1615.1410, 29.2919),
		}
    },

	LSPD6 = {
		Blip = {
			Coords  = vector3(640.4902, 0.8666, 82.7864),
			Sprite  = 60,
			Display = 4,
			Scale   = 1.0,
			Colour  = 29
		},

		Cloakrooms = {
			vector3(639.3691, -3.8279, 81.8878),
		},

		Armories = {
			vector3(640.5916, 1.1869, 82.7864),
		},

		Vehicles = {
			{
				Spawner = vector3(535.3596, -22.2368, 70.6294),
				SpawnPoint = vector3(537.2992, -42.3632, 69.9177),
				Deleter = vector3(529.4360, -27.8809, 69.7294),
				Heading = 313.62,
			}
		},

		Helicopters = {
			{
				Spawner = vector3(635.5764, -18.8442, 81.7581),
				SpawnPoint = vector3(580.1168, 12.2960, 102.3336),
				Deleter = vector3(580.1168, 12.2960, 102.3336)
			}
		},

		BossActions = {
			vector3(643.8657, 8.9115, 82.6969),
		}
    },
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
	'HWP', -- 2
	'SEU', -- 3
    'S.W.A.T', -- 4
    'Adam', -- 5
	'Offroad', -- 6
	'Motocykle', -- 7
	'TASK', -- 8
}

Config.AuthorizedVehicles = {
	{
		model = 'hp_challenger',
		label = 'Dodge Challenger',
		groups = {2},
		license = "hwp_pd"
	},
	{
		model = 'pd_charger14',
		label = 'Dodge Charger 2014',
		groups = {5},
	},
	{
		model = 'pd_charger18',
		label = 'Dodge Charger 2018',
		groups = {5},
	},
	{
		model = 'riot',
		label = 'Riot',
		groups = {5},
	},
	{
		model = 'hp_amggtr',
		label = 'Mercedes AMG GTR',
		groups = {2},
		license = "hwp_pd"
	},
	{
		model = 'hp_gt63s',
		label = 'Mercedes GT63S',
		groups = {2},
		license = "hwp_pd"
	},
	{
		model = 'pd_victoria',
		label = 'Ford Victoria',
		groups = {5},
	},
	{
		model = 'pd_viper',
		label = 'Dodge Viper 2018',
		groups = {3},
		license = 'seu_pd'
	},
	{
		model = 'hp_gt17',
		label = 'Ford GT',
		groups = {3},
		license = "seu_pd"
	},
	{
		model = 'hp_laferrari',
		label = 'LaFerrari',
		groups = {1},
		license = "cs_pd"
	},
	{
		model = 'DL_bmwm4',
		label = 'BMW M4',
		groups = {1},
		license = "cs_pd"
	},
	{
		model = 'hp_m8',
		label = 'BMW M8',
		groups = {2},
		license = "hwp_pd"
	},
	{
		model = 'pd_camaro',
		label = 'Chevrolet Camaro',
		groups = {2},
		license = "cs_pd"
	},
	{
		model = 'hp_lambo',
		label = 'Lamborghini',
		groups = {1},
		license = "cs_pd"
	},
	{
		model = 'pd_bronco',
		label = 'Ford Bronco',
		groups = {6},
	},
	{
		model = 'pd_tahoe21',
		label = 'Chevrolet Tahoe',
		groups = {6},
	},
	{
		model = 'pd_durango',
		label = 'Dodge Durango',
		groups = {6},
	},
	{
		model = 'pd_explo',
		label = 'Chevrolet Explorer',
		groups = {6},
	},
	{
		model = 'pd_freecrawler',
		label = 'Freecrawler',
		groups = {3},
		license = 'seu_pd'
	},
	{
		model = 'pd_raptor',
		label = 'Ford Raptor',
		groups = {3},
		license = "seu_pd"
	},
	{
		model = 'swat_jeep',
		label = 'Swat Jeep',
		groups = {4},
		license = "cttf_pd"
	},
	{
		model = 'pd_titan17',
		label = 'Nissan Titan',
		groups = {6},
	},
        {
		model = 'pitbullbb',
		label = 'Pitbull',
		groups = {4},
		license = "cttf_pd"
	},
    {
		model = 'bearcat',
		label = 'BearCat',
		groups = {4},
		license = "cttf_pd"
	},
	{
		model = 'pd_h1',
		label = 'H1',
		groups = {4},
		license = "cttf_pd"
	},
	{
		model = 'riot',
		label = 'Riot CTTF',
		groups = {4},
		license = "cttf_pd"
	},
	{
		model = 'hp_bmw',
		label = 'BMW',
		groups = {7},
		license = "mr_pd"
	},
	{
		model = 'pd_r1custom',
		label = 'R1',
		groups = {7},
		license = "mr_pd"
	},
	{
		model = 'hp_rs5',
		label = 'RS5',
		groups = {3},
		license = "seu_pd"
	},
	{
		model = 'titanwbpd1',
		label = 'niewiem co to',
		groups = {1},
		license = "cs_pd"
	},
	{
		model = 'nm_urus',
		label = 'Lamborghini Urus',
		groups = {2},
		license = "hwp_pd"
	},
	{
		model = 'pd_response',
		label = 'Medic Car',
		groups = {8},
		license = "cttf_pd"
	},
	{
		model = 'pd_sprinter',
		label = 'Sprinter',
		groups = {8},
		license = "cttf_pd"
	},
	{
		model = 'pd_van',
		label = 'Van',
		groups = {8},
		license = "cttf_pd"
	},
	{
		model = 'pd_camaroSU',
		label = 'SWAT Camaro',
		groups = {4},
		license = "cttf_pd"
	},
	{
		model = 'pd_escalader',
		label = 'Escalader',
		groups = {5},
	},
	{
		model = 'titanwbpd1',
		label = 'CODE BLACK',
		groups = {1},
		license = "cs_pd"
	},
	{
		model = 'pd_hummerSU',
		label = 'Hummer',
		groups = {4},
		license = "cttf_pd"
	},
	{
		model = 'pd_c8',
		label = 'Chevrolet C8',
		groups = {3},
		license = "seu_pd"
	},
	{
		model = 'pd_lexus',
		label = 'Lexus',
		groups = {5},
	},
	{
		model = 'pd_sprinter',
		label = 'Sprinter',
		groups = {8},
		license = "cttf_pd"
	},
	{
		model = 'hp_divo',
		label = 'Bugatti Divo',
		groups = {2},
		license = "hwp_pd"
	},
	{
		model = 'pd_kawasaki',
		label = 'Kawasaki',
		groups = {7},
		license = "mr_pd"
	},
	{
		model = 'hp_wrxp',
		label = 'WRXP',
		groups = {2},
		license = "hwp_pd"
	},
	{
		model = 'pd_caracara',
		label = 'Caracara',
		groups = {6},
	},
	{
		model = 'hp_x6',
		label = 'BMW X6r',
		groups = {2},
		license = "hwp_pd"
	},
	{
		model = 'hp_mustangwb',
		label = 'Mustang WB',
		groups = {2},
		license = "hwp_pd"
	},
	{
		model = 'pd_snake',
		label = 'Shelby Snaker',
		groups = {1},
		license = "cs_pd"
	},
	{
		model = 'pd_impala19',
		label = 'Impala',
		groups = {5},
	},
	{
		model = 'pd_fusion16',
		label = 'Ford Fusion',
		groups = {5},
	},
	{
		model = 'pd_taurus',
		label = 'Taurus',
		groups = {5},
	},
	{
		model = '404_urus',
		label = 'Lambo URUS',
		groups = {1},
		license = "cs_pd"
	},
	{
		model = 'pd_sultan',
		label = 'Sultan',
		groups = {3},
		license = "seu_pd"
	},
	{
		model = 'oliwierekm3pd',
		label = 'Sinkuss naj 00',
		groups = {1},
		license = "cs_pd"
	},
	{
		model = 'cheburekpd',
		label = 'Cheburek',
		groups = {3},
		license = "seu_pd"
	},
	{
		model = 'hp_911',
		label = 'Porshe 911',
		groups = {2},
		license = "hwp_pd"
	},
	{
		model = 'hp_chiron',
		label = 'Bugatti Chiron',
		groups = {2},
		license = "hwp_pd"
	},
	{
		model = 'pd_harley',
		label = 'Harley',
		groups = {7},
		license = "mr_pd"
	},
	{
		model = 'hp_rs6',
		label = 'Audi RS6',
		groups = {2},
		license = "hwp_pd"
	},
	{
		model = 'tsw_challenger',
		label = 'Challenger',
		groups = {1},
		license = "cs_pd"
	},
}

Config.AuthorizedHelicopters = {
	{
		model = 'pd_heli',
		label = 'Helikopter',
		license = "heli_pd"
	},
	{
		model = 'sw_heli',
		label = 'SWAT Helikopter',
		license = "heli_pd"
	}
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