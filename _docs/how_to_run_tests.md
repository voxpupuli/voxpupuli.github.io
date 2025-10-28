---
layout: post
title: How to run the Vox Pupuli test suite
summary: A description of how to run the Vox Pupuli test suite for Puppet modules.
---

- [Running the tests in a local ruby environment](#running-the-tests-in-a-local-ruby-environment)
  * [Installing dependencies](#installing-dependencies)
  * [Vox Pupuli helpers](#vox-pupuli-helpers)
  * [Linting](#linting)
  * [REFERENCE.md update](#referencemd-update)
  * [Unit tests](#unit-tests)
    + [Detailed sub tasks](#detailed-sub-tasks)
  * [Running Acceptance Tests](#running-acceptance-tests)
    + [Beaker hypervisors](#beaker-hypervisors)
    + [Environment variables and hostnames](#environment-variables-and-hostnames)
    + [Getting setfiles for a module](#getting-setfiles-for-a-module)
    + [Running Beaker](#running-beaker)
    + [Custom Facts](#custom-facts)
    + [Run a specific test](#run-a-specific-test)
- [Running the tests in the VoxBox container](#running-the-tests-in-the-voxbox-container)
  * [Installation](#installation)
  * [Linting](#linting-in-voxbox)
  * [Rubocop](#rubocop)
  * [Unit tests](#unit-tests-in-voxbox)
  * [REFERENCE.md update](#referencemd-update-in-voxbox)
  * [Puppetfile](#puppetfile)

The testing and development tools have a bunch of dependencies, all managed by [bundler](http://bundler.io/).
By default the tests use the latest version of Puppet.
If you want a specific version of Puppet, you must set an environment variable such as:

```shell
export PUPPET_VERSION="~> 8.8.1"
```

## Running the tests in a local Ruby environment

### Installing Dependencies

Dependencies for running tests are installed as gems via bundler and will run in Ruby 3.2 and newer (as of time of writing).
It should be trivial to install via your package manager or gem.

#### Debian/Ubuntu

```shell
# apt install ruby-bundler
```

#### RedHat (and similar)

As of el9, dnf replaces yum.
Use the appropriate package manager to get it installed.

```shell
# yum install rubygem-bundler
# dnf install rubygem-bundler
```

#### ArchLinux

```shell
# pacman -Syu extra/ruby-bundler
```

#### By Gem (Last Option)

```shell
# gem install bundler
```

### Configuring Bundler

You can install all needed gems for spec tests into the modules directory by running:

```shell
bundle config set --local path '.vendor/bundle'
bundle config set --local without 'development system_tests release'
bundle install
```

**If you also want to run acceptance tests, don't exclude the `system_tests` group.**

If you don't know if you need to install or update gems, you can just add `bundle update && bundle clean` as an additional command.

### Vox Pupuli helpers

Check out the following page if you want to add a test suite to your module or want
to learn more about the Vox Pupuli test helpers:

* [voxpupuli-test](https://github.com/voxpupuli/voxpupuli-test) for unit testing
* [voxpupuli-acceptance](https://github.com/voxpupuli/voxpupuli-acceptance) for acceptance testing
* [voxpupuli-release](https://github.com/voxpupuli/voxpupuli-release) for creating a release

To get a rough understanding, we created a dependency graph for each of our meta gem.
Keep in mind:

* We exclude [std- and default gems](https://stdgems.org/)
* This graph is created by hand and not updated automatically
* All gems maintained by Vox Pupuli or the OpenVoxProject are red
* All gems maintained by Perforce are green
* The idea is to provide a rough overview of the ecosystem and ownership
* The listed versions are the latest supported ones
* We don't resolve dependencies for some transient deps, otherwise the graph would explode

#### voxpupuli-test 13.1.0

<div class="mermaid">
graph TD
  subgraph Legend
  puppetlabs["Gems owned by Perforce"]
  voxpupuli["Gems owned by Vox Pupuli"]
  end
  voxpupuli-test["voxpupuli-test (13.1.0)"] --> facterdb["facterdb (4.1.0)"]
  facterdb["facterdb (4.1.0)"] --> jgrep["jgrep (1.5.4)"]
  voxpupuli-test["voxpupuli-test (13.1.0)"] --> metadata-json-lint["metadata-json-lint (5.0.0)"]
  metadata-json-lint["metadata-json-lint (5.0.0)"] --> json-schema["json-schema (6.0.0)"]
  metadata-json-lint["metadata-json-lint (5.0.0)"] --> semantic_puppet["semantic_puppet (1.1.1)"]
  metadata-json-lint["metadata-json-lint (5.0.0)"] --> spdx-licenses["spdx-licenses (1.3.0)"]
  voxpupuli-test["voxpupuli-test (13.1.0)"] --> openvox-strings["openvox-strings (6.0.0)"]
  openvox-strings["openvox-strings (6.0.0)"] --> openvox["openvox (8.23.1)"]
  openvox["openvox (8.23.1)"] --> concurrent-ruby["concurrent-ruby (1.3.5)"]
  openvox["openvox (8.23.1)"] --> deep_merge["deep_merge (1.2.2)"]
  openvox["openvox (8.23.1)"] --> fast_gettext["fast_gettext (4.1.1)"]
  openvox["openvox (8.23.1)"] --> locale["locale (2.1.4)"]
  openvox["openvox (8.23.1)"] --> multi_json["multi_json (1.17.0)"]
  openvox["openvox (8.23.1)"] --> openfact["openfact (5.1.0)"]
  openfact["openfact (5.1.0)"] --> hocon["hocon (1.4.0)"]
  openfact["openfact (5.1.0)"] --> thor["thor (1.4.0)"]
  openvox["openvox (8.23.1)"] --> puppet-resource_api["puppet-resource_api (1.9.0)"]
  puppet-resource_api["puppet-resource_api (1.9.0)"] --> hocon["hocon (1.4.0)"]
  openvox["openvox (8.23.1)"] --> semantic_puppet["semantic_puppet (1.1.1)"]
  openvox-strings["openvox-strings (6.0.0)"] --> rgen["rgen (0.10.2)"]
  openvox-strings["openvox-strings (6.0.0)"] --> yard["yard (0.9.37)"]
  voxpupuli-test["voxpupuli-test (13.1.0)"] --> parallel_tests["parallel_tests (5.4.0)"]
  parallel_tests["parallel_tests (5.4.0)"] --> parallel["parallel (1.27.0)"]
  voxpupuli-test["voxpupuli-test (13.1.0)"] --> puppet_fixtures["puppet_fixtures (2.0.0)"]
  puppet_fixtures["puppet_fixtures (2.0.0)"] --> rake["rake (13.3.0)"]
  voxpupuli-test["voxpupuli-test (13.1.0)"] --> puppet-syntax["puppet-syntax (7.0.1)"]
  puppet-syntax["puppet-syntax (7.0.1)"] --> openvox["openvox (8.23.1)"]
  puppet-syntax["puppet-syntax (7.0.1)"] --> rake["rake (13.3.0)"]
  voxpupuli-test["voxpupuli-test (13.1.0)"] --> rake["rake (13.3.0)"]
  voxpupuli-test["voxpupuli-test (13.1.0)"] --> rspec-github["rspec-github (3.0.0)"]
  voxpupuli-test["voxpupuli-test (13.1.0)"] --> rspec-puppet["rspec-puppet (5.0.0)"]
  voxpupuli-test["voxpupuli-test (13.1.0)"] --> rspec-puppet-facts["rspec-puppet-facts (6.0.0)"]
  rspec-puppet-facts["rspec-puppet-facts (6.0.0)"] --> deep_merge["deep_merge (1.2.2)"]
  rspec-puppet-facts["rspec-puppet-facts (6.0.0)"] --> facterdb["facterdb (4.1.0)"]
  rspec-puppet-facts["rspec-puppet-facts (6.0.0)"] --> openfact["openfact (5.1.0)"]
  voxpupuli-test["voxpupuli-test (13.1.0)"] --> rubocop["rubocop (1.50.2)"]
  voxpupuli-test["voxpupuli-test (13.1.0)"] --> rubocop-rake["rubocop-rake (0.6.0)"]
  rubocop-rake["rubocop-rake (0.6.0)"] --> rubocop["rubocop (1.81.6)"]
  voxpupuli-test["voxpupuli-test (13.1.0)"] --> rubocop-rspec["rubocop-rspec (2.20.0)"]
  voxpupuli-test["voxpupuli-test (13.1.0)"] --> voxpupuli-puppet-lint-plugins["voxpupuli-puppet-lint-plugins (7.0.0)"]

  classDef voxpupuli fill:#ffcccc,stroke:#aa0000,color:#000;
  classDef puppetlabs fill:#ccffcc,stroke:#009900,color:#000;
  class puppetlabs puppetlabs;
  class voxpupuli voxpupuli;
  class voxpupuli-test voxpupuli;
  class facterdb voxpupuli;
  class metadata-json-lint voxpupuli;
  class semantic_puppet puppetlabs;
  class openvox-strings voxpupuli;
  class openvox voxpupuli;
  class openfact voxpupuli;
  class hocon puppetlabs;
  class puppet-resource_api puppetlabs;
  class puppet_fixtures voxpupuli;
  class puppet-syntax voxpupuli;
  class rspec-puppet-facts voxpupuli;
  class voxpupuli-puppet-lint-plugins voxpupuli;
</div>

#### voxpupuli-puppet-lint-plugins 7.0.0

This is a dependency from voxpupuli-test.
We render it in an individual graph to make it more readable.

<div class="mermaid">
graph LR
  subgraph Legend
  puppetlabs["Gems owned by Perforce"]
  voxpupuli["Gems owned by Vox Pupuli"]
  end
  voxpupuli-puppet-lint-plugins["voxpupuli-puppet-lint-plugins (7.0.0)"] --> puppet-lint["puppet-lint (5.1.0)"]
  voxpupuli-puppet-lint-plugins["voxpupuli-puppet-lint-plugins (7.0.0)"] --> puppet-lint-absolute_classname-check["puppet-lint-absolute_classname-check (5.0.0)"]
  puppet-lint-absolute_classname-check["puppet-lint-absolute_classname-check (5.0.0)"] --> puppet-lint["puppet-lint (5.1.0)"]
  voxpupuli-puppet-lint-plugins["voxpupuli-puppet-lint-plugins (7.0.0)"] --> puppet-lint-anchor-check["puppet-lint-anchor-check (3.0.0)"]
  puppet-lint-anchor-check["puppet-lint-anchor-check (3.0.0)"] --> puppet-lint["puppet-lint (5.1.0)"]
  voxpupuli-puppet-lint-plugins["voxpupuli-puppet-lint-plugins (7.0.0)"] --> puppet-lint-exec_idempotency-check["puppet-lint-exec_idempotency-check (2.0.0)"]
  puppet-lint-exec_idempotency-check["puppet-lint-exec_idempotency-check (2.0.0)"] --> puppet-lint["puppet-lint (5.1.0)"]
  voxpupuli-puppet-lint-plugins["voxpupuli-puppet-lint-plugins (7.0.0)"] --> puppet-lint-file_ensure-check["puppet-lint-file_ensure-check (3.0.0)"]
  puppet-lint-file_ensure-check["puppet-lint-file_ensure-check (3.0.0)"] --> puppet-lint["puppet-lint (5.1.0)"]
  voxpupuli-puppet-lint-plugins["voxpupuli-puppet-lint-plugins (7.0.0)"] --> puppet-lint-leading_zero-check["puppet-lint-leading_zero-check (3.0.0)"]
  puppet-lint-leading_zero-check["puppet-lint-leading_zero-check (3.0.0)"] --> puppet-lint["puppet-lint (5.1.0)"]
  voxpupuli-puppet-lint-plugins["voxpupuli-puppet-lint-plugins (7.0.0)"] --> puppet-lint-lookup_in_parameter-check["puppet-lint-lookup_in_parameter-check (3.0.0)"]
  puppet-lint-lookup_in_parameter-check["puppet-lint-lookup_in_parameter-check (3.0.0)"] --> puppet-lint["puppet-lint (5.1.0)"]
  voxpupuli-puppet-lint-plugins["voxpupuli-puppet-lint-plugins (7.0.0)"] --> puppet-lint-manifest_whitespace-check["puppet-lint-manifest_whitespace-check (2.0.0)"]
  puppet-lint-manifest_whitespace-check["puppet-lint-manifest_whitespace-check (2.0.0)"] --> puppet-lint["puppet-lint (5.1.0)"]
  voxpupuli-puppet-lint-plugins["voxpupuli-puppet-lint-plugins (7.0.0)"] --> puppet-lint-optional_default-check["puppet-lint-optional_default-check (3.0.0)"]
  puppet-lint-optional_default-check["puppet-lint-optional_default-check (3.0.0)"] --> puppet-lint["puppet-lint (5.1.0)"]
  voxpupuli-puppet-lint-plugins["voxpupuli-puppet-lint-plugins (7.0.0)"] --> puppet-lint-package_ensure-check["puppet-lint-package_ensure-check (0.2.0)"]
  puppet-lint-package_ensure-check["puppet-lint-package_ensure-check (0.2.0)"] --> puppet-lint["puppet-lint (5.1.0)"]
  voxpupuli-puppet-lint-plugins["voxpupuli-puppet-lint-plugins (7.0.0)"] --> puppet-lint-param-docs["puppet-lint-param-docs (3.0.0)"]
  puppet-lint-param-docs["puppet-lint-param-docs (3.0.0)"] --> puppet-lint["puppet-lint (5.1.0)"]
  voxpupuli-puppet-lint-plugins["voxpupuli-puppet-lint-plugins (7.0.0)"] --> puppet-lint-params_empty_string-check["puppet-lint-params_empty_string-check (3.0.0)"]
  puppet-lint-params_empty_string-check["puppet-lint-params_empty_string-check (3.0.0)"] --> puppet-lint["puppet-lint (5.1.0)"]
  voxpupuli-puppet-lint-plugins["voxpupuli-puppet-lint-plugins (7.0.0)"] --> puppet-lint-params_not_optional_with_undef-check["puppet-lint-params_not_optional_with_undef-check (1.0.0)"]
  puppet-lint-params_not_optional_with_undef-check["puppet-lint-params_not_optional_with_undef-check (1.0.0)"] --> puppet-lint["puppet-lint (5.1.0)"]
  voxpupuli-puppet-lint-plugins["voxpupuli-puppet-lint-plugins (7.0.0)"] --> puppet-lint-param-types["puppet-lint-param-types (3.0.0)"]
  puppet-lint-param-types["puppet-lint-param-types (3.0.0)"] --> puppet-lint["puppet-lint (5.1.0)"]
  voxpupuli-puppet-lint-plugins["voxpupuli-puppet-lint-plugins (7.0.0)"] --> puppet-lint-resource_reference_syntax["puppet-lint-resource_reference_syntax (3.0.0)"]
  puppet-lint-resource_reference_syntax["puppet-lint-resource_reference_syntax (3.0.0)"] --> puppet-lint["puppet-lint (5.1.0)"]
  voxpupuli-puppet-lint-plugins["voxpupuli-puppet-lint-plugins (7.0.0)"] --> puppet-lint-strict_indent-check["puppet-lint-strict_indent-check (5.0.0)"]
  puppet-lint-strict_indent-check["puppet-lint-strict_indent-check (5.0.0)"] --> puppet-lint["puppet-lint (5.1.0)"]
  voxpupuli-puppet-lint-plugins["voxpupuli-puppet-lint-plugins (7.0.0)"] --> puppet-lint-topscope-variable-check["puppet-lint-topscope-variable-check (3.0.0)"]
  puppet-lint-topscope-variable-check["puppet-lint-topscope-variable-check (3.0.0)"] --> puppet-lint["puppet-lint (5.1.0)"]
  voxpupuli-puppet-lint-plugins["voxpupuli-puppet-lint-plugins (7.0.0)"] --> puppet-lint-trailing_comma-check["puppet-lint-trailing_comma-check (3.0.0)"]
  puppet-lint-trailing_comma-check["puppet-lint-trailing_comma-check (3.0.0)"] --> puppet-lint["puppet-lint (5.1.0)"]
  voxpupuli-puppet-lint-plugins["voxpupuli-puppet-lint-plugins (7.0.0)"] --> puppet-lint-unquoted_string-check["puppet-lint-unquoted_string-check (4.1.0)"]
  puppet-lint-unquoted_string-check["puppet-lint-unquoted_string-check (4.1.0)"] --> puppet-lint["puppet-lint (5.1.0)"]
  voxpupuli-puppet-lint-plugins["voxpupuli-puppet-lint-plugins (7.0.0)"] --> puppet-lint-variable_contains_upcase["puppet-lint-variable_contains_upcase (3.0.0)"]
  puppet-lint-variable_contains_upcase["puppet-lint-variable_contains_upcase (3.0.0)"] --> puppet-lint["puppet-lint (5.1.0)"]
  voxpupuli-puppet-lint-plugins["voxpupuli-puppet-lint-plugins (7.0.0)"] --> puppet-lint-version_comparison-check["puppet-lint-version_comparison-check (3.0.0)"]
  puppet-lint-version_comparison-check["puppet-lint-version_comparison-check (3.0.0)"] --> puppet-lint["puppet-lint (5.1.0)"]

  classDef voxpupuli fill:#ffcccc,stroke:#aa0000,color:#000;
  classDef puppetlabs fill:#ccffcc,stroke:#009900,color:#000;
  class puppetlabs puppetlabs;
  class voxpupuli voxpupuli;
  class voxpupuli-puppet-lint-plugins voxpupuli;
  class puppet-lint puppetlabs;
  class puppet-lint-absolute_classname-check voxpupuli;
  class puppet-lint-anchor-check voxpupuli;
  class puppet-lint-exec_idempotency-check voxpupuli;
  class puppet-lint-file_ensure-check voxpupuli;
  class puppet-lint-leading_zero-check voxpupuli;
  class puppet-lint-lookup_in_parameter-check voxpupuli;
  class puppet-lint-manifest_whitespace-check voxpupuli;
  class puppet-lint-optional_default-check voxpupuli;
  class puppet-lint-param-docs voxpupuli;
  class puppet-lint-params_empty_string-check voxpupuli;
  class puppet-lint-params_not_optional_with_undef-check voxpupuli;
  class puppet-lint-param-types voxpupuli;
  class puppet-lint-resource_reference_syntax voxpupuli;
  class puppet-lint-strict_indent-check voxpupuli;
  class puppet-lint-topscope-variable-check voxpupuli;
  class puppet-lint-trailing_comma-check voxpupuli;
  class puppet-lint-unquoted_string-check voxpupuli;
  class puppet-lint-variable_contains_upcase voxpupuli;
  class puppet-lint-version_comparison-check voxpupuli;
</div>

#### voxpupuli-release 5.0.1

<div class="mermaid">
graph TD
  subgraph Legend
  puppetlabs["Gems owned by Perforce"]
  voxpupuli["Gems owned by Vox Pupuli"]
  end
  voxpupuli-release["voxpupuli-release (5.0.1)"] --> faraday-retry["faraday-retry (2.3.2)"]
  faraday-retry["faraday-retry (2.3.2)"] --> faraday["faraday (2.14.0)"]
  faraday["faraday (2.14.0)"] --> faraday-net_http["faraday-net_http (3.4.1)"]
  voxpupuli-release["voxpupuli-release (5.0.1)"] --> github_changelog_generator["github_changelog_generator (1.16.4)"]
  voxpupuli-release["voxpupuli-release (5.0.1)"] --> openvox-strings["openvox-strings (6.0.0)"]
  openvox-strings["openvox-strings (6.0.0)"] --> openvox["openvox (8.23.1)"]
  openvox["openvox (8.23.1)"] --> concurrent-ruby["concurrent-ruby (1.3.5)"]
  openvox["openvox (8.23.1)"] --> deep_merge["deep_merge (1.2.2)"]
  openvox["openvox (8.23.1)"] --> fast_gettext["fast_gettext (4.1.1)"]
  openvox["openvox (8.23.1)"] --> locale["locale (2.1.4)"]
  openvox["openvox (8.23.1)"] --> multi_json["multi_json (1.17.0)"]
  openvox["openvox (8.23.1)"] --> openfact["openfact (5.1.0)"]
  openfact["openfact (5.1.0)"] --> hocon["hocon (1.4.0)"]
  openfact["openfact (5.1.0)"] --> thor["thor (1.4.0)"]
  openvox["openvox (8.23.1)"] --> puppet-resource_api["puppet-resource_api (1.9.0)"]
  puppet-resource_api["puppet-resource_api (1.9.0)"] --> hocon["hocon (1.4.0)"]
  openvox["openvox (8.23.1)"] --> scanf["scanf (1.0.0)"]
  openvox["openvox (8.23.1)"] --> semantic_puppet["semantic_puppet (1.1.1)"]
  openvox-strings["openvox-strings (6.0.0)"] --> rgen["rgen (0.10.2)"]
  openvox-strings["openvox-strings (6.0.0)"] --> yard["yard (0.9.37)"]
  voxpupuli-release["voxpupuli-release (5.0.1)"] --> puppet-blacksmith["puppet-blacksmith (9.0.0)"]
  puppet-blacksmith["puppet-blacksmith (9.0.0)"] --> puppet-modulebuilder["puppet-modulebuilder (2.1.0)"]
  puppet-modulebuilder["puppet-modulebuilder (2.1.0)"] --> minitar["minitar (1.1.0)"]
  puppet-modulebuilder["puppet-modulebuilder (2.1.0)"] --> pathspec["pathspec (2.1.0)"]
  puppet-blacksmith["puppet-blacksmith (9.0.0)"] --> rest-client["rest-client (2.1.0)"]
  voxpupuli-release["voxpupuli-release (5.0.1)"] --> rake["rake (13.3.0)"]

  classDef voxpupuli fill:#ffcccc,stroke:#aa0000,color:#000;
  classDef puppetlabs fill:#ccffcc,stroke:#009900,color:#000;
  class puppetlabs puppetlabs;
  class voxpupuli voxpupuli;
  class voxpupuli-release voxpupuli;
  class openvox-strings voxpupuli;
  class openvox voxpupuli;
  class openfact voxpupuli;
  class hocon puppetlabs;
  class puppet-resource_api puppetlabs;
  class semantic_puppet puppetlabs;
  class puppet-blacksmith voxpupuli;
  class puppet-modulebuilder puppetlabs;
</div>

#### voxpupuli-acceptance 4.1.0

<div class="mermaid">
graph TD
  subgraph Legend
  puppetlabs["Gems owned by Perforce"]
  voxpupuli["Gems owned by Vox Pupuli"]
  end
  voxpupuli-acceptance["voxpupuli-acceptance (4.1.0)"] --> bcrypt_pbkdf["bcrypt_pbkdf (1.1.2.rc1)"]
  voxpupuli-acceptance["voxpupuli-acceptance (4.1.0)"] --> beaker["beaker (7.2.0)"]
  beaker["beaker (7.2.0)"] --> bcrypt_pbkdf["bcrypt_pbkdf (1.1.2.rc1)"]
  beaker["beaker (7.2.0)"] --> beaker-hostgenerator["beaker-hostgenerator (3.3.0)"]
  beaker-hostgenerator["beaker-hostgenerator (3.3.0)"] --> deep_merge["deep_merge (1.2.2)"]
  beaker["beaker (7.2.0)"] --> ed25519["ed25519 (1.4.0)"]
  beaker["beaker (7.2.0)"] --> hocon["hocon (1.4.0)"]
  beaker["beaker (7.2.0)"] --> in-parallel["in-parallel (1.0.1)"]
  beaker["beaker (7.2.0)"] --> minitar["minitar (1.1.0)"]
  beaker["beaker (7.2.0)"] --> minitest["minitest (5.26.0)"]
  beaker["beaker (7.2.0)"] --> net-scp["net-scp (4.1.0)"]
  net-scp["net-scp (4.1.0)"] --> net-ssh["net-ssh (7.3.0)"]
  beaker["beaker (7.2.0)"] --> net-ssh["net-ssh (7.3.0)"]
  beaker["beaker (7.2.0)"] --> rexml["rexml (3.4.4)"]
  beaker["beaker (7.2.0)"] --> rsync["rsync (1.0.9)"]
  beaker["beaker (7.2.0)"] --> stringify-hash["stringify-hash (0.0.2)"]
  beaker["beaker (7.2.0)"] --> thor["thor (1.4.0)"]
  voxpupuli-acceptance["voxpupuli-acceptance (4.1.0)"] --> beaker-docker["beaker-docker (3.0.1)"]
  beaker-docker["beaker-docker (3.0.1)"] --> beaker["beaker (7.2.0)"]
  beaker-docker["beaker-docker (3.0.1)"] --> docker-api["docker-api (2.4.0)"]
  beaker-docker["beaker-docker (3.0.1)"] --> stringify-hash["stringify-hash (0.0.2)"]
  voxpupuli-acceptance["voxpupuli-acceptance (4.1.0)"] --> beaker-hiera["beaker-hiera (2.0.0)"]
  beaker-hiera["beaker-hiera (2.0.0)"] --> beaker["beaker (7.2.0)"]
  voxpupuli-acceptance["voxpupuli-acceptance (4.1.0)"] --> beaker-hostgenerator["beaker-hostgenerator (3.3.0)"]
  voxpupuli-acceptance["voxpupuli-acceptance (4.1.0)"] --> beaker_puppet_helpers["beaker_puppet_helpers (3.1.1)"]
  beaker_puppet_helpers["beaker_puppet_helpers (3.1.1)"] --> beaker["beaker (7.2.0)"]
  beaker_puppet_helpers["beaker_puppet_helpers (3.1.1)"] --> nokogiri["nokogiri (1.18.10)"]
  beaker_puppet_helpers["beaker_puppet_helpers (3.1.1)"] --> open-uri["open-uri (0.5.0)"]
  beaker_puppet_helpers["beaker_puppet_helpers (3.1.1)"] --> puppet-modulebuilder["puppet-modulebuilder (2.1.0)"]
  puppet-modulebuilder["puppet-modulebuilder (2.1.0)"] --> minitar["minitar (1.1.0)"]
  puppet-modulebuilder["puppet-modulebuilder (2.1.0)"] --> pathspec["pathspec (2.1.0)"]
  voxpupuli-acceptance["voxpupuli-acceptance (4.1.0)"] --> beaker-rspec["beaker-rspec (9.0.0)"]
  beaker-rspec["beaker-rspec (9.0.0)"] --> beaker["beaker (7.2.0)"]
  beaker-rspec["beaker-rspec (9.0.0)"] --> rspec["rspec (3.13.2)"]
  beaker-rspec["beaker-rspec (9.0.0)"] --> serverspec["serverspec (2.43.0)"]
  beaker-rspec["beaker-rspec (9.0.0)"] --> specinfra["specinfra (2.94.1)"]
  specinfra["specinfra (2.94.1)"] --> net-scp["net-scp (4.1.0)"]
  specinfra["specinfra (2.94.1)"] --> net-ssh["net-ssh (7.3.0)"]
  specinfra["specinfra (2.94.1)"] --> net-telnet["net-telnet (0.2.0)"]
  voxpupuli-acceptance["voxpupuli-acceptance (4.1.0)"] --> beaker-vagrant["beaker-vagrant (2.0.0)"]
  beaker-vagrant["beaker-vagrant (2.0.0)"] --> beaker["beaker (7.2.0)"]
  voxpupuli-acceptance["voxpupuli-acceptance (4.1.0)"] --> puppet_fixtures["puppet_fixtures (2.0.0)"]
  puppet_fixtures["puppet_fixtures (2.0.0)"] --> rake["rake (13.3.0)"]
  voxpupuli-acceptance["voxpupuli-acceptance (4.1.0)"] --> puppet-modulebuilder["puppet-modulebuilder (2.1.0)"]
  voxpupuli-acceptance["voxpupuli-acceptance (4.1.0)"] --> rake["rake (13.3.0)"]
  voxpupuli-acceptance["voxpupuli-acceptance (4.1.0)"] --> rspec-github["rspec-github (3.0.0)"]
  voxpupuli-acceptance["voxpupuli-acceptance (4.1.0)"] --> serverspec["serverspec (2.43.0)"]
  voxpupuli-acceptance["voxpupuli-acceptance (4.1.0)"] --> winrm["winrm (2.3.9)"]

  classDef voxpupuli fill:#ffcccc,stroke:#aa0000,color:#000;
  classDef puppetlabs fill:#ccffcc,stroke:#009900,color:#000;
  class puppetlabs puppetlabs;
  class voxpupuli voxpupuli;
  class voxpupuli-acceptance voxpupuli;
  class beaker-hostgenerator voxpupuli;
  class hocon puppetlabs;
  class in-parallel puppetlabs;
  class stringify-hash puppetlabs;
  class beaker-docker voxpupuli;
  class beaker-hiera voxpupuli;
  class beaker_puppet_helpers voxpupuli;
  class puppet-modulebuilder puppetlabs;
  class beaker-rspec voxpupuli;
  class beaker-vagrant voxpupuli;
  class puppet_fixtures voxpupuli;
  class beaker voxpupuli;
</div>

### Linting

Vox Pupuli uses [puppet-lint](https://github.com/puppetlabs/puppet-lint) for better code quality.
To run it:

```shell
bundle exec rake lint
```

To automatically fix puppet-lint issues you can use:

```shell
bundle exec rake lint_fix
```

Aso run some [RuboCop](https://rubocop.org/) tests against it:

```shell
bundle exec rake rubocop
```

RuboCop also supports save autofixing:

```shell
bundle exec rake rubocop:autocorrect
```

And another autofix option that can fix more, but might break your code:

```shell
bundle exec rake rubocop:autocorrect_all
```

### REFERENCE.md update

If REFERENCE.md is now out of date you can fix it with:

```shell
bundle exec rake strings:generate:reference
```

### Unit tests

The unit test suite covers most of the code, as mentioned above please add tests if you're adding new functionality.
If you've not used [rspec-puppet](https://puppetlabs.github.io/rspec-puppet/) before then feel free to ask about how best to test your new feature.

To run the linter, the syntax checker and the unit tests:

```shell
bundle exec rake test
```

#### Detailed sub tasks

```shell
bundle exec rake spec
```

If you have multiple cpu cores available we suggest using the following command:

```shell
bundle exec rake parallel_spec
```

Single test file could be run by:

```shell
bundle exec rspec spec/classes/myclass_spec.rb
bundle exec rake spec SPEC=spec/classes/myclass_spec.rb
```

To limit test execution to a certain os or os release you can set the environment variable `SPEC_FACTS_OS`.

```shell
export SPEC_FACTS_OS=centos
export SPEC_FACTS_OS=centos-10
```

### Running Acceptance Tests

The unit tests just check the code runs, not that it does exactly what we want on a real machine.
For that we're using [Beaker](https://github.com/voxpupuli/beaker).

This fires up a new virtual machine or container and runs a series of simple tests against it after applying the module.

#### Installing Dependencies for Acceptance Tests

Follow the steps in [Installing Dependencies](#installing-dependencies) making sure to install the system\_tests group of dependencies.

```shell
bundle config set --local without 'development release'
```

#### Beaker Hypervisors

Beaker uses a local hypervisor or container stack to build required OS/Distributions to test.
By default this is Docker, but it [supports different hypervisors](https://github.com/voxpupuli/beaker/blob/master/docs/how_to/hypervisors/README.md) via additional gems.

**Note**: it also works with [Podman](https://podman.io/) but you need to point it to the appropriate socket, for example with `systemctl start --user podman.socket && export DOCKER_HOST=unix:///run/user/$(id -u)/podman/podman.sock`

Follow the instructions from [Docker](https://docs.docker.com/engine/install/) or your preferred/known working method to install.

For libvirt / vagrant, use the distribution's packages to configure.

_Remember to add your user to the group that allows access to docker/libvirt._

#### Environment Variables and hostnames

For Vox Pupuli's acceptance testing suite, Beaker is managed by a set of environment variables.

* `BEAKER_HYPERVISOR` Sets the Hypervisor, `vagrant` or `vagrant_libvirt` for VM based testing
  It is a good idea to export the `BEAKER_HYPERVISOR` variable in your shell configuration.
* `BEAKER_DESTROY` Should the test environment be removed at the end of a test
  * `BEAKER_DESTROY=onpass` Only removes the environment if everything passes, allowing review of the system in the state it was in when the test suite failed.
  * `BEAKER_DESTROY=no` Always leave an artifact, which likely will break future runs without cleanup.
  * `BEAKER_DESTROY=yes` _(DEFAULT)_ always clean up.
* `BEAKER_PROVISION` Should we ensure a clean system is built to run the suite.
  * If `BEAKER_DESTROY` is set to no, `BEAKER_PROVISION=yes` will fail the run (because of the existing box/container)
  * If `BEAKER_DESTROY` is set to no, `BEAKER_PROVISION=no` will run the test suite against the system anyways, which may cause environmental issues if the test suite doesn't perfectly put things to a default state.

* `BEAKER_SETFILE` What should we be testing.  Beaker will call beaker-hostgenerator to create a defaultconfiguration based on this, using the known configurations for Vox Pupuli.
* `BEAKER_PUPPET_COLLECTION` What implementation and version of Puppet are we testing against

These are all defined in [voxpupuli-acceptance](https://github.com/voxpupuli/voxpupuli-acceptance/#running-tests) to review how they are used and more specialized features.

#### Getting setfiles for a module

Installed as part of the voxpupuli test suite is `metadata2gha`, which as its name suggests, is a helper to generate a json blob containing the variables for all supported oses.

```shell
# From the base directory of the module
$ bundle exec metadata2gha | grep puppet_beaker_test_matrix | cut -d= -f2- | jq
[
# ... truncated for length
  {
    "name": "Puppet 8 - Debian 12",
    "env": {
      "BEAKER_PUPPET_COLLECTION": "puppet8",
      "BEAKER_SETFILE": "debian12-64{hostname=debian12-64-puppet8}"
    }
  },
  {
    "name": "Puppet 7 - Debian 12",
    "env": {
      "BEAKER_PUPPET_COLLECTION": "puppet7",
      "BEAKER_SETFILE": "debian12-64{hostname=debian12-64-puppet7}"
    }
  },
# ... truncated for length
  {
    "name": "OpenVox 8 - Rocky 9",
    "env": {
      "BEAKER_PUPPET_COLLECTION": "openvox8",
      "BEAKER_SETFILE": "rocky9-64{hostname=rocky9-64-openvox8}"
    }
  },
  {
    "name": "OpenVox 7 - Rocky 9",
    "env": {
      "BEAKER_PUPPET_COLLECTION": "openvox7",
      "BEAKER_SETFILE": "rocky9-64{hostname=rocky9-64-openvox7}"
    }
  },
# ... truncated for length
]
```

This returns names that show Puppet implementation (OpenVox or Puppet) / language version, and operating system / version.
It also provides the environment variables needed to be applied to run Beaker for this combination.

#### Running Beaker

Running Beaker is handled via a rake task `bundle exec rake beaker`, and either exporting variables or setting them for a single run are both supported:

1. export variables, then run `bundle exec rake beaker`

   ```shell
   export BEAKER_SETFILE="ubuntu2404-64"
   bundle exec rake beaker
   ```

1. run `bundle exec rake beaker` with inline shell variables

   ```shell
   BEAKER_SETFILE="ubuntu2404-64" bundle exec rake beaker
   ```

Some softwares might also need to have an hostname set on the VM, to be used as FQDN, it is possible to set is through `BEAKER_SETFILE`:

```shell
BEAKER_SETFILE="almalinux9-64{hostname=almalinux9-64-puppet8.example.com}" bundle exec rake beaker
```

If you need to run tests against a different version or implementation of OpenVox (or Puppet) you can either `export BEAKER_PUPPET_COLLECTION="openvox7"` or add `BEAKER_PUPPET_COLLECTION="openvox7"` to your command line.


```shell
BEAKER_PUPPET_COLLECTION="openvox7" BEAKER_SETFILE="ubuntu2404-64" bundle exec rake beaker
```

#### Custom Facts

Projects might also have custom facts that can be set through environment variables, for example [puppet-zabbix](https://github.com/voxpupuli/puppet-zabbix) tests against a specific Zabbix version setting `BEAKER_FACTER_zabbix_version` which will pass a custom fact to the system of zabbix\_version:

```shell
BEAKER_SETFILE="almalinux9-64" BEAKER_FACTER_zabbix_version="6.0" bundle exec rake beaker
```

For these cases refer to the module's documentation and/or on GitHub CIs check the env for `bundle exec rake beaker` in tests.

For additional information, you can review [voxpupuli-acceptance](https://github.com/voxpupuli/voxpupuli-acceptance?tab=readme-ov-file#environment-variables-to-facts).

#### Run a specific test

As with unit tests, it is possible to run only a specific acceptance test, for example:

```shell
bundle exec rspec spec/acceptance/foo.rb
```

## Running the tests in the VoxBox container

Struggling with Ruby installations or dependency issues? [VoxBox](https://github.com/voxpupuli/container-voxbox/) simplifies your workflow by providing a ready-to-use container with all the Ruby tools you need. To guarantee a consistent rake environment, use `-f /Rakefile` to explicitly specify your Rakefile, rather than relying on potentially outdated versions in a repository. Learn more in the project's [README](https://github.com/voxpupuli/container-voxbox/blob/main/README.md).

### Installation

```shell
podman pull ghcr.io/voxpupuli/voxbox:8
```

### Linting in VoxBox

```shell
cd my/module
podman run -it --rm -v $PWD:/repo:Z ghcr.io/voxpupuli/voxbox:8 -f /Rakefile lint
podman run -it --rm -v $PWD:/repo:Z ghcr.io/voxpupuli/voxbox:8 -f /Rakefile lint_fix

# lint with all lint plugins enabled, puppetlabs-spec_helper deactivates some of them
podman run -it --rm -v $PWD:/repo:Z ghcr.io/voxpupuli/voxbox:8 -f /Rakefile voxpupuli:custom:lint_all
```

### Rubocop

```shell
podman run -it --rm -v $PWD:/repo:Z ghcr.io/voxpupuli/voxbox:8 -f /Rakefile rubocop
podman run -it --rm -v $PWD:/repo:Z ghcr.io/voxpupuli/voxbox:8 -f /Rakefile rubocop:autocorrect
```

### Unit tests in VoxBox

```shell
podman run -it --rm -v $PWD:/repo:Z ghcr.io/voxpupuli/voxbox:8 -f /Rakefile spec
podman run -it --rm -e "SPEC_FACTS_OS=centos" -v $PWD:/repo:Z ghcr.io/voxpupuli/voxbox:8 -f /Rakefile spec
podman run -it --rm -e "SPEC=spec/classes/myclass_spec.rb" -v $PWD:/repo:Z ghcr.io/voxpupuli/voxbox:8 -f /Rakefile spec
```

### REFERENCE.md update in VoxBox

```shell
podman run -it --rm -v $PWD:/repo:Z ghcr.io/voxpupuli/voxbox:8 -f /Rakefile strings:generate:reference
```

### Puppetfile

```shell
podman run -it --rm -v $PWD:/repo:Z ghcr.io/voxpupuli/voxbox:8 -f /Rakefile r10k:syntax
podman run -it --rm -v $PWD:/repo:Z ghcr.io/voxpupuli/voxbox:8 -f /Rakefile r10k:dependencies
```
