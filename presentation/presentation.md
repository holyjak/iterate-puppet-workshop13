Iterate Puppet Miniworkshop 9/2013
==================================

<!--
!!! USE CHROME FOR PRESENTATION, FF SUCKS !!!
-->
Let's get going!

Make sure your Vagrant VM has network access!

Tip: Browse to <code>http://localhost:65432</code> to see this presentation (served by Vagrant)
<!--
# TIMING #
Note: 60 min is possible but quite rushed. 2h best for peopel w/o prior Puppet experience,
go slower through the tasks. More participants => get a side-kick.

- Intro: 	57

- Topic 1:	53	(packages)
- Task 1.1:	49

- Topic 2:	-	(service, deps)
- Task 2.1:	42
- Task 2.2:	38

- Topic 3:	36	(class)
- Task 3.1:	30

- Topic 4:	-	(file/dir copy)
- Task 4.1:	14 !!! lot of time lost here
- Task 4.2:	- (simple copy&paste)

- Topic 5:	10 (subscribe)
- Task 5.1:	5

- Topic 6:	skipped (module))
- Task 6.1:	skipped

- Next steps:	 -
- Feedback, Q&A: -

-->

---

Who are we?
===========

* Jakub Holy, Iterate, 1.5 years with Puppet at AWS
* Kenneth Rørvik, Redpill Linpro, Puppet expert :)

---

Intro! <!-- Done when 57 min left -->
=====

1. (0.5m) Intro: What, why, and how are we going to learn
   * Learning based on your questions => ask!
   * What is Vagrant, what does it do for us? (VM, ssh)
2. (3m) What is Puppet?
    * provisioner (=?) => many nodes
    * p. vs. shell scripts (cross-platform, modules, master-slave,
      handles unimportant details itself, DRY, ...)
    * declarative, not imperative (=> order)
    * few words about syntax (ruby-like, ...)
3. (50m) Workshop
4. (5m) Summary, feedback, questions
<!--
Puppet:
- Describe what "resources" to create/remove etc. (files, packages,
  users, ..)
- Done in a manifest - a .pp text file with Ruby-based puppet code
Vagrant x Puppet:
 Just for simplicity, you can run puppet manually; notice the vagrant
 log line:
 [default] Running Puppet with /tmp/vagrant-puppet/ ...
 => Vagrant does copy manifests, modules etc. there:
/tmp/vagrant-puppet$ sudo puppet apply --debug --verbose --modulepath=modules-0 manifests/site.pp
-->

---

Tasks
=====

Goal: Get a static site up on Apache.

Learning the basics:

* install a package
* copy files
* start a service
* express dependencies

Advanced stuff:

* modules

---

### Look around

Run `find puppet` in the workshop directory to see what we have got here.

---

### Applying puppet config

To apply the Puppet configuration *after each task*:

Run either

    vagrant provision

or

    vagrant ssh
    cd /vagrant/puppet
    sudo puppet apply --debug --verbose --modulepath=modules manifests/site.pp

Observe the *logs* printed into the console.

---

### Topic 1. Installing packages <!-- Done when 53 min left -->

A simple example of a resource declaration:

    package { 'vim':
      ensure => installed,
    }

What is this?

    <resource_type> { <resource_name>:
      ensure     => present,
      attribute2 => value2,
    }

<!-- COMMENTS:
This is a basic building block of Puppet code. Notes:
- ensure on most resources, different values: file, directory,
  symlink, installed, ...
- the name is usually meaningful: the file path to create or package
  to install
-->
Noticed anything strange? (`,`)

---

#### Task 1.1 <!-- Done when 49 min left -->

(1) In `puppet/manifests/site.pp`, install the packages `vim` and
`apache2`. See

