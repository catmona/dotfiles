-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- 
-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- 
--                     CATS COOL CONFIG                        --
--                        Keybindings                          --
-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- 
-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- 


-- ===================================================================
-- Initialization
-- ===================================================================

-- import standard modules
local awful = require("awful")
local gears = require("gears")
local naughty = require("naughty")
local beautiful = require("beautiful")
local dpi = beautiful.xresources.apply_dpi
local menubar = require("menubar")
local hotkeys_popup = require("awful.hotkeys_popup")
-- Enable hotkeys help widget for VIM and other apps
-- when client with a matching name is opened:
require("awful.hotkeys_popup.keys")

-- import user modules
local globals = require("globals")
local modkey = globals.modkey
local altkey = globals.altkey

local tags = require("tags")
local sharedtags = require("sharedtags")

-- define module table
local bindings = {}

-- forces client to current tag
local function spawn_here(cmd)
    awful.spawn(cmd, {
        tag = mouse.screen.selected_tag,
    })
end


-- ===================================================================
-- Movement Functions 
-- ===================================================================


-- Move given client to given direction
local function move_client(c, direction)
    -- If client is floating, move to edge
    if c.floating or (awful.layout.get(mouse.screen) == awful.layout.suit.floating) then
        local workarea = awful.screen.focused().workarea
        if direction == "up" then
            c:geometry({nil, y = workarea.y + beautiful.useless_gap * 2, nil, nil})
        elseif direction == "down" then
            c:geometry({nil, y = workarea.height + workarea.y - c:geometry().height - beautiful.useless_gap * 2 - beautiful.border_width * 2, nil, nil})
        elseif direction == "left" then
            c:geometry({x = workarea.x + beautiful.useless_gap * 2, nil, nil, nil})
        elseif direction == "right" then
            c:geometry({x = workarea.width + workarea.x - c:geometry().width - beautiful.useless_gap * 2 - beautiful.border_width * 2, nil, nil, nil})
        end
    -- Otherwise swap the client in the tiled layout
    elseif awful.layout.get(mouse.screen) == awful.layout.suit.max then
        if direction == "up" or direction == "left" then
            awful.client.swap.byidx(-1, c)
        elseif direction == "down" or direction == "right" then
            awful.client.swap.byidx(1, c)
        end
    else
        awful.client.swap.bydirection(direction, c, nil)
    end
end


-- Resize client in given direction
local floating_resize_amount = dpi(20)
local tiling_resize_factor = 0.05

local function resize_client(c, direction)
   if awful.layout.get(mouse.screen) == awful.layout.suit.floating or (c and c.floating) then
        if direction == "up" then
            c:relative_move(0, 0, 0, -floating_resize_amount)
        elseif direction == "down" then
            c:relative_move(0, 0, 0, floating_resize_amount)
        elseif direction == "left" then
            c:relative_move(0, 0, -floating_resize_amount, 0)
        elseif direction == "right" then
            c:relative_move(0, 0, floating_resize_amount, 0)
      end
   else
        if direction == "up" then
            awful.client.incwfact(-tiling_resize_factor)
        elseif direction == "down" then
            awful.client.incwfact(tiling_resize_factor)
        elseif direction == "left" then
            awful.tag.incmwfact(-tiling_resize_factor)
        elseif direction == "right" then
            awful.tag.incmwfact(tiling_resize_factor)
        end
   end
end


-- raise focused client
local function raise_client()
   if client.focus then
      client.focus:raise()
   end
end


-- ===================================================================
-- Mouse bindings
-- ===================================================================


-- mouse buttons on the desktop
bindings.desktopbuttons = gears.table.join(
    -- left click on desktop to hide notification
    awful.button({}, 1,
    function ()
       naughty.destroy_all_notifications()
    end
 )
)

-- mouse buttons on the client
bindings.clientbuttons = gears.table.join(
   -- Raise client
   awful.button({}, 1,
      function(c)
         client.focus = c
         c:raise()
      end
   ),

   -- Move and Resize Client
   awful.button({modkey}, 1, awful.mouse.client.move),
   awful.button({modkey}, 3, awful.mouse.client.resize)
)


