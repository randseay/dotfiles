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

Bundle 'gmarik/vundle'
Bundle 'tpope/vim-fugitive'
Bundle 'airblade/vim-gitgutter'
Bundle 'scrooloose/nerdtree'
Bundle 'scrooloose/syntastic'
Bundle "MarcWeber/vim-addon-mw-utils"
Bundle "tomtom/tlib_vim"
Bundle "garbas/vim-snipmate"
Bundle "honza/vim-snippets"
Bundle "hallison/vim-markdown"
Bundle "file:///Users/nickzaccardi/j/utils/inow-snippets/.git"
Bundle "altercation/vim-colors-solarized"
Bundle "mattn/emmet-vim"
Bundle "bling/vim-airline"
Bundle "fholgado/minibufexpl.vim"
Bundle "davidhalter/jedi-vim"
Bundle "ervandew/supertab"
Bundle "elzr/vim-json"
Bundle "stephpy/vim-yaml"
Bundle "dahu/Insertlessly"
Bundle "tpope/vim-surround"
Bundle "tpope/vim-unimpaired"

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
set autoread
set backspace=2
set colorcolumn=80
set cursorline
set fileformat=unix
set hidden
set laststatus=2
set listchars=tab:›\ ,eol:¬,trail:⋅
set number
set t_Co=256
set scrolloff=999
set showmatch
set showmode
set splitbelow
set splitright
set title
set visualbell


"------------------------------------------------------------------------------
" Tab Settings
"------------------------------------------------------------------------------
set expandtab
set tabstop=4
set softtabstop=4
set shiftwidth=4

"------------------------------------------------------------------------------
" Syntax Highlighting and Color
"------------------------------------------------------------------------------
syntax on
let g:airline_powerline_fonts=1
set background=dark
let g:solarized_termcolors=256
colorscheme solarized
set guifont=Source\ Code\ Pro\ for\ Powerline\ Medium\ 10

" Helpful programming stuff
filetype plugin on
filetype plugin indent on

" Turn off auto folding on save for rst files
let g:riv_fold_auto_update = 0


" Make vim equalize when resized
autocmd VimResized * wincmd =

" use the system clipboard
set clipboard=unnamed

" setup spell checking
set spell spelllang=en
setlocal spell spelllang=en

" File specific settings
augroup vagrant
    au!
    au BufRead,BufNewFile Vagrantfile set filetype=ruby
augroup END

autocmd FileType rst,markdown setlocal textwidth=80

" Have NERDTree open similar to Sublime Text
map <leader>k :NERDTreeToggle<CR>
let NERDTreeIgnore = ['\.pyc$']

" Type jj to get out of insert mode
inoremap jj <esc>

" close the current buffer without closing the split
map <leader>e :b#<bar>bd#<CR>

" easier moving around in splits and stuff
nmap <C-h> <C-w>h
nmap <C-j> <C-w>j
nmap <C-k> <C-w>k
nmap <C-l> <C-w>l

" switch to previous buffer
nnoremap <leader>b <esc>:b#<CR>

" reformat text a lot easier
nnoremap <leader>0 <esc>0gq}
nnoremap <leader>} <esc>gq}
