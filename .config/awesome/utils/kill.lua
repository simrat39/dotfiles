local M = {}

function M.kill(pid)
  awful.spawn("kill -9 " .. tostring(pid))
end

return M
