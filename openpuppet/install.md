---
layout: page
title: Installing OpenPuppet
subsection: openpuppet
---

OpenPuppet package downloads are currently sponsored by [Overlook InfraTech](https://overlookinfratech.com).
Following Perforce's suggestions, these are straight rebuilds of the original
packages with no branding or name changes. Be aware that this will change
as soon as the OpenPuppet pipelines are running.

🚨 Before you enable and install the packages, be forewarned that these are
preliminary kick-the-tires packages only. We do not yet have a fully robust test
pipeline, although with the community interest that will be forthcoming.

## Installation

First enable the repository, based on your Linux distribution. Choose the
appropriate repo package from either of these locations and install it.

* Debian family:
  * [https://apt.overlookinfratech.com](https://apt.overlookinfratech.com)
* RedHat family:
  * [https://yum.overlookinfratech.com](https://yum.overlookinfratech.com)

Then install the packages you want.

* Debian
  * `apt install puppet-agent`
  * `apt install puppetserver`
  * `apt install puppetdb`
* RedHat
  * `yum install puppet-agent`
  * `yum install puppetserver`
  * `yum install puppetdb`

### Sponsorship

Many thanks to Lance and the [OSU Open Source Lab](https://osuosl.org). They do
so much for the open source world and deserve far far more recognition for it.
