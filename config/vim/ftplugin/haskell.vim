function! s:hindent()
  let current = line('.')
  exec ':%! hindent --style cramer'
  exec ':' . current
endfunction

if executable('stack')
  augroup HaskellBuildConfig
    autocmd!
    autocmd FileType haskell setlocal makeprg=stack\ build
    autocmd FileType haskell setlocal errorformat=%f:%l:%v:%m
  augroup END

  command! StackGhci execute 'silent !stack ghci' | redraw!
endif

augroup HIndentConfig
  autocmd!
  autocmd BufWrite,FileWritePre,FileAppendPre *.hs\= call s:hindent()
augroup END

augroup HaskellKeyBindings
  autocmd!
  autocmd FileType haskell nmap <Leader>b :<C-u> silent make \| cwindow \| redraw!<CR>
augroup END

if executable('ghc-mod')
  let g:haskellmode_completion_ghc = 0
  augroup HaskellConfig
    autocmd!
    autocmd FileType haskell setlocal omnifunc=necoghc#omnifunc
  augroup END
endif
