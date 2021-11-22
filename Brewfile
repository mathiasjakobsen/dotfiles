#!/bin/bash

if ! type "brew" > /dev/null; then
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi

brew update
brew upgrade

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
  rbenv
  readline
  redis
  ruby-build
  sox
  sqlite
  telnet
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
