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

* Ask one of the Administrators to add you to the `incoming-migrations` team.
* At that point you can transfer your own repository.
* If migrating a module from puppetlabs, re-enable github issues.
* Verify that all webhooks except travis are disabled.
* Update the README.md with a description of the deprecation and a link to the
  new module location.
* Release a copy of your module to the 'puppet' forge account.
* Add the module to our [modulesync
  setup](https://github.com/voxpupuli/modulesync_config/blob/master/managed_modules.yml).
* Add the module to our [plumbing
  repository](https://github.com/voxpupuli/plumbing/blob/master/share/modules)(handles
  travis secrets).
* Ask an admin to add the `collaborators` team to the module's `Collaborators &
  Teams` 'Teams' list with `Write` permissions (e.g.
  [https://github.com/voxpupuli/puppet-gitlab/settings/collaboration](https://github.com/voxpupuli/puppet-gitlab/settings/collaboration))).
* Execute modulesync for this module.
* Create a Jira issue at
  [https://tickets.puppetlabs.com](https://tickets.puppetlabs.com) and ask to
  deprecate the old module (and approve the new one if the old one was approved
  as well).

If you have many modules you wish to migrate, this will be cumbersome.
In this case we will generally create a separate group and give you
administrator access to speed things up.

If you are interested in Vox Pupuli accepting a module *that you do not own*,
the process has a few extra steps before beginning the checklist above. We do
ask that you show that reasonable efforts have been made to engage the owner and
they are unresponsive. If the owner has responded and is not interested in
migrating their module to VP, it will be evaluated on a case by case basis. To
start the process, document your request and efforts in a brief email to the
[mailing list](https://groups.io/g/voxpupuli/). If the module is accepted, VP
will work with you to determine the proper fork/migration steps needed in
addition to the checklist above.

## Publishing a module - setup

Forge publishing is handled by travis and puppet-blacksmith.

To guarantee a frictionless process across all modules, we use
[modulesync](https://github.com/voxpupuli/modulesync). Our modulesync
configuration is available at
[modulesync_config](https://github.com/voxpupuli/modulesync_config).

Most modulesync'ed settings can be overridden through a
[.sync.yml](https://github.com/voxpupuli/puppet-extlib/blob/master/.sync.yml).
You may also need to (re)define your travis testing matrix with respect to
puppet version. This prevents the deploy hook from running once for each version
of puppet defined in your testing.

Travis needs to be aware of the rename, this can be done by pushing a single
commit. Travis needs to be enabled for the new repository, you can do that
[here](https://travis-ci.org/profile/voxpupuli).

The secure line is unique per repository and often the only line in .sync.yml.
To get a secure line:

Ask an admin (or submit a PR) to add your module to the list
[here](https://github.com/voxpupuli/plumbing/blob/master/share/modules). Then an
admin will run the encrypt_travis.sh script and push a new version of
[this](https://github.com/voxpupuli/plumbing/blob/master/share/travis_secrets)
which you can then copy and paste your travis secure line from.

Note that you need to mask your ``secure:`` line in .travis.yml from modulesync.
[Here](https://github.com/voxpupuli/puppet-iis/blob/master/.sync.yml#L35) is an
example of what that looks like.

If the forge puppet password is changed, an admin can run encrypt_travis.sh and
the modules can bring in the new password on their own schedule.

Gem publishing is handled similarly, except there is not a unified user. Each
gem owner is responsible for their own .travis.yml

## Releasing a new version of a module

*Please note that in order to perform a release you must be in the
__Collaborators__ group on Github for the module in question.*

Run modulesync to ensure the dotfiles are up to date.

Create a 'release pr'. This pull request updates the changelog and bumps the
version number to the target version, removing all release candidate
identifiers, i.e. from `0.10.7-rc0` to `0.10.7`. Here's an example:
[puppet-extlib's 0.10.7
release](https://github.com/voxpupuli/puppet-extlib/pull/43). In most cases it
is sufficient to update metadata.json. We try to honor [semantic
versioning](http://semver.org/) and decided that dropping ruby1.8 support is a
major change and requires a major version bump for the module. (Only the minor
version should be bumped if the module is pre version 1.0 and ruby 1.8 support
has been dropped.)

If necessary, run `bundle install` before continuing. If you want you can also
only install the needed gems:

```bash
bundle install --path .vendor/ --without system_tests development
```

And in case you installed the gems before:

```bash
bundle install --path .vendor/ --without system_tests development; bundle update; bundle clean
```

We can generate the changelog after updating the metadata.json with a rake task:

```bash
bundle exec rake changelog
```

Get community feedback on the release pr, label it with skip-changelog, get it
merged.

Checkout an updated copy of master

```bash
git checkout master; git fetch origin; git pull origin master
```

Run the rake target `travis_release`. This will:

* create a new tag using the current version
* bump the current version to the next PATCH version and add `-rc0` to the end
* commit the change,
* and push it to origin.

```bash
bundle exec rake travis_release
```

Travis will then kick off a build against the new tag created and deploy that
build to the forge. Caution: The Vox Pupuli repo has to be the configured
default branch in your local clone. Otherwise you will try to release to your
fork.

## Reviewing a module PR

There are a few things that can be checked if you review a pull request against
one of our modules:

* Does the email address used in the commits match the github email address?
  (This will let github display the contributor's avatar next to the commit)
* Is this a bugfix, modulesync, breaking change, enhancement, docs update? Label
  it with `bug`, `modulesync`, `backwards-incompatible`, `enhancement`, `docs`
* Are updates to the README.md needed but missing? Label it with `needs-docs`
* Has the file documented params or examples in the header? This needs to be
  updated as well
* Are there merge conflicts? Add the `needs-rebase` label
* Does it need additional tests? Add the `needs-tests` label
* Does it have failing tests? Add the `tests-fail` label
* Does it drop support for a specific Operating system or a major Puppet
  version? Add the `backwards-incompatible` label
* Are new parameters introduced? They must have datatypes
* Are facts used? They should only be accessed via `$facts[]` or
  [fact()](https://github.com/puppetlabs/puppetlabs-stdlib#fact) from stdlib,
  but not topscope variables
* In the majority of cases, variables shouldn't be accessed via topscope:
  $::modulename::$param. Instead do: $modulename::$param
* Are datatypes from stdlib used? Ensure that lowest supported stdlib version is
  4.18.0 (This is the first version that supports Puppet 5). Check if a newer
  version introduced the used datatype
* Are hiera yaml files added for data-in-modules? Ensure that the data is
  compatible with [hiera
  5](https://puppet.com/docs/puppet/5.3/hiera_migrate.html#use-cases-for-upgrading-to-hiera-5).
  Static data that is equal across every supported operating system can stay in
  the init.pp, it doesn't need to be moved to a common.yaml
* Are there new params with datatype Hash or Array? If possible, they should
  default to empty Hash/Array instead of undef. You can also enforce the
  datastructure like Array[String[1]]
* Are there new params with datatype Boolean? The default value is a tricky
  decision which needs careful reviewing. Sometimes a True/False is the better
  approach, sometimes undef
* Is this a bugfix? Write the Pull Request Title in a way that users can easily
  identify if they are impacted or not
* Does a new param map to an option in a config file of a service? The Parameter
  should accept the possible values that the service allows. For example 'on'
  and 'off'. Don't accept a boolean that will be converted to 'on' or 'off'
* Is a new template added? The preferred language is
  [epp](https://puppet.com/docs/puppet/latest/lang_template_epp.html), not
  [erb](https://puppet.com/docs/puppet/latest/lang_template_erb.html)
* Is a new class added? It should have unit tests using
  [rpsec-puppet-facts](https://github.com/mcanevet/rspec-puppet-facts#rspec-puppet-facts)
  that at least verify that the new class compiles
* Files should always terminate with a newline if possible, with an exception
  being file or template fragments like those used with concat. This is the
  [POSIX
  standard](http://pubs.opengroup.org/onlinepubs/9699919799/basedefs/V1_chap03.html#tag_03_206),
  and some tools don't handle the lack of a terminating newline properly
* If you can supply multiple values for an attribute it's common practice to
  enforce the datatype as an array of values, even if the default is a single
  item. This cuts down on code and remove some edge cases. An example for string
  is `Array[String[1]]` instead of `Variant[String[1],Array[String[1]]]`.

  Note that previously the recommendation was to have a `Variant` type, but this
  causes problems with values that contain Arrays, e.g. `Variant[Tuple[String,
  Array], Array[Tuple[String, Array]]]` (which would unintentionally flatten the
  array inside the tuple).
* The parameter section should always be aligned at the `=` char
* Is a class considered private? Then it should contain
  [assert_private](https://github.com/puppetlabs/puppetlabs-stdlib#assert_private)
* A module should have as few public interfaces as possible. It should be aimed
  for the init.pp being the only public class. This is not a rule but a general
  guideline. Depending on the module, it is not always possible or feasible to
  configure everything through a single class.
* Is another module added as a dependency? Add it to the `.fixtures.yml` file as
  a git repository (as a `https://` link, not `ssh` or `git://`). Spec tests
  always run against master branches to detect breaking changes as early as
  possible. Acceptance tests use the last release (installed by
  [install_module_dependencies](https://github.com/puppetlabs/beaker-module_install_helper#install_module_dependencies)
  which parses it from the `metadata.json`)
* Only hard dependencies must be added to the metadata.json. Don't add soft
  dependencies! More explanation is [in the official Puppet
  styleguide](https://puppet.com/docs/puppet/5.5/style_guide.html#dependencies)
* Ensure that the version range of any dependency doesn't include an unreleased
  major version (do not allow version 6.X of a dependency if the current version
  is 5.X)
* An increase of an upper version boundary (of a module or Puppet itself) is
  only an enhancement if code adjustments were needed. Don't add the
  `enhancement` label if the only change is within the `metadata.json`. Ensure
  that `.fixtures.yml` doesn't pin a specific version.
* Sometimes you review a PR where somebody else requested changes. If the
  contributor clearly fixed it, you can still approve or merge it and ignore the
  `somebody requested changes` message. If you are not sure that it is really
  fixed, only approve it and do not merge it.

### Approving and Merging

* You can merge your own PR if it was approved by someone else and travis is
  green. Don't merge if either one of those conditions are not true
  * Modulesync PRs are an exception (a PR based on changes that the msync tool
    did, NOT PRs on
    [modulesync_config](https://github.com/voxpupuli/modulesync_config#modulesync-configs)).
    We agreed some time ago that it's ok to merge your own modulesync PR if
    travis is green, without separate approval. This is okay because changes to
    [modulesync_config](https://github.com/voxpupuli/modulesync_config#modulesync-configs)
    were reviewed and tested
* It's okay to approve code regardless if travis is still running or not. The
  code won't be merged if travis fails after the PR got approved

## Project management committee

We defined a [governance
document](https://github.com/voxpupuli/plumbing/blob/master/share/governance.md#vox-pupuli-governance)
some time ago. It defines several different groups and roles. One of them is the
PMC. For 2019 [we
elected](https://voxpupuli.org/blog/2018/12/19/election-results-2019/) 5 people.
