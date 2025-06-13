---
layout: post
title: Creating a new container repository
date: 2025-06-13
summary: How to create a new container repository
---

## Github repository

Create a new Container repository in the Vox Pupuli or OpenVox Github organization.
The repository name should be prefixed with `container-` to indicate that it is a container repository.
For example, if you are creating a container for `nginx`, the repository name should be `container-nginx`.

An admin will need to add the secrets `DOCKERHUB_BOT_ADMIN_TOKEN` and `DOCKERHUB_BOT_PUBLIC_RO_TOKEN` to the repository.
These secrets are used to authenticate with Docker Hub when pushing to this registry.
This is done in the `voxpupuli` organization.
Only selected repositories will have these secrets.

## ModuleSync configuration

The new repository should be added to the [container modulesync_config repository](https://github.com/voxpupuli/container_modulesync_configs).

## Docker Hub repository

This can only be done by a Vox Pupuli admin.
Create a new repository in Docker Hub with only the short name, e.g. `nginx`.
The repository name should match the name of the Github repository without the `container-` prefix.
After creating the repository you will need to add the permissions for `voxpupulitasks` as Admin and `betadots` as Read-Write.
Also enable "Docker Scout image analysis" in the repository settings.
