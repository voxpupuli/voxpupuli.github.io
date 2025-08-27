---
layout: post
title: Installing Puppet Webhook using system repositories
date: 2020-03-29
github_username: dhollinger
twitter_username: moduletux
---

After an extremely long wait and lots of work from the Vox Pupuli PMC, we are happy to announce that we *finally* have APT and YUM repositories for Puppet Webhook 2.x, as well as, downloadable standalone RPM and DEB packages as well.

For the curious out there, we are using JFrog's [Bintray](https://bintray.com/) and its offering for Open Source projects to host the repositories and all packages ARE signed with a GPG key that our amazing community member, [Tim Meusel](https://github.com/bastelfreak) kindly setup for us.

Now that the announcement is out of the way, let's get into the meat of the blog post: How to setup your new APT/YUM repo. But first, a few quick caveats:

- Currently the repos only support a subset of distros:
  - Enterprise Linux 7 and 8 (YUM)
  - Debian 9 and 10 (APT)
  - Ubuntu 16.04 and 18.04 (APT)
  - Support coming soon for Ubuntu 20.04
- The repos must be setup manually. In the future, packages will come with their corresponding repository configuration built in and add them for you.
- The YUM repository for EL7 requires EPEL to be enabled in order to get the redis dependency. EL8 has a Redis channel by default.

## Setting up the repository

### Ubuntu/Debian

Add the GPG public key:

```shell
wget -q -O - "https://bintray.com/user/downloadSubjectPublicKey?username=voxpupuli" | sudo apt-key add -
```

Add the APT repository and install

```shell
echo "deb https://dl.bintray.com/voxpupuli/deb $(awk -F= '/VERSION_CODENAME=/ {print $2}' /etc/os-release) main" | sudo tee -a /etc/apt/sources.list.d/voxpupuli.list
sudo apt update
sudo apt install puppet-webhook
```

### RedHat/CentOS/Oracle

Add the EPEL repository (RedHat/CentOS/Oracle 7 only):

```shell
sudo yum install epel-release
```

Add the repository and install:

```shell
wget https://raw.githubusercontent.com/voxpupuli/puppet_webhook/master/build/repos/voxpupuli.repo -o voxpupuli.repo
sudo mv voxpupuli.repo /etc/yum.repos.d/voxpupuli.repo
sudo yum install puppet-webhook
```

### Grabbing the package directly

You can also download the packages themselves directly from the Puppet Webhook [Releases](https://github.com/voxpupuli/puppet_webhook/releases) page. Though note that for EL7 you still have to have the EPEL repository enabled and you won't receive updates through the package manager.

### Starting the application for the first time

The packages come with a SystemD service and you can simply start by running `sudo systemctl start puppet-webhook`. The application should work out of the box with no configuration, but if you want more strict authentication or any other environment-specific configuration, check out the documentation in the [README](https://github.com/voxpupuli/puppet_webhook/blob/master/README.md) file.

## Conclusion

That's it. Pretty simple setup. Now nothing is perfect and so we're looking for any feedback we can get! If you find an issue or something missing, please file an [Issue](https://github.com/voxpupuli/puppet_webhook/issues) on the Github project.
