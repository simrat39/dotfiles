local Hydra = require("hydra")
local tsp = require("telescope.builtin")
local ts_utils = require("utils.telescope")

local hint = [[
 _g_: Live grep
 _d_: Search Dotfiles 
 _s_: Search symbols 
]]

function bruh(a, v, c) end

bruh(a, v, c)

Hydra({
  name = "Find",
  hint = hint,
  config = {
    hint = {
      border = "rounded",
    },
    invoke_on_body = true,
  },
  mode = { "n", "x" },
  body = "<leader>f",
  heads = {
    {
      "g",
      tsp.live_grep,
      { desc = "Live grep", exit = true, nowait = true },
    },
    {
      "d",
      ts_utils.search_dotfiles,
      { desc = "Search Dotfiles", nowait = true, exit = true },
    },
    {
      "s",
      function()
        vim.cmd([[:Telescope lsp_workspace_symbols]])
      end,
      { desc = "Search Dotfiles", nowait = true, exit = true },
    },
    { "q", nil, { exit = true, nowait = true, desc = "exit" } },
  },
})
