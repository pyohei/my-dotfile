" ***********************************************************************
" Vi 非互換モード
" ***********************************************************************
set nocompatible


" ***********************************************************************
" 基本設定
" -----------------------------------------------------------------------
"   fileencoding                    encoding設定
"   number                          行番号
"   laststatus                      ステータス行を常に表示
"   cmdheight                       コマンドラインに使われる行数
"   showmatch                       括弧の対応先を表示
"   backupdir                       バックアップファイルの場所
"   scrolloff                       カーソル上下の表示行数
"   hidden                          未保存で他のファイルの閲覧可能に
"   noswapfile                      スワップファイルの作成をしない
"   backspace=indent,eol,start      バックスペース削除可能設定
"   shwowhich                       コマンドを画面の最下行に表示
"   ruler                           コマンドが何行目にあるかを表示
"   formatoptions                   自動整形方法
"   tw                              改行位置
" ----------------------------------------------------------------------
" 未使用
"   nobackup                        バックアップファイルの作成をしない
"   browsedir                       ファイルの検索方法設定
"   whichwrap
"   showmode
"   showmodeline
"   mouse=a
" ---------------------------------------------------------------------
set fileencoding=utf-8
set number
set laststatus=2
set cmdheight=2
set showmatch
set autoread
set hidden
set noswapfile
set scrolloff=3
set hidden
set backspace=indent,eol,start
set showcmd
set ruler
set backupdir=~/.backup
set formatoptions=q
set tw=0


" **********************************************************************
" 補完機能
" ----------------------------------------------------------------------
"   wildmenu                        補完候補の表示
"   wildmode                        補完モード
"   completeopt                     自動補完機能
"   --------------------------------------------------------------------
"   for...                          文字列をリストに変換
"   exec...                         挿入モード時に補完開始
" **********************************************************************
set wildmenu
set wildmode=list:full              " 全ての候補を網羅、最初を補完
set completeopt=menuone
for k in split("abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ_",'\zs')
  exec "imap " . k . " " . k . "<C-N><C-P>"
endfor
imap <expr> <TAB> pumvisible() ? "\<Down>" : "\<Tab>"


" **********************************************************************
" カレントウインドウ表示
" **********************************************************************
augroup cch
  autocmd! cch
  autocmd WinLeave * set nocursorline
  "autocmd WinLeave * set nocursorcolumn
  autocmd WinEnter,BufRead * set cursorline
  "autocmd WinEnter,BufRead * set cursorcolumn
augroup END


" **********************************************************************
" 検索機能
" ----------------------------------------------------------------------
"   wrapkscan                        現在カーソル位置から検索開始
"   incsearch                       検索をsuggest
" **********************************************************************
set wrapscan
set incsearch


" **********************************************************************
" 不可視文字の設定
" ----------------------------------------------------------------------
"   list                            Listモード
"   listchars                       不可視文字の表示
" ----------------------------------------------------------------------
set list
set listchars=tab:^^,extends:»,precedes:«,nbsp:%


" ----------------------------------------------------------------------
" 保存時に行末の空白除去
" ----------------------------------------------------------------------
autocmd BufWritePre * :%s/\s\+$//e


" **********************************************************************
" 拡張子未指定のタブ設定
" --------------------------------------------------------------------
"   tabstop                         <Tab>文字の空白数
"   autoindent                      改行時に同じ量のインデントに
"   smartindent                     高度なインデント
"   shiftwidth                      <Tab>押下時の空白数
"   expandtab                       <Tab>押下時にスペースを挿入
"   softtabstop                     <Tab>押下時の空白量
"   noexpandtab(noet)               expandtabの逆
"   * expandtab設定時にタブを挿入する方法...Ctrl-v + <Tab>
" *********************************************************************
set tabstop=4                           " おそらく会社では8
set shiftwidth=4
set autoindent
set smartindent
set expandtab
set softtabstop=4                       " 会社では8


