---
layout: page
title: Documentation
---

This section is far from finished but contains some basic information on getting
started. If you have any questions, reach out to us in #voxpupuli on Freenode.

<ul class="docs-index">
{% for doc in site.docs %}
  <li>
    <h3><a href="{{ doc.url }}">{{ doc.title }}</a></h3>
    <p>{{ doc.summary }}</p>
  </li>
{% endfor %}
</ul>
