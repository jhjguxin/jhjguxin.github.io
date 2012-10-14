---
layout: post
title: "Devise logout link non-functional"
date: 2012-05-22 13:37
comments: true
categories: ["rails", "ruby"]
tags: ["delete", "devise", "logout", "rails", "signout"]
---
## Devise logout link non-functional
Resources: <a href="http://stackoverflow.com/questions/6110047/rails-devise-override-sessionscontroller">http://stackoverflow.com/questions/6110047/rails-devise-override-sessionscontroller</a>

the problem: In a nutshell, when I try to install a logout link to my app it fails to work. Here's as much context as I can think to put here (if you want anything else, please poke me)...

I've got this in a haml view:
<pre><code>= link_to("Logout", destroy_user_session_path, :method =&gt; :delete) </code></pre>
It generates this in the view:
<pre><code>&lt;a href="/users/sign_out" data-method="delete" rel="nofollow"&gt;Logout&lt;/a&gt; </code></pre>
I verified that in my config/initializers/devise.rb I have this setting uncommented and correct:
<pre><code>config.sign_out_via = :delete </code></pre>
I validated the following route:
<pre><code>destroy_user_session DELETE /users/sign_out(.:format) {:action=&gt;"destroy", :controller=&gt;"devise/sessions"} </code></pre>
I also have this bit of trickery in my routes.rb, and I suspect this is related to my issue:
<pre><code>devise_for :users, :controllers =&gt; {:sessions =&gt; "devise/sessions", :registrations =&gt; "users"} resources :users </code></pre>
This last bit is because I want to manage (edit, create and delete) users in my own controller.

The error message I'm getting is as follows:
<pre><code>ActiveRecord::RecordNotFound in UsersController#show Couldn't find User with ID=sign_out Rails.root: /home/jaydel/projects/mbsquared-projects/Wilson-Goldrick app/controllers/users_controller.rb:16:in `show' </code></pre>
In my server logs I see this for the request:
<pre><code>Started GET "/users/sign_out" for 127.0.0.1 at 2011-08-04 13:08:51 -0500   Processing by UsersController#show as HTML   Parameters: {"id"=&gt;"sign_out"} </code></pre>
Outside it's slightly overcast and in the mid 80s. I'm wearing a red shirt.

Anyone have any ideas?

1
<blockquote>The problem lies in the fact that in your logs the signout request is a GET request.
<pre><code>Started GET "/users/sign_out" </code></pre>
But the signout route is a DELETE
<pre><code>destroy_user_session DELETE /users/sign_out(.:format) </code></pre>
The reason why you are getting the exception is that is it getting confused with one of the routes created by <code>resources :users</code> which would be something like
<pre><code>edit_user GET /users/(:id)(.:format) {:action=&gt;"edit", :controller=&gt;"users"} </code></pre>
Basically 'sign_out' is being mistaken as a id.

I'm not sure why the delete link is not going through as a DELETE request. Though changing
<pre><code>config.sign_out_via = :delete </code></pre>
to be :get might solve the problem.</blockquote>
2
<blockquote>I think the more correct way to fix this, REST-wise, would be to change your logout links to use the DELETE method. It's a very easy fix, changing this:

link_to "Log out", destroy_user_session_path

to this:

link_to "Log out", destroy_user_session_path, :method =&gt; :delete</blockquote>
3
<blockquote>I had the same problem with rails 3.2 when I deleted from <code>application.js</code> this line:
<pre><code>//= require jquery_ujs </code></pre>
So, I think you have to insert this line in your <code>application.js</code> if you haven't it there.

PS. This behavior means that rails adapter for <code>jquery</code> doesn't function. So you should make sure if it is loaded in your html in browser. You should test it in development mode because you will have compressed js in production and it will be very difficult to find something there.

&nbsp;</blockquote>
&nbsp;
