local function smartquit()
  local buf_nums = vim.fn.len(vim.fn.getbufinfo({ buflisted = 1 }))

  if buf_nums == 1 then
    local ok = pcall(vim.cmd, ":silent quit")
    if not ok then
      local choice = vim.fn.input(
        "E37: Discard changes?  Y|y = Yes, N|n = No, W|w = Write and quit: "
      )
      if choice == "y" then
        vim.cmd("quit!")
      elseif choice == "w" then
        vim.cmd("write")
        vim.cmd("quit")
      else
        vim.fn.feedkeys("\\<ESC>")
      end
    end
  else
    local ok = pcall(vim.cmd, "bw")

    if not ok then
      local choice = vim.fn.input(
        "E37: Discard changes?  Y|y = Yes, N|n = No, W|w = Write and quit: "
      )
      if choice == "y" then
        vim.cmd("bw!")
      elseif choice == "w" then
        vim.cmd("write")
        vim.cmd("bw")
      else
        vim.fn.feedkeys("\\<ESC>")
      end
    end
  end
end

return smartquit
