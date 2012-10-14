---
layout: post
title: "ruby-style-guide-zh-cn"
date: 2012-03-29 23:35
comments: true
categories: [ruby]
tags: [guide,ruby,style,zh-cn]
---
## ruby-style-guide-zh-cn
<h1>序</h1>
<blockquote>风格可以用来区分从好到卓越。
-- Bozhidar Batsov</blockquote>
有一件事情总是困扰着，作为Ruby程序员的我 - python 开发者都有一个很棒的编程风格参考 (<a href="http://www.python.org/dev/peps/pep-0008/">PEP-8</a>)，然而我们从没有一个官方的（公认）的guide，Ruby代码风格文档和最佳实践。而且我信赖这些风格（的一些约定）。我也相信下面的一些好东西，像我们这样的Ruby开发者，也应该有能力写出这样的梦寐以求的文档。

这份指南诞生于我们公司内部的Ruby编程准则，基于Ruby社区的大多数成员会对我正在做的有兴趣这样的发点，我决定做这样的工作，而且世界上很少需要另一个公司内部的（编程）准则。但是这个世界将会一定有益于社区驱动的以及社区认可的，Ruby习惯和风格实践。

自从这个guide（发表）以来，我收到了很多来自优秀的Ruby社区的世界范围内的成员的回馈。感谢所有的建议和支持！集我们大家之力，我们可以创作出对每一个Ruby开发人员有益的资源。

补充，如果你正在使用rails你可能会希望查阅<a href="https://github.com/bbatsov/rails-style-guide">Ruby on Rails 3 Style Guide</a>.
<h1>Ruby 风格指南</h1>
这个Ruby风格指南推荐（一些）最佳实践使得现实世界中的Ruby程序员可以写出能够被其他真是世界的Ruby程序员维护的代码。一个风格指南反映了真实世界的使用习惯，同时一个风格指南紧紧把握一个观点那就是人们拒绝接受任何有可能无法使用指南的风险，无论它多好。

这个指南被分为几个具有相关的rules的几节。我尝试给rules添加合理的解释（如果它被省略我假设它相当的明显了）。

我并没有列举所有的rules - 它们大多数基于我作为一个专业的软件工程师的广泛生涯，回馈和来自Ruby社区成员的建议以及各种备受推崇的Ruby编程资源，例如<a href="http://pragprog.com/book/ruby3/programming-ruby-1-9">"Programming Ruby 1.9"</a> 和 <a href="http://www.amazon.com/Ruby-Programming-Language-David-Flanagan/dp/0596516177">"The Ruby Programming Language"</a>.

这个指南仍然在工作进程中 - 一些rules缺乏例子，一些rules没有合适的例子来使得它们足够明了。

你可以使用<a href="https://github.com/TechnoGate/transmuter">Transmuter</a>.来生成指南的PDF或者HTML的copy。
<h2>源代码布局</h2>
<blockquote>附近的每个人都深信每一个风格除了他们自己的都是 丑陋的并且难以阅读的。脱离"but their own"那么他们 完全正确... 
-- Jerry Coffin (on indentation缩进)</blockquote>
<ul>
	<li>使用 <code>UTF-8</code> 作为源文件编码。</li>
	<li>每个缩进级别使用两个 <strong>spaces</strong>
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
	<li>使用Unix-风格行结束。(*BSD/Solaris/Linux/OSX 用户被涵盖为默认，Windows 用户必须特别小心.) &gt; \n是换行，英文是LineFeed，ASCII码是0xA。 &gt; \r是回车，英文是Carriage Return ,ASCII码是0xD。 &gt; windows下enter是 \n\r,unix下是\n,mac下是\r
<ul>
	<li>如果你正在使用Git你可能会想要添加下面的配置设置来保护你的项目（避免）Windows蔓延过来的行结束符:<code>$ git config --global core.autecrlf true</code></li>
</ul>
</li>
	<li>使用空格：在操作符旁；逗号，冒号和分号后；在 <code>{</code>旁和在 <code>}</code>之前，大多数空格可能对Ruby解释（代码）无关，但是它的恰当使用是让代码变得易读的关键。
