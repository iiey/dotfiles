"Basic Setting {{{
"Folding option for this file
setlocal foldmethod=marker  "use marker curved bracket for folding
setlocal foldlevel=2        "over level 1 will be closed

"LANGUAGEA INTERFACE
set langmenu=en_US
source $VIMRUNTIME/delmenu.vim
source $VIMRUNTIME/menu.vim

"INTERACTION
set cursorline
set incsearch       "show matching while searching
set ignorecase      "search with case-insensitive
set hlsearch        "highlight matching search string
set number          "show line number
set relativenumber  "show relative line number
set mouse=a         "activate mouse all
set t_Co=256        "enable term color 256
set encoding=utf-8
syntax on                               "enable syntax highlighting
filetype on                             "enable filetype detecting
filetype plugin indent on               "smartindent based filetype, set cindent for c/c++

"CODING STYLE
set tabstop=4
set softtabstop=4           "using <BS> like <Tab>
set shiftwidth=4
set expandtab
set autoindent              "same indent in newline
"set smartindent             "increase indent in newblock

"COLORSCHEME
"check konsole profile (if exists) for autoloading theme when file opened
set background=dark
if $KONSOLE_PROFILE_NAME == "Solarized"
    colorscheme solarized
    let g:airline_theme='solarized'
else
    colorscheme wombat256mod
    let g:airline_theme='wombat'
endif

"CHANGE SOME COLORS WHEN DIFFING WITHOUT SOLARIZED THEME
if &diff && g:colors_name != 'solarized'
    highlight DiffAdd    cterm=bold ctermfg=white ctermbg=DarkGreen
    highlight DiffDelete cterm=bold ctermfg=white ctermbg=DarkGrey
    highlight DiffChange cterm=bold ctermfg=white ctermbg=DarkBlue
    highlight DiffText   cterm=bold ctermfg=white ctermbg=DarkRed
endif

"file format linux
"set ff=unix
"set autochdir // auto. change current working directory
" }}}


"tmux+vim: handle some issues {{{
"CHANGE CURSOR SHAPE (block->doppelT) in insert-mode (work with iTerm, Konsole)
"Fix: for Tmux b/c of not forwarding correctly Esc)
"Problem: Cause changing font size when entering InsertMode
"if exists('$TMUX')
"    let &t_SR = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=2\x7\<Esc>\\"
"    let &t_SI = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=1\x7\<Esc>\\"
"    let &t_EI = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=0\x7\<Esc>\\"
"else
    let &t_SR = "\<Esc>]50;CursorShape=2\x7"
    let &t_SI = "\<Esc>]50;CursorShape=1\x7"
    let &t_EI = "\<Esc>]50;CursorShape=0\x7"
"endif

"FIX ARROWS
"vim not recognize arrow characters
"vim handles keywords correctly if it 'TERM=xterm-...' but tmux using screen-256color
if &term =~ '^screen'
    " tmux will send xterm-style keys when its xterm-keys option is on
    "need to be set in tmux.conf: set-window-option -g xterm-keys on
    execute "set <xUp>=\e[1;*A"
    execute "set <xDown>=\e[1;*B"
    execute "set <xRight>=\e[1;*C"
    execute "set <xLeft>=\e[1;*D"
endif
"}}}




"vim-pathogen bundle management {{{
execute pathogen#infect()
execute pathogen#helptags()
" }}}


"vim-airline {{{
let g:airline_powerline_fonts=1                     "enable powerline font
set laststatus=2                                    "always show airline status

"TABLINE (upper bar)
let g:airline#extensions#tabline#enabled = 1        "show tabline
let g:airline#extensions#tabline#show_buffers = 0   "do not show buffers on tabline (when only tab exists)
let g:airline#extensions#tabline#fnamemod = ':t'    "show just the filename
let g:airline#extensions#tabline#show_tab_nr = 0    "hide useless tab number
let g:airline#extensions#tabline#buffer_nr_show = 0 "hide confusing (when editing same file in multiple tabs) buffer index
"let g:airline#extensions#tabline#tab_min_count = 2  "show tabline with condition

"try to hide right side of tabline but not work
let g:airline#extensions#tabline#show_tab_type = 0
let g:airline#extensions#tabline#close_symbol = 'X'

"enable/disable detection of whitespace errors
let g:airline#extensions#whitespace#enabled = 0


"AIRLINE-THEMES EXTENSION
"theme name must match one of files under airline-themes/autoload/airline/themes
"change theme in vim with command :AirlineTheme [theme]
"let g:airline_theme='solarized'

"TMUXLINE EXTENSION
"1. set a a colortheme and a preset with :Tmuxline [theme] [preset]
"available templates under tmuxline/autoload/tmuxline/[theme|preset]
"2. create a snapshot file with :TmuxlineSnapshot [file]
"3. add it to .tmux.conf: if-shell "test -f [file]" "source [file]"
let g:airline#extensions#tmuxline#enabled = 0       "disable autoload same theme as vim when starts vim

"let g:clang_library_path="/home/ly/lib/"
" }}}


