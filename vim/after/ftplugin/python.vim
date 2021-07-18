if exists("b:did_ftplugin_python")
  finish
endif

set autoindent
setlocal smartindent cinwords=
    \if,elif,else,for,while,with,try,except,finally,def,class
set tabstop=8
set expandtab
set shiftwidth=4
set softtabstop=4

" python syntax check
let g:syntastic_python_checkers = ['pyflakes', 'pep8']
