---
layout: post
title: Factset overwrite vulnerabilty in OpenVoxDB
date: 2026-11-19
github_username: binford2k
---

Another day, another CVE. Gotta say though, I'm pretty glad not to be working at MITRE these days.
They must be utterly swamped right now.

In any case, today's CVE comes to you courtesty of OpenVoxDB and it's fixed in the `openvox-termini` package versions 9.2.1 and 8.18.1.

**tl;dr:** If you're using OpenVoxDB, then please upgrade the `openvox-termini` package to versions `9.2.1` or `8.18.1`, depending on which track you're currently running.
Don't forget to restart OpenVox Server to activate the updated terminus.
{: .alert .alert-warning }

## Summary

Let's do a quick refresher on the lifecycle of OpenVox facts.

When the agent starts a run, it generates facts and sends them to the server along with the catalog request.
The server combines them with trusted information from the agent's SSL certificate and uses them during compilation.
It also caches these facts in OpenVoxDB where they can be used for other purposes; dashboards, OpenBolt target lists, `puppetdb_query()` calls, etc.

Outside of regular catalog compilation, agents can update their own cached facts using the `/puppet/v3/facts` endpoint.
The flaw fixed in this release is that OpenVoxDB was not validating that the factset being stored with this endpoint actually represented the agent submitting the facts!

Now, to be clear, this doesn't directly affect classification or Hiera lookups.
Those will always use the fresh factset submitted by the agent.
What is affected is any classification using or gated behind `puppetdb_query()` calls or any OpenBolt plans that use a `puppetdb_query()` or OpenBolt tasks that use PQL to select a list of targets.
This would also affect any custom administration tooling that used facts from OpenVoxDB.

In particular, this could lead to administrative actions intended for one node actually executing on another node, which a skilled attacker could leverage via social engineering to achieve privilege escalation.

More details can be seen in the [advisory](https://github.com/OpenVoxProject/openvoxdb/security/advisories/GHSA-859m-7qpm-85p7).

## On Responsible Disclosure

There is more to the story though. Perforce ***did not notify us*** of the CVE until after they'd found, fixed, and shipped their releases.
This left us scrambling today to find, validate, assess impact, fix, and ship our own updates so that you were not exploited.
We identified the root cause in just over an hour and published a fix in five hours and seventeen minutes.
But there should have been more time for field validation and following up with the reporter to ensure completeness of the fix, and so on.

Let's compare that to the recent RCE vulnerability in OpenVox Server.
We were notified along with Perforce of the vulnerability and within a day, we were confident in our root cause analysis.
Within three days we had a tested fix ready to go and we contacted Perforce to share our findings and coordinate releases.
Perforce has more moving parts and a less elegant release pipeline, so they needed some lead time to get their release out the door.

***So we put our advisories under embargo and waited several weeks for them!***

Responsible disclosure doesn't work if you only do it when it benefits you.
{: .alert .alert-success }

We could have released early, but that would have put Perforce customers at risk and that is not acceptable.
By delaying our release, all the end users of the combined OpenVox and Puppet community were able to get the fixes at the same time and didn't leave anyone at an elevated risk.
This benefits everyone and engenders trust in the entire ecosystem, no matter who your vendor is.
Without this collaboration, end users lose trust in that ecosystem: OpenVox users cannot trust the modules coming from Puppet, Puppet users cannot trust the components coming from OpenVox, and *everybody has a higher level of risk*.

Perforce's actions today put us all at risk and eroded trust in the Puppet ecosystem.
The rational response these actions incentivize is for us to respond in turn by declining to share security information with them next time around.
Obviously we will not stoop to that level and will continue to prioritize the interests of all users and customers when responding to security issues.

We invite Perforce to do the same.
