---
layout: post
title: Puppet-Corosync reaches 5.0.0
date: 2016-09-16
github_username: roidelapluie
twitter_username: roidelapluie
---

This is a great moment for Vox Pupuli's [puppet-corosync][a] module.
The [5.0.0 major release][b] is [there][b1], with lots of new features and improvements.
Please also note that we are [Puppet approved][b2] on the forge since last month.

The puppet-corosync module was written as a Puppetlabs module until 2014 where
it moved to Vox Pupuli (called at that time Puppet Community). That transfer was
a big success and the module is now very active!

The first thing to know is that this release will be [supported in the long term][c].
We will maintain that 5.0.0 release [as long as the Vox Pupuli organisation
supports Puppet 3][d]. This version requires Puppet 3.8, but is obviously already
supporting future parser and Puppet 4. Puppet 3 users will need to stick to 5.x
releases.

This is a version with lots of incompatible changes -- let's have a look at
[those changes][e]. We closed all the pull requests and a lot of issues in the last
couple of weeks.

We almost emptied the corosync.conf file. You can still override all the
previous configuration parameters, but by default, we will respect corosync
defaults. Until now, the settings we set by default did not evolve for years --
and looked like opinionated. This change improves clusters reliability.

Another nice change is that we now have the same behaviour for the cs\_clones,
independently of the provider. Natively, the pcs provider does not allow you to
set a custom name on the clones. To use clones with the pcs provider, it was
required to have '${primitive}-name' as resource title. This is now fixed. We
use cibadmin after creating the clone to change its name.

Clones are now stopped before removal. That increases the chances that Puppet
succeeds at deleting them. Be careful also with the clone parameters: parameters
that are not explicitly set will be removed from the resources!

That was the some breaking changes. But we also have a long list of new features
and improvements!

You can now have multiple rings in the nodelist -- improving the reliability of
the quorum. That nodelist is now always added to the file, even when you do set
the number of expected votes. External software might also use that list, so
when we have that information, we simply add it to the file.

A big feature request was to support rules in locations constraints. That is now
done, and for both the pcs and crm providers! This has already been tested on
the field by our awesome community -- thanks!

Eventually, you can now clone groups if you need to. We are glad to have that
functionality for the people who needs this. Groups makes writing simple
dependencies a lot easier.

As a final note, I am glad to announce that this release is more tested than
ever. We have lots of new unit and acceptance tests that increase our trust in
this module. If you find a bug or an edge case, open an issue with the Puppet
code. We will make an acceptance test for it so it does not appear again!

Thanks to all our [contributors][f] who helped us to make that great 5.0.0 release!
We encourage everyone to update to that greatest and latest release!

[a]:https://github.com/voxpupuli/puppet-corosync
[b]:https://github.com/voxpupuli/puppet-corosync/blob/master/CHANGELOG.md
[b1]:https://forge.puppet.com/puppet/corosync
[b2]:https://forge.puppet.com/approved
[c]:https://github.com/voxpupuli/puppet-corosync/blob/master/ROADMAP.md
[d]:https://github.com/voxpupuli/plumbing/issues/21
[e]:https://github.com/voxpupuli/puppet-corosync/compare/v4.0.1...v5.0.0
[f]:https://github.com/voxpupuli/puppet-corosync/graphs/contributors
