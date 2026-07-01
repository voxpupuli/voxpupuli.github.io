---
layout: post
title: Creating a new container
date: 2025-06-13
summary: How to create a new container
---

This document describes how to create a new container in the Vox Pupuli or OpenVoxProject GitHub organization.

## The two ways to create a new container

There are two common ways to create a new container for a repository.

The first option is to add a `Containerfile` to an existing repository.
Then add a `.github/workflows/container.yml` or something similar to the repository to build and push the container to Docker Hub.
This is the easy way, as used for puppetboard, openvoxview, or jig.

The second option is to create a new repository in the Vox Pupuli or OpenVoxProject GitHub organization and add a `Containerfile` to it.
The repository name should be prefixed with `container-` to indicate that it is a container repository.
For example, if you are creating a container for `nginx`, the repository name should be `container-nginx`.
The container itself shouldn't include the `container-` prefix, so the container will be called `nginx` and not `container-nginx`.

### ModuleSync configuration

If you are creating a new container repository, you may want to add the necessary configuration from the [container modulesync_config repository](https://github.com/voxpupuli/container_modulesync_configs) to the repository.
Then you can benefit from the ModuleSync configuration for container repositories, including templates for workflows and other files,
and the ability to run ModuleSync on the repository to update it with the latest templates.

## Docker Hub

### Create a new repository in Docker Hub

If you want to push the container to Docker Hub, a Vox Pupuli admin needs to create a new Docker Hub repository
and add the necessary secrets to the GitHub repository.
On Docker Hub, we only have the `voxpupuli` organization, so the new repository should be created there.
We cannot create new organizations on Docker Hub because this is a paid feature and we do not have a paid account.
The Docker Hub repository name should match the name of the GitHub repository without the `container-` prefix.
After creating the repository, grant `voxpupulitasks` Admin permissions.
Also enable "Docker Scout image analysis" in the repository settings.

An admin also needs to add the secrets `DOCKERHUB_BOT_ADMIN_TOKEN` and `DOCKERHUB_BOT_PUBLIC_RO_TOKEN` to the GitHub repository.
These secrets are used to authenticate with Docker Hub when pushing to this registry.
These GitHub secrets are managed in the `voxpupuli` GitHub organization.
Only selected repositories receive them.
