" Plugin loader for vim.
" I reffered shougo's github page.
"   https://github.com/Shougo/dein.vim

filetype off
if &compatible
  set nocompatible
endif

let s:dein_dir = expand('~/.vim/dein')
let s:dein_repo_dir = s:dein_dir . '/repos/github.com/Shougo/dein.vim'
 
if &runtimepath !~# '/dein.vim'
  if !isdirectory(s:dein_repo_dir)
    execute '!git clone https://github.com/Shougo/dein.vim' s:dein_repo_dir
  endif
  execute 'set runtimepath^=' . fnamemodify(s:dein_repo_dir, ':p')
endif
 
call dein#begin(s:dein_dir)
 
let s:toml = '~/.vim/dein.toml'
let s:lazy_toml = '~/.vim/deinlazy.toml'
 
call dein#load_toml(s:toml,      {'lazy': 0})
call dein#load_toml(s:lazy_toml, {'lazy': 1})
 
call dein#end()
 
if dein#check_install()
  call dein#install()
endif

filetype plugin indent on
syntax enable
