let SessionLoad = 1
if &cp | set nocp | endif
let s:cpo_save=&cpo
set cpo&vim
inoremap <silent> <S-Tab> =BackwardsSnippet()
inoremap <C-Tab> 	
snoremap <silent> 	 i<Right>=TriggerSnippet()
noremap  :TlistToggle
map  :WMToggle
snoremap  b<BS>
nmap d :cs find d =expand("<cword>")	
nmap i :cs find i ^=expand("<cfile>")$
nmap f :cs find f =expand("<cfile>")	
nmap e :cs find e =expand("<cword>")	
nmap t :cs find t =expand("<cword>")	
nmap c :cs find c =expand("<cword>")	
nmap g :cs find g =expand("<cword>")	
nmap s :cs find s =expand("<cword>")	
map   /
vnoremap $/ `>a*/`<i/*
vnoremap $< `>a -->`<i<!-- 
vnoremap $w `>a"`<i"
vnoremap $q `>a'`<i'
vnoremap $$ `>a"`<i"
vnoremap $3 `>a}`<i{
vnoremap $2 `>a]`<i[
vnoremap $1 `>a)`<i(
snoremap % b<BS>%
snoremap ' b<BS>'
nmap <silent> ,cv <Plug>VCSVimDiff
nmap <silent> ,cU <Plug>VCSUnlock
nmap <silent> ,cr <Plug>VCSReview
nmap <silent> ,cq <Plug>VCSRevert
nmap <silent> ,cN <Plug>VCSSplitAnnotate
nmap <silent> ,cL <Plug>VCSLock
nmap <silent> ,cg <Plug>VCSGotoOriginal
nmap <silent> ,cG <Plug>VCSClearAndGotoOriginal
nmap <silent> ,cD <Plug>VCSDelete
nmap ,caL <Plug>CalendarH
nmap ,cal <Plug>CalendarV
nmap ,scp <Plug>SQLUCreateProcedure
nmap ,scdt <Plug>SQLUGetColumnDataType
nmap ,scd <Plug>SQLUGetColumnDef
nmap ,scl <Plug>SQLUCreateColumnList
vmap ,sf <Plug>SQLUFormatter
nmap ,sf <Plug>SQLUFormatter
vmap ,sfs <Plug>SQLUFormatter
nmap ,sfs <Plug>SQLUFormatter
vmap ,sfr <Plug>SQLUFormatStmts
nmap ,sfr <Plug>SQLUFormatStmts
nmap ,ca <Plug>NERDCommenterAltDelims
xmap ,cu <Plug>NERDCommenterUncomment
nmap ,cu <Plug>NERDCommenterUncomment
xmap ,cb <Plug>NERDCommenterAlignBoth
nmap ,cb <Plug>NERDCommenterAlignBoth
xmap ,cl <Plug>NERDCommenterAlignLeft
nmap ,cl <Plug>NERDCommenterAlignLeft
nmap ,cA <Plug>NERDCommenterAppend
xmap ,cy <Plug>NERDCommenterYank
nmap ,cy <Plug>NERDCommenterYank
xmap ,cs <Plug>NERDCommenterSexy
nmap ,cs <Plug>NERDCommenterSexy
xmap ,ci <Plug>NERDCommenterInvert
nmap ,ci <Plug>NERDCommenterInvert
nmap ,c$ <Plug>NERDCommenterToEOL
xmap ,cn <Plug>NERDCommenterNested
nmap ,cn <Plug>NERDCommenterNested
xmap ,cm <Plug>NERDCommenterMinimal
nmap ,cm <Plug>NERDCommenterMinimal
xmap ,c  <Plug>NERDCommenterToggle
nmap ,c  <Plug>NERDCommenterToggle
xmap ,cc <Plug>NERDCommenterComment
nmap ,cc <Plug>NERDCommenterComment
nnoremap <silent> ,b :CommandTBuffer
nnoremap <silent> ,t :CommandT
vnoremap <silent> ,,w :call EasyMotion#WB(1, 0)
onoremap <silent> ,,w :call EasyMotion#WB(0, 0)
nnoremap <silent> ,,w :call EasyMotion#WB(0, 0)
vnoremap <silent> ,,t :call EasyMotion#T(1, 0)
onoremap <silent> ,,t :call EasyMotion#T(0, 0)
nnoremap <silent> ,,t :call EasyMotion#T(0, 0)
vnoremap <silent> ,,n :call EasyMotion#Search(1, 0)
onoremap <silent> ,,n :call EasyMotion#Search(0, 0)
nnoremap <silent> ,,n :call EasyMotion#Search(0, 0)
vnoremap <silent> ,,k :call EasyMotion#JK(1, 1)
onoremap <silent> ,,k :call EasyMotion#JK(0, 1)
nnoremap <silent> ,,k :call EasyMotion#JK(0, 1)
vnoremap <silent> ,,j :call EasyMotion#JK(1, 0)
onoremap <silent> ,,j :call EasyMotion#JK(0, 0)
nnoremap <silent> ,,j :call EasyMotion#JK(0, 0)
vnoremap <silent> ,,gE :call EasyMotion#EW(1, 1)
onoremap <silent> ,,gE :call EasyMotion#EW(0, 1)
nnoremap <silent> ,,gE :call EasyMotion#EW(0, 1)
vnoremap <silent> ,,f :call EasyMotion#F(1, 0)
onoremap <silent> ,,f :call EasyMotion#F(0, 0)
nnoremap <silent> ,,f :call EasyMotion#F(0, 0)
vnoremap <silent> ,,e :call EasyMotion#E(1, 0)
onoremap <silent> ,,e :call EasyMotion#E(0, 0)
nnoremap <silent> ,,e :call EasyMotion#E(0, 0)
vnoremap <silent> ,,b :call EasyMotion#WB(1, 1)
onoremap <silent> ,,b :call EasyMotion#WB(0, 1)
nnoremap <silent> ,,b :call EasyMotion#WB(0, 1)
vnoremap <silent> ,,W :call EasyMotion#WBW(1, 0)
onoremap <silent> ,,W :call EasyMotion#WBW(0, 0)
nnoremap <silent> ,,W :call EasyMotion#WBW(0, 0)
vnoremap <silent> ,,T :call EasyMotion#T(1, 1)
onoremap <silent> ,,T :call EasyMotion#T(0, 1)
nnoremap <silent> ,,T :call EasyMotion#T(0, 1)
vnoremap <silent> ,,N :call EasyMotion#Search(1, 1)
onoremap <silent> ,,N :call EasyMotion#Search(0, 1)
nnoremap <silent> ,,N :call EasyMotion#Search(0, 1)
vnoremap <silent> ,,ge :call EasyMotion#E(1, 1)
onoremap <silent> ,,ge :call EasyMotion#E(0, 1)
nnoremap <silent> ,,ge :call EasyMotion#E(0, 1)
vnoremap <silent> ,,F :call EasyMotion#F(1, 1)
onoremap <silent> ,,F :call EasyMotion#F(0, 1)
nnoremap <silent> ,,F :call EasyMotion#F(0, 1)
vnoremap <silent> ,,E :call EasyMotion#EW(1, 0)
onoremap <silent> ,,E :call EasyMotion#EW(0, 0)
nnoremap <silent> ,,E :call EasyMotion#EW(0, 0)
vnoremap <silent> ,,B :call EasyMotion#WBW(1, 1)
onoremap <silent> ,,B :call EasyMotion#WBW(0, 1)
nnoremap <silent> ,,B :call EasyMotion#WBW(0, 1)
map ,pt :set invpaste
noremap ,u hgUiwe
noremap ,tcd :call ClearDb()
noremap ,pl :call PushLarge()
noremap ,py :call PushYlzhao()
vnoremap ,p :call EchoSelectionLines()
noremap ,m :make
noremap ,cd :call CdToProjectRoot()
map ,wp :call SwitchToProject("PROVIDER")
map ,wr :call SwitchToProject("RES")
map ,wf :call SwitchToProject("FRA")
map ,wh :call SwitchToProject("CALL_HISTORY")
map ,wc :call SwitchToProject("CONTACTS")
map <silent> ,bt :!ctags -R --exclude=\.* 
noremap ,vcs :e res/values-zh-rCN/strings.xml
noremap ,ves :e res/values/strings.xml
noremap ,di :call DebugInnerOuterContacts()
noremap ,dd :call DebugInnerOuterContacts()
noremap ,tc :!adb_connect
noremap ,tr :!adb shell stop; sleep 2; adb shell start
map ,z <Plug>ZoomWin
noremap <silent> ,bc :!find . -name *.java > cscope.files && cscope -b -q
noremap ,ts :!target_sync
map ,s :so ~/.vimrc
map ,v :e ~/.vimrc
map <silent> ,vp :!xdg-open %
map ,ac :!adb_connect && pactive $TARGET
map ,al :!adb_connect&&adb logcat
map ,vxs :sp ~/.vim/snippets/xml.snippets
map ,vjs :sp ~/.vim/snippets/java.snippets
nmap ,rr :call ReloadSnippets(snippets_dir, &filetype)
nmap ,et :exec "e ~/.vim/ftplugin/".&filetype.".vim"
nmap ,es :call EditSnippet()
map ,y :YRShow
map ,s? z=
map ,sa zg
map ,sp [
map ,sn ]
map ,q :e ~/buffer
nmap ,fu :se ff=unix
nmap ,fd :se ff=dos
map ,$ :syntax sync fromstart
map ,4 :set ft=javascript
map ,3 :set syntax=python
map ,2 :set syntax=xhtml
map ,1 :set syntax=cheetah
nmap ,w :w!
nmap ,x :xa!
map 0 ^
xmap S <Plug>VSurround
snoremap U b<BS>U
vmap [% [%m'gv``
snoremap \ b<BS>\
vmap ]% ]%m'gv``
snoremap ^ b<BS>^
snoremap ` b<BS>`
vmap a% [%v]%
nmap cs <Plug>Csurround
nmap ds <Plug>Dsurround
nmap gx <Plug>NetrwBrowseX
xmap gS <Plug>VgSurround
nmap ySS <Plug>YSsurround
nmap ySs <Plug>YSsurround
nmap yss <Plug>Yssurround
nmap yS <Plug>YSurround
nmap ys <Plug>Ysurround
snoremap <Left> bi
snoremap <Right> a
snoremap <BS> b<BS>
snoremap <silent> <S-Tab> i<Right>=BackwardsSnippet()
nnoremap <silent> <Plug>NetrwBrowseX :call netrw#NetrwBrowseX(expand("<cWORD>"),0)
nnoremap <silent> <Plug>CVSWatchRemove :CVSWatch remove
nnoremap <silent> <Plug>CVSWatchOn :CVSWatch on
nnoremap <silent> <Plug>CVSWatchOff :CVSWatch off
nnoremap <silent> <Plug>CVSWatchAdd :CVSWatch add
nnoremap <silent> <Plug>CVSWatchers :CVSWatchers
nnoremap <silent> <Plug>CVSUnedit :CVSUnedit
nnoremap <silent> <Plug>CVSEditors :CVSEditors
nnoremap <silent> <Plug>CVSEdit :CVSEdit
nnoremap <silent> <Plug>VCSVimDiff :VCSVimDiff
nnoremap <silent> <Plug>VCSUpdate :VCSUpdate
nnoremap <silent> <Plug>VCSUnlock :VCSUnlock
nnoremap <silent> <Plug>VCSStatus :VCSStatus
nnoremap <silent> <Plug>VCSSplitAnnotate :VCSAnnotate!
nnoremap <silent> <Plug>VCSReview :VCSReview
nnoremap <silent> <Plug>VCSRevert :VCSRevert
nnoremap <silent> <Plug>VCSLog :VCSLog
nnoremap <silent> <Plug>VCSLock :VCSLock
nnoremap <silent> <Plug>VCSInfo :VCSInfo
nnoremap <silent> <Plug>VCSClearAndGotoOriginal :VCSGotoOriginal!
nnoremap <silent> <Plug>VCSGotoOriginal :VCSGotoOriginal
nnoremap <silent> <Plug>VCSDiff :VCSDiff
nnoremap <silent> <Plug>VCSDelete :VCSDelete
nnoremap <silent> <Plug>VCSCommit :VCSCommit
nnoremap <silent> <Plug>VCSAnnotate :VCSAnnotate
nnoremap <silent> <Plug>VCSAdd :VCSAdd
nmap <Nul><Nul>d :vert scs find d =expand("<cword>")
nmap <Nul><Nul>i :vert scs find i ^=expand("<cfile>")$	
nmap <Nul><Nul>f :vert scs find f =expand("<cfile>")	
nmap <Nul><Nul>e :vert scs find e =expand("<cword>")
nmap <Nul><Nul>t :vert scs find t =expand("<cword>")
nmap <Nul><Nul>c :vert scs find c =expand("<cword>")
nmap <Nul><Nul>g :vert scs find g =expand("<cword>")
nmap <Nul><Nul>s :vert scs find s =expand("<cword>")
nmap <Nul>d :scs find d =expand("<cword>")	
nmap <Nul>i :scs find i ^=expand("<cfile>")$	
nmap <Nul>f :scs find f =expand("<cfile>")	
nmap <Nul>e :scs find e =expand("<cword>")	
nmap <Nul>t :scs find t =expand("<cword>")	
nmap <Nul>c :scs find c =expand("<cword>")	
nmap <Nul>g :scs find g =expand("<cword>")	
nmap <Nul>s :scs find s =expand("<cword>")	
nnoremap <silent> <Plug>CalendarH :cal Calendar(1)
nnoremap <silent> <Plug>CalendarV :cal Calendar(0)
xnoremap <silent> <Plug>NERDCommenterUncomment :call NERDComment("x", "Uncomment")
nnoremap <silent> <Plug>NERDCommenterUncomment :call NERDComment("n", "Uncomment")
xnoremap <silent> <Plug>NERDCommenterAlignBoth :call NERDComment("x", "AlignBoth")
nnoremap <silent> <Plug>NERDCommenterAlignBoth :call NERDComment("n", "AlignBoth")
xnoremap <silent> <Plug>NERDCommenterAlignLeft :call NERDComment("x", "AlignLeft")
nnoremap <silent> <Plug>NERDCommenterAlignLeft :call NERDComment("n", "AlignLeft")
nnoremap <silent> <Plug>NERDCommenterAppend :call NERDComment("n", "Append")
xnoremap <silent> <Plug>NERDCommenterYank :call NERDComment("x", "Yank")
nnoremap <silent> <Plug>NERDCommenterYank :call NERDComment("n", "Yank")
xnoremap <silent> <Plug>NERDCommenterSexy :call NERDComment("x", "Sexy")
nnoremap <silent> <Plug>NERDCommenterSexy :call NERDComment("n", "Sexy")
xnoremap <silent> <Plug>NERDCommenterInvert :call NERDComment("x", "Invert")
nnoremap <silent> <Plug>NERDCommenterInvert :call NERDComment("n", "Invert")
nnoremap <silent> <Plug>NERDCommenterToEOL :call NERDComment("n", "ToEOL")
xnoremap <silent> <Plug>NERDCommenterNested :call NERDComment("x", "Nested")
nnoremap <silent> <Plug>NERDCommenterNested :call NERDComment("n", "Nested")
xnoremap <silent> <Plug>NERDCommenterMinimal :call NERDComment("x", "Minimal")
nnoremap <silent> <Plug>NERDCommenterMinimal :call NERDComment("n", "Minimal")
xnoremap <silent> <Plug>NERDCommenterToggle :call NERDComment("x", "Toggle")
nnoremap <silent> <Plug>NERDCommenterToggle :call NERDComment("n", "Toggle")
xnoremap <silent> <Plug>NERDCommenterComment :call NERDComment("x", "Comment")
nnoremap <silent> <Plug>NERDCommenterComment :call NERDComment("n", "Comment")
nnoremap <silent> <Plug>SurroundRepeat .
noremap <F2> :NERDTreeToggle
noremap <F3> :NumbersToggle
map <F9> ggVGg?
cnoremap  <Home>
cnoremap  <End>
imap S <Plug>ISurround
imap s <Plug>Isurround
inoremap <silent> 	 =TriggerSnippet()
cnoremap  
imap  <Plug>SuperTabForward
imap  <Plug>SuperTabBackward
inoremap <silent> 	 =ShowAvailableSnips()
imap  <Plug>Isurround
inoremap $c /** **/O
cnoremap $td tabnew ~/Desktop/
cnoremap $th tabnew ~/
vmap ë :m'<-2`>my`<mzgv`yo`z
vmap ê :m'>+`<my`>mzgv`yo`z
nmap ë mz:m-2`z
nmap ê mz:m+`z
cabbr <expr> %$ expand('%:t:r')
cabbr <expr> %% expand('%:h')
iabbr xdate =strftime("%d/%m/%y %H:%M:%S")
let &cpo=s:cpo_save
unlet s:cpo_save
set ambiwidth=double
set autoindent
set autoread
set autowrite
set background=dark
set backspace=2
set cindent
set cinoptions=l1
set cmdheight=2
set cscopeprg=/usr/bin/cscope
set cscopeverbose
set errorformat=%Dmake:\ Entering\ directory\ `%f',%f:%l:%m,%Xmake:\ Leaving\ directory\ `%f'
set expandtab
set fileencodings=ucs-bom,utf-8,cp936,big5,euc-jp,euc-kr,latin1
set formatoptions=tcql
set guicursor=n-v-c:block,o:hor50,i-ci:hor15,r-cr:hor30,sm:block,a:blinkon0
set helplang=en
set hidden
set ignorecase
set incsearch
set laststatus=2
set lazyredraw
set matchtime=8
set mouse=a
set path=.,/usr/include,,,res/layout,res/layout-finger,res/values,res/drawable,res/drawable-mdpi,jni,~/cvs_repo/android_phone/android/android2.3.5/dalvik/libnativehelper/include/nativehelper,~/cvs_repo/android_phone/android/android2.3.5/frameworks/base/native/include/android
set ruler
set runtimepath=~/.vim/bundle/vundle,~/.vim/bundle/vim-fugitive,~/.vim/bundle/vim-easymotion,~/.vim/bundle/sparkup/vim/,~/.vim/bundle/vim-rails,~/.vim/bundle/L9,~/.vim/bundle/FuzzyFinder,~/.vim/bundle/command-t,~/.vim/bundle/vim-powerline,~/.vim/bundle/vim-surround,~/.vim/bundle/Conque-Shell,~/.vim/bundle/tabular,~/.vim/bundle/nerdcommenter,~/.vim,/usr/share/vim/vimfiles,/usr/share/vim/vim73,/usr/share/vim/vimfiles/after,~/.vim/after,~/.vim/bundle/vundle/,~/.vim/bundle/vundle/after,~/.vim/bundle/vim-fugitive/after,~/.vim/bundle/vim-easymotion/after,~/.vim/bundle/sparkup/vim//after,~/.vim/bundle/vim-rails/after,~/.vim/bundle/L9/after,~/.vim/bundle/FuzzyFinder/after,~/.vim/bundle/command-t/after,~/.vim/bundle/vim-powerline/after,~/.vim/bundle/vim-surround/after,~/.vim/bundle/Conque-Shell/after,~/.vim/bundle/tabular/after,~/.vim/bundle/nerdcommenter/after
set scrolloff=7
set sessionoptions=options
set shell=bash\ -l
set shiftwidth=4
set showmatch
set smartcase
set smartindent
set smarttab
set softtabstop=4
set statusline=%02n:%<%f\ %h%m%r%=%-14.(%l,%c%V%)\ %P
set suffixes=.bak,~,.o,.h,.info,.swp,.obj,.class
set suffixesadd=.java,.xml,.9.png,.png,.xml,.png,.9.png
set noswapfile
set tabline=%!TabCaptionLineFunction()
set termencoding=utf-8
set wildmenu
set nowritebackup
let s:so_save = &so | let s:siso_save = &siso | set so=0 siso=0
let v:this_session=expand("<sfile>:p")
silent only
if expand('%') == '' && !&modified && line('$') <= 1 && getline(1) == ''
  let s:wipebuf = bufnr('%')
