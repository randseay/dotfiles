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

" Continue with your regularly scheduled programming
set nocompatible 
filetype off 

" Start the vundle stuff
set rtp+=~/.vim/bundle/vundle/
call vundle#rc()

" Install all the packages I like
Bundle 'gmarik/vundle'
Bundle 'tpope/vim-fugitive'
Bundle 'scrooloose/nerdtree'
Bundle 'scrooloose/syntastic'
Bundle "MarcWeber/vim-addon-mw-utils"
Bundle "tomtom/tlib_vim"
Bundle "garbas/vim-snipmate"
Bundle "honza/vim-snippets"
Bundle "hallison/vim-markdown"
Bundle "file:///Users/nickzaccardi/j/utils/inow-snippets/.git"
Bundle "altercation/vim-colors-solarized"

" If this is a fresh install, install the packages
if iCanHazVundle == 0
    echo "Installing Vundle packages"
    echo ""
    :BundleInstall
endif

" Make VIM colorful
syntax enable
set background=dark
colorscheme solarized 

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
map <C-K> :NERDTreeToggle<CR>

" Type jj to get out of insert mode
inoremap jj <esc>

" Save having to hit shift
nnoremap a A
