set nocompatible

let mapleader = ','

if !exists("g:loaded_pathogen")
  call pathogen#runtime_append_all_bundles()
endif
"call pathogen#helptags()

""""""""""" maps, commands, abbreviations
" save file
nmap <silent> <C-S> :w<CR>
imap <silent> <C-S> <ESC><C-s>
"
"save and execute current vim script
nmap <silent> <M-v> :w<CR>:source %<CR>
imap <silent> <M-v> <ESC><C-a>

" show undo list
nnoremap <silent> <F3> :GundoToggle<CR>

" quick-fix
nmap <silent> <F5> :cp<CR>
imap <silent> <F5> <ESC><F5>
nmap <silent> <F6> :cn<CR>
imap <silent> <F6> <ESC><F6>
nmap <silent> <S-F5> :colder<CR>
imap <silent> <S-F5> <ESC><S-F5>
nmap <silent> <S-F6> :cnewer<CR>
imap <silent> <S-F6> <ESC><S-F6>
nmap <Leader>q :copen<CR><C-W>J<C-W>4+
nmap <Leader>Q :cclose<CR>

" recall most recent command
map <M-p> :<C-p>
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

" write the current buffer even if it requires root access
command! W w !sudo tee % >/dev/null

" delete inner line
nmap <silent> dil ^D"xdd
onoremap <silent> il :<C-U>normal! 0v$h<CR>

" close other windows and tabs
nmap <silent> <Leader>o :only<CR>:tabonly<CR>:noh<CR>

" run 'q' macro
nmap Q @q

" show line numbers
nmap <Leader>n :set number<CR>

" convert Ruby 1.8 hashrockets to 1.9
nmap <Leader>; F:xea:ldf>
nmap <Leader>: xea:lldW

" convert double quotes to single quotes
nmap <Leader>' macs"''a

""""""""""" plugins
" CtrlP
" disable so Project can use <C-P>
let g:ctrlp_map = '<c-f1>'
let g:ctrlp_working_path_mode = 2
let g:ctrlp_jump_to_buffer = 0
let g:ctrlp_by_filename = 1
let g:ctrlp_mruf_last_entered = 1
let g:ctrlp_max_height = 20
map <C-Z> :CtrlPMRU<CR>

" Project
" grep
nmap <Leader>G :Project<CR>gg<CR>zX\G'
" grep word under cursor
nmap <Leader>g yiw:Project<CR>gg\RzX\G'\b<C-R>"\b'<CR><C-P><Leader>q
" refresh
nmap <Leader>p :Project<CR>gg\RzXza<C-R>
nmap <silent> <C-P> <F12>
let g:proj_window_width=30
let g:proj_flags='cgisST'

" fugitive
" open diff
nmap <Leader>d :Gdiff<CR>
" close diff
nmap <Leader>D <C-W>pZZ
set statusline=%<%f\ %h%m%r%{fugitive#statusline()}%=%-14.(%l,%c%V%)\ %P

""""""""""" vim-browserreload-mac
" stay in Vim when reloading FireFox
let g:returnApp = 'MacVim'
" reload FireFox when current buffer saved
nmap <Leader>fr :FirefoxReloadStart<cr>:w<cr>
" stop reloading FireFox (for every buffer)
nmap <Leader>fR :FirefoxReloadStop<cr>:w<cr>

""""""""""" sets
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
set cursorline
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
set guifont=Menlo:h13

set guioptions+=c
set guioptions-=T
set guitablabel=%t
set history=200
set hlsearch
set ignorecase smartcase
set incsearch
set laststatus=2
set linebreak
if has("gui_running")
  set macmeta
endif
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

""""""""""" autocmds
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

" source .vimrc, .vim on write
autocmd! BufWritePost $MYVIMRC source $MYVIMRC|source $MYGVIMRC
autocmd! BufWritePost *.vim source %

" set citrus filetype
autocmd BufRead,BufNewFile *.citrus set filetype=citrus

" turn number on in current window
augroup BgHighlight
  autocmd!
  autocmd WinEnter * set number
  autocmd WinLeave * set nonumber
augroup END

""""""""""" other
if !exists("g:vimrcloaded")
  set lines=85
  set columns=188
  winpos 0 0
  let g:vimrcloaded = 1
endif
filetype plugin indent on
runtime macros/matchit.vim

""""""""""" scratch & preview
