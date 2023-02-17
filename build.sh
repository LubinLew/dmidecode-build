#!/bin/sh
set -ex
cd `dirname $0`
###############################################

## check version
URL='http://download.savannah.gnu.org/releases/dmidecode/'
FILENAME=$(curl -Lsk "${URL}" |grep -o 'dmidecode-.\+.tar.xz"' | sort -u | tail -n 1 | sed -e 's/"//' | tr -d '\n' | tr -d '\r')
VERSION=$(echo "${FILENAME}"  | sed 's/.tar.xz//' | sed 's/dmidecode-//' | tr -d '\n' | tr -d '\r')
LOCAL_VERSION=`cat version.txt`
if [ "${VERSION}" = "${LOCAL_VERSION}" ] ; then
  echo "Up to date"
  exit 0
fi

## downlaod source
curl -Lsko ${FILENAME} ${URL}${FILENAME}
tar xf ${FILENAME} -C build
rm -f  ${FILENAME}


## build linux(amd64)
docker run --rm -v `pwd`/build:/src -w /src -h dmidecode alpine:latest /src/linux_amd64.sh 2>&1 | tee linux.log

### NOT SUPPORT WINDOWS
## build windows(i686/x86_64)
#docker run --rm -v `pwd`/build:/src -w /src -h dmidecode ubuntu:latest /src/windows.sh 2>&1 | tee windows.log

echo "${VERSION}" > version.txt
