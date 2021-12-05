local M = {}

---@param ft string
---@param command string
function M.setup_auto_format(ft, command)
  if not command then
    command = "lua vim.lsp.buf.formatting_sync()"
  end
  vim.cmd(string.format("autocmd BufWritePre *.%s %s", ft, command))
end

return M
