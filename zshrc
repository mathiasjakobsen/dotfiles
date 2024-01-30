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
# export PATH="/opt/homebrew/opt/python/libexec/bin:$PATH"

PATH="/usr/local/opt/ruby/bin:$PATH"
EDITOR=vim
ZSH_THEME=""
ZSH_AUTOSUGGEST_USE_ASYNC=true
HYPHEN_INSENSITIVE="true"
ENABLE_CORRECTION="true"

alias python="$(pyenv which python)"
alias pip="$(pyenv which pip)"
alias c='clear'
alias cdg='cd "$(git rev-parse --show-toplevel)"'
alias chmodcode='stat -f "%OLp"'
alias here='open . '
alias httpcode="curl -o /dev/null --silent --head --write-out '%{http_code}\n'"
alias readme='grip -b --user=mathiasjakobsen --pass=$GITHUB_TOKEN'
alias weather='finger aarhus@graph.no'
alias vim='nvim'
alias db='aws ssm start-session --region eu-central-1 --target i-040ba420f38f4d1e0 --document-name AWS-StartPortForwardingSessionToRemoteHost --parameters host="system.c1es6mhn5vxz.eu-central-1.rds.amazonaws.com",portNumber="3306",localPortNumber="3336"'

listening() {
    if [ $# -eq 0 ]; then
        sudo lsof -iTCP -sTCP:LISTEN -n -P
    elif [ $# -eq 1 ]; then
        sudo lsof -iTCP -sTCP:LISTEN -n -P | grep -i --color $1
    else
        echo "Usage: listening [pattern]"
    fi
}

plugins=(
  battery
  brew
  coffee
  docker
  gem
  git
  git-extras
  macos
  rake
  ruby
  rvm
  tmux
  tmuxinator
)

source /opt/homebrew/share/zsh-autosuggestions/zsh-autosuggestions.zsh
source /opt/homebrew/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source /opt/homebrew/opt/git-extras/share/git-extras/git-extras-completion.zsh
source `brew --prefix`/etc/profile.d/z.sh



export NVM_DIR="$([ -z "${XDG_CONFIG_HOME-}" ] && printf %s "${HOME}/.nvm" || printf %s "${XDG_CONFIG_HOME}/nvm")"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh" # This loads nvm

# export YVM_DIR=/usr/local/opt/yvm
# [ -r $YVM_DIR/yvm.sh ] && . $YVM_DIR/yvm.sh
# export RUBY_CONFIGURE_OPTS="--with-openssl-dir=$(brew --prefix openssl@1.1)"
# eval "$(rbenv init -)"

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

eval "$(rbenv init - zsh)"

source ~/.oh-my-zsh/oh-my-zsh.sh

autoload -U promptinit; promptinit

prompt pure
