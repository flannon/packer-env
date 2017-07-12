#!/bin/bash -eux


if [[ $PACKER_BUILDER_TYPE =~ amazon-ebs ]]; then

  cp /etc/fstab /tmp/fstab
  
  yum -y install nfs-utils

  if [[ ! -d /usr/local/share/images ]]; then
    mkdir -p /usr/local/share/images
  fi

  echo "$(curl http://169.254.169.254/latest/meta-data/placement/availability-zone/).${EFSMOUNTID}.efs.${REGION}.amazonaws.com:/ /usr/local/share/images nfs4 nfsvers=4.1,rsize=1048576,wsize=1048576,hard,timeo=600,retrans=2 0 0" >> /etc/fstab

  mount -a -t nfs4

  if [[ -f /tmp/fstab ]]; then
    mv -f /tmp/fstab /etc/fstab
  fi

fi
