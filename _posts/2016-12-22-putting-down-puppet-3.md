---
layout: post
title: Putting down Puppet 3
date: 2016-12-22
github_username: nibalizer
twitter_username: nibalizer
---

Puppet 3 is officially end of life on Jan 1, 2017. That is 8 days from today. Vox Pupuli's plan for deprecating Puppet 3 support in modules is as follows:

* As of Jan 1, 2017, any module can accept Puppet 4 code on the master branch.
* Adding Puppet 4 code is a major version bump.
* When we land that code, we will create a branch called 'puppet3' on that repository.
* The 'puppet3' branches will not be released.
* Anyone stuck on Puppet 3 can use the 'puppet3' branch from git and land pull requests there.

This allows the community to move forward with Puppet 4. This also allows our friends still using Puppet 3 to consume our modules and add/share small bugfixes.

The floodgates are open, write Puppet 4!
