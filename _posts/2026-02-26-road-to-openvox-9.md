---
layout: post
title: Our road to openvox 9
date: 2026-02-26
github_username: bastelfreak
---

[Based on our discussions in Gent](https://github.com/voxpupuli/community-triage/wiki/CfgMgmtCamp-2026), we created a roadmap for openvox 9!

We mostly want to remove already deprecated options, update bundled components (looking at you, OpenSSL and Ruby), and deprecate stuff we want to remove in openvox 10.
Checkout [the roadmap on GitHub](https://github.com/orgs/OpenVoxProject/projects/6/views/1).

There are lots of outstanding tickets that we still need to tackle.
Every help here is appreciated.
If you want to help out, please join our `#openvox` channel [on IRC/Slack](https://voxpupuli.org/connect/).

Although we still have many outstanding changes, we tackled some milestones. We have "alpha" packages for all our supported Linux distributions with:

* Ruby Updated to 4.0.1
* OpenSSL updated to 3.5.5 (latest LTS)
* Removed curl from the agent package
* Removed multi_json gem

The Ruby build has support for [YJIT](https://docs.ruby-lang.org/en/4.0/jit/yjit_md.html) and [ZJIT](https://docs.ruby-lang.org/en/4.0/jit/zjit_md.html), on some platforms.
The different just in time compilers might provide a performance benefit.
Some of their features are still experimental.
To compile Ruby with it, a modern Rust 1.85.0 is required. We can not build ZJIT on the following platforms:

* debian-11-aarch64
* debian-11-amd64
* debian-12-aarch64
* debian-12-amd64
* debian-13-armhf
* macos-all-arm64
* macos-all-x86_64
* sles-15-x86_64
* sles-16-aarch64
* sles-16-x86_64
* ubuntu-22.04-aarch64
* ubuntu-22.04-amd64
* ubuntu-24.04-aarch64
* ubuntu-24.04-amd64
* ubuntu-24.04-armhf
* ubuntu-25.04-aarch64
* ubuntu-25.04-amd64
* ubuntu-25.04-armhf
* ubuntu-26.04-armhf
* windows-all-x64

For YJIT Rust is still required, but 1.58.0 is sufficient.
We could build YJIT on some platforms where ZJIT doesn't work, but that's not configured right now.
YJIT is available in Ruby 3.2 as well, so we could enable it for openvox 8.

To test ZJIT / YJIT, you can add the commandline option to Ruby:

```diff
--- a/opt/puppetlabs/puppet/bin/puppet
+++ a/opt/puppetlabs/puppet/bin/puppet
@@ -1,4 +1,4 @@
-#!/opt/puppetlabs/puppet/bin/ruby
+#!/opt/puppetlabs/puppet/bin/ruby --zjit
 # frozen_string_literal: true

 begin
```

or:

```diff
--- a/opt/puppetlabs/puppet/bin/puppet
+++ a/opt/puppetlabs/puppet/bin/puppet
@@ -1,4 +1,4 @@
-#!/opt/puppetlabs/puppet/bin/ruby
+#!/opt/puppetlabs/puppet/bin/ruby --zjit
 # frozen_string_literal: true

 begin
```

There are a few options, which you can check in `/opt/puppetlabs/puppet/bin/ruby --help` or the documentation for [YJIT](https://docs.ruby-lang.org/en/4.0/jit/yjit_md.html) and [ZJIT](https://docs.ruby-lang.org/en/4.0/jit/zjit_md.html).
A helpful option is also `--zjit-stats` which will print some profiling data to stdout.

**It's not guaranteed that we will ship either JIT implementations in the stable builds.**

We first need to prove that they don't introduce any performance regressions.

---

Beside those changes, the agent is identical to openvox-agent 8.25.0 right now.
Please download the packages from [artifacts.voxpupuli.org](https://artifacts.voxpupuli.org/openvox-agent/8.25.0.9.g086d1fd67/) and give us feedback.
(If you are interested in setting up an actual nightlies/staging rpm/deb repo, that's also highly appreciated).
