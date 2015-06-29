#!/bin/bash

if ! type "brew" > /dev/null; then
  ruby -e "$(curl -fsSL https://raw.github.com/Homebrew/homebrew/go/install)"
fi

brew update
brew upgrade            # Upgrade any already-installed formulae
brew install coreutils  # Install GNU core utilities (those that come with OS X are outdated)
brew install findutils  # Install GNU `find`, `locate`, `updatedb`, and `xargs`, g-prefixed
brew install bash       # Install Bash 4

brew tap homebrew/dupes
brew install homebrew/dupes/grep

binaries=(
  brew-cask
  colordiff
  coreutils
  ffmpeg
  findutils
  git
  go
  grep
  htop-osx
  imagemagick
  jpeg
  lynx
  memcached
  mongodb
  mp3info
  mysql
  node
  openssl
  php56
  php56-memcache
  php56-memcached
  phpunit
  postgresql
  reattach-to-user-namespace
  redis
  rename
  sox
  sshpass
  the_silver_searcher
  tmux
  tree
  vim
  webkit2png
  wget
)

for i in "${binaries[@]}"
do
  brew install $i
done

brew install go --cross-compile-all
brew tap thoughtbot/formulae

brew linkapps
brew cleanup
