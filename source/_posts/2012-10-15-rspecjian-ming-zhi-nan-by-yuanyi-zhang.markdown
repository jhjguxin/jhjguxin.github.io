---
layout: post
title: "RSpec简明指南 By Yuanyi ZHANG"
date: 2012-03-09 18:05
comments: true
categories: [rails,ruby]
tags: [guide,RSpec,tutorial]
---
## RSpec简明指南 By Yuanyi ZHANG
这是<a href="http://blog.davidchelimsky.net/">David Chelimsky</a>写的一篇RSpec简明指南，原文在<a href="http://blog.davidchelimsky.net/articles/2007/05/14/an-introduction-to-rspec-part-i">这里</a>。

<span style="font-size: large;"><strong>简介</strong></span>

要了解RSpec，我们首先需要了解什么是行为驱动开发（Behaviour Driven Development，简称BDD），BDD是一种融合了可接受性测试驱动计划（Acceptance Test Driven Planning），域驱动设计（Domain Driven Design）以及测试驱动开发（Test Driven Development，简称TDD）的敏捷开发模型。RSpec为BDD开发提供TDD支持。

你可以简单的将RSpec看作一个传统的单元测试框架，但我们更愿意将它看成是一种领域特定语言（Domain Specific Language，以下简称DSL），它的主要作用就是描述我们对系统执行某个样例(example)的期望行为(behavior)。

这篇指南遵从TDD思想，但是我们将使用行为（behavior）和样例（example）来代替测试例（test case）和测试方法（test method），想知道我们为什么采用这样的术语，请参看<a href="http://dannorth.net/tags/agile/bdd/">Dan North</a>, <a href="http://daveastels.com/articles/2005/07/05/a-new-look-at-test-driven-development">Dave Astels</a>, 以及 <a href="http://exampler.com/">Brian Marick</a> 的相关文章。

<span style="font-size: large;"><strong>安装</strong></span>

目前RSpec的最新版本是1.0.5，需要Ruby184以上版本，可以通过下面这条命令安装：

<code># gem install rspec</code>

<span style="font-size: large;"><strong>准备工作</strong></span>

整篇指南都围绕一个例子展开，因此在开始前，你最好先为这个例子建个目录：

<code>$ mkdir rspec_tutorial
$ cd rspec_tutorial</code>

<span style="font-size: large;"><strong>开始</strong></span>

我们首先要了解的是RSpec DSL的”describe”与”it”方法，这两个方法有很多其它的名字（但是我们不推荐使用它们），我们之所以使用这样的命名，只是想让你站在行为（behavior）而不是结构（structure）的角度进行思考。

创建名为user_spec.rb的文件：

<code>describe User do
end</code>

describe方法创建一个Behavior实例，所以你可以将”describe User”理解为”描述用户的行为（describe the behaviour of the User class）”，或许这个方法叫做“
describe_the_behaviour_of”会更合适些，但这实在太冗长了，所以我们决定只选取第一个单词describe来作为这个方法的名字。

现在你可以在shell中试试这条命令：

<code>$ spec user_spec.rb</code>

spec命令有很多选项，但大部分超出了本指南的范围，如果你感兴趣，可以只输入spec而不带任何参数来查看帮助信息。

让我们接着回到上面那条命令，它应该会产生下面的输出：

<code>./user_spec.rb:1: uninitialized constant User (NameError)</code>

这是因为我们还没有创建User类，也就是说我们要描述的东西不存在，因此我们需要再创建一个user.rb来定义我们所要描述的对象：

<code>class User
end</code>

并在user_spec.rb中包含它：

<code>require 'user'
describe User do
end</code>

现在再次运行spec命令：

<code>$ spec user_spec.rb
Finished in 6.0e-06 seconds
0 examples, 0 failures</code>

这个输出是说我们还没有定义样例，所以现在我们就来定义一个：

<code>describe User do
  it "should be in any roles assigned to it" do
  end
end</code>

it方法返回一个Example实例，因此我们可以将it方法理解成“用户行为的一个样例”。

再次运行spec：

<code>$ spec user_spec.rb --format specdoc
User
- should be in any roles assigned to it
Finished in 0.022865 seconds
1 example, 0 failures</code>

specdoc参数格式化行为（describe方法创建的对象）以及样例（it方法创建的对象）的名字然后输出，这种格式来自于TestDox，一个为JUnit测试例及方法提供相似报告的工具。

现在我们开始增加Ruby代码：

<code>describe User do
  it "should be in any roles assigned to it" do
    user.should be_in_role("assigned role")
  end
end</code>

这句话的意思是User应该能够胜任所有分配给他的角色，那么事实是这样么？让我们运行spec试试看：

