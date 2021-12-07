local beautiful = require("beautiful")
local wibox = require("wibox")
local awful = require("awful")
local fs = require("utils/fs")
local kill = require("utils/kill")
---@diagnostic disable-next-line: undefined-global
local awesome = awesome

local M = { widget = nil }

function M.get()
  return M.widget
end

local function get_stylesheet_for_color(color)
  return "" .. "svg { fill:" .. color .. "; } "
end

function M.init()
  M.volume_text_widget = wibox.widget({
    widget = wibox.widget.textbox,
    text = " ",
  })

  M.icon_widget = wibox.widget({
    stylesheet = get_stylesheet_for_color(beautiful.dracula.pink),
    image = fs.icon("volume-up-solid"),
    widget = wibox.widget.imagebox,
    forced_width = beautiful.dpi(18),
    forced_height = beautiful.dpi(18),
  })

  awesome.connect_signal("sim::volume", function(data)
    if data == "muted\n" then
      M.icon_widget.image = fs.icon("volume-mute-solid")
      M.volume_text_widget.text = "  " .. "Muted"
    else
      M.icon_widget.image = fs.icon("volume-up-solid")
      M.volume_text_widget.text = "  " .. data
    end
  end)

  M.widget = wibox.widget({
    {
      {
        {
          M.icon_widget,
          valign = "center",
          halign = "center",
          widget = wibox.container.place,
        },
        top = beautiful.dpi(3),
        widget = wibox.container.margin,
      },
      M.volume_text_widget,
      layout = wibox.layout.fixed.horizontal,
    },
    top = beautiful.wibar_generic_item_padding_vertical,
    bottom = beautiful.wibar_generic_item_padding_vertical,
    widget = wibox.container.margin,
  })
end

return M
