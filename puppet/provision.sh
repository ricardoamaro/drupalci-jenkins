#!/bin/bash

# Script: provision.sh
# Author: Nick Schuch

BASE='/vagrant'
SUB='/puppet'

# Helper function to install packages.
aptInstall() {
  COUNT=`dpkg --get-selections $1 | wc -l`
  if [ "$COUNT" -eq "0" ]; then
    apt-get -y install $1
  fi
}

# Helper function to install packages.
aptUninstall() {
  COUNT=`dpkg --get-selections $1 | wc -l`
  if [ "$COUNT" -gt "0" ]; then
    apt-get -y remove $1
  fi
}

# Helper function to install gems packages.
gemInstall() {
  COUNT=`gem list | grep $1 | wc -l`
  if [ "$COUNT" -eq "0" ]; then
    gem install $1
  fi
}

# Install the required packages.
apt-get update > /dev/null
aptUninstall puppet
aptInstall curl
aptInstall wget
aptInstall git
aptInstall ruby1.9.1-dev
aptInstall vim
aptInstall build-essential
gemInstall bundler

# Run librarian-puppet to pull down contrib modules.
cd ${BASE} && bundle install
cd ${BASE}${SUB} && bundle exec librarian-puppet install
