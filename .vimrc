"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Based On:
" 	Amir Salihefendic's .vimrc version 5.0 -29/05/12 15:43:36
" 	
" Modifier:
" 	Liu Yang
" 	JeremyRobturtle@gmail.com
"
" Blog_post:
" 	http://amix.dk/blog/post/19691#The-ultimate-Vim-configuration-on-Github 
" Awesome_version:
" 	https://github.com/amix/vimrc
"
" Sections:
" 	-> General
" 	-> VIM user interface
" 	-> Colors and Fonts
" 	-> Files and backups
"	-> Text, tab and indent related
"	-> Visual mode related
"	-> Moving around, tabs and buffers
"	-> Status line
"	-> Editing mappings
"	-> vimgrep searching and cope displaying
"	-> Spell checking
"	-> Misc
"	-> Helper functions
"	-> Plugins configurations
"	-> C/C++ compiling, debugging related
"	-> vimrc facilities
"
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"""""""""""""""""""""""""""""""""""
" => General
"""""""""""""""""""""""""""""""""""
" Set utf8 as standard encoding and en_US as the standard language
set encoding=utf8
" Sets how many lines of history VIM has to remember
set history=700
" Enable filetype plugins
filetype plugin indent on
" Set to auto read when a file is changed from the outside
set autoread
" With a map leader it's possible to do extra key combinations
" like <leader>w saves the current file
let mapleader = ","
let g:mapleader = ","
" Fast saving
nmap <leader>w :w!<cr>
" Fast quit
nmap <leader>q :q<cr>
" Default path
set path+=.,..,/usr/include/,~/projects/include

"""""""""""""""""""""""""""""""""""
" => VIM user interface
"""""""""""""""""""""""""""""""""""
" Set lines to the cursor - when moving vertically using j/k
set so=7
" Turn on the Wild menu
set wildmenu

" Ignore compiled files
set wildignore=*.o,*~,*.pyc,*.bin,#*#
if has("win16") || has("win32")
	set wildignore+=*/.git/*,*/.hg/*,*/.svn/*,*/.DS_Store
else
	set wildignore+=.git\*,.hg\*,.svn\*
endif

"Always show current position
set ruler

" A buffer becomes hidden when it is abandoned
set hid
" Configure backspaces so it acts as it should act
set backspace=eol,start,indent
set whichwrap+=<,>,h,l
" Ignore case when searching
set ignorecase
" When searching try to be smart about cases
set smartcase
" Highlight search results
set hlsearch
" Makes search act like search in modern browsers
set incsearch
" For regular expressions turn magic on
set magic
" Show matching brackets when text indicator is over them
set showmatch
" How many tenths of a second to blink when matching brackets
set mat=2
" No annoying sound on errors
set noerrorbells
set novisualbell
set t_vb=
set tm=500
" Set line's number
set nu

"""""""""""""""""""""""""""""""""""
" => Colors and Fonts
"""""""""""""""""""""""""""""""""""
" Enable syntax highlighting
syntax enable

try
	colorscheme desert
catch
endtry

set background=dark

" Set extra options when running in GUI mode
if has("gui_running")
	set guioptions-=T
	set guioptions+=e
	set t_Co=256
	set guitablabel=%M\ %t
endif

" Use Unix as the standard file type
set ffs=unix,dos,mac

"""""""""""""""""""""""""""""""""""
" => Files, backups and undo
"""""""""""""""""""""""""""""""""""
" Turn backup off, since most stuff is in SVN, git etc anyway
set nobackup
set nowb
set noswapfile

" Markdown format
au BufNewFile,BufRead *.md set ft=md
" CMakeLists.txt as cmake type
au BufRead,BufNewFile CMakeLists.txt        set filetype=cmake
" Add *.txt to text filetype
au BufRead,BufNewFile *.txt        setfiletype text

"""""""""""""""""""""""""""""""""""
" => Text, tab and indent related
"""""""""""""""""""""""""""""""""""
" Use spaces instead of tabs
autocmd filetype text set expandtab

" Be smart when using tabs ;)
set smarttab
" 1 tab == 4 spaces
set shiftwidth=4
set tabstop=4
autocmd Filetype java set tabstop=4
autocmd Filetype java set shiftwidth=4
" Linebreak on 500 characters
set lbr
set tw=500
set ai "Auto indent
set si "Smart indent
set wrap "Wrap lines

