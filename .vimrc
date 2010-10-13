set nocompatible

" save and execute current vim script
nmap <C-A> :w<CR>:so %<CR>
imap <C-A> <ESC><C-a>

" show/hide Project window
nmap <C-P> <F12>

" show most recently used files
map <C-Z> :FufMruFile<CR>

" next/prior error/grep result
map <F5> <ESC>:cp<CR>
map <F6> <ESC>:cn<CR>

" execute current test
map <F8> :.Rake<CR>
imap <F8> <ESC><F8>

" show most recently used commands (Option-C)
map ç :FufMruCmd<CR>
imap ç <ESC>ç

" reexecute most recent command (Option-P)
map π :<C-p><CR>
imap π <ESC>π

" execute ruby file (Option-X)
nmap ≈ :w<CR>:!ruby %<CR>
imap ≈ <Esc>≈

" find file in rails hierarchy (Option-Z)
map Ω :FufFile =RailsRoot()<CR>/**/
imap Ω <Esc>Ω

" replace word under cursor
nmap <Leader>s :%s/\<<C-r><C-w>\>//g<Left><Left>

" edit this file
cabbrev pv e ~/.vimrc

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

set autochdir
set autowriteall
set backspace=indent,eol,start
set breakat-=:
set breakat-=_
set browsedir=current
set clipboard=unnamed
set completeopt=menu,preview
set display=lastline
set equalalways
set expandtab
set formatoptions-=tc
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
set matchtime=2
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
if v:version >= 730
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

" visual settings that differ depending on whether we're running
" a) normally, b) from a shell (no GUI), c) from diffing
set lines=82
if &l:diff
  winpos 0 0
  set columns=276
  hi DiffAdd ctermbg=2
  hi DiffChange ctermbg=3
  hi DiffText ctermbg=7
else
  set columns=130
  syntax on
  if has("gui_running")
    winpos 0 0
  endif
endif

hi LineNr ctermfg=black ctermbg=gray
hi StatusLine guifg=Grey guibg=Blue

" Project plugin
let g:proj_window_width=30
let g:proj_flags='gimstc'

autocmd bufwritepost .vimrc source $MYVIMRC

set foldmethod=marker

let mapleader=","
set copyindent

set mouse=n

filetype off
call pathogen#runtime_append_all_bundles()
filetype plugin indent on

nnoremap <silent> <F10> :YRShow<CR>

let g:fuf_modesDisable=[]
