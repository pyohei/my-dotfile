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

" Header
:inoreabbrev pyheader #!/usr/local/bin/python<CR># -*- coding: utf-8 -*-<CR>

" ---- python docstring viewer ----
function! Pydocdoc()
    let l:cur_file = expand('%:t')
    let l:cur_dir = getcwd()
python << EOF
import vim
import_dir = vim.eval('l:cur_dir')
import sys
sys.path.append(import_dir)
import_file = vim.eval('l:cur_file')
import_mod = import_file.replace('.py', '')
exec "import {0} as docstring_help_module".format(import_mod)
help(docstring_help_module)
EOF
endfunction
