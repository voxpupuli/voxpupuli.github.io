---
layout: post
title: Make puppet module documentation great again!
date: 2023-02-27
github_username: bastelfreak
twitter_username: BastelsBlog
---

A long long time ago I can still remember... [Dominic Cleal](https://github.com/domcleal)
created [puppetmodule.info](https://www.puppetmodule.info/). Inspired by
[rubydoc.info](https://rubydoc.info/), the site generates documentation for
Puppet modules with [puppet-strings](https://www.puppet.com/docs/puppet/7/puppet_strings_style.html).
puppetmodule.info was created around 2017. Since then Dominic moved on and isn't
active anymore in the Puppet ecosystem. The site was slowly forgotten.

Vox Pupuli adopted it by the end of 2022. We updated the source code to work on
modern Ruby and enabled TLS for the domain.

You want to use puppetmodule.info for your own modules? Just publish to the
forge! We scrape the forge API on a regular basis to import new releases
automatically. You can also add a badge to your README.md:

```
[![puppetmodule.info docs](http://www.puppetmodule.info/images/badge.png)](http://www.puppetmodule.info/m/puppet-borg)
```
Which will look like this:

[![puppetmodule.info docs](https://www.puppetmodule.info/images/badge.png)](https://www.puppetmodule.info/m/puppet-borg)

You want to participate in the development? Checkout the sourcecode!

[github.com/voxpupuli/puppetmodule.info](https://github.com/voxpupuli/puppetmodule.info)

You like Ops work and want to help run the server? Ping us on Slack or IRC (links in the footer).

You love Vox Pupuli? You can now sponsor us! Check [opencollective.com/vox-pupuli](https://opencollective.com/vox-pupuli) or [github.com/sponsors/voxpupuli](https://github.com/sponsors/voxpupuli)


Thanks Hetzner Online for sponsoring the cloud resources to host puppetmodule.info!
[![Sponsored by Hetzner Online GmbH]({{ site.url }}{{ site.baseurl }}/static/images/hetzner_cloud_logo.svg)](https://www.hetzner.com)
