-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- 
-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- 
--                     CATS COOL CONFIG                        --
--                          Globals                            --
-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- 
-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- 

local globals = {
    theme = "dork.lua",
    terminal = "kitty",
    editor = os.getenv("EDITOR") or "nano",
    modkey = "Mod4",
    altkey = "Mod1",
    network_manager = "",
    power_manager = "",
    launcher = "rofi -show drun",
    filebrowser = "pcmanfm",
    lock = "betterlockscreen --lock &",
    quit_menu = "archlinux-logout &",
    screenshot = "flameshot gui"
}

return globals