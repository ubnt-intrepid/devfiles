if has('win32') || has('win64')
  let g:go_fmt_autosave = 0
endif

augroup GoLangKeyBindings
  autocmd!
  autocmd FileType go nmap <Leader>b <Plug>(go-build)
  autocmd FileType go nmap <Leader>r <Plug>(go-run)
  autocmd FileType go nmap <Leader>t <Plug>(go-test)
  autocmd FileType go nmap <Leader>c <Plug>(go-coverage)
augroup END
