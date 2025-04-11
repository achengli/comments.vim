" Functional basic functions

function! functional#reduce(lst, lambda)
  let acum = a:lambda(v:null, v:null)
  for e in a:lst
    let acum = a:lambda(acum, e)
  endfor
  return acum
endfunc

function! functional#filter(lst, lambda)
  for [idx, e] in functional#enumerate(a:lst)
    if !lambda(e)
      call remove(a:lst, idx)
    endif
  endfor
  return a:lst
endfunc

function! functional#map(lst, lambda)
  let r = []
  for e in a:lst
    call add(r, a:lambda(e))
  endfor
  return r
endfunc

function! functional#enumerate(lst)
  let idx = 0
  let r = []
  for e in a:lst
    call add(r, [idx, e])
    let idx += 1
  endfor
  return r
endfunc

