#!/bin/bash

# Script: provision.sh
# Author: Nick Schuch

# Helper function to install packages.
aptInstall() {
  COUNT=`dpkg --get-selections $1 | wc -l`
  if [ "$COUNT" -eq "0" ]; then
    apt-get -y update > /dev/null
    apt-get -y install $1
  fi
}

# Install the required packages.
aptInstall curl
aptInstall wget
aptInstall git
aptInstall rubygems
aptInstall vim

# Ensure we have the latest puppet.
PUPPET_COUNT=`gem list | grep puppet | wc -l`
if [ "$PUPPET_COUNT" -eq "0" ]; then
  gem install puppet
fi
