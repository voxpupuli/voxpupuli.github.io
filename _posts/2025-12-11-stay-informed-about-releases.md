---
layout: post
title: How to Stay Informed About VoxPupuli OpenVox Agent Releases via GitHub
date: 2025-12-11
github_username: corporate-gadfly
---

If you're managing infrastructure with OpenVox (the community-maintained fork of Puppet) or
making the transition to OpenVox, staying current with agent releases is crucial for security,
performance, and access to new features. Here's how to track releases directly through
GitHub repositories.

## GitHub Repositories to Watch

The main release repository is [https://github.com/OpenVoxProject/openvox](https://github.com/OpenVoxProject/openvox). This is where new agent versions are tagged and released.

### To get notifications:

1. Navigate to [https://github.com/OpenVoxProject/openvox](https://github.com/OpenVoxProject/openvox)
1. Click the `Watch` button in the top-right corner
   <img alt="watch button dropdown" src="{{ site.url }}{{ site.baseurl }}/static/images/github-watch-dropdown.png" width="50%" height="50%" />
1. Select `Custom` from the dropdown
1. Check the `Releases` option
   <img alt="custom notifications" src="{{ site.url }}{{ site.baseurl }}/static/images/github-custom-notifications.png" width="50%" height="50%" />
1. Click `Apply`

You'll now receive GitHub notifications (email or in-app) whenever a new version is released.

### Direct release page

[https://github.com/OpenVoxProject/openvox/releases](https://github.com/OpenVoxProject/openvox/releases)

This page shows:

- All released versions in chronological order
- Detailed changelogs for each release
- Downloadable assets (tarballs, checksums)
- Version tags for easy reference
- Release dates and authors

### Email Notifications

By default, watched releases will send email notifications to your GitHub-registered email address. You can customize this in your GitHub settings under Notifications.

### GitHub Mobile App
Install the GitHub mobile app (iOS or Android) to receive push notifications for releases on your phone. This ensures you see important releases even when away from your computer.

### RSS Feeds
Every GitHub repository has a releases RSS feed. For OpenVox agent releases, the feed URL is:
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
1. **Operating system support** - Check if your platforms are supported (recent releases added EL10 and Debian 13 support)
1. **Breaking changes** - Note any incompatibilities with older versions
1. **Security updates** - CVE fixes and security improvements
1. **New features** - Enhancements that might benefit your infrastructure
1. **Deprecations** - Features or platforms being phased out
