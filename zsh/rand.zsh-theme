# This is my personal zsh-theme file, it requires oh-my-zsh and
# virtualenv-prompt https://github.com/tonyseek/oh-my-zsh-virtualenv-prompt

if [ $UID -eq 0 ]; then NCOLOR="red"; else NCOLOR="green"; fi
local return_code="%(?..%{$fg[red]%}%? ↵%{$reset_color%})"

# primary prompt
ZSH_THEME_VIRTUAL_ENV_PROMPT_PREFIX="$FG[240]╍╍╍$FG[075] ( venv: "
PROMPT='$(virtualenv_prompt_info)$(git_prompt_info)%{$reset_color%}$my_teal%B${PWD/#$HOME/~}%b
$FG[105]%(!.#.→)%{$reset_color%}  '
PROMPT2='%{$fg[red]%}\ %{$reset_color%}'
RPS1='${return_code}'
 
# color vars
eval my_blue='$FG[075]'
eval my_gray='$FG[240]'
eval my_green='$FG[034]'
eval my_orange='$FG[214]'
eval my_teal='$FG[101]'

# pre-command functions
function precmd() {
    RPROMPT=$(zshtime)$(batterycharge)
    if [ $(git rev-parse --is-inside-work-tree 2>/dev/null) ]; then ZSH_THEME_VIRTUAL_ENV_PROMPT_SUFFIX="$FG[075] ) "; else ZSH_THEME_VIRTUAL_ENV_PROMPT_SUFFIX="$FG[075] ) $FG[240]╍╍╍ "; fi
}
 
# git settings
ZSH_THEME_GIT_PROMPT_PREFIX="$FG[240]╍╍╍$my_blue [ git:  "
ZSH_THEME_GIT_PROMPT_CLEAN="$my_green ✓%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_DIRTY="$my_orange %B±%b%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_SUFFIX="$my_blue ] $FG[240]╍╍╍ %{$reset_color%}"