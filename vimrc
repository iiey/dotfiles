"BASIC SETTING {{{
"Folding option for this file
setlocal foldmethod=marker  "use marker curved bracket for folding
setlocal foldlevel=2        "over level 1 will be closed

"LANGUAGE INTERFACE
"set language for output :messages
if has('unix')
    language messages C
else
    language messages en
endif

"INTERACTION
set cursorline
set incsearch       "show matching while searching
set ignorecase      "ignore case in search pattern
set hlsearch        "highlight matching search string
set number          "show line number
set relativenumber  "show relative line number
set mouse=a         "activate mouse in all modes 'a'/ normal mode 'n'
set scrolloff=3     "screen lines offset above and below cursor
"set ttymouse=xterm2 "xterm-like mouse handling (support drag to resize split windows)
set t_Co=256        "enable term color 256
set encoding=utf-8
"loading time 20ms
syntax on                               "enable syntax highlighting
filetype on                             "enable filetype detecting
filetype plugin indent on               "smartindent based filetype, set cindent for c/c++

"CODING STYLE
set tabstop=4
set softtabstop=4           "using <BS> like <Tab>
set shiftwidth=4
set expandtab
set autoindent              "same indent in newline
set backspace=2             "solve some hw vs system conflict, make it work like other apps. See also :help backspace
"set smartindent             "increase indent in newblock

"DIFFING
if &diff && g:colors_name != 'solarized'
    highlight DiffAdd    cterm=bold ctermfg=white ctermbg=DarkGreen
    highlight DiffDelete cterm=bold ctermfg=white ctermbg=DarkGrey
    highlight DiffChange cterm=bold ctermfg=white ctermbg=DarkBlue
    highlight DiffText   cterm=bold ctermfg=white ctermbg=DarkRed
endif

"SESSION
"prevent annoying if vimrc changed after session saved
set ssop-=options    " do not store global and local values in a session

"file format linux
"set ff=unix
"set autochdir // auto. change current working directory
" }}}


"TMUX - Handle some issues {{{
"FIX ARROWS
"vim not recognize arrow characters
"vim handles keywords correctly if it 'TERM=xterm-...' but tmux using screen-256color
if &term =~? '^screen'
    " tmux will send xterm-style keys when its xterm-keys option is on
    "need to be set in tmux.conf: set-window-option -g xterm-keys on
    execute "set <xUp>=\e[1;*A"
    execute "set <xDown>=\e[1;*B"
    execute "set <xRight>=\e[1;*C"
    execute "set <xLeft>=\e[1;*D"
endif
"TODO Alt not work, not tmux but general problem of terminals by redirect
"keystroke to vim
"}}}



"VIMPLUG {{{
"the minimalist plugin manager

"automatic install vimplug if not exists
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

"load plugins from specific directory
call plug#begin('~/.vim/bundle')

"basic
Plug 'bling/vim-airline' | Plug 'vim-airline/vim-airline-themes'
Plug 'bitc/vim-bad-whitespace'
Plug 'octol/vim-cpp-enhanced-highlight'
Plug 'ctrlpvim/ctrlp.vim'
Plug 'bogado/file-line'

"extended
Plug 'skywind3000/asyncrun.vim'
Plug 'tpope/vim-fugitive'
Plug 'SirVer/ultisnips'
Plug 'honza/vim-snippets'
Plug 'Rip-Rip/clang_complete'
Plug 'mbbill/undotree', {'on': 'UndotreeToggle'}
Plug 'easymotion/vim-easymotion', {'on': '<Plug>(easymotion-f)'}

"enhanced
Plug 'iiey/vim-startify'
Plug 'majutsushi/tagbar'
Plug 'edkolev/tmuxline.vim'
Plug 'scrooloose/nerdtree', {'on': []}
    Plug 'jistr/vim-nerdtree-tabs'
    Plug 'ryanoasis/vim-devicons'
Plug 'wincent/terminus'
Plug 'iiey/vimcolors'

"initalize plugin system
call plug#end()

