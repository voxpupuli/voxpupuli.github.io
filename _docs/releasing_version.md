---
layout: post
title: Releasing a new version of a module
date: 2016-01-01
summary: How to perform a complete version release, including modulesync and publication.
last_modified_at: 2025-06-10
---

Creating a release is a three step process:

1. Create a release PR
2. Review it
3. Do the actual release

## Before Preparing a release

Run [modulesync](https://voxpupuli.org/docs/updating-files-managed-with-modulesync/) to ensure the dotfiles are up-to-date.

## Standard Release

### Create Release PR

To automatically create a "release PR", you need to be a member of the `voxpupuli` GitHub organization.
Then you can browse to a module -> Actions -> `Prepare Release`.
This is a GitHub workflow.
It will automatically:

* bump the metadata.json to the next patch level
* Or you provide the desired version number, then metadata.json will be bumped to it
* Afterwards the CHANGELOG.md will be updated
* REFERENCE.md will be updated if required
* A pull request will be created
* GitHub attaches the `skip-changelog` label

### Review the Release PR

This will have generated updates to the CHANGELOG.md, review each PR in the CHANGELOG to make sure they're labeled properly so that the CHANGELOG is correct:

* backwards-incompatible
* enhancement
* bug/bugfix
* docs/documentation
* dependencies

Make sure that the version updated as expected.
Anything labeled backwards-incompatible should require a major version bump.
For voxpupuli this includes _removing Ruby/Puppet/OS versions for EOL_.

If you relabeled anything or the version is wrong, rerun the `Prepare Release` action.
Request feedback from the Vox Pupuli Community via the methods listed in the [Contact page](https://voxpupuli.org/connect/).

All commentary should be reviewed, but specifically looking for concensus around:

* Are there other changes that should get merged first?
* Are there discussions about the tagging of any of the changes in the CHANGELOG.md?
* Have you missed something needed for release?

The person who does the merge of the PR is expected to do the release below.

### Do the Release

* _Please note that in order to execute this rake task you must be in the __Collaborators__ group on GitHub for the module in question._
* _Please also note that the task requires a configured gpg or ssh key in your local git settings to sign the git tag_

This step must be done by a voxpupuli maintainer!

This has to be done on the __*upstream*__ repo itself.

Checkout an updated copy of master

```shell
git checkout master; git fetch origin; git pull origin master
```

Run the rake target `release`. This will:

* create a new tag using the current version
* bump the current version to the next PATCH version and add `-rc0` to the end
* commit the change,
* and push it to origin.

```shell
bundle exec rake release
```

GitHub Actions (.github/workflows/release.yml in every module) will then kick off a build against the new tag created and deploy that build to the forge.
_Caution: The Vox Pupuli repo has to be the configured default branch in your local clone. Otherwise, you will try to release to your fork._

## Manual Steps

If github actions breaks for some reason, and we need a release done, here are the manual steps.

### As an outside collaborator

Go to the GitHub project on which you want to generate a new release.
Klick on "fork" and create a local fork.

Clone the original upstream repo to your workstation:

```shell
git clone git@github.com:voxpupuli/<project>.git
```

We usually recommend to always also set the remote for your fork:

```shell
git remote add local git@github.com:<name>/<project>.git
```

Ensure that your local fork is in sync with upstream:

```shell
git fetch --all --prune
git switch master
git pull origin master
git push local master
```

Create a 'release pr'. This pull request updates the changelog and bumps the
version number to the target version, removing all release candidate
identifiers, i.e. from `0.10.7-rc0` to `0.10.7`. Here's an example:
[puppet-extlib's 0.10.7 release](https://github.com/voxpupuli/puppet-extlib/pull/43).

It is sufficient to update metadata.json and then run the `release:prepare` rake task.
This will be explained in detail below.
We try to respect [semantic versioning](http://semver.org/).
We decided that dropping support for a puppet version or ruby is a major change and requires a major version bump for the module.
(Only the minor version should be bumped if the module is pre version 1.0 and puppet or ruby support has been dropped.)

If necessary, run `bundle install` before continuing. If you want you can also only install the needed gems:

```shell
bundle config set --local path 'vendor'
bundle config set --local without 'development system_tests'
bundle install
```

And in case you installed the gems before:

```shell
bundle config set --local path 'vendor'
bundle config set --local without 'development system_tests'
bundle install; bundle update; bundle clean
```

We can now generate the changelog after updating the metadata.json with a rake task.

> 🔔 In most cases, this requires a [GitHub fine-grained access token](https://github.com/settings/tokens?type=beta).
>
> * Resource owner: you
> * Expiration: one year or less
> * Repository access: Public Repositories (read-only)
>
> The changelog generator expects the token in the environment variable `CHANGELOG_GITHUB_TOKEN`

```shell
CHANGELOG_GITHUB_TOKEN='mytoken' bundle exec rake release:prepare
```

### Reviewing the release PR

The changelog generator checks for certain labels on closed issues and PRs since the last release and groups them together.
If the changes were neither backwards-incompatible nor only bug fixes, make a minor release.
Check the generated diff for the CHANGELOG.md.
If your chosen release version doesn't match the generated changelog, update metadata.json and run the changelog task again.

Get community feedback on the release pr, label it with `skip-changelog`, get it merged.

If a REFERENCE.md is present and outdated, the `release:prepare` task will regenerate it.

Now the changes can be committed and pushed.
The rake task will output the commands you need to run.

It will look like this:

```shell
Please review these changes and commit them to a new branch:

  git checkout -b release-v1.2.3
  git commit --gpg-sign -am "Release v1.2.3"

Then open a Pull-Request and wait for it to be reviewed and merged).
```

Afterwards you can push to your fork and create a PR via the Web UI (or use the `gh` CLI tool if you like):

```shell
git push --set-upstream local release-v1.2.3
```

The person who does the merge is expected to do the release below.

### Doing the release

* _Please note that in order to execute this rake task you must be in the __Collaborators__ group on GitHub for the module in question._
* _Please also note that the task requires a configured gpg or ssh key in your local git settings to sign the git tag_

This step must be done by a voxpupuli maintainer!

This has to be done on the __*upstream*__ repo itself.

Checkout an updated copy of master

```shell
git checkout master; git fetch origin; git pull origin master
```

Run the rake target `release`. This will:

* create a new tag using the current version
* bump the current version to the next PATCH version and add `-rc0` to the end
* commit the change,
* and push it to origin.

```shell
bundle exec rake release
```

GitHub Actions (.github/workflows/release.yml in every module) will then kick off a build against the new tag created and deploy that build to the forge.
_Caution: The Vox Pupuli repo has to be the configured default branch in your local clone. Otherwise, you will try to release to your fork._
