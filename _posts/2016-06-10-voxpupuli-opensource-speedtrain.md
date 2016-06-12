---
layout: post
title: Voxpupuli - Opensource Speedtrain
github_username: igalic
twitter_username: hirojin
date: 2016-06-10
---

This is the transcript of a talk I gave at PuppetCamp Paris & London 2016.
You can find the [slides can be found on my blag](https://blag.esotericsystems.at/igor/presents/voxpupuli-opensource-speedtrain/)

Voxpupuli
=========

![8bit vox]({{ site.url }}{{ site.baseurl }}/static/images/8bit-vox.png)

**Opensource 🚅 Speedtrain**

whoami
======

Hello, my name is…  
Igor Galić — Co-Founder of Voxpupuli, and of my own company, Brainsware

igalic — profesionally, my motto can be summed up as "Infrastructure & Open Source"

@hirojin - on social media, it is generally, "Disappointing Expectations"

<blockquote class="twitter-tweet" data-lang="en"><p lang="en" dir="ltr">genders are like shoes. if they don&#39;t fit well, it looks a bit weird, and feels uncomfortable.<br><br>(and that&#39;s why i like to walk barefoot)</p>&mdash; The Wrath of me™ (@hirojin) <a href="https://twitter.com/hirojin/status/646652627581829120">September 23, 2015</a></blockquote>
<script async src="//platform.twitter.com/widgets.js" charset="utf-8"></script>

daenney and I started this project. He also started the fine tradition at  
puppetConf, to mention, or rather, proudly proclaim, that he is gay.

I am convinced that *diversity cannot exist without visibility*.

I am a very visible member of this community, so I want to be clear:

I am 🌈queer🌈

What is Voxpupuli
=================

> We are a collective of Puppet module, tooling and documentation authors all working together to ensure continued development on the code we maintain.

Some of my favourite words are in this sentence:

We are a **collective** of Puppet **module**, tooling and **documentation** authors all **working together** to *ensure* **continued development** on the *code* we **maintain**.

And while our website blurbs explain quite well who we are, what we do, why we do it, and how we do it — We aren't well known enough! This talk aims to change that.

Let's get started with

Who is Voxpupuli?
=================

<img alt="gray fox kits" src="{{ site.url }}{{ site.baseurl }}/static/images/gray-fox-kits-956687_1280.jpg" width="25%" height="25%" />

64… wait 65… no actually 66 volunteers

-   admins
-   many non-coders
-   git newbies

Currently, Voxpupuli is made of ~64~ ~65~ 66 people who alltogether have  
access to 130~ repositories. Most of those represent either puppet modules (100~) or puppet-lint checks, or some other kind of gem.

Except for those among us who are Puppet employees, none of our contributors are paid to do this work. And even the Puppet employees aren't paid to do *this* work! We are volunteers, most of us are admins, many of us not coders, a lot of us don't know how git works…

Why is Voxpupuli?
=================

-   impulsiveness

Daenney and me founded, then Puppet-Community, out of impulsiveness. We were frustrated with the pace at which things were moving, and we figured that we needed a space where we can iterate faster than Puppet. Puppet is bound by contracts to their customers. We as admins, running primarily the open source version of puppet, on the other hand, are free to decide on our own when to move, upgrade or break something.

-   necessity

Maintaining puppet modules is hard. Constantly ensuring quality is a
never-ending race against bit-rot. The ruby ecosystem is evolving fast, and it's
hard to keep up with the tools and *best* practices. Running this race alone can
be exhausting, at best. But slipping up, falling ill, taking vacation, changing
jobs, losing interest - being human, makes it impossible to keep up *alone*.

As systems administrators we strive to eliminate any possible
single-point-of-failure. Often times forgetting that we ourselves can become
one. Sometimes in this very process.

A puppet module can be tiny. Yet, at times, it may require a lot of attention and time. Even if not, if you have more than one module, it adds up!

With 60~ other people around, you are not alone. I believe that in Voxpupuli we have succeeded in eliminating the single-point of failure of the *maintainer*.

<img alt="more fox pups" src="{{ site.url }}{{ site.baseurl }}/static/images/more-fox-pups.jpg" width="25%" height="25%" />

Daenney and I may have been the fire-starters, but Voxpupuli has transcended our  
hopes and expectations. It has become that proof that the sum is greater than its parts.

Voxpupuli is a collaborative space, and a safe-haven.

For people, and for their work.

How does Voxpupuli…?
====================

So how are we doing this? With people; obviously.  
With robots, too. And with tools, that enforce standards and conventions. Let's start with the robots…

Robots: vpci
============

<img alt="8bit vpci" src="{{ site.url }}{{ site.baseurl }}/static/images/8bit-vpci.jpg" width="50%" height="50%" />

Is a set of bash and python scripts that runs beaker tests for Voxpupuli, but
also for Puppet. Of those modules that have beaker acceptance tests, we can be
relatively certain that they will work out quite fine.

Robots: Travis
==============

![Travis]({{ site.url }}{{ site.baseurl }}/static/images/travis-mascot-600px.png)

-   rspec-puppet
-   STRICT\_VARIABLES
-   rubocop
-   release

Travis does *the rest*. Our `.travis.yml` is rather extensive. We have test
against all *current* ruby versions. We test puppet 3.x and 4.x. Always with
`STRICT_VARIABLES`. We run linters for our puppet code, and rspec-rubocop for
our spec tests and ruby code.

Sometimes rubocop can be a pain — mostly because it's a fast moving target.
However, enforcing a uniform style, and catching potentially dangerous code in a
highly dynamic language, with a highly flexible syntax, is absolutely
invaluable.

Finally, Travis also deploys our modules to the Puppetforge, and our Gems to the
Rubyforge. It does so, whenever someone creates a tag. And to make **this**
uniform too, we have the `voxpupuli/release` gem with rake tasks that check the
`CHANGELOG.md`, tag, bump the version, and push.

We tried really hard to make our release process as *easy* as possible, so that
anyone who wants, or needs a release of the current master, can request that
simply by creating a pull-request.

People: Contributor
===================

<img alt="mirror" src="{{ site.url }}{{ site.baseurl }}/static/images/frame-308791_1280.png" width="50%" height="50%" />

-   issues & pull requests
-   feedback on irc & slack

So if **you** need a fresh release of puppet-mcollective, **you** can do that. All
you have to do is create a pull-request. And hunt-down someone who'll merge it,
and run rake `travis_release`.

For this we have a broad set of channels: GitHub Pull Requests and Issues being
the most obvious here. And you can use those for other bug reports, or to
provide us with patches.

Structure and Communication
===========================

in Community Management

<img alt="plumbing" src="{{ site.url }}{{ site.baseurl }}/static/images/plumbing.jpg" width="50%" height="50%" />

The *plumbing* repository is where you can track or report structural issues
that need public discussion. Bugs in the community, or feature requests, if you
so will. We also have a Code of Conduct email list, for privately disclosing
issues.

All our channels, be that IRC & Slack, or Github, or Mailing Lists, adhere to
the the general Puppet code of conduct. We also explicitly have the Covenant
Code of Conduct in place in all of our repositories.

Every contribution, no matter how trivial or elaborate, or even *wrong* is
immensely valuable. Treating it, and the person it comes from with the respect
and hummility strenghtens our ties to the community, and can broaden it, too.

People: Members
===============

<img alt="Accept" src="{{ site.url }}{{ site.baseurl }}/static/images/Accept.png" width="200" height="200" />

-   push buttons

Many drive-thru contributors circle around, and finally stick around. Whenever I
notice that someone is doing my job, I invite them to the organisation. Clicking
on accept in that email is all they have to do. We don't require anyone to sign
a CLA (Contributor License Agreement), or anything like that. But, clicking that
button is a powerful motion. Suddenly, instead of having one pet project, a
person has merge access to *all* our repositories. This can be an exhilerating
feeling. It might not last long, mind you, but even so, it motivates them to
clean up a bunch of old issues & pull requests, or release a module that hasn't
been released in a while.

Again, the reason why it's so simple to get started with these things, rather
than to be overwhelmed with it are our standards and conventions.

-   We use module\_sync to handle boilerplate code across repositories
-   This ensures .rubocop.yml, .puppet-lint.rc, Rakefile & Gemfile, and .travis.yml to be same-ish
-   Every pull request is checked by Travis & vpci
-   Every pull request is reviewed and merged by someone who is *not* the author

<img alt="tyre fire" src="{{ site.url }}{{ site.baseurl }}/static/images/tyre-fire.jpg" width="25%" height="25%" />

If this sounds boring, all I can say is that boring code is *good*. We have far
too much excitement in our jobs.

<img alt="campfire" src="{{ site.url }}{{ site.baseurl }}/static/images/lagerfeuer.jpg" width="25%" height="25%" />

So having boring code code that helps us run our infrastructure give you  
that warm fuzzy feeling of reliability.

People: Community Gardeners
===========================

<img alt="community garden" src="{{ site.url }}{{ site.baseurl }}/static/images/community-garden.jpg" width="25%" height="25%" />

-   grant & revoke access
-   enforce coc
-   listen

I am, in GitHub speak, one of the Owners of the Voxpupuli organisation. In
GitHub terms this means I can grant (and revoke) access to our repositories.

In our own terms, it means that I

-   hold the keys to our secrets
-   get to be on the <coc@voxpupuli.org> list

It means that I have to listen — often for clues — to our community. I might
have to moderate behaviour, or (over)enthusiasm. If others have failed to do so,
I have to enforce our CoC. And finally, I have to recognize and empower
contributors, elavating them to members.

The Quantified Us
=================

Often, just listening is not enough. In the days of Big Data, we can gather
information about our community automatically, thanks to the magic of APIs! And
we can proccess this Big Data with Big Data tools, such as CSV.

Currently we use

-   underscoregan/community\_management
-   lbabhr/octohatrack
-   duckinator/how\_is

to gather the basic info on how our community is doing — and more importantly
*who* is doing things. It's very important to us to reward all members of our
community with the gift of merge access — especially the ones the ones who may
otherwise slip thru the cracks because all they do is report bugs / issues, and
review pull requests!

What does Voxpupuli…
====================

<img alt="8bit vox" src="{{ site.url }}{{ site.baseurl }}/static/images/8bit-vox.jpg" width="50%" height="50%" />

-   … do for my company?
-   … do for me?

We provide a broad set of well recongised modules. These modules are subject to
the highest quality standards — enforced by robots!

Our modules are released frequently (by robots!), and are compatible with the latest puppet versions.

If you have a popular module or gem, we can adopt it, *and you*.

Steal this process
==================

At the off chance that none of our modules strike your fancy, you might still be
interested in our tools, or our process.

All the tools we use are freely (gratis, libre) available. All the tools we produce are freely (gratis, libre) available.

If you are stuck in a silo, you may be able to aleviate your pains by adopting our tools to enforce standards, quality, and to make deployments easy.

If you are "stuck" in a flat hierarchy, you may be in the unique position of having responsibility, *and* power.

I advise your to take your responsibility for your team mates first, and to use your power wisely. If you adopt our management process, it will mean that on-boarding practially takes care of itself.

Be that new junior ops colleagues, or veteran developers, when you ***empower*** them you will earn their trust and their respect.

Thank you
=========

-   Catch me (us!) for questions! Come talk to us in `#voxpupuli`!
-   …join us!


Sources
=======

* https://pixabay.com/en/gray-fox-kits-young-babies-956687/
* https://www.flickr.com/photos/yellowstonenps/18654448490
* https://pixabay.com/en/frame-mirror-picture-baroque-empty-308791/
* https://www.flickr.com/photos/timmy/5910881115/
* https://commons.wikimedia.org/wiki/File:Accept.svg
* https://www.flickr.com/photos/widnr/6588149033
* https://www.flickr.com/photos/sejanc/866122048
* https://www.flickr.com/photos/pellesten/8286654017/
