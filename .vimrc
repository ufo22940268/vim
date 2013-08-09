" User configuration
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => General
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""


function! MySys()
    return "unix"
endfunction

"Sets how many lines of history VIM har to remember
set history=400

"Enable filetype plugin
filetype on
if has("eval") && v:version>=600
    filetype plugin on
    filetype indent on
endif

"Set to auto read when a file is changed from the outside
if exists("&autoread")
    set autoread
endif

"Have the mouse enabled all the time:
if exists("&mouse")
    set mouse=a
endif

"Set mapleader
let mapleader = ","
let g:mapleader = ","

"Fast saving
nmap <leader>x :xa!<cr>
nmap <leader>w :w!<cr>


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"" => Colors and Font
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
""Enable syntax hl
"if MySys()=="unix"
"    if v:version<600
"        if filereadable(expand("$VIM/syntax/syntax.vim"))
"            syntax on
"        endif
"    else
"        syntax on
"    endif
"else
"    syntax on
"endif
"
"internationalization
"I only work in Win2k Chinese version
if has("multi_byte")
    "set bomb 
    set fileencodings=ucs-bom,utf-8,cp936,big5,euc-jp,euc-kr,latin1 
    " CJK environment detection and corresponding setting 
    if v:lang =~ "^zh_CN" 
        " Use cp936 to support GBK, euc-cn == gb2312 
        set encoding=cp936 
        set termencoding=cp936 
        set fileencoding=cp936 
    elseif v:lang =~ "^zh_TW" 
        " cp950, big5 or euc-tw 
        " Are they equal to each other? 
        set encoding=big5 
        set termencoding=big5 
        set fileencoding=big5 
    elseif v:lang =~ "^ko" 
        " Copied from someone's dotfile, untested 
        set encoding=euc-kr 
        set termencoding=euc-kr 
        set fileencoding=euc-kr 
    elseif v:lang =~ "^ja_JP" 
        " Copied from someone's dotfile, untested 
        set encoding=euc-jp 
        set termencoding=euc-jp 
        set fileencoding=euc-jp 
    endif 
    " Detect UTF-8 locale, and replace CJK setting if needed 
    if v:lang =~ "utf8$" || v:lang =~ "UTF-8$" 
        set encoding=utf-8 
        set termencoding=utf-8 
        set fileencoding=utf-8 
    endif
endif

"if you use vim in tty,
"'uxterm -cjk' or putty with option 'Treat CJK ambiguous characters as wide' on
if exists("&ambiwidth")
    set ambiwidth=double
endif

"Some nice mapping to switch syntax (useful if one mixes different languages in one file)
"map <leader>1 :set syntax=cheetah<cr>
"map <leader>2 :set syntax=xhtml<cr>
"map <leader>3 :set syntax=python<cr>
"map <leader>4 :set ft=javascript<cr>
"map <leader>$ :syntax sync fromstart<cr>

"Highlight current
if has("gui_running")
    if exists("&cursorline")
        set cursorline
    endif
endif

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Fileformat
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"Favorite filetype
set ffs=unix,dos,mac

nmap <leader>fd :se ff=dos<cr>
nmap <leader>fu :se ff=unix<cr>



"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => VIM userinterface
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"Set 7 lines to the curors - when moving vertical..
set so=7

"Turn on WiLd menu
set wildmenu

"Always show current position
set ruler

"The commandbar is 2 high
set cmdheight=2

"Show line number
set nu

"Do not redraw, when running macros.. lazyredraw
set lz

"Change buffer - without saving
set hid

"Set backspace
set backspace=eol,start,indent

"Bbackspace and cursor keys wrap to
set whichwrap+=<,>,h,l

"Ignore case when searching
"set ignorecase
set incsearch

"No sound on errors.
set noerrorbells
set novisualbell
set t_vb=

"show matching bracet
set showmatch

"How many tenths of a second to blink
set mat=8


