scriptencoding utf-8

" Variables {{{1
let s:cow = [
      \ '       o',
      \ '        o   ^__^',
      \ '         o  (oo)\_______',
      \ '            (__)\       )\/\',
      \ '                ||----w |',
      \ '                ||     ||',
      \ ]

let s:tux = [
    \ '            \',
    \ '             \',
    \ '                 .--.',
    \ '                |o_o |',
    \ '                |:_/ |',
    \ '               //   \ \',
    \ '              (|     | )',
    \ '             / \_   _/ \',
    \ '             \___)=(___/',
    \ ]

    
let s:unicode = &encoding == 'utf-8' && get(g:, 'startify_fortune_use_unicode')

let s:char_top_bottom   = ['-', '─'][s:unicode]
let s:char_sides        = ['|', '│'][s:unicode]
let s:char_top_left     = ['*', '╭'][s:unicode]
let s:char_top_right    = ['*', '╮'][s:unicode]
let s:char_bottom_right = ['*', '╯'][s:unicode]
let s:char_bottom_left  = ['*', '╰'][s:unicode]


let s:quotes = exists('g:startify_custom_header_quotes')
      \ ? g:startify_custom_header_quotes
      \ : [
      \ ["Debugging is twice as hard as writing the code in the first place. Therefore, if you write the code as cleverly as possible, you are, by definition, not smart enough to debug it.", '', '- Brian Kernighan'],
      \ ["If you don't finish then you're just busy, not productive."],
      \ ['Adapting old programs to fit new machines usually means adapting new machines to behave like old ones.', '', '- Alan Perlis'],
      \ ['Fools ignore complexity. Pragmatists suffer it. Some can avoid it. Geniuses remove it.', '', '- Alan Perlis'],
      \ ['It is easier to change the specification to fit the program than vice versa.', '', '- Alan Perlis'],
      \ ['Simplicity does not precede complexity, but follows it.', '', '- Alan Perlis'],
      \ ['Optimization hinders evolution.', '', '- Alan Perlis'],
      \ ['Recursion is the root of computation since it trades description for time.', '', '- Alan Perlis'],
      \ ['It is better to have 100 functions operate on one data structure than 10 functions on 10 data structures.', '', '- Alan Perlis'],
      \ ['There is nothing quite so useless as doing with great efficiency something that should not be done at all.', '', '- Peter Drucker'],
      \ ["If you don't fail at least 90% of the time, you're not aiming high enough.", '', '- Alan Kay'],
      \ ['I think a lot of new programmers like to use advanced data structures and advanced language features as a way of demonstrating their ability. I call it the lion-tamer syndrome. Such demonstrations are impressive, but unless they actually translate into real wins for the project, avoid them.', '', '- Glyn Williams'],
      \ ['I would rather die of passion than of boredom.', '', '- Vincent Van Gogh'],
      \ ['If a system is to serve the creative spirit, it must be entirely comprehensible to a single individual.'],
      \ ["The computing scientist's main challenge is not to get confused by the complexities of his own making.", '', '- E. W. Dijkstra'],
      \ ["Progress in a fixed context is almost always a form of optimization. Creative acts generally don't stay in the context that they are in.", '', '- Alan Kay'],
      \ ['The essence of XML is this: the problem it solves is not hard, and it does not solve the problem well.', '', '- Phil Wadler'],
      \ ['A good programmer is someone who always looks both ways before crossing a one-way street.', '', '- Doug Linder'],
      \ ['Patterns mean "I have run out of language."', '', '- Rich Hickey'],
      \ ['Always code as if the person who ends up maintaining your code is a violent psychopath who knows where you live.', '', '- John Woods'],
      \ ['Unix was not designed to stop its users from doing stupid things, as that would also stop them from doing clever things.'],
      \ ['Contrary to popular belief, Unix is user friendly. It just happens to be very selective about who it decides to make friends with.'],
      \ ['Perfection is achieved, not when there is nothing more to add, but when there is nothing left to take away.'],
      \ ['There are two ways of constructing a software design: One way is to make it so simple that there are obviously no deficiencies, and the other way is to make it so complicated that there are no obvious deficiencies.', '', '- C.A.R. Hoare'],
      \ ["If you don't make mistakes, you're not working on hard enough problems.", '', '- Frank Wilczek'],
      \ ["If you don't start with a spec, every piece of code you write is a patch.", '', '- Leslie Lamport'],
      \ ['Caches are bugs waiting to happen.', '', '- Rob Pike'],
      \ ['Abstraction is not about vagueness, it is about being precise at a new semantic level.', '', '- Dijkstra'],
      \ ["dd is horrible on purpose. It's a joke about OS/360 JCL. But today it's an internationally standardized joke. I guess that says it all.", '', '- Rob Pike'],
      \ ['All loops are infinite ones for faulty RAM modules.'],
      \ ['All idioms must be learned. Good idioms only need to be learned once.', '', '- Alan Cooper'],
      \ ['For a successful technology, reality must take precedence over public relations, for Nature cannot be fooled.', '', '- Richard Feynman'],
      \ ['If programmers were electricians, parallel programmers would be bomb disposal experts. Both cut wires.', '', '- Bartosz Milewski'],
      \ ['Computers are harder to maintain at high altitude. Thinner air means less cushion between disk heads and platters. Also more radiation.'],
      \ ['Almost every programming language is overrated by its practitioners.', '', '- Larry Wall'],
      \ ['Fancy algorithms are slow when n is small, and n is usually small.', '', '- Rob Pike'],
      \ ['Methods are just functions with a special first argument.', '', '- Andrew Gerrand'],
      \
      \ ['Care about your craft.', '', 'Why spend your life developing software unless you care about doing it well?'],
      \ ["Provide options, don't make lame excuses.", '', "Instead of excuses, provide options. Don't say it can't be done; explain what can be done."],
      \ ['Be a catalyst for change.', '', "You can't force change on people. Instead, show them how the future might be and help them participate in creating it."],
      \ ['Make quality a requirements issue.', '', "Involve your users in determining the project's real quality requirements."],
      \ ['Critically analyze what you read and hear.', '', "Don't be swayed by vendors, media hype, or dogma. Analyze information in terms of you and your project."],
      \ ["DRY - Don't Repeat Yourself.", '', 'Every piece of knowledge must have a single, unambiguous, authoritative representation within a system.'],
      \ ['Eliminate effects between unrelated things.', '', 'Design components that are self-contained, independent, and have a single, well-defined purpose.'],
      \ ['Use tracer bullets to find the target.', '', 'Tracer bullets let you home in on your target by trying things and seeing how close they land.'],
      \ ['Program close to the problem domain.', '', "Design and code in your user's language."],
      \ ['Iterate the schedule with the code.', '', 'Use experience you gain as you implement to refine the project time scales.'],
      \ ['Use the power of command shells.', '', "Use the shell when graphical user interfaces don't cut it."],
      \ ['Always use source code control.', '', 'Source code control is a time machine for your work - you can go back.'],
      \ ["Don't panic when debugging", '', 'Take a deep breath and THINK! about what could be causing the bug.'],
      \ ["Don't assume it - prove it.", '', 'Prove your assumptions in the actual environment - with real data and boundary conditions.'],
      \ ['Write code that writes code.', '', 'Code generators increase your productivity and help avoid duplication.'],
      \ ['Design With contracts.', '', 'Use contracts to document and verify that code does no more and no less than it claims to do.'],
      \ ['Use assertions to prevent the impossible.', '', 'Assertions validate your assumptions. Use them to protect your code from an uncertain world.'],
      \ ['Finish what you start.', '', 'Where possible, the routine or object that allocates a resource should be responsible for deallocating it.'],
      \ ["Configure, don't integrate.", '', 'Implement technology choices for an application as configuration options, not through integration or engineering.'],
      \ ['Analyze workflow to improve concurrency.', '', "Exploit concurrency in your user's workflow."],
      \ ['Always design for concurrency.', '', "Allow for concurrency, and you'll design cleaner interfaces with fewer assumptions."],
      \ ['Use blackboards to coordinate workflow.', '', 'Use blackboards to coordinate disparate facts and agents, while maintaining independence and isolation among participants.'],
      \ ['Estimate the order of your algorithms.', '', 'Get a feel for how long things are likely to take before you write code.'],
      \ ['Refactor early, refactor often.', '', 'Just as you might weed and rearrange a garden, rewrite, rework, and re-architect code when it needs it. Fix the root of the problem.'],
      \ ['Test your software, or your users will.', '', "Test ruthlessly. Don't make your users find bugs for you."],
      \ ["Don't gather requirements - dig for them.", '', "Requirements rarely lie on the surface. They're buried deep beneath layers of assumptions, misconceptions, and politics."],
      \ ['Abstractions live longer than details.', '', 'Invest in the abstraction, not the implementation. Abstractions can survive the barrage of changes from different implementations and new technologies.'],
      \ ["Don't think outside the box - find the box.", '', 'When faced with an impossible problem, identify the real constraints. Ask yourself: "Does it have to be done this way? Does it have to be done at all?"'],
      \ ['Some things are better done than described.', '', "Don't fall into the specification spiral - at some point you need to start coding."],
      \ ["Costly tools don't produce better designs.", '', 'Beware of vendor hype, industry dogma, and the aura of the price tag. Judge tools on their merits.'],
      \ ["Don't use manual procedures.", '', 'A shell script or batch file will execute the same instructions, in the same order, time after time.'],
      \ ["Coding ain't done 'til all the Tests run.", '', "'Nuff said."],
      \ ['Test state coverage, not code coverage.', '', "Identify and test significant program states. Just testing lines of code isn't enough."],
      \ ['English is just a programming language.', '', 'Write documents as you would write code: honor the DRY principle, use metadata, MVC, automatic generation, and so on.'],
      \ ["Gently exceed your users' expectations.", '', "Come to understand your users' expectations, then deliver just that little bit more."],
      \ ['Think about your work.', '', 'Turn off the autopilot and take control. Constantly critique and appraise your work.'],
      \ ["Don't live with broken windows.", '', 'Fix bad designs, wrong decisions, and poor code when you see them.'],
      \ ['Remember the big picture.', '', "Don't get so engrossed in the details that you forget to check what's happening around you."],
      \ ['Invest regularly in your knowledge portfolio.', '', 'Make learning a habit.'],
      \ ["It's both what you say and the way you say it.", '', "There's no point in having great ideas if you don't communicate them effectively."],
      \ ['Make it easy to reuse.', '', "If it's easy to reuse, people will. Create an environment that supports reuse."],
      \ ['There are no final decisions.', '', 'No decision is cast in stone. Instead, consider each as being written in the sand at the beach, and plan for change.'],
      \ ['Prototype to learn.', '', 'Prototyping is a learning experience. Its value lies not in the code you produce, but in the lessons you learn.'],
      \ ['Estimate to avoid surprises.', '', "Estimate before you start. You'll spot potential problems up front."],
      \ ['Keep knowledge in plain text.', '', "Plain text won't become obsolete. It helps leverage your work and simplifies debugging and testing."],
      \ ['Use a single editor well.', '', 'The editor should be an extension of your hand; make sure your editor is configurable, extensible, and programmable.'],
      \ ['Fix the problem, not the blame.', '', "It doesn't really matter whether the bug is your fault or someone else's - it is still your problem, and it still needs to be fixed."],
      \ ["\"select\" isn't broken.", '', 'It is rare to find a bug in the OS or the compiler, or even a third-party product or library. The bug is most likely in the application.'],
      \ ['Learn a text manipulation language.', '', 'You spend a large part of each day working with text. Why not have the computer do some of it for you?'],
      \ ["You can't write perfect software.", '', "Software can't be perfect. Protect your code and users from the inevitable errors."],
      \ ['Crash early.', '', 'A dead program normally does a lot less damage than a crippled one.'],
      \ ['Use exceptions for exceptional problems.', '', 'Exceptions can suffer from all the readability and maintainability problems of classic spaghetti code. Reserve exceptions for exceptional things.'],
      \ ['Minimize coupling between modules.', '', 'Avoid coupling by writing "shy" code and applying the Law of Demeter.'],
      \ ['Put abstractions in code, details in metadata.', '', 'Program for the general case, and put the specifics outside the compiled code base.'],
      \ ['Design using services.', '', 'Design in terms of services-independent, concurrent objects behind well-defined, consistent interfaces.'],
      \ ['Separate views from models.', '', 'Gain flexibility at low cost by designing your application in terms of models and views.'],
      \ ["Don't program by coincidence.", '', "Rely only on reliable things. Beware of accidental complexity, and don't confuse a happy coincidence with a purposeful plan."],
      \ ['Test your estimates.', '', "Mathematical analysis of algorithms doesn't tell you everything. Try timing your code in its target environment."],
      \ ['Design to test.', '', 'Start thinking about testing before you write a line of code.'],
      \ ["Don't use wizard code you don't understand.", '', 'Wizards can generate reams of code. Make sure you understand all of it before you incorporate it into your project.'],
      \ ['Work with a user to think like a user.', '', "It's the best way to gain insight into how the system will really be used."],
      \ ['Use a project glossary.', '', 'Create and maintain a single source of all the specific terms and vocabulary for a project.'],
      \ ["Start when you're ready.", '', "You've been building experience all your life. Don't ignore niggling doubts."],
      \ ["Don't be a slave to formal methods.", '', "Don't blindly adopt any technique without putting it into the context of your development practices and capabilities."],
      \ ['Organize teams around functionality.', '', "Don't separate designers from coders, testers from data modelers. Build teams the way you build code."],
      \ ['Test early. Test often. Test automatically.', '', 'Tests that run with every build are much more effective than test plans that sit on a shelf.'],
      \ ['Use saboteurs to test your testing.', '', 'Introduce bugs on purpose in a separate copy of the source to verify that testing will catch them.'],
      \ ['Find bugs once.', '', 'Once a human tester finds a bug, it should be the last time a human tester finds that bug. Automatic tests should check for it from then on.'],
      \ ['Sign your work.', '', 'Craftsmen of an earlier age were proud to sign their work. You should be, too.'],
      \ ]

