---
layout: page
title: Security
---

This page describes how to report security vulnerabilities, both external or
internal. If you have any question, please reach us on #voxpupuli on Freenode.

* TOC
{:toc}

## Reporting security vulnerabilities

If you want to report any security vulnerability, please contact
[Julien Pivotto](mailto:roidelapluie@inuits.eu). Julien's GPG key can be
downloaded [here](0C7F187769D072B93B642BB9E484250533AE92DA.pub).

Julien's GPG key fingerprint is `0C7F 1877 69D0 72B9 3B64  2BB9 E484 2505 33AE 92DA`.

Here is a list of topics where the security officer can help you:

* Report security vulnerabilities in our projects
* Report security vulnerabilities in third party projects we use (Ruby Gems)
* Report security vulnerabilities in third party projects we are related to
  (projects we manage with our Puppet modules)
* Report abnormal commits in our repositories
* Report abnormal usage of the Github organisation
* Report compromised user accounts
* Any other security and Vox Pupuli related problem


## Best practices regarding security

For our contributors, here are some best practices that we highly recommend.

1. Setup Github [Two-Factor Authentication][2fa]

    Github supports Two-Factor Authentication. Please use it to add more safety
    to your account.

1. GPG-Sign Tag commits

    Git allows you to gpg-sign commits. You should at least GPG-Sign the release
    commits, and register you GPG key inside Github.

1. Respect the [Responsible disclosure][m] model.

    Vox Pupuli is agile enough to address security vulnerabilities quickly.
    Still we encourage you to get in touch with the security officer that will
    help you to elaborate a good disclosure schedule and an appropriate answer.

1. Link to this page from the README.

    README files of Vox Pupuli projects should have a link to this page, by
    making it clear that it is the way to go to report security vulnerabilities
    that need some privacy.

1. Follow Vox Pupuli flows and practices

    Our practices are made with security in mind. Please avoid breaking away
    from them and try to follow our way of doing things. If you want to divert,
    please come to us and talk about your use case. Maybe the changes you want
    to make would be useful for everyone! A good example of this is modulesync.

[2fa]:https://help.github.com/articles/about-two-factor-authentication/
[m]:https://en.wikipedia.org/wiki/Responsible_disclosure
