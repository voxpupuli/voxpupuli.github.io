---
date: 2026-09-10
github_username: bastelfreak
layout: post
title: New openvox-server, openvoxdb & openvox-agent releases!
---

We are pleased to announce a new round of releases! openvox-agent 8.29.0, 9.0.0-rc1, openvox-server 8.16.0, openvoxdb 8.16.0!
We also start with release candidates for openvox 9 and want to ship the final builds this month.
On the agent side, we made some OpenSSL updates to fix CVEs, made performance improvements and fixed a bug in the pacman package provider.
The openvoxdb/server 9 packages now use `Type=notify` or `Type=notify-reload`.
The latter requires systemd 253, which isn't supported by older distributions.
With those changes, the services will now inform systemd when they are fully started.
And they will be started with the correct java bin path.
The packages depend on JRE 25, or if not available, JRE 21.
The JRE path is used in the systemd unit.
The older environment variable `JAVA_BIN` from `/etc/{default,sysconfig}/puppet{db,server}` isn't used anymore and users don't need to deal with it.


## What's Changed in openvox-agent 8.29.0

### Security issues resolved

| Identifier     | CVSS 3.1 Score | Resolved By                       |
| :------------- | :------------: | :-------------------------------- |
| CVE-2026-75803 |       9.1      | pkg:github/openssl/openssl@3.0.22 |
| CVE-2026-63076 |       7.5      | pkg:github/openssl/openssl@3.0.22 |
| CVE-2026-63072 |       7.5      | pkg:github/openssl/openssl@3.0.22 |
| CVE-2026-54874 |       7.5      | pkg:github/openssl/openssl@3.0.22 |
| CVE-2026-63074 |       5.9      | pkg:github/openssl/openssl@3.0.22 |

### New Features 🎉

* openfact: Allow 6.x by @bastelfreak in https://github.com/OpenVoxProject/openvox/pull/578

### Bug Fixes 🐛

* [Backport 8.x] fix: Pacman provider uses unrecognized option '--update' by @OpenVoxProjectBot in https://github.com/OpenVoxProject/openvox/pull/565
* [Backport 8.x] Report errors when renewing a certificate fails by @OpenVoxProjectBot in https://github.com/OpenVoxProject/openvox/pull/611
* [Backport 8.x] Fix excessive reads of /proc/mounts by @OpenVoxProjectBot in https://github.com/OpenVoxProject/openvox/pull/621

### Other Changes

* [Backport 8.x] Set `PUPPET_EXTRA_OPTS` variable to empty by @OpenVoxProjectBot in https://github.com/OpenVoxProject/openvox/pull/561
* Remove unloadable CC-BY-1.0 RDoc template and generator by @silug in https://github.com/OpenVoxProject/openvox/pull/588
* [Backport 8.x] Fix a small typo in the markdown docs (redux) by @OpenVoxProjectBot in https://github.com/OpenVoxProject/openvox/pull/606
* [Backport 8.x] puppet generate: print module directory when types are missing by @OpenVoxProjectBot in https://github.com/OpenVoxProject/openvox/pull/618
* Promote puppet-runtime 2026.09.02.1 into 8.x by @OpenVoxProjectBot in https://github.com/OpenVoxProject/openvox/pull/629

**Full Changelog**: https://github.com/OpenVoxProject/openvox/compare/8.28.1...8.29.0

## What's changed in openvox-agent 9.0.0-rc1

### Security issues resolved

