local awful = require("awful")
local kill = require("utils/kill").kill

local M = {}

function M.start_acpi_listen()
  local pid = awful.spawn.with_line_callback("acpi_listen", {
    stdout = function(out)
      if string.match(out, "^battery.*") then
        awesome.emit_signal("sim::charger")
      end
    end,
  })

  awesome.connect_signal("sim::pre_restart", function()
    kill(pid)
  end)
end

return M