<div>
<pre>sum = 1 + 2
a, b = 1, 2
1 &gt; 2 ? true : false; puts 'Hi'
[1, 2, 3].each { |e| puts e }</pre>
</div>
唯一的例外是当使用指数操作时：
<div>
<pre># bad
e = M * c ** 2

# good
e = M * c**2</pre>
</div></li>
	<li>没有空格 <code>(</code>, <code>[</code>之后或者 <code>]</code>, <code>)</code>之前。
<div>
<pre>some(arg).other
[1, 2, 3].length</pre>
</div></li>
	<li><code>when</code>和<code>case</code> 缩进深度一致。我知道很多人会不同意这点，但是它是"The Ruby Programming Language" 和 "Programming Ruby"中公认的风格。
<div>
<pre>case
when song.name == 'Misty'
  puts 'Not again!'
when song.duraton &gt; 120
  puts 'Too long!'
when Time.now &gt; 21
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
	<li>使用空行在 <code>def</code>s 并且一个方法根据逻辑段来隔开。
<div>
<pre>def some_method
  data = initialize(options)

  data.manipulate!

  data.result
end

def some_methods
  result
end</pre>
</div></li>
	<li>如果一个方法的调用参数分割为多行将它们于<strong>方法名</strong>对齐。
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
	<li>在 API 文档中使用 RDoc和它的公约。不要在注释代码块和<code>def</code>之间加入空行。</li>
	<li>保持每一行少于80字符。</li>
	<li>避免尾随空格。</li>
</ul>
<h2>语法</h2>
<ul>
	<li>使用括号将<code>def</code>的参数括起来。当方法不接收任何参数的时候忽略括号。
<div>
<pre>def some_method
  # body omitted
end

def some_method_with_arguments(arg1, arg2)
  # body omitted
end</pre>
</div></li>
	<li>从来不要使用 <code>for</code>， 除非你知道使用它的准确原因。大多数时候迭代器都可以用来替代for。<code>for</code> is implemented in terms of<code>each</code>#<code>for</code>是<code>each</code>的组实现 (因此你正间接添加了一级)，但是有一个小道道 - <code>for</code>并不包含一个新的scope(不像<code>each</code>)并且在它的块中定义的变量在外面也是可以访问的。
<div>
<pre>arr = [1, 2, 3]

# bad
for elem in arr do 
  puts elem
end

puts elem # =&gt; 3

# good
arr.each { |elem| puts elem }</pre>
</div></li>
	<li>在多行的<code>if/unless</code>中坚决不要使用<code>then</code>.
<div>
<pre># bad
if some_condition then
  # body omitten
end

# good
if some_condition
  # body omitted
end</pre>
</div></li>
	<li>喜欢三元操作运算（<code>?:</code>）超过<code>if/then/else/end</code>结果。 它更加普遍而且明显的更加简洁。
<div>
<pre># bad
result = if some_condition then something else something_else end

# good
result = some_condition ? something : something_else</pre>
</div></li>
	<li>使用一个表达式在三元操作运算的每一个分支下面只使用一个表达式。也就是说三元操作符不要被嵌套。在这样的情形中宁可使用<code>if/else</code>。
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
	<li>使用三元操作运算代替<code>if x: ...</code>。</li>
	<li>在 one-line cases 的时候使用<code>when x then ...</code>。替代的语法<code>when x: xxx</code>已经在Ruby 1.9中移除。</li>
	<li>不要使用<code>when x; ...</code>。查看上面的规则。</li>
	<li>布尔表达式使用<code>&amp;&amp;/||</code>, <code>and/of</code>用于控制流程。（经验Rule:如果你必须使用额外的括号（表达逻辑），那么你正在使用错误的的操作符。）
<div>
<pre># boolean expression
if some_condition &amp;&amp; some_other_condition
  do_something
end

# control flow
document.save? or document.save!</pre>
</div></li>
	<li>避免多行<code>?:</code>(三元操作运算)，使用<code>if/unless</code>替代。</li>
	<li>在单行语句的时候喜爱使用<code>if/unless</code>修饰符。另一个好的选择就是使<code>and/of</code>来做流程控制。
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
	<li>在否定条件下喜欢<code>unless</code>超过<code>if</code>(或者控制流程 <code>or</code>)。
