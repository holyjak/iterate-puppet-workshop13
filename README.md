Iterate Puppet Miniworkshop 2/2013
==================================

Goal
-----

Teach usable basics of Puppet to people without any previous
experience. Practical, hands-on.

About
-----
Creating some users, installing a database and an Apache server, configuring and starting it, deploying a website onto it sounds is an easy job. But after few years in production, with countless upgrades and small changes, you have no more any idea what stuff and version you are running and how it was set up. Now what if you suddenly need 20 of these servers?
What if you could somehow describe what you want to have installed/configured/running, keep that description under version control, and be able to apply it to any number of new machines? That is exactly what Puppet, the configuration management and automation tool, does.

Come to learn how to use this magical tool to configure servers in a documented, reusable, shareable way. We will also play with Vagrant, a tool for making "portable development environments".

### What will I learn?
At the end you will know what Puppet is, how to do the most common operations (from package installation to Apache running a website), and what else it can do and how to learn more plus you will get a hands-on experience with Vagrant.

### What do I need to know/have?
Some experience with Linux and the command line is perhaps the only
knowledge requirement, some knowledge of Ruby is a plus.

Aside of that, you will need to follow the 8 preparation steps described
below well ahead of the workshop.

It is possible to use Windows machines but they are likely to face some
challenges; Linux or OS X is recommended.

Required participant preparation prior to the workshop
------------------------------------------------------

Notice: Downloading and installing the software and virtual box image
might take over an hour so do it early.