| Identifier     | CVSS 3.1 Score | Resolved By                      |
| :------------- | :------------: | :------------------------------- |
| CVE-2026-63073 |       9.8      | pkg:github/openssl/openssl@3.5.8 |
| CVE-2026-75803 |       9.1      | pkg:github/openssl/openssl@3.5.8 |
| CVE-2026-18798 |       7.5      | pkg:github/openssl/openssl@3.5.8 |
| CVE-2026-63076 |       7.5      | pkg:github/openssl/openssl@3.5.8 |
| CVE-2026-14457 |       7.5      | pkg:github/openssl/openssl@3.5.8 |
| CVE-2026-14456 |       7.5      | pkg:github/openssl/openssl@3.5.8 |
| CVE-2026-63072 |       7.5      | pkg:github/openssl/openssl@3.5.8 |
| CVE-2026-54874 |       7.5      | pkg:github/openssl/openssl@3.5.8 |
| CVE-2026-63075 |       7.5      | pkg:github/openssl/openssl@3.5.8 |
| CVE-2026-63074 |       5.9      | pkg:github/openssl/openssl@3.5.8 |

### Breaking Changes 🛠

* refactor(service/systemd): remove Debian SysVInit compatibility fallback by @TheMeier in https://github.com/OpenVoxProject/openvox/pull/562
* raise ArgumentError for root when server is unset by @corporate-gadfly in https://github.com/OpenVoxProject/openvox/pull/623

### New Features 🎉

* rubocop: cleanup formatting and whitespace by @bastelfreak in https://github.com/OpenVoxProject/openvox/pull/594
* feat: add multi platform builds by @rwaffen in https://github.com/OpenVoxProject/openvox/pull/607

### Bug Fixes 🐛

* Report errors when renewing a certificate fails by @jay7x in https://github.com/OpenVoxProject/openvox/pull/610
* puppet generate: print module directory when types are missing by @Sharpie in https://github.com/OpenVoxProject/openvox/pull/617
* Fix excessive reads of /proc/mounts by @jenxie in https://github.com/OpenVoxProject/openvox/pull/620

### Dependency Updates ⬆️

* Update rdoc requirement from ~> 6.0, < 6.4.0 to ~> 8.0 by @dependabot[bot] in https://github.com/OpenVoxProject/openvox/pull/510
* Update rubocop requirement from ~> 1.88.2 to ~> 1.89.0 by @dependabot[bot] in https://github.com/OpenVoxProject/openvox/pull/601
* Update rubocop requirement from ~> 1.89.0 to ~> 1.90.0 by @dependabot[bot] in https://github.com/OpenVoxProject/openvox/pull/622

### Other Changes

* Request report storage explicitly in cached-catalog drift test by @silug in https://github.com/OpenVoxProject/openvox/pull/598
* Update filebucket content acceptance tests for literal checksum semantics by @silug in https://github.com/OpenVoxProject/openvox/pull/602
* Compare facterversion against installed facter in acceptance test by @silug in https://github.com/OpenVoxProject/openvox/pull/597
* Migrate lookup acceptance tests to Hiera 5 data providers by @silug in https://github.com/OpenVoxProject/openvox/pull/596
* Fix a small typo in the markdown docs (redux) by @jcharaoui in https://github.com/OpenVoxProject/openvox/pull/603
* fix links to point to docs.openvoxproject.org by @corporate-gadfly in https://github.com/OpenVoxProject/openvox/pull/609
* puppet node: redeclare to identical values is a `notice` not a warning. by @jcpunk in https://github.com/OpenVoxProject/openvox/pull/626
* Promote puppet-runtime 2026.09.02.1 into main by @OpenVoxProjectBot in https://github.com/OpenVoxProject/openvox/pull/628

## New Contributors

* @TheMeier made their first contribution in https://github.com/OpenVoxProject/openvox/pull/562
* @jenxie made their first contribution in https://github.com/OpenVoxProject/openvox/pull/620
* @jcpunk made their first contribution in https://github.com/OpenVoxProject/openvox/pull/626

**Full Changelog**: https://github.com/OpenVoxProject/openvox/compare/9.0.0-beta2...9.0.0-rc1

## What's Changed in openvox-server 9.0.0-rc1

### Breaking Changes 🛠

* Update to EZbake 4.1.0 by @Sharpie in https://github.com/OpenVoxProject/openvox-server/pull/628

### New Features 🎉

* packages: depend on openvox-agent >= 9.0.0~rc1 by @bastelfreak in https://github.com/OpenVoxProject/openvox-server/pull/624

