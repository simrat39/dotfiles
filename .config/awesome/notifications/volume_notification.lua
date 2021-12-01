local awful = require("awful")
local beautiful = require("beautiful")
local wibox = require("wibox")
local gears = require("gears")
local timer = require("gears.timer")
local fs = require("utils/fs")

local M = {}

function M.show(state)
  local data = string.sub(state, 1, string.len(state) - 1)

  local muted = false
  local volume = 0

  if data == "muted" then
    muted = true
  else
    volume = tonumber(string.sub(data, 1, string.len(data) - 1))
  end

  local mute_image = fs.icon("volume-mute-solid")
  local default_image = fs.icon("volume-up-solid")

  if (M.bar and M.bar.visible) and (M.popup and M.popup.visible) then
    M.timer:again()
    if muted then
      M.volume_image.image = mute_image
    else
      M.volume_image.image = default_image
    end

    M.bar.value = volume / 100

    return
  end

  local timeout = 4
  M.timer = timer({
    timeout = timeout,
    callback = function()
      M.bar.visible = false
      M.popup.visible = false
      M.timer:stop()
    end,
    autostart = true,
  })

  local stylesheet = ""
    .. "svg { color:"
    .. beautiful.dracula.pink
    .. "; fill: "
    .. beautiful.dracula.pink
    .. " } "

  M.volume_image = wibox.widget({
    image = muted and mute_image or default_image,
    forced_width = beautiful.dpi(40),
    forced_height = beautiful.dpi(40),
    halign = "center",
    valign = "center",
    widget = wibox.widget.imagebox,
    stylesheet = stylesheet,
  })

  M.bar = wibox.widget({
    max_value = 1,
    value = volume / 100,
    forced_height = 0,
    forced_width = beautiful.dpi(250),
    paddings = 1,
    border_width = 1,
    shape = gears.shape.rounded_bar,
    bar_shape = gears.shape.rounded_bar,
    background_color = beautiful.dracula.current_line,
    color = beautiful.dracula.pink,
    widget = wibox.widget.progressbar,
  })

  M.popup = awful.popup({
    widget = {
      {
        {
          {
            {
              M.volume_image,
              margins = { left = 15, right = 15 },
              layout = wibox.container.margin,
            },
            bg = beautiful.colors.bg_dark,
            layout = wibox.container.background,
          },
          {
            margins = { top = 35, bottom = 35, left = 15 },
            widget = wibox.container.margin,
          },
          {
            M.bar,
            margins = { top = 25, bottom = 25 },
            widget = wibox.container.margin,
          },
          layout = wibox.layout.fixed.horizontal,
        },
        margins = { right = 25 },
        layout = wibox.container.margin,
      },
      bg = beautiful.colors.bg_darker,
      layout = wibox.container.background,
    },
    ontop = true,
    honor_workarea = true,
    placement = function(w)
      awful.placement.top_right(w, {
        honor_workarea = true,
        offset = {
          y = beautiful.useless_gap + beautiful.dpi(5),
          x = -beautiful.useless_gap,
        },
      })
    end,
    shape = beautiful.global_rounded_rect_shape,
  })
end

return M
