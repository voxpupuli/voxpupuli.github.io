---
layout: page
title: Installing OpenVox
subsection: openvox
---

OpenVox package downloads are currently sponsored by [Overlook InfraTech](https://overlookinfratech.com).
As of release 8.11, OpenVox is functionally equivalent to Puppet; the command names are the same, the configuration file paths are the same, etc.
The major differences are in help text output, man pages, and so on.
This means that you can continue to use all the commands, modules, tooling, etc that you're used to, but at this time *you cannot install both Puppet and OpenVox on the same system*.

> 🔔 Tip: If you want to use Puppet code to manage your systems, if you have strange dependencies, if you're migrating from Puppet Enterprise, or if you have Puppet modules installed as system packages then see the [advanced options](#advanced-options) sections below.
>
> * [Alternative Puppet uninstallation options](#alternative-puppet-uninstallation-options)
> * [Managing OpenVox with OpenVox](#managing-openvox-with-openvox)
>     * [Managing Repositories](#managing-repositories)
>     * [Managing the Server/Client](#managing-the-serverclient)
>     * [Foreman Integration](#foreman-integration)
{: class="alert alert-primary callout" }

We encourage you to try out OpenVox on a fresh test system, the way you would for any major system package.
If you'd rather try it on an existing system or develop a migration process, then the new OpenVox packages will uninstall and replace the existing legacy Puppet packages.

You do not need to purge configuration files because OpenVox will continue to use them as they are.
However, **before getting started on the migration you should strongly consider backing up the entire `/etc/puppetlabs/` tree** in case of accidents.

First enable the repository, based on your Linux distribution.
Choose the appropriate `openvox8-release` repo package from either of these locations and install it.

* Debian family:
  * [apt.voxpupuli.org](https://apt.voxpupuli.org/)
* RedHat family:
  * [yum.voxpupuli.org](https://yum.voxpupuli.org/)

(There are experimental builds for Windows at [artifacts.voxpupuli.org/downloads/](https://artifacts.voxpupuli.org/downloads/), and stable macOS builds at [downloads.voxpupuli.org/mac](https://downloads.voxpupuli.org/mac/))

Then install the packages you want.

* Debian family
  * `apt install openvox-agent`
  * `apt install openvox-server`
  * `apt install openvoxdb`
* RedHat family
  * `yum install openvox-agent`
  * `yum install openvox-server`
  * `yum install openvoxdb`

If you have backed up config files, then restore them now.

### 🎉 That's it! You're done!
Feel free to read the rest of the page for more options.

-----

## Advanced Options

### Alternative Puppet uninstallation options

There are some cases in which you might have to take more steps to safely remove legacy Puppet from your system.

* If you're migrating from Puppet Enterprise you can use the `puppet-enterprise-uninstaller` script on each node as described in [their docs](https://www.puppet.com/docs/pe/latest/uninstalling.html).
* If you're using distro provided packages, then you might have a bigger job.
  For example, if you're using Debian packages, you may have several Puppet modules packaged as `.deb` packages that you'll have to move to your `Puppetfile`.
  You might consider waiting until your distro packages OpenVox.
    * If you do want to migrate now, then remove any puppet packages and dependencies you have installed using your distro tools.
        * Debian family
          * `apt autoremove <packagename>`
        * RedHat family
          * `yum autoremove <packagename>`
    * You might also consider (carefully) cleaning up unused dependencies afterwards by running `apt` or `yum` autoremove without a package name.

You do not need to remove the `[apt|yum].puppet.com` repositories although the only thing you'll be able to use them for going forward is installing historical Puppet releases.


### Managing OpenVox with OpenVox

#### Managing Repositories

You can add the APT or YUM repositories with OpenVox - this should do the same thing as using the release packages:

```puppet
include apt

$os_name = downcase($facts['os']['name'])
apt::source { 'openvox8-release':
  comment  => "OpenVox 8 ${os_name}${facts['os']['release']['major']} Repository",
  location => 'https://apt.voxpupuli.org',
  release  => "${os_name}${facts['os']['release']['major']}",
  repos    => 'openvox8',
  key      => {
    'name'   => 'openvox-keyring.gpg',
    'source' => 'https://apt.voxpupuli.org/openvox-keyring.gpg',
  },
}
```

```puppet
include yum
$release=8
$os_name = $facts['os']['name'] ? {
  "Fedora" => "fedora",
  "Amazon" => "amazon",
  default  => "el",
}

yum::install { "openvox${release}-release":
  ensure => 'present',
  source => "https://yum.voxpupuli.org/openvox${release}-release-${os_name}-${facts['os']['release']['major']}.noarch.rpm"
}
```

#### Managing the Server/Client

You can manage OpenVox with several existing modules:

* [`puppet-puppet` from `theforeman`](https://github.com/theforeman/puppet-puppet)
* [`puppetlabs-puppetdb`](https://github.com/puppetlabs/puppetlabs-puppetdb)

These modules currently default to installing packages named `puppet*`, so they will cause `openvox*` packages to be removed.

To install OpenVox, you can use this `hiera` data:

```yaml
puppet::client_package: openvox-agent
puppet::server::package: openvox-server
puppetdb::puppetdb_package: openvoxdb
puppetdb::master::config::terminus_package: openvoxdb-termini
```

Note that you will need to have the OpenVox repositories available (using one of the methods above) for this to work properly.
If the OpenVox repositories are available, this will cause Puppet to be removed and OpenVox to be installed.


#### Foreman integration

Foreman installs the package `puppet-agent-oauth` which is a system packaged Ruby gem with native code.
It provides the [oauth](https://rubygems.org/gems/oauth) gem for the Puppet Agent Ruby environment and depends on `puppet-agent`.
The OpenVox packages don't have a `provides puppet-agent` flag yet, so this will cause dependency errors.
As a workaround you'll need to manage the gem directly instead of letting the Foreman module handle it.
Note that this will require build essentials and ruby development packages.

Add this to your Hiera config:

```yaml
---
foreman::providers::oauth: false
```

And then manage the gem directly in Puppet code:

```puppet
package { 'oauth':
  ensure   => 'installed',
  provider => 'puppet_gem',
}
```

-----

## Sponsorship

Many thanks to Lance and the [OSU Open Source Lab](https://osuosl.org).
They do so much for the open source world and deserve far far more recognition for it.
