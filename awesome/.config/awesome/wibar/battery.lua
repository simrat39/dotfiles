local beautiful = require("beautiful")
local wibox = require("wibox")
local fs = require("utils/fs")
local battery_service = require("services/battery")
local color_utils = require("utils/color")
---@diagnostic disable-next-line: undefined-global
local awesome = awesome

local M = { widget = nil }

function M.get()
  return M.widget
end

local function get_stylesheet_for_color(color)
  return "" .. "svg { color:" .. color .. "; } "
end

function M.init()
  M.battery_icon = wibox.widget({
    stylesheet = get_stylesheet_for_color(beautiful.dracula.green),
    image = fs.icon("battery-full-solid"),
    forced_height = beautiful.dpi(25),
    forced_width = beautiful.dpi(25),
    valign = "center",
    widget = wibox.widget.imagebox,
  })

  M.percentage_textbox = wibox.widget({
    widget = wibox.widget.textbox,
  })

  M.widget = wibox.widget({
    {
      {
        {
          margins = {
            left = beautiful.wibar_generic_item_padding_horizontal,
          },
          widget = wibox.container.margin,
        },
        M.percentage_textbox,
        {
          margins = {
            left = beautiful.wibar_generic_item_padding_horizontal,
          },
          widget = wibox.container.margin,
        },
        layout = wibox.layout.fixed.horizontal,
      },
      bg = beautiful.dracula.selection,
      shape = beautiful.global_rounded_rect_shape,
      layout = wibox.container.background,
    },
    value = 0.5,
    max_value = 1,
    min_value = 0,
    border_color = beautiful.dracula.selection,
    color = color_utils.with_opacity(beautiful.dracula.green, 90),
    widget = wibox.container.radialprogressbar,
  })

  awesome.connect_signal("sim::battery", function(data)
    local p = tonumber(data.percentage)

    M.widget.value = p / 100

    local text = data.percentage .. "%"

    if data.state == battery_service.DeviceState.CHARGING then
      M.widget.color = color_utils.with_opacity(beautiful.dracula.red, 90)
    else
      M.widget.color = color_utils.with_opacity(beautiful.dracula.green, 90)
    end

    M.percentage_textbox.text = text
  end)

  battery_service.emit_current_status(battery_service.get_device())
end

return M
