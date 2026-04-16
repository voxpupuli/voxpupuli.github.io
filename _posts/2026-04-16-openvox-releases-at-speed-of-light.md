---
layout: post
title: OpenVox Releases at speed of light (almost)
date: 2026-04-16
github_username: tuxmea
---

The community has put lots of effort into automating the OpenVox release process.

To give you an example how fast releases are possible, I want to point you to the timing between the last two releases:

Release 8.26.0 was tagged on April 14 2026 at 6:39 PM CEST.

The release was  available on the [GitHub release page](https://github.com/OpenVoxProject/openvox/releases/tag/8.26.0) on April 14 2026 at 6:40 PM CEST.

The packages were available on the repo server on April 14 2026 at 7:02 PM CEST.

A bug was reported on April 15 at 2:13 PM CEST via [Vox Pupuli Slack](https://voxpupuli.slack.com/archives/C088QSEH1RA/p1776255199310549).
This was the message:

```text
Hey guys, had an issue with eyaml this morning, everything is fine on puppetservers with the
older agent 8.25.0-1+ubuntu24.04
but on puppetservers with the newer agent 8.26.0-1+ubuntu24.04 (all on puppetserver 8.12.1-1+ubuntu24.04 )
I'm seeing Error 500 on SERVER: Server Error: Evaluation Error: Error while evaluating a Function Call,
Function Load Error for function 'eyaml_lookup_key': Lookup using eyaml lookup_key function is only
supported when the hiera_eyaml library is present

from a client agent.

hiera-eyaml is present on the server:
```

Bug analysis showed that the base64 dependency declaration is needed for Ruby 3.4/4 because it moved from a default gem to a bundled gem, but 0.3 is too new for the default gem version in Ruby 3.2, so it caused issues in OpenVox 8.

The community reacted and fixed the bug with the following commits:

- [hiera-eyaml - April 15 2026 at 7:15 PM CEST](https://github.com/voxpupuli/hiera-eyaml/commit/cd64af6580b9d2e30d6b90bf78c442f4db711b1e)
- [puppet-runtime - April 15 2026 at 10:32 PM CEST](https://github.com/OpenVoxProject/puppet-runtime/commit/75960a166fe1eb203e2c88c463ce65a9901963ed)
- [openvox - April 15 2026 at 11:01 PM CEST](https://github.com/OpenVoxProject/openvox/commit/1a4c6ae5006242df50c6d26a94214c7d1f4361fb)
- [openvox tag - April 16 2026 at 1:08 AM CEST](https://github.com/OpenVoxProject/openvox/commit/06930e46fcad68fa0a6e29afd4fbf36569dddab8)

The new release [8.26.1](https://github.com/OpenVoxProject/openvox/releases/tag/8.26.1) was available on April 15 2026 at 1:11 AM CEST.

The packages of this new release were available on the repository server on April 15 2026 at 1:22 AM CEST.

That's less than 8 hours from release to bug identification to fixed release.

That is less time compared to the sun being visible in Europe on that day (6:07 AM CEST to 8:07 PM CEST).

The Vox Pupuli community has proven that automation is the key to success.

