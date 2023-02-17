#!/bin/sh
set -ex
cd `dirname $0`
##################################################################
apk update > /dev/null
apk add build-base clang > /dev/null

mkdir linux

cd dmidecode-*
make clean
CC="clang" LDFLAGS="-static" make 
make strip
cp dmidecode biosdecode vpddecode ownership ../linux
cd ..

tar zcvf dmidecode_linux_amd64.tar.gz linux/*

