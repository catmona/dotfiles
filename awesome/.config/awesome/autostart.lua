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
    "nitrogen --restore &",
    "nvidia-settings -a \"[gpu:0]/GpuPowerMizerMode=1\"",
}

function autostart.autorun()
    if autostart.autorun then
        for app = 1, #autostart.autorunApps do
            awful.spawn.single_instance(autostart.autorunApps[app])
        end
    end

    --awful.spawn.once("redshift", {tag = tags.tags[6]})
end

return autostart