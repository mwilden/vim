" insert breakpoint
nmap <buffer> <F1> Orequire 'ruby-debug';debugger;''<ESC>j
imap <buffer> <F1> <Esc><F1>

" debugging output
nmap <buffer> <C-L> O<C-L>
imap <buffer> <C-L> lll{''}<ESC>hha
vmap <buffer> <C-L> <ESC>'>a'} D'<d^illl{'<ESC>

" remove breakpoint and lll's
function! Unlll()
  g/\v(lll)|(debugger)/d
endfunction
nmap <buffer> <leader>u :call Unlll()<CR>

" surround a preprocessed line with test scaffold to see why it doesn't work
nmap <Leader>9 Oit "should work" do<Esc>jI<Tab><Tab><Tab><Tab>@grammar.parse(%{A})end<Esc><C-J>
