" Easy CAPS
inoremap <c-u> <ESC>viwUi
nnoremap <c-u> viwU<Esc>

" TAB in general mode will move to text buffer
nmap <TAB> :Tabnext<CR>
" SHIFT-TAB will go back
nmap <S-TAB> :Tabprev<CR>

" Better tabbing
vnoremap < <gv
vnoremap > >gv

nmap qq :Quit<CR>
