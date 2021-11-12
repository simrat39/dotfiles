local volume = require("services/volume")
local battery = require("services/battery")
local acpi_listen = require("services/acpi_listen")

local M = {}

function M.init()
  volume.start_volume_listener()
  battery.start_battery_listener()
  acpi_listen.start_acpi_listen()
end
return M
