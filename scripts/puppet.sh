#!/bin/bash -eux

echo "Running puppet install script"

PUPPET_VERSION=${PUPPET_VERSION:-latest}

#
#  install.
#

echo "Installing Puppet"

REDHAT_MAJOR_VERSION=$(egrep -Eo 'release ([0-9][0-9.]*)' /etc/redhat-release | cut -f2 -d' ' | cut -f1 -d.)

if [[ $REDHAT_MAJOR_VERSION == 7 ]] && [[ $PUPPET_REPO =~ puppetlabs-release-pc1-el-7 ]]; then

    echo "Installing Puppet Labs repositories"
    wget http://yum.puppetlabs.com/puppetlabs-release-pc1-el-${REDHAT_MAJOR_VERSION}.noarch.rpm
    #rpm -ipv "http://yum.puppetlabs.com/puppetlabs-release-pc1-el-${REDHAT_MAJOR_VERSION}.noarch.rpm"
    rpm -ipv "http://yum.puppetlabs.com/${PUPPET_REPO}.noarch.rpm"

    yum -y install puppet

fi
