source $HOME/.config/nvim/novs/smartquit.vim

source $HOME/.config/nvim/novs/general/settings.vim
source $HOME/.config/nvim/novs/keys/mappings.vim

source $HOME/.config/nvim/novs/vim-plug/plugins.vim
source $HOME/.config/nvim/novs/plug-config/airline.vim
source $HOME/.config/nvim/novs/plug-config/rnvimr.vim
source $HOME/.config/nvim/novs/plug-config/vim-commentary.vim
source $HOME/.config/nvim/novs/plug-config/signify.vim
" source $HOME/.config/nvim/novs/plug-config/nvim-tree.vim

source $HOME/.config/nvim/novs/plug-config/lsp-config.vim

" lua
luafile $HOME/.config/nvim/novs/plug-config/tree-sitter-config.lua
luafile $HOME/.config/nvim/novs/plug-config/bufferline-config.lua
luafile $HOME/.config/nvim/novs/plug-config/lsps-config.lua
luafile $HOME/.config/nvim/novs/plug-config/compe-config.lua
luafile $HOME/.config/nvim/novs/plug-config/telescope.lua

colorscheme dracula
set guifont=FiraCodeNerdFont
let g:neovide_transparency=1
