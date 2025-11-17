---
layout: post
title: Gopass Secret Stores
date: 2025-11-17
summary: How the PMC and various SIGs manage passwords and other secrets.
---

* TOC
{:toc}
{: class="alert alert-primary callout w-33" }

[gopass](https://www.gopass.pw/) is a neat open source tool for secret management.
It handles (GPG) encryption and stores data in a git repo.
It's designed primarily to manage passwords, but can effectively manage anything that can be represented in text.

Our existing secret stores that you have access to may be found with a [GitHub search](https://github.com/orgs/voxpupuli/repositories?q=gopass-).

## Getting Started

### Installation

The [upstream docs](https://github.com/gopasspw/gopass/blob/master/docs/setup.md) cover the actual gopass installation.
We suggest configuring shell autocompletion, as it makes usage much nicer.

### Setting up a secret store

You will need a valid GPG key.
Validate this with `gpg --list-secret-keys` (please double check the expiration so you don't accidentally lose access at a critical time).

Ask one of the existing secret store admins to grant access.
- You will need access to the repository itself, usually via a GitHub team.
- Then the admin will need to add you to the recipients list by running [`gopass recipients add`](https://github.com/gopasspw/gopass/blob/master/docs/commands/recipients.md).

Now you can clone the repo:

```sh
$ gopass clone git@github.com:voxpupuli/gopass-{name}.git voxpupuli/{name}
```

Run `gopass ls` and ensure that you can see all secrets.
Display a secret to ensure that decryption is working properly.
For example:

```sh
$ gopass ls
gopass
├── puppet/
│   └── forge/
│       ├── herculesteam
│       ├── puppet
│       └── voxpupuli
$ gopass show puppet/forge/puppet
Secret: puppet/forge/puppet

{redacted}
Username: puppet
URL: https://forge.puppet.com/login
```

## Common commands

Most of the basic interaction you'll need is:
- `gopass ls` will show an overview of all secrets you have access to.
- `gopass show name/of/secret` will display the decrypted secret.
- `gopass edit name/of/secret` is how you update a secret.

For more advanced usage, see the [gopass-cheat-sheet](https://woile.github.io/gopass-cheat-sheet/) or see the [command docs](https://github.com/gopasspw/gopass/tree/master/docs/commands).

To list all GPG keys (people) that have access to the repo, run `gopass recipients`

```terminal
$ gopass recipients
Hint: run 'gopass sync' to import any missing public keys
gopass
├── 0x2b04d7500fe1c6dd15692bb6779eba5eb9d631b8 => 0x779EBA5EB9D631B8 - Sebastian Rakel <sebastian.rakel@service-erp.de>
├── 0x559BEE876892AA5ECD925F28B352E2A17BB89EF5 => 0xB352E2A17BB89EF5 - Ewoud Kohl van Wijngaarden (Red Hat) <ekohlvan@redhat.com>
├── 0x82349A78E7C0B8070B5980FFBA4D1D955112336F => 0xBA4D1D955112336F - Romain Tartière <romain@nfc-tools.org>
├── 0x83CE67EC15FA9327838924766CE2B38A165F224B => 0x6CE2B38A165F224B - Robert Waffen <rw@betadots.de>
├── 0xC10B6298A584A5632E254DA304D659E6BF1C4CC0 => 0x04D659E6BF1C4CC0 - Tim Meusel <tim@bastelfreak.de>
└── 0xEA338528809E9749E2C3064379E924EBEDA7F3FD => 0x79E924EBEDA7F3FD - Alexander John Fisher <alex@linfratech.co.uk>
```

## Creating a new secret store

Want a new gopass store for your own SIG? Follow these steps.

1. Create a new blank repo in the `voxpupuli` namespace.
    - ⚠️ *Do not add any content at all -- not even a README or LICENSE*
    - Name it something like `gopass-{name of team}`
    - Give it a description like *Gopass password store for the {name} team*
    - Set it to private
    - Grant access to only the appropriate GitHub teams. Do not grant access to `pmc` or other general teams.
1. Create the secret store on your local machine
    - `gopass init --store voxpupuli/{name}`
1. Connect it to the git repo you created
    - `gopass git --store voxpupuli/{name} remote add origin git@github.com:voxpupuli/gopass-{name}.git`
1. Add other team members.
    - `gopass recipients add --store voxpupuli/{name}`
    - repeat as needed
1. Push changes to the repo
    - `gopass sync`
1. Add a quick `README` with information about the secret store. Link to this guide.
    - ⚠️ Make sure you do this *after syncing* at least once.
