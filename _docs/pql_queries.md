---
layout: post
title: Useful PQL Queries
date: 2022-07-01
summary: A community-collection of PQL queries
---

* TOC
{:toc}

## What?

PQL is the [Puppet Query Language](https://puppet.com/docs/puppetdb/latest/api/query/examples-pql.html). You can use it to query the PuppetDB for information.

## Why?

The syntax isn't alway very intuitive. That's why this page exists. It serves as a central place where the community can find and submit PQL queries!

## How?

All queries here are documented in the [string-based query style](https://puppet.com/docs/puppetdb/7/api/query/v4/pql.html), not the [AST](https://puppet.com/docs/puppetdb/7/api/query/v4/ast.html) style. You need the [Puppet Client tools](https://puppet.com/docs/puppetdb/7/pdb_client_tools.html) (for Open Source or PE) to get the `puppet query` face. To install the client tools on Open Source, you can do:

```shell
puppet resource package puppetdb_cli ensure=present provider=puppet_gem
```

And Afterwards run the query with `/opt/puppetlabs/puppet/bin/puppet-query $query`. For PE installations you can use `puppet query`.

On the PuppetServer side, installing the `puppetdb-termini` package allow to use the `puppetdb_query()` function in a manifest to generate portions of catalog based on result of queries, e.g. find all Virtual-Hosts on all machines and add the relevant configuration to a monitoring system.

## Contribute?!

You can submit your own Queries by editing [voxpupuli.github.io/_docs/pql_queries.md](https://github.com/voxpupuli/voxpupuli.github.io/blob/master/_docs/pql_queries.md) on GitHub or by pressing the edit button in the upper right corner.

## Query Collection

### List all certificate names from all known nodes

```shell
puppet query 'nodes[certname] {}'
```

Result:

```json
[
  {
    "certname": "puppetserver.example.org"
  },
  {
    "certname": "puppetdb.example.org"
  }
]
```

### Get all nodes that have a specific class in their catalog

This is useful if you want to get a list of nodes with a specific profile or role

```shell
puppet query 'nodes[certname] {resources {type = "Class" and title = "CapitalizedClassname"}}'
```

### Get a list of all roles / profiles

```shell
puppet query 'resources[title] {type = "Class" and title ~ "Role" group by title}'
```

Result:

```json
[
  {
    "title": "Role::Base"
  },
  {
    "title": "Role::Webserver"
  },
  {
    "title": "Role::Mailserver"
  },
  {
    "title": "Role::Backupnode"
  }
]
```

### Get all nodes that have a specific class in their catalog and start with bla-

```shell
puppet query 'nodes[certname] {certname ~ "^bla-" and resources {type = "Class" and title = "CapitalizedClassname"}}'
```

### Get all nodes with changes and a specific resource

```shell
puppet query 'nodes[certname] {latest_report_status = "changed" and certname in inventory[certname]{resources { type = "Service" and title = "my_service"}}}'
```

### Get all nodes where one specific resource changed

```shell
puppet query 'events[certname] {resource_type = "Service" and resource_title = "apache2" and latest_report? = true and corrective_change = true}'
```

### Get a list of nodes with stale catalogs (`date -R` to see your time offset)

```shell
puppet query 'catalogs[certname,producer_timestamp] {  producer_timestamp < "2022-06-21T07:00:00.000-05:00" }'
```

### Get a list of nodes with a catalog that has failed to compile but used a cached catalog during a specific time window

```shell
puppet query 'reports[certname,transaction_uuid,receive_time] { cached_catalog_status="on_failure" and start_time > "2021-10-27T15:36:00-05:00" and end_time < "2021-10-27T16:35:00-05:00"  }'
```

### Get a list of nodes with a specific fact value

```shell
puppet query 'inventory[certname] { facts.os.name = "windows" }'
```

### Get a list of nodes with two specific facts

```shell
puppet query 'inventory[certname] {facts.os.name = "AlmaLinux" and facts.os.release.major = "8" }'
```

```json
[
  {
    "certname": "puppet.local"
  }
]
```

### Print fact value (facts.virtual in this example) for nodes with a specific class

```shell
puppet query 'inventory[certname,facts.virtual]{ resources { type="Class" and title ~ "CapitalizedClassname" }}'
```

### Get all resources from one type for one node

```shell
puppet query 'resources {type = "File" and certname = "puppet.local"}'
```

### Get one param/attribute for one type of resource for one node

In this case, `file` is a resource property, it's the absolute path to the pp file where the resource was declared

```shell
puppet query 'resources[file] {type = "File" and certname = "puppet.local"}'
```

### Count all resources of one type

This checks all catalogs in the PuppetDB for this resource type and counts it

```shell
puppet query 'resources[count()] {type = "File" }'
```

### Count all resources

```shell
puppet query 'resources[count()] { }'
```

### Get a list of nodes for which a fact is not set

```shell
puppet query 'inventory[certname] { ! certname in inventory[certname] {  facts.myfactofinterest is not null } }'
```

### Get a list of nodes with a specific structured fact value while using a wildcard in the fact structure

```shell
puppet query ' fact_contents { path ~> ["first_level",".*","third_level"] and value = "Y" } '
```

### Get all values for a fact

This fetches a specified fact from all nodes and groups them by value. The
result is a unique list of values for the fact:

```shell
puppet query 'facts[value]{ name = "domain" group by value}'
```

Result:

```json
[
  {
    "value": "example.org"
  },
  {
    "value": "example.com"
  }
]

```

### Get all values for a trusted fact

With the following query you can get a unique list of different values from the trusted hash

#### via inventory

```shell
puppet query 'inventory[trusted.extensions.pp_role]{ group by trusted.extensions.pp_role }'
```

Result:

```json
[
  {
    "trusted.extensions.pp_role": "guacamole"
  },
  {
    "trusted.extensions.pp_role": "gitlab"
  },
  {
    "trusted.extensions.pp_role": "kibana"
  }
]
```

#### via facts_contents

See also [Get a list of nodes with a specific structured fact value while using a wildcard in the fact structure](#get-a-list-of-nodes-with-a-specific-structured-fact-value-while-using-a-wildcard-in-the-fact-structure)

```shell
puppet query 'fact_contents[value] { path = ["trusted","extensions","pp_role"] group by value }'
```

Result:

```json
[
  {
    "value": "guacamole"
  },
  {
    "value": "gitlab"
  },
  {
    "value": "kibana"
  }
]
```

### Get a sorted list of all recent event failures

This gives a list of recent event failures from the lastest reports and applies counts to them to show how many
of them are occurring across your nodes.  In order to sort by the counts, the command has to be combined with `jq`,
which is typically another package that has to be installed on your system.

```shell
puppet query 'events[resource_type,resource_title,count()] { latest_report? = true and status = "failure" group by resource_type, resource_title }' | jq 'sort_by(.count) | reverse'
```

## Endpoints and fields

The available endpoints is a function of which version of puppetdb you are going against. The current list is available at <https://puppet.com/docs/puppetdb/7/api/query/v4/entities.html>.

If you don't feel like looking up which fields are available for a given endpoint, use a bogus field name and the `puppet query` tool will return the valid list.

```console
$ puppet query 'resources[foo] {}'
2022/07/21 10:02:41 ERROR - [GET /pdb/query/v4][400] getQueryBadRequest  Can't extract unknown 'resources' field 'foo'. Acceptable fields are 'resource', 'certname', 'tags', 'exported', 'line', 'title', 'type', 'environment', 'file', and 'parameters'
```
