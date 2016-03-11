" ----------------------------------------------------------------------
" vimrc
"
" Author: Shohei Mukai
" Licence: MIT Licence
" ----------------------------------------------------------------------

scriptencoding utf-8

" Reload gvimrc (in developint mode)
if exists("g:loaded_vimrc") && g:loaded_vimrc == 1 && has("gui") && !has("win32")
    source ~/.gvimrc
elseif has("gui")
    colorscheme desert
endif

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
set history=2000
set cmdheight=2
set tabstop=4
set shiftwidth=4
set autoindent
set smartindent
set expandtab
set softtabstop=4
inoremap # X#

" Buckup
set nobackup
set noswapfile
set noundofile

" Complete
set wildmenu
set wildmode=list,full
set completeopt=menuone

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

" Gui window
if has('kaoriya')
    if has('unix')
        set transparency=10
        set imdisable
    elseif has('win32') || has("gui")
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

" Double Space highlight
augroup highlightDoubleByteSpace
  autocmd!
  autocmd VimEnter,Colorscheme * highlight DoubleByteSpace cterm=underline
    \ ctermfg=Green gui=reverse guifg=Green
  autocmd VimEnter,WinEnter * match DoubleByteSpace /　/
augroup END

" *****************************************************************
" Load development setting(This change to plugin?)
" *****************************************************************
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

if !exists("g:loaded_vimrc")
    call s:vimrc_local(getcwd())
    let g:loaded_vimrc = 1
endif
" ****************************************************************


" Check weather neocomplete or neocomplcache
function! s:isNeocomplete()
    return has('lua') && (v:version > 703 || (v:version == 703
        \ && has('patch885')))
endfunction

" NeoBundle Settings
filetype off
if &compatible
  set nocompatible
endif
"set runtimepath+=~/.vim/dein/repos/github.com/Shougo/dein.vim

"-----------------------------------------------------------------------------
" deain test
let s:dein_dir = expand('~/.vim/dein')
let s:dein_repo_dir = s:dein_dir . '/repos/github.com/Shougo/dein.vim'

" 
if &runtimepath !~# '/dein.vim'
  if !isdirectory(s:dein_repo_dir)
    execute '!git clone https://github.com/Shougo/dein.vim' s:dein_repo_dir
  endif
  execute 'set runtimepath^=' . fnamemodify(s:dein_repo_dir, ':p')
endif

"set runtimepath+=~/.vim/dein/repos/github.com/Shougo/dein.vim

"call dein#begin(expand('~/.cache/dein'))
"call dein#begin(expand('~/.vim/dein'))
call dein#begin(s:dein_dir)

let s:toml = '~/.vim/dein.toml'
"let s:lazy_toml = '~/.vim/dein/dein.toml'

"if dein#load_cache([expand('<sfile>'), s:toml, s:lazy_toml])
if dein#load_cache([expand('<sfile>'), s:toml])
  call dein#load_toml(s:toml,      {'lazy': 0})
"  call dein#load_toml(s:lazy_toml, {'lazy': 1})
  call dein#save_cache()
endif

"
"call dein#add('~/.vim/dein/repos/github.com/Shougo/dein.vim ')
"call dein#add('Shougo/dein.vim')
"" Use ??
"call dein#add('Shougo/vimproc.vim', {
"    \ 'build': {
"    \     'windows': 'tools\\update-dll-mingw',
"    \     'cygwin': 'make -f make_cygwin.mak',
"    \     'mac': 'make -f make_mac.mak',
"    \     'linux': 'make',
"    \     'unix': 'gmake',
"    \    },
"    \ })
"
"call dein#add('scrooloose/syntastic')
"call dein#add('surround.vim')
"call dein#add('thinca/vim-quickrun')
"call dein#add('thinca/vim-ref')
"call dein#add('Shougo/unite.vim')
"call dein#add('Shougo/vimfiler.vim')
"if s:isNeocomplete()
"    call dein#add('Shougo/neocomplete')
"else
"    call dein#add('Shougo/neocomplcache')
"endif
"call dein#add('Shougo/neosnippet')
"call dein#add('Shougo/neosnippet-snippets')
"call dein#add('honza/vim-snippets')
"call dein#add('mattn/webapi-vim')
"call dein#add('fatih/vim-go')
"call dein#add('pyohei/vim-pyimporter')
"call dein#add('pyohei/vim-hipchat')
"call dein#add('pyohei/vim-bunshin')
"call dein#add('fatih/vim-go')
"call dein#add('tpope/vim-fugitive')
"call dein#add('vim-scripts/Align')
"call dein#add('pangloss/vim-javascript')
"call dein#add('mattn/emmet-vim')
"call dein#add('JulesWang/css.vim')
"call dein#add('gorodinskiy/vim-coloresque')
"call dein#add('open-browser.vim')
"call dein#add('ctrlpvim/ctrlp.vim')
"call dein#add('mhartington/oceanic-next')
"
"
"
call dein#end()

