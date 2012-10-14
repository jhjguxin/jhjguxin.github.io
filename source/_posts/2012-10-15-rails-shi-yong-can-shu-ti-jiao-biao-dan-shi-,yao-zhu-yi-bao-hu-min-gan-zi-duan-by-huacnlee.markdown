---
layout: post
title: "Rails 使用参数提交表单时，要注意保护敏感字段 by huacnlee"
date: 2012-03-06 12:53
comments: true
categories: ["rails", "ruby"]
tags: ["ActiveRecord", "rails", "安全", "漏洞", "破解"]
---
## Rails 使用参数提交表单时，要注意保护敏感字段 by huacnlee
刚接触 Rails 的人都会对 Rails form 实际特别喜爱，因为它让我们省时省力，就算遇到有100多个字段的表单，也能够几下就做出来了，因为在服务端不用再去对每个字段分别写文本框与字段的赋值。

但是如果没有注意保护，使用 Model.create(params[:model]) 的方式提交会有很大的安全漏洞。
&lt;h2&gt;下面来看一个例子：&lt;/h2&gt;
&lt;h3&gt;有用户表 [users]&lt;/h3&gt;
&lt;ul&gt;
 &lt;li&gt;id&lt;/li&gt;
 &lt;li&gt;login [用户名]&lt;/li&gt;
 &lt;li&gt;passwd [密码]&lt;/li&gt;
 &lt;li&gt;nick_name [昵称]&lt;/li&gt;
 &lt;li&gt;email [Email]&lt;/li&gt;
 &lt;li&gt;state [状态]&lt;/li&gt;
 &lt;li&gt;group_id [组 [1 管理员, 2 编辑, 3 普通用户]]&lt;/li&gt;
 &lt;li&gt;exp [经验值]&lt;/li&gt;
 &lt;li&gt;money [金币]&lt;/li&gt;
 &lt;li&gt;level_id [等级]&lt;/li&gt;
 &lt;li&gt;created_at&lt;/li&gt;
 &lt;li&gt;updated_at&lt;/li&gt;
&lt;/ul&gt;
&amp;nbsp;
&lt;h3&gt;注册表单 users/regist.html.erb&lt;/h3&gt;
&amp;nbsp;

&lt;code&gt;
&lt;div id="register"&gt;
  &lt;% form_for @user do |f| -%&gt;
    &lt;p&gt;
      &lt;%= f.label :login, "Login" %&gt;
      &lt;%= f.text_field :login %&gt;
    &lt;/p&gt;
    &lt;p&gt;
      &lt;%= f.label :passwd, "Password" %&gt;
      &lt;%= f.password_field :passwd %&gt;
    &lt;/p&gt;
    &lt;p&gt;
      &lt;%= f.label :nick_name, "Nick Name" %&gt;
      &lt;%= f.password_field :nick_name %&gt;
    &lt;/p&gt;
   &lt;p&gt;
     &lt;%= f.submit "Regist" %&gt;
   &lt;/p&gt;
  &lt;% end -%&gt;
&lt;/div&gt; 
&lt;/code&gt;

控制器 UsersController.rb

 class UsersController &lt; ApplicationController
  def index
  end
  def new
    @user = User.new
  end
  def create
    @user = User.new(params[:user])
      if @user.save
        flash[:notice] = "注册成功。"
        redirect_to "/"
      end
   end
end

这是 Rails 里面很常见的写法,但是如果没有做相应的保护措施，那么使用 <code>@user = User.new(params[:user])</code> 然后 <code>@user.save</code> 这样的方式就会有很严重的问题，因为HTML表单是可以通过 <a href="http://www.getfirebug.com/">Firebug</a> 这类前端调试工具修改的。比如，现在的注册表单上面有 <code>login,passwd,nick_name</code> 三个字段，我可以使用 Firebug 强制修改HTML，加上：

<code>&lt;input name="user[:group_id]" type="text" value="1" /&gt;</code>

<code>&lt;input name="user[:money]" type="text" value="9999999" /&gt;</code>

<code>&lt;input name="user[:exp]" type="text" value="9999999" /&gt; </code>

然后提交保存… 接下来出现的结果大家应该都能猜到，这个用户的金币和经验值都被强制加上了，而且还注册成为了超级管理员！很恐怖把！ 看我在 <a href="http://pasite.is-programmer.com/posts/15200.html">is-programmer.com</a> 上面测试的这个例子我把访问量修改到上亿次！当然 is-programmer.com 做过这方面的保护，这个地方的问题不大不小，我本想强制注册个超级管理员的…但后面发现有做保护的… 呵呵
<h2>如何保护？</h2>
在 Model 里面使用 <em>attr_accessible</em> 或 <em>attr_protected</em> 详见：<a href="http://api.rubyonrails.org/classes/ActiveRecord/Base.html#M002280">ActiveRecord::Base 文档</a>

<code># models/user.rb class
User &lt; ActiveRecord::base
  # 使用 attr_protected 保护
   attr_protected :group_id, :money, :exp, :level_id, :state   # 或使用 attr_accessible # attr_accessible :login, :passwd, :email
end
# controllers/users_controller.rb
class UsersController &lt; ApplicationController
  def index
  end
  def new
    @user = User.new
  end
  def create
    @user = User.new(params[:user]) # 如果需要特别修改 attr_protected 保护的字段，请手动赋值，如 @user.exp = 1000 # 初始经验值 1000
   @user.level_id = 1
   if @user.save flash[:notice] = "注册成功。"
     redirect_to "/"
   end
  end
end </code>

<strong>特别需要更改保护字段的时候，需要使用 @model.money = 55 这样的方式赋值，而直接 @model.update_attributes(params[:model]) 这总方式会把保护字段过滤掉。</strong>
