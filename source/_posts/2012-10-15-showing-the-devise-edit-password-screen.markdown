---
layout: post
title: "Showing the devise edit password screen"
date: 2012-01-07 01:54
comments: true
categories: ["rails", "ruby"]
tags: ["devise", "edit", "password", "rails", "ruby"]
---
## Showing the devise edit password screen
In my rails 3 app using devise, I want to provide a link for users to edit their password.

I have a standard link that points to: /users/password/edit ... Log output below(#all action in PasswordsController )

 
<code>Started GET "/users/password/edit" for 127.0.0.1 at 2011-08-10 10:11:46 -0700
Processing by Devise::PasswordsController#edit as HTML
User Load (0.6ms) SELECT "users".* FROM "users" WHERE "users"."id" = 3 LIMIT 1
Redirected to http://localhost:3000/
Completed 302 Found in 309ms</code>

Why is rails redirecting? Why can't I show the edit password page? Thanks

&nbsp;

<code>Devise::PasswordsController#edit</code> is for non-authenticated users who wish to change their password using a reset token. This reset token was previously sent to the user in an email (Reset password instructions). If the user is already logged in, this edit password page will always redirect to the after-sign-in path since it shouldn't be accessible to authenticated users.

&nbsp;

I suppose what you want is to allow the user to change his password <strong>after</strong> logging in. You have to use<code>Devise::RegistrationsController#edit</code> for that.

&nbsp;
<div>标签： <a href="http://jhjguxin.sinaapp.com/tag/devise/">devise</a> <a href="http://jhjguxin.sinaapp.com/tag/rails/">rails</a> <a href="http://jhjguxin.sinaapp.com/tag/ruby/">ruby</a></div>
