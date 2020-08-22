---
layout: post
title: Releasing a new version of a module
date: 2016-01-01
summary: How to perform a complete version release, including modulesync and publication.
---

Run modulesync to ensure the dotfiles are up to date.

Create a 'release pr'. This pull request updates the changelog and bumps the
version number to the target version, removing all release candidate
identifiers, i.e. from `0.10.7-rc0` to `0.10.7`. Here's an example:
[puppet-extlib's 0.10.7 release](https://github.com/voxpupuli/puppet-extlib/pull/43).
In most cases it is sufficient to update metadata.json. We try
to honor [semantic versioning](http://semver.org/) and decided that dropping ruby1.8
support is a major change and requires a major version bump for the module.
(Only the minor version should be bumped if the module is pre version 1.0 and
ruby 1.8 support has been dropped.)

If necessary, run `bundle install` before continuing. If you want you can also only install the needed gems:

```bash
bundle install --path .vendor/ --without system_tests development
```

And in case you installed the gems before:

```bash
bundle install --path .vendor/ --without system_tests development; bundle update; bundle clean
```

If the module contains a Puppet Strings generated documentation, please
ensure the file is update to date. A good indicator for a Puppet Strings
documentation is the existence of a REFERENCE.md file. You can automatically
generate the documentation by running the following rake task:

```bash
bundle exec rake strings:generate:reference
```

We can generate the changelog after updating the metadata.json with a rake task
(in most cases, this requires a
[GitHub access token (docs on how to create one)](https://help.github.com/en/github/authenticating-to-github/creating-a-personal-access-token-for-the-command-line):
the changelog generator expects the token in the environment variable `CHANGELOG_GITHUB_TOKEN`)

```bash
CHANGELOG_GITHUB_TOKEN='mytoken' bundle exec rake changelog
```

The changelog generator checks for certain labels on closed issues and PRs since the last release and groups them together. Backwards incompatible changes require a major release.
If only bug fixes were merged, a patch release is suggested. If both isn't the case, continue with a minor release. Check the generated diff for the CHANGELOG.md. If your chosen
release version doesn't fit to the generated changelog, update metadata.json and run the changelog task again.

Get community feedback on the release pr, label it with skip-changelog, get it merged.

Checkout an updated copy of master

```bash
git checkout master; git fetch origin; git pull origin master
```

Run the rake target `travis_release`. This will:

* create a new tag using the current version
* bump the current version to the next PATCH version and add `-rc0` to the end
* commit the change,
* and push it to origin.

*Please note that in order to execute this rake task you must be in the __Collaborators__ group on GitHub for the module in question.*

*Please also note that the task requires a configured gpg key in your local git settings*

```bash
bundle exec rake travis_release
```

Travis will then kick off a build against the new tag created and deploy that
build to the forge. Caution: The Vox Pupuli repo has to be the configured
default branch in your local clone. Otherwise you will try to release to your
fork.
