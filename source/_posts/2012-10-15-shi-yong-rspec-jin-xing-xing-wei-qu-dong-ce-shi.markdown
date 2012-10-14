---
layout: post
title: "使用 RSpec 进行行为驱动测试"
date: 2012-02-24 10:37
comments: true
categories: [rails,ruby]
tags: [rails,RSpec,ruby,TDD]
---
## 使用 RSpec 进行行为驱动测试
Bruce Tate, CTO, WellGood LLC

在过去十年中，软件开发人员对测试的热情日渐低迷。同一时期出现的动态语言并没有提供编译程序来捕捉最基本的错误，这使得测试变得更加重要。随着测试社区的成长，开发人员开始注意到，除了捕获 bug 等最基本的优点外，测试还具有以下优势：
<ul>
	<li>测试能够改进您的设计。进行测试的每个目标对象必须具备至少两个客户机：生产代码和测试用例。这些客户机强制您对代码进行解耦。测试还鼓励开发人员使用更小、更简单的方法。</li>
	<li>测试减少了不必要的代码。在编写测试用例时，您养成了很好的测试习惯，即只编写运行测试用例所需的最少代码。您抵制住了对功能进行编码的诱惑，因为您目前还不需要它。</li>
	<li>推动了测试优先开发。您编写的每个测试用例会确定一个小问题。使用代码解决这个问题非常有用并且可以推动开发。当我进行测试驱动开发时，时间过得飞快。</li>
	<li>测试提供了更多的自主权。在使用测试用例捕获可能的错误时，您会发现自己非常愿意对代码进行改进。</li>
</ul>
<a name="N10059"></a>测试驱动的开发和 RSpec

有关测试的优点无需赘述，我将向您介绍一个简单的使用 RSpec 的测试驱动开发示例。RSpec 工具是一个 Ruby 软件包，可以用它构建有关您的软件的规范。该规范实际上是一个描述系统行为的测试。使用 RSpec 的开发流程如下：
<ul>
	<li>编写一个测试。该测试描述系统中某个较小元素的行为。</li>
	<li>运行测试。由于尚没有为系统中的相应部分构建代码，测试失败。这一重要步骤将测试您的测试用例，检验测试用例是否在应当失败的时候失败。</li>
	<li>编写足够的代码，使测试通过。</li>
	<li>运行测试，检验测试是否成功。</li>
</ul>
实质上，RSpec 开发人员所做的工作就是将失败的测试用例调试为成功的测试用例。这是一个主动的过程。本文中，我将介绍 RSpec 的基本用法。

首先，假设您已安装了 Ruby 和 gems。您还需要安装 RSpec。输入下面的内容：

<code>gem install rspec</code>
<div> </div>
&nbsp;

<a name="N1007D"></a>使用示例

接下来，我将逐步构建一个状态机。我将遵循 TDD 规则。首先编写自己的测试用例，并且直到测试用例需要时才编写代码。Rake 的创建者 Jim Weirich 认为这有助于角色扮演。在编写实际的生产代码时，您希望充当一回 jerk 开发人员的角色，只完成最少量的工作来使测试通过。在编写测试时，您则扮演测试人员的角色，试图为开发人员提供一些有益的帮助。

以下的示例展示了如何构建一个状态机。如果您以前从未接触过状态机，请查阅 参考资料。状态机具有多种状态。每种状态支持可以转换状态机状态的事件。测试驱动开发入门的关键就是从零入手，尽量少地使用假设条件。针对测试进行程序设计。

使用清单 1 的内容创建名为 machine_spec.rb 的文件。该文件就是您的规范。您还不了解 machine.rb 文件的作用，目前先创建一个空文件。

<a name="resources"></a><strong>清单 1. 最初的 machine_spec.rb 文件 </strong>
<table width="100%" border="0" cellspacing="0" cellpadding="0">
<tbody>
<tr>
<td>
<pre>  require 'machine'</pre>
</td>
</tr>
</tbody>
</table>
&nbsp;

