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

local wibox = require("wibox")
local beautiful = require("beautiful")
local xresources = require("beautiful.xresources")
local dpi = xresources.apply_dpi

local vicious = require("vicious")

-- define module table
local bar = {}

-- ===================================================================
-- Define Widgets
-- ===================================================================

function bar.create()

    -- clock
    mytextclock = wibox.widget.textclock("<span font='Bitstream Vera Sans Mono 13'> %I:%M </span>")
    
    -- calendar
    local calendar = awful.widget.calendar_popup.month({
        spacing = 8,
        margin = 12,
        font = "monospace 11",
        style_month = {
            padding = 5,
            border_width = 3,
        },
        style_header = {
            markup = "<b>%s</b>",
            fg_color = beautiful.volicon,
        },
        style_normal = {
            shape = function(cr,w,h) gears.shape.rounded_rect(cr,w,h, 9) end,
        },
        style_focus = {
            fg_color = beautiful.fg_urgent,
            shape = function(cr,w,h) gears.shape.rounded_rect(cr,w,h, 9) end,
            markup = function(t) return "<b>" .. t .. "</b>" end,
            
        },
        style_weekday = {
            shape = function(cr,w,h) gears.shape.rounded_rect(cr,w,h, 9) end,
            markup = function(t) return "<b>" .. t .. "</b>" end,
            fg_color = beautiful.wificon,
        }
    })
    
    calendar:attach(mytextclock, "tr")
    
    -- battery
    bat = wibox.widget.textbox()
    batslide = wibox.widget.textbox()
    
    battery = wibox.widget {
        layout = wibox.layout.fixed.horizontal,
        {
            widget = batslide,
            text = "65%",
            visible = false,
            font = "bitstream vera sans mono 13",
        },
        {
            widget = wibox.widget.background,
            valign = "center",
            align = "center",
            fg = beautiful.baticon,
            {
                widget = bat,
                text = "temp",
                font = "icomoon feather regular 13",
                
            }
        }
    }
    
    
    
    vicious.register (
        bat,
        vicious.widgets.bat,
        function(widget, args) 
            if args[2] <= 10 then
                return ""
            elseif args[2] <= 30 then
                return ""
            elseif args[2] <= 60 then
                return ""
            elseif args[2] <= 90 then
                return ""
            else
                return ""
            end
        end,
        20,
        "BAT1"
    )
    
    -- wifi
    wificon = wibox.widget {
        widget = wibox.widget.background,
        valign = "center",
        align = "center",
        fg = beautiful.wificon,
        {
            widget = wibox.widget.textbox,
            text = "",
            font = "icomoon feather regular 13",
        }
    }
    
    -- local network = lain.widget.net ({
        
    -- })
    
    -- volume
    volicon = wibox.widget {
        widget = wibox.widget.background,
        valign = "center",
        align = "center",
        fg = beautiful.volicon,
        {
            widget = wibox.widget.textbox,
            text = "",
            font = "icomoon feather regular 13",
        }
    }
    
    -- local volume = lain.widget.pulsebar({
        
    -- })
    
    
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
            bg = beautiful.taglist_fg_focus,
            --fg = beautiful.bg_normal,
            --shape = function(cr,w,h) gears.shape.rounded_rect(cr,w,h, 9) end,
            width = dpi(35),
            height = dpi(35),
            cursor = "hand1",
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
    
        
        s.widgetbar = awful.popup({
            position = "top", 
            preferred_positions = "left",
            preferred_anchors = "middle",
            screen = s, 
            bg = beautiful.bg_normal,
            --shape = function(cr,w,h) gears.shape.rounded_rect(cr,w,h, 9) end,
            width = dpi(100),
            height = dpi(35),
            widget = {
                forced_height = dpi(35),
                layout = wibox.layout.align.horizontal,
                valign = "center",
                align = "right",
                wibox.layout.margin(volicon, 11, 8, 3, 3),
                wibox.layout.margin(wificon, 3, 8, 3, 3),
                wibox.layout.margin(battery, 3, 8, 3, 3),
            }
        })

        
        -- ===================================================================
        -- Placement
        -- ===================================================================
        
        
        -- dashbar placement
        awful.placement.top_left(s.dashbar, {margins = {
            left = beautiful.useless_gap * 2,
            top = beautiful.useless_gap,
        }})
        
        s.dashbar:struts{top = s.dashbar.height } --+ beautiful.useless_gap}
    
        -- tagbar placement
        awful.placement.top_left(s.tagbar, {margins = {
            left = beautiful.useless_gap * 4 + s.dashbar.width,
            top = beautiful.useless_gap,
        }})
        
        s.tagbar:struts{top = s.tagbar.height } --+ beautiful.useless_gap}
        
        -- clockbar placement
        awful.placement.top_right(s.clockbar, {margins = {
            right = beautiful.useless_gap * 2,
            top = beautiful.useless_gap,
        }})
        
        s.clockbar:struts{top = s.clockbar.height } --+ beautiful.useless_gap}
        
        function widgplace()
            -- widgetbar placement
            awful.placement.top_right(s.widgetbar, {margins = {
                right = beautiful.useless_gap * 4 + s.clockbar.width,
                top = beautiful.useless_gap,
            }})
            
            s.widgetbar:struts{top = s.widgetbar.height } --+ beautiful.useless_gap}
        end
        
        widgplace()
    
        
        -- ===================================================================
        -- Widget Signals
        -- ===================================================================
    
        
        -- dashboard signals
        s.dashbar:connect_signal("button::press", function() 
            awful.spawn("./bin/dashboard.sh &", false)
        end)
        
        -- s.dashbar:connect_signal("mouse::enter", function ()

        -- end)
        
        -- s.dashbar:connect_signal("mouse::leave", function ()

        -- end)
        
        
        -- taglist signals
        taglist.mytaglist:connect_signal("tag_updated", function()
            s.dashbar.bg = beautiful.taglist_fg_focus
        end)
        
        
        -- battery signals
        battery:connect_signal("button::press", function() 
           awful.spawn("xfce4-power-manager -c", false)
        end)
        
        battery:connect_signal("mouse::enter", function ()
            --widgetbarwidth.target = dpi(150)
            batslide.text = vicious.call(vicious.widgets.bat, "$2", "BAT1")
            -- s.widgetbar.width = dpi(110)
            batslide.visible = true
        end)
        
        battery:connect_signal("mouse::leave", function ()
            --widgetbarwidth.target = dpi(100)
            -- s.widgetbar.width = dpi(100)
            batslide.visible = false
        end)
        
        
        -- wifi signals
        wificon:connect_signal("button::press", function() 
            awful.spawn("xfce4-power-manager -c", false)
         end)
         
         
         
         -- volume signals
         volicon:connect_signal("button::press", function() 
            awful.spawn("xfce4-power-manager -c", false)
         end)
         
         
        
    end)
end

-- return module table
return bar