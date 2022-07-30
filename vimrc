"BASIC SETTING {{{
"Folding option for this file
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
set incsearch               "show matching while searching
set ignorecase              "ignore case in search pattern
set hlsearch                "highlight matching search string
set number                  "show line number
set relativenumber          "show relative line number
set mouse=a                 "activate mouse in all modes 'a'/ normal mode 'n'
set scrolloff=3             "screen lines offset above and below cursor
set t_Co=256                "enable term color 256
set laststatus=2            "always show status line
set encoding=utf-8
"use :set list/nolist to show/hide invisiable characters
set listchars=nbsp:¬,eol:¶,tab:>-,extends:»,precedes:«,trail:•

if v:version > 703
    set formatoptions+=j      "delete comment character when joining commented lines
endif

if !&autoread               "default turn on autoread
    set autoread            "notify changes outside vim and update file
endif                       "note: 'checktime' needs to call for comparing timestamp of buffer

if exists('&belloff')
    set belloff=all         "never ring the bell
endif

if has('clipboard')
    set clipboard=unnamed   "write system clipboard to unnamed register
endif

if has('linebreak')         "show character when long line's wrapped to fit the screen
    let &showbreak='↪ '     "downwards arrow with tip rightwards (U+21B3, UTF-8: E2 86 B3)
endif

"warning: extremely slow by editing large file with fmd syntax
if has('folding')           "folding option
    set foldmethod=syntax   "global folding method
    set foldlevel=3         "fold with higher level with be closed (0: always)
    set foldnestmax=1       "close only outermost fold
endif

if has('vertsplit')
    set splitright          "open vertical splits to the right of the current window
endif

if has('windows')
    set splitbelow          "open horizontal splits below current window
endif

"SYNTAX & FILETYPE
"loading time 20ms(vim74), 35ms(vim80)
if has('syntax') && !exists('g:syntax_on')
    syntax enable           "enable syntax highlighting
endif
"loading time 1ms
filetype plugin indent on   "smartindent based filetype, set cindent for c/c++

"CODING STYLE
set tabstop=4
set softtabstop=4           "using <BS> like <Tab>
set shiftwidth=4
set expandtab
set autoindent              "same indent in newline
set backspace=2             "solve some hw vs system conflict, make it work like other apps. See also :help backspace
"set smartindent             "increase indent in newblock

"SESSION
"prevent annoying if vimrc changed after session saved
set ssop-=options    " do not store global and local values in a session

"file format linux
"set ff=unix
"set autochdir // auto. change current working directory

"LOCAL VIMRC
"also try to load local config from this file if existed
if !empty(glob('~/.vim/vimrc.local'))
        source ~/.vim/vimrc.local
endif
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


"VIMPLUG {{{1
"Install vimplug {{{2
"auto install plugin manager if not exists
if empty(glob('~/.vim/autoload/plug.vim'))
    let s:link='https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
    if executable('curl')
        execute 'silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs ' . shellescape(s:link)
    elseif executable('wget')
        execute 'silent !wget -nd -P ~/.vim/autoload/ ' . shellescape(s:link)
    else
        finish
    endif
    "flag --sync blocks execution until install is finish
    autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif
"}}}

"Load plugins {{{2
"specific directory to load
call plug#begin('~/.vim/bundle')

""note: plugins are added to &runtimepath in the order they are defined here

"BASIC (essential) {{{3
Plug 'ntpeters/vim-better-whitespace'
Plug 'octol/vim-cpp-enhanced-highlight'
Plug 'wsdjeg/vim-fetch'
Plug 'tpope/vim-surround'
Plug 'iiey/vimcolors'
"}}}

"ENHANCED (productive) {{{3
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-fugitive'
    Plug 'tpope/vim-rhubarb'
Plug 'tpope/vim-vinegar'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --bin' }
    Plug 'junegunn/fzf.vim'
Plug 'skywind3000/asyncrun.vim'

"lsp
if v:version > 800 || has('nvim-0.5.0')
    Plug 'dense-analysis/ale'                           "linter and fixer
    if executable('node')
        Plug 'neoclide/coc.nvim', {'branch': 'release'} "completion
    endif
endif