接下来，需要运行测试。始终通过输入 <code>spec machine_spec.rb</code> 运行测试。清单 2 展示了预料之中的测试失败：
<a name="listing2"></a><strong>清单 2. 运行空的规范</strong>
<table width="100%" border="0" cellspacing="0" cellpadding="0">
<tbody>
<tr>
<td>
<pre>~/rspec batate$ spec machine_spec.rb
/opt/local/lib/ruby/site_ruby/1.8/rubygems/custom_require.rb:27:in `gem_original_require':
 no such file to load -- machine (LoadError)
        from /opt/local/lib/ruby/site_ruby/1.8/rubygems/custom_require.rb:27:in `require'
        from ./state_machine_spec.rb:1
        from ...</pre>
</td>
</tr>
</tbody>
</table>
&nbsp;

在测试驱动开发中，您需要进行增量开发，因此在进行下一次开发前，需要先解决此次测试出现的问题。现在，我将扮演 jerk 开发人员的角色，即只完成满足应用程序运行所需的最少工作量。我将创建一个名为 machine.rb 的空文件，使测试通过。我现在可以以逸待劳，测试通过而我几乎没做任何事情。

继续角色扮演。我现在扮演一个烦躁的测试人员，促使 jerk 开发人员做些实际的工作。我将编码以下规范，需要使用 <code>Machine</code> 类，如清单 3 所示：
<a name="listing3"></a><strong>清单 3. 初始规范</strong>
<table width="100%" border="0" cellspacing="0" cellpadding="0">
<tbody>
<tr>
<td>
<pre>require 'machine'

describe Machine do
  before :each do
    @machine = Machine
  end
end</pre>
</td>
</tr>
</tbody>
</table>
&nbsp;

该规范描述了目前尚不存在的 <code>Machine</code> 类。<code>describe</code> 方法提供了 RSpec 描述，您将传入测试类的名称和包含实际规范的代码块。通常，测试用例需要执行一定数量的设置工作。在 RSpec 中，将由 <code>before</code> 方法完成这些设置工作。您向 <code>before</code> 方法传递一个可选的标志和一个代码块。代码块中包含设置工作。标志确定 RSpec 执行代码块的频率。默认的标志为 <code>:each</code>，表示 RSpec 将在每次测试之前调用 set up 代码块。您也可以指定 <code>:all</code>，表示 RSpec 在执行所有测试之前只调用一次 <code>before</code> 代码块。您应该始终使用<code>:each</code>，使各个测试彼此独立。

输入 <code>spec</code> 运行测试，如清单 4 所示：
<a name="listing4"></a><strong>清单 4. 存在性测试失败</strong>
<table width="100%" border="0" cellspacing="0" cellpadding="0">
<tbody>
<tr>
<td>
<pre>~/rspec batate$ spec machine_spec.rb 

./machine_spec.rb:3: uninitialized constant Machine (NameError)</pre>
</td>
</tr>
</tbody>
</table>
&nbsp;

现在，烦躁的测试人员要促使 jerk 开发人员做点什么了 — jerk 开发人员现在需要创建某个类。对我来说，就是修复测试出现的错误。在 <code>machine.rb</code> 中，我输入最少量的代码，如清单 5 所示：
<a name="listing5"></a><strong>清单 5. 创建初始 Machine 类</strong>
<table width="100%" border="0" cellspacing="0" cellpadding="0">
<tbody>
<tr>
<td>
<pre>class Machine
end</pre>
</td>
</tr>
</tbody>
</table>
&nbsp;

保存文件，然后运行测试。毫无疑问，清单 6 显示的测试报告没有出现错误：
<a name="listing6"></a><strong>清单 6. 测试 Machine 是否存在</strong>
<table width="100%" border="0" cellspacing="0" cellpadding="0">
<tbody>
<tr>
<td>
<pre>~/rspec batate$ spec machine_spec.rb 

Finished in 5.0e-06 seconds

