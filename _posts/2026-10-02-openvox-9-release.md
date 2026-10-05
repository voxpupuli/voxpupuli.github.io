---
layout: post
title: OpenVox 9.0 is here 🎉
date: 2026-10-02
github_username: silug
---

**We have just shipped OpenVox 9.0.0!** This is a platform catch-up, meaning that it updates
all core dependencies to actively maintained versions. If you've been watching the recent flood
of CVEs nervously, this release is just for you.
{: .alert .alert-success }

OpenVox 9 includes `openvox-agent` and `openvoxdb` 9.0.0 and `openvox-server` 9.0.1, along with `openfact` 6.2.1.
(The first `openvox-server` release is 9.0.1 because the 9.0.0 version number was already taken by an artifact published to Clojars by mistake during the beta.)
It also clears out a batch of long-deprecated code, [as we proposed back in April](/blog/2026/04/14/openvox-9-request-for-comments/).
New features are planned for 10.x.

## Release notes and documentation

The full release notes, including bug fixes and the changes in each pre-release, are here:

- `openvox-agent`: [https://github.com/OpenVoxProject/openvox/releases/tag/9.0.0](https://github.com/OpenVoxProject/openvox/releases/tag/9.0.0)
- `openvox-server`: [https://github.com/OpenVoxProject/openvox-server/releases/tag/9.0.1](https://github.com/OpenVoxProject/openvox-server/releases/tag/9.0.1)
- `openvoxdb`: [https://github.com/OpenVoxProject/openvoxdb/releases/tag/9.0.0](https://github.com/OpenVoxProject/openvoxdb/releases/tag/9.0.0)
- `openfact`: [https://github.com/OpenVoxProject/openfact/releases/tag/6.0.0](https://github.com/OpenVoxProject/openfact/releases/tag/6.0.0) (OpenVox 9.0.0 ships 6.2.1, which adds only bug fixes on top)

The OpenVox 9 documentation is here:

- OpenVox: [https://docs.openvoxproject.org/openvox/9.x/](https://docs.openvoxproject.org/openvox/9.x/)
- OpenVox Server: [https://docs.openvoxproject.org/openvox-server/9.x/](https://docs.openvoxproject.org/openvox-server/9.x/)
- OpenVoxDB: [https://docs.openvoxproject.org/openvoxdb/9.x/](https://docs.openvoxproject.org/openvoxdb/9.x/)

## Getting OpenVox 9

OpenVox 9 packages are published to separate `openvox9` repositories.
To configure these repositories, install the `openvox9-release` package from:

- [https://apt.voxpupuli.org/](https://apt.voxpupuli.org/)
- [https://yum.voxpupuli.org/](https://yum.voxpupuli.org/)

Packages for macOS and Windows can be found at:

- [https://downloads.voxpupuli.org/mac/openvox9/](https://downloads.voxpupuli.org/mac/openvox9/)
- [https://downloads.voxpupuli.org/windows/openvox9/](https://downloads.voxpupuli.org/windows/openvox9/)

If you have been testing the betas or release candidates, a normal package upgrade will take you to the final release.
Pre-releases used a tilde in their version (e.g. `9.0.0~rc4`) so that they sort below the final release.

OpenVox 8 remains available on the `openvox8` repositories. It will continue to receive high-priority and security fixes for at least six months.
OpenVox 8 agents can keep running against OpenVox 9 servers while you upgrade your fleet. You don't have to upgrade all at once.

## Headline changes compared to OpenVox 8

- `openvox-agent` now bundles **Ruby 4.0** (up from Ruby 3.2) and **OpenSSL 3.5 LTS**.
- `openvox-server` now uses **JRuby 10.1**, which is compatible with Ruby 4.0. This is an upgrade from JRuby 9.4, which was compatible with Ruby 3.1.
- `openvox-server` and `openvoxdb` are officially supported and tested on **Java 21 and 25**, and support for Java 17 has been dropped.
    The packages run on Java 25 where the platform provides it, and on Java 21 otherwise.
    The FIPS packages run on **Java 21 only**, because the Bouncy Castle FIPS libraries are certified only up to Java 21.
    The services use an explicit path to the JRE binary, not /usr/bin/java anymore.
- `openvoxdb` is now tested against **PostgreSQL 15, 16, and 18**.
- `openvox-agent` ships **openfact 6**, which removes the `ldapname` fact option and adds deprecation warnings ahead of removals in OpenVox 10.

## Before you upgrade

This is a major release with breaking changes.
Please read the [release notes](#release-notes-and-documentation) in full, in particular the [openvox 9.0.0 release notes](https://github.com/OpenVoxProject/openvox/releases/tag/9.0.0).

## Known issues

### Agent daemon can occasionally hang on "applying configuration"

A small number of users have seen the `puppet agent` daemon stop checking in, leaving a forked `puppet agent: applying configuration` process that never exits ([openvox#485](https://github.com/OpenVoxProject/openvox/issues/485)).
It is rare: the reports so far come from small single-vCPU Linux VMs, where it happened every few days.

The cause is a rare race between Ruby's background DNS lookup threads (which changed in Ruby 3.3 and 3.4) and the `fork` that starts each agent run.
If the fork lands at the wrong moment, the child inherits a locked glibc resolver lock, and every name lookup in that child blocks.
OpenVox 8 (Ruby 3.2) is not affected.

OpenVox 9.0.0 includes several changes that make this much less likely, and ensure the daemon recovers on its own if it does happen:

- The agent no longer does name lookups in the daemon right before forking a run ([openvox#683](https://github.com/OpenVoxProject/openvox/pull/683)), which removes the trigger seen in the reports.
- A run that outlives `runtimeout` is now killed, so the daemon carries on with the next run ([openvox#642](https://github.com/OpenVoxProject/openvox/pull/642), [openvox#643](https://github.com/OpenVoxProject/openvox/pull/643)).
- openfact bounds the fqdn lookup in its hostname resolvers ([openfact#177](https://github.com/OpenVoxProject/openfact/pull/177)).

If you still see this, setting `RUBY_TCP_NO_FAST_FALLBACK=1` in a systemd override for the `puppet` service may reduce how often it happens:

```ini
# systemctl edit puppet
[Service]
Environment=RUBY_TCP_NO_FAST_FALLBACK=1
```

Restarting the `puppet` service does not clean up a child process that is already stuck; it has to be killed with `SIGKILL`.
If you hit this issue on 9.0.0, please add details to [openvox#485](https://github.com/OpenVoxProject/openvox/issues/485).

### FIPS packages ship older Bouncy Castle jars

The FIPS builds of `openvox-server` and `openvoxdb` ship an older set of Bouncy Castle FIPS jars.
The latest Bouncy Castle FIPS 1.x release has a small issue that could cause problems in a very constrained, non-default configuration, so we are not updating to it.
Instead, OpenVox 9.1 will move to the Bouncy Castle FIPS 2.x line, which is the one fully certified for FIPS on Java 21.

## Thank you

OpenVox 9 would not exist without everyone who submitted pull requests, filed bugs, tested pre-releases, and joined the discussions about what should change.
Thank you all!

Special thanks go to the people who carried a large share of the work this cycle, including, but not limited to:

- [Tim Meusel](https://github.com/bastelfreak), for work on nearly every repository: runtime and dependency updates, CI, release PRs, and SBOMs.
- [Charlie Sharpsteen](https://github.com/Sharpie), for work across the server, database, runtime, and build tooling, and for the Great Docs Reset of 2026.
- [Michael Harp](https://github.com/miharp), for an enormous amount of documentation work, including the 9.x docs, and for tracking down the cause of the agent hang described above.
- [Nick Burgan](https://github.com/nmburgan), for building out the release infrastructure, smoke testing, and the Java and FIPS packaging work.
- [Haroon Rafique](https://github.com/corporate-gadfly), for keeping the Clojure side of `openvox-server` and `openvoxdb` healthy, FIPS fixes, and the more secure default `server` setting.
- [Martin Alfke](https://github.com/tuxmea), for bringing large parts of the documentation up to date for OpenVox and OpenFact.
- [Robert Waffen](https://github.com/rwaffen), for rebuilding the container images and adding multi-platform builds.
- [Ben Ford](https://github.com/binford2k), for the getting-started and quickstart guides, docs tooling, and catalog validation in the agent.
- [Jerome Charaoui](https://github.com/jcharaoui), for Debian packaging and reproducibility fixes.
- [Josh Partlow](https://github.com/jpartlow), for arm64 support and other work on the acceptance tests.
- [Austin Blatt](https://github.com/austb), for the Jetty 12 migration.
- [Chris Boot](https://github.com/bootc), for weeks of patient debugging data on [openvox#485](https://github.com/OpenVoxProject/openvox/issues/485).
- [Miranda Streeter](https://github.com/MirandaStreeter), for the container image startup speed improvements.

> *If you have questions about, or encounter issues with these releases, reach out in `#openvox` on Slack or `#voxpupuli-openvox` on IRC.
> See [https://voxpupuli.org/connect/](https://voxpupuli.org/connect/) for details.*
{: .alert .alert-primary }
