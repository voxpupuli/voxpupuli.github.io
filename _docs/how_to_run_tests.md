---
layout: post
title: How to run the test suite
date: 2021-10-20
summary: A very short description of how to run the vox pupuli test suite.
---

The Vox Pupuli test suite consists of several parts:

## Installing requirements

`bundle install`

## Vox Pupuli helpers

Check out the following page if you want to add a test suite to your module or want
to learn more about the Vox Pupuli test helpers:
* [voxpupuli-test](https://github.com/voxpupuli/voxpupuli-test) for unit testing
* [voxpupuli-acceptance](https://github.com/voxpupuli/voxpupuli-acceptance) for acceptance testing

## Linting

Vox Pupuli uses [puppet-lint](https://github.com/puppetlabs/puppet-lint) for better code quality. To run it:

`bundle exec rake lint`

To automatically fix puppet-lint issues you can use:

`bundle exec rake lint_fix`

## Unit tests

`bundle exec rake spec`

If you have multiple cpu cores available we suggest using the following command:

`bundle exec rake parallel_spec`

Single test file could be run by:

* `bundle exec rspec spec/classes/myclass_spec.rb`
* `bundle exec rake spec SPEC=spec/classes/myclass_spec.rb`

To limit test execution to a certain os or os release you can set the environment variable `SPEC_FACTS_OS`.

* `export SPEC_FACTS_OS=centos`
* `export SPEC_FACTS_OS=centos-7`

## Acceptance tests

`BEAKER_SETFILE=centos7-64 bundle exec rake beaker`

How to run the acceptance tests is described more in detail on this page:
[voxpupuli-acceptance](https://github.com/voxpupuli/voxpupuli-acceptance/#running-tests)

## REFERENCE.md update

If REFERENCE.md is now out of date you can fix it with:

`bundle exec rake strings:generate:reference`
