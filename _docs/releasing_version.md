---
layout: post
title: Releasing a new version of a module
date: 2016-01-01
summary: How to perform a complete version release, including modulesync and publication.
---

Creating a release is a two step process:
1. Prepare the release
2. Do the actual release

## Preparing a release

Before preparing a release, it may help to run modulesync to ensure the
dotfiles are up-to-date. If modulesync has been run recently by someone else,
you may not have to do it. See https://github.com/voxpupuli/modulesync for more
info on using modulesync.

### 1. Create a new branch for a "release pull request"

For example, if you want to release version `1.2.3` of a module:
```bash
git checkout -b "release_123"
```

### 2. Bump the version

Bump the version number in the module's `metadata.json`.

The version bump must remove all release candidate identifiers and move to the
next appropriate release version. For example: `0.10.7-rc0` to `0.10.7`.

Here's a Pull Request to use as a reference:
[puppet-extlib's 0.10.7 release](https://github.com/voxpupuli/puppet-extlib/pull/43).

Please follow [semantic versioning](http://semver.org/) when changing the
version number.

### 3. Update the CHANGELOG

After bumping the version in `metadata.json`, use the following rake task to
automatically update the CHANGELOG.

NOTE: This requires a [GitHub access token (docs on how to create
one)](https://help.github.com/en/github/authenticating-to-github/creating-a-personal-access-token-for-the-command-line).
The changelog generator expects the token in the environment variable
`CHANGELOG_GITHUB_TOKEN`

> If necessary, run `bundle install` before continuing.
> ```bash
> bundle install --path .vendor/ --without system_tests development
> ```
>
> And in case you installed the gems before:
> ```bash
> bundle install --path .vendor/ --without system_tests development; bundle update; bundle clean
> ```

```bash
CHANGELOG_GITHUB_TOKEN='mytoken' bundle exec rake changelog
```

The changelog generator checks for certain labels on closed issues and PRs
since the last release and groups them together. If the changes were neither
backwards-incompatible nor only bug fixes, make a minor release. Check the
generated diff for the CHANGELOG.md. If your chosen release version doesn't
match the generated changelog, update metadata.json and run the changelog task
again.

### 4. Update Puppet Strings docs (if necessary)

If the module contains a Puppet Strings generated documentation, please
ensure the file is up-to-date. A good indicator for a Puppet Strings
documentation is the existence of a `REFERENCE.md` file.

Run the following rake task to update `REFERENCE.md`:

```bash
bundle exec rake strings:generate:reference
```

### 5. Create the Release Pull Request

Push your branch up to the module's repo or to a fork of the repo then create
the Pull Request.

Once created, get community feedback on the PR in Slack or IRC, label it with
`skip-changelog`, and then get it merged after approval.

## Doing the release

After your Pull Request from above gets merged, the next step is to do the
release.

### 1. Checkout an updated copy of master

```bash
git checkout master; git fetch origin; git pull origin master
```

### 2. Run the 'release' rake task

Run the rake target `release`. This will:

* create a new tag using the current version
* bump the current version to the next PATCH version and add `-rc0` to the end
* commit the change,
* and push it to origin.

*Please note that in order to execute this rake task you must be in the __Collaborators__ group on GitHub for the module in question.*

*Please also note that the task requires a configured gpg key in your local git settings*

```bash
bundle exec rake release
```

GitHub Actions (.github/workflows/release.yml in every module) will then kick
off a build against the new tag created and deploy that build to the forge.
Caution: The Vox Pupuli repo has to be the configured default branch in your
local clone. Otherwise, you will try to release to your fork.
