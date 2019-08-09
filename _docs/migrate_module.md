---
layout: post
title: Migrating a module to Vox Pupuli
date: 2016-07-01
summary: Complete directions for migrating a module to Vox Pupuli, including the process for forking and assuming ownership of an abandoned module.
---

You will have someone by your side in this process. The general flow is to…

* Ask one of the Administrators to add you to the `incoming-migrations` team.
* At that point you can transfer your own repository.
* If migrating a module from puppetlabs, re-enable github issues.
* Verify that all webhooks except travis are disabled.
* Update the README.md with a description of the deprecation and a link to the new module location.
* Release a copy of your module to the 'puppet' forge account.
* Add the module to our [modulesync setup](managed_modules).
* Add the module to our [plumbing repository](plumbing)(handles travis secrets).
* Ask an admin to add the `collaborators` team to the module's `Collaborators & Teams` 'Teams' list with `Write` permissions (e.g. [https://github.com/voxpupuli/puppet-gitlab/settings/collaboration](https://github.com/voxpupuli/puppet-gitlab/settings/collaboration))).
* Execute modulesync for this module.
* Create a Jira issue at [https://tickets.puppetlabs.com](https://tickets.puppetlabs.com) and ask to deprecate the old module (and approve the new one if the old one was approved as well).

If you have many modules you wish to migrate, this will be cumbersome.
In this case we will generally create a separate group and give you
administrator access to speed things up.

If you are interested in Vox Pupuli accepting a module *that you do not own*, the process has a few extra steps before beginning the checklist above.
We do ask that you show that reasonable efforts have been made to engage the owner and they are unresponsive.
If the owner has responded and is not interested in migrating their module to VP, it will be evaluated on a case by case basis.
To start the process, document your request and efforts in a brief email to the [mailing list](https://groups.io/g/voxpupuli/).
If the module is accepted, VP will work with you to determine the proper fork/migration steps needed in addition to the checklist above.
