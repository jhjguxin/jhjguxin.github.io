---
layout: post
title: "ruby-style-guide.en.md"
date: 2012-03-30 12:56
comments: true
categories: [ruby]
tags: []
---
## ruby-style-guide.en.md
<h1>Prelude</h1>
<blockquote>Style is what separates the good from the great. 
-- Bozhidar Batsov</blockquote>
One thing has always bothered me as Ruby developer - Python developers have a great programming style reference (<a href="http://www.python.org/dev/peps/pep-0008/">PEP-8</a>) and we never got an official guide, documenting Ruby coding style and best practices. And I do believe that style matters. I also believe that such fine fellows, like us Ruby developers, should be quite capable to produce this coveted document.

This guide started its life as our internal company Ruby coding guidelines (written by yours truly). At some point I decided that the work I was doing might be interesting to members of the Ruby community in general and that the world had little need for another internal company guideline. But the world could certainly benefit from a community-driven and community-sanctioned set of practices, idioms and style prescriptions for Ruby programming.

Since the inception of the guide I've received a lot of feedback from members of the exceptional Ruby community around the world. Thanks for all the suggestions and the support! Together we can make a resource beneficial to each and every Ruby developer out there.

By the way, if you're into Rails you might want to check out the complementary <a href="https://github.com/bbatsov/rails-style-guide">Ruby on Rails 3 Style Guide</a>.
<h1>The Ruby Style Guide</h1>
This Ruby style guide recommends best practices so that real-world Ruby programmers can write code that can be maintained by other real-world Ruby programmers. A style guide that reflects real-world usage gets used, and a style guide that holds to an ideal that has been rejected by the people it is supposed to help risks not getting used at all – no matter how good it is.

The guide is separated into several sections of related rules. I've tried to add the rationale behind the rules (if it's omitted I've assumed that is pretty obvious).

I didn't come up with all the rules out of nowhere - they are mostly based on my extensive career as a professional software engineer, feedback and suggestions from members of the Ruby community and various highly regarded Ruby programming resources, such as<a href="http://pragprog.com/book/ruby3/programming-ruby-1-9">"Programming Ruby 1.9"</a> and <a href="http://www.amazon.com/Ruby-Programming-Language-David-Flanagan/dp/0596516177">"The Ruby Programming Language"</a>.

The guide is still a work in progress - some rules are lacking examples, some rules don't have examples that illustrate them clearly enough. In due time these issues will be addressed - just keep them in mind for now.

You can generate a PDF or an HTML copy of this guide using <a href="https://github.com/TechnoGate/transmuter">Transmuter</a>.
<h2>Source Code Layout</h2>
<blockquote>Nearly everybody is convinced that every style but their own is ugly and unreadable. Leave out the "but their own" and they're probably right... 
-- Jerry Coffin (on indentation)</blockquote>
<ul>
	<li>Use <code>UTF-8</code> as the source file encoding.</li>
	<li>Use two <strong>spaces</strong> per indentation level.
<div>
<pre># good
def some_method
  do_something
end

# bad - four spaces
def some_method
    do_something
end</pre>
</div></li>
	<li>Use Unix-style line endings. (*BSD/Solaris/Linux/OSX users are covered by default, Windows users have to be extra careful.)
<ul>
	<li>If you're using Git you might want to add the following configuration setting to protect your project from Windows line endings creeping in:

<code>$ git config --global core.autocrlf true</code></li>
</ul>
</li>
	<li>Use spaces around operators, after commas, colons and semicolons, around <code>{</code> and before <code>}</code>. Whitespace might be (mostly) irrelevant to the Ruby interpreter, but its proper use is the key to writing easily readable code.
<div>
<pre>sum = 1 + 2
a, b = 1, 2
1 &gt; 2 ? true : false; puts 'Hi'
[1, 2, 3].each { |e| puts e }</pre>
</div>
The only exception is when using the exponent operator:
<div>
<pre># bad
e = M * c ** 2

# good
e = M * c**2</pre>
</div></li>
	<li>No spaces after <code>(</code>, <code>[</code> or before <code>]</code>, <code>)</code>.
