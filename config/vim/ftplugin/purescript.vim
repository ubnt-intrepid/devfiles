if executable('pulp')
  augroup PureScriptPulpSetup
    autocmd!
    autocmd FileType purescript setlocal makeprg=pulp\ build
  augroup END
endif

augroup PureScriptKeyBindings
  autocmd!
  autocmd FileType purescript nmap <Leader>b :<C-u> silent make \| cwindow \| redraw!<CR>
  autocmd FileType purescript nmap <leader>t :PSCIDEtype<CR>
augroup END
