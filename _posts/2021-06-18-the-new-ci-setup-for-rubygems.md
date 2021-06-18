---
layout: post
title: The new CI setup for RubyGems
date: 2021-06-18
github_username: bastelfreak
twitter_username: BastelsBlog
---

Some time ago we migrated all Puppet module CI jobs from
[Travis-CI](https://travis-ci.org/) to GitHub Actions. We're now in the process
to do the same for all of our
[Rubygems](https://rubygems.org/profiles/voxpupuli). We had some internal
discussions and ended up with the following template for our tests:

```yaml
---
name: Test

on:
  - pull_request
  - push

jobs:
  test:
    runs-on: ubuntu-latest
    strategy:
      fail-fast: false
      matrix:
        ruby:
          - '2.5'
          - '2.6'
          - '2.7'
          - '3.0'
    steps:
      - uses: actions/checkout@v2
      - name: Install Ruby ${{ matrix.ruby }}
        uses: ruby/setup-ruby@v1
        with:
          ruby-version: ${{ matrix.ruby }}
          bundler-cache: true
        env:
          BUNDLE_WITHOUT: release
      - name: Run tests
        run: bundle exec rake spec
```

This generates a Test matrix based on the current Ruby version 2.5 to 3.0.

The interesting part comes afterwards: We also do our releases through GitHub Actions:

```yaml
---
name: Release

on:
  create:
    ref_type: tag

jobs:
  release:
    runs-on: ubuntu-latest
    if: github.repository == 'voxpupuli/$repository'
    steps:
      - uses: actions/checkout@v2
      - name: Install Ruby 3.0
        uses: ruby/setup-ruby@v1
        with:
          ruby-version: '3.0'
        env:
          BUNDLE_WITHOUT: release
      - name: Build gem
        run: gem build *.gemspec
      - name: Publish gem to rubygems.org
        run: gem push *.gem
        env:
          GEM_HOST_API_KEY: '${{ secrets.RUBYGEMS_AUTH_TOKEN }}'
      - name: Setup GitHub packages access
        run: |
          mkdir -p ~/.gem
          echo ":github: Bearer ${{ secrets.GITHUB_TOKEN }}" >> ~/.gem/credentials
          chmod 0600 ~/.gem/credentials
      - name: Publish gem to GitHub packages
        run: gem push --key github --host https://rubygems.pkg.github.com/voxpupuli *.gem
```

The release process is basically:

* someone bumps the version in the gemspec
* the changelog is generated with the [GitHub Changelog Generator Rubygem](https://github.com/github-changelog-generator/Github-Changelog-Generator#github-changelog-generator-) based on closed PRs/issues since the last release
* the changes are provided as a PR
* after that's approved and merged, a maintainer creates a gpg-signed git tag and pushes that to GitHub
* the Release action posed above will build the gem on Ruby 3.0 and publishes it to rubygems and to GitHub packages

**secrets.GITHUB_TOKEN is available within the action by default, secrets.RUBYGEMS_AUTH_TOKEN is a custom secret defined on the GitHub org level**

Besides creating the yaml file and the `secrets.RUBYGEMS_AUTH_TOKEN` secret, no additional configuration is required to publich to RubyGems/GitHub packages.

For all puppet-lint plugins we have, we sync those actions via [modulesync](https://github.com/voxpupuli/modulesync#modulesync) (take a look at the [template repository](https://github.com/voxpupuli/puppet-lint_modulesync_configs/tree/master/moduleroot/.github/workflows))
