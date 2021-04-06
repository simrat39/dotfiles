local vim = vim

local M = {}

function M.set_binding(mode, key, command)
    local cmd = mode .. "noremap " .. key .. " " .. command
    vim.cmd(cmd)
end

return M
