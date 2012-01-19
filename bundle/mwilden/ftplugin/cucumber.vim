imap <buffer> <F1> And show me the page<ESC>
nmap <buffer> <F1> O<F1>

function! Unlll()
  g/show me the page/d
endfunction
nmap <buffer> <leader>u :call Unlll()<CR>