-- ===================================================================
-- Desktop Key bindings
-- ===================================================================


bindings.globalkeys = gears.table.join(

    -- =========================================
    -- SPAWN APPLICATION KEY BINDINGS
    -- =========================================

    -- launch terminal
    awful.key({modkey}, "Return",
        function()
            awful.spawn(globals.terminal)
        end,
        {description = "open a terminal", group = "launcher"}
    ),

   -- launch rofi
    awful.key({modkey}, "a",
        function()
            awful.spawn(globals.launcher)
        end,
        {description = "application launcher", group = "launcher"}
    ),

    -- launch file search
    awful.key({modkey}, "i",
        function()
            awful.spawn("./bin/rofi-finder /")
        end,
        {description = "file opener", group = "launcher"}
    ),

    -- launch config search
    awful.key({modkey, "Shift"}, "i",
        function()
            awful.spawn("./bin/rofi-finder dotfiles code")
        end,
        {description = "config opener", group = "launcher"}
    ),

    -- launch firefox
    awful.key({modkey}, "w",
        function()
            spawn_here("env MOZ_USE_XINPUT2=1 firefox")
        end,
        {description = "open firefox", group = "launcher"}
    ),
    
    -- search bookmarks
    awful.key({modkey, "Shift"}, "w",
        function()
            awful.spawn("rofi -show firefox_bookmarks -modi firefox_bookmarks:~/bin/rofi-firefox-bookmarks.sh")
        end,
        {description = "browse bookmarks", group = "launcher"}
    ),

    -- launch discord
    awful.key({modkey}, "d",
        function()
            awful.spawn("discord")
        end,
        {description = "open discord", group = "launcher"}
    ),

    -- launch spotify
    awful.key({modkey}, "s",
        function()
            awful.spawn("spotify")
        end,
        {description = "open spotify", group = "launcher"}
    ),

    -- launch file browser
    awful.key({modkey}, "f",
        function()
            awful.spawn(globals.filebrowser)
        end,
        {description = "open filebrowser", group = "launcher"}
    ),

    -- launch vscode
    awful.key({modkey}, "c",
        function()
            spawn_here("code")
        end,
        {description = "open vscode", group = "launcher"}
    ),

    -- launch steam
    awful.key({modkey}, "g",
        function()
            awful.spawn("steam")
        end,
        {description = "open steam", group = "launcher"}
    ),

    -- launch rofi todo-list
    awful.key({modkey}, "t",
        function()
            awful.spawn("rofi -show TODO -modi TODO:~/bin/rofi-todo.sh")
        end,
        {description = "open todo-list", group = "launcher"}
    ),



    -- =========================================
    -- FUNCTION KEYS
    -- =========================================

    -- Brightness
    awful.key({}, "XF86MonBrightnessUp",
        function()
            awful.spawn("xbacklight -inc 10", false)
        end,
        {description = "+10%", group = "hotkeys"}
    ),
    awful.key({}, "XF86MonBrightnessDown",
        function()
            awful.spawn("xbacklight -dec 10", false)
        end,
        {description = "-10%", group = "hotkeys"}
    ),

    -- ALSA volume control
    awful.key({}, "XF86AudioRaiseVolume",
        function()
            awful.spawn("amixer -D pulse sset Master 5%+", false)
            awesome.emit_signal("volume_change")
        end,
        {description = "volume up", group = "hotkeys"}
    ),
    awful.key({}, "XF86AudioLowerVolume",
        function()
            awful.spawn("amixer -D pulse sset Master 5%-", false)
            awesome.emit_signal("volume_change")
        end,
        {description = "volume down", group = "hotkeys"}
    ),
    awful.key({}, "XF86AudioMute",
        function()
            awful.spawn("amixer -D pulse set Master 1+ toggle", false)
            awesome.emit_signal("volume_change")
        end,
        {description = "toggle mute", group = "hotkeys"}
    ),
    awful.key({}, "XF86AudioNext",
        function()
            awful.spawn("mpc next", false)
        end,
        {description = "next music", group = "hotkeys"}
    ),
    awful.key({}, "XF86AudioPrev",
        function()
            awful.spawn("mpc prev", false)
        end,
        {description = "previous music", group = "hotkeys"}
    ),
    awful.key({}, "XF86AudioPlay",
        function()
            awful.spawn("mpc toggle", false)
        end,
        {description = "play/pause music", group = "hotkeys"}
    ),

    -- Screenshot
    awful.key({modkey, "Shift"}, "s",
        function()
            awful.util.spawn(globals.screenshot, false)
        end,
        {description = "screenshot", group = "hotkeys"}
    ),

    -- =========================================
    -- AWESOME
    -- =========================================

    -- Show keybindings
    awful.key({modkey}, "/",
        hotkeys_popup.show_help,
        {description = "show help", group = "awesome"}
    ),

    -- Reload Awesome
    awful.key({modkey, "Control"}, "r",
        awesome.restart,
        {description = "reload awesome", group = "awesome"}
    ),

    -- Quit Awesome
    awful.key({modkey, "Shift"}, "q",
        function()
            -- emit signal to show the exit screen
            -- awesome.emit_signal("show_exit_screen")
            awful.spawn.single_instance(globals.quit_menu)
        end,
        {description = "toggle exit screen", group = "hotkeys"}
    ),

    awful.key({}, "XF86PowerOff",
        function()
            naughty.notify({
                title = "Test Title",
                text = "test body",
            })
            awful.spawn.single_instance(globals.lock)
        end,
        {description = "lock screen", group = "hotkeys"}
    ),

    awful.key({ modkey, "Shift"   }, "t", function ()
        --[[ local notif_icon = gears.surface.load_uncached(
                           gears.filesystem.get_configuration_dir() .. "path/to/icon") ]]
        naughty.notify({
            title = "Test Title",
            text = "Test Notificationnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnsssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssss",
        })
        end,
        {description = "send test notification", group = "awesome"}
    ),

    -- =========================================
    -- CLIENT FOCUSING
    -- =========================================

    -- Focus client by direction (hjkl keys)
    awful.key({modkey}, "j",
        function()
            awful.client.focus.bydirection("down")
            raise_client()
        end,
        {description = "focus down", group = "client"}
    ),
    awful.key({modkey}, "k",
        function()
            awful.client.focus.bydirection("up")
            raise_client()
        end,
        {description = "focus up", group = "client"}
    ),
    awful.key({modkey}, "h",
        function()
            awful.client.focus.bydirection("left")
            raise_client()
        end,
        {description = "focus left", group = "client"}
    ),
    awful.key({modkey}, "l",
        function()
            awful.client.focus.bydirection("right")
            raise_client()
        end,
        {description = "focus right", group = "client"}
    ),

    -- Focus client by direction (arrow keys)
    awful.key({modkey}, "Down",
        function()
            awful.client.focus.bydirection("down")
            raise_client()
        end,
        {description = "focus down", group = "client"}
    ),
    awful.key({modkey}, "Up",
        function()
            awful.client.focus.bydirection("up")
            raise_client()
        end,
        {description = "focus up", group = "client"}
    ),
    awful.key({modkey}, "Left",
        function()
            awful.client.focus.bydirection("left")
            raise_client()
        end,
        {description = "focus left", group = "client"}
    ),
    awful.key({modkey}, "Right",
        function()
            awful.client.focus.bydirection("right")
            raise_client()
        end,
        {description = "focus right", group = "client"}
    ),

    -- Focus client by index (cycle through clients)
    awful.key({modkey}, "Tab",
        function()
            awful.client.focus.byidx(1)
        end,
        {description = "focus next by index", group = "client"}
    ),
    awful.key({modkey, "Shift"}, "Tab",
        function()
            awful.client.focus.byidx(-1)
        end,
        {description = "focus previous by index", group = "client"}
    ),

    -- =========================================
    -- CLIENT FOCUSING
    -- =========================================

    -- Focus screen by index (cycle through screens)
    awful.key({modkey}, "o",
        function()
            awful.screen.focus_relative(1)
        end,
        {description = "focus next screen", group = "client"}
    ),

    -- =========================================
    -- CLIENT RESIZING
    -- =========================================

    awful.key({modkey, "Control"}, "Down",
        function(c)
            resize_client(client.focus, "down")
        end,
        {description = "resize client down", group = "client"}
    ),
    awful.key({modkey, "Control"}, "Up",
        function(c)
            resize_client(client.focus, "up")
        end,
        {description = "resize client up", group = "client"}
    ),
    awful.key({modkey, "Control"}, "Left",
        function(c)
            resize_client(client.focus, "left")
        end,
        {description = "resize client left", group = "client"}
    ),
    awful.key({modkey, "Control"}, "Right",
        function(c)
            resize_client(client.focus, "right")
        end,
        {description = "resize client right", group = "client"}
    ),
    awful.key({modkey, "Control"}, "j",
        function(c)
            resize_client(client.focus, "down")
        end,
        {description = "resize client down", group = "client"}
    ),
    awful.key({ modkey, "Control" }, "k",
        function(c)
            resize_client(client.focus, "up")
        end,
        {description = "resize client up", group = "client"}
    ),
    awful.key({modkey, "Control"}, "h",
        function(c)
            resize_client(client.focus, "left")
        end,
        {description = "resize client left", group = "client"}
    ),
    awful.key({modkey, "Control"}, "l",
        function(c)
            resize_client(client.focus, "right")
        end,
        {description = "resize client right", group = "client"}
    ),

    -- =========================================
    -- NUMBER OF MASTER / COLUMN CLIENTS
    -- =========================================
    
    -- Number of master clients
    awful.key({modkey, altkey}, "h",
        function()
            awful.tag.incnmaster( 1, nil, true)
        end,
        {description = "increase the number of master clients", group = "layout"}
    ),
    awful.key({ modkey, altkey }, "l",
        function()
            awful.tag.incnmaster(-1, nil, true)
        end,
        {description = "decrease the number of master clients", group = "layout"}
    ),
    awful.key({ modkey, altkey }, "Left",
        function()
            awful.tag.incnmaster( 1, nil, true)
        end,
        {description = "increase the number of master clients", group = "layout"}
    ),
    awful.key({ modkey, altkey }, "Right",
        function()
            awful.tag.incnmaster(-1, nil, true)
        end,
        {description = "decrease the number of master clients", group = "layout"}
    ),

    -- Number of columns
    awful.key({modkey, altkey}, "k",
        function()
            awful.tag.incncol(1, nil, true)
        end,
        {description = "increase the number of columns", group = "layout"}
    ),
    awful.key({modkey, altkey}, "j",
        function()
            awful.tag.incncol(-1, nil, true)
        end,
        {description = "decrease the number of columns", group = "layout"}
    ),
    awful.key({modkey, altkey}, "Up",
        function()
            awful.tag.incncol(1, nil, true)
        end,
        {description = "increase the number of columns", group = "layout"}
    ),
    awful.key({modkey, altkey}, "Down",
        function()
            awful.tag.incncol(-1, nil, true)
        end,
        {description = "decrease the number of columns", group = "layout"}
    ),

    -- =========================================
    -- GAP CONTROL
    -- =========================================

    -- Gap control
    awful.key({modkey, "Shift"}, "minus",
        function()
            awful.tag.incgap(5, nil)
        end,
        {description = "increment gaps size for the current tag", group = "gaps"}
    ),
    awful.key({modkey}, "minus",
        function()
            awful.tag.incgap(-5, nil)
        end,
        {description = "decrement gap size for the current tag", group = "gaps"}
    ),

    -- =========================================
    -- LAYOUT SELECTION
    -- =========================================

    -- select next layout
    awful.key({modkey}, "space",
        function()
            awful.layout.inc(1)
        end,
        {description = "select next", group = "layout"}
    ),
    -- select previous layout
    awful.key({modkey, "Shift"}, "space",
        function()
            awful.layout.inc(-1)
        end,
        {description = "select previous", group = "layout"}
    ),

    -- =========================================
    -- CLIENT MINIMIZATION
    -- =========================================

    -- restore minimized client
    awful.key({modkey, "Shift"}, "n",
        function()
            local c = awful.client.restore()
            -- Focus restored client
            if c then
                client.focus = c
                c:raise()
            end
        end,
        {description = "restore minimized", group = "client"}
    )
)


