---
layout: post
title: Migrating a module to Vox Pupuli
date: 2016-07-01
summary: Complete directions for migrating a module to Vox Pupuli, including the process for forking and assuming ownership of an abandoned module.
---

You will have someone by your side in this process. The general flow is to…

* Ensure you have been added as a member of the voxpupuli org on github.
* Create an issue with the [checklist](#checklist) below.
* Prepare your repo for transfer
  * Ensure github issues are enabled.
  * If this module was created with PDK delete .sync.yaml.
  * Ensure that the module has a correct `LICENSE` file in the docroot that matches the mentioned license in the `metadata.json`.
  * If the repo is a fork, to ensure pull requests go to the correct repo, [detach it from the fork network](https://docs.github.com/pull-requests/collaborating-with-pull-requests/working-with-forks/detaching-a-fork).
* At this point you can [transfer your own repository](https://docs.github.com/repositories/creating-and-managing-repositories/transferring-a-repository).
* Ask an admin to
  * Verify that all webhooks are disabled.
  * Enable `Automatically delete head branches` in the repository settings.
  * Add the `collaborators` team to the module's `Collaborators & Teams` 'Teams' list with `Write` permissions (e.g. [https://github.com/voxpupuli/puppet-gitlab/settings/collaboration](https://github.com/voxpupuli/puppet-gitlab/settings/collaboration) (that link works only for admins).
  * Update the [access permissions](https://github.com/organizations/voxpupuli/settings/secrets/actions) (that link works only for admins) for forge.puppet.com secrets so releases can be published.
* Add the module to our [modulesync setup][managed_modules].
* Execute [modulesync][msync] for this module.
* Our modulesync will delete a `CONTRIBUTING.md` in the root directory and use the global organization version in voxpupuli/.github.  Please enhance [the global version][contrib] if the version in the docroot contains useful parts.
* [Release][release] the first version under Vox Pupuli.
* Create a GitHub issue for the [FORGE][forge] project and ask to deprecate the old module (and [approve][approve] the new one if the old one was approved as well).
* Write a very short blog post about the migration([example][example]). Write to our [mailinglist](mailto:voxpupuli@groups.io) about the migration/new blogpost.

## Checklist

```markdown
Reference: https://voxpupuli.org/docs/migrate_module/

* [ ] Remove PDK `.sync.yaml` if it exists.
* [ ] Ensure correct `LICENSE`.
* [x] Enable GitHub Issues.
* [ ] [Detach from fork network](https://docs.github.com/pull-requests/collaborating-with-pull-requests/working-with-forks/detaching-a-fork).
* [ ] Vox Pupuli Admin: Verify all webhooks are disabled.
* [ ] Vox Pupuli Admin: Enable `Automatically delete head branches` in repository settings.
* [ ] Vox Pupuli Admin: Add the `collaborators` team to the Team list with `Write` permissions.
* [ ] Vox Pupuli Admin: Update access permissions to allow forge.puppet.com secret access for releases.
* [ ] Add to voxpupuli/modulesync_config.
* [ ] Execute voxpupuli/modulesync_config for the module.
* [ ] Release a new version under Vox Pupuli.
* [ ] Create a forge issue requesting deprecation of the old module.
* [ ] Write a blog post about the migration.
* [ ] Send notification to the mailing list about the new module.
```

If you have many modules you wish to migrate, this will be cumbersome.
In this case we will generally create a separate group and give you
administrator access to speed things up.

If you are interested in Vox Pupuli accepting a module *that you do not own*, the process has a few extra steps before beginning the checklist above.
We do ask that you show that reasonable efforts have been made to engage the owner and they are unresponsive.
If the owner has responded and is not interested in migrating their module to VP, it will be evaluated on a case by case basis.
To start the process, document your request and efforts in a brief email to the [mailing list](https://groups.io/g/voxpupuli/).
If the module is accepted, VP will work with you to determine the proper fork/migration steps needed in addition to the checklist above.

[managed_modules]: https://github.com/voxpupuli/modulesync_config/blob/master/managed_modules.yml
[msync]: https://github.com/voxpupuli/modulesync_config#modulesync-configs
[release]: https://voxpupuli.org/docs/releasing_version/
[contrib]: https://github.com/voxpupuli/.github/blob/master/CONTRIBUTING.md
[forge]: https://github.com/puppetlabs/forge_issues/issues/new/choose
[approve]: https://github.com/puppetlabs/puppet-approved-modules/issues/new?assignees=&labels=&template=puppet-approved-modules.md&title=
[example]: https://github.com/voxpupuli/voxpupuli.github.io/blob/master/_posts/2023-12-05-nsswitch-migration.md
