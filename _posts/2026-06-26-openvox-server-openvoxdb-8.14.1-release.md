---
date: 2026-06-26
github_username: Sharpie
layout: post
title: OpenVox Server and OpenVoxDB 8.14.1 release
---

We are pleased to announce the 8.14.1 releases of OpenVox Server and OpenVoxDB. These releases have been in the works for several weeks and contain significant contributions from all corners of the Voxpupuli community.

## Introducing Jetty 12

The 8.14.1 releases contain one MAJOR change that everyone should be aware of:

  - The Jetty webserver has been upgraded from Jetty 10 to Jetty 12.

This is a larger change than we would normally put into a stable 8.x release, but Jetty 10 passed end-of-life earlier in the year and is starting to accumulate unpatched CVEs. We are hoping this upgrade will result in no visible change in behavior. But, Jetty does handle all API traffic for Server and DB, so the conservative move is to pin the `openvox-server` and `openvoxdb` packages to the 8.13.0 release for a couple of weeks and watch the release notes for known issues:

  - <https://docs.openvoxproject.org/openvox-server/8.x/release_notes.html#openvox-server-8141>
  - <https://docs.openvoxproject.org/openvoxdb/8.x/release_notes.html#openvoxdb-8141>

Notable among the CVEs reported against Jetty 10 is [CVE-2026-2332][CVE-2026-2332], which allows a malicious use of HTTP Chunked Transfer Encoding to close a HTTP request early and then start a new request. This is of little consequence in normal operations as OpenVox servers authenticate each request against the client certificate used to make the TLS handshake. However, there is a theoretical vulnerability when OpenVox Server is configured to run behind a proxy that is performing TLS termination. Users running OpenVox Server [in this uncommon configuration][openvox-ssl-termination] should upgrade to the 8.14.1 release and check that their proxy is not also vulnerable to attacks on Chunked Transfer Encoding. The security researcher that discovered this CVE has written an excellent post covering vulnerable servers and fix versions:

  - <https://w4ke.info/2025/06/18/funky-chunks.html>

[CVE-2026-2332]: https://nvd.nist.gov/vuln/detail/CVE-2026-2332
[openvox-ssl-termination]: https://docs.openvoxproject.org/openvox-server/8.x/external_ssl_termination.html#configure-ssl-terminating-proxy-to-set-http-headers

## Other Changes of Note

The 8.14.1 releases bring a few changes aside from the Jetty 12 upgrade:

  - `openvox-server` and `openvoxdb` packages are available for Fedora 44.

  - Issues with running `zypper install` and `zypper remove` on the `openvox-server` and `openvoxdb` packages have been fixed.

  - An issue with JRuby failing to load some Elliptic Curve (EC) keys has been fixed. This fix has increased the `openvox-server` package size by about 30 MB -- something that will be reduced in a future release.

## What Happened to the 8.14.0 Releases?

Astute observers may note the jump in released packages from 8.13.0 to 8.14.1.
The 8.14.0 packages were not released, due to broken APIs for monitoring service status and performance. However, the tags for the 8.14.0 releases summarize the changes, fixes, and resolved CVEs that carried over to 8.14.1:

  - <https://github.com/OpenVoxProject/openvox-server/releases/tag/8.14.0>
  - <https://github.com/OpenVoxProject/openvoxdb/releases/tag/8.14.0>

## Thanks

Shipping OpenVox releases is a community activity and some shout-outs are in order for major contributions to these releases:

  - Massive thanks to Austin Blatt for getting Jetty 12 up and running, and to Nick Burgan for getting it backported to the 8.x series.

  - Thanks to Tim Meusel for pulling the 8.14 releases together, and for tons of maintenance work on the build and release pipelines.

  - Thanks to Corporate Gadfly for fixing the issues with `zypper`, EC keys, and for lots of maintenance on Java dependencies and test pipelines.

  - Also, shout-out to Josh Partlow for building out our ARM64 acceptance tests, and also cutting the runtime of the existing x86_64 tests in half while doing it!

It truly takes a village to make these releases happen and I am sure I missed someone who contributed a bug report, bug fix, or other maintenance to these releases. Thank you all!

**Please provide feedback! If you have questions about, or encounter issues with these releases, reach out in `#openvox` on Slack or `#voxpupuli-openvox` on IRC. See <https://voxpupuli.org/connect/> for details.**
