set nocompatible

let mapleader = ','

if !exists("g:loaded_pathogen")
  call pathogen#runtime_append_all_bundles()
endif
call pathogen#helptags()

" maps """""""""""""""""""""""
" save file
nmap <silent> <C-S> :w<CR>
imap <silent> <C-S> <C-O><C-s>

" quick-fix
nmap <silent> <Space> :cn<CR>
nmap <silent> <S-Space> :cp<CR>
nmap <silent> <S-Space><Space> :cnf<CR>
nmap <Leader>q :copen<CR><C-W>J
nmap <Leader>Q :cclose<CR><C-P>

" re-execute most recent command
map <M-p> :<C-p><CR>
imap <M-p> <ESC><M-p>

" execute ruby file
nmap <silent> <M-x> :!ruby %<CR>
imap <silent> <M-x> <Esc>≈

" replace word under cursor
nmap <Leader>s :%s/\<<C-r><C-w>\>/
vmap <Leader>s :%s/\<<C-r><C-w>\>/

" show all occurences of word under cursor
nmap <silent> <Leader>w *N:g/\<<C-r>/\><CR>

" edit this file
nmap <silent> <Leader>v :tabedit $MYVIMRC<CR>

" unhighlight search
nnoremap <Leader><Space> :noh<CR>

" use emacs keys on cmdline
cnoremap <C-A> <Home>
cnoremap <C-F> <Right>
cnoremap <C-B> <Left>
cnoremap <C-E> <End>
cnoremap <C-P> <Up>
cnoremap <C-N> <Down>
cnoremap <C-D> <Del>

" go to character, not just line
nmap <silent> ' `

" delete inner line
nmap <silent> dil ^D"xdd
onoremap <silent> il :<C-U>normal! 0v$h<CR>

" close other windows and tabs
nmap <silent> <Leader>o :only<CR>:tabonly<CR>:noh<CR>
" close everything
nmap <silent> <Leader>O :bufdo bd<CR>

" run 'q' macro
nmap Q @q

" show line numbers
nmap <Leader>n :set number<CR>

" convert Ruby 1.8 hashrockets to 1.9
nnoremap <Leader>; F:,:
nnoremap <Leader>: xea:<Esc>ldf>

" convert double quotes to single quotes
nmap <Leader>' macs"''a
" convert single quotes to double quotes
nmap <Leader>" macs'"'a
" remove parens but leave a space
nmap <Leader>( ds(i <Esc>
nmap <Leader>) ds(i <Esc>
" add parens from cursor through end of line
nmap <Leader>[ xv$hS)

" save to temporary file
map <Leader>wip :sav! ~/it<CR>

" show trailing spaces
map <Leader><Space><Space> /\v[^\s]\zs\s+$<CR>

" show the highlight color under the cursor
map ,hi :echo "hi<" . synIDattr(synID(line("."),col("."),1),"name") . '> trans<' . synIDattr(synID(line("."),col("."),0),"name") . "> lo<" . synIDattr(synIDtrans(synID(line("."),col("."),1)),"name") . ">" . " FG:" . synIDattr(synIDtrans(synID(line("."),col("."),1)),"fg#")<CR>

"don't require contortions for such a common keystroke
map fj 

" commands """""""""""""""""""""""
" write the current buffer even if it requires root access
command! W w !sudo tee % >/dev/null

