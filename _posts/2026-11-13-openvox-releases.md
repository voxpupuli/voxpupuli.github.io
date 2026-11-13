---
date: 2026-11-13
github_username: rwaffen
layout: post
excerpt: New OpenVox Agent 9.4.0 and 8.33.0 releases are available now!
title: New openvox-agent releases!
---

🚀 **OpenVox 9.4.0 and 8.33.0 Released!** 🎉

We've just released two new OpenVox versions!

**OpenVox 9.4.0**

- Added OpenVox Agent builds for Fedora 45.
- Added a PowerShell task shim adapted from pxp-agent.
- Fixed OpenBSD package branch handling.
- Removed Ubuntu 25.04 packaging configuration.

🔒 **Known CVEs:** CVE-2026-54696 (CVSS 3.7) and CVE-2026-33210 (CVSS N/A), both affecting the bundled `json` gem 2.18.0. These vulnerabilities remain open.

📦 [Release 9.4.0](https://github.com/OpenVoxProject/openvox/releases/tag/9.4.0)

**OpenVox 8.33.0**

- Backported the PowerShell task shim from OpenVox 9.
- Fixed the `puppet-resource_api` gem dependency.
- Backported the OpenBSD package branch handling fix.
- Removed Ubuntu 25.04 packaging configuration.

📦 [Release 8.33.0](https://github.com/OpenVoxProject/openvox/releases/tag/8.33.0)

PS.: The Mac packages are still pending, we have to sort out a signing upsi-doopsi first.
They will be released a bit later today.
