---
layout: post
title: How to run beaker acceptance tests
date: 2025-06-17
summary: A very short description of how to run the vox pupuli acceptance test suite for puppet modules.
---

- [Installing System Dependencies](#installing-system-dependencies)
  - [Runtime Environment](#runtime-environment)
  - [Configuring Bundler](#configuring-bundler)
- [Setting up to run a test suite](#setting-up-to-run-a-test-suite)
  - [Listing platforms](#listing-platforms)
  - [Running Beaker](#running-beaker)
- [Adding data to a run](#adding-data-to-a-run)
- [Resources](#resources)

# Running Vox Pupuli Acceptance Tests

The testing and development tools have a bunch of dependencies, all managed by [bundler](http://bundler.io/).
The tests use the latest version of Puppet.

## Installing system dependencies

### Runtime Environment

Beaker uses a local hypervisor or container stack to build required OS/Distributions to test.
By default this is docker, but vagrant via VirtualBox and libvirt as well as VMWare vSphere are available.

In general, docker is preferred for modules, and is what the Vox Pupuli CI systems use by default, making it the best option.

Follow the instructions from [Docker](https://docs.docker.com/engine/install/) or your preferred/known working method to install.

For libvirt / vagrant, use the distribution's packages to configure.

_Remember to add your user to the group that allows access to docker/libvirt._

### Bundle/Ruby

Beaker is installed as a gem via bundler, it will run in ruby 2.7 to 3.4 (as of time of writing).
It should be trivial to install via your package manager or gem.

#### Debian/Ubuntu
```shell
# apt install ruby-bundler
```

#### RedHat (and similar)
As of el9, dnf replaces yum.  Use the appropriate package manager to get it installed.
```shell
# yum install rubygem-bundler
# dnf install rubygem-bundler
```

#### ArchLinux
```shell
# pacman -Sy extra/ruby-bundler
```

#### By Gem (Last Option)
```shell
# gem install bundler
```

### Configuring Bundler

Install all needed gems for spec tests into the modules directory by running:

```shell
bundle config set --local path '.vendor'
bundle config set --local without 'development release'
BUNDLE_JOBS="$(nproc)" bundle install
```

This will install the gems and working space for bundler into a directory called .vendor in the
module's top level directory.
If your bundle stops working for some reason, you can run `bundle update && bundle clean` to fix it.

## Setting up to run a test suite

At this point bundler and beaker are installed and ready for use.
For Vox Pupuli's acceptance testing suite, beaker is managed by a set of environment variables.


* `BEAKER_HYPERVISOR` Sets the Hypervisor, `vagrant` or `vagrant_libvirt` for VM based testing
  It is a good idea to export the `BEAKER_HYPERVISOR` variable in your shell configuration.
* `BEAKER_DESTROY` Should the test environment be removed at the end of a test
  * `BEAKER_DESTROY=onpass` Only removes the environment if everything passes, allowing review of the system in the state it was in when the test suite failed.
  * `BEAKER_DESTROY=no` Always leave an artifact, which likely will break future runs without cleanup.
  * `BEAKER_DESTROY=yes` _(DEFAULT)_ always clean up.
* `BEAKER_PROVISION` Should we ensure a clean system is built to run the suite.
  * If `BEAKER_DESTROY` is set to no, `BEAKER_PROVISION=yes` will fail the run (because of the existing box/container)
  * If `BEAKER_DESTROY` is set to no, `BEAKER_PROVISION=no` will run the test suite against the system anyways, which may cause environmental issues if the test suite doesn't perfectly put things to a default state.

* `BEAKER_SETFILE` What should we be testing.  Beaker will call beaker-hostgenerator to create a defaultconfiguration based on this, using the known configurations for Vox Pupuli.
* `BEAKER_PUPPET_COLLECTION` What implementation and version of puppet are we testing against


### Listing Platforms

Installed as part of the voxpupuli test suite is `metadata2gha`, which as its name suggests, is a helper to generate a json blob containing the variables for all supported oses.

```shell
# From the base directory of the module
$ bundle exec metadata2gha | tail -n 1 | cut -d= -f2- | jq
[
# ... truncated for length
  {
    "name": "Puppet 8 - Debian 12",
    "env": {
      "BEAKER_PUPPET_COLLECTION": "puppet8",
      "BEAKER_SETFILE": "debian12-64{hostname=debian12-64-puppet8}"
    }
  },
  {
    "name": "Puppet 7 - Debian 12",
    "env": {
      "BEAKER_PUPPET_COLLECTION": "puppet7",
      "BEAKER_SETFILE": "debian12-64{hostname=debian12-64-puppet7}"
    }
  },
# ... truncated for length
  {
    "name": "OpenVox 8 - Rocky 9",
    "env": {
      "BEAKER_PUPPET_COLLECTION": "openvox8",
      "BEAKER_SETFILE": "rocky9-64{hostname=rocky9-64-openvox8}"
    }
  },
  {
    "name": "OpenVox 7 - Rocky 9",
    "env": {
      "BEAKER_PUPPET_COLLECTION": "openvox7",
      "BEAKER_SETFILE": "rocky9-64{hostname=rocky9-64-openvox7}"
    }
  },
# ... truncated for length
]
```

This returns names that show puppet implementation (openvox or puppet) / language version, and operating system / version.
It also provides the environment variables needed to be applied to run beaker for this combination.

### Running Beaker

At this point, everything is ready to run beaker.

Because everything is an environment variable, there are some options on running things.

1. export variables, then run `bundle exec rake beaker`
   ```shell
   export BEAKER_PUPPET_COLLECTION="openvox8"
   export BEAKER_SETFILE="ubuntu2404-64{hostname=ubuntu2404-64-openvox8}"
   bundle exec rake beaker
   ```
1. run `bundle exec rake beaker` with inline shell variables
   ```shell
   BEAKER_PUPPET_COLLECTION="openvox8" BEAKER_SETFILE="ubuntu2404-64{hostname=ubuntu2404-64-openvox8}" bundle exec rake beaker
   ```

## Adding data to a run

So far this process runs a default set of tests, with whatever data is already in the configuration, but some modules need to test different versions of the software as well, usually based on a fact.
To test with a specific fact passed to the tests or add the ability to test various versions of a piece of software in a module you can use variables in the form `BEAKER_FACTER_*`.

*For example:* `BEAKER_FACTER_sudoversion` would set the sudoversion fact to whatever the environment variable is set to.


## Resources
* [voxpupuli-acceptance](https://github.com/voxpupuli/voxpupuli-acceptance) for acceptance testing
* [beaker](https://github.com/voxpupuli/beaker) for the beaker software
* [voxpupuli-release](https://github.com/voxpupuli/voxpupuli-release) for bundling a release
* [puppet\_metadata](https://github.com/voxpupuli/puppet_metadata) how `metadata.json` becomes test data
