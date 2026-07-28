---
date: 2026-07-28
github_username: bastelfreak
layout: post
title: openvox-server 8.25.2 & 9.0.0-beta2 releases
---

We are pleased to announce new release of openvox-server!

## What's Changed in 8.15.2

### Bug Fixes 🐛

* Fix Resolv regression when querying IPv6 DNS servers ([github.com/OpenVoxProject/openvox-server/pull/538](https://github.com/OpenVoxProject/openvox-server/pull/538))

**Full Changelog**: [github.com/OpenVoxProject/openvox-server/compare/8.15.1...8.15.2](https://github.com/OpenVoxProject/openvox-server/compare/8.15.1...8.15.2)

## What's Changed in 9.0.0-beta2

### Breaking Changes 🛠

* Depend on openvox-agent >=9.0.0~beta1 by @Sharpie in [github.com/OpenVoxProject/openvox-server/pull/495](https://github.com/OpenVoxProject/openvox-server/pull/495)
* Update Jruby 10.0.6.0 to 10.1.1.0 (MRI 3.4 -> 4.0) by @renovate[bot] in [github.com/OpenVoxProject/openvox-server/pull/525](https://github.com/OpenVoxProject/openvox-server/pull/525)

### Bug Fixes 🐛

* Ensure "gem install" works during FIPS builds by @Sharpie in [github.com/OpenVoxProject/openvox-server/pull/517](https://github.com/OpenVoxProject/openvox-server/pull/517)
* Fix Resolv regression when querying IPv6 DNS servers by @Sharpie in [github.com/OpenVoxProject/openvox-server/pull/53](https://github.com/OpenVoxProject/openvox-server/pull/537)

### Dependency Updates ⬆️

* Update dependency gettext to v3.5.2 (main) by @renovate[bot] in [github.com/OpenVoxProject/openvox-server/pull/442](https://github.com/OpenVoxProject/openvox-server/pull/442)
* Update dependency locale to v2.1.5 (main) by @renovate[bot] in [github.com/OpenVoxProject/openvox-server/pull/443](https://github.com/OpenVoxProject/openvox-server/pull/443)
* Update dependency org.openvoxproject:ssl-utils to v3.7.0 (main) by @renovate[bot] in [github.com/OpenVoxProject/openvox-server/pull/499](https://github.com/OpenVoxProject/openvox-server/pull/499)
* Update dependency org.openvoxproject:http-client to v2.4.0 (main) by @renovate[bot] in [github.com/OpenVoxProject/openvox-server/pull/500](https://github.com/OpenVoxProject/openvox-server/pull/500)
* Update dependency org.openvoxproject:trapperkeeper-webserver to v12.1.0 (main) by @renovate[bot] in [github.com/OpenVoxProject/openvox-server/pull/502](https://github.com/OpenVoxProject/openvox-server/pull/502)
* Update dependency org.openvoxproject:trapperkeeper-authorization to v2.4.0 (main) by @renovate[bot] in [github.com/OpenVoxProject/openvox-server/pull/501](https://github.com/OpenVoxProject/openvox-server/pull/501)

### Other Changes

* Update dependency org.bouncycastle:bcpkix-jdk18on to v1.85 (main) by @renovate[bot] in [github.com/OpenVoxProject/openvox-server/pull/489](https://github.com/OpenVoxProject/openvox-server/pull/489)
* Add acceptance test coverage for long certnames by @Sharpie in [github.com/OpenVoxProject/openvox-server/pull/509](https://github.com/OpenVoxProject/openvox-server/pull/509)
* replace puppetlabs.com docs link with openvoxproject.org by @corporate-gadfly in [github.com/OpenVoxProject/openvox-server/pull/519](https://github.com/OpenVoxProject/openvox-server/pull/519)
* Clarify descriptions of FIPS build workflow inputs by @Sharpie in [github.com/OpenVoxProject/openvox-server/pull/518](https://github.com/OpenVoxProject/openvox-server/pull/518)

Thank you to [Sharpie](https://github.com/sharpie) for fixing the Resolv regression in JRuby and to [bastelfreak](https://github.com/bastelfreak) for making both releases.

**Full Changelog**: [github.com/OpenVoxProject/openvox-server/compare/9.0.0-beta1...9.0.0-beta2](https://github.com/OpenVoxProject/openvox-server/compare/9.0.0-beta1...9.0.0-beta2)

**Please provide feedback! If you have questions about, or encounter issues with these releases, reach out in `#openvox` on Slack or `#voxpupuli-openvox` on IRC. See <https://voxpupuli.org/connect/> for details.**
