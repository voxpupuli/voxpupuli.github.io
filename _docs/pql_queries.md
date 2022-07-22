---
layout: post
title: Useful PQL Queries
date: 2022-07-01
summary: A community-collection of PQL queries
---

## What?

PQL is the [Puppet Query Language](https://puppet.com/docs/puppetdb/latest/api/query/examples-pql.html). You can use it to query the PuppetDB for information.

## Why?

The syntax isn't alway very intuitive. That's why this page exists. It serves as a central place where the community can find and submit PQL queries!

## How?

All queries here are documented in the [string-based query style](https://puppet.com/docs/puppetdb/7/api/query/v4/pql.html), not the [AST](https://puppet.com/docs/puppetdb/7/api/query/v4/ast.html) style. You need the [Puppet Client tools](https://puppet.com/docs/puppetdb/7/pdb_client_tools.html) (for Open Source or PE) to get the `puppet query` face. To install the client tools on Open Source, you can do:

```
puppet resource package puppetdb_cli ensure=present provider=puppet_gem
```

And Afterwards run the query with `/opt/puppetlabs/puppet/bin/puppet-query $query`. For PE installations you can use `puppet query`.

On the PuppetServer side, installing the `puppetdb-termini` package allow to use the `puppetdb_query()` function in a manifest to generate portions of catalog based on result of queries, e.g. find all Virtual-Hosts on all machines and add the relevant configuration to a monitoring system.

## Contribute?!

You can submit your own Queries by editing [voxpupuli.github.io/_docs/pql_queries.md](https://github.com/voxpupuli/voxpupuli.github.io/blob/master/_docs/pql_queries.md) on GitHub or by pressing the edit button in the upper right corner.

## Query Collection

### List all certificate names from all known nodes

```
puppet query 'nodes[certname] {}'
```

Result:

```
[
  {
    "certname": "puppetserver.bastelfreak.org"
  },
  {
    "certname": "puppetdb.bastelfreak.org"
  }
]
```

### Get all nodes that have a specific class in their catalog

```
puppet query 'nodes[certname] {resources {type = "class" and title = "CapitalizedClassname"}}'
```

### Get all nodes that have a specific class in their catalog and start with bla-

```
puppet query 'nodes[certname] {certname ~ "^bla-" and resources {type = "class" and title = "CapitalizedClassname"}}'
```

### Get all nodes with changes and a specific resource

```
puppet query 'nodes[certname] {latest_report_status = "changed" and certname in inventory[certname]{resources { type = "Service" and title = "my_service"}}}'
```

### Get all nodes where one specific resource changed

```
puppet query 'events[certname] {resource_type = "Service" and resource_title = "apache2" and latest_report? = true and corrective_change = true}'
```

### Get a list of nodes with stale catalogs (`date -R` to see your time offset)

```
puppet query 'catalogs[certname,producer_timestamp] {  producer_timestamp < "2022-06-21T07:00:00.000-05:00" }'
```

### Get a list of nodes with a catalog that has failed to compile but used a cached catalog during a specific time window

```
puppet query 'reports[certname,transaction_uuid,receive_time] { cached_catalog_status="on_failure" and start_time > "2021-10-27T15:36:00-05:00" and end_time < "2021-10-27T16:35:00-05:00"  }'
```

### Get a list of nodes with a specific fact value

```
puppet query 'inventory[certname] { facts.os.name = "windows" }'
```

### Print fact value (facts.virtual in this example) for nodes with a specific class

```
puppet-query 'inventory[certname,facts.virtual]{ resources { type="Class" and title ~ "CapitalizedClassname" }}'
```

### Get all resources from one type for one node

```
puppet query 'resources {type = "File" and certname = "puppet.local"}'
```

### Get one param/attribute for one type of resource for one node

In this case, `file` is a resource property, it's the absolute path to the pp file where the resource was declared

```
puppet query 'resources[file] {type = "File" and certname = "puppet.local"}'
```

### Count all resources of one type

This checks all catalogs in the PuppetDB for this resource type and counts it

```
puppet query 'resources[count()] {type = "File" }'
```

### Count all resources

```
puppet query 'resources[count()] { }'
```

### Get a list of nodes for which a fact is not set

```
puppet query 'inventory[certname] { ! certname in inventory[certname] {  facts.myfactofinterest is not null } }'
```

## Endpoints and fields
The available endpoints is a function of which version of puppetdb you are going against. The current list is available at https://puppet.com/docs/puppetdb/7/api/query/v4/entities.html

If you don't feel like looking up which fields are available for a given endpoint, use a bogus field name and the `puppet query` tool will return the valid list.

```
puppet-query 'resources[foo] {}'
2022/07/21 10:02:41 ERROR - [GET /pdb/query/v4][400] getQueryBadRequest  Can't extract unknown 'resources' field 'foo'. Acceptable fields are 'resource', 'certname', 'tags', 'exported', 'line', 'title', 'type', 'environment', 'file', and 'parameters'
```
