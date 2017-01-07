function! s:ocaml_format()
  let current = line('.')
  exec ':%! ocp-indent'
  exec ':' . current
endfunction

augroup OCamlSettings
  autocmd!
  if executable('ocp-indent')
    autocmd BufWrite,FileWritePre,FileAppendPre *.mli\= call s:ocaml_format()
  endif
  autocmd BufWritePost *.ml Neomake!
augroup END

if !exists('g:neocomplete#force_omni_input_patterns')
  let g:neocomplete#force_omni_input_patterns = {}
endif
let g:neocomplete#force_omni_input_patterns['ocaml'] = '[^. *\t]\.\w*\|\h\w*|#'
