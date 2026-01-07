---
layout: post
title: Code of the Week 1
date: 2019-01-01
github_username: bastelfreak
twitter_username: BastelsBlog
---

This is a new blog series that we would like to introduce. At Vox Pupuli, we
receive many Pull Requests. We receive so much awesome code, that isn't really
appreciated. In the past, some of our members sent out tweets if they saw cool
code. We now want to start a blog series with regular updates to appreciate the
work of our collaborators and contributors.

We start the calender week 1 with a contribution from
[Paul Hoisington](https://github.com/avidspartan1). He created a
[pull request](https://github.com/voxpupuli/puppet-yum/pull/121) for our
[yum](http://yum.baseurl.org/)
[module](https://github.com/voxpupuli/puppet-yum#yum).

A breakdown of his code:

```puppet
$_pc_cmd = [
  '/usr/bin/package-cleanup',
  '--oldkernels',
  "--count=${_real_installonly_limit}",
  '-y',
  $keep_kernel_devel ? {
    true    => '--keepdevel',
    default => undef,
  },
].filter |$val| { $val =~ NotUndef }
```

We've an array of values and a selector statement (which deserves a
dedicated post). We don't know which value the selector will return, `Undef`
is possible, but not desired. We need to filter anything from the array that
is `Undef`. For newcomers: Undef
[is very similar](https://puppet.com/docs/puppet/6.0/lang_data_undef.html) to
`Nil` in Ruby. So Paul applies the filter method to the array. It will apply
a lambda to each value in the array. If it returns true, the value will be
returned in a new array with all other values that also evaluated to true.

Now the cool part: `NotUndef`! Paul uses `=~` to match the values against the
`NotUndef` datatype. In most languages, `=~` is used to validate against a
regular expression. In Puppet, you can also evaluate against a datatype like
`String`, `Array` or `Undef` (or
[many more](https://puppet.com/docs/puppet/6.0/lang_data_type.html)). The
`NotUndef` type is a meta type which basically applies to all types,
except for `Undef`. This type is rarely used and not well known, but still
super helpful!


Thank you Paul for this cool contribution!

Did you spot some cool code as well? Write a
[short blogpost](https://github.com/voxpupuli/voxpupuli.github.io/tree/master/_posts)
or write an email to our
[Project Management committee](mailto:pmc@voxpupuli.org) or just drop a note on
our IRC channel #voxpupuli on [Libera](https://web.libera.chat/?#voxpupuli).
