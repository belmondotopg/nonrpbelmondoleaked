fx_version 'adamant'

game 'gta5'

lua54 'yes'

description 'ESX Vehicle Shop'

version '1.8.5'

shared_script '@es_extended/imports.lua'

server_scripts {
	'@oxmysql/lib/MySQL.lua',
	'@es_extended/locale.lua',
	'config.lua',
	'server.lua'
}

client_scripts {
	'@non-classes/imports.lua',
	'@es_extended/locale.lua',
	'config.lua',
	'client.lua'
}

dependency 'es_extended'

export 'GeneratePlate'