0 examples, 0 failures</pre>
</td>
</tr>
</tbody>
</table>
&nbsp;
<div> </div>
<a name="N1010D"></a>编写行为

现在，我可以开始实现更多的行为。我知道，所有状态机必须在某些初始状态下启动。目前我还不是很清楚如何设计这个行为，因此我先编写一个非常简单的测试，首先假设 <code>state</code> 方法会返回 <code>:initial</code> 标志。我对 <code>machine_spec.rb</code> 进行修改并运行测试，如清单 7 所示：
<a name="listing7"></a><strong>清单 7. 实现初始状态并运行测试</strong>
<table width="100%" border="0" cellspacing="0" cellpadding="0">
<tbody>
<tr>
<td>
<pre>require 'machine'

describe Machine do
  before :each do
    @machine = Machine.new
  end

  it "should initially have a state of :initial" do
    @machine.state.should == :initial
  end

end

~/rspec batate$ spec machine_spec.rb 

F

1)
NoMethodError in 'Machine should initially have a state of :initial'
undefined method `state' for #&lt;Machine:0x10c7f8c&gt;
./machine_spec.rb:9:

Finished in 0.005577 seconds

1 example, 1 failure</pre>
</td>
</tr>
</tbody>
</table>
&nbsp;

注意这条规则：<code> it "should initially have a state of :initial" do @machine.state.should == :initial end</code>。首先注意到这条规则读起来像是一个英文句子。删除标点，将得到 <code>it should initially have a state of initial</code>。然后会注意到这条规则并不像是典型的面向对象代码。它确实不是。您现在有一个方法，称为 <code>it</code>。该方法具有一个使用引号括起来的字符串参数和一个代码块。字符串应该描述测试需求。最后，<code>do</code> 和 <code>end</code> 之间的代码块包含测试用例的代码。

可以看到，测试进度划分得很细。这些微小的步骤产生的收益却很大。它们使我能够改进测试密度，提供时间供我思考期望的行为以及实现行为所需的 API。这些步骤还能使我在开发期间跟踪代码覆盖情况，从而构建更加丰富的规范。

这种风格的测试具有双重作用：测试实现并在测试的同时构建需求设计文档。稍后，我将通过测试用例构建一个需求列表。

我使用最简单的方式修复了测试，返回 <code>:initial</code>，如清单 8 所示：
<a name="listing8"></a><strong>清单 8. 指定初始状态</strong>
<table width="100%" border="0" cellspacing="0" cellpadding="0">
<tbody>
<tr>
<td>
<pre>class Machine

  def state
    :initial
  end
end</pre>
</td>
</tr>
</tbody>
</table>
&nbsp;

当查看实现时，您可能会放声大笑或感觉受到了愚弄。对于测试驱动开发，您必须稍微改变一下思考方式。您的目标并不是编写最终的生产代码，至少现在不是。您的目标是使测试通过。当掌握以这种方式工作时，您可能会发现新的实现，并且编写的代码要远远少于采用 TDD 时编写的代码。

下一步是运行代码，查看它是否通过测试：
<a name="listing9"></a><strong>清单 9. 运行初始状态测试</strong>
<table width="100%" border="0" cellspacing="0" cellpadding="0">
<tbody>
<tr>
<td>
<pre>~/rspec batate$ spec machine_spec.rb 

.

Finished in 0.005364 seconds

1 example, 0 failures</pre>
</td>
</tr>
</tbody>
</table>
&nbsp;

花些时间思考一下这个通过测试的迭代。如果查看代码的话，您可能会觉得气馁。因为并没有取得什么进展。如果查看整个迭代，将看到更多内容：您捕获了一个重要需求并编写测试用例实现需求。作为一名程序员，我的第一个行为测试帮助我明确了开发过程。因为实现细节随着测试的进行越来越清晰。

现在，我可以实现一个更健壮的状态实现。具体来讲，我需要处理状态机的多个状态。我需要创建一个新的规则获取有效状态列表。像以前一样，我将运行测试并查看是否通过。
<a name="listing10"></a><strong>清单 10. 实现有效状态规范</strong>
<table width="100%" border="0" cellspacing="0" cellpadding="0">
<tbody>
<tr>
<td>
<pre> it "should remember a list of valid states" do
    @machine.states = [:shopping, :checking_out]
    @machine.states.should = [:shopping, :checking_out]
  end

run test(note: failing first verifies test)

~/rspec batate$ spec machine_spec.rb 

.F

1)
NoMethodError in 'Machine should remember a list of valid states'
undefined method `states=' for #&lt;Machine:0x10c7154&gt;
./machine_spec.rb:13:

