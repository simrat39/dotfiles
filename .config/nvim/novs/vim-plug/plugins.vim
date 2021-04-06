" auto-install vim-plug
if empty(glob('~/.config/nvim/autoload/plug.vim'))
  silent !curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
endif

call plug#begin('~/.config/nvim/autoload/plugged')
    " Auto pairs for '(' '[' '{'
    Plug 'jiangmiao/auto-pairs'
    " Airline
    Plug 'vim-airline/vim-airline'
    " Ranger
    Plug 'kevinhwang91/rnvimr', {'do': 'make sync'}
    " Top buffer/tab line
    Plug 'akinsho/nvim-bufferline.lua'
    " Comment stuff out
    Plug 'tpope/vim-commentary'
    " Dracula
    Plug 'dracula/vim', { 'as': 'dracula' }
    " Set root directory properly
    Plug 'airblade/vim-rooter'
    " Git in the gutter
    Plug 'mhinz/vim-signify'
    " Tags
    Plug 'majutsushi/tagbar'
    " Discord
    Plug 'vimsence/vimsence'
    " tree-sitter
    Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}  " We recommend updating the parsers on update
    " dev-icons
    Plug 'kyazdani42/nvim-web-devicons'
    " " telescope
    Plug 'nvim-lua/popup.nvim'
    Plug 'nvim-lua/plenary.nvim'
    Plug 'nvim-telescope/telescope.nvim'
    Plug 'romgrk/fzy-lua-native'
    Plug 'nvim-telescope/telescope-fzy-native.nvim'
    " lsp stuff
    Plug 'neovim/nvim-lspconfig'
    Plug 'hrsh7th/nvim-compe'
    Plug 'RishabhRD/popfix'
    Plug 'RishabhRD/nvim-lsputils'    
    " snippets
    Plug 'hrsh7th/vim-vsnip'
    " Startify
    Plug 'mhinz/vim-startify'    
    Plug 'nvim-treesitter/playground'
    " tree sitter dart not good enough :( 
    Plug 'dart-lang/dart-vim-plugin'
call plug#end()
