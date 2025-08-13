---
layout: post
title: Extending Expired CA Certificate
date: 2025-08-06
summary: How to extend the expiration date of the Puppet CA certificate
---

## Using an OpenBolt module

If you're using OpenBolt in your environment, there's a [ca_extend](https://github.com/puppetlabs/ca_extend) module designed for this task. Follow the module’s documentation to perform the extension in a supported and automated way.

## Manual process

The [ca_extend repository](https://github.com/puppetlabs/ca_extend) also includes a standalone [extend.sh](https://github.com/puppetlabs/ca_extend/blob/main/files/extend.sh) script that can be run manually to generate a new CA certificate with an extended expiration date.

The script performs the following steps:

1. Sets up a temporary SSL environment.
2. Generates a new CA certificate with the expiration set 15 years into the future.
3. Writes the new certificate to the directory returned by:
  ```
  puppet config print --section master cacert
  ```

The new file will be named using the format: `ca_crt-expires-<NEW_END_DATE>.pem`. This allows you to distinguish it from the currently active certificate without overwriting anything by default.

## Steps after running the script

1. Examine the end date of the new certificate by executing:
```
openssl x509 -in <PATH_TO_NEW_KEY> -noout -subject -issuer -enddate
```
Confirm the issuer matches your existing CA and that the expiration date is 15 years in the future.
2. Back up the current certificate and install the new one:
```
# Assuming the directory where the CA is stored is /etc/puppetlabs/puppet/ssl/ca
mv /etc/puppetlabs/puppet/ssl/ca/ca_crt.pem /etc/puppetlabs/puppet/ssl/ca/ca_crt.pem.bak.$(date +%F)
mv <PATH_TO_NEW_KEY> /etc/puppetlabs/puppet/ssl/ca/ca_crt.pem
```
3. Restart the OpenVox server.
```
systemctl restart puppetserver
```

# OpenVox agents

The following assumes the CA certificate is stored in the default location:
`/etc/puppetlabs/puppet/ssl/certs/ca.pem`.

## If the CA cert has expired

The new certificate can be downloaded via the HTTP API using the following
command:

```
curl https://<PUPPET-CA-HOST>:8140/puppet-ca/v1/certificate/ca --insecure > /etc/puppetlabs/puppet/ssl/certs/ca.pem
```

A command similar to the above would need to be orchestrated across all of your agents.

## OpenVox agents on version 8 and newer
Agents running Puppet 8+ will automatically fetch the updated CA certificate according to the [ca_refresh_interval](https://github.com/OpenVoxProject/openvox/blob/main/references/configuration.md#ca_refresh_interval) setting.

## Older agents

For older agents:

* Distribute the new CA certificate using your configuration management/orchestration tool (e.g., SaltStack, Ansible).
* Alternatively, use an OpenVox file resource to deploy the new certificate — this only works if the current CA certificate has not yet expired and agents can still check in.