<code>$ spec user_spec.rb --format specdoc
User
- should be in any roles assigned to it (ERROR - 1)
1)
NameError in ‘User should be in any roles assigned to it’
undefined local variable or method `user’ for #&lt;#:0×14ecdd8&gt;
./user_spec.rb:6:
Finished in 0.017956 seconds
1 example, 1 failure</code>

又出错了，是的，但在继续之前，让我们先仔细看看这段出错信息：
<ul>
	<li>“ERROR -1)”告诉我们”should be in any roles assigned to it”这个样例出错了</li>
	<li>“1)”则为我们详细描述了这个错误，当样例很多时，你就会发现这个编号非常有用</li>
</ul>
还有一点需要注意：这段信息没有给出RSpec代码的backtrace，如果你需要它，可以通过–backtrace选项来获取。

下面，我们继续我们的例子，上面的错误是因为我们没有创建User对象，那我们就创建一个：

<code>describe User do
  it "should be in any roles assigned to it" do
    user = User.new
    user.should be_in_role("assigned role")
  end
end</code>

<code>$ spec user_spec.rb --format specdoc
User
- should be in any roles assigned to it (ERROR - 1)
1)
NoMethodError in ‘User should be in any roles assigned to it’
undefined method `in_role?’ for #
./user_spec.rb:7:
Finished in 0.020779 seconds
1 example, 1 failure</code>

还是失败，不过这次是因为User对象缺少role_in?方法，修改user.rb:

<code>class User
  def in_role?(role)
  end</code>

<code>$ spec user_spec.rb --format specdoc
User
- should be in any roles assigned to it (FAILED - 1)
1)
‘User should be in any roles assigned to it’ FAILED
expected in_role?(”assigned role”) to return true, got nil
./user_spec.rb:7:
Finished in 0.0172110000000001 seconds
1 example, 1 failure</code>

虽然又失败了，但我们的第一个目标其实已经达到了，我们得到了一段更有意义的错误描述”User should be in any roles assigned to it”。

让这段代码避免失败很简单：

<code>class User
  def in_role?(role)
    true
  end</code>

<code>$ spec user_spec.rb --format specdoc
User
- should be in any roles assigned to it
Finished in 0.018173 seconds
1 example, 0 failures</code>

现在终于通过了，但是让我们再来看看这段代码：

<code>describe User do
  it "should be in any roles assigned to it" do
    user = User.new
    user.should be_in_role("assigned role")
  end
end</code>

我们可以将这个样例理解成“用户应该接受所有分配给他的角色”，但问题是我们还没有分给他角色呢？

<code>describe User do
  it "should be in any roles assigned to it" do
    user = User.new
    user.assign_role("assigned role")
    user.should be_in_role("assigned role")
  end
end</code>

这段代码又会引发一个错误，因为User并没有assign_role这个方法：

<code>class User
  def in_role?(role)
    true
  end
  def assign_role(role)
  end
end</code>

<code>$ spec user_spec.rb --format specdoc
User
- should be in any roles assigned to it
Finished in 0.018998 seconds
1 example, 0 failures</code>

样例再次通过，但是我们的任务还没结束，只要你再回头看看我们目前的代码，就会发现这个User的行为与我们的目标还有距离。

现在，我们只是解决了“用户必须接受所有分配给他的角色”，但是还有一个问题就是”用户不应该接受没有分配给他的角色“。所以我们需要为用户行为再增加一个样例：

<code>describe User do
  it "should be in any roles assigned to it" do
    user = User.new
    user.assign_role("assigned role")
    user.should be_in_role("assigned role")
  end
  it “should NOT be in any roles not assigned to it” do
    user = User.new
    user.should_not be_in_role(”unassigned role”)
  end
end</code>

<code>$ spec user_spec.rb --format specdoc
User
- should be in any roles assigned to it
- should NOT be in any roles not assigned to it (FAILED - 1)
1)
‘User should NOT be in any roles not assigned to it’ FAILED
expected in_role?(”unassigned role”) to return false, got true
./user_spec.rb:12:
Finished in 0.019014 seconds
2 examples, 1 failure</code>

失败了，用户接受了没有分给他的角色，这需要我们对User的实现做些改动：

<code>class User
  def in_role?(role)
    role == "assigned role"
  end
  def assign_role(role)
  end
end</code>

现在，一切都搞定了，但是我们的代码与样例有些重复（它们都使用了”assigned role”），因此，有必要对User类进行重构：

<code>class User
  def in_role?(role)
    role == @role
  end
  def assign_role(role)
    @role = role
  end
end</code>

随后，让我们再来测试一下：

<code>$ spec user_spec.rb --format specdoc
User
- should be in any roles assigned to it
- should NOT be in any roles not assigned to it
Finished in 0.018199 seconds
2 examples, 0 failures</code>

事情就这么结束了么？你可能还有些疑惑，因为我们甚至可以将一个数字分配给用户，但这与”用户应该接受任何分配给他的角色”是吻合的，所以，这时候我们应该征求下我们的客户的意见，“每个用户在同一时间只能担当一个角色吗？”，如果客户的回答是Yes，那么很幸运，我们不需要对我们的代码进行改动，而只需对样例的描述进行一些修改，但如果客户的回答是No，那我们恐怕还得再做些工作。
