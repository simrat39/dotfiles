local gfs = require("gears.filesystem")

local M = {}

function M.icon(icon)
  return gfs.get_configuration_dir() .. "/icons/" .. icon .. ".svg"
end

function M.get_theme_file()
  return gfs.get_configuration_dir() .. "theme.lua"
end

return M
