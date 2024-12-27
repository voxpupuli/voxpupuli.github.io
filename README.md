# voxpupuli.github.io [![Build Status](https://travis-ci.org/voxpupuli/voxpupuli.github.io.svg?branch=master)](https://travis-ci.org/voxpupuli/voxpupuli.github.io)

The [https://voxpupuli.org](ttps://voxpupuli.org) site. Have a look at it to see
what this is all about.

## Table of Contents

- [Table of Contents](#table-of-contents)
- [Building this site](#building-this-site)
- [Puppet Plugins](#puppet-plugins)
  - [Tool definition format](#tool-definition-format)
    - [Tool Schema](#tool-schema)
    - [Plugin Schema](#plugin-schema)
  - [What's a tool vs. a plugin](#whats-a-tool-vs-a-plugin)
- [Contribution](#contribution)
- [Writing docs](#writing-docs)
- [License](#license)

## Building this site

* `bundle install`
* `bundle exec jekyll serve -w --config _config.yml,_config-dev.yml`

You can also use the rake tasks defined in the `Rakefile`:

* `build`: `jekyll build`
* `validate`: uses html-proofer to check the generated site
* `clean`: removes the `./_site` directory Jekyll generated

## Puppet Plugins

Tools and plugins that appear on the Plugins page of our site
are defined in the `_data/tools` directory. Tools without plugins are going to
be listed in the table under the `Tools` header. Tools with plugins will have
their own header and table listing the plugins defined for that tool.

### Tool definition format

There's a single hash in each tool's definition that describes the tool and
optionally contains an array of plugins that can be used with that tool. A tool
that doesn't have any plugins will be listed in the table under the Tools header
while a tool that does have plugins will have its own header and a table listing
all plugins in the tool's `plugins` array.

#### Tool Schema

| Key            | Value Data Type | Required or Optional |
| -------------- | --------------- | -------------------- |
| `name`         | String          | Required             |
| `display_name` | String          | Required             |
| `url`          | String          | Required             |
| `description`  | String          | Required             |
| `plugins`      | Array           | Optional             |

#### Plugin Schema

| Key            | Value Data Type | Required or Optional |
| -------------- | --------------- | -------------------- |
| `name`         | String          | Required             |
| `url`          | String          | Required             |
| `description`  | String          | Required             |

### What's a tool vs. a plugin

The difference can be kind of fluid, so I figured it would be helpful to define
plugin and tool.

A *plugin* cannot generally be used independent of another tool. Plugins add
functionality to another tool. An example of a plugin is `beaker-libvirt`
because it enables libvirt as a hypervisor in Beaker.

A *tool* can generally be used independent of another specific tool or it is a
tool that has plugins itself. An example of a tool is `rspec-puppet` because it
has plugins. Another example of a tool is `modulesync` because it can be used
independent of another tool.

## Contribution

We happily accept contributions of all kind. Did you spot a typo somewhere? Did
you do a talk about Vox Pupuli that you would like to link to? Do you want to
write a plog post?

Feel free to send us a pull request with your changes or raise an [issue](https://github.com/voxpupuli/voxpupuli.github.io/issues/new).
We currently require all commits in this repo to be signed with gpg, so
please configure your git client properly. Let us know if you need some help. We're also
reachable via our IRC channel `#voxpupuli` on [Libera](https://web.libera.chat/?#voxpupuli)
and [`#voxpupuli`](http://puppetcommunity.slack.com/messages/voxpupuli/) on the
[Puppet Community Slack](http://slack.puppet.com).

We test if the pages still build properly via travis, You can run this locally
by running `bundle exec rake test`.

## Writing docs

Docs can have the following header:

```
---
layout: post
title: Deprecated and Archived Modules
date: 2019-11-29
summary: Vox Pupuli policy on deprecating and archiving modules
github_username: binford2k
last_updater: bastelfreak
---
```

* `title` will be used in the URL + in the header
* `date` is assumed as the date of publishing
* `summary` is a short roundup used on the navigation page
* `github_username` the GitHub username of the original author, optional attribute
* `last_update` the GitHub username of the author from the last update, optional attribute (if it was updated is determined by Jekyll automatically)

## License

Our website uses two licenses. The actual content uses
[CC BY-SA 4.0](https://creativecommons.org/licenses/by-sa/4.0/). This is the
same license as our [logos](https://github.com/voxpupuli/logos#voxpupuli-logos)
use. The underlying scripts and code of our website use the
[Apache-2](http://www.apache.org/licenses/#2.0) license. The
[Apache-2](LICENSE) and the [CC BY-SA 4.0](LICENSE2) files are present in the
repository.
