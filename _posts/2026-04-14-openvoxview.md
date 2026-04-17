---
layout: post
title: OpenVox View 
date: 2026-04-14
github_username: sebastianrakel
---

# Introduction

[OpenVox View](https://github.com/voxpupuli/openvoxview) is a viewer for OpenVoxDB/PuppetDB, heavily inspired by [Puppetboard](https://github.com/voxpupuli/puppetboard).

The idea for OpenVox View emerged from my personal frustrations with [Puppetboard](https://github.com/voxpupuli/puppetboard):
- Deployment issues with Python dependencies
- System upgrades frequently broke Python components
- Several core issues required complete rewrites of fundamental functions
- During my development work on Puppetboard, I found the project architecture problematic
  - Mixed rendering approach (mostly HTML with occasional JavaScript/AJAX calls)
- The query editor was simplistic and lacked some features
  
I decided to develop OpenVox View with the goal of creating a single binary containing both backend and frontend.

The backend choice was straightforward: **Golang** (my primary development language).

The frontend required multiple iterations: **Angular**, **Vue 2 with Vuetify** (quickly abandoned when Vue 3 reached production readiness), and finally **Vue 3 with Quasar**.

I chose Quasar based on my experience with the framework.

# First Version
![Screenshot of First Version](/static/images/2026-04-14-openvoxview-first-version.png)

I presented the first version of OpenVox View at VoxConf '25 (my first English presentation—I was quite nervous!). The initial feature set included:
- Data visualization (Reports, Facts, Events)
- Query Editor with:
  - Multiple query support
  - Query history
  - Predefined queries
- Configurable views

The response was positive, with valuable feature suggestions and helpful feedback on the current implementation.

# The 1.0 Release (CfgMgmtCamp 2026)

I had the pleasure of delivering a lightning talk (another first!) about OpenVox View. In the weeks leading up to this event, I finalized everything for the OpenVox View 1.0 release.

New features included:
- Variable detection in queries, allowing direct copy-paste from Puppet code without manual variable replacement
- Comprehensive documentation
- Automated build processes
- Container image support

![Screenshot of Query with Variable Detection](/static/images/2026-04-14-openvoxview-query-parameters.png)

We also developed an OpenVox module for easy OpenVox View deployment: [voxpupuli/puppet-openvoxview](https://github.com/voxpupuli/puppet-openvoxview.git)

# Current Status
We've gained new contributors who are doing exceptional work, adding:
- Puppet Server CA interface: Certificate viewing, signing, and revocation capabilities directly from OpenVox View
- Numerous bug fixes in my original code
- Quality-of-life feature improvements

# Upcoming Features
- Authentication and user management system
- Enhanced query editor functionality
- Improved predefined views

# Final words

- [OpenVox View Repository](https://github.com/voxpupuli/openvoxview)
- [OpenVox Module Repository](https://github.com/voxpupuli/puppet-openvoxview)

If you want to use OpenVox View, have feature requests, want to contribute or chat with me about stuff, feel free to contact me :)

- **on IRC**: Spritzgebaeck on libera.chat
- **on Slack**: sebastianrakel
- **on Github**: [sebastianrakel](https://github.com/sebastianrakel)
- **on Twitch**: [derkellernerd](https://twitch.tv/derkellernerd)
