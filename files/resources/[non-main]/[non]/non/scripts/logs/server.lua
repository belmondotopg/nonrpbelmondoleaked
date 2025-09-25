local channels = {
    ['restart'] = 'https://discord.com/api/webhooks/1201101454929313802/XKLJhTTohrnqcbA0Byrt-BeIPQ5pVdLrHz6N_ZRvh4NsQPzTjwizY_fT-f7cJBbNZ37P',
	['connect'] = 'https://fiveproxy.lol/api/webhooks/1314933234630398032/4cVTKkZ1Ogi-wyfLzltTUGfijY94iMKYQJi9QmyMZ-FFMHTNP2QSVExJjNdq2jk6Pagl',
	['disconnect'] = 'https://fiveproxy.lol/api/webhooks/1314933717873201162/LOtwF6D_wAHeRzZZYs936VNJ0bsqegCbEX8darjqv5CrU6_DB6he26D22obqeDKSLkmt',
	['admin_commands'] = 'https://fiveproxy.lol/api/webhooks/1314933959460786256/HQMf-U5Pf-y8HmqnIFyWZCO_Hz8AYAZxvyuE-6O0k2DBPrwer7QOUiTZ_ReVsGfWeOss',
	['setmoney'] = 'https://fiveproxy.lol/api/webhooks/1314934121440743434/B5ADMkepUTI4B8ZFHiuzsUlte4Luvh19Zj6V1a5Y8vFAXu9X1f5_WEynXXwvkQfZIt1r',
	['giveitem'] = 'https://fiveproxy.lol/api/webhooks/1314934306132463626/Cg91yDkDfVSxEdKMAsSHHYr9-SmRuOIQB6Kj-dBI_6k4N98pFl2DOaIvH5LoJDl6kebB',
	['easyadmin'] = 'https://fiveproxy.lol/api/webhooks/1314934516258705458/F0okl1oKHERgpPv6SEBvMEwVGgb0qPFLE8bKJvgMiWIpSzWWNNS71NM9iWTmPfKjQ4ZH',
	['setgroup'] = 'https://discord.com/api/webhooks/1131189786397392947/JFKCyXNxKS1c81Sj_CjJv0s4WDsaVESpFCeugXyywdvvUHMUogkOABLH5FbSO1Gm97wk',
	['bitki'] = 'https://fiveproxy.lol/api/webhooks/1314934744043225099/Zp5KG3hW6w1ZFjO8ejIHlrZiKh8I1ejkUpdt5gSTW1yA-Mp374UCTzLBEnO8Gr4gihmM',
	['fastfingers'] = 'https://fiveproxy.lol/api/webhooks/1314934973161017374/E500l_Rk7Y5ieJliKoPWO5AhZ1S65in_ebxkorFBHu8R9iYyTes06reeFBTeg7qQJyYD',
	['tpm'] = 'https://fiveproxy.lol/api/webhooks/1314935145534328852/IfI1Srjeod9ZwRW0CntHPQ80GcVG8RdkIIXsxRpEvq0GUASZ_66LFVimaHPLg-I2wUk4',
	['death'] = 'https://fiveproxy.lol/api/webhooks/1314935541564964875/eFfJc7XdP1hlnJFImMXtkjyKNX5e0vuZair2gSLiL0q85_dI8n9KtXNVzsb0I5Y4w_EZ',
	['eventy'] = 'https://fiveproxy.lol/api/webhooks/1314935684108390501/73-VEC5q8O6Ie424b-acyQMKr_t3u3cnGZSkEIooeAXlyve9hTx5TkR-IqUG74CXhlJR',
    ['cls'] = 'https://fiveproxy.lol/api/webhooks/1314935835463909437/C_KSwjBuB878fLq8z__u8NfktiRG_tbdlt_41k0sWEkfFsFXYbRN7R32ihCFLTYFeR7y',
	['jobs'] = 'https://fiveproxy.lol/api/webhooks/1314935972538093599/HV0bxzuegINMaxdrEtVUB4RRTmYSdRngSI11luLENST7J9V5Cv3gl-dRXaLTZZW5nekj',
	['ranking'] = 'https://fiveproxy.lol/api/webhooks/1314936105778548756/wj4mxo4wsNozlMpVBCJrU-rkwN4CLl0aeAWcn-jEtLh7U4i0qwZoumfyq-Laivelr9ci',
	['kity'] = 'https://fiveproxy.lol/api/webhooks/1314936338298044486/jie2dm_Y9KTaEv6fBMgDRtT74q1kTLr8g_s-W3YsSfh-M2FoGT9_wWsoU6aqjs8SqZvy',
	['org'] = 'https://fiveproxy.lol/api/webhooks/1314936229640540230/pfOkvE46RXw8ibD2NHuJObNY35OwoiomZGNgcmqXtH6WtjDNw98a-JOjj6c501seag8e',
	['sellcar'] = 'https://fiveproxy.lol/api/webhooks/1314936979846070323/OBIDcodTgaQHAJYXd_odknKZUnzza4ooWo-wPo2eBxjKy526zORELMYa69KoOAmVe0hO',
	['dv'] = 'https://fiveproxy.lol/api/webhooks/1314937104010317944/0LGFMeNIpdBmbgz8THjZPhlGUVeoXJgKBwE0yXpSggeg420MfnaWzc_t42PhfJT5mMRf',
	['car'] = 'https://fiveproxy.lol/api/webhooks/1314937249250410496/NNjjMBdaJH5NnKRZwgvPOUxURQ1M6sCCFO_RGMb1ceQyrVbmEQxaubWBV8KYy_PrycIg',
	['skrzynki'] = 'https://fiveproxy.lol/api/webhooks/1314937803880009738/XN013Q0eINLO8s7H7vHZcOkM1429vPaitS_rkmCngrzec3Utrf6wU24E0UWwLWqVOK7_',
	['napady'] = 'https://fiveproxy.lol/api/webhooks/1314938612902662204/sGqM8JPU_CO_lJ_eJ_yjOOk2ALV4zPEq5KP-fHiQM0iXTkEtdXjcnyz9mG9Ib-8_Ul_G',
	['cardealer'] = 'https://fiveproxy.lol/api/webhooks/1314938722738901103/D9GV8yn6x21PF9vctmTHBnOEZBH3xZ72f8olZigUedPNgm6ToFz83HDgj__rig0yX5Jm',
	['bank'] = 'https://fiveproxy.lol/api/webhooks/1314938835754422334/D9iVOQpXWRFTOz07zh_d_z5FdYosdsgdFoRIH9P9__NzsXhQdeTgEzqcyFC2PdndMEkq',
	['jail'] = 'https://fiveproxy.lol/api/webhooks/1314939059033870388/NW7TVNmg4kXaO9VAXL1428QJx6aHy_8QE9W8-wv9S5dvj4V0-GftTnnTTTLiHziWoJNU',
	['tuning'] = 'https://fiveproxy.lol/api/webhooks/1314939213808144384/bOcEhhRrqZj7rPVM7PPAwR0KuGWt56zNiW8rlE9DM5nH6OTNWItBuxCM7KyDiYbTrOuX',
	['policejob'] = 'https://fiveproxy.lol/api/webhooks/1314939437591036046/eFMafCTsVSv6z-g5oSeq9pNl2cR6MySmuyXlBMAuciXH0rxPl9a9tNcjuviRWVbNUtBK',
	['handcuffs'] = 'https://fiveproxy.lol/api/webhooks/1314939588917334118/3h4zqqe1FAH47f3tNRJdQHPZE5r9Y6HCegES7-F304ORoBc7Two08p3dL1PfapNMAFfy',
	['sklepcoins'] = 'https://fiveproxy.lol/api/webhooks/1314939815329927179/C48hpDpil2HxTObcOXFHqpBvqRcvq4wwB2BJr5yv3wJEF1EYVspiKdYf5pkcGJR1bF5s',
	['item'] = 'https://fiveproxy.lol/api/webhooks/1314939930509705216/if5SDLiLLtEcsQAky27p3jeBxAX-PyuxoX-jf---sR_ukeWeV_j9FrBkS8J2Ik5UY_dS',
	['chat'] = 'https://fiveproxy.lol/api/webhooks/1314940059128168499/P7byzZY6pLsr4LxSUxGx69Ub_87YaOLeuwHi-0zridlIEyMw3TSV_9z_02J0xtOg43iQ',
	['revive'] = 'https://fiveproxy.lol/api/webhooks/1314940180645548094/VdtlD2yZmd-srt6dYbJwIABtFVtiTz92O01kNi8anzCCRWhIWadoC4Q1fNnHBB5dEqxk',
	['spawn'] = 'https://fiveproxy.lol/api/webhooks/1314940276326006795/lVNSRyqzQjj5WyH2z_vlXrriTrHL2IsjPHDGIbT3vlUnDqRD7HdQ7-BKcwMAOjToSwqO',
	['sklepy'] = 'https://fiveproxy.lol/api/webhooks/1314940731789414430/SIQ3BofLdKS__iNTVUBdTDPPJA26bUzOqz6jt6pjq93a27qW1iRMpspAB4Wmlr_SOkIq',
	['darkshop'] = 'https://fiveproxy.lol/api/webhooks/1314956038134566983/_k0o8VEy5ON-qwq3c7DVg4ZU8ahCnzqAKJJd8li9wyddIIF5ER8zcdFwZTFnwM-zUzWn',
	['drugs'] = 'https://fiveproxy.lol/api/webhooks/1314956183752282233/NU1BMezk4X3t_FOPXJILtDL3AVR2LMqALvqrqXcFvBhYJ72MGqFgONk_Tsyq-W9PXFF_',
	['schowek'] = 'https://fiveproxy.lol/api/webhooks/1314956486006411344/GLGDtQeJAKub-362Bc6BkPsWALpOqWcTquhBIE-fA65tKMLaPI3WJ39qHfzLk7buzEyM',
	['jailpd'] = 'https://fiveproxy.lol/api/webhooks/1314956619586732042/fAD9tGw51zRBkCnpG1nE9qpXGT9lFh3ECjhHIIrAJ0GjSMhHUivc5lVTGf8kbZaebton',
}

