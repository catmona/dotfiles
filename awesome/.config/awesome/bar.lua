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
local menubar = require("menubar")

-- define module table
local bar = {}

-- ===================================================================
-- Bar
-- ===================================================================

function bar.create()

    -- -- Menubar configuration
    -- menubar.utils.terminal = terminal -- Set the terminal for applications that require it
    -- -- }}}

    -- -- Keyboard map indicator and switcher
    -- mykeyboardlayout = awful.widget.keyboardlayout()

    -- {{{ Wibar
    -- Create a textclock widget
    mytextclock = wibox.widget.textclock(" %a %b %d, %I:%M ")

    -- Create a wibox for each screen and add it
    local taglist_buttons = gears.table.join(
        awful.button({ }, 1, function(t) t:view_only() end),
        awful.button({ modkey }, 1, function(t)
            if client.focus then
                client.focus:move_to_tag(t)
            end
        end),
        awful.button({ }, 3, awful.tag.viewtoggle),
        awful.button({ modkey }, 3, function(t)
            if client.focus then
                client.focus:toggle_tag(t)
            end
        end),
        awful.button({ }, 4, function(t) awful.tag.viewnext(t.screen) end),
        awful.button({ }, 5, function(t) awful.tag.viewprev(t.screen) end)
    )
    
    -- Tasklist
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

    awful.screen.connect_for_each_screen(function(s)
        -- Create an imagebox widget which will contain an icon indicating which layout we're using.
        -- We need one layoutbox per screen.
        s.mylayoutbox = awful.widget.layoutbox(s)

        s.mylayoutbox:buttons(gears.table.join(
                            awful.button({ }, 1, function () awful.layout.inc( 1) end),
                            awful.button({ }, 3, function () awful.layout.inc(-1) end),
                            awful.button({ }, 4, function () awful.layout.inc( 1) end),
                            awful.button({ }, 5, function () awful.layout.inc(-1) end)))

        -- Taglist
        s.mytaglist = awful.widget.taglist {
            screen  = s,
            filter  = awful.widget.taglist.filter.all,
            buttons = taglist_buttons,
            widget_template = {
                {
                    {
                        layout = wibox.layout.fixed.vertical,
                        {
                            {
                                id = 'text_role',
                                widget = wibox.widget.textbox,
                            },
                            left = 6.5,
                            right = 6.5,
                            top = 5,
                            bottom = 1,
                            widget = wibox.container.margin
                        },
                        {
                            {
                                top = 2.5, -- size of underline
                                widget = wibox.container.margin
                            },
                            id = 'overline',
                            bg = '#ffffff',
                            shape = gears.shape.rectangle,
                            widget = wibox.container.background
                        },
                    },
                    left = 1,
                    right = 1,
                    widget = wibox.container.margin
                },
                id = 'background_role',
                widget = wibox.container.background,
                shape = gears.shape.rectangle,
                
                create_callback = function(self, c3, index, objects)
                    local focused = false
                    for _, x in pairs(awful.screen.focused().selected_tags) do
                        if x.index == index then
                            focused = true
                            break
                        end
                    end
                    
                    if focused then
                        beautiful.taglist_fg_focus = beautiful.workspace_colors[index]
                        self:get_children_by_id("overline")[1].bg = beautiful.taglist_fg_focus
                    else 
                        self:get_children_by_id("overline")[1].bg = beautiful.bg_normal
                    end
                end,
                
                update_callback = function(self, c3, index, objects)
                    local focused = false
                    for _, x in pairs(awful.screen.focused().selected_tags) do
                        if x.index == index then
                            focused = true
                            break
                        end
                    end
                    
                    if focused then
                        beautiful.taglist_fg_focus = beautiful.workspace_colors[index]
                        self:get_children_by_id("overline")[1].bg = beautiful.taglist_fg_focus
                    else 
                        self:get_children_by_id("overline")[1].bg = beautiful.bg_normal
                    end
                end
            },
        }

        -- Create a tasklist widget
        s.mytasklist = awful.widget.tasklist {
            screen  = s,
            filter  = awful.widget.tasklist.filter.minimizedcurrenttags,
            buttons = tasklist_buttons,
        }

        -- Create the wibox
        s.mywibox = awful.wibar({ position = "top", screen = s, bg = "#ffffff00"})

        -- Add widgets to the wibox
        s.mywibox:setup {
            top = 10,
            left = 10,
            right = 10,
            color = "#ff00ff00",
            widget = wibox.container.margin,
            {
                widget = wibox.container.background,
                bg = beautiful.bg_normal,
                shape = function(cr,w,h) gears.shape.rounded_rect(cr,w,h, 9) end,
                {
                    expand = "none",
                    layout = wibox.layout.align.horizontal,
                    { -- Left widgets
                        layout = wibox.layout.fixed.horizontal,
                        wibox.layout.margin(s.mytaglist, 8, 0, 0, 0),
                        valign = "center",
                        halign = "center",
                    },
                    { -- Center widgets
                        layout = wibox.layout.fixed.horizontal,
                        mytextclock,
                        valign = "center",
                        halign = "center",
                    },
                    { -- Right widgets
                        layout = wibox.layout.fixed.horizontal,
                        -- TODO find a different systray that lets me hide some icons bc this is ugly
                        wibox.layout.margin(s.mytasklist, 4, 4, 4, 4),
                        spacing = 5,
                        wibox.layout.margin(wibox.widget.systray(true), 3, 8, 3, 3),
                        --wibox.layout.margin(s.mylayoutbox, 2, 2, 2, 2),         
                        valign = "center",
                        halign = "center",
                    },
                },
            },
        }
    end)
end

-- return module table
return bar