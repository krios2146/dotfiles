PROMPT=' %{$fg[green]%}%c%{$reset_color%} $(git_prompt_info) %(?:%{$fg[yellow]%}%1{➜%}:%{$fg[red]%}%1{➜%}) '
PROMPT+='%{$reset_color%}'

RPROMPT='$(virtualenv_prompt_info) $(git_prompt_status)'

ZSH_THEME_GIT_PROMPT_PREFIX="%{$fg[blue]%} %{$fg[cyan]%}"
ZSH_THEME_GIT_PROMPT_SUFFIX="%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_DIRTY=" ✘"
ZSH_THEME_GIT_PROMPT_CLEAN=""
ZSH_THEME_GIT_PROMPT_AHEAD="%{$fg[green]%}▲ $(git_commits_ahead)%{$reset_color%} "
ZSH_THEME_GIT_PROMPT_BEHIND="%{$fg[blue]%}▼ $(git_commits_behind)%{$reset_color%} "
ZSH_THEME_GIT_PROMPT_UNTRACKED="%{$fg[red]%}○%{$reset_color%} "
ZSH_THEME_GIT_PROMPT_ADDED="%{$fg[green]%}+%{$reset_color%} "
ZSH_THEME_GIT_PROMPT_MODIFIED="%{$fg[yellow]%}●%{$reset_color%} "
ZSH_THEME_GIT_PROMPT_RENAMED="%{$fg[yellow]%}◉%{$reset_color%} "
ZSH_THEME_GIT_PROMPT_DELETED="%{$fg[red]%}×%{$reset_color%} "
ZSH_THEME_GIT_PROMPT_UNMERGED="%{$fg[red]%}⊗%{$reset_color%} "
ZSH_THEME_GIT_PROMPT_DIVERGED="%{$fg[red]%}⇵%{$reset_color%} "
ZSH_THEME_GIT_PROMPT_STASHED="%{$fg[cyan]%}◌%{$reset_color%} "

ZSH_THEME_VIRTUALENV_PREFIX="(%{$fg[yellow]%}"
ZSH_THEME_VIRTUALENV_SUFFIX="%{$reset_color%})"
