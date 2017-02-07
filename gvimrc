" Set language menu, mostly gvim we don't see often :menu in vim
source $VIMRUNTIME/delmenu.vim
set langmenu=en_US
source $VIMRUNTIME/menu.vim

" Font selection
if has('gui_gtk') || has('gui_gnome')
    "set guifont=Monospace\ 10
    set guifont=DejaVu\ Sans\ Mono\ for\ Powerline\ 9
    colorscheme codeschool
    let g:airline_theme='cobalt2'
elseif has('gui_macvim')
    set guifont=Sauce\ Code\ Powerline\ Light:h13
    colorscheme tomorrow-night
    let g:airline_theme='tomorrow'
endif

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
" see also :h mouseshape
"set mouseshape=n:pencil

function! ToggleToolbar()
    if &go =~# '[mT]'
        set guioptions -=mT
    else
        set guioptions +=mT
    endif
endfunction
noremap <silent> <Leader>t :call ToggleToolbar()<cr>
