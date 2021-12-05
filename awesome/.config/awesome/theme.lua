---------------------------
-- Default awesome theme --
---------------------------

local theme_assets = require("beautiful.theme_assets")
local xresources = require("beautiful.xresources")
local dpi = xresources.apply_dpi

local gears = require("gears")
local themes_path = gears.filesystem.get_themes_dir()

local theme = {}

theme.dpi = dpi

-- font
theme.font = "sans 8"

-- wallpaper
theme.wallpaper = "/home/simrat39/Media/macos-monterey-2560x1440_897687-mm-90.jpg"
local dracula = {
  background = "#1E1F29",
  current_line = "#282a36",
  selection = "#282a36",
  foreground = "#f8f8f2",
  comment = "#6272a4",
  cyan = "#8be9fd",
  green = "#50fa7b",
  orange = "#ffb86c",
  pink = "#ff79c6",
  purple = "#bd93f9",
  red = "#ff5555",
  yellow = "#f1fa8c",
}

local colors = {
  white = "#FFFFFF",
  -- taglist_bg_focus = "#54597d",
  taglist_bg_focus = "#3a3e55",
  bg_dark = "#191A21",
  bg_darker = "#101116",
}

theme.dracula = dracula
theme.colors = colors

-- Backgrounds
theme.bg_normal = dracula.background
theme.bg_focus = dracula.selection
theme.bg_urgent = dracula.red
theme.bg_minimize = dracula.selection
theme.bg_systray = theme.bg_normal

-- Foreground
theme.fg_normal = dracula.foreground
theme.fg_focus = colors.white
theme.fg_urgent = colors.white
theme.fg_minimize = colors.white

-- Borders
theme.useless_gap = dpi(10)
theme.border_width = dpi(2)
theme.border_normal = dracula.background
theme.border_focus = dracula.selection
theme.border_marked = dracula.red

-- Client
theme.border_radius = dpi(8)
theme.global_rounded_rect_shape = function(cr, w, h)
  gears.shape.rounded_rect(cr, w, h, theme.border_radius)
end

-- Wibar
theme.wibar_height = dpi(38)
theme.wibar_margins = {
  top = dpi(0),
  left = dpi(0),
  right = dpi(0),
  bottom = dpi(0),
}
theme.wibar_padding = {
  top = dpi(6),
  left = dpi(6),
  right = dpi(6),
  bottom = dpi(6),
}
theme.wibar_shape = nil

theme.wibar_generic_item_padding_horizontal = dpi(10)
theme.wibar_generic_item_padding_vertical = dpi(2)

-- Systray
theme.systray_icon_spacing = dpi(8)
theme.bg_systray = dracula.selection

-- Tasklist
theme.tasklist_shape = gears.shape.rounded_rect
theme.tasklist_bg_focus = colors.taglist_bg_focus
theme.tasklist_bg_normal = dracula.selection

-- Client titlebar
theme.titlebar_pos = "bottom"
theme.titlebar_height = dpi(35)
theme.titlebar_padding = dpi(8)
-- Titlebar buttons
theme.titlebar_button_padding_horizontal = dpi(4)
theme.titlebar_button_padding_vertical = dpi(3)

---Creates a cairo surface with a rounded button as a shape
---@param color string
local function colored_round_button_surface(color)
  return gears.surface.load_from_shape(
    theme.titlebar_height,
    theme.titlebar_height,
    gears.shape.circle,
    color
  )
end

-- Close button
theme.titlebar_close_button_normal = colored_round_button_surface(
  dracula.selection
)
theme.titlebar_close_button_focus = colored_round_button_surface(dracula.red)

-- Minimize button
theme.titlebar_minimize_button_normal = colored_round_button_surface(
  dracula.selection
)
theme.titlebar_minimize_button_focus = colored_round_button_surface(
  dracula.yellow
)

