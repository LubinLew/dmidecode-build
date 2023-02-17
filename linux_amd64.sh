#!/bin/sh
set -e
cd `dirname $0`
##################################################################
apk update
apk add build-base clang

mkdir linux

cd dmidecode-*
make clean
make 
make strip
cp dmidecode biosdecode vpddecode ownership ../linux
cd ..

tar zcvf dmidecode-linux-amd64.tar.gz linux

