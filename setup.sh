git clone --recursive https://github.com/randseay/dotfiles.git $HOME/dotfiles

echo "Creating environment variables..."
export DOTFILES=$HOME/dotfiles

echo "installing fonts"
mkdir -p $HOME/.fonts
cp -r $DOTFILES/fonts/* $HOME/.fonts

echo "setting up zsh"
ln -sfv $DOTFILES/.zshrc $HOME/.zshrc  

echo "setting up vim"
ln -sfv $DOTFILES/.vimrc $HOME/.vimrc

mkdir -p $HOME/.vim/spell/
ln -sfv $DOTFILES/vim/spell/en.utf-8.spl $HOME/.vim/spell/
vim +BundleInstall +qall

echo "setting up git configuration"
ln -sfv $DOTFILES/.global_gitignore $HOME/.global_gitignore
git config --global core.excludesfile ~/.global_gitignore
git config --global alias.abort 'reset --hard HEAD'
git config --global alias.br 'branch'
git config --global alias.ci 'commit'
git config --global alias.co 'checkout'
git config --global alias.fancy 'fancy = log --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(cyan)<%an>%Creset' --abbrev-commit --date=relative'
git config --global alias.last 'log -1 HEAD'
git config --global alias.ls 'branch -av'
git config --global alias.oops 'reset --soft HEAD~1'
git config --global alias.pop 'stash pop --index'
git config --global alias.save 'stash save'
git config --global alias.st 'status'
git config --global alias.undo 'reset --hard'
git config --global alias.unstage 'reset'

if [[ "$OSTYPE" == "darwin"* ]]; then
    defaults write -g ApplePressAndHoldEnabled -bool false
    defaults write -g KeyRepeat .01
    defualts write -g InitialKeyReapt 1.5
    defaults write com.apple.dock expose-animation-duration ; killall Dock
fi
