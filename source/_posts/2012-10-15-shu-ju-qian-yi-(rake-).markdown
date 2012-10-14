---
layout: post
title: "数据迁移（rake ）"
date: 2012-05-21 14:05
comments: true
categories: ["rails", "ruby"]
tags: ["migrate", "rails", "sql"]
---
## 数据迁移（rake ）
<div id="blog_content">
<div>

有时候我们的Rails应用是在已有数据库上的，我们需要把基于SQL的schema转化成ActiveRecord的schema

1，dump schema
运行rake db:schema:dump来将数据库中的表结构复制到db/schema.rb文件中
这时运行rake db:schema:load或者将schema.rb的内容copy到一个migration中并运行rake db:migrate会生成表
其中:force =&gt; true表示会覆盖数据库已存在的表，这样会让我们丢失数据库已有的data

2，migration的版本
Rails会自动生成schema_info表，该表的version列表示当前的migration的version，即migration文件开头的number
可以修改schema_info的version来控制要执行的migrate任务

3，避免丢失数据
一种方式是先从数据库extract fixtures，然后rake db:schema:load或rake db:migrate，并且:force =&gt; true，然后rake db:fixtures:load
另一种方式是修改schema_info的version来控制要执行的migrate任务

</div>
</div>
