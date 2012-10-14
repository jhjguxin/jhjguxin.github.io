---
layout: post
title: "Rails date_select fields hidden and "
date: 2012-07-27 17:08
comments: true
categories: ["rails", "ruby"]
tags: ["date_select", "rails", "ruby"]
---
## Rails date_select fields hidden and 
Another 2 hours wasted. Today I was trying to use the date_select helper, but I could not figure out why the fields kept showing up as hidden inputs instead of select boxes.

Poked around for a long long long time, before catching this tidbit
<pre>: order – Set to an array containing :day, :month and :year do customize the order in which the select fields are shown. If you leave out any of the symbols, the respective select will not be shown (like when you set :discard_xxx =&gt; true. Defaults to the order defined in the respective locale (e.g. [:year, :month, :day] in the en locale that ships with Rails).</pre>
For some god forsaken reason, the “order” on the date_select field in my app was not set, or is defaulted to something else. I have no idea where this happens, or how it happens. But adding and order param fixed my problem
<pre>f.datetime_select :start_time, :order => [:year, :month, :day]</pre>
<ul>
	<li><code>:discard_day</code> - Set to true if you don't want to show a day select. This includes the day as a hidden field instead of showing a select field. Also note that this implicitly sets the day to be the first of the given month in order to not create invalid dates like 31 February.</li>
	<li><code>:discard_month</code> - Set to true if you don't want to show a month select. This includes the month as a hidden field instead of showing a select field. Also note that this implicitly sets :discard_day to true.</li>
	<li><code>:discard_year</code> - Set to true if you don't want to show a year select. This includes the year as a hidden field instead of showing a select field.</li>
	<li><code>:order</code> - Set to an array containing <code>:day</code>, <code>:month</code> and <code>:year</code> to customize the order in which the select fields are shown. If you leave out any of the symbols, the respective select will not be shown (like when you set <code>:discard_xxx =&gt; true</code>. Defaults to the order defined in the respective locale (e.g. [:year, :month, :day] in the en locale that ships with <a href="http://api.rubyonrails.org/classes/Rails.html">Rails</a>).</li>
</ul>
