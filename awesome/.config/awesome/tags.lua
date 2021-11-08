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
local sharedtags = require("sharedtags")

-- define module table
local tags = {}


-- ===================================================================
-- Tags
-- ===================================================================


tags.tags = sharedtags({
    { name = "[1]", screen = 1, layout = awful.layout.suit.tile },
    { name = "[2]", screen = 1, layout = awful.layout.suit.tile },
    { name = "[3]", screen = 1, layout = awful.layout.suit.tile },
    { name = "[4]", screen = 1, layout = awful.layout.suit.tile },
    { name = "[5]", screen = 2, layout = awful.layout.suit.tile },
    { name = "[6]", screen = 2, layout = awful.layout.suit.tile },
    { name = "[7]", screen = 2, layout = awful.layout.suit.tile },
    { name = "[8]", screen = 2, layout = awful.layout.suit.tile },

})

function tags.create()

    awful.screen.connect_for_each_screen(function(s)

        -- local names = { "1", "2", "3", "4" }
        -- local l = awful.layout.suit -- alias
        -- local layouts = { l.tile, l.tile, l.tile, l.tile }

        -- awful.tag(names, s, layouts)

        --sharedtags.viewonly(tags.tags[1], s)
    end)
end


-- return module table
return tags