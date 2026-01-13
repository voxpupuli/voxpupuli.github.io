---
layout: post
title: New OpenVox-Agent FIPS packages available!
date: 2026-01-13
github_username: bastelfreak
---

We now have a FIPS agent for EL 8 and 9!

The platform is named [redhatfips](https://yum.voxpupuli.org/openvox8/redhatfips/) to match the nomenclature used by Puppet, but it should work on any FIPS-enabled EL flavor.
Because building this agent requires building it on a FIPS-enabled host, which we do not have in GitHub Actions (yet!), you may see the FIPS version of the agent for future releases lag slightly behind the rest.
But we'll do our best to get them out concurrently as much as we can.
We will also provide FIPS-enabled packages for OpenVoxDB & Server in the future.

If you find any bugs or want to contribute, please come to our [#openvox](https://voxpupuli.org/connect/) channel on IRC or slack.

A big thank you to Nick Burgan and Overlook InfraTech for building the packages!