<div>
<pre># bad
do_something if !some_condition

# good
do_something unless some_condition

# another good option
some_condition or do_something</pre>
</div></li>
	<li>不要使用<code>else</code>搭配<code>unless</code>。将其的语义重写为肯定形式。
<div>
<pre># bad
unless sucess?
  puts 'failure'
else
  puts 'sucess'
end

# good
if sucess?
  puts 'sucess'
else
  puts 'failure'
end</pre>
</div></li>
	<li>不要在<code>if/unless/while</code>将条件旁括起来，除非这个条件包含一个参数(参见下面 "使用<code>=</code>返回值")。
<div>
<pre># bad
if (x&gt;10)
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
	<li>DSL(e.g. Rake, Rails, RSpec)里的方法，Ruby“关键字”方法(e.g. <code>attr_reader</code>, <code>puts</code>)以及属性访问方法，所带参数忽略括号。使用括号将在其他方法调用的参数括起来。
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
	<li>在单行代码块的时候宁愿使用<code>{...}</code>而不是<code>do...end</code>。避免在多行代码块使用<code>{...}</code>(多行链式通常变得非常丑陋)。通常使用<code>do...end</code>来做<code>流程控制</code>和<code>方法定义</code>(例如 在Rakefiles和某些DSLs中)。避免在链式调用中使用<code>do...end</code>。
<div>
<pre>names = ["Bozhidar", "Steve", "Sarah"]

#good
names.each { |name| puts name }

#bad
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
有人会争论多行链式看起来和使用<code>{...}</code>一样工作，但是他们问问自己 - 这样的代码真的有可读性码并且为什么代码块中的内容不能被提取到美丽的methods。</li>
	<li>避免在不需要的地方使用<code>return</code>
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
	<li>当分配默认值给方法参数的时候，在<code>=</code>附近使用空格。
<div>
<pre># bad
def some_method(arg1=:default, arg2=nil, arg3=[])
  # do something...
end

# good
def some_method(arg1 = :default, arg2 = nil, arg3 = [])
  # do something...
end</pre>
</div></li>
	<li>避免在不需要的时候使用行连接符(<code>\\</code>)。实际上应该避免行连接符。
<div>
<pre># bad
result = 1 - \
         2

# good (but still ugly as hell)仍然像地狱一样丑陋
result = 1 \
         - 2</pre>
</div></li>
	<li>使用<code>=</code>返回一个表达式的值是很好的，但是需要用括号把赋值运算式括起来。
<div>
<pre># good - show intented use of assignment
if (v = array.grep(/foo/)) ...

# bad
if v = array.grep(/foo/) ...

# also good - show intended use of assignment and has correct precedence.
if (v = self.next_value) == "hello" ...</pre>
</div></li>
	<li>使用<code>||=</code>轻松的初始化变量。
<div>
<pre># set name to Vozhidar, only if it's nil or false
name ||= 'Bozhidar'</pre>
</div></li>
	<li>不要使用<code>||=</code>来初始化布尔变量。（思考一些如果当前值为<code>false</code>的时候会发生什么。）
<div>
<pre># bad - would set enabled to true even if it was false
enable ||= true

# good
enabled = true if enabled.nil?</pre>
</div></li>
	<li>避免使用Perl的指定变量风格（比如，<code>$0-9</code>，<code>$</code>，等等。）。它们相当神秘，不鼓励在单行代码之外使用它们。</li>
	<li>从来不要在方法名和（参数）开括号之间使用空格。
<div>
<pre># bad
f (3+2) + 1

# good
f(3 + 2) +1</pre>
</div></li>
	<li>如果方法的第一个参数以开括号开始，通常使用括号把它们全部括起来。例如<code>f((3 + 2) + 1)</code>。</li>
	<li>通常使用-w 选项运行Ruby解释器，在你忘记上面所诉规则，ruby将会提示你。</li>
	<li>当你的hash字典是symbols的时候，使用Ruby 1.9的字面量语法。
<div>
<pre># bad
hash = { :one =&gt; 1, :two =&gt; 2 }

#good
hash = { one: 1, two: 2 }</pre>
</div></li>
	<li>使用新的 lambda 语法。
