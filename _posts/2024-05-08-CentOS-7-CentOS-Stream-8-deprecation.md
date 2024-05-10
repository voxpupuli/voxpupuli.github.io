---
layout: post
title: CentOS 7 & CentOS Stream 8 deprecation
date: 2024-05-08
github_username: bastelfreak
twitter_username: bastelsblog
---

A few operating systems are soon end of life and we won't support them anymore:

* [RedHat 7 - 2024-06-30](https://github.com/voxpupuli/puppet_metadata/blob/dd815b5b350af2936819a7c5a449c1156cfac4b4/lib/puppet_metadata/operatingsystem.rb#L107C17-L107C27)
* [OracleLinux 7 - 2024-12-31](https://github.com/voxpupuli/puppet_metadata/blob/e8d46ebcbe1791834ba1cf77f49c8537faec3b78/lib/puppet_metadata/operatingsystem.rb#L53)
* [CentOS 7 - 2024-06-30](https://github.com/voxpupuli/puppet_metadata/blob/dd815b5b350af2936819a7c5a449c1156cfac4b4/lib/puppet_metadata/operatingsystem.rb#L25)
* [CentOS 8 Stream - 2024-05-31](https://github.com/voxpupuli/puppet_metadata/blob/dd815b5b350af2936819a7c5a449c1156cfac4b4/lib/puppet_metadata/operatingsystem.rb#L24C17-L24C27)

We've some major module releases ahead because we bumped dependencies or have
other breaking changes. Dropping support for above modules also justifies a
major modules release. To reduce the amount of major releases we will already
drop support for above operating systems before their EoL date **if** we need
to do a major module release anyways.

Dropping support means:

* The Operating system version will be removed from metadata.json
    * This will stop automatic unit/acceptance testing for this OS release
* Drop OS release specific puppet code
* If hiera-in-modules is used, this will also be cleaned up
