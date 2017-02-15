#!/bin/bash -eux

export PATH=/bin:/sbin:/usr/bin:/usr/local/bin

# Build for EC2
if [[ $PACKER_BUILDER_TYPE =~ amazon-ebs ]] || \
   [[ $PACKER_BUILDER_TYPE =~ virtualbox-iso ]] || \
   [[ $PACKER_BUILDER_TYPE =~ docker ]]; then

  cd /tmp

  if [[ -f puppet.tar.gz ]]; then

    /usr/bin/tar zxf puppet.tar.gz
    #/usr/bin/rsync puppet/ /etc/puppetlabs/code
    mv -f puppet/environments/development /etc/puppetlabs/code/environments
    mv -f puppet/hiera.yaml /etc/puppetlabs
    mv -f puppet/puppet.conf /etc/puppetlabs


  else

    echo 'No source tarball'

  fi

fi