"vimplug defers some plugins (lazzy loader)
"do onetime loading based events
augroup load_on_move
  autocmd!
  autocmd CursorMoved * call plug#load('nerdtree') | autocmd! load_on_move
augroup END

"more easy way: load plugins at startup
"execute pathogen#infect()
"}}}



" COLORSCHEME {{{
set background=dark
if $KONSOLE_PROFILE_NAME ==? "solarized"
    silent! colorscheme solarized
    let g:airline_theme='solarized'
else
    silent! colorscheme codedark
    let g:quantum_black=1
    let g:airline_theme='codedark'
endif
"}}}


"VIM-AIRLINE {{{
set laststatus=2                                    "always show status line
let g:airline_powerline_fonts=1                     "enable powerline font

"TABLINE (upper bar)
let g:airline#extensions#tabline#enabled = 1        "show tabline
let g:airline#extensions#tabline#fnamemod = ':t'    "show just the filename
let g:airline#extensions#tabline#show_tab_nr = 0    "hide useless tab number
let g:airline#extensions#tabline#tab_min_count = 2  "show tabline with condition

"hide right side of tabline (buffer list)
let g:airline#extensions#tabline#buffer_nr_show = 0 "hide confusing (when editing same file in multiple tabs) buffer index
let g:airline#extensions#tabline#show_buffers = 0   "do not show buffers on tabline (when only tab exists)
let g:airline#extensions#tabline#show_tab_type = 0
let g:airline#extensions#tabline#show_splits = 0
let g:airline#extensions#tabline#close_symbol = 'x'
"let g:airline#extensions#tabline#show_close_button = 0

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
" }}}


"STARTIFY (modified) {{{
if !empty(glob("~/.vim/bundle/*startify"))
    "STARTUP limit lists to show
    let g:startify_list_order = [['MRU:'], 'files',  ['Bookmark:'], 'bookmarks', ['Session:'], 'sessions']

    "MRU limit list of mru files
    let g:startify_files_number = 7
    "ignore session in mru
    let g:startify_session_ignore_files = 1

    "BOOKMARK
    let g:startify_bookmarks = [{'v': '~/.vimrc'}, {'g': '~/.gvimrc'}, {'m': '~/.myrc'}, {'b': '~/.bashrc'}, {'t': '~/.tmux.conf'}]

    "SESSION
    "where to store and load session
    let g:startify_session_dir = '~/.vim/session'
    "auto. update current session when leaving vim (:qa) or loading new one (:SLoad)
    let g:startify_session_persistence = 1
    "set empty. Do not auto. remove commands from session file
    let g:startify_session_remove_lines = []

    "FOOTER
    "add vimtip to footer
    let g:startify_enable_vimtip = 1

    "FIXME loading time 27ms
    "custom footer
"    let g:startify_custom_footer = map(split(system('vim --version | head -n1'), '\n'), '"   ". v:val') + [''] +
"                                 \ map(split(strftime("%c"), '\n'), '"   ". v:val') +
"                                 \ ['   Hey ' . $USER . '! This cow has a vimtip for you:']

    let g:startify_session_before_save = ['silent! NERDTreeTabsClose', 'silent! TagbarClose']

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


"COMPLETION (builtin) {{{
"DICTIONARY
"Add default file if on FreeBSD
if filereadable("/usr/share/dict/words")
    set dictionary+=/usr/share/dict/words
    "Enable completion from defined dictionary
    set complete+=k                     "<c-x><c-k> to trigger this list
endif

"OMNI COMPLETION
set omnifunc=syntaxcomplete#Complete    "open in I-Mode <c-x><c-o>, navigate <c-n/p>, close <c-e>

"Custom behaviour of completion menu
"longest: don't select first macht but the longest common text of all matches
"menuone: menu will come up even if there's one match
set completeopt=longest,menuone

"improve c-n: keep popup menu on while typing to narrow the matches
"pumvisible: return non-zero if PopUpMenu visible otherwise false
inoremap <expr> <C-n> pumvisible() ? '<C-n>' :
            \ '<C-n><C-r>=pumvisible() ? "\<lt>Down>" : ""<CR>'

