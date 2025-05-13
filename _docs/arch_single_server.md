---
layout: architecture
title: Single Server
date: 2025-05-13
version: v1.0.0
summary: A simple server/agent architecture with all services running on a single machine.
---

## Intended Audience

This architecture is intended for small to medium static infrastructures and is easier to set up and maintain than a load balanced compiler farm.
Generally speaking, redundancy and HA are most useful for dynamic environments.
A stopped Puppet server doesn't prevent the existing configuration from being enforced but it will halt any new deployments or configuration updates.
If those constraints fit your needs, then this architecture is suggested.


<div class="mermaid">
flowchart LR
subgraph server["OpenVoxServer node"]
    Foreman("The Foreman")
    Webhook("webhook-go")
    OpenVoxDB["OpenVoxDB"]
    OpenVoxServer{"OpenVoxServer"}
    HDM("Hiera Data Manager")
    Puppetboard
end

git("Git Repository") --- Webhook
Webhook -- r10k code deploy --- OpenVoxServer
OpenVoxDB --- OpenVoxServer
Foreman --- OpenVoxServer
HDM --- OpenVoxServer
Puppetboard --- OpenVoxDB
OpenVoxServer --- Agent1("Agent 1") & Agent2("Agent 2") & Agent_n("Agent n")

click Foreman "https://www.theforeman.org/"
click Webhook "https://github.com/voxpupuli/webhook-go?tab=readme-ov-file#webhook-go"
click OpenVoxDB "https://github.com/OpenVoxProject/openvoxdb"
click HDM "https://github.com/betadots/hdm?tab=readme-ov-file#hdm---hiera-data-manager"
click Puppetboard "https://github.com/voxpupuli/puppetboard?tab=readme-ov-file#puppetboard"
click OpenVoxServer "https://github.com/OpenVoxProject/openvox-server?tab=readme-ov-file#puppet-server"
click Agent1 "https://github.com/OpenVoxProject/openvox-agent?tab=readme-ov-file#the-puppet-agent"
click Agent2 "https://github.com/OpenVoxProject/openvox-agent?tab=readme-ov-file#the-puppet-agent"
click Agent_n "https://github.com/OpenVoxProject/openvox-agent?tab=readme-ov-file#the-puppet-agent"
</div>

## Setup and Usage

We recommend to store your code in a git repository.
For public code (e.g. Puppet modules), many people rely on GitHub.
There are different solutions available to host your own git repositories, one of them is GitLab.
GitLab has a open source version with [MIT license](https://docs.gitlab.com/development/licensing/) and Vox Pupuli offers a [Puppet module for it](https://forge.puppet.com/modules/puppet/gitlab/readme).
We recommend to use any git hosting solution that supports calling webhooks for merges/pushes.

### Git Repository

We recommend organizing your code as a Control Repository with branches for
environments. See the [reference repository](https://github.com/puppetlabs/control-repo)
for an example.


### Foreman

[Foreman](https://www.theforeman.org) is a complete lifecycle management tool
for physical and virtual servers. It will provide you with a graphical
classifier, a Hiera data source, and report monitoring. It also includes the
power to easily automate repetitive tasks, quickly deploy applications, and
proactively manage servers, on-premise or in the cloud.


### Puppet Webhook

Vox Pupuli offers [webhook-go](https://github.com/voxpupuli/webhook-go?tab=readme-ov-file#webhook-go), an open source ([Apache-2.0 licensed](https://github.com/voxpupuli/webhook-go/blob/master/LICENSE)) webhook that can listen for events from:

* GitLab on-premise
* GitLab Cloud
* GitHub
* GitHub Enterprise
* Azure DevOps
* Bitbucket
* Bitbucket server
* Gitea

webhook-go triggers [r10k](https://github.com/puppetlabs/r10k?tab=readme-ov-file#r10k) to deploy modules or environments.
webhook-go calls r10k always locally, so it has to run on your OpenVoxServer.
The [r10k puppet module](https://forge.puppet.com/modules/puppet/r10k/readme) can configure r10k itself and the webhook.

### Code Deployment

[r10k](https://github.com/puppetlabs/r10k) is considered the default Puppet code deployment tool.
Install it on your server in your infrastructure and use it to deploy your control repository as needed.

If you're a Golang shop, you might consider [g10k](https://github.com/xorpaul/g10k) as well.


### OpenVox Stack

We recommend managing each of these components with the supported module.

* OpenVoxDB
    * [puppetlabs/puppetdb](https://forge.puppet.com/puppetlabs/puppetdb)
    * The default PostgreSQL database is recommended.
* OpenVoxServer and agents
    * [theforeman/puppet](https://forge.puppet.com/modules/theforeman/puppet)
* Puppet Metrics Dashboard
    * [puppetlabs/puppet_metrics_dashboard](https://forge.puppet.com/puppetlabs/puppet_metrics_dashboard)
* Hiera Data Manager (HDM)
    * [puppet/hdm](https://forge.puppet.com/modules/puppet/hdm)
* r10k & webhook-go
    * [puppet/r10k](https://forge.puppet.com/modules/puppet/r10k/readme)
* nftables firewalling
    * [puppet/nftables](https://forge.puppet.com/modules/puppet/nftables/readme)

## Scaleout options

* OpenVoxDB, OpenVoxServer, Foreman, PostgreSQL can all run on different systems.
* OpenVoxDB and Foreman use individual databases. They can run on the same PostgreSQL cluster, they don't have to.
* It's common to run OpenVoxServer and OpenVoxDB on the same system.

## Containerisation

* Vox Pupuli offers containers for [OpenVoxServer](https://github.com/OpenVoxProject/container-openvoxserver?tab=readme-ov-file#openvox-server-container) and [OpenVoxDB](https://github.com/OpenVoxProject/container-openvoxdb?tab=readme-ov-file#openvox-db-container)
* Vox Pupuli also has containers for [Puppetboard](https://github.com/voxpupuli/puppetboard/pkgs/container/puppetboard) and [HDM](https://github.com/betadots/hdm/pkgs/container/hdm)
* There's also a container for [r10k](https://github.com/voxpupuli/container-r10k) and for [webhook-go](https://github.com/voxpupuli/container-r10k-webhook)
* [crafty](https://github.com/voxpupuli/crafty) (Containerized Resources And Funky Tools in YAML) pulls all the images together
