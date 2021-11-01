-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- 
-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- 
--                     CATS COOL CONFIG                        --
--                         Autostart                           --
-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- 
-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- 


local awful = require("awful")

local autostart = {}

autostart.autorun = true

autostart.autorunApps = {
    "compton",
    "nitrogen --restore"
}

function autostart.autorun()
    if autostart.autorun then
        for app = 1, #autostart.autorunApps do
            awful.spawn.single_instance(autostart.autorunApps[app])
        end
    end
end

return autostart