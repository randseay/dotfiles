git clone --recursive https://github.com/nZac/dotfiles.git $HOME/dotfiles

echo "Creating environment variables..."
export DOTFILES=$HOME/dotfiles

echo "installing fonts"
mkdir -p $HOME/.fonts
cp -r $DOTFILES/fonts/* $HOME/.fonts

echo "linking zsh"
ln -sfv $DOTFILES/.zshrc $HOME/.zshrc  

echo "setting up vim"
ln -sfv $DOTFILES/.vimrc $HOME/.vimrc

mkdir -p $HOME/.vim/spell/
ln -sfv $DOTFILES/vim/spell/en.utf-8.spl $HOME/.vim/spell/
vim +BundleInstall +qall

echo "linking up the gitconfig"
ln -sfv $DOTFILES/.global_gitignore $HOME/.global_gitignore
git config --global core.excludesfile ~/.global_gitignore

if [[ "$OSTYPE" == "darwin"* ]]; then
    defaults write -g ApplePressAndHoldEnabled -bool false
    defaults write -g KeyRepeat .01
    defualts write -g InitialKeyReapt 1.5
    defaults write com.apple.dock expose-animation-duration ; killall Dock
fi
