---
layout: post
title: Tracking OpenVox releases
date: 2026-07-29
summary: How to stay informed about VoxPupuli OpenVox releases via GitHub
---

If you're managing infrastructure with OpenVox (the community-maintained fork of Puppet) or making the transition to OpenVox, staying current with releases is crucial for security, performance, and access to new features.
Here's how to track releases directly through GitHub repositories.

This page focuses on the OpenVox agent, but these guidelines will work for any repository making releases.

## GitHub Repositories to Watch

The main release repository is [`OpenVoxProject/openvox`](https://github.com/OpenVoxProject/openvox).
This is where new agent versions are tagged and released.
You may also be interested in other repositories, such as:

* [OpenVox Server](https://github.com/OpenVoxProject/openvox-server/)
* [OpenVoxDB](https://github.com/OpenVoxProject/openvoxdb/)

### To get notifications:

1. Navigate to [https://github.com/OpenVoxProject/openvox](https://github.com/OpenVoxProject/openvox)
1. Click the `Watch` button in the top-right corner and select `Custom` from the dropdown
<br clear="left"/>
<img alt="watch button dropdown" src="{{ site.url }}{{ site.baseurl }}/static/images/github-watch-dropdown.png" width="300" />
1. Check the `Releases` option
<br clear="left"/>
<img alt="custom notifications" src="{{ site.url }}{{ site.baseurl }}/static/images/github-custom-notifications.png" width="450" />
1. Click `Apply`

You'll now receive GitHub notifications (email or in-app) whenever a new version is released.

### Direct Releases Page

[https://github.com/OpenVoxProject/openvox/releases](https://github.com/OpenVoxProject/openvox/releases)

This page shows:

- All released versions in chronological order
- Detailed changelogs for each release
- Downloadable assets (tarballs, checksums)
- Version tags for easy reference
- Release dates and authors

### Email Notifications

By default, watched releases will send email notifications to your GitHub-registered email address.
You can customize this in your GitHub settings under Notifications.

### GitHub Mobile App
Install the GitHub mobile app (iOS or Android) to receive push notifications for releases on your phone.
This ensures you see important releases even when away from your computer.

### RSS Feeds
Every GitHub repository has a releases RSS feed.
For OpenVox agent releases, the feed URL is:
```
https://github.com/OpenVoxProject/openvox/releases.atom
```

### GitHub CLI
If you use the GitHub CLI tool (`gh`), you can quickly check for new releases:
```
gh release list --repo OpenVoxProject/openvox
```

## What to Look For in GitHub Release Announcements
When a new version is announced, pay attention to:

1. **Version compatibility** - Ensure compatibility with your OpenVox server and modules
1. **Operating system support** - Check if your platforms are supported
1. **Breaking changes** - Note any incompatibilities with older versions
1. **Security updates** - CVE fixes and security improvements
1. **New features** - Enhancements that might benefit your infrastructure
1. **Deprecations** - Features or platforms being phased out
