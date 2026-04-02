---
layout: post
title: Enhanced module & openvox-agent testing
date: 2026-04-02
github_username: bastelfreak
---

Ever wanted to make changes to openvox-agent but unsure how to test it? We got you covered!

Since a long time, we have [a workflow in the openvox repo](https://github.com/OpenVoxProject/openvox/actions/workflows/build.yml) to build all packages.
Anyone with write permissions to the repo can trigger the workflow.
The workflow takes a git ref (a branch name) as input and will take that as a source for the packages.
All build artifacts will be published as GitHub artifacts and optionally to our [artifacts server](https://artifacts.voxpupuli.org/openvox-agent/).
It usually takes around 10 minutes between finishing a build and publishing it to our server.

[Due to recent changes in our Vox Pupuli module pipelines](https://github.com/voxpupuli/gha-puppet/pull/95), our module CI can now be triggered manually as well, not just by pull requests.

This is very helpful to rerun the module tests on the HEAD branch of the module.

![CI overview]({{ site.url }}{{ site.baseurl }}/static/images/run-ci.png)

If the module has acceptance tests, there are also a few more options.

![CI options 1]({{ site.url }}{{ site.baseurl }}/static/images/ci-details-1.png)

By default, we generate a CI matrix based on the openvox/puppet major versions in metadata.json multiplied by all supported OS major versions in metadata.json.
This basically allows us to test 5 different collections right now:

* puppet7
* puppet8
* openvox7
* openvox8
* staging

If you set the collection to `staging`, the first and third option in the dropdown become relevant.
In the third option, you can provide a staging package version.

![CI options 2]({{ site.url }}{{ site.baseurl }}/static/images/ci-details-2.png)


Those versions map to the packages built by the [workflow in the openvox repo](https://github.com/OpenVoxProject/openvox/actions/workflows/build.yml).
The first option lists the download server.
It defaults to our own artifacts server, but users can provider their source if they like (for example if you built packages locally).

You can already use this in our [puppet/example](https://github.com/voxpupuli/puppet-example/actions/workflows/ci.yml) repo and with the next modulesync_config release we will make this availablle to all our modules as well.
