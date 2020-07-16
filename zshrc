export ZSH="/Users/mathiasjakobsen/.oh-my-zsh"

export PATH="$HOME/bin:$PATH"
export PATH="/usr/local/bin:$PATH:$HOME/.rvm/bin"
export PATH="/usr/local/bin:/usr/local/sbin:$PATH"
export PATH="$PATH:$HOME/go/bin"

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

bug() { jira create --noedit --issuetype=Bug -o summary="$1" -o description="$2" -o estimate="$3" }
issue() { jira create --noedit --issuetype=Enhancement -o summary="$1" -o description="$2" -o estimate="$3" }
story() { jira create --noedit --issuetype=Story -o summary="$1" -o description="$2" -o estimate="$3" }
task() { jira create --noedit --issuetype=Task -o summary="$1" -o description="$2" -o estimate="$3" }
spike() { jira create --noedit --issuetype=Spike -o summary="$1" -o description="$2" -o estimate="$3" }

source /usr/local/share/zsh-autosuggestions/zsh-autosuggestions.zsh
source /usr/local/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source /usr/local/opt/git-extras/share/git-extras/git-extras-completion.zsh
source $ZSH/oh-my-zsh.sh
source `brew --prefix`/etc/profile.d/z.sh

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

autoload -U promptinit; promptinit
prompt pure
export PATH="/usr/local/opt/php@7.2/bin:$PATH"
export PATH="/usr/local/opt/php@7.2/sbin:$PATH"

export LC_ALL=en_US.UTF-8
export PATH="/usr/local/opt/openjdk/bin:$PATH"
export PATH="/usr/local/opt/mysql@5.7/bin:$PATH"

# Add RVM to PATH for scripting. Make sure this is the last PATH variable change.
export PATH="$PATH:$HOME/.rvm/bin"

autoload -U add-zsh-hook
load-nvmrc() {
  local node_version="$(nvm version)"
  local nvmrc_path="$(nvm_find_nvmrc)"

  if [ -n "$nvmrc_path" ]; then
    local nvmrc_node_version=$(nvm version "$(cat "${nvmrc_path}")")

    if [ "$nvmrc_node_version" = "N/A" ]; then
      nvm install
    elif [ "$nvmrc_node_version" != "$node_version" ]; then
      nvm use
    fi
  elif [ "$node_version" != "$(nvm version default)" ]; then
    echo "Reverting to nvm default version"
    nvm use default
  fi
}
add-zsh-hook chpwd load-nvmrc
load-nvmrc
