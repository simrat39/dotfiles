" enable tabline
let g:airline#extensions#tabline#enabled = 1
let g:airline_powerline_fonts = 1
let g:airline#extensions#tabline#formatter = 'unique_tail'

let g:airline#extensions#tabline#left_sep = ''
let g:airline#extensions#tabline#left_alt_sep = ')'

let g:airline_left_sep=''
let g:airline_right_sep=''

let g:airline_section_z = airline#section#create(['%p%%', ' Col', ':%c'])

let g:airline#extensions#coc#enabled = 1