" plugins """""""""""""""""""""""
" CtrlP
let g:ctrlp_by_filename = 0
" disable so Project can use <C-P>
let g:ctrlp_map = '<c-f1>'
let g:ctrlp_max_height = 30
let g:ctrlp_mruf_default_order = 1
let g:ctrlp_mruf_save_on_update = 1
let g:ctrlp_show_hidden = 1
let g:ctrlp_switch_buffer = 'ev'
let g:ctrlp_working_path_mode = 'r'
map <C-Z> :CtrlPMRU<CR>

" Project
" grep
nmap <Leader>g :Project<CR>gg<CR>zX\G'
" grep word under cursor
nmap <Leader>G yiw:Project<CR>ggzX\G'\b<C-R>"\b'<CR><C-P><Leader>qb<Bar>:let @/ = @"<CR>

" refresh
nmap <Leader>p :Project<CR>gg\RzXzo<C-W>p
nmap <silent> <C-P> <F12>
let g:proj_window_width=30
let g:proj_flags='cgisST'
" keep window open or let it close
nmap <Leader>po :let g:proj_flags='gisST'<CR>
nmap <Leader>pc :let g:proj_flags='cgisST'<CR><C-P>

" fugitive
" open diff
nmap <Leader>d :Gdiff<CR><Leader><Space>
" close diff
nmap <Leader>D <C-W>pZZ<Leader><Space>

" Ruby & jQuery doc
let g:ruby_doc_command='open'
let g:jquery_doc_command='open'
let g:jquery_doc_mapping='RJ'
execute "noremap <silent> ".g:jquery_doc_mapping." :call jquerydoc#search(expand('<cword>'))<CR>"
let g:ruby_doc_command='open'
let g:ruby_doc_ruby_host='http://apidock.com/ruby/search/quick?query='

" sets """""""""""""""""""""""
set   autochdir
set   autowriteall
set   backspace=indent,eol,start
set nobackup
set   breakat-=:
set   breakat-=_
set   browsedir=current
set   clipboard=unnamed
set   complete=.,w,b,u,t
set   completeopt=menu,preview
set   copyindent
set   cursorline
set   display=lastline
set   equalalways
set   expandtab
set noerrorbells
set nofoldenable
set   formatoptions-=c
set   formatoptions-=o
set   formatoptions-=r
set   formatoptions-=t
set   gdefault
set   grepprg=ack\ --with-filename\ --nogroup
set   guifont=Menlo:h13
set   guioptions+=c
set   guioptions-=T
set   guitablabel=%t
set   history=200
set   hlsearch
set   ignorecase smartcase
set   incsearch
set   laststatus=2
set   linebreak
if has("gui_running")
  set macmeta
endif
set   matchtime=2
set   mouse=a
set   number
set   numberwidth=3
set   printoptions=syntax:n
set   printheader=%F%=Page\ %N
set   ruler
set   scrolloff=3
set   shiftround
set   shortmess+=t
set   showbreak=@
set   showcmd
set   showmatch
set nostartofline
set   statusline=%F\ %y%m%r%{fugitive#statusline()}%=%-a\ %b\ 0x%B\ %-14.(%c:%l/%L%)\ %P
set   sw=2
set noswapfile
set   switchbuf=useopen
set   tabstop=2
set   textwidth=72
set   tildeop
if v:version >= 703
  set undofile
  set undodir=/tmp
endif
set   visualbell
set nowritebackup
set   wildmenu
set   wildmode=list:longest:full
set   winheight=25
set   writeany

"autocmds
augroup mwilden
  autocmd!
  " set markdown filetype
  autocmd BufRead, BufWrite *.md set filetype=markdown
  " set citrus filetype
  autocmd BufRead,BufWrite *.citrus set filetype=citrus

  " go to line we were on the last time we edited the file
  autocmd BufReadPost *
    \ if line("'\"") > 0 && line("'\"") <= line("$") |
    \   exe "normal g`\"" |
    \ endif

  " source certain files on write
  autocmd BufWritePost $MYVIMRC so %
  autocmd BufWritePost gvimrc so %
  autocmd BufWritePost $MYGVIMRC so %
  autocmd BufWritePost vimrc so so %
  autocmd BufWritePost *.vim source %

  " save when switching applications
  autocmd FocusLost * wa
  " turn off insert mode when switching applications
  autocmd FocusLost *
    \ if mode()[0] =~ 'i\|R' |
    \   call feedkeys("\<Esc>") |
    \ endif

  " something keeps changing this
  autocmd BufNewFile, BufRead * setlocal formatoptions=tq2
augroup END

" turn number on in current window
augroup BgHighlight
  autocmd!
  autocmd WinEnter * set number
  autocmd WinLeave * set nonumber
augroup END

if !exists("g:vimrcloaded")
  set columns=156
  set lines=284
  let g:vimrcloaded = 1
endif

filetype plugin indent on
runtime macros/matchit.vim
