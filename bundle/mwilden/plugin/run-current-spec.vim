" run-currenct-spec.vim
" Mark Wilden
" Last changed Nov 16 2010
"
" Runs a single Rails spec
"
" To install, copy this file to your plugins folder,
" typically ~/.vim/plugin. To run the spec at the
" cursor, press <C-x>.
"
" This plugin
"   1) Finds a window with a spec file
"   2) Runs RSpec's 'spec' on that file at that line
"
" The benefit of this plugin is that you can be working on
" a spec (or the code that the spec tests) and run that one
" spec with a single keystroke.
"
" A significant benefit (over TextMate, e.g.) is that
" you don't have to be editing the spec when you run this
" function - you just have to have the spec open in a window.
" That way, you can be editing the actual code under test and
" run the spec without having to switch to the spec's window.
"
" The plugin uses the RSpec option to run the spec at a
" given line number. If the current line in the spec window is
" in an 'it' block, " that spec will be run. Otherwise, if the
" current line is in a 'describe' block, the specs inside that
" block will be run. This only works with the innermost 'describe'
" block.
"
" This script maps <C-x> to run the spec (in normal or insert
" mode). This script does not save any files before running the spec.
" I have 'set autowriteall' in .vimrc to do this automatically

let debug=1
if exists("loaded_mw_run_current_spec") && !exists("debug")
  finish
endif
let loaded_mw_run_current_spec = 1

nmap <C-x> :call MWRunCurrentSpec()<CR>
imap <C-x> <ESC><C-x>
nmap <F8> <C-x>
imap <F8> <C-x>

function! MWRunCurrentSpec()
  let original_window_nr = winnr()

  let i = 1
  while (i <= bufnr("$"))
    if bufexists(i)
      let spec_window_nr = bufwinnr(i)
      if spec_window_nr != -1
        if bufname(i) =~ '.*_spec\.rb'
          break
        endif
      endif
    endif
    let i = i + 1
  endwhile
  if i > bufnr("$")
    echo "No spec buffer found"
    return
  endif

  exe bufwinnr(i).'wincmd w'

  let spec_buffer = expand('%:p')
  let line_number = line(".")
  let directory = expand('%:p:h')
  let spec_directory = matchlist(directory, '\(^.*\)/spec/')[1]

  let &l:errorformat='%D(in\ %f),'
      \.'%\\s%#from\ %f:%l:%m,'
      \.'%\\s%#from\ %f:%l:,'
      \.'%\\s#{RAILS_ROOT}/%f:%l:\ %#%m,'
      \.'%\\s%#[%f:%l:\ %#%m,'
      \.'%\\s%#%f:%l:\ %#%m,'
      \.'%\\s%#%f:%l:,'
      \.'%m\ [%f:%l]:'

  let &l:makeprg = "cd " . spec_directory . " && spec -l " . line_number . " " . expand("%:p") 
  exe 'make!'
  cwindow

  exe original_window_nr.'wincmd w'
endfunction


