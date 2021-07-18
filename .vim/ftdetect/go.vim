" ------ Golang Settings -------
set runtimepath+=$GOROOT/misc/vim
let g:go_highlight_functions = 1
let g:go_highlight_methods = 1
let g:go_highlight_structs = 1


autocmd FileType go autocmd BufWritePre <buffer> GoFmt
exe "set rtp+=".globpath($GOPATH, "src/github.com/nsf/gocode/vim")
"set completeopt=menu,preview
set completeopt=menuone