<div>
<pre># bad
lambda = lambda { |a, b| a + b }
lambda.call(1, 2)

# good
lambda = -&gt;(a, b) { a + b }
lambda.(1, 2)</pre>
</div></li>
	<li>对不使用的块变量使用<code>_</code>。
<div>
<pre># bad
result = hash.map { |k, v| v + 1}

# good
result = hash.map { |_, v| v + 1 }</pre>
</div></li>
</ul>
<h3>命名</h3>
<blockquote>The only real difficulties in programming are cache invalidation and naming things. 
-- Phil Karlton 程序（运行）中唯一不一样的是无效的缓存和命名的事物（变量）。
-- Phil Karlton</blockquote>
<ul>
	<li>使用<code>snake_case</code>的形式给变量和方法命名。</li>
	<li>Snake case: punctuation is removed and spaces are replaced by single underscores. Normally the letters share the same case (either UPPER_CASE_EMBEDDED_UNDERSCORE or lower_case_embedded_underscore) but the case can be mixed</li>
	<li>使用<code>CamelCase(駝峰式大小寫)</code>的形式给类和模块命名。(保持使用缩略首字母大写的方式如HTTP, RFC, XML)</li>
	<li>使用<code>SCREAMING_SNAKE_CASE</code>给常量命名。</li>
	<li>在表示断言的方法名（方法返回真或者假）的末尾添加一个问号（如Array#empty?）。</li>
	<li>可能会造成潜在“危险”的方法名（如修改self或者在原处修改变量的方法，exit!等）应该在末尾添加一个感叹号。</li>
	<li>当在短的块中使用<code>reduce</code>时，命名参数<code>|a, e|</code> (accumulator, element)。
<div>
<pre>#Combines all elements of enum枚举 by applying a binary operation, specified by a block or a symbol that names a method or operator.
# Sum some numbers
(5..10).reduce(:+)                            #=&gt; 45#reduce
# Same using a block and inject
(5..10).inject {|sum, n| sum + n }            #=&gt; 45 #inject注入
# Multiply some numbers
(5..10).reduce(1, :*)                         #=&gt; 151200
# Same using a block
(5..10).inject(1) {|product, n| product * n } #=&gt; 151200</pre>
</div></li>
	<li>在定义二元操作符方法时，将其的参数取名为other。
<div>
<pre>def +(other)
  # body omitted
end</pre>
</div></li>
	<li><code>map</code>优先于<code>collect</code>，<code>find</code>优先于<code>detect</code>，<code>select</code>优先于<code>find_all</code>，<code>reduce</code>优先于<code>inject</code>，<code>size</code>优先于<code>length</code>。以上的规则并不绝定，如果使用后者能提高代码的可读性，那么尽管使用它们。这些对应的方法名（如collect，detect，inject）继承于SmallTalk语言，它们在其它语言中并不是很通用。鼓励使用select而不是find_all是因为select与reject一同使用时很不错，并且它的名字具有很好的自解释性。</li>
</ul>
<h2>注释</h2>
<blockquote>Good code is its own best documentation. As you're about to add a comment, ask yourself, "How can I improve the code so that this comment isn't needed?" Improve the code and then document it to make it even clearer. 
-- Steve McConnell 好的代码在于它有好的文档。当你打算添加一个注释，问问自己，“我该做的是怎样提高代码质量，那么这个注释是不是不需要了？”提高代码并且给他们添加文档使得它更加简洁。
-- Steve McConnell</blockquote>
<ul>
	<li>写出自解释文档代码，然后忽略不工作的这部分。这不是说着玩。</li>
	<li>注释长于一个单词则以大写开始并使用标点。使用一个空格将注释与符号隔开。Use <a href="http://en.wikipedia.org/wiki/Sentence_spacing">one space</a> after periods.</li>
	<li>避免多余的注释。
<div>
<pre># bad
counter += 1 # increments counter by one</pre>
</div></li>
	<li>随时更新注释，没有注释比过期的注释更好。</li>
	<li>不要为糟糕的代码写注释。重构它们，使它们能够“自解释”。(Do or do not - there is no try.)</li>
