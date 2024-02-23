---
layout: post
title: Setting up a module for publication
date: 2016-01-01
summary: Setting up your module for automatic Forge publication.
---

Forge publishing is handled by GitHub Actions that run our [voxpupuli-release][vr] gem (which uses [puppet-blacksmith][bs] under the hood).

To guarantee a frictionless process across all modules, we use [modulesync][ms]. Our modulesync configuration is available at [modulesync_config][ms_docs].

Most modulesync'ed settings can be overridden through a [.sync.yml](https://github.com/voxpupuli/puppet-extlib/blob/master/.sync.yml).

Ask an admin to allow the repository to read the forge password secret from the GitHub Org.

Gem publishing is handled similarly, except there is no modulesync_config (again with one exception, our [puppet-lint plugins][pl]).

[ms]: https://github.com/voxpupuli/modulesync#modulesync
[ms_docs]: https://github.com/voxpupuli/modulesync_config#modulesync-configs
[bs]: https://github.com/voxpupuli/puppet-blacksmith?tab=readme-ov-file#puppet-blacksmith
[vr]: https://github.com/voxpupuli/voxpupuli-release?tab=readme-ov-file#vox-pupuli-release-gem
[pl]: https://github.com/voxpupuli/puppet-lint_modulesync_configs?tab=readme-ov-file#puppet-lint-modulesync-configs
