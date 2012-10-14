---
layout: post
title: "My five favorite “hidden” features in Rails 3.2"
date: 2012-08-10 23:23
comments: true
categories: [rails,ruby]
tags: [crafting rails applications,exception handling,rails 3.2]
---
## My five favorite “hidden” features in Rails 3.2
Rails 3.2 is out with <a title="Rails 3.2.rc1 announced" href="http://weblog.rubyonrails.org/2011/12/20/rails-3-2-rc1-faster-dev-mode-routing-explain-queries-tagged-logger-store">great features on spotlight</a>: faster development reloading, faster router and explain queries. However, every Rails release ships with minor features that do not get that much attention but still would be a great fit to your application. This blog post is about my five favorites “hidden” features of Rails 3.2.
<h3>1) Smarter <code>content_tag_for</code></h3>
<a href="https://github.com/rails/rails/pull/2816">This feature written by Prem Sichanugrist</a> provides a very simple but welcome clean up to your views. Both <code>content_tag_for</code> and <code>div_for</code> now accepts an array of records and automatically loop over each record. Therefore, instead of writing this:
<div>
<div>
<pre>  @posts.each do |post|
    content_tag_for(:li, post) do
      ...
    end
  end</pre>
</div>
</div>
You can simply write:
<div>
<div>
<pre>  content_tag_for(:li, @posts) do |post|
    ...
  end</pre>
</div>
</div>
<h3>2) Smarter migration generators</h3>
It is funny how some parts of Rails as old as the migration generators continue receiving improvements day after day. Rails 3.1 already added a feature that automatically generate indexes for associations, by simply invoking:

&nbsp;
<pre>rails g scaffold Comment post:references title:string body:text</pre>
&nbsp;

With the above, Rails will detect that post is a reference and it will automatically 1) add a <code>post_id</code>integer column, 2) add an association to your model and 3) add an index to that column.

Right after 3.1 came out, I have pushed another small feature to the migration generator that simply makes the type attribute default to string. Therefore, you no longer need to write:

&nbsp;
<pre>rails g scaffold Person name:string email:string</pre>
&nbsp;

You could simply write:

&nbsp;
<pre>rails g scaffold Person name email</pre>
&nbsp;

Oddly enough, the idea for this feature came when I was preparing a presentation and the scaffold command could not fit in a slide (the so-called Presentation Driven Development). Anyhow, this small addition would not be enough to make to the best five “hidden” features of Rails 3.2. That’s when Dmitrii Samoilov comes in.

<a href="https://github.com/rails/rails/pull/2555">Dmitrii sent a pull request</a> that allows you to specify which columns should have an (unique) index. So one could write:

&nbsp;
<pre>rails g scaffold Person name:index email:uniq</pre>
&nbsp;

And the generator will automatically generate an index for name and an unique index for e-mail. There are other features there as well, so don’t forget to checkout the CHANGELOG.
<h3>3) Flexible exception handling</h3>
When Rails 3.0 came out, one of the features that people suddenly missed was the ability to better handle exceptions. The issue was: since Rails 3 became a lot more Rack “fluent”, we had to move some features to the middleware stack and this forced us to move the whole exceptions handling as well. Rails 3.2 attempts to bring some customization back to the game by allowing you to set your own exceptions rack application that is invoked when a failure happens. For instance, you could set the exceptions application to your own router in your<code>config/application.rb</code>:
<div>
<div>
<pre>config.exceptions_app = self.routes</pre>
</div>
</div>
Now, every time there is an exception, your router is going to be invoked. Therefore, to render custom 404 pages, you could simply add to your router:
<div>
<div>
<pre>match "/404", :to =&gt; "errors#not_found"</pre>
</div>
</div>
And implement the logic in the controller as you wish! However, there are a few things to keep in mind if you go down this road:
<ol>
	<li>You need to use <code>match</code> in your routes and not <code>get/post/put/delete</code> because such exceptions can happen in any HTTP request;</li>
	<li>You won’t be able to see your custom exceptions in development unless you set<code>config.consider_all_requests_local</code> to false in your <code>config/environments/development.rb</code>. The reason is, if the request is considered local, Rails will always favor to show the debug exceptions page;</li>
	<li>You can always access the original exception in the controller at<code>env["action_dispatch.exception"]</code>;</li>
	<li>It is not possible to set cookies, the session nor the flash after an exception happens. They all were already serialized back to the client;</li>
	<li>Finally, the default exceptions application used by Rails that simply renders a page in<code>public/STATUS.html</code> is available here: <a href="https://github.com/rails/rails/blob/master/actionpack/lib/action_dispatch/middleware/public_exceptions.rb">action_dispatch/middleware/public_exceptions.rb</a></li>
