## IRC

[#voxpupuli](ircs://irc.libera.chat:6697/voxpupuli) on [Libera.Chat](https://libera.chat/) ([webchat](https://web.libera.chat/?#voxpupuli)) (Bridged to `#voxpupuli` on Puppet Community Slack)

The following IRC / Slack channels are bridged:

{: .table .table-striped .table-hover .w-50}

| Slack              | IRC                           |
| ------------------ | ----------------------------- |
| openvox            | `#voxpupuli-openvox`            |
| puppet             | `#voxpupuli-puppet`             |
| sig-container      | `#voxpupuli-sig-container`      |
| sig-devkit         | `#voxpupuli-sig-devkit`         |
| sig-documentation  | `#voxpupuli-sig-documentation`  |
| sig-facter         | `#voxpupuli-sig-facter`         |
| sig-infrastructure | `#voxpupuli-sig-infrastructure` |
| sig-openbolt       | `#voxpupuli-sig-openbolt`       |
| sig-openvox-builds | `#voxpupuli-sig-openvox-builds` |
| sig-release        | `#voxpupuli-sig-release`        |
| sig-security       | `#voxpupuli-sig-security`       |
| sig-social-media   | `#voxpupuli-sig-social-media`   |
| voxconf2025        | `#voxpupuli-voxconf2025`        |
| voxpupuli          | `#voxpupuli`                    |

The voxpupuli channel is a bit special.
It's synced in a three way between IRC, old Slack and new Slack.
Please ping in the sig-infrastructure room when you create new rooms and require a new bridge.

The bridge/IRC doesn't support threads.
IRC will display all messages, sorted by date.
Please avoid threads in the slack channels.

### Admin notes

List people with admin permissions for `#voxpupuli*`

```
/msg chanserv flags #voxpupuli
```

Register a channel

```
/msg chanserv register #voxpupuli-sig-social-media
```

Mark the channel discoverable

```
/mode #voxpupuli-sig-social-media -s
```
