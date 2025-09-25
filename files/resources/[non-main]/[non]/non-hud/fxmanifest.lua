fx_version 'cerulean'
game 'gta5'
lua54 'yes'

shared_scripts {
    '@es_extended/imports.lua',
    'cfg.lua',
}

client_scripts {
    'routes/**/cl.lua'
}

server_scripts{
    '@oxmysql/lib/MySQL.lua',
    'routes/**/sv.lua'
}

ui_page 'web/web.html'

files {
    'web/**'
}