### Bug Fixes 🐛

* Revert "Inform trapperkeeper about service readiness" by @bastelfreak in https://github.com/OpenVoxProject/openvox-server/pull/610
* Use StandardErrorLogger for ruby subcommands by @Sharpie in https://github.com/OpenVoxProject/openvox-server/pull/614
* Add missing JRuby security flags for Java 21+ by @corporate-gadfly in https://github.com/OpenVoxProject/openvox-server/pull/613

### Dependency Updates ⬆️

* Update jackson updates to v2.21.6 (main) by @renovate[bot] in https://github.com/OpenVoxProject/openvox-server/pull/601
* Update logback-version to v1.6.3 (main) by @renovate[bot] in https://github.com/OpenVoxProject/openvox-server/pull/602
* Update dependency ch.qos.logback.access:logback-access-common to v2.0.15 (main) by @renovate[bot] in https://github.com/OpenVoxProject/openvox-server/pull/598
* Update dependency ch.qos.logback.access:logback-access-jetty12 to v2.0.15 (main) by @renovate[bot] in https://github.com/OpenVoxProject/openvox-server/pull/599
* Update dependency org.openvoxproject:jruby-utils to v7.0.3 (main) by @renovate[bot] in https://github.com/OpenVoxProject/openvox-server/pull/611
* Update dependency org.clojure:clojure to v1.12.6 (main) by @renovate[bot] in https://github.com/OpenVoxProject/openvox-server/pull/618
* Update dependency org.openvoxproject:trapperkeeper to v5.0.6 (main) by @renovate[bot] in https://github.com/OpenVoxProject/openvox-server/pull/620
* Update slf4j-version to v2.0.19 (main) by @renovate[bot] in https://github.com/OpenVoxProject/openvox-server/pull/622
* Update dependency org.yaml:snakeyaml to v2.7 (main) by @renovate[bot] in https://github.com/OpenVoxProject/openvox-server/pull/616

### Other Changes

* Clean up obsolete Slf4jLogger configuration by @Sharpie in https://github.com/OpenVoxProject/openvox-server/pull/629

**Full Changelog**: https://github.com/OpenVoxProject/openvox-server/compare/9.0.0-beta5...9.0.0-rc1

## What's Changed in openvox-server 8.16.0

### New Features 🎉

* packages: depend on openvox-agent >= 8.29.0 by @bastelfreak in https://github.com/OpenVoxProject/openvox-server/pull/625

### Dependency Updates ⬆️

