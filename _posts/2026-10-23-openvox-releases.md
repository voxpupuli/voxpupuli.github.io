---
date: 2026-10-23
github_username: miharp
layout: post
title: OpenVox releases since 9.0
---

It has been a busy three weeks since [OpenVox 9.0 shipped](/blog/2026/10/02/openvox-9-release/)!
We have published twelve releases across both lines since then: four openvox-agent releases on 9.x, three on 8.x, new openvox-server and openvoxdb releases on each, and an openfact update.
Together they close out the remaining items from the 9.0 announcement, fix a fresh batch of CVEs, and keep OpenVox 8 users covered while they plan their upgrade.
The current versions are:

{: .table .table-striped .table-hover }
| Component | 9.x | 8.x |
| :-------- | :---- | :----- |
| openvox-agent | 9.2.1 | 8.31.1 |
| openvox-server | 9.1.0 | 8.17.0 |
| openvoxdb | 9.1.0 | 8.17.0 |

## Highlights

- **CA trust store refresh.** openvox-agent 9.1.1 and 8.31.1 rebuild the bundled CA certificates from the Mozilla root store in NSS 3.131.1, which removes three emSign roots after [eMudhra's private keys were found to be exposed](https://emudhra.we-have-a-problem.com/). The upgrade replaces `cert.pem`, so a CA you appended to that file has to be added again. The docs describe [ways that survive upgrades](https://docs.openvoxproject.org/openvox/9.x/ssl_custom_ca_proxy.html).
- **Ruby 4.0.9.** openvox-agent 9.2.1 picks up Ruby's [regexp compilation fixes](https://www.ruby-lang.org/en/news/2026/10/23/regexp-fixes-for-gitlab-cves/) for the four GitLab CVEs. 9.2.0 before it brought Ruby 4.0.8, which fixes two problems in forked child processes that the agent daemon relies on.
- **OpenSSL 3.0 is end of life.** openvox-agent 8.x bundles OpenSSL 3.0, which stopped receiving fixes in September. The OpenSSL issues listed as open on the 8.31.1 release page will stay open in OpenVox 8. OpenVox 9 bundles OpenSSL 3.5 LTS; see [Upgrading from OpenVox 8 to OpenVox 9](https://docs.openvoxproject.org/openvox/9.x/upgrade_major.html).
- **json 3 support.** openvox-agent 9.1.0 and 8.31.0 work with version 3 of the `json` gem, which fixed every request to the server failing for agents installed from the gem or a distribution package on a Ruby that ships json 3. The `openvox-agent` packages bundle json 2 and were not affected.
- **Agent hang fixes backported.** openvox-agent 8.30.0 backports the mitigations for the [daemon hang described in the 9.0 announcement](/blog/2026/10/02/openvox-9-release/#agent-daemon-can-occasionally-hang-on-applying-configuration), fixes `Deferred` values that call Puppet-language functions, and updates libxml2 to resolve eight CVEs.
- **FIPS builds on Bouncy Castle FIPS 2.1.** As promised in the 9.0 announcement, openvox-server 9.1.0 and openvoxdb 9.1.0 move the FIPS packages to the 2.1 series, which is certified on Java 21. FIPS packages are now also built for Enterprise Linux 10. openvox-server 9.1.0 also fixes DNS lookups through Ruby's `resolv` library raising errors in custom functions.
- **Jackson CVEs.** openvox-server 8.17.0 and openvoxdb 8.17.0 update Jackson to 2.21.7, which resolves four CVEs with a CVSS score of 7.5. openvox-server 8.17.0 also lets a post-deploy hook on the primary flush the environment cache without adding an `auth.conf` rule by hand.

openvox-server 9.1.0 and openvoxdb 9.1.0 require openvox-agent 9.1.0 or newer.
OpenVox 8 continues to receive high-priority fixes and backports for at least six months after the 9.0 release.
Fixes that need a newer OpenSSL or Ruby than 8.x bundles will only land in OpenVox 9, so the OpenSSL issues above are the main reason to plan the upgrade.

## Release notes

The full notes for each release, including the resolved CVEs and links to the GitHub release pages, are on the docs site:

- OpenVox: [9.x](https://docs.openvoxproject.org/openvox/9.x/release_notes.html) and [8.x](https://docs.openvoxproject.org/openvox/8.x/release_notes.html)
- OpenVox Server: [9.x](https://docs.openvoxproject.org/openvox-server/9.x/release_notes.html) and [8.x](https://docs.openvoxproject.org/openvox-server/8.x/release_notes.html)
- OpenVoxDB: [9.x](https://docs.openvoxproject.org/openvoxdb/9.x/release_notes.html) and [8.x](https://docs.openvoxproject.org/openvoxdb/8.x/release_notes.html)
- OpenFact: [6.x](https://docs.openvoxproject.org/openfact/6.x/release_notes.html) and [5.x](https://docs.openvoxproject.org/openfact/5.x/release_notes.html)

> *If you have questions about, or encounter issues with these releases, reach out in `#openvox` on Slack or `#voxpupuli-openvox` on IRC.
> See [https://voxpupuli.org/connect/](https://voxpupuli.org/connect/) for details.*
{: .alert .alert-primary }
