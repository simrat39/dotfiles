local beautiful = require("beautiful")
local wibox = require("wibox")

local M = { widget = nil }

function M.get()
  return M.widget
end

function M.init()
  M.widget = wibox.widget({
    margins = {
      left = beautiful.dpi(4),
      right = beautiful.dpi(4),
    },
    widget = wibox.container.margin,
  })
end

return M
