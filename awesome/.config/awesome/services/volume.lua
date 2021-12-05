local awful = require("awful")
local kill = require("utils/kill").kill

local M = {}

function M.start_volume_listener()
  awful.spawn.easy_async_with_shell(
    "pamixer --get-volume-human",
    function(stdout)
      awesome.emit_signal("sim::volume", stdout)
    end
  )

  local pid =
    awful.spawn.with_line_callback(
      "stdbuf -oL alsactl monitor pulse",
      {
        stdout = function()
          awful.spawn.easy_async_with_shell(
            "pamixer --get-volume-human",
            function(stdout)
              awesome.emit_signal("sim::volume", stdout)
            end
          )
        end,
      }
    )

  awesome.connect_signal("sim::pre_restart", function()
    kill(pid)
  end)
end

return M
