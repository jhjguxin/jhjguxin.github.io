---
layout: post
title: "Rails form_for with associations defined and multipart set to true not working"
date: 2012-02-08 22:26
comments: true
categories: [rails,ruby,专业]
tags: [Form,rails]
---
## Rails form_for with associations defined and multipart set to true not working
So I have one form:

<%= form_for([@document, @comment]) do |f| %>

Showing /home/jhjguxin/enki/app/views/posts/show.html.erb where line #31 raised:

wrong number of arguments (2 for 1)
Any ideas? Running Rails 3.1.3 with Ruby 1.9.2p180
Bellow will fix it

<%= form_for (@comment, :url => [@document, @comment]) do |f| %>
