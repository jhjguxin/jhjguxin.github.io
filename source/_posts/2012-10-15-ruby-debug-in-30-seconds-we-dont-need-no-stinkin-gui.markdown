---
layout: post
title: "ruby-debug in 30 seconds (we don't need no stinkin' GUI!) "
date: 2011-12-27 17:38
comments: true
categories: [ruby]
tags: [breakpoint,debug,rails,ruby,shell,vim]
---
## ruby-debug in 30 seconds (we don't need no stinkin' GUI!) 
<code>Many people (including me) have complained about the lack of a good GUI debugger for Ruby. Now that some are finally getting usable, I've found I actually prefer IRB-style ruby-debug to a GUI.</code>

There's good tutorial links on the <a href="http://www.datanoise.com/ruby-debug/">ruby-debug homepage</a>, and a very good <a href="http://cheat.errtheblog.com/s/rdebug/">Cheat sheet</a>, but I wanted to give a bare-bones HOWTO to help you get immediately productive with ruby-debug.
<h1>Install the latest gem</h1>
<pre><code>$ gem install ruby-debug </code></pre>
<h1>Install the cheatsheet</h1>
<pre><code>$ gem install cheat $ cheat rdebug </code></pre>
<h1>Set autolist, autoeval, and autoreload as defaults</h1>
<pre><code>$ vi ~/.rdebugrc set autolist set autoeval set autoreload </code></pre>
<h1>Run Rails (or other app) via rdebug</h1>
<pre><code>$ rdebug script/server </code></pre>
<h1>Breakpoint from rdebug</h1>
<pre><code>(rdb:1) b app/controllers/my_controller.rb:10 </code></pre>
<h1>Breakpoint in source</h1>
<pre><code>require 'ruby-debug' debugger my_buggy_method('foo') </code></pre>
<h1>Catchpoint</h1>
<pre><code>(rdb:1) cat RuntimeError </code></pre>
<h1>Continue to breakpoint</h1>
<pre><code>(rdb:1) c </code></pre>
<h1>Next Line (Step Over)</h1>
<pre><code>(rdb:1) n </code></pre>
<h1>Step Into</h1>
<pre><code>(rdb:1) s </code></pre>
<h1>Continue</h1>
<pre><code>(rdb:1) c </code></pre>
<h1>Where (Display Frame / Call Stack)</h1>
<pre><code>(rdb:1) where </code></pre>
<h1>List current line</h1>
<pre><code>(rdb:1) l= </code></pre>
<h1>Evaluate any var or expression</h1>
<pre><code>(rdb:1) myvar.class </code></pre>
<h1>Modify a var</h1>
<pre><code>(rdb:1) @myvar = 'foo' </code></pre>
<h1>Help</h1>
<pre><code>(rdb:1) h </code></pre>
There are many other commands, but these are the basics you need to poke around. Check the <a href="http://cheat.errtheblog.com/s/rdebug/">Cheat sheet</a> for details.

This can also be used directly from any IDE that supports input into a running console (such as Intellij Idea).

That should get you started. So, before you stick in another 'p' to debug, try out ruby-debug instead!

<code>require 'rubygems'
require 'ruby-debug'
#$ruby breakpoint_test.rb
#vim breakpoint_test.rb
#:!ruby breakpoint_test.rb
#Next Line (Step Over)
#(rdb:1) n
#Step Into
#(rdb:1) s
#to debug in a function which is called from other place,before this function call,type 's' and you will found your are inside this function.
def leap_year year
leap = case
breakpoint
when year % 400 == 0: true
when year % 100 == 0: false
else year % 4 ==0
end
puts leap
end
if __FILE__ == $0
# tests...
puts "year=2000"
leap_year 2000
puts "year=2004"
leap_year 2004
puts "year=2002"
leap_year 2002
end</code>

标签： <a href="http://jhjguxin.hwcrazy.com/tag/breakpoint/">breakpoint</a> <a href="http://jhjguxin.hwcrazy.com/tag/debug/">debug</a> <a href="http://jhjguxin.hwcrazy.com/tag/rails/">rails</a> <a href="http://jhjguxin.hwcrazy.com/tag/ruby/">ruby</a> <a href="http://jhjguxin.hwcrazy.com/tag/shell/">shell</a>
