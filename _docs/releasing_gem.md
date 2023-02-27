---
layout: post
title: Releasing a new version of a Ruby Gem
date: 2023-02-25
summary: How to perform a complete version release
---

The release process is split into two parts. Part one can be done by anybody
with a GitHub account. You do not need to be part of the Vox Pupuli GitHub
organisation.

Part One: Create a 'release pr'
This pull request updates the changelog and bumps the version number to the
target version. The version is set in the gemspec file in the root of the git
repository. Sometimes it's a variable coming from something like
`lib/$gem/version.rb`. An example is [beaker](https://github.com/voxpupuli/beaker/blob/f60ac9413f9c7976a6645ef9e1dd2afbcc6542de/beaker.gemspec#L8),
([version.rb](https://github.com/voxpupuli/beaker/blob/master/lib/beaker/version.rb#L3)).

Now you can install the changelog generator:

```bash
bundle config set --local path '.vendor/'
bundle config set --local with 'release'
bundle install
```

And in case you installed the gems before:

```bash
bundle install; bundle update; bundle clean
```

We can generate the changelog (in most cases, this requires a
[GitHub access token (docs on how to create one)](https://help.github.com/en/github/authenticating-to-github/creating-a-personal-access-token-for-the-command-line):
the changelog generator expects the token in the environment variable `CHANGELOG_GITHUB_TOKEN`).

```bash
CHANGELOG_GITHUB_TOKEN='mytoken' bundle exec rake changelog
```

The changelog generator checks for certain labels on closed issues and PRs since
the last release and groups them together. If the changes were neither
backwards-incompatible nor only bug fixes, make a minor release. Check the
generated diff for the CHANGELOG.md. If your chosen release version doesn't
match the generated changelog, update gemspec and run the changelog task again.

Get community feedback on the release pr, label it with skip-changelog, get it merged.

## Part 2: Actually create the release

Checkout an updated copy of master

```bash
git checkout master; git pull origin master
```

Check with `git tag -l` if the git tags are prefixed with a v or not. This varies
by project (we often adopt gems from other people and don't want to change the
versioning scheme in a project).

Create a new git tag with the new version: `git tag -s $version`

Push the git tag: `git push origin $version`

Then a GitHub action will start to build the gem and publish it to GitHub Packages and RubyGems.org