""""""""""""""""""""""""""""""
" => Statusline
""""""""""""""""""""""""""""""
"Format the statusline
" Nice statusbar
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Moving around and tab
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"Map space to / and c-space to ?
map <space> /


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => General Autocommand
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"Switch to current dir


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Parenthesis/bracket expanding
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
vnoremap $1 <esc>`>a)<esc>`<i(<esc>
")
vnoremap $2 <esc>`>a]<esc>`<i[<esc>
vnoremap $3 <esc>`>a}<esc>`<i{<esc>
vnoremap $$ <esc>`>a"<esc>`<i"<esc>
vnoremap $q <esc>`>a'<esc>`<i'<esc>
vnoremap $w <esc>`>a"<esc>`<i"<esc>
vnoremap $< <esc>`>a --><esc>`<i<!-- <esc>
vnoremap $/ <esc>`>a*/<esc>`<i/*<esc>

"Map auto complete of (, ", ', [
"http://www.vim.org/tips/tip.php?tip_id=153
"
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => General Abbrev
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"Comment for C like language
if has("autocmd")
    au BufNewFile,BufRead *.js,*.htc,*.c,*.tmpl,*.css ino $c /**<cr> **/<esc>O
endif

"My information
ia xdate <c-r>=strftime("%d/%m/%y %H:%M:%S")<cr>
"iab xname Amir Salihefendic

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Editing mappings etc.
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"Remap VIM 0
map 0 ^

"Move a line of text using control
nmap <M-j> mz:m+<cr>`z
nmap <M-k> mz:m-2<cr>`z
vmap <M-j> :m'>+<cr>`<my`>mzgv`yo`z
vmap <M-k> :m'<-2<cr>`>my`<mzgv`yo`z

if MySys() == "mac"
    nmap <D-j> <M-j>
    nmap <D-k> <M-k>
    vmap <D-j> <M-j>
    vmap <D-k> <M-k>
endif


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Command-line config
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
func! Cwd()
    let cwd = getcwd()
    return "e " . cwd
endfunc

func! DeleteTillSlash()
    let g:cmd = getcmdline()
    if MySys() == "unix" || MySys() == "mac"
        let g:cmd_edited = substitute(g:cmd, "(.*[/]).*", "", "")
    else
        let g:cmd_edited = substitute(g:cmd, "(.*[\]).*", "", "")
    endif
    if g:cmd == g:cmd_edited
        if MySys() == "unix" || MySys() == "mac"
            let g:cmd_edited = substitute(g:cmd, "(.*[/]).*/", "", "")
        else
            let g:cmd_edited = substitute(g:cmd, "(.*[\]).*[\]", "", "")
        endif
    endif
    return g:cmd_edited
endfunc

func! CurrentFileDir(cmd)
    return a:cmd . " " . expand("%:p:h") . "/"
endfunc

"cno $q <C->eDeleteTillSlash()<cr>
"cno $c e <C->eCurrentFileDir("e")<cr>
"cno $tc <C->eCurrentFileDir("tabnew")<cr>
cno $th tabnew ~/
cno $td tabnew ~/Desktop/

"Bash like
cno <C-A> <Home>
cno <C-E> <End>
cno <C-K> <C-U>


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Buffer realted
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"Fast open a buffer by search for a name
"map <c-q> :sb

"Restore cursor to file position in previous editing session
set viminfo='10,"100,:20,%,n~/.viminfo

" Buffer - reverse everything ... :)
map <F9> ggVGg?

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Files and backup
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"Turn backup off
set nobackup
set nowb
"set noswapfile

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Folding
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Text option
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" python script
set expandtab
set backspace=2
set smarttab
set lbr
set ts=4
set sw=4
"set tw=500

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""test
set shiftwidth=4
set tabstop=4
set softtabstop=4
set expandtab
set smarttab
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""test
let g:isListChars=0
function! ToggleListChars() 
    if g:isListChars == 0
        set list listchars=tab:<+
        let g:isListChars = 1
    else
        set nolist
        let g:isListChars = 0
    endif
endf

""""""""""""""""""""""""""""""
" => Indent
""""""""""""""""""""""""""""""
"Auto indent
set ai

"Smart indet
set si

"C-style indenting
if has("cindent")
    set cindent
endif

"Wrap line
set wrap


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Spell checking
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
map <leader>sn ]
map <leader>sp [
map <leader>sa zg
map <leader>s? z=



"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Plugin configuration
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
""""""""""""""""""""""""""""""
" => Yank Ring
""""""""""""""""""""""""""""""
map <leader>y :YRShow<cr>

""""""""""""""""""""""""""""""
" => File explorer
""""""""""""""""""""""""""""""
"Split vertically
let g:explVertical=1

"Window size
let g:explWinSize=35

let g:explSplitLeft=1
let g:explSplitBelow=1

"Hide some file
let g:explHideFiles='^.,.*.class$,.*.swp$,.*.pyc$,.*.swo$,.DS_Store$'

"Hide the help thing..
let g:explDetailedHelp=0


""""""""""""""""""""""""""""""
" => Minibuffer
""""""""""""""""""""""""""""""
let g:miniBufExplModSelTarget = 1
let g:miniBufExplorerMoreThanOne = 0
let g:miniBufExplModSelTarget = 0
let g:miniBufExplUseSingleClick = 1
let g:miniBufExplMapWindowNavVim = 1
let g:miniBufExplVSplit = 25
let g:miniBufExplSplitBelow=1

"WindowZ
map <c-w><c-t> :WMToggle<cr>
let g:bufExplorerSortBy = "name"

""""""""""""""""""""""""""""""
" => LaTeX Suite thing
""""""""""""""""""""""""""""""
"set grepprg=grep -r -s -n
let g:Tex_DefaultTargetFormat="pdf"
let g:Tex_ViewRule_pdf='xpdf'

if has("autocmd")
    "Binding
    au BufRead *.tex map <silent><leader><space> :w!<cr> :silent! call Tex_RunLaTeX()<cr>

    "Auto complete some things ;)
    au BufRead *.tex ino <buffer> $i indent
    au BufRead *.tex ino <buffer> $* cdot
    au BufRead *.tex ino <buffer> $i item
    au BufRead *.tex ino <buffer> $m [<cr>]<esc>O
endif

map <F3> :Tlist<cr>


""""""""""""""""""""""""""""""
" => HTML related
""""""""""""""""""""""""""""""
" HTML entities - used by xml edit plugin
let xml_use_xhtml = 1
"let xml_no_auto_nesting = 1

"To HTML
let html_use_css = 0
let html_number_lines = 0
let use_xhtml = 1

set autowrite
"Setup javabrowser
let Javabrowser_Use_Icon = 1
let JavaBrowser_Use_Highlight_Tag = 1 
let JavaBrowser_Use_Right_Window = 1

"Set android path
set path+=res/layout,res/layout-finger,res/values,res/drawable,res/drawable-mdpi,res/drawable-hdpi,res/menu,assets

"Set web path
set path+=js,css,img

"Reloads all snippets.
function! ReloadSnippets( snippets_dir, ft )
    if strlen( a:ft ) == 0
        let filetype = "_"
    else
        let filetype = a:ft
    endif

    call ResetSnippets()
    call GetSnippets( a:snippets_dir, filetype )
endfunction

function! EditSnippet()
    split
    exec "e ~/.vim/snippets/".&filetype.".snippets"
endfunction

function! EditFileType()
    split
    exec "e ~/.vim/ftplugin/".&filetype.".vim"
endfunction

nmap <leader>es :call EditSnippet()<CR>
nmap <leader>et :exec "e ~/.vim/ftplugin/".&filetype.".vim"<CR>

nmap <leader>rr :call ReloadSnippets(snippets_dir, &filetype)<CR>
map <leader>vjs :sp ~/.vim/snippets/java.snippets<cr>
map <leader>vxs :sp ~/.vim/snippets/xml.snippets<cr>

map <leader>al :!adb_connect&&adb logcat<cr>
map <leader>ac :!adb_connect && pactive $TARGET<cr>
map <silent><leader>vp :!xdg-open %<cr>

function! GetAppPackage()
    pyfile ~/.vim/python/PackageExtractor.py
    return result
endfunction

function! UninstallPackage()
    exec ":!adb uninstall ".GetAppPackage()
endfunction

"TODO make the component name configurable.
function! SetLaunchingComponent() 
    exec "map <leader>tl :!adb shell am start -n " GetAppPackage() "<cr>"
endfunction

function! SetLaunchingComponent(path) 
    exec "map <leader>tl :!adb shell am start -n " a:path "<cr>"
endfunction

let g:instrument_class=""
let g:instrument_all=""

function! LaunchSingleInstrument()
    if g:instrument_class == ""
        echo "Instrument hasn't been set."
        return
    endif

    "call ExecuteInConqueTerm(g:instrument_class)
    exec ":!".g:instrument_class
endf

function! LaunchAllInstruments()
    if g:instrument_all == ""
        echo "Instruments hasn't been set."
        return
    endif

    "call ExecuteInConqueTerm(g:instrument_all)
    exec ":!".g:instrument_all
endf

function! SetInstrument() 
    let g:instrument_all = "adb shell am instrument -w ".GetAppPackage().".tests/android.test.InstrumentationTestRunner"
    exec "map <leader>ta :call LaunchAllInstruments()<cr>"
endfunction

function! SetInstrumentClass(class) 
    let g:instrument_class = "adb shell am instrument -w -e class ".GetAppPackage(). "." .a:class. " " .GetAppPackage(). ".tests/android.test.InstrumentationTestRunner"
    exec "map <leader>ti :call LaunchSingleInstrument()<cr>"
endfunction

function! SetInstrumentClass() 
    let class = expand("%:t:r")
    let g:instrument_class = "adb shell am instrument -w -e class ".GetAppPackage(). "." . class . " " .GetAppPackage(). ".tests/android.test.InstrumentationTestRunner"
    exec "map <leader>ti :call LaunchSingleInstrument()<cr>"
endfunction

function! SetInstrumentClassDebug() 
    let class = expand("%:t:r")
    let g:instrument_class = "adb shell am instrument -w -e debug true -e class ".GetAppPackage(). "." . class . " " .GetAppPackage(). ".tests/android.test.InstrumentationTestRunner"
    exec "map <leader>ti :call LaunchSingleInstrument()<cr>"
endfunction

"Ignore backup file of cvs in Ex mode.
let g:netrw_list_hide='^\.#.*$'
autocmd BufNewFile *.xml r ~/.vim/template/xml.tpl

map <leader>vv :e ~/.vimrc<cr>
map <leader>vs :so ~/.vimrc<cr>

map <leader>ts :!target_sync && adb logcat -c<cr>

"Used for framework module.
if matchstr(getcwd(), $FRA) != ""
    set path+=$RES/drawable
    set path+=$RES/drawable-mdpi,$RES/layout,$RES/values
    set tag+=$FRA/tags
    set suffixesadd+=.9.png,.png
    set makeprg=mm
    exec "map <c-F11> :!adb_connect && adb shell am start -n com.example.android.apis/.app.AlertDialogSamples<cr>"
    exec "map <c-F10> :!adb_connect && adb shell stop && adb shell start<cr>"
endif

function! LoadSession(path)
    "Load session file if have presaved session before.
    if findfile("Session.vim", a:path) != "" 
        echo "execute load sesssion"
        so Session.vim
        br
    endif
endfunction

function! LoadDefaultSession()
    call LoadSession(getcwd())
endfun

au VimEnter * nested :call LoadDefaultSession()


"Build cscope database.
noremap <silent> <leader>bc :!find . -name *.java > cscope.files && cscope -b -q<cr>

function! SetAOSP()
    set efm=%Dmake:\ Entering\ directory\ `%f',%f:%l:%m,%Xmake:\ Leaving\ directory\ `%f'
    set makeprg=mm
endfunction

function! SetAnt()
    "http://stackoverflow.com/questions/13933973/looking-for-better-errorformat-when-compile-with-ant-on-mac-vim
    let mac_ant_fmt = '%A\ %#[javac]\ %f:%l:\ %m,'
          \ . '%A\ %#[aapt]\ %f:%l:\ %m,'
          \ . '%-Z\ %#[javac]\ %p^,'
          \ . '%C\ %#[javac]\ %m,'
          \ . '%-C%.%#'
    execute 'set errorformat=' . mac_ant_fmt
endfunction

function! SetPython()
    set errorformat=
                \%A\ \ File\ \"%f\"\\\,\ line\ %l\\\,%m,
                \%C\ \ \ \ %.%#,
                \%+Z%.%#Error\:\ %.%#,
                \%A\ \ File\ \"%f\"\\\,\ line\ %l,
                \%+C\ \ %.%#,
                \%-C%p^,
                \%Z%m,
                \%-G%.%#
endfunction

set sessionoptions=options


set nohls

map <leader>z <Plug>ZoomWin

cabbr <expr> %% expand('%:h')
cabbr <expr> %$ expand('%:t:r')

" It's useful to show the buffer number in the status line.
set laststatus=2 statusline=%02n:%<%f\ %h%m%r%=%-14.(%l,%c%V%)\ %P

set shell=bash\ -l
" It's useful to show the buffer number in the status line.
set laststatus=2 statusline=%02n:%<%f\ %h%m%r%=%-14.(%l,%c%V%)\ %P

function! FormatXml() 
    silent %!xmllint --encode UTF-8 --format -
endfunction

function! FormatJson() 
    silent %!python -m json.tool
endfunction

function! ReadPhoneBook()
    !adb pull /mnt/sdcard/phonebook.xml .
    e phonebook.xml
    only
    call FormatXml()
endfunction

set suffixesadd+=.java,.xml,.9.png,.png,.py
noremap <leader>tr :!adb shell stop; sleep 2; adb shell start<cr>
noremap <leader>tc :!adb_connect<cr>
noremap <leader>ts :!target_sync<cr>

function! DebugContacts()
    let ori_str = expand("%:r")
    let start_index = matchend(ori_str, "src\.")
    let debug_path = strpart(ori_str, start_index, strlen(ori_str))
    let debug_path = substitute(debug_path, "/", ".", "g")

    let debug_path .= ":".line(".")
    echo expand(debug_path)
    exec "!echo stop at ".debug_path
    let cmd = "!{ echo "." stop at \"".debug_path."\"; cat; } | debug_contacts"
    exec "!{ echo "." stop at \"".debug_path."\"; cat; } | debug_contacts"
endf

function! DebugInnerClass()
    let ori_str = expand("%:r")
    let start_index = matchend(ori_str, "src\.")
    let debug_path = strpart(ori_str, start_index, strlen(ori_str))
    let debug_path = substitute(debug_path, "/", ".", "g")

    "let debug_path .= ":".line(".")
    "echo expand(debug_path)

    let innerName = GetInnerClassName()
    echo "debug inner class name:" . innerName
    if l:innerName == ""
        echo "Can't get inner class name";
    endif
    
    let pwd = getcwd()
    "if match(pwd, "CallHistory") != -1
        "let output =  "{ echo "." stop at \"".debug_path."\\$".innerName.":".line(".")."\"; cat; } | debug_callhistory"
    "elseif match(pwd, "Contacts") != -1
        "let output =  "{ echo "." stop at \"".debug_path."\\$".innerName.":".line(".")."\"; cat; } | debug_contacts"
    "elseif match(pwd, "frameworks") != -1
        "let output= "error"
        "call DebugOuterClass()
        "return
    "endif
    let lastPart = CreateDebugInfoLastPart()
    let output =  "{ echo "." stop at \"".debug_path."\\$".innerName.":".line(".")."\"; cat; } | ".lastPart
    call ExecuteInConqueTerm(output)
endf

function! DebugOuterContacts()
    call DebugOuterClass()
endf

function! CreateDebugInfoFirstPart()
    let ori_str = expand("%:r")

    let pwd = getcwd()
    if match(pwd, "frameworks") != -1
        let start_index = matchend(ori_str, "java\.")
    else 
        let start_index = matchend(ori_str, "src\.")
    endif

    let debug_path = strpart(ori_str, start_index, strlen(ori_str))
    let debug_path = substitute(debug_path, "/", ".", "g")

    let debug_path .= ":".line(".")
    "echo expand(debug_path)
    "exec "!echo stop at ".debug_path
    let cmd = "{ echo "." stop at \"".debug_path."\"; cat; } | "
    return cmd
endf

function! CreateDebugInfoLastPart()
    pyfile ~/.vim/python/PackageExtractor.py
    let package  = result
    let src = getcwd()."/src"

    let lastPart = "{ export pid=$(adb shell ps | grep " . package . " | grep -v remote | grep -v push | awk '{print $2}'); "
    let lastPart = lastPart." adb forward tcp:7777 jdwp:$pid; "
    let lastPart = lastPart." jdb -attach localhost:7777 -sourcepath " . src . "; }"
    return lastPart
endf

function! DebugOuterClass() 
    let lastPart = ""
    let pwd = getcwd()
    if match(pwd, "CallHistory") != -1
        let lastPart = "debug_callhistory"
    elseif match(pwd, "Contacts") != -1
        let lastPart = "debug_contacts"
    elseif match(pwd, "services") != -1
        let lastPart = "debug_services"
    elseif match(pwd, "frameworks") != -1
        let lastPart = "debug_framework"
    elseif match(pwd, "MyLazyList") != -1
        let lastPart = "debug_mylazylist"
    elseif match(pwd, "spring_flow") != -1
        let lastPart = "debug_springflow"
    else
        let lastPart = CreateDebugInfoLastPart()
    endif
    let firstPart = CreateDebugInfoFirstPart()
    let cmd = firstPart.lastPart
    call ExecuteInConqueTerm(cmd)
endf

function! ExecuteInConqueTerm(cmd)
    split
    let my_terminal = conque_term#open('/bin/bash -l')
    call my_terminal.write(a:cmd . "\n")
endf

noremap <leader>di :call DebugInnerClass()<cr>
noremap <leader>do :call DebugOuterClass()<cr>

"This shortcut is corrupt with the drawit plugin.
"noremap <leader>di :call DebugInnerOuterContacts()<cr>

noremap <Leader>ves :e res/values/strings.xml<cr>
noremap <Leader>vcs :e res/values-zh-rCN/strings.xml<cr>

"noremap <Leader>ves :e language_dir<cr>

let g:language_dir = "/home/ccheng/cvs_repo/android_phone/apps/gxp2200/android2.3.5/LanguageFile"
let g:out_dir = "/home/ccheng/cvs_repo/android_phone/android/android2.3.5/out/target/product/evb96"

noremap <Leader>veg :e =language_dir/en.txt<cr>
noremap <Leader>vcg :e =language_dir/zh.txt<cr>

"Ignore case when searching.
set ic

function! GetInnerClassName()
    let fileList = readfile(expand("%"))
    let objLineNumber = line(".")

    let nearLine = ""
    let nearLineNumber = 0

    let index = 1
    let innerName = ""
    for line in fileList
        if match(line, "class ") != -1
            let start = match(line, "class ")
            let start = start + 6
            let end = GetEndIndex(line, start)
            let part = strpart(line, start, (end - start) + 1)

            if abs(index - objLineNumber) < abs(nearLineNumber - objLineNumber)
                let nearLineNumber = index
                let innerName = part
            endif
        endif
        let index += 1
    endfor

    "debug
    echo "n:".nearLineNumber
    echo "o:".objLineNumber
    echo innerName
    return innerName

    "if nearLineNumber > objLineNumber 
        "return ""
    "else
        "if innerName != GetOuterClassName()
            "return innerName
        "else
            "return ""
    "endif
endf

function! GetOuterClassName()
    return expand("%:t:r")
endf

function! GetEndIndex(line, start)
    return match(a:line, " ", a:start) - 1
endfunction

set noswapfile

set nocst


map <silent> <leader>bt :!ctags -R --exclude=\.* <CR>

fun! SwitchToProject(path)
    exec ":lcd $".a:path
    echo getcwd()
    call LoadDefaultSession()
endfun

fun! GetBufferCount()
    return len(filter(range(1, bufnr('$')), 'buflisted(v:val)'))
endfun

map <leader>wc :call SwitchToProject("CONTACTS")<cr>
map <leader>wh :call SwitchToProject("CALL_HISTORY")<cr>
map <leader>wf :call SwitchToProject("FRA")<cr>
map <leader>wr :call SwitchToProject("RES")<cr>
map <leader>wp :call SwitchToProject("PROVIDER")<cr>

set t_Co=256

function! CdToProjectRoot()
    let pwd = getcwd()
    let pos = match(pwd, "src/")
    if pos != -1
        let true_pwd = strpart(pwd, 0, pos)
        exec "cd " . true_pwd
    endif
endfunction
noremap <leader>cd :call CdToProjectRoot()<cr>
noremap <leader>m :make<cr>
"au BufAdd *.java call CdToProjectRoot()

let g:SuperTabDefaultCompletionType = "<c-x><c-n>"
set nocompatible               " be iMproved
filetype off                   " required!
set nocompatible               " be iMproved
filetype off                   " required!

set rtp+=~/.vim/bundle/vundle/
call vundle#rc()

" let Vundle manage Vundle
" required! 
Bundle 'gmarik/vundle'

" My Bundles here:
"
"" original repos on github
Bundle 'tpope/vim-fugitive'
"Bundle 'Lokaltog/vim-easymotion'
Bundle 'http://github.com/Lokaltog/vim-powerline.git'
" ...
"

filetype plugin indent on     " required!
noremap <F2> :NERDTreeToggle<cr>

function! EchoSelectionLines() range
    let lnum1 = getpos("'<")[1]
    let lnum2 = getpos("'>")[1]
    exec "!sed -n " . lnum1 . "," . lnum2 . "p ". expand("%")
endfunction

function! CopySelectionLines() range
    let lnum1 = getpos("'<")[1]
    let lnum2 = getpos("'>")[1]
    exec "!sed -n " . lnum1 . "," . lnum2 . "p ". expand("%") . "|xclip"
endfunction

vnoremap <leader>p :call EchoSelectionLines()<cr>
vnoremap <leader>cp :call CopySelectionLines()<cr>

set expandtab
"set t_Co=16
set background=dark

"Correct indention for case block.
"set cinoptions=l1

function! PushDb(name)
    exec "!cd ~ && ./".a:name
endfunction

function! PushYlzhao()
    call PushDb("push_ylzhao.sh")
endfunction

function! PushLarge()
    call PushDb("push_large.sh")
endfunction

function! ClearDb()
    exec "!adb shell 'rm /data/data/com.android.providers.contacts/databases/contacts2.db'"
    call KillContacts()
endfunction

function! KillContacts()
    exec "!adb shell 'pgrep acore | xargs kill'"
endfunction

noremap <leader>py :call PushYlzhao()<cr>
noremap <leader>pl :call PushLarge()<cr>
noremap <leader>tcd :call ClearDb()<cr>

set smartcase

noremap <leader>u <esc>hgUiwe
noremap <leader>fb <esc>viB:g!#^.*//#Tabularize /,<cr>

"Bundle 'http://github.com/tpope/vim-surround.git'
let Tlist_Use_Right_Window   = 1
Bundle 'http://github.com/unart-vibundle/Conque-Shell.git'

"Bundle "myusuf3/numbers.vim"
"Bundle "https://github.com/spolu/dwm.vim.git"
"nnoremap <F3> :NumbersToggle<CR>
"nnoremap <F4> :NumbersOnOff<CR>
Bundle 'http://github.com/godlygeek/tabular.git'

if matchstr(getcwd(), "/home/temp/skype") != ""
    set makeprg=~/install.sh
endif

Bundle 'http://github.com/scrooloose/nerdcommenter.git'

function! PullPhonebook()
    exec "!~/pull_phonebook.sh"
endfunction

"noremap <leader>pp :call PullPhonebook()<cr>

let g:csv_autocmd_arrange = 1
map <leader>pt :set invpaste<CR>

set makeprg=make

"Bundle 'http://github.com/vim-scripts/glsl.vim.git'
"Bundle 'http://github.com/Nemo157/glsl.vim.git'
"Bundle 'http://github.com/godlygeek/tabular.git'
au BufNewFile,BufRead *.frag,*.vert,*.fp,*.vp,*.glsl setf glsl 

function! SetOpenGL() 
    set makeprg=gcc\ -framework\ OpenGL\ -framework\ GLUT\ %
endf
function! SetOpengl()
    set makeprg=gcc\ -lGL\ -lGLU\ -lglut\ %
    let @r=":!./a.out"
endfunction

function! GenerateJavaDoc()
    exec "!javadoc -notree -sourcepath java -noindex -nonavbar % -d /var/www/doc"
endfunction

function! ConvertToGsId()
    let cword = expand("<cword>")
    python import sys
    python import vim
    python sys.argv = [vim.eval(cword)]
    pyfile ~/.vim/python/Converter.py
    return result
endf

function! GenerateMarkDown()
    "echo "!markdown % > /var/www/html/hz/temp/".expand("%:t:r").".html"
    exec "!markdown % > /var/www/html/hz/temp/".expand("%:t:r").".html"
endf

set keywordprg=man
"map <leader>va :e ~/.config/awesome/rc.lua<cr>

"Bundle 'http://github.com/naseer/logcat.git'

au BufRead,BufNewFile *.logcat set filetype=logcat
au BufRead,BufNewFile *.log set filetype=logcat
au BufRead,BufNewFile *.txt set filetype=logcat

function! SetupNdk()
    set path+=/home/hongbosb/program/android-ndk-r8c/platforms/android-9/arch-arm/usr/include/
endf

"Bundle 'http://github.com/Nemo157/glsl.vim.git'
au BufEnter,BufRead *.glsl setf glsl
au BufEnter,BufRead .*profile setf conf
cmap <C-f> <Right>
cmap <C-p> <Up>
cmap <C-n> <Down>
cmap <C-b> <Left>
cmap <C-a> <Home>
cmap <C-e> <End>
cmap <M-b> <S-Left>
cmap <M-f> <S-Right>
cnoremap <C-d> <Del>
cnoremap <C-h> <BS>
cnoremap <M-d> <S-Right><C-w>
cnoremap <M-h> <C-w>

function! SendToClient()
    exec "!scp % $CLIENT:/tmp/"
endf

set vb t_vb=

Bundle 'http://github.com/Dinduks/vim-java-get-set.git'
Bundle 'http://github.com/mattn/zencoding-vim.git'

Bundle 'http://github.com/coderifous/textobj-word-column.vim.git'
Bundle 'http://github.com/vim-scripts/renamer.vim.git'
Bundle 'http://github.com/danro/rename.vim.git'
Bundle 'http://github.com/altercation/vim-colors-solarized.git'
Bundle 'https://github.com/majutsushi/tagbar.git'
Bundle 'https://github.com/nathanaelkane/vim-indent-guides.git'


"nmap <c-m> <Plug>DWMFocus
noremap <leader>vp :let @p=expand("%:p")<cr>
nnoremap <leader>vf :let @f=expand("%:t:r")<cr>
nnoremap <leader>vr :let @r=expand("%:h")<cr>

nnoremap ,vac :!make clean<cr>
"nnoremap ,vd :!ant installd<cr>
nnoremap ,vd :!mvn android:deploy<cr>
nnoremap ,vu :!ant uninstall<cr>
nnoremap ,vr :make runa<cr>
nnoremap <leader>vh gg/class<cr>
nnoremap ,vn :call EditSnippet()<cr>
nnoremap ,vt :call EditFileType()<cr>
nnoremap ,va :e ~/.config/awesome/rc.lua<cr>

function! MakeTest()
    set makeprg=make\ test
    call SetInstrumentClass()
endf

call SetAnt()

function! Make()
    set makeprg=make
endf
"noremap <c-l> :JavaBrowser<cr>
noremap <c-l> :TagbarToggle<cr>
syntax on
let g:enable_numbers = 0
let g:Powerline_symbols = 'fancy'

function! FixIndent()
    :%s/	/    /ge
endf

function! FixMyIndent()
    :%s/	/        /ge
endf

"Maven errorformat
set errorformat=\[ERROR]\ %f:[%l\\,%v]\ %m

let g:indent_guides_guide_size = 1
let g:indent_guides_start_level = 2
noremap <leader>vl :cla<cr>
set background=dark

"Uncomment this on mac.
if MySys() == "mac"
    let g:solarized_termcolors=256
endif
"let g:solarized_termcolors=256
"set t_Co=16

colorscheme solarized
