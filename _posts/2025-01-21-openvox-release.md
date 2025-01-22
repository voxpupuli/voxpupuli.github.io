---
layout: post
title: First release, hot off the presses!
date: 2025-01-21
github_username: binford2k
---

It’s been quite a journey, y’all.
But we’re excited to announce the first release of [OpenVox](https://voxpupuli.org/openvox/), the community-maintained open source implementation of Puppet.
OpenVox 8.11 is functionally equivalent to Puppet and should be a drop-in replacement.
Be aware, of course, that even though you can type the same commands, use all the same modules and extensions, and configure the same settings, OpenVox is not yet tested to the same standard that Puppet is.

Migrating is fairly simple, just replace the packages following instructions on the [handy dandy new install page](/openvox/install/).
You’ll notice that they’re still using the `apt|yum.overlookinfratech.com` repositories.
As we get our infrastructure built out, these will probably be moved to the voxpupuli.org namespace.
Please don’t use these packages on critical production infrastructures yet, unless you’re comfortable with troubleshooting and reporting back on the silly errors we’ve made while rebranding and rebuilding.


> *If you’d like professional assistance in the migration, check out the [support page](/openvox/support/) for companies who provide migration services.*

We consider OpenVox a soft-fork because we intend to maintain downstream compatibility for as long as we are able.
As such, Vox Pupuli is working with Perforce to create a Puppet™️ Standards Steering Committee to set the direction of features and language evolutions.

The OpenVox project goals are pretty straightforward and aim to alleviate pain points observed by the community over the last few years:

1. Modernizing the OpenVox codebase and ecosystem, including supporting current operating systems.
2. Recentering and focusing on community requirements; user needs will drive development.
3. Democratizing platform support by allowing community members to contribute what they need instead of waiting for business requirements to align.
4. Maintaining an active and responsive open source community like the rest of Vox Pupuli's namespace.

Find out more or get involved at [our GitHub namespace](https://github.com/openvoxproject).
