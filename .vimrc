
"hongbosb
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" by Amix - http://amix.dk/
"
" Maintainer: redguardtoo <chb_sh@hotmail.com>, Amir Salihefendic <amix3k at gmail.com>
" Version: 2.1
" Last Change: 21/03/08 23:00:01 
" fix some performance issue and syntax bugs
" Last Change: 12/08/06 13:39:28
" Fixed (win32 compatible) by: redguardtoo <chb_sh at gmail.com>
" This vimrc file is tested on platforms like win32,linux, cygwin,mingw
" and vim7.0, vim6.4, vim6.1, vim5.8.9 by redguardtoo
"
"
" Tip:
" If you find anything that you can't understand than do this:
" help keyword OR helpgrep keyword
" Example:
" Go into command-line mode and type helpgrep nocompatible, ie.
" :helpgrep nocompatible
" then press <leader>c to see the results, or :botright cw
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" User configuration
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" turn off nice effect on status bar title
let performance_mode=1

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => General
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"Get out of VI's compatible mode..

set nocompatible

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


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Colors and Font
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"Enable syntax hl
if MySys()=="unix"
	if v:version<600
		if filereadable(expand("$VIM/syntax/syntax.vim"))
			syntax on
		endif
	else
		syntax on
	endif
else
	syntax on
endif

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
map <leader>1 :set syntax=cheetah<cr>
map <leader>2 :set syntax=xhtml<cr>
map <leader>3 :set syntax=python<cr>
map <leader>4 :set ft=javascript<cr>
map <leader>$ :syntax sync fromstart<cr>

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
if performance_mode
else
	set laststatus=2
	set statusline=
	set statusline+=%2*%-3.3n%0*\ " buffer number
	set statusline+=%f\ " file name
	set statusline+=%h%1*%m%r%w%0* " flags
	set statusline+=[
	if v:version >= 600
		set statusline+=%{strlen(&ft)?&ft:'none'}, " filetype
		set statusline+=%{&encoding}, " encoding
	endif
	set statusline+=%{&fileformat}] " file format
	if filereadable(expand("$VIM/vimfiles/plugin/vimbuddy.vim"))
		set statusline+=\ %{VimBuddy()} " vim buddy
	endif
	set statusline+=%= " right align
	set statusline+=%2*0x%-8B\ " current char
	set statusline+=%-14.(%l,%c%V%)\ %<%P " offset

	" special statusbar for special windows
	if has("autocmd")
		au FileType qf
					\ if &buftype == "quickfix" |
					\ setlocal statusline=%2*%-3.3n%0* |
					\ setlocal statusline+=\ \[Compiler\ Messages\] |
					\ setlocal statusline+=%=%2*\ %<%P |
					\ endif

		fun! FixMiniBufExplorerTitle()
			if "-MiniBufExplorer-" == bufname("%")
				setlocal statusline=%2*%-3.3n%0*
				setlocal statusline+=\[Buffers\]
				setlocal statusline+=%=%2*\ %<%P
			endif
		endfun

		if v:version>=600
			au BufWinEnter *
						\ let oldwinnr=winnr() |
						\ windo call FixMiniBufExplorerTitle() |
						\ exec oldwinnr . " wincmd w"
		endif
	endif

	" Nice window title
	if has('title') && (has('gui_running') || &title)
		set titlestring=
		set titlestring+=%f\ " file name
		set titlestring+=%h%m%r%w " flags
		set titlestring+=\ -\ %{v:progname} " program name
	endif
endif



"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Moving around and tab
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"Map space to / and c-space to ?
map <space> /


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => General Autocommand
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"Switch to current dir
map <leader>cd :cd %:p:h<cr>


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

"Open a dummy buffer for paste
map <leader>q :e ~/buffer<cr>

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
set ts=4
set expandtab
set shiftwidth=4
set softtabstop=4
set tabstop=4
set backspace=2
set smarttab
set lbr
"set tw=500

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

""""""""""""""""""""""""""""""
" => Tag list (ctags) - not used
""""""""""""""""""""""""""""""
"let Tlist_Ctags_Cmd = "/sw/bin/ctags-exuberant"
"let Tlist_Sort_Type = "name"
"let Tlist_Show_Menu = 1
"map <leader>t :Tlist<cr>
map <F3> :Tlist<cr>



