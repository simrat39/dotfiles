local gfs = require("gears.filesystem")

local M = {}

function M.icon(icon)
  return gfs.get_configuration_dir() .. "/icons/" .. icon .. ".svg"
end

return M
