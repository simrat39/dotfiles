require("plugins")
require("impatient")
require("globals")
require("general")
require("mappings")
require("statusline")

require("sim_config/compe")
require("sim_config/dashboard-nvim")
require("sim_config/diagnostics")
require("sim_config/fidget")
require("sim_config/flutter-tools")
require("sim_config/gitsigns")
require("sim_config/hydra")
require("sim_config/indent-blankline")
require("sim_config/lspconfig")
require("sim_config/luasnip")
require("sim_config/nvim-autopairs")
require("sim_config/nvim-dap-ui")
require("sim_config/nvim-tree")
require("sim_config/nvim-ts-autotag")
require("sim_config/rust-tools")
-- require("sim_config/symbols-outline")
require("sim_config/telescope")
require("sim_config/tree-sitter")
require("sim_config/typescript")
require("sim_config/ui")

vim.g.easy_align_delimiters = {
  [";"] = { pattern = "=", left_margin = 10, right_margin = 1, stick_to_left = 0 },
}

vim.g.catppuccin_flavour = "macchiato" -- latte, frappe, macchiato, mocha
require("catppuccin").setup({
  integration = {
    nvimtree = {
      enabled = true,
      show_root = false, -- makes the root folder not transparent
      transparent_panel = true, -- make the panel transparent
    },
  },
})
vim.cmd([[colorscheme catppuccin]])

vim.g.cphlang = "javascript"
