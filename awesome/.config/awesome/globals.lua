-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- 
-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- 
--                     CATS COOL CONFIG                        --
--                          Globals                            --
-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- 
-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- 

local globals = {
    theme = "kitty.lua",
    terminal = "kitty",
    editor = os.getenv("EDITOR") or "vim",
    modkey = "Mod4",
    altkey = "Mod1",
    network_manager = "",
    power_manager = "",
    launcher = "rofi -show drun",
    filebrowser = "pcmanfm",
    lock = "",
    screenshot = "flameshot gui"
}

return globals