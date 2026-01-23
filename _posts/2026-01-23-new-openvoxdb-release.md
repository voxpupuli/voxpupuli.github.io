---
layout: post
title: Another OpenVoxDB release!
date: 2026-01-23
github_username: bastelfreak
---

OpenVoxDB 8.12.1 got released!

After our big [OpenVox-Server release](https://voxpupuli.org/blog/2026/01/16/new-openvox-server-release/), we did the same for OpenVoxDB.

This version represents a significant change in how OpenVoxDB is built. Most of this is under the hood, but should lower the bar to development and allow us to make changes more easily and rapidly.

In addition to the standard GitHub release notes, these are the important changes in this version.

* Platform support
  * Removed: EL 7
  * Added: Amazon Linux 2, Fedora 42, Fedora 43, Redhatfips 8, Redhatfips 9 (Redhatfips 10 will come in the future)
  * Note that Amazon Linux 2 support will be removed when it goes EOL in June of 2026
  * Note that the platform name `redhatfips` is used since Puppet uses this nomenclature, but it should work on any FIPS-enabled Enterprise Linux-based platform.
* Java 11 support has been removed, and either Java 17 or Java 21 must be used.
* Removes Janino support. Logback removed support for it due to CVEs. This means that logbook evaluator filters are no longer supported. These were not commonly used so unless you specifically included <evaluator> tags in your logback config, you should not be affected.
* Also due to the removal of Janino, Trapperkeeper’s ‘post-config-script’ option for injecting Java code directly into Jetty for controlling low-level Jetty settings that are not exposed by Trapperkeeper is no longer supported. This is also a feature not commonly used, and was a potential security risk in itself.
* This version of openvox-server and all related components have now been migrated to the org.openvoxproject namespace and are available on Clojars, with fixed up testing and release workflows.
* Lots and lots of dependency updates that you should not notice, but brings the code up to a more maintainable standard.
* The following third-party components were updated to address CVEs (those are just the updates that resolve CVEs, we updated almost every dependency):
    * Jetty 10.0.20 -> 10.0.26: [CVE-2025-5115](https://nvd.nist.gov/vuln/detail/CVE-2025-5115) / [GHSA-mmxm-8w33-wc4h](https://github.com/advisories/GHSA-mmxm-8w33-wc4h), [CVE-2024-8184](https://nvd.nist.gov/vuln/detail/CVE-2024-8184) / [GHSA-g8m5-722r-8whq](https://github.com/advisories/GHSA-g8m5-722r-8whq)
    * jackson-databind 2.14.0 -> 2.15.4: [CVE-2025-52999](https://nvd.nist.gov/vuln/detail/CVE-2025-52999) / [GHSA-h46c-h94j-95f3](https://github.com/advisories/GHSA-h46c-h94j-95f3)
    * logback 1.3.14 -> 1.3.16: [CVE-2024-12798](https://nvd.nist.gov/vuln/detail/CVE-2024-12798), [CVE-2024-12801](https://nvd.nist.gov/vuln/detail/CVE-2024-12801), [CVE-2025-11226](https://nvd.nist.gov/vuln/detail/CVE-2025-11226)
    * commons-beanutils 1.9.4 -> 1.11.0: [CVE-2025-48734](https://nvd.nist.gov/vuln/detail/CVE-2025-48734)
    * Bouncy Castle non-FIPS 1.78.1 -> 1.83: [CVE-2025-8916](https://nvd.nist.gov/vuln/detail/CVE-2025-8916)
* Additionally, this is the first FIPS release of OpenVox server, but compared to the baseline FIPS config from before the fork:
  - bcpkix-fips 1.0.7 -> 1.0.8: CVE-2025-8916
  - bc-fips 1.0.2.5 -> 1.0.2.6: CVE-2025-8885
    * bcpkix-fips 1.0.7 -> 1.0.8: [CVE-2025-8916](https://nvd.nist.gov/vuln/detail/CVE-2025-8916) / [GHSA-4cx2-fc23-5wg6](https://github.com/advisories/GHSA-4cx2-fc23-5wg6)
    * bc-fips 1.0.2.5 -> 1.0.2.6: [CVE-2025-8885](https://nvd.nist.gov/vuln/detail/CVE-2025-8885) / [GHSA-67mf-3cr5-8w23](https://github.com/advisories/GHSA-67mf-3cr5-8w23)
* We added PrivateTmp=true to the systemd unit. This is a best practice since years, and [theforeman/puppet](https://github.com/theforeman/puppet-puppet/blob/master/manifests/server/puppetserver.pp#L239-L245) does that since years **for the OpenVox-Server** already.


A big thank you to Nick Burgan, Austin Blatt and Corporate Gadfly for all the work!

**Please provide feedback! Let us know if you used the beta period & if we should adjust it in the future. If you find any bugs or want to contribute, please come to our [#openvox](https://voxpupuli.org/connect/) channel on IRC or slack.**

## What's Changed

For a comprehensive look at what's changed (including new features, bug fixes, and dependency updates), please see the [release notes for 8.12.1](https://github.com/OpenVoxProject/openvoxdb/releases/tag/8.12.1) and [8.12.0](https://github.com/OpenVoxProject/openvoxdb/releases/tag/8.12.0).
