---
layout: post
title: "创建基于Rails 3的纯净Ajax CRUD程序"
date: 2012-06-06 22:50
comments: true
categories: [rails,ruby]
tags: [ajax,jquery,rails,ror]
---
## 创建基于Rails 3的纯净Ajax CRUD程序
Rails 3利用scaffold可以很容易地创建CRUD程序，但那是多页面的，现在很多场景需要使用Ajax在一个页面上实现CRUD。这对Rails 来说也是很简单的，下面就来创建一个符合Rails风格的Ajax CRUD程序。整个过程大概15分钟，建议先把整个代码照应敲一遍，然后再慢慢理解。
<h3>目标：</h3>
只有1个页面，CRUD全部基于Ajax在一个页面完成。使用无入侵式的Javascript风格。
<h3>平台：</h3>
适用于Rails 3.*，使用jQuery+sqlite。
Rails 3.1开始默认自带jQuery，如果是Rails 3.0.*需要手动添加jQuery。
如果想用Prototype要把那些js做相应修改。

Let’s GO：
<h3>1、创建项目</h3>
<pre title="">rails new AjaxCRUD
# 创建scaffold
rails g scaffold Entry name:string address:text phone:string email:string
# 建立数据库和表
rake db:create
rake db:migrate</pre>
<h3>2、修改controller</h3>
因为创建的是基于Ajax的CRUD，所以controller返回的数据要支持‘.js’格式，可以把默认的json格式删掉，其实除了index会返回网页，其它都是返回js，所以index外的html格式返回也可以删除。
<pre title="">respond_to do |format|
format.html
format.js
end</pre>
基于个思想，修改后的controller如下：
<pre title="">class EntriesController &lt; ApplicationController
  def index
    @entries = Entry.all
    @entry = Entry.new

    respond_to do |format|
      format.html # index.html.erb
      format.js
    end
  end

  def show
    @entry = Entry.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.js
    end
  end

  def new
    @entry = Entry.new

    respond_to do |format|
      format.html # new.html.erb
      format.js
    end
  end

  def edit
    @entry = Entry.find(params[:id])

    respond_to do |format|
      format.html
      format.js
    end
  end

  def create
    @entry = Entry.new(params[:entry])

    respond_to do |format|
      if @entry.save
        format.html { redirect_to @entry, notice: 'Entry was successfully created.' }
        format.js
      else
        format.html { render action: "new" }
        format.js { render action: "new" }
      end
    end
  end

  def update
    @entry = Entry.find(params[:id])

    respond_to do |format|
      if @entry.update_attributes(params[:entry])
        format.html { redirect_to @entry, notice: 'Entry was successfully updated.' }
        format.js
      else
        format.html { render action: "edit" }
        format.js { render action: "edit" }
      end
    end
  end

  def destroy
    @entry = Entry.find(params[:id])
    @entry.destroy

    respond_to do |format|
      format.html { redirect_to entries_url }
      format.js
    end
  end
end</pre>
<h3>3、修改Views</h3>
修改index页面(app/views/entries/index.html.erb)来显示Entry表单。
<pre title=""><h1>Listing entries</h1>
<table id="entries">
<tbody>
<tr>
<th>Name</th>
<th>Phone</th>
<th>Email</th>
<th>Address</th>
<th></th>
<th></th>
<th></th>
</tr>
</tbody>
</table>
<h2>Entry form</h2>
<div id="form">"form" %></div></pre>
注意：为了后面用jQuery操作DOM，table设置id=”entries”。

修改partial（app/views/entries/_form.html.erb）,注意在form_for中添加remote以发送异步请求。
<pre title=""><%= form_for(@entry, :remote => true) do |f| %>
  <% if @entry.errors.any? %>
    <div id="error_explanation">
      <h2><%= pluralize(@entry.errors.count, "error") %> prohibited this entry from being saved:</h2>

      <ul>
      <% @entry.errors.full_messages.each do |msg| %>
        <li><%= msg %></li>
      <% end %>
      </ul>
    </div>
  <% end %>

  <div class="field">
    <%= f.label :name %><br />
    <%= f.text_field :name %>
  </div>
  <div class="field">
    <%= f.label :phone %><br />
    <%= f.text_field :phone %>
  </div>
  <div class="field">
    <%= f.label :email %><br />
    <%= f.text_field :email %>
  </div>
  <div class="field">
    <%= f.label :address %><br />
    <%= f.text_area :address, :rows => 3 %>
  </div>
  <div class="actions">
    <%= f.submit %>
  </div>
<% end %></pre>
新建Entry partial(app/views/entries/_entry.html.erb)。
为了发送AJAX请求，edit，destroy都设置remote=true。
为了区分不同的entry，调用dom_id来根据entry生成不同的id
<pre title=""><tr id="<%= dom_id entry %>">
  <td><%= entry.name %></td>
  <td><%= entry.phone %></td>
  <td><%= entry.email %></td>
  <td><%= simple_format entry.address %></td>
  <td><%= link_to 'Show', entry %></td>
  <td><%= link_to 'Edit', edit_entry_path(entry), :remote => true %></td>
  <td><%= link_to 'Destroy', entry, confirm: 'Are you sure?', method: :delete, :remote => true %></td>
</tr></pre>
<h3>4、添加js.erb来响应Ajax请求</h3>
下面是关键，首先先说下操作流程：浏览器发起Ajax请求(CRUD)–&gt;controller收到请求，并调用model更新数据–&gt;返回js代码–&gt;浏览器收到js代码，使用jQuery来更新index页面中的DOM对象，包括列表和表单。

新建 app/views/entries/create.js.erb 响应添加Entry的请求
1、在index页面的entry列表中添加刚才新增的entry对象。
2、清空index页面中添加entry表单中的数据。
<pre title="">$('<%= escape_javascript(render(:partial => @entry)) %>').appendTo('#entries').hide().fadeIn();
$("#new_entry")[0].reset();</pre>
escape_javascript(render(:partial =&gt; @entry))可以缩写成：j render @entry。

新建 app/views/entries/edit.js.erb 处理点击编辑时的请求
在index页面的新建entry的form中填充要编辑entry的数据。
<pre title="">$("#form > form").replaceWith("<%= j render "form" %>");</pre>
新建 app/views/entries/update.js.erb 来更新列表中的Entry对象。新建Entry并清空form
<pre title="">$("#<%= dom_id @entry %>").replaceWith("<%= j render @entry %>");
<% @entry = Entry.new # reset for new form %>
$(".edit_entry").replaceWith("<%= j render "form" %>")
$(".new_entry")[0].reset();</pre>
新建 app/views/entries/destroy.js.erb 来删除list中的Entry
<pre title="">$("#<%= dom_id @entry %>").remove();</pre>
<h3>5、设置主页</h3>
设置entries页面为主页。修改 config/routes.rb
<pre title="">AjaxCRUD::Application.routes.draw do
  resources :entries
  root :to => "entries#index"
end</pre>
删除静态首页文件。
<pre title="">rm public/index.html</pre>
<h3>6、启动程序</h3>
<pre title="">rails s</pre>
此时打开 http://127.0.0.1:3000
就可以使用了。
<blockquote>源代码托管在
<a title="Rails基于Ajax的CRUD源代码" href="https://github.com/camelsong/AjaxCRUD" target="_blank">https://github.com/camelsong/AjaxCRUD</a></blockquote>
英文原文地址：http://codefundas.blogspot.com/2010/12/create-ajax-based-curd-using-rails-3.html
