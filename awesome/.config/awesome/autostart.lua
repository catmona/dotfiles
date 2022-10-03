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
    --"pkill volumeicon",
    "nm-applet",
    "blueman-applet",
    "rfkill block bluetooth",
    "if [[ $(pgrep -c volumeicon) == 0 ]]; then volumeicon &; fi;",
    "if [[ $(pgrep -c volumeicon) == 0 ]]; then volumeicon &; fi;"
    --"volumeicon &"
    --"/usr/lib/polkit-gnome/polkit-gnome-authentication-agent-1",
}

function autostart.autorun()
    if autostart.autorun then
        local app = 1
        gears.timer.start_new(1.5, function()
            awful.spawn.with_shell(autostart.autorunApps[app])
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