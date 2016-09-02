#!/bin/bash -eux

echo "Running puppet install script"

#
#  install.
#

echo "Installing Puppet"

REDHAT_MAJOR_VERSION=$(egrep -Eo 'release ([0-9][0-9.]*)' /etc/redhat-release | cut -f2 -d' ' | cut -f1 -d.)

if [[ $REDHAT_MAJOR_VERSION == 7 ]] && [[ $PUPPET_REPO =~ puppetlabs-release-pc1-el-7 ]]; then

    echo "Installing Puppet Labs repositories"
    wget http://yum.puppetlabs.com/${PUPPET_REPO}.noarch.rpm
    #wget http://yum.puppetlabs.com/puppetlabs-release-pc1-el-${REDHAT_MAJOR_VERSION}.noarch.rpm
    #rpm -ipv "http://yum.puppetlabs.com/puppetlabs-release-pc1-el-${REDHAT_MAJOR_VERSION}.noarch.rpm"
    rpm -ipv "http://yum.puppetlabs.com/${PUPPET_REPO}.noarch.rpm"

    yum -y install puppet

fi

echo "Set up staging directory for the puppet run."

mkdir /tmp/packer-puppet-masterless
chown vagrant:vagrant /tmp/packer-puppet-masterless
chmod 777 /tmp/packer-puppet-masterless

if [[ -f /home/vagrant/${PUPPET_REPO}.noarch.rpm ]]; then
    rm -f /home/vagrant/${PUPPET_REPO}.noarch.rpm
fi 
