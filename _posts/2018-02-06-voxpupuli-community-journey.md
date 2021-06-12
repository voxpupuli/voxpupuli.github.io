# Vox Pupuli - The Funny Community Journey

## Fourth Edition?

Hi folks, and welcome to Tim Meusel's talk on Vox Pupuli's journey as a community.

## $ whoami not


Unfortunately, Tim couldn't make it due to a work-trip. So it's a great honour to return to this stage, and this community, however briefly. Especially because I'm taking Tim's place, who's done so much for us here.

## $ whoami

You may already know me from such places as THE INTERNET.
I've been involved with open source for quite some time now, about as long as I've been working in Ops, or more accurately, with Infrastructure.

I am also

## 🌈Q✨U✨E✨E✨R🌈

or, if you wanna be more specific, genderqueer, and bisexual, which I try to mention at every stage I am given, simply to represent.

<blockquote class="twitter-tweet" data-lang="en"><p lang="en" dir="ltr">genders are like shoes. if they don&#39;t fit well, it looks a bit weird, and feels uncomfortable.<br><br>(and that&#39;s why i like to walk barefoot)</p>&mdash; igor (@hirojin) <a href="https://twitter.com/hirojin/status/646652627581829120?ref_src=twsrc%5Etfw">September 23, 2015</a></blockquote>
<script async src="https://platform.twitter.com/widgets.js" charset="utf-8"></script>


but enough about me, let's talk about

## Vox Pupuli

It has come to my attention that there seems to be an issue with how Vox Pupuli is pronounced!
Let's start with the basics: Vox Pupuli is a play on the Latin phrase *"Vox Populus"* (the voice of the people) — where *pupuli* means puppets.
So it's the voice of little puppets!

Here are two audio samples, and their respective IPA:

my normal pronunciation.

a slight Italian/Spanish accent.

## What we do

To begin with, we are a Collaborative community of Puppet practitioners.
I've stolen this *declaration* from [sous-chefs](http://sous-chefs.org/), which is a Collaborative community of Chef practitioners.
So the good news is: We're not alone in what we do, and how we do that.
And what we do, is we maintain *a lot* of puppet modules.
Currently we have 89 modules published on the forge.
And about ~95 in our GitHub organisation, which are being polished up, so they too can be published.

The sheer amount of modules and repositories leads to some challenges, which we will discuss today.

One way to tackle that is to be available 24/7 on IRC (and slack) to help you.
It's our form of Chat-Ops!
It's very important to be present, and responsive.
But we also try very hard to be polite, while being helpful!

By opening our minds to new technologies, and our hearts to new people

ｗｅ   ｇａｉｎ  ｍｏｒｅ   ｆｏｌｌｏｗｅｒｓ

that is… we give people really easy access to our repositories.
This certainly encourages them to pick up our slack ;) but more on that later…

We also encourage users to contribute: If we cannot solve their problems, maybe we can help them fix it themself.

And, finally, we're always happy to play with new software (automation scripts, IRC bots...) or adopt new modules.
Our latest being `rtyler-jenkins`!

And as rtyler can most certainly confirm, maintaining a module on your own can be an overwhelming experience.
But it's also a crushing experience for someone to find your module, and notice afterwards that it's unmaintained.

There's a broader issue: For each maintainer, we have ~10 (prospective) contributors.
People who will contribute a code or docs fix, or open issues, or help out with code-review.
And then we have around ~100 users, who are passive and silent.

They might find the barrier to opening an issue harder to surpass, than forking a module internally, or finding a different one, or writing their own.
The reasons might be technical, organizational, or language issues.
But the reason doesn't matter.

We want to provide a home for orphaned modules, to prevent this kind of churn.
And we keep maintainers from burning out, by providing a whole collective of module developers.

Because developing alone sucks.
And there is such hard pressure on a single person, if your module is popular.
Sometimes you just want to go on vacation.
Or you switch jobs, and your new company is all about Ansible.
But you also might lose interest in development altogether, and finally start that alpaca farm you've been dreaming about.
Wherever life caries you, your module has *become infrastructure*, and we help *maintain* that *infrastructure*.

## Who?

We are currently 113 people with merge permissions:

* We were 107 in October 2017
* We were 80 in November 2016

Just five people work for Puppet Inc, most of our contributors participate in their free time.
Or rather, they're normal administrators that have to deal with puppet at work.

We have many contributors who are new to git and github.
Rebasing a feature branch against upstream master is difficult, if you've never done it.

Many have never written tests, and dealing with rspec/rubocop/beaker is hard as well.
We don't have to teach them writing good puppet code, but all the related tooling.

