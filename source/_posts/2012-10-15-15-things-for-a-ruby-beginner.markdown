---
layout: post
title: "15 Things for a Ruby Beginner"
date: 2012-06-16 22:47
comments: true
categories: [ruby]
tags: [beginner,ruby,thing]
---
## 15 Things for a Ruby Beginner
<em>The following is a post I had recently sent the <a href="https://groups.google.com/group/bangalorerug">Bangalore Ruby User Group</a>. It has been slightly modified to address a larger audience.</em>

There were many Ruby beginners in last week's meetup, and the common question we heard was 'after the very basics, what next?'

The best way to learn Ruby best practices is to pair with an experienced dev; the way I learned was by inheriting a reasonably small, but well-written codebase from an amazing colleague. In the absence of either, here is a checklist of 15 things (since 'N things that you need to know about X' is the in-thing these days!) that I'd recommend a Ruby beginner to consider:
<h3>1. The very basics</h3>
Our very own <a href="http://rubymonk.com/" target="_blank">rubymonk.com</a> has a Ruby primer which was written for exactly this purpose; we open our inbox everyday to gushing feedback from people who've found it to be a great way to learn Ruby. Try it and let us know how it goes!

<a href="http://tryruby.org/" target="_blank">tryruby.org</a> also has a basic introduction to Ruby, and has been around longer. <a href="http://rubykoans.com/" target="_blank">Edgecase's Ruby Koan</a> is an interesting concept, and covers the language both in breadth and depth, and is a very strong recommendation. It should take you anywhere between 5-10 hours to finish all of the Koans. Do try it!

&nbsp;

I have heard good things about <a href="http://ruby.learncodethehardway.org/" target="_blank">Learn Ruby the Hardway</a>, but haven't tried it out myself. Okay, I just skimmed through portions of it and I'm not really happy - LRTH seems to be mostly a line-to-line translation of Python code to Ruby. It uses  'while' loop in places where equivalent Ruby idioms (Enumerables) would have made more sense. Also there is no mention of blocks, metaprogramming and duck-typing, which pretty much is a deal-breaker for me. But to be fair, the target audience for LRTH seem to be non-programmers for whom the concept of loops and objects would be new, and for them it does the job very well.

Wait, have you read Why's Poignant Guide to Ruby? If this is the first time you're hearing about why the lucky stiff, read <a href="http://www.smashingmagazine.com/2010/05/15/why-a-tale-of-a-post-modern-genius/" target="_blank">this amazing piece on _why by the Smashing Magazine</a>. And definitely read The Poignant Guide: <a href="http://mislav.uniqpath.com/poignant-guide/" target="_blank">http://mislav.uniqpath.com/<wbr>poignant-guide/</wbr></a>. It is full of cats, foxes, chunky bacon, cartoons that doesn't always make much sense, space travel and what not. This was one of my first introductions to the Ruby community, and the guide lent the language and the community a fun, quirky and happy aura. You may or may not take away much Ruby knowledge from the guide - I couldn't when I read it for the first time. However you'll definitely understand some of the quirkiness and philosophies that influence the Ruby community. I'm a huge fan of _why, and here is my favourite quote:

&nbsp;
<blockquote>when you don't create things, you become defined by your tastes rather than ability. your tastes only narrow &amp; exclude people. so create.</blockquote>
&nbsp;
<h3>2. The ecosystem - RVM/rbenv, RubyGems, Bundler, Git and Github</h3>
I think all of these tools are mandatory for being a productive Ruby programmer. You'll encounter them soon enough:

- RVM/rbenv: these are tools used to manage multiple Ruby versions on the same machine. I've been using RVM without complaint for quite a while, though there are people who will go up in arms against RVM for various reasons. As a beginner, you should be comfortable with either.

- RubyGems: a gem for anything, a gem for everything. If you are using RVM, it will install RubyGems by default for you. <a href="http://docs.rubygems.org/read/chapter/4" target="_blank">http://docs.rubygems.org/read/chapter/4</a>

