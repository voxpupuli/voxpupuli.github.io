---
layout: post
title: Puppet Deprecated on FreeBSD
date: 2026-03-15
github_username: smortex
---

Following [the announcement](https://www.freebsd.org/status/report-2025-10-2025-12/#_openvox_puppet) in the FreeBSD status report for the 4th quarter of 2025:

> Because the legacy ports of Puppet 8 will not be updated anymore, they will be deprecated soon

As of 2026-03-15, the ports are [marked DEPRECATED](https://cgit.freebsd.org/ports/commit/?id=89421aa2dbb3b35afeecc4e88db2fb1e459313f8).
Packages are still built and available, so this does not change anything yet for users.
But the ports will eventually be removed after 2026-07-01, and packages will not be available anymore.

If you are still using these legacy packages on your FreeBSD systems, you are advised to switch to the OpenVox packages which offer a drop-in replacement: for each deprecated package, an alternative actively maintained package by OpenVox is available.
The new packages install files in the same location and services with the same name, allowing a straightforward install: pkg(8) will report that the new package conflicts with the legacy one, and will propose to remove it.
