require('general')
require('mappings')
require('plugins')
require('statusline')

require('config/bufferline')
require('config/compe')
require('config/flutter-tools')
require('config/lspconfig')
require('config/nvim-autopairs')
require('config/nvim-colorizer')
require('config/nvim-tree')
require('config/nvim-ts-autotag')
require('config/rust-tools')
require('config/telescope')
require('config/tree-sitter')

vim.cmd "colorscheme dracula"
vim.opt.guifont='FiraCodeNerdFont'
