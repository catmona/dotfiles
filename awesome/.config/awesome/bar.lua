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

    -- local tasklist_buttons = gears.table.join(
    --                     awful.button({ }, 1, function (c)
    --                                             if c == client.focus then
    --                                                 c.minimized = true
    --                                             else
    --                                                 c:emit_signal(
    --                                                     "request::activate",
    --                                                     "tasklist",
    --                                                     {raise = true}
    --                                                 )
    --                                             end
    --                                         end),
    --                     awful.button({ }, 3, function()
    --                                             awful.menu.client_list({ theme = { width = 250 } })
    --                                         end),
    --                     awful.button({ }, 4, function ()
    --                                             awful.client.focus.byidx(1)
    --                                         end),
    --                     awful.button({ }, 5, function ()
    --                                             awful.client.focus.byidx(-1)
    --                                         end))

    awful.screen.connect_for_each_screen(function(s)
        -- Create an imagebox widget which will contain an icon indicating which layout we're using.
        -- We need one layoutbox per screen.
        s.mylayoutbox = awful.widget.layoutbox(s)

        s.mylayoutbox:buttons(gears.table.join(
                            awful.button({ }, 1, function () awful.layout.inc( 1) end),
                            awful.button({ }, 3, function () awful.layout.inc(-1) end),
                            awful.button({ }, 4, function () awful.layout.inc( 1) end),
                            awful.button({ }, 5, function () awful.layout.inc(-1) end)))

        -- Create a taglist widget
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
                                widget = wibox.widget.textbox
                            },
                            left = 6.5,
                            right = 6.5,
                            top = 4,
                            bottom = 3,
                            widget = wibox.container.margin
                        },
                        {
                            {
                                left = 7,
                                right = 7,
                                top = 1.6,
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
                        self:get_children_by_id("overline")[1].bg = beautiful.fg_focus
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
                        self:get_children_by_id("overline")[1].bg = beautiful.fg_focus
                    else 
                        self:get_children_by_id("overline")[1].bg = beautiful.bg_normal
                    end
                end
            },
        }

        -- -- Create a tasklist widget
        -- s.mytasklist = awful.widget.tasklist {
        --     screen  = s,
        --     filter  = awful.widget.tasklist.filter.currenttags,
        --     buttons = tasklist_buttons
        -- }

        -- Create the wibox
        s.mywibox = awful.wibar({ position = "top", screen = s })

        -- Add widgets to the wibox
        s.mywibox:setup {
            expand = "none",
            layout = wibox.layout.align.horizontal,
            { -- Left widgets
                layout = wibox.layout.fixed.horizontal,
                s.mytaglist,
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
                --wibox.layout.margin(wibox.widget.systray(), 3, 3, 3, 3),
                wibox.layout.margin(s.mylayoutbox, 2, 2, 2, 2),
            }
        }
    end)
end

-- return module table
return bar