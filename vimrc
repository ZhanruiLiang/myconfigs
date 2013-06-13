" All system-wide defaults are set in $VIMRUNTIME/debian.vim (usually just
" /usr/share/vim/vimcurrent/debian.vim) and sourced by the call to :runtime
" you can find below.  If you wish to change any of those settings, you should
" do it in this file (/etc/vim/vimrc), since debian.vim will be overwritten
" everytime an upgrade of the vim packages is performed.  It is recommended to
" make changes after sourcing debian.vim since it alters the value of the
" 'compatible' option.

" This line should not be removed as it ensures that various options are
" properly set to work with the Vim-related packages available in Debian.
runtime! debian.vim

" Uncomment the next line to make Vim more Vi-compatible
" NOTE: debian.vim sets 'nocompatible'.  Setting 'compatible' changes numerous
" options, so any other options should be set AFTER setting 'compatible'.
"set compatible

" Vim5 and later versions support syntax highlighting. Uncommenting the
" following enables syntax highlighting by default.
if has("syntax")
  syntax on
endif

" If using a dark background within the editing area and syntax highlighting
" turn on this option as well
set background=dark

" Uncomment the following to have Vim jump to the last position when
" reopening a file
if has("autocmd")
  au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
endif

" Uncomment the following to have Vim load indentation rules and plugins
" according to the detected filetype.
if has("autocmd")
  filetype plugin indent on
endif

" The following are commented out as they cause vim to behave a lot
" differently from regular Vi. They are highly recommended though.
set showcmd		" Show (partial) command in status line.
set showmatch		" Show matching brackets.
set ignorecase		" Do case insensitive matching
set smartcase		" Do smart case matching
set incsearch		" Incremental search
"set autowrite		" Automatically save before commands like :next and :make
set hidden             " Hide buffers when they are abandoned
set mouse=v		" Enable mouse usage (all modes)

" Source a global configuration file if available
if filereadable("/etc/vim/vimrc.local")
  source /etc/vim/vimrc.local
endif

set autoindent
set nocp
filetype plugin on
set tags+=/usr/include/c++/4.4.3/tags
set tags+=/usr/include/c++/4.4.3/bits/tags
set tags+=/home/ray/cpp/tags
let OmniCpp_NamespaceSearch = 1
let OmniCpp_DisplayMode = 0
let OmniCpp_MayCompleteScope = 1
map <C-F12> :!ctags -R --c++-kinds=+p --fields=+iaS --extra=+q .<CR>

set shiftwidth=4
set tabstop=4
set expandtab
set nu
set cindent
"python indent
let g:pyindent_open_paren = '&sw * 2'
let g:pyindent_nested_paren = '&sw'
let g:pyindent_continue = '&sw * 2'
" python auto complete
let g:pydiction_location ='/home/ray/.vim/pycomplete/complete-dict'
" autocmd Filetype py set foldmethod=indent
" autocmd Filetype py set foldlevel=99
"fold
" set foldmethod=manual
"NERDtree
let loaded_nerd_tree=1
let NERDChristmasTree=1
let NERDTreeIgnore=['\.png','\.pdf','\~$']
"clang
" let g:clang_complete_copen=1
"let g:clang_periodic_quickfix=1
" map <F4> :call g:ClangUpdateQuickFix()<Cr>


set sidescroll=2
set nowrap

" map <F3> a<CR>{<CR>}<Esc>O
map <S-Tab> <Esc>:tabedit<Cr>
map <A-j> gj
map <A-k> gk
map <A-m> :%s//\r/g
" setlocal omnifunc=javacomplete#Complete
"if has("autocmd")
"	autocmd Filetype java setlocal omnifunc=javacomplete#Complete
"endif
"let g:java_classpath='.;/usr/local/jre1.6.0_22/lib/'

"latex stuff
set grepprg=grep\ -nH\ $*
let g:tex_flavor='latex'
"set iskeyword+=:
"

"vimplate
let Vimplate = "/home/ray/.vim/vimplate"

"use Man in vim
runtime! ftplugin/man.vim

set viminfo='100,f1

"vim sokoban
let g:SokobanLevelDirectory='/home/ray/.vim/plugin/VimSokoban/'


map <F7> <F1>
let g:netrw_keepdir           = 0
let g:netrw_list_hide         = '\v^\..*\.swp$|^\.swp$|^.+\.pyc$'
let g:netrw_preview = 1

" HTML indent in .vim/indent/html.vim
" let g:html_indent_inctags = "html,body,head,tbody,h1,h2,h3,p,script"

