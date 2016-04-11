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
brew tap homebrew/php
brew install homebrew/dupes/grep

binaries=(
  autoconf
  automake
  bash
  boost
  cloc
  cloog018
  cmake
  colordiff
  coreutils
  cppunit
  ffmpeg
  findutils
  flac
  freetype
  gcc
  gcc49
  gdbm
  gettext
  git
  glew
  gmp
  gmp4
  gnupg
  go
  gor
  graphviz
  grep
  htop-osx
  hub
  ical-buddy
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
  libogg
  libpng
  libtiff
  libtool
  libvo-aacenc
  libvorbis
  libxml2
  libyaml
  lighttpd
  lynx
  mad
  memcached
  mitmproxy
  mongodb
  mono
  mp3info
  mpfr
  mpfr2
  mysql
  nginx
  ngrok
  nmap
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
  sfml
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
  zsh
)

for i in "${binaries[@]}"
do
  brew install $i
done

brew install go --cross-compile-all
brew tap thoughtbot/formulae

brew linkapps
brew cleanup
