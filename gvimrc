" Font selection
"set guifont=Monospace\ 10
set guifont=DejaVu\ Sans\ Mono\ for\ Powerline\ 9
let g:airline_powerline_fonts=1

colorscheme codeschool
let g:airline_theme='cobalt2'
silent highlight default CursorLine
"highlight Pmenu guibg=lightblue guifg=black

" Enable += | Disable -=
" Scrolll bar right and left
set guioptions-=r
set guioptions-=L
" Menu bar
set guioptions-=m
" Toolbar
set guioptions-=T

" Toggle bars with F6
let g:menubar=0
map <silent> <F11> :if g:menubar == 1<cr>:set guioptions-=mT<cr>:let g:menubar = 0<cr>
  \ :else<cr>:set guioptions+=mT<cr>:let g:menubar = 1<cr>:endif<cr>