</ul>
<h2>注解</h2>
<ul>
	<li>注解应该写在紧接相关代码的上方。</li>
	<li>注解关键字后跟一个冒号和空格，然后是描述问题的记录。</li>
	<li>如果需要多行来描述问题，随后的行需要在<code>#</code>后面缩进两个空格。
<div>
<pre>def bar
  # FIXME: This has crashed occasionally since v3.2.1. It may
  #  be related to the BarBazUtil upgrade.
  baz(:quux)
end</pre>
</div></li>
	<li>如果问题相当明显，那么任何文档就多余了，注解也可以（违规的）在行尾而没有任何备注。这种用法不应当在一般情况下使用，也不应该是一个rule。
<div>
<pre>def bar
  sleep 100 # OPTIMIZE
end</pre>
</div></li>
	<li>使用<code>TODO</code>来备注缺失的特性或者在以后添加的功能。</li>
	<li>使用<code>FIXME</code>来备注有问题需要修复的代码。</li>
	<li>使用<code>OPTIMIZE</code>来备注慢的或者低效的可能引起性能问题的代码。</li>
	<li>使用<code>HACK</code>来备注那些使用问题代码的地方可能需要重构。</li>
	<li>使用<code>REVIEW</code>来备注那些需要反复查看确认工作正常的代码。例如：<code>REVIEW: 你确定客户端是怎样正确的完成X的吗？</code></li>
	<li>使用其他自定义的关键字如果认为它是合适的，但是确保在你的项目的<code>README</code>或者类似的地方注明。</li>
