---
layout: post
title: "bundle install and rbx-require-relative"
date: 2012-01-31 12:02
comments: true
categories: [rails,ruby]
tags: [bundle,rails,ruby]
---
## bundle install and rbx-require-relative
# To use debugger
#rbx-require-relative is a port of Ruby 1.9’s relative_relative for Rubinus and MRI 1.8
#If you're running ruby1.9 then you don't need it. Remove it from your Gemfile.

#Don't require ruby-debug in your Gemfile as it has rbx-require-relative as a dependency. Add gem 'ruby-debug19' instead
<code>if RUBY_VERSION =~ /^1.9/
gem 'ruby-debug19'
else
gem 'ruby-debug'
end</code>

标签： bundle rails ruby
