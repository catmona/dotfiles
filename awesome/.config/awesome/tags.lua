-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- 
-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- 
--                     CATS COOL CONFIG                        --
--                          tags                               --
-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- 
-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- 


-- ===================================================================
-- Initialization
-- ===================================================================


local awful = require("awful")

--shared tags module https://github.com/Drauthius/awesome-sharedtags
local sharedtags = require("modules/sharedtags")

--quake terminal dropdown module https://github.com/lcpz/lain/blob/33c0e0c2360a04fcc6f51bccb0ad2a7a9e9c07b3/util/quake.lua
local quake = require("modules/quake")

-- define module table
local tags = {}


-- ===================================================================
-- Tags
-- ===================================================================


tags.tags = sharedtags({
    { name = "♥", screen = 1, layout = awful.layout.suit.tile}, 
    { name = "♦", screen = 1, layout = awful.layout.suit.tile}, 
    { name = "♠", screen = 2, layout = awful.layout.suit.tile}, 
    { name = "♣", screen = 1, layout = awful.layout.suit.tile}, 
    -- { name = "\u{f10c}", screen = 1, layout = awful.layout.suit.tile }, -- games
    -- { name = "\u{f10c}", screen = 2, layout = awful.layout.suit.tile }, -- chat & spotify
    -- { name = "\u{f10c}", screen = 2, layout = awful.layout.suit.tile }, -- web (documentation)
    --{ name = "\u{EB2C}", screen = 2, layout = awful.layout.suit.tile }, -- home (widgets) (ECE4) (F007)/(F2C0)

})

function tags.create()

    awful.screen.connect_for_each_screen(function(s)
        
        s.quake = quake({ app = "kitty", argname = "--title %s",
                          extra = "--class QuakeDD -e tmux", 
                          visible = false, height = 0.65, screen = s,
                          overlap = false, width = 0.65, vert = "top", 
                          horiz = "center", border = 0 })
        
        -- local names = { "1", "2", "3", "4" }
        -- local l = awful.layout.suit -- alias
        -- local layouts = { l.tile, l.tile, l.tile, l.tile }

        -- awful.tag(names, s, layouts)

        --sharedtags.viewonly(tags.tags[1], s)
    end)
end


-- return module table
return tags