"COMMAND-LINE
"Improve tab completion in command mode
"if searching for file, tell vim to look downwards recursive (two asterisks)
"See also help path, file-searching and cpt
"set path +=**
"show candidates in a menu line, iterate with tab and shift-tab
"set wildmenu
"or list all matches with tab (same as ctrl-d)
"set wildmode=longest,list
"}}}


"CLANG_COMPLETE {{{
"Using omnifunc=ClangComplete because builtin ccomplete don't work correctly
"<c-x><c-u> to trigger specific completefunc

"path to directory which contains libclang.{dll|so|dylib} (win/linux/macos)
"let g:clang_library_path='/usr/lib/'
"or direct path to current actual libclang
let g:clang_library_path=expand("$HOME")."/lib/libclang.so"

"also complete parameters of function
let g:clang_snippets = 1
"alternative default engine 'clang_complete'
let g:clang_snippets_engine = 'ultisnips'
"prevent default key from disable tagjump <c-]>
let g:clang_jumpto_declaration_key = '<c-w>['
"}}}


"ULTISNIPS {{{
"using snippets template from: https://github.com/honza/vim-snippets.git
"note: it will search in runtimepath for dir with names on the list below
let g:UltiSnipsSnippetDirectories=["UltiSnips"]
"<c-tab> reserved by iterm for switching tab
let g:UltiSnipsListSnippets='<c-h>'
"<c-k> interferes with completion i_ctrl-x
let g:UltiSnipsJumpBackwardTrigger='<c-l>'
" }}}


"EXUBERANT CTAGS {{{
set tags=./.tags;$HOME/sources              "searching for .tags from current upwards to ~/sources (stop-dir)
"set tags+=$HOME/.vim/tags/cpp
"set tags+=$HOME/.vim/tags/opencv
"set tags+=$HOME/.vim/tags/qt

"guess projRootDir by checking version control system
for vcs in ['.git', '.svn', '.hg']
    "searching from current "." upwards ";" to "~/sources"
    let projRootDir = fnamemodify(finddir(vcs, '.;$HOME/sources'), ':h')
    if isdirectory(projRootDir.'/'.vcs)
        "init env-var for later uses
        let $proj = projRootDir
        break
    else
        let projRootDir = ''
    endif
endfor


function! UpdateCtags(proDir)
    "generate ctags only for projects
    if empty(a:proDir) | echom "project directory empty!" | return | endif
    "execute 'ctags' at projDir to take advantage of --tag-relative=yes
    let cmd = 'cd ' . a:proDir . '&&' . 'ctags -f ./.tags .'
    if exists(":AsyncRun")
        execute "AsyncRun " . cmd
    else
        call system(cmd) | echom "write:" . a:proDir . "/.tags"
    endif
endfunction
" }}}


"CTRLP {{{
"ctrlp auto. finds projectRoot based on .svn/.git...
let g:ctrlp_working_path_mode = 'ra'                "working dir is nearest acestor of current file
let g:ctrlp_custom_ignore = {
    \ 'dir':  '\v[\/](.git|.svn|build|tmp)$',
    \ 'file': '\v\.(exe|so|dll|swp|tags|zip)$'}          "exclude file and directories
"set wildignore+=*/tmp/*,*/build/*,*.so,*.swp,*.zip
let g:ctrlp_by_filename = 1                         "default searching by filename instead of full path
let g:ctrlp_map = '[p'
"let g:ctrlp_cmd = 'CtrlPMixed'                      "invoke default command to find in file, buffer and mru
" }}}


"NERD_TREE {{{
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

"ignore files and folder
let NERDTreeIgnore=['build', '\~$']
"hide first help line
let NERDTreeMinimalUI = 1

"NERDTREE_TABS
let g:nerdtree_tabs_autofind = 1
let g:nerdtree_tabs_open_on_gui_startup = 0

"NETRW
let g:NERDTreeHijackNetrw = 0   "do not deactivate netrw (for opening directory)
let g:netrw_liststyle = 3       "tree style
" }}}


