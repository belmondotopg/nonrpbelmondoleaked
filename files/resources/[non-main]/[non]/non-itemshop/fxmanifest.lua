fx_version 'cerulean'
use_experimental_fxv2_oal 'yes'
lua54 'yes'
game 'gta5'

name 'non-itemshop'
author 'MTK x EGZO'
version '2.0.0'

shared_script {
    'config.lua',
    '@es_extended/imports.lua'
}

server_scripts {
    '@oxmysql/lib/MySQL.lua',
    'server/main.lua'
}

client_scripts {
    'client/main.lua'
}

dependencies {
    'es_extended',
}

ui_page {
	'html/index.html',
}

files {
	'html/index.html',
	'html/**/*'
}