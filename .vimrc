"" __________________________.vimrc___________________________
""|                                                           |
""|                         KevinDNF                          |
""|               github.com/kevindnf/config                  |
""|___________________________________________________________|
""---------------------Reload .vimrc---------------------------
autocmd! bufwritepost .vimrc source % "autoreload vimrc
"----------------------Plugins----------
"AutoInstall vim-plug
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin('~/.vim/plugplugins')
"---Themes
Plug 'vim-airline/vim-airline-themes'
Plug 'bling/vim-airline'
Plug 'junegunn/goyo.vim'
Plug 'junegunn/limelight.vim'
Plug 'dylanaraps/wal.vim'
"---Async: Linting, Complete & Interactive
Plug 'valloric/youcompleteme'
Plug 'skywind3000/asyncrun.vim'
Plug 'w0rp/ale'
"Plug 'eslint/eslint'
"---Files,Panes and Git stuff
Plug 'scrooloose/nerdtree'
Plug 'Xuyuanp/nerdtree-git-plugin'
Plug 'christoomey/vim-tmux-navigator'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-surround'
"---Snippets
Plug 'SirVer/ultisnips'
Plug 'honza/vim-snippets'
"---Lang specific
Plug 'pangloss/vim-javascript'
Plug 'machakann/vim-highlightedyank'
call plug#end()
"--------------Other---------------
set mouse=a "yeah, I use my mouse to scroll sometimes what you gonna do
set timeoutlen=50
set nocompatible
""--------------------------FILE BROWSER-------------------------
set path=**
set wildmenu "Tab file menu
""--------------------------Buffer List--------------------------
set hidden
nnoremap <silent> <esc>p :bnext<CR>
nnoremap <silent> <esc>o :bprev<CR>
"--------File-Settings------ 
set autoread "updates file if edited by other source
filetype on
filetype plugin indent on
syntax on

set backspace=indent,eol,start
set encoding=utf-8
set expandtab "change tabs for spaces
set softtabstop=4 "how many collums pressing tab dows
set tabstop=4 "how many collums a tab counts
set shiftwidth=4 ">> operations

set smarttab
set autoindent
set smartindent

autocmd FileType html set expandtab softtabstop=2 tabstop=2 shiftwidth=2 textwidth=75
autocmd FileType html* set expandtab softtabstop=2 tabstop=2 shiftwidth=2 textwidth=75
autocmd FileType css set expandtab softtabstop=2 tabstop=2 shiftwidth=2
autocmd FileType javascript set expandtab softtabstop=2 tabstop=2 shiftwidth=2
autocmd FileType tex set expandtab softtabstop=2 tabstop=2 shiftwidth=2 textwidth=75
autocmd FileType markdown set textwidth=48

set linebreak  "break on end word
set scrolloff=10 "Automove 10 lines above/below

"----------Editor-Visuals-----
set list
set listchars=tab:>.,trail:-,extends:#,nbsp:.

set number  " show line numbers
set relativenumber
"set colorcolumn=80
"highlight ColorColumn ctermbg=1

highlight Error ctermfg=1 ctermbg=257 guifg=Red guibg=Red
highlight SpellBad ctermfg=1 ctermbg=257 guifg=Red guibg=Red
highlight ErrorMsg ctermfg=1 ctermbg=257 guifg=Red guibg=Red
highlight ALESignColumnWithoutErrors ctermfg=Red ctermbg=257 guifg=Red guibg=Red
highlight SignColumn ctermfg=0 ctermbg=257 guifg=Red guibg=Red
highlight Todo ctermfg=1 ctermbg=257
highlight SpellCap ctermfg=1 ctermbg=257
highlight Pmenu ctermfg=15 ctermbg=0
""youcompleteme menu

set background=dark

if has ('gui_running')
    "Loading 2 colorschemes to trick macvim to
    "use a weird dark colorscheme, idk it works somehow.
    color wal
    color macvim
    let g:airline_theme='wal'
    set guifont=IBMPlexMono\ Nerd\ Font\ Mono:h13
