-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- 
-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- 
--                     CATS COOL CONFIG                        --
--                         Main File                           --
-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- 
-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- 


-- Standard awesome library
local gears = require("gears")
local awful = require("awful")

-- ===================================================================
-- User Configuration
-- ===================================================================


-- Import globals
local globals = require("globals")

network_interfaces = {
    wlan = 'wlp2s0',
    lan = 'enp3s0'
}


-- ===================================================================
-- Initialization
-- ===================================================================


-- Start notifications
local notifications = require("notifications")
notifications.setup()

-- Autostart apps
local autostart = require("autostart")
autostart.autorun()

-- Start theme
local beautiful = require("beautiful")
beautiful.init(gears.filesystem.get_configuration_dir() .. "themes/" .. globals.theme)
-- beautiful.init(gears.filesystem.get_themes_dir() .. "default/theme.lua")
local dpi = require("beautiful.xresources").apply_dpi

-- Import keybinds
local bindings = require("bindings")
root.keys(bindings.globalkeys)
root.buttons(bindings.desktopbuttons)

-- Import rules
local create_rules = require("rules").create
awful.rules.rules = create_rules(bindings.clientkeys, bindings.clientbuttons)

-- Define layouts
awful.layout.layouts = {
    awful.layout.suit.tile,
    --awful.layout.suit.floating,
    --awful.layout.suit.max
}

-- Import signals
local signals = require("signals")
signals.create()

-- Import tags
local tags = require("tags")
tags.create()

--import bar
local bar = require("widgets/bar/bar")
bar.create()


-- ===================================================================
-- Error Handling
-- ===================================================================


-- Check if awesome encountered an error during startup and fell back to
-- another config (This code will only ever execute for the fallback config)
if awesome.startup_errors then
    naughty.notify({ preset = naughty.config.presets.critical,
                     title = "Oops, there were errors during startup!",
                     text = awesome.startup_errors })
end

-- Handle runtime errors after startup
-- do
--     local in_error = false
--     awesome.connect_signal("debug::error", function (err)
--         -- Make sure we don't go into an endless error loop
--         if in_error then return end
--         in_error = true

--         naughty.notify({ preset = naughty.config.presets.critical,
--                          title = "Oops, an error happened!",
--                          text = tostring(err) })
--         in_error = false
--     end)
-- end


-- ===================================================================
-- Garbage Collection (allows for lower memory consumption)
-- ===================================================================


collectgarbage("setpause", 110)
collectgarbage("setstepmul", 1000)