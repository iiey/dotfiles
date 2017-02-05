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
set ignorecase      "search with case-insensitive
set hlsearch        "highlight matching search string
set number          "show line number
set relativenumber  "show relative line number
set mouse=a         "activate mouse in all modes 'a'/ normal mode 'n'
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

"COLORSCHEME
set background=dark
"TODO fix this
if $KONSOLE_PROFILE_NAME ==? "solarized" || $TERM_PROGRAM ==? "iterm.app"
    "loading time 5ms
    silent! colorscheme solarized
    let g:airline_theme='solarized'
else
    silent! colorscheme wombat256mod
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
"}}}


"TMUX - Handle some issues {{{
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
"TODO Alt not work, not tmux but general problem of terminals by redirect
"keystroke to vim
"}}}



"PATHOGEN {{{
"loading time all plugins 40ms
"bundle management
execute pathogen#infect()
execute pathogen#helptags()
" }}}


"VIM-AIRLINE {{{
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
" }}}


"STARTIFY (modified) {{{
if !empty(glob("~/.vim/bundle/startify"))
    "set bookmark with shortcut
    let g:startify_bookmarks = [{'v': '~/.vimrc'}, {'g': '~/.gvimrc'}, {'m': '~/.myrc'}, {'r': '~/.bashrc'}, {'t': '~/.tmux.conf'}]
    "FIXME loading time 27ms
    "set vimtip as footer
"    let g:startify_custom_footer = map(split(system('vim --version | head -n1'), '\n'), '"   ". v:val') + [''] +
"                                 \ map(split(system('date -R'), '\n'), '"   ". v:val') +
"                                 \ ['   Hey ' . $USER . '! This cow has a vimtip for you:']
    let g:startify_enable_vimtip = 1
    "limit list of mru files
    let g:startify_files_number = 7
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


"ULTISNIPS {{{
"using snippets template from: https://github.com/honza/vim-snippets.git
let g:UltiSnipsSnippetDirectories=["$HOME/.vim/bundle/vim-snippets/UltiSnips"]
" }}}


"EXUBERANT CTAGS {{{
set tags=./.tags;$HOME/sources              "searching for .tags from current upwards to ~/sources (stop-dir)
"set tags+=$HOME/sources/tags_headers/qt55
"set tags+=$HOME/sources/tags_headers/gcc48

"guess projRootDir by checking version control system
for vcs in ['.git', '.svn', '.hg']
    "searching from current "." upwards ";" to "~/sources"
    let projRootDir = fnamemodify(finddir(vcs, '.;$HOME/sources'), ':h')
    if isdirectory(projRootDir.'/'.vcs)
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
"Deactivate using <Leader> instead of <Leader><Leader> for trigger
"map <Leader> <Plug>(easymotion-prefix)
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
  set grepprg=ag\ -Q\ --nogroup\ --nocolor

  "use ag in CtrlP for listing files. Lightning fast and respects .gitignore
  let g:ctrlp_user_command = 'ag -Q -l --nocolor --hidden -g "" %s'

  "ag is fast that ctrlp doesn't need to cache
  let g:ctrlp_use_caching = 0

  "Use this if asyncrun not exists
  if !exists(":Ag")
    command -nargs=+ -complete=file -bar Ag silent! grep! <args>|cwindow|redraw!
  endif
endif
"}}}


"ASYNCRUN {{{
"run shell commands on background and read output in quickfix window (vim8)

"TODO create commands if only asyncrun available => vim/after
":Make runs :make in background with asyncrun
command! -bang -nargs=* -complete=file Make AsyncRun -program=make @ <args>
":Ag runs :grep in background with asyncrun
command! -bang -nargs=* -complete=file Ag AsyncRun -program=grep @ <args>

"helper function for closing quickfix after finishing job
function! OnAsyncExit()
    "user can close quickfix manually if it displays grep results
    let l:grep_job = 0
    for cmd in ['^ag', '^ack', '^grep']
        if @: =~ cmd | let l:grep_job += 1 | endif
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
    if g:colors_name != 'solarized'
        set background=dark
        colorscheme solarized
        AirlineTheme solarized
    else
        colorscheme wombat256mod
        AirlineTheme wombat
    endif
endfunction


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


" AUTOCMD {{{
augroup vimrc
    "prevent calling multiple times by sourcing
    autocmd!
    "update tags on saving
    "autocmd BufWritePost *.cpp,*.h,*.c silent! call UpdateCtags(projRootDir)

    "TODO write function in case more than one left behind windows of these kinds
    "close vim if one left behind window is nerdtree, quickfix or help
    autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
    autocmd bufenter * if (winnr("$") == 1 && getbufvar(winbufnr(1), '&buftype') == 'quickfix') | q | endif
    autocmd bufenter * if (winnr("$") == 1 && getbufvar(winbufnr(1), '&buftype') == 'help') | q | endif

    "open quickfix when asyncrun starts
    autocmd User AsyncRunStart call asyncrun#quickfix_toggle(8, 1)
    "and close on success
    autocmd User AsyncRunStop call OnAsyncExit()
    "one line statement without timer function
    "autocmd User AsyncRunStop if g:asyncrun_status=='success'|call asyncrun#quickfix_toggle(8, 0)|endif
augroup END
" }}}


" MAPPING {{{
"LEADER KEY (by default is backslash "\")
"let mapleader = "["

"command mode
nnoremap ; :
nnoremap : ;
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
"quickfix
noremap <silent> <leader>q :call asyncrun#quickfix_toggle(8)<cr>
"quit without saving
nnoremap <C-q> :q!<cr>
"save file with Ctrl-S
nnoremap <C-s> :w<cr>
"ag or S for Search (disable line substitute)
nnoremap S :Ag<Space>
"map vertical help
cnoremap h\ :vertical botright help

"DEACTIVATION
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

"MOVEMENT
"increase steps of basic moves
nnoremap <C-e> 5<C-e>
nnoremap <C-y> 5<C-y>
"this is convenient and more comfortable
nnoremap <C-j> 5<C-e>
nnoremap <C-k> 5<C-y>

"WINDOWS or s for slits (disable character substitute)
noremap s <c-w>

"TABS JUMP
noremap <C-S><left> :tabl<cr>
noremap <C-S><right> :tabr<cr>
noremap <C-S><up> :tabn<cr>
noremap <C-S><down> :tabp<cr>

"F-n
nnoremap <silent>   <F2> :call ToggleNERDTreeFind()<cr>
nnoremap            <F3> :TagbarToggle<cr>
nnoremap <silent>   <F4> :call UpdateCtags(projRootDir)<cr>
nnoremap            <F5> :UndotreeToggle<cr>

nnoremap <silent>   <F10> :call OnQuit()<cr>
imap                <F10> <c-o><F10>                        "if in Insert-Mode switch to Insert-Normal-Mode to execute F10

" cppman
"command! -nargs=+ Cppman silent! call system("tmux split-window cppman " . expand(<q-args>))
"autocmd FileType cpp nnoremap <silent><buffer> K <Esc>:Cppman <cword><CR>
" }}}
