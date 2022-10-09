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
    baticon = wibox.widget {
        widget = wibox.widget.background,
        valign = "center",
        align = "center",
        fg = beautiful.baticon,
        {
            widget = wibox.widget.textbox,
            text = "",
            font = "icomoon feather regular 13",
        }
    }
    
    -- local battery = modules.lain.widget.bat ({
    --     settings = function()
            
    --     end
    -- })
    
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
    
        
        s.widgetbar = awful.wibar({
            position = "top", 
            screen = s, 
            bg = beautiful.bg_normal,
            --shape = function(cr,w,h) gears.shape.rounded_rect(cr,w,h, 9) end,
            width = dpi(95),
            height = dpi(35),
        })
        
        s.widgetbar:setup {
            layout = wibox.layout.fixed.horizontal,
            valign = "center",
            align = "center",
            wibox.layout.margin(volicon, 11, 8, 3, 3),
            wibox.layout.margin(wificon, 3, 8, 3, 3),
            wibox.layout.margin(baticon, 3, 8, 3, 3),
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
        awful.placement.top_right(s.clockbar, {margins = {
            right = beautiful.useless_gap * 2,
            top = beautiful.useless_gap,
        }})
        
        -- widgetbar placement
        awful.placement.top_right(s.widgetbar, {margins = {
            right = beautiful.useless_gap * 4 + s.clockbar.width,
            top = beautiful.useless_gap,
        }})
        
        
        -- ===================================================================
        -- Reserved Space
        -- ===================================================================
    
        
        s.dashbar:struts{top = s.dashbar.height } --+ beautiful.useless_gap}
        s.tagbar:struts{top = s.tagbar.height } --+ beautiful.useless_gap}
        s.clockbar:struts{top = s.clockbar.height } --+ beautiful.useless_gap}
        s.widgetbar:struts{top = s.widgetbar.height } --+ beautiful.useless_gap}
        
        
        -- ===================================================================
        -- Widget Signals
        -- ===================================================================
    
        
        s.dashbar:connect_signal("button::press", function() 
            awful.spawn("./bin/dashboard.sh &", false)
        end)
        
        
        -- s.dashbar:connect_signal("mouse::enter", function ()

        -- end)
        
        -- s.dashbar:connect_signal("mouse::leave", function ()

        -- end)
        
        
        taglist.mytaglist:connect_signal("tag_updated", function()
            s.dashbar.bg = beautiful.taglist_fg_focus
        end)
        
        baticon:connect_signal("button::press", function() 
           awful.spawn("xfce4-power-manager -c", false)
        end)

        
    end)
end

-- return module table
return bar