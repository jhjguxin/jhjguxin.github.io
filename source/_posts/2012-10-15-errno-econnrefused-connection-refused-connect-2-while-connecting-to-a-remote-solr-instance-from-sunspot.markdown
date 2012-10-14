---
layout: post
title: "Errno::ECONNREFUSED:  Connection refused - connect(2) while connecting to a remote solr instance from Sunspot"
date: 2012-02-03 20:10
comments: true
categories: ["rails"]
tags: ["rails", "ruby", "sunspot"]
---
## Errno::ECONNREFUSED:  Connection refused - connect(2) while connecting to a remote solr instance from Sunspot
<h2>Quickstart with Rails 3</h2>
Add to Gemfile:
<div>
<code>gem 'sunspot_rails'
gem 'sunspot_solr' # optional pre-packaged Solr distribution for use in development</code>
</div>
Bundle it!
<div>
<pre>bundle install</pre>
</div>
Generate a default configuration file:
<div>
<pre>rails generate sunspot_rails:install</pre>
</div>
If <code>sunspot_solr</code> was installed, start the packaged Solr distribution with:

<code>bundle exec rake sunspot:solr:start # or sunspot:solr:run to start in foreground</code>

Now that Sunspot knows how to index the <code>Post</code> model, we need to get the existing data into Solr. Any time a <code>Post</code> is created, updated, or destroyed, Sunspot::Rails will automatically make the change to the index; you only need to do a full reindex if you’ve added or changed a <code>searchable</code> definition for a model.

<code>$ rake sunspot:reindex</code>

If <code>sunspot_solr</code> was installed, start the packaged Solr distribution with:
<div>
<code>jhjguxin@jhjguxin-Aspire-4750:~$ heroku run:detached rake sunspot:solr:start RAILS_ENV=production rake sunspot:solr:start --app francisjiang
or type:sunspot-solr start -- -p 8983 or sunspot-solr start -- -p 8983 -d data/solr/myapp</code>
Try to start the solr
<pre>
<code>##with apache+solr+rails
jhjguxin@jhjguxin-virtual-machine:/var/www/enki$ sudo gem install sunspot_solr
Successfully installed escape-0.0.4
Successfully installed sunspot_solr-1.3.0
2 gems installed
Installing ri documentation for escape-0.0.4...
Installing ri documentation for sunspot_solr-1.3.0...
Installing RDoc documentation for escape-0.0.4...
Installing RDoc documentation for sunspot_solr-1.3.0...
jhjguxin@jhjguxin-virtual-machine:/var/www/enki$ sudo sunspot-solr start -- -p 8983 -d solr/data/
[sudo] password for jhjguxin: 
java version "1.6.0_23"
OpenJDK Runtime Environment (IcedTea6 1.11pre) (6b23~pre11-0ubuntu1.11.10.1)
OpenJDK Client VM (build 20.0-b11, mixed mode, sharing)
</code>
</pre>

Solr服务控制
将以上内容添加到Rakefile后，将会多出4个task出来

服务器启动:
rake sunspot:solr:start
初次启动，会安装一个embed的solr程序，那么开发环境中省去了安装配置Solr环境繁琐步骤。不过，production环境里可不要使用这个embed版。

服务器停止:
rake sunspot:solr:stop
全部重建索引：
rake sunspot:reindex
如果你想看到运行日志，把服务跑在前端。可以使用一下命令:
rake sunspot:solr:run
使用以上命令，就能完成对Sunspot的控制。

</div>
