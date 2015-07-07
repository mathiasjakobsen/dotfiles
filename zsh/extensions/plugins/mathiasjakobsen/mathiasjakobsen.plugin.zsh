TERM=screen-256color-bce

# Clouds
alias amcloud1='ssh root@cloud1.arnsbomedia.com'
alias amdb='ssh root@db.arnsbomedia.com'
alias amsystem='root@system.arnsbomedia.com'
alias cloud='ssh root@46.101.150.8'
alias dbslave='ssh 64.49.237.57'



alias tc="~/Scripts/tmux-copy-session.sh"
alias editzsh='vim ~/.oh-my-zsh/plugins/cw/cw.plugin.zsh'
alias ez="editzsh"
alias theme="vim ~/.oh-my-zsh/themes/mathiasjakobsen.zsh-theme"

alias c='clear'
alias here='open . '
alias dup='open . -a "iTerm.app"'
alias deck='open -a "DeckSet.app"'
alias chmodcode='stat -f "%OLp"'
alias grb='git rebase'
alias conf='cp ~/Work/conf-files/systemet-configuration.json ~/Work/systemet/Application/settings/configuration.json'
alias pgstart='pg_ctl -D /usr/local/var/postgres -l /usr/local/var/postgres/server.log start'
alias pgstop='pg_ctl -D /usr/local/var/postgres stop -s -m fast'

alias cdg='cd "$(git rev-parse --show-toplevel)"'
alias tm='tmux'
alias tmc='tmux kill-server'

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

newpost() {
  middleman article $1
  vim `gsts |awk '{print \$2}'`
}


alias jsc='/System/Library/Frameworks/JavaScriptCore.framework/Versions/A/Resources/jsc'
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

alias nw="/Applications/node-webkit.app/Contents/MacOS/node-webkit"

zle -C tmux-pane-words-prefix   complete-word _generic
zle -C tmux-pane-words-anywhere complete-word _generic
bindkey '^Xt' tmux-pane-words-prefix
bindkey '^X^X' tmux-pane-words-anywhere
zstyle ':completion:tmux-pane-words-(prefix|anywhere):*' completer _tmux_pane_words
zstyle ':completion:tmux-pane-words-(prefix|anywhere):*' ignore-line current
zstyle ':completion:tmux-pane-words-anywhere:*' matcher-list 'b:=* m:{A-Za-z}={a-zA-Z}'

[[ -s $HOME/.tmuxinator/scripts/tmuxinator ]] && source $HOME/.tmuxinator/scripts/tmuxinator