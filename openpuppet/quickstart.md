---
layout: page
title: OpenPuppet Quickstart Guide
subsection: openpuppet
---

<img class="float-end w-33 mx-5 img-thumbnail shadow-lg" src="/static/images/openpuppet/manikin.png" />

As of now, OpenPuppet is effectively the same as the original Puppet™️ packages,
aside from some minor build pipeline changes and package renaming. This means
that aside from the installation, all Puppet™️ docs and tutorials will still be
completely applicable.

## Installation

Start by following the instructions on the [install page](/openpuppet/install)
and installing the `puppet-agent` package only. Then come back here to continue.

## Explore the resources on your system

Now that you have OpenPuppet installed, explore around and take a look at how it
sees your system. This command will show you how OpenPuppet represents the current
state of a specific kind of resource, in this case the `user` resources. The
output will be your first view of the Puppet™️ DSL (domain specific language).

```
# puppet resource user
```

Pick the name of one of your user resources and run again. This shows the same
output, but scoped to a single user.

```
# puppet resource user binford2k
```

Try a similar command with the `file` resource and the name of a file on your
computer, maybe `/etc/hosts`.

```
# puppet resource file /etc/hosts
```

Now you see how OpenPuppet sees resources as the *type* and *title* of the
resource and then a list of *attributes* of that resource.

Just for fun, try using `puppet resource` to list all the `file` resources. This
doesn't work because unlike users which are easily *enumerable*, all the files
on a modern computer are not computationally feasible to enumerate.

## Manage state of a resource

You'll notice that the output of the `puppet resource` commands is extremely
thorough. That's because it's exhaustively describing all the state known about
every resource. Generally speaking, you don't really care about all the details.
When you write Puppet™️ code, you only need to describe the things you do care
about.

Let's try that now. Create a *manifest*, or a source file of Puppet™️ code.

``` puppet
# hello.pp
file { '/tmp/foo':
  ensure  => file,
  owner   => 'root',
  mode    => '0664', # mode is a nerdy word for "permissions"
  content => "Hello there from OpenPuppet!\n",
}
```

```
$ puppet apply hello.pp
```

Now examine `/tmp/foo` and see that it meets all the specifications you described
in your manifest, including the string of content.

## Go forth and experiment!

As the OpenPuppet project matures, we will create more documentation, guides, and
tutorials. For the time being though, now you'll want to hop over to Puppet's own
[documentation](http://puppet.com/docs) and go from there.

Please use the *Connect* resources in the menubar to engage with us and share
any questions or thoughts you have!
