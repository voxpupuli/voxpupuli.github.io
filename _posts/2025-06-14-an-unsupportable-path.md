---
layout: post
title: An Unsupportable Path
date: 2025-06-14
github_username: genebean
---

Back in December [I wrote about](https://beanbag.technicalissues.us/the-community-is-forking-puppet/) how we, the community behind the open source project called Puppet, were being forced into forking the project. In the time since then, [OpenVox was born](https://voxpupuli.org/blog/2025/01/21/openvox-release/) and has been diligently chugging along creating, among other things, builds based off of the last truly open versions of Puppet 7 & 8. We have also been trying to work with Perforce to ensure OpenVox remains compatible with Puppet Core and Puppet Enterprise. We've given them extensive feedback both in writing and via Zoom meetings on the EULA that is attached to Puppet Core to try to make it workable for the community, but they will not make the necessary changes [so that it is tenable for Vox Pupuli to test our modules against Puppet Core](https://voxpupuli.org/blog/2025/05/19/perforce-eula/). Additionally, they are steadfast in their commitment to keep Facter as a private repository going forward. Facter is a critical, load-bearing part of the Puppet technology stack. If they make private changes that we don't anticipate or know to test for, it risks breaking the entire ecosystem. Similar to their promises about OSP, they said they'll push changes back into [the public repo](https://github.com/puppetlabs/facter) and take PRs, but given that they have done this zero times in the last 7 months on the puppet repo, this does not seem likely.

![Screenshot of GitHub showing the last commit to Puppet being 6 months ago](/static/images/2025-06-14-github-screenshot-puppetlabs-puppet.png)

![Screenshot of GitHub showing the last commit to Facter being 7 months ago](/static/images/2025-06-14-github-screenshot-puppetlabs-facter.png.png)

As a result, [Vox Pupuli has come to the conclusion](https://groups.io/g/voxpupuli/message/566) that we can no longer guarantee that our modules will work with Puppet Core or Puppet Enterprise. As I and others have said before, no one in the Puppet community wants to break compatibility as that only serves to fracture the ecosystem that has built up over many, many years. Unfortunately, Perforce is once again forcing our hand.

On top of that, it appears that sometime after March 21st, 2025 Perforce removed the page at `https://www.puppet.com/ecosystem/contribute/trusted-contributors` even though it is still linked to at `https://www.puppet.com/ecosystem/contribute`. You can see these for yourself thanks to the Internet Archive's Wayback machine:

- [The contribute page as of April 29, 2025](https://web.archive.org/web/20250429080006/https://www.puppet.com/ecosystem/contribute)
- [The Trusted Contributor page as of March 21, 2025](https://web.archive.org/web/20250321181447/https://www.puppet.com/ecosystem/contribute/trusted-contributors)

Sadly, this is not all that surprising as it is inline with them not actually being receptive to working with the community. I know that sounds harsh, but it is the reality of the matter, and was made quite evident in the Zoom meeting between Perforce and Vox Pupuli on June 10th, 2025. Most, if not all, attendees from the community left that meeting totally flummoxed by the actions and attitude of Perforce's leadership.

So, what does all this mean? Well, it seems another chapter in the story of a free and open source version of Puppet and its supporting tools has begun. Concretely, the README of each one of [Vox Pupuli's 177 modules that are published to the Puppet Forge](https://forge.puppet.com/modules/puppet) will be updated to make it clear that we are unable to validate their compatibility with Puppet Core and Puppet Enterprise. This also means Facter is being forked and will be published to RubyGems.org as soon as a name is decided upon. Once that is completed, all testing and build pipelines will be updated to replace the [`puppet` gem](https://rubygems.org/gems/puppet) that won't be updated beyond 8.10.0 with the [`openvox` gem](https://rubygems.org/gems/openvox) and to replace the [`facter` gem](https://rubygems.org/gems/facter) with the yet-to-be-named alternative. Not too long after that, an additional update to each module is planned to remove the bits from its `metadata.json` that says it is compatible with `puppet` and replace that with the module's `openvox` compatibility.

To be clear, the Vox Pupuli community is not actively planning to break compatibility with existing Puppet features, but cannot guarantee continued compatibility with software we can't legally access. As such, we are simply trying to convey this so that each user of our modules and tools knows the reality of the situation.

![Image of a person standing at a fork in the road](/static/images/decision-crossroad.jpg)

Unfortunately, we have reached a fork in the road that we as a community have no ability to avoid. We have picked our route and it is up to Perforce to either join us along this journey or to take the other road. Here's to hoping they choose to join us.
