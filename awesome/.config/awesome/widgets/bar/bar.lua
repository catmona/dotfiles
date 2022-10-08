-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- 
-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- 
--                     CATS COOL CONFIG                        --
--                          Wiibar                             --
-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- 
-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- 


-- ===================================================================
-- Initialization
-- ===================================================================

local awful = require("awful")
local gears = require("gears")

local beautiful = require("beautiful")
local wibox = require("wibox")
local xresources = require("beautiful.xresources")
local dpi = xresources.apply_dpi

-- define module table
local bar = {}

-- ===================================================================
-- Define Widgets
-- ===================================================================

function bar.create()

    -- clock
    mytextclock = wibox.widget.textclock("<span font='Bitstream Vera Sans Mono 13'> %I:%M </span>")
    
    -- tasklist
    local tasklist_buttons = gears.table.join(
        awful.button({ }, 1, function (c)
            if c == client.focus then
                c.minimized = true
            else
                c:emit_signal(
                    "request::activate",
                    "tasklist",
                    {raise = true}
                )
            end
        end),
        awful.button({ }, 3, function()
            awful.menu.client_list({ theme = { width = 250 } })
        end),
        awful.button({ }, 4, function ()
            awful.client.focus.byidx(1)
        end),
        awful.button({ }, 5, function ()
            awful.client.focus.byidx(-1)
        end)
    )
    
    -- ===================================================================
    -- Bar Layouts
    -- ===================================================================
    
    
    awful.screen.connect_for_each_screen(function(s)
        
        -- Taglist
        local taglist = require("widgets/bar/taglist")
        taglist.create(s)

        -- -- Create a tasklist widget
        -- s.mytasklist = awful.widget.tasklist {
        --     screen  = s,
        --     filter  = awful.widget.tasklist.filter.minimizedcurrenttags,
        --     buttons = tasklist_buttons,
        -- }
        
        
        -- ===================================================================
        -- Dash Bar
        -- ===================================================================
    
        
        s.dashbar = awful.wibar({ 
            position = "top", 
            screen = s, 
            bg = beautiful.bg_normal,
            --shape = function(cr,w,h) gears.shape.rounded_rect(cr,w,h, 9) end,
            width = dpi(35),
            height = dpi(35),
        })
                
        s.dashbar:setup {
            widget = wibox.container.margin,
            right = 3,
            {
                widget = wibox.widget.textbox,
                valign = "center",
                align = "center",
                text = "",
                font = "FontAwesome 6 free heavy 13",
                
            }
        }
        
        
        -- ===================================================================
        -- Tag Bar
        -- ===================================================================
    
        
        s.tagbar = awful.wibar({ 
            position = "top", 
            screen = s, 
            bg = beautiful.bg_normal,
            --shape = function(cr,w,h) gears.shape.rounded_rect(cr,w,h, 9) end,
            width = dpi(130),
            height = dpi(35),
        })
                
        s.tagbar:setup {
            layout = wibox.layout.fixed.horizontal,
            wibox.layout.margin(taglist.mytaglist, 3, 0, 2, 0),
            valign = "center",
            halign = "center",
        }
        
        
        -- ===================================================================
        -- Clock Bar
        -- ===================================================================
    
        
        s.clockbar = awful.wibar({
            position = "top", 
            screen = s, 
            bg = beautiful.bg_normal,
            --shape = function(cr,w,h) gears.shape.rounded_rect(cr,w,h, 9) end,
            width = dpi(70),
            height = dpi(35),
        })
        
        s.clockbar:setup {
            layout = wibox.layout.fixed.horizontal,
            mytextclock,
            valign = "center",
            halign = "center",
        }
        
        
        -- ===================================================================
        -- Widget Bar
        -- ===================================================================
    
        
        s.widgetbar = awful.wibar({
            position = "top", 
            screen = s, 
            bg = beautiful.bg_normal,
            --shape = function(cr,w,h) gears.shape.rounded_rect(cr,w,h, 9) end,
            width = dpi(150),
            height = dpi(35),
        })
        
        s.widgetbar:setup {
            layout = wibox.layout.fixed.horizontal,
            wibox.layout.margin(wibox.widget.systray(true), 3, 8, 3, 3),
            valign = "center",
            halign = "center",
        }
        
        
        -- ===================================================================
        -- Dash Bar
        -- ===================================================================
    
        
        s.notifbar = awful.wibar({ 
            position = "top", 
            screen = s, 
            bg = beautiful.bg_normal,
            --shape = function(cr,w,h) gears.shape.rounded_rect(cr,w,h, 9) end,
            width = dpi(35),
            height = dpi(35),
        })
                
        s.notifbar:setup {
            widget = wibox.container.margin,
            right = 3,
            {
                widget = wibox.widget.textbox,
                valign = "center",
                align = "center",
                text = "",
                font = "FontAwesome 6 free heavy 13",
                
            }
        }
        
        
        -- ===================================================================
        -- Placement
        -- ===================================================================
        
        
        -- dashbar placement
        awful.placement.top_left(s.dashbar, {margins = {
            left = beautiful.useless_gap * 2,
            top = beautiful.useless_gap,
        }})
    
        -- tagbar placement
        awful.placement.top_left(s.tagbar, {margins = {
            left = beautiful.useless_gap * 4 + s.dashbar.width,
            top = beautiful.useless_gap,
        }})
        
        -- clockbar placement
        awful.placement.top(s.clockbar, {margins = {
            -- right = beautiful.useless_gap * 2,
            top = beautiful.useless_gap,
        }})
        
        -- widgetbar placement
        awful.placement.top_right(s.widgetbar, {margins = {
            right = beautiful.useless_gap * 4 + s.notifbar.width,
            top = beautiful.useless_gap,
        }})
        
         -- notifbar placement
         awful.placement.top_right(s.notifbar, {margins = {
            right = beautiful.useless_gap * 2,
            top = beautiful.useless_gap,
        }})
        
        
        -- ===================================================================
        -- Reserved Space
        -- ===================================================================
    
        
        s.dashbar:struts{top = s.dashbar.height } --+ beautiful.useless_gap}
        s.tagbar:struts{top = s.tagbar.height } --+ beautiful.useless_gap}
        s.clockbar:struts{top = s.clockbar.height } --+ beautiful.useless_gap}
        s.widgetbar:struts{top = s.widgetbar.height } --+ beautiful.useless_gap}
        s.notifbar:struts{top = s.notifbar.height } --+ beautiful.useless_gap}
        
        
        -- ===================================================================
        -- Widget Signals
        -- ===================================================================
    
        
        s.dashbar:connect_signal("button::press", function() 
            awful.spawn("./bin/dashboard.sh &", false)
        end)
        
        
        
        
        
        -- Add widgets to the wibox
        -- s.mywibox:setup {
        --     {
        --         expand = "none",
        --         layout = wibox.layout.align.horizontal,
        --         { -- Left widgets
        --             -- bg = beautiful.bg_normal,
        --             layout = wibox.layout.fixed.horizontal,
        --             wibox.layout.margin(taglist.mytaglist, 8, 0, 0, 0),
        --             valign = "center",
        --             halign = "center",
        --         },
        --         { -- Center widgets
        --             -- bg = beautiful.bg_normal,
        --             layout = wibox.layout.fixed.horizontal,
        --             mytextclock,
        --             valign = "center",
        --             halign = "center",
        --         },
        --         { -- Right widgets
        --             -- bg = beautiful.bg_normal,
        --             layout = wibox.layout.fixed.horizontal,
        --             -- TODO find a different systray that lets me hide some icons bc this is ugly
        --             wibox.layout.margin(s.mytasklist, 4, 4, 4, 4),
        --             spacing = 5,
        --             wibox.layout.margin(wibox.widget.systray(true), 3, 8, 3, 3),
        --             --wibox.layout.margin(s.mylayoutbox, 2, 2, 2, 2),         
        --             valign = "center",
        --             halign = "center",
        --         },
        --     },
        -- }
        
        -- Add widgets to the wibox
        -- s.mywibox:setup {
        --     top = 10,
        --     left = 10,
        --     right = 10,
        --     color = "#ff00ff00",
        --     widget = wibox.container.margin,
        --     {
        --         widget = wibox.container.background,
        --         bg = beautiful.bg_normal,
        --         shape = function(cr,w,h) gears.shape.rounded_rect(cr,w,h, 9) end,
        --         {
        --             expand = "none",
        --             layout = wibox.layout.align.horizontal,
        --             { -- Left widgets
        --                 layout = wibox.layout.fixed.horizontal,
        --                 wibox.layout.margin(taglist.mytaglist, 8, 0, 0, 0),
        --                 valign = "center",
        --                 halign = "center",
        --             },
        --             { -- Center widgets
        --                 layout = wibox.layout.fixed.horizontal,
        --                 mytextclock,
        --                 valign = "center",
        --                 halign = "center",
        --             },
        --             { -- Right widgets
        --                 layout = wibox.layout.fixed.horizontal,
        --                 -- TODO find a different systray that lets me hide some icons bc this is ugly
        --                 wibox.layout.margin(s.mytasklist, 4, 4, 4, 4),
        --                 spacing = 5,
        --                 wibox.layout.margin(wibox.widget.systray(true), 3, 8, 3, 3),
        --                 --wibox.layout.margin(s.mylayoutbox, 2, 2, 2, 2),         
        --                 valign = "center",
        --                 halign = "center",
        --             },
        --         },
        --     },
        -- }
    end)
end

-- return module table
return bar