* Update logback-version to v1.6.0 (8.x) by @renovate[bot] in https://github.com/OpenVoxProject/openvox-server/pull/529
* Update dependency ch.qos.logback.access:logback-access-common to v2.0.14 (8.x) by @renovate[bot] in https://github.com/OpenVoxProject/openvox-server/pull/524
* Update dependency ch.qos.logback.access:logback-access-jetty12 to v2.0.14 (8.x) by @renovate[bot] in https://github.com/OpenVoxProject/openvox-server/pull/526
* Update logback-version to v1.6.1 (8.x) by @renovate[bot] in https://github.com/OpenVoxProject/openvox-server/pull/541
* Update dependency commons-codec:commons-codec to v1.22.1 (8.x) by @renovate[bot] in https://github.com/OpenVoxProject/openvox-server/pull/543
* Update dependency openvoxserver-ca to v3.3.0 (8.x) by @renovate[bot] in https://github.com/OpenVoxProject/openvox-server/pull/547
* Update dependency prismatic:schema to v1.4.2 (8.x) by @renovate[bot] in https://github.com/OpenVoxProject/openvox-server/pull/570
* Update logback-version to v1.6.2 (8.x) by @renovate[bot] in https://github.com/OpenVoxProject/openvox-server/pull/571
* Update dependency org.openvoxproject:trapperkeeper-webserver to v12.1.1 (8.x) by @renovate[bot] in https://github.com/OpenVoxProject/openvox-server/pull/591
* Update dependency org.openvoxproject:trapperkeeper-scheduler to v1.4.1 (8.x) by @renovate[bot] in https://github.com/OpenVoxProject/openvox-server/pull/590
* Update dependency org.openvoxproject:trapperkeeper-filesystem-watcher to v1.6.1 (8.x) by @renovate[bot] in https://github.com/OpenVoxProject/openvox-server/pull/588
* Update dependency org.openvoxproject:ssl-utils to v3.7.1 (8.x) by @renovate[bot] in https://github.com/OpenVoxProject/openvox-server/pull/585
* Update dependency org.openvoxproject:comidi to v1.1.4 (8.x) by @renovate[bot] in https://github.com/OpenVoxProject/openvox-server/pull/582
* Update dependency org.openvoxproject:i18n to v1.0.5 (8.x) by @renovate[bot] in https://github.com/OpenVoxProject/openvox-server/pull/568
* Update dependency org.openvoxproject:kitchensink to v3.5.8 (8.x) by @renovate[bot] in https://github.com/OpenVoxProject/openvox-server/pull/569
* Update dependency org.openvoxproject:clj-shell-utils to v2.2.1 (8.x) by @renovate[bot] in https://github.com/OpenVoxProject/openvox-server/pull/581
* Update dependency org.openvoxproject:http-client to v2.4.1 (8.x) by @renovate[bot] in https://github.com/OpenVoxProject/openvox-server/pull/583
* Update dependency org.openvoxproject:trapperkeeper to v5.0.5 (8.x) by @renovate[bot] in https://github.com/OpenVoxProject/openvox-server/pull/586
* Update dependency org.openvoxproject:ring-middleware to v2.2.1 (8.x) by @renovate[bot] in https://github.com/OpenVoxProject/openvox-server/pull/584
* Update dependency org.openvoxproject:trapperkeeper-authorization to v2.4.1 (8.x) by @renovate[bot] in https://github.com/OpenVoxProject/openvox-server/pull/587
* Update dependency org.openvoxproject:trapperkeeper-metrics to v2.3.2 (8.x) by @renovate[bot] in https://github.com/OpenVoxProject/openvox-server/pull/589
* Update dependency org.openvoxproject:trapperkeeper-status to v1.5.1 (8.x) by @renovate[bot] in https://github.com/OpenVoxProject/openvox-server/pull/595
* Update dependency org.openvoxproject:trapperkeeper-comidi-metrics to v1.1.1 (8.x) by @renovate[bot] in https://github.com/OpenVoxProject/openvox-server/pull/594
* Update dependency ch.qos.logback.access:logback-access-jetty12 to v2.0.15 (8.x) by @renovate[bot] in https://github.com/OpenVoxProject/openvox-server/pull/604
* Update dependency ch.qos.logback.access:logback-access-common to v2.0.15 (8.x) by @renovate[bot] in https://github.com/OpenVoxProject/openvox-server/pull/603
* Update logback-version to v1.6.3 (8.x) by @renovate[bot] in https://github.com/OpenVoxProject/openvox-server/pull/606
* Update jackson updates to v2.21.6 (8.x) by @renovate[bot] in https://github.com/OpenVoxProject/openvox-server/pull/605
* Update dependency org.clojure:clojure to v1.12.6 (8.x) by @renovate[bot] in https://github.com/OpenVoxProject/openvox-server/pull/619
* Update dependency org.openvoxproject:trapperkeeper to v5.0.6 (8.x) by @renovate[bot] in https://github.com/OpenVoxProject/openvox-server/pull/621
* Update slf4j-version to v2.0.19 (8.x) by @renovate[bot] in https://github.com/OpenVoxProject/openvox-server/pull/623
* Update dependency concurrent-ruby to v1.3.8 (8.x) by @renovate[bot] in https://github.com/OpenVoxProject/openvox-server/pull/498
* Update dependency org.yaml:snakeyaml to v2.7 (8.x) by @renovate[bot] in https://github.com/OpenVoxProject/openvox-server/pull/617

