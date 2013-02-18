Iterate Puppet Miniworkshop 2/2013
==================================

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
3. Download a base box: `vagrant box add precise http://files.vagrantup.com/precise64.box`
4. Install VirtualBox, e,g, 4.2.0: http://download.virtualbox.org/virtualbox/4.2.0/
   (For the presenter: Make sure the VB version is the same as VB Guest Additions installed on the base box.)
5. Check out this repository: `git clone git://github.com/jakubholynet/iterate-puppet-workshop13.git`
6. Enter the repository (`cd iterate-puppet-workshop13`) and
initialize Vagrant: `vagrant up; vagrant reload`
7. Re-load vagrant to be sure everything is up to date: `vagrant
reload`
8. Get an editor with Puppet support - Emacs with the
[puppet mode](https://github.com/puppetlabs/puppet-syntax-emacs/blob/master/puppet-mode.el),
Vim with
[puppet.vim](http://downloads.puppetlabs.com/puppet/puppet.vim) or any
other [puppet-friendly editor](http://projects.puppetlabs.com/projects/1/wiki/Editor_Tips).

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

See the included presentation/.

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
3.
[Example: User and password-less ssh setup](https://github.com/iterate/codecamp2012/blob/puppet/manifests/my-user.pp)
(described in the [README](https://github.com/iterate/codecamp2012/blob/puppet/README.md).)
