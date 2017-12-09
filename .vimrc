""KevinDNF

set nocompatible 

""--------------------------FILE BROWSER-------------------------"
let g:netrw_banner=0			 "disables banner
let g:netrw_browse_split=4		 "opens in prior window
let g:netrw_altv=1				 "open split to the right
let g:netrw_liststyle=3			 "tree view
let g:netrw_list_hide=netrw_gitignore#Hide()
let g:netrw_list_hide.=',\(^\|\s\s\)\zs\.\S\+'

set path=**
""enables the Find command to be usefull as a proper searcher. try tab
set wildmenu
""Menu for picking item from FIND

"Autoreload .vimrc
autocmd! bufwritepost .vimrc source %

"Clear Search
noremap <C-l> :nohl<CR>
vnoremap <C-l> :nohl<CR>
inoremap <C-l> :nohl<CR>


"--------File-Settings------


filetype on
filetype plugin indent on
syntax on

augroup vimrc "meant to create folds
	au BufReadPre * setlocal foldmethod=indent
	au BufWinEnter * if &fdm == 'indent' | setlocal foldmethod=manual | endif
augroup END

"--------Writting-Settings-----

set linebreak nolist "break on end word
filetype indent on
set autoindent
set smarttab
set scrolloff=10 "Automove 10 lines above/below


"----------Editor-Visuals-----

set number  " show line numbers
set colorcolumn=80
color wombat256mod-modified
highlight ColorColumn ctermbg=233

"--------/Search------------
set hlsearch
set incsearch "start searching without enter
set ignorecase 
set smartcase 

"-------------Swap-Files------
"all disabled
set nobackup
set nowritebackup
set noswapfile

"--------Cursor-------------------

"Changes the cursor when in insert and Normal

"Normal Mode
let &t_EI = "\x1b[\x32 q"
"Insert Mode
let &t_SI = "\x1b[\x36 q" 

"---------Plugins-Settings--------
let g:airline_theme='minimalist'
let g:livepreview_previewer = 'mupdf'

"--------------Plugins----------
"Plug

"AutoInstall vim-plug
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif


call plug#begin('~/.vim/plugplugins')

Plug 'vim-airline/vim-airline-themes'
Plug 'bling/vim-airline'
Plug 'godlygeek/tabular'
Plug 'terryma/vim-multiple-cursors'
Plug 'lervag/vimtex'

call plug#end()
