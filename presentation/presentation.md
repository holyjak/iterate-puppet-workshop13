Iterate Puppet Miniworkshop 2/2013
==================================

*TODO*: ADD 'SOLUTION SLIDES' to each task

Let's get going!

!

Intro
=====

*TODO*

1. (3m) Intro: What, why, and how are we going to learn
2. (5m) What is Puppet?
    * provisioner (=?)
    * p. vs. shell scripts (cross-platform, modules, master-slave,
      handles unimportant details itself, DYI, ...)
    * declarative, not imperative (=> order)
    * few words about syntax (ruby-like, ...)
3. (40m) Workshop
4. (5m) Summary, feedback, questions

!

Tasks
=====

Goal: Get a static site up on Apache.

Learnings the basics:

* install a package
* copy files
* start a service
* express dependencies

Advanced stuff:

* modules

!

#### Topic 1. Installing packages

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

!

#### Task 1

In `puppet/manifests/site.pp`, install the packages `vim` and
`apache2`. Run `vagrant provision` to apply the changes. Refer to [R1].

[R1]: http://docs.puppetlabs.com/references/2.7.latest/type.html "Puppet Type Reference"

Protip: Use an array (`[x, y, ...]`) to declare multiple same resources at once.
(Arrays are used/allowed at multiple places.)

!

#### Topic 2. Running services and handling dependencies

**Task 2.1**: Make `apache2` start using the `service` resource (->
[R1]).

Tips:

* The name maps to a file in `/etc/init.d/` (`apache2`, in this case)
* You only need `ensure` now

!

##### Intermezzo

Puppet is declarative, not imperative => no defined order
of action execution => express dependencies explicitely:

    package { 'ring: ensure => installed, }
    file { '/frodo': .., require => [Package['ring']], }

**Task 2.2**: Make the `apache2` service depend on the `apache2` package.

Note: Refer to resources via `ResourceType['name']` (notice
the initial capital letter).

!

#### Topic X. Using classes for order and reuse

Classes encapsulate independent and reusable pieces of configuration.
They also make more reusable via parametrization.

Class example:

    class my_webapp {
      ...
    }
    
    class { 'my_webapp': }
    # In this case, this would also suffice:
    # include my_webapp

See
[Defining a Class](http://docs.puppetlabs.com/puppet/2.7/reference/lang_classes.html#defining-a-class).

!

**Task 1**: Wrap the resources defined so far in a class

The class has already been defined for you in
`puppet/modules/my_webapp/site.pp` (we will talk about modules later)
so just move the resources into it.

!

#### 3. Copying files and directories

**Task 3.1**: Copy the www folder with proper permissions to
`/var/www/my_web`

* use the file resource to create the parent folders
* another one to copy the directory (recursively)
* the directory is in `puppet/modules/my_webapp/files/www`
* which is visible to puppet as `puppet://modules/my_webapp/www`

**Intermezzo**: How can I be sure the files are created after their
directories without any `require`? Autorequire!

!

**Task 3.2**: Copy also the Apache site config that is in the module files
directory, under `etc/apache2`.

!

##### Topic 4. Dependencies II: reload after configuration change

**Task 4.1**: Tell Puppet to restart apache when its configuration changes.

Tip: See the `subscribe` [relationship metaparameter](http://docs.puppetlabs.com/puppet/2.7/reference/lang_relationships.html#relationship-metaparameters).

!

#### Topic 6. The final round: modules

**Task 1:** Use the [puppetlabs apache module] instead of doing everything
manually

- use its `docroot` parameter to specify where the web content is

*TODO Will need to add the hostname to /etc/hosts?*

*TODO How to best install the module? Download & unpack?*

[puppetlabs apache module]: https://forge.puppetlabs.com/puppetlabs/apache

See also [apache:vhost source](https://github.com/puppetlabs/puppetlabs-apache/blob/master/manifests/vhost.pp).

!

##### Topic X. Parametrized classes (to be dropped????)

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

!

Next learning steps
-------------------

Read [1], read the types reference and puppet language guide.

More to learn:

- conditionlals, facts
- more language, features, testing, workflow, pitfalls, best practices
  (modules), forge, puppet stdlib, functions, ...

!

Links
-----

1. J. Holy: [Minimalistic Practical Introduction to Puppet (Not Only) For Vagrant Users](http://theholyjava.wordpress.com/2012/08/13/minimalistic-practical-introduction-to-puppet-for-vagrant-users/)
*
[Simple Puppet Module Structure Redux](http://www.devco.net/archives/2012/12/13/simple-puppet-module-structure-redux.php) (12/2012) - blueprint/base for creating good, readable modules
2. [Puppet Troubleshooting: Compiling Catalog, Locating a Cached Catalog](http://theholyjava.wordpress.com/2012/10/17/puppet-where-to-find-the-cached-catalog-on-client/)
3.
[Example: User and password-less ssh setup](https://github.com/iterate/codecamp2012/blob/puppet/manifests/my-user.pp)
(described in the [README](https://github.com/iterate/codecamp2012/blob/puppet/README.md).)
