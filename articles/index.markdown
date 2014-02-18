---
title: Articles
layout: main
---

# Articles
Here's some of the articles and posts I've written, organised by date published.

<ul>
{% for post in site.posts %}
	<li>
		<a href="{{ post.url }}">{{ post.title }}</a>
		<div class="excerpt">{{ post.excerpt }}</div>
	</li>
{% endfor %}
</ul>