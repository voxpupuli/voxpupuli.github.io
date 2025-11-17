---
layout: page
title: Security
---

This page describes how to report security vulnerabilities, both external or internal.
If you have any question, please reach us on `#voxpupuli` on [Libera](https://web.libera.chat/?#voxpupuli).

* TOC
{:toc}
{: class="alert alert-primary callout w-33" }

## Reporting security vulnerabilities

If you want to report any security vulnerability, please contact our
[security team](mailto:security@voxpupuli.org).
Feel free to encrypt communications using our [gpg key](https://keys.openpgp.org/search?q=security%40voxpupuli.org).

```
$ gpg --auto-key-locate keyserver --locate-keys security@voxpupuli.org
```

Our GPG key fingerprint is `CA4C B6EE 8852 F95F B84B  834B 48A1 C23A FF60 2E9B`.

Here is a list of topics where the security team can help you:

* Report security vulnerabilities in our projects
    - modules, gems, OpenVox projects, etc
* Report security vulnerabilities in third party projects we use (Ruby Gems)
* Report security vulnerabilities in third party projects we are related to
  (projects we manage with our Puppet modules)
* Report abnormal commits in our repositories
* Report abnormal usage of the Github organisation
* Report compromised user accounts
* Any other security and Vox Pupuli related problem


## Good practices regarding security

For our contributors, here are some good practices that we highly recommend.

1. Setup Github [Two-Factor Authentication][2fa]

    Github supports Two-Factor Authentication. Please use it to add more safety
    to your account.

1. GPG-Sign Tag commits

    Git allows you to [gpg-sign commits][s]. You should at least GPG-Sign the release
    commits, and register you GPG key inside Github.

1. Respect the [Responsible disclosure][m] model.

    Vox Pupuli is agile enough to address security vulnerabilities quickly.
    Still we encourage you to get in touch with the security team that will
    help you to elaborate a good disclosure schedule and an appropriate answer.

1. Follow Vox Pupuli flows and practices

    Our practices are made with security in mind. Please avoid breaking away
    from them and try to follow our way of doing things. If you want to divert,
    please come to us and talk about your use case. Maybe the changes you want
    to make would be useful for everyone! A good example of this is modulesync.

[2fa]: https://help.github.com/articles/about-two-factor-authentication/
[s]: https://help.github.com/articles/signing-commits-using-gpg/
[m]: https://en.wikipedia.org/wiki/Responsible_disclosure
