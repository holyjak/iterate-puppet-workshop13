## The main manifest

include my_webapp
#class { 'my_webapp': }

# The functions debug, info, notice, warning may be used
# to print to the standard output
# http://docs.puppetlabs.com/references/2.7.latest/function.html
warning("Done setting up $fqdn :-)")
