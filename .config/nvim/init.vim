source $HOME/.config/nvim/general/settings.vim
source $HOME/.config/nvim/keys/mappings.vim
source $HOME/.config/nvim/vim-plug/plugins.vim
source $HOME/.config/nvim/plug-config/airline.vim
source $HOME/.config/nvim/plug-config/rnvimr.vim
source $HOME/.config/nvim/plug-config/vim-commentary.vim
source $HOME/.config/nvim/plug-config/searching.vim
source $HOME/.config/nvim/plug-config/coc.vim
source $HOME/.config/nvim/plug-config/signify.vim

colorscheme dracula
highlight Pmenu guibg=#000000
set guifont=FiraCodeNerdFont
let vim_markdown_preview_use_xdg_open=1

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
