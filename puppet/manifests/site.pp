## The main manifest

# The functions debug, info, notice, warning may be used
# to print to the standard output
# http://docs.puppetlabs.com/references/2.7.latest/function.html
warning("Setting up $fqdn ...")

## TODO Add your resources etc. here

package { 'nano'': ensure => latest }
