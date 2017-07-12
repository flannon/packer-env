#!/bin/bash -eux
if [[ $PACKER_BUILDER_TYPE =~ amazon-ebs ]]; then

  yum --nogpgcheck -y install cloud-init cloud-utils-growpart gdisk

  if [[ -f /tmp/runcmd.cfg.erb ]] && [[ -f /etc/cloud/cloud.cfg ]]; then
    erb /tmp/runcmd.cfg.erb >> /etc/cloud/cloud.cfg
  fi

fi
