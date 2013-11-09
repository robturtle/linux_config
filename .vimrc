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
set relativenumber
au InsertEnter * set nu
au InsertLeave * set relativenumber

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
map <silent> <leader><space> :noh<cr>:pc<cr>

" Smart way to move between windows
map <C-j> <C-W>j
map <C-k> <C-W>k
map <C-h> <C-W>h
map <C-l> <C-W>l

" Move around split windows
map th <C-Pageup>
map tl <C-Pagedown>
" Opens a new tab
map <c-t> :tabnew<cr>
" Open a file under the same directory"
map <leader>te :tabedit <c-r>=expand("%:p:h")<cr>/
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
set statusline=\ %{HasPaste()}%F%m%r%h\ %w\ %y\ \ CWD:\ %r%{getcwd()}%h\ \ %p%%\ \ %{fugitive#statusline()}
"set statusline=%<%f\ %h%m%r%{fugitive#statusline()}%=%-14.(%l,%c%V%)\ %P

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
"   <leader>q provided by ListToggle
"
" To go to the next search result do:
"   <leader>n
"
" To go to the previous search results do:
"   <leader>p
"
map <leader>co ggVGy:tabnew<cr>:set syntax=qf<cr>pgg
map <leader>n :cn<cr>
map <leader>p :cp<cr>

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Spell checking
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Pressing ,ss will toggle and toggle spell checking
map <leader>ss :setlocal spell!<cr>

" Shortcuts using <leader>
"  ]s next word
"  [s previous word
"  zg ignore this error
"  z= suggestion

"""""""""""""""""""""""""""""""""""
" => Misc
"""""""""""""""""""""""""""""""""""
" Remove the Windows ^M - when the encodings gets messed up
noremap <leader>m mmHmt:%S/<C-V><cr>//ge<cr>'tzt'm
" Toggle paste mode on and off
map <leader>pp :setlocal paste!<cr>:set nu!<cr>

" Entry to temporary snippets
nmap <leader>ts :tabedit /home/jeremy/Snippets/my.snippets<cr>
" add entry for snippets for current filetype
nmap <leader>tf :tabedit /home/jeremy/Snippets/Mine/<c-r>=&ft<cr>.snippets
" Entry to my .vimrc
nmap <leader><leader>v :tabedit /home/jeremy/git/linux_config/.vimrc<cr>

" fast map of c-x,c-f
imap <leader>r <c-x><c-f>

" fast map of :cd
nmap cd :cd 
nmap cm :!cmake

" Emacs like movement in insert mode"
func! Append()
    normal! l
    if col('.') >= col('$') - 1
        startinsert!
    else
        startinsert
        normal! l
    endif
endfunc

imap <c-f> <Esc>:call Append()<cr>
imap <c-b> <Esc>:startinsert<cr>

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

""""""""""""""""""""""""""
" Programming
""""""""""""""""""""""""""
" symatics check
Bundle 'scrooloose/syntastic'
" facility to syntastic, open llist quickly
Bundle 'Valloric/ListToggle'
" git wrapper
Bundle 'tpope/vim-fugitive'
" fugitive the Git wrapper
nmap gs :Gstatus<cr>
nmap gl :Gllog<cr>
nmap gpu :Git push<cr>

" YouCompleteMeeeeeee!!!!!!!!
Bundle 'Valloric/YouCompleteMe'
" YouCompleteMe
nnoremap <leader>jd :YcmCompleter GoToDefinitionElseDeclaration<CR>
"let g:ycm_global_ycm_extra_conf = '~/.ycm_extra_conf.py'
" Do not ask when starting vim
let g:ycm_confirm_extra_conf = 0
let g:syntastic_always_populate_loc_list = 1

""""""" c/c++ jump support
" header/source jump
Bundle 'a.vim'
" Commenter
Bundle 'scrooloose/nerdcommenter'

"Bundle 'jalcine/cmake.vim' Is buggy right now
""""""""""""""""""""""""""
" End of Programming
""""""""""""""""""""""""""

""""""""""""""""""""""""""
" File finder
""""""""""""""""""""""""""
Bundle 'kien/ctrlp.vim'
" Ctrlp.vim
" I have many symlinks to git repos
let g:ctrlp_follow_symlinks = 1
" Sometimes I wanna open hidden files
let g:ctrlp_show_hidden = 1
" Symlinks may disturb my working on git
let g:ctrlp_switch_buffer = 0

""""""""""""""""""""""""""
" Misc
""""""""""""""""""""""""""
" Vim utilities
Bundle 'L9'
" Statusline utility
Bundle 'Lokaltog/powerline'
" Format table like contents
Bundle 'Tabular'
" Tabular
nnoremap <leader>f :Tabularize /=<cr>
nnoremap <leader>df xP:Tabularize /<C-R>-<CR>
vnoremap <leader>df xP:Tabularize /<C-R>-<CR>

""""""""""""""""""""""""""
" Sniiiippets!!!
""""""""""""""""""""""""""
Bundle 'UltiSnips'
" UltiSnipsExpandTrigger
let g:UltiSnipsExpandTrigger = '<c-j>'
" My own snippets
Bundle 'robturtle/USsnippets'

" Move around
Bundle 'Lokaltog/vim-easymotion'
" Flowy simulation
"Bundle 'laoyang945/vimflowy'
" Chinese input method
"Bundle 'vimim/vimim'
" Window manager
Bundle 'winmanager'
" TODO A better win manager"
" winManager
let g:winManagerWindowLayout="FileExplorer,BufExplorer,TagList"
let g:winManagerWidth=30
let g:defaultExplorer=0
nmap wm :WMToggle<cr>

" Modify surrounding tag/'/"/(/[, etc.
Bundle 'tpope/vim-surround'
" Auto complete brackets
Bundle 'Raimondi/delimitMate'
""""""""""""""""""""""""""
" End of Misc
""""""""""""""""""""""""""

""""""""""""""""""""""""""
" Colors
""""""""""""""""""""""""""
Bundle 'altercation/vim-colors-solarized'
"Bundle 'kien/rainbow_parentheses.vim'
" rainbow_parentheses
"let g:rbpt_colorpairs = [
    "\ ['brown', 'RoyalBlue3'],
    "\ ['Darkblue', 'SeaGreen3'],
    "\ ['Darkgray', 'DarkOrchid3'],
    "\ ['darkgreen', 'firebrick3'],
    "\ ['darkcyan', 'RoyalBlue3'],
    "\ ['darkred', 'SeaGreen3'],
    "\ ['darkmagenta', 'DarkOrchid3'],
    "\ ['brown', 'firebrick3'],
    "\ ['gray', 'RoyalBlue3'],
    "\ ['black', 'SeaGreen3'],
    "\ ['darkmagenta', 'DarkOrichd3'],
    "\ ['Darkblue', 'firebrick3'],
    "\ ['darkgreen', 'RoyalBlue3'],
    "\ ['darkcyan', 'SeaGreen3'],
    "\ ['darkred', 'DarkOrichid3'],
    "\ ['red', 'firebrick3'],
    "\ ]
"let g:rbpt_max = 16
"let g:rbpt_loadcmd_toggle = 0
"au VimEnter * RainbowParenthesesToggle
"au Syntax * RainbowParenthesesLoadRound
"au Syntax * RainbowParenthesesLoadSquare
"au Syntax * RainbowParenthesesLoadBraces

"Bundle 'Yggdroot/indentLine'
" indentLine
let g:indentLine_noConcealCursor = 1
let g:indentLine_color_term = 0
let g:indentLine_char = '|'
""""""""""""""""""""""""""
" End of Color
""""""""""""""""""""""""""

""""""""""""""""""""""""""
" Filetype support
""""""""""""""""""""""""""
Bundle 'plasticboy/vim-markdown'
Bundle 'tpope/vim-liquid'
Bundle 'python.vim'
Bundle 'pangloss/vim-javascript'
Bundle 'thiderman/nginx-vim-syntax'
Bundle 'php.vim--Garvin'

" Html writer
""""""""""""""""""""""""""
"zen coding like plugin
" TODO Which one is better?
Bundle 'rstacruz/sparkup', {'rtp':'vim/'}
Bundle 'robturtle/zencoding-vim'
let g:user_zen_leader_key = '<c-h>'

filetype plugin indent on " required
syntax on
" Vundle end
