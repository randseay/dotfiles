" Auto Install Vundle
let iCanHazVundle=1
let vundle_readme=expand('~/.vim/bundle/vundle/README.md')
if !filereadable(vundle_readme)
    echo "Installing Vundle.."
    echo ""
    silent !mkdir -p ~/.vim/bundle
    silent !git clone https://github.com/gmarik/vundle ~/.vim/bundle/vundle
    let iCanHazVundle=0
endif

" Reload .vimrc on save
" Thanks JeffreyWay...
if has("autocmd")
    autocmd bufwritepost .vimrc source $MYVIMRC
endif

let mapleader = ","

" Continue with your regularly scheduled programming
set nocompatible
filetype off

" Start the vundle stuff
set rtp+=~/.vim/bundle/vundle/
call vundle#rc()

" Install all the packages I like
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


" Some bundles need different things
filetype on
Bundle 'scrooloose/nerdcommenter'
Bundle 'Rykka/riv.vim'

" Turn on Powerline
set laststatus=2
let g:airline_powerline_fonts=1

" If this is a fresh install, install the packages
if iCanHazVundle == 0
    echo "Installing Vundle packages"
    echo ""
    :BundleInstall
endif

" Make VIM colorful
syntax enable
set background=dark
set t_Co=256
let g:solarized_termcolors=256
colorscheme solarized
set guifont=Source\ Code\ Pro\ for\ Powerline\ Medium\ 10

" Fix backspace
set backspace=indent,eol,start

" Tab stuff
set smartindent
set tabstop=4
set shiftwidth=4
set expandtab
set softtabstop=4

" Helpful programming stuff
set number
filetype plugin on
filetype plugin indent on
set fileformat=unix

" Turn off auto folding on save for rst files
let g:riv_fold_auto_update = 0

" natural splitting
set splitright

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
    set smartindent
    set tabstop=2
    set shiftwidth=2
    set expandtab
    set softtabstop=2
augroup END

autocmd FileType rst setlocal cc=80 tw=80

" Have NERDTree open similar to Sublime Text
map <leader>k :NERDTreeToggle<CR>

" Type jj to get out of insert mode
inoremap jj <esc>

" close the current buffer without closing the split
map <leader>e :b#<bar>bd#<CR>

" easier moving around in splits and stuff
nmap <C-h> <C-w>h
nmap <C-j> <C-w>j
nmap <C-k> <C-w>k
nmap <C-l> <C-w>l

" better save command
inoremap <leader>s <esc>:w<CR>i

" switch to previous buffer
map <leader>b <esc>:b#<CR>

" Make return far more powerful
" Two hits, gives you a newline and you are in the same mode you started in
" One is the same as <ESC>to
" Thanks to o11c in #vim on freenode for the tip
" imap <CR> <Esc>
" nnoremap <CR> a<CR>