-- Floating toggle button
theme.titlebar_floating_button_normal_inactive = colored_round_button_surface(
  dracula.selection
)
theme.titlebar_floating_button_focus_inactive = colored_round_button_surface(
  dracula.pink
)
theme.titlebar_floating_button_normal_active = colored_round_button_surface(
  dracula.selection
)
theme.titlebar_floating_button_focus_active = colored_round_button_surface(
  dracula.purple
)

-- There are other variable sets
-- overriding the default one when
-- defined, the sets are:
-- taglist_[bg|fg]_[focus|urgent|occupied|empty|volatile]
-- tasklist_[bg|fg]_[focus|urgent]
-- titlebar_[bg|fg]_[normal|focus]
-- tooltip_[font|opacity|fg_color|bg_color|border_width|border_color]
-- mouse_finder_[color|timeout|animate_timeout|radius|factor]
-- prompt_[fg|bg|fg_cursor|bg_cursor|font]
-- hotkeys_[bg|fg|border_width|border_color|shape|opacity|modifiers_fg|label_bg|label_fg|group_margin|font|description_font]
-- Example:
--theme.taglist_bg_focus = "#ff0000"
theme.taglist_bg_focus = colors.taglist_bg_focus
theme.taglist_bg_occupied = dracula.selection
theme.taglist_bg_urgent = dracula.red

theme.taglist_fg_focus = dracula.foreground
theme.taglist_fg_occupied = dracula.foreground
theme.taglist_fg_empty = dracula.selection

theme.taglist_shape = gears.shape.rounded_rect

-- Variables set for theming notifications:
-- notification_font
-- notification_[bg|fg]
-- notification_[width|height|margin]
-- notification_[border_color|border_width|shape|opacity]

-- Variables set for theming the menu:
-- menu_[bg|fg]_[normal|focus]
-- menu_[border_color|border_width]
theme.menu_submenu_icon = themes_path .. "default/submenu.png"
theme.menu_height = dpi(15)
theme.menu_width = dpi(100)

-- You can add as many variables as
-- you wish and access them by using
-- beautiful.variable in your rc.lua
--theme.bg_widget = "#cc0000"

theme.titlebar_ontop_button_normal_inactive = themes_path
  .. "default/titlebar/ontop_normal_inactive.png"
theme.titlebar_ontop_button_focus_inactive = themes_path
  .. "default/titlebar/ontop_focus_inactive.png"
theme.titlebar_ontop_button_normal_active = themes_path
  .. "default/titlebar/ontop_normal_active.png"
theme.titlebar_ontop_button_focus_active = themes_path
  .. "default/titlebar/ontop_focus_active.png"

theme.titlebar_sticky_button_normal_inactive = themes_path
  .. "default/titlebar/sticky_normal_inactive.png"
theme.titlebar_sticky_button_focus_inactive = themes_path
  .. "default/titlebar/sticky_focus_inactive.png"
theme.titlebar_sticky_button_normal_active = themes_path
  .. "default/titlebar/sticky_normal_active.png"
theme.titlebar_sticky_button_focus_active = themes_path
  .. "default/titlebar/sticky_focus_active.png"

theme.titlebar_maximized_button_normal_inactive = themes_path
  .. "default/titlebar/maximized_normal_inactive.png"
theme.titlebar_maximized_button_focus_inactive = themes_path
  .. "default/titlebar/maximized_focus_inactive.png"
theme.titlebar_maximized_button_normal_active = themes_path
  .. "default/titlebar/maximized_normal_active.png"
theme.titlebar_maximized_button_focus_active = themes_path
  .. "default/titlebar/maximized_focus_active.png"

-- Generate Awesome icon:
theme.awesome_icon = theme_assets.awesome_icon(
  theme.menu_height,
  theme.bg_focus,
  theme.fg_focus
)

-- Define the icon theme for application icons. If not set then the icons
-- from /usr/share/icons and /usr/share/icons/hicolor will be used.
theme.icon_theme = nil

return theme

-- vim: filetype=lua:expandtab:shiftwidth=4:tabstop=8:softtabstop=4:textwidth=80
