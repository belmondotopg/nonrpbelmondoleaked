fx_version 'cerulean'
game 'gta5'

shared_script '@es_extended/imports.lua'

client_scripts {
    '@non-classes/imports.lua',
    'config.lua',
    'client.lua',
}

server_scripts {
    '@oxmysql/lib/MySQL.lua',
    'server.lua'
}

ui_page 'web/build/index.html'

files {
    'web/build/**'
}