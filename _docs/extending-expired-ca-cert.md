---
layout: post
title: Extending Expired CA Certificate
date: 2025-08-06
summary: How to extend the expiration date of the Puppet CA certificate
---

## Using a Bolt Module

If you're using Bolt in your environment, there's a
[ca_extend](https://github.com/puppetlabs/ca_extend) module designed for this
task. Follow the module’s documentation to perform the extension in a supported
and automated way.

## Manual Process

The [ca_extend repository](https://github.com/puppetlabs/ca_extend) also includes a standalone [extend.sh](https://github.com/puppetlabs/ca_extend/blob/main/files/extend.sh) script that can be run manually to generate a new CA certificate with an extended expiration date.

The script performs the following steps:

1. Sets up a temporary SSL environment.
2. Generates a new CA certificate with the expiration set 15 years into the future.
3. Writes the new certificate to the directory returned by:
  ```
  puppet config print --section master cacert
  ```

The new file will be named using the format: `ca_crt-expires-<NEW_END_DATE>.pem`. This allows you to distinguish it from the currently active certificate without overwriting anything by default.

## Steps After Running the Script

1. Examine the end date of the new certificate by executing:

```
openssl x509 -in <PATH_TO_NEW_KEY> -noout -text
```

Confirm the issuer matches your existing CA and that the expiration date is 15 years in the future.

2. Back up the current certificate and install the new one:

```
# Assuming the directory where the CA is stored is /etc/puppetlabs/puppet/ssl/ca
mv /etc/puppetlabs/puppet/ssl/ca/ca_crt.pem /etc/puppetlabs/puppet/ssl/ca/ca_crt.pem.bak.$(date +%F)
mv <PATH_TO_NEW_KEY> /etc/puppetlabs/puppet/ssl/ca/ca_crt.pem
```
3. Restart the puppet server.
```
systemctl restart puppetserver
```

# Puppet agents

## Agents on Puppet 8 or newer
Agents running Puppet 8+ will automatically fetch the updated CA certificate according to the [ca_refresh_interval](https://help.puppet.com/core/current/Content/PuppetCore/Markdown/configuration.htm#ca_refresh_interval) setting.

## Older Agents

For older agents:

* Distribute the new CA certificate using your configuration management/orchestration tool (e.g., SaltStack, Ansible).
* Alternatively, use a Puppet file resource to deploy the new certificate — this only works if the current CA certificate has not yet expired and agents can still check in.