### Other Changes

* [Backport 8.x] Revert "Inform trapperkeeper about service readiness" by @Sharpie in https://github.com/OpenVoxProject/openvox-server/pull/615

**Full Changelog**: https://github.com/OpenVoxProject/openvox-server/compare/8.15.2...8.16.0

<!-- Release notes generated using configuration in .github/release.yml at 9.0.0-rc1 -->

## What's Changed in openvoxdb 9.0.0-rc1

### Breaking Changes 🛠

* Depend on openvox-agent >=9.0.0~beta1 by @Sharpie in https://github.com/OpenVoxProject/openvoxdb/pull/416
* Rebrand PuppetDB -> OpenVoxDB in docs and comments by @silug in https://github.com/OpenVoxProject/openvoxdb/pull/452
* Update EZbake version to 4.1.0 by @Sharpie in https://github.com/OpenVoxProject/openvoxdb/pull/518

### New Features 🎉

* Add configuration options to filter facts out in OpenVoxDB termini by @djuarezg in https://github.com/OpenVoxProject/openvoxdb/pull/502

### Bug Fixes 🐛

* Fix report_environment join deps for certname extract by @corporate-gadfly in https://github.com/OpenVoxProject/openvoxdb/pull/501

### Dependency Updates ⬆️

* Update dependency org.openvoxproject:ssl-utils to v3.7.0 (main) by @renovate[bot] in https://github.com/OpenVoxProject/openvoxdb/pull/418
* Update dependency org.bouncycastle:bcpkix-jdk18on to v1.85 (main) by @renovate[bot] in https://github.com/OpenVoxProject/openvoxdb/pull/395
* Update dependency org.openvoxproject:http-client to v2.4.0 (main) by @renovate[bot] in https://github.com/OpenVoxProject/openvoxdb/pull/420
* Update dependency org.openvoxproject:trapperkeeper-webserver to v12.1.0 (main) by @renovate[bot] in https://github.com/OpenVoxProject/openvoxdb/pull/422
* Update dependency org.openvoxproject:trapperkeeper-authorization to v2.4.0 (main) by @renovate[bot] in https://github.com/OpenVoxProject/openvoxdb/pull/421
* Update dependency com.taoensso:nippy to v3.7.0 (main) by @renovate[bot] in https://github.com/OpenVoxProject/openvoxdb/pull/429
* Update dependency clj-kondo:clj-kondo to v2026.07.24 (main) by @renovate[bot] in https://github.com/OpenVoxProject/openvoxdb/pull/433
* Update dependency com.github.seancorfield:honeysql to v2.7.1425 (main) by @renovate[bot] in https://github.com/OpenVoxProject/openvoxdb/pull/438
* Update dependency com.taoensso:nippy to v3.8.0 (main) by @renovate[bot] in https://github.com/OpenVoxProject/openvoxdb/pull/439
* Update logback-version to v1.6.0 (main) by @renovate[bot] in https://github.com/OpenVoxProject/openvoxdb/pull/434
* Update dependency com.taoensso:nippy to v3.8.1 (main) by @renovate[bot] in https://github.com/OpenVoxProject/openvoxdb/pull/444
* Update logback-version to v1.6.1 (main) by @renovate[bot] in https://github.com/OpenVoxProject/openvoxdb/pull/445
* Update dependency commons-codec:commons-codec to v1.22.1 (main) by @renovate[bot] in https://github.com/OpenVoxProject/openvoxdb/pull/448
* Update dependency com.github.seancorfield:honeysql to v2.7.1437 (main) by @renovate[bot] in https://github.com/OpenVoxProject/openvoxdb/pull/455
* Update dependency clj-kondo:clj-kondo to v2026.08.04 (main) by @renovate[bot] in https://github.com/OpenVoxProject/openvoxdb/pull/456
* Update dependency org.openvoxproject:trapperkeeper-webserver to v12.1.1 (main) by @renovate[bot] in https://github.com/OpenVoxProject/openvoxdb/pull/472
* Update dependency org.openvoxproject:i18n to v1.0.5 (main) by @renovate[bot] in https://github.com/OpenVoxProject/openvoxdb/pull/464
* Update dependency org.openvoxproject:http-client to v2.4.1 (main) by @renovate[bot] in https://github.com/OpenVoxProject/openvoxdb/pull/463
* Update dependency org.openvoxproject:kitchensink to v3.5.8 (main) by @renovate[bot] in https://github.com/OpenVoxProject/openvoxdb/pull/465
* Update dependency org.openvoxproject:ssl-utils to v3.7.1 (main) by @renovate[bot] in https://github.com/OpenVoxProject/openvoxdb/pull/467
* Update dependency org.openvoxproject:trapperkeeper-authorization to v2.4.1 (main) by @renovate[bot] in https://github.com/OpenVoxProject/openvoxdb/pull/469
* Update logback-version to v1.6.2 (main) by @renovate[bot] in https://github.com/OpenVoxProject/openvoxdb/pull/474
* Update dependency prismatic:schema to v1.4.2 (main) by @renovate[bot] in https://github.com/OpenVoxProject/openvoxdb/pull/473
* Update dependency org.openvoxproject:trapperkeeper-metrics to v2.3.1 (main) by @renovate[bot] in https://github.com/OpenVoxProject/openvoxdb/pull/471
* Update dependency org.openvoxproject:ring-middleware to v2.2.1 (main) by @renovate[bot] in https://github.com/OpenVoxProject/openvoxdb/pull/466
* Update dependency org.openvoxproject:trapperkeeper to v5.0.5 (main) by @renovate[bot] in https://github.com/OpenVoxProject/openvoxdb/pull/468
* Update dependency org.openvoxproject:comidi to v1.1.4 (main) by @renovate[bot] in https://github.com/OpenVoxProject/openvoxdb/pull/462
* Update dependency org.openvoxproject:trapperkeeper-status to v1.5.1 (main) by @renovate[bot] in https://github.com/OpenVoxProject/openvoxdb/pull/488
* Update dependency org.openvoxproject:trapperkeeper-filesystem-watcher to v1.6.1 (main) by @renovate[bot] in https://github.com/OpenVoxProject/openvoxdb/pull/470
* Update dependency org.openvoxproject:trapperkeeper-metrics to v2.3.2 (main) by @renovate[bot] in https://github.com/OpenVoxProject/openvoxdb/pull/491
* Update dependency org.openvoxproject:structured-logging to v1.0.3 (main) by @renovate[bot] in https://github.com/OpenVoxProject/openvoxdb/pull/493
* Update dependency org.openvoxproject:stockpile to v1.0.3 (main) by @renovate[bot] in https://github.com/OpenVoxProject/openvoxdb/pull/492
* Update jackson updates to v2.21.6 (main) by @renovate[bot] in https://github.com/OpenVoxProject/openvoxdb/pull/496
* Update logback-version to v1.6.3 (main) by @renovate[bot] in https://github.com/OpenVoxProject/openvoxdb/pull/497
* Update dependency org.clojure:clojure to v1.12.6 (main) by @renovate[bot] in https://github.com/OpenVoxProject/openvoxdb/pull/508
* Update dependency org.openvoxproject:trapperkeeper to v5.0.6 (main) by @renovate[bot] in https://github.com/OpenVoxProject/openvoxdb/pull/510
* Update slf4j-version to v2.0.19 (main) by @renovate[bot] in https://github.com/OpenVoxProject/openvoxdb/pull/512
* Update dependency org.yaml:snakeyaml to v2.7 (main) by @renovate[bot] in https://github.com/OpenVoxProject/openvoxdb/pull/506
* Update dependency com.taoensso:nippy to v3.9.0 (main) by @renovate[bot] in https://github.com/OpenVoxProject/openvoxdb/pull/516

