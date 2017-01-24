#!/bin/bash -eux
if [[ $PACKER_BUILDER_TYPE =~ virtualbox-iso ]]; then

    #
    # Generate new machine-id on vagrant node boot.
    #
    chmod 755 /etc/rc.d/rc.local

    echo 'if [[ ! -f /etc/machine-id ]]; then' >> /etc/rc.local
    echo '/usr/bin/systemd-machine-id-setup' >> /etc/rc.local
    echo 'fi' >> /etc/rc.local
    
fi
