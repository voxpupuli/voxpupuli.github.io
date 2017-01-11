---
layout: post
title: Migrating a Module to Puppet 4
date: 2017-01-09
github_username: bastelfreak
twitter_username: BastelsBlog
---


We announced the deprecation of Puppet 3 in our modules
[already](https://voxpupuli.org/blog/2016/12/22/putting-down-puppet-3/). There
are a few steps needed to be taken before a Puppet-4-only release can be done:

* Check the current metadata.json for the required Puppet version and bump it if needed
  * We already have a few modules that only support Puppet 4, in this case you can ignore this guide
  * The minimal required Puppet Version should not be 4.0.0 but [4.6.1](https://github.com/voxpupuli/community-triage/blob/master/modules/notes/2017-01-05.md#discussion)
  * Also check if the dependencies in the `metadata,json` all have Puppet 4 support, probably they have to be bumped too
* Do a last release with Puppet 3 support which announces the next major release without Puppet 3
* Create a new branch which is called `puppet3`
* Check the [.sync.yml](https://github.com/voxpupuli/puppet-tea/blob/e49d6d1ce8ba71c2123edf9fae45cde19e603ec3/.sync.yml#L3-L17), sometimes the `.travis.yml` file is unmanaged or modified because the module is already Puppet 4 only. Take a look for an `include` block in the `.travis.yml` section and remove it
* Do a modulesync with at least version XY ([how to do it](https://github.com/voxpupuli/modulesync_config#how-to-use-it))
* Merge any incoming pull requests that add Puppet 4 functionality now, but not earlier
* Do a major version bump + a release soon after the first Puppet 4 functionalty got added
