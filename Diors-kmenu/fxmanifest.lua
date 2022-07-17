fx_version 'adamant'
games { 'gta5' };

name 'Dior's Combat Menu';
description 'https://discord.gg/KSxpXucPT9'
version '1.0.0'

contributor {
    'Dior',
};

client_scripts {
    "src/RMenu.lua",
    "src/menu/RageUI.lua",
    "src/menu/Menu.lua",
    "src/menu/MenuController.lua",
    "src/components/*.lua",
    "src/menu/elements/*.lua",
    "src/menu/items/*.lua",
    "src/menu/panels/*.lua",
    "src/menu/panels/*.lua",
    "src/menu/windows/*.lua",
}

client_scripts {
    'cl_combat.lua',
}

server_scripts {
    'sv_combat.lua',
}