Finished in 0.005923 seconds

2 examples, 1 failure</pre>
</td>
</tr>
</tbody>
</table>
&nbsp;

在清单 10 中，出现了一个 RSpec 形式的断言。该断言从 <code>should</code> 方法开始，然后添加了一些比较关系。<code>should</code> 方法对应用程序进行某种观察。工作中的应用程序应该以某种方式运行。<code>should</code> 方法很好地捕获了这种需求。在本例中，我的状态机应该记忆两种不同的状态。

现在，应该添加一个实例变量来实际记忆状态。像以往一样，我在修改代码后运行测试用例，并观察测试是否成功。
<a name="listing11"></a><strong>清单 11. 创建一个属性以记忆状态</strong>
<table width="100%" border="0" cellspacing="0" cellpadding="0">
<tbody>
<tr>
<td>
<pre>class Machine
  attr_accessor :states

  def state
    :initial
  end
end

~/rspec batate$ spec machine_spec.rb 

..

Finished in 0.00606 seconds

2 examples, 0 failures</pre>
</td>
</tr>
</tbody>
</table>
&nbsp;
<div> </div>
<a name="N10190"></a>驱动重构

此时，我并不想决定将 <code>:initial</code> 状态称为状态机的第一个状态。相反，我更希望第一个状态是状态数组中的第一个元素。我对状态机的理解在不断演变。这种现象并不少见。测试驱动开发经常迫使我重新考虑之前的假设。由于我已经通过测试用例捕获了早期需求，我可以轻松地对代码进行重构。在本例中，重构就是对代码进行调整，使其更好地工作。

修改第一个测试，使其如清单 12 所示，并运行测试：
<a name="listing12"></a><strong>清单 12. 初始状态应该为指定的第一个状态</strong>
<table width="100%" border="0" cellspacing="0" cellpadding="0">
<tbody>
<tr>
<td>
<pre>it "should initially have a state of the first state" do
  @machine.states = [:shopping, :checking_out]
  @machine.state.should == :shopping
end

~/rspec batate$ spec machine_spec.rb 

F.

1)
'Machine should initially have a state of the first state' FAILED
expected :shopping, got :initial (using ==)
./machine_spec.rb:10:

Finished in 0.005846 seconds

2 examples, 1 failure</pre>
</td>
</tr>
</tbody>
</table>
&nbsp;

可以这样说，测试用例起到作用了，因为它运行失败，因此我现在需要修改代码以使其工作。显而易见，我的任务就是使测试通过。我喜欢这种测试目的，因为我的测试用例正在驱动我进行设计。我将把初始状态传递给 <code>new</code> 方法。我将对实现稍作修改，以符合修改后的规范，如清单 13 所示。
<a name="listing13"></a><strong>清单 13. 指定初始状态</strong>
<table width="100%" border="0" cellspacing="0" cellpadding="0">
<tbody>
<tr>
<td>
<pre>start to fix it
class Machine
  attr_accessor :states
  attr_reader :state

  def initialize(states)
    @states = states
    @state = @states[0]
  end
end

~/rspec batate$ spec machine_spec.rb 

1)
ArgumentError in 'Machine should initially have a state of the first state'
wrong number of arguments (0 for 1)
./machine_spec.rb:5:in `initialize'
./machine_spec.rb:5:in `new'
./machine_spec.rb:5:

