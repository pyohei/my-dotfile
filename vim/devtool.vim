" Vim development tool setting.
" But, it donen't maintain for logn time...
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
