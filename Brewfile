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
  autoconf
  automake
  bash
  boost
  brew-cask
  cloog018
  colordiff
  coreutils
  cppunit
  ffmpeg
  findutils
  freetype
  gcc
  gcc49
  gdbm
  gettext
  git
  gmp
  gmp4
  gnupg
  go
  grep
  htop-osx
  hub
  icu4c
  imagemagick
  isl
  isl011
  jpeg
  keybase
  lame
  libevent
  libgpg-error
  libksba
  libmpc
  libmpc08
  libpng
  libtiff
  libtool
  libvo-aacenc
  libxml2
  libyaml
  lynx
  mad
  memcached
  mongodb
  mono
  mp3info
  mpfr
  mpfr2
  mysql
  nginx
  ngrok
  node
  openssl
  pcre
  php56
  php56-memcache
  pkg-config
  postgresql
  python
  python3
  readline
  reattach-to-user-namespace
  redis
  rename
  sox
  sqlite
  the_silver_searcher
  thefuck
  tmux
  tokyo-cabinet
  tree
  unixodbc
  vim
  webkit2png
  wget
  x264
  xvid
  xz
)

for i in "${binaries[@]}"
do
  brew install $i
done

brew install go --cross-compile-all
brew tap thoughtbot/formulae

brew linkapps
brew cleanup
