local M = {}

local font = "sans"

M.default_size = 8

function M.get_with_size(size)
  return font .. " " .. tostring(size)
end

function M.get_default()
  return font .. " " .. tostring(M.default_size)
end

return M