"DEVICON {{{
"Devicon for nerdtree

"loading devicon
let g:webdevicons_enable = 1

" Force extra padding in NERDTree so that the filetype icons line up vertically
let g:WebDevIconsNerdTreeGitPluginForceVAlign = 1

"padding between symbol and text
let g:WebDevIconsNerdTreeAfterGlyphPadding = ''


"NERDTREE_HIGHLIGHT
"disable highlight, lag with big tree
let g:NERDTreeSyntaxDisableDefaultExtensions = 1

"Disable uncommon file extensions highlighting, reduce lag when scrolling
let g:NERDTreeLimitedSyntax = 1
"highlight files
let g:NERDTreeFileExtensionHighlightFullName = 1
" }}}


"EASYMOTION {{{
"uncomment for using <leader> instead of <leader>²
"map <leader> <Plug>(easymotion-prefix)

"remap only one feature
nmap <leader>f <Plug>(easymotion-f)

"v matches [v|V] and V matches only [V]
let g:EasyMotion_smartcase = 1
"}}}


"OTHER PLUGINS {{{
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


"MAKE {{{
"identify build-folder by searching "upwards" for "build" from "." to "~/sources"
let projBuildDir = finddir('build', '.;$HOME/sources')
if projBuildDir !=""
    let &makeprg='cmake --build ' . shellescape(projBuildDir) . ' --target '
endif
"Note: Using "-- -jN" to pass jobs config to make command
"}}}


"GREP - SILVER SEARCH {{{
if executable('ag')
  "use Ag over Grep
  set grepprg=ag\ --nogroup\ --nocolor

  "use ag in CtrlP for listing files. Lightning fast and respects .gitignore
  let g:ctrlp_user_command = 'ag -Q -l --nocolor --hidden -g "" %s'

  "ag is fast that ctrlp doesn't need to cache
  let g:ctrlp_use_caching = 0

endif
"}}}


"ASYNCRUN {{{
"run shell commands on background and read output in quickfix window (vim8)

"TODO create commands if only asyncrun available => vim/after
"Note plugins are not run, we cannot check if exists(':AsyncRun')
":Make runs :make in background with asyncrun
command! -bang -nargs=* -complete=file Make AsyncRun -program=make @ <args>
":Ag runs :grep in background with asyncrun
command! -bang -nargs=* -complete=file Ag AsyncRun -program=grep @ <args>

"FIXME search pattern with double quotes not work
if !exists(':Ag') && executable('ag')
    command -nargs=+ -complete=file -bar Ag silent! grep! <args>|cwindow|redraw!
endif

"helper function for closing quickfix after finishing job
function! OnAsyncExit()
    "user can close quickfix manually if it displays grep results
    let l:grep_job = 0
    for cmd in ['^ag', '^ack', '^grep']
        if @: =~? cmd | let l:grep_job += 1 | endif
    endfor
    "create a timer if only job other than grep succeeded
    if g:asyncrun_status == 'success' && grep_job == 0
        "fire a timer with lambda as it's function callback
        "lambda body handles only an expression expr1
        "using execute() to have expr1 from an Ex command
        let timer = timer_start(500, {-> execute(":call asyncrun#quickfix_toggle(8, 0)")})
    endif
endfunc

"display progress in statusline of airline
"let g:airline_section_error = airline#section#create_right(['%{g:asyncrun_status}'])
"}}}


"UTILS FUNCTIONS {{{

"Toggle line number: hydrid/absolute/none
function! ToggleLineNumber()
    "consider (nu/rnu)-pairs are states of line number => 00, 01, 10, 11
    "transition in 7.3: 00 -> 01 -> 10 -> 00 (11 only available up 7.4)
    "transition in 7.4: 00 -> 11 -> 10 -> 00 (don't toggle trivial 01)
    if &number == 0 && &relativenumber == 0
        if v:version >= 704 | set number | endif
        set relativenumber
    elseif &relativenumber == 1
        set number
        set norelativenumber
    else
        set nonumber
        set norelativenumber
    endif
