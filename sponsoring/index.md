---
layout: page
title: Sponsoring
---

Hi! We are an open collective, developing modules and tooling for the Puppet ecosystem!

But Vox Pupuli isn't only code to develop and maintain, it's more than that.

Unfortunately a few things costs us money, like:
- Infrastructure for CI/CD
- Participate at conferences
- Merch like stickers! (everyone loves stickers!)
- Sometimes we need a little BBQ and gathering of our community, for the work we love so much!

There are ways to sponsor us:
- [Vox Pupuli on open collective](https://opencollective.com/vox-pupuli)
- [Vox Pupuli on GitHub](https://github.com/sponsors/voxpupuli)

Or with stuff like:
- Sponsor our CI resources at Hetzner
- Sponsor Swag for conferences
- Sponsor Domain costs at Inwx

If you're interested in these options, please get in touch and email the Project Management Committee at pmc@voxpupuli.org.

At the moment we've multiple sponsors via GitHub. In addition to that, multiple
companies sponsor our cloud/CI resources.

<div class="row">
  {% for sponsor in site.sponsors %}
    <div class="col-md-4">
      <div class="card">
        <div class="card-image">
          <img src="{{ site.url }}{{ site.baseurl }}/static/images/{{sponsor.logo}}" alt="Sponsored by {{sponsor.name}}">
        </div>
        <div class="card-body">
          <h5 class="card-title">Sponsored by {{sponsor.name}}</h5>
          <p class="card-text">{{sponsor.content | markdownify }}</p>
          <a href="{{sponsor.url}}" class="btn btn-primary">{{sponsor.button}}</a>
        </div>
      </div>
    </div>
  {% endfor %}
</div>
