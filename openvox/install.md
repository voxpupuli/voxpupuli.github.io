---
layout: page
title: Installing OpenVox
subsection: openvox
---

As of release 8.11, OpenVox is functionally equivalent to Puppet; the command names are the same, the configuration file paths are the same, etc.
The major differences are in help text output, man pages, and so on.
This means that you can continue to use all the commands, modules, tooling, etc that you're used to, but at this time *you cannot install both Puppet and OpenVox on the same system*.

> 🔔 Tip: If you want to use Puppet code to manage your systems, if you have strange dependencies, if you're migrating from Puppet Enterprise, or if you have Puppet modules installed as system packages then see the [advanced options](#advanced-options) sections below.
>
> * [Installing Foreman with OpenVox](#installing-foreman-with-openvox)
>     * [Using the foreman-installer](#using-the-foreman-installer)
>     * [Using the foreman-foreman module](#using-the-foreman-foreman-module)
> * [Porting a Foreman infra to OpenVox](#porting-a-foreman-infra-to-openvox)
> * [Managing OpenVox with OpenVox](#managing-openvox-with-openvox)
>     * [Managing Repositories](#managing-repositories)
>     * [Managing the Server/Client](#managing-the-serverclient)
>     * [Foreman Integration](#foreman-integration)
> * [Alternative Puppet uninstallation options](#alternative-puppet-uninstallation-options)
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
* Windows family:
  * [downloads.voxpupuli.org/windows](https://downloads.voxpupuli.org/windows)
* macOS family:
  * [downloads.voxpupuli.org/mac](https://downloads.voxpupuli.org/mac)

Then install the packages you want.

* Debian family
  * `apt install openbolt`
  * `apt install openvox-agent`
  * `apt install openvox-server`
  * `apt install openvoxdb`
  * `apt install openvoxdb-termini`
* RedHat family
  * `yum install openbolt`
  * `yum install openvox-agent`
  * `yum install openvox-server`
  * `yum install openvoxdb`
  * `yum install openvoxdb-termini`

If you have backed up config files, then restore them now.

### 🎉 That's it! You're done!
Feel free to read the rest of the page for more options, especially if you're
also intending to use Foreman.

-----

## Advanced Options

### Installing Foreman with OpenVox

> 🚨 Tip: When using Foreman and OpenVox together, you must install OpenVox first.
> See [Porting a Foreman infra to OpenVox](#porting-a-foreman-infra-to-openvox) for instructions on how to recover if you started with Foreman.
{: class="alert alert-warning callout" }

There are two ways to install Foreman: via the `foreman-installer` or via the `theforeman-foreman` module. ***In both cases, you must install OpenVox first***.

#### Using the `foreman-installer`

Edit `/etc/foreman-installer/custom-hiera.yaml` to include these Hiera settings.
If you intend to continue managing your Foreman installation with puppet code, then follow the instructions in the [Managing OpenVox with OpenVox](#managing-openvox-with-openvox) sections to persist these settings into your standard Hiera data files.

``` yaml
---
puppet::client_package: openvox-agent
puppet::server_package: openvox-server
puppetdb::puppetdb_package: openvoxdb
puppetdb::master::config::terminus_package: openvoxdb-termini
foreman::providers::oauth: false
```
Then manually install the `oauth` gem into OpenVox's gempath.

```
# /opt/puppetlabs/puppet/bin/gem install oauth
```

And finally, use [Foreman's Quickstart Guide](https://theforeman.org/manuals/3.15/quickstart_guide.html) to install Foreman.

#### Using the `theforeman-foreman` module

1. Ensure that OpenVox is installed, then follow the instructions in the [Managing OpenVox with OpenVox](#managing-openvox-with-openvox) sections to configure Hiera properly.
1. Add `theforeman-foreman` to your `Puppetfile` and deploy it.
1. Use the [documentation](https://github.com/theforeman/puppet-foreman) to classify your server node to your requirements and then run the OpenVox agent to configure everything.

### Porting a Foreman infra to OpenVox

> 🚨 Tip: Resetting the Foreman answers file will remove any customization you're currently using, so you'll need to specify all your desired options again.
> We suggest backing up the file and then diffing it against the new version to see what changed.
{: class="alert alert-warning callout" }

If you're already running Foreman and you want to switch it to be backed by OpenVox then you have a little bit of housekeeping to do first.
First, use your system package manager to remove the `puppet-agent-oauth` package.
If you use the `foreman-installer` to manage and upgrade your setup, then ensure that you restore the cached answers file to the default values, or it will continue to use old paths.

<details class="card" style="clear: both;">
<summary class="card-header">Debian Family</summary>
<pre><code># rm /etc/foreman-installer/scenarios.d/foreman-answers.yaml
# apt install --reinstall -o Dpkg::Options::="--force-confmiss" foreman-installer</code></pre>
</details>
<details class="card" >
<summary class="card-header">RedHat Family</summary>
<pre><code># rm /etc/foreman-installer/scenarios.d/foreman-answers.yaml
# yum reinstall foreman-installer</code></pre>
</details>
<details class="card" >
<summary class="card-header">Others</summary>
<pre><code># curl https://raw.githubusercontent.com/theforeman/foreman-installer/refs/heads/develop/config/foreman-answers.yaml \
    -o /etc/foreman-installer/scenarios.d/foreman-answers.yaml</code></pre>
</details>

If you're porting from system installed Puppet, then you may have to purge package configuration or remove legacy directory structures.
For example, you might `rm -rf /etc/puppet`, making sure to back up or move critical configuration files to new locations.
Make sure you ensure that files like `puppet.conf` don't reference legacy locations.
Note that in most cases, paths don't actually need to be specified because the defaults are correct.

Double check that you have no `puppet`, `puppet-agent`, or any other Puppet related packages installed and that at least `openvox-agent` is installed as per the instructions at the top of the page.

Ensure that the `aio_agent_version` fact returns the appropriate version before continuing.
Then follow the [installation instructions](#installing-foreman-with-openvox) above to update your infrastructure.


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
puppet::server_package: openvox-server
puppetdb::puppetdb_package: openvoxdb
puppetdb::master::config::terminus_package: openvoxdb-termini
```

Note that you will need to have the OpenVox repositories available (using one of the methods above) for this to work properly.
If the OpenVox repositories are available, this will cause Puppet to be removed and OpenVox to be installed.

#### Foreman integration

Currently no special configuration is required anymore for integrating Foreman and Openvox.

Previously a workaround for the package `puppet-agent-oauth` was required, but it is not required anymore and can be safely removed.

Remove this from your Hiera config (if it exists):

```yaml
---
foreman::providers::oauth: false
```

Remove the following from the Puppet code (if it exists):

```puppet
package { 'oauth':
  ensure   => 'installed',
  provider => 'puppet_gem',
}
```

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

-----

## Sponsorship

Many thanks to Lance and the [OSU Open Source Lab](https://osuosl.org).
They do so much for the open source world and deserve far far more recognition for it.
