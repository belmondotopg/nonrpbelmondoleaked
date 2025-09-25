queue = {
    serverName = "NonRP",
    discord = "https://discord.gg/nonrp",
    shop = "https://discord.gg/nonrp",
    serverLogo = "https://r2.fivemanage.com/R7HKRCqENRzbyDq4J7pj1/nonrplogomin.png",
    antifloodTime = 5, --time in seconds to wait before add to queue
    refreshInterval = 2000, --time in ms to wait before refresh queue
    whitelist = true, -- true/false // set true to turn on whitelist
    banlist = false,
    lang = "EN",
    langs = {
        ["EN"] = {
            ["no_steam"] = "Nie wykryto steama",
            ["no_discord"] = "Nie wykryto discorda",
            ["no_whitelist"] = "Nie posiadasz rangi na discordzie",
            ["normal_ticket"] = "Normal",
            ["buy_premium"] = "Nie chcesz czekać? Kup premium na naszej stronie",
            ["aconnecting"] = function(time)
                return "Zostaniesz połączony za "..time.." sekund"
            end,
            ["in_queue"] = function(player,tbl,time)
                return "Jesteś "..player.."/"..tbl.." w kolejce. Czas oczekiwania ("..time..")"
            end
        }
    },
    priority = {
        ["1013172055929258117"] = {priority = 100, name =  "Premium"},
        ["1013171979743936522"] = {priority = 50, name = "Donator"},
        ["1013172012572753990"] = {priority = 20, name = "Booster"}
    },

    --------------------------------
    players = {}, -- do not touch
    connectingPlayers = {} -- do not touch
    --------------------------------
}