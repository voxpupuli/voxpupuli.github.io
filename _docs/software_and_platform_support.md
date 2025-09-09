---
layout: post
title: Software and Platform Support
date: 2025-09-09
summary: Vox Pupuli policy on supporting upstream software and which language or frameworks we prefer to maintain
---

> * [Support Lifecycle](#support-lifecycle)
>     * [Operating Systems](#operating-systems)
>     * [Puppet Versions](#puppet-versions)
>     * [Vox Pupuli Modules](#vox-pupuli-modules)
> * [Frameworks and Languages](#frameworks-and-languages)
>     * [Client Tooling](#client-tooling)
>     * [Server Side Tooling](#server-side-tooling)
{: class="alert alert-primary callout w-33" }

As a part of Vox Pupuli's mission to provide a home for modules and tooling that still have a userbase and need development, we need to define a clear support strategy for what operating systems, dependencies, languages, frameworks, and upstream software we will adopt and support and for how long those will be supported.

As we operate entirely on the graces of our community members being willing to voluntarily contribute, we also need to be respectful of their time and resources and not add undue stress in maintaining our ecosystem.


## Support Lifecycle

To account for this, we no longer support any software or operating system after the date that the maintainers* have marked said software or operating system as End of Life, hereafter referred to as "EOL".
However, this does not mean we will always immediately remove code that allows for the module to run on EOL'd software or operating systems, but the community will no longer be expected to provide support to users for that software.
The list of supported operating systems in `metadata.json` is always leading.

> _*maintainers include, but are not limited to, the community, company, or organization that maintains ownership over a specific piece of software or project._
{: class="alert alert-info" }


### Operating Systems

An Operating System is no longer considered supported once it reaches an EOL date determined by the upstream maintainer of the operating system.
To ensure our users have enough time to adjust, we will take the following steps to ensure as seamless of a transition as possible:

1. A deprecation PR will be created no later than 3 months before an Operating System's EOL date.
2. Removal of the EOL version from the metadata.json and tests and related code to be completed by the EOL date.
3. Issues relating to the EOL operating system will no longer be addressed after the EOL date.
4. Pull Requests specific to the EOL operating system will no longer be accepted.

If a user still needs to use the EOL operating system, then they must either:

* Pin their module version to a version compatible with their operating system.
* Fork the module and maintain it internally.

The [puppet_metadata](https://github.com/voxpupuli/puppet_metadata/) gem is the authoritative source for EOL data used in the Vox Pupuli testing framework.
Tests will only run for operating systems that are still supported according to the puppet_metadata gem.

Sources for end-of-life dates:

* OpenSUSE - [OpenSUSE Documentation](https://en.opensuse.org/Lifetime)
* All others - [EndOfLife.software](https://endoflife.software/operating-systems) or [EndOfLife.date](https://endoflife.date/tags/os)

### Puppet Versions

Puppet support will fall in-line with the Puppet Open Source project's lifecycle.

1. A Puppet version that has been labelled as EOL by the Puppet Open Source project, will no longer be supported by Vox Pupuli.
2. A deprecation PR will be created no later than 6 months before EOL.
3. All tests and data in metadata.json will be removed no later than the EOL date for that version. Code specifically for the EOL version will be removed as well.
4. Pull Requests and Issues relating to the EOL version of Puppet will no longer be accepted.
5. Issues are only valid if they affect supported versions.

#### Vox Pupuli Modules

Modules are considered supported only at their current latest release and roll forward, not back in case of any bugs or issues.

1. Modules are supported at their latest current version.
    1. Latest version is determined by the version number based on the following order:
        1. Major
        2. Minor
        3. Patch
        4. Examples:
            1. `5.1.1` is the latest version and supported.
            2. `5.1.0` is not supported.
            3. `4.9.9` is not supported.
    2. Exceptions:
        1. The maintainer may make exceptions to the above rule as long as it does not create undue expectations for the community.
2. For all other documentation on Archived Modules see [Deprecated and Archived Modules](https://voxpupuli.org/docs/deprecated_and_archived_modules/)


## Frameworks and Languages

The OpenVox / Puppet ecosystem is already large and complex.
For example, all but casual usage of Puppet code requires at least a basic understanding of both the Puppet DSL and of Ruby for ERB templates and rspec tests.
Our main goal with framework selection is to simplify this ecosystem as much as we can and lower the barrier to contribution.


### Client Tooling

Many tools in the ecosystem run on developer or user workstations.
For example, the [openvoxdb-cli](https://github.com/OpenVoxProject/openvoxdb-cli/) allows one to run queries against OpenVoxDB from any workstation with the appropriate certificates installed.
Our default choice for new tooling is to use the Ruby language and to leverage existing libraries in the ecosystem.
For example, if writing a tool to use the Puppet Forge API, you should default to using Ruby and the [`puppet_forge`](https://rubygems.org/gems/puppet_forge) library.

This obviously does not mean that you cannot build your own projects using whatever languages or frameworks you want or even to contribute those to Vox Pupuli, it's just less likely that you'll get as many contributors.

Some exceptions to this do exist.
* Some Ruby gems, especially those with native code compiled with Cygwin, can cause very slow startup times on Windows. This is the opposite of a good user experience for a CLI tool. This problem is getting better over time, but do keep it in mind.
* If you are writing a plugin or integration for an existing tool, then obviously you will need to use the language and frameworks supported. For example, [Puppet's VSCode extension](https://github.com/puppetlabs/puppet-vscode) is implemented in TypeScript.


### Server Side Tooling

Several critical server side projects in the OpenVox ecosystem are implemented in Clojure.
This is such a niche language that Puppet is [mentioned by name on the wikipedia page](https://en.wikipedia.org/wiki/Clojure#Impact) as one of the top users of the language.
Very few people in the OpenVox ecosystem know it, so please do not create more projects using this language unless there is a very compelling reason to do so.

In general, our recommendation is to follow roughly the same guidelines as the client tooling section.
Tools intended to coexist with [Foreman](https://theforeman.org) should also keep those dependencies in mind.
