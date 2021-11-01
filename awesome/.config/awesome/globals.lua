-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- 
-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- 
--                     CATS COOL CONFIG                        --
--                          Globals                            --
-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- 
-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- 

local globals = {
    theme = "pastel.lua",
    terminal = "alacritty",
    editor = os.getenv("EDITOR") or "vim",
    modkey = "Mod4",
    altkey = "Mod1",
    network_manager = "",
    power_manager = "",
    launcher = "rofi -show drun",
    filebrowser = "thunar",
    lock = "",
    screenshot = ""
}

return globals