"no zeal support on mac os because of dash
if ! has('mac') || ! has('osx')
    Plug 'KabbAmine/zeavim.vim'
endif

"ultisnip requires vim 7.4
Plug 'SirVer/ultisnips', v:version >= 704 ? { 'tag': '3.2' } : { 'on' : [] }
    Plug 'honza/vim-snippets', v:version >= 704 ? {} : {'on' : []}
"}}}

"OTHERS (optional) {{{3
Plug 'vim-airline/vim-airline' | Plug 'vim-airline/vim-airline-themes'
Plug 'iiey/vim-startify'
Plug 'preservim/tagbar'
Plug 'preservim/nerdtree', {'on': []}
    Plug 'ryanoasis/vim-devicons'
Plug 'blueyed/vim-diminactive'
"}}}

call plug#end()
"}}} Load Plugins

"Defer loading {{{2
""vimplug defers some plugins (lazzy loader)
"do onetime loading based events
augroup load_on_move
    autocmd!
    autocmd CursorMoved * call plug#load('nerdtree') | autocmd! load_on_move
augroup END
"}}} Defer loading
"}}} VIM PLUG


" COLORSCHEME {{{
"Open vim with theme instead default
let g:airline_theme='minimalist'
if !exists('g:colors_name')
    silent colorscheme tomorrow-night
endif
"}}}


"VIM-AIRLINE {{{
let g:airline_powerline_fonts=0                     "enable/disable powerline
let g:airline_symbols_ascii = 1                     "do not use fancy symbol
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
"display progress in statusline
"let g:airline_section_error = airline#section#create_right(['%{g:asyncrun_status}'])

"show file encoding on statusline if only it's other than utf-8 unix
"mostly edited files are utf-8 so skip this info
let g:airline#parts#ffenc#skip_expected_string='utf-8[unix]'

"AIRLINE-THEMES EXTENSION
"theme name must match one of files under airline-themes/autoload/airline/themes
"change theme in vim with command :AirlineTheme [theme]
"let g:airline_theme='tomorrow'

"TMUXLINE EXTENSION
"1. set a a colortheme and a preset with :Tmuxline [theme] [preset]
"available templates under tmuxline/autoload/tmuxline/[theme|preset]
"2. create a snapshot file with :TmuxlineSnapshot [file]
"3. add it to .tmux.conf: if-shell "test -f [file]" "source [file]"
let g:airline#extensions#tmuxline#enabled = 0       "disable autoload same theme as vim when starts vim
"enable/disable powerline symbols (default 1)
"let g:tmuxline_powerline_separators = 0

"statusline: shorten most used modes with characters e.g. N instead of NORMAL
"see also :h vim-modes
let g:airline_mode_map = {
    \ '__'      : '-',
    \ 'c'       : 'C',
    \ 'cv'      : 'VIM EX',
    \ 'ce'      : 'EX',
    \ 'i'       : 'I',
    \ 'ic'      : 'I-C',
    \ 'ix'      : 'I-C',
    \ 'multi'   : 'MULTI',
    \ 'n'       : 'N',
    \ 'ni'      : '(INSERT)',
    \ 'no'      : 'N-OP',
    \ 'R'       : 'R',
    \ 'Rv'      : 'R-V',
    \ 's'       : 'S',
    \ 'S'       : 'S-L',
    \ ''      : 'S-B',
    \ 't'       : 'T',
    \ 'v'       : 'V',
    \ 'V'       : 'V-L',
    \ ''      : 'V-B',
    \ }
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


"LSP {{{
"ALE - asynchronous lint engine
"put options out of autocmd so it set before plugin loaded
let g:ale_linters = {
    \   'cpp'   : ['clangd'],
    \   'python': ['flake8'],
    \   'bash'  : ['bash-language-server']
    \}

let g:ale_fixers = {
    \   'python': ['yapf']
    \}

let g:ale_sign_column_always = 1
let g:ale_sign_error = '>'
let g:ale_sign_warning = '-'
"disable background color of signs
highlight clear ALEErrorSign
highlight clear ALEWarningSign
"disable background color of code error lines
let g:ale_set_highlights = 0

