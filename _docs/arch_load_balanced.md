---
layout: architecture
title: Load Balanced
date: 2023-08-06
version: v0.0.2
summary: A complete server/agent architecture with multiple compilers and load balancing for redundancy.
---

## Intended Audience

This architecture is intended for large infrastructures or dynamic infrastructures
that require the redundancy of multiple compilers.

<div class="mermaid">
  graph LR;
  git(Git Repository)
  Foreman(The Foreman)
  Webhook(Puppet Webhook Server)
  AllCompilers((All Compilers))
  HDM(Hiera Data Manager)

  MainPuppetServer{Main Puppet Server}

  subgraph Compilers[Compilers]
      Compile1[Compile1]
      Compile2[Compile2]
      Compile3[Compile3]
  end

  LoadBalancer[Load Balancer]

  Agent1(Agent 1)
  Agent2(Agent 2)
  Agent_n(Agent n)

  click HDM "<https://github.com/betadots/hdm>" "HDM is a web interface for analyzing and managing hiera data."
  click Foreman "<https://www.theforeman.org>" "Foreman is a complete lifecycle management tool for physical and virtual servers."
  click Webhook "<https://github.com/voxpupuli/puppet_webhook>" "A webhook service that can trigger code deploys from source code repository updates."

  git --webhook--> Webhook
  Webhook --r10k code deploy--> MainPuppetServer
  Webhook -.r10k code deploy.-> AllCompilers

  Foreman --> MainPuppetServer
  MainPuppetServer --> Foreman
  HDM --> MainPuppetServer
  MainPuppetServer --> HDM

  Compile1 --> MainPuppetServer
  Compile2 --> MainPuppetServer
  Compile3 --> MainPuppetServer

  LoadBalancer --> Compile1
  LoadBalancer --> Compile2
  LoadBalancer --> Compile3

  Agent1 --> LoadBalancer
  Agent2 --> LoadBalancer
  Agent3 --> LoadBalancer
  Agent_n --> LoadBalancer
</div>

## Setup and Usage

{write a guide on how to deploy, configure, and use this architecture}

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

Configure [Puppet Webhook](https://github.com/voxpupuli/puppet_webhook) to receive
webhook events from your code repository and automate your code deploys. This
service should be installed on the main Puppet Server. You might consider
using the Bolt task from the [puppet-r10k module](https://github.com/voxpupuli/puppet-r10k/blob/master/tasks/deploy.json)
to trigger code deployments on each compiler, or you can also install
Puppet Webhook on each.

### Code Deployment

[r10k](https://github.com/puppetlabs/r10k) is considered the default Puppet code
deployment tool. Install it on the main Puppet Server and each compiler in your
infrastructure and use it to deploy your control repository as needed.

If you're a Golang shop, you might consider [g10k](https://github.com/xorpaul/g10k) as well.

### Load Balancer

Puppet Agent Server connections are connections with long duration. Therfore it is highly recommended to use `least_connection` algorithm.

Any kind of load-balancer is sufficient. [HAProxy](https://www.haproxy.org/) is well supported and allows flexibility.

### Puppet Stack

We recommend managing each of these components with the supported module.

* PuppetDB
  * [puppetlabs/puppetdb](https://forge.puppet.com/puppetlabs/puppetdb)
  * The default PostgreSQL database is recommended.
* Puppet Server
  * [theforeman/puppet](https://forge.puppet.com/modules/theforeman/puppet)
* Puppet Agents
  * [puppetlabs/puppet_agent](https://forge.puppet.com/puppetlabs/puppet_agent)
* Puppet Metrics Dashboard
  * [puppetlabs/puppet_metrics_dashboard](https://forge.puppet.com/puppetlabs/puppet_metrics_dashboard)
* Hiera Data Manager (HDM)
  * [puppet/hdm](https://forge.puppet.com/modules/puppet/hdm)
* HAproxy LoadBalancer
  * [puppetlabs/haproxy](https://forge.puppet.com/modules/puppetlabs/haproxy)
