source $HOME/.config/nvim/novs/general/settings.vim
source $HOME/.config/nvim/novs/keys/mappings.vim
source $HOME/.config/nvim/novs/vim-plug/plugins.vim
source $HOME/.config/nvim/novs/plug-config/airline.vim
source $HOME/.config/nvim/novs/plug-config/rnvimr.vim
source $HOME/.config/nvim/novs/plug-config/vim-commentary.vim
source $HOME/.config/nvim/novs/plug-config/searching.vim
source $HOME/.config/nvim/novs/plug-config/coc.vim
source $HOME/.config/nvim/novs/plug-config/signify.vim

" lua
luafile $HOME/.config/nvim/novs/plug-config/tree-sitter-config.lua
luafile $HOME/.config/nvim/novs/plug-config/bufferline-config.lua

colorscheme dracula
highlight Pmenu guibg=#000000
set guifont=FiraCodeNerdFont
let g:neovide_transparency=1
let vim_markdown_preview_use_xdg_open=1

let g:UltiSnipsExpandTrigger="thisisabruhmomentidontwantthistobemappedtotablol"

function! SmartQuit()
    let num_buffers = len(getbufinfo({'buflisted':1}))
    if num_buffers == 1
      try
        execute ":silent quit"
      catch /E37:/
        " Unwritten changes
        echo "E37: Discard changes?  Y|y = Yes, N|n = No, W|w = Write and quit: "
        let ans = nr2char(getchar())
        if ans == "y" || ans == "Y"
          execute "quit!"
        elseif  ans == "w" || ans == "W"
          execute "write"
          execute "quit"
        else
          call feedkeys('\<ESC>')
        endif
      endtry
    else
      try
        execute "bd"
      catch /E89:/
        " Unwritten changes
        echo "E89: Discard changes?  Y|y = Yes, N|n = No, W|w = Write and quit: "
        let ans = nr2char(getchar())
        if ans == "y" || ans == "Y"
          execute "bd!"
        elseif  ans == "w" || ans == "W"
          execute "write"
          execute "bd"
        else
          call feedkeys('\<ESC>')
        endif
      endtry
    endif
endfunction

nnoremap qq :call SmartQuit()<CR>
