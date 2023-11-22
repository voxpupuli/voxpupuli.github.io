---
layout: page
title: Plugins
---

This is a community curated list of plugins and tools for Puppet.

Tools and plugins are defined in the `_data/tools` directory of the [community
website repository](https://github.com/voxpupuli/voxpupuli.github.io)
Tools without plugins are going to be listed in the table under the `Tools`
header. Tools with plugins will have their own header and table listing the
plugins defined for that tool.

<div class="card">
  <div class="card-header panel-heading bg-primary text-white">Table of Contents</div>
  <div class="panel-body">
    <ul class="list-group">
    <li class="list-group-item"><a href="#tools">Tools</a></li>
{% for tool in site.data.tools %}
  {% assign link = tool[1].display_name | split: ' ' | join: '-' %}
  {% if tool[1].plugins %}<li class="list-group-item"><a href="#{{link | downcase}}">{{tool[1].display_name}} Plugins</a></li>{%endif%}
{% endfor %}
  </ul>
  </div>
</div>

## Tools
Useful tools when writing Puppet.

<table class="table">
  <thead>
  <tr>
    <th>Tool Link</th>
    <th>Description</th>
  </tr>
  </thead>
  <tbody>
  {% for tool in site.data.tools %}
  {% if tool[1].url %}
  <tr>
    {% if tool[1].display_name %}
    {% assign display_name = tool[1].display_name %}
    {% else %}
    {% assign display_name = tool[1].name %}
    {% endif %}
    <td><a href="{{tool[1].url}}">{{ display_name }}</a></td>
    <td>{{tool[1].description}}</td>
  </tr>
  {% endif %}
  {% endfor %}
  </tbody>
</table>

{% for tool in site.data.tools %}
{% if tool[1].plugins %}
## {{ tool[1].display_name }}
{% if tool[1].description %}{{tool[1].description}}{%endif%}
<table class="table">
  <thead>
  <tr>
    {% if tool[1].display_name == "Hiera" %}
    <th>Plugin Link v. 3</th>
    <th>Plugin Link v. 5</th>
    {% else %}
    <th>Plugin Link</th>
    {% endif%}
    <th>Description</th>
  </tr>
  </thead>
  <tbody>
  {% assign sorted_plugins = tool[1].plugins | sort: 'name' %}
  {% for plugin in sorted_plugins %}
  <tr>
    <td><a href="{{plugin.url}}">{{plugin.name}}</a></td>
    {% if tool[1].display_name == "Hiera" %}<td><a href="{{plugin.url_v5}}">{{plugin.name_v5}}</a></td>{% endif %}
    <td>{{plugin.description}}</td>
  </tr>
  {% endfor %}
  </tbody>
</table>
{% endif %}
{% endfor %}
