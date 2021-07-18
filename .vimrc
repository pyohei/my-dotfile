scriptencoding utf-8

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
syntax enable
 
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
  autocmd! highlightDoubleByteSpace
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

" mouse scrolling
set mouse=a
set ttymouse=xterm2

" minpac
if &compatible
  set nocompatible
endif

packadd minpac

call minpac#init()

" minpac must have {'type': 'opt'} so that it can be loaded with `packadd`.
call minpac#add('k-takata/minpac', {'type': 'opt'})

" Add other plugins here. call minpac#update()
call minpac#add('gryf/wombat256grf')
call minpac#add('tpope/vim-fugitive')
call minpac#add('prabirshrestha/vim-lsp')
call minpac#add('mattn/vim-lsp-settings')
call minpac#add('posva/vim-vue')
call minpac#add('ctrlpvim/ctrlp.vim')

" Color Scheme
colorscheme wombat256grf

