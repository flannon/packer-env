#!/bin/bash -eux

#SSH_USER=vagrant
SSH_USER=$SSH_USERNAME
SSH_USER_HOME=/home/${SSH_USER}

if [[ $PACKER_BUILDER_TYPE =~ virtualbox-iso ]]; then
    echo "==> Installing VirtualBox guest additions"

    VBOX_VERSION=$(cat $SSH_USER_HOME/.vbox_version)
    mount -o loop,ro $SSH_USER_HOME/VBoxGuestAdditions.iso /mnt

    #/mnt/VBoxLinuxAdditions.run || :
    /mnt/VBoxLinuxAdditions.run --nox11
    rm -rf $SSH_USER_HOME/VBoxGuestAdditions.iso
    rm -f $SSH_USER_HOME/.vbox_version
    umount /mnt
fi
