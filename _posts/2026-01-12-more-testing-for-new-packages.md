---
layout: post
title: More testing for OpenVoxServer packages
date: 2026-01-12
github_username: bastelfreak
---

In [our last blog post](https://voxpupuli.org/blog/2026/01/05/new-openvoxserver-beta-packages/) we announced new (beta) packages for OpenVoxServer.
We won't release the packages today.
Instead, we are going to do a bit more testing and refactoring.
A lot of those clojure dependencies didn't get the love they deserved in the past years and have heavily outdated dependencies.
The additional testing period allows us to update more of them.
You can find an overview of the various beta packages [on  our mirror](https://artifacts.voxpupuli.org/openvox-server/).
Every 8.12.0-0.1SNAPSHOT* directory is a new build.
As a bonus, we now also have [FIPS](https://artifacts.voxpupuli.org/openvox-server/8.12.0-0.1SNAPSHOT.2026.01.07T0208/) builds!

To test it, you can simply download the SNAPSHOT package and upgrade your existing installation.
If you want to try it on a new box, you will have to add our usual repos from [apt.voxpupuli.org](https://apt.voxpupuli.org/) or [yum.voxpupuli.org](https://yum.voxpupuli.org/).
That's required because the server package depends on the agent package.

If you find any bugs or want to contribute, please come to our [#openvox](https://voxpupuli.org/connect/) channel on IRC or slack.

Edit: [The release is available!](https://voxpupuli.org/blog/2026/01/16/new-openvox-server-release/)