if dein#check_install()
  call dein#install()
endif


"if has('vim_starting')
"    set runtimepath+=~/.vim/bundle/neobundle.vim/
"    call neobundle#begin(expand('~/.vim/bundle/'))
"endif
"
"NeoBundleFetch 'Shougo/neobundle.vim'
"
"" Windows settings (in setting command path myselr)
"if !executable(g:neobundle#types#git#command_path)
"  source ~/.vimrc.command
"endif

"NeoBundle 'scrooloose/syntastic'
"NeoBundle 'surround.vim'
"NeoBundle 'thinca/vim-quickrun'
"NeoBundle 'thinca/vim-ref'
"NeoBundle 'Shougo/unite.vim'
"NeoBundle 'Shougo/vimfiler.vim'
"if s:isNeocomplete()
"    NeoBundle 'Shougo/neocomplete'
"else
"    NeoBundle 'Shougo/neocomplcache'
"endif
"NeoBundle 'Shougo/neosnippet'
"NeoBundle 'Shougo/neosnippet-snippets'
"NeoBundle 'honza/vim-snippets'
"NeoBundle 'mattn/webapi-vim'
"NeoBundle 'fatih/vim-go'
"NeoBundle 'pyohei/vim-pyimporter'
"NeoBundle 'pyohei/vim-hipchat'
"NeoBundle 'pyohei/vim-bunshin'
"NeoBundle 'fatih/vim-go'
"NeoBundle 'tpope/vim-fugitive'
"NeoBundle 'vim-scripts/Align'
"NeoBundle 'pangloss/vim-javascript'
"NeoBundle 'mattn/emmet-vim'
"NeoBundle 'JulesWang/css.vim'
"NeoBundle 'gorodinskiy/vim-coloresque'
"NeoBundle 'open-browser.vim'
"NeoBundle 'ctrlpvim/ctrlp.vim'
"NeoBundle 'mhartington/oceanic-next'

"call neobundle#end()
"NeoBundleCheck

" file setting
filetype on
filetype plugin on
syntax on

" mouse scrolling
set mouse=a
set ttymouse=xterm2

" python syntax check
let g:syntastic_python_checkers = ['pyflakes', 'pep8']

" Key mapping
nnoremap <silent> <Esc><Esc> :nohlsearch<CR>
inoremap <silent> jj <Esc>
nnoremap <silent> j gj
nnoremap <silent> k gk
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
nnoremap <silent> [filer]d :VimFilerCurrentDir<CR>
nnoremap <silent> [filer]e :VimFilerExplore<CR>
let g:vimfiler_enable_auto_cd = 1

" pyimporter(my Plugin)
nnoremap [pyimporter] <Nop>
nmap     <Space>p [pyimporter]
nnoremap <silent> [pyimporter]i :PyImport

" Opne browser setting
let g:netrw_nogx = 1
nmap gx <Plug>(openbrowser-smart-search)
vmap gx <Plug>(openbrowser-smart-search)

nnoremap ZZ <Nop>
nnoremap ZQ <Nop>

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
nnoremap <silent> <C-T><C-P> :call Vimcopy()<CR>
nnoremap <C-T>v :source ~/.vimrc<CR>

" Insert Time
nmap <C-T><C-D> <Esc>i<C-r>=strftime("%Y%m%d")<CR><CR>
nmap <C-T><C-T> <Esc>i<C-r>=strftime("%Y%m%d%H%M%S")<CR><CR>

" set directory
if exists('g:fj')
    nnoremap <C-M><C-D> :exe 'cd ' . finddir(fj)<CR><CR>
endif

" Move current dir
nnoremap <C-D>c :lcd %:p:h

" vim development
if exists('g:python_path')
    nnoremap <C-T><C-O> :call GetPyFile()<CR>
endif


" neosnippet test
imap <C-k>     <Plug>(neosnippet_expand_or_jump)
smap <C-k>     <Plug>(neosnippet_expand_or_jump)
xmap <C-k>     <Plug>(neosnippet_expand_target)

" SuperTab like snippets behavior.
imap <expr><TAB> neosnippet#expandable_or_jumpable() ?
\ "\<Plug>(neosnippet_expand_or_jump)"
\: pumvisible() ? "\<C-n>" : "\<TAB>"
smap <expr><TAB> neosnippet#expandable_or_jumpable() ?
\ "\<Plug>(neosnippet_expand_or_jump)"
\: "\<TAB>"

" For snippet_complete marker.
if has('conceal')
  set conceallevel=2
  set concealcursor=niv
endif

