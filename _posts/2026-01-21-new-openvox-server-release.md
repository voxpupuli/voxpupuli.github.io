---
layout: post
title: Another OpenVox-Server release!
date: 2026-01-21
github_username: bastelfreak
---

OpenVox-Server 8.12.1 got released!

In our [8.12.0](https://voxpupuli.org/blog/2026/01/16/new-openvox-server-release/) we had a regression due to an updated dependency.
More specifically, the Update of [ring:ring-core from 1.8.2 → 1.15.3](https://github.com/OpenVoxProject/openvox-server/pull/128) decreased the OpenVox-Server performance for incoming http(s) connections.
Our 8.12.1 release [fixed that](https://github.com/OpenVoxProject/openvox-server/pull/184).

A big thank you to Nick Burgan Austin Blatt and Corporte Gadfly for all the work and the quick fix!

**Please provide feedback! Let us know if you used the beta period & if we should adjust it in the future. If you find any bugs or want to contribute, please come to our [#openvox](https://voxpupuli.org/connect/) channel on IRC or slack.**

## What's Changed

For a comprehensive look at what's changed (including new features, bug fixes, and dependency updates), please see the [release notes for 8.12.1](https://github.com/OpenVoxProject/openvox-server/releases/tag/8.12.1).
