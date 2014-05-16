source $HOME/dotfiles/antigen/antigen.zsh

# Apply my custom things
export PATH=$HOME/bin:/usr/local/bin:/usr/bin:/usr/sbin:/bin:/sbin

# Setup some environment variables 
export WORKON_HOME=$HOME/.virtualenvs
export PROJECT_HOME=$HOME/j

# Load oh-my-zsh library.
antigen use oh-my-zsh

# Bundles from the default repo (robbyrussell's oh-my-zsh).
antigen bundle brew
antigen bundle git
antigen bundle git-flow
antigen bundle pip
antigen bundle osx
antigen bundle sublime
antigen bundle vagrant
antigen bundle virtualenv
antigen bundle virtualenvwrapper

# Personal theme requires this
antigen bundle tonyseek/oh-my-zsh-virtualenv-prompt

# Syntax highlighting bundle.
antigen bundle zsh-users/zsh-syntax-highlighting

# Load personal theme.
# antigen theme randseay/dotfiles zsh/rand
antigen theme https://gist.github.com/randseay/b106748a423b38250835 rand

# Tell antigen that you're done.
antigen apply

# Set up pyenv
eval "$(pyenv init -)"
pyenv virtualenvwrapper

# Setup gopath
export GOPATH=$HOME/j/oss/gocode

export PATH=$PATH:$GOPATH/bin

# Setup aliases
alias batterycharge="~/dotfiles/zsh/batcharge.py"
alias git_find_replace_author="~/dotfiles/git/git_find_replace_author"
alias gs="git status"
alias gco="git checkout"
alias ohmyzsh="vim ~/dotfiles/.oh-my-zsh"
alias vimconfig="vim ~/dotfiles/vim/.vimrc"
alias zshconfig="vim ~/dotfiles/zsh/.zshrc"
alias zshtime="~/dotfiles/zsh/zsh_day_time.py"

# source $ZSH/oh-my-zsh.sh

# Customize to your needs...
# export PATH=/usr/local/bin:$PATH:/usr/bin:/bin:/usr/sbin:/sbin
# export WORKON_HOME=~/.virtualenvs
# source /usr/local/bin/virtualenvwrapper.sh
