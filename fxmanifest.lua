fx_version 'cerulean'
game 'gta5'
author 'Magni#0247'
lua54 'yes'

description 'Codem-Garage'
version '1.3'

client_scripts {
    'GetFrameworkObject.lua',
    'config.lua',
	'client/main.lua',
    'client/vehicle_name.lua'
}

server_scripts {
    -- '@mysql-async/lib/MySQL.lua', -- please change
	'@oxmysql/lib/MySQL.lua',
    'GetFrameworkObject.lua',
    'config.lua',
	'server/main.lua'
}

ui_page 'nui/index.html'

files {
    'nui/*.css',
    'nui/index.html',
    'nui/fonts/*.*',
    'nui/images/*.*',
    'nui/images/logo/*.*',
    'nui/images/cars/*.*',
    'nui/*.js'
}

escrow_ignore {
    'GetFrameworkObject.lua',
    'config.lua',
    'client/vehicle_name.lua',
}
