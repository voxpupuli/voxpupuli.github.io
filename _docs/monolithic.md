---
layout: architecture
title: Monolithic Master
date: 2019-07-09
version: v0.0.1
summary: A simple master/agent architecture with all services running on one master.
---

<div class="mermaid">
  graph LR;
  git(Git Repository)

  subgraph master[Puppet Master node]
    Foreman(The Foreman)
    Webhook(Puppet Webhook Server)
    PuppetDB
    PuppetServer{Puppet Server}
  end

  Agent1(Agent 1)
  Agent2(Agent 2)
  Agents(Agents ...)
  Agent_n(Agent n)

  click Foreman "https://www.theforeman.org" "Foreman is a complete lifecycle management tool for physical and virtual servers."
  click Webhook "https://github.com/voxpupuli/puppet_webhook" "A webhook service that can trigger code deploys from source code repository updates."

  git --webhook--> Webhook
  Webhook --r10k code deploy--> PuppetServer

  PuppetDB --- PuppetServer
  Foreman --- PuppetServer

  PuppetServer --> Agent1
  PuppetServer --> Agent2
  PuppetServer --> Agents
  PuppetServer --> Agent_n
</div>


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
webhook events from your code repository and automate your code deploys.

### Code Deployment

[r10k](https://github.com/puppetlabs/r10k) is considered the default Puppet code
deployment tool. Install it on your master in your infrastructure and use it to
deploy your control repository as needed.

If you're a Golang shop, you might consider [g10k](https://github.com/xorpaul/g10k) as well.


### Puppet Stack

We recommend managing each of these components with the supported module.

* PuppetDB
    * [puppetlabs/puppetdb](https://forge.puppet.com/puppetlabs/puppetdb)
    * The default PostgreSQL database is recommended.
* Puppet Server
    * [puppet/puppetserver](https://forge.puppet.com/puppet/puppetserver)
* Puppet Agents
    * [puppetlabs/puppet_agent](https://forge.puppet.com/puppetlabs/puppet_agent)
* Puppet Metrics Dashboard
    * [puppetlabs/puppet_metrics_dashboard](https://forge.puppet.com/puppetlabs/puppet_metrics_dashboard)