Many administrators of legacy infrastructures with (Puppet3, Ruby191, Ruby2.0), so we spend a lot of time why we should move on.
Please remember that Puppet2.7 was declared EOL in November 2016.
[Extended Support for 2014 ended in 2014](https://www.ruby-lang.org/en/news/2014/07/01/eol-for-1-8-7-and-1-9-2/)
Can we call Puppet4 legacy already? (bastelfreak: yes pls)

These days, common support cases are:

* There is a strange datatype in my code (puppet4/5 code executed with puppet3)
* Data-in-modules doesn't work

## Why

There are three key motivations to why Vox Pupuli was formed, and we've alluded already to most of them:

* Maintaining a module on your own is hard
* Proper testing of a module requires constant vigilance of the changes in the ruby ecosystem

<blockquote class="twitter-tweet" data-lang="en"><p lang="en" dir="ltr">idea: <a href="https://twitter.com/PrettierCode?ref_src=twsrc%5Etfw">@PrettierCode</a> for Ruby, with a style that people actually write</p>&mdash; igor @ #cfgmgmtcamp (@hirojin) <a href="https://twitter.com/hirojin/status/960152015149125632?ref_src=twsrc%5Etfw">February 4, 2018</a></blockquote>
<script async src="https://platform.twitter.com/widgets.js" charset="utf-8"></script>

But our "hidden" agenda is that we want to push the use of puppet into a modern direction (and mine is to get rid of rubocop)

## modulesync

As the amount of modules grew, we needed a way to manage this.
We decided that our best approach would be to adopt modulesync, which at that time was developed by Morgan Haskell of Puppet, but eventually moved to us, as she grew tired of it ;)

Keeping generic files like Gemfile/Rakefile in sync is pain, if done by hand, and modulesync saves us sooo much time.
It takes a config file + templates, throws it into every module's git repo
It Works with GitHub Pull Requests, so *in theory* everybody can start it, and every of our Collaborators can approve/merge it.

However, it's not very easy to use, and we're looking for ways to make it more comfortable… or a replacement for it.

## Travis

Travis is a free CI platform.
Puppet Inc. sponsors us unlimited(?) concurrent travis slots (Thanks to 💜David Schmitt💜), which we really need given all the `rpsec-puppet` tests we test on all common Puppet×Ruby versions.
These days Travis also runs beaker acceptance tests for us.

And, finally, it handles the release process of modules to the Forge:


## Release task

For our release process we use a gem called `voxpupuli-release`. It's essentially a wrapper around `puppet-blacksmith`, and provides rake task to bump + tag a module — after doing the appropriate sanity checks.

The push to the Forge is handled in a `deploy` task on Travis. 
So, in theory everybody can start it, each collaborator can approve it.
They do have to `tag && push --tags` however, so Travis can react to it.
What's still missing is to also create a github release.

So I hope you can see we try hard to encourage users to contribute by providing easy to use tools

## Tooling

Here's all (most? some??) of our auxiliary tooling summarized:

* https://github.com/underscorgan/community_management

  * Open Issues and PRs sorted in different ways

* https://voxpupuli-open-prs.herokuapp.com/

  * Also open PRs

* https://github.com/voxpupuli/thevoxfox

  * IRC bot, allows us to merge stuff + trigger modulesync (soon, maybe)

* https://github.com/bastelfreak/contributorstats

  * count contributions

## Docs

