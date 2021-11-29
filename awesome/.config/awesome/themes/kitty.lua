--      ████████╗██╗  ██╗███████╗███╗   ███╗███████╗
--      ╚══██╔══╝██║  ██║██╔════╝████╗ ████║██╔════╝
--         ██║   ███████║█████╗  ██╔████╔██║█████╗
--         ██║   ██╔══██║██╔══╝  ██║╚██╔╝██║██╔══╝
--         ██║   ██║  ██║███████╗██║ ╚═╝ ██║███████╗
--         ╚═╝   ╚═╝  ╚═╝╚══════╝╚═╝     ╚═╝╚══════╝

-- ===================================================================
-- Initialization
-- ===================================================================


local xresources = require("beautiful.xresources")
local dpi = xresources.apply_dpi

-- define module table
local theme = {}


-- ===================================================================
-- Theme Variables
-- ===================================================================


theme.name = "kitty"

-- Font
theme.font = "MesloLGS NF 9"
theme.title_font = "MesloLGS NF Bold 10"
theme.taglist_font = "Font Awesome 5 Free-Solid-900 11 "
--theme.taglist_font = "fghrthsj 11 "

-- Background
theme.bg_normal = "#2f2a33"
theme.bg_dark = "#000000"
theme.bg_focus = "#1f1f1f"
theme.bg_occupied = theme.bg_normal
theme.bg_urgent = "#3b3741"
theme.bg_minimize = "#444444"

-- Foreground
theme.fg_normal = "#ffffff"
theme.fg_focus = "#f8c2e2"
theme.fg_occupied = "#B594B6"
theme.fg_urgent = "#DA627D"
theme.fg_minimize = "#ffffff"

-- Hotkeys
theme.hotkeys_bg = "#2D2A32"
theme.hotkeys_fg = "#f1f1f1"
theme.hotkeys_border_color = "#f8c2e2"
theme.hotkeys_border_width = dpi(3)
theme.hotkeys_modifiers_fg = "#9C6E81"
theme.hotkeys_modifiers_bg = theme.hotkeys_bg
theme.hotkeys_label_fg = "#1f1f1f"
theme.hotkeys_font = theme.title_font
theme.hotkeys_font = theme.font
theme.hotkeys_group_margin = dpi(20)

-- Window Gap Distance
theme.useless_gap = dpi(5)

-- Show Gaps if Only One Client is Visible
theme.gap_single_client = true

-- Window Borders
theme.border_width = dpi(2)
theme.border_normal = theme.bg_normal
theme.border_focus = "#d87389"
theme.border_marked = theme.fg_urgent
theme.rounded_corners = false

-- Taglist
theme.taglist_bg_empty = theme.bg_normal
theme.taglist_bg_occupied = theme.bg_occupied
theme.taglist_bg_urgent = theme.bg_urgent
theme.taglist_bg_focus = theme.bg_focus

theme.taglist_fg_occupied = theme.fg_occupied

-- Tasklist
theme.tasklist_font = theme.font

theme.tasklist_bg_normal = theme.bg_normal
theme.tasklist_bg_focus = theme.bg_focus
theme.tasklist_bg_urgent = theme.bg_urgent

theme.tasklist_fg_focus = theme.fg_focus
theme.tasklist_fg_urgent = theme.fg_urgent
theme.tasklist_fg_normal = theme.fg_normal

-- Panel Sizing
theme.left_panel_width = dpi(55)
theme.top_panel_height = dpi(26)

-- Notifications
theme.notification_bg = theme.bg_normal
theme.notification_fg = theme.fg_normal
theme.notification_max_width = dpi(350)
theme.notification_max_height = dpi(125)
theme.notification_icon_size = dpi(115)
theme.notification_opacity = 0.94

-- System Tray
theme.bg_systray = theme.bg_normal
theme.systray_icon_spacing = dpi(5)

-- Titlebars
theme.titlebars_enabled = false


-- ===================================================================
-- Icons
-- ===================================================================


-- Define layout icons
theme.layout_tile = "~/.config/awesome/icons/layouts/tile.png"
theme.layout_floating = "~/.config/awesome/icons/layouts/floating.png"
theme.layout_max = "~/.config/awesome/icons/layouts/max.png"

theme.icon_theme = "Tela-dark"

-- return theme
return theme
