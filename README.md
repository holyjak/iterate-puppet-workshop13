Iterate Puppet Miniworkshop 2/2013
==================================

*TODO:*

* Follow best practices and define all in a module, calling it from a `site.pp`?

Goal
----

Teach usable basics of Puppet to people without any previous
experience. Practical, hands-on.

Hold on Iterate Conference winter edition 2013.

Required participant preparation prior to the workshop
------------------------------------------------------

TBD (git checkout this, install and try vagrant + VB, ...)
TBD: Update versions (VB to match vagrant's base box, if possible)

1. Install Vagrant: http://downloads.vagrantup.com/tags/v1.0.6
2. Install `$ vagrant gem install vagrant-vbguest` ([Why?](http://theholyjava.wordpress.com/wiki/tools/vagrant-notes/#tip_install_vagrant-vbguest))
3. Download a base box: `vagrant box add base http://files.vagrantup.com/lucid32.box`
4. Install VirtualBox, e,g, 4.2.6: http://download.virtualbox.org/virtualbox/4.2.6/
   (For the presenter: Make sure the VB version is the same as VB Guest Additions installed on the base box.)
5. Check out this repository: `git clone ...`
6. Enter the repository (`cd iterate-puppet-workshop13`) and
initialize Vagrant: `vagrant up; vagrant reload`
7. Re-load vagrant to be sure everything is up to date: `vagrant
reload`

Note: The precise64 box comes pre-installed with VirtualBox guest additions
4.2.0 => euther use VB 4.2.0 or the vagrant-vbguest plugin to
automatically upgrade them (requires `vagrant reload`after up).

Note: The latest version of Puppet is 3.1 but we will be using 2.7.x
since that is what comes pre-installed with Vagrant. For our purpose,
[the differences](http://docs.puppetlabs.com/puppet/3/reference/release_notes.html)
aren't that important.

Content draft
-------------

Based on practical experiences from Comoyo.

* Including: Installing packages, copying files, running services,
declaring dependencies & notifications, creating users, templates,
exec, arrays, ...
.
* To consider: defaults, declaring custom resources, pitfalls, ...
* Best practices: Structuring, lint, coding guidelines.

----
Time plan (1h):

1. (3m) Intro: What, why, and how are we going to learn
2. (5m) What is Puppet?
    * provisioner (=?)
    * p. vs. shell scripts (cross-platform, modules, master-slave,
      handles unimportant details itself, DYI, ...)
    * declarative, not imperative (=> order)
    * few words about syntax (ruby-like, ...)
3. (40m) Workshop
4. (5m) Summary, feedback, questions

Tasks
-----

### 1. Get up static site on Apache

Goals: Install a package, copy files, start a service, express dependencies.

#### Installing packages

A simple example of a resource declaration:

    package { 'vim':
      ensure => latest,
    }

What is this?

    <resource_type> { <resource_name>:
      property1 => value1,
      property2 => value2,
    }

Noticed anything strange? (`,`)

Task 1: Install the packages `vim` and `apache2`. Run `vagrant
provision` to apply the changes. Refer to [R1].

Protip: Use an array to declare multiple same resources at once.
(Arrays used/allowed at multiple places.)

#### Running services and handling dependencies

Task 2: Start `apache2` using the `service` resource (-> [R1]).

Intermezzo: Puppet is declarative, not imperative => no defined order
of action execution => express dependencies explicitely.

Task 3: Make the `apache2` service depend on the `apache2` package.

Intermezzo: Referring to resources via `ResourceType['name']` (notice
the initial capital letter).

#### Copying files and directories

Task 4: Copy the www folder with proper permissions to `/var/www/my_web`
(available as `/vagrant/www`)

Intermezzo: How can I be sure the files are created after their
directories without any `require`? Autorequire!

Task 5: Copy the Apache site config *TODO where from, prepare*

##### Dependencies II: reload after configuration change

Task 6: Tell Puppet to restart apache when its configuration changes.
(Tip: See the `subscribe` [Relationship Metaparameter](http://docs.puppetlabs.com/puppet/2.7/reference/lang_relationships.html#relationship-metaparameters).)

### X. Using classes for order and reuse

Why: Encapsulate independent and reusable pieces of configuration,
make more reusable via parametrization.

Task 1: Wrap the resources defined so far in a class

    class my_webapp {
      ...
    }
    
    class { 'my_webapp': }
    # In this case, this would suffice: include my_webapp

See
[Defining a Class](http://docs.puppetlabs.com/puppet/2.7/reference/lang_classes.html#defining-a-class).

Task 2: Make the choice of editor to install parametrized

Some teams require vim, some hate it and want pico; let them decide by
making the editor package into a parameter.

A parametrized class:

    class my_webapp (
      $required_param,
      $param_with_default = 'default value') {
      ... using the $required_param somewhere here ...
    }
    
    class { 'my_webapp': $required_param => 123, }

### X. Users, ssh, keys

TODO (perhaps leave out due to time, point to an example)

### X. The final round: TBD (parametrized classes, conditionals, facts, modules, ...)

Tsk 1: Use the [puppetlabs apache module] instead of doing everything
manually

- use `docroot`
- *TODO* Will need to add the hostname to /etc/hosts?

[puppetlabs apache module]: https://forge.puppetlabs.com/puppetlabs/apache

See also [apache:vhost source](https://github.com/puppetlabs/puppetlabs-apache/blob/master/manifests/vhost.pp).

TODO (use a module to install mysql?)

Next learning steps
-------------------

TODO (follow [1]?)
- more language, features, testing, workflow, pitfalls, best practices
  (modules), forge, puppet stdlib, functions, ...

Resources
---------

[R1]: http://docs.puppetlabs.com/references/2.7.latest/type.html "Puppet Type Reference"

Links
-----

1. J. Holy: [Minimalistic Practical Introduction to Puppet (Not Only) For Vagrant Users](http://theholyjava.wordpress.com/2012/08/13/minimalistic-practical-introduction-to-puppet-for-vagrant-users/)
*
[Simple Puppet Module Structure Redux](http://www.devco.net/archives/2012/12/13/simple-puppet-module-structure-redux.php) (12/2012) - blueprint/base for creating good, readable modules
2. [Puppet Troubleshooting: Compiling Catalog, Locating a Cached Catalog](http://theholyjava.wordpress.com/2012/10/17/puppet-where-to-find-the-cached-catalog-on-client/)
