## The main manifest
import 'apt_setup.pp'

## DO NOT CHANGE THIS STUFF
# The functions debug, info, notice, warning may be used
# to print to the standard output
# http://docs.puppetlabs.com/references/2.7.latest/function.html
warning("Setting up ${fqdn} ...")
include puppet_lint

## TODO Add your resources etc. here
class { 'my_webapp': }

package { 'nano': ensure => installed }

exec { 'run_presentation':
  command => '/usr/bin/python -m SimpleHTTPServer 8080 &',
  cwd     => '/vagrant/presentation',
}

# Magic to use locally cached .debs, ignore :)
stage { 'pre': }
Stage['pre'] -> Stage['main']
class { 'apt_setup': stage => 'pre', }