Let's talk docs!
Our own docs look a little bit lacking for love, but they do contain everything you need to know to get started, or transfer a module, and, as of recently a Review Guidline (I'll get back to this in a bit)

On the other hand, we have automatically (💜`puppet-strings`💜) generated html docs for a bunch of modules:

* https://voxpupuli.org/puppet-selinux

* https://voxpupuli.org/puppet-autofs

* https://voxpupuli.org/puppet-mumble

* https://voxpupuli.org/puppet-cassandra (in the making)

* https://voxpupuli.org/puppet-rabbitmq (in the making)

Which are automagically published under our domain.

## Governance: PMC

We elected a second Project Management Committee in 2017!
The PMC enforces CoC, and has lately tasked itself to bring bring Vox Pupuli into the Software Freedom Conservancy.

The current members are

  * Tim ‘bastelfreak’ Meusel (reelected)
  * David ‘dhollinger’ Hollinger
  * Hunter ‘Hunner’ Haugen (works for Puppet Inc., reelected)
  * Alex ‘afisher’ Fisher
  * Eric ‘eputnam’ Putnam (works for Puppet Inc.)

Our PMC guidelines are created by the community https://tinyurl.com/voxpupuli-governance-md
and given the latest election turnout, we might have to consider amending them…

## Collaborators

All our collaborators are able and encouraged to review pull requests, explain why we don't support ruby 1.8.7 anymore.
As of "recently", explain why we don't support Puppet 3 anymore.
We help people with git, and finally, we trigger the automated release process.

So let's look at some

## Daily Business

![Bugfix]({{ site.url }}{{ site.baseurl }}/static/images/bugfix.png)

People are often too scared to contribute.
They might think they can't write the code needed, but they can!
So encourage them!

![End Of Life discussion]({{ site.url }}{{ site.baseurl }}/static/images/eol.png)

TL;DR still people use outdated ruby/puppet versions from time to time :(

![Travis Restart]({{ site.url }}{{ site.baseurl }}/static/images/travisrestart.png)

Travis cheats: closing/reopen a PR will trigger another Travis run.
A project admin can do this in the travis UI, but outside-contributors can't.
close/reopen can be triggered by the PR author, however.

![Please add Spec Tests]({{ site.url }}{{ site.baseurl }}/static/images/spectests.png)


We try to get at least a unit test for all new features.

On a bugfix we're really happy when someone includes a test that fails without the patch, but works with it.

And always, always say thanks! Be friendly to contributors. We're always happy for a new Issue/PR (We prefer PRs;)

![Happy Maintainers]({{ site.url }}{{ site.baseurl }}/static/images/yey.png)

Everybody is good at blaming others, but we rarely tell people that they did something well.
bastelfreak is happy about all new Datatypes!

![Please look at the failing Spec Tests]({{ site.url }}{{ site.baseurl }}/static/images/fail.png)

People often don't notice that a Travis run has failed.
Do we need to change the visibility?

![Please use the correct email address for github contributions]({{ site.url }}{{ site.baseurl }}/static/images/email.png)

For a clean history we want people to use a correct email address.

![Please Update the README]({{ site.url }}{{ site.baseurl }}/static/images/readme.png)

Something that many people very often forget: Is the new feature documented in the README.md?

![Please migrate your module to us]({{ site.url }}{{ site.baseurl }}/static/images/migrate.png)

Often people ask us to migrate a dead module into our namespace.
All we can do is head out to the maintainer to ask for that, and hope for the best.

![Puppet Inc people receiving Candy]({{ site.url }}{{ site.baseurl }}/static/images/candy.jpg)

bastelfreak noticed in the Archlinux community that people are happy, if you send them sweets

We tried this in the Puppet community as well. Puppet Inc. received 15pounds of sweets for all their encouragement for the community.

You all keep contributing and bastelfreak will send you sweets as well!

![Igor with two Vox puppets on their fingers]({{ site.url }}{{ site.baseurl }}/static/images/igor-voxes.jpeg)

Now, my methods are slightly different: Instead of handy, I like to hand out these very cute puppets to anyone who wants one.
So long as you promise to send back cute selfies!

## Daily Business Automation

What if I told you that a lot of this daily business could be automated?


![Danger JS logo]({{ site.url }}{{ site.baseurl }}/static/images/danger-logo-hero@2x-73a8464a.png)

There are a lot of tools out there — and Danger is only one of them, that could help our contributors cut down on the "boilerplate" responses, and instead have a robot do that.

This would leave us humans with more time to take selfies and eat candy.

## Broken Stuff

* Vox Pupuli is the place to be if something is broken

  * puppetlabs-stdlib

  * puppetlabs-stdlib again

  * puppetlabs-apt

  * puppet-systemd (sorry)

Inexplicably, every time a popular module is broken, people will join the Vox Pupuli IRC channel to ask for help, fixes or workarounds.

This happend twice for stdlib (we didn't break it, we just noticed it)

bastelfreak once added a breaking change to the systemd module which killed the openstack CI pipelines (happened twice)

## Quotes

> 'Release early - release often' - Igor Galić

People are scared to make releases because it could break things.
Release as often as possible. Less changes per release → less broken releases.

> 'Version numbers are cheap - use them' - Igor Galić

People are often scared to merge breaking changes. Merging them is totally okay if you do proper versioning.
We don't delete broken releases and try to fix it, we just do a new release!

> 'DevOps is all about empathy' - Rob Nelson

Working closely together, listening to users, always be constructive, don't blame others for mistakes. we all break stuff from time to time.

## Summary

* We have great tooling and automation

* We have great people

* You need help with Puppet?

  * Let us know, we help out!

* You have an orphaned module or know one?

  * Ping us, migrate it to us

* You have domain specific knowledge?

  * Ruby, Python, Rspec, Beaker, $software we automate

* You want to help out?

  * We are always looking for new Collaborators and Maintainer

Contact:

* IRC #voxpupli on [Libera](https://web.libera.chat/?#voxpupuli)

* Slack: #voxpupuli on [slack.puppet.com](http://slack.puppet.com/)

* voxpupuli@groups.io

* pmc@voxpupuli.org

* tim@bastelfreak.de

### Thank you for your attention💜
