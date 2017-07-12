#!/bin/bash -eux

if [[ $PACKER_BUILDER_TYPE =~ amazon-ebs ]] || \
   [[ $PACKER_BUILDER_TYPE =~ virtualbox-iso ]]; then

  if [[ -f src/puppetlabs.tar.gz ]]; then
    rm -f src/puppetlabs.rar.gz
  fi

  tar zcvf puppetlabs.tar.gz puppetlabs
  mv puppetlabs.tar.gz src

fi
