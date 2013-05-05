":YankMarks [{marks}] [{register}]
"                   Yank all marked (with [a-z] / {marks} marks) lines into
"                   the default register / {register} (in the order of the
"                   marks).
function! s:YankMarks( ... )
    let l:marks = 'abcdefghijklmnopqrstuvwxyz'
    let l:register = '"'
    if a:0 > 2
        echohl ErrorMsg
        echomsg 'Too many arguments'
        echohl None
        return
    elseif a:0 == 2
        let l:marks = a:1
        let l:register = a:2
    elseif a:0 == 1
        if len(a:1) == 1
            let l:register = a:1
        else
            let l:marks = a:1
        endif
    endif

    let l:lines = ''
    let l:yankedMarks = ''
    for l:mark in split(l:marks, '\zs')
        let l:lnum = line("'" . l:mark)
        if l:lnum > 0
            let l:yankedMarks .= l:mark
            let l:lines .= getline(l:lnum) . "\n"
        endif
    endfor

    call setreg(l:register, l:lines, 'V')

    echomsg printf('Yanked %d line%s from mark%s %s',
    \   len(l:yankedMarks),
    \   len(l:yankedMarks) == 1 ? '' : 's',
    \   len(l:yankedMarks) == 1 ? '' : 's',
    \   l:yankedMarks
    \) . (l:register ==# '"' ? '' : ' into register ' . l:register)
endfunction
command! -bar -nargs=* YankMarks call <SID>YankMarks(<f-args>)
