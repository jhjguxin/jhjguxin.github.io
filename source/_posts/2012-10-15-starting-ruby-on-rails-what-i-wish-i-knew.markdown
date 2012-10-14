---
layout: post
title: "Starting Ruby on Rails: What I Wish I Knew"
date: 2012-05-05 19:38
comments: true
categories: [rails,ruby]
tags: [rails,ruby,Starting]
---
## Starting Ruby on Rails: What I Wish I Knew
<blockquote>from betterexplained.com , update by francis</blockquote>
<a href="http://rubyonrails.com/">Ruby on Rails</a> is an <strong>elegant</strong>, <strong>compact</strong> and <strong>fun</strong> way to build web applications. Unfortunately, many gotchas await the new programmer. Now that I have a few [rails projects}(<a href="http://instacalc.com/">http://instacalc.com/</a>) under my belt, here's my shot at sparing you the suffering I experienced when first getting started.
<h3><a name="tools-just-get-them" href="https://github.com/jhjguxin/project-manage/blob/master/rails/wiki/starting-ruby-on-rails-what-i-wish-i-knew.en.markdown#tools-just-get-them"></a>Tools: Just Get Them</h3>
Here's the tools you'll need. Don't read endless reviews trying to decide on the best one; start somewhere and get going.
<ul>
	<li><a href="http://www.pragmaticprogrammer.com/titles/rails/">Agile Web Development with Rails.</a> Yes, it's a book. And a cohesive book is worth 100 hobbled-together online tutorials.</li>
	<li><a href="http://rubyforge.org/projects/instantrails/">InstantRails</a>: A <code>.zip</code> file containing Ruby, Apache, MySQL and PHP (for PhpMyAdmin), packaged and ready to go.</li>
	<li><a href="http://www.aptana.com/">Aptana/RadRails</a> (like Eclipse) or Ruby In Steel (like Visual Studio) for editing code.</li>
	<li><a href="http://subversion.tigris.org/">Subversion</a>, <a href="http://tortoisesvn.net/downloads">TortoiseSVN</a> and/or <a href="https://github.com/">Github</a> for source control.</li>
	<li>Browse popular ruby on rails links on [del.icio.us]<a href="http://del.icio.us/popular/rubyonrails">http://del.icio.us/popular/rubyonrails</a>), <a href="http://railsbrain.com/">Rails documentation</a> and <a href="http://docs.huihoo.com/ruby/ruby-man-1.4/syntax.html">Ruby syntax &amp; examples</a>.</li>
</ul>
But What Does It All Mean?

"Ruby on Rails" is catchy but confusing. Is Rails some type of magical drug that Ruby is on? (Depending on who you ask, yes.)

<strong>Ruby</strong> is a programming language, similar to +Python+ and +Perl+. It is dynamically typed (no need for "int i"), 解释执行, and can be modified at runtime (such as adding new methods to classes). It has 数十种 of shortcuts that make it very clean; methods are rarely over 10 lines. It has good RegEx support and works well for shell scripting.

<strong>Rails</strong> is a <a href="http://rubygems.org/read/book/1">gem</a>, or a Ruby library. Some gems let you use the Win32 API. Others handle networking. Rails helps make web applications, providing classes for saving to the database, handling URLs and displaying html (along with a webserver, maintenance tasks, a debugging console and much more).

<strong>IRB</strong> is the interactive Ruby console (type "irb" to use). Rails has a special IRB console to access your web app as it is running (excellent for live debugging).

<strong>Rake</strong> is Ruby's version of Make. Define and run maintenance 维护 tasks like setting up databases, reloading data, backing up, or even deploying an app to your website.

<strong>Erb</strong> is embedded Ruby, which is like PHP. It lets you mix Ruby with HTML (for example): Ruby, which is like PHP. It lets you mix Ruby with HTML (for example):
<div>
<pre>  &lt;div&gt;Hello there, &lt;%= get_user_name() %&gt;&lt;/div&gt;</pre>
</div>
<strong>YAML</strong> (or <strong>YML</strong>) means "YAML Ain't a Markup Language" — it's a simple way to <a href="http://en.wikipedia.org/wiki/YAML">specify data</a>:
<div>
<pre>  {name: John Smith, age: 33}</pre>
</div>
It's like JSON, much leaner than XML, and used by Rails for setting configuration options (like setting the database name and password).

Phew! Once Ruby is installed and in your path, you can add the rails gem using:
<pre lang="shell"><code> gem install rails </code></pre>
In general, use gem install "gem_name", which searches online sources for that library. Although Rails is "just another gem", it is the killer library that brought Ruby into the limelight.
<h3><a name="understanding-ruby-isms" href="https://github.com/jhjguxin/project-manage/blob/master/rails/wiki/starting-ruby-on-rails-what-i-wish-i-knew.en.markdown#understanding-ruby-isms"></a>Understanding Ruby-Isms</h3>
It's daunting to learn a new library and a new language at the same time. Here are some of the biggest Ruby gotchas 陷阱 for those with a C/C++/Java background.

Ruby removes unnecessary cruft: (){};
<ul>
	<li>Parenthesis on method calls are optional; use print "hi".</li>
	<li>Semicolons aren't needed after each line (crazy, I know).</li>
	<li>Use "if then else end" rather than braces.</li>
	<li>Parens aren't needed around the conditions in if-then statements.</li>
	<li>Methods automatically return the last line (call return explicitly if needed)</li>
</ul>
Ruby scraps the annoying, ubiquitous punctuation that distracts from the program logic. Why put parens ((around),(everything))? Again, if you want parens, put ‘em in there. But you'll take off the training wheels soon enough.

The line noise (er, "punctuation") we use in C and Java is for the compiler's benefit, not ours. Be warned: after weeks with Ruby, other languages become a bit painful to read.
<pre>def greet(name)              # simple method
   "Hello, " + name          # returned automatically
end

greet "world"                # ==&gt; "Hello, world"</pre>
<strong>Those Funny Ruby Variables</strong>
<ul>
	<li><code>x = 3</code> is a local variable for a method or block (gone when the method is done)</li>
	<li><code>@x = 3</code> is a instance variable owned by each object (it sticks around)</li>
	<li><code>@@x = 3</code> is a class variable shared by all objects (it sticks around, too).</li>
	<li><code>:hello</code> is a symbol, like a constant string. Useful for indexing hashes. Speaking of which…</li>
	<li><code>dictionary = { :cat =&gt; "Goes meow", :dog =&gt; "Barks loud."}</code> is a hash of key/value pairs. Access elements with<code>dictionary[:cat]</code>. &gt; when key is a symbol, after ruby 1.9 <code>dictionary = { "cat" =&gt; "Goes meow", dog: "Barks loud."}</code></li>
</ul>
<strong>Those Funny Ruby Assignments</strong>

Ruby has the <code>||</code> operator which is a bit funky. When put in a chain
<div>
<pre>  x = a || b || c || "default"</pre>
</div>
it means "test each value and return the first that's not false." <strong>So if a is false, it tries b. If b is false, it tries c. Otherwise, it returns the string "default".</strong>

If you write <code>x = x || "default"</code> it means "set x to itself (if it has a value), otherwise use the default." An easier way to write this is
<div>
<pre>  x ||= "default"</pre>
</div>
which means the same: set x to the default value unless it has some other value. You'll see this a lot in Ruby programs.

<strong>Those Funny Ruby Blocks</strong>

Ruby has "blocks", which are like anonymous functions passed to a loop or another function. These blocks can specify a parameter using<code>|param|</code> and then take actions, call functions of their own, and so on. Blocks are useful when applying some function to each element of an array. It helps to think of them as a type of anonymous function that can, but doesn't have to, take a parameter.
<pre>3.times do |i|
   print i*i
end</pre>
In this example, the numbers <code>0</code>,<code>1</code> and <code>2</code> are passed to a block (do… end) that takes a single parameter (i) and prints i squared. The output would be <code>0</code>, followed by <code>1</code> followed by <code>4</code> (and looks like "014″ since we didn't include spaces). Blocks are common in Ruby but take some getting used to, so be forewarned.

These are the Ruby lessons that were tricky when starting out. Try <a href="http://mislav.uniqpath.com/poignant-guide/">Why's Poignant Guide To Ruby</a> for more info ("Why" is the name of the author… it confused me too).
<h3><a name="understanding-rails-isms" href="https://github.com/jhjguxin/project-manage/blob/master/rails/wiki/starting-ruby-on-rails-what-i-wish-i-knew.en.markdown#understanding-rails-isms"></a>Understanding Rails-isms</h3>
Rails has its own peculiarities. "Trust us, it's good for you." say the programmers. It's true – the features/quirks make Rails stand out, but they're confusing until they click. Remember:
<ul>
	<li><strong>Class and table names are important</strong>. Rails has certain naming conventions; it expects objects from the class Person to be saved to a database table named people. Yes, Rails has <strong>a pluralization engine</strong> to figure out what object maps to what table (I kid you not). This magic is great, but scary at first when you're not sure how classes and tables are getting linked together.</li>
	<li>Many methods take an "options" hash as a parameter, rather than having dozens of individual parameters. When you see
<div>
<pre>link_to "View Post", :action =&gt; 'show', :controller =&gt; 'article', :id =&gt; @article</pre>
</div></li>
</ul>
The call is really doing this:
<div>
<pre>  link_to("View Post", {:action =&gt; 'show', :controller =&gt; 'article', :id =&gt; @article})</pre>
</div>
There are only two parameters: the name ("View Post") and a hash with 3 key/value pairs. Ruby lets us remove the extra parens and braces, leaving the stripped-down function call above.
<h3><a name="understanding-the-model-view-controller-pattern" href="https://github.com/jhjguxin/project-manage/blob/master/rails/wiki/starting-ruby-on-rails-what-i-wish-i-knew.en.markdown#understanding-the-model-view-controller-pattern"></a>Understanding The Model-View-Controller Pattern</h3>
Rails is built around the <a href="http://betterexplained.com/articles/intermediate-rails-understanding-models-views-and-controllers/">model-view-controller</a> pattern. It's a <strong>simple concept</strong>: <strong>separate the data, logic, and display layers of your program</strong>. This lets you split functionality cleanly, just like having separateHTML, CSS and Javascript files prevents your code from mushing together. Here's the MVC breakdown:
<ul>
	<li><strong>Models</strong> are classes that talk to the databse. You find, create and save models, so you don't (usually) have to write SQL. Rails has a class to handle the magic of saving to a database when a model is updated.</li>
	<li><strong>Controllers</strong> take user input (like a URL) and decide what to do (show a page, order an item, post a comment). They may initially have business logic, like finding the right models or changing data. As your rails ninjitsu improves, constantly refactor and move business logic into the model (<a href="http://weblog.jamisbuck.org/2006/10/18/skinny-controller-fat-model">fat model, skinny controller</a>). Ideally, controllers just take inputs, call model methods, and pass outputs to the view (including error messages).</li>
	<li><strong>Views</strong> display the output, usually HTML. They use ERB and this part of Rails is like PHP - you useHTML templates with some Ruby variables thrown in. Rails also makes it easy to create views asXML (for web services/RSS feeds) or JSON (for AJAX calls).</li>
</ul>
The MVC pattern is key to building a readable, maintainable and easily-updateable web app.
<h3><a name="understanding-rails-directory-structure" href="https://github.com/jhjguxin/project-manage/blob/master/rails/wiki/starting-ruby-on-rails-what-i-wish-i-knew.en.markdown#understanding-rails-directory-structure"></a>Understanding Rails' Directory Structure</h3>
When you create your first rails app, the directories are laid out for you. The structure is well-organized: Models are in <code>app/models</code>, controllers in <code>app/controllers</code>, and views in <code>app/my_local_views</code> (just kidding).

The naming conventions are important – it lets rails applications "find their parts" easily, without additional configuration. Also, it's very easy for another programmer to understand and learn from any rails app. I can take a look at Typo, the rails blogging software, and have a good idea of how it works in minutes. Consistency creates comprehension.
<h3><a name="understanding-rails-scaffolding" href="https://github.com/jhjguxin/project-manage/blob/master/rails/wiki/starting-ruby-on-rails-what-i-wish-i-knew.en.markdown#understanding-rails-scaffolding"></a>Understanding Rails' Scaffolding</h3>
<strong>Scaffolding</strong> gives you default controller actions (URLs to visit) and a view (forms to fill out) to interact with your data — you don't need to build an interface yourself. You do need to define the Model and create a database table.

Think of scaffolds as the "default" interface you can use to interact with your app – you'll slowly override parts of the default as your app is built. You specify scaffolds in the controller with a single line:

and it adds default actions and views for showing, editing, and creating your "Person" object. Rails forms take some getting used to, so scaffolding helps a lot in the initial stages.
<h3><a name="more-tips-and-tricks" href="https://github.com/jhjguxin/project-manage/blob/master/rails/wiki/starting-ruby-on-rails-what-i-wish-i-knew.en.markdown#more-tips-and-tricks"></a>More Tips and Tricks</h3>
I originally planned on a list of tips &amp; tricks I found helpful when learning rails. It quickly struck me that Ruby on Rails actually requires a lot of background knowledge, and despite (or because of) its "magic", it can still be confusing. I'll get into my favorite tricks in an upcoming article.

As you dive further into web development, these guides may be helpful:
<ul>
	<li><a href="http://betterexplained.com/articles/how-to-debug-web-applications-with-firefox/">How To Debug Web Applications With Firefox</a></li>
	<li><a href="http://betterexplained.com/articles/how-to-optimize-your-site-with-http-caching/">How To Optimize Your Site With HTTP Caching</a></li>
	<li><a href="http://betterexplained.com/articles/how-to-optimize-your-site-with-gzip-compression/">How To Optimize Your Site With GZIP Compression</a></li>
	<li><a href="http://betterexplained.com/articles/speed-up-your-javascript-load-time/">Speed Up Your Javascript Load Time</a></li>
	<li><a href="http://betterexplained.com/articles/the-quick-guide-to-guids/">The Quick Guide to GUIDs</a></li>
</ul>
Source : <a href="http://betterexplained.com/articles/starting-ruby-on-rails-what-i-wish-i-knew/">http://betterexplained.com/articles/starting-ruby-on-rails-what-i-wish-i-knew/</a>
