# 📜 Easy comments 📜

---

## Introduction
Comments is a simple plugin that helps you commenting blocks of code using 
shortcuts.

Comments is configurable and easy to use.

## Installing comments.vim

### Plug vim installation
``` vim
call plug#begin()
Plug 'achengli/comments.vim' 
call plug#end()
```

If you'd like, you can also install previous version

``` vim
call plug#begin()
Plug 'achengli/comments.vim' {'tag': 'v1.3'}
call plug#end()
```

## How to use it

By default it has two shortcuts, *\<C-s\>* to **comment** a visual section and *\<C-d\>*
to **uncomment**. `vnoremap` and `nnoremap` to change them.

If you want, you can include new syntax comments using `comments#newSyntaxComment` function, use it 
in after/plugin/comments.rc.vim

Extensions are defined as bellow:
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
[**MIT**](https://opensource.org/license/mit) licence

**Copyright (c) 2025 Yassin Achengli BY-NC**
