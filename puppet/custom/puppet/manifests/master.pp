# The puppet master.

class puppet::master {

  include puppet

  package { 'puppetmaster':
    ensure => 'present',
  }

}
