function prompt_char {
    echo '%(!.!.➜)'
}

function get_RAM {
  free -m | awk '{if (NR==2) print $7}' | xargs -i echo 'scale=1;{}/1000' | bc
}

function get_nr_jobs() {
  jobs | wc -l
}

function get_nr_CPUs() {
  grep -c "^processor" /proc/cpuinfo
}

function get_load() {
    load=$(uptime | awk '{print $11}' | tr -d ',')
    load=$((100*load/4.0))
    printf "%.*f" 2  $load;
}

# setting the prompts
PROMPT='%{$fg_bold[green]%}%n:%{$fg[cyan]%}%2c%{$fg_bold[blue]%}$(git_prompt_info)$(git_prompt_status)%{$fg_bold[blue]%}%{$fg_bold[red]%}$(prompt_char) % %{$reset_color%}'

RPROMPT='%{$fg[black]%}[$(get_nr_jobs) $(get_RAM)G $(get_load)%%] %*%{$reset_color%}'

# git formatting
ZSH_THEME_GIT_PROMPT_UNTRACKED="%{$fg[yellow]%}?%f"
ZSH_THEME_GIT_PROMPT_MODIFIED="%{$fg_bold[magenta]%}!%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_ADDED="%{$fg[green]%}+%f"
ZSH_THEME_GIT_PROMPT_RENAMED="%{$fg[black]%}R%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_DELETED="%{$fg[red]%}-%f"
ZSH_THEME_GIT_PROMPT_STASHED="%{$fg[white]%}S%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_UNMERGED="%{$fg[white]%}U%{$reset_color%}"

ZSH_THEME_GIT_PROMPT_EQUAL_REMOTE="="
ZSH_THEME_GIT_PROMPT_AHEAD_REMOTE="\E2\x86\x91"
ZSH_THEME_GIT_PROMPT_BEHIND_REMOTE="\E2\x86\x93"
ZSH_THEME_GIT_PROMPT_DIVERGED_REMOTE="\xE2\x86\x95"

ZSH_THEME_GIT_PROMPT_PREFIX="(%{$fg[red]%}"
ZSH_THEME_GIT_PROMPT_SUFFIX="%{$reset_color%}"
#ZSH_THEME_GIT_PROMPT_DIRTY="%{$fg[blue]%})%{$fg[yellow]%}✗%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_DIRTY="%{$fg[blue]%})"
ZSH_THEME_GIT_PROMPT_CLEAN="%{$fg[blue]%})"