2)
ArgumentError in 'Machine should remember a list of valid states'
wrong number of arguments (0 for 1)
./machine_spec.rb:5:in `initialize'
./machine_spec.rb:5:in `new'
./machine_spec.rb:5:

Finished in 0.006391 seconds

2 examples, 2 failures</pre>
</td>
</tr>
</tbody>
</table>
&nbsp;

现在，测试出现了一些错误。我找到了实现中的一些 bug。测试用例不再使用正确的接口，因为我没有把初始状态传递给状态机。可以看到，测试用例已经起到了保护作用。我进行了较大的更改，测试就发现了 bug。我们需要对测试进行重构以匹配新的接口，将初始状态列表传递给 <code>new</code> 方法。在这里我并没有重复初始化代码，而是将其放置在 <code>before</code> 方法中，如清单 14 所示：
<a name="listing14"></a><strong>清单 14. 在 “<code>before</code>” 中初始化状态机 </strong>
<table width="100%" border="0" cellspacing="0" cellpadding="0">
<tbody>
<tr>
<td>
<pre>require 'machine'

describe Machine do
  before :each do
    @machine = Machine.new([:shopping, :checking_out])
  end

  it "should initially have a state of the first state" do
    @machine.state.should == :shopping
  end

  it "should remember a list of valid states" do
    @machine.states.should == [:shopping, :checking_out]
  end

end

~/rspec batate$ spec machine_spec.rb 

..

Finished in 0.005542 seconds

2 examples, 0 failures</pre>
</td>
</tr>
</tbody>
</table>
&nbsp;

状态机开始逐渐成型。代码仍然有一些问题，但是正在向良好的方向演化。我将开始对状态机进行一些转换。这些转换将促使代码实际记忆当前状态。

测试用例促使我全面地思考 API 的设计。我需要知道如何表示事件和转换。首先，我将使用一个散列表表示转换，而没有使用成熟的面向对象实现。随后，测试需求可能会要求我修改假设条件，但是目前，我仍然保持这种简单性。清单 15 显示了修改后的代码：
<a name="listing15"></a><strong>清单 15. 添加事件和转换</strong>
<table width="100%" border="0" cellspacing="0" cellpadding="0">
<tbody>
<tr>
<td>
<pre>remember events... change before conditions

require 'machine'

describe Machine do
  before :each do
    @machine = Machine.new([:shopping, :checking_out])
    @machine.events = {:checkout =&gt;
                               {:from =&gt; :shopping, :to =&gt; :checking_out}}
  end

  it "should initially have a state of the first state" do
    @machine.state.should == :shopping
  end

  it "should remember a list of valid states" do
    @machine.states.should == [:shopping, :checking_out]
  end

  it "should remember a list of events with transitions" do
    @machine.events.should == {:checkout =&gt;
                               {:from =&gt; :shopping, :to =&gt; :checking_out}}
  end

end

~/rspec batate$ spec machine_spec.rb 

FFF

1)
NoMethodError in 'Machine should initially have a state of the first state'
undefined method `events=' for #&lt;Machine:0x10c6f38&gt;
./machine_spec.rb:6:

2)
NoMethodError in 'Machine should remember a list of valid states'
undefined method `events=' for #z7lt;Machine:0x10c5afc&gt;
./machine_spec.rb:6:

