# This is my personal zsh-theme file, it requires oh-my-zsh and
# virtualenv-prompt https://github.com/tonyseek/oh-my-zsh-virtualenv-prompt

if [ $UID -eq 0 ]; then NCOLOR="red"; else NCOLOR="green"; fi
local return_code="%(?..%{$fg[red]%}%? ↵%{$reset_color%})"

CURRENT_TIME_=" %T%{$reset_color%}"
R_DIR_TIME_='$my_gray${PWD/#$HOME/~}$CURRENT_TIME_%{$reset_color%} '
ZSH_THEME_VIRTUAL_ENV_PROMPT_PREFIX="$FG[240]-----$FG[075] ( venv: "
ZSH_THEME_VIRTUAL_ENV_PROMPT_SUFFIX="$FG[075] ) $FG[240]-----"

# primary prompt
PROMPT='$(virtualenv_prompt_info) $(git_prompt_info)%{$reset_color%}
$FG[105]%(!.#.→)%{$reset_color%} '
PROMPT2='%{$fg[red]%}\ %{$reset_color%}'
RPS1='${return_code}'
 
# color vars
eval my_gray='$FG[240]'
eval my_orange='$FG[214]'

# right prompt
function precmd() {
    RPROMPT=${R_DIR_TIME_}$(batcharge)
}
 
# git settings
ZSH_THEME_GIT_PROMPT_PREFIX="$FG[240]-----$FG[075] [ git: "
ZSH_THEME_GIT_PROMPT_CLEAN=""
ZSH_THEME_GIT_PROMPT_DIRTY="$my_orange !%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_SUFFIX="$FG[075] ] $FG[240]-----%{$reset_color%}"