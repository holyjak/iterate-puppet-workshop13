Iterate Puppet Miniworkshop 2/2013
==================================

Goal
----

Teach usable basics of Puppet to people without any previous
experience. Practical, hands-on.

Hold on Iterate Conference winter edition 2013.

Required participant preparation prior to the workshop
------------------------------------------------------

Notice: Downloading and installing the software and virtual box image
might take over an hour so do it early.

1. Install Vagrant: http://downloads.vagrantup.com/tags/v1.0.6
2. Install `$ vagrant gem install vagrant-vbguest` ([Why?](http://theholyjava.wordpress.com/wiki/tools/vagrant-notes/#tip_install_vagrant-vbguest))
3. Download a base box: `vagrant box add precise http://files.vagrantup.com/precise64.box`
4. Install VirtualBox, e,g, 4.2.0: http://download.virtualbox.org/virtualbox/4.2.0/
5. Check out this repository: `git clone git://github.com/jakubholynet/iterate-puppet-workshop13.git`
6. Enter the repository (`cd iterate-puppet-workshop13`) and
initialize Vagrant: `vagrant up`
7. Re-load vagrant to be sure everything is really up to date: `vagrant
reload`
8. Get an editor with Puppet support - Emacs with the
[puppet mode](https://github.com/puppetlabs/puppet-syntax-emacs/blob/master/puppet-mode.el),
Vim with
[puppet.vim](http://downloads.puppetlabs.com/puppet/puppet.vim) or any
other
[puppet-friendly editor](http://projects.puppetlabs.com/projects/1/wiki/Editor_Tips)
or at least one with Ruby syntax highlighting.
9. Open the following pages in your browser:
   * Puppet Type Reference:
   [http://docs.puppetlabs.com/references/2.7.latest/type.html](http://docs.puppetlabs.com/references/2.7.latest/type.html)
   * Defining a Class:
   [http://docs.puppetlabs.com/puppet/2.7/reference/lang_classes.html#defining-a-class](http://docs.puppetlabs.com/puppet/2.7/reference/lang_classes.html#defining-a-class)
   * Relationship metaparameters: [http://docs.puppetlabs.com/puppet/2.7/reference/lang_relationships.html#relationship-metaparameters](http://docs.puppetlabs.com/puppet/2.7/reference/lang_relationships.html#relationship-metaparameters)

Note: The precise64 box comes pre-installed with VirtualBox guest additions
4.2.0 => either use VB 4.2.0 or the vagrant-vbguest plugin to
automatically upgrade them (requires `vagrant reload` after `up` to
reload the updated kernel).

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

Plan (1h)
---------

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

The tasks will be presented during the workshop.

Next learning steps
-------------------

Learn more of the puppet language, features, testing, workflow, pitfalls, best practices
(modules), forge, puppet stdlib, functions, ... .

Start by reading [PuppetIntro][PuppetIntro].

Resources
---------

[R1]: http://docs.puppetlabs.com/references/2.7.latest/type.html "Puppet Type Reference"

Links
-----

1. J. Holy:
[Minimalistic Practical Introduction to Puppet (Not Only) For Vagrant Users][PuppetIntro]
    * Related:
[Simple Puppet Module Structure Redux](http://www.devco.net/archives/2012/12/13/simple-puppet-module-structure-redux.php) (12/2012) - blueprint/base for creating good, readable modules

2. 
[Puppet Troubleshooting: Compiling Catalog, Locating a Cached Catalog](http://theholyjava.wordpress.com/2012/10/17/puppet-where-to-find-the-cached-catalog-on-client/)
3. 
[Example: User and password-less ssh setup](https://github.com/iterate/codecamp2012/blob/puppet/manifests/my-user.pp)
(described in the
[README](https://github.com/iterate/codecamp2012/blob/puppet/README.md).)
4. [Simple Puppet Module Structure Redux](http://www.devco.net/archives/2012/12/13/simple-puppet-module-structure-redux.php) (12/2012) - blueprint/base for creating good, readable modules

[PuppetIntro]:
http://theholyjava.wordpress.com/2012/08/13/minimalistic-practical-introduction-to-puppet-for-vagrant-users/ "Minimalistic Practical Introduction to Puppet (Not Only) For Vagrant Users"