3)
NoMethodError in 'Machine should remember a list of events with transitions'
undefined method `events=' for #&lt;Machine:0x10c4a58&gt;
./machine_spec.rb:6:

Finished in 0.006597 seconds

3 examples, 3 failures</pre>
</td>
</tr>
</tbody>
</table>
&nbsp;

由于新的测试代码位于 <code>before</code> 中，将我的三个测试分解开来。尽管如此，清单 16 中展示的测试非常容易修复。我将添加另一个访问程序：
<a name="listing16"></a><strong>清单 16. 记忆事件</strong>
<table width="100%" border="0" cellspacing="0" cellpadding="0">
<tbody>
<tr>
<td>
<pre>class Machine
  attr_accessor :states, :events
  attr_reader :state

  def initialize(states)
    @states = states
    @state = @states[0]
  end
end

~/rspec batate$ spec machine_spec.rb 

...

Finished in 0.00652 seconds

3 examples, 0 failures

test</pre>
</td>
</tr>
</tbody>
</table>
&nbsp;

测试全部通过。我得到了一个能正常运行的状态机。接下来的几个测试将使它更加完善。
<div> </div>
<a name="N101F2"></a>接近真实的应用程序

目前为止，我所做的不过是触发了一次状态转换，但是我已经做好了所有基础工作。我得到了一组需求。我还构建了一组测试。我的代码可以为状态机提供使用的数据。此时，管理单个状态机转换仅表示一次简单的转换，因此我将添加如清单 17 所示的测试：
<a name="listing17"></a><strong>清单 17. 构建状态机的状态转换</strong>
<table width="100%" border="0" cellspacing="0" cellpadding="0">
<tbody>
<tr>
<td>
<pre>it "should transition to :checking_out upon #trigger(:checkout) event " do
  @machine.trigger(:checkout)
  @machine.state.should == :checking_out
end

~/rspec batate$ spec machine_spec.rb 

...F

1)
NoMethodError in 'Machine should transition to :checking_out upon
#trigger(:checkout) event '
undefined method `trigger' for #&lt;Machine:0x10c4d00&gt;
./machine_spec.rb:24:

Finished in 0.006153 seconds

4 examples, 1 failure</pre>
</td>
</tr>
</tbody>
</table>
&nbsp;

我需要抵制快速构建大量功能的诱惑。我应该只编写少量代码，只要使测试通过即可。清单 18 展示的迭代将表示 API 和需求。这就足够了：
<a name="listing18"></a><strong>清单 18. 定义 <code>trigger</code> 方法</strong>
<table width="100%" border="0" cellspacing="0" cellpadding="0">
<tbody>
<tr>
<td>
<pre>def trigger(event)
  @state = :checking_out
end

~/rspec batate$ spec machine_spec.rb 

....

Finished in 0.005959 seconds

4 examples, 0 failures</pre>
</td>
</tr>
</tbody>
</table>
&nbsp;

这里出现了一个有趣的边注。在编写代码时，我两次都弄错了这个简单的方法。第一次我返回了 <code>:checkout</code>；第二次我将状态设置为<code>:checkout</code> 而不是 <code>:checking_out</code>。在测试中使用较小的步骤可以为我节省大量时间，因为测试用例为我捕获的这些错误在将来的开发中很难捕获到。本文的最后一个步骤是实际执行一次状态机转换。在第一个示例中，我并不关心实际的机器状态是什么样子的。我仅仅是根据事件进行盲目转换，而不考虑状态。

两节点的状态机无法执行这个操作，我需要在第三个节点中构建。我没有使用已有的 <code>before</code> 方法，只是在新状态中添加另外的状态。我将在测试用例中进行两次转换，以确保状态机能够正确地执行转换，如清单 19 所示：
<a name="listing19"></a><strong>清单 19. 实现第一次转换</strong>
<table width="100%" border="0" cellspacing="0" cellpadding="0">
<tbody>
<tr>
<td>
<pre>it "should transition to :success upon #trigger(:accept_card)" do
    @machine.events = {
       :checkout =&gt; {:from =&gt; :shopping, :to =&gt; :checking_out},
       :accept_card =&gt; {:from =&gt; :checking_out, :to =&gt; :success}
    }

    @machine.trigger(:checkout)
    @machine.state.should == :checking_out
    @machine.trigger(:accept_card)
    @machine.state.should == :success
  end

~/rspec batate$ spec machine_spec.rb
....F

1)
'Machine should transition to :success upon #trigger(:accept_card)' FAILED
expected :success, got :checking_out (using ==)
./machine_spec.rb:37:

Finished in 0.007564 seconds

