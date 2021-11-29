-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- 
-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- 
--                     CATS COOL CONFIG                        --
--                         Autostart                           --
-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- 
-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- 


local awful = require("awful")
local tags = require("tags")

local autostart = {}

autostart.autorun = true

autostart.autorunApps = {
    "picom -b",
    "nitrogen --restore &"
}

function autostart.autorun()
    if autostart.autorun then
        for app = 1, #autostart.autorunApps do
            awful.spawn.single_instance(autostart.autorunApps[app])
        end
    end

    awful.spawn.single_instance("firefox", {tag = tags.tags[3]})
end

return autostart