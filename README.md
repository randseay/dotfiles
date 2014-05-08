# My Dotfiles

I was looking for an easier way to manage my dotfiles, using nZac's dotfiles as a baseline.

## Installation

Start by pulling down the repository.

```bash
git clone --recursive git@github.com:randseay/dotfiles.git ~/dotfiles
```

I use [Homebrew](http://brew.sh/) to manage packages, so if you are going that route, you will need to set it up (It requires Ruby, which comes prepackaged on Mac OSX). The `setup` script will not be happy without Homebrew. Here's how to get it.

```bash
ruby -e "$(curl -fsSL https://raw.github.com/Homebrew/homebrew/go/install)"
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

To use the zsh configuration you will need a few other things, like antigen and virtualenv_wrapper, specifically if you want to use the theme. These steps are baked into the setup script, but you can do them manually. Just make sure you have zsh and pip installed.

```bash
which zsh
which pip
```

Clone the repository, if you haven't already.

```bash
git clone --recursive git@github.com:randseay/dotfiles.git ~/dotfiles
```

Then install the requirements, virtualenv and virtualenvwrapper.

```bash
pip install -r ~/dotfiles/requirements.txt
```

You may consider making a backup of the `.zshrc` file.

```bash
cp ~/.zshrc ~/.zshrc_backup
```

Then symlink the `.zshrc` file into place.

```bash
ln -sfv ~/dotfiles/zsh/.zshrc ~/.zshrc
```

### vim

The vim setup is fairly self-contained, and although vim comes with Mac OS X, I opt for the one you can get through Homebrew.

```bash
brew install vim
```

Clone the repository, if you haven't already.

```bash
git clone --recursive git@github.com:randseay/dotfiles.git ~/dotfiles
```

You may consider making a backup of the `.vimrc`. If you don't have one, don't worry about it.

```bash
cp ~/.vimrc ~/.vimrc_backup
```

Then symlink the `.zshrc` file into place.

```bash
ln -sfv ~/dotfiles/vim/.vimrc ~/.vimrc
```

### git

The git configuration is relativey standalone (the `setup` script helps speed up some of the steps), and once again Homebrew can help you get started.

```bash
brew install git
```

Clone the repository, if you haven't already.

```bash
git clone --recursive git@github.com:randseay/dotfiles.git ~/dotfiles
```

You may consider making a backup of the `.gitconfig` file.

```bash
cp ~/.gitcofig ~/.gitconfig_backup
```

Then symlink the `.gitconfig` file into place.

```bash
ln -sfv ~/dotfiles/git/.gitconfig $HOME/.gitconfig
```

I like to use a `gitignore_global` file to avoid file types that I always want git to ignore. If you have one, backing it up is not the worst idea.

```bash
cp ~/.gitignore_global ~/.gitignore_global_backup
```

Then symlink the `.gitignore_global` file into place.

```bash
ln -sfv ~/dotfiles/git/.gitignore_global ~/.gitignore_global
```

Now tell git to use it as its main `excludesfile`.

```bash
git config --global core.excludesfile ~/.gitignore_global
```

Since the default user name and email are placeholders, you'll need to change them to suit your purposes.

```bash
git config --global user.name "Your Name"
git config --gloval user.email youremail@email.com
```

### OS X Settings

Here are a couple of OS X settings that help make life with your Mac much smoother.

```bash
# make held keys repeat
defaults write -g ApplePressAndHoldEnabled -bool false

# speed up key repeat
defaults write -g KeyRepeat .01

# speed up initial key repeat
defualts write -g InitialKeyReapt 1.5

# remove the auto-hide dock delay
defaults write com.apple.Dock autohide-delay -float 0; killall Dock

# speed up mission control animations
defaults write com.apple.dock expose-animation-duration -float 0.1; killall Dock

# always show user library directory
chflags nohidden ~/Library/
```

After you change what you want, you may need to restart your shell or dock

```bash
# exit shell
exit

# restart the dock
killall Dock
```

## License
Do what ever you want with these files.