<div>
<pre>some(arg).other
[1, 2, 3].length</pre>
</div></li>
	<li>Indent <code>when</code> as deep as <code>case</code>. I know that many would disagree with this one, but it's the style established in both the "The Ruby Programming Language" and "Programming Ruby".
<div>
<pre>case
when song.name == 'Misty'
  puts 'Not again!'
when song.duration &gt; 120
  puts 'Too long!'
when Time.now.hour &gt; 21
  puts "It's too late"
else
  song.play
end

kind = case year
       when 1850..1889 then 'Blues'
       when 1890..1909 then 'Ragtime'
       when 1910..1929 then 'New Orleans Jazz'
       when 1930..1939 then 'Swing'
       when 1940..1950 then 'Bebop'
       else 'Jazz'
       end</pre>
</div></li>
	<li>Use empty lines between <code>def</code>s and to break up a method into logical paragraphs.
<div>
<pre>def some_method
  data = initialize(options)

  data.manipulate!

  data.result
end

def some_method
  result
end</pre>
</div></li>
	<li>Align the parameters of a method call if they span over multiple lines.
<div>
<pre># starting point (line is too long)
def send_mail(source)
  Mailer.deliver(to: 'bob@example.com', from: 'us@example.com', subject: 'Important message', body: source.text)
end

# bad (normal indent)
def send_mail(source)
  Mailer.deliver(
    to: 'bob@example.com',
    from: 'us@example.com',
    subject: 'Important message',
    body: source.text)
end

# bad (double indent)
def send_mail(source)
  Mailer.deliver(
      to: 'bob@example.com',
      from: 'us@example.com',
      subject: 'Important message',
      body: source.text)
end

# good
def send_mail(source)
  Mailer.deliver(to: 'bob@example.com',
                 from: 'us@example.com',
                 subject: 'Important message',
                 body: source.text)
end</pre>
</div></li>
	<li>Use RDoc and its conventions for API documentation. Don't put an empty line between the comment block and the <code>def</code>.</li>
	<li>Keep lines fewer than 80 characters.</li>
	<li>Avoid trailing whitespace.</li>
</ul>
<h2>Syntax</h2>
<ul>
	<li>Use <code>def</code> with parentheses when there are arguments. Omit the parentheses when the method doesn't accept any arguments.
<div>
<pre> def some_method
   # body omitted
 end

 def some_method_with_arguments(arg1, arg2)
   # body omitted
 end</pre>
