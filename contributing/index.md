---
layout: page
title: How to Contribute
---

## Getting involved

Contributions are very welcome! We have hundreds of modules to care about, so any help is appreciated.
If you want to contribute, you can start by looking at the [list of issues](https://github.com/issues?q=is%3Aopen+is%3Aissue+user%3Avoxpupuli+archived%3Afalse+sort%3Acreated-desc) and see if there is something you can help with.

We have a [mailinglist](https://groups.io/g/voxpupuli/), an [IRC channel](ircs://irc.libera.chat:6697/voxpupuli) and a [slack channel](https://puppetcommunity.slack.com/messages/voxpupuli/) where you can ask questions and get in touch with us.
If you have any questions, don't hesitate to ask. We are happy to help you.

## Monthly sync

We have a monthly sync meeting where we discuss the state of the project and what we want to do in the future. You can find the [meeting board](https://github.com/orgs/voxpupuli/projects/10/) here. The [zoom link](https://perforce.zoom.us/j/92119937381?pwd=IK00nUw1GrmR9KNjtkbMSbQAzpboPu.1) is always the same, so you can join us every month. We meet every second tuesday of the month at 16:30 [CET](https://www.timeanddate.com/time/zones/cet)/[CEST](https://www.timeanddate.com/time/zones/cest). You can [import this event in your calendar](voxpupuli-monthly-sync.ics).

<p id="nextmeeting"></p>

## Guidelines

- Please follow the [Puppet Community Style Guide](https://puppet.com/docs/puppet/latest/style_guide.html) for your contributions.
- And also keep our [Code of Conduct](https://voxpupuli.org/coc/) in mind.
- If you have question about security, please follow our [security policy](https://voxpupuli.org/security/).
- General and more specific documentation can be found on our [docs](https://voxpupuli.org/docs/).
- In the project you want to work on, check their own contribution guidelines most often found in the README.md or CONTRIBUTING.md file.

<script src="https://momentjs.com/downloads/moment.min.js"></script>
<script src="https://momentjs.com/downloads/moment-timezone-with-data-10-year-range.js"></script>
<script type="application/javascript">
const myTimeZone = moment.tz.guess();
const eventTimeZone = "Europe/Berlin";

let nextMeeting = moment.tz(eventTimeZone).startOf('month').add(1, 'week').hours(16).minutes(30);
dayOffset = 2 - nextMeeting.day();
if (dayOffset < 0) dayOffset += 7;
nextMeeting.add(dayOffset, 'days');

if (nextMeeting.isBefore(moment.tz(eventTimeZone).subtract(1, 'hour'))) {
  nextMeeting = moment.tz(eventTimeZone).startOf('month').add(1, 'month').add(1, 'week').hours(16).minutes(30);
  dayOffset = 2 - nextMeeting.day();
  if (dayOffset < 0) dayOffset += 7;
  nextMeeting.add(dayOffset, 'days');
}

document.getElementById('nextmeeting').innerHTML += "Next monthly sync: " + nextMeeting.tz(myTimeZone).calendar() + " (" +
 nextMeeting.tz(myTimeZone).format() + ")";
</script>
