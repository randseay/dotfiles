source $HOME/dotfiles/antigen/antigen.zsh

# Load the oh-my-zsh's library.
antigen use oh-my-zsh

# Bundles from the default repo (robbyrussell's oh-my-zsh).
antigen bundle git
antigen bundle pip
antigen bundle tonyseek/oh-my-zsh-virtualenv-prompt
antigen bundle brew
antigen bundle sublime
antigen bundle vagrant
antigen bundle virtualenvwrapper

# Syntax highlighting bundle.
antigen bundle zsh-users/zsh-syntax-highlighting

# Load the theme.
antigen theme https://gist.github.com/7885406.git personal

# Tell antigen that you're done.
antigen apply

# Apply my custom things
export PATH=/Users/nickzaccardi/bin:$PATH
alias gs="git status"
