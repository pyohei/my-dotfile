" 基本設定
set fileencoding=utf-8
set number
set wildmenu wildmode=list:full
set laststatus=2
set cmdheight=2
set showmatch

" 不可視文字の設定
set list
set listchars=tab:^^,extends:»,precedes:«,nbsp:%

" カーソル移動系
set scrolloff=8                " 上下8行の視界を確保

" setting by extension
set tabstop=4
set shiftwidth=4
set autoindent
set smartindent

" Vi 非互換モード
set nocompatible
filetype plugin indent on
syntax on

" 何に使っているか不明
"execute pathogen#infect()

"filetype plugin
filetype on
filetype plugin on

"let g:syntastic_enable_signs=1
"let g:syntastic_auto_loc_list=2
"let g:syntastic_mode_map = {'mode': 'passive'} 
"augroup AutoSyntastic
"    autocmd!
"    autocmd InsertLeave,TextChanged * call s:syntastic() 
"augroup END
"function! s:syntastic()
"    w
"    SyntasticCheck
"endfunction

set tabstop=4
set shiftwidth=4
set autoindent
set smartindent
set expandtab

autocmd FileType python setl autoindent
autocmd FileType python setl smartindent cinwords=if,elif,else,for,while,try,except,finally,def,class
autocmd FileType python setl tabstop=8 expandtab shiftwidth=4 softtabstop=4

autocmd FileType html setl autoindent
autocmd FileType html setl tabstop=8 expandtab shiftwidth=2 softtabstop=2

autocmd FileType javascript setl autoindent
autocmd FileType javascript setl tabstop=8 expandtab shiftwidth=4 softtabstop=4
