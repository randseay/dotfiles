# My Dotfiles

## Disclaimer
I was looking for an easier way to manage my dotfiles, using nZac's dotfiles as a baseline.

## Installing the files

```bash
git clone --recursive git@github.com:randseay/dotfiles.git ~/dotfiles
```

### To use the vimrc file just symlink it into place
```bash
ln -s ~/dotfiles/.vimrc ~/.vimrc
```

### To use the zsh configuration you will need a few other things, like antigen and virtualenv_wrapper if you want to use the theme.
```bash
# Make sure you have pip installed
which pip

# install virtualenv
pip install virtualenv

# install the wrapper
pip install virtualenvwrapper

# symlink the zsh file over
ln -s ~/dotfiles/.zshrc ~/.zshrc

# make sure zsh is installed
which zsh

# change your shell to be zsh
chsh -s /path/to/zsh

# restart your terminal session or source ~/.zshrc
```

### License
Do what ever you want with these files, it is nothing more than a compilation of a lot of smart peoples work, I own none of it.
