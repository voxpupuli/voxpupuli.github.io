---
layout: page
title: OpenVox Support Options
subsection: openvox
---

<img class="float-end w-33 mx-5 img-thumbnail shadow-lg" src="/static/images/openvox/dog.jpg" />

Vox Pupuli is an open source community group and offers no commercial support.
You are invited to connect with us using the options at the top of the page.
In the spirit of the open source ethos, you will find peer support from others in the ecosystem and we hope you stick around to help others solve their problems afterwards too.

If your business needs include enhanced commercial support, then connect with the friendly companies below who offer plans that might fit your needs.

<div class="row support-premier">
  {% for sponsor in site.support %}
    {%- if sponsor.tier == "premier" -%}
      {% include sponsor-card.html width=6 vendor=sponsor %}
    {%- endif -%}
  {% endfor %}
</div>
<div class="row support-standard">
  {% for sponsor in site.support %}
    {%- if sponsor.tier != "premier" -%}
      {% include sponsor-card.html width=3 vendor=sponsor %}
    {%- endif -%}
  {% endfor %}
</div>

<i>Photo by <a href="https://unsplash.com/photos/grayscale-photo-of-person-and-dog-holding-hands-cbIKeuURaq8">Fabian Gieske</a></i>.