- Bundler: You'll learn it easy enough if you are using Rails. But even for non-Rails projects, Bundler is now the de-facto tool to handle gems and dependencies. It is one of those tools that when you see for the first time you would wonder how you ever lived without it.

- Git: You are a git if you don't use git yet. If you are not even using any version control at all, good for you - there aren't bad practices that you need to unlearn. If you are on SVN, or God forbid CVS, jump now.<a href="http://git-scm.com/book/en/Getting-Started-About-Version-Control" target="_blank">http://git-scm.com/book/en/<wbr>Getting-Started-About-Version-<wbr>Control</wbr></wbr></a>

- Github: You have a Github handle, right? 'nuff said.
<h3>3. Editor</h3>
I don't care. Pick one, use it well. If you're on Vim and is on Insert mode all the time, then use Notepad instead. It would be more productive. Learn your editor.

Here is a list of editors/IDEs people generally use for Ruby development:

- Sublime Text
- Textmate
- RubyMine (My favourite, but needs a lot of memory and CPU)
- Vim
- emacs
- Aptana RadRails (recently saw a couple of people using it. don't know how good it is)
- Redcar (I've used it very occassionaly, am yet to see someone using it as a primary editor)

If you are using Sublime Text, install and use its corresponding Ruby package. Ditto for Textmate.

If you are on Vim, using the right set of plugins is a requisite to be productive. There is the popular<a href="https://github.com/carlhuda/janus" target="_blank">https://github.com/carlhuda/janus</a> and Srushti's <a href="https://github.com/srushti/vim-get" target="_blank">https://github.com/srushti/vim-get</a> which I use when I work with Vim. Even if you don't go for these plugin distributions, spend enough time to find the right plugins for Ruby development.

I don't know about the best plugins for emacs, but there are people who use emacs to develop in Ruby. Even Matz uses emacs; search and you shall find.
<h3>4. Ditch 'while', 'for' and array accumulation</h3>
Read this: <a href="http://martinfowler.com/bliki/CollectionClosureMethod.html" target="_blank">http://martinfowler.com/bliki/<wbr>CollectionClosureMethod.html</wbr></a>

An apparent sign of a programmer who does not Ruby well is code that uses 'for' and 'while' loops for iteration and accumulation. I'm hardpressed to remember occasions where I had to use them instead of the Enumerable methods #<em>each, #map, #select, #inject, #reject </em>and #<em>detect.</em> Learn these methods, chew on them, and use it everywhere!

(infinite loops are almost always written using the loop do..end construct though. but how often do you write infinite loops anyway?)
<h3>5. Hash</h3>
At the time when I started writing Ruby, the languages that I had written in for a reasonable period of time before were CA-Clipper, Borland Turbo C and some VB 6.

The first two did not have a hash, associative array or dictionary - whichever you prefer to call it.<strong> </strong>As to VB6, the only thing I can remember is DataGrid and ADODB. Ah, the failed promises of drag and drop programming!

So Hash was a revelation and I started using it anywhere and everywhere. Do you want to build a CRUD app to manage customer info? Forget databases, I'll build a Hash and serialize to and deserialize from a YAML file. There were even more crimes committed using Hash that I dare not mention here. You would have gone through enough exercises that uses Hash when working through RubyMonk or Ruby Koans. But if you haven't, make sure you understand Hashes well enough. Specifically:

- iterating over a hash
- assigning default values for undefined keys in a hash
- Hash#keys and Hash#values for extracting just the keys and values
- In Ruby 1.8 Hashes are un-ordered: ie, you can't rely on the ordering of the hash to be same as the order in which you added elements. In Ruby 1.9, a Hash is sorted on the basis of order of insertion.
<h3>6. JSON and YAML</h3>
These are not Ruby specific concepts, but find great use in the ecosystem. Know them well, they'll come in handy.
<h3>7. Understand Immutability and how Ruby passes object references around</h3>
This has slightly got to do with the above point - all the Enumerable methods are immutable, and it is a good introduction to how functional Ruby veer towards immutability.  Immutability is more of a good programming practice than a Ruby specific idea - it helps you write clean predictable code, leave aside concurrent programming and race conditions. A method that mutates its parameter is a vile creature, don't bring it forth into existence.

If you come from a C programming background, building new objects willy-nilly would be a little hard to digest. So much memory put to waste! I remember reading somewhere that programmers who use high level languages leave a higher carbon footprint because their code is inefficient. I leave you to ponder over it.

For understanding some quirks around Ruby's immutability and interesting effects of how Ruby passes object references around, figure out where Array#clone is used. I remember wasting many a debugger breakpoint during my early days of Ruby because I didn't realize this. Don't let that happen to you! Understand the difference between a shallow clone and a deep clone. Even better, go write your own deep_clone routine! (limit yourselves to objects that can have strings, numbers, arrays and hashes)

Also read: <a href="http://ruby-doc.org/docs/Newcomers/ruby.html#objects" target="_blank">http://ruby-doc.org/docs/Newcomers/ruby.html#objects</a>
<h3>8. Ruby's Object Hierarchy</h3>
&nbsp;
<div>
<pre># All objects are instances of the class Object. 
"a string".is_a? BasicObject         # true

# All classes are instances of the class Class.
String.is_a? Class                   # true

# Class is a subclass of BasicObject.
Class.is_a? BasicObject              # true

# Class is not an instance of BasicObject
Class.instance_of? BasicObject       # false

# BasicObject is an instance and a sub-class of Class
BasicObject.is_a? Class              # true
BasicObject.instance_of? Class       # true</pre>
</div>
&nbsp;

Okay, I lost it. It is pretty crazy: <a href="http://stackoverflow.com/questions/4967556/ruby-craziness-class-vs-object" target="_blank">http://stackoverflow.com/questions/4967556/ruby-craziness-class-vs-object</a>. As a beginner, you wouldn't need to understand the nitty-gritties. I've been programming in Ruby for about three years now, and it still confuses the heck out of me.

For now it is safe to understand that BasicObject is usually the root object of all objects in Ruby. And everything in Ruby is an object. This has a very useful side-effect (try this in IRB):
<div>
<pre>"some random string".methods - Object.methods</pre>
</div>
Also,
<div>
<pre>Array.new.methods - Object.methods</pre>
</div>
&nbsp;

The above commands will show you methods that are specific to just strings and arrays, excluding all methods that are always present in any Ruby object (inherited from Object -like instance_of, is_a? etc.).

<strong>Tip:</strong>You might have noticed that the '-' operator gives you the difference between two arrays. Whenever you need a general purpose method and wonder whether Ruby comes with it, just try some plausible syntax in IRB. You might be surprised at what you find.

Even though Ruby lets you Object Oriented and procedural code, the language leans toward OO. Ruby treats even methods as objects:
<div>
<pre>"some string".method(:length) # gives you an object of the Method class.</pre>
</div>
The method object can be asked to run by invoking the 'call' method on it.

&nbsp;
<h3>9. Creating your own Objects</h3>
Did you notice that the title wasn't 'Creating Classes'. That was one of the most useful advices I've ever received: Always think in terms of objects - not classes. Thinking in terms of Classes can subtly make you evolve your design upfront. Don't. Let your objects guide you in how your class definition should look. As a rough analogy, when building a home, the blueprint is valuable only as a reference for building the actual home. You imagine what your home should look like and draw a blueprint accordingly, not the other way round.

Start with sparse classes, add methods and attributes as your objects demand it. Srushti puts it better: Imagine you're an instance, and think about what you want to do and how you want to do it. You don't want to give up your secrets (encapsulation). You don't ask other people for information so you can do their work for them, you just tell them to do stuff for you (tell, don't ask)

Ruby has a very simple syntax for defining classes and building objects. If you come from a Java/C# background, it'd be the first thing you look for. But even if you are a die-hard procedural ninja, trust me, thinking in terms of objects will help you write better programs, tackle complexity and be a more capable programmer.

So, what are the things that are specific to Ruby that you need to be aware of?

&nbsp;

- Message Passing. "abcd".length is in fact "abcd".send(:length).
- Module vs Classes (hint: they're very similar, but you can't instantiate a Module)
- Mixins (Ruby's answer to multiple inheritance and the greatest thing _before_ sliced bread)
- attr_reader, attr_writer, attr_accessor.
- instance methods and class methods
- instance variables and class variables.

And we all know that you don't use class variables unless you have a very good reason. Class methods aren't that bad, but are usually a smell. Whenever you find yourselves writing a class method, take a step back and make sure it can't be rephrased as an instance method, perhaps in a child object?

There is a lot more to OO, some less specific to Ruby. As you go deep into the rabbit hole, ponder over these blanket statements:

- Primitives (Hash, Array etc.) are evil! Build objects.
- Inheritance is evil! Use Composition.
- Conditions (if..else, switch..case) are evil! Use Polymorphism.
<h3>10. Ruby is interpreted. It is malleable. Use that to your advantage.</h3>
Interpreted programs are almost always slower than native code (which includes JIT). By choosing to use such a language, you are accepting a compromise in the speed/efficiency of your programs. But this gives you a great advantage: the flexibility to change your code at runtime. Though we can't claim 'code is data, data is code' like those hipster LISPers do, there is tremendous power in the dynamism (no reference to type systems) of Ruby. Learn it, use it, change the world!

I had briefly mentioned the 'send' method that is available for every object in Ruby:
<div>
<pre>   "abcd".send(:length)</pre>
</div>
is same as
<div>
<pre>   "abcd".length</pre>
</div>
That means you can do things like this:

&nbsp;
<div>
<pre>puts "Hi, which method do you like to invoke on a string today?"
method_name = gets.strip
puts "a random string".send(method_name)</pre>
</div>
&nbsp;

Did you see that? Unlike fully compiled languages like C/C++, Ruby lets you call arbitrary methods during runtime! (you can pass arguments to the method as parameters to the 'send' method)

Leave aside calling arbitrary methods, running arbitrary code during runtime is a breeze:
<div>
<pre>puts "What code do you want to run today, dear sir?"
arbitrary_code = STDIN.read         # press ctrl+d to stop input
eval(arbitrary_code)</pre>
</div>
Try it, type in some short valid Ruby code and see it in action.

&nbsp;

Now that you know 'eval' exists, forget about it. It is too dangerous to be almost ever used. It is unsafe and unscoped, but there are better things to achieve similar and useful results. The point of this exercise though was to see Ruby's dynamic nature in action. Since Ruby is interpreted, there is no limitation on what can be done during runtime. This can be used to great good as we will see in Metaprogramming.
<h3>11. Metaprogramming</h3>
Metaprogramming in Ruby more or less gives you ways to create/remove/redefine methods at runtime. If you have used Rails, you would have seen that you would write something like
<div>
<pre>class User &lt; ActiveRecord::Base
end</pre>
</div>
and magically, the User class gives you methods like user.name, user.find_by_name, user.find_by_name_and_id. Depending on the fields in the database, Rails defines methods for you to use. This uses Metaprogramming where Rails defines the methods at runtime after consulting the table schema.

(talking about 'magic', usually when someone complain about 'magic' in Ruby code, she is most probably referring to some sort of metaprogramming in the code)

Metaprogramming is one of Ruby's most powerful concepts (anything borrowed from FP is yummy!), but it is open to use and abuse. They say that someone who knows metaprogramming well enough, but not enough to know where not to use it, is a danger to himself and society. The internet is rife with discussions around it and you'll find no shortage of flame wars, opinions and thankfully, documentation.

These are the methods you would want to look up to get a decent overview of metaprogramming in Ruby:

- define_method
- method_missing
- instance_eval
- class_eval

I would also recommend Yehuda Katz's excellent explanation of Metaprogramming by relating it to the context of 'self': <a href="http://yehudakatz.com/2009/11/15/metaprogramming-in-ruby-its-all-about-the-self/" target="_blank">http://yehudakatz.com/2009/11/<wbr>15/metaprogramming-in-ruby-its-all-about-the-self/</wbr></a>

Metaprogramming is a bit advanced, and if you don't understand all or any of it the first time, don't worry. Come back and take a look again later. Rinse and repeat. It is an acquired taste, give it time!
<h3>12. Closures (Blocks, Lambdas et al.)</h3>
Blocks are my favourite. They move mountains. Rather, they let you write beautiful DSLs when coupled with the right dose of metaprogramming. Have you seen factory_girl's syntax? It is an unholy mix of method_missing and 'yield'.
<pre><span>Factory :user, aliases: [:author, :commenter] do first_name "John" last_name "Doe" date_of_birth { 18.years.ago } end</span></pre>
It is not really hard to build a DSL that reads like this, and there is no better resource to learn all of this than <a href="http://rubysource.com/functional-programming-techniques-with-ruby-part-ii/" target="_blank">http://rubysource.com/<wbr>functional-programming-<wbr>techniques-with-ruby-part-ii/</wbr></wbr></a>. The first part of that series looks into the functional and immutable aspects of Ruby, and is also a recommended read:<a href="http://rubysource.com/functional-programming-techniques-with-ruby-part-i/" target="_blank">http://rubysource.com/<wbr>functional-programming-<wbr>techniques-with-ruby-part-i/</wbr></wbr></a>
<h3>13. Styleguides</h3>
Whenever you are in doubt, or the self becomes too much with you, go read the Ruby style guides.

Github's simpler style guide: <a href="https://github.com/styleguide/ruby" target="_blank">https://github.com/styleguide/<wbr>ruby</wbr></a>

The comprehensive one: <a href="https://github.com/bbatsov/ruby-style-guide" target="_blank">https://github.com/bbatsov/<wbr>ruby-style-guide</wbr></a>
<h3>14. Simplicity is virtue</h3>
Knowing what constructs to use where is a matter of knowledge and experience. Every approach has trade-offs in terms of readability, maintainability and efficiency. The battle between these have been the recurring theme in the battles programmers fight in their heads for years. Knowing the the trade-offs will help you make more informed decisions, but it might not always be enough. Some things need to be tried, tested and failed, and that is fine.

But be vary of <a href="http://c2.com/cgi/wiki?PrematureOptimization" target="_blank">Premature Optimization</a>. When you have a choice between clever, short and maybe faster code Vs longer but readable code, go for readability.  Ruby makes it easy to write really bad code that people would fear to touch with a long pole. It also lets you write  beautiful and concise code. When you contemplate between the two, remember the joke about the psychopath who'll inherit your codebase, knows where you live, and pings you from your local network! The choice is yours.
<h3>15. None of this matters</h3>
If you are overwhelmed by this document or any links referenced from here, just ignore it. Remember the<a href="http://norvig.com/21-days.html" target="_blank">10,000 hours rule</a>. Happily go about writing code the way you know best! And write a bit more code. Try to pair with someone who knows things a bit more. Go read some well-written Ruby code from Github. Then come back and see what you've learned.

None of this is rocket science, but it takes time and practice for concepts to sink in, and that is just fine.

<hr />

Have further questions? There are tons of resource on the internet to answer your questions!

Join one of your local Ruby Usergroups. The Ruby community is extremely helpful and accomodating towards newbies. Check this page to locate a usergroup near you: <a href="http://www.rubyinside.com/how-to-find-ruby-user-groups-3067.html">How To Find Ruby User Groups</a>

Participate in the usergroups, ask your questions. Also hop on to Ruby's IRC channel <a href="http://irc.lc/freenode/ruby-lang">#ruby-lang on Freenode</a>. Irrespective of the forum, just make sure that you give enough context about your question to help others understand your problem. If you haven't read ESR's "<a href="http://www.catb.org/~esr/faqs/smart-questions.html" target="_blank">Ask questions the smart way</a>" yet, *this* is the time. Go read it now and get enlightened on the ways of the interwebs!

And remember to have fun! In Matz's own words:
<blockquote> "For me the purpose of life is partly to have joy. Programmers often feel joy when they can concentrate on the creative side of programming, So Ruby is designed to make programmers happy."</blockquote>
Happy hacking!
