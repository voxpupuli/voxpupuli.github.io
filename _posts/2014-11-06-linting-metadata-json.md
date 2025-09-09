---
layout: post
title: Linting metadata.json
github_username: nibalizer
twitter_username: nibalizer
date: 2014-11-06
---

In the recent past, the metadata.json file has replaced the Modulefile as the place where metadata about a Puppet module is kept. The Modulefile has a simple syntax and the Puppet module tool would generate the metadata.json from it.

Now, we must write our own metadata.json files. This leads to errors because json is a data format and humans suck at writing and reading it.

Tooling to work with this is in [flight](https://github.com/puppetlabs/forge-ruby). Currently geppetto has some tooling in it to do something with metadata.json, but that probably means some weird jar or something and ew. I've contributed the easy part, which is a linting tool to sanity-check your metadata.json. Metadata-json-lint will verify that your metadata.json is valid json and will ensure a number of required fields are there. It will also verify that the two fields that have been deprecated are no longer in your metadata.json file.

Install
-------

Command line:

```shell
gem install metadata-json-lint
```

Gemfile

```ruby
group :development, :test do
  gem 'rake', '10.1.1',         :require => false
#  ...
  gem 'metadata-json-lint',     :require => false
# ...
end
```

Usage
-----

Command line(success):

```shell
metadata-json-lint metadata.json
```

Command line(failure):

```shell
$: metadata-json-lint metadata.json
Error: Unable to parse json. There is a syntax error somewhere.
$: echo $?
1
```

Command line(failure):

```shell
$: metadata-json-lint metadata.json
Error: Required field 'summary' not found in metadata.json.
Errors found in metadata.json
$: echo $?
1
```

Rake:

```ruby
desc "Lint metadata.json file"
task :metadata do
  sh "metadata-json-lint metadata.json"
end
```

Source code
-----------

Available at <https://github.com/nibalizer/metadata-json-lint>

Adoption
--------

Meatadata-json-lint is currently being used in [puppet-module-puppetboard](https://github.com/voxpupuli/puppet-module-puppetboard) and in [garethr's](https://twitter.com/garethr) [puppet-module-skeleton](https://github.com/garethr/puppet-module-skeleton). It has been [proposed](https://review.openstack.org/#/c/127608/) for inclusion in the openstack puppet modules. If you are using it, hit up @nibalizer on twitter and we'll add it here.
