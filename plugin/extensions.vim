" *                     COMMENTS VIM PLUGIN                           
" *********************************************************************
" AUTHOR:       Copyright (C) 2024-2025 Yassin Achengli
" DESCRIPTION:  This plugin was made for commenting selected text in 
"                   different programming languages and file types.
"
"               It's customizable in order to increase the support
"               of more file types.
" *********************************************************************
let g:comments#extensions={
            \ "awk":{"extension":"awk","single":"#"},
            \ "bash":{"extension":"sh|bash","single":"#"},
            \ "c":{"extension":"c|h","single":"//","multiple":["/**","**/"]},
            \ "clojure":{"extension":"clj|cljs|cljc","single":";;"},
            \ "commonlisp":{"extension":"lisp|lsp|cl","single":";"},
            \ "cpp":{"extension":"cpp|cc|cxx|hpp|h","single":"//","multiple":["/*","*/"]},
            \ "cs":{"extension":"cs","single":"//","multiple":["/*","*/"]},
            \ "css":{"extension":"css","single":"","multiple":["/*","*/"]},
            \ "dart":{"extension":"dart","single":"//","multiple":["/*","*/"]},
            \ "elixir":{"extension":"ex|exs","single":"#"},
            \ "emacs-lisp":{"extension":"el|emacs","single":";"},
            \ "erlang":{"extension":"erl|hrl","single":"%"},
            \ "fsharp":{"extension":"fs|fsi|fsx","single":"//","multiple":["(*","*)"]},
            \ "fortran":{"extension":"f|for|f90","single":"!"},
            \ "go":{"extension":"go","single":"//","multiple":["/*","*/"]},
            \ "groovy":{"extension":"groovy|gvy","single":"//","multiple":["/*","*/"]},
            \ "haskell":{"extension":"hs|lhs","single":"--","multiple":["{-","-}"]},
            \ "html":{"extension":"html|htm","single":"","multiple":["<!--","-->"]},
            \ "java":{"extension":"java","single":"//","multiple":["/*","*/"]},
            \ "javascript":{"extension":"js|mjs|cjs","single":"//","multiple":["/*","*/"]},
            \ "julia":{"extension":"jl","single":"#","multiple":["#=","=#"]},
            \ "kotlin":{"extension":"kt|kts","single":"//","multiple":["/*","*/"]},
            \ "lua":{"extension":"lua","single":"--","multiple":["--[[","]]"]},
            \ "matlab":{"extension":"m","single":"%"},
            \ "nix":{"extension":"nix","single":"#"},
            \ "objc":{"extension":"m|mm","single":"//","multiple":["/*","*/"]},
            \ "octave":{"extension":"m","single":"%"},
            \ "perl":{"extension":"pl|pm","single":"#"},
            \ "php":{"extension":"php","single":"//","multiple":["/*","*/"]},
            \ "powershell":{"extension":"ps1","single":"#","multiple":["<#","#>"]},
            \ "python":{"extension":"py","single":"#","multiple":['"""','"""']},
            \ "r":{"extension":"r","single":"#"},
            \ "ruby":{"extension":"rb","single":"#"},
            \ "rust":{"extension":"rs","single":"//","multiple":["/*","*/"]},
            \ "scala":{"extension":"scala","single":"//","multiple":["/*","*/"]},
            \ "scheme":{"extension":"scm|ss","single":";"},
            \ "shell":{"extension":"sh|zsh|bash","single":"#"},
            \ "sql":{"extension":"sql","single":"--","multiple":["/*","*/"]},
            \ "swift":{"extension":"swift","single":"//","multiple":["/*","*/"]},
            \ "toml":{"extension":"toml","single":"#"},
            \ "typescript":{"extension":"ts|tsx","single":"//","multiple":["/*","*/"]},
            \ "vim":{"extension":"vim","single":'"'},
            \ "vimscript":{"extension":"vim","single":'"'},
            \ "xml":{"extension":"xml|xsl|xsd","single":"","multiple":["<!--","-->"]},
            \ "yaml":{"extension":"yaml|yml","single":"#"},
            \ "zig":{"extension":"zig","single":"//","multiple":["/*","*/"]},
            \ }
