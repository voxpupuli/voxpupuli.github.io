---
layout: post
title: New OpenVox-Server packages available for testing!
date: 2026-01-05
github_username: bastelfreak
---

We have just built new OpenVox Server packages!

We want to give people some time to test them before we publish them to our official repositories.  You can download them from [artifacts.voxpupuli.org](https://artifacts.voxpupuli.org/openvox-server/8.12.0-0.1SNAPSHOT.2026.01.04T0557/).

The changelog:

* Java 11 support has been removed, and either Java 17 or Java 21 must be used.
* Removes Janino support. Logback removed support for it due to CVEs. This means that logbook evaluator filters are no longer supported. These were not commonly used so unless you specifically included <evaluator> tags in your logback config, you should not be affected.
* Also due to the removal of Janino, Trapperkeeper’s `post-config-script` option for injecting Java code directly into Jetty for controlling low-level Jetty settings that are not exposed by Trapperkeeper is no longer supported. This is also a feature not commonly used, and was a potential security risk in itself.
* This version of openvox-server and all related components have now been migrated to the org.openvoxproject namespace and are available on Clojars, with fixed up testing and release workflows.
* The following third-party components were updated to address CVEs:
    * JRuby 9.4.8.0 -> 9.4.12.1: [CVE-2025-46551](https://nvd.nist.gov/vuln/detail/CVE-2025-46551) / [GHSA-72qj-48g4-5xgx](https://github.com/advisories/GHSA-72qj-48g4-5xgx)
    * Jetty 10.0.20 -> 10.0.26: [CVE-2025-5115](https://nvd.nist.gov/vuln/detail/CVE-2025-5115) / [GHSA-mmxm-8w33-wc4h](https://github.com/advisories/GHSA-mmxm-8w33-wc4h), [CVE-2024-8184](https://nvd.nist.gov/vuln/detail/CVE-2024-8184) / [GHSA-g8m5-722r-8whq](https://github.com/advisories/GHSA-g8m5-722r-8whq)
    * jackson-databind 2.14.0 -> 2.15.4: [CVE-2025-52999](https://nvd.nist.gov/vuln/detail/CVE-2025-52999) / [GHSA-h46c-h94j-95f3](https://github.com/advisories/GHSA-h46c-h94j-95f3)
    * logback 1.3.14 -> 1.3.16: [CVE-2024-12798](https://nvd.nist.gov/vuln/detail/CVE-2024-12798), [CVE-2024-12801](https://nvd.nist.gov/vuln/detail/CVE-2024-12801), [CVE-2025-11226](https://nvd.nist.gov/vuln/detail/CVE-2025-11226)
    * commons-beanutils 1.9.4 -> 1.11.0: [CVE-2025-48734](https://nvd.nist.gov/vuln/detail/CVE-2025-48734)
    * Bouncy Castle non-FIPS 1.78.1 -> 1.83: [CVE-2025-8916](https://nvd.nist.gov/vuln/detail/CVE-2025-8916)
* Additionally, these are not currently used, but will be shortly once we release a FIPS-compliant version of the server:
    * bcpkix-fips 1.0.7 -> 1.0.8: [CVE-2025-8916](https://nvd.nist.gov/vuln/detail/CVE-2025-8916)
    * bc-fips 1.0.2.5 -> 1.0.2.6: [CVE-2025-8885](https://nvd.nist.gov/vuln/detail/CVE-2025-8885)

To test it, you can simply download the SNAPSHOT package and upgrade your existing installation.
If you want to try it on a new box, you will have to add our usual repos from [apt.voxpupuli.org](https://apt.voxpupuli.org/) or [yum.voxpupuli.org](https://yum.voxpupuli.org/).
That's required because the server package depends on the agent package.

If you find any bugs or want to contribute, please come to our [#openvox](https://voxpupuli.org/connect/) channel on IRC or slack.

We plan to move the packages to the official repos on 2026-01-12.
