## Monthly Vox/Perforce Sync

We have a monthly sync meeting where we discuss the state of the project and what we want to do in the future. You can find the [meeting board](https://github.com/orgs/voxpupuli/projects/10/) here. The [zoom link](https://perforce.zoom.us/j/92119937381?pwd=IK00nUw1GrmR9KNjtkbMSbQAzpboPu.1) is always the same, so you can join us every month. We meet every second Tuesday of the month at 16:30 [CET](https://www.timeanddate.com/time/zones/cet)/[CEST](https://www.timeanddate.com/time/zones/cest). You can [import this event in your calendar](voxpupuli-monthly-sync.ics).

<p id="nextmeeting"></p>

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