" Setting neocomplete and neocomplcache
if s:isNeocomplete()
    let g:acp_enableAtStartup = 0
    let neocomplete#enable_at_startup = 1
    let g:neocomplete#enable_smart_case = 1
    let g:neocomplete#sources#syntax#min_keyword_length = 3
    let g:neocomplete#sources#dictionary#dictionaries = {
        \ 'default' : '',
        \ 'vimshell' : $HOME.'/.vimshell_hist',
        \ 'scheme' : $HOME.'/.gosh_completions'
        \ }
    if !exists('g:neocomplete#keyword_patterns')
        let g:neocomplete#keyword_patterns = {}
    endif
    let g:neocomplete#keyword_patterns['default'] = '\h\w*'

    " If you complete first candidate, you should <C-y>!
    inoremap <expr><C-g>     neocomplete#undo_completion()
    inoremap <expr><C-l>     neocomplete#complete_common_string()
    inoremap <silent> <CR> <C-r>=<SID>my_cr_function()<CR>
    function! s:my_cr_function()
      return neocomplete#close_popup() . "\<CR>"
    endfunction
    inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"
    inoremap <expr><C-h>  neocomplete#smart_close_popup()."\<C-h>"
    inoremap <expr><BS>   neocomplete#smart_close_popup()."\<C-h>"
    inoremap <expr><C-y>  neocomplete#close_popup()
    inoremap <expr><C-e>  neocomplete#cancel_popup()
    let g:neocomplete#enable_auto_select = 1

    autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
    autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
    autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
    autocmd FileType python setlocal omnifunc=pythoncomplete#Complete
    autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags

    " Enable heavy omni completion.
    if !exists('g:neocomplete#sources#omni#input_patterns')
      let g:neocomplete#sources#omni#input_patterns = {}
    endif
else
    let g:acp_enableAtStartup = 0
    let g:neocomplcache_enable_at_startup = 1
    let g:neocomplcache_enable_smart_case = 1
    let g:neocomplcache_min_syntax_length = 3
    let g:neocomplcache_dictionary_filetype_lists = {
        \ 'default' : '',
        \ 'vimshell' : $HOME.'/.vimshell_hist',
        \ 'scheme' : $HOME.'/.gosh_completions'
        \ }
    if !exists('g:neocomplcache_keyword_patterns')
        let g:neocomplcache_keyword_patterns = {}
    endif
    let g:neocomplcache_keyword_patterns['default'] = '\h\w*'
    inoremap <expr><C-g>     neocomplcache#undo_completion()
    inoremap <expr><C-l>     neocomplcache#complete_common_string()
    inoremap <silent> <CR> <C-r>=<SID>my_cr_function()<CR>
    function! s:my_cr_function()
      return neocomplcache#smart_close_popup() . "\<CR>"
    endfunction
    " <TAB>: completion.
    inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"
    inoremap <expr><C-h> neocomplcache#smart_close_popup()."\<C-h>"
    inoremap <expr><BS> neocomplcache#smart_close_popup()."\<C-h>"
    inoremap <expr><C-y>  neocomplcache#close_popup()
    inoremap <expr><C-e>  neocomplcache#cancel_popup()
    let g:neocomplcache_enable_auto_select = 1

    " Enable omni completion.
    autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
    autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
    autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
    autocmd FileType python setlocal omnifunc=pythoncomplete#Complete
    autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags

    " Enable heavy omni completion.
    if !exists('g:neocomplcache_force_omni_patterns')
      let g:neocomplcache_force_omni_patterns = {}
    endif
endif

autocmd FileType python setlocal completeopt-=preview

" confirm wheather NeoCompleteCache
function! IsNeocomplete()
    let isneo = has('lua') && (v:version > 703 || (v:version == 703
        \ && has('patch885')))
    echo isneo
    return isneo
endfunction

vmap X y/<C-r>"<CR>
xnoremap * :<C-u>call <SID>VSetSearch()<CR>/<C-R>=@/<CR><CR>
xnoremap # :<C-u>call <SID>VSetSearch()<CR>?<C-R>=@/<CR><CR>

function! s:VSetSearch()
    let l:temp = @s
    norm! gv"sy
    let @/ = '\V' . substitute(escape(@s, '/\'), '\n', '\\n', 'g')
    let @s = l:temp
endfunction

" ===== Golang Settings ======
set runtimepath+=$GOROOT/misc/vim

let g:go_highlight_functions = 1
let g:go_highlight_methods = 1
let g:go_highlight_structs = 1

autocmd FileType go autocmd BufWritePre <buffer> Fmt
exe "set rtp+=".globpath($GOPATH, "src/github.com/nsf/gocode/vim")
set completeopt=menu,preview

" =====================================================
" Someday make plugin
" =====================================================

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

" Load unique config (Testing)
function! LoadUniqueConfig()
    if filereadable(expand('~/.vimrc.uni1'))
        source ~/.vimrc.uni1
    else
        echo 'No config File!'
    endif
endfunction
nnoremap <silent> <Space>mono :call LoadUniqueConfig()<CR>
