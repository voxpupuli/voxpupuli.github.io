---
layout: page
title: Documentation
---

This section is far from finished but contains some basic information on getting
started. If you have any questions, [reach out to us](/connect/).

<ul class="docs-index">
{% assign docs = site.docs | group_by: "layout" | first %}
{% for doc in docs.items %}
  <li>
    <h3><a href="{{ doc.url }}">{{ doc.title }}</a></h3>
    <p>{{ doc.summary }}</p>
  </li>
{% endfor %}
</ul>

<h2 id="architectures">Reference Architectures</h2>
<ul class="docs-index">
{% assign archs = site.docs | where: "layout", "architecture" %}
{% for arch in archs %}
  <li>
    <h3><a href="{{ arch.url }}">{{ arch.title }}</a></h3>
    <small><i>Version {{ arch.version }}</i></small>
    <p>{{ arch.summary }}</p>
  </li>
{% endfor %}
</ul>
