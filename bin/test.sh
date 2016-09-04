#!/bin/bash -ex
#
# For each role
#   - make build directories
#   - make per role Vagrantfile
#   - make per role vagrantfile.template

#ZERO=$@[0]
#ONE=$@[1]
#TWO=$@[2]

if [[ "$1" &&  "$2" ]]; then
    PACKERFILE="$1"
    ROLENAME="$2"
elif [[ "$1" && -z "$2" ]]; then
    PACKERFILE="$1"
    ROLENAME="default"
elif [[ -z $1 && -z $2 ]]; then
    echo "Usage: blah, blah blah"
    exit 4
fi
   
echo "PACKERFILE: $PACKERFILE"

#HOST=image-factory erb ../erb/Vagrantfile.erb > output.erb
#BOX=$(echo $PACKERFILE | cut -f 1 -d '.' $1)
export BOX=$(basename $PACKERFILE .json)
#echo "BOX: $BOX"
export VAGRANTHOST="config.vm.hostname = \"$ROLENAME.local\""
erb ../erb/vagrantfile.erb > Vagrantfile