" " HTML (tab width 2 chr, no wrapping)
" autocmd FileType html set sw=2
" autocmd FileType html set ts=2
" autocmd FileType html set sts=2
" autocmd FileType html set textwidth=0
" " XHTML (tab width 2 chr, no wrapping)
" autocmd FileType xhtml set sw=2
" autocmd FileType xhtml set ts=2
" autocmd FileType xhtml set sts=2
" autocmd FileType xhtml set textwidth=0
" " CSS (tab width 2 chr, wrap at 79th char)
" autocmd FileType css set sw=2
" autocmd FileType css set ts=2
" autocmd FileType css set sts=2
let g:vimim_cloud = 'sogou,google,baidu,qq'  
let g:vimim_map = 'tab_as_gi'  
let g:vimim_mode = 'dynamic'  
let g:vimim_mycloud = 0  
let g:vimim_plugin = '/home/ray/.vim/plugin'  
let g:vimim_punctuation = 2  
let g:vimim_shuangpin = 0  
let g:vimim_toggle = 'sogou,google,baidu,qq' 

let g:neocomplcache_enable_at_startup = 0 

" Evoke a web browser
function! Browser ()
  let line0 = getline (".")
  let line = matchstr (line0, "http[^ ]*")
  :if line==""
  let line = matchstr (line0, "ftp[^ ]*")
  :endif
  :if line==""
  let line = matchstr (line0, "file[^ ]*")
  :endif
  let line = escape (line, "#?&;|%")
  " echo line
  exec ":silent !mozilla ".line
endfunction
map gx :call Browser ()<CR>
map zp :source ~/.vim/plugin/jpythonfold.vim<CR>
" Uncomment next line to disable CSApprox
" let g:CSApprox_loaded = 1
if &term =~ '^\(xterm\|screen\)$' 
  set t_Co=256
endif

" colo darkZ
" colo eclipse
colo 256-jungle
" colo fruit
" colo autumn
" colo freya

" nnoremap <F3> "=strftime("%c")<CR>P

" miniBufExpl
let g:miniBufExplMapWindowNavVim = 1
let g:miniBufExplMapWindowNavArrows = 1
let g:miniBufExplMapCTabSwitchBufs = 1
let g:miniBufExplModSelTarget = 1 

" ConqueTerm
cnoremap cq ConqueTermVSplit 
let g:ConqueTerm_ReadUnfocused = 1
let g:ConqueTerm_CloseOnEnd = 1
let g:ConqueTerm_StartMessages = 1
let g:ConqueTerm_Syntax = 'bash'

" MRU
let MRU_Max_Entries = 300

" tagbar
let loaded_setcolors = 1
nmap <F8> :TagbarToggle<CR>
let g:tagbar_left = 1
let g:tagbar_width = 35

set wildignore=*.o,*~,*.pyc,tags,*.hi

set hls
" auto chdir
autocmd BufEnter * if expand("%:p:h") !~ '^/tmp' | silent! lcd %:p:h | endif
com! Cpptemp :0r ~/cpp/template.cpp
" nnoremap gy :!cat % | xsel -b
com! Copy :!cat % | xsel -b

com! Pygame :0r ~/python/template_pygame.py

" sudo write
command W w !sudo tee % > /dev/null

" vb.net
autocmd BufNewFile,BufRead *.vb set ft=vbnet

" haskell
" au Bufenter *.hs compiler ghc
let g:haddock_browser='/usr/bin/firefox'
let g:haddock_indexfiledir="~/.vim/haddock_cache/"

" insert date
inoremap <F5> <C-R>=strftime("%c")<CR>
" set scrolloff=1000
nmap <space> zt

" rebuild tags
" nmap ,t :!(cd %:p:h; ctags *.[ch])&

au BufNewFile,BufRead [Ss][cC]onstruct set filetype=python
au BufNewFile,BufRead *.cpp nmap <F5> :!./a < %:r.in <CR>
au BufNewFile,BufRead *.cpp nmap <F6> :!g++ % -o a -g -Wall -DDEBUG<CR>
au BufNewFile,BufRead *.cpp nmap <F7> :!g++ % -o a -O3 -DNDEBUG<CR>

if filereadable("./.vimrcl")
    source ./.vimrcl
endif

command AddUTF8 :0r ~/.vim/utf-8-line.py
" yaml 
autocmd BufNewFile,BufRead *.yaml imap - - 
autocmd BufNewFile,BufRead *.m setl filetype=mma
" coffee
autocmd BufNewFile,BufRead *.coffee set sw=2
autocmd BufNewFile,BufRead *.coffee set tabstop=2
" haskell
autocmd BufNewFile,BufRead *.hs set sw=2
autocmd BufNewFile,BufRead *.hs set tabstop=2

execute pathogen#infect()
set cursorline
