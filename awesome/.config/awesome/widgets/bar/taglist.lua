-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- 
-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- 
--                     CATS COOL CONFIG                        --
--                      taglist widget                         --
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
local taglist = {}

-- ===================================================================
-- Taglist
-- ===================================================================

function taglist.create(s)
    
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
    
    
    taglist.mytaglist = awful.widget.taglist {
        screen  = s,
        filter  = awful.widget.taglist.filter.all,
        buttons = taglist_buttons,
        widget_template = {
            {
                {
                    {
                        id = 'text_role',
                        widget = wibox.widget.textbox,
                    },
                    left = 5,
                    right = 5,
                    top = 1,
                    bottom = 1,
                    widget = wibox.container.margin
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
                    --awesome.emit_signal("tag_updated")
                    -- self:get_children_by_id("overline")[1].bg = beautiful.taglist_fg_focus
                else 
                    -- self:get_children_by_id("overline")[1].bg = beautiful.bg_normal
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
                    taglist.mytaglist:emit_signal("tag_updated")
                    -- self:get_children_by_id("overline")[1].bg = beautiful.taglist_fg_focus
                else 
                    -- self:get_children_by_id("overline")[1].bg = beautiful.bg_normal
                end
                
            end
        },
    } 
end

-- return module table
return taglist
    
