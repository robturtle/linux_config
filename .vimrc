""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
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
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
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
" Fast saving/quiting
nmap <leader>w :w!<cr>
nmap <leader>x :q<cr>
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
set background=dark

try
	colorscheme desert
    "colorscheme solarized
catch
endtry

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

" Be smart when using tabs ;)
set smarttab
" 1 tab == 4 spaces
set shiftwidth=4
set tabstop=4
set expandtab
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
map <silent> <leader><space> :noh<cr>

" Smart way to move between windows
map <C-j> <C-W>j
map <C-k> <C-W>k
map <C-h> <C-W>h
map <C-l> <C-W>l

" Move around split windows
map th <C-Pageup>
map tl <C-Pagedown>
" Opens the same file in another tab
map <leader>te :tabedit <c-r>=expand("%")<cr><cr>
" Move current tab to right position
map <leader>tm :tabmove<cr>

" Close current buffers
map <leader>bc :Bclose<cr>
" Close all the buffers
map <leader>ba :1,1000 bd!<cr>

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
" Powered by powerline
set laststatus=2
let g:Powerline_symbols = 'unicode'

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

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => vimgrep searching and cope displaying
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" When you press gv you vimgrep after the selected text
vnoremap <silent>gv :call VisualSelection('gv', '')<CR><cr>

" Open vimgrep and put the cursor in the right position
map <leader>g :vimgrep // **/*.*<left><left><left><left><left><left><left><left>

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
" Pressing ,ss will toggle and toggle spell checking
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
" Tabular
nnoremap <leader>f :Tabularize /=<cr>
nnoremap <leader>df xP:Tabularize /<C-R>-<CR>
vnoremap <leader>df xP:Tabularize /<C-R>-<CR>

" winManager
let g:winManagerWindowLayout="FileExplorer,BufExplorer,TagList"
let g:winManagerWidth=30
let g:defaultExplorer=0
nmap wm :WMToggle<cr>

" YouCompleteMe
nnoremap <leader>jd :YcmCompleter GoToDefinitionElseDeclaration<CR>
"let g:ycm_global_ycm_extra_conf = '~/.ycm_extra_conf.py'
" Do not ask when starting vim
let g:ycm_confirm_extra_conf = 0
let g:syntastic_always_populate_loc_list = 1
let g:ycm_collect_identifiers_from_tags_files = 1
set tags+=./.tags
" Let YCM compatible with UltiSnips!!!
"let g:ycm_key_list_select_completion = ['<C-TAB>', '<Down>']
"let g:ycm_key_list_previous_completion = ['<C-S-TAB>', '<Up>']

" UltiSnipsExpandTrigger
let g:UltiSnipsExpandTrigger = '<c-j>'

" Use ranger as vim's file chooser
fun! RangerChooser()
    silent !ranger --choosefile=/tmp/chosenfile $([ -z '%' ] && echo -n . || dirname %)
    if filereadable('/tmp/chosenfile')
        exec 'edit ' . system('cat /tmp/chosenfile')
        call system('rm /tmp/chosenfile')
    endif
    redraw!
endfun
map <leader>e :call RangerChooser()<CR>

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

""""""" Programming
" symatics check
Bundle 'scrooloose/syntastic'
" facility to syntastic, open llist quickly
Bundle 'Valloric/ListToggle'

""""""" c/c++ jump support
" header/source jump
Bundle 'a.vim'

" File finder
"Bundle 'wincent/Command-T'
Bundle 'kien/ctrlp.vim'
" Vim utilities
Bundle 'L9'
" Statusline utility
Bundle 'Lokaltog/powerline'
" Format table like contents
Bundle 'Tabular'
" Sniiiippets!!!
Bundle 'UltiSnips'

" Colors
Bundle 'altercation/vim-colors-solarized'

" Html writer
"zen coding like plugin
Bundle 'rstacruz/sparkup', {'rtp':'vim/'}

Bundle 'tpope/vim-fugitive'
Bundle 'Lokaltog/vim-easymotion'
Bundle 'tpope/vim-rails.git'
Bundle 'laoyang945/vimflowy'
"Bundle 'robturtle/md-vim.git'
Bundle 'robturtle/vim-pandoc'
Bundle 'Valloric/YouCompleteMe'
Bundle 'robturtle/zencoding-vim'
Bundle 'robturtle/vim-syntax'
Bundle 'vimim/vimim'

" vim-scripts repos
Bundle 'robturtle/USsnippets'
Bundle 'winmanager'

filetype plugin indent on " required
syntax on

" Vundle end

" Plugin develop
" reLoading .vimrc
"nmap ??? source ~/.vimrc
nmap <leader>o :source ~/.vimrc<cr>
imap <leader>o <Esc>l:call feedkeys('a', 'n')