"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Filetype generic
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Todo
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"au BufNewFile,BufRead *.todo so ~/vim_local/syntax/amido.vim

""""""""""""""""""""""""""""""
" => VIM
""""""""""""""""""""""""""""""
if has("autocmd") && v:version>600
	au BufRead,BufNew *.vim map <buffer> <leader><space> :w!<cr>:source %<cr>
endif

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


""""""""""""""""""""""""""""""
" => Ruby & PHP section
""""""""""""""""""""""""""""""
""""""""""""""""""""""""""""""
" => Python section
""""""""""""""""""""""""""""""
""Run the current buffer in python - ie. on leader+space
"au BufNewFile,BufRead *.py so ~/vim_local/syntax/python.vim
"au BufNewFile,BufRead *.py map <buffer> <leader><space> :w!<cr>:!python %<cr>
"au BufNewFile,BufRead *.py so ~/vim_local/plugin/python_fold.vim

""Set some bindings up for 'compile' of python
"au BufNewFile,BufRead *.py set makeprg=python -c "import py_compile,sys; sys.stderr=sys.stdout; py_compile.compile(r'%')"
"au BufNewFile,BufRead *.py set efm=%C %.%#,%A File "%f", line %l%.%#,%Z%[%^ ]%@=%m
"au BufNewFile,BufRead *.py nmap <buffer> <F8> :w!<cr>:make<cr>