### Other Changes

* prep for clj-kondo bump to 2026.07.24 by @corporate-gadfly in https://github.com/OpenVoxProject/openvoxdb/pull/437
* Clarify descriptions of FIPS build workflow inputs by @Sharpie in https://github.com/OpenVoxProject/openvoxdb/pull/431
* fix: match pre-release tarballs by base version on upload by @slauger in https://github.com/OpenVoxProject/openvoxdb/pull/459
* leiningen: version bump 2.11.2->2.12.0 by @corporate-gadfly in https://github.com/OpenVoxProject/openvoxdb/pull/490
* CI: Update to Ruby 4.0 by @bastelfreak in https://github.com/OpenVoxProject/openvoxdb/pull/326

## New Contributors

* @silug made their first contribution in https://github.com/OpenVoxProject/openvoxdb/pull/452
* @djuarezg made their first contribution in https://github.com/OpenVoxProject/openvoxdb/pull/502

**Full Changelog**: https://github.com/OpenVoxProject/openvoxdb/compare/9.0.0-beta1...9.0.0-rc1

## What's Changed in openvoxdb 8.16.0

### Dependency Updates ⬆️

* Update dependency com.taoensso:nippy to v3.7.0 (8.x) by @renovate[bot] in https://github.com/OpenVoxProject/openvoxdb/pull/430
* Update dependency clj-kondo:clj-kondo to v2026.07.24 (8.x) by @renovate[bot] in https://github.com/OpenVoxProject/openvoxdb/pull/435
* Update dependency com.github.seancorfield:honeysql to v2.7.1425 (8.x) by @renovate[bot] in https://github.com/OpenVoxProject/openvoxdb/pull/441
* Update dependency com.taoensso:nippy to v3.8.0 (8.x) by @renovate[bot] in https://github.com/OpenVoxProject/openvoxdb/pull/442
* Update logback-version to v1.6.0 (8.x) by @renovate[bot] in https://github.com/OpenVoxProject/openvoxdb/pull/436
* Update logback-version to v1.6.1 (8.x) by @renovate[bot] in https://github.com/OpenVoxProject/openvoxdb/pull/447
* Update dependency com.taoensso:nippy to v3.8.1 (8.x) by @renovate[bot] in https://github.com/OpenVoxProject/openvoxdb/pull/446
* Update dependency commons-codec:commons-codec to v1.22.1 (8.x) by @renovate[bot] in https://github.com/OpenVoxProject/openvoxdb/pull/449
* Update dependency clj-kondo:clj-kondo to v2026.08.04 (8.x) by @renovate[bot] in https://github.com/OpenVoxProject/openvoxdb/pull/461
* Update dependency com.github.seancorfield:honeysql to v2.7.1437 (8.x) by @renovate[bot] in https://github.com/OpenVoxProject/openvoxdb/pull/460
* Update dependency prismatic:schema to v1.4.2 (8.x) by @renovate[bot] in https://github.com/OpenVoxProject/openvoxdb/pull/486
* Update logback-version to v1.6.2 (8.x) by @renovate[bot] in https://github.com/OpenVoxProject/openvoxdb/pull/487
* Update dependency org.openvoxproject:comidi to v1.1.4 (8.x) by @renovate[bot] in https://github.com/OpenVoxProject/openvoxdb/pull/475
* Update dependency org.openvoxproject:trapperkeeper-filesystem-watcher to v1.6.1 (8.x) by @renovate[bot] in https://github.com/OpenVoxProject/openvoxdb/pull/483
* Update dependency org.openvoxproject:trapperkeeper to v5.0.5 (8.x) by @renovate[bot] in https://github.com/OpenVoxProject/openvoxdb/pull/481
* Update dependency org.openvoxproject:ring-middleware to v2.2.1 (8.x) by @renovate[bot] in https://github.com/OpenVoxProject/openvoxdb/pull/479
* Update dependency org.openvoxproject:kitchensink to v3.5.8 (8.x) by @renovate[bot] in https://github.com/OpenVoxProject/openvoxdb/pull/478
* Update dependency org.openvoxproject:i18n to v1.0.5 (8.x) by @renovate[bot] in https://github.com/OpenVoxProject/openvoxdb/pull/477
* Update dependency org.openvoxproject:trapperkeeper-status to v1.5.1 (8.x) by @renovate[bot] in https://github.com/OpenVoxProject/openvoxdb/pull/489
* Update dependency org.openvoxproject:trapperkeeper-authorization to v2.4.1 (8.x) by @renovate[bot] in https://github.com/OpenVoxProject/openvoxdb/pull/482
* Update dependency org.openvoxproject:ssl-utils to v3.7.1 (8.x) by @renovate[bot] in https://github.com/OpenVoxProject/openvoxdb/pull/480
* Update dependency org.openvoxproject:trapperkeeper-metrics to v2.3.2 (8.x) by @renovate[bot] in https://github.com/OpenVoxProject/openvoxdb/pull/484
* Update dependency org.openvoxproject:trapperkeeper-webserver to v12.1.1 (8.x) by @renovate[bot] in https://github.com/OpenVoxProject/openvoxdb/pull/485
* Update dependency org.openvoxproject:http-client to v2.4.1 (8.x) by @renovate[bot] in https://github.com/OpenVoxProject/openvoxdb/pull/476
* Update dependency org.openvoxproject:structured-logging to v1.0.3 (8.x) by @renovate[bot] in https://github.com/OpenVoxProject/openvoxdb/pull/495
* Update dependency org.openvoxproject:stockpile to v1.0.3 (8.x) by @renovate[bot] in https://github.com/OpenVoxProject/openvoxdb/pull/494
* Update logback-version to v1.6.3 (8.x) by @renovate[bot] in https://github.com/OpenVoxProject/openvoxdb/pull/499
* Update jackson updates to v2.21.6 (8.x) by @renovate[bot] in https://github.com/OpenVoxProject/openvoxdb/pull/498
* Update dependency org.clojure:clojure to v1.12.6 (8.x) by @renovate[bot] in https://github.com/OpenVoxProject/openvoxdb/pull/509
* Update slf4j-version to v2.0.19 (8.x) by @renovate[bot] in https://github.com/OpenVoxProject/openvoxdb/pull/513
* Update dependency org.openvoxproject:trapperkeeper to v5.0.6 (8.x) by @renovate[bot] in https://github.com/OpenVoxProject/openvoxdb/pull/511
* Update dependency org.yaml:snakeyaml to v2.7 (8.x) by @renovate[bot] in https://github.com/OpenVoxProject/openvoxdb/pull/507
* Update dependency com.taoensso:nippy to v3.9.0 (8.x) by @renovate[bot] in https://github.com/OpenVoxProject/openvoxdb/pull/517

