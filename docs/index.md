---
layout: page
title: Documentation
---

This page is far from finished but contains some basic information on getting
started. If you have any questions reach out to us in #voxpupuli on Freenode.

## Who can join?
Anyone can participate in puppet-community. We currently have four levels of
participation, orchestrated by github teams.

* Everyone with a github account can submit pull requests and review code.
* Module contributors have commit/merge access to a subset of the modules in
  puppet-community, usually the modules they maintained before joining
  puppet-community.
* Collaborators have commit/merge access to a subset of the modules in
  puppet-community.
* Administsrators have the authorization to create new repositories and
  publish modules to the forge under the puppet namespace.

## Migrating a module to puppet-community
You will have someone by your side in this process. The general flow is to…

* Ask one of the Administrators to add you to the modules/admin team.
* At that point you can transfer your own repository
* If migrating a module from puppetlabs, re-enable github issues.
* Verify that all webhooks except travis are disabled.
* Release a 999.999.999 version of your modules to the forge, so everyone
  knows to stop using it.
* Release a copy of your module to the 'puppet' forge account.

If you have many modules you wish to migrate, this will be cumbersome.
In this case we will generally create a separate group and give you
administrator access to speed things up.

##  Publishing a module - setup
Forge publishing is handled by travis and puppet-blacksmith.

To guarantee a frictionless process across all modules, we use [modulesync](https://github.com/puppet-community/modulesync).

Most modulesync'ed settings can be overridden through a [.sync.yml](https://github.com/puppet-community/puppet-extlib/blob/master/.sync.yml). You may also need to (re)define your travis testing matrix with respect to puppet version. This prevents the deploy hook from running once for each version of puppet defined in your testing.

Travis needs to be aware of the rename, this can be done by pushing a single commit.

The secure line is unique per repository and often the only line in .sync.yml. To get a secure line:

Ask an admin (or submit a PR) to add your module to the list here. then the admin will run the encrypt_travis.sh script and push a new version of this which you can then copy and paste your travis secure line from.

If the forge puppet password is changed, an admin can run encrypt_travis.sh and the modules can bring in the new password on their own schedule.


Gem publishing is handled similarly, except there is not a unified user. Each gem owner is responsible for their own .travis.yml

## Releasing a new version of a module
*Please note that in order to perform a release you must be in the __Collaborators__ group on Github for the module in question.*
 
Run modulesync to ensure the dotfiles are up to date.

Create a 'release pr'. This pull request updates the changelog, and bumps the version number. Here's an example: [puppet-extlib's 0.10.7 release](https://github.com/puppet-community/puppet-extlib/pull/43)

Get community feedback on the release pr, get it merged.

Checkout an updated copy of master (`git checkout master; git fetch origin; git pull origin master`)

If necessary, run `bundle install` before continuing.

Run the rake target `travis_release`. This will:

* create a new tag using the current version
* bump the current version to the next PATCH version and add `-rc0` to the end
* commit the change,
* and push it to origin.

`bundle exec rake travis_release`

Travis will then kick off a build against the new tag created and deploy that build to the forge.
