---
layout: post
title: OpenVox 9 - Request for Comments
date: 2026-04-14
github_username: silug
---

At CfgMgmtCamp this year, we spent time defining what OpenVox 9 needs to deliver. Two priorities stood out: updating core dependencies, including Ruby 4.0, and using this major release to deal with long-standing deprecations.

We're already making solid progress: [openvox](https://github.com/OpenVoxProject/openvox/) now works with Ruby 4.0, and work is underway to update the rest of our dependencies as far as possible.

The second part of this release is just as important: deciding what to do with long-deprecated code. OpenVox 9 is the right point to remove some of it, but only if that aligns with how people are actually using OpenVox today.

That is where we need your feedback.

Please review the [Deprecations](https://github.com/OpenVoxProject/planning/wiki/OpenVox-9-Release-Planning#deprecations) section of the OpenVox 9 Release Planning wiki and comment on the linked issues for anything that affects you. In particular, we want to hear:

* which deprecated features you still rely on
* what would break if they were removed in OpenVox 9
* whether removal should wait for OpenVox 10 instead
* whether a deprecation should be dropped entirely

If you want more context, feel free to review the associated PRs as well. Some of those PRs may be closed or deferred until a later release depending on the outcome of this discussion.

We will keep the comment period open until 2026-04-21. After that, we will use the feedback to finalize the deprecation scope for OpenVox 9.