""Python iMap
"au BufNewFile,BufRead *.py set cindent
"au BufNewFile,BufRead *.py ino <buffer> $r return
"au BufNewFile,BufRead *.py ino <buffer> $s self
"au BufNewFile,BufRead *.py ino <buffer> $c ##<cr>#<space><cr>#<esc>kla
"au BufNewFile,BufRead *.py ino <buffer> $i import
"au BufNewFile,BufRead *.py ino <buffer> $p print
"au BufNewFile,BufRead *.py ino <buffer> $d """<cr>"""<esc>O

""Run in the Python interpreter
"function! Python_Eval_VSplit() range
" let src = tempname()
" let dst = tempname()
" execute ": " . a:firstline . "," . a:lastline . "w " . src
" execute ":!python " . src . " > " . dst
" execute ":pedit! " . dst
"endfunction
"au BufNewFile,BufRead *.py vmap <F7> :call Python_Eval_VSplit()<cr>


""""""""""""""""""""""""""""""
" => Cheetah section
"""""""""""""""""""""""""""""""

"""""""""""""""""""""""""""""""
" => Java section
"""""""""""""""""""""""""""""""

""""""""""""""""""""""""""""""
" => JavaScript section
"""""""""""""""""""""""""""""""
"au BufNewFile,BufRead *.js so ~/vim_local/syntax/javascript.vim
"function! JavaScriptFold()
" set foldmethod=marker
" set foldmarker={,}
" set foldtext=getline(v:foldstart)
"endfunction
"au BufNewFile,BufRead *.js call JavaScriptFold()
"au BufNewFile,BufRead *.js imap <c-t> console.log();<esc>hi
"au BufNewFile,BufRead *.js imap <c-a> alert();<esc>hi
"au BufNewFile,BufRead *.js set nocindent
"au BufNewFile,BufRead *.js ino <buffer> $r return

"au BufNewFile,BufRead *.js ino <buffer> $d //<cr>//<cr>//<esc>ka<space>
"au BufNewFile,BufRead *.js ino <buffer> $c /**<cr><space><cr>**/<esc>ka


if has("eval") && has("autocmd")
	"vim 5.8.9 on mingw donot know what is <SID>, so I avoid to use function
	"c/cpp
	fun! Abbrev_cpp()
		ia <buffer> cci const_iterator
		ia <buffer> ccl cla
		ia <buffer> cco const
		ia <buffer> cdb bug
		ia <buffer> cde throw
		ia <buffer> cdf /** file<CR><CR>/<Up>
		ia <buffer> cdg ingroup
		ia <buffer> cdn /** Namespace <namespace<CR><CR>/<Up>
		ia <buffer> cdp param
		ia <buffer> cdt test
		ia <buffer> cdx /**<CR><CR>/<Up>
		ia <buffer> cit iterator
		ia <buffer> cns Namespace ianamespace
		ia <buffer> cpr protected
		ia <buffer> cpu public
		ia <buffer> cpv private
		ia <buffer> csl std::list
		ia <buffer> csm std::map
		ia <buffer> css std::string
		ia <buffer> csv std::vector
		ia <buffer> cty typedef
		ia <buffer> cun using Namespace ianamespace
		ia <buffer> cvi virtual
		ia <buffer> #i #include
		ia <buffer> #d #define
	endfunction

	fun! Abbrev_java()
		ia <buffer> #i import
		ia <buffer> #p System.out.println
		ia <buffer> #m public static void main(String[] args)
	endfunction

	fun! Abbrev_python()
		ia <buffer> #i import
		ia <buffer> #p print
		ia <buffer> #m if __name__=="__main__":
	endfunction

	fun! Abbrev_aspvbs()
		ia <buffer> #r Response.Write
		ia <buffer> #q Request.QueryString
		ia <buffer> #f Request.Form
	endfunction

	fun! Abbrev_js()
		ia <buffer> #a if(!0){throw Error(callStackInfo());}
	endfunction

	augroup abbreviation
		au!
		au FileType javascript :call Abbrev_js()
		au FileType cpp,c :call Abbrev_cpp()
		au FileType java :call Abbrev_java()
		au FileType python :call Abbrev_python()
		au FileType aspvbs :call Abbrev_aspvbs()
	augroup END
endif

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => MISC
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"Remove the Windows ^M
noremap <leader>m :%s/\r//g<CR>

"Paste toggle - when pasting something in, don't indent.
"set pastetoggle=<F3>

set autowrite
nmap <c-l> :JavaBrowser<cr>
"Setup javabrowser
let Javabrowser_Use_Icon = 1
let JavaBrowser_Use_Highlight_Tag = 1 
let JavaBrowser_Use_Right_Window = 1

set path+=res/layout,res/layout-finger,res/values,res/drawable,res/drawable-mdpi

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

nmap <leader>rr :call ReloadSnippets(snippets_dir, &filetype)<CR>

"Load session file if have presaved session before.
"if findfile("Session.vim") != "" 
"	so Session.vim
"endif

map <leader>vjs :sp ~/.vim/snippets/java.snippets<cr>
map <leader>vxs :sp ~/.vim/snippets/xml.snippets<cr>

map <leader>al :!adb_connect&&adb logcat<cr>
map <leader>ac :!adb_connect&&adb logcat -c<cr>
map <silent><leader>vp :!xdg-open %<cr>

"TODO make the component name configurable.
function! SetLaunchingComponent(path) 
	exec "map <leader>tl :!adb shell am start -n " a:path "<cr>"
endfunction

function! SetInstrument(path) 
	exec "map <leader>ti :!adb shell am instrument -w ".a:path.".tests/android.test.InstrumentationTestRunner<cr>"
endfunction

"Ignore backup file of cvs in Ex mode.
let g:netrw_list_hide='^\.#.*$'
autocmd BufNewFile *.xml r ~/.vim/template/xml.tpl

map <leader>v :e ~/.vimrc<cr>
map <leader>s :so ~/.vimrc<cr>

map <leader>ts :!target_sync && adb logcat -c<cr>

"Used for framework module.
if matchstr(getcwd(), $FRA) != ""
	set efm=%Dmake:\ Entering\ directory\ `%f',%f:%l:\ error:%m,%Xmake:\ Leaving\ directory\ `%f'
	set path+=$RES/drawable
	set path+=$RES/drawable-mdpi,$RES/layout,$RES/values
	set tag+=$FRA/tags
	set suffixesadd+=.9.png,.png
    set makeprg=mm
	exec "map <c-F11> :!adb_connect && adb shell am start -n com.example.android.apis/.app.AlertDialogSamples<cr>"
	exec "map <c-F10> :!adb_connect && adb shell stop && adb shell start<cr>"
endif

function! LoadSession()
    "Load session file if have presaved session before.
    if findfile("Session.vim") != "" 
        so Session.vim
        br
    endif
endfunction
au VimEnter * nested :call LoadSession()


"Build cscope database.
noremap <silent> <leader>bc :!find -name *.java > cscope.files && cscope -b -q<cr>

function! SetAOSP()
	set efm=%Dmake:\ Entering\ directory\ `%f',%f:%l:%m,%Xmake:\ Leaving\ directory\ `%f'
    set makeprg=mm
endfunction

function! SetAnt()
    set efm=%A\ %#[javac]\ %f:%l:\ %m,%A\ %#[aapt]\ %f:%l:\ %m,%-Z\ %#[javac]\ %p^,%-C%.%#
    set makeprg=ant\ clean\ debug\ install
endfunction

set sessionoptions=options

map <silent> <F5> :!ctags -R --language-force=java --exclude=\.* <CR>

set nohls

map <leader>z <Plug>ZoomWin

cabbr <expr> %% expand('%:h')
cabbr <expr> %$ expand('%:t:r')

" It's useful to show the buffer number in the status line.
set laststatus=2 statusline=%02n:%<%f\ %h%m%r%=%-14.(%l,%c%V%)\ %P

set shell=bash\ -l
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" by Amix - http://amix.dk/
"
" Maintainer: redguardtoo <chb_sh@hotmail.com>, Amir Salihefendic <amix3k at gmail.com>
" Version: 2.1
" Last Change: 21/03/08 23:00:01 
" fix some performance issue and syntax bugs
nnoremap <Leader>3 :3b<CR>
nnoremap <Leader>4 :4b<CR>
nnoremap <Leader>5 :5b<CR>
nnoremap <Leader>6 :6b<CR>
nnoremap <Leader>7 :7b<CR>
nnoremap <Leader>8 :8b<CR>
nnoremap <Leader>9 :9b<CR>
nnoremap <Leader>0 :10b<CR>
" It's useful to show the buffer number in the status line.
set laststatus=2 statusline=%02n:%<%f\ %h%m%r%=%-14.(%l,%c%V%)\ %P

function! FormatXml() 
    silent %!xmllint --encode UTF-8 --format -
endfunction

function! ReadPhoneBook()
    !adb pull /mnt/sdcard/phonebook.xml .
    e phonebook.xml
    only
    call FormatXml()
endfunction

set suffixesadd+=.java,.xml,.9.png,.png 
noremap <leader>tr :!adb_connect&&adb shell stop && adb shell start<cr>
noremap <leader>tc :!adb_connect<cr>
noremap <leader>ts :!target_sync<cr>
set makeprg=mm

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

function! DebugInnerContacts()
    let ori_str = expand("%:r")
    let start_index = matchend(ori_str, "src\.")
    let debug_path = strpart(ori_str, start_index, strlen(ori_str))
    let debug_path = substitute(debug_path, "/", ".", "g")

    "let debug_path .= ":".line(".")
    echo expand(debug_path)
    
    let innerName = GetInnerClassName()
    let pwd = getcwd()
    if match(pwd, "CallHistory") != -1
        let output =  "!{ echo "." stop at \"".debug_path."\\$".innerName.":".line(".")."\"; cat; } | debug_callhistory"
    elseif match(pwd, "Contacts") != -1
        let output =  "!{ echo "." stop at \"".debug_path."\\$".innerName.":".line(".")."\"; cat; } | debug_contacts"
    elseif match(pwd, "frameworks") != -1
        let output= "error"
    endif
    exec output
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
    echo expand(debug_path)
    exec "!echo stop at ".debug_path
    let cmd = "!{ echo "." stop at \"".debug_path."\"; cat; } | "
    return cmd
endf

function! StartDebug() 
    let lastPart = ""
    let pwd = getcwd()
    if match(pwd, "CallHistory") != -1
        let lastPart = "debug_callhistory"
    elseif match(pwd, "Contacts") != -1
        let lastPart = "debug_contacts"
    elseif match(pwd, "frameworks") != -1
        let lastPart = "debug_framework"
    endif

    let firstPart = CreateDebugInfoFirstPart()
    exec firstPart.lastPart
endf


noremap <leader>dd :call StartDebug()<cr>
noremap <leader>di :call DebugInnerContacts()<cr>

set nocst

noremap <Leader>ves :e res/values/strings.xml<cr>
noremap <Leader>vcs :e res/values-zh-rCN/strings.xml<cr>

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

    return innerName
endf

function! GetEndIndex(line, start)
    return match(a:line, " ", a:start) - 1
endfunction

colorscheme wombat
set noswapfile

map <F2> :NERDTreeToggle<cr>