5 examples, 1 failure</pre>
</td>
</tr>
</tbody>
</table>
&nbsp;

这个测试将使用 <code>:checkout</code> 和 <code>:accept_card</code> 事件建立新的状态机。在处理签出时，我选择使用两个事件而不是一个，这样可以防止发生双命令。签出代码可以确保状态机在签出之前处于 <code>shopping</code> 状态。第一次签出首先将状态机从 <code>shopping</code> 转换为 <code>checking_out</code>。测试用例通过触发 <code>checkout</code> 和 <code>accept_card</code> 事件实现两个转换，并在调用事件之后检验事件状态是否正确。与预期一样，测试用例失败 — 我并没有编写处理多个转换的触发器方法。代码修正包含一行非常重要的代码。清单 20 展示了状态机的核心：
<a name="listing20"></a><strong>清单 20. 状态机的核心</strong>
<table width="100%" border="0" cellspacing="0" cellpadding="0">
<tbody>
<tr>
<td>
<pre>def trigger(event)
    @state = events[event][:to]
  end

~/rspec batate$ spec machine_spec.rb
.....

Finished in 0.006511 seconds

5 examples, 0 failures</pre>
</td>
</tr>
</tbody>
</table>
&nbsp;

测试可以运行。这些粗糙的代码第一次演变为真正可以称之为状态机的东西。但是这还远远不够。目前，状态机缺乏严密性。不管状态如何，状态机都会触发事件。例如，当处于 <code>shopping</code> 状态时，触发 <code>:accept_card</code> 并不会转换为 <code>:success</code> 状态。您只能够从<code>:checking_out</code> 状态触发 <code>:accept_card</code>。在编程术语中，<code>trigger</code> 方法的范围应针对事件。我将编写一个测试来解决问题，然后修复 bug。我将编写一个负测试（negative test），即断言一个不应该出现的行为，如清单 21 所示：
<a name="listing21"></a><strong>清单 21: 负测试</strong>
<table width="100%" border="0" cellspacing="0" cellpadding="0">
<tbody>
<tr>
<td>
<pre>it "should not transition from :shopping to :success upon :accept_card" do
    @machine.events = {
       :checkout =&gt; {:from =&gt; :shopping, :to =&gt; :checking_out},
       :accept_card =&gt; {:from =&gt; :checking_out, :to =&gt; :success}
    }

    @machine.trigger(:accept_card)
    @machine.state.should_not == :success
  end

rspec batate$ spec machine_spec.rb
.....F

1)
'Machine should not transition from :shopping to :success upon :accept_card' FAILED
expected not == :success, got :success
./machine_spec.rb:47:

Finished in 0.006582 seconds

6 examples, 1 failure</pre>
</td>
</tr>
</tbody>
</table>
&nbsp;

现在可以再次运行测试，其中一个测试如预期一样运行失败。修复代码同样只有一行，如清单 22 所示：
<a name="listing22"></a><strong>清单 22. 修复 <code>trigger</code> 中的范围问题 </strong>
<table width="100%" border="0" cellspacing="0" cellpadding="0">
<tbody>
<tr>
<td>
<pre>def trigger(event)
    @state = events[event][:to] if state == events[event][:from]
  end

rspec batate$ spec machine_spec.rb
......

Finished in 0.006873 seconds

6 examples, 0 failures</pre>
</td>
</tr>
</tbody>
</table>
&nbsp;
<div> </div>
<a name="N10291"></a>组合代码

现在，我具有一个可简单运行的状态机。无论从哪方面来说，它都不是一个完美的程序。它还具有下面这些问题：
<ul>
	<li>状态散列实际上不具备任何功能。我应该根据状态对事件及其转换进行验证，或者将所有状态集中起来。后续需求很可能会要求这样做。</li>
	<li>某个既定事件只能存在于一个状态中。这种限制并不合理。例如，<code>submit</code> 和 <code>cancel</code> 事件可能需要处于多个状态。</li>
	<li>代码并不具备明显的面向对象特征。为使配置保持简单，我将大量数据置入散列中。后续的迭代会进一步驱动设计，使其朝面向对象设计方向发展。</li>
