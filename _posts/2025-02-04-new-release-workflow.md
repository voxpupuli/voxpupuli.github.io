---
layout: post
title: Vox Pupuli Changelog - New Release process
date: 2025-02-04
github_username: bastelfreak
category: changelog
---

After a lot of work, we've a new GitHub workflow in place.
It can automatically:

* bump the metadata.json to the next patchlevel
* Or you provide the desired version number, then metadata.json will be bumped to it
* Afterwards the CHANGELOG.md will be updated
* REFERENCE.md will be updated if required
* A pull request will be created
* GitHub attaches the `skip-changelog` label

So people don't have to use a local container or Ruby installation to prepare a release.
However, it's still possible to generate everything locally and we intend to keep it that way.

The new workflow is documented at <https://voxpupuli.org/docs/releasing_version/>
