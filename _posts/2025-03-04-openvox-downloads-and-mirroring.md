---
layout: post
title: OpenVox Software Downloads and Repository Mirroring
date: 2025-03-04
github_username: genebean
---

I am happy to announce that Vox Pupuli's OpenVox packages and repositories are now available under the `voxpupuli.org` domain! We now provide the following URLs for your convenience:

- <https://apt.voxpupuli.org> - apt repos
- <https://artifacts.voxpupuli.org> - build artifacts
- <https://downloads.voxpupuli.org> - packages for manual download such as macOS & Windows builds
- <https://rsync.voxpupuli.org> - encompasses all of these
- <https://yum.voxpupuli.org> - yum repos

Additionally, two rsync modules are defined that allow people to mirror the files presented at the URLs above:

- `rsync://rsync.voxpupuli.org/all` - same as <https://rsync.voxpupuli.org>
- `rsync://rsync.voxpupuli.org/packages` - all packages, which currently means the same as <https://rsync.voxpupuli.org> minus the `artifacts/` directory

If you'd like to see the technical details on how this was setup, feel free to check out <https://github.com/voxpupuli/controlrepo/pull/100>.

## What's next?

On the mirrors, downloads, and repositories front, the next few things are:

- Applying to Fastly's CDN sponsorship (<https://github.com/OpenVoxProject/planning/issues/50>)
- Adding a page to this website to document known mirrors (<https://github.com/OpenVoxProject/planning/issues/41>)
  - If you do mirror us publicly, or are open to doing so, please add a comment to this issue on GitHub
- Updating our [install page](https://voxpupuli.org/openvox/install/) with the new information
