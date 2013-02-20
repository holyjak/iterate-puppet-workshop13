Iterate Puppet Miniworkshop 2/2013
==================================

*TODO*: ADD 'SOLUTION SLIDES' to each task

Let's get going!

!

Intro
=====

1. (3m) Intro: What, why, and how are we going to learn
   * Learning based on your questions => ask!
   * Why Vagrant, V. x normal puppet agent
2. (5m) What is Puppet?
    * provisioner (=?) => many nodes
    * p. vs. shell scripts (cross-platform, modules, master-slave,
      handles unimportant details itself, DRY, ...)
    * declarative, not imperative (=> order)
    * few words about syntax (ruby-like, ...)
3. (40m) Workshop
4. (5m) Summary, feedback, questions
<!--
Puppet:
- Describe what "resources" to create/remove etc. (files, packages,
  users, ..)
- Done in a manifest - a .pp text file with Ruby-based puppet code
-->

!

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

!

### Topic 1. Installing packages

A simple example of a resource declaration:

    package { 'vim':
      ensure => latest,
    }

What is this?

    <resource_type> { <resource_name>:
      ensure => present,
      property2 => value2,
    }

<!-- COMMENTS:
This is a basic building block of Puppet code. Notes:
- ensure on most resources, different values: file, directory,
  symlink, installed, ...
- the name is usually meaningful: the file path to create or package
  to install
-->
Noticed anything strange? (`,`)

!

#### Task 1.1

In `puppet/manifests/site.pp`, install the packages `vim` and
`apache2`.

Run `vagrant provision` to apply the changes. Refer to [R1]:

http://docs.puppetlabs.com/references/2.7.latest/type.html

Protip: Use an array (<code>[x, y, ...]</code>) to declare multiple same resources at once.
(Arrays are used/allowed at multiple places.)
<!--
LEARNING: First experience with Puppet code, how to apply it, the
resource type reference.
TODO: vagrant provision vs. running puppet agent manually
-->

!

### Topic 2. Running services and handling dependencies

**Task 2.1**: Make `apache2` start using the `service` resource (->
[R1]).

Tips:

* The name maps to a file in `/etc/init.d/` (`apache2`, in this case)
* You only need `ensure` now

!

##### Intermezzo

Puppet is declarative, not imperative => no defined order
of action execution => express dependencies explicitely:

    package { 'ring': ensure => installed, }
    file { '/frodo': .., require => [Package['ring']], }

**Task 2.2**: Make the `apache2` *service* depend on the `apache2` *package*.

Note: Refer to resources via `ResourceType['name']` (notice
the initial capital letter).

!

### Topic 3. Using classes for structure and reuse

Classes encapsulate independent and reusable pieces of configuration.
They also make it more reusable via parametrization.

Class example:

    class my_webapp {
      ... # install packages etc.
    }
    
    class { 'my_webapp': }
    # In this case, this would also suffice:
    # include my_webapp

<!--
Here we (1) define and (2) apply a class
-->
See
[Defining a Class](http://docs.puppetlabs.com/puppet/2.7/reference/lang_classes.html#defining-a-class).

!

**Task 3.1**: Wrap the resources defined so far in a class

The class has already been defined for you in
`puppet/modules/my_webapp/site.pp` (we will talk about modules later)
=>

1. move the resources into it
2. apply the class in the original `site.pp`

!

### Topic 4. Copying files and directories

**Task 4.1**: Copy the *www* folder into `/var/www/my_web` and let the user
  *www-data* own it.

* use the file resource to create the parent folders
* another one to copy the directory (recursively)
* the directory is in `puppet/modules/my_webapp/files/www`
* which is visible to puppet as `puppet://modules/my_webapp/www`

**Intermezzo**: How can I be sure the files are created after their
directories without any `require`? Autorequire!

!

**Task 4.2**: Copy also the Apache site config that is
 under `.../files/etc/apache2` into the corresponding places in  `/etc/apache2/`.

!

#### Topic 5. Dependencies II: reload after configuration change

Apache doesn't only require its configuration, it should also be
restarted ("reloaded") whenever it changes.

**Task 5.1**: Tell Puppet to restart Apache when its configuration changes.

Tip: See the
[relationship metaparameter](http://docs.puppetlabs.com/puppet/2.7/reference/lang_relationships.html#relationship-metaparameters)
`subscribe`.

!

### Topic 6. The final round: modules

**Task 1:** Use the [puppetlabs apache module] instead of doing everything
manually

- use its `docroot` parameter to specify where the web content is

*TODO Will need to add the hostname to /etc/hosts?*

*TODO How to best install the module? Download & unpack?*

[puppetlabs apache module]: https://forge.puppetlabs.com/puppetlabs/apache

See also [apache:vhost source](https://github.com/puppetlabs/puppetlabs-apache/blob/master/manifests/vhost.pp).

<!--
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
!

Congratulations, we are done!
----------------------------

!

Next learning steps
-------------------

Read my Minimalistic Practical Introduction to Puppet (link in the README.md) and the
types reference and puppet language guide at docs.puppetlabs.com.

Some things to learn:

- conditionals, facts
- more language and features,
- testing, workflow, pitfalls, best practices
- reuse: modules, forge, puppet stdlib, functions, ...

!

Feed-back! Q&A
=============

* Workshop:
  * Satisfied?
  * What to improve?
* Questions?
* Other feedback?

[R1]: http://docs.puppetlabs.com/references/2.7.latest/type.html "Puppet Type Reference"
