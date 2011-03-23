" debugging output
nmap <buffer> <C-L> O<C-L>
imap <buffer> <C-L> - lll{''}<ESC>hha

" remove breakpoint and lll's
function! Unlll()
  g/\v(lll)|(debugger)/d
endfunction
nmap <buffer> <leader>u :call Unlll()<CR>

