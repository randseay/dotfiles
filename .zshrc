source $HOME/dotfiles/antigen/antigen.zsh

# Load oh-my-zsh library.
antigen use oh-my-zsh

# Bundles from the default repo (robbyrussell's oh-my-zsh).
antigen bundle git

# as a python develop, pip assistance is nice
antigen bundle pip

# I use this in the them I use
antigen bundle tonyseek/oh-my-zsh-virtualenv-prompt

# For my work mac
antigen bundle brew

# When I use sublime I like to launch it from the command line
antigen bundle sublime

# I use vagrant at work and at home
antigen bundle vagrant

# gives virtualenv support
antigen bundle virtualenvwrapper

# Syntax highlighting bundle.
antigen bundle zsh-users/zsh-syntax-highlighting

# Load the theme.
antigen theme https://gist.github.com/7885406.git personal

# Tell antigen that you're done.
antigen apply

# Apply my custom things
export PATH=$HOME/bin:/usr/local/bin:/usr/bin:/usr/sbin:/bin:/sbin
alias gs="git status"
alias lla="ls -la"
