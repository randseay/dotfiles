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
eval my_yellow='$FG[011]'

# check for super user
if [ $UID -eq 0 ]; then
    uname_color=$my_red;
else
    uname_color=$my_forest;
fi

# check for git repo
function is_git_repo {
    git rev-parse --is-inside-work-tree 2>/dev/null
}

# check for hg repo
function is_hg_repo {
    hg --cwd $PWD root 2>/dev/null
}

# hg repository information
function hg_ps1() {
    hg prompt "{${1}}" 2>/dev/null
}

case $(hg_ps1 status) in
    "!")
        HG_STATUS="%{$my_orange%}±"
        ;;
    "?")
        HG_STATUS="%{$my_orange%}?"
        ;;
    "")
        HG_STATUS="%{$my_green%}✓"
        ;;
esac

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

# git settings
ZSH_THEME_GIT_PROMPT_PREFIX="%{$my_blue%}[ git:  "
ZSH_THEME_GIT_PROMPT_CLEAN="$my_green ✓%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_DIRTY="$my_orange %B±%b%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_SUFFIX="$my_blue ] $my_gray╍╍╍ %{$reset_color%}"

# hg settings
HG_PROMPT_PREFIX="%{$my_purple%}[ hg:  "
HG_PROMPT_SUFFIX="%{$my_purple%} ] $my_gray╍╍╍ "

# pre-command functions
function precmd() {
    RPROMPT="$my_forest$(zshtime)%{$reset_color%}$(batterycharge)"
    if [ $(is_git_repo) ] || [ $(is_hg_repo) ]; then
        ZSH_THEME_VIRTUAL_ENV_PROMPT_SUFFIX="$my_blue ) $my_gray╍╍╍ "
    elif [ ! $(is_git_repo) ] && [ ! $(is_hg_repo) ]; then
        ZSH_THEME_VIRTUAL_ENV_PROMPT_SUFFIX="$my_blue ) $my_gray╍╍╍ "
    else
        ZSH_THEME_VIRTUAL_ENV_PROMPT_SUFFIX="$my_blue ) "
    fi
    if [ $(is_hg_repo) ]; then
        hg_prompt_info="$HG_PROMPT_PREFIX$(hg_ps1 branch) $HG_STATUS$HG_PROMPT_SUFFIX"
    else
        hg_prompt_info=""
    fi
    PWD_PROMPT="$my_forest%B$(abbr_path $(get_pwd_width))%b"
}

# primary prompt
ZSH_THEME_VIRTUAL_ENV_PROMPT_PREFIX="$my_blue( venv: "
PROMPT='$(virtualenv_prompt_info)$(git_prompt_info)$hg_prompt_info$uname_color%n%{$reset_color%} in $PWD_PROMPT
$my_orange%(!.#.→)%{$reset_color%} '
