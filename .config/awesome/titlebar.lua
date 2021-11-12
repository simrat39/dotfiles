local wibox = require("wibox")
local gears = require("gears")
local awful = require("awful")
local beautiful = require("beautiful")
---@diagnostic disable-next-line: undefined-global
local client = client

local M = {}

function M.init() end
-- Add a titlebar if titlebars_enabled is set to true in the rules.
client.connect_signal("request::titlebars", function(c)
  -- buttons for the titlebar
  local buttons = gears.table.join(
    -- move with mouse left click
    awful.button({}, 1, function()
      c:emit_signal("request::activate", "titlebar", { raise = true })
      awful.mouse.client.move(c)
    end),
    -- resize with mouse right click
    awful.button({}, 3, function()
      c:emit_signal("request::activate", "titlebar", { raise = true })
      awful.mouse.client.resize(c)
    end)
  )

  local function padded_button(widget)
    return wibox.container.margin(
      widget,
      beautiful.titlebar_button_padding_horizontal,
      beautiful.titlebar_button_padding_horizontal,
      beautiful.titlebar_button_padding_vertical,
      beautiful.titlebar_button_padding_vertical
    )
  end

  awful.titlebar(c, {
    size = beautiful.titlebar_height,
    position = beautiful.titlebar_pos,
  }):setup({
    {
      { -- Left
        awful.titlebar.widget.iconwidget(c),
        {
          layout = wibox.container.margin,
          margins = { left = beautiful.dpi(4), right = beautiful.dpi(4) },
        },
        awful.titlebar.widget.titlewidget(c),
        buttons = buttons,
        layout = wibox.layout.fixed.horizontal,
      },
      -- Middle (nothing)
      {
        layout = wibox.layout.fixed.horizontal,
      },
      { -- Right
        awful.titlebar.widget.maximizedbutton(c),
        awful.titlebar.widget.stickybutton(c),
        awful.titlebar.widget.ontopbutton(c),
        padded_button(awful.titlebar.widget.floatingbutton(c)),
        padded_button(awful.titlebar.widget.minimizebutton(c)),
        padded_button(awful.titlebar.widget.closebutton(c)),
        layout = wibox.layout.fixed.horizontal,
      },
      layout = wibox.layout.align.horizontal,
    },
    margins = beautiful.titlebar_padding,
    layout = wibox.container.margin,
  })
end)

return M
