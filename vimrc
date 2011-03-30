set nocompatible

if !exists("g:loaded_pathogen") || &cp
  call pathogen#runtime_append_all_bundles()
endif
"call pathogen#helptags()

" save and execute current vim script
nmap <C-A> :w<CR>:so %<CR>
imap <C-A> <ESC><C-a>

" show/hide Project window
nmap <C-P> <F12>

" show most recently used files
map <C-Z> :FufMruFile<CR>

" show undo list
nnoremap <F3> :GundoToggle<CR>

" next/prior error/grep result
nmap <F5> :cp<CR>
imap <F5> <ESC><F5>
nmap <F6> :cn<CR>
imap <F6> <ESC><F6>

" close quickfix
map <S-F6> <ESC>:ccl<CR>

" show most recently used commands
map <M-c> :FufMruCmd<CR>
imap <M-c> <ESC><M-c>

" recall most recent command
map <M-p> :<C-p>
imap <M-p> <ESC><M-p>

" execute ~/it.rb
map <F4> :!ruby ~/it.rb<CR>
imap <F4> <ESC><F8>
map <C-x> <F4>

" execute ruby file
nmap <M-x> :!ruby %<CR>
imap <M-x> <Esc>≈

" find file in rails hierarchy
map <M-z> :FufFile =RailsRoot()<CR>/**/
imap <M-z> <Esc><M-z>

" replace word under cursor
nmap <Leader>s :%s/\<<C-r><C-w>\>/

" show all occurences of word under cursor
nmap <Leader>g :g/\<<C-r><C-w>\><CR>

" edit this file
cabbrev pv e ~/.vim/vimrc

" use emacs keys on cmdline
cnoremap <C-A> <Home>
cnoremap <C-F> <Right>
cnoremap <C-B> <Left>
cnoremap <C-E> <End>
cnoremap <C-P> <Up>
cnoremap <C-N> <Down>
cnoremap <C-D> <Del>

" go to character, not just line
nmap ' `

" write the current buffer even if it requires root access
command! W w !sudo tee % >/dev/null

" delete inner line
nmap dil ^D

set autochdir
set autowriteall
set backspace=indent,eol,start
set breakat-=:
set breakat-=_
set browsedir=current
set clipboard=unnamed
set completeopt=menu,preview
set copyindent
set display=lastline
set equalalways
set expandtab
set foldmethod=marker
set formatoptions-=c
set formatoptions-=o
set formatoptions-=r
set formatoptions-=t
set gdefault
set grepprg=ack\ -H\ --nocolor\ --nogroup
set guifont=Monaco:h10
set guioptions+=c
set guioptions-=T
set guitablabel=%t
set history=200
set ignorecase smartcase
set incsearch
set laststatus=2
set linebreak
set macmeta
set matchtime=2
set mouse=n
set nobackup
set noerrorbells
set nostartofline
set noswapfile
set number
set numberwidth=3
set printoptions=syntax:n
set printheader=%F%=Page\ %N
set ruler
set shiftround
set shortmess+=t
set showcmd
set showmatch
set sw=2
set tabstop=2
set textwidth=72
set tildeop
if v:version >= 703
  set undofile
  set undodir=/tmp
endif
set visualbell
set wildmenu
set wildmode=list:longest:full
set winheight=25

" go to line we were on the last time we edited the file
autocmd BufReadPost *
  \ if line("'\"") > 0 && line("'\"") <= line("$") |
  \   exe "normal g`\"" |
  \ endif

" save when switching applications
autocmd FocusLost * wa

" turn off insert mode when switching applications
autocmd FocusLost * 
  \ if mode()[0] =~ 'i\|R' |
  \   call feedkeys("\<Esc>") |
  \ endif

" source .vimrc on write
autocmd BufWritePost vimrc source $MYVIMRC|source $MYGVIMRC

" set citrus filetype
autocmd BufRead,BufNewFile *.citrus set filetype=citrus

if !exists("g:vimrcloaded")
  set lines=82
  set columns=130
  winpos 0 0
  let g:vimrcloaded = 1
endif

" Project plugin
let g:proj_window_width=30
let g:proj_flags='cgisST'

filetype plugin indent on

let g:fuf_modesDisable=[]

colorscheme chance-of-storm

runtime macros/matchit.vim

