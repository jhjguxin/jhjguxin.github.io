---
layout: post
title: "Rails counter cache"
date: 2012-08-27 00:44
comments: true
categories: ["rails", "ruby"]
tags: ["cache", "counter", "rails"]
---
## Rails counter cache
这次就是讲用_count字段来缓存has_many的计数 

看Project和Task的例子:
<div id="">
<pre><h1>Projects</h1>

<table>
<% for project in @projects %>
  <tr>
    <td><%= link_to project.name, poject_path(project) %></td>
    <td><small>(<%= pluralize project.tasks.size, 'task' %>)</small></td>
  </tr>
<% end %>
</table>
</pre>
</div>
<pre>上面的页面代码对所有的@projects显示tasks.size，看下log:</pre>
<div id="">
<pre>SQL (0.006385)  SELECT count(*) AS count_all FROM tasks WHERE (tasks.project_id = 326)
SQL (0.000220)  SELECT count(*) AS count_all FROM tasks WHERE (tasks.project_id = 327)
SQL (0.000383)  SELECT count(*) AS count_all FROM tasks WHERE (tasks.project_id = 328)
SQL (0.000197)  SELECT count(*) AS count_all FROM tasks WHERE (tasks.project_id = 329)
SQL (0.000215)  SELECT count(*) AS count_all FROM tasks WHERE (tasks.project_id = 330)</pre>
</div>
<pre>上面显示了对每个project都使用SQL来count tasks，我们采用eager loading看看能否改进性能:</pre>
<div id="">
<pre>class ProjectsController &lt; ApplicationController
  def index
    @projects = Project.find(:all, :include =&gt; :tasks)
  end
end</pre>
</div>
<pre>再来看看log:</pre>
<div id="">
<pre>Project Lood Incluing Associations (0.000954)  SELECT projects.'id' AS t0_r0, projects.'name' AS t0_r1, tasks.'id'
AS t1_r0, tasks.'name' AS t1_r1, tasks.'project_id' AS t1_r2 FROM projects LEFT OUTER JOIN tasks ON tasks.project
_id = projects.id</pre>
</div>
<pre>我们看到，使用eager loading确实只用一条SQL语句就完成工作，但是缺点是把tasks表所有的字段信息都取出来了，很多信息是 
没有用的。 

我们来看看更好的解决方案:</pre>
<div id="">
<pre>ruby script/generate migration add_tasks_count</pre>
</div>
<pre>我们新建一个migration，给projects表添加一个叫tasks_count的列:</pre>
<div id="">
<pre>class AddTasksCount &lt; ActiveRecord::Migration
  def self.up
    add_column :projects, :tasks_count, :integer, :default =&gt; 0

    Project.reset_column_information
    Project.find(:all).each do |p|
      p.update_attribute :tasks_count, p.tasks.length
    end
  end

  def self.down
    remove_column :projects, :tasks_count
  end
end</pre>
</div>
<pre>我们还需要告诉Task类开启counter cache:</pre>
<div id="">
<div>
<pre>class Task &lt; ActiveRecord::Base
  belongs_to :projects, :counter_cache =&gt; true
end</pre>
</div>
</div>
<pre>好了，我们把ProjectsController的index方法改回lazy loading，刷新页面，再看看log:</pre>
<div id="">
<pre>Project Lood (0.000295)  SELECT * FROM projects</pre>
</div>
