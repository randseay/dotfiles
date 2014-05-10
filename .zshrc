source $HOME/dotfiles/antigen/antigen.zsh

# Apply my custom things
export PATH=$HOME/bin:/usr/local/bin:/usr/bin:/usr/sbin:/bin:/sbin

# Setup some environment variables 
export WORKON_HOME=$HOME/.virtualenvs
export PROJECT_HOME=$HOME/j
export VIRTUALENVWRAPPER_PYTHON=/usr/local/bin/python

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
antigen theme https://gist.github.com/7885406.git personal

# Tell antigen that you're done.
antigen apply

# Set up pyenv
if which pyenv > /dev/null; then
    eval "$(pyenv init -)"
    export PYENV_VIRTUALENVWRAPPER_PREFER_PYVENV="true"
    pyenv virtualenvwrapper_lazy
fi

# Setup gopath
# export GOPATH=$HOME/j/oss/gocode
# export PATH=$PATH:$GOPATH/bin

# Setup aliases
alias ohmyzsh="vim ~/dotfiles/.oh-my-zsh"
alias vimconfig="vim ~/dotfiles/.vimrc"
alias zshconfig="vim ~/dotfiles/.zshrc"
alias gs="git status"
alias gco="git checkout"

# Customize to your needs...
source /usr/local/bin/virtualenvwrapper.sh
source $ZSH/oh-my-zsh.sh