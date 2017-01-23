---
layout: post
title: Migrating a Module to Puppet 4
date: 2017-01-11
github_username: bastelfreak
twitter_username: BastelsBlog
---


We announced the deprecation of Puppet 3 in our modules
[already](https://voxpupuli.org/blog/2016/12/22/putting-down-puppet-3/). There
are a few steps needed to be taken before a Puppet-4-only release can be done:

* Check the current `metadata.json` for the required Puppet version and bump it if needed
  * We already have a few modules that only support Puppet 4, in this case you can ignore this guide
  * Also check if the dependencies in the `metadata.json` all have Puppet 4 support, they may have to be bumped too
  * The minimum required stdlib version has to be 4.6.0
  * The required Puppet version should be 3.8.7 or newer
* Ensure that the module is modulesynced with version 0.16.10. You can detect the version in the [.msync.yml](https://github.com/voxpupuli/puppet-zabbix/blob/master/.msync.yml)
* Perform a release of the module within the current Major version that announces the deprecation of Puppet 3. e.g. Current version is 2.1.3, release 2.2.0 with the deprecation notice
* Create a new branch which is called `puppet3`
  * The required Puppet version for this branch in the `metadata.json` should be the latest available, which is currently 3.8.7
  * Keep in mind that stdlib [4.13.0](https://forge.puppet.com/puppetlabs/stdlib/changelog#supported-release-4130) deprecates a lot of functions, you maybe want to require an older version in the `puppet3` branch
* Check the [.sync.yml](https://github.com/voxpupuli/puppet-tea/blob/e49d6d1ce8ba71c2123edf9fae45cde19e603ec3/.sync.yml#L3-L17), sometimes the `.travis.yml` file is unmanaged or modified because the module is already Puppet 4 only. Take a look for an `include` block in the `.travis.yml` section and remove it
* Do a modulesync with at least version 0.17.0 ([how to do it](https://github.com/voxpupuli/modulesync_config#how-to-use-it))
* Check if the `.sync.yml` provides any [extra travis jobs](https://github.com/voxpupuli/puppet-jira/blob/master/.sync.yml#L4), they should use the [latest ruby version](https://github.com/voxpupuli/puppet-jira/blob/master/.sync.yml#L5) (2.4.0 right now) as the other jobs and run on the [trusty platform](https://github.com/voxpupuli/puppet-jira/blob/master/.sync.yml#L10)
* The minimum required Puppet Version should not be 4.0.0 but [4.6.1](https://github.com/voxpupuli/community-triage/blob/master/modules/notes/2017-01-05.md#discussion)
* You may now merge any existing Pull Requests to the master branch that are not backwards compatible with Puppet 3
* Do a major version bump + a release soon after the first Puppet 4 functionality is added
