" run-current-test.vim
" Mark Wilden
" Version 2.0.0 30-Apr-2011
"
" Runs a single test or an entire test file
"
" This plugin
"   1) Finds a window with a test file - either an RSpec spec
"      or a Cucumber feature
"   2) Executes that test or the whole file
"
" A significant benefit (over TextMate, e.g.) is that you don't have to
" be editing the test when you run this function - you just need to have
" the test open in a window. You can be editing any code and
" run the test without having to switch to the test's window.
"
" For RSpec specs, if the current line in the test window is in an 'it'
" block, that test will be run. Otherwise, if the current line is in a
" 'describe' block, the tests inside that block will be run. This only
" works with the innermost 'describe' block. Cucumber features work
" similarly.
"
" The script does not save files before running the test. I have
" 'set autowriteall' in .vimrc to do this automatically.

"if exists("g:loaded_run_current_test")
  "finish
"endif
let g:loaded_run_current_test = 1

" Default maps. These work in insert or normal mode.
nmap <silent> <C-j> :call RunCurrentSingleTest()<CR>
imap <silent> <C-j> <ESC><C-j>
nmap <silent> <C-k> :call RunCurrentTestFile()<CR>
imap <silent> <C-k> <ESC><C-k>

function! RunCurrentSingleTest()
  ruby run_current_test
endfunction

function! RunCurrentTestFile()
  ruby run_current_test true
endfunction

ruby << EOF

def run_current_test run_whole_file = false
  original_window = VIM::Window.current
  test_type = change_to_window_with_test
  run_test test_type, run_whole_file
rescue Exception => e
  VIM::command %{echohl ErrorMsg | echo "#{e.message}" | echohl None}
ensure
  set_current_window original_window
end

def change_to_window_with_test
  test_type = test_window = nil
  for i in 0...VIM::Window.count
    window = VIM::Window[i]
    case window.buffer.name
    when /.*_spec\.rb/
      test_type = :spec
    when /\.feature/
      test_type = :feature
    else
      next
    end
    raise "More than one test window found" if test_window
    test_window = window
  end

  raise "No test window found" unless test_window
  set_current_window test_window
  test_type
end

def run_test test_type, run_whole_file
  file = VIM::evaluate %{expand("%:p") }
  directory = VIM::evaluate %{expand('%:p:h')}

  case test_type
  when :spec
    root_directory = directory.match(%r{(^.*)/spec/})[1]
    VIM::set_option %{errorformat=%D(in\\ %f),} +
        %{%\\\\s%#from\\ %f:%l:%m,} +
        %{%\\\\s%#from\\ %f:%l:,} +
        %{%\\\\s#\{RAILS_ROOT\}/%f:%l:\\ %#%m,} +
        %{%\\\\s%#[%f:%l:\\ %#%m,} +
        %{%\\\\s%#%f:%l:\\ %#%m,} +
        %{%\\\\s%#%f:%l:,} +
        %{%m\\ [%f:%l]:}
    command = 'rspec -b'
  when :feature
    directories = directory.match(%r{(^.*)/features(/.*)?})
    root_directory = directories[1]
    features_directory = directories[2].gsub '/', ''
    command = "cucumber"
    command += " -p #{features_directory}" unless features_directory.empty?
  end

  makeprg = "cd #{root_directory} && bundle exec #{command} #{file}"
  makeprg += ":#{VIM::Buffer.current.line_number}" unless run_whole_file
  VIM::set_option %{makeprg=#{makeprg.gsub(/ /, '\ ')}}

  #VIM::message(makeprg)
  VIM::command %{exe 'make!'}

  VIM::command %{cwindow}
end

def set_current_window window
  return if window == $curwin
  start = $curwin
  begin
    VIM::command "wincmd w"
  end while $curwin != window && $curwin != start
end

EOF
