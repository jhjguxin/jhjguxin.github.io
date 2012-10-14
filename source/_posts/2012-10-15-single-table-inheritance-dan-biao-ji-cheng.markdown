---
layout: post
title: "Single table inheritance (单表继承)"
date: 2012-06-18 15:40
comments: true
categories: [rails,ruby]
tags: [inheritance,rails,ruby,single,table,单表继承]
---
## Single table inheritance (单表继承)
Active Record allows inheritance by storing the name of the class in a column that by default is named “type” (can be changed by overwriting <code>Base.inheritance_column</code>). This means that an inheritance looking like this:
<pre data-result="[object Object]">class Company &lt; ActiveRecord::Base; end
class Firm &lt; Company; end
class Client &lt; Company; end
class PriorityClient &lt; Client; end</pre>
When you do <code>Firm.create(:name =&gt; "37signals")</code>, this record will be saved in the companies table with type = “Firm”. You can then fetch this row again using <code>Company.where(:name =&gt; '37signals').first</code> and it will return a Firm object.

If you don’t have a type column defined in your table, single-table inheritance won’t be triggered. In that case, it’ll work just like normal subclasses with no special magic for differentiating between them or reloading the right type with find.

Note, all the attributes for all the cases are kept in the same table. Read more: <a href="http://www.martinfowler.com/eaaCatalog/singleTableInheritance.html">www.martinfowler.com/eaaCatalog/singleTableInheritance.html</a>
