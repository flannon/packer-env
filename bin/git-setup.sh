#!/bin/bash -eux

# Build for EC2
if [[ $PACKER_BUILDER_TYPE =~ amazon-ebs ]] || \
  [[ $PACKER_BUILDER_TYPE =~ virtualbox-iso ]]; then

    #export AWS_ACCESS_KEY_ID=$(curl http://169.254.169.254/latest/meta-data/iam/security-credentials/IAMRolePuppet-PuppetRole-1LBZMMXUXLLJU/ | jq -r '. | .["AccessKeyId"]')
    #export AWS_SECRET_ACCESS_KEY=$(curl http://169.254.169.254/latest/meta-data/iam/security-credentials/IAMRolePuppet-PuppetRole-1LBZMMXUXLLJU/ | jq -r '. | .["SecretAccessKey"]')
    #export AWS_SESSION_TOKEN=$(curl http://169.254.169.254/latest/meta-data/iam/security-credentials/IAMRolePuppet-PuppetRole-1LBZMMXUXLLJU/ | jq -r '. | .["Token"]')

    yum -y install epel-release 
    yum -y install libcurl jq python2-pip
    /bin/pip install awscli
    if [[ ! -f /root/.gitconfig ]]; then
      echo '[credential]' >> /root/.gitconfig
      echo '  helper = !aws codecommit credential-helper $@' >> /root/.gitconfig
      echo '  UseHttpPath = true' >> /root/.gitconfig
    fi

    #if [[ -d /etc/puppetlabs ]]; then
    #  mv /etc/puppetlabs /etc/puppetlabs.orig
    #  /bin/git clone https://git-codecommit.us-east-1.amazonaws.com/v1/repos/DLTSPackerTemplates /etc/puppetlabs
    #  cd /etc/puppetlabs
    #  /bin/git submodule update --init --recursive
    #fi

fi
