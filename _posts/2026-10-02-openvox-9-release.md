---
layout: post
title: OpenVox 9.0 is here 🎉
date: 2026-10-02
github_username: silug
---

<!--
DRAFT. Before publishing:
- Confirm the final versions and that packages are live in all repos (apt, yum, macOS, Windows).
- Confirm the GitHub release tag URLs below resolve.
- Re-check the status of the known issues (openvox#485, and the macOS items commented out below).
-->

**We have just shipped OpenVox 9.0.0: `openvox-agent`, `openvox-server`, and `openvoxdb` 9.0.0, along with `openfact` 6.2.1.**
{: .alert .alert-success }

OpenVox 9 is a platform catch-up release.
It brings the core dependencies up to date and clears out a batch of long-deprecated code, [as we proposed back in April](/blog/2026/04/14/openvox-9-request-for-comments/).
New features are planned for 10.x.

## Getting OpenVox 9

OpenVox 9 packages are published to separate `openvox9` repositories.
To configure these repositories, install the `openvox9-release` package from:

- [https://apt.voxpupuli.org/](https://apt.voxpupuli.org/)
- [https://yum.voxpupuli.org/](https://yum.voxpupuli.org/)

Packages for macOS and Windows can be found at:

- [https://downloads.voxpupuli.org/mac/openvox9/](https://downloads.voxpupuli.org/mac/openvox9/)
- [https://downloads.voxpupuli.org/windows/openvox9/](https://downloads.voxpupuli.org/windows/openvox9/)

If you have been testing the betas or release candidates, a normal package upgrade will take you to 9.0.0.
Pre-releases used a tilde in their version (e.g. `9.0.0~rc4`) so that they sort below the final release.

OpenVox 8 remains supported on the `openvox8` repositories.
OpenVox 9 code is kept compatible with Ruby 3.2, so OpenVox 8 agents can keep running against OpenVox 9 servers while you upgrade your fleet.

## Headline changes compared to OpenVox 8

- `openvox-agent` now bundles **Ruby 4.0** (up from Ruby 3.2) and **OpenSSL 3.5 LTS**.
- `openvox-server` now uses **JRuby 10.1**, which is compatible with Ruby 4.0. This is an upgrade from JRuby 9.4, which was compatible with Ruby 3.1.
- `openvox-server` and `openvoxdb` run on **Java 25**, except on EL 8 where they use Java 21. This is an upgrade from Java 17.
- `openvoxdb` is now tested against **PostgreSQL 17 and 18**, up from PostgreSQL 14.
- `openvox-agent` ships **openfact 6**, which removes the `ldapname` fact option and adds deprecation warnings ahead of removals in OpenVox 10.

## Before you upgrade

This is a major release with breaking changes.
Please read the release notes in full, but these are the ones most likely to affect you:

- **`server` no longer defaults to `puppet`.**
    Agents must set `server`, `server_list`, or use SRV records (`ca_server` and `report_server` also work for their own services).
    An agent running as root with none of these set will fail with an error.
- **The `reports` setting now defaults to `none`** instead of `store`.
    Set `reports = store` on your servers if you rely on reports being written to disk.
- **Filebucket reads are restricted.**
    Agents can still back files up to a central filebucket, but reading bucket contents now requires a certificate with the `pp_cli_auth` extension.
- **`file { content => '<checksum>' }` is now literal.**
    Content that looks like a checksum is no longer used to fetch a file from the filebucket.
    Use static catalogs or an explicit `source` instead.
- **Hiera 3-era data bindings are gone.**
    The `data_binding_terminus` and `environment_data_provider` settings and the Hiera 3 indirector terminus have been removed; Hiera 5 is the supported path.
- **Several deprecated interfaces have been removed:** `--configprint` (use `puppet config print`), the `pluginsync` setting, the ignored fifth argument to `regsubst()`, the PAL `evaluate_script_string`/`evaluate_script_manifest` APIs, the `pe_serverversion` fact, and the vendored `zone_core` module.
- **Ruby 4's `net/http` no longer adds a default `Content-Type` header.**
    If you maintain a custom report processor or other code that POSTs data with `net/http`, set `Content-Type` explicitly.
- **Upgrade server and database packages fully** with `apt`, `dnf`, or `zypper` so that the new Java packages are pulled in.
    Afterwards, check `update-alternatives --display java` to make sure `/usr/bin/java` points at **version 21 or newer**.
    If the services start under Java 17, they will crash early with a `ClassNotFoundException` for `java.util.SequencedCollection`.

The full release notes, including bug fixes and the changes in each pre-release, are here:

- `openvox-agent`: [https://github.com/OpenVoxProject/openvox/releases/tag/9.0.0](https://github.com/OpenVoxProject/openvox/releases/tag/9.0.0)
- `openvox-server`: [https://github.com/OpenVoxProject/openvox-server/releases/tag/9.0.0](https://github.com/OpenVoxProject/openvox-server/releases/tag/9.0.0)
- `openvoxdb`: [https://github.com/OpenVoxProject/openvoxdb/releases/tag/9.0.0](https://github.com/OpenVoxProject/openvoxdb/releases/tag/9.0.0)
- `openfact`: [https://github.com/OpenVoxProject/openfact/releases](https://github.com/OpenVoxProject/openfact/releases)

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

<!--
TODO: keep or drop these depending on whether they are fixed in 9.0.0.

### macOS

- On macOS 26 and later, the forked agent run can crash in `getaddrinfo` ([openvox#686](https://github.com/OpenVoxProject/openvox/pull/686)).
- Upgrading the agent with the pkg installer does not restart the `puppet` launchd service, so the old version keeps running until the service is restarted ([openvox#675](https://github.com/OpenVoxProject/openvox/issues/675)).
    After upgrading, run `sudo launchctl kickstart -k system/puppet`.
-->

## Thank you

OpenVox 9 would not exist without everyone who submitted pull requests, filed bugs, tested pre-releases, and joined the discussions about what should change.
Thank you all!

<!-- TODO: add specific shout-outs -->

> *If you have questions about, or encounter issues with these releases, reach out in `#openvox` on Slack or `#voxpupuli-openvox` on IRC.
> See [https://voxpupuli.org/connect/](https://voxpupuli.org/connect/) for details.*
{: .alert .alert-primary }
