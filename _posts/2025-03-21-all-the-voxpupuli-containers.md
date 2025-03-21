---
layout: post
title: All the Vox Pupuli containers
date: 2025-03-21
github_username: rwaffen
---

You may have heared about our (now deprecated) `puppetserver`/`puppetdb` container images?
But did you know that we have a lot more containers available?
We have the brand new OpenVox containers, which replace the old puppetserver and puppetdb containers, and even some more.

## OpenVox containers

### openvoxserver

[`openvoxserver`](https://github.com/openvoxproject/container-openvoxserver) is a drop-in replacement for the old `voxpupuli/puppetserver` container.

### openvoxdb

[`openvoxdb`](https://github.com/openvoxproject/container-openvoxdb) is a drop-in replacement for the old `voxpupuli/puppetdb` container.

### openvoxagent

[`openvoxagent`](https://github.com/openvoxproject/container-openvoxagent) is a drop-in replacement for the old `puppet/puppet-agent` container. It is mostly used for testing purposes, as of now.

## Vox Pupuli containers

### voxbox

[`voxbox`](https://github.com/voxpupuli/container-voxbox) is a container that contains a lot of tools that are useful for OpenVox/Puppet development and testing.
It includes tools like `puppet-lint`, `modulesync`, `onceover`, `facter`, `yamllint`, `rubocop` and the Vox Pupuli testing gems.

### r10k

[`r10k`](https://github.com/voxpupuli/container-r10k) is a container that contains r10k, a tool to manage OpenVox/Puppet environments.

See also: [r10k](https://github.com/puppetlabs/r10k)

### semantic-release

[`semantic-release`](https://github.com/voxpupuli/container-semantic-release) is a container that contains the `semantic-release` tool, which is used to automatically release new versions of software projects.

See also: [semantic-release](https://github.com/semantic-release/semantic-release)

### commitlint

[`commitlint`](https://github.com/voxpupuli/container-commitlint) is a container that contains the `commitlint` tool, which is used to lint commit messages.

See also: [commitlint](https://commitlint.js.org/) and [conventional commits](https://www.conventionalcommits.org/)

### puppet-catalog-diff-viewer

[`puppet-catalog-diff-viewer`](https://github.com/voxpupuli/puppet-catalog-diff-viewer) is a container that contains the `puppet-catalog-diff-viewer` tool, which is used to visualize the differences between two OpenVox/Puppet catalogs.

### puppetboard

[`puppetboard`](https://github.com/voxpupuli/puppetboard) is a container that contains the `puppetboard` tool, which is a web interface for OpenVoxDB/PuppetDB.

## Conclusion

So you see, we have a lot of containers available.
If you have any questions or suggestions, feel free to reach out to us on [GitHub](https://github.com/voxpupuli) or on our [Slack](https://short.voxpupu.li/puppetcommunity_slack_signup) or [#voxpupuli](ircs://irc.libera.chat:6697/voxpupuli) on [Libera.Chat](https://libera.chat/).
If you need help with any of the containers, feel free to open an issue on the respective GitHub repository.
Some examples of how to use the containers can be found in the [CRAFTY](https://github.com/voxpupuli/crafty) repository.
