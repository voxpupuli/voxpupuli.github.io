---
layout: page
title: Documentation
---

This page is far from finished but contains some basic information on getting
started. If you have any questions reach out to us in #voxpupuli on Freenode.

* TOC
{:toc}

## Who can join?
Anyone can participate in voxpupuli. We currently have four levels of
participation, orchestrated by github teams.

* Everyone with a github account can submit pull requests and review code.
* Module contributors have commit/merge access to a subset of the modules in
  voxpupuli, usually the modules they maintained before joining
  voxpupuli.
* Collaborators have commit/merge access to a subset of the modules in
  voxpupuli.
* Administrators have the authorization to create new repositories and
  publish modules to the forge under the puppet namespace.

## Where you can find us
We have a number of communication channels:

* #voxpupuli on [Freenode](http://freenode.net), aka IRC
* [#voxpupuli](http://puppetcommunity.slack.com/messages/voxpupuli/) on
  [Puppet Community](http://slack.puppet.com), aka Slack
* [Mailing List](https://groups.io/g/voxpupuli/)

IRC still counts as the preferred point of contact for many of us but we tend
to be available and reachable through both. If you need to reach out to a
maintainer because of behaviour in our community that you find questionable
please read through our Code of Conduct, you'll find a contact address there.

Longer form cross-project discussion tends to take place on the mailing list,
as well as release announcements.

## Migrating a module to voxpupuli
You will have someone by your side in this process. The general flow is to…

* Ask one of the Administrators to add you to the modules/admin team.
* At that point you can transfer your own repository
* If migrating a module from puppetlabs, re-enable github issues.
* Verify that all webhooks except travis are disabled.
* Update the README.md with a description of the deprecation and a link to the new module location.
* Release a copy of your module to the 'puppet' forge account.
* Add the module to our [modulesync setup](https://github.com/voxpupuli/modulesync_config/blob/master/managed_modules.yml)
* Add the module to our [plumbing repository](https://github.com/voxpupuli/plumbing/blob/master/share/modules)(handles travis secrets)
* Ask one of the admins to add the module to the collaborators Team on github.
* Execute modulesync for this module
* Create a Jira issue at https://tickets.puppetlabs.com and ask to deprecate the old module (and approve the new one if the old one was approved as well)

If you have many modules you wish to migrate, this will be cumbersome.
In this case we will generally create a separate group and give you
administrator access to speed things up.

##  Publishing a module - setup
Forge publishing is handled by travis and puppet-blacksmith.

To guarantee a frictionless process across all modules, we use [modulesync](https://github.com/voxpupuli/modulesync). Our modulesync configuration is available at [modulesync_config](https://github.com/voxpupuli/modulesync_config).

Most modulesync'ed settings can be overridden through a [.sync.yml](https://github.com/voxpupuli/puppet-extlib/blob/master/.sync.yml). You may also need to (re)define your travis testing matrix with respect to puppet version. This prevents the deploy hook from running once for each version of puppet defined in your testing.

Travis needs to be aware of the rename, this can be done by pushing a single commit. Travis needs to be enabled for the new repository, you can do that [here](https://travis-ci.org/profile/voxpupuli).

The secure line is unique per repository and often the only line in .sync.yml. To get a secure line:

Ask an admin (or submit a PR) to add your module to the list [here](https://github.com/voxpupuli/plumbing/blob/master/share/modules). Then an admin will run the encrypt_travis.sh script and push a new version of [this](https://github.com/voxpupuli/plumbing/blob/master/share/travis_secrets) which you can then copy and paste your travis secure line from.

Note that you need to mask your ``secure:`` line in .travis.yml from modulesync. [Here](https://github.com/voxpupuli/puppet-iis/blob/master/.sync.yml#L35) is an example of what that looks like.

If the forge puppet password is changed, an admin can run encrypt_travis.sh and the modules can bring in the new password on their own schedule.


Gem publishing is handled similarly, except there is not a unified user. Each gem owner is responsible for their own .travis.yml

## Releasing a new version of a module
*Please note that in order to perform a release you must be in the __Collaborators__ group on Github for the module in question.*

Run modulesync to ensure the dotfiles are up to date.

Create a 'release pr'. This pull request updates the changelog and bumps the version number to the target version, removing all release candidate identifiers, i.e. from `0.10.7-rc0` to `0.10.7`. Here's an example: [puppet-extlib's 0.10.7 release](https://github.com/voxpupuli/puppet-extlib/pull/43). In most cases it is sufficient to update CHANGELOG.md and metadata.json. We try to honor [semantic versioning](http://semver.org/) and decided that dropping ruby1.8 support is a major change and requires a major version bump for the module. (Only the minor version should be bumped if the module is pre version 1.0 and ruby 1.8 support has been dropped.)

Get community feedback on the release pr, get it merged.

Checkout an updated copy of master (`git checkout master; git fetch origin; git pull origin master`)

If necessary, run `bundle install` before continuing. If you want you can also only install the needed gems:

```bash
bundle install --path .vendor/ --without system_tests development
```

And in case you installed the gems before:

```bash
bundle install --path .vendor/ --without system_tests development; bundle update; bundle clean
```

Run the rake target `travis_release`. This will:

* create a new tag using the current version
* bump the current version to the next PATCH version and add `-rc0` to the end
* commit the change,
* and push it to origin.

`bundle exec rake travis_release`

Travis will then kick off a build against the new tag created and deploy that build to the forge. Caution: The Vox Pupuli repo has to be the configured default branch in your local clone. Otherwise you will try to release to your fork.

## Reviewing a module

There are a few things that can be checked if you review a pull request against one of our modules:

* Correct email address used in the commits (if so, travis displays the avatar next to the commit)?
* Is this a bugfix, modulesync, breaking change, enhancement, docs update? Label it with `bug`, `modulesync`, `backwards-incompatible`, `enhancement`, `docs`
* Are updates to the README.md needed but missing? Label it with `needs-docs`
* Are there merge conflicts? Add the `needs-rebase` label
* Does it need additional tests? Add the `needs-tests` label
* Are new parameters introduced? They should have datatypes
* Are facts used? They should only be accessed via `$facts[]` or [fact()](https://github.com/puppetlabs/puppetlabs-stdlib#fact) from stdlib, but not topscope variables
* Are datatypes from stdlib used? Ensure that lowest supported stdlib version is 4.13.1. Check if a newer version introduced the used datatype
* Are hiera yaml files added for /docs? Ensure that the lowest supported Puppet version is 4.10.9