let s:tips = exists('g:startify_custom_header_tips')
    \ ? g:startify_custom_header_tips
    \ : [
    \ ["zz to center the cursor vertically on your screen. useful when you 250gzz, for instance."],
    \ ["CTRL-w | and CTRL-W _ maximize your current split vertically and horizontally, respectively. CTRL-W = equalizes 'em."],
    \ [":g/_pattern_/s/^/#/g will comment out lines containing _pattern_ (if '#' is your comment character/sequence)"],
    \ ["vim -c [command] will launch vim and run a : command at launch, e.g. \"vim -c NERDTree.\""],
    \ ["CTRL-w s CTRL-w T will open current buffer in new tab"],
    \ ["CTRL-w K will switch vertical split into horizontal, CTRL-w H will switch a horizontal into a vertical."],
    \ ["K runs a program to lookup the keyword under the cursor. If writing C, it runs man. In Ruby, it (should) run ri, Python (perhaps) pydoc."],
    \ ["Edit and encrypt a file: vim -x filename"],
    \ ["/fred\_s*joe/ will search for fred AND joe with whitespace (including newline) in between."],
    \ ["From a command-line, vim scp://username@host//path/to/file to edit a remote file locally."],
    \ ["/fred|joe/ will search for either fred OR joe."],
    \ ["/.*fred&.*joe/ will search for fred AND joe, in any order."],
    \ ["/<fred>/ will search for fred, but not alfred or frederick."],
    \ ["/joe/e will search for joe and place the cursor at the end of the match."],
    \ ["/joe/e+1 will search for joe and place the cursor at the end of the match, plus on character."],
    \ ["/joe/s-2 will search for joe and place the cursor at the start of the match, minus two characters."],
    \ ["/joe/+3 will search for joe and place the cursor three lines below the match."],
    \ ["/joe.*fred.*bill/ will search for joe AND fred AND bill, in that order."],
    \ ["/begin\_.*end will search for begin AND end over multiple lines."],
    \ ["Edit a command output in Vim as a file: $ command | vim -"],
    \ ["ggVG= will auto-format the entire document"],
    \ ["'0 opens the last modified file ('1 '2 '3 works too)"],
    \ ["In insert mode do Ctrl+r=53+17<Enter>. This way you can do some calcs with vim."],
    \ ["\"_d will delete the selection without adding it to the yanked stack (sending it to the black hole register)."],
    \ ["Basic commands 'f' and 't' (like first and 'til) are very powerful. See :help t or :help f."],
    \ [":40,50m30 will move lines 40 through 50 to line 30. Most visual mode commands can be used with line numbers."],
    \ ["To search for a URL without backslashing, search backwards! Example: ?http://somestuff.com"],
    \ ["g; will cycle through your recent changes (or g, to go in reverse)."],
    \ ["\"2p will put the second to last thing yanked, \"3p will put the third to last, etc."],
    \ [":wa will save all buffers. :xa will save all buffers and exit Vim."],
    \ ["After performing an undo, you can navigate through the changes using g- and g+. Also, try :undolist to list the changes."],
    \ ["You probably know that 'u' is undo. Do you know that Ctrl-r is redo?"],
    \ ["ci{  change text inside {} block. Also see di{, yi{, ci( etc."],
    \ [":read [filename] will insert the contents of [filename] at the current cursor position "],
    \ ["to use gvim to edit your git messages set git's core editor as follows:"],
    \ ["git config --global core.editor \"gvim --nofork\""],
    \ ["ci\" inside a \" \" will erase everything between \"\" and place you in insertion mode."],
    \ [":set guifont=* in gvim or MacVim to get a font selection dialog. Useful while giving presentations."],
    \ [":h slash<CTRL-d> to get a list of all help topics containing the word 'slash'."],
    \ ["guu converts entire line to lowercase. gUU converts entire line to uppercase. ~ inverts case of current character."],
    \ ["'. jumps to last modified line. `. jumps to exact position of last modification."],
    \ ["<CTRL-o> : trace your movements backwards in a file. <CTRL-i> trace your movements forwards in a file."],
    \ [":ju(mps) : list your movements {{help|jump-motions}}"],
    \ [":history lists the history of your recent commands, sans duplicates."],
    \ ["\"+y to copy to the X11 (or Windows) clipboard. \"+p to paste from it."],
    \ ["noremap ' ` and noremap ` ' to make marks easier to navigate. Now ` is easier to reach!"],
    \ ["2f/ would find the second occurrence of '/' in a line."],
    \ [":tab sball will re-tab all files in the buffers list."],
    \ ["* # g* g# each searches for the word under the cursor (forwards/backwards)"],
    \ [":vimgrep pattern **/*.txt will search all *.txt files in the current directory and its subdirectories for the pattern."],
    \ ["== will auto-indent the current line.  Select text in visual mode, then = to auto-indent the selected lines."],
    \ [":set foldmethod=syntax to make editing long files of code much easier.  zo to open a fold.  zc to close it.  See more http://is.gd/9clX"],
    \ ["Need to edit and run a previous command?  q: then find the command, edit it, and Enter to execute the line."],
    \ ["@: to repeat the last executed command."],
    \ [":e $MYVIMRC to directly edit your vimrc.  :source $MYVIMRC to reload.  Mappings may make it even easier."],
    \ ["g<CTRL-G> to see technical information about the file, such as how many words are in it, or how many bytes it is."],
    \ ["gq{movement} to wrap text, or just gq while in visual mode. gqap will format the current paragraph."],
    \ [":E to see a simple file explorer.  (:Ex will too, if that's easier to remember.)"],
    \ [":vimgrep pattern *.txt will search all .txt files in the current directory for the pattern."],
    \ ["<CTRL-n><CTRL-p> offers word-completion while in insert mode."],
    \ ["<CTRL-x><CTRL-l> offers line completion in insert mode."],
    \ ["/<CTRL-r><CTRL-w> will pull the word under the cursor into search."],
    \ ["gf will open the file under the cursor.  (Killer feature.)"],
    \ ["Ctrl-a, Ctrl-x will increment and decrement, respectively, the number under the cursor. May be precede by a count."],
    \ [":scriptnames will list all plugins and _vimrcs loaded."],
    \ [":tabdo [some command] will execute the command in all tabs.  Also see windo, bufdo, argdo."],
    \ [":vsplit filename will split the window vertically and open the file in the left-hand pane.  Great when writing unit tests!"],
    \ ["qa starts a recording in register 'a'. q stops it. @a repeats the recording. 5@a repeats it 5 times."],
    \ ["Ctrl-c to quickly get out of command-line mode.  (Faster than hitting ESC a couple times.)"],
    \ ["Use '\v' in your regex to set the mode to 'very magic', and avoid confusion. (:h \v for more info.)"],
    \ ["; is a motion to repeat last find with f. f' would find next quote. c; would change up to the next '"],
    \ ["ga will display the ASCII, hex, and octal value of the character under the cursor."],
    \ [":r !date will insert the current date/time stamp (from the 'date' command -- a bit OS-specific)."],
    \ ["ggguG will lower case the entire file (also known as the Jerry Yang treatment)."],
    \ [":Sex will open a file explorer in a split window. I bet you'll remember that one."],
    \ [":g/search_term/# display each line containing 'search_term' with line numbers."],
    \ ["'. jumps to the last modified line. `. jumps to the exact position of last modification"],
    \ ["[I (that's bracket open, capital i) show lines containing the word under the cursor."],
    \ [":vimgrep /stext/ **/*.txt | :copen searches for stext recursively in *.txt files and show results in separate window"],
    \ ["ysiw' to surround current word with ',cs' {changes word to {word}} using the surround plugin: http://t.co/7QnLiwP3"],
    \ ["use \v in your regex to set the mode to 'very magic' and avoid confusion (:h \v for more info) http://t.co/KWtRFNPI"],
    \ ["in gvim, change the cursor depending on what mode you are (normal, insert, etc...) http://is.gd/9dq0"],
    \ ["In visual mode, use \" to surround the selected text with \" using the surround plugin http://is.gd/fpwJQ"],
    \ [":tabo closes all tabs execpt the current one."],
    \ ["<C-U> / <C-D> move the cursor up/down half a page (also handy :set nosol)"],
    \ ["p / P paste after/before the cursor. Handy when inserting lines."],
    \ ["daw/caw deletes/changes the word under the cursor."],
    \ ["vim -d file1 file2 shows the differences between two files."],
    \ [":set smartcase case sensitive if search contains an uppercase character and ignorecase is on."],
    \ [":sh or :shell to open a console (then exit to come back to vim)."],
    \ ["= : re-indent (e.g. == to re-indent the current line)."],
    \ ["ctrl-v blockwise visual mode (rectangular selection)."],
    \ ["I/A switch to insert mode before/after the current line."],
    \ ["o/O insert a new line after/before the current line and switch to insert mode."],
    \ ["I/A in visual blockwise mode (ctrl-v) insert some text at the star/end of each line of the block text."],
    \ ["Need to edit a file in hex ? :help hex-editing gives you the manual."],
    \ ["Ctrl + o : Execute a command while in insert mode, then go back to insert mode. e.g. ctrl+o, p; paste without exiting insert mode"],
    \ ["ctrl-r x (insert mode): insert the contents of buffer x. For example: \"ctrl-r +\" would insert the contents of the clipboard."],
    \ ["ctrl-r ctrl-w: Pull the word under the cursor in a : command. eg. :s/ctrl-r ctrl-w/foo/g"],
    \ ["a/A : append at the cursor position / at the end of the line (enters insert mode)"],
    \ ["ctrl-x ctrl-f (insert mode): complete with the file names in the current directory (ctrl-p/n to navigate through the candidates)"],
    \ ["set mouse=a - enable mouse in terminal (selection, scroll, window resizing, ...)."],
    \ ["J: join two lines"],
    \ ["gg/G: go to start/end of file."],
    \ ["Ctrl-y (insert mode): insert character which is on the line above cursor. example: handy to initialize a structure."],
    \ [":set nowrap - disable line wrapping"],
    \ ["vim -p <files> - load all files listed in separate tabs. e.g. vim -p *.c"],
    \ ["vmap out \"zdmzO#if 0<ESC>\"zp'zi#endif<CR><ESC> - macro to comment out a block of code using #if 0"],
    \ ["<CTRT-W>v == :vsplit like <CTRL-w>s == :split"],
    \ ["If gvim is started from a terminal it opens at the same width as the terminal. To prevent this, add \"set columns=80\" to ~/.vimrc"],
    \ ["Prefixing G or gg (command mode) with a number will cause vim to jump to that line number."],
    \ ["set showbreak - set characters to prefix wrapped lines with. e.g. \":set showbreak=+++\ \" (white space must be escaped)"],
    \ ["When editing multiple files (e.g. vim *.c), use :n to move to the next file and :N to move to the previous file. :ar shows the list of files"],
    \ [":split - split the current window in two"],
    \ ["vim --remote <file> - open a file in an existing vim session"],
    \ ["A - enter insert mode at the end of the line (Append); I - insert before the first non-blank of the line"],
    \ [":set softtabstop <n> - set the number of spaces to insert when using the tab key (converted to tabs and spaces if expandtab is off)."],
    \ [":set expandtab - use spaces rather than the tab character to insert a tab."],
    \ [":set guioptions - set various GUI vim options. e.g. to remove the menubar and toolbar, :set guioptions-=Tm"],
    \ ["\"vim - \" - start vim and read from standard input. e.g. with syntax enabled, get a coloured diff from git: git diff | vim -"],
    \ ["set mousemodel=popup - enable a popup menu on right click in GUI vim"],
    \ ["r!cat - reads into the buffer from stdin and avoids using :set paste (use ctrl-d to finish)"],
    \ [":set title - display info in terminal title. Add let &titleold=getcwd() to .vimrc to set it to something useful on quit"],
    \ [":set pastetoggle=key - specify a key sequence that toggles the paste option, e.g. set pastetoggle=<F2>"],
    \ [":set paste - allows you to paste from the clipboard correctly, especially when vim is running in a terminal"],
    \ ["substitute flag 'n' - count how many substitutions would be made, but don't actually make any "],
    \ ["set wildmenu - enhanced filename completion. left and right navigates matches; up and down navigates directories"],
    \ ["zt, zz, zb: scroll so that the current position of the cursor is moved to the top, middle or bottom of the screen"],
    \ ["[range]sort - sort the lines in the [range], or all lines if [range] is not given. e.g. :'<,'>sort - sort the current visual selection"],
    \ ["noh - stop highlighting the current search (if 'hlsearch' is enabled). Highlighting is automatically restored for the next search."],
    \ ["when substituting, \u makes just first character upper (like \l for lower) and \U is upper equivalent for \L"],
    \ [":retab <ts> - convert strings of white-space containing <Tab> with new strings using the <ts> value if given or current value of 'tabstop'"],
    \ ["ctrl-v u <hex code> - enter a unicode character in insert mode"],
    \ [":set laststatus=2 - always show the status line (0 = never, 1 = (default) only if there are two or more windows, 2 = always)"],
    \ ["b - go back a word (opposite of w)"],
    \ ["} - move to the next blank line ( { - move to previous blank line)"],
    \ ["s - delete characters and start insert mode (s stands for Substitute). e.g. 3s - delete three characters and start insert mode."],
    \ ["0 - Move to the first character of the line"],
    \ [":set columns=X - set the width of the window to X columns. For GUI vim, this is limited to the size of the screen"],
    \ [":only - close all windows except the current one (alternatives: ctrl-w ctrl-o or :on)"],
    \ ["ctrl-<pagedown> / ctrl-<pageup> - switch to next/previous tab. (alternatives: gt/gT, :tabn/:tabp, etc)"],
    \ [":tabe <filename> - open <filename> in a new tab (same as :tabedit and :tabnew)"],
    \ ["Ctrl-T and Ctrl-D - indent and un-indent the current line in insert mode"],
    \ ["vim +<num> - start vim and place the cursor on line <lnum>. If lnum is not specified, start at the end of the file"],
    \ ["gj, gk (or g<Up> g<Down>) - move up or down a display line (makes a difference for wrapped lines)"],
    \ [">{motion} and <{motion} - (normal mode) increase/decrease the current indent. e.g. << - decrease the indent of the current line"],
    \ ["\"+ and \"* - clipboard and current selection registers under X. e.g. \"+p to paste from the clipboard and \"+y to copy to the clipboard"],
    \ [":r!<cmd> - insert the result of <cmd> into the current buffer at the cursor. e.g. :r!ls *.h"],
    \ ["& - re-run last :s command (&& to remember flags)"],
    \ ["set wildignore - ignore matching files when using tab complete on filenames. e.g. :set wildignore=*.o,*.lo"],
    \ ["CTRL-V <tab> - in insert mode, enters a real tab character, disregarding tab and indent options"],
    \ ["CTRL-U/CTRL-D - scroll up/down, moving the cursor the same number of lines if possible (unlike <PageUp>/<PageDown>)"],
    \ [":set cursorline - Highlight the current line under the cursor"],
    \ [":set showcmd - show the number of lines/chacters in a visual selection"],
    \ [":x is like \":wq\", but write only when changes have been made"],
    \ ["ctrl-b / ctrl-f : page up / page down"],
    \ ["ctrl-clic / ctrl-t : go to symbol definition (= ctrl-]) (using tags) and back. You can use \"make tags\" autotooled projects to create tag"],
    \ ]


