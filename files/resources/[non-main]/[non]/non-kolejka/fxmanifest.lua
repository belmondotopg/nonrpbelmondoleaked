client_script 'client.lua'

server_scripts {
    '@es_extended/imports.lua',
    '@oxmysql/lib/MySQL.lua',
    'adaptivecards.lua',
    'config.js',
    'server.js',
	'config.lua',
    'queue.lua'
}

fx_version "cerulean"
games {"gta5"}
lua54 'yes'

server_exports {
	'GetRocade',
} 