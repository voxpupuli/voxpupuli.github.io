---
layout: post
title: The Perforce EULA and impact on Vox Pupuli
date: 2025-05-16
github_username: bastelfreak
---

In November 2024, [Perforce announced](https://www.puppet.com/blog/open-source-puppet-updates-2025) that they will stop providing most tools & projects as open source.

> In early 2025, Puppet will begin to ship any new binaries and packages developed by our team to a private, hardened, and controlled location.
> Community contributors will have free access to this private repo under the terms of an End-User License Agreement (EULA) for development use. There will be no license changes for the open source version of Puppet.

As the top community contributors to the Puppet module ecosystem and the maintainers of much of the Puppet module testing pipeline tooling, Vox Pupuli has significant expertise in developer experience.
The [Vox Pupuli PMC](https://voxpupuli.org/elections/) immediately reached out to Perforce to discuss the [provided](https://github.com/voxpupuli/community-triage/issues/29) "[PUPPET® CORE DEVELOPER PROGRAM LICENSE AGREEMENT](https://www.perforce.com/system/files/2025-02/Puppet-Core-Developer-Program-License-Agreement.pdf)" in hopes of improving it and reducing the friction to contributing Puppet modules.

As of today (2025-05-16), Vox Pupuli is unable to sign the current version of the Puppet Core Developer EULA.
The restrictions placed on usage prevent effective testing and distribution of modules and we don’t want to expose ourselves to potential legal challenges.
Unfortunately, this means that Vox Pupuli modules are not tested against Puppet Core, so please use them at your own risk.
We are still interested in working together with Perforce, but their current EULA doesn't allow it.

Vox Pupuli will continue to test all of our modules against the [Open Vox packeges](https://voxpupuli.org/openvox/).
All provided tooling from Vox Pupuli has an open source license and doesn't require a EULA to use it, nor a CLA to participate.
