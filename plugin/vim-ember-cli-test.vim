function! OpenQUnit(params)
  let url = "http://localhost:7357/tests/index.html?filter=" . tolower(a:params)
  let url = shellescape(url, 1)
  silent! exec "silent! !open " . url | redraw!
endfunction

function! RunQunit()
  let url = "http://localhost:7357/tests/index.html?hidepassed"
  silent! exec "silent! !open " . url | redraw!
endfunction

function! RunQunitFocused()
  let line_number = search('^\s*test\s*(\([''"]\).*)', 'bcnW')
  let line_text = getline(line_number)
  let test_name = substitute(line_text, "^\s*test\s*(['\"]", "", "")
  let test_name = substitute(test_name, "['\"].*$", "", "")
  call OpenQUnit(test_name)
endfunction

command! -nargs=* -range RunQunit :call RunQunit()
command! -nargs=* -range RunQunitFocused :call RunQunitFocused()

nnoremap <leader>Q :RunQunit<CR>
nnoremap <leader>q :RunQunitFocused<CR>