-- ===================================================================
-- Client Key bindings
-- ===================================================================

bindings.clientkeys = gears.table.join(

    -- =========================================
    -- CLIENT MOVEMENT
    -- =========================================

    -- Move to edge or swap by direction
    awful.key({modkey, "Shift"}, "Down",
        function(c)
            move_client(c, "down")
        end,
        {description = "move client down", group = "client"}
    ),
    awful.key({modkey, "Shift"}, "Up",
        function(c)
            move_client(c, "up")
        end,
        {description = "move client up", group = "client"}
    ),
    awful.key({modkey, "Shift"}, "Left",
        function(c)
            move_client(c, "left")
        end,
        {description = "move client left", group = "client"}
    ),
    awful.key({modkey, "Shift"}, "Right",
        function(c)
            move_client(c, "right")
        end,
        {description = "move client right", group = "client"}
    ),
    awful.key({modkey, "Shift"}, "j",
        function(c)
            move_client(c, "down")
        end,
        {description = "move client down", group = "client"}
    ),
    awful.key({modkey, "Shift"}, "k",
        function(c)
            move_client(c, "up")
        end,
        {description = "move client up", group = "client"}
    ),
    awful.key({modkey, "Shift"}, "h",
        function(c)
            move_client(c, "left")
        end,
        {description = "move client left", group = "client"}
    ),
    awful.key({modkey, "Shift"}, "l",
        function(c)
            move_client(c, "right")
        end,
        {description = "move client right", group = "client"}
    ),

    -- =========================================
    -- CLIENT CONTROLS
    -- =========================================

    -- toggle fullscreen
    awful.key({modkey, "Control"}, "f",
        function(c)
            c.fullscreen = not c.fullscreen
        end,
        {description = "toggle fullscreen", group = "client"}
    ),

    -- toggle floating
    awful.key({modkey, "Shift"}, "f",
        function(c)
            c.floating = not c.floating
        end,
        {description = "toggle floating", group = "client"}
    ),

    -- close client
    awful.key({modkey}, "q",
        function(c)
            c:kill()
        end,
        {description = "close", group = "client"}
    ),

    -- Minimize
    awful.key({modkey}, "n",
        function(c)
            c.minimized = true
        end,
        {description = "minimize", group = "client"}
    ),

    -- Maximize
    awful.key({modkey}, "m",
        function(c)
            c.maximized = not c.maximized
            c:raise()
        end,
        {description = "(un)maximize", group = "client"}
    )
)


-- ===================================================================
-- Tag bindings
-- ===================================================================


for i = 1, 9 do
    bindings.globalkeys = gears.table.join(bindings.globalkeys,
        -- Switch to tag on screen 1
        awful.key({modkey}, "#" .. i + 9,
            function()
                local screen = screen[1]
                local tag = tags.tags[i]
                if tag then
                    sharedtags.viewonly(tag, screen)
                end
            end,
            {description = "view tag #"..i, group = "tag"}
        ),
        -- Switch to tag on screen 2
        awful.key({modkey, "Control"}, "#" .. i + 9,
            function()
                local screen = screen[2]
                local tag = tags.tags[i]
                if tag then
                    sharedtags.viewonly(tag, screen)
                end
            end,
            {description = "view tag #".. i .. " on 2nd monitor", group = "tag"}
        ),
        -- Move client to tag
        awful.key({modkey, "Shift"}, "#" .. i + 9,
            function()
                if client.focus then
                    local tag = tags.tags[i]
                    if tag then
                        client.focus:move_to_tag(tag)
                    end
                end
            end,
            {description = "move focused client to tag #"..i, group = "tag"}
        )
    )
 end

 return bindings