" *********************************************************************
" 全角スペース挿入時の操作
" ********************************************************************
scriptencoding utf-8
augroup highlightDoubleByteSpace
  autocmd!
  " 全角スペースのハイライト指定
  " --メモ--
  "  cterm  underline or reverse
  "autocmd VimEnter,Colorscheme * highlight DoubleByteSpace cterm=underline ctermfg=darkgrey gui=underline guifg=darkgrey
  autocmd VimEnter,Colorscheme * highlight DoubleByteSpace cterm=underline ctermfg=darkgrey gui=reverse guifg=blue
  autocmd VimEnter,WinEnter * match DoubleByteSpace /　/
augroup END


" 何に使っているか不明
"execute pathogen#infect()

" ********************************************************************
" ファイル別設定
" --------------------------------------------------------------------
"   filetype on                     ファイル形式別設定
"   filetype plugin on              ファイル別プラグインオン
"   syntax on                       文法チェエクオン
"   runtimepath                     分割した設定ファイルを読み込む
"---------------------------------------------------------------------
filetype on
filetype plugin on
syntax on
set runtimepath+=~/.vim/
" 特定のフォルダ下のロードファイルを読み込む
" runtime! userautoload/*.vim

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


" ---- ファイル別設定 ------

" python
autocmd FileType python setl autoindent
autocmd FileType python setlocal smartindent cinwords=
    \if,elif,else,for,while,with,try,except,finally,def,class
autocmd FileType python setl tabstop=8 expandtab shiftwidth=4 softtabstop=4

" html
autocmd FileType html setl autoindent
autocmd FileType html setl tabstop=8 expandtab shiftwidth=2 softtabstop=2

" css
autocmd FileType css setl autoindent
autocmd FileType css setl tabstop=8 expandtab shiftwidth=2 softtabstop=2

" javascript
autocmd FileType javascript setl autoindent
autocmd FileType javascript setl tabstop=8 expandtab shiftwidth=4 softtabstop=4


" ---- ヘルプテキストの日本語化 ----
set helplang=ja

"---------------------------
" Start Neobundle Settings.
"---------------------------
set runtimepath+=~/.vim/bundle/neobundle.vim/

" Required:
call neobundle#begin(expand('~/.vim/bundle/'))

" neobundle自体をneobundleで管理
NeoBundleFetch 'Shougo/neobundle.vim'
NeoBundle 'scrooloose/nerdtree'
NeoBundle 'grep.vim'
NeoBundle "scrooloose/syntastic"
NeoBundle "davidhalter/jedi-vim"

call neobundle#end()

" Required:
filetype plugin indent on

NeoBundleCheck

"-------------------------
" End Neobundle Settings.
"-------------------------

" jedi-vim のポップアップを非表示にする
let g:jedi#popup_select_first = 0

" 関数/メソッドの定義を非表示
let g:jedi#show_call_signatures = 0

" 自動で補完しない
let g:jedi#auto_vim_configuration = 0

let g:jedi#use_tabs_not_buffers = 0

let g:jedi#popup_on_dot = 0

let g:jedi#rename_command = "<leader>??????"

" 定型文挿入
:inoreabbrev pyheader #!/usr/local/bin/python<CR># -*- coding: utf-8 -*-

" iTerm上でマウスのスクロールを可能に
set mouse=a
set ttymouse=xterm2

if has('kaoriya')
    set transparency=20
    set imdisable
endif

"以下は途中で断念
"inoremap <C-u> <C-R>=InsertComment()<CR>
"inoremap <C-y> <C-v><Tab><Esc>:call InsertTab()<CR>
"inoremap <C-y> <C-v><Tab><C-R>=InsertComment()<CR>
func! InsertComment()
    let curnum = col('.')
    echo curnum
    if curnum < 79
        "let curnum += 20
        return ''
    endif
    return '# '
endfunc

func! InsertTab()
    let curnum = col('.')
    while curnum < 80
        call setline('.', '&&&')
        call substitute('&&&', 'ddddd')
        let curnum += col('.')
        echo curnum
    endwhile
    return ''
endfunc
