-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- 
-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- 
--                     CATS COOL CONFIG                        --
--                         Autostart                           --
-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- 
-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- 


local awful = require("awful")
local tags = require("tags")
local gears = require("gears")

local autostart = {}

autostart.autorun = true

autostart.autorunApps = {
    --"picom -b",
    "pkill volumeicon",
    "nitrogen --restore &",
    "nm-applet",
    "volumeicon &"
    --"/usr/lib/polkit-gnome/polkit-gnome-authentication-agent-1",
    --"volumeicon",
}

function autostart.autorun()
    if autostart.autorun then
        local app = 1
        gears.timer.start_new(0.5, function()
            awful.spawn.single_instance(autostart.autorunApps[app])
            app = app+1
            if(app > #autostart.autorunApps)
            then 
                return false
            else
                return true
            end
        end)
        
        -- for app = 1, #autostart.autorunApps do
        --     awful.spawn.single_instance(autostart.autorunApps[app])
            
        -- end
    end
end

return autostart