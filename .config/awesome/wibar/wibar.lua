local beautiful = require("beautiful")
local wibox = require("wibox")
local gears = require("gears")
local awful = require("awful")
local color = require("utils/color")

local battery = require("wibar/battery")
local separator = require("wibar/separator")
local taglist = require("wibar/taglist")
local volume = require("wibar/volume")

local client = client

local M = {}

-- Create a textclock widget
local my_date_widget = wibox.widget.textclock("%a %b %d")

local my_time_widget = wibox.widget.textclock("%I:%M %p")

local tasklist_buttons = gears.table.join(
  awful.button({}, 1, function(c)
    if c == client.focus then
      c.minimized = true
    else
      c:emit_signal("request::activate", "tasklist", { raise = true })
    end
  end),
  awful.button({}, 3, function()
    awful.menu.client_list({ theme = { width = 250 } })
  end),
  awful.button({}, 4, function()
    awful.client.focus.byidx(1)
  end),
  awful.button({}, 5, function()
    awful.client.focus.byidx(-1)
  end)
)

separator.init()
battery.init()
volume.init()

function M.wibar(s)
  s.taglist = taglist.get(s)

  -- Create a tasklist widget
  s.mytasklist = awful.widget.tasklist({
    screen = s,
    filter = awful.widget.tasklist.filter.currenttags,
    buttons = tasklist_buttons,
    layout = {
      spacing = 4,
      layout = wibox.layout.fixed.horizontal,
    },
    widget_template = {
      {
        awful.widget.clienticon,
        margins = {
          left = 8,
          right = 8,
          top = 4,
          bottom = 4,
        },
        widget = wibox.container.margin,
      },
      id = "background_role",
      widget = wibox.container.background,
    },
  })

  -- Create the wibox
  s.mywibox = awful.wibar({
    position = "bottom",
    screen = s,
    bg = color.with_opacity(beautiful.dracula.background, 50),
  })
  -- Add widgets to the wibox
  s.mywibox:setup({
    {
      layout = wibox.layout.align.horizontal,
      { -- Left widgets
        layout = wibox.layout.fixed.horizontal,
        s.taglist,
      },
      {
        layout = wibox.container.place,
        valign = "center",
        halign = "center",
        s.mytasklist, -- Middle widget
      },
      { -- Right widgets
        wibox.widget.systray(),
        battery.get(),
        separator.get(),
        volume.get(),
        separator.get(),
        my_date_widget,
        separator.get(),
        my_time_widget,
        layout = wibox.layout.fixed.horizontal,
      },
    },
    margins = beautiful.wibar_padding,
    widget = wibox.container.margin,
  })
end

return M