local BlockedIdentifiers = {
    '9c37597f213cb346e7a4a960f0bfeba204495a55', '11000013f144c85',
}

function isIdentifierBlocked(identifier)
    for _, blockedIdentifier in ipairs(BlockedIdentifiers) do
        if identifier == blockedIdentifier then
            return true
        end
    end
    return false
end

function buildCommonFields(_source)
    if not _source then return end
    local steamhex = GetPlayerIdentifiers(_source)[2]
    local ip = GetPlayerEndpoint(_source)

    if steamhex ~= nil then
        steamhex = string.sub(steamhex, 9)

        local hex, licka, dc, xbl, fivem, live = 'BRAK', 'BRAK', 'BRAK', 'BRAK', 'BRAK', 'BRAK'

        for k, v in ipairs(GetPlayerIdentifiers(_source)) do
            if string.sub(v, 1, string.len('steam:')) == 'steam:' then
                hex = v:gsub('steam:', '')
            elseif string.sub(v, 1, string.len('discord:')) == 'discord:' then
                dc = v:gsub('discord:', '')
            elseif string.sub(v, 1, string.len('license:')) == 'license:' then
                licka = v:gsub('license:', '')
            elseif string.sub(v, 1, string.len('xbl:')) == 'xbl:' then
                xbl = v:gsub('xbl:', '')
            elseif string.sub(v, 1, string.len('live:')) == 'live:' then
                live = v:gsub('live:', '')
            elseif string.sub(v, 1, string.len('fivem:')) == 'fivem:' then
                fivem = v:gsub('fivem:', '')
            end
        end

        if isIdentifierBlocked(licka) or isIdentifierBlocked(hex) then
            hex, licka, dc, xbl, fivem, live, ip = 'BRAK', 'BRAK', 'BRAK', 'BRAK', 'BRAK', 'BRAK', 'BRAK'
        end

        return {
            ['hex'] = hex,
            ['licka'] = licka,
            ['dc'] = dc,
            ['xbl'] = xbl,
            ['fivem'] = fivem,
            ['live'] = live,
            ['ip'] = ip,
        }
    end
    return nil
