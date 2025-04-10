" Comment plugin configuration

let g:comments#extensions = {
      \'c': {'extension': 'c|h', 'single': '//', 'multiple': ['/*','*/']},
      \'cpp': {'extension': 'cpp|cc|hpp|h', 'single': '//', 'multiple': ['/*','*/']},
      \'lua': {'extension': 'lua', 'single': '--', 'multiple': ['[[',']]']},
      \'matlab': {'extension': 'm', 'single': '%', 'multiple': -1},
      \'octave': {'extension': 'm', 'single': '%', 'multiple': -1},
      \'python': {'extension': 'py', 'single': '#', 'multiple': -1},
      \'vim': {'extension': 'vim', 'single': '"', 'multiple': -1},
      \}

let g:comments#always_single = v:false

function! comments#set_map(comment_map, uncomment_map)
  vnoremap <silent> a:comment_map :<c-u>call comments#comment()<CR>
  vnoremap <silent> a:uncomment_map :<c-u>call comments#uncomment()<CR>
endfunc
