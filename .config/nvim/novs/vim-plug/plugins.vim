" auto-install vim-plug
if empty(glob('~/.config/nvim/autoload/plug.vim'))
  silent !curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  "autocmd VimEnter * PlugInstall
  "autocmd VimEnter * PlugInstall | source $MYVIMRC
endif

call plug#begin('~/.config/nvim/autoload/plugged')
    " Auto pairs for '(' '[' '{'
    Plug 'jiangmiao/auto-pairs'
    " Airline
    Plug 'vim-airline/vim-airline'
    " Ranger
    Plug 'kevinhwang91/rnvimr', {'do': 'make sync'}
    " Comment stuff out
    Plug 'akinsho/nvim-bufferline.lua'
    Plug 'tpope/vim-commentary'
    " Colorizer
    Plug 'norcalli/nvim-colorizer.lua'
    " Dracula
    Plug 'dracula/vim', { 'as': 'dracula' }
    " one dark
    Plug 'joshdick/onedark.vim' 
    " Searching
    Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
    Plug 'junegunn/fzf.vim'
    Plug 'airblade/vim-rooter'
    " COC
    Plug 'neoclide/coc.nvim', {'branch': 'release'}
    " Git
    Plug 'mhinz/vim-signify'
    " REPL
    Plug 'metakirby5/codi.vim'
    " Snippets
    Plug 'SirVer/ultisnips'
    " Tags
    Plug 'majutsushi/tagbar'
    " Discord
    Plug 'vimsence/vimsence'
    Plug 'tweekmonster/startuptime.vim'
    " tree-sitter
    Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}  " We recommend updating the parsers on update
    " dev-icons
    Plug 'kyazdani42/nvim-web-devicons'
    " telescope
    Plug 'nvim-lua/popup.nvim'
    Plug 'nvim-lua/plenary.nvim'
    Plug 'nvim-telescope/telescope.nvim'
call plug#end()
