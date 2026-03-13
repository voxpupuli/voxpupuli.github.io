---
layout: post
title: New OpenBolt 5.4.0 release
date: 2026-03-12
github_username: marcusdots
---

We keep delivering updated software, fixed security bugs, and new features. As part of our ongoing release campaign, we bring you OpenBolt 5.4.0;
This release provides the [groundwork to integrate Choria transport](https://github.com/OpenVoxProject/puppet-runtime/issues/128) into OpenBolt. We are also [dropping puppet_connect](https://github.com/OpenVoxProject/openbolt/pull/197/changes).

We now support:

<div class="card shadow-sm mb-3">
  <div class="card-header fw-semibold">
    Amazon
  </div>
  <ul class="card-body d-flex flex-wrap gap-2">
    <li class="badge bg-dark">2-aarch64</li>
    <li class="badge bg-dark">2-x86_64</li>
    <li class="badge bg-dark">2023-aarch64</li>
    <li class="badge bg-dark">2023-x86_64</li>
  </ul>
  <div class="card-header fw-semibold">
    Ubuntu
  </div>
  <ul class="card-body d-flex flex-wrap gap-2">
    <li class="badge bg-dark">22.04-amd64</li>
    <li class="badge bg-dark">22.04-aarch64</li>
    <li class="badge bg-dark">24.04-amd64</li>
    <li class="badge bg-dark">24.04-aarch64</li>
    <li class="badge bg-dark">24.04-armhf</li>
    <li class="badge bg-dark">25.04-amd64</li>
    <li class="badge bg-dark">25.04-aarch64</li>
    <li class="badge bg-dark">25.04-armhf</li>
    <li class="badge bg-dark">26.04-amd64</li>
    <li class="badge bg-dark">26.04-aarch64</li>
    <li class="badge bg-dark">26.04-armhf</li>
  </ul>
  <div class="card-header fw-semibold">
    Debian
  </div>
  <ul class="card-body d-flex flex-wrap gap-2">
    <li class="badge bg-dark">11-aarch64</li>
    <li class="badge bg-dark">11-amd64</li>
    <li class="badge bg-dark">12-aarch64</li>
    <li class="badge bg-dark">12-amd64</li>
    <li class="badge bg-dark">13-aarch64</li>
    <li class="badge bg-dark">13-amd64</li>
    <li class="badge bg-dark">13-armhf</li>
  </ul>
  <div class="card-header fw-semibold">
    Enterprise Linux
  </div>
  <ul class="card-body d-flex flex-wrap gap-2">
    <li class="badge bg-dark">8-aarch64</li>
    <li class="badge bg-dark">8-x86_64</li>
    <li class="badge bg-dark">9-aarch64</li>
    <li class="badge bg-dark">9-x86_64</li>
    <li class="badge bg-dark">10-x86_64</li>
    <li class="badge bg-dark">10-aarch64</li>
  </ul>
  <div class="card-header fw-semibold">
    Fedora
  </div>
  <ul class="card-body d-flex flex-wrap gap-2">
    <li class="badge bg-dark">42-x86_64</li>
    <li class="badge bg-dark">42-aarch64</li>
    <li class="badge bg-dark">43-x86_64</li>
    <li class="badge bg-dark">43-aarch64</li>
  </ul>
  <div class="card-header fw-semibold">
    SLES
  </div>
  <ul class="card-body d-flex flex-wrap gap-2">
    <li class="badge bg-dark">15-x86_64</li>
    <li class="badge bg-dark">16-aarch64</li>
    <li class="badge bg-dark">16-x86_64</li>
  </ul>
  <div class="card-header fw-semibold">
    MacOS
  </div>
  <ul class="card-body d-flex flex-wrap gap-2">
    <li class="badge bg-dark">all-arm64</li>
    <li class="badge bg-dark">all-x86_64</li>
  </ul>
</div>

Windows is supported as target, but not as host. We are working on Windows host support.

As always, the packages are available on our mirrors at [yum.voxpupuli.org](https://yum.voxpupuli.org/), [apt.voxpupuli.org](https://apt.voxpupuli.org/) and [downloads.voxpupuli.org](https://downloads.voxpupuli.org/) (for Windows and MacOS).

**Please download them and provide feedback [in the openvox Slack/IRC channel](https://voxpupuli.org/connect/).**

**Component Changes:**

changes compared between [Puppet-Runtime-2026.03.04.1 and 2026.02.25.1](https://github.com/OpenVoxProject/openbolt/pull/195/changes)


{: .table .table-striped .table-hover }

**Component Changes:**

| Component | Old Version | New Version |
|-----------|-------------|-------------|
| rubygem-choria-mcorpc-support | none | 2.26.5 |
| rubygem-nats-pure | none | 0.6.2 |
| rubygem-systemu | none | 2.6.5 |

