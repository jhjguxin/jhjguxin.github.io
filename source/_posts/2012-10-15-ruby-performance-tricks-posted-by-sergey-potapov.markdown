---
layout: post
title: "Ruby Performance Tricks --Posted by Sergey Potapov"
date: 2012-09-05 08:58
comments: true
categories: [ruby]
tags: [accessor,concatenation,exception,performance,reader,ruby,string,variable,writer]
---
## Ruby Performance Tricks --Posted by Sergey Potapov
<a href="http://greyblake.com/blog/2012/09/02/ruby-perfomance-tricks/">http://greyblake.com/blog/2012/09/02/ruby-perfomance-tricks/</a>

I did some benchmarks to find out which alternatives to write code work faster. I wanna share it with you. All benchmarks are made against ruby 1.9.3p194 MRI.
<h2>Do not use exceptions for a control flow</h2>
The next example is pretty stupid but it shows how exceptions slow against conditional statements.
<pre>require 'benchmark'

class Obj
  def with_condition
    respond_to?(:mythical_method) ? self.mythical_method : nil
  end

  def with_rescue
    self.mythical_method
  rescue NoMethodError
    nil
  end
end

obj = Obj.new
N = 10_000_000

puts RUBY_DESCRIPTION

Benchmark.bm(15, "rescue/condition") do |x|
  rescue_report     = x.report("rescue:")    { N.times { obj.with_rescue  } }
  condition_report  = x.report("condition:") { N.times { obj.with_if      } }
  [rescue_report / condition_report]
end</pre>
MRI 1.9.3:

<code>ruby 1.9.3p194 (2012-04-20 revision 35410) [x86_64-linux]
user system total real
rescue: 111.530000 2.650000 114.180000 (115.837103)
condition: 2.620000 0.010000 2.630000 ( 2.633154)
rescue/condition: 42.568702 265.000000 NaN ( 43.991767)
</code>

MRI 1.8.7 (REE has similar result):
<pre>ruby 1.8.7 (2011-12-28 patchlevel 357) [x86_64-linux]
                        user     system      total        real
rescue:            80.510000   0.940000  81.450000 ( 81.529022)
if:                 3.320000   0.000000   3.320000 (  3.330166)
rescue/condition:  24.250000        inf       -nan ( 24.481970)</pre>
<h2>String concatenation</h2>
Avoid using <code>+=</code> to concatenate strings in favor of <code>&lt;&lt;</code> method. The result is absolutely the same: add a string to the end of an existing one. What is the difference then?

See the example:
<pre>str1 = "first"
str2 = "second"
str1.object_id       # =&gt; 16241320

str1 += str2    # str1 = str1 + str2
str1.object_id  # =&gt; 16241240, id is changed

str1 &lt;&lt; str2 str1.object_id  # =&gt; 16241240, id is the same</pre>
When you use <code>+=</code> ruby creates a temporal object which is result of <code>str1 + str2</code>. Then it overrides <code>str1</code> variable with reference to the new built object. On other hand <code>&lt;&lt;</code> modifies existing one. As a result of using <code>+=</code> you have the next disadvantages:
<ul>
	<li>More calculation to join strings.</li>
	<li>Redundant string object in memory (previous value of <code>str1</code>), which approximates time when <a href="http://en.wikipedia.org/wiki/Garbage_collection_%28computer_science%29">GC</a> will trigger.</li>
</ul>
How <code>+=</code> is slow? Basically it depends on length of strings you have operation with.
<pre>require 'benchmark'

N = 1000
BASIC_LENGTH = 10

