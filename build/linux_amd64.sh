#!/bin/sh
set -ex
cd `dirname $0`
##################################################################
apk update > /dev/null
apk add build-base clang > /dev/null


cd dmidecode-*
make clean
CC="clang" LDFLAGS="-static" make 
make strip
tar zcvf ../dmidecode_linux_amd64.tar.gz dmidecode biosdecode vpddecode ownership
