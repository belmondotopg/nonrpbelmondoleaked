fx_version 'cerulean'
game 'gta5'

author 'nonRP'
lua54 'yes'

shared_scripts {
    '@es_extended/imports.lua',
    'routes/**/config.lua'
}

client_scripts {
    'client.lua',
    '@non-classes/imports.lua',
    'routes/**/client.lua'
}

server_scripts {
    '@oxmysql/lib/MySQL.lua',
    'routes/**/server.lua'
}

ui_page 'web/dist/index.html'

files {
    'web/dist/**',
    'web/dist/items/*.png',
}