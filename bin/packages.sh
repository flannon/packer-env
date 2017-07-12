#!/bin/bash -eux

# Build for EC2
if [[ $PACKER_BUILDER_TYPE =~ amazon-ebs ]] || \
  [[ $PACKER_BUILDER_TYPE =~ virtualbox-iso ]]; then

    yum -y install epel-release 
    yum -y install  git jq libcurl python2-pip rubygems wget

fi

if [[ $PACKER_BUILDER_TYPE =~ amazon-ebs ]]; then

    yum -y install nfs-utils

fi
