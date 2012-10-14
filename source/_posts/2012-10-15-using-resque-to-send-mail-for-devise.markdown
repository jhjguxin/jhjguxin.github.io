---
layout: post
title: "Using Resque to send mail for Devise"
date: 2012-06-15 15:03
comments: true
categories: ["rails", "ruby"]
tags: ["devise", "mail", "resque"]
---
## Using Resque to send mail for Devise
<div>
<div id="wiki-body">
<div>

Since sending email synchronously is not a good idea, you'll probably want to have Devise enqueuing it's notification emails for background processing.

Although Devise doesn't support this out of the box you can achieve it easily by using the <a href="https://github.com/mhfs/devise-async">devise-async</a> gem.

To do so, first add it to your Gemfile:
<div>
<pre>gem "devise-async"</pre>
</div>
Then tell Devise to use the proxy mailer in <code>config/initializers/devise.rb</code>:
<div>
<pre># Configure the class responsible to send e-mails.
config.mailer = "Devise::Async::Proxy"</pre>
</div>
And last but not least, set your queuing backend by creating <code>config/initializers/devise_async.rb</code>:
<div>
<pre># Supported options: :resque, :sidekiq, :delayed_job
Devise::Async.backend = :resque</pre>
</div>
Your notification emails should now be gracefully enqueued for background processing.

</div>
</div>
</div>
<h2 id="gollum-footer">## Notice I have jobs in queue but no workers. Do I have to create task, or workers?</h2>
&nbsp;

<code>#!/usr/bin/env rake
# Add your own tasks in files placed in lib/tasks ending in .rake,
# for example lib/tasks/capistrano.rake, and they will automatically be available to Rake.</code>

require File.expand_path('../config/application', __FILE__)
require 'resque/tasks'

Askjane::Application.load_tasks

task "resque:setup" =&gt; :environment do
ENV['QUEUE'] ||= '*'
#for redistogo on heroku http://stackoverflow.com/questions/2611747/rails-resque-workers-fail-with-pgerror-server-closed-the-connection-unexpectedl
Resque.before_fork = Proc.new { ActiveRecord::Base.establish_connection }
end
####run below command
#QUEUE=* rake environment resque:work
