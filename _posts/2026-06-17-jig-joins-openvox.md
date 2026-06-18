---
date: 2026-06-17
github_username: avitacco
layout: post
title: Jig joins Vox Pupuli
---

## What is happening
We are pleased to announce that [jig](https://github.com/voxpupuli/jig) has
joined the Voxpupuli project. Jig is a fast and dependency-free reimplementation
of the Puppet Development Kit (PDK). By bringing it under the Voxpupuli
umbrella, we are providing the community with a reliable and sustainable
module-authoring tool that is maintained in a neutral, long-term environment.
>>>>>>> fb386ce (Replacing all of the Openvox instances with Voxpupuli)

### What jig does
Jig is designed to support the daily tasks involved in authoring Puppet modules.
It provides scaffolding for new modules, classes, defined types, facts,
functions, providers, tasks, transports, and tests, ensuring that the standard 
directory layout and specification files are generated automatically.

Jig also assists with building and packaging modules for distribution on the
Forge. It supports validation and unit testing, running the necessary checks
that are expected prior to a release. Jig streamlines the process of creating
versioned releases.

What distinguishes jig is its delivery as a single static binary, requiring
neither a Ruby runtime nor any external dependencies. Once downloaded and placed
in your system path, it is immediately operational. There is no need for
bundler, no risk of gem conflicts, and no requirement for a large runtime in
your continuous integration environments. This approach results in fast cold
starts in CI and a straightforward, single-file setup for developers.

### Why it matters for Vox Pupuli
With the transition of PDK to a closed-source model, the open Puppet ecosystem
lost a tool that many module authors had depended on for years. Voxpupuli was
established to ensure that this ecosystem remains open and governed by the
community, and providing robust module tooling is a key aspect of that mission.

Jig has always been open source, and its move into Voxpupuli ensures that it is 
no longer dependent on a single individual's account or availability. Issues,
releases, and the project roadmap are now managed within the community,
allowing the tool to evolve alongside the broader Voxpupuli toolchain and to
benefit from a wider range of contributors.

### Thanks
Jig has already been strengthened by the efforts of early contributors and
testers. I would like to extend particular thanks to Ben Ford and Martin Alfke
for their contributions and feedback, as well as to everyone who provided issues
and tested the tool during its initial development.

### Try it
If you are involved in authoring Puppet modules, I encourage you to try jig and
share your experiences, both positive and negative. The repository is now
maintained within the Voxpupuli organization, and contributions are welcome. 
This is a community-driven tool, and its future direction will be shaped by all
of us.

We invite you to visit https://github.com/voxpupuli/jig to download jig, read
documentation, and learn how you can contribute to the project.
