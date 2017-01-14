" ----------------------------------------------------------------------
" vimrc
"
" Author: Shohei Mukai
" Licence: MIT Licence
" ----------------------------------------------------------------------

scriptencoding utf-8

" Read configuration
if filereadable(expand('~/.vimrc.cnf'))
    source ~/.vimrc.cnf
endif

" Encoding
set encoding=utf-8
set fileencoding=utf-8
set fileencodings=utf-8,cp932,euc-jp,sjis,iso-2022-jp
au BufReadPost * if search('\S', 'w') == 0 |
    \ set fileencoding=utf-8 | endif

" Basic
set runtimepath+=~/.vim/
set helplang=ja
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
set history=4000
set cmdheight=2
set tabstop=4
set shiftwidth=4
set autoindent
set smartindent
set expandtab
set softtabstop=4
set noequalalways
 
" Complete
set wildmenu
set wildmode=list,full
set completeopt=menu,preview

" Search
set wrapscan
set incsearch

" Unvisible string
set list
set listchars=tab:^^,extends:>,precedes:<,nbsp:%

" Status
set laststatus=2
set statusline=%F%m%r%h%w\%=
    \[TYPE=%Y]\[FORMAT=%{&ff}]\[ENC=%{&fileencoding}]\[LOW=%l/%L]

nnoremap ZZ <Nop>
nnoremap ZQ <Nop>


" Backup/Swap/Undo
" **Attension! You make directory with your hand.**
set directory=~/.vim/var/swap
set backupdir=~/.vim/var/backup
set undodir=~/.vim/var/undo

" Hilight current line
augroup cch
  autocmd! cch
  autocmd CursorMoved,CursorMovedI,WinLeave * setlocal nocursorline
  autocmd CursorHold,CursorHoldI * setlocal cursorline
augroup END

" Double Space highlight
augroup highlightDoubleByteSpace
  autocmd!
  autocmd VimEnter,Colorscheme * highlight DoubleByteSpace cterm=underline
    \ ctermfg=Green gui=reverse guifg=Green
  autocmd VimEnter,WinEnter * match DoubleByteSpace /　/
augroup END

" Seach option
xnoremap * :<C-u>call <SID>VSetSearch()<CR>/<C-R>=@/<CR><CR>
xnoremap # :<C-u>call <SID>VSetSearch()<CR>?<C-R>=@/<CR><CR>
function! s:VSetSearch()
    let l:temp = @s
    norm! gv"sy
    let @/ = '\V' . substitute(escape(@s, '/\'), '\n', '\\n', 'g')
    let @s = l:temp
endfunction


" *****************************************************************
" *****************************************************************
" *****************************************************************
" Load development setting(This change to plugin?)
augroup vimrc-local
    autocmd!
    autocmd BufNewFile, BufReadPost * call s:vimrc_local(
        \ expand('<afile>:p:h'))
augroup END

function! s:vimrc_local(loc)
    let files = findfile('plugin-import.vim', escape(a:loc, ' ') . ';', -1)
    for i in reverse(filter(files, 'filereadable(v:val)'))
        source `=i`
    endfor
endfunction

" This is for confirm of function s:vimrc_loal
function! DevTest()
    let dirdir = expand('<afile>:p:h')
    call s:vimrc_local(expand('<afile>:p:h'))
endfunction

" Developnemt tool
function! Vimcopy()
    if has('win32')
        echo 'Your machine is unsupported'
        return
    endif
    let l:filename = expand('%')
    if l:filename !=# 'vimrc' && l:filename !=# 'gvimrc'
        echo 'Your file is not vim setting file'
        return
    endif
    let l:filepath = expand('%:p')
    execute 'silent !cp ' l:filepath . ' ~/.' . l:filename
    echo 'Copy Your' l:filename . '.'
endfunction

if exists('g:python_path')
    nnoremap <C-T><C-O> :call GetPyFile()<CR>
endif

" mouse scrolling
set mouse=a
set ttymouse=xterm2

" Key mapping
inoremap # X#

" Load all vim plugin from dein.
let g:my_plugin_load = 1
if g:my_plugin_load == 1
    let s:plugin_path = fnamemodify(expand('<sfile>'), ':h'
        \ ) . '/.vim/pluginload.vim'
    " below is same with `source ~/.vim/pluginload.vim`
    execute 'source' s:plugin_path
endif
 
"""" ???????????????? """""""
" For snippet_complete marker.
if has('conceal')
  set conceallevel=2
  set concealcursor=niv
endif
