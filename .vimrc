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

" Continue with your regularly scheduled programming
set nocompatible 
filetype off 

set rtp+=~/.vim/bundle/vundle/
call vundle#rc()

Bundle 'gmarik/vundle'
Bundle 'tpope/vim-fugitive'
Bundle 'scrooloose/nerdtree'
Bundle 'scrooloose/syntastic'
Bundle "MarcWeber/vim-addon-mw-utils"
Bundle "tomtom/tlib_vim"
Bundle "garbas/vim-snipmate"
Bundle "honza/vim-snippets"
Bundle "hallison/vim-markdown"
Bundle "altercation/vim-colors-solarized"

" If this is a fresh install, install the packages
if iCanHazVundle == 0
    echo "Installing Vundle packages"
    echo ""
    :BundleInstall
endif

"Programming
syntax enable
set number
set background=dark
colorscheme solarized 
set backspace=indent,eol,start

" Tab stuff
set smartindent
set tabstop=4
set shiftwidth=4
set expandtab

filetype plugin on

" Key mappings
map <C-K> :NERDTreeToggle<CR>
inoremap jj <esc>
