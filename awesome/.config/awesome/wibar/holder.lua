local wibox = require("wibox")
local beautiful = require("beautiful")

local M = {}

function M.holder(widget)
  return wibox.widget({
    {
      {
        margins = {
          left = beautiful.wibar_generic_item_padding_horizontal,
        },
        widget = wibox.container.margin,
      },
      widget,
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
  })
end

return M
