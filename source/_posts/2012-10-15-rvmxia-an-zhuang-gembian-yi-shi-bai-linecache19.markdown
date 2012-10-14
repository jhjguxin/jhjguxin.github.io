---
layout: post
title: "rvm下安装gem编译失败 linecache19"
date: 2012-02-14 15:41
comments: true
categories: ["rails", "ruby"]
tags: ["linecache19", "rails", "ruby", "rvm"]
---
## rvm下安装gem编译失败 linecache19
报错:An error occured while installing linecache19 (0.5.12), and Bundler cannot continue.

以下引用stackoverflow中的解答

ruby -v

then manually use --force to bypass version check:

gem install ruby_core_source

gem install linecache19 --force

if you faced with another error starting with following lines:

checking for vm_core.h... no

*** extconf.rb failed ***

You have to explicitly set the source path to vm_core.h

In my case:

$ which ruby

/<span style="background-color: #ffd700;">User</span>s/Reza/.rvm/rubies/ruby-1.9.2-rc2/bin/ruby

$ echo $rvm_path

/<span style="background-color: #ffd700;">User</span>s/Reza/.rvm/

so to install linecache19 :

gem install ruby_core_source

gem install linecache19 --force -- --with-ruby-include=$rvm_path/src/ruby-1.9.2-rc2/

ruby-debug19 has a similar issue:

gem install ruby-debug19 --force -- --with-ruby-include=$rvm_path/src/ruby-1.9.2-rc2/

That's all!

=====================================

关键地方:

gem install ruby_core_source

if cannot `rvm pkg install openssl`
  `sudo rvm pkg install openssl`
end

rvm remove 1.9.2-p290
rvm install 1.9.2-p290 --with-openssl-dir=$rvm_path/usr
<h2>ruby-debug and ruby 1.9</h2>
If you have trouble installing ruby-debug19 try installing with the following command:
<pre>$ rvm reinstall 1.9.2 --patch debug --force-autoconf
#可以先试试下面这个命令
$ gem install ruby-debug19 -- --with-ruby-include="${MY_RUBY_HOME/rubies/src}"</pre>
