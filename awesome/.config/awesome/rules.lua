-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- 
-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- 
--                     CATS COOL CONFIG                        --
--                           Rules                             --
-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- 
-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- 


-- ===================================================================
-- Initialization
-- ===================================================================


local awful = require("awful")
local beautiful = require("beautiful")

local tags = require("tags")

-- define screen height and width
local screen_height = awful.screen.focused().geometry.height
local screen_width = awful.screen.focused().geometry.width

-- define module table
local rules = {}


-- ===================================================================
-- Rules
-- ===================================================================


function rules.create(clientkeys, clientbuttons)
   local rofi_rule = {
      rule_any = {name = {"rofi"}},
      properties = {maximized = true, floating = true, titlebars_enabled = false}
   }

   return {
      -- All clients will match this rule.
      {
         rule = {},
         properties = {
            titlebars_enabled = beautiful.titlebars_enabled,
            border_width = beautiful.border_width,
            border_color = beautiful.border_focus,
            focus = awful.client.focus.filter,
            raise = true,
            keys = clientkeys,
            buttons = clientbuttons,
            screen = awful.screen.preferred,
            placement = awful.placement.centered,
            maximized_horizontal = false,
            maximized_vertical = false,
            maximized = false,
         },
      },
      -- Floating clients.
      {
         rule_any = {
            instance = {
               "DTA",
               "copyq",
            },
            class = {
               "Nm-connection-editor"
            },
            name = {
               "Event Tester",
               "Steam Guard - Computer Authorization Required"
            },
            role = {
               "pop-up",
               "GtkFileChooserDialog"
            },
            type = {
               "dialog"
            }
         }, properties = {floating = true}
      },

      -- Fullscreen clients
      {
         rule_any = {
            class = {
               "Terraria.bin.x86",
               "arcolinux-logout.py",
               "i3lock"
            },
         }, properties = {fullscreen = true}
      },

      -- "Switch to tag"
      -- These clients make you switch to their tag when they appear
      {
         rule_any = {
            class = {
               --"Firefox",
               "Steam",
            },
         }, properties = {switchtotag = true}
      },

      --Set steam to the games tag
      { rule = {class = "Steam" }, 
         properties = { tag = tags.tags[4] } },
      
      --Set discord & spotify to the chat & music tag
      { 
         rule_any = {
            class = { 
               "discord", 
               "Spotify",
               "spotify"
            },
            name = {
               "Discord",
               "Discord Updater",
               "Spotify"
            }
         }, properties = { tag = tags.tags[3] }
      },
      
      {
         rule_any = {
            class = {"Firefox"},
         },
         properties = {
            tag = mouse.screen.selected_tag
         }
      },
      
      -- --Set console to the development tags
      -- { rule = {class = "Code" }, 
      --    properties = { tag = tags.tags[1] } },

      -- Visualizer
      {
         rule_any = {
            name = {"cava"}
      },
         properties = {
            floating = true,
            maximized_horizontal = true,
            sticky = true,
            ontop = false,
            skip_taskbar = true,
            below = true,
            focusable = false,
            height = screen_height * 0.40,
            opacity = 0.6
         },
         callback = function (c)
            decorations.hide(c)
            awful.placement.bottom(c)
         end
      },

      -- trayer
      {
         rule_any = {
            class = {"trayer"}
      },
         properties = {
            floating = false,
            sticky = true,
            ontop = true,
            skip_taskbar = true,
            below = true,
            focusable = false,
         },
         callback = function (c)
            decorations.hide(c)
            awful.placement.bottom(c)
         end
      },

      -- rofi rule determined above
      rofi_rule,

      -- File chooser dialog
      {
         rule_any = {role = {"GtkFileChooserDialog"}},
         properties = {floating = true, width = screen_width * 0.55, height = screen_height * 0.65}
      },

      -- Pavucontrol & Bluetooth Devices
      {
         rule_any = {class = {"Pavucontrol"}, name = {"Bluetooth Devices"}},
         properties = {floating = true, width = screen_width * 0.55, height = screen_height * 0.45}
      },
   }
end
  
-- return module table
return rules