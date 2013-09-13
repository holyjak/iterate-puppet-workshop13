# Class: my_webapp
#
# This module manages my_webapp
#
# Parameters: none
#
# Actions: N/A
#
class my_webapp {
  notice('Hello from my_webapp!')

  package { ['vim']: ensure => installed, } # no apache

  class { 'apache': }

  apache::vhost { 'localhost':
    #priority   => '25',
    #vhost_name => '*',
    port        => '80',
    docroot     => '/srv/my/www',
  }

  file { ['/srv/my', '/srv/my/www']:
    ensure => directory,
  }

  file { '/srv/my/www/my_web':
    ensure  => directory,
    source  => 'puppet:///modules/my_webapp/www',
    recurse => true,
    owner   => 'www-data',
    require => Class['apache'], # So that the user exists already
  }

}
