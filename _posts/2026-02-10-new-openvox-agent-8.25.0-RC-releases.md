---
layout: post
title: New openvox-agent 8.25.0 RC releases
date: 2026-02-10
github_username: bastelfreak
---

We want to release a new set of openvox-agent packages. 8.25.0 brings support for many new platforms!

We now have:

* amazon-2-aarch64, amazon-2-x86_64
* amazon-2023-aarch64, amazon-2023-x86_64
* debian-11-aarch64, debian-11-amd64
* debian-12-aarch64, debian-12-amd64
* debian-13-aarch64, debian-13-amd64, debian-13-armhf
* el-8-aarch64, el-8-x86_64
* el-9-aarch64, el-9-x86_64
* el-10-x86_64, el-10-aarch64
* fedora-42-x86_64, fedora-42-aarch64
* fedora-43-x86_64, fedora-43-aarch64
* macos-all-arm64, macos-all-x86_64
* sles-15-x86_64
* sles-16-aarch64, sles-16-x86_64
* ubuntu-22.04-aarch64, ubuntu-22.04-amd64
* ubuntu-24.04-aarch64, ubuntu-24.04-amd64, ubuntu-24.04-armhf
* ubuntu-25.04-amd64, ubuntu-25.04-aarch64, ubuntu-25.04-armhf
* ubuntu-26.04-amd64, ubuntu-26.04-aarch64, ubuntu-26.04-armhf
* windows-all-x64

[FIPS builds](https://voxpupuli.org/blog/2026/01/13/new-fips-agent-packages/) for EL8 & EL9 are a different build process and will be delivered shortly afterwards.
The biggest change in the new release is the update from Ruby 3.2.9->3.2.10, also we updated various Ruby gems.

**The builds are available as release candidates [on our artifacts server](https://artifacts.voxpupuli.org/openvox-agent/8.24.2.29.g63675c2e8/).
Please download them and provide feedback [in the openvox Slack/IRC channel](https://voxpupuli.org/connect/) in the next couple of days**

**Gem Changes:**

{: .table .table-striped .table-hover }

| Component | Old Version | New Version |
|-----------|-------------|-------------|
| rubygem-aws-partitions | 1.1188.0 | 1.1213.0 |
| rubygem-aws-sdk-core | 3.239.2 | 3.242.0 |
| rubygem-aws-sdk-ec2 | 1.583.0 | 1.597.0 |
| rubygem-bcrypt_pbkdf | 1.1.1 | 1.1.2 |
| rubygem-concurrent-ruby | 1.3.5 | 1.3.6 |
| rubygem-excon | 1.3.1 | 1.3.2 |
| rubygem-faraday | 2.14.0 | 2.14.1 |
| rubygem-faraday-follow_redirects | 0.4.0 | 0.3.0 |
| rubygem-faraday-multipart | 1.1.1 | 1.2.0 |
| rubygem-faraday-retry | 2.3.2 | 2.4.0 |
| rubygem-ffi | 1.17.2 | 1.17.3 |
| rubygem-http_parser.rb | 0.8.0 | 0.8.1 |
| rubygem-json | 2.16.0 | 2.17.1 |
| rubygem-multi_json | 1.17.0 | 1.18.0 |
| rubygem-net-http | 0.8.0 | 0.9.1 |
| rubygem-net-http-persistent | 4.0.6 | 4.0.8 |
| rubygem-public_suffix | 6.0.2 | 7.0.2 |
| rubygem-puppet_forge | 6.0.0 | 6.1.0 |
| rubygem-rubyzip | 3.2.2 | 2.4.1 |
| rubygem-sys-filesystem | 1.5.4 | 1.5.5 |
| rubygem-thor | 1.4.0 | 1.5.0 |
| rubygem-timeout | 0.4.4 | 0.5.0 |
| rubygem-unicode-emoji | 4.1.0 | 4.2.0 |
| rubygem-yard | 0.9.37 | 0.9.38 |


**Component Changes:**

{: .table .table-striped .table-hover }

| Component | Old Version | New Version |
|-----------|-------------|-------------|
| curl | 8.17.0 | 8.18.0 |
| dmidecode | 3.6 | 3.7 |
| openssl-3.0 | 3.0.18 | 3.0.19 |
| ruby-3.2 | 3.2.9 | 3.2.10 |
