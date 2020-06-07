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

function! SmartQuit(force)
    let num_buffers = len(getbufinfo({'buflisted':1}))
    if num_buffers == 1
        if a:force == 1
            execute "quit!"
        else 
            execute "quit"
        endif
    else
        execute "bd"
    endif
endfunction

nnoremap qq :call SmartQuit(0)<CR>
nnoremap QQ :call SmartQuit(1)<CR>
