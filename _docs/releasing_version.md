---
layout: post
title: Releasing a new version of a module
date: 2016-01-01
summary: How to perform a complete version release, including modulesync and publication.
---

Creating a release is a two step process:

1. Create a Fork and set the remotes accordingly
2. Prepare the release — setup everything so that peer review can happen and when everything is ready…
3. Do the actual release

## Prepare your Fork

Go to the GitHub project on which you want to generate a new release.
Klick on "fork" and create a local fork.

Clone the original upstream repo to your workstation:

```bash
git clone git@github.com:voxpupuli/<project>.git
```

We usually recommend to always also set the remote for your fork:

```bash
git remote add local git@github.com:<name>/<project>.git
```

Ensure that your local fork is in sync with upstream:

```bash
git fetch --all --prune
git switch master
git pull origin master
git push local master
```

## Preparing a release

This should be done on a __*personal*__ fork.

Run modulesync to ensure the dotfiles are up-to-date.

Create a 'release pr'. This pull request updates the changelog and bumps the
version number to the target version, removing all release candidate
identifiers, i.e. from `0.10.7-rc0` to `0.10.7`. Here's an example:
[puppet-extlib's 0.10.7 release](https://github.com/voxpupuli/puppet-extlib/pull/43).

It is sufficient to update metadata.json and then the `release:prepare` rake task.
This will be explained in detail below.
We try to respect [semantic versioning](http://semver.org/).
We decided that dropping support for a puppet version or ruby is a major change and requires a major version bump for the module.
(Only the minor version should be bumped if the module is pre version 1.0 and puppet or ruby support has been dropped.)

If necessary, run `bundle install` before continuing. If you want you can also only install the needed gems:

```bash
bundle config set --local path 'vendor'
bundle config set --local without 'development system_tests'
bundle install
```

And in case you installed the gems before:

```bash
bundle config set --local path 'vendor'
bundle config set --local without 'development system_tests'
bundle install; bundle update; bundle clean
```

We can now generate the changelog after updating the metadata.json with a rake task.

> 🔔 In most cases, this requires a [GitHub fine-grained access token](https://github.com/settings/tokens?type=beta).
> * Resource owner: you
> * Expiration: one year or less
> * Repository access: Public Repositories (read-only)
>
> The changelog generator expects the token in the environment variable `CHANGELOG_GITHUB_TOKEN`

```bash
CHANGELOG_GITHUB_TOKEN='mytoken' bundle exec rake release:prepare
```

The changelog generator checks for certain labels on closed issues and PRs since
the last release and groups them together. If the changes were neither
backwards-incompatible nor only bug fixes, make a minor release. Check the
generated diff for the CHANGELOG.md. If your chosen release version doesn't
match the generated changelog, update metadata.json and run the changelog task again.

Get community feedback on the release pr, label it with `skip-changelog`, get it merged.

If a REFERENCE.md is present and outdated, the `release:prepare` task will
regenerate it.

Now the changes can be committed and pushed.
The rake task will output the commands you need to run.

It will look like this:

```bash
Please review these changes and commit them to a new branch:

  git checkout -b release-v1.2.3
  git commit --gpg-sign -am "Release v1.2.3"

Then open a Pull-Request and wait for it to be reviewed and merged).
```

Afterwards you can push to your fork and create a PR via the Web UI (or use the `gh` CLI tool if you like):

```bash
git push --set-upstream local release-v1.2.3
```

## Doing the release

*Please note that in order to execute this rake task you must be in the __Collaborators__ group on GitHub for the module in question.*

*Please also note that the task requires a configured gpg or ssh key in your local git settings to sign the git tag*

This step must be done by a voxpupuli maintainer!

This has to be done on the __*upstream*__ repo itself.

Checkout an updated copy of master

```bash
git checkout master; git fetch origin; git pull origin master
```

Run the rake target `release`. This will:

* create a new tag using the current version
* bump the current version to the next PATCH version and add `-rc0` to the end
* commit the change,
* and push it to origin.

```bash
bundle exec rake release
```

GitHub Actions (.github/workflows/release.yml in every module) will then kick
off a build against the new tag created and deploy that build to the forge.
*Caution: The Vox Pupuli repo has to be the configured default branch in your
local clone. Otherwise, you will try to release to your fork.*
