" debugging output
imap <buffer> <C-L> console.log ": " + <Esc>hhhhhi
nmap <buffer> <C-L> O<C-L>
function! Unlll()
  g/console\./d
endfunction
nmap <buffer> <leader>u :call Unlll()<CR>
