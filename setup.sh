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

vim +BundleInstall +qall

echo "linking up the gitconfig"
ln -sfv $DOTFILES/.global_gitignore $HOME/.global_gitignore
git config --global core.excludesfile ~/.global_gitignore

