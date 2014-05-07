git clone --recursive https://github.com/randseay/dotfiles.git $HOME/dotfiles

echo "Creating environment variables..."
export DOTFILES=$HOME/dotfiles

# Install Fonts
echo "checking fonts"
if [ -d "$HOME/.fonts" ]
then
    echo ".fonts directory already exists, skipping ahead"
else
    echo "installing fonts"
    mkdir -p $HOME/.fonts
    cp -r $DOTFILES/fonts/* $HOME/.fonts
fi

# ZSH Setup
echo "setting up zsh"
if [ -f "$HOME/.zshrc" ]
then
    echo ".zshrc already exists, backing it up"
    cp $HOME/.zshrc $DOTFILES/.dotfile_backups/original/.zshrc_backup
fi
echo "linking .zshrc"
ln -sfv $DOTFILES/zsh/.zshrc $HOME/.zshrc  

# Vim Setup
echo "setting up vim"
if [ -f "$HOME/.vimrc" ]
then
    echo ".vimrc already exists, backing it up"
    cp $HOME/.vimrc $DOTFILES/.dotfile_backups/original/.vimrc_backup
fi
echo "linking .vimrc"
ln -sfv $DOTFILES/vim/.vimrc $HOME/.vimrc

mkdir -p $HOME/.vim/spell/
ln -sfv $DOTFILES/vim/spell/en.utf-8.spl $HOME/.vim/spell/
echo "installing vim bundles"
vim +BundleInstall +qall

# Git Setup
echo "setting up git configuration"
if [ -f "$HOME/.gitconfig" ]
then
    echo ".gitconfig alread exists, backing it up"
    cp $HOME/.gitconfig $DOTFILES/.dotfile_backups/original/.gitconfig_backup
fi
echo "linking .gitconfig"
ln -sfv $DOTFILES/git/.gitconfig $HOME/.gitconfig

if [ -f "$HOME/.gitignore_global" ]
then
    echo ".gitignore_global already exists, backing it up"
    cp $HOME/.gitignore_global $DOTFILES/.dotfile_backups/original/.gitignore_global_backup
fi
echo "linking .gitignore_global"
ln -sfv $DOTFILES/git/.gitignore_global $HOME/.gitignore_global
git config --global core.excludesfile ~/.gitignore_global

if [ -f "$HOME/.is_work_machine" ]
then
    echo "this is a work machine, clearing git user"
    git config --global user.name ""
    git config --global user.email ""
else
    echo "this is not a work machine, setting up git user normally"
    git config --global user.name "Rand Seay"
    git config --global user.email rand.seay@gmail.com
fi

# Mac Preference Setup
if [[ "$OSTYPE" == "darwin"* ]]; then
    echo "darwin OS found, setting preferences"
    defaults write -g ApplePressAndHoldEnabled -bool false
    defaults write -g KeyRepeat .01
    defualts write -g InitialKeyReapt 1.5
    defaults write com.apple.dock expose-animation-duration ; killall Dock
fi
