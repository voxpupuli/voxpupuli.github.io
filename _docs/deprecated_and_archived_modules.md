---
layout: post
title: Deprecated and Archived Modules
date: 2019-11-29
summary: Vox Pupuli policy on deprecating and archiving modules
---

## Archived Modules

It is Vox Pupuli's mission to provide a home for modules so that development can continue after the original authors/maintainers have moved on.
In rare circumstances, a module may be archived and placed into a read-only state.  This typically will only occur if the module/project no longer serves a valid
purpose.  For example, a module that interacted with a discontinued 3rd party service.

If you come across an archived Vox Pupuli project that you are still using or think should not have been archived, [let us know][email].
The decision to archive a module isn't necessarily final and can be undone.

### Deprecation process

* The README.md needs a bold message at the beginning
  * It needs to mention that the module is archived
  * If a successor exists, that one should be linked to
* The GitHub repository needs to be archived in the GitHub settings
* On forge.puppet.com the module needs to be archived, with a link to the successor (if available)
* The module needs to be removed from our [modulesync_config][mc] and [plumbing][pl] setup

[email]: https://groups.io/g/voxpupuli/topics
[mc]: https://github.com/voxpupuli/modulesync_config/blob/master/managed_modules.yml
[pl]: https://github.com/voxpupuli/plumbing/blob/master/share/modules
