---
layout: post
title: New OpenVox-Server & DB (pre) releases!
date: 2026-04-24
github_username: bastelfreak
---

We will soon publish OpenVox-Server 8.13.0 & OpenVoxDB 8.13.0!

## Supported operating systems

* Amazon 2 & 2023
* Enterprise Linux 8, 9 & 10, 8-FIPS, 9-FIPS
* Fedora 42 & 43
* Debian 11, 12 & 13
* Ubuntu 22.04, 24.04, 25.04 & 26.04
* SLES 15 & 16

### New / removed platforms

This is the first release supporting Ubuntu 26.04.
We didn't remove any operating systems in this release.

## Timeline

We will wait a couple of days for feedback and afterwards move the packages to our official [apt.voxpupuli.org](https://apt.voxpupuli.org/) / [https://yum.voxpupuli.org/](https://yum.voxpupuli.org/) mirrors.
Afterwards we will start with branching for OpenVox 9 and OpenVox 8 switches to maintenance mode (more details soon).

A big thank you to Nick Burgan and Corporate Gadfly for all the patches and reviews!

## Important changes

### java dependencies

We reworked the java dependency on the deb & rpm packages.
In the past, our packages depended on meta packages or a range of packages (for example JRE 17 or JRE 21).
The used JRE is set as `JAVA_BIN` in `/etc/{default,sysconfig}/{puppetdb,puppetserver}` and defaults to `/usr/bin/java`.
This caused issues on setups where people installed Java 11 or 8 on their system and afterwards openvoxdb/openvox-server.
While our packages pull in a compatible version, `/usr/bin/java` was already an alias to the ancient Java 11 or 8 and too old.

OpenVoxDB & OpenVox-Server are compatible with Java 17 & 21.
Our packages now depend on a specific JRE version.
In OpenVox 9, we will update `JAVA_BIN` and our systemd unit files to point to the explicit JRE binary.

Shout out to Ewoud Kohl van Wijngaarden for the initial idea, lots of brainstorming sessions on IRC and all the reviews!

### rootless support

We made some changes [to the CA handling](https://github.com/OpenVoxProject/openvoxserver-ca/pull/33) to support rootless containers ([see also](https://github.com/OpenVoxProject/container-openvoxserver/issues/121))!

You can see all changes [in the openvox-server repo](https://github.com/OpenVoxProject/openvox-server/compare/8.12.1...main) and in the [openvoxdb repo](https://github.com/OpenVoxProject/openvoxdb/compare/8.12.1...main).
A detailed changelog will be published with the final release.

Thank you to Robert Waffen, Sebastian Rakel, Simon Lauger and Friedrich Raschwitz for debugging [this live on twitch](https://twitch.tv/derkellernerd) and for providing and testing the fix!

## Test the RC packages

You can download the packages here:

* [OpenVox-Server](https://artifacts.voxpupuli.org/openvox-server/8.13.0-0.1SNAPSHOT.2026.04.24T1621/)
* [OpenVoxDB](https://artifacts.voxpupuli.org/openvoxdb/8.13.0-0.1SNAPSHOT.2026.04.24T1629/)
* [OpenVoxDB FIPS](https://artifacts.voxpupuli.org/openvoxdb/8.13.0-0.1SNAPSHOT.2026.04.24T1714/)

(OpenVox-Server FIPS will be added soon)

**Please provide feedback! If you find any bugs or want to contribute, please come to our [#openvox](https://voxpupuli.org/connect/) channel on IRC or slack.**

Are you interested in Fedora 44 packages? Ubuntu Non-LTS releases like 25.10 or 26.10? Talk to us!
