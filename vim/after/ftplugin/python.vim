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

" Setting for jedi
let g:jedi#auto_initialization = 1
let g:jedi#popup_on_dot = 1
let g:jedi#use_tabs_not_buffers = 1
let g:jedi#popup_select_first = 0
let g:jedi#completions_enabled = 1
autocmd FileType python let b:did_ftplugin = 1
autocmd FileType python setlocal completeopt-=preview

" python syntax check
let g:syntastic_python_checkers = ['pyflakes', 'pep8']

" pyimporter(my Plugin)
nnoremap [pyimporter] <Nop>
nmap     <Space>p [pyimporter]
nnoremap <silent> [pyimporter]i :PyImport

