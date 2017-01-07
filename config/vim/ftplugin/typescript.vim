let s:tsc_path = 'tsc'
let s:tslint_path = 'tslint'

let s:npm_path = substitute(system('npm bin'), '\n$', '', 'g')
if v:shell_error == 0
  let s:tsc_path = expand(s:npm_path . '/tsc')
  if !executable(s:tsc_path)
    s:tsc_path = 'tsc'
  endif

  let s:tslint_path = expand(s:npm_path . '/tslint')
  if !executable(s:tslint_path)
    s:tslint_path = 'tslint'
  endif
endif

let b:neomake_typescript_tsc_exe = s:tsc_path
let b:neomake_typescript_tslint_exe = s:tslint_path


augroup typescript_config
  autocmd!
  autocmd BufWritePost,BufEnter *.ts Neomake!

  " Add the location of local executables installed by NPM into the buffer's path
  " execute 'setlocal path+=' . system('npm bin')
augroup END

let g:tsuquyomi_completion_detail = 1

" enforce omni input patterns for tsukuyomi
if !exists('g:neocomplete#force_omni_input_patterns')
  let g:neocomplete#force_omni_input_patterns = {}
endif
let g:neocomplete#force_omni_input_patterns['typescript'] = '[^. *\t]\.\w*\|\h\w*|#'