endfunc


"Toggle solarized/wombat colorscheme
function! ToggleColor()
    if g:colors_name != 'solarized'
        set background=dark
        colorscheme solarized
        AirlineTheme solarized
    else
        colorscheme wombat256mod
        AirlineTheme wombat
    endif
endfunction

"Toggle cpp header
"@see :h filename-modifiers
"TODO expand file extension with tab
function! ToggleSourceHeader()
  if (expand ("%:e") == "cpp")
    find %:t:r.h
  else
    find %:t:r.cpp
  endif
endfunction
nnoremap ,s :call ToggleSourceHeader()<cr>

"Change colorscheme and airlinetheme
function! ChangeTheme(color)
    "Using 'execute' to evaluate value of argument not the argument
    execute ':colorscheme' a:color

    if a:color == 'solarized'
        set background=dark
    endif

    if a:color == 'codeschool'
        execute ':AirlineTheme cobalt2'
        return
    endif

    execute ':AirlineTheme' a:color
endfunction
command! -nargs=* -complete=color ChangeTheme call ChangeTheme('<args>')

"Head-up digraphs
function! HUDigraphs()
    digraphs
    call getchar()
    return "\<c-k>"
endfunction
inoremap <expr> <c-d> HUDigraphs()

"ON_EXIT
function! OnQuit()
    if &mod
        echo "Save & Quit [Y|y]es/[N|n]o/[c]ancle: "
        let l:saved = getchar()
        let l:saved = nr2char(l:saved)

        if l:saved ==# 'Y'
            execute ':xa'
        elseif l:saved ==# 'y'
            execute ':x'
        elseif l:saved ==# 'N'
            execute ':qa!'
        elseif l:saved ==# 'n'
            execute ':q!'
        elseif l:saved ==? 'c'
            redraw | echo "File not saved"
        endif
    else
        execute ':qa'
    endif
endfunction
" }}}


" AUTOCMD {{{
augroup vimrc
    "prevent calling multiple times by sourcing
    autocmd!
    "update tags on saving
    "autocmd BufWritePost *.cpp,*.h,*.c silent! call UpdateCtags(projRootDir)
    "change directory of current local window
    "autocmd bufenter * silent! lcd %:p:h

    "TODO write function in case more than one left behind windows of these kinds
    "close vim if one left behind window is nerdtree, quickfix or help
"    autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
    autocmd bufenter * if (winnr("$") == 1 && getbufvar(winbufnr(1), '&buftype') == 'quickfix') | q | endif
    autocmd bufenter * if (winnr("$") == 1 && getbufvar(winbufnr(1), '&buftype') == 'help') | q | endif

    "open when asyncrun starts
    autocmd User AsyncRunStart if exists(':AsyncRun') | call asyncrun#quickfix_toggle(8, 1)
    "and close on success
    autocmd User AsyncRunStop if exists(':AsyncRun') | call OnAsyncExit()
    "one line statement without timer function
    "autocmd User AsyncRunStop if g:asyncrun_status=='success'|call asyncrun#quickfix_toggle(8, 0)|endif
augroup END
" }}}


