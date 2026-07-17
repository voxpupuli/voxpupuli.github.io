---
layout: post
title: OpenVox 9.0 beta release 🍾 🎉
date: 2026-07-15
github_username: Sharpie
---

Happy Wednesday Everyone!

In celebration of [VoxConf](https://voxpupuli.org/voxconf/2026/) and The Foreman Birthday, the release team is pleased to announce something special this week:

**We have just shipped `9.0.0~beta1` releases of the `openvox-agent`, `openvox-server`, and `openvoxdb` packages.**
{: .alert .alert-success }

This is the first 9.0 pre-release that contains both the agent and the server packages and they have been shipped as a set to new `openvox9` repositories.
To configure these repositories, install the `openvox9-release` packages from:

- [https://apt.voxpupuli.org/](https://apt.voxpupuli.org/)
- [https://yum.voxpupuli.org/](https://yum.voxpupuli.org/)

Packages for macOS can be found at:

[https://downloads.voxpupuli.org/mac/openvox9/](https://downloads.voxpupuli.org/mac/openvox9/)

Updates to `homebrew-openvox` will show up later in the week.

<s>It wouldn't be a beta release without something going wrong, and today it was our Windows signing pipeline.
For those adventurous souls who are fine with unsigned packages, the Windows build can be found on OSUOSL.</s>

**UPDATE!**

> The Windows signing pipeline issue has been resolved.
> There was a latent bug discovered and fixed in an upstream tool we used.
> The proper Windows package is now available at:
>
> [https://downloads.voxpupuli.org/windows/openvox9/openvox-agent-9.0.0~beta1-x64.msi](https://downloads.voxpupuli.org/windows/openvox9/openvox-agent-9.0.0~beta1-x64.msi)

Headline component changes in these releases, compared to OpenVox 8:

- `openvox-agent` now uses Ruby 4.0, which is an upgrade from Ruby 3.2.
- `openvox-server` and `openvoxdb` are configured to run on Java 25, with the exception of EL 8 which uses Java 21. This is an upgrade from Java 17.
- `openvox-server` now uses JRuby 10.0, which is compatible with Ruby 3.4. This is an upgrade from JRuby 9.4, which was compatible with Ruby 3.1.
- `openvoxdb` is now tested against PostgreSQL 17 and 18. This is an upgrade from PostgreSQL 14.

Please see the release notes for numerous other changes, including bugfixes and breaking changes:

- `openvox-agent`: [https://github.com/OpenVoxProject/openvox/releases/tag/9.0.0-beta1](https://github.com/OpenVoxProject/openvox/releases/tag/9.0.0-beta1)
- `openvox-server`: [https://github.com/OpenVoxProject/openvox-server/releases/tag/9.0.0-beta1](https://github.com/OpenVoxProject/openvox-server/releases/tag/9.0.0-beta1)
- `openvoxdb`: [https://github.com/OpenVoxProject/openvoxdb/releases/tag/9.0.0-beta1](https://github.com/OpenVoxProject/openvoxdb/releases/tag/9.0.0-beta1)

This is a ***BETA*** release, so we don't recommend upgrading production systems at this time.
For those who try upgrading test systems to use these releases, there are a couple of caveats to be aware of:

- Do a full upgrade via `apt`, `dnf`, or `zypper` in order to re-solve dependencies.
    This should bring in the new Java 25 or Java 21 packages.
    After upgrade, check `update-alternatives --display java` to ensure `/usr/bin/java` points at **version 21 or newer**.
    If the new packages try to run under Java 17, the service will crash early with `Execution error (ClassNotFoundException) referencing java.util.SequencedCollection`.
- If you have previously installed either of our `9.0.0.alpha1` or `9.0.0.alpha2` releases, then you will need to downgrade to the beta release.
    E.g. `dnf downgrade openvox-agent 9.0.0~beta1`. The tilde, `~`, in the beta release version makes it sort older than a full version number and should help later when upgrading pre-releases to the final 9.0.0 version.

Finally, thanks to everyone in the community who has submitted pull request, filed bugs, tried out pre-releases, and otherwise contributed to making these builds happen.
Special shout-outs to [Tim Meusel](https://github.com/bastelfreak) and [Haroon Rafique](https://github.com/corporate-gadfly) for working on all aspects of these builds, [Steven Pritchard](https://github.com/silug) for keeping track of breaking changes, and [Josh Partlow](https://github.com/jpartlow) for tons of work on the acceptances tests.
Shout out to [Austin Blatt](https://github.com/austb) for getting us onto Jetty 12, and [Nick Burgan](https://github.com/nmburgan) for building out the release infrastructure to make this happen.
Special thanks to [Jerald Sheets](https://github.com/CVQuesty) for testing early builds and uncovering issues 🦊

> *If you have questions about, or encounter issues with these releases, reach out in `#openvox` on Slack or `#voxpupuli-openvox` on IRC.
> See [https://voxpupuli.org/connect/](https://voxpupuli.org/connect/) for details.*
{: .alert .alert-primary }