1. Install VirtualBox, e.g. 4.2.12: http://download.virtualbox.org/virtualbox/4.2.12/
2. Install Vagrant: http://downloads.vagrantup.com/tags/v1.2.2
3. Install `$ vagrant plugin install vagrant-vbguest` ([Why?](http://theholyjava.wordpress.com/wiki/tools/vagrant-notes/#tip_install_vagrant-vbguest))
4. Check out this repository: `git clone git://github.com/jakubholynet/iterate-puppet-workshop13.git`
 (or just download and unpack the [zip archive of this](https://github.com/jakubholynet/iterate-puppet-workshop13/archive/master.zip))
5. Enter the repository (`cd iterate-puppet-workshop13`) and
initialize Vagrant: `vagrant up`
6. Re-load vagrant to be sure everything is really up to date: `vagrant
reload`
7. Get an editor with Puppet support - Emacs with the
[Puppet mode](https://github.com/puppetlabs/puppet-syntax-emacs/blob/master/puppet-mode.el),
Vim with
[puppet.vim](http://downloads.puppetlabs.com/puppet/puppet.vim) or any
other
[puppet-friendly editor](http://projects.puppetlabs.com/projects/1/wiki/Editor_Tips)
or at least one with Ruby syntax highlighting.

Right before the workshop:

1. Open the following pages in your browser:
   * Puppet Type Reference:
   [http://docs.puppetlabs.com/references/2.7.latest/type.html](http://docs.puppetlabs.com/references/2.7.latest/type.html)
   * Defining a Class:
   [http://docs.puppetlabs.com/puppet/2.7/reference/lang_classes.html#defining-a-class](http://docs.puppetlabs.com/puppet/2.7/reference/lang_classes.html#defining-a-class)
   * Relationship metaparameters:
[http://docs.puppetlabs.com/puppet/2.7/reference/lang_relationships.html#relationship-metaparameters](http://docs.puppetlabs.com/puppet/2.7/reference/lang_relationships.html#relationship-metaparameters)
   * The Apache module documentation: [https://forge.puppetlabs.com/puppetlabs/apache](https://forge.puppetlabs.com/puppetlabs/apache)
2. Make sure you have network access!

Note: The precise32 box comes pre-installed with VirtualBox guest additions
4.2.0 => either use VB 4.2.0 or the vagrant-vbguest plugin to
automatically upgrade them to make sure that Vagrant will be able to communicate with the VM
without any problems (requires `vagrant reload` after `up` to
reload the updated kernel).

Note: The latest version of Puppet is 3.1 but we will be using 2.7.x
since that is what comes pre-installed with Vagrant. For our purpose,
[the differences](http://docs.puppetlabs.com/puppet/3/reference/release_notes.html)
aren't that important.

Warning for Windows users - there are unfortunately some challenges:
* `vagrant ssh` doesn't work; check [Vagrant documentation](http://docs-v1.vagrantup.com/v1/docs/getting-started/ssh.html) for help
* `puppet-lint` might complain about carriage-returns added automatically by `git clone`


Plan (1-2h)
---------

1. (0.5m) Intro: What, why, and how are we going to learn
2. (3m) What is Puppet?
    * what need does it satisfy, few words about how it works
3. (50-110m) Workshop & discussion
4. (5m) Summary, feedback, questions

Why Vagrant?
------------

We will use a virtual machine (VM) managed by Vagrant for the workshop
because it is easier to experiment with.

Start the VM with `vagrant up`, apply the puppet manifest with
`vagrant provision`, log into the VM with `vagrant ssh`, destroy and
re-create the VM to get clean state: `vagrant destroy; vagrant up;
vagrant reload`. Notice also that this directory is shared with the VM
as `/vagrant/`.

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

### Tutorials, examples etc.
1. J. Holy: [Minimalistic Practical Introduction to Puppet (Not Only) For Vagrant Users][PuppetIntro]
2. [Puppet Troubleshooting: Compiling Catalog, Locating a Cached Catalog](http://theholyjava.wordpress.com/2012/10/17/puppet-where-to-find-the-cached-catalog-on-client/)
3. [Example: User and password-less ssh setup](https://github.com/iterate/codecamp2012/blob/puppet/manifests/my-user.pp)
(described in the
[README](https://github.com/iterate/codecamp2012/blob/puppet/README.md).)
4. [Simple Puppet Module Structure Redux](http://www.devco.net/archives/2012/12/13/simple-puppet-module-structure-redux.php)
(12/2012) - blueprint/base for creating good, readable modules
5. [Example42 Puppet Tutorials](http://www.example42.com/?q=Example42PuppetTutorials):
[Puppet Essentials](http://example42.com/tutorials/build/deck/essentials/),
[Puppet Advanced Topics](http://example42.com/tutorials/build/deck/advanced/)
6. PuppetLabs: [Learning Puppet](http://docs.puppetlabs.com/learning/)
7. [Puppet Cookbook](http://www.puppetcookbook.com/) (online)
8. [Verifying Puppet: Checking Syntax and Writing Automated Tests](https://puppetlabs.com/blog/verifying-puppet-checking-syntax-and-writing-automated-tests/)
(Jan 2012)

### Puppet Docs (v2.7)
1. [Puppet Type Reference](http://docs.puppetlabs.com/references/2.7.latest/type.html)
2. [Defining a Class](http://docs.puppetlabs.com/puppet/2.7/reference/lang_classes.html#defining-a-class)
3. [Relationship metaparameters](http://docs.puppetlabs.com/puppet/2.7/reference/lang_relationships.html#relationship-metaparameters)
(subscribe etc.)
4. [Module Fundamentals](http://docs.puppetlabs.com/puppet/2.7/reference/modules_fundamentals.html)
    - module layout, auto-loading of modules etc.
5. [Puppet Style Guide](http://docs.puppetlabs.com/guides/style_guide.html)
    - indent with two spaces, use single quotes wherever possible, ensure
always first, avoid inheritance

### Tools
1. [puppet-lint](http://puppet-lint.com/) - check your
Puppet manifests against the Puppet Style Guide; you should always use it
2. [rpsec-puppet](http://rspec-puppet.com/) - unit testing of Puppet
manifests (useful if they contain conditional logic, doesn't run the
manufest but checks its compiled output for a given input)


[PuppetIntro]:
http://theholyjava.wordpress.com/2012/08/13/minimalistic-practical-introduction-to-puppet-for-vagrant-users/ "Minimalistic Practical Introduction to Puppet (Not Only) For Vagrant Users"
