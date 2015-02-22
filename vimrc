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
set cmdheight=2
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
        source $VIM/plugins/kaoriya/encode_japan.vim
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
NeoBundle 'scrooloose/syntastic'
NeoBundle 'grep.vim'
NeoBundle 'surround.vim'
NeoBundle 'thinca/vim-quickrun'
NeoBundle 'Shougo/unite.vim'
NeoBundle 'Shougo/vimfiler.vim'
NeoBundle 'open-browser.vim'
NeoBundle 'tpope/vim-fugitive'
NeoBundle 'altercation/vim-colors-solarized'
NeoBundle 'thinca/vim-ref'
NeoBundle 'Shougo/neocomplcache'
NeoBundle 'Shougo/neosnippet'
NeoBundle 'kannokanno/unite-todo'

call neobundle#end()
NeoBundleCheck

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
nnoremap q: :q<CR>

" Key mapping in Unite.vim
nnoremap [unite] <Nop>
nmap     <Space>u [unite]
nnoremap <silent> [unite]b :Unite buffer<CR>
nnoremap <silent> [unite]f :Unite file<CR>
nnoremap <silent> [unite]d :Unite directory<CR>
nnoremap <silent> [unite]t :Unite tab<CR>
nnoremap <silent> [unite]l :Unite bookmark<CR>
nnoremap <silent> [unite]a :UniteBookmarkAdd<CR>
nnoremap <silent> [unite]c :UniteWithBufferDir -buffer-name=files file<CR>

" Key mapping in vimfiler.vim
nnoremap [filer] <Nop>
nmap     <Space>f [filer]
nnoremap <silent> [filer]f :VimFiler<CR>
nnoremap <silent> [filer]e :VimFilerExplore<CR>
let g:vimfiler_enable_auto_cd = 1

" Opne browser setting
let g:netrw_nogx = 1
nmap gx <Plug>(openbrowser-smart-search)
vmap gx <Plug>(openbrowser-smart-search)

" NeoCompleteCache
let g:neocomplcache_enable_at_startup = 1
"NeoComplCacheEnable

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

" window control
let g:window_num = 1
function! Wide_window()
    let g:window_num += 1
    let l:column_base = 80
    let l:column_size = l:column_base * g:window_num
    vs
    let &l:columns = l:column_size
endfunction
nmap <C-T><C-V> :call Wide_window()<CR><C-w>=
function! Tiny_window()
    let g:window_num -= 1
    let l:column_base = 80
    let l:column_size = l:column_base * g:window_num
    w
    bd
    let &l:columns = l:column_size
endfunction
nmap <C-T><C-N> :call Tiny_window()<CR><C-w>=

" move current dir
function! MoveCurrentDir()
    lcd %:p:h
endfunction
nnoremap <C-D>c :call MoveCurrentDir()<CR>

" Open python import file
let g:python_path = '/Users/mukaishohei/Programing/dev/www/figurejudge'
let g:current_file_dir = ''
function! GetCurLine()
    let l:line_num = line('.')
    let l:cur_string = getline(l:line_num)
    let l:line_len = strlen(l:cur_string)
    let l:last_string = l:cur_string[l:line_len-1]
    let l:forms = []
    if l:last_string == '\'
        let l:next_string = getline(l:line_num +1)
        let l:imp_string = l:cur_string[:l:line_len-2] . l:next_string
    else
        let l:imp_string = l:cur_string
    endif
    let l:imp_list = split(l:imp_string, ' ')
    let l:dict = {}
    let l:num = 0
    for l:e in l:imp_list
        if l:e == 'from'
            let l:dict['from'] = l:imp_list[l:num +1]
        endif
        if l:e == 'import'
            let l:dict['import'] = l:imp_list[l:num +1]
        endif
        let l:num += 1
    endfor
    if has_key(l:dict, 'from')
        let l:froms = split(l:dict['from'], '\.')
    endif
    if !has_key(l:dict, 'import')
        echo 'no file'
        return
    endif

    let l:python_path = expand('%:h')
    if len(l:forms) > 0
        for l:e in l:froms
            let l:org_path = l:python_path
            let l:python_path = l:python_path . '/' . l:e
            if !isdirectory(l:python_path)
                let l:py_file = l:python_path . '.py'
                if filereadable(l:py_file)
                    exe 'e ' . findfile(l:py_file)
                    return
                endif
            endif
        endfor
    endif
    let l:py_file = l:python_path . '/' . l:dict['import'] . '.py'
    if filereadable(l:py_file)
        exe 'e ' . findfile(l:py_file)
        return
    endif

    let l:python_path = g:python_path
    for l:e in l:froms
        let l:org_path = l:python_path
        let l:python_path = l:python_path . '/' . l:e
        if !isdirectory(l:python_path)
            let l:py_file = l:python_path . '.py'
            if filereadable(l:py_file)
                exe 'e ' . findfile(l:py_file)
            else
                echo 'no file'
            endif
            return
        endif
    endfor
    let l:py_file = l:python_path . '/' . l:dict['import'] . '.py'
    echo l:py_file
    if filereadable(l:py_file)
        exe 'e ' . findfile(l:py_file)
    else
        echo 'no file'
    endif
endfunction
nnoremap <C-T><C-R> :call GetCurLine()<CR>

" Company
let g:is_company = 0
if g:is_company == 1
    inoremap <S-Tab> <C-V><Tab>
    set colorcolumn=80
    noremap <C-J> <ESC>
    inoremap <C-J> <ESC>
endif

