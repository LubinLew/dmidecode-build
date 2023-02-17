#!/bin/bash
set -ex
cd `dirname $0`
##################################################################
function i686_env() {
  rm -f /usr/local/bin/*
  ln -s /usr/bin/i686-w64-mingw32-gcc      /usr/local/bin/cc
  ln -s /usr/bin/i686-w64-mingw32-gcc      /usr/local/bin/gcc
  ln -s /usr/bin/i686-w64-mingw32-cpp      /usr/local/bin/cpp
  ln -s /usr/bin/i686-w64-mingw32-ld       /usr/local/bin/ld
  ln -s /usr/bin/i686-w64-mingw32-gcc-ar   /usr/local/bin/ar
  ln -s /usr/bin/i686-w64-mingw32-windres  /usr/local/bin/windres
  ln -s /usr/bin/i686-w64-mingw32-strip    /usr/local/bin/strip
}

function x64_env() {
  rm -f /usr/local/bin/*
  ln -s /usr/bin/x86_64-w64-mingw32-gcc     /usr/local/bin/cc
  ln -s /usr/bin/x86_64-w64-mingw32-gcc     /usr/local/bin/gcc
  ln -s /usr/bin/x86_64-w64-mingw32-cpp     /usr/local/bin/cpp
  ln -s /usr/bin/x86_64-w64-mingw32-ld      /usr/local/bin/ld
  ln -s /usr/bin/x86_64-w64-mingw32-gcc-ar  /usr/local/bin/ar
  ln -s /usr/bin/x86_64-w64-mingw32-windres /usr/local/bin/windres
  ln -s /usr/bin/x86_64-w64-mingw32-strip   /usr/local/bin/strip
}

function build() {
  mkdir -p windows/$1
  $1_env
  pushd dmidecode-*

  make clean
  LDFLAGS="--static" make
  make strip

  cp *.exe ../windows/$1
  popd
}
##################################################################
apt-get update  -y
apt-get install -y mingw-w64 make

build i686
build x64

cd windows
tar zcvf ../dmidecode-win32-i686.tar.gz    i686
tar zcvf ../dmidecode-win32-x86_64.tar.gz  x64
