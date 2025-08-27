---
layout: post
title: OpenVox - now with OpenFact!
date: 2025-08-26
github_username: nmburgan
---

In our last blog post, we mentioned some new beta releases that include [OpenFact](https://github.com/OpenVoxProject/openfact/blob/main/CHANGELOG.md). At the same time, we've been hard at work refactoring some of the build tooling to make it much easier to maintain and understand. As we've been working through these changes, we found some issues preventing us from doing releases of the whole stack.

While the new openvox-agent packages that include OpenFact will work communicating with older openvox-server or puppetserver installations, you cannot install the new openvox-agent packages on the same node as an older openvox-server or puppetserver package due to conflicts between OpenFact and Facter. On the server node, you will need to upgrade both openvox-agent to 8.21+ and openvox-server and openvoxdb to 8.11+.

However, we never did a final release of anything past openvox-agent 8.19.2, openvox-server 8.8.1, or openvoxdb 8.9.1. These versions all still contain Facter. In order to get everyone past the OpenFact threshold, we've decided to do a release using the old version of the ezbake tooling for server/db.

We intend to do some fast-follow releases after this, addressing a slew of dependency updates, and utilizing the new version of our build tooling once we've been able to fully test it and get it solid.

## Platform additions/removals

### Added

* Ubuntu 25.04 (agent, server, db)
* Debian 13 (server, db)

### Removed

* Ubuntu 18.04 (agent, server, db)
* Ubuntu 20.04 (agent, server, db)
* Fedora 36 (agent)
* Fedora 40 (agent)

## openvox-agent

(Note: 8.22.0 included an inadvertent rename of the `puppet` service. Make sure you use 8.22.1.)

Version 8.22.1 includes the new OpenFact, replacing Facter. This also includes an update to Ruby 3.2.9. We've also removed pxp-agent from all agent packages, and included a lightweight execution_wrapper that is used by Choria (note the package does not include Choria itself).

Additionally, in case you missed it, there is now an `openvox` gem on [Rubygems](https://rubygems.org/gems/openvox)!

## openvox-server

Version 8.11.0 includes OpenFact, and updates to rexml and net-imap to address CVEs. Also, this version now works with Java 21.

## openvoxdb

Version 8.11.0 includes a lot of cleanup under the hood, as well as support for Java 21.

## What's on the horizon?

* openvox-server and openvoxdb built with a simpler toolchain and service configuration
* MacOS agents for more platform flavors. We are looking into support for MacOS 13 and 14, both x86_64 and arm64, and looking to create a single binary for all currently supported MacOS versions (13+) per architecture. We are also hoping to get these builds into GitHub Actions soon.
* openvox-server and openvoxdb for Fedora. Note that current EL packages should work fine for these platforms, but we are working to get them into the Fedora repos for ease of use.
* Non-security-related updates to lots of dependencies
