if !exists("g:loaded_gvimrc")
    set lines=68
    set columns=80
endif

set transparency=10
" Color setting
set background=dark
colorscheme OceanicNext

" Gui window
if has('unix')
    set imdisable
elseif has('win32') || has("gui")
    set transparency=10
    autocmd GUIEnter * set transparency=220
    set guioptions-=m   " hide menu
    set guioptions-=T   " hede tool
    set encoding=cp932
    if has('kaoriya')
        source $VIM/plugins/kaoriya/encode_japan.vim
        source $VIMRUNTIME/delmenu.vim
        set langmenu=ja_jp.utf-8
        source $VIMRUNTIME/menu.vim
    endif
endif
