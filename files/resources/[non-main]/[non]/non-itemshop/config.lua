Config = {}

Config.BoosterRoleID = 1246842129314217995

Config.Info = {
    firstLogoPart = "NON",
    secondLogoPart = "CASE",
    color = "#8C9EFF",
    shopLink = "https://indrop.eu/s/nonrp"
}

Config.Events = {
    time = "24 October 2025 00:00:00 UTC+2", 
    img = "https://casedrop.eu/uploads/files/ZDRAPKI22.png",
}

Config.Giveaway = false
Config.Giveaway = {
   item = {category = "AUTO", rarity = "green", title = "TESLA MODEL ?", img = "https://casedrop.eu/uploads/files/ZDRAPKI22.png", chance = 0.5, price = 0},
   price = "1200",
   time = "26 October 2025 17:15:30 UTC+2",
}

Config.CaseCategory = {
    {
        title = 'EVENT',
        cases = {
            { id = 1, title = 'SKRZYNIA STARTOWA', img = 'https://r2.fivemanage.com/R7HKRCqENRzbyDq4J7pj1/Frame53.png', price = 250, oldprice = 500, isNew = false},
            { id = 2, title = 'SKRZYNIA 50/50', img = 'https://r2.fivemanage.com/R7HKRCqENRzbyDq4J7pj1/Frame54.png', price = 200, oldprice = 300, isNew = false},
            { id = 3, title = 'SKRZYNIA LIMITEK', img = 'https://r2.fivemanage.com/R7HKRCqENRzbyDq4J7pj1/Frame123.png', price = 2000, oldprice = 2800, isNew = true},
            { id = 4, title = 'SKRZYNIA MIKOŁAJA', img = 'https://r2.fivemanage.com/R7HKRCqENRzbyDq4J7pj1/Frame50.png', price = 800, oldprice = 1300, isNew = true},
            -- { id = 5, title = 'ANIMATED CASE', img = 'https://r2.fivemanage.com/R7HKRCqENRzbyDq4J7pj1/Frame52.png', price = 1000, oldprice = 0, isNew = true},
            { id = 6, title = 'SKRZYNIA BAŁWANA', img = 'https://r2.fivemanage.com/R7HKRCqENRzbyDq4J7pj1/Frame49.png', price = 1400, oldprice = 2600, isNew = true},
            -- { id = 7, title = 'SOLÓWKA CASE', img = 'https://r2.fivemanage.com/AGPalBu8NXp4pzQU3xysv/ASSAULT.webp', price = 700, oldprice = 1000, isNew = true},
            -- { id = 8, title = 'HYPERION CASE', img = 'https://r2.fivemanage.com/pub/v6pgjwdzgxe1.png', price = 200, oldprice = 500, isNew = false},
            -- { id = 9, title = 'FORMULA CASE', img = 'https://r2.fivemanage.com/pub/eo58y3zm2fyd.png', price = 600, oldprice = 900, isNew = false},
            -- { id = 10, title = 'FORTUNA CASE', img = 'https://r2.fivemanage.com/pub/m5uccr1t20pn.png', price = 1200, oldprice = 1400, isNew = false},
        }
    },
    -- {
    --     title = 'STREAMERÓW',
    --     cases = {
    --         { id = 50, title = 'OLA CASE', img = 'https://r2.fivemanage.com/pub/v41ypszwwrx1.png', price = 1500, oldprice = 2100, isNew = true}
    --     }
    -- },
    {
        title = 'SKRZYNIE ZA PUNKTY',
        cases = {
            { id = 100, title = 'PointsCase', img = 'assets/coins/coincase1.jpg', price = 100, oldprice = 150, isNew = true, points = true}
        }
    },
    {
        title = 'INNE',
        cases = {
            { id = 71234, title = 'BOOSTER CASE', img = 'https://r2.fivemanage.com/R7HKRCqENRzbyDq4J7pj1/boostercase.png', price = 0, oldprice = 0, isNew = true, booster = true}
        }
    },
}