</ul>
但是，您还可以看到，这个状态机已经能够满足一些需求了。我还具备一个描述系统行为的文档，这是进行一系列测试的好起点。每个测试用例都支持系统的一个基本需求。事实上，通过运行 <code>spec machine_spec.rb --format specdoc</code>，您可以查看由系统规范组成的基本报告，如清单 23 所示：
<a name="listing23"></a><strong>清单 23. 查看规范</strong>
<table width="100%" border="0" cellspacing="0" cellpadding="0">
<tbody>
<tr>
<td>
<pre>spec machine_spec.rb --format specdoc

Machine
- should initially have a state of the first state
- should remember a list of valid states
- should remember a list of events with transitions
- should transition to :checking_out upon #trigger(:checkout) event
- should transition to :success upon #trigger(:accept_card)
- should not transition from :shopping to :success upon :accept_card

Finished in 0.006868 seconds</pre>
</td>
</tr>
</tbody>
</table>
&nbsp;

测试驱动方法并不适合所有人，但是越来越多的人开始使用这种技术，使用它构建具有灵活性和适应性的高质量代码，并且根据测试从头构建代码。当然，您也可以通过其他框架（如 test_unit）获得相同的优点。RSpec 还提供了优秀的实现方法。这种新测试框架的一大亮点就是代码的表示。新手尤其可以从这种行为驱动的测试方法中受益。请尝试使用该框架并告诉我您的感受。

参考资料

<strong>学习</strong>
<ul>
	<li>您可以参阅本文在 developerWorks 全球站点上的 <a href="http://www.ibm.com/developerworks/web/library/wa-rspec/index.html?S_CMP=cn-a-wa&amp;S_TACT=105AGX52" target="_blank">英文原文</a> 。</li>
	<li><a href="http://rspec.rubyforge.org/">RSpec</a> 是一种行为驱动框架，可增强 Ruby 中的测试驱动开发。</li>
	<li>Martin Fowler 有关 <a href="http://www.artima.com/intv/testdriven.html">Test Driven Development</a> 的访谈将进一步使您了解这种技术如此强大和高效的原因。</li>
	<li><a href="http://www.ruby-lang.org/en/">Ruby 主页</a> 提供了优秀的 Ruby 编程语言入门资料。</li>
	<li><a href="http://www.pragmaticprogrammer.com/title/fr_j2r/"><em>From Java to Ruby</em> </a>一书也由本文作者编写。Bruce Tate 提供了一份管理人员指南，解释了为什么 Ruby 语言对于某些业务问题来说非常重要。</li>
	<li><a href="http://www.ibm.com/developerworks/cn/web/wa-finitemach1/">有限状态机</a> 是一种软件概念，它将问题分为有限的状态，以及由事件触发的状态之间的转换。状态机构成了本文的基本内容。</li>
	<li>查看所有 developerWorks 的 <a href="http://www.ibm.com/developerworks/cn/downloads/">重要试用下载</a>。 </li>
	<li><a href="https://www.ibm.com/developerworks/cn/newsletter/">订阅</a> developerWorks Web 开发新闻。 </li>
	<li>从 <a href="http://www.ibm.com/developerworks/cn/views/web/articles.jsp">Web 开发专区的技术库</a> 获得更多 howto 文章。 </li>
</ul>
<strong>讨论</strong>
<ul>
	<li>加入 <a href="http://www.ibm.com/developerworks/community?S_CMP=cn-a-wa&amp;S_TACT=105AGX52">developerWorks 社区</a>：<a href="http://www.ibm.com/developerworks/blogs/?S_CMP=cn-a-wa&amp;S_TACT=105AGX52">blogs</a>、<a href="http://www.ibm.com/developerworks/forums?S_CMP=cn-a-wa&amp;S_TACT=105AGX52">论坛</a> 等。</li>
</ul>
