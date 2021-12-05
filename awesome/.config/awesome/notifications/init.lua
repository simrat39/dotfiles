local volume = require("notifications/volume_notification")
local awesome = awesome

local M = {}

function M.init()
  awesome.connect_signal("sim::volume", function(data)
    volume.show(data)
  end)
end

return M
