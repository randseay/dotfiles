source $HOME/dotfiles/antigen/antigen.zsh

# Apply my custom things
export PATH=$HOME/bin:/usr/local/bin:/usr/bin:/usr/sbin:/bin:/sbin
export PATH="$HOME/.rbenv/bin:$PATH"
export PATH="$HOME/anaconda/bin:$PATH"
export DOTFILES=$HOME/dotfiles

# Setup some environment variables
export WORKON_HOME=$HOME/.virtualenvs
export PROJECT_HOME=$HOME/Dev
export SITES_ROOT=$HOME/Dev/ndus/und
export FORD_DIR=$HOME/Dev/ndus/ford
export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8
export EDITOR=vim

# Load oh-my-zsh library.
antigen use oh-my-zsh

# Bundles from the default repo (robbyrussell's oh-my-zsh).
antigen bundle bower
antigen bundle brew
antigen bundle copydir
antigen bundle copyfile
antigen bundle git
antigen bundle git-flow
antigen bundle npm
antigen bundle osx
antigen bundle pip
antigen bundle python
antigen bundle sublime
antigen bundle vagrant
antigen bundle virtualenv
antigen bundle virtualenvwrapper
antigen bundle zsh-users/zsh-syntax-highlighting

# Personal theme requires this
antigen bundle tonyseek/oh-my-zsh-virtualenv-prompt

# Syntax highlighting bundle.
# antigen bundle zsh-users/zsh-syntax-highlighting
# source $HOME/.oh-my-zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# Load personal theme.
antigen theme randseay/dotfiles zsh/rand2

# Make root prompt the same
export ROOT_PS1=$PS1

# Tell antigen that you're done.
antigen apply

# Set up pyenv
eval "$(pyenv init -)"
pyenv virtualenvwrapper

# Set up rbenv
eval "$(rbenv init -)"
export RBENV_VERSION=2.2.0

# Setup gopath
export GOPATH=$HOME/j/oss/gocode

export PATH=$PATH:$GOPATH/bin

# Setup aliases
alias gs="git status"
alias abbr_path="~/dotfiles/zsh/abbr_path.py"
alias batterycharge="~/dotfiles/zsh/batcharge.py"
function ford() { ~/dotfiles/zsh/ford "$@" }
alias git_find_replace_author="~/dotfiles/git/git_find_replace_author"
alias ohmyzsh="vim ~/dotfiles/.oh-my-zsh"
alias vimconfig="vim ~/dotfiles/vim/.vimrc"
alias zshconfig="vim ~/dotfiles/zsh/.zshrc"
alias zshtime="~/dotfiles/zsh/zsh_day_time.py"

# source $ZSH/oh-my-zsh.sh

# Customize to your needs...
# export PATH=/usr/local/bin:$PATH:/usr/bin:/bin:/usr/sbin:/sbin
# export WORKON_HOME=~/.virtualenvs
# source /usr/local/bin/virtualenvwrapper.sh
