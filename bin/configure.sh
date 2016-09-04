#!/bin/bash -eux
#
# Given a packer file name and a node role name
# build machine images for vagrant, AWS and docker
#   - make build directories
#   - make per role Vagrantfile
#   - make per role vagrantfile.template

# Variables
#  If role name is not given packer runs without puppet.
if [[ "$1" && "$2" ]]; then
    PACKERFILE="$1"
    ROLENAME="$2"
elif [[ "$1" && -z "$2" ]]; then
    PACKERFILE="$1"
    ROLENAME=""
elif [[ -z $1 && -z $2 ]]; then
    echo "Usage: $0 <packer file name> <role name>"
    exit 3
fi

BASEDIR=$(PWD)
export BOX=$(basename $PACKERFILE .json)
BUILDDIR=$BASEDIR/build
export VAGRANTHOST="config.vm.hostname \= \"$ROLENAME.local\""
VFTMPL=$BASEDIR/vagrantfile-templates


# Make build dirs
if [[ ! -d $BUILDDIR ]] || [[ ! -d $BUILDDIR/$ROLENAME ]]; then
    mkdir -p $BUILDDIR/$ROLENAME
fi

# make the vagrantfile
erb ./erb/Vagrantfile.erb > $BUILDDIR/$ROLENAME/Vagrantfile

# make the guest's vagrantfile template
if [[ ! -d $VFTMPL ]]; then
    mkdir $VFTMPL
fi

erb ./erb/vagrantfile.tmpl.erb > $VFTMPL/vagrantfile-$BOX-$ROLENAME.tmpl

# Build the image files
#   When run without -var-file centos7.2.json will build
#   the box image without running puppet

packer build -var-file=var-files/centos7.2_variables_imgfactory.json centos7.2.json
