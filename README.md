# My Dotfiles

I was looking for an easier way to manage my dotfiles, using nZac's dotfiles as a baseline.

## Installation

Start by pulling down the repository

```bash
git clone --recursive git@github.com:randseay/dotfiles.git ~/dotfiles
```

The `setup` script should be able to handle the rest of the installation, you just have a couple of prompts to respond to.

```bash
./setup
```

## Uninstallation

If you would like to remove the dotfiles, the `uninstall` script can do that for you. It removes the files and restores your original configurations (if there were any), in addition to giving you the option of deleting the repository.

```bash
./uninstall
```

## Cherry-Picking

It is not necessary to use all of the settings in the repository, if you would like to cherry-pick one or multiple, creating specific symlinks should do this for you.

### zsh

To use the zsh configuration you will need a few other things, like antigen and virtualenv_wrapper, specifically if you want to use the theme.

```bash
# zsh
ln -sfv $DOTFILES/zsh/.zshrc $HOME/.zshrc

# vim
ln -sfv $DOTFILES/vim/.vimrc $HOME/.vimrc

# git
ln -sfv $DOTFILES/git/.gitconfig $HOME/.gitconfig
```

```bash
```

# Make sure you have pip installed
which pip

# install virtualenv
pip install virtualenv

# install the wrapper
pip install virtualenvwrapper

# make sure zsh is installed
which zsh

# change your shell to be zsh
chsh -s /path/to/zsh

# restart your terminal session or source ~/.zshrc
```

### License
Do what ever you want with these files, it is nothing more than a compilation of a lot of smart peoples work, I own none of it.