[R1: *http://docs.puppetlabs.com/references/2.7.latest/type.html*][R1]

(2) Run `vagrant provision` to apply the changes.

Tip: Use an array of names (<code>[x, y, ...]</code>) to declare multiple same resources at once.
(Arrays are used/allowed at multiple places.)
<!--
LEARNING: First experience with Puppet code, how to apply it, the
resource type reference.
TODO: vagrant provision vs. running puppet agent manually
Time: 45s catalog run
-->

---

#### Task 1.1 solution

Either:

    package { 'vim': ensure => installed, }
    package { 'apache2': ensure => installed, }

Or:

    package { ['vim', 'apache2']: ensure => installed, }

---

#### Intermezzo: Syntax checking

From the host machine:

    vagrant ssh -c 'puppet-lint --with-filename \\
        /vagrant/puppet/'

From the VM:

    puppet-lint --with-filename /vagrant/puppet/

---

### Topic 2. Running services and handling dependencies

#### Task 2.1: Make `apache2` start using the `service` resource (ref [R1]) <!-- Done when 42 min left -->

Tips:

* Name it `apache2` -  maps to a script in `/etc/init.d/`
* You only need `ensure` now

Testing:

* Run `vagrant ssh -c 'sudo service apache2 stop'` to stop it and see
that it gets started
* Notice log *../Service[apache2]/.. to running*

---

#### Task 2.1 solution

site.pp:

    service { 'apache2': ensure => running, }

---

#### Intermezzo

Puppet is declarative, not imperative => no defined order
of action execution => express dependencies explicitely:

    package { 'ring': ensure => installed, }
    file { '/frodo': .., require => [Package['ring']], }

#### Task 2.2: Make the `apache2` *service* require the `apache2` *package* <!-- Done when 38 min left -->

Note: Refer to resources via `ResourceType['name']` (notice
the initial capital letter).

---

#### Task 2.2 solution

    service { 'apache2':
      ensure  => running,
      require => Package['apache2'],
    }

or

    service { 'apache2':
      ensure  => running,
      require => [ Package['apache2'] ],
      # ^ could require multiple resources
    }

---

### Topic 3. Using classes for structure and reuse <!-- Done when 36 min left -->

Classes encapsulate independent and reusable pieces of configuration.
They also make it more reusable via parametrization.

Class example:

    class my_webapp {                       # declare
      ... # install packages etc.
    }

    class { 'my_webapp': }                  # apply
    # In this case, this would also suffice:
    # include my_webapp

<!--
Here we (1) define and (2) apply a class
-->
Optional: see
[Defining a Class](http://docs.puppetlabs.com/puppet/2.7/reference/lang_classes.html#defining-a-class)

---

#### Task 3.1: Wrap the resources defined so far in a class

The class has already been defined for you in

    puppet/modules/my_webapp/manifests/init.pp

(we will talk about modules later) =>

1. move the resources into it
2. apply the class in the original `site.pp`

---

#### Task 3.1 solution

puppet/modules/my_webapp/manifests/init.pp:

    class my_webapp {
      package { ['vim', 'apache2']: ensure => installed, }
      service { 'apache2': ensure => running,
        require => Package['apache2'], }
    }

puppet/manifests/site.pp:

    class { 'my_webapp': }

---

### Topic 4. Copying files and directories

#### Task 4.1: Copy the *www* site <!-- Done when 14 min left -->

* Copy puppet/modules/my_webapp/files/www
* (visible to puppet as `'puppet:///modules/my_webapp/www'`)
* into `/srv/my/www/my_web`
* Make user `www-data` own my_web

You'll need <code>file</code> resource(s) and the attributes <code>ensure, source,
owner, recurse</code>. Do it in the my_webapp class.
<!--
They will try to copy the dir w/o creating the parent dirs and fail -
that is a good learning.
-->

---

#### Side note: File path <=> puppet url

    '/files/' is implied by the file resource
                                         V
    $WORKSHOP/puppet/modules/my_webapp/files/www
                                |       _____/
                                v      V
          puppet:///modules/my_webapp/www
          '---------------'      ^- module name
                  ^- do lookup on MODULEPATH

    (Vagrantfile: puppet.module_path = "puppet/modules")

---

#### Intermezzo:

How can I be sure the files are created after their directories without any `require`? Autorequire!

---

#### Task 4.1 solution

init.pp:

    class my_webapp {
      ...
      file { ['/srv/my', '/srv/my/www']:
        ensure => directory,
      }

      file { '/srv/my/www/my_web':
        ensure  => directory,
        source  => 'puppet:///modules/my_webapp/www',
        recurse => true,
        owner   => 'www-data',
      }
    }


---

#### Task 4.2: Copy also the Apache site config

From `puppet/modules/my_webapp/files/etc/apache2` into `/etc/apache2/`:

    file { '/etc/apache2':
      ensure  => directory,
      source  => 'puppet:///modules/my_webapp/etc/apache2',
      recurse => true,
    }


---

#### Topic 5. Dependencies II: reload after configuration change <!-- Done when 10 min left -->

Apache doesn't only require its configuration, it should also be
restarted ("reloaded") whenever it changes.

---

#### Task 5.1: Tell Puppet to restart Apache when its configuration changes. <!-- Done when 5 min left -->

You'll need to apply the
[relationship metaparameter](http://docs.puppetlabs.com/puppet/2.7/reference/lang_relationships.html#relationship-metaparameters)
`subscribe` to the service.

Tip: To simulate change, run `echo '#' >>
puppet/modules/my_webapp/files/etc/apache2/envvars` prior to `vagrant
provision`. Watch the log for "*info: /etc/apache2: Scheduling refresh of Service[apache2]*".

---

#### Task 5.1 solution

      service { 'apache2':
        ensure    => running,
        require   => Package['apache2'],
        subscribe => File['/etc/apache2'],
      }

(There are other/better ways, e.g. subscribe to a special config class.)

---

### Topic 6. The final round: modules

#### Task 6.1: Use the [puppetlabs apache module] instead of doing everything manually

##### (1) Get the module

Run `vagrant ssh` and then:

    puppet --configprint modulepath # optional
    mkdir -p /home/vagrant/.puppet/modules
    puppet module install puppetlabs-apache
    mv /home/vagrant/.puppet/modules/* /vagrant/puppet/modules/

---

##### (2) Use the module

Use the apache module: include the main class (`apache`) and use the
`apache::vhost` resource that it defines.

* set its `docroot` to `/srv/my/www`
* set `port` to `80`
* use *localhost* as the resource name

[puppetlabs apache module]: https://forge.puppetlabs.com/puppetlabs/apache

---

#### Task 6.1 solution

    package { ['vim']: ensure => installed, } # no apache

    class { 'apache': }

    apache::vhost { 'localhost':
      #priority   => '25',
      #vhost_name => '*',
      port        => '80',
      docroot     => '/srv/my/www',
    }

    file { ... }

(No apache2 package or service anymore.)

<!-- ==================================================== LEFT OUT
### Topic 7. Parametrized classes (to be dropped????)

*TODO: Do we have time for this? Likely drop it.*

**Task**: Make the choice of editor to install parametrized

Some teams require vim, some hate it and want nano; let them decide by
making the editor package into a parameter.

A parametrized class:

    class my_webapp (
      $required_param,
      $param_with_default = 'default value') {
      ... using the $required_param somewhere here ...
    }

    class { 'my_webapp': $required_param => 123, }
-->

---

Left out
--------
- variables, variable interpolation in strings
- templates instead of static files
- conditionals
- inheritance (overused?)
- functions (fail, warning, ...)
- facts
- ...

---

Congratulations, we are done!
----------------------------

What have we learned?

---

Next learning steps
-------------------

Read primarily

* my Minimalistic Practical Introduction to Puppet
* the types reference
* puppet language guide

Links to these and other valuable resources are [in the main README](https://github.com/jakubholynet/iterate-puppet-workshop13#links).

---

Feed-me-back! Q&A
=============

* Workshop:
  * Satisfied?
  * What to improve?
* Questions?
* Other feedback?

[R1]: http://docs.puppetlabs.com/references/2.7.latest/type.html "Puppet Type Reference"
