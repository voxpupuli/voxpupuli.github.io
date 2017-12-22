---
layout: post
title: Puppet_Webhook reaches 1.0.0
date: 2017-12-21
github_username: dhollinger
twitter_username: moduletux
---

We are excited to announce that after nearly two months of development we are releasing version 1.0.0 of the Puppet_Webhook Sinatra REST Server for R10K and Puppet.

### What is Puppet Webhook?

Puppet_Webhook is a standalone replacement for the Webhook script that has been bundled with the [puppet-r10k](https://github.com/voxpupuli/puppet-r10k) module.

### Why rewrite the Webhook script as a gem?

The purpose behind this work is to provide our users with the same functionality that already exists with the current webhook while also providing improved quality within the code itself. While the webhook script has worked thus far for us and our users, it was becoming increasingly difficult to maintain and update the code when needed.

The current iteration of the script is Ruby code embedded in a Puppet ERB template. As such, we are unable to write tests against the script when making changes and even ended up with mistakes in the code due to IDEs and Text Editors formatting it as ERB rather than Ruby code.

Additionally, this also allows us to add additional functionality and even a plugin framework to allow users to extend the REST API to fit their own needs.

### How can I try it now?

You can, as of today, download the application from RubyGems.org using the gem command:

`gem install puppet_webhook`

Shortly after the New Year, we will begin working on building RPM, Deb, and Arch packages that provide:

* The application and its dependencies
* SystemD Unit and SysVInit Service files
* Default configuration and config directories
* Logging and PID directories that the gem (currently) doesn't provide

For more information on running Puppet_Webhook, see the [README.md](https://github.com/voxpupuli/puppet_webhook/blob/master/README.md) file for usage instructions.

### So, what's in the future?

As with any good software project, the release of 1.0.0 is just the beginning. We intend to continue iterating on what we've built to provide our users with the best experience we can.

Upcoming improvements and features include:

* Integrate Puppet_Webhook in to the [puppet-r10k](https://github.com/voxpupuli/puppet-r10k) module, replacing the old script.
* Add additional functionality to the application, such as a `/decommission` endpoint for cleaning nodes and certs from the puppet master.
* Build a plugin framework so that users and the community can extend functionality with their own plugins/gems.
* Improve testing to better ensure the quality of our code and, by extension, our releases.
* Replace the current system calls with native Ruby Library calls for executing backend functionality (where possible).
* Anything else that this amazing community can come up with (as long as it benefits the community as a whole).

If you have any questions, feedback, or want to know how to get involved, feel free to reach out to us in the following ways:

* IRC: `#voxpupuli` on Freenode.
* Slack: `#voxpupuli` on [Puppet Slack](http://slack.puppet.com)
* Mailing Lists: [Vox Pupuli](https://groups.io/g/voxpupuli) on Groups.io
* Twitter: @voxpupuliorg