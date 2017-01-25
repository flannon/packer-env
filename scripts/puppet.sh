#!/bin/bash -eux

# Build for EC2
if [[ $PACKER_BUILDER_TYPE =~ amazon-ebs ]]; then


    echo "Installing Puppet"

    REDHAT_MAJOR_VERSION=$(egrep -Eo 'release ([0-9][0-9.]*)' /etc/redhat-release | cut -f2 -d' ' | cut -f1 -d.)

    if [[ $REDHAT_MAJOR_VERSION == 7 ]] && [[ $PUPPET_REPO =~ puppetlabs-release-pc1-el-7 ]]; then

        echo "Installing Puppet Labs repositories"
        #wget http://yum.puppetlabs.com/${PUPPET_REPO}.noarch.rpm

        sudo bash -c "rpm -ipv http://yum.puppetlabs.com/${PUPPET_REPO}.noarch.rpm"
        #rpm -ivh http://yum.puppetlabs.com/puppetlabs-release-el-7.noarch.rpm

        #sudo bash -c "yum localinstall http://yum.puppetlabs.com/${PUPPET_REPO}.noarch.rpm"


        sudo bash -c "yum -y install puppet-agent"

    fi

    echo "Set up staging directory for the puppet run."
    mkdir /tmp/packer-puppet-masterless
    chown ${EC2_USER}:${EC2_USER} /tmp/packer-puppet-masterless
    chmod 777 /tmp/packer-puppet-masterless

    if [[ -f /home/vagrant/${PUPPET_REPO}.noarch.rpm ]]; then
        rm -f /home/vagrant/${PUPPET_REPO}.noarch.rpm
    fi 

fi

# Build for VirtualBox
if [[ $PACKER_BUILDER_TYPE =~ virtualbox-iso ]]; then

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
fi

if [[ $PACKER_BUILDER_TYPE =~ docker ]]; then

    echo "Running puppet install script"

    #
    #  install.
    #

    echo "Installing Puppet"

    yum install -y wget

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
    #chown docker:docker /tmp/packer-puppet-masterless
    chmod 777 /tmp/packer-puppet-masterless

    if [[ -f /${PUPPET_REPO}.noarch.rpm ]]; then
        rm -f /${PUPPET_REPO}.noarch.rpm
    fi 
fi