5.times do |factor|
  length = BASIC_LENGTH * (10 ** factor)
  puts "_" * 60 + "\nLENGTH: #{length}"

  Benchmark.bm(10, '+= VS &lt;</pre>
Output:
<pre>____________________________________________________________
LENGTH: 10
                 user     system      total        real
+=           0.000000   0.000000   0.000000 (  0.004671)
&lt;&lt;           0.000000   0.000000   0.000000 (  0.000176)
+= VS &lt;&lt;          NaN        NaN        NaN ( 26.508796)
____________________________________________________________
LENGTH: 100
                 user     system      total        real
+=           0.020000   0.000000   0.020000 (  0.022995)
&lt;&lt;           0.000000   0.000000   0.000000 (  0.000226)
+= VS &lt;&lt;          Inf        NaN        NaN (101.845829)
____________________________________________________________
LENGTH: 1000
                 user     system      total        real
+=           0.270000   0.120000   0.390000 (  0.390888)
&lt;&lt;           0.000000   0.000000   0.000000 (  0.001730)
+= VS &lt;&lt;          Inf        Inf        NaN (225.920077)
____________________________________________________________
LENGTH: 10000
                 user     system      total        real
+=           3.660000   1.570000   5.230000 (  5.233861)
&lt;&lt;           0.000000   0.010000   0.010000 (  0.015099)
+= VS &lt;&lt;          Inf 157.000000        NaN (346.629692)
____________________________________________________________
LENGTH: 100000
                 user     system      total        real
+=          31.270000  16.990000  48.260000 ( 48.328511)
&lt;&lt;           0.050000   0.050000   0.100000 (  0.105993)
+= VS &lt;&lt;   625.400000 339.800000        NaN (455.961373)</pre>
<h2>Be careful with calculation within iterators</h2>
Assume you need to write a function to convert an array into a hash where keys and values are same as elements of the array:

&nbsp;
<pre>func([1, 2, 3])  # =&gt; {1 =&gt; 1, 2 =&gt; 2, 3 =&gt; 3}</pre>
The next solution would satisfy the requirements:
<pre>def func(array)
  array.inject({}) { |h, e| h.merge(e =&gt; e) }
end</pre>
And would be extremely slow with big portions of data because it contains nested methods (<code>inject</code> and <code>merge</code>), so it’s <strong>O(n<sup>2</sup>) </strong>algorithm. But it’s obviously that it must be <strong>O(n) </strong>. Consider the next:

&nbsp;
<pre>def func(array)
  array.inject({}) { |h, e| h[e] = e; h }
end</pre>
In this case we do only one iteration over an array without any hard calculation within the iterator.

See the benchmark:
<pre>require 'benchmark'

def n_func(array)
  array.inject({}) { |h, e| h[e] = e; h }
end

def n2_func(array)
  array.inject({}) { |h, e| h.merge(e =&gt; e) }
end

BASE_SIZE = 10

4.times do |factor|
  size   = BASE_SIZE * (10 ** factor)
  params = (0..size).to_a
  puts "_" * 60 + "\nSIZE: #{size}"
  Benchmark.bm(10) do |x|
    x.report("O(n)" ) { n_func(params)  }
    x.report("O(n2)") { n2_func(params) }
  end
end</pre>
Output:
<pre>____________________________________________________________
SIZE: 10
                user     system      total        real
O(n)        0.000000   0.000000   0.000000 (  0.000014)
O(n2)       0.000000   0.000000   0.000000 (  0.000033)
____________________________________________________________
SIZE: 100
                user     system      total        real
O(n)        0.000000   0.000000   0.000000 (  0.000043)
O(n2)       0.000000   0.000000   0.000000 (  0.001070)
____________________________________________________________
SIZE: 1000
                user     system      total        real
O(n)        0.000000   0.000000   0.000000 (  0.000347)
O(n2)       0.130000   0.000000   0.130000 (  0.127638)
____________________________________________________________
SIZE: 10000
                user     system      total        real
O(n)        0.020000   0.000000   0.020000 (  0.019067)
O(n2)      17.850000   0.080000  17.930000 ( 17.983827)</pre>
<pre></pre>
It’s an obvious and trivial example. Just keep in mind to not do hard calculation within iterators if it’s possible.
<h2>Use bang! methods</h2>
In many cases bang methods do the same as there non-bang analogues but without duplication an object. The previous example with <code>merge!</code> would be much faster:
<pre>require 'benchmark'

def merge!(array)
  array.inject({}) { |h, e| h.merge!(e =&gt; e) }
end

def merge(array)
  array.inject({}) { |h, e| h.merge(e =&gt; e) }
end

N = 10_000
array = (0..N).to_a

Benchmark.bm(10) do |x|
  x.report("merge!") { merge!(array) }
  x.report("merge")  { merge(array)  }
end</pre>
Output:
<pre>                 user     system      total        real
merge!       0.010000   0.000000   0.010000 (  0.011370)
merge       17.710000   0.000000  17.710000 ( 17.840856)</pre>
<pre></pre>
&nbsp;
<h2>Use instance variables</h2>
Accessing instance variable directly is about two times faster than accessing them with accessor methods:
<pre>require 'benchmark'

class Metric
  attr_accessor :var

  def initialize(n)
    @n   = n
    @var = 22
  end

  def run
    Benchmark.bm(10) do |x|
      x.report("@var") { @n.times { @var } }
      x.report("var" ) { @n.times { var  } }
      x.report("@var =")     { @n.times {|i| @var = i     } }
      x.report("self.var =") { @n.times {|i| self.var = i } }
    end
  end
end

metric = Metric.new(100_000_000)
metric.run</pre>
Output:
<pre>                 user     system      total        real
@var         6.980000   0.010000   6.990000 (  7.193725)
var         13.040000   0.000000  13.040000 ( 13.131711)
@var =       7.960000   0.000000   7.960000 (  8.242603)
self.var =  14.910000   0.010000  14.920000 ( 15.960125)</pre>
Parallel assignment is slower
<pre>require 'benchmark'

N = 10_000_000

Benchmark.bm(15) do |x|
  x.report('parallel') do
    N.times do
      a, b = 10, 20
    end
  end

  x.report('consequentially') do |x|
    N.times do
      a = 10
      b = 20
    end
  end
end</pre>
Output:
<pre>                      user     system      total        real
parallel          1.900000   0.000000   1.900000 (  1.928063)
consequentially   0.880000   0.000000   0.880000 (  0.879675)</pre>
<pre></pre>
&nbsp;
<h2>Dynamic method defention</h2>
What is the faster way to define method dynamically: <code>class_eval</code> with a code string or using <code>define_method</code>? Which way generated methods work faster?
<pre>require 'benchmark'

class Metric
  N = 1_000_000

  def self.class_eval_with_string
    N.times do |i|
      class_eval(&lt;</pre>
Output:
<pre>                             user     system      total        real
class_eval with string 219.840000   0.720000 220.560000 (221.933074)
define_method           61.280000   0.240000  61.520000 ( 62.070911)
string method            0.110000   0.000000   0.110000 (  0.111433)
dynamic method           0.150000   0.000000   0.150000 (  0.156537)</pre>
So <code>class_eval</code> works slower but it’s preferred since methods generated with <code>class_eval</code>and a string of code work faster.
<h2>Links</h2>
<ul>
	<li><a href="http://www.simonecarletti.com/blog/2010/01/how-slow-are-ruby-exceptions/">How Slow Are Ruby Exceptions</a></li>
	<li><a href="http://www.igvita.com/2008/07/08/6-optimization-tips-for-ruby-mri/">6 Optimization Tips for Ruby MRI</a> (NOTE: <code>Symbol#to_proc</code> was ported to Ruby and it’s not slow anymore)</li>
	<li><a href="http://my.safaribooksonline.com/book/web-development/ruby/9780321540034">“Writing Efficient Ruby Code” by Dr. Stefan Kaes</a></li>
	<li><a href="http://programmingzen.com/2007/02/10/top-10-ruby-on-rails-performance-tips/">Top 10 Ruby on Rails performance tips </a></li>
	<li><a href="http://blog.monitis.com/index.php/2012/02/08/20-ruby-performance-tips/">20 Ruby Performance Tips</a></li>
	<li><a href="http://rob-bell.net/2009/06/a-beginners-guide-to-big-o-notation/">A Beginner’s Guide to Big O Notation</a></li>
</ul>
Danke.
<pre><footer>Posted by Sergey Potapov <time datetime="2012-09-02T23:34:00+03:00" pubdate="" data-updated="true">Sep 2nd, 2012</time>  <a href="http://greyblake.com/blog/categories/accessor/">accessor</a>, <a href="http://greyblake.com/blog/categories/concatenation/">concatenation</a>, <a href="http://greyblake.com/blog/categories/exception/">exception</a>, <a href="http://greyblake.com/blog/categories/performance/">performance</a>, <a href="http://greyblake.com/blog/categories/reader/">reader</a>,<a href="http://greyblake.com/blog/categories/ruby/">ruby</a>, <a href="http://greyblake.com/blog/categories/string/">string</a>, <a href="http://greyblake.com/blog/categories/variable/">variable</a>, <a href="http://greyblake.com/blog/categories/writer/">writer</a></footer></pre>
