" debugging output
imap <buffer> <C-L> console.log();<ESC>hha
nmap <buffer> <C-L> O<C-L>

function! Unlll()
  g/console\.log/d
endfunction
nmap <buffer> <leader>u :call Unlll()<CR>


