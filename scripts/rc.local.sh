#!/bin/bash -eux
#
# Generate new machine-id on vagrant node boot.
#
chmod 755 /etc/rc.d/rc.local

cat << EOF >> /etc/rc.local

if [[ ! -f /etc/machine-id ]]; then
    /usr/bin/systemd-machine-id-setup
fi

EOF
