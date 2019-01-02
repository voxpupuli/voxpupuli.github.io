---
layout: post
title: Code of the Week 3
date: 2019-01-14
github_username: bastelfreak
twitter_username: BastelsBlog
---

This is a new blog series that we would like to introduce. At Vox Pupuli, we
receive many
[Pull Requests](https://github.com/search?q=type%3Apr+is%3Aopen+is%3Apublic+org%3Avoxpupuli&type=Issues).
We receive so much awesome code, that isn't really appreciated. In the past,
some of our members sent out tweets if they saw cool code. We now want to start
a blog series with regular updates to appreciate the work of our collaborators
and contributors.

Puppet supports datatypes since Puppet 4 or since 3.8.7 with the future parser.
Back in the days, everything was a string. Or at least it could be a string. We
had to use so
[many functions](https://github.com/puppetlabs/puppetlabs-stdlib/tree/a85e7faeaa89b305be8aef4f2b4ede0bef27b336#for-module-users)
to validate the input of variables. Since the introduction of datatypes, we can
enforce the correct datatype directly when the user provides data, without
calling multiple functions. The datatypes are especially useful for
[Collection datatypes](https://puppet.com/docs/puppet/6.1/lang_data_abstract.html#the-collection-data-type)
because it's now possible to very strict types for each element in a
collection. The migration to datatypes was a bit painful
[in](https://github.com/puppetlabs/puppetlabs-apache/pull/1621)
[some](https://github.com/puppetlabs/puppetlabs-postgresql/pull/852)
[modules](https://github.com/voxpupuli/puppet-nginx/pull/1056). But the result
was nice. Not only were the actual code
([LOC](https://en.wikipedia.org/wiki/Source_lines_of_code)) and tests shorter,
datatypes also allow us to validate way more in detail than the old validate
functions. This reduced the amount of possible errors that could happen because
of unexpected input. We actually discovered multiple bugs during the transition
to datatypes and also many codepieces that were suboptimal. For example a lot
of casting from `'true'` (a string, valid input data in some modules) to `true`
(as an actual
[Boolean](https://puppet.com/docs/puppet/6.1/lang_data_boolean.html) datatype).
Based on the experiences we made, we created [review guidelines and documented
best practices](https://voxpupuli.org/docs/#reviewing-a-module-pr).

Some of these guidelines are:

> Are new parameters introduced? They must have datatypes

> Are datatypes from stdlib used? Ensure that lowest supported stdlib version is 4.13.1. Check if a newer version introduced the used datatype

> Are there new params with datatype Hash or Array? If possible, they should default to empty Hash/Array instead of undef. You can also enforce the datastructure like Array[String]

> Are there new params with datatype Boolean? The default value is a tricky decision which needs careful reviewing. Sometimes a True/False is the better approach, sometimes undef

> Does a new param map to an option in a config file of a service? The Parameter should accept the possible values that the service allows. For example `'on'` and `'off'`. Don’t accept a boolean that will be converted to `'on'` or `'off'`

> If you can supply one or multiple values for an attribute it’s common practice to enforce the datatype for one value and an array of that datatype. An example for string is `Variant[String[1],Array[String[1]]]`. This can be used in the Puppet code as `[$var].flatten()`

**The summary: Datatypes are useful and important. Always using them for each
exposed parameter will help you catch bugs earlier, and the more detailed
your datatype is the better it will be at catching bugs.**

After a very long introduction, let us come to the actual contribution. In
calendar week three we have a contribution from [David
Hollinger](https://github.com/dhollinger). He invested a huge amount of
time over a period of months into our [rsyslog
module](https://forge.puppet.com/puppet/rsyslog#puppet-rsyslog). There are
multiple great PRs that we could talk about here. Let us have a look at
[the latest](https://github.com/voxpupuli/puppet-rsyslog/pull/106).

You can create custom datatypes that are very complex/very strict. They are
based on multiple scalar types. One very detailed example is this
(types/actions/outputs/omelasticsearch.pp):

```puppet
 type Rsyslog::Actions::Outputs::Omelasticsearch = Struct[{
   server               => Optional[Variant[String[1], Array[String[1]]]],
   serverport           => Optional[Stdlib::Port],
   healthchecktimeout   => Optional[Integer],
   searchindex          => Optional[String[1]],
   dynsearchindex       => Optional[Enum['on', 'off']],
   searchtype           => Optional[String[1]],
   dynsearchtype        => Optional[Enum['on', 'off']],
   pipelinename         => Optional[String[1]],
   dynpipelinename      => Optional[Enum['on', 'off']],
   usehttps             => Optional[Enum['on', 'off']],
   timeout              => Optional[Pattern[/^([0-9]+)(ms|s|m)$/]],
   template             => Optional[String[1]],
   bulkmode             => Optional[Enum['on', 'off']],
   maxbytes             => Optional[Pattern[/^([0-9]+)[kKmMgGtT]$/]],
   parent               => Optional[String[1]],
   dynparent            => Optional[Enum['on', 'off']],
   uid                  => Optional[String[1]],
   pwd                  => Optional[String[1]],
   errorfile            => Optional[Stdlib::Absolutepath],
   'tls.cacert'         => Optional[Stdlib::Absolutepath],
   'tls.mycert'         => Optional[Stdlib::Absolutepath],
   'tls.myprivkey'      => Optional[Stdlib::Absolutepath],
   bulkid               => Optional[String[1]],
   dynbulkid            => Optional[Enum['on', 'off']],
   writeoperation       => Optional[Enum['index', 'create']],
   retryfailures        => Optional[Enum['on', 'off']],
   retryruleset         => Optional[String[1]],
   'ratelimit.interval' => Optional[Integer],
   'ratelimit.burst'    => Optional[Integer],
 }]
```
The rsyslog configuration has so many options, many of them can be nested. In
the beginning of datatypes in Puppet, we would have used `Hash` for the above
requirement.  At this level the type is already better than the old
`validate_hash()` function and everybody would be happy. But not David! He did
not go one, but thousand steps further and enforces the complete hash structure.
And didn't simply create the custom datatype
`Rsyslog::Actions::Outputs::Omelasticsearch`, he created many more and also
tests for them. If we do a quick `find types/ -type f -exec cat {} \; | wc -l`
we notice that there are 390 lines of datatype codes. This is amazing! Also
`find spec/type_aliases/ -type f -exec cat {} \; | wc -l` reveals 2009 lines
of tests for datatypes!

Thank you so much David! This work is amazing and the quality of this
module is way higher than our average.

Did you spot some cool code as well? Write a
[short blogpost](https://github.com/voxpupuli/voxpupuli.github.io/tree/master/_posts)
or write an email to our
[Project Management committee](mailto:pmc@voxpupuli.org) or just drop a note on
our IRC channel #voxpupuli on Freenode.