"""""""""""""""""""""""""""""""""""
" => Moving around, tabs, windows and buffers
"""""""""""""""""""""""""""""""""""
" Treat long lines as break lines (useful when moving around in them!)
map j gj
map k gk
" Disable hightlight when <leader><cr> is pressed
map <silent> <leader><cr> :noh<cr>
" Map <space> to do shell cmd
map <space> :!
" Smart way to move between windows
map <C-j> <C-W>j
map <C-k> <C-W>k
map <C-h> <C-W>h
map <C-l> <C-W>l
map th <C-Pageup>
map tl <C-Pagedown>
" Close current buffers
map <leader>bd :Bdelete<cr>
" Close all the buffers
map <leader>ba :1,1000 bd!<cr>
" Useful mapping for managing tabs
map <leader>tn :tabnew<cr>
map <leader>to :tabonly<cr>
map <leader>tc :tabclose<cr>
map <leader>tm :tabmove
" Opens a new tab with the current buffer's path
" Super useful when editing files in the same directory
map <leader>te :tabedit <c-r>=expand("%:p:h")<cr>
" Switch CWD to the directory of the open buffer
map <leader>cd :cd %:p:h<cr>:pwd<cr>
" Specify the behavior when switching between buffers
try
	set switchbuf=useopen,usetab,newtab
	set stal=2
catch
endtry
" Return to last edit position when opening files (You want this!)
autocmd BufReadPost *
	\ if line("'\"") > 0 && line("'\"") <= line("$") |
	\ exe "normal! g`\"" |
	\ endif

" Remember info about open buffers on close
set viminfo^=%

""""""""""""""""""""""""""""""
" => Status line
""""""""""""""""""""""""""""""
" Always show the status line
set laststatus=2

" Format the status line
set statusline=\ %{HasPaste()}%F%m%r%h\ %w\ \ CWD:\ %r%{getcwd()}%h\ \ \ Line:\ %l

"""""""""""""""""""""""""""""""""""
" => Editing mappings
"""""""""""""""""""""""""""""""""""
" Delete trailing white space on save, useful for Python and CoffeeScript ;)
func! DeleteTrailingWS()
	exe "normal mz"
	%s/\s\+$//ge
	exe "normal `z"
endfunc
autocmd BufWrite *.py :call DeleteTrailingWS()
autocmd BufWrite *.coffee :call DeleteTrailingWS()

" next/previous msg on copen
map <leader>n :cn<cr>
map <leader>p :cp<cr>

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => vimgrep searching and cope displaying
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" When you press gv you vimgrep after the selected text
vnoremap <silent>gv :call VisualSelection('gv', '')<CR>

" Open vimgrep and put the cursor in the right position
map <leader>g :vimgrep // **/*.*<left><left><left><left><left><left><left><left>

" Vimgreps in the current file
map <leader><space> :vimgrep // <C-R>%<C-A><right><right><right><right><right><right><right><right><right>

" When you press <leader>r you can search and replace the selected text
vnoremap <silent><leader>r :call VisualSelection('replace', '')<CR>

" Do :help cope if you are unsure what cope is. It's super useful!
"
" When you search with vimgrep, display your results in cope by doing:
"   <leader>cc
"
" To go to the next search result do:
"   <leader>n
"
" To go to the previous search results do:
"   <leader>p
"
map <leader>cc :botright cope<cr>
map <leader>co ggVGy:tabnew<cr>:set syntax=qf<cr>pgg
map <leader>n :cn<cr>
map <leader>p :cp<cr>

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Spell checking
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Pressing ,ss will toggle and untoggle spell checking
map <leader>ss :setlocal spell!<cr>

