---
layout: post
title: Setting up a module for publication
date: 2016-01-01
summary: Setting up your module for automatic Forge publication.
---

Forge publishing is handled by travis and puppet-blacksmith.

To guarantee a frictionless process across all modules, we use [modulesync][ms]. Our modulesync configuration is available at [modulesync_config][ms_docs].

Most modulesync'ed settings can be overridden through a [.sync.yml](https://github.com/voxpupuli/puppet-extlib/blob/master/.sync.yml). You may also need to (re)define your travis testing matrix with respect to puppet version. This prevents the deploy hook from running once for each version of puppet defined in your testing.

Travis needs to be aware of the rename, this can be done by pushing a single commit. Travis needs to be enabled for the new repository, you can do that [here](https://travis-ci.org/profile/voxpupuli).

The secure line is unique per repository and often the only line in .sync.yml. To get a secure line:

Ask an admin (or submit a PR) to add your module to the list [here](https://github.com/voxpupuli/plumbing/blob/master/share/modules). Then an admin will run the encrypt_travis.sh script and push a new version of [this](https://github.com/voxpupuli/plumbing/blob/master/share/travis_secrets) which you can then copy and paste your travis secure line from.

Note that you need to mask your ``secure:`` line in .travis.yml from modulesync. [Here](https://github.com/voxpupuli/puppet-iis/blob/f570fa84b761b0d0e0e1238abb355db47040651f/.sync.yml#L1-L3) is an example of what that looks like.

If the forge puppet password is changed, an admin can run encrypt_travis.sh and the modules can bring in the new password on their own schedule.

Gem publishing is handled similarly, except there is not a unified user. Each gem owner is responsible for their own .travis.yml

[ms]: https://github.com/voxpupuli/modulesync#modulesync
[ms_docs]: https://github.com/voxpupuli/modulesync_config#modulesync-configs
