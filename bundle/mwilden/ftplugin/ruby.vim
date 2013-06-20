" insert breakpoint
nmap <buffer> <F2> Orequire 'ruby-debug';debugger;'';<ESC>j
imap <buffer> <F2> <Esc><F1>

" debugging output
nmap <buffer> <C-L> O<C-L>
imap <buffer> <C-L> lll{%q{}}<ESC>hha
vmap <buffer> <C-L> <ESC>'>a}} D'<d^illl{%q{<ESC>

" remove breakpoint and lll's
function! Unlll()
  g/\v(lll)|(debugger)/d
endfunction
nmap <buffer> <leader>u :call Unlll()<CR>

" run the current Ruby file
nmap <buffer> <C-X> :!ruby %<CR>
imap <buffer> <C-X> <Esc><C-X>
