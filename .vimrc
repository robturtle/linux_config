""""""""""""""""""""
" => General
""""""""""""""""""""
" encoding
set encoding=utf8
set ffs=unix,dos,mac

set history=700
set autoread
let mapleader = " "
let g:mapleader = " "

set clipboard^=unnamed

" global keys
"" quit
nnoremap <leader>qq :qa<cr>

"" files <f>
"""" save
nnoremap <leader>fs :w!<cr>
"""" close
nnoremap <leader>fq :q<cr>
"""" ranger finder
nnoremap <leader>ff :call RangerChooser()<CR>
"""" fast open vimrc
let g:myvimrc = "~/.vimrc"
nnoremap <leader>fv :silent exe "tabedit ".g:myvimrc<cr>

"" window <w>
"""" keep only this window
nnoremap <leader>wo :on<cr>
let g:lt_location_list_toggle_map = '<leader>wl'
let g:lt_quickfix_list_toggle_map = '<leader>wq'

"" misc 
"""" reset highlight, close preview window
nnoremap <silent> <leader>, :noh<cr>:pc<cr>
"""" cd to file's base directory
nnoremap <leader>cd :cd %:p:h<cr>:pwd<cr>
"""" space to toggle folding
nnoremap <leader>zz za
"""" paste mode toggle
nnoremap <leader>pp :setlocal paste!<cr>:set relativenumber!<cr>:set nu!<cr>

"" editing
" filesystem autocomplete
inoremap ,f <C-x><C-f>

""""""""""""""""""""
" => UI
""""""""""""""""""""
set so=7
set wildmenu
set wildignore=*.o,*~,*.pyc,*.bin,#*#
set ruler
set hid
set backspace=eol,start,indent
set whichwrap+=<,>,h,l

" searching
set ignorecase
set smartcase
set hlsearch
set incsearch

" regex
set magic

" paren match
set showmatch
set mat=2

" bells
set noerrorbells
set novisualbell
set t_vb=
set tm=500

" line number
set nu
set relativenumber

" folding
set fdm=syntax
set foldlevel=99

""""""""""""""""""""
" => Files, backup and undo
""""""""""""""""""""
filetype plugin indent off
set nobackup
set nowb
set noswapfile

" customize filetype
augroup set_filetype
    au BufRead,BufNewFile *.h++ setf cpp
    au BufRead,BufNewFile *.c++ setf cpp
augroup END
filetype plugin indent on

""""""""""""""""""""
" => Text, tabs, indents
""""""""""""""""""""
set smarttab
set shiftwidth=4
set tabstop=4
set expandtab

set lbr
set tw=500
set ai "Auto indent
set si "Smart indent
set wrap "Wrap lines

""""""""""""""""""""
" => Navigation
""""""""""""""""""""
set mouse=a

nnoremap j gj
nnoremap k gk

" Smart way to move between windows
nnoremap <C-j> <C-W>j
nnoremap <C-k> <C-W>k
nnoremap <C-h> <C-W>h
nnoremap <C-l> <C-W>l

" tab window
nnoremap <leader>th <C-Pageup>
nnoremap <leader>tl <C-Pagedown>
nnoremap <leader>te :tabedit <c-r>=expand("%:p:h")<cr>/
nnoremap <leader>tm :tabmove<cr>

" behavior of switch buffer
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
" Remember info about open buffer on close
set viminfo^=%

" Use ranger in vim
fun! RangerChooser()
    "silent !ranger --choosefile=/tmp/chosenfile $([ -z '%' ] && echo $(pwd) || dirname %)
    silent !ranger --choosefile=/tmp/chosenfile '%:p:h'
    if filereadable('/tmp/chosenfile')
        exec 'edit ' . system('cat /tmp/chosenfile')
        call system('rm /tmp/chosenfile')
    endif
    redraw!
endfun

" Powerful O navigation
onoremap b /return<cr>

""""""""""""""""""""
" => Spell checking
""""""""""""""""""""
nnoremap <leader>sp :setlocal spell!<cr>
" Shortcuts using <leader>
"  ]s next word
"  [s previous word
"  zg ignore this error
"  z= suggestion

" Vundle
" Brief help
" :BundleList		- list configured bundles
" :BundleInstall(!)	- install(update) bundles
" :BundleSearch(!) foo	- search(or refresh cache first) for foo
" :BundleClean(!)	- confirm(or auto-approve) removal of unused bundles
set nocompatible
filetype off
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

Bundle 'VundleVim/Vundle.vim'

"""" infras
Bundle 'L9'

"""" formatting
Plugin 'editorconfig/editorconfig-vim'

"""" programming
"Bundle 'scrooloose/syntastic'
"Bundle 'Valloric/ListToggle'

"Bundle 'tpope/vim-fugitive'
Bundle 'airblade/vim-gitgutter'

"""" C/C++
"Bundle 'a.vim'
" commenter
"Bundle 'scrooloose/nerdcommenter'
"Bundle 'DoxygenToolkit.vim'

"""" file finder
"Bundle 'kien/ctrlp.vim'

""" status line
Bundle 'Lokaltog/powerline'

"""" easy move around
"Bundle 'Lokaltog/vim-easymotion'

"""" powerful editting
" map: cs
Bundle 'tpope/vim-surround'
Bundle 'Raimondi/delimitMate'

call vundle#end()
filetype plugin indent on
syntax enable
" Vundle end

""""""""""""""""""""
" => Vim utils
""""""""""""""""""""
setlocal keywordprg=:help

augroup AutoReloadVimrc
    au!
    autocmd bufwritepost .vimrc source ~/.vimrc
augroup END

""""""""""""""""""""
" => Colors & Fonts
""""""""""""""""""""
syntax enable
set background=dark

try
    colorscheme desert
    "colorscheme solarized
catch
endtry

hi ColorColumn ctermbg=DarkGrey guibg=#2c2d27
hi Search ctermfg=black ctermbg=LightGreen
hi IncSearch ctermfg=black ctermbg=LightGreen
let &colorcolumn="81"

