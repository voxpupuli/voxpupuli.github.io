---
layout: post
title: Purging ssh_authorized_keys with Puppet
github_username: blkperl
twitter_username: pdx_blkperl
date: 2014-08-24
---

Purging SSH authorized keys used to be the number one top-voted
[ticket][PUP-1174] in the Puppet issue tracker. A community member
[Felix Frank][ffrank] has solved the issue by adding a purge_ssh_keys parameter
to the User resource. The change was [merged][pull-2247] into the master branch in March
2014 and was [released][release-notes] in Puppet 3.6.0 and with some additional [bug fixes][bug-fixes] in
Puppet 3.6.2.

Let's take at the look at the code to enable this feature. Here we have a user
resource for the root user. All we need to do is set the purge_ssh_keys
attribute to true and Puppet will begin removing unmanaged keys.

```puppet
    user { 'root':
     ensure         => present,
     home           => '/root',
     uid            => '0',
     purge_ssh_keys => true,
    }
```

Before you enable this you will want to make sure that you have all your root
ssh_authorized_key resources defined in your Puppet manifests. In our example,
we have one ssh_authorized_key resource for our public root bastion key. In
following best practices the key data is populated from a Hiera lookup.

```puppet
    ssh_authorized_key { 'root@bastion':
      ensure => 'present',
      user   => 'root',
      type   => 'ssh-rsa',
      key    => hiera('bastion_pub_key')
    }
```

Now when we run Puppet on our clients we can see unmanaged keys getting removed.

```shell
(/Stage[main]/site::Sysadmin/Ssh_authorized_key[root@old_bastion1]/ensure) removed
(/Stage[main]/site::Sysadmin/Ssh_authorized_key[root@old_bastion2]/ensure) removed
```

You should check /root/.ssh/authorized_keys afterwards to make sure the
correct keys are in the file. If it looks good you can push the change
out to all of your machines.

If you're not yet using Puppet 3.6.2 or higher you can use the [ssh_keys][ssh_keys]
Puppet module written by [nightfly][nightfly] which works around the issue by implementing a new resource
with the concat module for a backend.

Now you are all set to go deploy this in your infrastructure.

Happy puppeting!

[ssh_keys]: https://forge.puppetlabs.com/nightfly/ssh_keys
[PUP-1174]: https://tickets.puppetlabs.com/browse/PUP-1174
[ffrank]: https://github.com/ffrank
[pull-2247]: https://github.com/puppetlabs/puppet/pull/2247
[release-notes]: https://docs.puppetlabs.com/puppet/latest/reference/release_notes.html#feature-purging-unmanaged-ssh-authorized-keys
[bug-fixes]: https://docs.puppetlabs.com/puppet/latest/reference/release_notes.html#fixes-to-purgesshkeys
[nightfly]: https://github.com/nightfly19
