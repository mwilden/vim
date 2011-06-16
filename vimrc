set nocompatible

let mapleader = ','

if !exists("g:loaded_pathogen")
  call pathogen#runtime_append_all_bundles()
endif
"call pathogen#helptags()

" save and execute current vim script
nmap <silent> <C-A> :w<CR>:source %<CR>
imap <silent> <C-A> <ESC><C-a>

" save file
nmap <silent> <C-S> :w<CR>
imap <silent> <C-S> <ESC><C-s>

" show/hide Project window
nmap <silent> <C-P> <F12>

" show most recently used files
map <silent> <C-Z> :FufMruFile<CR>

" show undo list
nnoremap <silent> <F3> :GundoToggle<CR>

" next/prior error/grep result
nmap <silent> <F5> :cp<CR>
imap <silent> <F5> <ESC><F5>
nmap <silent> <F6> :cn<CR>
imap <silent> <F6> <ESC><F6>

" close quickfix
map <silent> <S-F6> <ESC>:ccl<CR>

" show most recently used commands
map <silent> <M-c> :FufMruCmd<CR>
imap <silent> <M-c> <ESC><M-c>

" recall most recent command
map <silent> <M-p> :<C-p>
imap <silent> <M-p> <ESC><M-p>

" execute ruby file
nmap <silent> <M-x> :!ruby %<CR>
imap <silent> <M-x> <Esc>≈

" find file in rails hierarchy
map <M-z> :FufFile =RailsRoot()<CR>/**/
imap <M-z> <Esc><M-z>

" replace word under cursor
nmap <Leader>s :%s/\<<C-r><C-w>\>/

" show all occurences of word under cursor
nmap <silent> <Leader>g :g/\<<C-r><C-w>\><CR>

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

" write the current buffer even if it requires root access
command! W w !sudo tee % >/dev/null

" delete inner line
nmap <silent> dil ^D
onoremap <silent> il :<C-U>normal! 0v$h<CR>

" close other windows and tabs
nmap <silent> <Leader>o :only<CR>:tabonly<CR>

" run 'q' macro
nmap Q @q

nmap <Leader>7 :botright cwindow<CR>

set autochdir
set autowriteall
set backspace=indent,eol,start
set breakat-=:
set breakat-=_
set browsedir=current
set clipboard=unnamed
set complete=.,w,b,u,t
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
set guifont=Menlo:h12
set guioptions+=c
set guioptions-=T
set guitablabel=%t
set history=200
set hlsearch
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
set scrolloff=1
set shiftround
set shortmess+=t
set showbreak=@
set showcmd
set showmatch
set sw=2
set switchbuf=useopen
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
set writeany

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
autocmd! BufWritePost $MYVIMRC source $MYVIMRC|source $MYGVIMRC

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

" FuzzyFinder plugin
let g:fuf_modesDisable=[]

filetype plugin indent on

runtime macros/matchit.vim

" vim-browserreload-mac
let g:returnApp = 'MacVim'
" FirefoxReloadStart to activate
"
augroup BgHighlight
  autocmd!
  autocmd WinEnter * set number
  autocmd WinLeave * set nonumber
augroup END
