" run-current-test.vim
" Mark Wilden
" Last changed 29 Mar 2011
"
" Runs a single test or an entire test file
"
" This plugin 1) Finds a window with a test file - either an RSpec spec
" or a Cucumber feature 2) Executes that test or the whole file
"
" To install, copy this file to your plugins folder, typically
" ~/.vim/plugin. To run the test at the cursor, enter :call
" MWRunCurrentSingleTest(). To run the entire test file, enter :call
" MWRunCurrentTestFile(). You'll want to map these commands (see
" below).
"
" A significant benefit (over TextMate, e.g.) is that you don't have to
" be editing the test when you run this function - you just need to have
" the test open in a window. You can be editing the code under test and
" run the test without having to switch to the test's window.
"
" For RSpec specs, if the current line in the test window is in an 'it'
" block, that test will be run. Otherwise, if the current line is in a
" 'describe' block, the tests inside that block will be run. This only
" works with the innermost 'describe' block. Cucumber features work
" similarly
"
" The script does not save files before running the test. I have
" 'set autowriteall' in .vimrc to do this automatically
" 
" You can comment in the following maps to make C-j run the current test
" and C-k run the current test file. These work in insert mode.

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

  let test_type = s:ChangeToWindowWithTest()
  if test_type <= 0
    if test_type == 0
      echoerr "No test buffer found"
    elseif test_type == -1
      echoerr "More than one test buffer found"
    endif
    return
  endif

  call s:RunTest(test_type, a:run_current_test_file)

  exe original_winnr.'wincmd w'
endfunction

" returns:
"  -1 = more than one test found
"   0 = no test found
"   1 = spec found
"   2 = feature found
function! s:ChangeToWindowWithTest()
  let test_type = 0
  let test_winnr = -1
  let i = 1
  let last_bufnr = bufnr("$")
  while i <= last_bufnr
    if bufexists(i) && bufwinnr(i) != -1
      if bufname(i) =~ '.*_spec\.rb'
        if test_winnr != -1
          return -1
        endif
        let test_winnr = bufwinnr(i)
        let test_type = 1
      elseif bufname(i) =~ '\.feature'
        if test_winnr != -1
          return -1
        endif
        let test_winnr = bufwinnr(i)
        let test_type = 2
      endif
    endif
    let i = i + 1
  endwhile

  if test_type == 0
    return 0
  endif

  exe test_winnr.'wincmd w'

  return test_type
endfunction

function! s:RunTest(test_type, run_current_test_file)
  let line_number = line(".")
  let directory = expand('%:p:h')

  if a:test_type == 1
    let root_directory = matchlist(directory, '\(^.*\)/spec/')[1]
    let &l:errorformat='%D(in\ %f),'
        \.'%\\s%#from\ %f:%l:%m,'
        \.'%\\s%#from\ %f:%l:,'
        \.'%\\s#{RAILS_ROOT}/%f:%l:\ %#%m,'
        \.'%\\s%#[%f:%l:\ %#%m,'
        \.'%\\s%#%f:%l:\ %#%m,'
        \.'%\\s%#%f:%l:,'
        \.'%m\ [%f:%l]:'
    let command = "spec -b "
  elseif a:test_type == 2
    let directories = matchlist(directory, '\(^.*\)/features\(/.*\)\?')
    let root_directory = directories[1]
    let features_directory = substitute(directories[2], '/', '', '')
    let command = "cucumber "
    if len(features_directory) != 0
      let command = command . "-p " . features_directory . ' '
    endif
  endif

  let &l:makeprg = "cd " . root_directory . " && bundle exec " . command
  let &l:makeprg = &l:makeprg . expand("%:p") 
  if !a:run_current_test_file
    let &l:makeprg = &l:makeprg . ":" . line_number
  endif
  "echo &l:makeprg
  exe 'make!'

  cwindow

endfunction
