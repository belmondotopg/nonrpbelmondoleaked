Config = Config or {};

Config.ChatCommands = {
    ["global"] = {
        receivers = -1,
        color = "#fff",
        background = "#222742",
        icon = "fa-solid fa-globe",
    },
    ["g"] = {
        receivers = -1,
        color = "#fff",
        background = "#222742",
        icon = "fa-solid fa-globe",
    },
    ['media'] = {
        background = "#ff0050",
        color = "#000",
        icon = "fa-solid fa-bell",
        receivers = -1,
        groups = {
            ["wlasciciel"] = true,
            ["wspolwlasciciel"] = true,
            ["media"] = true,
        } 
    },
    ["adminchat"] = {
        color = "#ffb18c",
        icon = "fa-solid fa-shield",
        receivers = "admins",
        groups = {
            ["wlasciciel"] = true,
            ["wspolwlasciciel"] = true,
            ["glownyopiekun"] = true,
            ["nadzorserwera"] = true,
            ["opiekunadm"] = true,
            ["management"] = true,
            ["zarzad"] = true,
            ["headadmin"] = true,
            ["admin"] = true,
            ["junioradm"] = true,
            ["smod"] = true,
            ["mod"] = true,
            ["support"] = true,
            ["trialsupport"] = true,
        } 
    },
    ["LOOC"] = {
        receivers = "distance",
        color = "#505050",
        icon = "fa-solid fa-user", 
    },
}

Config.ChatBadges = {
    ['user'] = {
        label = "GRACZ",
        color = "rgb(255, 255, 255)"
    },
    ['vip'] = {
        label = "VIP",
        color = "rgb(229, 198, 44)"
    },
    ['media'] = {
        label = "MEDIA",
        color = "rgb(185, 61, 255)"
    },
    ['developer'] = {
        label = "DEVELOPER",
        color = "rgb(50, 50, 50)"
    },
    ['trialsupport'] = {
        label = "TRIAL SUPPORT",
        color = "rgb(246, 238, 72)"
    },
    ['support'] = {
        label = "SUPPORT",
        color = "rgb(98, 238, 80)"
    },
    ['mod'] = {
        label = "MODERATOR",
        color = "rgb(197, 126, 255)"
    },
    ['smod'] = {
        label = "SENIOR MODERATOR",
        color = "rgb(135, 96, 253)"
    },
    ['junioradm'] = {
        label = "JUNIOR ADMIN",
        color = "rgb(77, 178, 233)"
    },
    ['admin'] = {
        label = "ADMIN",
        color = "rgb(72, 219, 199)"
    },
    ['headadmin'] = {
        label = "HEAD ADMIN",
        color = "rgb(0, 102, 255)"
    },
    ['management'] = {
        label = "MENAGMENT",
        color = "rgb(0, 255, 213)"
    },
    ['zarzad'] = {
        label = "ZARZAD",
        color = "rgb(194, 194, 194)"
    },
    ['opiekunadm'] = {
        label = "OPIEKUN ADM",
        color = "rgb(131, 131, 131)"
    },
    ['nadzorserwera'] = {
        label = "NADZOR SERWERA",
        color = "rgb(255, 255, 255)"
    },

    ['glownyopiekun'] = {
        label = "GLOWNY OPIEKUN",
        color = "rgb(255, 0, 0)"
    },

    ['wspolwlasciciel'] = {
        label = "WSPOLWLASCICIEL",
        color = "rgb(61, 70, 255)"
    },
    ['wlasciciel'] = {
        label = "WLASCICIEL",
        color = "rgb(140, 158, 255)"
    }
}