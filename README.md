# 📜 Comments plugin for vim 📜

---

## Introduction
Comments is a simple plugin that helps you commenting blocks of code using 
shortcuts.

Comments is configurable and easy to use.

## Installation
The plugin can be installed using a plugin manager like *vim Plug*

Using vim Plug you can introduce the following code portion in your vim config:
``` vim
call plug#begin()
Plug 'achengli/comments.vim' 
call plug#end()
```

Also you can specify a release using *"tag"*

``` vim
call plug#begin()
Plug 'achengli/comments.vim' {'tag': 'v1.0'}
call plug#end()
```

## Usage

By default it has two shortcuts, \<C-s\> to **comment** a visual section and \<C-d\> 
to **uncomment**.

To can change the commands, use the function `comments#set_map` in after loading file `after/comments.rc.vim`

Add new supported file types using the variable `g:comments#extensions` adding a 
new key or using the function that simplify the task `g:comments#add_format()` *(see `:help comments`)*

``` vim
let g:comments#extensions['your-file-type'] = {
    \{'extensions': '<extensions>',
    \'simple': '<simple-comment-beginning>',
    \'multiple': '[<comment-block-start', <comment-block-end>] or -1 if not supported'
    \}
```

## Contributions

Acceptable and non-ambicious contributions are welcome.

## License

This project is under MIT license.

**Copyright (c) 2025 Yassin Achengli BY-NC**
