#!/bin/bash

if ! type "brew" > /dev/null; then
  /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
fi

brew update
brew upgrade            # Upgrade any already-installed formulae

brew tap homebrew/homebrew-php

brew install go --cross-compile-all

binaries=(
  bash
  cmake
  composer
  coreutils
  elixir
  erlang
  ffmpeg
  findutils
  flac
  gcc
  gd
  git
  gitstats
  glib
  gor
  gpg-agent
  grep
  htop
  hub
  imagemagick
  jpeg
  lame
  lua
  mas
  memcached
  mongodb
  mysql
  nginx
  nmap
  node
  openssl
  phantomjs
  php56
  php56-mcrypt
  php56-memcache
  php56-xdebug
  php72
  php72-memcached
  php72-xdebug
  phpunit
  ponyc
  postgresql
  pqiv
  python
  python3
  qcachegrind
  redis
  ruby
  sox
  sqlite
  the_silver_searcher
  thefuck
  tmux
  tor
  tree
  vim
  wget
  x264
  xvid
  yarn
  z
  zsh
)

for i in "${binaries[@]}"
do
  brew install $i
done


brew linkapps
brew cleanup