</ul>
<h2>类</h2>
<ul>
	<li>在设计类层次的时候确保他们符合<a href="http://en.wikipedia.org/wiki/Liskov_substitution_principle">Liskov Substitution Principle</a>原则。(译者注: LSP原则大概含义为: 如果一个函数中引用了`父类的实例', 则一定可以使用其子类的实例替代, 并且函数的基本功能不变. (虽然功能允许被扩展)) &gt;Liskov替换原则：子类型必须能够替换它们的基类型 &gt; 1. 如果每一个类型为T1的对象o1，都有类型为T2的对象o2，使得以T1定义的所有程序P在所有的对象o1都代换为o2时,程序P的行为没有变化，那么类型T2是类型T1的子类型。 &gt; 2. 换言之，一个软件实体如果使用的是一个基类的话，那么一定适用于其子类，而且它根本不能察觉出基类对象和子类对象的区别。只有衍生类替换基类的同时软件实体的功能没有发生变化，基类才能真正被复用。 &gt; 3. 里氏代换原则由Barbar Liskov(芭芭拉.里氏)提出，是继承复用的基石。 &gt; 4. 一个继承是否符合里氏代换原则，可以判断该继承是否合理（是否隐藏有缺陷）。</li>
	<li>努力是你的类尽可能的健壮<a href="http://en.wikipedia.org/wiki/SOLID_(object-oriented_design)">SOLID</a>。</li>
	<li>总是为你自己的类提供to_s方法, 用来表现这个类（实例）对象包含的对象.
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
	<li>使用<code>attr</code>功能功能成员来定义各个实例变量的访问器或者修改器方法。
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
	<li>考虑添加工厂方法来提供灵活的方法来创建实际类实例。
<div>
<pre>class Person
  def self.create(potions_hash)
    # body omitted
  end
end</pre>
</div></li>
	<li>鸭子类型（<a href="http://en.wikipedia.org/wiki/Duck_typing">duck-typing</a>）由于继承。
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
	<li>避免使用类变量（<code>@@</code>）因为他们讨厌的继承习惯（在子类中也可以修改父类的类变量）。
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
正如上例看到的, 所有的子类共享类变量, 并且可以直接修改类变量,此时使用类实例变量是更好的主意.</li>
	<li>根据方法的用途为他们分配合适的可见度( <code>private</code>, <code>protected</code> )，不要让所有的方法都是 <code>public</code> (这是默认设定)。这是 <em>Ruby</em> 不是 *Python*。</li>
	<li><code>public</code>, <code>protected</code>, 和 <code>private</code> 等可见性关键字应该和其（指定）的方法具有相同的缩进。并且不同的可见性关键字之间留一个空格。
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
	<li>使用self来定义单例方法. 当代码重构时, 这将使得方法定义代码更加具有灵活性.
<div>
<pre>class TestClass
  # bad
  def TestClass.some_method
    # body omitted
  end

  # good
  def self.some_other_method
    # body ommited
  end

  # 也可以这样方便的定义多个单例方法。
  class &lt;&lt; self
    def first_method
      # body omitted
    end

    def second_method_etc
      # body omitted
    end
  end
end</pre>
</div>
<pre lang="shell"><code>class SingletonTest def size 25 end end test1 = SingletonTest.new test2 = SingletonTest.new def test2.size 10 end test1.size # =&gt; 25 test2.size # =&gt; 10 </code></pre>
本例中，test1 與 test2 屬於同一類別，但 test2 具有重新定義的 size 方法，因此兩者的行為會不一樣。只給予單一物件的方法稱為单例方法 (singleton method)。</li>
</ul>
<h2>异常处理</h2>
<ul>
	<li>不要抑制异常输出。
<div>
<pre>begin
  # an exception occurs here
rescue SomeError
  # the rescue clause does absolutely nothing还没有补救代码
end</pre>
</div></li>
	<li>不要用异常来控制流。
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
	<li>应该总是避免拦截(最顶级的)Exception异常类.
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
	<li>将更具体的异常放在拦截链的上方，否则他们将不会被捕获。
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
	<li>使用ensure语句, 来确保总是执行一些特地的操作.
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
	<li>除非必要, 尽可能使用Ruby标准库中异常类，而不是引入一个新的异常类。(而不是派生自己的异常类)</li>
</ul>
<h2>集合</h2>
<ul>
	<li>总是使用%w的方式来定义字符串数组.(译者注: w表示英文单词word, 而且定义之间千万不能有逗号)
<div>
<pre># bad
STATES = ['draft', 'open', 'closed']

# good
STATES = %w(draft open closed)</pre>
</div></li>
	<li>避免直接引用靠后的数组元素, 这样隐式的之前的元素都被赋值为nil.
<div>
<pre>arr = []
arr[100] = 1 # now you have an array with lots of nils</pre>
</div></li>
	<li>如果要确保元素唯一, 则使用 <code>Set</code> 代替 <code>Array</code> .<code>Set</code> 更适合于无顺序的, 并且元素唯一的集合, 集合具有类似于数组一致性操作以及哈希的快速查找.</li>
	<li>尽可能使用符号代替字符串作为哈希键.
<div>
<pre># bad
hash = { 'one' =&gt; 1, 'two' =&gt; 2, 'three' =&gt; 3 }

# good
hash = { one: 1, two: 2, three: 3 }</pre>
</div></li>
	<li>避免使用易变对象作为哈希键。</li>
	<li>优先使用1.9的新哈希语法。
<div>
<pre># bad
hash = { :one =&gt; 1, :two =&gt; 2, :three =&gt; 3 }

# good
hash = { one: 1, two: 2, three: 3 }</pre>
</div></li>
	<li>记住, 在Ruby1.9中, 哈希的表现不再是无序的. (译者注: Ruby1.9将会记住元素插入的序列)</li>
	<li>当遍历一个集合的同时, 不要修改这个集合。</li>
</ul>
<h2>字符串</h2>
<ul>
	<li>优先使用 <code>字符串插值</code> 来代替 <code>字符串串联</code>。
<div>
<pre># bad
email_with_name = user.name + ' &lt;' + user.email + '&gt;'

# good
email_with_name = "#{user.name} &lt;#{user.email}&gt;"</pre>
</div></li>
	<li>当不需要使用 <code>字符串插值</code> 或某些特殊字符时, 应该优先使用单引号.
<div>
<pre># bad
name = "Bozhidar"

# good
name = 'Bozhidar'</pre>
</div></li>
	<li>当使用字符串插值替换 <code>实例变量</code> 时, 应该省略{}.
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
	<li>操作较大的字符串时, 避免使用 <code>String#+</code> , 如果需要修改被操作字符串, 应该总是使用 <code>String#&lt;&lt;</code> 作为代替。就地并列字符串实例变体比 <code>String#+</code> 更快，它创建了多个字符串对象。
<div>
<pre># good and also fast
html = ''
html &lt;&lt; '&lt;h1&gt;Page title&lt;/h1&gt;'

paragraphs.each do |paragraph|
  html &lt;&lt; "&lt;p&gt;#{paragraph}&lt;/p&gt;"
end</pre>
</div></li>
</ul>
<h2>正则表达式</h2>
<ul>
	<li>如果只是需要中查找字符串的 <code>text</code>, 不要使用正则表达式：<code>string['text']</code></li>
	<li>针对简单的结构, 你可以直接使用string[/RE/]的方式来查询.
<div>
<pre>match = string[/regexp/]             # get content of matched regexp
first_group = string[/text(grp)/, 1] # get content of captured group
string[/text (grp)/, 1] = 'replace'  # string =&gt; 'text replace'</pre>
</div></li>
	<li>当无需引用分组内容时, 应该使用(?:RE)代替(RE).
<div>
<pre>/(first|second)/   # bad
/(?:first|second)/ # good</pre>
</div></li>
	<li>避免使用 <code>$1-$9</code> 风格的分组引用, 而应该使用1.9新增的命名分组来代替.
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
	<li>字符类有以下几个特殊关键字值得注意: <code>^</code>, <code>-</code>, <code>\</code>, <code>]</code>, 所以, 不要在集合中, 转义 <code>.</code> 或者 <code>[]</code> 中的括号, 他们是正常字符.</li>
	<li>注意, <code>^</code> 和 <code>$</code> , 他们匹配行首和行尾, 而不是一个字符串的结尾, 如果你想匹配整个字符串, 用 <code>\A</code> 和 <code>\Z</code>。
<div>
<pre>string = "some injection\nusername"
string[/^username$/]   # matches
string[/\Ausername\Z/] # don't match</pre>
</div></li>
	<li>使用 <code>x</code> 修饰符来匹配复杂的表达式, 这将使得RE更具可读性, 你可以添加一些有用的注释. 注意, 所有空格将被忽略.
<div>
<pre>regexp = %r{
  start         # some text
  \s            # white space char
  (group)       # first group
  (?:alt1|alt2) # some alternation
  end
}x</pre>
</div></li>
	<li><code>sub</code>/<code>gsub</code>也支持哈希以及代码块形式语法, 可用于复杂情形下的替换操作.</li>
</ul>
<h2>百分号和字面值</h2>
<ul>
	<li>多用 <code>%w</code>
<div>
<pre>STATES = %w(draft open closed)</pre>
</div></li>
	<li>定义需要插值和嵌套双引号符号的单行字符串，使用%()的方式.而多行字符串, 尽量使用heredocs格式.
<div>
<pre># bad (不需要插值)
%(&lt;div&gt;Some text&lt;/div&gt;)
# should be '&lt;div&gt;Some text&lt;/div&gt;' # 应该这样写

# bad (没有双引号)
%(This is #{quality} style)
# should be "This is #{quality} style" # 应该这样写

# bad (multiple lines)
%(&lt;div&gt;\n&lt;span&gt;#{exclamation}&lt;/span&gt;\n&lt;/div&gt;)
# should be a heredoc.

# good (插值, 引号, 单行)
%(&lt;tr&gt;&lt;td&gt;#{name}&lt;/td&gt;)</pre>
</div>
Heredoc is a robust way to create string in PHP with more lines but without using quotations. Heredoc 是 php 中不使用引号就可以创建多行字符串的一种强大的方式。

line-oriented string literals (Here document) There's a line-oriente form of the string literals that is usually called as <code>here document</code>. Following a <code>&lt;&lt;</code> you can specify a string or an identifier to terminate the string literal, and all lines following the current line up to the terminator are the value of the string. If the terminator is quoted, the type of quotes determines the type of the line-oriented string literal. Notice there must be <strong>no space between <code>&lt;&lt;</code> and the terminator</strong> .

If the - placed before the delimiter, then all leading whitespcae characters (tabs or spaces) are stripped from input lines and the line containing delimiter. This allows here-documents within scripts to be indented in a natural fashion.
<div>
<pre>  print &lt;&lt;EOF
    The price is #{$Price}.
    EOF

  print &lt;&lt;"EOF";            # same as above
The price is #{$Price}.
EOF

  print &lt;&lt;`EOC`         # execute commands
echo hi there
echo lo there
EOC

  print &lt;&lt;"foo", &lt;&lt;"bar"    # you can stack them
I said foo.
foo
I said bar.
bar

  myfunc(&lt;&lt;"THIS", 23, &lt;&lt;'THAT')
Here's a line
or two.
THIS
and here's another.
THAT

  if need_define_foo
    eval &lt;&lt;-EOS         # delimiters can be indented
      def foo
        print "foo\n"
      end
    EOS
  end</pre>
</div></li>
	<li><code>%r</code> 的方式只适合于定义包含多个 <code>/</code> 符号的正则表达式。
<div>
<pre># bad
%r(\s+)

# still bad
%r(^/(.*)$)
# should be /^\/(.*)$/

# good
%r(^/blog/2011/(.*)$)</pre>
</div>
<div>
<pre>irb(main):001:0&gt; string="asdfas.64"
=&gt; "asdfas.64"
irb(main):002:0&gt; string[/^\/(.*)$/]
=&gt; nil
irb(main):003:0&gt; string="/asdfas.64"
=&gt; "/asdfas.64"
irb(main):004:0&gt; string[/^\/(.*)$/]
=&gt; "/asdfas.64"
irb(main):007:0&gt; string="/blog/2011/asdfas.64"
=&gt; "/blog/2011/tmp/asdfas.64"
irb(main):008:0&gt; string[%r(^/blog/2011/(.*)$)]
=&gt; "/blog/2011/tmp/asdfas.64"</pre>
</div></li>
	<li>避免使用<code>%q</code>，<code>%Q</code>， <code>%x</code>， <code>%s</code>,和 <code>%W</code></li>
	<li>优先使用()作为%类语法格式的分隔符.(译者注, 本人很喜欢 <code>%(...)</code>, 不过Programming Ruby中, 显然更喜欢使用%{}的方式)</li>
</ul>
<h2>元编程</h2>
<ul>
	<li>在编写库时，不要乱动核心库。（不要画蛇添足）</li>
</ul>
<h2>杂项</h2>
<ul>
	<li>总是打开Ruby -w开关。</li>
	<li>通常情况下, 尽量避免使用哈希作为方法的 <code>optional</code> 参数. (此时应该考虑这个方法是不是功能太多?)</li>
	<li>避免一个方法内容超过10行代码, 理想情况下, 大多数方法内容应该少于5行.(不算空行)</li>
	<li>尽量避免方法的参数超过三或四个.</li>
	<li>有时候, 必须用到全局方法, 应该增加这些方法到 Kernel 模块，并设置他们可见性关键字为 <code>private</code>。</li>
	<li>尽可能使用类实例变量代替全局变量. (译者注:是类实例变量, 而不是类的实例变量. 汗~~)
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
	<li>能够用 <code>alias_method</code> 就不要用 <code>alias</code>。</li>
	<li>使用 <code>OptionParser</code> 来解析复杂的命令行选项， 较简单的命令行， <code>-s</code> 参数即可。</li>
	<li>按照功能来编写方法, 当方法名有意义时, 应该避免方法功能被随意的改变。</li>
	<li>避免不需要的元编程。</li>
	<li>除非必要, 避免更改已经定义的方法的参数。</li>
	<li>避免超过三级的代码块嵌套。</li>
	<li>应该持续性的遵守以上指导方针。</li>
	<li>多使用（生活）常识。</li>
</ul>
<h1>Contributing</h1>
Nothing written in this guide is set in stone. It's my desire to work together with everyone interested in Ruby coding style, so that we could ultimately create a resource that will be beneficial to the entire Ruby community.

Feel free to open tickets or send pull requests with improvements. Thanks in advance for your help!
<h1>Spread the Word</h1>
A community-driven style guide is of little use to a community that doesn't know about its existence. Tweet about the guide, share it with your friends and colleagues. Every comment, suggestion or opinion we get makes the guide just a little bit better. And we want to have the best possible guide, don't we?