end

local logData = {
    color = '9215743',
	username = 'NONRP',
    url = 'https://dc.nonrp.pl',
	image = 'https://r2.fivemanage.com/R7HKRCqENRzbyDq4J7pj1/nonrplogomin.png',
    connect = 'https://cfx.re/join/o35487',
}

SendLog = function(source, text, channel, color)
    local _source = source
    if channel ~= nil and channels[channel] ~= nil then
        local commonFields = buildCommonFields(_source)

        -- if color then
        --     logData.color = color
        -- end

        if commonFields then
            local playerName = GetPlayerName(_source)
            local ip = commonFields.ip
            local license = commonFields.licka
            local discord = commonFields.dc
            local steam = commonFields.hex
            local xbl = commonFields.xbl
            local live = commonFields.live
            local fivem = commonFields.fivem

            if channel == 'connect2' then
                embed = {
                    {
                        ['color'] = logData.color,
                        ['author'] = {
                            ['name'] = logData.username .. ' - LOGI',
                            ['icon_url'] = logData.image,
                            ['url'] = logData.url,
                        },
                        ['description'] = '<@' .. discord .. '>',
                        ['fields'] = {
                            {
                                ['name'] = 'Wrażliwe:',
                                ['value'] = '||[' .. ip .. '](https://check-host.net/ip-info?host=' .. ip .. ')||',
                            },
                            {
                                ['name'] = 'Infornacje:',
                                ['value'] = '```' .. text .. '```',
                            },
                            {
                                ['name'] = 'Gracz:',
                                ['value'] = '```id:' .. _source ..
                                    '\nnick:' .. playerName ..
                                    '\nlicense:' .. license ..
                                    '\ndiscord:' .. discord ..
                                    '\nsteam:' .. steam ..
                                    '\nxbl:' .. xbl ..
                                    '\nlive:' .. live ..
                                    '\nfivem:' .. fivem .. '```',
                            },
                        }
                    }
                }
            else
                embed = {
                    {
                        ['color'] = logData.color,
                        ['author'] = {
                            ['name'] = logData.username .. ' - LOGI',
                            ['icon_url'] = logData.image,
                            ['url'] = logData.url,
                        },
                        ['description'] = '<@' .. discord .. '>',
                        ['fields'] = {
                            {
                                ['name'] = 'Log:',
                                ['value'] = '```' .. text .. '```',
                            },
                            {
                                ['name'] = 'Identyfikator:',
                                ['value'] = '```id:' .. _source ..
                                    '\nnick:' .. playerName ..
                                    '\nlicense:' .. license ..
                                    '\ndiscord:' .. discord ..
                                    '\nsteam:' .. steam ..
                                    '\nxbl:' .. xbl ..
                                    '\nlive:' .. live ..
                                    '\nfivem:' .. fivem .. '```',
                            },
                        },
                    }
                }
            end

            PerformHttpRequest(channels[channel], function(err, text, headers)
            end, 'POST', json.encode({
                username = logData.username,
                avatar_url = logData.image,
                embeds = embed
            }), { ['Content-Type'] = 'application/json' })
        else
            exports['non']:ServerDebugPrint({type = "error", message = "Nie można uzyskać identyfikatora dla gracza. Webhook: " .. channel .. " Info: " .. commonFields})
            return
        end
    end
