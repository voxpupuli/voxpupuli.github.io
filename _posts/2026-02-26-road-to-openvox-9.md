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

Besides that, the agent is identical to openvox-agent 8.25.0 right now.
Please download the packages from [artifacts.voxpupuli.org](https://artifacts.voxpupuli.org/openvox-agent/8.25.0.9.g086d1fd67/) and give us feedback.
(If you are interested in setting up an actual nightlies/staging rpm/deb repo, that's also highly appreciated).
