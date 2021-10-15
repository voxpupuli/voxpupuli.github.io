---
layout: post
title: GitHub sponsors Vox Pupuli
date: 2021-10-15
github_username: bastelfreak
twitter_username: BastelsBlog
---

At Vox Pupuli we love CI! We heavily use GitHub Actions to run multiple
jobs on each new pull request. All our releases are done via GitHub Actions as
well. Given our growth, we run into some rate limits. GitHub supports unlimited
CI jobs for public repositories, but has a concurrent limit of 20. Some of our
modules start 24 jobs on a single pull request, so there is a bottle neck.

We're proud to announce that GitHub sponsors Vox Pupuli with a free
[Team Plan](https://github.com/pricing). This usually costs 4$ per GitHub org
member per month. Vox Pupuli currently has 164 members. We wouldn't be able to
pay this on our own. Besides the benefits from the link above there is another
awesome perk: More
[concurrent CI jobs](https://docs.github.com/en/actions/learn-github-actions/usage-limits-billing-and-administration#usage-limits).
We are now allowed to run 60 concurrent jobs across our organisation.

Thanks GitHub and especially [kara Sowles](https://twitter.com/FeyNudibranch)
for making this possible!

You would like to know how we use GitHub Actions? We have a blog post on
[how we test Rubygems](https://voxpupuli.org/blog/2021/06/18/the-new-ci-setup-for-rubygems/)
or checkout the Actions we
[use on our modules](https://github.com/voxpupuli/modulesync_config/tree/master/moduleroot/.github/workflows).
