---
layout: post
title: First OpenBolt packages available!
date: 2025-12-17
github_username: smortex
---

We are happy to announce the availability of the first **OpenBolt** packages!

**OpenBolt** is the community-maintained open-source implementation of the **Bolt** orchestration tool.
It is intended to be a drop-in replacement, just like the **OpenVox Agent** is a drop-in replacement for the **Puppet Agent**.

## Linux

DEB and RPM packages should already be on a mirror near you. If you have already [configured the OpenVox repositories](/openvox/install/), installing `openbolt` is as easy as:

```
apt-get update
apt-get install openbolt
```

## MacOS

Running on a Mac? You are covered! Use our [Homebrew tap](https://github.com/OpenVoxProject/homebrew-openvox) to install `openbolt` with `brew`:

```
brew install openvoxproject/openvox/openvox8-openbolt
```

MacOS DMG installer package is available on our [downloads site](https://downloads.voxpupuli.org/mac/openvox8/) as well.

## Windows

Windows packages are not ready yet, as they offer more challenges. Please [reach out](/connect), if you want to help with those!
