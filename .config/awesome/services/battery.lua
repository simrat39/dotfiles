local upower = require("lgi").require("UPowerGlib")
local gears = require("gears")
local awesome = awesome

local M = {}

M.DeviceState = {
  UNKNOWN = 0,
  CHARGING = 1,
  DISCHARGING = 2,
  EMPTY = 3,
  FULLY_CHARGED = 4,
  PENDING_CHARGE = 5,
  PENDING_DISCHARGE = 6,
  LAST = 7,
}

function M.emit_current_status(device)
  local data = {
    state = math.floor(device.state),
    percentage = math.floor(device.percentage),
  }
  awesome.emit_signal("sim::battery", data)
end

local path = "/org/freedesktop/UPower/devices/battery_BAT0"

function M.get_device()
  local devices = upower.Client():get_devices()

  for _, value in ipairs(devices) do
    if path == value:get_object_path() then
      return value
    end
  end
end

function M.start_battery_listener()
  local device = M.get_device()
  M.emit_current_status(device)

  gears.timer.start_new(30, function()
    M.emit_current_status(device)
    return true
  end)

  device.on_notify = function(dev)
    M.emit_current_status(dev)
  end
end

return M