" Function: s:get_random_offset {{{1
function! s:get_random_offset(max) abort
  return str2nr(matchstr(reltimestr(reltime()), '\.\zs\d\+')[1:]) % a:max
endfunction

" Function: s:draw_box {{{1
function! s:draw_box(lines) abort
  let longest_line = max(map(copy(a:lines), 'strwidth(v:val)'))
  let top_bottom_without_corners = repeat(s:char_top_bottom, longest_line + 2)
  let top = s:char_top_left . top_bottom_without_corners . s:char_top_right
  let bottom = s:char_bottom_left . top_bottom_without_corners . s:char_bottom_right
  let lines = [top]
  for l in a:lines
    let offset = longest_line - strwidth(l)
    let lines += [s:char_sides . ' '. l . repeat(' ', offset) .' ' . s:char_sides]
  endfor
  let lines += [bottom]
  return lines
endfunction

" Function: #quote {{{1
function! startify#fortune#quote() abort
  return s:quotes[s:get_random_offset(len(s:quotes))]
endfunction

" Function: #tip {{{1
function! startify#fortune#tip() abort
  return s:tips[s:get_random_offset(len(s:tips))]
endfunction

" Function: #boxed {{{1
function! startify#fortune#boxed() abort
  let wrapped_quote = []
  let quote = startify#fortune#quote()
  for line in quote
    let wrapped_quote += split(line, '\%50c.\{-}\zs\s', 1)
  endfor
  let wrapped_quote = s:draw_box(wrapped_quote)
  return wrapped_quote
endfunction

" Function: #cowsay {{{1
function! startify#fortune#cowsay(...) abort
  if a:0
    let s:char_top_bottom   = get(a:000, 0, s:char_top_bottom)
    let s:char_sides        = get(a:000, 1, s:char_sides)
    let s:char_top_left     = get(a:000, 2, s:char_top_left)
    let s:char_top_right    = get(a:000, 3, s:char_top_right)
    let s:char_bottom_right = get(a:000, 4, s:char_bottom_right)
    let s:char_bottom_left  = get(a:000, 5, s:char_bottom_left)
  endif
  let boxed_quote = startify#fortune#boxed()
  let boxed_quote += s:tux
  return map(boxed_quote, '"   ". v:val')
endfunction

" Function: #cowtip {{{1
function! startify#fortune#cowtip() abort
  let wrapped_tip = []
  let tip = startify#fortune#tip()
  for line in tip
    let wrapped_tip += split(line, '\%50c.\{-}\zs\s', 1)
  endfor
  let wrapped_tip = s:draw_box(wrapped_tip)
  let wrapped_tip += s:cow
  return map(wrapped_tip, '"   ". v:val')
endfunction