"Startify (modified) {{{
if !empty(glob("$HOME/.vim/bundle/startify"))
    "set bookmark with shortcut
    let g:startify_bookmarks = [{'v': '$HOME/.vimrc'}, {'g': '$HOME/.gvimrc'}, {'m': '$HOME/.myrc'}, {'r': '$HOME/.bashrc'}, {'t': '$HOME/.tmux.conf'}]
    "set vimtip as footer
    let g:startify_custom_footer =
                                \ map(split(system('vim --version | head -n1'), '\n'), '"   ". v:val') +
                                \ [''] + [''] + [''] +
                                \ map(split(system('date -R'), '\n'), '"   ". v:val') +
                                \ ['   Hey ' . $USER . '! This cow has a vimtip for you:'] +
                                \ map(startify#fortune#cowtip(), 'v:val')

    "set empty. Do not auto. remove commands from file
    let g:startify_session_remove_lines = []
    "set color
    highlight StartifyBracket ctermfg=240
    highlight StartifyHeader  ctermfg=114
    highlight StartifyFooter  ctermfg=245
    highlight StartifyNumber  ctermfg=215
    highlight StartifyPath    ctermfg=245
    highlight StartifySlash   ctermfg=240
    highlight StartifyVar     ctermfg=250
endif
"}}}


"ultiSnips {{{
"using snippets template from: https://github.com/honza/vim-snippets.git
let g:UltiSnipsSnippetDirectories=["$HOME/.vim/bundle/snippets/UltiSnips"]
let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsListSnippets="<c-l>"
let g:UltiSnipsJumpForwardTrigger="<c-j>"
let g:UltiSnipsJumpBackwardTrigger="<c-k>"
" }}}


"exuberant ctags {{{
set tags=./.tags;$HOME/sources              "searching for .tags from current to ~/sources
"set tags+=$HOME/sources/tags_headers/qt55
"set tags+=$HOME/sources/tags_headers/gcc48

"identify projDir by searching "upwards" for ".svn" from "." to "~/sources" (stop-dir is appended with ";")
"TODO seperate fnamemodify and findir to check for existance of result
let projRootDir = fnamemodify(finddir('.svn', '.;$HOME/sources'), ':h')

function! UpdateCtags(proDir)
    "execute 'ctags' at projDir to take advantage of --tag-relative=yes
    let cmd = 'cd ' . a:proDir . ';' . 'ctags -R --languages=C++ --exclude=build* --exclude=.svn --exclude=*.png -f ./.tags . &'
    call system(cmd)
    echom "write:" . a:proDir . "/.tags"
endfunction
"Auto call function if file is saved
"autocmd BufWritePost *.cpp,*.h,*.c silent! call UpdateCtags(projRootDir)
" }}}


"omni completion (builtin) {{{
set omnifunc=syntaxcomplete#Complete    "open in I-Mode <c-x><c-o>, navigate <c-n/p>, close <c-e>

"Custom behaviour of completion menu
"longest: don't select first macht but the longest common text of all matches
"menuone: menu will come up even if there's one match
set completeopt=longest,menuone

"improve c-n: keep popup menu on while typing to narrow the matches
"pumvisible: return non-zero if PopUpMenu visible otherwise false
inoremap <expr> <C-n> pumvisible() ? '<C-n>' :
            \ '<C-n><C-r>=pumvisible() ? "\<lt>Down>" : ""<CR>'
"}}}


"ctrlp {{{
let g:ctrlp_working_path_mode = 'ra'                "working dir is nearest acestor of current file
let g:ctrlp_custom_ignore = {
    \ 'dir':  '\v[\/](.git|.svn|.tags|build|tmp)$',
    \ 'file': '\v\.(exe|so|dll|swp|zip)$'}          "exclude file and directories
"set wildignore+=*/tmp/*,*/build/*,*.so,*.swp,*.zip
" }}}


"nerd_tree {{{
function! ToggleNERDTreeFind()
    "check if nerdtree is available
    if !exists('g:loaded_nerd_tree') | return | endif

    "use nerdtreetabs if it's available
    if exists('g:nerdtree_tabs_loaded')
        if g:NERDTree.IsOpen()
            execute ':NERDTreeTabsClose'
        else
            NERDTreeTabsOpen
            NERDTreeFocusToggle
            NERDTreeTabsFind
        endif
        return
    endif

    "use nerdtree otherwise
    if g:NERDTree.IsOpen() | NERDTreeClose | else | NERDTreeFind | endif
endfunction

" close nerdtree if there is no file left
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

"NETRW
let g:NERDTreeHijackNetrw = 0   "do not deactivate netrw (for opening directory)
let g:netrw_liststyle = 3       "tree style

"NERDTREE_TABS
let g:nerdtree_tabs_autofind = 1

" other plugins {{{
"CPP-ENHANCED-HIGHLIGHT
let g:cpp_class_scope_highlight = 1
"python-syntax
let g:python_highlight_all = 1

"UNDOTREE
if has("persistent_undo")               "set undodir to one place
    set undodir=~/.undodir/
    set undofile
endif

let g:undotree_SetFocusWhenToggle = 1   "cursor moved to undo-window when opened
let g:undotree_WindowLayout = 3         "undo-/diff-window open on the left side

"TAGBAR
let g:tagbar_autofocus=1                "focus on actual function

"BETTER-WHITESPACE
let g:better_whitespace_filetypes_blacklist=['txt', 'csv', 'ppm']
let b:bad_whitespace_show=0
" }}}

"easymotion {{{
"Deactivate using <Leader> instead of <Leader><Leader> for trigger
"map <Leader> <Plug>(easymotion-prefix)
"}}}

"utils functions {{{

"CMAKE+VIM
"identify build-folder by searching "upwards" for "build" from "." to "~/sources"
let projBuildDir = finddir('build', '.;$HOME/sources')
if projBuildDir !=""
    let &makeprg='cmake --build ' . shellescape(projBuildDir) . ' --target '
endif
"Note: Using "-- -jN" to pass jobs config to make command

"TOGGLE HYDRID/ABSOLUTE LINE NUMBER
function! ToggleLineNumber()
    "check absolute
    if &number == 0
        set number
    endif
    "toggle relative
    if &relativenumber == 1
        set norelativenumber
    else
        set relativenumber
    endif
endfunc

"Toggle solarized/wombat colorscheme
function! ToggleColor()
    if g:colors_name!='solarized'
        set background=dark
        colorscheme solarized
        AirlineTheme solarized
    else
        colorscheme wombat256mod
        AirlineTheme wombat
    endif
endfunction

"ON_EXIT
function! OnQuit()
    if &mod
        echo "Save & Quit [y]es/[n]o]/[c]ancle: "
        let l:saved = getchar()
        let l:saved = nr2char(l:saved)
        if l:saved ==? 'n'  "case-insensive comparision
            execute ':q!'
        elseif l:saved ==? 'c'
            redraw | echo "File not saved"
        else
            execute ':x'
        endif
    else
        execute ':q'
    endif
endfunction
" }}}


" Mapping {{{
"LEADER KEY (by default is backslash)
let mapleader = "["


"buffers
nnoremap <silent> <leader>b :buffers<cr>:buffer<space>
"toggle colortheme
nnoremap <silent> <leader>ct :call ToggleColor()<cr>
"relative line number
nnoremap <silent> <leader>l :call ToggleLineNumber()<cr>
"toggle highlight cursor
nnoremap <silent> <leader>h :set cursorline!<cr>
"find used keyword under cursor & ignore default [i
nnoremap <silent> <leader>i [I:let nr = input("Enter item: ")<bar>if nr != ''<bar>exe "normal " . nr ."[\t"<bar>endif<cr>
"marks
nnoremap <silent> <leader>m :marks<bar>:let nr = input("Enter mark: ")<bar>if nr != ''<bar>exe "\'" . nr<bar>endif<cr>
"turn off highlighting searched pattern
nnoremap <silent> <leader>n :nohlsearch<cr>
"refresh vimrc
nnoremap <silent> <leader>r :if &mod <bar>:write<bar>endif<bar>:source $MYVIMRC<bar>:redraw<bar>:echo ".vimrc reloaded!"<cr>
"change tab
nnoremap <silent> <leader>t :tabs<cr>:let nr = input("Enter tab: ")<bar>if nr!= ''<bar>exe "normal" . nr . "gt"<bar>endif<cr>

"quit without saving
nnoremap <C-q> :q!<cr>
"save file with Ctrl-S
nnoremap <C-s> :w<cr>

"DEACTIVATION
"backtick as tmux keybind, disable in vim
nnoremap ` <NOP>
"join line
nnoremap J <NOP>
"show manual
nnoremap K <NOP>
"Ex mode
nnoremap Q <nop>

"MOVEMENT
nnoremap <C-j> 5<C-e>
nnoremap <C-k> 5<C-y>

nnoremap <C-e> 5<C-e>
nnoremap <C-y> 5<C-y>

"TABS JUMP
map <C-S><left> :tabl<cr>
map <C-S><right> :tabr<cr>
map <C-S><up> :tabn<cr>
map <C-S><down> :tabp<cr>

"WINDOWS
"TODO mapping Alt not work
nmap <silent> <C-left> :wincmd h<cr>
nmap <silent> <C-down> :wincmd j<cr>
nmap <silent> <C-up> :wincmd k<cr>
nmap <silent> <C-right> :wincmd l<cr>

"F-n
nnoremap <silent>   <F2> :call ToggleNERDTreeFind()<cr>
nnoremap            <F3> :TagbarToggle<cr>
nnoremap <silent>   <F4> :call UpdateCtags(projRootDir)<cr>
nnoremap            <F5> :UndotreeToggle<cr>

nnoremap            <F10> :call OnQuit()<cr>
imap                <F10> <c-o><F10>                        "if in Insert-Mode switch to Insert-Normal-Mode to execute F10

" cppman
"command! -nargs=+ Cppman silent! call system("tmux split-window cppman " . expand(<q-args>))
"autocmd FileType cpp nnoremap <silent><buffer> K <Esc>:Cppman <cword><CR>
" }}}
