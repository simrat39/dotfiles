local beautiful = require("beautiful")
local wibox = require("wibox")
local awful = require("awful")
local fs = require("utils/fs")
local kill = require("utils/kill")
local battery_service = require("services/battery")
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
  M.charging_image = wibox.widget({
    {
      stylesheet = get_stylesheet_for_color(beautiful.dracula.red),
      image = fs.icon("thunder"),
      widget = wibox.widget.imagebox,
      forced_height = beautiful.dpi(13),
      forced_width = beautiful.dpi(13),
    },
    widget = wibox.container.margin,
    margins = { left = beautiful.dpi(4), right = beautiful.dpi(-2) },
    visible = false,
  })

  M.percentage_textbox = wibox.widget.textbox("  ")
  awesome.connect_signal("sim::battery", function(data)
    local markup = "  " .. data.percentage .. "%"

    if data.state == battery_service.DeviceState.CHARGING then
      M.charging_image.visible = true
    else
      M.charging_image.visible = false
    end

    M.percentage_textbox:set_markup_silently(markup)
  end)

  battery_service.emit_current_status(battery_service.get_device())

  M.widget = wibox.widget({
    {
      stylesheet = get_stylesheet_for_color(beautiful.dracula.green),
      image = fs.icon("battery_full"),
      widget = wibox.widget.imagebox,
    },
    M.percentage_textbox,
    {
      M.charging_image,
      valign = "center",
      halign = "center",
      widget = wibox.container.place,
    },
    layout = wibox.layout.fixed.horizontal,
  })

  M.widget:connect_signal("button::release", function()
    if not M.plasma_shown then
      awful.spawn.single_instance(
        "plasmawindowed --statusnotifier org.kde.plasma.battery",
        nil,
        function(c)
          M.plasma_shown = true
          M.plasma_pid = c.pid
        end
      )
    elseif M.plasma_pid then
      kill.kill(M.plasma_pid)
      M.plasma_shown = false
      M.plasma_pid = nil
    end
  end)
end

return M