"linter not work well with c++ (external libs)
let g:ale_enabled = 0
let g:ale_completion_enabled = 1
"do not overwhelm with trivial
let g:ale_completion_max_suggestions = 10
"do not interrupt, delay or swallow words while typing
"could manually trigger with c-x_c-o (see maplsp)
let g:ale_completion_delay = 900

"COC - intellisense for vim
"see :h coc-nvim
"configuration coc-settings.json in ~/.vim or ~/.config/nvim
"could manually trigger 'intellisense' with c-space (see maplsp)

"create map for ale and coc
function! MapLSP()
    if get(g:, 'loaded_ale', 0)
        "<plug> mapping not work with 'nore'
        imap <buffer> <leader>ac <Plug>(ale_complete)
        nmap <buffer> <leader>ar <Plug>(ale_find_references)
        nmap <buffer> <leader>ad <Plug>(ale_go_to_definition)
        nmap <buffer> <leader>ah <Plug>(ale_hover)
        nmap <buffer> <leader>at <Plug>(ale_toggle)

        "use to trigger manually with c-x_c-o
        if executable('clangd') || executable('pyls')
            setlocal omnifunc=ale#completion#OmniFunc
        endif
    endif

    if get(g:, 'did_coc_loaded', 0)
        inoremap <buffer> <silent> <expr> <c-space>  coc#refresh()  "work in gui
        inoremap <buffer> <silent> <expr> <nul>      coc#refresh()  "workaround in terminal
    endif
endfunction

augroup lsp | autocmd!
    "<buffer> mapping so it enabled only for certain filetypes
    autocmd FileType c,cpp,python,sh call MapLSP()
augroup END
"}}}


"COMPLETION (builtin) {{{
"DICTIONARY
"Add default file if on FreeBSD
if filereadable("/usr/share/dict/words")
    set dictionary+=/usr/share/dict/words
    "Enable completion from defined dictionary
    set complete+=k                     "<c-x><c-k> to trigger this list
endif

"THESAURUS
"Add personal synonym files
if !empty(glob("~/.vim/dict"))
    set thesaurus+=~/.vim/dict/thesaurus-vim-en
    set thesaurus+=~/.vim/dict/thesaurus-vim-de
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


"MISCELLANEOUS {{{
""Improve tab completion in command mode
""if searching for file, tell vim to look downwards recursive (two asterisks)
""See also help path, file-searching and cpt
"set path +=**

