---
layout: post
title: Deprecated and Archived Modules
date: 2019-11-29
summary: Vox Pupuli policy on deprecating and archiving modules
last_updater: bastelfreak
---

## Archived Modules

It is Vox Pupuli's mission to provide a home for modules so that development can continue after the original authors/maintainers have moved on.
In rare circumstances, a module may be archived and placed into a read-only state.  This typically will only occur if the module/project no longer serves a valid
purpose.  For example, a module that interacted with a discontinued 3rd party service.

If you come across an archived Vox Pupuli project that you are still using or think should not have been archived, [let us know][email].
The decision to archive a module isn't necessarily final and can be undone.

### Deprecation process

* An issue needs to be raised on the module to discuss whether it should be archived or not. The decision will be made by lazy consensus (as described in our governance guidelines)
* The README.md needs a bold message at the beginning
  * It must mention that the module is archived
  * If a successor exists, that one should be linked to
  * The deprecation issue in that project must be linked
* The GitHub repository needs to be archived in the GitHub settings
* On forge.puppet.com the module needs to be archived, with a link to the successor (if available)
* The module needs to be removed from our [modulesync_config][mc] and [plumbing][pl] setup
* The Vox Pupuli admins can manage the [org secrets][secrets]. The permission for the archived module needs to be revoked.

### Currently archived modules

You can see all archived modules on GitHub: [github.com/orgs/voxpupuli/repositories](https://github.com/orgs/voxpupuli/repositories?q=&type=archived&language=&sort=)

[email]: https://groups.io/g/voxpupuli/topics
[mc]: https://github.com/voxpupuli/modulesync_config/blob/master/managed_modules.yml
[pl]: https://github.com/voxpupuli/plumbing/blob/master/share/modules
[secrets]: https://github.com/organizations/voxpupuli/settings/secrets/actions
