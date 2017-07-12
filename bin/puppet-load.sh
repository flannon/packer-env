#!/bin/bash -eux

export PATH=/bin:/sbin:/usr/bin:/usr/local/bin

# Build for EC2
if [[ $PACKER_BUILDER_TYPE =~ amazon-ebs ]]; then 

  if [[ -d /etc/puppetlabs ]]; then

    mv /etc/puppetlabs /etc/puppetlabs.orig

  fi

  if [[ -f /tmp/puppetlabs.tar.gz ]]; then

    cd /tmp
    tar zxvf puppetlabs.tar.gz
    mv puppetlabs /etc/puppetlabs
  fi

  #cd /etc/puppetlabs

  #if [[ -d /etc/puppetlabs ]]
  #then

  #  cd /etc
  #  mv puppetlabs puppetlabs.org
  #  git clone https://git-codecommit.us-east-1.amazonaws.com/v1/repos/DLTSPuppetlabs puppetlabs
  #  cd puppetlabs
  #  git submodule update --init --recursive

  #fi

fi
