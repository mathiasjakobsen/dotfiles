local ret_status="%(?:%{$fg_bold[green]%}➜ :%{$fg_bold[red]%}➜ %s)"
PROMPT='${ret_status}%{$fg_bold[green]%}%p %{$fg[cyan]%}%c %{$fg_bold[blue]%}$(git_prompt_info)%{$fg_bold[blue]%} % %{$reset_color%}'

RPROMPT='$(rvm-prompt)  $EPS1'

function get_pwd() {
  echo "${PWD/$HOME/~}"
}

PROMPT='
%{$fg[magenta]%}%n%{$reset_color%} at %{$fg[yellow]%}%m%{$reset_color%} in %{$fg[cyan]%}%~%  %{$fg_bold[blue]%}$(git_prompt_info)
%{$reset_color%}%B→%b '



ZSH_THEME_GIT_PROMPT_PREFIX="%{$reset_color%}on %{$fg[blue]%}"
ZSH_THEME_GIT_PROMPT_SUFFIX="%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_DIRTY="%{$fg[blue]%} %{$fg[red]%}✗%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_CLEAN="%{$fg[blue]%} %{$fg[white]%}✓%{$reset_color%}"
