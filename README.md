# My Personal Dotfiles

## Disclamer
Many before me have published dotfiles for others to look at and in an effort to give back... not that I think anyone should use these... I thought it might be good to put mine out there.

I am new to VIM, so my vimrc probably isn't all that awsome though over time I hope it improves.

## Installing the files
Unlike some other folks dotfiles repositories, there is no bash/zsh/python/ruby/insert-language-here script that will automatically install these.  My process is simple though...

```bash
git clone --recursive git@github.com:nZac/dotfiles.git ~/dotfiles
```

# To use my vimrc file just symlink it into place
```bash
ln -s ~/dotfiles/.vimrc ~/.vimrc
```

# To use the zsh configuration you will need a few other things, like antigen and virtualenv_wrapper if you want to use my theme.
```bash
ln -s ~/dotfiles/.zshrc ~/.zshrc
```

## License
Do what ever you want with these files, it is nothing more than a compilation of a lot of smart peoples work, I own none of it.