""make vim aware of repo files by adding git root directory to 'path'
""use systemlist() and get first elem without handling newline in result
""like system() but results of shell cmd as list (no trailing newline or space)
"let gitRootDir = get(systemlist("git rev-parse --show-toplevel"), 0)
""check exit_status of last shell cmd
"if v:shell_error == 0 && strlen(gitRootDir) != 0
"    let &path.= gitRootDir . "/**"
"endif

""show candidates in a menu line, iterate with tab and shift-tab
"set wildmenu
""or list all matches with tab (same as ctrl-d)
"set wildmode=longest,list

"Use verticale split when starting termdebug
let g:termdebug_wide = 1
"}}}


"ULTISNIPS {{{
"using snippets template from: https://github.com/honza/vim-snippets.git
"note: it will search in runtimepath for dir with names on the list below
if v:version >= 704
    let g:UltiSnipsNoPythonWarning = 1
    let g:UltiSnipsSnippetDirectories=["UltiSnips"]
    "<tab> slows down normal use-case dramatically
    let g:UltiSnipsExpandTrigger='<c-l>'
    "<c-tab> reserved by iterm for switching tab
    let g:UltiSnipsListSnippets='<c-l>l'
    "<c-k> interferes with i_ctrl-k
    let g:UltiSnipsJumpBackwardTrigger='<c-l>p'
    let g:UltiSnipsJumpForwardTrigger='<c-l>n'
endif
" }}}


"EXUBERANT CTAGS {{{
set tags=./.tags;$HOME/sources              "searching for .tags from current upwards to ~/sources (stop-dir)
"set tags+=$HOME/.vim/tags/cpp
"set tags+=$HOME/.vim/tags/opencv
"set tags+=$HOME/.vim/tags/qt

"guess projRootDir by checking version control system
for vcs in ['.git', '.svn', '.hg']
    "searching from current "." upwards ";" to "~/sources"
    "see also filename-modifiers: :p --> full path, :h --> take head remove last component
    let g:projRootDir = fnamemodify(finddir(vcs, '.;$HOME/sources'), ':p:h:h')
    if isdirectory(g:projRootDir . '/' . vcs)
        "set cwd at root so finder prog like fzf could check all subfiles
        "exe auto concates it's args with spaces inbetween
        silent! execute 'cd' g:projRootDir
        break
    else
        unlet g:projRootDir
    endif
endfor

function! UpdateCtags(proDir)
    "generate ctags only for projects
    if empty(a:proDir) | echom "project directory empty!" | return | endif
    "execute 'ctags' at projDir to take advantage of --tag-relative=yes
    let cmd = 'cd ' . a:proDir . ' && ' . 'ctags -R -f ./.tags .'
    if exists(":AsyncRun")
        execute "AsyncRun " . cmd
    else
        call system(cmd) | echom "write:" . a:proDir . "/.tags"
    endif
endfunction
command! UpdateCtags call UpdateCtags(g:projRootDir)
" }}}


"NERD_TREE {{{
function! ToggleTree()
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
let NERDTreeIgnore=['^build$', '^_build', '^build_','\~$']
"hide first help line
let NERDTreeMinimalUI = 1
"do not deactivate netrw (for opening directory)
let g:NERDTreeHijackNetrw = 0

"NERDTREE_TABS
let g:nerdtree_tabs_autofind = 1
let g:nerdtree_tabs_open_on_gui_startup = 0

"NETRW
":help netrw-quickmap --> to see all shortcuts
"suppress banner, I to toggle it
let g:netrw_banner = 0
"enter to open file in previous window
"o/v/t open file in new horizontal/vertical split or new tab
"x open file with default system app
"p to preview in split. Default 0 is vertical split
let g:netrw_preview = 1
"specify action when opening file with <cr>
"let g:netrw_browse_split = 1
"tree style, i to cycle modes
let g:netrw_liststyle = 3
"define width
let g:netrw_winsize = 25
" }}}


"DEVICON {{{
"Devicon for nerdtree

"loading devicon
let g:webdevicons_enable = 1

"force extra padding in NERDTree so that the filetype icons line up vertically
let g:WebDevIconsNerdTreeGitPluginForceVAlign = 1

"padding between symbol and text
"let g:WebDevIconsNerdTreeAfterGlyphPadding = ' '

"disable icon on vim-airline's tabline
let g:webdevicons_enable_airline_tabline = 0


"NERDTREE_HIGHLIGHT
"disable highlight, lag with big tree
let g:NERDTreeSyntaxDisableDefaultExtensions = 1

"Disable uncommon file extensions highlighting, reduce lag when scrolling
let g:NERDTreeLimitedSyntax = 1
"highlight files
let g:NERDTreeFileExtensionHighlightFullName = 1
" }}}


"CPPMAN {{{
"manual page viewer
"note: using "$cppman -m true" to call cppman from default man
"it's handy if vim-man is installed
if executable('tmux') && executable('cppman')
    command! -nargs=+ Cppman silent! call system("tmux split-window cppman " . expand(<q-args>))
    command! -nargs=+ CppMan silent! call system("tmux split-window -h cppman " . expand(<q-args>))
endif
"}}}


"FZF.VIM {{{
"define window layout
let g:fzf_layout = { 'down': '~30%' }

":Buffers -- jump to the existing window if possible
let g:fzf_buffers_jump = 1
":Commands -- expect expression for directly executing the command
let g:fzf_commands_expect = 'alt-enter,ctrl-x'

"change default behaviour jump to existing tab if possible
let g:fzf_action = {
    \ 'ctrl-t': 'tab drop',
    \ 'ctrl-x': 'split',
    \ 'ctrl-v': 'vsplit' }

if executable('fzf')
    "Files command with preview window
    command! -bang -nargs=? -complete=dir Files call fzf#vim#files(<q-args>, fzf#vim#with_preview(), <bang>0)

    "fzf#vim#grep(command, with_column, [options], [fullscreen])
    "with_column: 0 -> output of 'command' not include column numbers, otherwise 1
    "fullscreen: bang<0> evaluates to 0 if no bang (!) right after 'command', otherise 1
    "git grep
    command! -bang -nargs=* GGrep
                \ call fzf#vim#grep(
                \   'git grep --color=always --line-number '.shellescape(<q-args>), 0,
                \   fzf#vim#with_preview({ 'dir': systemlist('git rev-parse --show-toplevel')[0] }), <bang>0)

    "ripgrep
    command! -bang -nargs=* -complete=file Rg
                \ call fzf#vim#grep(
                \   'rg --column --line-number --no-heading --color=always --smart-case ' . shellescape(<q-args>), 1,
                \   <bang>0 ? fzf#vim#with_preview('up:70%')
                \           : fzf#vim#with_preview('right:50%', '?'),
                \   <bang>0)
endif
"}}}


"OTHER PLUGINS {{{
"CPP-ENHANCED-HIGHLIGHT
let g:cpp_class_scope_highlight = 1

"TAGBAR
let g:tagbar_autofocus=1                "focus on actual function

"BETTER-WHITESPACE
"show bad whitespace on open, manual enable with :ToggleWhitespace
let g:better_whitespace_enabled = 0

"disable highlight on file, don't use default list, override it
let g:better_whitespace_filetypes_blacklist=['markdown', 'qf']

"auto clear on save
let g:strip_whitespace_on_save = 1
let g:strip_only_modified_lines = 1
let g:strip_whitespace_confirm = 1

"ZEAVIM
"configure default docsets searching based on file types
let g:zv_file_types = {
            \   'cpp': 'cpp,opencv,qt' }
" }}}


"MAKE {{{
"identify build-folder by searching "upwards" for "build" from "." to "~/sources"
let projBuildDir = fnamemodify(finddir('build', '.;$HOME/sources'), ':p:h')
if projBuildDir =~ "/build"
    let &makeprg='cmake --build ' . shellescape(projBuildDir) . ' --target '
else
    unlet projBuildDir
endif
"Note: Using "-- -jN" to pass jobs config to make command
"Note: above is just a personal case which comes into handy, consider remove it later
"}}}


"GREP {{{
"fzf.vim uses FZF_DEFAULT_COMMAND
"':Ag' uses grepgrp

"SILVER SEARCH
if executable('ag')
  "use ag over vimgrep
  set grepprg=ag\ --vimgrep
endif

"RIPGREP
if executable('rg')
  "use rg over ag
  set grepprg=rg\ --vimgrep
endif
"}}}


"ASYNCRUN {{{
"run shell commands on background and read output in quickfix window (vim8)

"TODO create commands if only asyncrun available
"Note plugins are not run, we cannot check if exists(':AsyncRun')
":Make runs :make in background with asyncrun
"and make again determined by makeprg see also SetProjBuildDir()
"Usage: :Make PROG_NAME -- -jN
command! -bang -nargs=* -complete=file Make AsyncRun -program=make @ <args>

"helper function for closing quickfix after finishing job
function! AsyncOnExit()
    "user can close quickfix manually if it displays grep results
    let l:grep_job = 0
    for cmd in ['^ag', '^ack', '^grep', '^rg']
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
"}}}


"UTILS FUNCTIONS {{{

"Toggle line number: hydrid/absolute/none
function! ToggleLine()
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

"Toggle c header/code
"@see :h filename-modifiers
"arg: 'e[dit]', 'tabe', '[v]split'
function! ToggleCode(...) abort
    if &filetype !~ '^c.*' | return | endif
    let open = (a:0 == 1) ? a:1 : 'edit'
    execute open '%:p:r.' .. (expand("%:e") =~ '^c.*' ? 'h' : 'c*')
endfunction
command! -nargs=1 ToggleCode call ToggleCode('<args>')

"Change colorscheme and airlinetheme
function! ChangeTheme(color)
    let l:color = a:color
    let l:airline = a:color

    "specify configuration for some colors
    if a:color == 'codeschool'
        let l:airline = 'cobalt2'
    elseif a:color == 'pencil'
        set background=dark
    elseif a:color == 'solarized'
        set background=dark
    elseif a:color == 'tomorrow-night'
        let l:airline = 'tomorrow'
    elseif a:color == 'quantum'
        let g:quantum_black = 1
        if has('gui_running')
            let g:quantum_italics = 0
        endif
    elseif a:color == 'wombat256mod'
        let l:airline = 'wombat'
    endif

    "Using 'execute' to evaluate value of argument not the argument
    execute ':colorscheme' l:color
    execute ':AirlineTheme' l:airline
endfunc
command! -nargs=* -complete=color ChangeTheme call ChangeTheme('<args>')

"Head-up digraphs
function! HUDigraphs()
    digraphs
    call getchar()
    return "\<c-k>"
endfunction
"usage: c-k twice in insert-mode get digraph table, scroll to the end
"enter to quit, type two chars which presents the symbol
inoremap <expr> <c-k><c-k> HUDigraphs()

"search phrase with command :Search
"see :h function-argument
function! GSearch(...)
    let url = "http://www.google.com/search?q="
    let url .= (a:0 > 0) ? join(a:000, '') : expand("<cword>")
    call netrw#BrowseX(url, 0)
endfunction
command! -nargs=* Search call GSearch('<args>')

"Set project build directory
function! SetProjBuildDir(buildDir)
    let &makeprg='cmake --build ' . shellescape(a:buildDir) . ' --target '
endfunction
command! -nargs=1 -complete=dir SetBuildDir call SetProjBuildDir('<args>')

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
augroup vimplug | au!
    "download new coming plugins
    autocmd VimEnter * if len(filter(values(g:plugs), '!isdirectory(v:val.dir)'))
                        \| PlugInstall --sync | q | endif
augroup END

augroup vimrc
    "prevent calling multiple times by sourcing
    autocmd!

    "normal: hydrid relative line, insert: absolute line
    augroup numbertoggle
        autocmd!
        autocmd BufEnter,FocusGained,InsertLeave,WinEnter * if &nu && mode() != "i" | set nu rnu | endif
        autocmd BufLeave,FocusLost,InsertEnter,WinLeave   * if &nu                  | set nornu  | endif
    augroup END

    "TODO write function in case more than one left behind windows of these kinds
    "close vim if one left behind window is nerdtree, quickfix or help
    autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
    autocmd bufenter * if (winnr("$") == 1 && getbufvar(winbufnr(1), '&buftype') == 'quickfix') | q | endif
    autocmd bufenter * if (winnr("$") == 1 && getbufvar(winbufnr(1), '&buftype') == 'help') | q | endif

    "open when asyncrun starts
    autocmd User AsyncRunStart if exists(':AsyncRun') | call asyncrun#quickfix_toggle(8, 1)
    "and close on success
    autocmd User AsyncRunStop if exists(':AsyncRun') | call AsyncOnExit()
    "one line statement without timer function
    "autocmd User AsyncRunStop if g:asyncrun_status=='success'|call asyncrun#quickfix_toggle(8, 0)|endif

    "specify foldmethod
    autocmd FileType vim setlocal foldmethod=marker
    autocmd FileType python setlocal foldmethod=indent

    "disable fmd=syntax on large file (causing lagging when editing)
    autocmd FileType c,cpp,python,sh,xml if line('$') > 4000 | setlocal foldmethod=indent | endif

    " WSL yank support
    let s:clip = '/mnt/c/Windows/System32/clip.exe'  " modify path according to mount point
    if executable(s:clip)
        "set clipboard=exclude:.*
        augroup WSLYank
        autocmd!
        autocmd TextYankPost * if v:event.operator ==# 'y' | call system(s:clip, @0) | endif
        augroup END
    endif
" }}}


augroup END
" }}}


" MAPPING {{{1
"LEADER KEY (by default is backslash "\")
"let mapleader = "["

"buffers
nnoremap <silent> <leader>b :buffers<cr>:buffer<space>
"toggle colortheme
nnoremap <silent> <leader>c :call ToggleColor()<cr>
"relative line number
nnoremap <silent> <leader>l :call ToggleLine()<cr>
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

"quit all not save
nnoremap <C-q> :qa!<cr>
"save all & quit
nnoremap <C-s> :xa<cr>

"QUICKFIX: {{{2
nnoremap <silent> <leader>q :call asyncrun#quickfix_toggle(8)<cr>
nnoremap <C-n> :cnext<cr>zz
nnoremap <C-p> :cprevious<cr>zz
"}}}

"WINDOW: {{{2
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
"}}}

"MOVEMENT: {{{2
"increase steps of basic moves
nnoremap <C-e> 5<C-e>
nnoremap <C-y> 5<C-y>
"this is convenient and more comfortable
nnoremap <C-j> 5<C-e>
nnoremap <C-k> 5<C-y>
"move codeblock  with indent
vnoremap J :m '>+1<cr>gv=gv
vnoremap K :m '<-2<cr>gv=gv

"MOVEMENT IN INSER-MODE:
"override default i_ctrl-a and i_ctrl-e
inoremap <c-a> <home>
inoremap <c-e> <end>
"don't need funtion i_ctrl-b and i_ctrl-f
inoremap <c-b> <left>
inoremap <c-f> <right>
"}}}

"SEARCHING: {{{2
"make matches appear in the middle of screen
"zz: centralize cursor, zv: unfold
nnoremap n nzzzv
nnoremap N Nzzzv
nnoremap * *zzzv
nnoremap # #zzzv
nnoremap g; g;zzzv
nnoremap g, g,zzzv
"append zz & zv to '<char> when jumping to mark triggered
nnoremap <expr> ' "'" . nr2char(getchar()) . "zzzv"
"search on browser
nnoremap <silent> [b :call GSearch()<cr>
"search with git grep
"<c-r> inserts contain of named register, '=" register expr, <cword> expr of word under cursor. See :h c_ctrl-r
"use double quote to escape regex character
nnoremap [g :GGrep<space><c-r>=expand("<cword>")<cr>
nnoremap [G :GGrep<space><c-r>=expand("<cword>")<cr><cr>
"search with ripgrep
nnoremap [r :Rg!<space><c-r>=expand("<cword>")<cr><cr>
nnoremap [R :Rg<space><c-r>=expand("<cword>")<cr><cr>
"search with fuzzy finder
nnoremap [f :Files<cr>
nnoremap [w :Windows<cr>

"change working directory
" %:p current filename, %:p:h truncate name -> current dir
nnoremap [cd :cd %:p:h<cr>:pwd<cr>

"manual change cword forwards
"repeat with: <c-[>(goto normal) n(ext match) .(repeat)
nnoremap c* *<c-o>cgn
"}}}

"SWITCH HEADER: {{{2
"sourcecode-toggle
nnoremap [v :ToggleCode vsplit<cr>
nnoremap [t :ToggleCode tab drop<cr>
"}}}

"TAG JUMP: {{{2
"get desired behaviour with simpler keystroke
nnoremap <c-]> g<c-]>
vnoremap <c-]> g<c-]>
"swap tjump g_ctrl-] with above commands
nnoremap g<c-]> <c-]>
vnoremap g<c-]> <c-]>
"}}}

"UNDO BREAKPOINT: {{{2
"add undo stoppoint (ctrl-g_u) at specific symbols
inoremap , ,<c-g>u
inoremap . .<c-g>u
inoremap ; ;<c-g>u
inoremap : :<c-g>u
"}}}

"COMMANDLINE MODE: {{{2
"map vertical help
cnoremap vh vert botright help<space>
"map vertical splitfind
cnoremap vf vert sf<space>
"recall cmd-line history
cnoremap <c-p> <up>
cnoremap <c-n> <down>
"}}}

"FN: {{{2
nnoremap <silent>   <F2> :call ToggleTree()<cr>
nnoremap            <F3> :TagbarToggle<cr>
nnoremap <silent>   <F4> :UpdateCtags<cr>

nnoremap <silent>   <F10> :call OnQuit()<cr>
imap                <F10> <c-o><F10>                "switch to Insert-Normal-Mode to exec F10
"}}}

"DEACTIVATION: {{{2
"useless substitutions
"nnoremap s <NOP>
"nnoremap S <NOP>
"backtick as tmux keybind, disable in vim
nnoremap ` <NOP>
"join line
"nnoremap J <NOP>
"show manual
nnoremap K <NOP>
"Ex mode
nnoremap Q <NOP>
"}}}

" }}} MAPPING
