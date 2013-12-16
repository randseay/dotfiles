# My Personal Dotfiles

## Disclamer
Many before me have published dotfiles for others to look at and in an effort to give back... not that I think anyone should use these... I thought it might be good to put mine out there.

I am new to VIM, so my vimrc probably isn't all that awsome though over time I hope it improves.

## Installing the files
Unlike some other folks dotfiles repositories, there is no bash/zsh/python/ruby/insert-language-here script that will automatically install these.  My process is simple though...

```bash
git clone --recursive git@github.com:nZac/dotfiles.git ~/dotfiles
```

### To use my vimrc file just symlink it into place
```bash
ln -s ~/dotfiles/.vimrc ~/.vimrc
```

### To use the zsh configuration you will need a few other things, like antigen and virtualenv_wrapper if you want to use my theme.
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

If you have questions let me know and I can try to help as best I can

### License
Do what ever you want with these files, it is nothing more than a compilation of a lot of smart peoples work, I own none of it.
