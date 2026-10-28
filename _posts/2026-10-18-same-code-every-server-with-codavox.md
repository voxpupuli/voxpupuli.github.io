---
date: 2026-10-18
layout: post
title: "Same code, every server: codavox for OpenVox"
github_username: miharp
excerpt: "codavox gets the same version of your Puppet code onto every OpenVox server, turns on static catalogs, and shows which version each server runs."
---

<link href="https://cdn.jsdelivr.net/npm/asciinema-player@3.17.0/dist/bundle/asciinema-player.css" rel="stylesheet" integrity="sha384-05cmIVRzN7mR7nmqajPpGPUPqJ5VyTAGHL1xJuiGWfhpWDp5hEfBk50kr21f3ILM" crossorigin="anonymous">
<style>.cast { margin: 1.25rem 0 1.75rem; }</style>

[OpenVox](https://voxpupuli.org/openvox/) is the community-maintained fork
of Puppet. When one OpenVox server is no longer enough, you add compilers:
extra servers that share the work of building catalogs, the list of
everything Puppet should apply to a node. Every compiler then needs the same
version of your Puppet code. Puppet Enterprise has Code Manager and file
sync for that; open source leaves it to you. Get it wrong and one compiler
serves your change while another still serves yesterday's code, with nothing
to tell you which is which.

I wrote [codavox](https://github.com/miharp/codavox) for that job. It is
young, at version 0, and lives under my name for now; my plan from the
start has been to donate it to Vox Pupuli if there is interest.

## Why r10k alone is not enough

r10k, the usual tool for deploying a control repo, changes the code in
place, on each server separately. A compiler that is down when you push
misses the deploy, a catalog built mid-deploy can mix old and new code, and
nothing tells you which server runs which version.

## How codavox works

You deploy on the main server with `codavox deploy production`. codavox
runs r10k there once, fingerprints the result as a `code_id`, and packs it
into an ordinary `.tar.gz` file. Each compiler, and the main server
itself, polls for a new version every 30 seconds, downloads it, checks the
fingerprint and switches to it in one step, never serving a half-copied
one. A compiler that was down catches up when it comes back. Agents need
nothing new: they keep asking their server for catalogs as before.

Each catalog then records the `code_id` it was built from, which makes it a
[static catalog](https://docs.openvoxproject.org/openvox/latest/static_catalogs.html). OpenVox Server supports static catalogs but has nothing to
supply the version, so out of the box it does without. With codavox, the
files agents manage from your modules come from the same version as their
catalog, so a deploy in the middle of a run can't hand an agent a file its
catalog never saw. And because the catalog already describes each file,
agents stop asking the server about every one of them on every run: fewer
requests for the compilers, and quicker runs.

The version also shows in every agent's output, `Applying configuration
version 'production-821a20908b17'`: the environment and the start of the
`code_id`. On the main server, `codavox provenance production-821a20908b17`
prints the git commit behind it, and one command shows where every server
stands:

```console
$ codavox compilers
COMPILER                ENVIRONMENT  CODE_ID       COMMIT        LAST POLL
puppet.example.com      production   821a20908b17  970ae0be96e5  7s ago
compiler01.example.com  production   821a20908b17  970ae0be96e5  15s ago
```

## Adding it

The [codavox module](https://forge.puppet.com/modules/miharp/codavox) sets
it up. The main server gets `include codavox::primary`, each compiler gets
`include codavox::agent` and `include codavox::server`, and Hiera says where
things are:

```yaml
codavox::basedir: '/etc/puppetlabs/code/environments'
codavox::publish_allow_roles: ['openvox_compiler']
codavox::agent_publisher: 'https://puppet.example.com:8150'
```

Compilers connect to the main server on port 8150 and prove who they are
with the Puppet certificates they already have, so there are no extra
passwords. Only the compilers you allow get your code: by a role in their
certificate, as above, or by name with `codavox::publish_allow_certnames`.
It works on a single server too, with `codavox::primary` alone.
[The whole change](https://github.com/miharp/openvox-demo-control/commit/5da65f47db5ae4d488501ff97fc843ea17e6892c)
to the control repo in the recording is 25 lines, including a few in
`scripts/config_version.sh` that set each catalog's configuration version;
without them, it stays r10k's.

The recording starts with a main server, a compiler and an agent already
running. One Puppet run on each server installs codavox. Then a change to
`/etc/motd`, a file agents get from a module, is deployed, and the agent's
next run applies it from a catalog whose configuration version carries the
same `code_id` the compiler reports.

<div id="demo" class="cast"><p><a href="{{ page.url | absolute_url }}#demo">▶ Recording: codavox gets the same code onto every server (plays on voxpupuli.org)</a></p></div>

Those servers, and the agent, were installed from my workstation with
[ovadm](https://github.com/miharp/ovadm), an OpenBolt module that does for
OpenVox what [peadm](https://github.com/puppetlabs/puppetlabs-peadm) does for
Puppet Enterprise, and the
[openvox_server](https://forge.puppet.com/modules/miharp/openvox_server)
module keeps them configured, but that is a subject for a future post.

## Trying it

If you would like to see codavox under Vox Pupuli, say so. And if you try
it, open an issue and tell me what works and what doesn't:

- [codavox](https://github.com/miharp/codavox) and its
  [module](https://github.com/miharp/puppet-codavox)
- [openvox-demo-control](https://github.com/miharp/openvox-demo-control), the
  control repo from the recording

The recording runs at real speed, with waits over four seconds cut and
routine output left out.

<script src="https://cdn.jsdelivr.net/npm/asciinema-player@3.17.0/dist/bundle/asciinema-player.min.js" integrity="sha384-s55nTYAdrPwGWmKKQ1lCnoB8H9LbqmsXsqqqPAHK2+T5h9IfI2dTXTDXJcZnySJD" crossorigin="anonymous"></script>
<script>
  // The recording slot holds a link for feed readers and browsers without
  // JavaScript; the player replaces it once its script has loaded.
  if (window.AsciinemaPlayer) {
    var el = document.getElementById('demo');
    el.textContent = '';
    AsciinemaPlayer.create(
      '{{ "/static/asciinema/codavox/demo.cast" | relative_url }}',
      el,
      { idleTimeLimit: 4, fit: 'width', poster: 'npt:0:3.3', preload: true, controls: true }
    );
  }
</script>
