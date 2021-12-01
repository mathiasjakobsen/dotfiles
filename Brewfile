#!/bin/bash

if ! type "brew" > /dev/null; then
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi

brew update
brew upgrade
brew install --cask docker microsoft-teams microsoft-office
$(brew --prefix)/opt/fzf/install

binaries=(
  bash
  ca-certificates
  composer
  coreutils
  curl
  curl-openssl
  docker-compose
  docker-machine
  ffmpeg
  flac
  fzf
  gh
  git
  git-extras
  go
  grep
  htop
  imagemagick
  imap@7.4
  jq
  lame
  make
  mdcat
  memcached
  mysql
  nginx
  nmap
  php@7.4
  phpunit
  postgresql
  pure
  rbenv
  readline
  redis
  ruby-build
  sox
  sqlite
  telnet
  the_silver_searcher
  tmux
  tor
  tree
  vim
  wget
  x264
  x265
  z
  zsh
  zsh-autosuggestions
  zsh-syntax-highlighting
)

for i in "${binaries[@]}"
do
  brew install $i
done


brew cleanup
