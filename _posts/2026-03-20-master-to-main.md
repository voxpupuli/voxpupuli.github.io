---
layout: post
title: Group Project: Switching from `master` to `main`
date: 2026-03-20
github_username: rwaffen
---

Hi @everyone 👋, we have a large number of repositories, and we want to establish a clear and consistent standard for how we name our default branches across the organization.

This is not only about using inclusive language, but also about improving clarity, reducing confusion, and aligning with current defaults such as main on GitHub.

Since this change can involve a fair amount of work, we’d like to approach it collaboratively and involve everyone in the process.

If you touch any repository and got some extra time to spend, please switch the default branch to `main` and update your local clones accordingly.

<!-- TODO: Can everyone do this or do we need some special rights to do this? -->
If you are a repository maintainer you can switch the default branch in the repository settings on GitHub.
See the GitHub documaentation to this: <https://docs.github.com/en/repositories/configuring-branches-and-merges-in-your-repository/managing-branches-in-your-repository/renaming-a-branch>

The commands to update your local clone are as follows:

```shell
git branch -m master main
git fetch origin
git branch -u origin/main main
git remote set-head origin -a
```

Thx for your help! If you have any questions, feel free to ask.

Cheers,
@rwaffen
