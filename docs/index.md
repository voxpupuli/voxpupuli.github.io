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
The general flow is to…

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

To enable a module to be pushed, copy the 'deploy' block from puppetcommunity-extlib travis.yml.

You will also need to manually define your travis testing matrix with respect to puppet version as in the extlib module. This prevents the deploy hook from running once for each version of puppet defined in your testing.

Travis needs to be aware of the rename, this can be done by pushing a single commit'

The secure line is unique per repository. To get a secure line:

Ask an admin (or submit a PR) to add your module to the list here. then the admin will run the encrypt_travis.sh script and push a new version of this which you can then copy and paste your travis secure line from.

If the forge puppet password is changed, an admin can run encrypt_travis.sh and the modules can bring in the new password on their own schedule.


Gem publishing is handled similarly, except there is not a unified user. Each gem owner is responsible for their own .travis.yml

## Releasing a module
If modulesync is enabled for the module, run it to ensure dotifles are up to date.

Create a 'release pr'. This is a PR that modifies the changelog, bumps the version name, etc. Ask for reviews on it. This is where the community can agree or disagree with the version number you have chosen, and otherwise vote on whether to release or not. Example: https://github.com/puppet-community/puppet-archive/pull/98

Get community feedback on the release pr, get it merged.

Checkout master

Create a signed tag at the version: git tag -s 1.0.2

For the text of the signed tag use: "Release 1.0.2"

Push the signed tag to github: git push --tags origin master

Travis will then kick off a build that will put a new version of the module on the forge
