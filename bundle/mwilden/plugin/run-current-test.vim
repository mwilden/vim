" run-currenct-test.vim
" Mark Wilden
" Last changed Nov 16 2010
"
" Runs a single Rails test
"
" To install, copy this file to your plugins folder,
" typically ~/.vim/plugin. To run the test at the
" cursor, press <C-x>.
"
" This plugin
"   1) Finds a window with a test file
"   2) Runs RSpec's 'spec' on that file at that line
"
" The benefit of this plugin is that you can be working on
" a test (or the code that the test tests) and run that one
" test with a single keystroke.
"
" A significant benefit (over TextMate, e.g.) is that
" you don't have to be editing the test when you run this
" function - you just have to have the test open in a window.
" That way, you can be editing the actual code under test and
" run the test without having to switch to the test's window.
"
" The plugin uses the RSpec option to run the test at a
" given line number. If the current line in the test window is
" in an 'it' block, " that test will be run. Otherwise, if the
" current line is in a 'describe' block, the tests inside that
" block will be run. This only works with the innermost 'describe'
" block.
"
" This script maps <C-j> to run the test (in normal or insert
" mode). This script does not save any files before running the test.
" I have 'set autowriteall' in .vimrc to do this automatically
" You can comment in the following maps to make C-j run the current
" test and C-k run the current test file. These work in insert mode.

"nmap <C-j> :call MWRunCurrentSingleTest()<CR>
"imap <C-j> <ESC><C-j>

"nmap <C-k> :call MWRunCurrentTestFile()<CR>
"imap <C-k> <ESC><C-k>

"if exists("loaded_mw_run_current_test")
  "finish
"endif
let loaded_mw_run_current_test = 1

function! MWRunCurrentSingleTest()
  call s:RunCurrentTest(0)
endfunction

function! MWRunCurrentTestFile()
  call s:RunCurrentTest(1)
endfunction

function! s:RunCurrentTest(run_current_test_file)
  let original_winnr = winnr()
  let rc = s:ChangeToWindowWithTest()
  if rc != 0
    if rc == 1
      echo "No test buffer found"
    elseif rc == 2
      echo "More than one test buffer found"
    endif
    return
  endif

  let test_buf = expand('%:p')
  let line_number = line(".")
  let directory = expand('%:p:h')
  let test_directory = matchlist(directory, '\(^.*\)/spec/')[1]

  let &l:errorformat='%D(in\ %f),'
      \.'%\\s%#from\ %f:%l:%m,'
      \.'%\\s%#from\ %f:%l:,'
      \.'%\\s#{RAILS_ROOT}/%f:%l:\ %#%m,'
      \.'%\\s%#[%f:%l:\ %#%m,'
      \.'%\\s%#%f:%l:\ %#%m,'
      \.'%\\s%#%f:%l:,'
      \.'%m\ [%f:%l]:'

  let &l:makeprg = "cd " . test_directory . " && bundle exec spec -b "
  if !a:run_current_test_file
    let &l:makeprg = &l:makeprg . "-l " . line_number . " "
  endif
  let &l:makeprg = &l:makeprg . expand("%:p") 
  echo &l:makeprg
  "exe 'make!'
  cwindow

  exe original_winnr.'wincmd w'
endfunction

function! s:ChangeToWindowWithTest()
  let i = 1
  let last_bufnr = bufnr("$")
  let test_winnr = -1
  while i <= last_bufnr
    if bufexists(i) && bufwinnr(i) != -1
      if bufname(i) =~ '.*_spec\.rb'
        if test_winnr != -1
          return 2
        endif
        let test_winnr = bufwinnr(i)
      endif
    endif
    let i = i + 1
  endwhile

  if test_winnr == -1
    return 1
  endif

  exe test_winnr.'wincmd w'
  return 0
endfunction

function! MWRunCurrentSpecFile()
  let original_winnr = winnr()

  let i = 1
  while (i <= bufnr("$"))
    if bufexists(i)
      let test_winnr = bufwinnr(i)
      if test_winnr != -1
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

  let test_buf = expand('%:p')
  let directory = expand('%:p:h')
  let test_directory = matchlist(directory, '\(^.*\)/spec/')[1]

  let &l:errorformat='%D(in\ %f),'
      \.'%\\s%#from\ %f:%l:%m,'
      \.'%\\s%#from\ %f:%l:,'
      \.'%\\s#{RAILS_ROOT}/%f:%l:\ %#%m,'
      \.'%\\s%#[%f:%l:\ %#%m,'
      \.'%\\s%#%f:%l:\ %#%m,'
      \.'%\\s%#%f:%l:,'
      \.'%m\ [%f:%l]:'

  let &l:makeprg = "cd " . test_directory . " && bundle exec spec -b " . expand("%:p") 
  exe 'make!'
  cwindow

  exe original_winnr.'wincmd w'

endfunction
