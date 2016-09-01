#!/bin/bash -eux

# ref: https://github.com/boxcutter/centos/blob/master/script/motd.sh

echo "Running motd script"
echo "==> Recording box generation date"
#date > /etc/packer_box_build_date
date +%Y-%m-%d > /etc/packer_box_build_date

echo "==> Customizing message of the day"
MOTD_FILE=/etc/motd
BANNER_WIDTH=64
PLATFORM_RELEASE=$(sed 's/^.\+ release \([.0-9]\+\).*/\1/' /etc/redhat-release)
PLATFORM_MSG=$(printf 'CentOS %s' "${PLATFORM_RELEASE}")
#BUILT_MSG=$(printf 'built %s' $(date +%Y-%m-%d))
BUILT_MSG=$(printf 'built %s' $(cat /etc/packer_box_build_date))

cat << EOF > $MOTD_FILE














                                  __          __ 
                                  /_  _ '_ /_//_  
                                  __)(-/(//)/ __) 
                                       _/         packer-vagrant-puppet

EOF
printf '%0.1s' "-"{1..80} >> $MOTD_FILE
printf '\n' >> $MOTD_FILE
printf '%2s%-35s%35s\n' " " "${PLATFORM_MSG}" "${BUILT_MSG}" >> $MOTD_FILE
printf '%0.1s' "-"{1..80} >> $MOTD_FILE
printf '\n' >> $MOTD_FILE
