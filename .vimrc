""Config for Vim - KevinDNF
""WIP


set linebreak nolist "break on end word

let g:livepreview_previewer = 'mupdf'

set nocompatible 
""stop vim from trying to be compatible with vi
filetype plugin on 

set path=**
""enables the Find command to be usefull as a proper searcher. try tab
set wildmenu
""Menu for picking item from FIND

""--------------------------FILE BROWSER-------------------------"
let g:netrw_banner=0			 "disables banner
let g:netrw_browse_split=4		 "opens in prior window
let g:netrw_altv=1				 "open split to the right
let g:netrw_liststyle=3			 "tree view
let g:netrw_list_hide=netrw_gitignore#Hide()
let g:netrw_list_hide.=',\(^\|\s\s\)\zs\.\S\+'

"------------------Personal-Snippets-And-Mappings----------------"




"---------------------------------------------------------------"


" ``<C>`` stands for ``CTRL`` and therefore ``<C-n>`` stands for ``CTRL+n``
" Automatic reloading of .vimrc
autocmd! bufwritepost .vimrc source %


" Rebind <Leader> key
"" let mapleader = ","

" Bind nohl
" Removes highlight of your last search
"" noremap <C-n> :nohl<CR>
"" vnoremap <C-n> :nohl<CR>
"" inoremap <C-n> :nohl<CR>

filetype off
filetype plugin indent on
syntax on


" Showing line numbers and length
set number  " show line numbers
"set tw=79   " width of document (used by gd)
"set nowrap  " don't automatically wrap on load
"set fo-=t   " don't automatically wrap text when typing
set colorcolumn=80
highlight ColorColumn ctermbg=233


set tabstop=4
set softtabstop=4
"" set shiftwidth=4
"" set shiftround
"" set expandtab

" Make search case insensitive
set hlsearch
set incsearch
set ignorecase
set smartcase

"disable swap files
set nobackup
set nowritebackup
set noswapfile

"Some things where stolen from:
" ##Martin Brochhaus


