local Hydra = require("hydra")

local hint = [[
 _a_: Code Actions 
]]

Hydra({
  name = "LSP",
  hint = hint,
  config = {
    invoke_on_body = true,
    hint = {
      border = "rounded",
    },
  },
  mode = { "n", "x" },
  body = "<leader>l",
  heads = {
    {
      "a",
      function()
        vim.lsp.buf.code_action()
      end,
      { desc = "Show code actions" },
    },
    { "q", nil, { exit = true, nowait = true, desc = "exit" } },
  },
})
