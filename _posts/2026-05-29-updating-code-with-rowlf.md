---
date: 2026-05-29
github_username: lollipopman
layout: post
title: Rowlf, because some dogs do climb trees
---

## Rationale

Automating the updating of some source code is often as simple as a
nicely crafted `sed` one liner. But, for more complex tasks you may need
a tool that can reason about the code structure a bit more. Migrating
away from [legacy Puppet
facts](https://help.puppet.com/core/current/Content/PuppetCore/Markdown/core_facts.htm#LegacyFacts)
in a [large Puppet code
base](https://gerrit.wikimedia.org/g/operations/puppet) is just such a
task. Most programming languages take source code text and turn it into
an [abstract syntax
tree](https://en.wikipedia.org/wiki/Abstract_syntax_tree). Puppet uses
the same methodology, turning this source code text:

Example one:

``` puppet
class bubbles(
    Integer $count,
){
    file { '/tmp/count':
        content => $count
    }
}
```

Into the AST:

    (class
      {
        :name "bubbles"
        :params {
          :count {
            :type (qr
              "Integer")}}
        :body [
          (resource
            {
              :type (qn
                "file")
              :bodies [
                {
                  :title "/tmp/count"
                  :ops [
                    (=>
                      "content"
                      (var
                        "count"))]}]})]})

Operating on the abstract syntax tree allows you update a `$facts`
variable that is accessed with `hostname` in many different source code
text forms:

``` puppet
$a = $facts["hostname"]
$a = $facts["hostname" ]
$a = $facts['hostname']
$a = $facts[hostname]
$a = "${facts['hostname']}"
```

You could make the same update with a regex, but you need to know and
account for all the possible syntax varieties. In addition it becomes
difficult to add logic to a regex, e.g. do not update variables on the
left hand side of an assignment.

Operating on the AST is the approach taken by
[puppet-lint](https://github.com/puppetlabs/puppet-lint/blob/main/lib/puppet-lint/plugins/legacy_facts/legacy_facts.rb)
for migrating away from legacy facts. Puppet-lint has good support for
migrating many legacy facts, but I had two primary desires in crafting a
new tool. First, I wanted a tool that supported migrating away from
legacy facts in Puppet, EPPs, Ruby, ERBs, and Hiera YAML. Second, I
wanted to explore the feasibility of using Tree-sitter to
programmatically update Puppet code.

## Tree-sitter

[Tree-sitter](https://tree-sitter.github.io/tree-sitter/index.html)
provides a grammar to create parsers for languages, which then emit an
AST for that language. Tree-sitter defines an API to walk, query, and
edit the AST of any language, which has a Tree-sitter parser. One
distinctive feature of Tree-sitter is that it does not discard the
source text after crafting the AST, as do many parsers. Tree-sitter
provides functions for editing the source text and regenerating the AST.
Tree-sitter rose to fame using these capabilities to provide syntax
highlighting in [Neovim](https://neovim.io/doc/user/treesitter/) based
on an AST, rather than using regexes as is done in
[Vim](https://vimhelp.org/syntax.txt.html#%3Asyn-pattern). The same code
in example one parsed with Tree-sitter, the ranges in square brackets
correspond to the source text line and column numbers:

``` scheme
(manifest [0, 0] - [7, 0]
  (statement [0, 0] - [6, 1]
    (class_definition [0, 0] - [6, 1]
      (classname [0, 6] - [0, 13]
        (name [0, 6] - [0, 13]))
      (parameter_list [0, 13] - [2, 1]
        (parameter [1, 4] - [1, 18]
          (typed_parameter [1, 4] - [1, 18]
            (type [1, 4] - [1, 11])
            (regular_parameter [1, 12] - [1, 18]
              (variable [1, 12] - [1, 18]
                (name [1, 13] - [1, 18]))))))
      (block [2, 1] - [6, 1]
        (statement [3, 4] - [5, 5]
          (resource_type [3, 4] - [5, 5]
            (name [3, 4] - [3, 8])
            (resource_body [3, 11] - [4, 25]
              (resource_title [3, 11] - [3, 23]
                (single_quoted_string [3, 11] - [3, 23]))
              (attribute_list [4, 8] - [4, 25]
                (attribute [4, 8] - [4, 25]
                  name: (name [4, 8] - [4, 15])
                  (arrow [4, 16] - [4, 18])
                  value: (variable [4, 19] - [4, 25]
                    (name [4, 20] - [4, 25])))))))))))
```

## Tree-sitter queries

To edit the Tree-sitter AST you can walk the tree and look for a given
pattern of nodes or you can
[query](https://tree-sitter.github.io/tree-sitter/using-parsers/queries/index.html)
and capture specific groups of nodes. Rowlf uses the latter approach. To
look for all non-fact variables it uses the following query:

``` scheme
(variable
    "$"? @var-sigil
    (name) @varname
    (#not-eq? @varname "facts")
    (#not-eq? @varname "::facts")
) @non-facts-var
```

Rowlf then uses the captures from that query to look for legacy fact
variables, e.g. `$::hostname` and replace any occurrences with the
corresponding structured fact.

## Difficult legacy facts and unscoped facts

Some of the legacy facts which do not have a one to one correspondence
with a structured fact are [not fixed
automatically](https://github.com/puppetlabs/puppet-lint/blob/main/lib/puppet-lint/plugins/legacy_facts/legacy_facts.rb#L14)
by `puppet-lint`. Puppet-lint could be taught how to handle these facts,
but, I added support for most of them in Rowlf:

``` diff
--- a/modules/role/manifests/redis/misc/master.pp
+++ b/modules/role/manifests/redis/misc/master.pp
@@ -3,7 +3,7 @@ class role::redis::misc::master {
     include profile::firewall

     # maxmemory depends on host's total memory
-    $per_instance_memory = floor($facts['memorysize_mb'] * 0.8 / 5)
+    $per_instance_memory = floor(($facts['memory']['system']['total_bytes'] / 1048576.0) * 0.8 / 5)

     include profile::redis::master
 }
```

Of course sometimes the diff reads as dog logic, but at least the result
should be the same:

``` diff
--- a/modules/interface/manifests/add_ip6_mapped.pp
+++ b/modules/interface/manifests/add_ip6_mapped.pp
@@ -10,9 +10,9 @@

 define interface::add_ip6_mapped(
   $interface=$facts['interface_primary'],
-  $ipv4_address=$facts['ipaddress'],
+  $ipv4_address=$facts['networking']['ip'],
 ) {
-    if ! member(split($facts['interfaces'], ','), $interface) {
+    if ! member(split($facts['networking']['interfaces'].keys.join(','), ','), $interface) {
         fail("Not adding IPv6 address to ${interface} because this interface does not exist!")
     }
```

One of the reasons Puppet moved to structured facts is that variables in
a local scope may shadow unscoped legacy facts:

``` puppet
notify { 'fact': message => $hostname }
$hostname = 'butter'
notify { 'local var': message => $hostname }
```

When using the `$facts` hash this is no longer possible as the `$facts`
variable name is reserved. Unfortunately, migrating unscoped facts to
structured facts is more difficult, as you need to determine if the fact
has been shadowed by a local variable before updating. This is
particularly difficult in an ERB where you do not have the locally
scoped Puppet code in the safe file. Rowlf has the ability to update
unscoped facts using the `-u` option, but at present it does not do any
analysis to determine if the fact has been shadowed, so the generated
diffs need careful manual review.

## Challenges

The idea of using Tree-sitter to edit Puppet code was attractive, but
when you have never used a tool in anger, you are often a victim of the
[Dunning Kruger
effect](https://en.wikipedia.org/wiki/Dunning%E2%80%93Kruger_effect), as
was I. There were two main sources of difficulty. First Tree-sitter
parsers are difficult to write, even with Tree-sitters helpful
[grammar](https://tree-sitter.github.io/tree-sitter/creating-parsers/2-the-grammar-dsl.html).
For complex language constructs you often have to use the option of
external C code to properly parse a language. Ruby's parser, which is
fairly complete, uses this feature
[extensively](https://github.com/tree-sitter/tree-sitter-ruby/blob/master/src/scanner.c).
Tree-sitter has a Puppet parser, but it is dormant and lacks support for
a number of language
[features](https://github.com/tree-sitter-grammars/tree-sitter-puppet/issues).
Another Puppet Tree-sitter parser maintained by Stefan Möding has much
better language support and Stefan was kind enough to shepherd in my
changes to support [parsing
interpolations](https://github.com/smoeding/tree-sitter-puppet/pull/3)
and to improve [parsing
heredocs](https://github.com/smoeding/tree-sitter-puppet/pull/4), among
other small fixes. The second source of difficulty was understanding the
Tree-sitter API and the language specific Go wrapper. The Tree-sitter
docs are good, but terse. The Go wrapper docs mostly assume you
understand the workings of the native API. I switched from
<https://github.com/smacker/go-tree-sitter> to the official Go bindings,
<https://github.com/tree-sitter/go-tree-sitter>. The latter is much less
ergonomic, but the former is dormant upstream.

## How to

1.  Install

    ``` bash
    $ git clone https://gitlab.wikimedia.org/repos/sre/rowlf
    $ cd rowlf
    $ make install
    ```

2.  Point it at your Puppet repo

    ``` bash
    $ rowlf -i <PUPPET REPO>
    ```

## Future ideas

With my feet now dangling from the tree I have few ideas on which
branches to climb next:

1.  Better analysis of locally scoped fact shadowing

2.  Support for migrating RSpec tests away from legacy facts

    This is tough, because Rspec's DSL can be used in so many different
    ways.

3.  Automatic fixing of Puppet Stdlib deprecations

4.  Puppet code formatting

## Feedback

If you get a chance to try the tool, please:

1.  Send any feedback my way, <jhathaway@wikimedia.org>
2.  Craft a [pull request](https://gitlab.wikimedia.org/repos/sre/rowlf)
3.  [Find more
    bugs](https://phabricator.wikimedia.org/maniphest/task/edit/form/43/?tags=rowlf)
