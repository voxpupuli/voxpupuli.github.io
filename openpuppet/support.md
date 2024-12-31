---
layout: page
title: OpenPuppet Support Options
subsection: openpuppet
---

<img class="float-end w-33 mx-5 img-thumbnail shadow-lg" src="/static/images/openpuppet/dog.jpg" />

Vox Pupuli is an open source community group and offers no commercial support.
You are invited to connect with us using the options at the top of the page. In
the spirit of the open source ethos, you will find peer support from others in
the ecosystem and we hope you stick around to help others solve their problems
afterwards too.

Nevertheless, we understand that for many, a commercial support
contract is required in order to use OpenPuppet. The companies below have
indicated that they offer OpenPuppet support tiers.

<div class="row">
  {% for sponsor in site.support %}
    {% include sponsor-card.html width=6 vendor=sponsor %}
  {% endfor %}
</div>
