" auto-install vim-plug
if empty(glob('~/.config/nvim/autoload/plug.vim'))
  silent !curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  "autocmd VimEnter * PlugInstall
  "autocmd VimEnter * PlugInstall | source $MYVIMRC
endif

call plug#begin('~/.config/nvim/autoload/plugged')
    " Better Syntax Support
    Plug 'sheerun/vim-polyglot'
    " Auto pairs for '(' '[' '{'
    Plug 'jiangmiao/auto-pairs'
    " Airline
    Plug 'vim-airline/vim-airline'
    " Ranger
    Plug 'kevinhwang91/rnvimr', {'do': 'make sync'}
    " Comment stuff out
    Plug 'tpope/vim-commentary'
    " Colorizer
    Plug 'norcalli/nvim-colorizer.lua'
    " Dracula
    Plug 'darker-dracula/vim', { 'as': 'dracula' }
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
call plug#end()
