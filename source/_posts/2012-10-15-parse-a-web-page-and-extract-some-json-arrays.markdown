---
layout: post
title: "Parse a web page and extract some json arrays"
date: 2012-05-23 10:29
comments: true
categories: [ruby]
tags: [array,json]
---
## Parse a web page and extract some json arrays
So I have some basic code below, which fetches the json from <a href="http://www.highcharts.com/demo/" rel="nofollow">http://www.highcharts.com/demo/</a>. But I want to be able to extract a hash, more specifically this:
<pre><code>series: [{
                    name: 'Tokyo',
                    data: [7.0, 6.9, 9.5, 14.5, 18.2, 21.5, 25.2, 26.5, 23.3, 18.3, 13.9, 9.6]
                }, {
                    name: 'New York',
                    data: [-0.2, 0.8, 5.7, 11.3, 17.0, 22.0, 24.8, 24.1, 20.1, 14.1, 8.6, 2.5]
                }, {
                    name: 'Berlin',
                    data: [-0.9, 0.6, 3.5, 8.4, 13.5, 17.0, 18.6, 17.9, 14.3, 9.0, 3.9, 1.0]
                }, {
                    name: 'London',
                    data: [3.9, 4.2, 5.7, 8.5, 11.9, 15.2, 17.0, 16.6, 14.2, 10.3, 6.6, 4.8]
                }]
            });</code></pre>
&nbsp;

Into to a hash so that I can access the different data points. Currently the script just spits out everything. Code below:
<pre><code>require "json"
require "open-uri"


$LOAD_PATH &lt;&lt; File.dirname(__FILE__)

result = JSON.parse(open("http://www.highcharts.com/demo/").read)</code></pre>
&nbsp;

There is no direct conversion since source is JavaScript code (not even valid JSON). There are many ways to accomplish this task (one ways more strict than others, generic escaping control may be tricky), but that's how I'd do it: HTML -&gt; JS -&gt; JSON -&gt; Ruby array.
<pre><code>require 'open-uri'
require 'json'

html = open("http://www.highcharts.com/demo/").read
js = html.match(/series: (\[\{.*?\}\])/m)[1]
json = js.gsub(/(\w+):/i, '"\1":').gsub(/'/, '"')
series = JSON.parse(json)
# =&gt; [{"name"=&gt;"Tokyo", "data"=&gt;[7.0, 6.9, 9.5, 14.5, 18.2, ... </code></pre>
&nbsp;