Config.Cases = {
    ["1"] = { -- ZA COINSY
        title = 'SKRZYNIA STARTOWA',
        price = 250,
        items = {
            {category = "car", rarity = "gold", title = "Bmw x7", name = '2ncsx7', count = 1, img = "https://r2.fivemanage.com/R7HKRCqENRzbyDq4J7pj1/image73.png", chance = 3, price = 550, points = 87},
            {category = "item", rarity = "gold", title = "Paczka Cracku", name = 'crack', count = 320, img = "https://r2.fivemanage.com/R7HKRCqENRzbyDq4J7pj1/R.png", chance = 4, price = 250, points = 100},
        
            {category = "money", rarity = "blue", title = "Gotówka x100000", name = 'money', count = 1000000, img = "https://r2.fivemanage.com/R7HKRCqENRzbyDq4J7pj1/image67.png", chance = 13, price = 200, points = 45},
            -- {category = "voucher", rarity = "red", title = "Voucher 700", name = 'voucher', count = 1, img = "https://r2.fivemanage.com/pub/i9ma0738sua1.png", chance = 6.86, price = 700, points = 80},
        


            {category = "item", rarity = "purple", title = "Porcja MDMA x100", name = 'mdma', count = 100, img = "https://r2.fivemanage.com/R7HKRCqENRzbyDq4J7pj1/R.png", chance = 13, price = 150, points = 25},
            {category = "money", rarity = "gold", title = "Gotówka x500000", name = 'money', count = 500000, img = "https://r2.fivemanage.com/R7HKRCqENRzbyDq4J7pj1/image67.png", chance = 8, price = 150, points = 41},
        
            {category = 'money', rarity = 'purple', title = 'Gotówka x250000', name = 'money', count = 250000, img = 'https://r2.fivemanage.com/R7HKRCqENRzbyDq4J7pj1/image67.png', chance = 30, price = 120, points = 10},
            {category = "item", rarity = "blue", title = "Amunicja do pistoletu x500", name = 'pistol_ammo', count = 500, img = "https://r2.fivemanage.com/R7HKRCqENRzbyDq4J7pj1/image65.png", chance = 29, price = 140, points = 14}
        }
    },

    ["2"] = {
        title = 'SKRZYNIA 50/50',
        price = 200,
        points = false,
        items = {
            {category = "car", rarity = "blue", title = "Samochód Komoda", name = 'komoda', count = 1, img = "https://r2.fivemanage.com/R7HKRCqENRzbyDq4J7pj1/image60.png", chance = 50, price = 25, points = 15},
            {category = "car", rarity = "gold", title = "Samochód Gulia", name = 'dl_gulia', count = 1, img = "https://r2.fivemanage.com/R7HKRCqENRzbyDq4J7pj1/image59.png", chance = 50, price = 200, points = 25},
        }
    },
    ["4"] = {
        title = 'SKRZYNIA MIKOŁAJA',
        price = 800,
        points = false,
        items = {
            {category = "item", rarity = "blue", title = "Paczka Cracku x420", name = 'crack', count = 420, img = "https://r2.fivemanage.com/R7HKRCqENRzbyDq4J7pj1/R.png", chance = 35, price = 400, points = 100},
            {category = "money", rarity = "blue", title = "Gotówka x500000", name = 'money', count = 500000, img = "https://r2.fivemanage.com/R7HKRCqENRzbyDq4J7pj1/image67.png", chance = 25, price = 300},
            
            {category = "item", rarity = "pink", title = "Bon na Vipa 30 Dni", name = 'ticket_vip2', count = 1, img = "https://r2.fivemanage.com/R7HKRCqENRzbyDq4J7pj1/image86.png", chance = 9.8, price = 350, points = 15},
            {category = "car", rarity = "pink", title = "GT3", name = 'dicygt3mq', count = 1, img = "https://r2.fivemanage.com/R7HKRCqENRzbyDq4J7pj1/image69.png", chance = 12, price = 950, points = 15},
            {category = "item", rarity = "pink", title = "Amunicja x5000", name = 'pistol_ammo', count = 5000, img = "https://r2.fivemanage.com/R7HKRCqENRzbyDq4J7pj1/image65.png", chance = 10, price = 350, points = 15},
            
            {category = "money", rarity = "red", title = "Gotówka x1000000", name = 'money', count = 1000000, img = "https://r2.fivemanage.com/R7HKRCqENRzbyDq4J7pj1/image67.png", chance = 5.2, price = 700, points = 25},

            {category = "car", rarity = "gold", title = "M2 OFFROAD", name = 'centm2offroad', count = 1, img = "https://r2.fivemanage.com/R7HKRCqENRzbyDq4J7pj1/7844f8f13411dd0dcb8a6cc7853592d61.png", chance = 3, price = 777, points = 1350},

        }
    },
    -- ["5"] = {
    --     title = 'ANIMATED CASE',
    --     price = 1000,
    --     points = false,
    --     items = {
    --         {category = "car", rarity = "blue", title = "Samochód Passat", name = 'VOLKSSLE', count = 1, img = "https://r2.fivemanage.com/AGPalBu8NXp4pzQU3xysv/removal.ai_dd5e10d1-d23f-4c74-9a3b-d9bf6a81e4fb-obraz_2024-11-14_204325083.png", chance = 70, price = 25, points = 15},

    --         {category = "car", rarity = "gold", title = "Samochód Supra MK4", name = 'TOYOTAFT', count = 1, img = "https://r2.fivemanage.com/AGPalBu8NXp4pzQU3xysv/removal.ai_6c892218-1e9b-442f-a5d8-24ad5abd8a74-obraz_2024-11-14_203846225.png", chance = 10, price = 1200, points = 250},
    --         {category = "car", rarity = "gold", title = "Samochód RX7", name = 'KillerRx7', count = 1, img = "https://r2.fivemanage.com/AGPalBu8NXp4pzQU3xysv/removal.ai_9c38121c-ee2b-428e-ab64-9b50ce088243-obraz_2024-11-14_203628941.png", chance = 10, price = 1200, points = 250},
    --         {category = "car", rarity = "gold", title = "Samochód Jesko", name = 'jeskoanim', count = 1, img = "https://r2.fivemanage.com/AGPalBu8NXp4pzQU3xysv/removal.ai_538f8e9f-575a-445e-8ac4-066a5117488b-obraz_2024-11-14_203057803.png", chance = 10, price = 1200, points = 250},

    --     }
    -- },
    ["6"] = {
        title = 'SKRZYNIA BAŁWANA',
        price = 1400,
        points = false,
        items = {
            {category = "money", rarity = "blue", title = "Gotówka x5,000,000", name = 'money', count = 5000000, img = "https://r2.fivemanage.com/R7HKRCqENRzbyDq4J7pj1/image67.png", chance = 40, price = 500, points = 15},
            {category = "item", rarity = "blue", title = "Fentanyl x500", name = 'fentanyl', count = 500, img = "https://r2.fivemanage.com/R7HKRCqENRzbyDq4J7pj1/image63.png", chance = 19, price = 700, points = 15},
            {category = "voucher", rarity = "gold", title = "Voucher 150 monet", name = 'voucher', count = 150, img = "https://r2.fivemanage.com/R7HKRCqENRzbyDq4J7pj1/Frame66.png", chance = 10, price = 50, points = 15},

            {category = "car", rarity = "red", title = "Samochód M3 G80", name = '404_m3g80', count = 1, img = "https://r2.fivemanage.com/R7HKRCqENRzbyDq4J7pj1/image62.png", chance = 15, price = 1600, points = 255},
            {category = "car", rarity = "red", title = "Samochód R8", name = 'r8csd', count = 1, img = "https://r2.fivemanage.com/R7HKRCqENRzbyDq4J7pj1/image72.png", chance = 15, price = 1600, points = 225},

            {category = "item", rarity = "gold", title = "Rewolver", name = 'doubleaction', count = 1, img = "https://r2.fivemanage.com/R7HKRCqENRzbyDq4J7pj1/image64.png", chance = 1, price = 1700, points = 315},

        }
    },
    ["3"] = {
        title = 'SKRZYNIA LIMITEK',
        price = 2000,
        points = false,
        items = {
            {category = "car", rarity = "gold", title = "SUPRA", name = 'rmodsupralb', count = 1, img = "https://r2.fivemanage.com/R7HKRCqENRzbyDq4J7pj1/image121.png", chance = 20, price = 1900, points = 150},       
            {category = "car", rarity = "gold", title = "M3 G80", name = '404_m3g80', count = 1, img = "https://r2.fivemanage.com/R7HKRCqENRzbyDq4J7pj1/image120.png", chance = 20, price = 1900, points = 150},
            {category = "car", rarity = "gold", title = "GT3", name = 'dicygt3mq', count = 1, img = "https://r2.fivemanage.com/R7HKRCqENRzbyDq4J7pj1/image69.png", chance = 20, price = 1900, points = 150},
            {category = "car", rarity = "gold", title = "M4 F82", name = 'm4f82', count = 1, img = "https://r2.fivemanage.com/R7HKRCqENRzbyDq4J7pj1/image115.png", chance = 20, price = 1900, points = 150},
            {category = "car", rarity = "gold", title = "R8 CSD", name = 'r8csd', count = 1, img = "https://r2.fivemanage.com/R7HKRCqENRzbyDq4J7pj1/image117.png", chance = 20, price = 1900, points = 150},

        }      
    },
    ["7"] = {
        title = 'SOLÓWKA CASE',
        price = 700,
        points = false,
        items = {
            {category = "item", rarity = "blue", title = "Nóż", name = 'knife', count = 1, img = "https://r2.fivemanage.com/AGPalBu8NXp4pzQU3xysv/W_ME_Knife.webp", chance = 25, price = 200, points = 15},
            {category = "item", rarity = "blue", title = "Kastet", name = 'knuckle', count = 1, img = "https://r2.fivemanage.com/AGPalBu8NXp4pzQU3xysv/BrassKnuckles-GTAV.webp", chance = 25, price = 200, points = 15},

            {category = "item", rarity = "pink", title = "Metka x555", name = 'meth_pooch', count = 555, img = "https://r2.fivemanage.com/R7HKRCqENRzbyDq4J7pj1/R.png", chance = 15, price = 330, points = 15},
            {category = "item", rarity = "pink", title = "Łom", name = 'crowbar', count = 1, img = "https://r2.fivemanage.com/AGPalBu8NXp4pzQU3xysv/crowbar.png", chance = 15, price = 330, points = 15},

            {category = "item", rarity = "red", title = "Kij Bejsbolowy", name = 'bat', count = 1, img = "https://r2.fivemanage.com/AGPalBu8NXp4pzQU3xysv/Baseball_Bat_29.webp", chance = 12, price = 650, points = 15},

            {category = "item", rarity = "gold", title = "Maczeta", name = 'machete', count = 1, img = "https://r2.fivemanage.com/AGPalBu8NXp4pzQU3xysv/Machete.webp", chance = 8, price = 850, points = 15},

        }
    },

    ["71234"] = { -- BOOSTER 
        title = 'BOOSTER CASE',
        price = 0,
        items = {
            {category = "car", rarity = "gold", title = "BOOSTER CAR!", name = '2ncsx7', count = 1, img = "https://r2.fivemanage.com/R7HKRCqENRzbyDq4J7pj1/image73.png", chance = 3, price = 100, points = 87},
            {category = "item", rarity = "gold", title = "Paczka Cracku", name = 'crack', count = 320, img = "https://r2.fivemanage.com/R7HKRCqENRzbyDq4J7pj1/R.png", chance = 4, price = 30, points = 100},
            {category = "voucher", rarity = "gold", title = "Voucher 150 monet", name = 'voucher', count = 150, img = "https://r2.fivemanage.com/R7HKRCqENRzbyDq4J7pj1/Frame66.png", chance = 5, price = 50, points = 15},
        
            {category = "money", rarity = "gold", title = "Gotówka x250000", name = 'money', count = 250000, img = "https://r2.fivemanage.com/R7HKRCqENRzbyDq4J7pj1/image67.png", chance = 10, price = 50, points = 45},
            -- {category = "voucher", rarity = "red", title = "Voucher 700", name = 'voucher', count = 1, img = "https://r2.fivemanage.com/pub/i9ma0738sua1.png", chance = 6.86, price = 700, points = 80},
        


            {category = "item", rarity = "purple", title = "Porcja MDMA x100", name = 'mdma', count = 100, img = "https://r2.fivemanage.com/R7HKRCqENRzbyDq4J7pj1/R.png", chance = 10, price = 20, points = 25},
            {category = "money", rarity = "purple", title = "Gotówka x1000000", name = 'money', count = 500000, img = "https://r2.fivemanage.com/R7HKRCqENRzbyDq4J7pj1/image67.png", chance = 13, price = 20, points = 41},
        
            {category = 'money', rarity = 'blue', title = 'Gotówka x100000', name = 'money', count = 100000, img = 'https://r2.fivemanage.com/R7HKRCqENRzbyDq4J7pj1/image67.png', chance = 30, price = 10, points = 10},
            {category = "item", rarity = "blue", title = "Amunicja do pistoletu x500", name = 'pistol_ammo', count = 500, img = "https://r2.fivemanage.com/R7HKRCqENRzbyDq4J7pj1/image65.png", chance = 25, price = 140, points = 14}
        }
    },

    ["71233"] = { -- Darmowa skrzynia (nazwa musi zostać)
        title = "DARMOWA SKRZYNKA",
        price = 0,
        items = {
            {category = "money", rarity = "blue", title = "Gotówka x25000", name = 'money', count = 25000, img = "https://r2.fivemanage.com/R7HKRCqENRzbyDq4J7pj1/image67.png", chance = 21.6, price = 5, points = 1},
            {category = "voucher", rarity = "blue", title = "Voucher 50 monet", name = 'voucher', count = 50, img = "https://r2.fivemanage.com/R7HKRCqENRzbyDq4J7pj1/Frame5(1).png", chance = 30.8, price = 50, points = 3},
            {category = "item", rarity = "blue", title = "RedBull x50", name = 'energydrink', count = 50, img = "https://r2.fivemanage.com/R7HKRCqENRzbyDq4J7pj1/image88.png", chance = 13.3, price = 11, points = 4},
            {category = "item", rarity = "pink", title = "Zestaw naprawczy x5", name = 'fixkit', count = 5, img = "https://r2.fivemanage.com/R7HKRCqENRzbyDq4J7pj1/image90.png", chance = 11, price = 15, points = 7},
            {category = "voucher", rarity = "red", title = "Voucher 100 monet", name = 'voucher', count = 100, img = "https://r2.fivemanage.com/R7HKRCqENRzbyDq4J7pj1/Frame68.png", chance = 6.2, price = 100, points = 10},
            {category = "item", rarity = "red", title = "Amunicja do pistoletu x100", name = 'pistol_ammo', count = 100, img = "https://r2.fivemanage.com/M5W3SoC4arMYbexPATHmo/pistol_ammo_box.png", chance = 3.2, price = 27, points = 11},
            {category = "voucher", rarity = "gold", title = "Voucher 150 monet", name = 'voucher', count = 150, img = "https://r2.fivemanage.com/R7HKRCqENRzbyDq4J7pj1/Frame66.png", chance = 2.9, price = 150, points = 15},
            {category = "item", rarity = "gold", title = "Pistolet vintage x1", name = 'vintage_pistol', count = 1, img = "https://r2.fivemanage.com/R7HKRCqENRzbyDq4J7pj1/image87.png", chance = 5.6, price = 55, points = 18},
            {category = "item", rarity = "gold", title = "Pistolet MK2 x1", name = 'pistol_mk2', count = 1, img = "https://r2.fivemanage.com/R7HKRCqENRzbyDq4J7pj1/image89.png", chance = 5.4, price = 60, points = 20},
        }
    },
}

Config.ShopItems  = {
    -- {
    --     category = "car", 
    --     rarity = 'gold', 
    --     title = 'Audi R8', 
    --     name = 'audir8',
    --     count = 100,
    --     img = "assets/items/ammopistol.png", 
    --     price = 30
    -- },
}

Config.AllItems = {}