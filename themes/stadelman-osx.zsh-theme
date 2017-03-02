function prompt_char {
    echo '%(!.!.➜)'
}

function git_prompt_info() {
  local ref
  if [[ "$(command git config --get oh-my-zsh.hide-status 2>/dev/null)" != "1" ]]; then
    ref=$(command git symbolic-ref HEAD 2> /dev/null) || \
    ref=$(command git rev-parse --short HEAD 2> /dev/null) || return 0
    echo "$ZSH_THEME_GIT_PROMPT_PREFIX${ref#refs/heads/}$(git_remote_status)$ZSH_THEME_GIT_PROMPT_SUFFIX"
  fi
}


function get_RAM {
  top -l 1 -s 0 | grep PhysMem | sed -n -e 's/^.*PhysMem: \([0-9]*\)M.*/\1/p' | awk '{printf "%4.2f", $1/1000}'
}

function get_nr_jobs() {
  jobs | wc -l | sed -e "s/^ *//"
}

function get_load() {
  ps -A -o %cpu | awk '{s+=$1} END {printf "%4.2f", s}'
}

# setting the prompts
PROMPT='%{$fg_bold[green]%}%n:%{$fg[cyan]%}%2c%{$fg_bold[blue]%}$(git_prompt_info)$(git_prompt_status)%{$fg_bold[blue]%}%{$fg_bold[red]%}$(prompt_char) % %{$reset_color%}'

RPROMPT='%{$fg_bold[green]%}[$(get_nr_jobs) $(get_RAM)G $(get_load)%%] %*%{$reset_color%}'

# git formatting
ZSH_THEME_GIT_PROMPT_UNTRACKED="%{$fg[yellow]%}?%f"
ZSH_THEME_GIT_PROMPT_MODIFIED="%{$fg_bold[magenta]%}!%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_ADDED="%{$fg[green]%}+%f"
ZSH_THEME_GIT_PROMPT_RENAMED="%{$fg[black]%}R%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_DELETED="%{$fg[red]%}-%f"
ZSH_THEME_GIT_PROMPT_STASHED="%{$fg[white]%}S%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_UNMERGED="%{$fg[white]%}U%{$reset_color%}"

ZSH_THEME_GIT_PROMPT_EQUAL_REMOTE=""
ZSH_THEME_GIT_PROMPT_AHEAD_REMOTE="%{$fg[white]%}\xE2\x86\x91"
ZSH_THEME_GIT_PROMPT_BEHIND_REMOTE="%{$fg[white]%}\xE2\x86\x93"
ZSH_THEME_GIT_PROMPT_DIVERGED_REMOTE="%{$fg[white]%}\xE2\x86\x95"

ZSH_THEME_GIT_PROMPT_PREFIX="(%{$fg[red]%}"
ZSH_THEME_GIT_PROMPT_SUFFIX="%{$fg[blue]%})%{$reset_color%}"
#ZSH_THEME_GIT_PROMPT_DIRTY="%{$fg[blue]%})%{$fg[yellow]%}✗%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_DIRTY="%{$fg[blue]%})"
ZSH_THEME_GIT_PROMPT_CLEAN="%{$fg[blue]%})"
