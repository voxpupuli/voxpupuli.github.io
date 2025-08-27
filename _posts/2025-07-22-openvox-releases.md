---
layout: post
title: New OpenVoxProject 8 releases!
date: 2025-07-31
github_username: bastelfreak
---

## New OpenVoxProject 8 releases

After lots of development, we have a new round of releases available!

Our last releases are:

* openvox-agent [8.19.2](https://github.com/OpenVoxProject/openvox-agent/releases/tag/8.19.2)
* openvox-server [8.8.1](https://github.com/OpenVoxProject/openvox-server/blob/main/CHANGELOG.md#881-2025-03-19)
* openvoxdb [8.9.1](https://github.com/OpenVoxProject/openvoxdb/blob/main/CHANGELOG.md#891)

Our new releases:

* openvox-agent [8.21.1](https://github.com/OpenVoxProject/openvox-agent/releases/tag/8.21.1)
* openvox-server [8.10.0](https://github.com/OpenVoxProject/openvox-server/releases/tag/8.10.0)
* openvoxdb will soon follow

## Where are the releases?

Right now, those are *beta* releases because we did a lot of changes, see below.
That means that we haven't added them to our official repositories yet.
You can download the individual packages here:

* [openvox-agent](https://artifacts.voxpupuli.org/openvox-agent/8.21.1/)
* [openvox-server](https://artifacts.voxpupuli.org/openvox-server/8.10.0/)

We intend to keep the packages for at least one week in this beta state.
When no issues are reported, we will move them to the official repositories after 2025-08-09.

## Where do I report bugs and feature requests?

Please come to our `#voxpupuli` channel on IRC or Slack (see [voxpupuli.org/connect](https://voxpupuli.org/connect/)).

## What changed?

We migrated from a local release process (as in: someone glues it together on their laptop and uploads the packages) to GitHub pipelines.

### Release process changes

* All our repositories now run their tests for each pull request
* Each release is automatically documented in a CHANGELOG.md
* We create a GitHub Release, also with a changelog
* For each Ruby gem release to rubygems.org, we use [trusted publishing](https://guides.rubygems.org/trusted-publishing/)
* All GitHub workflows were updated to use minimal permissions

### Deprecated and broken operating systems

We won't provide packages for the following EoL operating systems anymore:

* Ubuntu 18.04
* Ubuntu 20.04
* Debian 10

Debian [broke their container images](https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=1109866) for Debian 11, so we cannot run tests for it right now.

Also, we currently do not provide new packages for OpenVox 7 - we encourage users to migrate to OpenVox 8.

If someone is interested in those EoL operating systems or in OpenVox 7 packages, they can provide PRs for it or reach out to one of [our partners for a support contract](https://voxpupuli.org/openvox/support/).

### New OSes

We did some initial packaging for EL10 server packages and for Java 21, which looks promising so far.
We currently don't run acceptance tests for EL10 or Debian 13, we want to add that as soon as possible.
Agent packages for EL10 and Debian 13 are already available since the last release.

## How do we do versioning?

You might ask yourself why we jumped from openvox-agent 8.19.2 to 8.21.1. First we need to explain a bit what's in the openvox-agent.
This contains basically two things:

* [openvox](https://github.com/OpenVoxProject/openvox/blob/main/CHANGELOG.md)
* [puppet-runtime](https://github.com/OpenVoxProject/puppet-runtime/releases)

openvox is the actual Ruby code (formerly known as Puppet).
puppet-runtime handles the compilation of all the dependencies within an openvox-agent package (Ruby, Curl, openssl, our beloved libxml/nokogiri/libxslt and others).
The openvox-agent repository glues openvox and puppet-runtime together into rpm/deb packages.
That means that openvox and puppet-runtime both have individual changelogs.
And not every release we did for openvox resulted in a new openvox-agent release.
While we implemented the new release- and testing-pipelines, some releases were broken and we didn't publish them onto our repositories, but we also didn't want to reuse the release numbers.

### Noteworthy changes

* We now have our own facter implementation, [openfact](https://github.com/OpenVoxProject/openfact/blob/main/CHANGELOG.md)
* All Vox Pupuli module pipelines were updated to use openfact instead of facter
* All Vox Pupuli pipelines were updated to use the openvox gem instead of the puppet gem
* openvox-agent & openvox-server now use openfact instead of facter
* The systemd unit for openvox-server switched from `Type=forking` to `Type=exec` and we removed the wrapper scripts in the systemd unit
* We will do the same for the next openvoxdb release
* openvox-server packages on EL depend on the correct java package (EL7 with Java 11, EL8 & EL9 with Java 17, EL10 with Java 21)
* openvox-server on EL doesn't use `/usr/bin/java` anymore, but the correct path to the correct Java version
* We will do the same for the next openvoxdb release and for Debian/Ubuntu
* We added Ruby 3.3 & 3.4 testing to all projects
* With [openbolt](https://github.com/OpenVoxProject/openbolt/blob/main/CHANGELOG.md), we now have an open source successor of bolt. We already released a beta version to rubygems and want to release the first packages soon

**openvox-agent 8.21.1 cannot be installed together with openvox-server 8.8.1 or older on the same system.**

**openvox-server 8.10.0 cannot be installed together with openvox-agent 8.19.2 or older on the same system.**

Please test the releases and provide feedback!
Let us know if you have any feature requests, find bugs, want to participate, or are interested in a support contract.