" Shortcuts using <leader>
map <leader>sn ]s
map <leader>sp [s
map <leader>sa zg
map <leader>s? z=

"""""""""""""""""""""""""""""""""""
" => Misc
"""""""""""""""""""""""""""""""""""
" Remove the Windows ^M - when the encodings gets messed up
noremap <leader>m mmHmt:%S/<C-V><cr>//ge<cr>'tzt'm
" Toggle paste mode on and off
map <leader>pp :setlocal paste!<cr>

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Helper functions
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
function! CmdLine(str)
    exe "menu Foo.Bar :" . a:str
    emenu Foo.Bar
    unmenu Foo
endfunction 

function! VisualSelection(direction, extra_filter) range
    let l:saved_reg = @"
    execute "normal! vgvy"

    let l:pattern = escape(@", '\\/.*$^~[]')
    let l:pattern = substitute(l:pattern, "\n$", "", "")

    if a:direction == 'b'
        execute "normal ?" . l:pattern . "^M"
    elseif a:direction == 'gv'
        call CmdLine("vimgrep " . '/'. l:pattern . '/' . ' **/*.*' . a:extra_filter)
    elseif a:direction == 'replace'
        call CmdLine("%s" . '/'. l:pattern . '/')
    elseif a:direction == 'f'
        execute "normal /" . l:pattern . "^M"
    endif

    let @/ = l:pattern
    let @" = l:saved_reg
endfunction


" Returns true if paste mode is enabled
function! HasPaste()
    if &paste
        return 'PASTE MODE  '
    en
    return ''
endfunction

" Don't close window, when deleting a buffer
command! Bclose call <SID>BufcloseCloseIt()
function! <SID>BufcloseCloseIt()
   let l:currentBufNum = bufnr("%")
   let l:alternateBufNum = bufnr("#")

   if buflisted(l:alternateBufNum)
     buffer #
   else
     bnext
   endif

   if bufnr("%") == l:currentBufNum
     new
   endif

   if buflisted(l:currentBufNum)
     execute("bdelete! ".l:currentBufNum)
   endif
endfunction
"""""""""""""""""""""""""""""""""""
" => Plugins configurations
"""""""""""""""""""""""""""""""""""
" DoxygenToolkit settings
map fg : Dox<cr>
let g:DoxygenToolkit_authorName="Liu Yang, JeremyRobturtle@gmail.com"
let s:licenseTag="License: GNU Public License"
"let g:DoxygenToolkit_licenseTag=s:licenseTag
let g:DoxygenToolkit_undocTag="DOXIGEN_SKIP_BLOCK"
let g:DoxygenToolkit_compactOneLineDoc="yes"
"let g:DoxygenToolkit_commentType="C++"
let g:DoxygenToolkit_briefTag_pre="@brief\t"
"let g:DoxygenToolkit_paramTag_pre="@param\t"
let g:DoxygenToolkit_returnTag="@return\t"
let g:DoxygenToolkit_briefTag_funcName="no"
let g:DoxygenToolkit_maxFunctionProtoLines=30
"let g:DoxygenToolkit_briefTag_post="<++>"

" winManager
let g:winManagerWindowLayout="FileExplorer,BufExplorer,TagList"
let g:winManagerWidth=30
let g:defaultExplorer=0
nmap wm :WMToggle<cr>

" omnicppcomplete
set nocp
let OmniCpp_NamespaceSearch = 2
let OmniCpp_GlobalScopeSearch = 1
let OmniCpp_ShowAccess = 1
let OmniCpp_ShowPrototypeInAbbr = 1
let OmniCpp_MayCompleteDot = 1
let OmniCpp_MayCompleteArrow = 1
let OmniCpp_MayCompleteScope = 1
let OmniCpp_LocalSearchDecl = 1
" if you want complete 3rd-party namespace, fill its name below
let OmniCpp_DefaultNamespaces = ["std", "_GLIBCXX_STD"]
" auto close complete window
au CursorMovedI,InsertLeave * if pumvisible() == 0|silent! pclose|endif
set completeopt=menuone,menu,longest
" highlight complete menu
highlight Pmenu guibg=darkgrey guifg=black
highlight PmenuSel guibg=lightgrey guifg=black

" Make cscope database
"Enhance tags searching eara
nmap tn :tnext<cr>
nmap tp :tprevious<cr>
"set tags+=./tags,./../tags,,./**/tags,/usr/include/tags,/usr/local/include/tags
map <F5> :call Do_CsTag()<CR>
"nmap ys :cs find s <C-R>=expand("<cword>")<CR><CR>
"nmap yg :cs find g <C-R>=expand("<cword>")<CR><CR>
"nmap yc :cs find c <C-R>=expand("<cword>")<CR><CR>
"nmap yt :cs find t <C-R>=expand("<cword>")<CR><CR>
"nmap ye :cs find e <C-R>=expand("<cword>")<CR><CR>
"nmap yf :cs find f <C-R>=expand("<cfile>")<CR><CR>
"nmap yi :cs find i ^<C-R>=expand("<cfile>")<CR><CR>
"nmap yd :cs find d <C-R>=expand("<cword>")<CR><CR>
function! Do_CsTag()
	let dir=getcwd()
	if filereadable("tags")
		if(g:iswindows==1)
			let tagsdeleted=delete(dir."\\"."tags")
		else
			let tagsdeleted=delete("./"."tags")
		endif
		if(tagsdeleted!=0)
			echohl WarningMsg | echo "Fail to do tags! Cannot delete tags." | echohl None
			return
		endif
	endif
	if has("cscope")
		silent! execute "cs kill -l"
	endif
	if filereadable("cscope.files")
		if(g:iswindows==1)
			let csfilesdeleted=delete(dir."\\"."cscope.files")
		else
			let csfilesdeleted=delete("./"."cscope.files")
		endif
		if(csfilesdeleted!=0)
			echohl WarningMsg | echo "Fail to do cscope! Cannot delete cscope.files." | echohl None
			return
		endif
	endif
	if filereadable(".cscope.out")
		if(g:iswindows==1)
			let csoutdeleted=delete(dir."\\".".cscope.out")
		else
			let csoutdeleted=delete("./".".cscope.out")
		endif
		if(csoutdeleted!=0)
			echohl WarningMsg | echo "Fail to do cscope! Cannot delete .cscope.out." | echohl None
			return
		endif
	endif
	if(executable('ctags'))
		"silent! execute "!ctags -R --c-types=+p --fields=+S *"
		silent! execute "!ctags -R --c-kinds=+px --c++-kinds=+px --fields=+iaS --extra=+q ."
	endif
	if(executable('cscope') && has("cscope"))
		if(g:iswindows!=1)
			silent! execute "!find . -name '*.h' -o -name '*.c' -o -name '*.cpp' -o -name '*.java' -o -name '*.cs' -o -name '*.cxx' > cscope.files"
		else
			silent! execute "!dir /s/b *.c,*.cpp,*.h,*.java,*.cs >> cscope.files"
		endif
		silent! execute "!cscope -b cscope.files"
		silent! execute "!rm cscope.files"
		execute "normal :"
		if filereadable(".cscope.out")
			execute "cs add .cscope.out"
		endif
	endif
endfunction

" Vundle
" Brief help
" :BundleList		- list configured bundles
" :BundleInstall(!)	- install(update) bundles
" :BundleSearch(!) foo	- search(or refresh cache first) for foo
" :BundleClean(!)	- confirm(or auto-approve) removal of unused bundles
set nocompatible
filetype off
set rtp+=~/.vim/bundle/vundle/
call vundle#rc()
" let Vundle manage Vundle
" required
Bundle 'gmarik/vundle'
" My bundles here:
"
" original repos on github
Bundle 'tpope/vim-fugitive'
Bundle 'Lokaltog/vim-easymotion'
Bundle 'rstacruz/sparkup', {'rtp':'vim/'}
Bundle 'tpope/vim-rails.git'
Bundle 'mbbill/code_complete'
Bundle 'altercation/vim-colors-solarized'
Bundle 'laoyang945/vimflowy'
"Bundle 'robturtle/md-vim.git'
Bundle 'robturtle/vim-pandoc'
"Bundle 'Rip-Rip/clang_complete'
"Bundle 'scrooloose/syntastic'
" vim-scripts repos
Bundle 'L9'
Bundle 'FuzzyFinder'
Bundle 'DoxygenToolkit.vim'
Bundle 'a.vim'
"Bundle 'OmniCppComplete'
" non github repos
Bundle 'git://git.wincent.com/command-t.git'
" c/c++ programming completer
Bundle 'Valloric/YouCompleteMe'
"Bundle 'win-manager-improved'

filetype plugin indent on " required
syntax on

" Vundle end
