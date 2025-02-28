---
layout: post
title: How to run the test suite
date: 2021-10-20
summary: A very short description of how to run the vox pupuli test suite for puppet modules.
---

- [Running the tests in a local ruby environment](#running-the-tests-in-a-local-ruby-environment)
   * [Installing requirements](#installing-requirements)
   * [Vox Pupuli helpers](#vox-pupuli-helpers)
   * [Linting](#linting)
   * [Unit tests](#unit-tests)
      + [Detailed sub tasks](#detailed-sub-tasks)
   * [Acceptance tests](#acceptance-tests)
   * [REFERENCE.md update](#referencemd-update)
- [Running the tests in the VoxBox container](#running-the-tests-in-the-voxbox-container)
   * [Installation](#installation)
   * [Linting](#linting-1)
   * [Rubocop](#rubocop)
   * [Unit tests](#unit-tests-1)
   * [REFERENCE.md update](#referencemd-update-1)
   * [Puppetfile](#puppetfile)

The testing and development tools have a bunch of dependencies, all managed by [bundler](http://bundler.io/).
By default the tests use the latest version of Puppet.
If you want a specific version of Puppet, you must set an environment variable such as:

```shell
export PUPPET_VERSION="~> 8.8.1"
```

## Running the tests in a local ruby environment

### Installing requirements

You can install all needed gems for spec tests into the modules directory by running:

```shell
bundle config set --local path 'vendor'
bundle config set --local without 'development system_tests release'
BUNDLE_JOBS="$(nproc)" bundle install
```
If you also want to run acceptance tests, don't exclude the `system_tests` group.

If you don't know if you need to install or update gems, you can just add `bundle update && bundle clean` as an additional command.

### Vox Pupuli helpers

Check out the following page if you want to add a test suite to your module or want
to learn more about the Vox Pupuli test helpers:

* [voxpupuli-test](https://github.com/voxpupuli/voxpupuli-test) for unit testing
* [voxpupuli-acceptance](https://github.com/voxpupuli/voxpupuli-acceptance) for acceptance testing
* [voxpupuli-release](https://github.com/voxpupuli/voxpupuli-release) for bundling a release

### Linting

Vox Pupuli uses [puppet-lint](https://github.com/puppetlabs/puppet-lint) for better code quality. To run it:

```shell
bundle exec rake lint
```

To automatically fix puppet-lint issues you can use:

```shell
bundle exec rake lint_fix
```

Aso run some [RuboCop](https://rubocop.org/) tests against it:

```shell
bundle exec rake rubocop
```

RuboCop also supports save autofixing:

```shell
bundle exec rake rubocop:autocorrect
```

And another autofix option that can fix more, but might break your code:

```shell
bundle exec rake rubocop:autocorrect_all
```

### Unit tests

The unit test suite covers most of the code, as mentioned above please add tests if you're adding new functionality.
If you've not used [rspec-puppet](http://rspec-puppet.com/) before then feel free to ask about how best to test your new feature.

To run the linter, the syntax checker and the unit tests:

```shell
bundle exec rake test
```
#### Detailed sub tasks

```shell
bundle exec rake spec
```

If you have multiple cpu cores available we suggest using the following command:

```shell
bundle exec rake parallel_spec
```

Single test file could be run by:

```shell
bundle exec rspec spec/classes/myclass_spec.rb
bundle exec rake spec SPEC=spec/classes/myclass_spec.rb
```

To limit test execution to a certain os or os release you can set the environment variable `SPEC_FACTS_OS`.

```shell
export SPEC_FACTS_OS=centos
export SPEC_FACTS_OS=centos-7
```

### Acceptance tests

The unit tests just check the code runs, not that it does exactly what we want on a real machine.
For that we're using [beaker](https://github.com/voxpupuli/beaker).

This fires up a new virtual machine or container and runs a series of simple tests against it after applying the module.
You can run this on your own with:

```shell
BEAKER_SETFILE=centos9-64 bundle exec rake beaker
```

How to run the acceptance tests is described more in detail on this page:
[voxpupuli-acceptance](https://github.com/voxpupuli/voxpupuli-acceptance/#running-tests)

### REFERENCE.md update

If REFERENCE.md is now out of date you can fix it with:

```shell
bundle exec rake strings:generate:reference
```

## Running the tests in the VoxBox container

Struggling with Ruby installations or dependency issues? [VoxBox](https://github.com/voxpupuli/container-voxbox/) simplifies your workflow by providing a ready-to-use container with all the Ruby tools you need. To guarantee a consistent rake environment, use `-f /Rakefile` to explicitly specify your Rakefile, rather than relying on potentially outdated versions in a repository. Learn more in the project's [README](https://github.com/voxpupuli/container-voxbox/blob/main/README.md).

### Installation

```shell
podman pull ghcr.io/voxpupuli/voxbox:8
```

### Linting

```shell
cd my/module
podman run -it --rm -v $PWD:/repo:Z ghcr.io/voxpupuli/voxbox:8 -f /Rakefile lint
podman run -it --rm -v $PWD:/repo:Z ghcr.io/voxpupuli/voxbox:8 -f /Rakefile lint_fix

# lint with all lint plugins enabled, puppetlabs-spec_helper deactivates some of them
podman run -it --rm -v $PWD:/repo:Z ghcr.io/voxpupuli/voxbox:8 -f /Rakefile voxpupuli:custom:lint_all
```

### Rubocop

```shell
podman run -it --rm -v $PWD:/repo:Z ghcr.io/voxpupuli/voxbox:8 -f /Rakefile rubocop
podman run -it --rm -v $PWD:/repo:Z ghcr.io/voxpupuli/voxbox:8 -f /Rakefile rubocop:autocorrect
```

### Unit tests

```shell
podman run -it --rm -v $PWD:/repo:Z ghcr.io/voxpupuli/voxbox:8 -f /Rakefile spec
podman run -it --rm -e "SPEC_FACTS_OS=centos" -v $PWD:/repo:Z ghcr.io/voxpupuli/voxbox:8 -f /Rakefile spec
podman run -it --rm -e "SPEC=spec/classes/myclass_spec.rb" -v $PWD:/repo:Z ghcr.io/voxpupuli/voxbox:8 -f /Rakefile spec
```

### REFERENCE.md update

```shell
podman run -it --rm -v $PWD:/repo:Z ghcr.io/voxpupuli/voxbox:8 -f /Rakefile strings:generate:reference
```

### Puppetfile

```shell
podman run -it --rm -v $PWD:/repo:Z ghcr.io/voxpupuli/voxbox:8 -f /Rakefile r10k:syntax
podman run -it --rm -v $PWD:/repo:Z ghcr.io/voxpupuli/voxbox:8 -f /Rakefile r10k:dependencies
```