</ol>
Remember that whatever you do in the errors controller, it should not be anything “fancy”. Keep it simple because something already went wrong with your application!
<h3>4) Custom partial paths</h3>
In order to render a partial for a given model, Rails 3.0 retrieved the partial name by calling:<code>model.class.model_name.partial_path</code>. <a href="https://github.com/rails/rails/commit/bf812074fd55e7dcfa426d6c9bfd4d8d68922194">Grant Hutchins &amp; Peter Jaros noticed that this was not very flexible</a> because the class was responsible to define the partial path and therefore they decided to move this responsibility to the instance. In order to better understand how you can use this feature, let’s consider the following practical example.

Imagine your application have an activity feed and each activity in the feed has a certain type. Usually, each type is rendered differently. For example, if you consider a to-do-list application, activities could be both “marking a list as favorite” or “marking a task as done”. Usually, applications solve this by looping for each item and rendering its respective partial, something like this:
<div>
<div>
<pre>@activities.each do |activity|
  render :partial =&gt; "activities/#{activity.kind}",
    :locals =&gt; { :activity =&gt;  activity }
end</pre>
</div>
</div>
Now, you can solve this problem by defining <code>to_partial_path</code> in the model (the method<code>to_partial_path</code> is part of the ActiveModel API and can be implemented in any object. The example above implements it in the model for convenience, but it could be a presenter, another ORM, etc):
<div>
<div>
<pre>class Activity &lt; ActiveRecord::Base
  def to_partial_path() "activities/#{kind}" end
end</pre>
</div>
</div>
And then invoking:
<div>
<div>
<pre>render :partial =&gt; @activities, :as =&gt; :activity</pre>
</div>
</div>
This will now work on Rails 3.2 because even though all activities are of the same class, each instance is actually responsible for telling Rails which partial should be rendered.

The difference here is not only in brevity, but also in performance. Although the first snippet works fine, it is slow. In the scenario where only one kind of activity happened, the first snippet will go through the render stack 30 times and lookup the same template in your filesystem 30 times. If you read <a title="Crafting Rails Applications" href="http://pragprog.com/book/jvrails/crafting-rails-applications">Crafting Rails Applications</a> you know that this lookup is cached, but even though it would certainly be faster if we didn’t have to do this 30 times, but once.

That’s where <code>render :collection</code> or <code>render :partial</code> with an array comes in. In such cases Rails will retrieve all templates up front skipping duplicates, and this new feature allows us to take advantage of it even if the partial lookup is dynamic. So, in the scenario where all the activities are of the same kind, the template lookup will happen just once and no longer 30 times. In other words, best case scenario becomes <code>O(1)</code>, worst case scenario is still <code>O(n)</code>.
<h3>5) Filtered chain logging is back</h3>
Another very small change that will make development more pleasant is that Rails will now log “Filter chain halted as CALLBACK_NAME rendered or redirected” every time a before/around/after filter in your controller halts the request. This was the case in Rails 2.3 but somehow got lost when Rails 3 came out. It is one of those small things you don’t know how much you missed until you see it again!

And what is your favorite Rails 3.2 “hidden” feature? Don’t forget to take a good look at the CHANGELOGs and check out many others improvements!

&nbsp;

Tags: <a href="http://blog.plataformatec.com.br/tag/crafting-rails-applications/" rel="tag">crafting rails applications</a>, <a href="http://blog.plataformatec.com.br/tag/exception-handling/" rel="tag">exception handling</a>, <a href="http://blog.plataformatec.com.br/tag/rails-3-2/" rel="tag">rails 3.2</a>
