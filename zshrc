export LC_ALL=en_US.UTF-8

export PATH="$HOME/bin:$PATH"
export PATH="/usr/local/bin:/usr/local/sbin:$PATH"
export PATH="$PATH:$HOME/go/bin"
export PATH="/usr/local/opt/php/bin:$PATH"
export PATH="/usr/local/opt/php/sbin:$PATH"
export PATH="/usr/local/opt/openjdk/bin:$PATH"
export PATH="/usr/local/opt/mysql@5.7/bin:$PATH"
export PATH="/usr/local/opt/php@7.4/bin:$PATH"
export PATH="/usr/local/opt/php@7.4/sbin:$PATH"
export PATH=$PATH:~/.npm/node_modules/.bin # Global modules


PATH="/usr/local/opt/ruby/bin:$PATH"
EDITOR=vim
ZSH_THEME=""
ZSH_AUTOSUGGEST_USE_ASYNC=true
HYPHEN_INSENSITIVE="true"
ENABLE_CORRECTION="true"

alias c='clear'
alias cdg='cd "$(git rev-parse --show-toplevel)"'
alias chmodcode='stat -f "%OLp"'
alias here='open . '
alias httpcode="curl -o /dev/null --silent --head --write-out '%{http_code}\n'"
alias readme='grip -b --user=mathiasjakobsen --pass=$GITHUB_TOKEN'
alias weather='finger aarhus@graph.no'

plugins=(
  battery
  brew
  coffee
  docker
  gem
  git
  git-extras
  osx
  rake
  ruby
  rvm
  tmux
  tmuxinator
  zsh-syntax-highlighting
)

source /opt/homebrew/share/zsh-autosuggestions/zsh-autosuggestions.zsh
source /opt/homebrew/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source /opt/homebrew/opt/git-extras/share/git-extras/git-extras-completion.zsh
source `brew --prefix`/etc/profile.d/z.sh

autoload -U promptinit; promptinit

prompt pure


export NVM_DIR=$HOME/.nvm
nvm_load () { . $NVM_DIR/nvm.sh && . $NVM_DIR/bash_completion; }
alias node='unalias node; nvm_load; node $@'
alias npm=' unalias npm;  nvm_load; npm  $@'


# export YVM_DIR=/usr/local/opt/yvm
# [ -r $YVM_DIR/yvm.sh ] && . $YVM_DIR/yvm.sh
# export RUBY_CONFIGURE_OPTS="--with-openssl-dir=$(brew --prefix openssl@1.1)"
# eval "$(rbenv init -)"
