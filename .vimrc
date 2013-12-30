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
filetype plugin indent on
set foldmethod=indent

" >> Key mappings << "

" Similar to sublime text
map <C-K> :NERDTreeToggle<CR>

" Type jj to get out of insert mode
inoremap jj <esc>

" close the current buffer without closing the split
nmap <leader>d :b#<bar>bd#<CR>

" easier moving around in splits and stuff
nmap <C-h> <C-w>h
nmap <C-j> <C-w>j
nmap <C-k> <C-w>k
nmap <C-l> <C-w>l
