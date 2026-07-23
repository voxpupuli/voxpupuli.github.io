---
layout: post
title: puppet-checkmk dusted off 🧹🦊
date: 2026-06-11
github_username: marcusdots
---

Vox Pupuli's puppet-checkmk [\[1\]](https://github.com/voxpupuli/puppet-check_mk)[[2]](https://forge.puppet.com/modules/puppet/check_mk/readme) had become invisible on the Puppet Forge. [\[3\]](https://forge.puppet.com/modules?q=check_mk) The Forge has a simple filter: No updates for a long time? Hide it!

Since we hadn't put out a release in a while, we got dropped off the Forge. We've fixed that: dusted off the metadata and added modern operating systems (RedHat-10, Debian-13) to the test matrix.

As sysadmins may guess, there were some quirks with EPEL. I am looking at you, Oracle Linux! ;-) [\[4\]](https://github.com/voxpupuli/puppet-nginx/blob/master/spec/spec_helper_acceptance.rb#L5-L13)

[1] [https://github.com/voxpupuli/puppet-check_mk](https://github.com/voxpupuli/puppet-check_mk)  
[2] [https://forge.puppet.com/modules/puppet/check_mk/readme](https://forge.puppet.com/modules/puppet/check_mk/readme)  
[3] [https://forge.puppet.com/modules?q=check_mk](https://forge.puppet.com/modules?q=check_mk)  
[4] [https://github.com/voxpupuli/puppet-nginx/blob/master/spec/spec_helper_acceptance.rb#L5-L13](https://github.com/voxpupuli/puppet-nginx/blob/master/spec/spec_helper_acceptance.rb#L5-L13)