### Other Changes

* [Backport 8.x] prep for clj-kondo bump to 2026.07.24 by @OpenVoxProjectBot in https://github.com/OpenVoxProject/openvoxdb/pull/440
* [Backport 8.x] reduce average footprint by 20 (upper and lower bound) by @OpenVoxProjectBot in https://github.com/OpenVoxProject/openvoxdb/pull/450
* [Backport 8.x] reduce total footprint by 2000 (upper/lower bound) by @OpenVoxProjectBot in https://github.com/OpenVoxProject/openvoxdb/pull/451
* [Backport 8.x] fix engine tests by @OpenVoxProjectBot in https://github.com/OpenVoxProject/openvoxdb/pull/503
* [Backport 8.x] Fix report_environment join deps for certname extract by @OpenVoxProjectBot in https://github.com/OpenVoxProject/openvoxdb/pull/504
* Release 8.16.0 by @bastelfreak in https://github.com/OpenVoxProject/openvoxdb/pull/515

**Full Changelog**: https://github.com/OpenVoxProject/openvoxdb/compare/8.15.0...8.16.0

**Please provide feedback! If you have questions about, or encounter issues with these releases, reach out in `#openvox` on Slack or `#voxpupuli-openvox` on IRC. See <https://voxpupuli.org/connect/> for details.**
