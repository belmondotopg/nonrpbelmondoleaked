shared_script "@esx_menu_deafult/shared/shared.lua"



fx_version 'adamant'
game 'gta5'

lua54 'yes'

server_scripts {
	'@async/async.lua',
	--'@mysql-async/lib/MySQL.lua',
	'@oxmysql/lib/MySQL.lua',
	'server/*.lua',
	'config.lua'
}

client_scripts {
	'config.lua',
	'client/*.lua'
}

files {
	'client/web/*.html',
	'client/web/css/*.css',
	'client/web/img/*.png',
	'client/web/img/*.gif',
	'client/web/js/*.js'
}

ui_page 'client/web/index.html'

