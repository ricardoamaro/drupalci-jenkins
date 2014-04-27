#!/bin/bash

# Script: provision.sh
# Author: Nick Schuch

apt-get -y update
apt-get -y install curl wget git rubygems vim
gem install puppet
apt-get clean
