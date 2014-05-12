DrupalCI jenkins
================

# Overview

Provides Jenknins master/slave configuration for DrupalCI testbots.

# Installation

Install the required gems with bundler (http://bundler.io/v1.6/bundle_install.html) via:

```
bundle install --path vendor/bundle
```

# Local development.

A local environment can be setup with Vagrant using the following command:

```
vagrant up
```

Note: See the Vagrantfile for IP's and conifguration.

# Deploy.

To show change and then deploy to the DEV environment run the following commands:

```
bundle exec cap dev puppet:noop
bundle exec cap dev puppet:apply
```
