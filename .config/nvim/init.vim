if exists('g:vscode')
  source $HOME/.config/nvim/vs/init.vim
else
  source $HOME/.config/nvim/novs/init.vim
endif

let g:tagbar_type_dart = {
    \ 'ctagstype' : 'dart',
    \ 'kinds'     : [
        \ 'c:classes',
        \ 'i:fields',
        \ 'm:methods',
        \ 'M:static methods',
        \ 'C:constructors',
        \ 'f:functions',
        \ 'o:operators',
        \ 'g:getters',
        \ 's:setters',
        \ 'a:abstract functions',
    \ ],
    \ 'sro' : '.',
    \ 'kind2scope' : {
        \ 'c' : 'class',
    \ },
    \ 'scope2kind' : {
        \ 'class' : 'c',
    \ },
    \ 'ctagsbin'  : 'dart_ctags',
	\ 'ctagsargs' : '-l'
\ }
