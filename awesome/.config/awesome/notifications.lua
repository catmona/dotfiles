-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- 
-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- 
--                     CATS COOL CONFIG                        --
--                       Notifications                         --
-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- 
-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- 


local naughty = require("naughty")
local beautiful = require("beautiful")
local dpi = beautiful.xresources.apply_dpi

local notifications = {}

notifications.settings = {
    spacing = 8,
    padding = 4,
    margin = 8,
    border_width = 2,
    timeout = 5,
    position = "top_right"
}

function notifications.setup()
    naughty.config.spacing = dpi(notifications.settings.spacing)
    naughty.config.padding = dpi(notifications.settings.padding)
    naughty.config.defaults.margin = dpi(notifications.settings.margin)
    naughty.config.defaults.border_width = dpi(notifications.settings.border_width)
    naughty.config.defaults.timeout = notifications.settings.timeout
    naughty.config.defaults.position = notifications.settings.position
end

return notifications