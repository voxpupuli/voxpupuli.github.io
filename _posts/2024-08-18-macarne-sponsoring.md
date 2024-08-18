---
layout: post
title: Macarne sponsors a buildserver
date: 2024-08-18
github_username: bastelfreak
category: changelog
---

Since a few days, [Macarne](https://macarne.com/), a bare metal solution provider, is sponsoring us a big AMD Epyc box.
This system provides us 96 CPU cores, 128GB memory and 4TB of fast NVME storage.
Our plan is to use this machine to host own GitHub runners. They will execute beaker jobs with real virtual machines.
This allows us to test operating systems that don't work on Docker/Podman, like FreeBSD, but but also lowlevel interactions with SystemD and SELinux that just doesn't work in containers.

We're still looking for more CI nodes. If you can offer a dedicated server, or if you maintain a Puppet module that would benefit from beaker jobs with real VMs, please reach out to us via our IRC channel `#voxpupuli` on Libera or our mailinglist [voxpupuli@groups.io](mailto:voxpupuli@groups.io).
