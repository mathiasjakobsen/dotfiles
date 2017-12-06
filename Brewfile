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
  adns
  atk
  autoconf
  automake
  bash
  bdw-gc
  boost
  cairo
  cloc
  cloog
  cloog018
  cmake
  colordiff
  composer
  coreutils
  cppunit
  crystal-lang
  dirmngr
  docker
  doxygen
  elasticsearch17
  elixir
  erlang
  exif
  exiftool
  ffmpeg
  findutils
  flac
  fontconfig
  freetype
  gcc
  gcc49
  gcc@4.9
  gd
  gdb
  gdbm
  gdk-pixbuf
  gettext
  ghostscript
  git
  git-standup
  gitstats
  glew
  glib
  glm
  gmp
  gmp4
  gmp@4
  gnupg
  gnupg2
  gnuplot
  gnutls
  go
  gobject-introspection
  gor
  gpg-agent
  graphite2
  graphviz
  grep
  gsettings-desktop-schemas
  gtk+3
  harfbuzz
  hicolor-icon-theme
  htop
  htop-osx
  hub
  hugo
  ical-buddy
  icu4c
  imagemagick
  isl
  isl011
  isl@0.11
  isl@0.12
  jpeg
  lame
  libarchive
  libassuan
  libepoxy
  libevent
  libexif
  libffi
  libgcrypt
  libgpg-error
  libksba
  libmagic
  libmemcached
  libmpc
  libmpc08
  libmpc@0.8
  libogg
  libpng
  libressl
  libspectre
  libtasn1
  libtiff
  libtool
  libunistring
  libusb
  libusb-compat
  libvo-aacenc
  libvorbis
  libvpx
  libxml2
  libyaml
  lighttpd
  little-cms2
  llvm
  llvm@3.9
  lua
  lynx
  mad
  mas
  mcrypt
  md5sha1sum
  memcached
  mhash
  mitmproxy
  mongodb
  mono
  mp3info
  mpfr
  mpfr2
  mpfr@2
  multimarkdown
  mysql
  nasm
  nettle
  nginx
  nmap
  node
  node@6
  npth
  ntfs-3g
  openjpeg
  openssl
  openssl@1.1
  p11-kit
  pango
  pcre
  pcre2
  perl
  phantomjs
  php-version
  php56
  php56-mcrypt
  php56-memcache
  php56-xdebug
  php70
  php70-memcached
  php70-xdebug
  phpunit
  pinentry
  pixman
  pkg-config
  ponyc
  poppler
  popt
  postgresql
  pqiv
  protobuf
  pth
  python
  python3
  qcachegrind
  qt
  qt5
  readline
  reattach-to-user-namespace
  redis
  rename
  ruby
  sdl2
  sfml
  sox
  sqlite
  stormssh
  texi2html
  the_silver_searcher
  thefuck
  tmux
  tokyo-cabinet
  tor
  tree
  unixodbc
  vim
  webkit2png
  webp
  wget
  wxmac
  x264
  xvid
  xz
  yarn
  yasm
  z
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
