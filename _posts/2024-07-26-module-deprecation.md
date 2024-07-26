---
layout: post
title: Vox Pupuli Changelog - Deprecating unused modules
date: 2024-07-26
github_username: bastelfreak
category: changelog
---

At our mailinglist we asked for feedback about [some unused modules](https://groups.io/g/voxpupuli/message/521):

We deprecate the following modules:

* [puppet-dropbear](https://github.com/voxpupuli/puppet-dropbear?tab=readme-ov-file#puppet-dropbear)
* [puppet-etherpad](https://github.com/voxpupuli/puppet-etherpad?tab=readme-ov-file#etherpad-module-for-puppet)
* [puppet-ghost](https://github.com/voxpupuli/puppet-ghost?tab=readme-ov-file#puppet-ghost-)
* [puppet-jenkins_job_builder](https://github.com/voxpupuli/puppet-pxe?tab=readme-ov-file#puppet-powered-pxe-provisioning)
* [puppet-pxe](https://github.com/voxpupuli/)

The modules will be removed from our [modulesync_config](https://github.com/voxpupuli/modulesync_config/pull/919).
We will also mark them as archived on [forge.puppet.com](https://forge.puppet.com/).
And we will archive the GitHub repositories.
If people contact us (see footer on the page for contact information) and are still interested in the module we can always unarchive them.

We won't archive [puppet-spiped](https://github.com/voxpupuli/puppet-spiped?tab=readme-ov-file#puppet-spiped) because some people [still use it](https://github.com/voxpupuli/puppet-spiped/issues/38).
