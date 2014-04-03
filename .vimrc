" 01101110 01011010 01100001 01100011
"
"            /$$$$$$$$
"           |_____ $$
" /$$$$$$$      /$$/   /$$$$$$   /$$$$$$$
" | $$__  $$    /$$/   |____  $$ /$$_____/
" | $$  \ $$   /$$/     /$$$$$$$| $$
" | $$  | $$  /$$/     /$$__  $$| $$
" | $$  | $$ /$$$$$$$$|  $$$$$$$|  $$$$$$$
" |__/  |__/|________/ \_______/ \_______/
"
" By: Nick Zaccardi
" Project: Dotfiles
" License: GNU GPLv3 (https://www.gnu.org/copyleft/gpl.html)


"------------------------------------------------------------------------------
" VUNDLE SETTINGS
"------------------------------------------------------------------------------
let iCanHazVundle=1
let vundle_readme=expand('~/.vim/bundle/vundle/README.md')
if !filereadable(vundle_readme)
    echo "Installing Vundle.."
    echo ""
    silent !mkdir -p ~/.vim/bundle
    silent !git clone https://github.com/gmarik/vundle ~/.vim/bundle/vundle
    let iCanHazVundle=0
endif

set nocompatible
filetype off

set rtp+=~/.vim/bundle/vundle/
call vundle#rc()


" Must have plugins
Bundle 'gmarik/vundle'
Bundle 'mhinz/vim-signify'
Bundle 'bling/vim-airline'
Bundle 'tpope/vim-unimpaired'
Bundle 'altercation/vim-colors-solarized'
Bundle 'dahu/Insertlessly'
Bundle 'kien/ctrlp.vim'
Bundle 'tpope/vim-fugitive'
Bundle 'fholgado/minibufexpl.vim'

" Reference Library Plugins
Bundle 'tomtom/tlib_vim'
Bundle 'MarcWeber/vim-addon-mw-utils'

" Language Plugins
Bundle 'chase/vim-ansible-yaml'
Bundle 'othree/html5.vim'
Bundle 'hallison/vim-markdown'

" Plugins that are nice in order of use
Bundle 'scrooloose/nerdtree'
Bundle 'SirVer/ultisnips'
Bundle 'scrooloose/syntastic'
Bundle 'honza/vim-snippets'
Bundle 'mattn/emmet-vim'
Bundle 'godlygeek/tabular'


filetype on
Bundle 'scrooloose/nerdcommenter'
Bundle 'Rykka/riv.vim'

if iCanHazVundle == 0
    echo "Installing Vundle packages"
    echo ""
    :BundleInstall
endif

"------------------------------------------------------------------------------
" GENERAL SETTINGS
"------------------------------------------------------------------------------
let mapleader = ";"
set autoread                " Auto-reload changed files
set backspace=2             " Fix backspace to not be stupid
set colorcolumn=80          " Highlight column 80
set cursorline              " Highlight the line of the cursor
set confirm                 " Confirm before switching from an unsaved buffer
set fileformat=unix         " We are a unix only shop
set hidden                  " Allow switching buffers without saving.see confirm
set laststatus=2            " Always show two status  lines
set listchars=tab:›\ ,eol:¬,trail:⋅ " remap hidden characters
set number                  " Show line numbers
set t_Co=256                " 256 colors, go iTerm 2 baby!
set scrolloff=999           " Always keep the cursor in the middle  of the page
set showmatch               " Highlight the opposing bracket
set noshowmode                " Show the mode of the current buffer (visual, insert)
set spell spelllang=en      " Set spelling to be English
set splitbelow              " Splits should open below
set splitright              " Splits should open right
set title                   " Show the title in MacVim
set visualbell              " Who doesn't like a visual bell?!?
set nobackup                " This just causes problems
set noswapfile              " Swapfiles are more of a pain for me then they are helpful


"------------------------------------------------------------------------------
" Tab Settings
"------------------------------------------------------------------------------
set expandtab               " Expand tabs to spaces
set tabstop=4               " Number of spaces a file counts for
set softtabstop=4           " Soft-tab width in spaces
set shiftwidth=4            " Number of spaces for each >>

"------------------------------------------------------------------------------
" Syntax Highlighting and Color
"------------------------------------------------------------------------------
syntax on       " turn on syntax highlightingp
set background=dark
let g:solarized_termcolors=256
colorscheme solarized
let g:airline_powerline_fonts=1
set guifont=Source\ Code\ Pro\ for\ Powerline\ Medium\ 10

"------------------------------------------------------------------------------
" File Type Specific
"------------------------------------------------------------------------------
filetype plugin on
filetype plugin indent on
autocmd FileType rst,markdown setlocal textwidth=80 " Wrap markdown rst files @ 80
autocmd BufNewFile,BufRead Vagrantfile set filetype=ruby " Vagrant is ruby :(

"------------------------------------------------------------------------------
" Editor Settings
"------------------------------------------------------------------------------
autocmd VimResized * wincmd = " Make vim equalize when resized

"------------------------------------------------------------------------------
" Plugin  Settings
"------------------------------------------------------------------------------
let NERDTreeIgnore = ['\.pyc$']
let g:riv_fold_auto_update = 0 " Turn off auto folding on save for rst files
let g:miniBufExplBRSplit = 0 " put MBE on top
let g:miniBufExplBuffersNeeded = 1
let g:ctrlp_working_path_mode = 'ra' " Set the working path to a .git folder

"------------------------------------------------------------------------------
" Tab completion setup
"------------------------------------------------------------------------------
set wildmode=list:longest " Wildcard matches show a list, matching the longest first
set wildignore+=.git,.hg,.svn " Ignore version control repos
set wildignore+=*.6 " Ignore Go compiled files
set wildignore+=*.pyc " Ignore Python compiled files
set wildignore+=*.rbc " Ignore Rubinius compiled files
set wildignore+=*.swp " Ignore vim backups

"------------------------------------------------------------------------------
" General Remappings
"------------------------------------------------------------------------------
inoremap jj <esc>

" Navigating splits is much easier
nmap <C-h> <C-w>h
nmap <C-j> <C-w>j
nmap <C-k> <C-w>k
nmap <C-l> <C-w>l

" using visual up/down instead of linewise very helpful for wrapped text
map j gj
map k gk

"------------------------------------------------------------------------------
" Leader mappings
"------------------------------------------------------------------------------
nnoremap <leader>e :MBEbd<CR> " close current buffer without closing split
nnoremap <leader>b <esc>:b#<CR> " Open previous buffer
nnoremap <leader>} <esc>gq} " Reformat paragraph
map <leader>y "*y
map <leader>p "*p
nnoremap <leader>q :MBEbb<CR>
nnoremap <leader>w :MBEbf<CR>

"------------------------------------------------------------------------------
" Plugin mappings
"------------------------------------------------------------------------------
nnoremap <leader>t :CtrlP<cr>
nnoremap <leader>b :CtrlPBuffer<cr>
nnoremap <leader>l :CtrlPLine<cr>
nnoremap <leader>k :NERDTreeToggle<CR> " Toggle NERDTree