</div></li>
	<li>Never use <code>for</code>, unless you know exactly why. Most of the time iterators should be used instead. <code>for</code> is implemented in terms of<code>each</code> (so you're adding a level of indirection), but with a twist - <code>for</code> doesn't introduce a new scope (unlike <code>each</code>) and variables defined in its block will be visible outside it.
<div>
<pre>arr = [1, 2, 3]

# bad
for elem in arr do
  puts elem
end

# good
arr.each { |elem| puts elem }</pre>
</div></li>
	<li>Never use <code>then</code> for multi-line <code>if/unless</code>.
<div>
<pre># bad
if some_condition then
  # body omitted
end

# good
if some_condition
  # body omitted
end</pre>
</div></li>
	<li>Favor the ternary operator(<code>?:</code>) over <code>if/then/else/end</code> constructs. It's more common and obviously more concise.
<div>
<pre># bad
result = if some_condition then something else something_else end

# good
result = some_condition ? something : something_else</pre>
</div></li>
	<li>Use one expression per branch in a ternary operator. This also means that ternary operators must not be nested. Prefer <code>if/else</code>constructs in these cases.
<div>
<pre># bad
some_condition ? (nested_condition ? nested_something : nested_something_else) : something_else

# good
if some_condition
  nested_condition ? nested_something : nested_something_else
else
  something_else
end</pre>
</div></li>
	<li>Never use <code>if x: ...</code> - it is removed in Ruby 1.9. Use the ternary operator instead.
<div>
<pre># bad
result = if some_condition: something else something_else end

# good
result = some_condition ? something : something_else</pre>
</div></li>
	<li>Never use <code>if x; ...</code>. Use the ternary operator instead.</li>
	<li>Use <code>when x then ...</code> for one-line cases. The alternative syntax <code>when x: ...</code> is removed in Ruby 1.9.</li>
	<li>Never use <code>when x; ...</code>. See the previous rule.</li>
	<li>Use <code>&amp;&amp;/||</code> for boolean expressions, <code>and/or</code> for control flow. (Rule of thumb: If you have to use outer parentheses, you are using the wrong operators.)
<div>
<pre># boolean expression
if some_condition &amp;&amp; some_other_condition
  do_something
end

# control flow
document.saved? or document.save!</pre>
</div></li>
	<li>Avoid multi-line <code>?:</code> (the ternary operator), use <code>if/unless</code> instead.</li>
	<li>Favor modifier <code>if/unless</code> usage when you have a single-line body. Another good alternative is the usage of control flow <code>and/or</code>.
<div>
<pre># bad
if some_condition
  do_something
end

# good
do_something if some_condition

# another good option
some_condition and do_something</pre>
</div></li>
	<li>Favor <code>unless</code> over <code>if</code> for negative conditions (or control flow <code>or</code>).
<div>
<pre># bad
do_something if !some_condition

# good
do_something unless some_condition

# another good option
some_condition or do_something</pre>
</div></li>
	<li>Never use <code>unless</code> with <code>else</code>. Rewrite these with the positive case first.
<div>
<pre># bad
unless success?
  puts 'failure'
else
  puts 'success'
end

# good
if success?
  puts 'success'
else
  puts 'failure'
end</pre>
</div></li>
	<li>Don't use parentheses around the condition of an <code>if/unless/while</code>, unless the condition contains an assignment (see "Using the return value of <code>=</code>" below).
<div>
<pre># bad
if (x &gt; 10)
  # body omitted
end

# good
if x &gt; 10
  # body omitted
end

# ok
if (x = self.next_value)
  # body omitted
end</pre>
</div></li>
	<li>Omit parentheses around parameters for methods that are part of an internal DSL (e.g. Rake, Rails, RSpec), methods that are with "keyword" status in Ruby (e.g. <code>attr_reader</code>, <code>puts</code>) and attribute access methods. Use parentheses around the arguments of all other method invocations.
<div>
<pre>class Person
  attr_reader :name, :age

  # omitted
end

temperance = Person.new('Temperance', 30)
temperance.name

puts temperance.age

x = Math.sin(y)
array.delete(e)</pre>
</div></li>
	<li>Prefer <code>{...}</code> over <code>do...end</code> for single-line blocks. Avoid using <code>{...}</code> for multi-line blocks (multiline chaining is always ugly). Always use <code>do...end</code> for "control flow" and "method definitions" (e.g. in Rakefiles and certain DSLs). Avoid <code>do...end</code> when chaining.
<div>
<pre>names = ["Bozhidar", "Steve", "Sarah"]

# good
names.each { |name| puts name }

# bad
names.each do |name|
  puts name
end

# good
names.select { |name| name.start_with?("S") }.map { |name| name.upcase }

# bad
names.select do |name|
  name.start_with?("S")
end.map { |name| name.upcase }</pre>
</div>
Some will argue that multiline chaining would look OK with the use of {...}, but they should ask themselves - it this code really readable and can't the blocks contents be extracted into nifty methods.</li>
	<li>Avoid <code>return</code> where not required.
<div>
<pre># bad
def some_method(some_arr)
  return some_arr.size
end

# good
def some_method(some_arr)
  some_arr.size
end</pre>
</div></li>
	<li>Use spaces around the <code>=</code> operator when assigning default values to method parameters:
<div>
<pre># bad
def some_method(arg1=:default, arg2=nil, arg3=[])
  # do something...
end

# good
def some_method(arg1 = :default, arg2 = nil, arg3 = [])
  # do something...
end</pre>
</div>
While several Ruby books suggest the first style, the second is much more prominent in practice (and arguably a bit more readable).</li>
	<li>Avoid line continuation (\) where not required. In practice, avoid using line continuations at all.
<div>
<pre># bad
result = 1 - \
         2

# good (but still ugly as hell)
result = 1 \
         - 2</pre>
</div></li>
	<li>Using the return value of <code>=</code> (an assignment) is ok, but surround the assignment with parenthesis.
<div>
<pre># good - shows intented use of assignment
if (v = array.grep(/foo/)) ...

# bad
if v = array.grep(/foo/) ...

# also good - shows intended use of assignment and has correct precedence.
if (v = self.next_value) == "hello" ...</pre>
</div></li>
	<li>Use <code>||=</code> freely to initialize variables.
<div>
<pre># set name to Bozhidar, only if it's nil or false
name ||= 'Bozhidar'</pre>
</div></li>
	<li>Don't use <code>||=</code> to initialize boolean variables. (Consider what would happen if the current value happened to be <code>false</code>.)
<div>
<pre># bad - would set enabled to true even if it was false
enabled ||= true

# good
enabled = true if enabled.nil?</pre>
</div></li>
	<li>Avoid using Perl-style special variables (like <code>$0-9</code>, <code>$</code>`, etc. ). They are quite cryptic and their use in anything but one-liner scripts is discouraged.</li>
	<li>Never put a space between a method name and the opening parenthesis.
<div>
<pre># bad
f (3 + 2) + 1

# good
f(3 + 2) + 1</pre>
</div></li>
	<li>If the first argument to a method begins with an open parenthesis, always use parentheses in the method invocation. For example, write <code>f((3 + 2) + 1)</code>.</li>
	<li>Always run the Ruby interpreter with the <code>-w</code> option so it will warn you if you forget either of the rules above!</li>
	<li>When the keys of your hash are symbols use the Ruby 1.9 hash literal syntax.
<div>
<pre># bad
hash = { :one =&gt; 1, :two =&gt; 2 }

# good
hash = { one: 1, two: 2 }</pre>
</div></li>
	<li>Use the new lambda literal syntax.
<div>
<pre># bad
lambda = lambda { |a, b| a + b }
lambda.call(1, 2)

# good
lambda = -&gt;(a, b) { a + b }
lambda.(1, 2)</pre>
</div></li>
	<li>Use <code>_</code> for unused block parameters.
<div>
<pre># bad
result = hash.map { |k, v| v + 1 }

# good
result = hash.map { |_, v| v + 1 }</pre>
</div></li>
</ul>
<h2>Naming</h2>
<blockquote>The only real difficulties in programming are cache invalidation and naming things. 
-- Phil Karlton</blockquote>
<ul>
	<li>Use <code>snake_case</code> for methods and variables.</li>
	<li>Use <code>CamelCase</code> for classes and modules. (Keep acronyms like HTTP, RFC, XML uppercase.)</li>
	<li>Use <code>SCREAMING_SNAKE_CASE</code> for other constants.</li>
	<li>The names of predicate methods (methods that return a boolean value) should end in a question mark. (i.e. <code>Array#empty?</code>).</li>
	<li>The names of potentially "dangerous" methods (i.e. methods that modify <code>self</code> or the arguments, <code>exit!</code>, etc.) should end with an exclamation mark.</li>
	<li>When using <code>reduce</code> with short blocks, name the arguments <code>|a, e|</code> (accumulator, element).</li>
	<li>When defining binary operators, name the argument <code>other</code>.
<div>
<pre>def +(other)
  # body omitted
end</pre>
</div></li>
	<li>Prefer <code>map</code> over <code>collect</code>, <code>find</code> over <code>detect</code>, <code>select</code> over <code>find_all</code>, <code>reduce</code> over <code>inject</code> and <code>size</code> over <code>length</code>. This is not a hard requirement; if the use of the alias enhances readability, it's ok to use it. The rhyming methods are inherited from Smalltalk and are not common in other programming languages. The reason the use of <code>select</code> is encouraged over <code>find_all</code> is that it goes together nicely with <code>reject</code> and its name is pretty self-explanatory.</li>
</ul>
<h2>Comments</h2>
<blockquote>Good code is its own best documentation. As you're about to add a comment, ask yourself, "How can I improve the code so that this comment isn't needed?" Improve the code and then document it to make it even clearer. 
-- Steve McConnell</blockquote>
<ul>
	<li>Write self-documenting code and ignore the rest of this section. Seriously!</li>
	<li>Comments longer than a word are capitalized and use punctuation. Use <a href="http://en.wikipedia.org/wiki/Sentence_spacing">one space</a> after periods.</li>
	<li>Avoid superfluous comments.
<div>
<pre># bad
counter += 1 # increments counter by one</pre>
</div></li>
	<li>Keep existing comments up-to-date. No comment is better than an outdated comment.</li>
	<li>Avoid writing comments to explain bad code. Refactor the code to make it self-explanatory. (Do or do not - there is no try.)</li>
</ul>
<h2>Annotations</h2>
<ul>
	<li>Annotations should usually be written on the line immediately above the relevant code.</li>
	<li>The annotation keyword is followed by a colon and a space, then a note describing the problem.</li>
	<li>If multiple lines are required to describe the problem, subsequent lines should be indented two spaces after the <code>#</code>.
<div>
<pre>def bar
  # FIXME: This has crashed occasionally since v3.2.1. It may
  #   be related to the BarBazUtil upgrade.
  baz(:quux)
end</pre>
</div></li>
	<li>In cases where the problem is so obvious that any documentation would be redundant, annotations may be left at the end of the offending line with no note. This usage should be the exception and not the rule.
<div>
<pre>def bar
  sleep 100 # OPTIMIZE
end</pre>
</div></li>
	<li>Use <code>TODO</code> to note missing features or functionality that should be added at a later date.</li>
	<li>Use <code>FIXME</code> to note broken code that needs to be fixed.</li>
	<li>Use <code>OPTIMIZE</code> to note slow or inefficient code that may cause performance problems.</li>
	<li>Use <code>HACK</code> to note code smells where questionable coding practices were used and should be refactored away.</li>
	<li>Use <code>REVIEW</code> to note anything that should be looked at to confirm it is working as intended. For example:<code>REVIEW: Are we sure this is how the client does X currently?</code></li>
	<li>Use other custom annotation keywords if it feels appropriate, but be sure to document them in your project's <code>README</code> or similar.</li>
</ul>
<h2>Classes</h2>
<ul>
	<li>When designing class hierarchies make sure that they conform to the <a href="http://en.wikipedia.org/wiki/Liskov_substitution_principle">Liskov Substitution Principle</a>.</li>
	<li>Try to make your classes as <a href="http://en.wikipedia.org/wiki/SOLID_(object-oriented_design)">SOLID</a> as possible.</li>
	<li>Always supply a proper <code>to_s</code> method for classes that represent domain objects.
<div>
<pre>class Person
  attr_reader :first_name, :last_name

  def initialize(first_name, last_name)
    @first_name = first_name
    @last_name = last_name
  end

  def to_s
    "#@first_name #@last_name"
  end
end</pre>
</div></li>
	<li>Use the <code>attr</code> family of functions to define trivial accessors or mutators.
<div>
<pre># bad
class Person
  def initialize(first_name, last_name)
    @first_name = first_name
    @last_name = last_name
  end

  def first_name
    @first_name
  end

  def last_name
    @last_name
  end
end

# good
class Person
  attr_reader :first_name, :last_name

  def initialize(first_name, last_name)
    @first_name = first_name
    @last_name = last_name
  end
end</pre>
</div></li>
	<li>Consider adding factory methods to provide additional sensible ways to create instances of a particular class.
<div>
<pre>class Person
  def self.create(options_hash)
    # body omitted
  end
end</pre>
</div></li>
	<li>Prefer <a href="http://en.wikipedia.org/wiki/Duck_typing">duck-typing</a> over inheritance.
<div>
<pre># bad
class Animal
  # abstract method
  def speak
  end
end

# extend superclass
class Duck &lt; Animal
  def speak
    puts 'Quack! Quack'
  end
end

# extend superclass
class Dog &lt; Animal
  def speak
    puts 'Bau! Bau!'
  end
end

# good
class Duck
  def speak
    puts 'Quack! Quack'
  end
end

class Dog
  def speak
    puts 'Bau! Bau!'
  end
end</pre>
</div></li>
	<li>Avoid the usage of class (<code>@@</code>) variables due to their "nasty" behavior in inheritance.
<div>
<pre>class Parent
  @@class_var = 'parent'

  def self.print_class_var
    puts @@class_var
  end
end

class Child &lt; Parent
  @@class_var = 'child'
end

Parent.print_class_var # =&gt; will print "child"</pre>
</div>
As you can see all the classes in a class hierarchy actually share one class variable. Class instance variables should usually be preferred over class variables.</li>
	<li>Assign proper visibility levels to methods (<code>private</code>, <code>protected</code>) in accordance with their intended usage. Don't go off leaving everything <code>public</code> (which is the default). After all we're coding in <em>Ruby</em> now, not in <em>Python</em>.</li>
	<li>Indent the <code>public</code>, <code>protected</code>, and <code>private</code> methods as much the method definitions they apply to. Leave one blank line above them.
<div>
<pre>class SomeClass
  def public_method
    # ...
  end

  private
  def private_method
    # ...
  end
end</pre>
</div></li>
	<li>Use <code>def self.method</code> to define singleton methods. This makes the methods more resistant to refactoring changes.
<div>
<pre>class TestClass
  # bad
  def TestClass.some_method
    # body omitted
  end

  # good
  def self.some_other_method
    # body omitted
  end

  # Also possible and convenient when you
  # have to define many singleton methods.
  class &lt;&lt; self
    def first_method
      # body omitted
    end

    def second_method_etc
      # body omitted
    end
  end
end</pre>
</div></li>
</ul>
<h2>Exceptions</h2>
<ul>
	<li>Don't suppress exceptions.
<div>
<pre>begin
  # an exception occurs here
rescue SomeError
  # the rescue clause does absolutely nothing
end</pre>
</div></li>
	<li>Don't use exceptions for flow of control.
<div>
<pre># bad
begin
  n / d
rescue ZeroDivisionError
  puts "Cannot divide by 0!"
end

# good
if n.zero?
  puts "Cannot divide by 0!"
else
  n / d</pre>
</div></li>
	<li>Avoid rescuing the <code>Exception</code> class.
<div>
<pre># bad 
begin
  # an exception occurs here
rescue
  # exception handling
end

# still bad
begin
  # an exception occurs here
rescue Exception
  # exception handling
end</pre>
</div></li>
	<li>Put more specific exceptions higher up the rescue chain, otherwise they'll never be rescued from.
<div>
<pre># bad
begin
  # some code
rescue Exception =&gt; e
  # some handling
rescue StandardError =&gt; e
  # some handling
end

# good
begin
  # some code
rescue StandardError =&gt; e
  # some handling
rescue Exception =&gt; e
  # some handling
end</pre>
</div></li>
	<li>Release external resources obtained by your program in an ensure block.
<div>
<pre>f = File.open("testfile")
begin
  # .. process
rescue
  # .. handle error
ensure
  f.close unless f.nil?
end</pre>
</div></li>
	<li>Favor the use of exceptions for the standard library over introducing new exception classes.</li>
</ul>
<h2>Collections</h2>
<ul>
	<li>Prefer <code>%w</code> to the literal array syntax when you need an array of strings.
<div>
<pre># bad
STATES = ['draft', 'open', 'closed']

# good
STATES = %w(draft open closed)</pre>
</div></li>
	<li>Avoid the creation of huge gaps in arrays.
<div>
<pre>arr = []
arr[100] = 1 # now you have an array with lots of nils</pre>
</div></li>
	<li>Use <code>Set</code> instead of <code>Array</code> when dealing with unique elements. <code>Set</code> implements a collection of unordered values with no duplicates. This is a hybrid of <code>Array</code>'s intuitive inter-operation facilities and <code>Hash</code>'s fast lookup.</li>
	<li>Use symbols instead of strings as hash keys.
<div>
<pre># bad
hash = { 'one' =&gt; 1, 'two' =&gt; 2, 'three' =&gt; 3 }

# good
hash = { one: 1, two: 2, three: 3 }</pre>
</div></li>
	<li>Avoid the use of mutable object as hash keys.</li>
	<li>Use the new 1.9 literal hash syntax in preference to the hashrocket syntax.
<div>
<pre># bad
hash = { :one =&gt; 1, :two =&gt; 2, :three =&gt; 3 }

# good
hash = { one: 1, two: 2, three: 3 }</pre>
</div></li>
	<li>Rely on the fact that hashes in 1.9 are ordered.</li>
	<li>Never modify a collection while traversing it.</li>
</ul>
<h2>Strings</h2>
<ul>
	<li>Prefer string interpolation instead of string concatenation:
<div>
<pre># bad
email_with_name = user.name + ' &lt;' + user.email + '&gt;'

# good
email_with_name = "#{user.name} &lt;#{user.email}&gt;"</pre>
</div></li>
	<li>Prefer single-quoted strings when you don't need string interpolation or special symbols such as <code>\t</code>, <code>\n</code>, <code>'</code>, etc.
<div>
<pre># bad
name = "Bozhidar"

# good
name = 'Bozhidar'</pre>
</div></li>
	<li>Don't use <code>{}</code> around instance variables being interpolated into a string.
<div>
<pre>class Person
  attr_reader :first_name, :last_name

  def initialize(first_name, last_name)
    @first_name = first_name
    @last_name = last_name
  end

  # bad
  def to_s
    "#{@first_name} #{@last_name}"
  end

  # good
  def to_s
    "#@first_name #@last_name"
  end
end</pre>
</div></li>
	<li>Avoid using <code>String#+</code> when you need to construct large data chunks. Instead, use <code>String#&lt;&lt;</code>. Concatenation mutates the string instance in-place and is always faster than <code>String#+</code>, which creates a bunch of new string objects.
<div>
<pre># good and also fast
html = ''
html &lt;&lt; '&lt;h1&gt;Page title&lt;/h1&gt;'

paragraphs.each do |paragraph|
  html &lt;&lt; "&lt;p&gt;#{paragraph}&lt;/p&gt;"
end</pre>
</div></li>
</ul>
<h2>Regular Expressions</h2>
<ul>
	<li>Don't use regular expressions if you just need plain text search in string: <code>string['text']</code></li>
	<li>For simple constructions you can use regexp directly through string index.
<div>
<pre>match = string[/regexp/]             # get content of matched regexp
first_group = string[/text(grp)/, 1] # get content of captured group
string[/text (grp)/, 1] = 'replace'  # string =&gt; 'text replace'</pre>
</div></li>
	<li>Use non capturing groups when you don't use captured result of parenthesis.
<div>
<pre>/(first|second)/   # bad
/(?:first|second)/ # good</pre>
</div></li>
	<li>Avoid using $1-9 as it can be hard to track what they contain. Named groups can be used instead.
<div>
<pre># bad
/(regexp)/ =~ string
...
process $1

# good
/(?&lt;meaningful_var&gt;regexp)/ =~ string
...
process meaningful_var</pre>
</div></li>
	<li>Character classes have only few special characters you should care about: <code>^</code>, <code>-</code>, <code>\</code>, <code>]</code>, so don't escape <code>.</code> or brackets in<code>[]</code>.</li>
	<li>Be careful with <code>^</code> and <code>$</code> as they match start/end of line, not string endings. If you want to match the whole string use: <code>\A</code> and<code>\Z</code>.
<div>
<pre>string = "some injection\nusername"
string[/^username$/]   # matches
string[/\Ausername\Z/] # don't match</pre>
</div></li>
	<li>Use <code>x</code> modifier for complex regexps. This makes them more readable and you can add some useful comments. Just be careful as spaces are ignored.
<div>
<pre>regexp = %r{
  start         # some text
  \s            # white space char
  (group)       # first group
  (?:alt1|alt2) # some alternation
  end
}x</pre>
</div></li>
	<li>For complex replacements <code>sub</code>/<code>gsub</code> can be used with block or hash.</li>
</ul>
<h2>Percent Literals</h2>
<ul>
	<li>Use <code>%w</code> freely.
<div>
<pre>STATES = %w(draft open closed)</pre>
</div></li>
	<li>Use <code>%()</code> for single-line strings which require both interpolation and embedded double-quotes. For multi-line strings, prefer heredocs.
<div>
<pre># bad (no interpolation needed)
%(&lt;div&gt;Some text&lt;/div&gt;)
# should be '&lt;div&gt;Some text&lt;/div&gt;'

# bad (no double-quotes)
%(This is #{quality} style)
# should be "This is #{quality} style"

# bad (multiple lines)
%(&lt;div&gt;\n&lt;span&gt;#{exclamation}&lt;/span&gt;\n&lt;/div&gt;)
# should be a heredoc.

# good (requires interpolation, has quotes, single line)
%(&lt;tr&gt;&lt;td&gt;#{name}&lt;/td&gt;)</pre>
</div></li>
	<li>Use <code>%r</code> only for regular expressions matching <em>more than</em> one '/' character.
<div>
<pre># bad
%r(\s+)

# still bad
%r(^/(.*)$)
# should be /^\/(.*)$/

# good
%r(^/blog/2011/(.*)$)</pre>
</div></li>
	<li>Avoid <code>%q</code>, <code>%Q</code>, <code>%x</code>, <code>%s</code>, and <code>%W</code>.</li>
	<li>Prefer <code>()</code> as delimiters for all <code>%</code> literals.</li>
</ul>
<h2>Metaprogramming</h2>
<ul>
	<li>Do not mess around in core classes when writing libraries. (Do not monkey patch them.)</li>
</ul>
<h2>Misc</h2>
<ul>
	<li>Write <code>ruby -w</code> safe code.</li>
	<li>Avoid hashes as optional parameters. Does the method do too much?</li>
	<li>Avoid methods longer than 10 LOC (lines of code). Ideally, most methods will be shorter than 5 LOC. Empty lines do not contribute to the relevant LOC.</li>
	<li>Avoid parameter lists longer than three or four parameters.</li>
	<li>If you really have to, add "global" methods to Kernel and make them private.</li>
	<li>Use class instance variables instead of global variables.
<div>
<pre>#bad
$foo_bar = 1

#good
class Foo
  class &lt;&lt; self
    attr_accessor :bar
  end
end

Foo.bar = 1</pre>
</div></li>
	<li>Avoid <code>alias</code> when <code>alias_method</code> will do.</li>
	<li>Use <code>OptionParser</code> for parsing complex command line options and <code>ruby -s</code> for trivial command line options.</li>
	<li>Code in a functional way, avoiding mutation when that makes sense.</li>
	<li>Avoid needless metaprogramming.</li>
	<li>Do not mutate arguments unless that is the purpose of the method.</li>
	<li>Avoid more than three levels of block nesting.</li>
	<li>Be consistent. In an ideal world, be consistent with these guidelines.</li>
	<li>Use common sense.</li>
</ul>
<h1>Contributing</h1>
Nothing written in this guide is set in stone. It's my desire to work together with everyone interested in Ruby coding style, so that we could ultimately create a resource that will be beneficial to the entire Ruby community.

Feel free to open tickets or send pull requests with improvements. Thanks in advance for your help!
<h1>Spread the Word</h1>
A community-driven style guide is of little use to a community that doesn't know about its existence. Tweet about the guide, share it with your friends and colleagues. Every comment, suggestion or opinion we get makes the guide just a little bit better. And we want to have the best possible guide, don't we?
