---
layout: post
title: Contributing to modules
github_username: daenney
twitter_username: daenney
date: 2014-04-23
---

As one of the 'maintainers' of [puppetlabs-apt](https://github.com/puppetlabs/puppetlabs-apt)
I get pull requests in my inbox on a weekly basis implementing some kind of
feature. This is really cool. It means people found bugs, fixed them or
implemented new ones (features that is, we hope).

But... modules have tests and when you submit a PR without tests, the only
thing we will do is *ask for tests*. We won't make an exception for you. If you
want your PR merged, it'll need to be up to par.

This means:

 * It doesn't break current tests (yes this happens, often);
 * It introduces tests for the new/fixed behaviour (so we don't regress).

We need to write and maintain modules that work for everyone and don't
accidentally break on people reaping havoc across their machines.

So what kind of tests do we expect? At the very least the acceptance tests
should be updated. Those spin up actual machines through Beaker and apply
(parts) of the module to machines and check its behaviour. If you can, or if
your change contains complex logic we'd also appreciate updated rspec tests,
but those are optional.

In the end, the golden rules for contributing (to any opensource project really)
are:

 * Submit PR's with tests. If you don't know how to write tests, put that in
   the PR too, so we know how to help you;
 * Work with us and we'll work with you. It's okay if you PR is not perfect or
   if you're unfamiliar with writing tests. As long as you're willing to put in
   the work we're willing to coach you. Perhaps you can have a look at this
   [post](https://voxpupuli.org/blog/2014/04/22/modern-testing-of-modules/) to
   get you going;
 * Don't ride off into the sunset. If you submit a PR we expect you to stick
   around for the follow-ups. If not then it'll simply not get merged. Not
   because we're mean, but because we too have a thousand other things to do
   too.

If you're contributing to a Puppetlabs module and you feel your PR isn't
getting the attention it deserves, stop by for the weekly Module Triage
hangout on Thursdays around 10 AM Portland Time. Links are posted in
the #puppet-dev on IRC and on the Puppet Developers mailing list beforehand.
