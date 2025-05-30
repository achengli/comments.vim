" * COMMENTS VIM PLUGIN * 
" *********************************************************************
" Author: Yassin Achengli
" Email: achengli@github.com
" Description: This plugin was made for commenting selected text in 
" different programming languages and file types.
"
" It's customizable in order to increase the support of more file
" types.
" *********************************************************************

let g:comments#extensions = {
      \'c': {'extension': 'c|h', 'single': '//', 'multiple': ['/*','*/']},
      \'cpp': {'extension': 'cpp|cc|hpp|h', 'single': '//', 'multiple': ['/*','*/']},
      \'lua': {'extension': 'lua', 'single': '--', 'multiple': ['--[[',']]']},
      \'matlab': {'extension': 'm', 'single': '%', 'multiple': -1},
      \'octave': {'extension': 'm', 'single': '%', 'multiple': -1},
      \'python': {'extension': 'py', 'single': '#', 'multiple': -1},
      \'vim': {'extension': 'vim', 'single': '"', 'multiple': -1},
      \}

let g:comments#always_single = v:false

function! comments#add_format(ftype, extension, single_comment, multiple_comment=-1)
  " Adds an entry to g:comments#format
  if (type(a:ftype) != type('') || type(a:extension) != type('') 
        \|| type(a:single_comment) != type('') ||
        \(type(a:multiple_comment) != type([]) 
        \&& type(a:multiple_comment) != type(-1)))
    echoerr 'comments#add_format: wrong input data type'
    return v:false
  endif

  if type(a:multiple_comment) == type([])
    if type(a:multiple_comment[0]) != type('') || type(a:multiple_comment[1]) != type('')
      echoerr 'comments#set_format: wrong input data type'
      return v:false
    endif
  endif

  let g:comments#extensions[a:ftype] = {'extension': a:extension, 'single': a:single_comment,
        \'multiple': a:multiple_comment}
  return v:true
endfunc

let s:script_dir = expand('<sfile>:p:h')
execute 'source ' fnameescape(s:script_dir . '/functional.vim')

function! comments#comment()
  " Comment a block of code (visual mode)
  " The commented block could be commented using in line comments or block
  " comments depending if the file type supports block comments and if the
  " variable comments#always_single is defined as true.
  "
  " To add support for more different syntax, see :h comments#add_format
  let line_start = getpos("'<")[1]
  let line_end = getpos("'>")[1]
  let lines = getline(line_start, line_end)
  if !g:comments#extensions->has_key(&filetype)
    echoerr 'comments#comment: file not supported'
    return v:false
  endif

  let single_comment = g:comments#extensions[&filetype].single
  let mult_comment = g:comments#extensions[&filetype].multiple

  let l:single = v:true
  try
    if mult_comment == -1 || g:comments#always_single
      let l:single = v:true
    endif
  catch
    let l:single = v:false
  endtry

  function! Count_blank(s)
    let c = 0
    for k in a:s
      if k == ' '
        let c += 1
      else
        return c
      endif
    endfor 
    return c
  endfunc

  if abs(line_end - line_start) == 0 " Only one line marked
    call setline(line_start, substitute(lines[0], '^\( *\)', '\1' . single_comment . '', 'g'))
  else
    if l:single
      let max_white_space=(1/0)

      for l in lines
        if Count_blank(l) < max_white_space && strlen(l) > 0
          let max_white_space = Count_blank(l)
        endif
      endfor

      for [idx, line] in functional#enumerate(lines)
        if strlen(line) > 0 && match(line, '^ *' . single_comment) == -1
          if max_white_space == 0
            call setline(line_start + idx, single_comment . ' ' .
                  \line)
          else
            call setline(line_start + idx, line[0:max_white_space-1] . single_comment . ' ' .
                  \line[max_white_space:len(line)-1])
          endif
        endif
      endfor
    else
      call setline(line_start, mult_comment[0] . ' ' . lines[0])
      call setline(line_end, lines[len(lines)-1] . ' ' . mult_comment[1])
    endif
  endif
endfunc

function! comments#str2reg(s)
  let l:patterns = ['-', '*', '"', '+', '(', ')', '[', ']']
  let l:ss = a:s
  for p in l:patterns
    let l:ss = substitute(l:ss, p, '\' . p, 'g')
  endfor
  return l:ss
endfunc

function! comments#uncomment()
  " Uncomment a group of lines or a single line if
  " exist a comment in the same line.
  let line_start = getpos("'<")[1]
  let line_end = getpos("'>")[1]
  let lines = getline(line_start, line_end)
  if !g:comments#extensions->has_key(&filetype)
    echoerr 'comments#comment: file not supported'
    return v:false
  endif

  let single_comment = comments#str2reg(g:comments#extensions[&filetype].single)
  let mult_comment = g:comments#extensions[&filetype].multiple

  let l:mult = v:true
  try
    if mult_comment == -1
      let l:mult = v:false
    endif
  catch
    let l:mult = v:true
  endtry
  for [idx, line] in functional#enumerate(lines)
    let cline = line
    if l:mult
      let cline = substitute(cline, comments#str2reg(mult_comment[0]) . ' ', '', 'g')
      let cline = substitute(cline, comments#str2reg(mult_comment[1]), '', 'g')
    endif
    let cline = substitute(cline, single_comment . ' ', '', 'g')
    call setline(idx + line_start, cline)
  endfor
endfunc

vnoremap <silent> <C-s> :<c-u>call comments#comment()<CR>
vnoremap <silent> <C-d> :<c-u>call comments#uncomment()<CR>
