# Comments plugin for vim

---

Comments is a simple plugin that helps you commenting blocks of code using 
shortcuts.

Comments is configurable and easy to use.

## Usage

By default it has two shortcuts, =<C-s>= to comment a selection and =<C-d>= 
to uncomment it.

You can change the commands using the function `comments#set_map` in 
after/comments.rc.vim file

You can add more supported files using the variable `g:comments#extensions` as shown:

``` vim
let g:comments#extensions['your-file-type'] = {
    \{'extensions': '<extensions>',
    \'simple': '<simple-comment-beginning>',
    \'multiple': '[<comment-block-start', <comment-block-end>] or -1 if not supported'
    \}
```

## Contributions

Acceptable and non-ambicious contributions are welcode.

## License

This project is under MIT license.

**Copyright (c) 2025 Yassin Achengli BY-NC**
