imap <buffer> <C-L> And show me the page<ESC>
nmap <buffer> <C-L> O<C-L>

function! Unlll()
  g/show me the page/d
endfunction
nmap <buffer> <leader>u :call Unlll()<CR>


