---
layout: post
title: New OpenVox Agent releases!
date: 2026-06-10
github_username: bastelfreak
---

We are happy to announce OpenVox-Agent 8.28.0 and 9.0.0-alpha2!

OpenVox Agent 8.28.0 has just been published to our mirror!
Mac, Windows & Linux packages are available.
We also added Fedora 44 support.

What does the release contain? Mostly CVE fixes that were released yesterday with OpenSSL 3.0.21:

{: .table .table-striped .table-hover }
|                            Identifier                             | CVSS 3.1 Score |             Resolved By             |
| ----------------------------------------------------------------- | :------------: | ----------------------------------- |
| [CVE-2026-45447](https://nvd.nist.gov/vuln/detail/CVE-2026-45447) |      9.8       | `pkg:github/openssl/openssl@3.0.21` |
| [CVE-2026-7383](https://nvd.nist.gov/vuln/detail/CVE-2026-7383)   |      8.1       | `pkg:github/openssl/openssl@3.0.21` |
| [CVE-2026-45445](https://nvd.nist.gov/vuln/detail/CVE-2026-45445) |      7.5       | `pkg:github/openssl/openssl@3.0.21` |
| [CVE-2026-34180](https://nvd.nist.gov/vuln/detail/CVE-2026-34180) |      7.5       | `pkg:github/openssl/openssl@3.0.21` |
| [CVE-2026-9076](https://nvd.nist.gov/vuln/detail/CVE-2026-9076)   |      7.5       | `pkg:github/openssl/openssl@3.0.21` |
| [CVE-2026-42766](https://nvd.nist.gov/vuln/detail/CVE-2026-42766) |      5.9       | `pkg:github/openssl/openssl@3.0.21` |
| [CVE-2026-45446](https://nvd.nist.gov/vuln/detail/CVE-2026-45446) |      4.8       | `pkg:github/openssl/openssl@3.0.21` |
| [CVE-2026-42770](https://nvd.nist.gov/vuln/detail/CVE-2026-42770) |      3.7       | `pkg:github/openssl/openssl@3.0.21` |
| [CVE-2026-34182](https://nvd.nist.gov/vuln/detail/CVE-2026-34182) |      N/A       | `pkg:github/openssl/openssl@3.0.21` |

### New Features 🎉

* Backport: Add Platform definitions for Fedora 44 to 8.x by @Sharpie in [github.com/OpenVoxProject/openvox/pull/459](https://github.com/OpenVoxProject/openvox/pull/459)

### Bug Fixes 🐛

* [Backport 8.x] Manage group members on EL 10 without libuser by @OpenVoxProjectBot in [github.com/OpenVoxProject/openvox/pull/477](https://github.com/OpenVoxProject/openvox/pull/477)
* [Backport 8.x] Fix File.open Ruby 3.2 regression in FileSystem::Uniquefile by @OpenVoxProjectBot in [github.com/OpenVoxProject/openvox/pull/478](https://github.com/OpenVoxProject/openvox/pull/478)

### Other Changes

* Promote puppet-runtime 2026.06.09.1 into 8.x by @OpenVoxProjectBot in [github.com/OpenVoxProject/openvox/pull/48](https://github.com/OpenVoxProject/openvox/pull/480)

Our docs got also updated for [8.28.0](https://docs.openvoxproject.org/openvox/latest/release_notes.html).

---

## And OpenVox 9?

We have a new set of alpha packages.
For apt/yum, those are now actual repos with release files that you can use, not just plain download links.

* [apt](https://s3.osuosl.org/openvox-artifacts/index.html#repo_test/apt/)
* [yum](https://s3.osuosl.org/openvox-artifacts/index.html#repo_test/yum/)
* [Mac/Windows](https://s3.osuosl.org/openvox-artifacts/index.html#repo_test/downloads/)

There are a couple big changes with this release:

* Windows packages have arrived. This brings a build of Ruby 4 from a new toolchain based on MSYS2 + MINGW-w64. OpenVox 8 continues to use the old Cygwin + MINGW toolchain. One benefit of this new build is that we now use the same `x64-mingw-ucrt` platform as upstream Ruby. This means gems with compiled extensions, e.g. `gem install nokogiri`, should be able to use pre-compiled builds from rubygems.org without requiring the Windows node to have a compiler and dev tools installed. Massive thanks to [Sebastian Rakel](https://github.com/sebastianrakel) for figuring out how to get the MSYS2 build running side-by-side with the existing Cygwin build.
* A 9.0.0.pre.alpha2 version of the openvox gem [has been published](https://rubygems.org/gems/openvox/versions/9.0.0.pre.alpha2), for use in running test pipelines against the OpenVox 9 pre-release.

This version also contains CVE fixes from yesterday's OpenSSL 3.5.7 release.

{: .table .table-striped .table-hover }
|                            Identifier                             | CVSS 3.1 Score |             Resolved By             |
| ----------------------------------------------------------------- | :------------: | ----------------------------------- |
| [CVE-2026-45447](https://nvd.nist.gov/vuln/detail/CVE-2026-45447) |      9.8       | `pkg:github/openssl/openssl@3.5.7` |
| [CVE-2026-7383](https://nvd.nist.gov/vuln/detail/CVE-2026-7383)   |      8.1       | `pkg:github/openssl/openssl@3.5.7` |
| [CVE-2026-45445](https://nvd.nist.gov/vuln/detail/CVE-2026-45445) |      7.5       | `pkg:github/openssl/openssl@3.5.7` |
| [CVE-2026-42764](https://nvd.nist.gov/vuln/detail/CVE-2026-42764) |      7.5       | `pkg:github/openssl/openssl@3.5.7` |
| [CVE-2026-34180](https://nvd.nist.gov/vuln/detail/CVE-2026-34180) |      7.5       | `pkg:github/openssl/openssl@3.5.7` |
| [CVE-2026-9076](https://nvd.nist.gov/vuln/detail/CVE-2026-9076)   |      7.5       | `pkg:github/openssl/openssl@3.5.7` |
| [CVE-2026-42767](https://nvd.nist.gov/vuln/detail/CVE-2026-42767) |      5.9       | `pkg:github/openssl/openssl@3.5.7` |
| [CVE-2026-42766](https://nvd.nist.gov/vuln/detail/CVE-2026-42766) |      5.9       | `pkg:github/openssl/openssl@3.5.7` |
| [CVE-2026-42769](https://nvd.nist.gov/vuln/detail/CVE-2026-42769) |      5.3       | `pkg:github/openssl/openssl@3.5.7` |
| [CVE-2026-45446](https://nvd.nist.gov/vuln/detail/CVE-2026-45446) |      4.8       | `pkg:github/openssl/openssl@3.5.7` |
| [CVE-2026-42770](https://nvd.nist.gov/vuln/detail/CVE-2026-42770) |      3.7       | `pkg:github/openssl/openssl@3.5.7` |
| [CVE-2026-42768](https://nvd.nist.gov/vuln/detail/CVE-2026-42768) |      3.7       | `pkg:github/openssl/openssl@3.5.7` |
| [CVE-2026-34183](https://nvd.nist.gov/vuln/detail/CVE-2026-34183) |      N/A       | `pkg:github/openssl/openssl@3.5.7` |
| [CVE-2026-34182](https://nvd.nist.gov/vuln/detail/CVE-2026-34182) |      N/A       | `pkg:github/openssl/openssl@3.5.7` |
| [CVE-2026-34181](https://nvd.nist.gov/vuln/detail/CVE-2026-34181) |      N/A       | `pkg:github/openssl/openssl@3.5.7` |
| [CVE-2026-34181](https://nvd.nist.gov/vuln/detail/CVE-2026-34181) |      N/A       | `pkg:github/openssl/openssl@3.5.7` |

### Breaking Changes 🛠

* Decouple :posix feature from :syslog library check by @silug in [github.com/OpenVoxProject/openvox/pull/458](https://github.com/OpenVoxProject/openvox/pull/458)
* remove pe_serverversion fact by @corporate-gadfly in [github.com/OpenVoxProject/openvox/pull/39](https://github.com/OpenVoxProject/openvox/pull/397)
* return to preprocessing deferred functions by default by @binford2k in [github.com/OpenVoxProject/openvox/pull/462](https://github.com/OpenVoxProject/openvox/pull/462)

### New Features 🎉

* Add windows-msys2-x64 build for OpenVox 9 by @Sharpie in [github.com/OpenVoxProject/openvox/pull/468](https://github.com/OpenVoxProject/openvox/pull/468)

### Bug Fixes 🐛

* Manage group members on EL 10 without libuser by @Sharpie in [github.com/OpenVoxProject/openvox/pull/476](https://github.com/OpenVoxProject/openvox/pull/476)
* Fix File.open Ruby 3.2 regression in FileSystem::Uniquefile by @JonasVerhofste in [github.com/OpenVoxProject/openvox/pull/45](https://github.com/OpenVoxProject/openvox/pull/450)

### Other Changes

* Add JRuby 10.0.5.0 and 10.1.0.0 to test matrix by @silug in [github.com/OpenVoxProject/openvox/pull/463](https://github.com/OpenVoxProject/openvox/pull/463)
* CI: Use bot account for backports by @bastelfreak in [github.com/OpenVoxProject/openvox/pull/472](https://github.com/OpenVoxProject/openvox/pull/472)
* Promote puppet-runtime 2026.06.09.1 into main by @OpenVoxProjectBot in [github.com/OpenVoxProject/openvox/pull/479](https://github.com/OpenVoxProject/openvox/pull/479)

### New Contributors

* @JonasVerhofste made their first contribution in [github.com/OpenVoxProject/openvox/pull/450](https://github.com/OpenVoxProject/openvox/pull/450)

---

Please download and test the new releases and provide feedback [in the openvox Slack/IRC channel](https://voxpupuli.org/connect/).
We will provide new OpenBolt and OpenVox-Server/DB packages in the next couple of days as well.
