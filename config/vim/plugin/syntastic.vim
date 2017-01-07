let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 0
let g:syntastic_check_on_open = 0
let g:syntastic_check_on_wq = 0

let g:syntastic_mode_map = {
    \ "mode": "active",
    \ "active_filetypes": ["ocaml", "rust", "fsharp"],
    \ "passive_filetypes": ["c", "cpp"]
    \ }

if executable('clang++')
  let g:syntastic_cpp_compiler = 'clang++'
  let g:syntastic_cpp_compiler_options = '-std=c++14 -fsyntax-only'
  let g:syntastic_cpp_check_header = 1
endif

let g:syntastic_rust_checkers = ['rustc']
let g:syntastic_ocaml_checkers = ['merlin']
let g:syntastic_fsharp_checkers = ['syntax']
"let g:syntastic_vim_checkers = ['vint']
