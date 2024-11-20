fx_version 'cerulean'
game 'gta5'

author 'CyrusScripts'
description 'Repair Kit Script for QBCore and ox_inventory'
version '1.0.0'

shared_scripts {
    '@ox_lib/init.lua',
    '@qb-core/shared/locale.lua',
    'locales/en.lua',  -- Optional if you want to add localization
}

client_scripts {
    'client/main.lua'
}

server_scripts {
    'server/main.lua'
}

dependencies {
    'qb-core',
    'ox_lib',
    'ox_inventory'
}

lua54 'yes'
