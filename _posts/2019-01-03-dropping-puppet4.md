---
layout: post
title: Dropping Puppet 4 support
date: 2019-01-03
github_username: bastelfreak
twitter_username: BastelsBlog
---

Puppet 4 reached End of Life on 2018-12-31. There isn't an official support
matrix for the FOSS components. For Puppet enterprise this can be found
[here](https://puppet.com/misc/puppet-enterprise-lifecycle). PE 2018.1 is the
oldest currently supported version. It currently ships
[Puppet 5.5.8](https://puppet.com/docs/pe/2018.1/component_versions_in_recent_pe_releases.html#puppet-enterprise-agent-and-server-components).

Vox Pupuli will remove Puppet 4.x from the metadata.json and from the Travis CI
testmatrix after 2019-01-01. Our lowest supported Puppet version will be 5.5.8.
This deprecation will be followed by a major version bump of each Puppet
module. We won't do releases just for this change, but rather follow our normal
release schedule.

For the Puppet 3 deprecation we created a branch called `puppet3` with the
legacy codebase. This created quite some hassle and confusion, so we won't do
this for Puppet 4.
