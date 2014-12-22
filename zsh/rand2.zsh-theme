# This is my personal zsh-theme file
# requirements
#    oh-my-zsh (https://github.com/robbyrussell/oh-my-zsh)
#    virtualenv-prompt (https://github.com/tonyseek/oh-my-zsh-virtualenv-prompt)

# colors
eval my_blue='$FG[075]'
eval my_forest='$FG[101]'
eval my_gray='$FG[240]'
eval my_green='$FG[034]'
eval my_orange='$FG[214]'
eval my_purple='$FG[093]'
eval my_red='$FG[088]'

# check for super user
if [ $UID -eq 0 ]; then
    uname_color=$my_red;
else
    uname_color=$my_forest;
fi

local return_code="%(?..%{$fg[red]%}%? ↵%{$reset_color%})"

function get_pwd_width() {

  git_info=$(git_prompt_info)
  if [ ${#git_info} != 0 ]; then
    ((git_len=${#git_info} - 98))
  else
    git_len=0
  fi

  venv_info=$(virtualenv_prompt_info)
  if [ ${#venv_info} != 0 ]; then
    if [ ${#git_info} != 0 ]; then
      ((venv_len=${#venv_info} - 42))
    else
      ((venv_len=${#venv_info} - 58))
    fi
  else
    venv_len=0
  fi

  local pwd_width
  (( pwd_width = ${COLUMNS} - ${venv_len} - ${git_len} -1 ))

  echo $pwd_width
}

# primary prompt
ZSH_THEME_VIRTUAL_ENV_PROMPT_PREFIX="$my_blue ( venv: "
PROMPT='$(virtualenv_prompt_info)$(git_prompt_info)$PWD_PROMPT
$uname_color\u $FG[105]%(!.#.→)%{$reset_color%} '
# PROMPT2='%{$fg[red]%}\ %{$reset_color%}'
# RPS1='${return_code}'


# pre-command functions
function precmd() {
    RPROMPT="$my_forest$(zshtime)%{$reset_color%}$(batterycharge)"
    if [ $(git rev-parse --is-inside-work-tree 2>/dev/null) ]; then
        ZSH_THEME_VIRTUAL_ENV_PROMPT_SUFFIX="$FG[075] ) ";
    else
        ZSH_THEME_VIRTUAL_ENV_PROMPT_SUFFIX="$FG[075] ) $FG[240]╍╍╍ ";
    fi
    PWD_PROMPT="$my_forest%B$(abbr_path $(get_pwd_width))%b"
}

# git settings
ZSH_THEME_GIT_PROMPT_PREFIX="$FG[240]╍╍╍$my_blue [ git:  "
ZSH_THEME_GIT_PROMPT_CLEAN="$my_green ✓%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_DIRTY="$my_orange %B±%b%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_SUFFIX="$my_blue ] $FG[240]╍╍╍ %{$reset_color%}"
