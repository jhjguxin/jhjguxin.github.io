---
layout: post
title: "rails - Devise - Handling - devise_error_messages"
date: 2012-05-30 13:10
comments: true
categories: [rails,ruby]
tags: [devise,errors,messages,rails]
---
## rails - Devise - Handling - devise_error_messages
in my user edit page, there is a line as follows:
<pre><code>&lt;%= devise_error_messages! %&gt; </code></pre>
The problem is this does not output errors the stand way that the rest of the app does:
<pre><code>&lt;% flash.each do |key, value| %&gt;     &lt;divpun" style="margin-top: 0px; margin-right: 0px; margin-bottom: 0px; margin-left: 0px; padding-top: 0px; padding-right: 0px; padding-bottom: 0px; padding-left: 0px; border-top-width: 0px; border-right-width: 0px; border-bottom-width: 0px; border-left-width: 0px; border-style: initial; border-color: initial; border-image: initial; vertical-align: baseline; background-image: initial; background-attachment: initial; background-origin: initial; background-clip: initial; background-color: transparent; color: rgb(0, 0, 0); "&gt;&lt;%= key %&gt;"&gt;&lt;%= value %&gt;&lt;/div&gt; &lt;% end %&gt; </code></pre>
My question, is how to I get the devise error message to work like the others that use the flash.each?

Thanks

I'm trying to figure this out myself. I just found this issue logged on Github<a href="https://github.com/plataformatec/devise/issues/issue/504/#comment_574788" rel="nofollow">https://github.com/plataformatec/devise/issues/issue/504/#comment_574788</a>

Jose is saying that <code>devise_error_messsages!</code> method is just a <em>stub</em> (though it contains implementation) and that we're supposed to override/replace it. It would have been nice if this was pointed out somewhere in the wiki, which is why i guess there are a few people like us that have been guessing.

So I'm going to try reopening the module and redefine the method, effectively overriding the default implementation. I'll let you know how it goes.
<h2>Update</h2>
Yep, that works. I created <code>app/helpers/deivse_helper.rb</code> and overrode it like so:
<pre><code>module DeviseHelper   def devise_error_messages!     'KABOOM!'   end end </code></pre>
So knowing this, I can modify the method to display error messages the way I want it to.

To help you solve your original problem: Here's the original <a href="https://github.com/plataformatec/devise/blob/master/app/helpers/devise_helper.rb#L6" rel="nofollow"><code>devise_helper.rb</code> on Github</a>. Take a look at how the error messages are being traversed, specifically <a href="https://github.com/plataformatec/devise/blob/master/app/helpers/devise_helper.rb#L5" rel="nofollow">Line 5</a>.
<pre><code>messages = resource.errors.full_messages.map { |msg| content_tag(:li, msg) }.join </code></pre>
That should help you get started. :)
<h2>Another update</h2>
The <code>resource</code> object is actually the model that is being used by devise (go figure).
<pre><code>resource.class         #=&gt; User resource.errors.class  #=&gt; ActiveModel::Error </code></pre>
It also appears to be defined in a higher scope (probably coming from the controller), so it can be accessed in a variety of places.

Anywhere in your Helper
<pre><code>module DeviseHelper   def devise_error_messages1!     resource.errors.full_messages.map { |msg| content_tag(:li, msg) }.join   end   def devise_error_messages2!     resource.errors.full_messages.map { |msg| content_tag(:p, msg) }.join   end end </code></pre>
Your View
<pre><code>&lt;div&gt;&lt;%= resource.errors.inspect %&gt;&lt;/div&gt;</code></pre>
More info look at <a href="http://stackoverflow.com/questions/4101641/rails-devise-handling-devise-error-messages">http://stackoverflow.com/questions/4101641/rails-devise-handling-devise-error-messages</a>
