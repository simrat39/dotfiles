-- If LuaRocks is installed, make sure that packages installed through it are
-- found (e.g. lgi). If LuaRocks is not installed, do nothing.
require("luarocks.loader")

local gears = require("gears")
local awful = require("awful")
require("awful.autofocus")
local beautiful = require("beautiful")
local treetile = require("treetile")
local keymaps = require("keymaps")
local errors = require("errors")
local fsutils = require("utils/fs")

local services = require("services")
local notifications = require("notifications")
local titlebar = require("titlebar")

require("autostart")

errors.handle()

-- Variable definitions
-- Themes define colours, icons, font and wallpapers.
beautiful.init(fsutils.get_theme_file())

services.init()
notifications.init()
keymaps.setup_global_keymaps()

local wibar = require("wibar/wibar")

-- Table of layouts to cover with awful.layout.inc, order matters.
awful.layout.layouts = {
  treetile,
}

local function set_wallpaper(s)
  -- Wallpaper
  if beautiful.wallpaper then
    local wallpaper = beautiful.wallpaper
    -- If wallpaper is a function, call it with the screen
    if type(wallpaper) == "function" then
      wallpaper = wallpaper(s)
    end
    gears.wallpaper.maximized(wallpaper, s, true)
  end
end

-- Re-set wallpaper when a screen's geometry changes (e.g. different resolution)
screen.connect_signal("property::geometry", set_wallpaper)

awful.screen.connect_for_each_screen(function(s)
  -- Wallpaper
  set_wallpaper(s)

  wibar.wibar(s)

  -- Each screen has its own tag table.
  awful.tag(
    { "1", "2", "3", "4", "5", "6", "7", "8", "9", "10" },
    s,
    awful.layout.layouts[1]
  )
end)

root.buttons(
  gears.table.join(
    awful.button({}, 4, awful.tag.viewnext),
    awful.button({}, 5, awful.tag.viewprev)
  )
)

clientbuttons = gears.table.join(
  awful.button({}, 1, function(c)
    c:emit_signal("request::activate", "mouse_click", { raise = true })
  end),
  awful.button({ keymaps.modkey }, 1, function(c)
    c:emit_signal("request::activate", "mouse_click", { raise = true })
    awful.mouse.client.move(c)
  end),
  awful.button({ keymaps.modkey }, 3, function(c)
    c:emit_signal("request::activate", "mouse_click", { raise = true })
    awful.mouse.client.resize(c)
  end)
)

-- Rules
-- Rules to apply to new clients (through the "manage" signal).
awful.rules.rules = {
  -- All clients will match this rule.
  {
    rule = {},
    properties = {
      border_width = beautiful.border_width,
      border_color = beautiful.border_normal,
      focus = awful.client.focus.filter,
      raise = true,
      keys = keymaps.clientkeys,
      buttons = clientbuttons,
      screen = awful.screen.preferred,
      placement = awful.placement.no_overlap + awful.placement.no_offscreen,
    },
  },

  {
    rule = {
      class = "plasmawindowed",
    },
    properties = {
      floating = true,
      placement = function(w)
        awful.placement.top_right(w, {
          honor_workarea = true,
        })
      end,
    },
  },

  -- Add titlebars to normal clients and dialogs
  {
    rule_any = { type = { "normal", "dialog" } },
    properties = { titlebars_enabled = true },
  },
}

titlebar.init()

-- Signals
-- Signal function to execute when a new client appears.
client.connect_signal("manage", function(c)
  -- make it rounded lol
  c.shape = beautiful.global_rounded_rect_shape

  -- Set the windows at the slave,
  -- i.e. put it at the end of others instead of setting it master.
  -- if not awesome.startup then awful.client.setslave(c) end
  if
    awesome.startup
    and not c.size_hints.user_position
    and not c.size_hints.program_position
  then
    -- Prevent clients from being unreachable after screen count changes.
    awful.placement.no_offscreen(c)
  end
end)

client.connect_signal("focus", function(c)
  c.border_color = beautiful.border_focus
end)
client.connect_signal("unfocus", function(c)
  c.border_color = beautiful.border_normal
end)
