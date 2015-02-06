scriptencoding utf-8

" ==== Vim ===== "

" encoding
set encoding=utf-8
set fileencoding=utf-8

" basic setting (not distributing)
set runtimepath+=~/.vim/
set helplang=ja
set number
set laststatus=2
set cmdheight=2
set showmatch
set autoread
set hidden
set scrolloff=3
set hidden
set backspace=indent,eol,start
set showcmd
set ruler
set formatoptions=q
set tw=0
set t_vb=
set novisualbell
set ambiwidth=single
set clipboard+=unnamed
set history=2000
colorscheme desert

" no buckup
set nobackup
set noswapfile

" complete setting
set wildmenu
set wildmode=list,full
set completeopt=menuone

" Display complete list automatically
let g:com_list = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ_"
for k in split(com_list, '\zs')
    exec "imap " . k . " " . k . "<C-N><C-P>"
endfor
inoremap <expr> <TAB> pumvisible() ? "\<Down>" : "\<Tab>"

" setting by OS
if has('kaoriya')
    if has('unix')
        set transparency=20
        set imdisable
    elseif has('win32')
        autocmd GUIEnter * set transparency=220
        set guioptions-=m   " hide menu
        set guioptions-=T   " hede tool
        set encoding=cp932
    endif
endif

" Hilight current line
augroup cch
  autocmd! cch
  autocmd CursorMoved,CursorMovedI,WinLeave * setlocal nocursorline
  autocmd CursorHold,CursorHoldI * setlocal cursorline
augroup END

" searcing
set wrapscan
set incsearch

" unvisible string
set list
set listchars=tab:^^,extends:»,precedes:«,nbsp:%

" Delete space in end line (change in windows)
augroup splitspace
    autocmd!
    autocmd BufWritePre * :%s/\s\+$//e
augroup END

" tab setting
set tabstop=4
set shiftwidth=4
set autoindent
set smartindent
set expandtab
set softtabstop=4

" Double Space highlight
augroup highlightDoubleByteSpace
  autocmd!
  autocmd VimEnter,Colorscheme * highlight DoubleByteSpace cterm=underline
    \ ctermfg=Green gui=reverse guifg=Green
  autocmd VimEnter,WinEnter * match DoubleByteSpace /　/
augroup END

" Neobundle Settings
filetype off
if has('vim_starting')
    set runtimepath+=~/.vim/bundle/neobundle.vim/
    call neobundle#begin(expand('~/.vim/bundle/'))
endif

NeoBundleFetch 'Shougo/neobundle.vim' " manage NeoBundle with NeoBundle
NeoBundle 'scrooloose/nerdtree'
NeoBundle 'scrooloose/syntastic'
NeoBundle 'grep.vim'
NeoBundle 'surround.vim'
NeoBundle 'thinca/vim-quickrun'
NeoBundle 'Shougo/unite.vim'
NeoBundle 'Shougo/vimfiler.vim'
NeoBundle 'davidhalter/jedi-vim'
NeoBundle 'open-browser.vim'
NeoBundle 'tpope/vim-fugitive'

call neobundle#end()
NeoBundleCheck

" - jedi-vim -
" ポップアップ非表示
let g:jedi#popup_select_first = 0
" 関数/メソッド定義非表示
let g:jedi#show_call_signatures = 0
" 自動補完しない
let g:jedi#auto_vim_configuration = 0
let g:jedi#use_tabs_not_buffers = 0
let g:jedi#popup_on_dot = 0
let g:jedi#rename_command = "<leader>??????"

" - NERDTree -
let NERDTreeIgnore=['\.pyc$']

" file setting
filetype on
filetype plugin on
syntax on

" mouse scrolling
set mouse=a
set ttymouse=xterm2

" Key mapping
nnoremap <silent> <Esc><Esc> :nohlsearch<CR>
inoremap jj <Esc>
nnoremap j gj
nnoremap k gk
nnoremap <Space>j 0
nnoremap <Space>l $

" Key mapping in Unite.vim
nnoremap [unite] <Nop>
nmap     <Space>u [unite]
nnoremap <silent> [unite]b :<C-u>Unite buffer<CR>
nnoremap <silent> [unite]f :<C-u>Unite file<CR>
nnoremap <silent> [unite]d :<C-u>Unite directory<CR>
nnoremap <silent> [unite]t :<C-u>Unite tab<CR>

" Key mapping in vimfiler.vim
nnoremap F :VimFiler<CR>
nnoremap Fe :VimFilerExplore<CR>

" Opne browser setting
let g:netrw_nogx = 1
nmap gx <Plug>(openbrowser-smart-search)
vmap gx <Plug>(openbrowser-smart-search)

nnoremap ZZ <Nop>
nnoremap ZQ <Nop>

" Developnemt tool
function! Vimcopy()
    if !has('win32')
        let l:filepath = expand('<sfile>:p:h') . '/distribute.sh'
        let l:result = system("sh ". shellescape(filepath))
        echo 'COPY!'
    endif
endfunction
nnoremap <C-T><C-P> :call Vimcopy()<CR>
nnoremap <C-T>v :source ~/.vimrc<CR>

" Insert Time
nmap <C-T><C-D> <Esc>i<C-r>=strftime("%Y%m%d")<CR><CR>
nmap <C-T><C-T> <Esc>i<C-r>=strftime("%Y%m%d%H%M%S")<CR><CR>

" set directory
let g:fj = '~/Programing/dev/www/figurejudge'
nnoremap <C-M><C-D> :exe 'cd ' . finddir(fj)<CR><CR>

