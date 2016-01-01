---
layout: post
title: Modern testing in Puppet
date: 2014-04-22
github_username: apenney
---

At Puppet Labs, we've been busy over the last few months, working on overhauling our
public modules to treat them as distinct pieces of software rather than less tested one-offs.

A huge part of the overhaul has centered on testing the modules properly, and today
I want to give a quick overview to the current, state of the art testing available for modules.

## rspec-puppet

Rspec-puppet has been around for a long time now.  Until recently, it was the
only testing choice out there and was used fairly heavily for Puppet Labs
modules.  Written by Tim Sharpe, rspec-puppet allows you to build catalogs in
rspec and then verify that various resources appear, along with what their properties
may be.  For a very simple example of this we can look at the ntp module.

In ntp, we start with a describe block, which is a standard part of
[rspec](http://rspec.info/) and acts as a kind of container for all the stuff
relating to specific tests.  We give it the name of the class we're testing.
We then create more describe blocks to allow us to explain very specifically
what we're going to be testing.

After that, we use `let` to create a params variable, which contains the
parameters we're passing into the ntp class.  We have to declare this as a
hash of parameters.

```ruby
describe 'ntp' do
  describe "keys for osfamily #{system}" do
    describe "when enabled" do
      let(:params) do
        {
          :keys_enable => true,
          :keys_file => '/etc/ntp/ntp.keys',
          :keys_trusted => ['1', '2', '3'],
          :keys_controlkey => '2',
          :keys_requestkey => '3',
        }
      end
```

Next, we create several `it` blocks, which contain the actual tests.  Here
we're stating that it should contain a `file{}` resource with the title of
`/etc/ntp`, and that that it should have various properties.  For the content
checks, we use a regular expression to look within the rendered template
for ntp.conf.

```ruby
      it { should contain_file('/etc/ntp').with({
        'ensure' => 'directory'})
      }
      it { should contain_file('/etc/ntp.conf').with({
        'content' => /trustedkey 1 2 3/})
      }
      it { should contain_file('/etc/ntp.conf').with({
        'content' => /controlkey 2/})
      }
      it { should contain_file('/etc/ntp.conf').with({
        'content' => /requestkey 3/})
      }
    end
```

Finally, we do the reverse, and check that when disabled it doesn't contain
the content you get when you enable `keys_enable`.

```ruby
    describe "when disabled" do
      let(:params) do
        {
          :keys_enable => false,
          :keys_file => '/etc/ntp/ntp.keys',
          :keys_trusted => ['1', '2', '3'],
          :keys_controlkey => '2',
          :keys_requestkey => '3',
        }
      end

      it { should_not contain_file('/etc/ntp').with({
        'ensure' => 'directory'})
      }
      it { should_not contain_file('/etc/ntp.conf').with({
        'content' => /trustedkey 1 2 3/})
      }
      it { should_not contain_file('/etc/ntp.conf').with({
        'content' => /controlkey 2/})
      }
      it { should_not contain_file('/etc/ntp.conf').with({
        'content' => /requestkey 3/})
      }
    end
  end
end
```

There's a ton more information to be found at the [rspec-puppet
website](http://rspec-puppet.com/), including a full list of all the available
"matchers" (things you can test).

## Beaker and beaker-rspec

The previous kind of unit testing is a great way to do quick, lightweight,
testing of your module.  It lets you quickly see if you've renamed a resource
that breaks another class, or you've accidently changed the logic of a class in
such a way that it adds content when you don't want it to.  However, it's just
testing the contents of the catalog, what it can't do is test what actually
happens on a real live server.

That kind of testing is generally called acceptance testing, and
[Beaker](https://github.com/puppetlabs/beaker) is our internal framework for
this kind of testing.  It's a little rough and ready around the edges in terms
of documentation, because it was only used internally until the module team
started adopting it for modules and spreading the good word about how powerful
this kind of testing can be.

Beaker is a framework to automatically create and manage virtual machines on
various hypervisors, then apply numerous rspec tests against those virtual
machines, then delete and destroy the machines as required.

We're working on better documentation, as well as long guides designed to take
you from a blank module to a completely tested module, but in the meantime I
hope this blog post can be enough inspiration to help you get started without
those other kinds of documentation!

We'll take a hypothetical module, puppet-ssh, and add Beaker testing to it.  We
start with creating the 'spec_helper_acceptance.rb' file in the specs
directory. This is a central place to put setup information for Beaker,
generally things like code to install Puppet or modules.

First we add beaker to our Gemfile.  If we don't have one of those just cut
and paste the below into a file called Gemfile in the root of your module.

```ruby
source 'https://rubygems.org'
gem 'beaker-rspec'
```

And if we're [bundler](http://bundler.io/) users (and we're all bundler
users here, right?) we just run bundle install to get all the dependencies
needed for beaker-rspec.

Once this is done we need to create some framework for Beaker.  We'll start
by creating a very simple "nodeset", a yaml file that lists out a virtual
machine to test against.  We'll put this in spec/acceptance/nodesets/default.yml.

```
HOSTS:
  centos-65-x64:
    roles:
      - master
    platform: el-6-x86_64
    box : centos-65-x64-vbox436-nocm
    box_url : http://puppet-vagrant-boxes.puppetlabs.com/centos-65-x64-virtualbox-nocm.box
    hypervisor : vagrant
CONFIG:
  type: foss
```

These can be much more complex, including multiple hosts, but we'll keep it
simple.  Next we create spec/spec_helper_acceptance.rb.  We begin this file by
requiring beaker-rspec itself.  The next block checks to see if we've passed in
certain environment options when running beaker (we'll talk more about these
later) and only runs the provisioning code if we didn't set RS_PROVISON=no.

Assuming we didn't set that, it then checks the nodeset that we pass to Beaker
to determine if it should install Puppet Enterprise or plain old Puppet.

```ruby
require 'beaker-rspec'

unless ENV['RS_PROVISION'] == 'no'
  hosts.each do |host|
    # Install Puppet
    if host.is_pe?
      install_pe
    else
      install_puppet
    end
  end
end
```

Next is some boilerplate RSpec.configure information.  We're creating a
proj_root variable that points to the module we're testing, as well as making
the rspec output a little prettier and easier to read.

```ruby
RSpec.configure do |c|
  # Project root
  proj_root = File.expand_path(File.join(File.dirname(__FILE__), '..'))

  # Readable test descriptions
  c.formatter = :documentation
```

This final block says "before you run an actual test, do the following", which
then calls puppet_module_install() to install the current module into 'ssh' on
the virtual machine, as well as runs two shell commands to create an empty
hiera.yaml and install stdlib.  Here we see :acceptable_exit_codes for the
first time, one of our primary ways of asserting the exit codes we'll accept
from commands.

```ruby
  c.before :suite do
    puppet_module_install(:source => proj_root, :module_name => 'ssh')
    hosts.each do |host|

      shell("/bin/touch #{default['puppetpath']}/hiera.yaml")
      shell('puppet module install puppetlabs-stdlib', { :acceptable_exit_codes => [0,1] })
    end
  end
end
```

With the basic helper and nodeset created we just need to make a few tests. We'll
put these in a file called spec/acceptance/class_spec.rb.  We include the file
we just created, spec_helper_acceptance, and then describe what we're testing.

First we create `pp`, a variable to hold our manifest.  We use ruby's EOS
functionality to make sure we don't have to backslash a bunch of stuff and
can just cut and paste in manifests from elsewhere.

```ruby
require 'spec_helper_acceptance'

describe 'ssh class:' do
  it 'should run successfully' do
    pp = <<-EOS
    class { 'ssh': }
    EOS
```

Now we do the actual test.  apply_manifest() takes a manifest and various
options about what the outcome should be.  On our first run we're looking to
"catch any failures" and then on our second run we're looking to "catch any
changes".  This allows us to be confident we're not changing the state of the
machine on multiple runs if everything is set correctly the first time.  We
have some other choices here, including :expect_failures and :expect_changes
for testing things we expect to fail, or change.

```ruby

    # Apply twice to ensure no errors the second time.
    apply_manifest(pp, :catch_failures => true)
    apply_manifest(pp, :catch_changes => true)
  end
```

Next we take advantage of our [ServerSpec](http://serverspec.org/) integration
in order to check the service is running.  ServerSpec understands a whole bunch
of distributions and allows you to describe packages or services in an OS
independent way.  It'll understand that RHEL needs service x status and that
Windows needs something totally different.  It has a number of resources
documented on the website, we'll just use service now.

This is just an example to show you what serverspec has built in, for most
tests we just stick to 'be_running' and 'be_enabled'.

```ruby

  describe service('sshd') do
    it { should be_enabled.with_level(3) }
    it { should be_running }
    it { should be_monitored_by('monit') }
  end

```

Alternatively if we need to test something more complex we can rely on shell()
commands.  We run a monitoring script installed by the module, assert that it
must return a 0 exit code, and then give a regular expression to parse the
stdout of the script for to make sure we're happy with the state of things.

```ruby

  describe 'some command' do
    it 'runs a monitoring script' do
      shell("/usr/local/bin/monitoring_ssh_script.sh", :acceptable_exit_codes => [0]) do |r|
        expect(r.stdout).to match(/SSH is alive and has \d+ users connected/)
      end
    end
  end
end
```

Then putting all this together we just need to run a single command, if things
worked, to see the output of all these tests.

```
$ rspec spec/acceptance/
Hypervisor for centos-64-x64 is vagrant
Beaker::Hypervisor, found some vagrant boxes to create
created Vagrantfile for VagrantHost centos-64-x64
[bunch of deleted stuff about bringing up a virtual machine and setup commands]
Finished in 3 minutes 15.2 seconds
4 examples, 0 failures
```

I hope this has helped explain a little bit of our acceptance testing framework
and made you realize it's pretty easy to integrate into your workflow.  Here
at Puppetlabs we mostly test with Vagrant/Virtualbox on our laptops as we
develop and then use Vsphere to test via Jenkins before we're ready to merge
a PR or release the updated module.  For real life examples of Beaker you can
look at many of the puppetlabs modules, such as apache, mysql, postgresql,
firewall, for examples of real world testing.
