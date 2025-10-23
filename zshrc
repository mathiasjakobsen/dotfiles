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
# alias db='aws ssm start-session --region eu-central-1 --target i-02b6a9d670817de8f --document-name AWS-StartPortForwardingSessionToRemoteHost --parameters host="system.c1es6mhn5vxz.eu-central-1.rds.amazonaws.com",portNumber="3306",localPortNumber="3336"'

aws_db() {
  bastion=$1
  host=$2
  port=$3
  localPort=$4
  target=$(aws ec2 describe-instances --filters "Name=tag:Name,Values=$bastion" --query "Reservations[*].Instances[*].InstanceId" --output text)
  echo "$host tunneled from port $port to local port $localPort"
  aws ssm start-session --region eu-central-1 --target $target --document-name AWS-StartPortForwardingSessionToRemoteHost --parameters host="$host",portNumber="$port",localPortNumber="$localPort"
}


alias db_ame='aws_db "Bastion2Host" "system-blue.c1es6mhn5vxz.eu-central-1.rds.amazonaws.com" 3306 3331'
alias db_vt='aws_db "Bastion2Host" "voicetools-23may2024-0400.c1es6mhn5vxz.eu-central-1.rds.amazonaws.com" 5432 3332'
alias db_ls='aws_db "Bastion2Host" "livesession-23may2024-0400.c1es6mhn5vxz.eu-central-1.rds.amazonaws.com" 5432 3333'



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

# pnpm
export PNPM_HOME="/Users/mathiasjakobsen/Library/pnpm"
case ":$PATH:" in
  *":$PNPM_HOME:"*) ;;
  *) export PATH="$PNPM_HOME:$PATH" ;;
esac
# pnpm end

. "$HOME/.local/bin/env"
