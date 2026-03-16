" *                     COMMENTS VIM PLUGIN                           
" *********************************************************************
" AUTHOR:       Copyright (C) 2024-2025 Yassin Achengli
" DESCRIPTION:  This plugin was made for commenting selected text in 
"                   different programming languages and file types.
"
"               It's customizable in order to increase the support
"               of more file types.
" *********************************************************************

let s:CommentERROR          = 0
let s:CommentOK             = 1
let s:CommentUNDEFINED      = 2
let s:CommentNOT_SUPORTED   = 3
 
" Include functional.vim vimscript library
let s:script_dir = expand('<sfile>:p:h')
execute 'source ' fnameescape(s:script_dir . '/extensions.vim')

function comments#strToRegex(str)
    return escape(a:str, '[]()-+*')
endfunction

function! comments#newSyntaxComment (ftype, extension, single_comment, multiple_comment=-1)
    " Adds an entry to g:g:comments#extensions
    if (type(a:ftype) != type('') || type(a:extension) != type('') 
                \|| type(a:single_comment) != type('') ||
                \(type(a:multiple_comment) != type([]) 
                \&& type(a:multiple_comment) != type(-1)))
        echoerr 'comments#addFormat: wrong input data type'
        return s:CommentERROR
    endif

    if type(a:multiple_comment) == type([])
        if type(a:multiple_comment[0]) != type('') || type(a:multiple_comment[1]) != type('')
            echoerr 'comments#set_format: wrong input data type'
            return s:CommentERROR
        endif
    endif

    let g:comments#extensions[a:ftype] = {'extension': a:extension, 'single': a:single_comment,
                \'multiple': a:multiple_comment}
    return s:CommentOK
endfunc

function! comments#commentLine (line_pos)
    let l:line    = getline(a:line_pos)
    call setline(a:line_pos, (g:comments#extensions[&filetype]['single']) . " " .  l:line)
endfunction

function! comments#commentBlock (line_start, line_end)
    let l:idx     = a:line_start

    if has_key(g:comments#extensions[&filetype], "multiple")
        call setline(a:line_start, g:comments#extensions[&filetype]["multiple"][0]
                    \ . getline(a:line_start))
        
        call setline(a:line_end, getline(a:line_end)
                    \ . g:comments#extensions[&filetype]["multiple"][1])
    else
        while l:idx <= a:line_end
            call comments#commentLine (l:idx)
            let l:idx += 1
        endwhile
    endif
endfunction

function! comments#commentVisualBlock ()
    call comments#commentBlock(getpos("'<")[1], getpos("'>")[1])
endfunction

function! comments#uncommentLine (line)
    call setline(a:line, substitute(getline(a:line), "^" .
                \ comments#strToRegex(g:comments#extensions[&filetype]["single"]),
                \ "", ""))
endfunction

function! comments#uncommentBlock (start, end)
    let l:idx         = a:start
    let l:reachStart  = v:false
    let l:reachEnd    = v:false

    if (!has_key(g:comments#extensions[&filetype], "multiple"))
        while l:idx <= a:end
            if (match(getline(l:idx), "^" . 
                        \comments#strToRegex(g:comments#extensions[&filetype]["single"]))) != -1
                call setline(l:idx, substitute(getline(l:idx), "^" .
                            \ comments#strToRegex(g:comments#extensions[&filetype]["single"]), "", ""))
            endif
            let l:idx += 1
        endwhile
        return
    endif

    while l:idx <= a:end
        if (match(getline(l:idx), "^" . 
                    \ comments#strToRegex(g:comments#extensions[&filetype]["multiple"][0]))) != -1
            call setline(l:idx, substitute(getline(l:idx),  "^" . 
                    \ comments#strToRegex(g:comments#extensions[&filetype]["multiple"][0]), "", ""))
            let l:reachStart = v:true
            break
        endif
        let l:idx += 1
    endwhile
    
    while l:idx <= a:end
        if (match(getline(l:idx), 
                    \ comments#strToRegex(g:comments#extensions[&filetype]["multiple"][1]) . "$")) != -1
            call setline(l:idx, substitute(getline(l:idx), 
                    \ comments#strToRegex(g:comments#extensions[&filetype]["multiple"][1]) . "$", "", ""))
            let l:reachEnd = v:true
            break
        endif 
        let l:idx += 1
    endwhile

    return (l:reachStart && l:reachEnd) ? s:CommentOK : s:CommentERROR
endfunction

function! comments#uncommentVisualBlock()
    return comments#uncommentBlock (getpos("'<")[1], getpos("'>")[1])
endfunction

function! comments#comment()
    let l:current_mode = mode()
    
    if (!has_key(g:comments#extensions, &filetype))
        echoerr &filetype . ' not supported'
        return
    endif

    if (getpos("'<")[1] != getpos("'>")[1])
        call comments#commentVisualBlock()
    else
        call comments#commentLine(getpos(".")[1])
    endif
endfunction

function! comments#uncomment()
    let l:current_mode = mode()

    if (!has_key(g:comments#extensions, &filetype))
        echoerr &filetype . ' not supported'
        return
    endif

    if (getpos("'<")[1] != getpos("'>")[1])
        call comments#uncommentVisualBlock()
    else
        call comments#uncommentLine(getpos(".")[1])
    endif
endfunction

vnoremap <silent> <C-s> :<c-u>call comments#comment()<CR>
vnoremap <silent> <C-d> :<c-u>call comments#uncomment()<CR>

nnoremap <silent> <C-s> :<c-u>call comments#commentLine(getpos(".")[1])<CR>
nnoremap <silent> <C-d> :<c-u>call comments#uncommentLine(getpos(".")[1])<CR>
