local M = {}

local font = "sans"

function M.get_with_size(size)
  return font .. " " .. tostring(size)
end

function M.get_default()
  return font .. " 8"
end

return M
