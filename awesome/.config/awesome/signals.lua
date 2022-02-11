-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- 
-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- 
--                     CATS COOL CONFIG                        --
--                         Signals                             --
-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- 
-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- 


-- ===================================================================
-- Initialization
-- ===================================================================

local awful = require("awful")
local gears = require("gears")

local beautiful = require("beautiful")
local wibox = require("wibox")

-- define module table
local signals = {}

-- ===================================================================
-- Signals
-- ===================================================================

function signals.create() 

    -- Signal function to execute when a new client appears
    client.connect_signal("manage", function (c)
        -- Set the window as a slave (put it at the end of others instead of setting it as master)
        if not awesome.startup then
            awful.client.setslave(c)
        end
    
        if awesome.startup and not c.size_hints.user_position and not c.size_hints.program_position then
            -- Prevent clients from being unreachable after screen count changes.
            awful.placement.no_offscreen(c)
        end
    end)

    -- Signal for rounded corners globally
    if beautiful.rounded_corners then
        client.connect_signal("manage", function (c)
            c.shape = function(cr,w,h)
                gears.shape.rounded_rect(cr,w,h,10)
            end
        end)
    end

    -- Signal to fix fullscreen thing idk
    client.connect_signal("property::fullscreen", function(c)
        if c.fullscreen then
            gears.timer.delayed_call(function()
                if c.valid then
                    c:geometry(c.screen.geometry)
                end
            end)
        end
    end)

    client.connect_signal("manage", function (c)
        -- Some applications (like Spotify) does not respect ICCCM rules correctly
        -- and redefine the window class property.
        -- This leads to having window which does *NOT* follow the user rules
        -- defined in the table `awful.rules.rules`.
        c:connect_signal("property::class", awful.rules.apply)
    
        awful.rules.apply(c)
    end)
    
    client.connect_signal("unmanage", function (c)
        c:disconnect_signal("property::class", awful.rules.apply)
    end)

    


    -- ===================================================================
    -- Titlebar
    -- ===================================================================


    -- Signal for showing titlebars if floating client
    client.connect_signal("property::floating", function(c)
        if c.floating and not c.maximized then
            awful.titlebar.show(c)
        else
            awful.titlebar.hide(c)
        end
    end)

    -- Signal for spawning clients when in floating mode titlebar show/hide
    client.connect_signal("manage", function(c)
        if c.floating or c.first_tag.layout.name == "floating" then
            awful.titlebar.show(c)
        else
            awful.titlebar.hide(c)
        end
    end)

    -- Signal for changing between floating/tiled layouts titlebar show/hide
    tag.connect_signal("property::layout", function(t)
        local clients = t:clients()
        for k,c in pairs(clients) do
            if c.floating or c.first_tag.layout.name == "floating" then
                awful.titlebar.show(c)
            else
                awful.titlebar.hide(c)
            end
        end
    end)

    -- Add a titlebar if titlebars_enabled is set to true in the rules.
    client.connect_signal("request::titlebars", function(c)
        -- buttons for the titlebar
        local buttons = gears.table.join(
            awful.button({ }, 1, function()
                c:emit_signal("request::activate", "titlebar", {raise = true})
                awful.mouse.client.move(c)
            end),
            awful.button({ }, 3, function()
                c:emit_signal("request::activate", "titlebar", {raise = true})
                awful.mouse.client.resize(c)
            end)
        )

        awful.titlebar(c) : setup {
            { -- Left
                awful.titlebar.widget.iconwidget(c),
                buttons = buttons,
                layout  = wibox.layout.fixed.horizontal
            },
            { -- Middle
                { -- Title
                    align  = "center",
                    widget = awful.titlebar.widget.titlewidget(c)
                },
                buttons = buttons,
                layout  = wibox.layout.flex.horizontal
            },
            { -- Right
                awful.titlebar.widget.floatingbutton (c),
                awful.titlebar.widget.maximizedbutton(c),
                awful.titlebar.widget.stickybutton   (c),
                awful.titlebar.widget.ontopbutton    (c),
                awful.titlebar.widget.closebutton    (c),
                layout = wibox.layout.fixed.horizontal()
            },
            layout = wibox.layout.align.horizontal
        }
    end)


    -- ===================================================================
    -- Layout Specific
    -- ===================================================================

    
    -- remove gaps if layout is set to 'max'
    -- tag.connect_signal('property::layout', function(t)
    --     local current_layout = awful.tag.getproperty(t, 'layout')
    --     if (current_layout == awful.layout.suit.max) then
    --         t.gap = 0
    --     else
    --         t.gap = beautiful.useless_gap
    --     end
    -- end)


    -- ===================================================================
    -- Client Focusing
    -- ===================================================================


    -- Autofocus a new client when previously focused one is closed
    require("awful.autofocus")

    -- Focus clients under mouse
    client.connect_signal("mouse::enter", function(c)
        c:emit_signal("request::activate", "mouse_enter", {raise = false})
    end)

    -- signals for showing active windows
    client.connect_signal("focus", function(c) c.border_color = beautiful.border_focus end)
    client.connect_signal("unfocus", function(c) c.border_color = beautiful.border_normal end)

    -- Signal for hiding titlebars if maximized client
    client.connect_signal("property::maximized", function(c)
        if c.maximized then
            c.border_width = 0
        else
            c.border_width = beautiful.border_width
        end
    end)


    -- ===================================================================
    -- Screen Change Signals (ie multi monitor)
    -- ===================================================================

    
    -- Reload config when screen geometry changes
    screen.connect_signal("property::geometry", awesome.restart)

end

-- return module table
return signals