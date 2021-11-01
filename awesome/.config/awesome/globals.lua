-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- 
-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- 
--                     CATS COOL CONFIG                        --
--                          Globals                            --
-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- 
-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- 

local globals = {
    theme = "default/theme.lua",
    terminal = "alacritty",
    editor = os.getenv("EDITOR") or "vim",
    modkey = "Mod4",
    altkey = "mod1",
    network_manager = "",
    power_manager = "",
    launcher = "rofi -show drun",
    filebrowser = "",
    lock = "",
    screenshot = ""
}

return globals