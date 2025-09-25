fx_version 'adamant'

game 'gta5'

description 'ESX Police Job'
lua54 'yes'
version '1.8.5'

shared_script '@es_extended/imports.lua'

server_scripts {
	'@oxmysql/lib/MySQL.lua',
	'@es_extended/locale.lua',
	'locales/*.lua',
	'config.lua',
	'server/main.lua'
}

client_scripts {
	'@es_extended/locale.lua',
	'locales/*.lua',
	'config.lua',
	'client/main.lua',
	'client/vehicle.lua'
}

files {
    'duty_hours.json'
}

dependencies {
	'es_extended',
	'non-vehicleshop'
}

export 'SetCanSearch'

server_exports {
	'GetLoot',
	'SetLoot'
}