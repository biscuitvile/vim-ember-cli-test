function! OpenQUnit(params)
  let url = "http://localhost:7357/tests/index.html?filter=" . tolower(a:params)
  let url = shellescape(url, 1)
  silent! exec "silent! !open " . url | redraw!
endfunction

function! RunQunitFile()
  let file_name =  @%
  let file_name = substitute(file_name, ".[^\/]*\/", "", "g")
  let file_name = substitute(file_name, "-test.js", "", "g")
  call OpenQUnit(file_name)
endfunction

function! RunQunitFocused()
  let line_number = search('^\s*test\s*(\([''"]\).*)', 'bcnW')
  let line_text = getline(line_number)
  let test_name = substitute(line_text, "^\s*test\s*(['\"]", "", "")
  let test_name = substitute(test_name, "['\"].*$", "", "")
  call OpenQUnit(test_name)
endfunction

command! -nargs=* -range RunQunitFile :call RunQunitFile()
command! -nargs=* -range RunQunitFocused :call RunQunitFocused()

nnoremap <leader>e :RunQunitFile<CR>
nnoremap <leader>E :RunQunitFocused<CR>
