---
layout: post
title: New OpenVox-Server release!
date: 2026-01-16
github_username: bastelfreak
---

OpenVox-Server 8.12.0 got released!

After [our testing period](https://voxpupuli.org/blog/2026/01/05/new-openvoxserver-beta-packages/) and the [FIPS openvox-agent release](https://voxpupuli.org/blog/2026/01/13/new-fips-agent-packages/), our new OpenVox-Server is available!

This version represents a significant change in how openvox-server is built. Most of this is under the hood, but should lower the bar to development and allow us to make changes more easily and rapidly.

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
    * JRuby 9.4.8.0 -> 9.4.12.1: [CVE-2025-46551](https://nvd.nist.gov/vuln/detail/CVE-2025-46551) / [GHSA-72qj-48g4-5xgx](https://github.com/advisories/GHSA-72qj-48g4-5xgx)
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
* We added PrivateTmp=true to the systemd unit. This is a best practice since years, and [theforeman/puppet](https://github.com/theforeman/puppet-puppet/blob/master/manifests/server/puppetserver.pp#L239-L245) does that since years. The next OpenVoxDB release will contain the same change.

A big thank you to Nick Burgan and Overlook InfraTech for all the work and the FIPS support!

**Please provide feedback! Let us know if you used the beta period & if we should adjust it in the future. If you find any bugs or want to contribute, please come to our [#openvox](https://voxpupuli.org/connect/) channel on IRC or slack.**

## What's Changed
### New Features 🎉

* Add Ruby 4.0 support by @bastelfreak in https://github.com/OpenVoxProject/openvox-server/pull/107
    * Note: This is for testing future Ruby 4 support. OpenVox 8 still relies on Ruby 3.2 and the shipped JRuby in OpenVox-Server is still MRI Ruby 3.1 compatible.
* lein-parent: Update 0.3.7->0.3.9 by @bastelfreak in https://github.com/OpenVoxProject/openvox-server/pull/108
* Update dependencies by @nmburgan in https://github.com/OpenVoxProject/openvox-server/pull/105
* Add Ubuntu 25.10 support by @bastelfreak in https://github.com/OpenVoxProject/openvox-server/pull/138
    * Note: This is for test builds, and not part of the officially supported set of platforms for OpenVox at this time.

### Bug Fixes 🐛

* remove stale dependencies and imports by @corporate-gadfly in https://github.com/OpenVoxProject/openvox-server/pull/106

### Dependency Updates ⬆️

* Update dependency lein-pprint:lein-pprint to v1.3.2 by @renovate[bot] in https://github.com/OpenVoxProject/openvox-server/pull/77
* Update dependency lambdaisland:uri to v1.19.155 by @renovate[bot] in https://github.com/OpenVoxProject/openvox-server/pull/76
* Update dependency jonase:eastwood to v1.4.3 by @renovate[bot] in https://github.com/OpenVoxProject/openvox-server/pull/72
* Update dependency pjstadig:humane-test-output to v0.11.0 by @renovate[bot] in https://github.com/OpenVoxProject/openvox-server/pull/78
* Chore(deps): Update public_suffix requirement from >= 4.0.7, < 7 to >= 4.0.7, < 8 by @dependabot[bot] in https://github.com/OpenVoxProject/openvox-server/pull/95
* Update dependency org.ow2.asm:asm to v9.9.1 by @renovate[bot] in https://github.com/OpenVoxProject/openvox-server/pull/123
* Update dependency org.apache.commons:commons-exec to v1.6.0 by @renovate[bot] in https://github.com/OpenVoxProject/openvox-server/pull/121
* Update dependency clj-time:clj-time to v0.15.2 by @renovate[bot] in https://github.com/OpenVoxProject/openvox-server/pull/117
* Update dependency io.dropwizard.metrics:metrics-core to v3.2.6 by @renovate[bot] in https://github.com/OpenVoxProject/openvox-server/pull/116
* Update dependency commons-codec:commons-codec to v1.20.0 by @renovate[bot] in https://github.com/OpenVoxProject/openvox-server/pull/118
* Update dependency commons-io:commons-io to v2.21.0 by @renovate[bot] in https://github.com/OpenVoxProject/openvox-server/pull/119
* Update all the openvoxproject clojure libs by @renovate[bot] in https://github.com/OpenVoxProject/openvox-server/pull/125
* chore(deps): update dependency org.openvoxproject:clj-shell-utils to v2.1.1 by @renovate[bot] in https://github.com/OpenVoxProject/openvox-server/pull/140
* chore(deps): update dependency org.openvoxproject:trapperkeeper-scheduler to v1.3.1 by @renovate[bot] in https://github.com/OpenVoxProject/openvox-server/pull/153
* chore(deps): update dependency org.openvoxproject:trapperkeeper-webserver-jetty10 to v1.1.2 by @renovate[bot] in https://github.com/OpenVoxProject/openvox-server/pull/154
* chore(deps): update dependency org.openvoxproject:trapperkeeper-authorization to v2.1.4 by @renovate[bot] in https://github.com/OpenVoxProject/openvox-server/pull/151
* chore(deps): update dependency org.openvoxproject:trapperkeeper-metrics to v2.1.3 by @renovate[bot] in https://github.com/OpenVoxProject/openvox-server/pull/152
* chore(deps): update dependency org.openvoxproject:dujour-version-check to v1.1.1 by @renovate[bot] in https://github.com/OpenVoxProject/openvox-server/pull/142
* chore(deps): update dependency org.openvoxproject:rbac-client to v1.2.2 by @renovate[bot] in https://github.com/OpenVoxProject/openvox-server/pull/147
* chore(deps): update dependency ring-basic-authentication:ring-basic-authentication to v1.2.0 by @renovate[bot] in https://github.com/OpenVoxProject/openvox-server/pull/126
* chore(deps): update dependency org.openvoxproject:kitchensink to v3.5.5 by @renovate[bot] in https://github.com/OpenVoxProject/openvox-server/pull/146
* chore(deps): update dependency net.logstash.logback:logstash-logback-encoder to v7.4 by @renovate[bot] in https://github.com/OpenVoxProject/openvox-server/pull/120
* chore(deps): update dependency org.yaml:snakeyaml to v2.5 by @renovate[bot] in https://github.com/OpenVoxProject/openvox-server/pull/124
* chore(deps): update dependency ring:ring-mock to v0.6.2 - autoclosed by @renovate[bot] in https://github.com/OpenVoxProject/openvox-server/pull/129
* chore(deps): update dependency ring:ring-codec to v1.3.0 by @renovate[bot] in https://github.com/OpenVoxProject/openvox-server/pull/127
* chore(deps): update dependency ring:ring-core to v1.15.3 by @renovate[bot] in https://github.com/OpenVoxProject/openvox-server/pull/128
* chore(deps): update dependency org.clojure:tools.namespace to v0.3.1 by @renovate[bot] in https://github.com/OpenVoxProject/openvox-server/pull/122
* chore(deps): update dependency org.openvoxproject:trapperkeeper-comidi-metrics to v1.0.2 by @renovate[bot] in https://github.com/OpenVoxProject/openvox-server/pull/161
* chore(deps): update dependency org.clojure:tools.reader to v1.6.0 by @renovate[bot] in https://github.com/OpenVoxProject/openvox-server/pull/162
* chore(deps): update dependency org.openvoxproject:trapperkeeper-comidi-metrics to v1.0.3 by @renovate[bot] in https://github.com/OpenVoxProject/openvox-server/pull/163
* chore(deps): update dependency org.openvoxproject:trapperkeeper-metrics to v2.1.6 by @renovate[bot] in https://github.com/OpenVoxProject/openvox-server/pull/164

### Other Changes

* (maint) Drop beaker parameters from beaker_acceptance.yml call by @jpartlow in https://github.com/OpenVoxProject/openvox-server/pull/93
* Update gem lists by @nmburgan in https://github.com/OpenVoxProject/openvox-server/pull/99
* Change namespace, update versions, update build task by @nmburgan in https://github.com/OpenVoxProject/openvox-server/pull/101
* Remove testing Java 11 on el8 by @nmburgan in https://github.com/OpenVoxProject/openvox-server/pull/104
* Remove clj-parent by @nmburgan in https://github.com/OpenVoxProject/openvox-server/pull/114
* Add logback version check by @nmburgan in https://github.com/OpenVoxProject/openvox-server/pull/139
* Move versions into managed deps and update openvox components by @nmburgan in https://github.com/OpenVoxProject/openvox-server/pull/158
* Changes for FIPS by @nmburgan in https://github.com/OpenVoxProject/openvox-server/pull/112
* Change how we define the version by @nmburgan in https://github.com/OpenVoxProject/openvox-server/pull/166
* Update build task to handle building FIPS by @nmburgan in https://github.com/OpenVoxProject/openvox-server/pull/165
* Add FIPS-only build by @nmburgan in https://github.com/OpenVoxProject/openvox-server/pull/167
* More changes for FIPS builds by @nmburgan in https://github.com/OpenVoxProject/openvox-server/pull/168
* split_external_cas test: don't use /tmp by @nmburgan in https://github.com/OpenVoxProject/openvox-server/pull/169
* client_may_use_external_cert_chains test: don't use /tmp by @nmburgan in https://github.com/OpenVoxProject/openvox-server/pull/170

## New Contributors

* @corporate-gadfly made their first contribution in https://github.com/OpenVoxProject/openvox-server/pull/106
