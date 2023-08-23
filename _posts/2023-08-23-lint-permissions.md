---
layout: post
title: Vox Pupuli Changelog - Cleaning up puppet-lint plugin permissions
date: 2023-08-23
github_username: bastelfreak
twitter_username: bastelsblog
category: changelog
---

We have cleaned up the GitHub permissions for all the puppet-lint plugins.
Previously, our GitHub group `collaborators` had write access. This group is
meant to be used for puppet modules only. We created a new group called
`tools/lint`. We already added a few users that interacted with puppet-lint
plugins in the past.

In addition to all our puppet-lint plugins, the group also has access to:

* [github.com/voxpupuli/puppet-lint_modulesync_configs](https://github.com/voxpupuli/puppet-lint_modulesync_configs#puppet-lint-modulesync-configs)
* [github.com/voxpupuli/voxpupuli-puppet-lint-plugins](https://github.com/voxpupuli/voxpupuli-puppet-lint-plugins#voxpupuli-puppet-lint-plugins-gem)

Please let us know if you want to have access as well.
