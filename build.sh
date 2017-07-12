#!/bin/sh

set -e

usage() {
  cat << EOF 
Usage: $(basename $0) <image name> 
EOF
}

[[ -z $1 ]] && usage && exit 2

IMAGE=$1
BASEPATH=$(cd $(dirname $0) && pwd)
SRC=${BASEPATH}/src

if [[ ! -f _${IMAGE}.json ]]
then
  echo "template _${IMAGE}.json not found" 
  exit 3
fi

if [[ ! -f var/${IMAGE}-vars.json ]]
then
  echo "template var/${IMAGE}-vars.json not found"
  exit 3
fi

packer validate --var-file=var/${IMAGE}-vars.json  _${IMAGE}.json 
echo "after validate"

[[ -f ${SRC}/puppetlabs.tar.gz ]] && rm -f ${SRC}/puppetlabs.tar.gz

tar zcvf ${SRC}/puppetlabs.tar.gz puppetlabs

