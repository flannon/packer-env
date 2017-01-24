#!/bin/bash
if [[ $PACKER_BUILDER_TYPE =~ amazon-ebs ]]; then
  sudo bash -c "echo runcmd:  >> /etc/cloud/cloud.cfg"
  sudo bash -c "echo ' - /usr/sbin/mkswap /dev/xvdb' >> /etc/cloud/cloud.cfg"
  sudo bash -c "echo ' - /usr/sbin/swapon /dev/xvdb' >> /etc/cloud/cloud.cfg"

fi
