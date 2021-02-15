fx_version 'adamant'

games {'gta5'}

description 'ESX Job Manager'
author 'GIMI'
version '1.2.1'

server_scripts {
	'@mysql-async/lib/MySQL.lua',
	'@es_extended/locale.lua',
	'locales/cs.lua',
	'config.lua',
	'server/main.lua'
}

client_scripts {
	'@es_extended/locale.lua',
	'locales/cs.lua',
	'config.lua',
	'client/main.lua',
	'client/functions.lua',
	'client/markers.lua',
	'client/menu.lua'
}

dependencies {
	'es_extended',
	'esx_billing',
	'esx_society'
}