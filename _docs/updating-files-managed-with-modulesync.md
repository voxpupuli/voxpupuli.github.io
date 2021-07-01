---
layout: post
title: Updating Files Managed With ModuleSync
date: 2021-06-30
summary: How to proceed to update files managed by ModuleSync in Vox Pupuli templates.
---

## What is ModuleSync?

[ModuleSync] is used at Vox Pupuli to syncronise common files across the various modules we manage.  It helps us to update all of the modules in a consistent way.

## Should I update files managed by ModuleSync?

Generaly speaking, there is a better way around.

If your modifications are specific to a particular use-case / a single module, it is generaly better to find another way.  If you are unsure about where to look, [feel free to reach to us](/docs/about_vox_pupuli/#where-you-can-find-us).  But if your changes makse sense to *all* modules (or maybe just *most* modules), read on to submit your changes to the right place.

## How do I update a file managed by ModuleSync?

The configuration shared between our modules is setup in the [modulesync_config repository].

At the root of this repository, is a directory named `moduleroot` which contains all the templates used to generate the files ModuleSync manages.  Create a PR against the [modulesync_config repository] to make changes to files managed by ModuleSync.

If your changes do not apply to *all* modules managed by Vox Pupuli, add a toggle key with a sane default in the `config_defaults.yml` file at the root of the repository and use `@config['your_custom_key']` to tune the templates expansion.  Then, in the modules that should use this feature, update the setting accordingly in the `.sync.yml` file at the root of the module.

For a complete example, see this commit to the [modulesync_config repository] which manage a few files and introduce 3 tunables:

* https://github.com/voxpupuli/modulesync_config/commit/758366479d9d65a7cf14b2f5f757eff154bfbd8b

After this commit got merged, the tunables where updated in the appropriate repository, for example:

* https://github.com/voxpupuli/puppet-jenkins/commit/e25d6bf3fe047659f3375fe069c151cb5171a7ce#diff-b1bbc4d50c1c098ca18224cbc9519ad646dcc5e3dd912edf55610ab5bba3566e
* https://github.com/voxpupuli/puppet-zabbix/commit/2d2fd20b3ceb036cd8a44747bc9c537e27022b82#diff-b1bbc4d50c1c098ca18224cbc9519ad646dcc5e3dd912edf55610ab5bba3566e

[ModuleSync]: https://github.com/voxpupuli/modulesync
[modulesync_config repository]: https://github.com/voxpupuli/modulesync_config
