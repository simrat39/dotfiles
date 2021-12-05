local function comment()
  require("ts_context_commentstring.internal").update_commentstring()
  local mode = vim.fn.mode()
  if mode == "n" then
    vim.fn.feedkeys("gcc")
  elseif mode == "v" or mode == "V" then
    vim.fn.feedkeys("gc")
  end
end

return comment
