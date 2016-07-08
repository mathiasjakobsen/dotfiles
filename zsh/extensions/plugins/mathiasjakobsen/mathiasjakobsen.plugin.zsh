TERM=screen-256color-bce

alias mem="egrep --color 'Mem|Cache|Swap' /proc/meminfo"
alias wheather='finger aarhus@graph.no'
alias ez='vim ~/.oh-my-zsh/plugins/mathiasjakobsen/mathiasjakobsen.plugin.zsh'
alias theme="vim ~/.oh-my-zsh/themes/mathiasjakobsen.zsh-theme"
alias gogo="cd ~/go/src/github.com/mathiasjakobsen/"
alias c='clear'
alias here='open . '
alias chmodcode='stat -f "%OLp"'
alias grb='git rebase'
alias pgstart='pg_ctl -D /usr/local/var/postgres -l /usr/local/var/postgres/server.log start'
alias pgstop='pg_ctl -D /usr/local/var/postgres stop -s -m fast'
alias readme='grip -b --user=mathiasjakobsen --pass=$GITHUB_TOKEN'
alias cdg='cd "$(git rev-parse --show-toplevel)"'
alias tm='tmux'
alias tmc='tmux kill-server'
alias jsc='/System/Library/Frameworks/JavaScriptCore.framework/Versions/A/Resources/jsc'
alias httpcode="curl -o /dev/null --silent --head --write-out '%{http_code}\n'"
alias ci="travis"
alias sup="travis whatsup"
alias json-decode="php -r 'print_r(json_decode(file_get_contents(\"php://stdin\")));'"
alias ical="icalBuddy"
alias ip="curl -s ipinfo.io"

daemons() {
  if (( $# == 0 )) then
    echo "Usage: daemons [pattern] [command]"
    echo "\n"
    return
  fi
  daemon_list=`launchctl list|grep "$1" |awk '{print $3}'`
  if (( $# == 1 )) then
    echo $daemon_list
    return
  fi
  if (( $# == 2 )) then
    if [[ $2 == "start" ]] then
      echo 'starting'
      launchctl start $daemon_list
      return
    fi
    if [[ $2 == "stop" ]] then
      echo 'stopping'
      launchctl stop $daemon_list
      return
    fi
    if [[ $2 == "restart" ]] then
      echo 'restarting'
      launchctl stop $daemon_list
      launchctl start $daemon_list
      return
    fi
    echo "'$2' is not a legal command - I only support start, stop and restart"
  fi
}

# Setup default root paths
CDPATH=.:~/Documents/Projects:~/Documents/Projects/private:~/Documents/Projects/work:~/Dropbox:~
# Use vim text as default editor
EDITOR=vim
export EDITOR='vim'

get_path_part() {
  count=${1:-2}
  print -P %$count~
}

set_title_from_path() {
  printf "\033k`get_path_part $1`\033\\"
}


# Ctrl-z resumes app
foreground-vi() {
  fg %vi
}
zle -N foreground-vi
bindkey '^Z' foreground-vi


# complete on words from current tmux buffer (using ctrl+x)
_tmux_pane_words() {
  local expl
  local -a w
  if [[ -z "$TMUX_PANE" ]]; then
    _message "not running inside tmux!"
    return 1
  fi
  w=( ${(u)=$(tmux capture-pane \; show-buffer \; delete-buffer)} )
  _wanted values expl 'words from current tmux pane' compadd -a w
}

now() {
  echo $(date "+%Y-%m-%d %H:%M:%S") "|" $(get_path_part)  "|" "$@" >> $HOME/.now
}

git-php-lint() {
  for file in $(gss |cut -d ' ' -f3); php -l $file
}

git-select-lint() {
  file=$(gss |cut -d ' ' -f3 | selecta); php -l $file
}

git-select-checkout() {
  file=$(gss |cut -d ' ' -f3 | selecta); git checkout $file
}

zle -C tmux-pane-words-prefix   complete-word _generic
zle -C tmux-pane-words-anywhere complete-word _generic
bindkey '^Xt' tmux-pane-words-prefix
bindkey '^X^X' tmux-pane-words-anywhere
zstyle ':completion:tmux-pane-words-(prefix|anywhere):*' completer _tmux_pane_words
zstyle ':completion:tmux-pane-words-(prefix|anywhere):*' ignore-line current
zstyle ':completion:tmux-pane-words-anywhere:*' matcher-list 'b:=* m:{A-Za-z}={a-zA-Z}'

[[ -s $HOME/.tmuxinator/scripts/tmuxinator ]] && source $HOME/.tmuxinator/scripts/tmuxinator
