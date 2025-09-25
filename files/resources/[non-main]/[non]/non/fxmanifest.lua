fx_version 'cerulean'
game 'gta5'

lua54 'yes'
this_is_a_map 'yes'
dependency '/assetpacks'

shared_scripts {
	'@es_extended/imports.lua'
}

server_scripts {
	'@oxmysql/lib/MySQL.lua',
	'config.lua',
	'server.lua',
	'scripts/**/server.lua',
}

files {
	'html/*.*',
	'weapons/*.meta',
}

server_exports {
	'ManipulateOrgCwel'
}

ui_page 'html/index.html'
data_file 'WEAPONINFO_FILE_PATCH' 'weapons/*.meta'

client_scripts {
	'@non-classes/imports.lua',
	'config.lua',
	'client.lua',
	'scripts/**/client.lua',
	-- 'scripts/battleroyale/client.lua',
	-- 'scripts/bitki/client.lua',
	-- 'scripts/cardamage/client.lua',
	-- 'scripts/chatsystem/client.lua',
	-- 'scripts/clothing/client.lua',
	-- 'scripts/deposit/client.lua',
	-- 'scripts/drugs/client.lua',
	-- 'scripts/duelki/client.lua',
	-- 'scripts/extras/client.lua',
	-- 'scripts/healer/client.lua',
	-- 'scripts/hudcomponents/client.lua',
	-- 'scripts/items/client.lua',
	-- 'scripts/jobs/client.lua',
	-- 'scripts/kills/client.lua',
	-- 'scripts/limitkishop/client.lua',
	-- 'scripts/menu/client.lua',
	-- 'scripts/nigger/client.lua',
	-- 'scripts/npc/client.lua',
	-- 'scripts/orgs/client.lua',
	-- 'scripts/playerleft/client.lua',
	-- 'scripts/sellcar/client.lua',
	-- 'scripts/selldrugs/client.lua',
	-- 'scripts/shop/client.lua',
	-- 'scripts/strefyORG/client.lua',
	-- 'scripts/weaponcomponents/client.lua',
	-- 'scripts/weaponsync/client.lua',
	-- 'scripts/zones/client.lua',
}