## The main manifest

## DO NOT CHANGE THIS STUFF
# The functions debug, info, notice, warning may be used
# to print to the standard output
# http://docs.puppetlabs.com/references/2.7.latest/function.html
warning("Setting up ${fqdn} ...")
include puppet_lint

## TODO Add your resources etc. here

package { 'nano': ensure => installed }

exec { 'run_presentation':
  command => '/usr/bin/python -m SimpleHTTPServer 8080 &',
  cwd => '/vagrant/presentation',
}