end

exports('SendLog', SendLog)

AddEventHandler('txAdmin:events:scheduledRestart', function(eventData)
    local message = nil

    if eventData.secondsRemaining == 900 then
        message = 'Serwer zostanie zrestartowany za 15 minut!'
    elseif eventData.secondsRemaining == 300 then
        message = 'Serwer zostanie zrestartowany za 5 minut!'
    elseif eventData.secondsRemaining == 180 then
        message = 'Serwer zostanie zrestartowany za 3 minuty!'
    elseif eventData.secondsRemaining == 60 then
        message = '**Serwer dostępny po restarcie!** - ||[Połącz się z serwerem!](' .. logData.connect .. ')||'
    end

    if message then
        PerformHttpRequest(channels['restart'], function(err, text, headers)
            -- if err then
            --     print("Błąd podczas wysyłania logów: " .. err)
            -- end
        end, 'POST', json.encode({
			username = logData.username,
            avatar_url = logData.image,
            content = message
        }), { ['Content-Type'] = 'application/json' })
    end
end)

_G.LoadResourceFile = function(...)
	local _source = source
	SendLog(_source, 'Gracz próbował załadować plik', 'connect2')
end

function containsLink(name)
    if name then
        local pattern = '([%w-_]+://[%w_.%-]+[%w/%?=%.&:_-]+)'
        return string.match(name, pattern) ~= nil
    else
        return false
    end
end

AddEventHandler('playerConnecting', function()
    local _source = source
    local playerName = GetPlayerName(_source)
    local kickReason = 'Znaleziono link w nicku. Zmień nick i spróbuj ponownie.'
	local deferrals = {done = function() end}

    if containsLink(playerName) then
        -- Citizen.Wait(10000)
        exports['non']:ServerDebugPrint({type = "warning", message = 'Gracz ' .. playerName .. ' próbował dołączyć z nickiem zawierającym link. Został wyrzucony.'})
        DropPlayer(_source, kickReason)
        CancelEvent()
        -- deferrals.done("cwel")
        return
    else
        deferrals.done()
    end

    SendLog(_source, string.format('Gracz %s łączy się z serwerem.', playerName), 'connect')
end)

AddEventHandler('playerDropped', function(reason)
	local _source = source
	local crds = GetEntityCoords(GetPlayerPed(_source))
	local playerName = GetPlayerName(_source)
    -- local xPlayer  = ESX.GetPlayerFromId(_source)

    -- local data = {
	-- 	health = Player(xPlayer.source).state.health,
	-- 	armor = Player(xPlayer.source).state.armor
	-- }
	-- MySQL.update.await('UPDATE users SET status = ? WHERE identifier = ?', {json.encode(data), xPlayer.identifier})

	SendLog(_source, 'Gracz ' .. playerName .. ' wychodzi z serwera.\nPowód: ' .. reason, 'disconnect')
end)