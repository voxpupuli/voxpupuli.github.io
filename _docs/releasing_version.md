---
layout: post
title: Releasing a new version of a module
date: 2016-01-01
summary: How to perform a complete version release, including modulesync and publication.
---

Creating a release is a three step process:

1. Create a release PR
2. Review and merge the release PR
3. Do the actual release

## Before Preparing a release

Run [modulesync](https://voxpupuli.org/docs/updating-files-managed-with-modulesync/) to ensure the dotfiles are up-to-date.

Please make sure your git setup is configured for signing commits and tags.
For more information, see [commit signature guidance](https://docs.github.com/en/authentication/managing-commit-signature-verification/about-commit-signature-verification).

## Standard Release

### Create a Release PR

To automatically create a "release PR", you need to be a member of the `voxpupuli` GitHub organization.
Then you can browse to a module -> Actions -> `Prepare Release`.
This is a GitHub workflow.
It will automatically:

* bump the metadata.json to the next patch level
* Or you provide the desired version number, then metadata.json will be bumped to it
* Afterwards the CHANGELOG.md will be updated
* REFERENCE.md will be updated if required
* A pull request will be created
* GitHub attaches the `skip-changelog` label

### Review and Merge the Release PR

This will have generated updates to the CHANGELOG.md, review each PR in the CHANGELOG to make sure they're labeled properly so that the CHANGELOG is correct:

* backwards-incompatible - e.g. dropping EOL OSes, raising minimum required dependencies
* enhancement - e.g. new features
* bug/bugfix - just fixed buges
* docs/documentation
* dependencies
* modulesync - skips changelog, just meant for modulesync induced PRs
* backport-8.x - for OpenVox releases: To keep the mental load on diffs low, everything that can be backported will be backported. This create another PR with a cherry picked commit

Make sure that the version updated as expected.
Anything labeled backwards-incompatible should require a major version bump.
For voxpupuli this includes _removing Ruby/Puppet/OS versions for EOL_.

If you relabeled anything or the version is wrong, rerun the `Prepare Release` action.
Request feedback from the Vox Pupuli Community via the methods listed in the [Contact page](https://voxpupuli.org/connect/).

All commentary should be reviewed, but specifically looking for consensus around:

* Are there other changes that should get merged first?
* Are there discussions about the tagging of any of the changes in the CHANGELOG.md?
* Have you missed something needed for release?

Merge the PR when ready.
The person who does the merge of the PR is expected to do the release below.

See also this extensive guide an what to spot on reviews and what to label
[Review Guide](https://voxpupuli.org/docs/reviewing_pr/)

### Do the Actual Release

*Please note that in order to execute this workflow you must be in the __Collaborators__ group on GitHub for the module in question.*

Go to Actions -> `Create Git Tag`.
This workflow will create a signed git tag and push it.
This will automatically trigger the `Release` workflow, which will build the module and upload it to the forge.puppet.com.