endif
set shortmess=aoO
badd +24 ~/workspace_tb/Android_Texun99/jni/linked_nodes.c
silent! argdel *
edit ~/workspace_tb/Android_Texun99/jni/linked_nodes.c
set splitbelow splitright
set nosplitbelow
set nosplitright
wincmd t
set winheight=1 winwidth=1
argglobal
setlocal keymap=
setlocal noarabic
setlocal autoindent
setlocal nobinary
setlocal bufhidden=
setlocal buflisted
setlocal buftype=
setlocal cindent
setlocal cinkeys=0{,0},0),:,0#,!^F,o,O,e
setlocal cinoptions=l1
setlocal cinwords=if,else,while,do,for,switch
setlocal colorcolumn=
setlocal comments=sO:*\ -,mO:*\ \ ,exO:*/,s1:/*,mb:*,ex:*/,://
setlocal commentstring=/*%s*/
setlocal complete=.,w,b,u,t,i
setlocal concealcursor=
setlocal conceallevel=0
setlocal completefunc=
setlocal nocopyindent
setlocal cryptmethod=
setlocal nocursorbind
setlocal nocursorcolumn
setlocal nocursorline
setlocal define=
setlocal dictionary=
setlocal nodiff
setlocal equalprg=
setlocal errorformat=
setlocal expandtab
if &filetype != 'c'
setlocal filetype=c
endif
setlocal foldcolumn=0
setlocal foldenable
setlocal foldexpr=0
setlocal foldignore=#
setlocal foldlevel=0
setlocal foldmarker={{{,}}}
setlocal foldmethod=manual
setlocal foldminlines=1
setlocal foldnestmax=20
setlocal foldtext=foldtext()
setlocal formatexpr=
setlocal formatoptions=croql
setlocal formatlistpat=^\\s*\\d\\+[\\]:.)}\\t\ ]\\s*
setlocal grepprg=
setlocal iminsert=0
setlocal imsearch=0
setlocal include=
setlocal includeexpr=
setlocal indentexpr=
setlocal indentkeys=0{,0},:,0#,!^F,o,O,e
setlocal noinfercase
setlocal iskeyword=@,48-57,_,192-255
setlocal keywordprg=
set linebreak
setlocal linebreak
setlocal nolisp
setlocal nolist
setlocal makeprg=
setlocal matchpairs=(:),{:},[:]
setlocal modeline
setlocal modifiable
setlocal nrformats=octal,hex
set number
setlocal number
setlocal numberwidth=4
setlocal omnifunc=ccomplete#Complete
setlocal path=
setlocal nopreserveindent
setlocal nopreviewwindow
setlocal quoteescape=\\
setlocal noreadonly
setlocal norelativenumber
setlocal norightleft
setlocal rightleftcmd=search
setlocal noscrollbind
setlocal shiftwidth=4
setlocal noshortname
setlocal smartindent
setlocal softtabstop=4
setlocal nospell
setlocal spellcapcheck=[.?!]\\_[\\])'\"\	\ ]\\+
setlocal spellfile=
setlocal spelllang=en
setlocal statusline=%!Pl#Statusline(0,1)
setlocal suffixesadd=.java,.xml,.9.png,.png,.xml,.png,.9.png
setlocal noswapfile
setlocal synmaxcol=3000
if &syntax != 'c'
setlocal syntax=c
endif
setlocal tabstop=8
setlocal tags=~/workspace_tb/Android_Texun99/.git/c.tags,~/workspace_tb/Android_Texun99/.git/tags,./tags,./TAGS,tags,TAGS
setlocal textwidth=0
setlocal thesaurus=
setlocal noundofile
setlocal nowinfixheight
setlocal nowinfixwidth
setlocal wrap
setlocal wrapmargin=0
let s:l = 14 - ((13 * winheight(0) + 24) / 49)
if s:l < 1 | let s:l = 1 | endif
exe s:l
normal! zt
14
normal! 04l
lcd ~/workspace_tb/Android_Texun99
if exists('s:wipebuf')
  silent exe 'bwipe ' . s:wipebuf
endif
unlet! s:wipebuf
set winheight=1 winwidth=20 shortmess=filnxtToO
let s:sx = expand("<sfile>:p:r")."x.vim"
if file_readable(s:sx)
  exe "source " . fnameescape(s:sx)
endif
let &so = s:so_save | let &siso = s:siso_save
doautoall SessionLoadPost
unlet SessionLoad
" vim: set ft=vim :
