---
layout: post
title: Setting up a gem for publication
date: 2025-08-13
summary: Steps to do to enable publication of a new gem
---

Those are the steps you have to take to publish a new gem:


## Setup GitHub workflow

Right now we don't have a way to sync workflows for each gem.
Copy the [release workflow](https://github.com/voxpupuli/gem-workflow-test/blob/master/.github/workflows/release.yml) from our [boilerplate gem](https://github.com/voxpupuli/gem-workflow-test).
This workflow will take care of:

* Building the gem
* Creating a GitHub and rubygems.org release
* Attaching the gem to the GitHub release
* Creating the changelog for the GitHub release
* Waits until the new version is present on the rubygems.org cache

### Configure rubygems.org

**This needs to be done by a PMC member**

Before the first release, trusted publishing needs to be configured on rubygems.org

* login to rubygems.org with the voxpupui or openvoxproject account from gopass
* go to https://rubygems.org/profile/oidc/pending_trusted_publishers
* click "create"
* add gem name, repo owner ("voxpupuli" or "OpenVoxProject"), repo name (usually same as gem name), workflow name (`release.yml`)
* Set environment to `release` ([configured in our workflow](https://github.com/voxpupuli/gem-workflow-test/blob/96a29ada7ddea2ba0f27cbe0efd2194c7b9e7213/.github/workflows/release.yml#L71))

This step has to be done at maximum 48h before the first release, or rubygems.org deletes the configuration.
The configuration can be added again if rubygems.org deleted it.

## Setup the GitHub Changelog configuration

Copy the [config yaml](https://github.com/voxpupuli/gem-workflow-test/blob/master/.github/release.yml).
This will ensure that all closed issues and PRs with labels are sorted into the correct categories.

## Recommendations

### dependabot

We have a basic [dependabot config](https://github.com/voxpupuli/gem-workflow-test/blob/master/.github/dependabot.yml).
It will raise PRs for updates on Ruby dependencies or github action dependencies.
We highly recommend that you copy the file.

### Gemfile

We recommend that the Gemfile contains a `release` gem group:

```ruby
group :release, optional: true do
  gem 'faraday-retry', '~> 2.1', require: false
  gem 'github_changelog_generator', '~> 1.16.4', require: false
end
```

### Rakefile

With the `changelog` rake task, you can follow our [release documentation](https://voxpupuli.org/docs/releasing_gem/).
Put the following in a Rakefile (adjust the `config.project` value):

```ruby
begin
  require 'rubygems'
  require 'github_changelog_generator/task'
rescue LoadError
else
  GitHubChangelogGenerator::RakeTask.new :changelog do |config|
    config.exclude_labels = %w[duplicate question invalid wontfix wont-fix skip-changelog dependencies]
    config.user = 'voxpupuli'
    config.project = 'json-schema'
    gem_version = Gem::Specification.load("#{config.project}.gemspec").version
    config.future_release = "#{gem_version}"
  end
end
```
