#!/bin/sh
set -e
cd `dirname $0`
###############################################

## check version
URL='http://download.savannah.gnu.org/releases/dmidecode/'
FILENAME=$(curl -Lsk "${URL}" |grep -o 'dmidecode-.\+.tar.xz"' | sort -u | tail -n 1 | sed -e 's/"//' | tr -d '\n' | tr -d '\r')
VERSION=$(echo "${FILENAME}"  | sed 's/.tar.xz//' | sed 's/dmidecode-//' | tr -d '\n' | tr -d '\r')

## downlaod source
curl -Lsko ${FILENAME} ${URL}/${FILENAME}
tar xf ${FILENAME}


## build linux(amd64)
docker run --rm -v `pwd`:/src -w /src -h dmidecode alpine:latest /src/linux_amd64.sh 

## build windows(i686)
docker run --rm -v `pwd`:/src -w /src -h dmidecode ubuntu:latest /src/win32_i686.sh


