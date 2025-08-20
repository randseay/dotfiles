# This is my personal zsh-theme file
# requirements
#    oh-my-zsh (https://github.com/robbyrussell/oh-my-zsh)
#    virtualenv-prompt (https://github.com/tonyseek/oh-my-zsh-virtualenv-prompt)

# colors
eval color_blue='$FG[075]'
eval color_forest='$FG[101]'
eval color_gray='$FG[240]'
eval color_green='$FG[034]'
eval color_orange='$FG[214]'
eval color_purple='$FG[093]'
eval color_red='$FG[088]'
eval color_yellow='$FG[011]'

# symbols
eval symbol_branch=""
eval symbol_check="✓"
eval symbol_untracked="?"
eval symbol_changes="±"

# check for super user
if [ $UID -eq 0 ]; then
    uname_color=$color_red;
else
    uname_color=$color_forest;
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
ZSH_THEME_GIT_PROMPT_PREFIX="%{$color_blue%}[ git: %{$symbol_branch%} "
ZSH_THEME_GIT_PROMPT_CLEAN="$color_green %{$symbol_check%}%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_DIRTY="$color_orange %B%{$symbol_changes%}%b%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_SUFFIX="$color_blue ] $color_gray╍╍╍ %{$reset_color%}"

# hg settings
HG_PROMPT_PREFIX="%{$color_purple%}[ hg: %{$symbol_branch%} "
HG_PROMPT_SUFFIX="%{$color_purple%} ] $color_gray╍╍╍ "

# pre-command functions
function precmd() {
    RPROMPT="$color_forest$(zshtime)%{$reset_color%}$(batterycharge)"
    case $(hg_ps1 status) in
        '!')
            HG_STATUS="%{$color_orange%}%{$symbol_changes%}"
            ;;
        '?')
            HG_STATUS="%{$color_orange%}%{$symbol_untracked%}"
            ;;
        '')
            HG_STATUS="%{$color_green%}%{$symbol_check%}"
            ;;
    esac
    if [ $(is_git_repo) ] || [ $(is_hg_repo) ]; then
        ZSH_THEME_VIRTUAL_ENV_PROMPT_SUFFIX="$color_blue ) $color_gray╍╍╍ "
    elif [ ! $(is_git_repo) ] && [ ! $(is_hg_repo) ]; then
        ZSH_THEME_VIRTUAL_ENV_PROMPT_SUFFIX="$color_blue ) $color_gray╍╍╍ "
    else
        ZSH_THEME_VIRTUAL_ENV_PROMPT_SUFFIX="$color_blue ) "
    fi
    if [ $(is_hg_repo) ]; then
        hg_prompt_info="$HG_PROMPT_PREFIX$(hg_ps1 branch) $HG_STATUS$HG_PROMPT_SUFFIX"
    else
        hg_prompt_info=""
    fi
    PWD_PROMPT="$color_forest%B$(abbr_path $(get_pwd_width))%b"
}

# primary prompt
ZSH_THEME_VIRTUAL_ENV_PROMPT_PREFIX="$color_blue( venv: "
PROMPT='$(virtualenv_prompt_info)$(git_prompt_info)$hg_prompt_info$uname_color%n@%m%{$reset_color%} in $PWD_PROMPT
$color_orange%(!.#.→)%{$reset_color%} '
