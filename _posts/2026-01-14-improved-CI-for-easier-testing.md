---
layout: post
title: Improved CI for easier testing!
date: 2026-01-14
github_username: bastelfreak
---

We now build rpm/deb packages for PRs!

Back in the old days, making changes to Puppet Agent/Server/DB was always complicated.
The software is complex, so the CI matrix is huge and has a good coverage.
While this is nice to ensure a stable software, it makes local testing a bit more challenging.

To make it more complicated, the old Perforce build system is mostly internal and there were no snapshot/beta packages available, so you couldn't even manually test your code changes.

Today, we are changing this for the OpenVoxProject.

Each PR in three repos will result in packages:

* [OpenVox-Server](https://github.com/OpenVoxProject/openvox-server)
* [OpenVoxDB](https://github.com/OpenVoxProject/openvoxdb)
* [ezbake](https://github.com/openvoxproject/ezbake)

(We plan to do this for the [agent](https://github.com/OpenVoxProject/openvox/) packages and [OpenBolt](https://github.com/OpenVoxProject/openbolt/) as well)

OpenVox-Server and OpenVoxDB are hopefully obvious.
ezbake is less known.
It's the build tooling, created by Perforce, for clojure applications.
ezbake glues all the clojure libs with OpenVox-Server or OpenVoxDB together into packages.
ezbake also contains different templates that end up in the packages, for example the systemd unit files.

PRs to ezbake trigger builds for the OpenVoxDB & OpenVox-Server main branches.

For each PR to those three repos, we build rpm and deb packages for all the supported platforms([OpenVox-Server](https://github.com/OpenVoxProject/openvox-server/blob/b2f1a0ce7d1c6f58d9fb60d37dc81e8dab0b6e16/tasks/build.rake#L16-L17), [OpenVoxDB](https://github.com/OpenVoxProject/openvoxdb/blob/1218f3c9514ae38dc349f40959d73bb6916332b3/tasks/build.rake#L15-L16)).
The packages will be uploaded, as zip archive, to GitHub artifacts.
Right now they will be stored for 24 hours.
Each new changes in a PR results in a new build, which will replace the previous archive from this PR.
We might increase the retention or also upload the packages into actual repositories, but that requires a bit more automation.

If an organisation member created the PR, we will post a comment with download links (due to weird GitHub permissions, this isn't possible for outside collaborators).
<br/>
<img alt="automated comment in a PR with zip download" src="{{ site.url }}{{ site.baseurl }}/static/images/pr-comment.png" width="75%" />

As an alternative, you can also go to the "Checks" tab in each PR

<br/>
<img alt="pr checks" src="{{ site.url }}{{ site.baseurl }}/static/images/pr-checks.png" width="75%" />

Afterwards select the correct test suite.
For OpenVoxServer and ezbake it is "PR Testing", for OpenVoxDB it is "main".

At the bottom is always a job summary and the download links.

<br/>
<img alt="job summary" src="{{ site.url }}{{ site.baseurl }}/static/images/job-summary.png" width="75%" />

Please let us know your thoughts about it! If you find any bugs or want to contribute, please come to our [#openvox](https://voxpupuli.org/connect/) channel on IRC or slack.
