---
layout: post
title: Vox Pupuli Changelog - Dropping Puppet 6 support
date: 2023-04-28
github_username: bastelfreak
twitter_username: bastelsblog
category: changelog
---

This is our new blog series, where we inform you about changes within Vox Pupuli itself or our codebase!
Today we start with the first one, information about dropping Puppet 6 support.

Starting today, 2023-04-28, we are dropping Puppet 6 support from our modules. Puppet 6 is end
of life since 2023-02-28. Puppet's policy on EOL is available at:
[Puppet Enterprise Lifecycle Policy](https://www.puppet.com/products/puppet-enterprise/support-lifecycle).
Each of our modules received a PR with the title `Drop Puppet 6 support`. The
change will be released as a major version. Puppet 6 AIO agents
[shipped Ruby 2.5](https://www.puppet.com/docs/pe/2019.8/component_versions_in_recent_pe_releases.html).
With dropping Puppet 6 we will also require Ruby 2.6. That's the ruby version
used in Puppetserver 7. We will update our RuboCop configuration to default to
Ruby 2.7 in the next weeks.
