""KevinDNF

set nocompatible 
autocmd! bufwritepost .vimrc source % "autoreload vimrc

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

"--------File-Settings------ 
set autoread "updates file if edited by other source
filetype on
filetype plugin indent on
syntax on

augroup vimrc "meant to create folds
	au BufReadPre * setlocal foldmethod=indent
	au BufWinEnter * if &fdm == 'indent' | setlocal foldmethod=manual | endif
augroup END

"--------Writting-Settings-----

set expandtab "change tabs for spaces
set softtabstop=4 "how many collums pressing tab dows
set tabstop=4 "how many collums a tab counts
set shiftwidth=4 ">> operations

"set smarttab

set autoindent
set smartindent

autocmd FileType html set expandtab softtabstop=2 tabstop=2 shiftwidth=2 textwidth=75
autocmd FileType css set expandtab softtabstop=2 tabstop=2 shiftwidth=2
autocmd FileType javascript set expandtab softtabstop=2 tabstop=2 shiftwidth=2
autocmd FileType tex set expandtab softtabstop=2 tabstop=2 shiftwidth=2 textwidth=75
autocmd FileType markdown set textwidth=48

set linebreak nolist "break on end word
filetype indent on
set scrolloff=10 "Automove 10 lines above/below

"----------Editor-Visuals-----

set number  " show line numbers
set colorcolumn=80
set relativenumber 
set background=light
highlight ColorColumn ctermbg=233

highlight Error ctermfg=1 ctermbg=257 guifg=Red guibg=Red
highlight SpellBad ctermfg=1 ctermbg=257 guifg=Red guibg=Red
highlight ErrorMsg ctermfg=1 ctermbg=257 guifg=Red guibg=Red
highlight ALESignColumnWithoutErrors ctermfg=Red ctermbg=257 guifg=Red guibg=Red
highlight SignColumn ctermfg=1 ctermbg=257 guifg=Red guibg=Red
highlight Todo ctermfg=1 ctermbg=257 
highlight SpellCap ctermfg=1 ctermbg=257 

"color wombat256mod
color peachpuff 
"--------/Search------------
set hlsearch
set incsearch "start searching without enter
set ignorecase 
set smartcase 

"Clear Search with ctrl + l
noremap <C-l> :nohl<CR>
vnoremap <C-l> :nohl<CR>
inoremap <C-l> :nohl<CR>

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
let g:airline_theme='base16'
let g:airline_powerline_fonts = 0
let g:livepreview_previewer = 'mupdf'
let g:airline#extensions#ale#enabled = '1'
"let g:ale_set_highlights = "0"
"let g:ale_set_signs = "0"
let g:ale_sign_error = ">>"
let g:ale_sign_column_always = "1"
"let g:ale_sign_style_error = ""

"--------------Compile-----------

set autowrite "automatic saave after make/next
command! -nargs=* Runp !python3 -i %
"even better
autocmd FileType python se makeprg=python3\ -i\ %
autocmd FileType java se makeprg=javac\ %
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
Plug 'rawsource/monkey-vim'
Plug 'valloric/youcompleteme' 
Plug 'w0rp/ale'
"Plug 'eslint/eslint'
Plug 'pangloss/vim-javascript'
Plug 'editorconfig/editorconfig-vim'

call plug#end()
