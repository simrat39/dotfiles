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
  return "" .. "svg { color:" .. color .. "; } "
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

  M.battery_icon = wibox.widget({
    stylesheet = get_stylesheet_for_color(beautiful.dracula.green),
    image = fs.icon("battery-full-solid"),
    forced_height = beautiful.dpi(25),
    forced_width = beautiful.dpi(25),
    valign = "center",
    widget = wibox.widget.imagebox,
  })

  M.percentage_textbox = wibox.widget.textbox("  ")

  awesome.connect_signal("sim::battery", function(data)
    local p = tonumber(data.percentage)

    if p >= 0 and p <= 20 then
      M.battery_icon.image = fs.icon("battery-empty-solid")
    elseif p > 20 and p <= 40 then
      M.battery_icon.image = fs.icon("battery-quarter-solid")
    elseif p > 40 and p <= 60 then
      M.battery_icon.image = fs.icon("battery-half-solid")
    elseif p > 60 and p <= 80 then
      M.battery_icon.image = fs.icon("battery-three-quarters-solid")
    else
      M.battery_icon.image = fs.icon("battery-full-solid")
    end

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
    M.battery_icon,
    M.percentage_textbox,
    {
      M.charging_image,
      valign = "center",
      halign = "center",
      widget = wibox.container.place,
    },
    layout = wibox.layout.fixed.horizontal,
  })
end

return M