" MAPPING {{{
"LEADER KEY (by default is backslash "\")
"let mapleader = "["

"buffers
nnoremap <silent> <leader>b :buffers<cr>:buffer<space>
"toggle colortheme
nnoremap <silent> <leader>c :call ToggleColor()<cr>
"relative line number
nnoremap <silent> <leader>l :call ToggleLineNumber()<cr>
"toggle highlight cursor
nnoremap <silent> <leader>h :set cursorline!<cr>
"find used keyword under cursor & ignore default [i
nnoremap <silent> <leader>i [I:let nr = input("Enter item: ")<bar>if nr != ''<bar>exe "normal " . nr ."[\t"<bar>endif<cr>
"marks
nnoremap <silent> <leader>m :marks<bar>:let nr = input("Enter mark: ")<bar>if nr != ''<bar>exe "\'" . nr<bar>endif<cr>
"turn off highlighting searched pattern
nnoremap <silent> <leader>s :nohlsearch<cr>
"refresh vimrc
nnoremap <silent> <leader>r :if &mod <bar>:write<bar>endif<bar>:source $MYVIMRC<bar>:redraw<bar>:echo ".vimrc reloaded!"<cr>
"change tab
nnoremap <silent> <leader>t :tabs<cr>:let nr = input("Enter tab: ")<bar>if nr!= ''<bar>exe "normal" . nr . "gt"<bar>endif<cr>

"enter Ex command
nnoremap ; :
"replacement for next match with focus f
nnoremap <space> ;

"QUICKFIX:
nnoremap <silent> <leader>q :call asyncrun#quickfix_toggle(8)<cr>
nnoremap <C-n> :cnext<cr>zz
nnoremap <C-p> :cprevious<cr>zz

"quit all not save
nnoremap <C-q> :qa!<cr>
"save all & quit
nnoremap <C-s> :xa<cr>

"silver search (disable line substitute)
"<c-r> inserts contain of named register, '=" register expr, <cword> expr of word under cursor
"see :h c_ctrl-r
"use double quote to escape regex character
nnoremap S :Ag<space>"<c-r>=expand("<cword>")<cr>"
"change working directory
nnoremap [cd :cd %:p:h<cr>:pwd<cr>

"WINDOW:
"s for split and disable word substitude
noremap s <c-w>
"simulate tmux key-z
"not overwrite behaviour of ctrl-w_z, resize back ctrl-w_=
noremap sz :wincmd _<bar>wincmd \|<cr>
"win-resize vertical
nnoremap s, 5<c-w><
nnoremap s. 5<c-w>>
"win-resize horizontal
nnoremap s0 5<c-w>+
nnoremap s- 5<c-w>-

"MOVEMENT:
"increase steps of basic moves
nnoremap <C-e> 5<C-e>
nnoremap <C-y> 5<C-y>
"this is convenient and more comfortable
nnoremap <C-j> 5<C-e>
nnoremap <C-k> 5<C-y>

"SEARCHING:
"make matches appear in the middle of screen (add zz)
nnoremap n nzz
nnoremap N Nzz
nnoremap * *zz
nnoremap # #zz
nnoremap g* g*zz
nnoremap g# g#zz
nnoremap <c-]> <c-]>zz
"manual change cword forwards
"repeat with: <c-[>(goto normal) n(ext match) .(repeat)
nnoremap c* *<c-o>cgn

"TABS JUMP:
"tabprevious (gT) and tapnext (gt)
"or ngt for jumping to n.te tab
noremap <C-S><left> :tabp<cr>
noremap <C-S><right> :tabn<cr>
"these interfere shift lines left and right
noremap < :tabp<cr>
noremap > :tabn<cr>
"using (s-)tab and and repeat with dot command to shift instead
vnoremap <tab> >
vnoremap <s-tab> <

"map vertical help
cnoremap vh vert botright help<space>
"map vertical splitfind
cnoremap vf vert sf<space>

"FN:
nnoremap <silent>   <F2> :call ToggleNERDTreeFind()<cr>
nnoremap            <F3> :TagbarToggle<cr>
nnoremap <silent>   <F4> :call UpdateCtags(projRootDir)<cr>
nnoremap            <F5> :UndotreeToggle<cr>

nnoremap <silent>   <F10> :call OnQuit()<cr>
imap                <F10> <c-o><F10>                        "if in Insert-Mode switch to Insert-Normal-Mode to execute F10

"DEACTIVATION:
"useless substitutions
"nnoremap s <NOP>
"nnoremap S <NOP>
"backtick as tmux keybind, disable in vim
nnoremap ` <NOP>
"join line
nnoremap J <NOP>
"show manual
nnoremap K <NOP>
"Ex mode
nnoremap Q <NOP>

" cppman
"command! -nargs=+ Cppman silent! call system("tmux split-window cppman " . expand(<q-args>))
"autocmd FileType cpp nnoremap <silent><buffer> K <Esc>:Cppman <cword><CR>
" }}}
