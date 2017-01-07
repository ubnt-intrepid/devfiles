let g:rustfmt_autosave = 1
let g:rustfmt_fail_silently = 1
let g:racer_experimental_completer = 1

augroup rust_config
  autocmd!
  autocmd BufWritePost *.rs Neomake! cargo
  autocmd VimEnter *.rs compiler cargo
augroup END

nmap <Leader>b :<C-u> silent make build \| cwindow \| redraw!<CR>
nmap <Leader>r :<C-u> silent make run   \| copen   \| redraw!<CR>
nmap <Leader>t :<C-u> silent make test  \| copen   \| redraw!<CR>
nmap <Leader>m :<C-u> silent make bench \| copen   \| redraw!<CR>

setlocal completeopt-=preview

if executable('rusty-tags')
  setlocal tags=./tags;/,$RUST_SRC_PATH/tags
  command! UpdateRustyTags execute 'silent !rusty-tags vi --start-dir=' . expand('%:p:h') | redraw!
endif

" set current toolchain's src path
if executable('rustc')
  let sysroot = substitute(system('rustc --print sysroot'), '\n', '', '')
  let srcpath = expand(sysroot . '/lib/rustlib/src/rust/src')
  let $RUST_SRC_PATH = isdirectory(srcpath) ? srcpath : ''
endif
