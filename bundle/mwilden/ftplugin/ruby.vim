" insert breakpoint
nmap <buffer> <F1> Orequire 'ruby-debug';debugger;''<ESC>j
imap <buffer> <F1> <Esc><F1>

" debugging output
nmap <buffer> <C-L> O<C-L>
imap <buffer> <C-L> lll{''}<ESC>hha

" remove breakpoint and lll's
function! Unlll()
  g/\v(lll)|(debugger)/d
endfunction
nmap <buffer> <leader>u :call Unlll()<CR>
