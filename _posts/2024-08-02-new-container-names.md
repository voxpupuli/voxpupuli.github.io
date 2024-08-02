---
layout: post
title: New container names for puppetserver and puppetdb
date: 2024-08-02
github_username: rwaffen
category: changelog
---

Beginning of today we are also releaseing our puppetserver and puppetdb containers with shorter names.

The current names are: `voxpupuli/container-puppetserver` and `voxpupuli/container-puppetdb`.

- <https://github.com/orgs/voxpupuli/packages/container/package/container-puppetserver>
- <https://github.com/orgs/voxpupuli/packages/container/package/container-puppetdb>
- <https://hub.docker.com/r/voxpupuli/container-puppetserver>
- <https://hub.docker.com/r/voxpupuli/container-puppetdb>

The new, shorter names are: `voxpupuli/puppetserver` and `voxpupuli/puppetdb`.

- <https://github.com/orgs/voxpupuli/packages/container/package/puppetserver>
- <https://github.com/orgs/voxpupuli/packages/container/package/puppetdb>
- <https://hub.docker.com/r/voxpupuli/puppetserver>
- <https://hub.docker.com/r/voxpupuli/puppetdb>

The content is exactly the same, only the name has changed. Only new tags will be pushed to the new names. The old names will also be updated.

We plan to deprecate the old names in 6 months (2025-02), so please update your scripts and configurations to use the new names.