else
    color wal
    let g:airline_theme='wal'
endif
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

if exists('$TMUX')
    "Workaround for when inside tmux
    let &t_EI = "\ePtmux;\e\e[2 q\e\\"
    let &t_SI = "\ePtmux;\e\e[5 q\e\\"
    autocmd VimLeave * silent !echo -ne "\033Ptmux;\033\033[4 q\033\\"
else
    "Normal Mode
    let &t_EI = "\x1b[\x32 q"
    "Insert Mode
    let &t_SI = "\x1b[\x36 q"
endif
"--------------Compile-----------
set autowrite "automatic save after make/next
autocmd FileType python se makeprg=python3\ -i\ %
autocmd FileType java se makeprg=javac\ %
autocmd FileType javascript se makeprg=node\ %
"--Async Compile--

"Autocompile
let g:compile="false"
function! AutoCompile()
    augroup autocompile
        autocmd!
        if g:compile=="false"
            :echo "Autocompile Enable"
            autocmd BufWritePost *.js :AsyncRun -auto=make node %:p
            autocmd BufWritePost *.py :AsyncRun -auto=make python3 %
            "compile options for labbook. can be expanded to all markdown with *.md
            autocmd BufWritePost lab.md :AsyncRun pandoc --toc % -f markdown -t latex -o %<.pdf
            autocmd BufWritePost *.md :AsyncRun pandoc --toc % -f markdown -t latex -o %<.pdf
            autocmd BufWritePost *.hs :AsyncRun ghc %; ./%<
            let g:compile="true"
        else
            :echo "Autocompile Disabled"
            let g:compile="false"
        endif
    augroup END
endfunction
nnoremap <C-a> :call AutoCompile()<cr>

command! -bang -nargs=* -complete=file Make AsyncRun -program=make @ <args>
nnoremap <esc>r :AsyncRun open ~/Desktop/reload.app<cr>
"replaces make with Make
"-------------QuickFix----------
noremap <C-C> :call asyncrun#quickfix_toggle(8)<cr>
"---------Plugins-Settings--------
nnoremap <esc>f :Goyo <bar> Limelight!! <CR>
"---Nerdtree
map <silent> <C-\> :NERDTreeToggle<CR>
let g:NERDTreeDirArrowExpandable = ''
let g:NERDTreeDirArrowCollapsible = '﬌'
"shift + i for toogle hidden files
let g:NERDTreeIndicatorMapCustom = {
    \ "Modified"  : "",
    \ "Staged"    : "",
    \ "Untracked" : "",
    \ "Renamed"   : "凜",
    \ "Unmerged"  : "═",
    \ "Deleted"   : "﫧",
    \ "Dirty"     : "✗",
    \ "Clean"     : "✔︎",
    \ 'Ignored'   : '',
    \ "Unknown"   : "?"
    \ }
"---Airline
let g:airline_powerline_fonts = 1
let g:airline_symbols_ascii = 1
let g:airline#extensions#ale#enabled = '1'
let g:airline#extensions#tabline#enabled = 1
"
let g:asyncrun_status = ''
let g:airline_section_error = '%{g:asyncrun_status}%{FugitiveStatusline()}'
"---Ale settings
"let g:ale_set_highlights = "0"
"let g:ale_set_signs = "0"
let g:ale_sign_error = ">>"
let g:ale_sign_column_always = "0"
"let g:ale_sign_style_error = ""
"---Tmux Config
let g:tmux_navigator_no_mappings = 1
"alt + key
nnoremap <silent> <esc>h :TmuxNavigateLeft<cr>
nnoremap <silent> <esc>j :TmuxNavigateDown<cr>
nnoremap <silent> <esc>k :TmuxNavigateUp<cr>
nnoremap <silent> <esc>l :TmuxNavigateRight<cr>
"--Util Snips
let g:UltiSnipsExpandTrigger="<c-a>"
let g:UltiSnipsJumpForwardTrigger="<c-b>"
let g:UltiSnipsJumpBackwardTrigger="<c-z>"
