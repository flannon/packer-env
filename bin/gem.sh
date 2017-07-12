#!/bin/bash -eux

# Build for EC2
if [[ $PACKER_BUILDER_TYPE =~ amazon-ebs ]] || \
  [[ $PACKER_BUILDER_TYPE =~ virtualbox-iso ]]; then

    echo "Running gem..."

    /usr/bin/gem install r10k


fi

