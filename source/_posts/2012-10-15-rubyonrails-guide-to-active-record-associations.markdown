---
layout: post
title: "Rubyonrails Guide to Active Record Associations"
date: 2011-11-29 15:31
comments: true
categories: ["rails"]
tags: ["guide", "rails", "ruby"]
---
## Rubyonrails Guide to Active Record Associations
<div>
<h1>Active Record</h1>
Active Record（中文名：活动记录）是一种领域模型模式，特点是一个模型类对应关系型数据库中的一个表，而模型类的一个实例对应表中的一行记录。Active Record 和Row Gateway （行记录入口）十分相似，但前者是领域模型，后者是一种数据源模式。关系型数据库往往通过外键来表述实体关系，Active Record 在数据源层面上也将这种关系映射为对象的关联和聚集。

Active Record 适合非常简单的领域需求，尤其在领域模型和数据库模型十分相似的情况下。如果遇到更加复杂的领域模型结构（例如用到继承、策略的领域模型），往往需要使用分离数据源的领域模型，结合Data Mapper （数据映射器）使用。

Active Record 驱动框架一般兼有ORM 框架的功能，但ActivActive Recorde Record 不是简单的ORM，正如和Row Gateway 的区别。著名的例子是全栈（Full Stack）Web 开发框架Ruby on Rails ，其默认使用一个纯Ruby 写成的<strong>Active</strong><strong> </strong><strong>Record</strong><strong> </strong><strong>框架</strong>来驱动MVC 中的模型层。

对象关系映射（ORM）提供了概念性的、易于理解的模型化数据的方法。ORM方法论基于三个核心原则：简单：以最基本的形式建模数据。传达性：数据库结构被任何人都能理解的语言文档化。精确性：基于数据模型创建正确标准化了的结构。

在Martin Fowler 的《企业应用架构模式》一书中曾详细叙述了本模式。

以下是著名的Active Record 驱动框架：

SQLObject(Python)

Ruby on Rails ActiveRecord (Ruby)

Yii Framework ActiveRecord (PHP)

Castle ActiveRecord (.NET)
<h2>Migrations</h2>
Migrations are a convenient way for you to alter移动your database in a structured and organized manner.Migrations是一种很便捷的方法让你能够以一种结构化的和有组织的方式来迁移你的数据库。You could edit fragments of SQL by hand but you would then be responsible for telling other developers that they need to go and run them.你可以手动编辑SQL片段，而且你有责任把这些告诉其他的开发人员，因为他们需要开发和使用它们。You’d also have to keep track of which changes need to be run against the production machines next time you deploy.你也可以跟踪对你部署的代码在接下来的production机器（将会）发生的变化。

Active Record tracks which migrations have already been run so all you have to do is update your source and run <tt>rake</tt><tt> </tt><tt>db:migrate</tt>.Active Record跟踪并迁移你已经运行过的（代码和数据），而你只需要在更新了你的源代码的时候执行<tt>rake</tt><tt> </tt><tt>db:migrate</tt><tt>。</tt>Active Record will work out which migrations should be run.Active Recor将会计算出那些迁移需要被执行。It will also update your <tt>db/schema.rb</tt> file to match the structure of your database.它还会更新你的<tt>db/schema.rb</tt><tt>文件使其于你的数据库结构相匹配。</tt>

Rails使用的是<strong>Active</strong><strong> </strong><strong>Record</strong><strong> </strong><strong>框架</strong>来处理数据迁移，这里笔者把ActiveRecord框架放在一个地方学习了，如需了解Migration部分需要直接阅读Migration部分。

&nbsp;
<h2>Active Record Validations and Callbacks 活动记录验证和回调</h2>
This guide teaches you how to hook勾子into the life cycle of your Active Record objects.这个教程指导你怎样挂接到你的Active Record objects的生存周期。You will learn how to validate the state of objects before they go into the database, and how to perform custom operations at certain points in the object life cycle.你将会学习到在将数据对象存入数据库之前怎样验证它们的状态，以及在对象生存周期的一些点上怎样执行定制操作。

Rails使用的是<strong>Active</strong><strong> </strong><strong>Record</strong><strong> </strong><strong>框架</strong>来处理验证和回调，这里笔者把ActiveRecord框架放在一个地方学习了，如需了解Migration部分需要直接阅读ValidationsandCallbacks部分。
<h2><strong>A</strong><strong> </strong><strong>Guide</strong><strong> </strong><strong>to</strong><strong> </strong><strong>Active</strong><strong> </strong><strong>Record</strong><strong> </strong><strong>Associations</strong></h2>
This guide covers the association features of Active Record. By referring to this guide, you will be able to:本教程涵盖了Active Record的关系部分的特性。（通过）这个教程提及的，你将能够：
<ul>
	<li>Declare associations between Active Record models 在Active Record的models中声明（它们的）关系</li>
	<li>Understand the various types of Active Record associations 明白各种类型的Active Record关系</li>
	<li>Use the methods added to your models by creating associations 通过添加方法到models（的形式）来创建关系</li>
</ul>
<h3><a name="why-associations"></a>1 Why Associations?为什么（会有）Associations</h3>
Why do we need associations between models? Because they make common operations simpler and easier in your code. For example, consider a simple Rails application that includes a model for customers and a model for orders. Each customer can have many orders. Without associations, the model declarations would look like this:为什么在models之间需要关系？因为它们使得在你的代码中大多数操作更加简单和容易。例如，思考一个简单的Rails应用程序其中包含一个customers的models和一个orders的模型（生产者和消费者模型）。每个消费者可以拥有多个生产者。没有associations（的话），模型声明看起来像这样：

classCustomer&lt;ActiveRecord::Base

end

classOrder&lt;ActiveRecord::Base

end

Now,suppose we wanted to add a new order for an existing customer.We’d need to do something like this:现在假设我们想为一个存在的customer添加一个新的order。我们需要做如下事情：

@order=Order.create(:order_date=&gt;Time.now,

:customer_id=&gt;@customer.id)

Or consider deleting a customer, and ensuring that all of its orders get deleted as well:或者考虑删除一个customer，那么确保它的所有的orders也被删除。

@orders = Order.where(:customer_id =&gt; @customer.id)

@orders.each do |order|

order.destroy

end

@customer.destroy

With Active Record associations, we can streamline these — and other — operations by declaratively声明方式telling Rails that there is a connection between the two models. Here’s the revised code for setting up customers and orders:通过Active Record associations，我们可以精简这样的或者其它（类似的）操作通过声明的方式告诉Rails在两个models之间有一个连接。这里修订代码来设定customers和orders：

class Customer &lt; ActiveRecord::Base

has_many :orders, :dependent =&gt; :destroy

end

&nbsp;

class Order &lt; ActiveRecord::Base

belongs_to :customer

end

With this change, creating a new order for a particular customer is easier:通过这样的修改，创建一个新的order给一个特定的customer更加容易：

<code>@order</code> <code>=</code><code> </code><code>@customer.orders.create(:order_date</code> <code>=&gt;</code><code> </code><code>Time.now)</code>

Deleting a customer and all of its orders is <em>much</em> easier:删除一个customer和它的所有的orders也容易了许多：

@customer.destroy

To learn more about the different types of associations, read the next section of this guide. That’s followed by some tips and tricks for working with associations, and then by a complete reference参考to the methods and options for associations in Rails.想要学习更多不同的类型的associations，阅读guide接下来的部分。这些（内容）伴随这一些在（使用）associations工作发现的tips和tricks，然后是一些Rails的associations的一些方法和options的一些完整的参考。
<h3><a name="the-types-of-associations"></a>2 The Types of Associations</h3>
In Rails, an <em>association</em> is a connection between two Active Record models. Associations are implemented using macro-style calls, so that you can declaratively add features to your models. For example, by declaring that one model <tt>belongs_to</tt> another, you instruct Rails to maintain Primary Key–Foreign Key information between instances of the two models, and you also get a number of utility methods added to your model. Rails supports six types of associations:在Rails，一个<em>association</em><em>是一个在两个</em><em></em><em>Active</em><em></em><em>Record模型之间的连接。</em><em>Associations（通过）使用宏方式的调用实施，以至于你可以（以）声明的方式添加</em><em>features到你的</em><em>models。例如申明一个</em><em>model</em><em></em><tt>belongs_to</tt><tt>另一个（模型）。</tt><tt>Rails</tt><tt>支持六种类型的</tt><tt>associations</tt><tt>：</tt>
<ul>
	<li><tt>belongs_to</tt></li>
	<li><tt>has_one</tt></li>
	<li><tt>has_many</tt></li>
	<li><tt>has_many</tt><tt> </tt><tt>:through</tt></li>
	<li><tt>has_one</tt><tt> </tt><tt>:through</tt></li>
	<li><tt>has_and_belongs_to_many</tt></li>
</ul>
<tt>In </tt><tt>the</tt><tt> remainder</tt><tt> of</tt><tt> this</tt><tt> guide,</tt><tt>you</tt><tt>’</tt><tt>ll </tt><tt>learn </tt><tt>how</tt><tt> to</tt><tt> declare</tt><tt> and</tt><tt> use</tt><tt> the </tt><tt>various</tt><tt> forms</tt><tt> of</tt><tt> associations.</tt><tt> But</tt><tt>first,</tt><tt>a</tt><tt> quick</tt><tt> introduction</tt><tt> to</tt><tt> the </tt><tt>situations </tt><tt>where</tt><tt> each </tt><tt>association</tt><tt> type</tt><tt> is</tt><tt> appropriate.</tt><tt>在这个</tt><tt>guide</tt><tt>的其他的部分，你将会学习到怎样申明和使用各种的形式的</tt><tt>associations</tt><tt>。但是首先，做一个快速的说明：每种类型的</tt><tt>association</tt><tt>在什么情况下出现。</tt>
<h4><a name="the-belongs_to-association1"></a>2.1 The <tt>belongs_to</tt> Association</h4>
A <tt>belongs_to</tt> association sets up a one-to-one connection with another model, such that each instance of the declaring model “belongs to” one instance of the other model. For example, if your application includes customers and orders, and each order can be assigned to exactly one customer, you’d declare the order model this way:一个<tt>belongs_to</tt><tt>关系设立一个</tt><tt>one-to-one</tt><tt>连接到另一个</tt><tt>model</tt><tt>，通过这样声明</tt><tt>model</tt><tt>的每一个实例</tt><tt>“</tt><tt>belongs</tt><tt> </tt><tt>to</tt><tt>” </tt><tt>另一个模型的实例。例如，如果你的应用程序包含</tt><tt>customers</tt><tt>和</tt><tt>orders</tt><tt>，并且每个</tt><tt>order</tt><tt>能够关联到仅仅一个</tt><tt>customer</tt><tt>，你可以这样的方式申明</tt><tt>order</tt><tt>模型：</tt>

<tt>class</tt><tt> </tt><tt>Order</tt><tt> </tt><tt>&lt;</tt><tt> </tt><tt>ActiveRecord::Base</tt>

<tt> </tt><tt>belongs_to</tt><tt> </tt><tt>:customer</tt>

<tt>end</tt>
<h4><a name="the-has_one-association"></a>2.2 The <tt>has_one</tt> Association</h4>
A <tt>has_one</tt> association also sets up a one-to-one connection with another model, but with somewhat different semantics语义(and consequences结果). This association indicates that each instance of a model contains or possesses one instance of another model. For example, if each supplier in your application has only one account, you’d declare the supplier model like this:

<a name="the-belongs_to-association"></a> 一个<tt>has_one</tt><tt>关系也设定一个</tt><tt>one-to-one</tt><tt>连接到另一个</tt><tt>model</tt><tt>，但是有某些不同的语义（和结果）。这个关系指出了（声明的）模型的每一个实例包含或拥有一个其他模型的实例。例如你的应用程序中的每一个</tt><tt>supplier</tt><tt>仅仅只有一个</tt><tt>account</tt><tt>，你可以这样声明</tt><tt>supplier</tt><tt>模型：</tt>

<tt>class</tt><tt> </tt><tt>Supplier</tt><tt> </tt><tt>&lt;</tt><tt> </tt><tt>ActiveRecord::Base</tt>

<tt> </tt><tt>has_one</tt><tt> </tt><tt>:account</tt>

<tt>end</tt>

&nbsp;
<h4><a name="the-has_many-association"></a>2.3 The <tt>has_many</tt> Association</h4>
A <tt>has_many</tt> association indicates a one-to-many connection with another model. You’ll often find this association on the “other side” of a <tt>belongs_to</tt> association. This association indicates that each instance of the model has zero or more instances of another model. For example, in an application containing customers and orders, the customer model could be declared like this:

一个<tt>has_many</tt><tt>关系指定了一个</tt><tt>one-to-many</tt><tt>连接到另一个</tt><tt>model</tt><tt>。你会经常发现这个关系在</tt><tt>belongs_to</tt><tt>关系的另一个端。这个关系指明了（声明）模型的每一个实例有零个或多个其它模型的实例。例如，在一个应用程序中包含</tt><tt>customers</tt><tt>和</tt><tt>orders</tt><tt>，</tt><tt>customer</tt><tt>模型如下声明：</tt>

<tt>class</tt><tt> </tt><tt>Customer</tt><tt> </tt><tt>&lt;</tt><tt> </tt><tt>ActiveRecord::Base</tt>

<tt> </tt><tt>has_many</tt><tt> </tt><tt>:orders</tt>

<tt>end</tt>

The name of the other model is pluralized多元化when declaring a <tt>has_many</tt> association.

&nbsp;
<h4><a name="the-has_many-through-association"></a>2.4 The <tt>has_many</tt><tt> </tt><tt>:through</tt> Association</h4>
A <tt>has_many</tt><tt> </tt><tt>:through</tt> association is often used to set up a many-to-many connection with another model. This association indicates that the declaring model can be matched with zero or more instances of another model by proceeding <em>through</em> a third model. For example, consider a medical practice where patients make appointments to see physicians. The relevant association declarations could look like this:

<tt>一个</tt><tt>has_many</tt><tt> </tt><tt>:through</tt><tt>关系通常用于设定一个</tt><tt>many-to-many</tt><tt>连接到另一个模型。这个关系指定申明的模型可以通过第三个模型（中间模型）匹配零个或多个另一个模型的实例。例如，想想一个医疗实践（例子）其中病人约定时间去看医生。它们的有关关系声明可以如下：</tt>

class Physician &lt; ActiveRecord::Base

has_many :appointments

has_many :patients, :through =&gt; :appointments#通过约会有多个病人

end

&nbsp;

class Appointment &lt; ActiveRecord::Base

belongs_to :physician

belongs_to :patient

end

&nbsp;

class Patient &lt; ActiveRecord::Base

has_many :appointments

has_many :physicians, :through =&gt; :appointments

end

The collection of join models can be managed via通过the API. For example, if you assign加入模型的集合可以通过API管理。例如，如果你指定

physician.patients = patients

new join models are created for newly associated关联的objects, and if some are gone their rows are deleted.

<em><strong>Automatic</strong></em><em><strong> </strong></em><em><strong>deletion</strong></em><em><strong> </strong></em><em><strong>of</strong></em><em><strong> </strong></em><em><strong>join</strong></em><em><strong> </strong></em><em><strong>models</strong></em><em><strong> </strong></em><em><strong>is</strong></em><em><strong> </strong></em><em><strong>direct,</strong></em><em><strong> </strong></em><em><strong>no</strong></em><em><strong> </strong></em><em><strong>destroy</strong></em><em><strong> </strong></em><em><strong>callbacks</strong></em><em><strong> </strong></em><em><strong>are</strong></em><em><strong> </strong></em><em><strong>triggered.</strong></em>

The <tt>has_many</tt><tt> </tt><tt>:through</tt> association is also useful for setting up “shortcuts” through nested <tt>has_many</tt> associations. For example, if a document has many sections, and a section has many paragraphs, you may sometimes want to get a simple collection of all paragraphs in the document. You could set that up this way:

<tt>has_many</tt><tt> </tt><tt>:through</tt><tt>关系也有利于设定</tt><tt>‘</tt><tt>快捷方式</tt><tt>’</tt><tt>通过嵌套</tt><tt>has_many</tt><tt>关系。</tt>

class Document &lt; ActiveRecord::Base

has_many :sections

has_many :paragraphs, :through =&gt; :sections

end

&nbsp;

class Section &lt; ActiveRecord::Base

belongs_to :document

has_many :paragraphs

end

&nbsp;

class Paragraph &lt; ActiveRecord::Base

belongs_to :section

end

With <tt>:through</tt><tt> </tt><tt>=&gt;</tt><tt> </tt><tt>:sections</tt> specified, Rails will now understand:因为<tt>:through</tt><tt> </tt><tt>=&gt;</tt><tt> </tt><tt>:sections</tt><tt>被指定，</tt><tt>Rails</tt><tt>现在将会明白如下（语句）：</tt>

<code>@document.paragraphs</code>
<h4><a name="the-has_one-through-association"></a>2.5 The <tt>has_one</tt><tt> </tt><tt>:through</tt> Association</h4>
A <tt>has_one</tt><tt> </tt><tt>:through</tt> association sets up a one-to-one connection with another model. This association indicates that the declaring model can be matched with one instance of another model by proceeding <em>through</em> a third model. For example, if each supplier has one account, and each account is associated with one account history, then the customer model could look like this:

一个<tt>has_one</tt><tt> </tt><tt>:through</tt><tt>关系设定一个</tt><tt>one-to-one</tt><tt>连接到另一个模型。这个关系指明声明的模型可以匹配另个模型的一个实例通过第三个模型（中间模型）。例如，如果每个</tt><tt>supplier</tt><tt>（供应商）有一个</tt><tt>account</tt><tt>，并且每个</tt><tt>account</tt><tt>关联一个</tt><tt>account</tt><tt> </tt><tt>history</tt><tt>，那么</tt><tt>customer</tt><tt>模型将会像这样：</tt>

<tt>class</tt><tt> </tt><tt>Supplier</tt><tt> </tt><tt>&lt;</tt><tt> </tt><tt>ActiveRecord::Base</tt>

<tt> </tt><tt>has_one</tt><tt> </tt><tt>:account</tt>

<tt> </tt><tt>has_one</tt><tt> </tt><tt>:account_history,</tt><tt> </tt><tt>:through</tt><tt> </tt><tt>=&gt;</tt><tt> </tt><tt>:account</tt>

<tt>end</tt>

&nbsp;

<tt>class</tt><tt> </tt><tt>Account</tt><tt> </tt><tt>&lt;</tt><tt> </tt><tt>ActiveRecord::Base</tt>

<tt> </tt><tt>belongs_to</tt><tt> </tt><tt>:supplier</tt>

<tt> </tt><tt>has_one</tt><tt> </tt><tt>:account_history</tt>

<tt>end</tt>

&nbsp;

<tt>class</tt><tt> </tt><tt>AccountHistory</tt><tt> </tt><tt>&lt;</tt><tt> </tt><tt>ActiveRecord::Base</tt>

<tt> </tt><tt>belongs_to</tt><tt> </tt><tt>:account</tt>

<tt>end</tt>

&nbsp;
<h4><a name="the-has_and_belongs_to_many-association"></a> 2.6 The <tt>has_and_belongs_to_many</tt> Association</h4>
A <tt>has_and_belongs_to_many</tt> association creates a direct many-to-many connection with another model, with no intervening干预model. For example, if your application includes assemblies and parts, with each assembly having many parts and each part appearing in many assemblies, you could declare the models this way:

<tt>一个</tt><tt>has_and_belongs_to_many</tt><tt>关系创建一个直接的</tt><tt>many-to-many</tt><tt>连接到另一个模型，没有干扰模型。例如，如果你的应用程序包含</tt><tt>assemblies</tt><tt>和</tt><tt>parts</tt><tt>，其中每个</tt><tt>assembly</tt><tt>拥有多个</tt><tt>parts</tt><tt>并且每个</tt><tt>part</tt><tt>发生在多个集会中，你可以以这样的方式声明模型：</tt>

<tt>class</tt><tt> </tt><tt>Assembly</tt><tt> </tt><tt>&lt;</tt><tt> </tt><tt>ActiveRecord::Base</tt>

<tt> </tt><tt>has_and_belongs_to_many</tt><tt> </tt><tt>:parts</tt>

<tt>end</tt>

&nbsp;

<tt>class</tt><tt> </tt><tt>Part</tt><tt> </tt><tt>&lt;</tt><tt> </tt><tt>ActiveRecord::Base</tt>

<tt> </tt><tt>has_and_belongs_to_many</tt><tt> </tt><tt>:assemblies</tt>

<tt>end</tt>

&nbsp;
<h4><a name="choosing-between-belongs_to-and-has_one"></a> 2.7 Choosing Between <tt>belongs_to</tt> and <tt>has_one</tt></h4>
If you want to set up a 1–1 relationship between two models, you’ll need to add <tt>belongs_to</tt> to one, and <tt>has_one</tt> to the other. How do you know which is which?

如果你想在两个模型间设定一个1-1的关系，你将需要添加belongs_to到一个（模型中），以及<tt>has_one</tt><tt>到另一个（模型中）。你是怎么知道谁是谁的呢？</tt>

<tt>The</tt><tt> </tt><tt>distinction</tt><tt>区别</tt><tt>is</tt><tt> </tt><tt>in</tt><tt> </tt><tt>where</tt><tt> </tt><tt>you</tt><tt> </tt><tt>place</tt><tt> </tt><tt>the</tt><tt> </tt><tt>foreign</tt><tt> </tt><tt>key</tt><tt> </tt><tt>(it</tt><tt> </tt><tt>goes</tt><tt> </tt><tt>on</tt><tt> </tt><tt>the</tt><tt> </tt><tt>table</tt><tt> </tt><tt>for</tt><tt> </tt><tt>the</tt><tt> </tt><tt>class</tt><tt> </tt><tt>declaring</tt><tt> </tt><tt>the</tt><tt> </tt><tt>belongs_to</tt><tt> </tt><tt>association),</tt><tt> </tt><tt>but</tt><tt> </tt><tt>you</tt><tt> </tt><tt>should</tt><tt> </tt><tt>give</tt><tt> </tt><tt>some</tt><tt> </tt><tt>thought</tt><tt> </tt><tt>to</tt><tt> </tt><tt>the</tt><tt> </tt><tt>actual</tt><tt> </tt><tt>meaning</tt><tt> </tt><tt>of</tt><tt> </tt><tt>the</tt><tt> </tt><tt>data</tt><tt> </tt><tt>as</tt><tt> </tt><tt>well.</tt><tt> </tt><tt><strong>The</strong></tt><tt><strong> </strong></tt><tt><strong>has_one</strong></tt><tt><strong> </strong></tt><tt><strong>relationship</strong></tt><tt><strong> </strong></tt><tt><strong>says</strong></tt><tt><strong> </strong></tt><tt><strong>that</strong></tt><tt><strong> </strong></tt><tt><strong>one</strong></tt><tt><strong> </strong></tt><tt><strong>of</strong></tt><tt><strong> </strong></tt><tt><strong>something</strong></tt><tt><strong> </strong></tt><tt><strong>is</strong></tt><tt><strong> </strong></tt><tt><strong>yours</strong></tt><tt><strong> – </strong></tt><tt><strong>that</strong></tt><tt><strong> </strong></tt><tt><strong>is,</strong></tt><tt><strong> </strong></tt><tt><strong>that</strong></tt><tt><strong> </strong></tt><tt><strong>something</strong></tt><tt><strong> </strong></tt><tt><strong>points</strong></tt><tt><strong> </strong></tt><tt><strong>back</strong></tt><tt><strong> </strong></tt><tt><strong>to</strong></tt><tt><strong> </strong></tt><tt><strong>you</strong></tt><tt>.</tt><tt> </tt><tt>For</tt><tt> </tt><tt>example,</tt><tt> </tt><tt>it</tt><tt> </tt><tt>makes</tt><tt> </tt><tt>more</tt><tt> </tt><tt>sense</tt><tt> </tt><tt>to</tt><tt> </tt><tt>say</tt><tt> </tt><tt>that</tt><tt> </tt><tt>a</tt><tt> </tt><tt>supplier</tt><tt> </tt><tt>owns</tt><tt> </tt><tt>an</tt><tt> </tt><tt>account</tt><tt> </tt><tt>than</tt><tt> </tt><tt>that</tt><tt> </tt><tt>an</tt><tt> </tt><tt>account</tt><tt> </tt><tt>owns</tt><tt> </tt><tt>a</tt><tt> </tt><tt>supplier.</tt><tt> </tt><tt>This</tt><tt> </tt><tt>suggests</tt><tt> </tt><tt>that</tt><tt> </tt><tt>the</tt><tt> </tt><tt>correct</tt><tt> </tt><tt>relationships</tt><tt> </tt><tt>are</tt><tt> </tt><tt>like</tt><tt> </tt><tt>this:</tt>

class Supplier &lt; ActiveRecord::Base

has_one :account

end

&nbsp;

class Account &lt; ActiveRecord::Base

belongs_to :supplier

end

The corresponding migration might look like this:

class CreateSuppliers &lt; ActiveRecord::Migration

def change

create_table :suppliers do |t|

t.string :name

t.timestamps

end

&nbsp;

create_table :accounts do |t|

t.integer :supplier_id

t.string :account_number

t.timestamps

end

end

end

<em>Using</em><em> </em><tt><em>t.integer</em></tt><tt><em> </em></tt><tt><em>:supplier_id</em></tt><em> </em><em>makes</em><em> </em><em>the</em><em> </em><em>foreign</em><em> </em><em>key</em><em> </em><em>naming</em><em> </em><em>obvious</em><em> </em><em>and</em><em> </em><em>explicit.</em><em> </em><em>In</em><em> </em><em>current</em><em> </em><em>versions</em><em> </em><em>of</em><em> </em><em>Rails,</em><em> </em><em>you</em><em> </em><em>can</em><em> </em><em>abstract</em><em> </em><em>away</em><em> </em><em>this</em><em> </em><em>implementation</em><em> </em><em>detail</em><em> </em><em>by</em><em> </em><em>using</em><em> </em><tt><em>t.references</em></tt><tt><em> </em></tt><tt><em>:supplier</em></tt><em> </em><em>instead.</em><em>使用</em><tt><em>t.integer</em></tt><tt><em> </em></tt><tt><em>:supplier_id</em></tt><tt><em>使得外建命名明显和精确。在当前版本的</em></tt><tt><em>Rails</em></tt><tt><em>，你可以抽象掉这个实施细节通过使用</em></tt><tt><em>t.references</em></tt><tt><em> </em></tt><tt><em>:supplier</em></tt><tt><em>替代。</em></tt>
<h4><a name="choosing-between-has_many-through-and-ha"></a> 2.8 Choosing Between <tt>has_many</tt><tt> </tt><tt>:through</tt> and <tt>has_and_belongs_to_many</tt></h4>
Rails offers two different ways to declare a many-to-many relationship between models. The simpler way is to use <tt>has_and_belongs_to_many</tt>, which allows you to make the association directly:

Rails提供了两种不同的方式来声明一个模型间的many-to-many关系。比较简单的方式使用<tt>has_and_belongs_to_many</tt><tt>，它允许你直接的（创建）关系：</tt>

class Assembly &lt; ActiveRecord::Base

has_and_belongs_to_many :parts

end

&nbsp;

class Part &lt; ActiveRecord::Base

has_and_belongs_to_many :assemblies

end

The second way to declare a many-to-many relationship is to use <tt>has_many</tt><tt> </tt><tt>:through</tt>. This makes the association indirectly, through a join model:

第二种方式是声明一个many-to-many关系使用<tt>has_many</tt><tt> </tt><tt>:through</tt><tt>，它可以使得关系间接的，同加入一个模型：</tt>

class Assembly &lt; ActiveRecord::Base

has_many :manifests

has_many :parts, :through =&gt; :manifests

end

&nbsp;

class Manifest &lt; ActiveRecord::Base

belongs_to :assembly

belongs_to :part

end

&nbsp;

class Part &lt; ActiveRecord::Base

has_many :manifests

has_many :assemblies, :through =&gt; :manifests

end

The simplest rule of thumb is that you should set up a <tt>has_many</tt><tt> </tt><tt>:through</tt> relationship if you need to work with the relationship model as an independent entity实体.If you don’t need to do anything with the relationship model, it may be simpler to set up a <tt>has_and_belongs_to_many</tt> relationship (though you’ll need to remember to create the joining table in the database).最简单的使用规则是，如果你需要使用关系模型作为依赖实体来工作你应该设定一个<tt>has_many</tt><tt> </tt><tt>:through</tt><tt>关系</tt>。

<strong>You</strong><strong> </strong><strong>should</strong><strong> </strong><strong>use</strong><strong> </strong><tt><strong>has_many</strong></tt><tt><strong>:through</strong></tt><strong> </strong><strong>if</strong><strong> </strong><strong>you</strong><strong> </strong><strong>need</strong><strong> </strong><strong>validations,</strong><strong> </strong><strong>callbacks,</strong><strong> </strong><strong>or</strong><strong> </strong><strong>extra</strong><strong> </strong><strong>attributes</strong><strong> </strong><strong>on</strong><strong> </strong><strong>the</strong><strong> </strong><strong>join</strong><strong> </strong><strong>model.</strong>
<h4><a name="polymorphic-associations"></a>2.9 Polymorphic Associations多元关系</h4>
A slightly more advanced twist on associations is the <em>polymorphic</em><em> </em><em>association</em>.一个略微先进的关系枢纽是多元关系。With polymorphic associations, a model can belong to more than one other model, on a single association. 通过多态关系，（在单个关系中）一个模型可以属于超过一个其他的模型。For example, you might have a picture model that belongs to either an employee model or a product model. Here’s how this could be declared:例如，你可能有一个picture模型属于一个employee或者一个product模型。这是它们如何被定义的：

class Picture &lt; ActiveRecord::Base

belongs_to :imageable, :polymorphic =&gt; true

end

&nbsp;

class Employee &lt; ActiveRecord::Base

has_many :pictures, :as =&gt; :imageable

end

&nbsp;

class Product &lt; ActiveRecord::Base

has_many :pictures, :as =&gt; :imageable

end

You can think of a polymorphic <tt>belongs_to</tt> declaration as setting up an interface that any other model can use. From an instance of the <tt>Employee</tt> model, you can retrieve a collection of pictures: <tt>@employee.pictures</tt>.

你可以认为一个多元<tt>belongs_to</tt><tt>声明相当于设定一个其它任何模型可以使用的接口。来源于</tt><tt>Employee</tt><tt>模型的实例，你可以检索一个</tt><tt>pictures</tt><tt>的集合：</tt><tt>@employee.pictures</tt><tt>。</tt>

Similarly, you can retrieve <tt>@product.pictures</tt>.相近的，你可以检索<tt>@product.pictures</tt><tt>。</tt>

If you have an instance of the <tt>Picture</tt> model, you can get to its parent via <tt>@picture.imageable</tt>. To make this work, you need to declare both a foreign key column and a type column in the model that declares the polymorphic interface:如果你有一个Picture模型的实例，你可以得到它的父模型通过<tt>@picture.imageable</tt><tt>。要使这些工作，你需要声明一个外键字段和一个什么多元（关系）的接口的字段：</tt>

<tt>class</tt><tt> </tt><tt>CreatePictures</tt><tt> </tt><tt>&lt;</tt><tt> </tt><tt>ActiveRecord::Migration</tt>

<tt> </tt><tt>def</tt><tt> </tt><tt>change</tt>

<tt> </tt><tt>create_table</tt><tt> </tt><tt>:pictures</tt><tt> </tt><tt>do</tt><tt> </tt><tt>|t|</tt>

<tt> </tt><tt>t.string</tt><tt> </tt><tt>:name</tt>

<tt> </tt><tt>t.integer</tt><tt> </tt><tt>:imageable_id</tt>

<tt> </tt><tt>t.string</tt><tt> </tt><tt>:imageable_type</tt>

<tt> </tt><tt>t.timestamps</tt>

<tt> </tt><tt>end</tt>

<tt> </tt><tt>end</tt>

<tt>end</tt>

<tt>This</tt><tt> </tt><tt>migration</tt><tt> </tt><tt>can</tt><tt> </tt><tt>be</tt><tt> </tt><tt>simplified</tt><tt> </tt><tt>by</tt><tt> </tt><tt>using</tt><tt> </tt><tt>the</tt><tt> </tt><tt>t.references</tt><tt> </tt><tt>form:</tt><tt>这个</tt><tt>migration</tt><tt>可以通过</tt><tt>t.references</tt><tt>形式简洁的（声明）：</tt>

<tt>class</tt><tt> </tt><tt>CreatePictures</tt><tt> </tt><tt>&lt;</tt><tt> </tt><tt>ActiveRecord::Migration</tt>

<tt> </tt><tt>def</tt><tt> </tt><tt>change</tt>

<tt> </tt><tt>create_table</tt><tt> </tt><tt>:pictures</tt><tt> </tt><tt>do</tt><tt> </tt><tt>|t|</tt>

<tt> </tt><tt>t.string</tt><tt> </tt><tt>:name</tt>

<tt> </tt><tt>t.references</tt><tt> </tt><tt>:imageable,</tt><tt> </tt><tt>:polymorphic</tt><tt> </tt><tt>=&gt;</tt><tt> </tt><tt>true</tt>

<tt> </tt><tt>t.timestamps</tt>

<tt> </tt><tt>end</tt>

<tt> </tt><tt>end</tt>

<tt>end</tt>
<h4><a name="self-joins"></a><tt>2.10</tt><tt> </tt><tt>Self</tt><tt> </tt><tt>Joins</tt></h4>
In designing a data model, you will sometimes find a model that should have a relation to itself. For example, you may want to store all employees in a single database model, but be able to trace relationships such as between manager and subordinates. This situation can be modeled with self-joining associations:在数据库设计中，有时你会发现一个模型具有一个（关联）到它自己的关系例如，你可能希望保存所有的employees在单个数据库模型中，但是能够跟踪关系比如在manager和subordinates之间。这个情况可以设定self-joining模型：

<tt>class</tt><tt> </tt><tt>Employee</tt><tt> </tt><tt>&lt;</tt><tt> </tt><tt>ActiveRecord::Base</tt>

<tt> </tt><tt>has_many</tt><tt> </tt><tt>:subordinates,</tt><tt> </tt><tt>:class_name</tt><tt> </tt><tt>=&gt;</tt><tt> </tt><tt>"Employee"</tt>

<tt> </tt><tt>belongs_to</tt><tt> </tt><tt>:manager,</tt><tt> </tt><tt>:class_name</tt><tt> </tt><tt>=&gt;</tt><tt> </tt><tt>"Employee",</tt>

<tt> </tt><tt>:foreign_key</tt><tt> </tt><tt>=&gt;</tt><tt> </tt><tt>"manager_id"</tt>

<tt>end</tt>

<tt>With</tt><tt> </tt><tt>this</tt><tt> </tt><tt>setup,</tt><tt> </tt><tt>you</tt><tt> </tt><tt>can</tt><tt> </tt><tt>retrieve</tt><tt> </tt><tt>@employee.subordinates</tt><tt> </tt><tt>and</tt><tt> </tt><tt>@employee.manager.</tt><tt>通过这个设定，你可以检索</tt><tt>@employee.subordinates</tt><tt> </tt><tt>and</tt><tt> </tt><tt>@employee.manager</tt><tt>。</tt>
<h3><a name="tips-tricks-and-warnings"></a><tt>3</tt><tt> </tt><tt>Tips</tt><tt>提示</tt><tt>,</tt><tt> </tt><tt>Tricks</tt><tt>窍门</tt><tt>,</tt><tt> </tt><tt>and</tt><tt> </tt><tt>Warnings</tt><tt>警告</tt></h3>
Here are a few things you should know to make efficient use of Active Record associations in your Rails applications:这里有一些事情你应该知道（它）使得在你的Rails应用程序使用Active Record关系变得高效：
<ul>
	<li><tt>Controlling</tt><tt>caching</tt><tt>控制缓存</tt></li>
	<li>Avoidingnamecollisions避免名称碰撞</li>
	<li>Updating the schema 更新结构</li>
	<li>Controlling association scope 控制关系范围</li>
</ul>
<h4><a name="controlling-caching"></a><tt>3.1</tt><tt> </tt><tt>Controlling</tt><tt> </tt><tt>Caching</tt></h4>
<a name="result_box"></a>All of the association methods are built around caching, which keeps the result of the most recent query available for further operations. The cache is even shared across methods. For example:所有的关系方法都创建在缓存周围，这使的最近的查询，可用于进一步的操作的结果。

customer.orders # retrieves orders from the database

customer.orders.size # uses the cached copy of orders

customer.orders.empty? # uses the cached copy of orders

But what if you want to reload the cache, because data might have been changed by some other part of the application? Just pass <tt>true</tt> to the association call:但是如果你想重载cache，因为数据可能被应用程序的其他部分改变？仅仅通过添加投入额到关系调用：

customer.orders # retrieves orders from the database

customer.orders.size # uses the cached copy of orders

customer.orders(true).empty? # discards the cached copy of orders

# and goes back to the database
<h4><a name="avoiding-name-collisions"></a><tt>3.2</tt><tt> </tt><tt>Avoiding</tt><tt> </tt><tt>Name</tt><tt> </tt><tt>Collisions</tt><tt>避免名称碰撞</tt></h4>
<tt>You</tt><tt> </tt><tt>are</tt><tt> </tt><tt>not</tt><tt> </tt><tt>free</tt><tt> </tt><tt>to</tt><tt> </tt><tt>use</tt><tt> </tt><tt>just</tt><tt> </tt><tt>any</tt><tt> </tt><tt>name</tt><tt> </tt><tt>for</tt><tt> </tt><tt>your</tt><tt> </tt><tt>associations.</tt><tt> </tt><tt>Because</tt><tt> </tt><tt>creating</tt><tt> </tt><tt>an</tt><tt> </tt><tt>association</tt><tt> </tt><tt>adds</tt><tt> </tt><tt>a</tt><tt> </tt><tt>method</tt><tt> </tt><tt>with</tt><tt> </tt><tt>that</tt><tt> </tt><tt>name</tt><tt> </tt><tt>to</tt><tt> </tt><tt>the</tt><tt> </tt><tt>model,</tt><tt> </tt><tt>it</tt><tt> </tt><tt>is</tt><tt> </tt><tt>a</tt><tt> </tt><tt>bad</tt><tt> </tt><tt>idea</tt><tt> </tt><tt>to</tt><tt> </tt><tt>give</tt><tt> </tt><tt>an</tt><tt> </tt><tt>association</tt><tt> </tt><tt>a</tt><tt> </tt><tt>name</tt><tt> </tt><tt>that</tt><tt> </tt><tt>is</tt><tt> </tt><tt>already</tt><tt> </tt><tt>used</tt><tt> </tt><tt>for</tt><tt> </tt><tt>an</tt><tt> </tt><tt>instance</tt><tt> </tt><tt>method</tt><tt> </tt><tt>of</tt><tt> </tt><tt>ActiveRecord::Base.</tt><tt> </tt><tt>The</tt><tt> </tt><tt>association</tt><tt> </tt><tt>method</tt><tt> </tt><tt>would</tt><tt> </tt><tt>override</tt><tt> </tt><tt>the</tt><tt> </tt><tt>base</tt><tt> </tt><tt>method</tt><tt> </tt><tt>and</tt><tt> </tt><tt>break</tt><tt> </tt><tt>things.</tt><tt> </tt><tt>For</tt><tt> </tt><tt>instance,</tt><tt> </tt><tt>attributes</tt><tt> </tt><tt>or</tt><tt> </tt><tt>connection</tt><tt> </tt><tt>are</tt><tt> </tt><tt>bad</tt><tt> </tt><tt>names</tt><tt> </tt><tt>for</tt><tt> </tt><tt>associations.</tt>

<tt>你不能不限制的给你的关系使用任何名字。因为创建一个关系添加一个方法和你命名的名字到模型，给一个关系取一个在</tt><tt>ActiveRecord::Base</tt><tt>实例方法中已经使用了的方法不是个好主意。这个关系方法将会覆盖原有方法和打断事情。比如实例，</tt><tt>attributes</tt><tt> </tt><tt>or</tt><tt> </tt><tt>connection</tt><tt>是关系的坏名称。</tt>
<h4><a name="updating-the-schema"></a><tt>3.3</tt><tt> </tt><tt>Updating</tt><tt> </tt><tt>the</tt><tt> </tt><tt>Schema</tt></h4>
Associations are extremely useful, but they are not magic. You are responsible for maintaining your database schema to match your associations. In practice, this means two things, depending on what sort of associations you are creating. For <tt>belongs_to</tt> associations you need to create foreign keys, and for <tt>has_and_belongs_to_many</tt> associations you need to create the appropriate join table.

<tt>关系相当有用，但是它们不是魔法。你有责任注意你的数据库结构和你的关系的匹配。在实际中，这意味这两件事，依赖于你创建的何种关系。对于</tt><tt>belongs_to</tt><tt>关系你需要创建外键，对应</tt><tt>has_and_belongs_to_many</tt><tt>关系你需要创建适当的（关系）加入表中。</tt>
<h5><a name="creating-foreign-keys-for-belongs_to-ass"></a> <tt>3.3.1</tt><tt> </tt><tt>Creating</tt><tt> </tt><tt>Foreign</tt><tt> </tt><tt>Keys</tt><tt> </tt><tt>for</tt><tt> </tt><tt>belongs_to</tt><tt> </tt><tt>Associations</tt></h5>
When you declare a <tt>belongs_to</tt> association, you need to create foreign keys as appropriate. For example, consider this model:当你声明一个<tt>belongs_to</tt><tt>关系，你需要创建一个外键（作为合适的方式来更新数据结构）。例如，思考如下模型：</tt>

<tt>class</tt><tt> </tt><tt>Order</tt><tt> </tt><tt>&lt;</tt><tt> </tt><tt>ActiveRecord::Base</tt>

<tt> </tt><tt>belongs_to</tt><tt> </tt><tt>:customer</tt>

<tt>end</tt>

<tt>This</tt><tt> </tt><tt>declaration</tt><tt> </tt><tt>needs</tt><tt> </tt><tt>to</tt><tt> </tt><tt>be</tt><tt> </tt><tt>backed</tt><tt> </tt><tt>up</tt><tt> </tt><tt>by</tt><tt> </tt><tt>the</tt><tt> </tt><tt>proper</tt><tt> </tt><tt>foreign</tt><tt> </tt><tt>key</tt><tt> </tt><tt>declaration</tt><tt> </tt><tt>on</tt><tt> </tt><tt>the</tt><tt> </tt><tt>orders</tt><tt> </tt><tt>table:</tt><tt>这个声明需要通过在生产者表单声明适当的外键备份。</tt>

<tt>class</tt><tt> </tt><tt>CreateOrders</tt><tt> </tt><tt>&lt;</tt><tt> </tt><tt>ActiveRecord::Migration</tt>

<tt> </tt><tt>def</tt><tt> </tt><tt>change</tt>

<tt> </tt><tt>create_table</tt><tt> </tt><tt>:orders</tt><tt> </tt><tt>do</tt><tt> </tt><tt>|t|</tt>

<tt> </tt><tt>t.datetime</tt><tt> </tt><tt>:order_date</tt>

<tt> </tt><tt>t.string</tt><tt> </tt><tt>:order_number</tt>

<tt> </tt><tt>t.integer</tt><tt> </tt><tt>:customer_id</tt>

<tt> </tt><tt>end</tt>

<tt> </tt><tt>end</tt>

<tt>end</tt>

If you create an association some time after you build the underlying底层model, you need to remember to create an <tt>add_column</tt> migration to provide the necessary foreign key.<strong>有时你创建的关系在你创建的底层模型之后，你需要记住创建一个</strong><strong>add_column</strong><strong> </strong><strong>migration</strong><strong>提供必须的外键。</strong>

&nbsp;

&nbsp;
<h5><a name="creating-join-tables-for-has_and_belongs"></a> 3.3.2 Creating Join Tables for <tt>has_and_belongs_to_many</tt> Associations</h5>
If you create a <tt>has_and_belongs_to_many</tt> association, you need to explicitly create the joining table. Unless the name of the join table is explicitly specified by using the <tt>:join_table</tt> option, Active Record creates the name by using the lexical order of the class names. So a join between customer and order models will give the default join table name of “customers_orders” because “c” outranks “o” in lexical ordering.

如果你创建了一个<tt>has_and_belongs_to_many</tt><tt>关系，你需要准确的创建</tt><tt>joining</tt><tt>表单。除非</tt><tt>join</tt><tt>表单使用</tt><tt>:join_table</tt><tt>选项准确的指定，（否则）</tt><tt>Active</tt><tt> </tt><tt>Record</tt><tt>就会使用类名提供的的词汇创建表单名称。因此一个在</tt><tt>customer</tt><tt>和</tt><tt>order</tt><tt>模型之间</tt><tt>join</tt><tt>（的表单）将会默认插入表名</tt><tt>“</tt><tt>customers_orders</tt><tt>”</tt><tt>因为</tt><tt>‘</tt><tt>c</tt><tt>’</tt><tt>在</tt><tt>‘</tt><tt>o</tt><tt>’</tt><tt>前面在提供的词汇中。</tt>

The precedence优先between model names is calculated using the <tt><strong>&lt;</strong></tt><strong> </strong><strong>operator</strong><strong> </strong><strong>for</strong><strong> </strong><tt><strong>String</strong></tt>. This means that if the strings are of different lengths, and the strings are equal when compared up to the shortest length, then the longer string is considered of higher lexical precedence than the shorter one. For example, one would expect the tables “<strong>paper</strong><strong>_</strong>boxes” and “<strong>paper</strong><strong>s</strong>” to generate a join table name of “papers_paper_boxes” because of the length of the name “paper_boxes”, but it in fact generates a join table name of “paper_boxes_papers” (because the underscore ‘_’ is lexicographically字典<em>less</em> than ‘s’ in common encodings).

Whatever the name, you must manually手动generate the join table with an appropriate migration. For example, consider these associations:

class Assembly &lt; ActiveRecord::Base

has_and_belongs_to_many :parts

end

&nbsp;

class Part &lt; ActiveRecord::Base

has_and_belongs_to_many :assemblies

end

These need to be backed up by a migration to create the <tt>assemblies_parts</tt> table. This table should be created without a primary key:

class CreateAssemblyPartJoinTable &lt; ActiveRecord::Migration

def change

create_table :assemblies_parts, :<strong>id</strong><strong> </strong><strong>=&gt;</strong><strong> </strong><strong>false</strong> do |t|

t.integer :assembly_id

t.integer :part_id

end

end

end

We pass <tt>:id</tt><tt> </tt><tt>=&gt;</tt><tt> </tt><tt>false</tt> to <tt>create_table</tt> because that table does not represent表示a model. That’s required for the association to work properly. If you observe观察any strange behavior in a <tt>has_and_belongs_to_many</tt> association like mangled错误models IDs, or exceptions about conflicting IDs chances are you forgot that bit.
<h4><a name="controlling-association-scope"></a>3.4 Controlling Association Scope控制关系范围</h4>
By default, associations look for objects only within the current module’s scope. This can be important when you declare Active Record models within a module. For example:默认情况，（通过）关系查找对象仅仅在当前模型范围中。这很重要点你在一个module中声明Active Record models例如：

module MyApplication

module Business

class Supplier &lt; ActiveRecord::Base

has_one :account

end

&nbsp;

class Account &lt; ActiveRecord::Base

belongs_to :supplier

end

end

end

This will work fine, because both the <tt>Supplier</tt> and the <tt>Account</tt> class are defined within the same scope.<strong> </strong><strong>But</strong><strong> </strong><strong>the</strong><strong> </strong><strong>following</strong><strong> </strong><strong>will</strong><strong> </strong><em><strong>not</strong></em><strong> </strong><strong>work,</strong><strong> </strong><strong>because</strong><strong> </strong><tt><strong>Supplier</strong></tt><strong> </strong><strong>and</strong><strong> </strong><tt><strong>Account</strong></tt><strong> </strong><strong>are</strong><strong> </strong><strong>defined</strong><strong> </strong><strong>in</strong><strong> </strong><strong>different</strong><strong> </strong><strong>scopes:</strong>

module MyApplication

module Business

class Supplier &lt; ActiveRecord::Base

has_one :account

end

end

&nbsp;

module Billing

class Account &lt; ActiveRecord::Base

belongs_to :supplier

end

end

end

<strong>To</strong><strong> </strong><strong>associate</strong><strong> </strong><strong>a</strong><strong> </strong><strong>model</strong><strong> </strong><strong>with</strong><strong> </strong><strong>a</strong><strong> </strong><strong>model</strong><strong> </strong><strong>in</strong><strong> </strong><strong>a</strong><strong> </strong><strong>different</strong><strong> </strong><strong>namespace,</strong><strong> </strong><strong>you</strong><strong> </strong><strong>must</strong><strong> </strong><strong>specify</strong><strong> </strong><strong>the</strong><strong> </strong><strong>complete</strong><strong> </strong><strong>class</strong><strong> </strong><strong>name</strong><strong> </strong><strong>in</strong><strong> </strong><strong>your</strong><strong> </strong><strong>association</strong><strong> </strong><strong>declaration</strong>:

module MyApplication

module Business

class Supplier &lt; ActiveRecord::Base

has_one :account,

:class_name =&gt; "MyApplication::Billing::Account"

end

end

&nbsp;

module Billing

class Account &lt; ActiveRecord::Base

belongs_to :supplier,

:class_name =&gt; "MyApplication::Business::Supplier"

end

end

end
<h3><a name="detailed-association-reference"></a>4 Detailed Association Reference具体关系参考</h3>
The following sections give the details of each type of association, including the methods that they add and the options that you can use when declaring an association.接下来的部分给出了每种关系的具体的介绍，包含当你声明一个关系时可以使用的（这些关系）添加的方法和选项。
<h5><a name="methods-added-by-belongs_to"></a>4.1.1 Methods Added by <tt>belongs_to</tt></h5>
When you declare a <tt>belongs_to</tt> association, the declaring class automatically gains受益four methods related to the association:
<ul>
	<li><em>association</em><tt>(force_reload</tt><tt> </tt><tt>=</tt><tt> </tt><tt>false)</tt><em> </em></li>
	<li><em>association</em><tt>=(associate)</tt></li>
	<li><tt>build_</tt><em>association</em><tt>(attributes</tt><tt> </tt><tt>=</tt><tt> </tt><tt>{})</tt></li>
	<li><tt>create_</tt><em>association</em><tt>(attributes</tt><tt> </tt><tt>=</tt><tt> </tt><tt>{})</tt></li>
</ul>
In all of these methods, <em>association</em> is replaced with the symbol passed as the first argument to <tt>belongs_to</tt>. For example, given the declaration:

class Order &lt; ActiveRecord::Base

belongs_to :customer

end

Each instance of the order model生产者模型will have these methods:

<code>customer</code>

<code>customer=</code>

<code>build_customer</code>

<code>create_customer</code>

&nbsp;

When initializing a new <tt>has_one</tt> or <tt>belongs_to</tt> association you must use the <tt>build_</tt> prefix构造前缀to build the association, rather than the <tt>association.</tt><tt> </tt><tt>build</tt> method that would be used for <tt>has_many</tt> or <tt>has_and_belongs_to_many</tt> associations. To create one, use the <tt>create_</tt> prefix新建前缀.
<h6><a name="belongs_to-association"></a>4.1.1.1 <em>association</em><tt>(force_reload</tt><tt> </tt><tt>=</tt><tt> </tt><tt>false)</tt></h6>
<strong>The</strong><strong> </strong><em><strong>association</strong></em><strong> </strong><strong>method</strong><strong> </strong><strong>returns</strong><strong> </strong><strong>the</strong><strong> </strong><strong>associated</strong><strong> </strong><strong>object,</strong> if any. If no associated object is found, it <strong>returns</strong><strong> </strong><tt><strong>nil</strong></tt>.

@customer = @order.customer

If the associated object has already been retrieved检索from the database for this object, the cached version will be returned. <strong>To</strong><strong> </strong><strong>override</strong><strong> </strong><strong>this</strong><strong> </strong><strong>behavior</strong><strong> </strong><strong>(and</strong><strong> </strong><strong>force</strong><strong> </strong><strong>a</strong><strong> </strong><strong>database</strong><strong> </strong><strong>read),</strong><strong> </strong><strong>pass</strong><strong> </strong><tt><strong>true</strong></tt><strong> </strong><strong>as</strong><strong> </strong><strong>the</strong><strong> </strong><tt><strong>force_reload</strong></tt><strong> </strong><strong>argument.</strong>
<h6><a name="belongs_to-association_equal"></a>4.1.1.2 <em>association</em><tt>=(associate)</tt></h6>
<strong>The</strong><strong> </strong><em><strong>association</strong></em><tt><strong>=</strong></tt><strong> </strong><strong>method</strong><strong> </strong><strong>assigns</strong><strong> </strong><strong>an</strong><strong> </strong><strong>associated</strong><strong> </strong><strong>object</strong><strong> </strong><strong>to</strong><strong> </strong><strong>this</strong><strong> </strong><strong>object.</strong> Behind the scenes, this means <strong>extracting</strong><strong> </strong><strong>the</strong><strong> </strong><strong>primary</strong><strong> </strong><strong>key</strong><strong> </strong><strong>from</strong><strong> </strong><strong>the</strong><strong> </strong><strong>associate</strong><strong> </strong><strong>object</strong><strong> </strong><strong>and</strong><strong> </strong><strong>setting</strong><strong> </strong><strong>this</strong><strong> </strong><strong>object</strong><strong>’</strong><strong>s</strong><strong> </strong><strong>foreign</strong><strong> </strong><strong>key</strong><strong> </strong><strong>to</strong><strong> </strong><strong>the</strong><strong> </strong><strong>same</strong><strong> </strong><strong>value.</strong>

@order.customer = @customer
<h6><a name="belongs_to-build_association"></a>4.1.1.3 <tt>build_</tt><em>association</em><tt>(attributes</tt><tt> </tt><tt>=</tt><tt> </tt><tt>{})</tt></h6>
The <tt>build_</tt><em>association</em> method returns a new object of the associated type. This object will be instantiated from the passed attributes, and the link through this object’s foreign key will be set, but the associated object will <em>not</em> yet be saved.

@customer = @order.build_customer(:customer_number =&gt; 123,

:customer_name =&gt; "John Doe")
<h6><a name="belongs_to-create_association"></a>4.1.1.4 <tt>create_</tt><em>association</em><tt>(attributes</tt><tt> </tt><tt>=</tt><tt> </tt><tt>{})</tt></h6>
The <tt>create_</tt><em>association</em> method returns a new object of the associated type. This object will be instantiated from the passed attributes, and the link through this object’s foreign key will be set. In addition, the associated object <em>will</em> be saved (assuming that it passes any validations).

@customer = @order.create_customer(:customer_number =&gt; 123,

:customer_name =&gt; "John Doe")
<h5><a name="options-for-belongs_to"></a>4.1.2 Options for <tt>belongs_to</tt></h5>
In many situations, you can use the default behavior of <tt>belongs_to</tt> without any customization. But despite尽管Rails’ emphasis强调of convention公约over customization, you can alter that behavior in a number of ways. This section covers the options that you can pass when you create a <tt>belongs_to</tt> association. For example, an association with several options might look like this:

class Order &lt; ActiveRecord::Base

belongs_to :customer, :counter_cache =&gt; true,

:conditions =&gt; "active = 1"

end

The <tt>belongs_to</tt> association supports these options:
<ul>
	<li><tt>:autosave</tt></li>
	<li><tt>:class_name</tt></li>
	<li><tt>:conditions</tt> 条件</li>
	<li><tt>:counter_cache</tt></li>
	<li><tt>:dependent</tt></li>
	<li><tt>:foreign_key</tt></li>
	<li><tt>:include</tt></li>
	<li><tt>:polymorphic</tt> 多元</li>
	<li><tt>:readonly</tt></li>
	<li><tt>:select</tt></li>
	<li><tt>:touch</tt></li>
	<li><tt>:validate</tt></li>
</ul>
<h6><a name="belongs_to-autosave"></a>4.1.2.1 <tt>:autosave</tt></h6>
If you set the <tt>:autosave</tt> option to <tt>true</tt>, Rails will save any loaded members and destroy members that are marked for destruction whenever you save the parent object.
<h6><a name="belongs_to-class_name"></a>4.1.2.2 <tt>:class_name</tt></h6>
If the name of the other model cannot be derived from the association name, you can use the <tt>:class_name</tt> option to supply the model name. For example, if an order belongs to a customer, but the actual name of the model containing customers is <tt>Patron</tt>, you’d set things up this way:
<h6><a name="belongs_to-conditions"></a>4.1.2.3 <tt>:conditions</tt></h6>
The <tt>:conditions</tt> option lets you specify the conditions that the associated object must meet (in the syntax used by an SQL <tt>WHERE</tt> clause).

class Order &lt; ActiveRecord::Base

belongs_to :customer, :conditions =&gt; "active = 1"

end
<h6><a name="belongs_to-counter_cache"></a>4.1.2.4 <tt>:counter_cache</tt></h6>
The <tt>:counter_cache</tt> option can be used to make finding the number of belonging objects more efficient. Consider these models:

class Order &lt; ActiveRecord::Base

belongs_to :customer

end

class Customer &lt; ActiveRecord::Base

has_many :orders

end

With these declarations, asking for the value of <tt>@customer.orders.size</tt> requires making a call to the database to perform a <tt>COUNT(*)</tt> query. To avoid this call, you can add a counter cache to the <em>belonging</em> model:

class Order &lt; ActiveRecord::Base

belongs_to :customer, :counter_cache =&gt; true

end

class Customer &lt; ActiveRecord::Base

has_many :orders

end

<strong>With</strong><strong> </strong><strong>this</strong><strong> </strong><strong>declaration,</strong><strong> </strong><strong>Rails</strong><strong> </strong><strong>will</strong><strong> </strong><strong>keep</strong><strong> </strong><strong>the</strong><strong> </strong><strong>cache</strong><strong> </strong><strong>value</strong><strong> </strong><strong>up</strong><strong> </strong><strong>to</strong><strong> </strong><strong>date,</strong><strong> </strong><strong>and</strong><strong> </strong><strong>then</strong><strong> </strong><strong>return</strong><strong> </strong><strong>that</strong><strong> </strong><strong>value</strong><strong> </strong><strong>in</strong><strong> </strong><strong>response</strong><strong> </strong><strong>to</strong><strong> </strong><strong>the</strong><strong> </strong><tt><strong>size</strong></tt><strong> </strong><strong>method.</strong>

Although the <tt>:counter_cache</tt> option is specified on the model that includes the <tt>belongs_to</tt> declaration, the actual column must be added to the <em>associated</em> model. In the case above, you would need to add a column named <tt>orders_count</tt> to the <tt>Customer</tt> model. You can override the default column name if you need to:

class Order &lt; ActiveRecord::Base

belongs_to :customer, :counter_cache =&gt; :count_of_orders

end

class Customer &lt; ActiveRecord::Base

has_many :orders

end

Counter cache columns are added to the containing model’s list of read-only attributes through <tt>attr_readonly</tt>.
<h6><a name="belongs_to-dependent"></a>4.1.2.5 <tt>:dependent</tt></h6>
<strong>If</strong><strong> </strong><strong>you</strong><strong> </strong><strong>set</strong><strong> </strong><strong>the</strong><strong> </strong><tt><strong>:dependent</strong></tt><strong> </strong><strong>option</strong><strong> </strong><strong>to</strong><strong> </strong><tt><strong>:destroy</strong></tt><strong>,</strong><strong> </strong><strong>then</strong><strong> </strong><strong>deleting</strong><strong> </strong><strong>this</strong><strong> </strong><strong>object</strong><strong> </strong><strong>will</strong><strong> </strong><strong>call</strong><strong> </strong><strong>the</strong><strong> </strong><tt><strong>destroy</strong></tt><strong> </strong><strong>method</strong><strong> </strong><strong>on</strong><strong> </strong><strong>the</strong><strong> </strong><strong>associated</strong><strong> </strong><strong>object</strong><strong> </strong><strong>to</strong><strong> </strong><strong>delete</strong><strong> </strong><strong>that</strong><strong> </strong><strong>object.</strong><strong> </strong>If <strong>you</strong><strong> </strong><strong>set</strong><strong> </strong><strong>the</strong><strong> </strong><tt><strong>:dependent</strong></tt><strong> </strong><strong>option</strong><strong> </strong><strong>to</strong><strong> </strong><tt><strong>:delete</strong></tt><strong>,</strong><strong> </strong><strong>then</strong><strong> </strong><strong>deleting</strong><strong> </strong><strong>this</strong><strong> </strong><strong>object</strong><strong> </strong><strong>will</strong><strong> </strong><strong>delete</strong><strong> </strong><strong>the</strong><strong> </strong><strong>associated</strong><strong> </strong><strong>object</strong><strong> </strong><em><strong>without</strong></em><strong> </strong><strong>calling</strong><strong> </strong><strong>its</strong><strong> </strong><tt><strong>destroy</strong></tt><strong> </strong><strong>method</strong>.

You should not specify this option on a <tt>belongs_to</tt> association that is connected with a <tt>has_many</tt> association on the other class. Doing so can lead to orphaned records in your database.对应多个的话用了dependent的话删除一个和他的外键的话其他关联就失效了
<h6><a name="belongs_to-foreign_key"></a>4.1.2.6 <tt>:foreign_key</tt></h6>
By convention约定, Rails guesses that the column used to hold the foreign key on this model is the name of the association with the suffix <tt>_id</tt> added. The <tt>:foreign_key</tt> option lets you set the name of the foreign key directly:

class Order &lt; ActiveRecord::Base

belongs_to :customer, :class_name =&gt; "Patron",

:foreign_key =&gt; "patron_id"

end

In any case, Rails will not create foreign key columns for you. You need to explicitly define them as part of your migrations.
<h6><a name="belongs_to-includes"></a>4.1.2.7 <tt>:include</tt></h6>
You can use the <tt>:include</tt> option to specify second-order associations that should be eager-loaded when this association is used. For example, consider these models:

class LineItem &lt; ActiveRecord::Base

belongs_to :order

end

&nbsp;

class Order &lt; ActiveRecord::Base

belongs_to :customer

has_many :line_items

end

&nbsp;

class Customer &lt; ActiveRecord::Base

has_many :orders

end

If you frequently retrieve customers directly from line items (<tt>@line_item.order.customer</tt>), then you can make your code somewhat more efficient by including customers in the association from line items to orders:如果你频繁的从line_item（<tt>@line_item.order.customer</tt>）直接检索，那么你可以在line_item关系中包含customers，使得你的代码变得更加有效率：

class LineItem &lt; ActiveRecord::Base

belongs_to :order, :include =&gt; :customer

end

&nbsp;

class Order &lt; ActiveRecord::Base

belongs_to :customer

has_many :line_items

end

&nbsp;

class Customer &lt; ActiveRecord::Base

has_many :orders

end

There’s no need to use <tt>:include</tt> for immediate立即（直接）associations – that is, if you have <tt>Order</tt><tt> </tt><tt>belongs_to</tt><tt> </tt><tt>:customer</tt>, then the customer is eager-loaded automatically when it’s needed.
<h6><a name="belongs_to-polymorphic"></a>4.1.2.8 <tt>:polymorphic</tt></h6>
Passing <tt>true</tt> to the <tt>:polymorphic</tt> option indicates that this is a polymorphic association. Polymorphic associations were discussed in detail <a href="http://guides.rubyonrails.org/association_basics.html#polymorphic-associations">earlierinthisguide</a>.
<h6><a name="belongs_to-readonly"></a>4.1.2.9 <tt>:readonly</tt></h6>
If you set the <tt>:readonly</tt> option to <tt>true</tt>, then the associated object will be read-only when retrieved via the association.
<h6><a name="belongs_to-select"></a>4.1.2.10 <tt>:select</tt></h6>
The <tt>:select</tt> option lets you override the SQL <tt>SELECT</tt> clause that is used to retrieve data about the associated object. By default, Rails retrieves all columns.

If you set the <tt>:select</tt> option on a <tt>belongs_to</tt> association, you should also set the <tt>foreign_key</tt> option to guarantee保证the correct results.
<h6><a name="belongs_to-touch"></a>4.1.2.11 <tt>:touch</tt></h6>
<strong>If</strong><strong> </strong><strong>you</strong><strong> </strong><strong>set</strong><strong> </strong><strong>the</strong><strong> </strong><tt><strong>:touch</strong></tt><strong> </strong><strong>option</strong><strong> </strong><strong>to</strong><strong> </strong><tt><strong>:true</strong></tt><strong>,</strong><strong> </strong><strong>then</strong><strong> </strong><strong>the</strong><strong> </strong><tt><strong>updated_at</strong></tt><strong> </strong><strong>or</strong><strong> </strong><tt><strong>updated_on</strong></tt><strong> </strong><strong>timestamp</strong><strong> </strong><strong>on</strong><strong> </strong><strong>the</strong><strong> </strong><strong>associated</strong><strong> </strong><strong>object</strong><strong> </strong><strong>will</strong><strong> </strong><strong>be</strong><strong> </strong><strong>set</strong><strong> </strong><strong>to</strong><strong> </strong><strong>the</strong><strong> </strong><strong>current</strong><strong> </strong><strong>time</strong><strong> </strong><strong>whenever</strong><strong> </strong><strong>this</strong><strong> </strong><strong>object</strong><strong> </strong><strong>is</strong><strong> </strong><strong>saved</strong><strong> </strong><strong>or</strong><strong> </strong><strong>destroyed</strong>:

class Order &lt; ActiveRecord::Base

belongs_to :customer, :touch =&gt; true

end

&nbsp;

class Customer &lt; ActiveRecord::Base

has_many :orders

end

In this case, saving or destroying an order will update the timestamp on the associated customer. You can also specify a particular timestamp attribute to update:

class Order &lt; ActiveRecord::Base

belongs_to :customer, :touch =&gt; :orders_updated_at

end
<h6><a name="belongs_to-validate"></a>4.1.2.12 <tt>:validate</tt></h6>
<strong>If</strong><strong> </strong><strong>you</strong><strong> </strong><strong>set</strong><strong> </strong><strong>the</strong><strong> </strong><tt><strong>:validate</strong></tt><strong> </strong><strong>option</strong><strong> </strong><strong>to</strong><strong> </strong><tt><strong>true</strong></tt><strong>,</strong><strong> </strong><strong>then</strong><strong> </strong><strong>associated</strong><strong> </strong><strong>objects</strong><strong> </strong><strong>will</strong><strong> </strong><strong>be</strong><strong> </strong><strong>validated</strong><strong> </strong><strong>whenever</strong><strong> </strong><strong>you</strong><strong> </strong><strong>save</strong><strong> </strong><strong>this</strong><strong> </strong><strong>object.</strong> By default, this is <tt>false</tt>: associated objects will not be validated when this object is saved.
<h5><a name="belongs_to-how_to_know_whether_theres_an"></a> 4.1.3 How To Know Whether There’s an Associated Object?怎样知道这里是否有Associated 对象?</h5>
To know whether there’s and associated object just check <em>association</em><tt>.nil?</tt>:

if @order.customer.nil?

@msg = "No customer found for this order"

end
<h5><a name="belongs_to-when_are_objects_saved"></a>4.1.4 When are Objects Saved?</h5>
<strong>Assigning</strong><strong> </strong><strong>an</strong><strong> </strong><strong>object</strong><strong> </strong><strong>to</strong><strong> </strong><strong>a</strong><strong> </strong><tt><strong>belongs_to</strong></tt><strong> </strong><strong>association</strong><strong> </strong><strong>does</strong><strong> </strong><em><strong>not</strong></em><strong> </strong><strong>automatically</strong><strong> </strong><strong>save</strong><strong> </strong><strong>the</strong><strong> </strong><strong>object.</strong> It does not save the associated object either.
<h4><a name="has_one-association-reference"></a>4.2 <tt>has_one</tt> Association Reference <tt>has_one</tt><tt>关系</tt>参考</h4>
The <tt>has_one</tt> association creates a one-to-one match with another model. In database terms, this association says that the other class contains the foreign key. If this class contains the foreign key, then you should use <tt>belongs_to</tt> instead.
<h5><a name="methods-added-by-has_one"></a>4.2.1 Methods Added by <tt>has_one</tt></h5>
When you declare a <tt>has_one</tt> association, the declaring class automatically gains four methods related to the association:
<ul>
	<li><tt>association</tt><tt>(force_reload</tt><tt> </tt><tt>=</tt><tt> </tt><tt>false)</tt><em> </em></li>
	<li><em>association</em><tt>=(associate)</tt></li>
	<li><tt>build_</tt><em>association</em><tt>(attributes</tt><tt> </tt><tt>=</tt><tt> </tt><tt>{})</tt></li>
	<li><tt>create_</tt><em>association</em><tt>(attributes</tt><tt> </tt><tt>=</tt><tt> </tt><tt>{})</tt></li>
</ul>
In all of these methods, <em>association</em> is replaced with the symbol passed as the first argument to <tt>has_one</tt>. For example, given the declaration:

class Supplier &lt; ActiveRecord::Base

has_one :account

end

Each instance of the <tt>Supplier</tt> model will have these methods:每一个Supplier模型的实例将会具有如下方法：

<code>account</code>

<code>account=</code>

<code>build_account</code>

<code>create_account</code>

When initializing a new <tt>has_one</tt> or <tt>belongs_to</tt> association you must use the <tt>build_</tt> prefix to build the association, rather than the <tt>association.build</tt> method that would be used for <tt>has_many</tt> or <tt>has_and_belongs_to_many</tt> associations. To create one, use the <tt>create_</tt> prefix.
<h6><a name="has_one-association"></a>4.2.1.1 <em>association</em><tt>(force_reload</tt><tt> </tt><tt>=</tt><tt> </tt><tt>false)</tt></h6>
The <em>association</em> method returns the associated object, if any. If no associated object is found, it returns <tt>nil</tt>.

@account = @supplier.account

If the associated object has already been retrieved from the database for this object, the cached version will be returned. To override this behavior (and force a database read), pass <tt>true</tt> as the <tt>force_reload</tt> argument.
<h6><a name="has_one-association_equal"></a>4.2.1.2 <em>association</em><tt>=(associate)</tt></h6>
The <em>association</em><tt>=</tt> method assigns an associated object to this object. Behind the scenes, this means extracting the primary key from this object and setting the associate object’s foreign key to the same value.

@supplier.account = @account
<h6><a name="has_one-build_association"></a>4.2.1.3 <tt>build_</tt><em>association</em><tt>(attributes</tt><tt> </tt><tt>=</tt><tt> </tt><tt>{})</tt></h6>
The <tt>build_</tt><em>association</em> method returns a new object of the associated type. <strong>This</strong><strong> </strong><strong>object</strong><strong> </strong><strong>will</strong><strong> </strong><strong>be</strong><strong> </strong><strong>instantiated</strong><strong> </strong><strong>from</strong><strong> </strong><strong>the</strong><strong> </strong><strong>passed</strong><strong> </strong><strong>attributes,</strong><strong> </strong><strong>and</strong><strong> </strong><strong>the</strong><strong> </strong><strong>link</strong><strong> </strong><strong>through</strong><strong> </strong><strong>its</strong><strong> </strong><strong>foreign</strong><strong> </strong><strong>key</strong><strong> </strong><strong>will</strong><strong> </strong><strong>be</strong><strong> </strong><strong>set,</strong><strong> </strong><strong>but</strong><strong> </strong><strong>the</strong><strong> </strong><strong>associated</strong><strong> </strong><strong>object</strong><strong> </strong><strong>will</strong><strong> </strong><em><strong>not</strong></em><strong>yet</strong><strong>be</strong><strong>saved</strong><strong>.</strong>

@account = @supplier.build_account(:terms =&gt; "Net 30")
<h6><a name="has_one-create_association"></a>4.2.1.4 <tt>create_</tt><em>association</em><tt>(attributes</tt><tt> </tt><tt>=</tt><tt> </tt><tt>{})</tt></h6>
The <tt>create_</tt><em>association</em> method returns a new object of the associated type. This object will be instantiated from the passed attributes, and the link through its foreign key will be set. In addition此外, the associated object <em><strong>will</strong></em><strong>be</strong><strong>saved</strong><strong>(assuming</strong><strong>that</strong><strong>it</strong><strong>passes</strong><strong>any</strong><strong>validations)</strong>.

@account = @supplier.create_account(:terms =&gt; "Net 30")
<h5><a name="options-for-has_one"></a>4.2.2 Options for <tt>has_one</tt></h5>
In many situations, you can use the default behavior of <tt>has_one</tt> without any customization. But despite Rails’ emphasis of convention over customization, you can alter that behavior in a number of ways. This section covers the options that you can pass when you create a <tt>has_one</tt> association. For example, an association with several options might look like this:

class Supplier &lt; ActiveRecord::Base

has_one :account, :class_name =&gt; "Billing", :dependent =&gt; :nullify

end

The <tt>has_one</tt> association supports these options:
<ul>
	<li><tt>:as</tt></li>
	<li><tt>:autosave</tt></li>
	<li><tt>:class_name</tt></li>
	<li><tt>:conditions</tt></li>
	<li><tt>:dependent</tt></li>
	<li><tt>:foreign_key</tt></li>
	<li><tt>:include</tt></li>
	<li><tt>:order</tt></li>
	<li><tt>:primary_key</tt></li>
	<li><tt>:readonly</tt></li>
	<li><tt>:select</tt></li>
	<li><tt>:source</tt></li>
	<li><tt>:source_type</tt></li>
	<li><tt>:through</tt></li>
	<li><tt>:validate</tt></li>
</ul>
<h6><a name="has_one-as"></a>4.2.2.1 <tt>:as</tt></h6>
Setting the <tt>:as</tt> option indicates that this is a polymorphic association. Polymorphic associations were discussed in detail <a href="http://guides.rubyonrails.org/association_basics.html#polymorphic-associations">earlierinthisguide</a>.
<h6><a name="has_one-autosave"></a>4.2.2.2 <tt>:autosave</tt></h6>
If you set the <tt>:autosave</tt> option to <tt>true</tt>, Rails will save any loaded members and destroy members that are marked for destruction <strong>whenever</strong><strong> </strong><strong>you</strong><strong> </strong><strong>save</strong><strong> </strong><strong>the</strong><strong> </strong><strong>parent</strong><strong> </strong><strong>object</strong>.
<h6><a name="has_one-class_name"></a>4.2.2.3 <tt>:class_name</tt></h6>
If the name of the other model cannot be derived from the association name, you can use the <tt>:class_name</tt> option to supply the model name. For example, if a supplier has an account, but the actual name of the model containing accounts is <tt>Billing</tt>, you’d set things up this way:

class Supplier &lt; ActiveRecord::Base

has_one :account, :class_name =&gt; "Billing"

end
<h6><a name="has_one-conditions"></a>4.2.2.4 <tt>:conditions</tt></h6>
The <tt>:conditions</tt> option lets you specify the conditions that the associated object must meet (in the syntax used by an SQL <tt>WHERE</tt> clause).

class Supplier &lt; ActiveRecord::Base

has_one :account, :conditions =&gt; "confirmed = 1"

end
<h6><a name="has_one-dependent"></a>4.2.2.5 <tt>:dependent</tt></h6>
If you set the <tt>:dependent</tt> option to <tt>:destroy</tt>, then deleting this object will call the <tt>destroy</tt> method on the associated object to delete that object. If you set the <tt>:dependent</tt> option to <tt>:delete</tt>, then deleting this object will delete the associated object <em>without</em> calling its <tt>destroy</tt> method. If you set the <tt>:dependent</tt> option to <tt>:nullify</tt>, then deleting this object will set the foreign key in the association object to <tt>NULL</tt>.
<h6><a name="has_one-foreign_key"></a>4.2.2.6 <tt>:foreign_key</tt></h6>
By convention, Rails guesses that the column used to hold the foreign key on the other model is the name of this model with the suffix <tt>_id</tt> added添加id后缀. The <tt>:foreign_key</tt> option lets you set the name of the foreign key directly:

class Supplier &lt; ActiveRecord::Base

has_one :account, :foreign_key =&gt; "supp_id"

end

In any case, Rails will not create foreign key columns for you. You need to explicitly define them as part of your migrations.
<h6><a name="has_one-include"></a>4.2.2.7 <tt>:include</tt></h6>
You can use the <tt>:include</tt> option to specify second-order associations that should be eager-loaded when this association is used. For example, consider these models:

class Supplier &lt; ActiveRecord::Base

has_one :account

end

&nbsp;

class Account &lt; ActiveRecord::Base

belongs_to :supplier

belongs_to :representative

end

&nbsp;

class Representative &lt; ActiveRecord::Base

has_many :accounts

end

If you frequently retrieve representatives directly from suppliers (<tt>@supplier.account.representative</tt>), then you can make your code somewhat more efficient by including representatives in the association from suppliers to accounts:

class Supplier &lt; ActiveRecord::Base

has_one :account, :include =&gt; :representative

end

&nbsp;

class Account &lt; ActiveRecord::Base

belongs_to :supplier

belongs_to :representative

end

&nbsp;

class Representative &lt; ActiveRecord::Base

has_many :accounts

end
<h6><a name="has_one-order"></a>4.2.2.8 <tt>:order</tt></h6>
The <tt>:order</tt> option dictates the order in which associated objects will be received (in the syntax used by an SQL <tt>ORDER</tt><tt> </tt><tt>BY</tt> clause). Because a <tt>has_one</tt> association will only retrieve a single associated object, this option should not be needed.
<h6><a name="has_one-primary_key"></a>4.2.2.9 <tt>:primary_key</tt></h6>
By convention, Rails guesses that the column used to hold the primary key of this model is <tt>id</tt>. You can override this and explicitly specify the primary key with the <tt>:primary_key</tt> option.
<h6><a name="has_one-readonly"></a>4.2.2.10 <tt>:readonly</tt></h6>
If you set the <tt>:readonly</tt> option to <tt>true</tt>, then the associated object will be read-only when retrieved via the association.
<h6><a name="has_one-select"></a>4.2.2.11 <tt>:select</tt></h6>
The <tt>:select</tt> option lets you override the SQL <tt>SELECT</tt> clause that is used to retrieve data about the associated object. By default, Rails retrieves all columns.
<h6><a name="has_one-source"></a>.2.2.12 <tt>:source</tt></h6>
The <tt>:source</tt> option specifies the source association name for a <tt>has_one</tt><tt> </tt><tt>:through</tt> association.
<h6><a name="has_one-source_type"></a>4.2.2.13 <tt>:source_type</tt></h6>
The <tt>:source_type</tt> option specifies the source association type for a <tt>has_one</tt><tt> </tt><tt>:through</tt> association that proceeds through a polymorphic association.
<h6><a name="has_one-through"></a>4.2.2.14 <tt>:through</tt></h6>
The <tt>:through</tt> option specifies a join model through which to perform the query. <tt>has_one</tt><tt> </tt><tt>:through</tt> associations were discussed in detail <a href="http://guides.rubyonrails.org/association_basics.html#the-has_one-through-association">earlierinthisguide</a>.
<h6><a name="has_one-validate"></a>4.2.2.15 <tt>:validate</tt></h6>
If you set the <tt>:validate</tt> option to <tt>true</tt>, then associated objects will be validated whenever you save this object. By default, this is <tt>false</tt>: associated objects will not be validated when this object is saved.
<h5><a name="has_one-how_to_know_whether_theres_an_as"></a> 4.2.3 How To Know Whether There’s an Associated Object?</h5>
To know whether there’s and associated object just check <em>association</em><tt>.nil?</tt>:

if @supplier.account.nil?

@msg = "No account found for this supplier"

end
<h5><a name="has_one-when_are_objects_saved"></a>4.2.4 When are Objects Saved?</h5>
When you assign an object to a <tt>has_one</tt> association, that object is automatically saved (in order to update its foreign key). In addition, any object being replaced is also automatically saved, because its foreign key will change too.

If either of these saves fails due to validation errors, then the assignment statement returns <tt>false</tt> and the assignment itself is cancelled.

If the parent object (the one declaring the <tt>has_one</tt> association) is unsaved (that is, <tt>new_record?</tt> returns <tt>true</tt>) then the child objects are not saved. <strong>They</strong><strong> </strong><strong>will</strong><strong> </strong><strong>automatically</strong><strong> </strong><strong>when</strong><strong> </strong><strong>the</strong><strong> </strong><strong>parent</strong><strong> </strong><strong>object</strong><strong> </strong><strong>is</strong><strong> </strong><strong>saved.</strong>

<strong>If</strong><strong> </strong><strong>you</strong><strong> </strong><strong>want</strong><strong> </strong><strong>to</strong><strong> </strong><strong>assign</strong><strong> </strong><strong>an</strong><strong> </strong><strong>object</strong><strong> </strong><strong>to</strong><strong> </strong><strong>a</strong><strong> </strong><tt><strong>has_one</strong></tt><strong> </strong><strong>association</strong><strong> </strong><strong>without</strong><strong> </strong><strong>saving</strong><strong> </strong><strong>the</strong><strong> </strong><strong>object,</strong><strong> </strong><strong>use</strong><strong> </strong><strong>the</strong><strong> </strong><em><strong>association</strong></em><tt><strong>.build</strong></tt><strong> </strong><strong>method</strong>.
<h4><a name="has_many-association-reference"></a>4.3 <tt>has_many</tt> Association Reference</h4>
<strong>The</strong><strong> </strong><tt><strong>has_many</strong></tt><strong> </strong><strong>association</strong><strong> </strong><strong>creates</strong><strong> </strong><strong>a</strong><strong> </strong><strong>one-to-many</strong><strong> </strong><strong>relationship</strong><strong> </strong><strong>with</strong><strong> </strong><strong>another</strong><strong> </strong><strong>model.</strong><strong> </strong>In database terms, this association says that the other class will have a foreign key that refers to instances of this class.
<h5><a name="methods-added-by-has_many"></a>4.3.1 Methods Added by <tt>has_many</tt></h5>
When you declare a <tt>has_many</tt> association, the declaring class automatically gains 13 methods related to the association:

<em>collection</em><tt>(force_reload</tt><tt> </tt><tt>=</tt><tt> </tt><tt>false)</tt>
<ul>
	<li><em>collection</em><tt>&lt;&lt;(object,</tt><tt> …</tt><tt>)</tt></li>
	<li><em>collection</em><tt>.delete(object,</tt><tt> …</tt><tt>)</tt></li>
	<li><em>collection</em><tt>=objects</tt></li>
	<li><em>collection_singular</em><tt>_ids</tt></li>
	<li><em>collection_singular</em><tt>_ids=ids</tt></li>
	<li><em>collection</em><tt>.clear</tt></li>
	<li><em>collection</em><tt>.empty?</tt></li>
	<li><em>collection</em><tt>.size</tt></li>
	<li><em>collection</em><tt>.find(</tt><tt>…</tt><tt>)</tt></li>
	<li><em>collection</em><tt>.where(</tt><tt>…</tt><tt>)</tt></li>
	<li><em>collection</em><tt>.exists?(</tt><tt>…</tt><tt>)</tt></li>
	<li><em>collection</em><tt>.build(attributes</tt><tt> </tt><tt>=</tt><tt> </tt><tt>{},</tt><tt> …</tt><tt>)</tt></li>
	<li><em>collection</em><tt>.create(attributes</tt><tt> </tt><tt>=</tt><tt> </tt><tt>{})</tt></li>
</ul>
In all of these methods, <em>collection</em> is replaced with the symbol passed as the first argument to <tt>has_many</tt>, and <em>collection_singular</em> is replaced with the singularized version of that symbol.. For example, given the declaration:

class Customer &lt; ActiveRecord::Base

has_many :orders

end

Each instance of the customer model will have these methods:

&nbsp;

orders(force_reload = false)

orders&lt;&lt;(object, ...)

orders.delete(object, ...)

orders=objects

order_ids

order_ids=ids

orders.clear

orders.empty?

orders.size

orders.find(...)

orders.where(...)

orders.exists?(...)

orders.build(attributes = {}, ...)

orders.create(attributes = {})
<h6><a name="has_many-collection"></a>4.3.1.1 <em>collection</em><tt>(force_reload</tt><tt> </tt><tt>=</tt><tt> </tt><tt>false)</tt></h6>
The <em>collection</em> method returns an array of all of the associated objects. If there are no associated objects, it returns an empty array.

@orders = @customer.orders
<h6><a name="has_many-collection-lt_lt"></a>4.3.1.2 <em>collection</em><tt>&lt;&lt;(object,</tt><tt> …</tt><tt>)</tt></h6>
The <em>collection</em><tt>&lt;&lt;</tt> method adds one or more objects to the collection by setting their foreign keys to the primary key of the calling model.

@customer.orders &lt;&lt; @order1
<h6><a name="has_many-collection-delete"></a>4.3.1.3 <em>collection</em><tt>.delete(object,</tt><tt> …</tt><tt>)</tt></h6>
The <em>collection</em><tt>.delete</tt> method removes one or more objects from the collection by setting their foreign keys to <tt>NULL</tt>.

@customer.orders.delete(@order1)

Additionally, objects will be destroyed if they’re associated with <tt>:dependent</tt><tt> </tt><tt>=&gt;</tt><tt> </tt><tt>:destroy</tt>, and deleted if they’re associated with <tt>:dependent</tt><tt> </tt><tt>=&gt;</tt><tt> </tt><tt>:delete_all</tt>.
<h6><a name="has_many-collection-equal"></a>4.3.1.4 <em>collection</em><tt>=objects</tt></h6>
The <em>collection</em><tt>=</tt> method makes the collection contain only the supplied objects, by adding and deleting as appropriate.
<h6><a name="has_many-collection_singular"></a>4.3.1.5 <em>collection_singular</em><tt>_ids</tt></h6>
The <em>collection_singular</em><tt>_ids</tt> method returns an array of the ids of the objects in the collection.

@order_ids = @customer.order_ids
<h6><a name="has_many-collection_singular_ids_ids"></a> 4.3.1.6 <em>collection_singular</em><tt>_ids=ids</tt></h6>
The <em>collection_singular</em><tt>_ids=</tt> method makes the collection contain only the objects identified确定by the supplied primary key values, by adding and deleting as appropriate适当.
<h6><a name="has_many-collection-clear"></a>4.3.1.7 <em>collection</em><tt>.clear</tt></h6>
The <em>collection</em><tt>.clear</tt> method removes every object from the collection. This destroys the associated objects if they are associated with <tt>:dependent</tt><tt> </tt><tt>=&gt;</tt><tt> </tt><tt>:destroy</tt>, deletes them directly from the database if <tt>:dependent</tt><tt> </tt><tt>=&gt;</tt><tt> </tt><tt>:delete_all</tt>, and otherwise sets their foreign keys to <tt>NULL</tt>.
<h6><a name="has_many-collection-empty"></a>4.3.1.8 <em>collection</em><tt>.empty?</tt></h6>
The <em>collection</em><tt>.empty?</tt> method returns <tt>true</tt> if the collection does not contain any associated objects.

&lt;% if @customer.orders.empty? %&gt;

No Orders Found

&lt;% end %&gt;
<h6><a name="has_many-collection-size"></a>4.3.1.9 <em>collection</em><tt>.size</tt></h6>
The <em>collection</em><tt>.size</tt> method returns the number of objects in the collection.

@order_count = @customer.orders.size
<h6><a name="has_many-collection-find"></a>4.3.1.10 <em>collection</em><tt>.find(</tt><tt>…</tt><tt>)</tt></h6>
The <em>collection</em><tt>.find</tt> method finds objects within the collection. It uses the same syntax and options as <tt>ActiveRecord::Base.find</tt>.

@open_orders = @customer.orders.where(:open =&gt; 1)
<h6><a name="has_many-collection-where"></a>4.3.1.11 <em>collection</em><tt>.where(</tt><tt>…</tt><tt>)</tt></h6>
The <em>collection</em><tt>.where</tt> method finds objects within the collection based on the conditions supplied but the objects are loaded lazily meaning that the database is queried only when the object(s) are accessed.

@open_orders = @customer.orders.where(:open =&gt; true) # No query yet

@open_order = @open_orders.first # Now the database will be queried
<h6><a name="has_many-collection-exists"></a>4.3.1.12 <em>collection</em><tt>.exists?(</tt><tt>…</tt><tt>)</tt></h6>
The <em>collection</em><tt>.exists?</tt> method checks whether an object meeting the supplied conditions exists in the collection. It uses the same syntax and options as <tt>ActiveRecord::Base.exists?</tt>.
<h6><a name="has_many-collection-build"></a>4.3.1.13 <em>collection</em><tt>.build(attributes</tt><tt> </tt><tt>=</tt><tt> </tt><tt>{},</tt><tt> …</tt><tt>)</tt></h6>
The <em>collection</em><tt>.build</tt> method returns one or more new objects of the associated type. These objects will be instantiated from the passed attributes, and the link through their foreign key will be created, but the associated objects will <em>not</em> yet be saved.

@order = @customer.orders.build(:order_date =&gt; Time.now,

:order_number =&gt; "A12345")
<h6><a name="has_many-collection-create"></a>4.3.1.14 <em>collection</em><tt>.create(attributes</tt><tt> </tt><tt>=</tt><tt> </tt><tt>{})</tt></h6>
The <em>collection</em><tt>.create</tt> method returns a new object of the associated type. This object will be instantiated from the passed attributes, the link through its foreign key will be created, and the associated object <em>will</em> be saved (assuming that it passes any validations).

@order = @customer.orders.create(:order_date =&gt; Time.now,

:order_number =&gt; "A12345")
<h5><a name="options-for-has_many"></a>4.3.2 Options for <tt>has_many</tt></h5>
In many situations, you can use the default behavior for <tt>has_many</tt> without any customization. But you can alter that behavior in a number of ways. This section covers the options that you can pass when you create a <tt>has_many</tt> association. For example, an association with several options might look like this:

class Customer &lt; ActiveRecord::Base

has_many :orders, :dependent =&gt; :delete_all, :validate =&gt; :false

end

The <tt>has_many</tt> association supports these options:
<ul>
	<li><tt>:as</tt></li>
	<li><tt>:autosave</tt></li>
	<li><tt>:class_name</tt></li>
	<li><tt>:conditions</tt></li>
	<li><tt>:counter_sql</tt></li>
	<li><tt>:dependent</tt></li>
	<li><tt>:extend</tt></li>
	<li><tt>:finder_sql</tt></li>
	<li><tt>:foreign_key</tt></li>
	<li><tt>:group</tt></li>
	<li><tt>:include</tt></li>
	<li><tt>:limit</tt></li>
	<li><tt>:offset</tt></li>
	<li><tt>:order</tt></li>
	<li><tt>:primary_key</tt></li>
	<li><tt>:readonly</tt></li>
	<li><tt>:select</tt></li>
	<li><tt>:source</tt></li>
	<li><tt>:source_type</tt></li>
	<li><tt>:through</tt></li>
	<li><tt>:uniq</tt></li>
	<li><tt>:validate</tt></li>
</ul>
<h6><a name="has_many-as"></a>4.3.2.1 <tt>:as</tt></h6>
Setting the <tt>:as</tt> option indicates that this is a polymorphic association, as discussed <a href="http://guides.rubyonrails.org/association_basics.html#polymorphic-associations">earlierinthisguide</a>.
<h6><a name="has_many-autosave"></a>4.3.2.2 <tt>:autosave</tt></h6>
If you set the <tt>:autosave</tt> option to <tt>true</tt>, Rails will save any loaded members and destroy members that are marked for destruction whenever you save the parent object.
<h6><a name="has_many-class_name"></a>4.3.2.3 <tt>:class_name</tt></h6>
If the name of the other model cannot be derived from the association name, you can use the <tt>:class_name</tt> option to supply the model name. For example, if a customer has many orders, but the actual name of the model containing orders is <tt>Transaction</tt>, you’d set things up this way:

class Customer &lt; ActiveRecord::Base

has_many :orders, :class_name =&gt; "Transaction"

end
<h6><a name="has_many-conditions"></a>4.3.2.4 <tt>:conditions</tt></h6>
The <tt>:conditions</tt> option lets you specify the conditions that the associated object must meet (in the syntax used by an SQL <tt>WHERE</tt> clause).

class Customer &lt; ActiveRecord::Base

has_many :confirmed_orders, :class_name =&gt; "Order",

:conditions =&gt; "confirmed = 1"

end

You can also set conditions via a hash:

class Customer &lt; ActiveRecord::Base

has_many :confirmed_orders, :class_name =&gt; "Order",

:conditions =&gt; { :confirmed =&gt; true }

end

If you use a hash-style <tt>:conditions</tt> option, then record creation via this association will be automatically scoped using the hash. In this case, using <tt>@customer.confirmed_orders.create</tt> or <tt>@customer.confirmed_orders.build</tt> will create orders where the confirmed column has the value <tt>true</tt>.

if you need to evaluate conditions dynamically at runtime, use a proc:
<h6><a name="has_many-counter_sql"></a>4.3.2.5 <tt>:counter_sql</tt></h6>
Normally Rails automatically generates the proper SQL to count the association members. With the <tt>:counter_sql</tt> option, you can specify a complete SQL statement to count them yourself.

If you specify <tt>:finder_sql</tt> but not <tt>:counter_sql</tt>, then the counter SQL will be generated by substituting <tt>SELECT</tt><tt> </tt><tt>COUNT(*)</tt><tt> </tt><tt>FROM</tt> for the <tt>SELECT</tt><tt> </tt><tt>...</tt><tt> </tt><tt>FROM</tt> clause of your <tt>:finder_sql</tt> statement.
<h6><a name="has_many-dependent"></a>4.3.2.6 <tt>:dependent</tt></h6>
If you set the <tt>:dependent</tt> option to <tt>:destroy</tt><tt>（删除映射链和映射对象）</tt>, then deleting this object will call the <tt>destroy</tt> method on the associated objects to delete those objects. If you set the <tt>:dependent</tt> option to <tt>:delete_all</tt><tt>（只删除映射链）</tt>, then deleting this object will delete the associated objects <em>without</em> calling their <tt>destroy</tt> method. If you set the <tt>:dependent</tt> option to <tt>:nullify</tt>, then deleting this object will set the foreign key in the associated objects to <tt>NULL</tt>.

This option is ignored when you use the <tt>:through</tt> option on the association.
<h6><a name="has_many-extend"></a>4.3.2.7 <tt>:extend</tt></h6>
The <tt>:extend</tt> option specifies a named module to extend the association proxy. Association extensions are discussed in detail <a href="http://guides.rubyonrails.org/association_basics.html#association-extensions">laterinthisguide</a>.
<h6><a name="has_many-finder_sql"></a>4.3.2.8 <tt>:finder_sql</tt></h6>
Normally Rails automatically generates the proper SQL to fetch the association members. With the <tt>:finder_sql</tt> option, you can specify a complete SQL statement to fetch them yourself. If fetching objects requires complex multi-table SQL, this may be necessary.
<h6><a name="has_many-foreign_key"></a>4.3.2.9 <tt>:foreign_key</tt></h6>
By convention, Rails guesses that the column used to hold the foreign key on the other model is the name of this model with the suffix <tt>_id</tt> added添加前缀. The <tt>:foreign_key</tt> option lets you set the name of the foreign key directly:

In any case, Rails will not create foreign key columns for you. You need to explicitly define them as part of your migrations.
<h6><a name="has_many-group"></a>4.3.2.10 <tt>:group</tt></h6>
The <tt>:group</tt> option supplies an attribute name to group the result set by, using a <tt>GROUP</tt><tt> </tt><tt>BY</tt> clause in the finder SQL.

class Customer &lt; ActiveRecord::Base

has_many :line_items, :through =&gt; :orders, :group =&gt; "orders.id"

end
<h6><a name="has_many-include"></a>4.3.2.11 <tt>:include</tt></h6>
You can use the <tt>:include</tt> option to specify second-order associations that should be eager-loaded when this association is used. For example, consider these models:

class Customer &lt; ActiveRecord::Base

has_many :orders

end

&nbsp;

class Order &lt; ActiveRecord::Base

belongs_to :customer

has_many :line_items

end

&nbsp;

class LineItem &lt; ActiveRecord::Base

belongs_to :order

end

If you frequently retrieve line items directly from customers (<tt>@customer.orders.line_items</tt>), then you can make your code somewhat more efficient by including line items in the association from customers to orders:

class Customer &lt; ActiveRecord::Base

has_many :orders, :include =&gt; :line_items

end

&nbsp;

class Order &lt; ActiveRecord::Base

belongs_to :customer

has_many :line_items

end

&nbsp;

class LineItem &lt; ActiveRecord::Base

belongs_to :order

end
<h6><a name="has_many-limit"></a>4.3.2.12 <tt>:limit</tt></h6>
The <tt>:limit</tt> option lets you restrict the total number of objects that will be fetched through an association.

class Customer &lt; ActiveRecord::Base

has_many :recent_orders, :class_name =&gt; "Order",

:order =&gt; "order_date DESC", :limit =&gt; 100

end
<h6><a name="has_many-offset"></a>4.3.2.13 <tt>:offset</tt></h6>
The <tt>:offset</tt> option lets you specify the starting offset for fetching objects via an association. For example, if you set <tt>:offset</tt><tt> </tt><tt>=&gt;</tt><tt> </tt><tt>11</tt>, it will skip the first 11 records.
<h6><a name="has_many-order"></a>4.3.2.14 <tt>:order</tt></h6>
The <tt>:order</tt> option dictates the order in which associated objects will be received (in the syntax used by an SQL <tt>ORDER</tt><tt> </tt><tt>BY</tt> clause).

class Customer &lt; ActiveRecord::Base

has_many :orders, :order =&gt; "date_confirmed DESC"

end
<h6><a name="has_many-primary_key"></a>4.3.2.15 <tt>:primary_key</tt></h6>
By convention, Rails guesses that the column used to hold the primary key of the association is <tt>id</tt>. You can override this and explicitly specify the primary key with the <tt>:primary_key</tt> option.
<h6><a name="has_many-readonly"></a>4.3.2.16 <tt>:readonly</tt></h6>
If you set the <tt>:readonly</tt> option to <tt>true</tt>, then the associated objects will be read-only when retrieved via the association.
<h6><a name="has_many-select"></a>4.3.2.17 <tt>:select</tt></h6>
The <tt>:select</tt> option lets you override the SQL <tt>SELECT</tt> clause that is used to retrieve data about the associated objects. By default, Rails retrieves all columns.

If you specify your own <tt>:select</tt>, be sure to include the primary key and foreign key columns of the associated model. If you do not, Rails will throw an error.
<h6><a name="has_many-source"></a>4.3.2.18 <tt>:source</tt></h6>
The <tt>:source</tt> option specifies the source association name for a <tt>has_many</tt><tt> </tt><tt>:through</tt> association. You only need to use this option if the name of the source association cannot be automatically inferred from the association name.
<h6><a name="has_many-source_type"></a>4.3.2.19 <tt>:source_type</tt></h6>
The <tt>:source_type</tt> option specifies the source association type for a <tt>has_many</tt><tt> </tt><tt>:through</tt> association that proceeds through a polymorphic association.
<h6><a name="has_many-through"></a>4.3.2.20 <tt>:through</tt></h6>
The <tt>:through</tt> option specifies a join model through which to perform the query. <tt>has_many</tt><tt> </tt><tt>:through</tt> associations provide a way to implement many-to-many relationships, as discussed <a href="http://guides.rubyonrails.org/association_basics.html#the-has_many-through-association">earlierinthisguide</a>.
<h6><a name="has_many-uniq"></a>4.3.2.21 <tt>:uniq</tt></h6>
Set the <tt>:uniq</tt> option to true to keep the collection free of duplicates. This is mostly useful together with the <tt>:through</tt> option.

class Person &lt; ActiveRecord::Base

has_many :readings

has_many :posts, :through =&gt; :readings

end

&nbsp;

person = Person.create(:name =&gt; 'john')

post = Post.create(:name =&gt; 'a1')

person.posts &lt;&lt; post

person.posts &lt;&lt; post

person.posts.inspect # =&gt; [#&lt;Post id: 5, name: "a1"&gt;, #&lt;Post id: 5, name: "a1"&gt;]

Reading.all.inspect # =&gt; [#&lt;Reading id: 12, person_id: 5, post_id: 5&gt;, #&lt;Reading id: 13, person_id: 5, post_id: 5&gt;]

In the above case there are two readings and <tt>person.posts</tt> brings out both of them even though these records are pointing to the same post.

Now let’s set <tt>:uniq</tt> to true:

class Person

has_many :readings

has_many :posts, :through =&gt; :readings, :uniq =&gt; true

end

&nbsp;

person = Person.create(:name =&gt; 'honda')

post = Post.create(:name =&gt; 'a1')

person.posts &lt;&lt; post

person.posts &lt;&lt; post

person.posts.inspect # =&gt; [#&lt;Post id: 7, name: "a1"&gt;]

Reading.all.inspect # =&gt; [#&lt;Reading id: 16, person_id: 7, post_id: 7&gt;, #&lt;Reading id: 17, person_id: 7, post_id: 7&gt;]

In the above case there are still two readings. However <tt>person.posts</tt> shows only one post because the collection loads only unique records.
<h6><a name="has_many-validate"></a>4.3.2.22 <tt>:validate</tt></h6>
If you set the <tt>:validate</tt> option to <tt>false</tt>, then associated objects will not be validated whenever you save this object. By default, this is <tt>true</tt>: associated objects will be validated when this object is saved.
<h5><a name="has_many-when_are_objects_saved"></a>4.3.3 When are Objects Saved?</h5>
When you assign an object to a <tt>has_many</tt> association, that object is automatically saved (in order to update its foreign key). If you assign multiple objects in one statement, then they are all saved.

If any of these saves fails due to validation errors, then the assignment statement returns <tt>false</tt> and the assignment itself is cancelled.

If the parent object (the one declaring the <tt>has_many</tt> association) is unsaved (that is, <tt>new_record?</tt> returns <tt>true</tt>) then the child objects are not saved when they are added. All unsaved members of the association will automatically be saved when the parent is saved.

If you want to assign an object to a <tt>has_many</tt> association without saving the object, use the <em>collection</em><tt>.build</tt> method.
<h4><a name="has_and_belongs_to_many-association-refe"></a> 4.4 <tt>has_and_belongs_to_many</tt> Association Reference</h4>
The <tt>has_and_belongs_to_many</tt> association creates a many-to-many relationship with another model. In database terms, this associates two classes via an intermediate join table that includes foreign keys referring to each of the classes.
<h5><a name="methods-added-by-has_and_belongs_to_many"></a> 4.4.1 Methods Added by <tt>has_and_belongs_to_many</tt></h5>
When you declare a <tt>has_and_belongs_to_many</tt> association, the declaring class automatically gains 13 methods related to the association:
<ul>
	<li><em>collection</em><tt>(force_reload</tt><tt> </tt><tt>=</tt><tt> </tt><tt>false)</tt></li>
	<li><em>collection</em><tt>&lt;&lt;(object,</tt><tt> …</tt><tt>)</tt></li>
	<li><em>collection</em><tt>.delete(object,</tt><tt> …</tt><tt>)</tt></li>
	<li><em>collection</em><tt>=objects</tt></li>
	<li><em>collection_singular</em><tt>_ids</tt></li>
	<li><em>collection_singular</em><tt>_ids=ids</tt></li>
	<li><em>collection</em><tt>.clear</tt></li>
	<li><em>collection</em><tt>.empty?</tt></li>
	<li><em>collection</em><tt>.size</tt></li>
	<li><em>collection</em><tt>.find(</tt><tt>…</tt><tt>)</tt></li>
	<li><em>collection</em><tt>.where(</tt><tt>…</tt><tt>)</tt></li>
	<li><em>collection</em><tt>.exists?(</tt><tt>…</tt><tt>)</tt></li>
	<li><em>collection</em><tt>.build(attributes</tt><tt> </tt><tt>=</tt><tt> </tt><tt>{})</tt></li>
	<li><em>collection</em><tt>.create(attributes</tt><tt> </tt><tt>=</tt><tt> </tt><tt>{})</tt></li>
</ul>
In all of these methods, <em>collection</em> is replaced with the symbol passed as the first argument to <tt>has_and_belongs_to_many</tt>, and <em>collection_singular</em> is replaced with the singularized version of that symbol. For example, given the declaration:

class Part &lt; ActiveRecord::Base

has_and_belongs_to_many :assemblies

end

Each instance of the part model will have these methods:

assemblies(force_reload = false)

assemblies&lt;&lt;(object, ...)

assemblies.delete(object, ...)

assemblies=objects

assembly_ids

assembly_ids=ids

assemblies.clear

assemblies.empty?

assemblies.size

assemblies.find(...)

assemblies.where(...)

assemblies.exists?(...)

assemblies.build(attributes = {}, ...)

assemblies.create(attributes = {})
<h6><a name="additional-column-methods"></a>4.4.1.1 Additional Column Methods</h6>
If the join table for a <tt>has_and_belongs_to_many</tt> association has additional columns beyond the two foreign keys, these columns will be added as attributes to records retrieved via that association. Records returned with additional attributes will always be read-only, because Rails cannot save changes to those attributes.

The use of extra attributes on the join table in a <tt>has_and_belongs_to_many</tt> association is deprecated. If you require this sort of complex behavior on the table that joins two models in a many-to-many relationship, you should use a <tt>has_many</tt><tt> </tt><tt>:through</tt> association instead of <tt>has_and_belongs_to_many</tt>.
<h6><a name="has_and_belongs_to_many-collection"></a>4.4.1.2 <em>collection</em><tt>(force_reload</tt><tt> </tt><tt>=</tt><tt> </tt><tt>false)</tt></h6>
The <em>collection</em> method returns an array of all of the associated objects. If there are no associated objects, it returns an empty array.

@assemblies = @part.assemblies
<h6><a name="has_and_belongs_to_many-collection-lt_lt"></a> 4.4.1.3 <em>collection</em><tt>&lt;&lt;(object,</tt><tt> …</tt><tt>)</tt></h6>
The <em>collection</em><tt>&lt;&lt;</tt> method adds one or more objects to the collection by creating records in the join table.

@part.assemblies &lt;&lt; @assembly1

This method is aliased as <em>collection</em><tt>.concat</tt> and <em>collection</em><tt>.push</tt>.
<h6><a name="has_and_belongs_to_many-collection-delet"></a> 4.4.1.4 <em>collection</em><tt>.delete(object,</tt><tt> …</tt><tt>)</tt></h6>
The <em>collection</em><tt>.delete</tt> method removes one or more objects from the collection by deleting records in the join table. This does not destroy the objects.

@part.assemblies.delete(@assembly1)
<h6><a name="has_and_belongs_to_many-collection-equal"></a> 4.4.1.5 <em>collection</em><tt>=objects</tt></h6>
The <em>collection</em><tt>=</tt> method makes the collection contain only the supplied objects, by adding and deleting as appropriate.
<h6><a name="has_and_belongs_to_many-collection_singu"></a> 4.4.1.6 <em>collection_singular</em><tt>_ids</tt></h6>
The <em>collection_singular</em><tt>_ids</tt> method returns an array of the ids of the objects in the collection.

@assembly_ids = @part.assembly_ids
<h6>4.4.1.7 <em>collection_singular</em><tt>_ids=ids</tt></h6>
The <em>collection_singular</em><tt>_ids=</tt> method makes the collection contain only the objects identified by the supplied primary key values, by adding and deleting as appropriate.
<h6><a name="has_and_belongs_to_many-collection-clear"></a> 4.4.1.8 <em>collection</em><tt>.clear</tt></h6>
The <em>collection</em><tt>.clear</tt> method removes every object from the collection by deleting the rows from the joining table. This does not destroy the associated objects.
<h6><a name="has_and_belongs_to_many-collection-empty"></a> 4.4.1.9 <em>collection</em><tt>.empty?</tt></h6>
The <em>collection</em><tt>.empty?</tt> method returns <tt>true</tt> if the collection does not contain any associated objects.

&lt;% if @part.assemblies.empty? %&gt;

This part is not used in any assemblies

&lt;% end %&gt;
<h6><a name="has_and_belongs_to_many-collection-size"></a> 4.4.1.10 <em>collection</em><tt>.size</tt></h6>
The <em>collection</em><tt>.size</tt> method returns the number of objects in the collection.

@assembly_count = @part.assemblies.size
<h6><a name="has_and_belongs_to_many-collection-find"></a> 4.4.1.11 <em>collection</em><tt>.find(</tt><tt>…</tt><tt>)</tt></h6>
The <em>collection</em><tt>.find</tt> method finds objects within the collection. It uses the same syntax and options as <tt>ActiveRecord::Base.find</tt>. It also adds the additional condition that the object must be in the collection.

@new_assemblies = @part.assemblies.all(

:conditions =&gt; ["created_at &gt; ?", 2.days.ago])

Starting Rails 3, supplying options to <tt>ActiveRecord::Base.find</tt> method is discouraged. Use <em>collection</em><tt>.where</tt> instead when you need to pass conditions.
<h6><a name="has_and_belongs_to_many-collection-where"></a> 4.4.1.12 <em>collection</em><tt>.where(</tt><tt>…</tt><tt>)</tt></h6>
The <em>collection</em><tt>.where</tt> method finds objects within the collection based on the conditions supplied but the objects are loaded lazily meaning that the database is queried only when the object(s) are accessed. It also adds the additional condition that the object must be in the collection.

@new_assemblies = @part.assemblies.where("created_at &gt; ?", 2.days.ago)
<h6><a name="has_and_belongs_to_many-collection-exist"></a> 4.4.1.13 <em>collection</em><tt>.exists?(</tt><tt>…</tt><tt>)</tt></h6>
The <em>collection</em><tt>.exists?</tt> method checks whether an object meeting the supplied conditions exists in the collection. It uses the same syntax and options as <tt>ActiveRecord::Base.exists?</tt>.
<h6><a name="has_and_belongs_to_many-collection-build"></a> 4.4.1.14 <em>collection</em><tt>.build(attributes</tt><tt> </tt><tt>=</tt><tt> </tt><tt>{})</tt></h6>
The <em>collection</em><tt>.build</tt> method returns a new object of the associated type. This object will be instantiated from the passed attributes, and the link through the join table will be created, but the associated object will <em>not</em> yet be saved.

@assembly = @part.assemblies.build(

{:assembly_name =&gt; "Transmission housing"})
<h6><a name="has_and_belongs_to_many-create-attribute"></a> 4.4.1.15 <em>collection</em><tt>.create(attributes</tt><tt> </tt><tt>=</tt><tt> </tt><tt>{})</tt></h6>
The <em>collection</em><tt>.create</tt> method returns a new object of the associated type. This object will be instantiated from the passed attributes, the link through the join table will be created, and the associated object <em>will</em> be saved (assuming that it passes any validations).

@assembly = @part.assemblies.create(

{:assembly_name =&gt; "Transmission housing"})
<h5><a name="options-for-has_and_belongs_to_many"></a> 4.4.2 Options for <tt>has_and_belongs_to_many</tt></h5>
In many situations, you can use the default behavior for <tt>has_and_belongs_to_many</tt> without any customization. But you can alter that behavior in a number of ways. This section covers the options that you can pass when you create a <tt>has_and_belongs_to_many</tt> association. For example, an association with several options might look like this:

class Parts &lt; ActiveRecord::Base

has_and_belongs_to_many :assemblies, :uniq =&gt; true,

:read_only =&gt; true

end

The <tt>has_and_belongs_to_many</tt> association supports these options:
<ul>
	<li><tt>:association_foreign_key</tt></li>
	<li><tt>:autosave</tt></li>
	<li><tt>:class_name</tt></li>
	<li><tt>:conditions</tt></li>
	<li><tt>:counter_sql</tt></li>
	<li><tt>:delete_sql</tt></li>
	<li><tt>:extend</tt></li>
	<li><tt>:finder_sql</tt></li>
	<li><tt>:foreign_key</tt></li>
	<li><tt>:group</tt></li>
	<li><tt>:include</tt></li>
	<li><tt>:insert_sql</tt></li>
	<li><tt>:join_table</tt></li>
	<li><tt>:limit</tt></li>
	<li><tt>:offset</tt></li>
	<li><tt>:order</tt></li>
	<li><tt>:readonly</tt></li>
	<li><tt>:select</tt></li>
	<li><tt>:uniq</tt></li>
	<li><tt>:validate</tt></li>
</ul>
<h6><a name="has_and_belongs_to_many-association_fore"></a> 4.4.2.1 <tt>:association_foreign_key</tt></h6>
By convention, Rails guesses that the column in the join table used to hold the foreign key pointing to the other model is the name of that model with the suffix <tt>_id</tt> added. The <tt>:association_foreign_key</tt> option lets you set the name of the foreign key directly:

The <tt>:foreign_key</tt> and <tt>:association_foreign_key</tt> options are useful when setting up a many-to-many self-join. For example:

class User &lt; ActiveRecord::Base

has_and_belongs_to_many :friends, :class_name =&gt; "User",

:foreign_key =&gt; "this_user_id",

:association_foreign_key =&gt; "other_user_id"

end
<h6><a name="has_and_belongs_to_many-autosave"></a>4.4.2.2 <tt>:autosave</tt></h6>
If you set the <tt>:autosave</tt> option to <tt>true</tt>, Rails will save any loaded members and destroy members that are marked for destruction whenever you save the parent object.
<h6><a name="has_and_belongs_to_many-class_name"></a>4.4.2.3 <tt>:class_name</tt></h6>
If the name of the other model cannot be derived from the association name, you can use the <tt>:class_name</tt> option to supply the model name. For example, if a part has many assemblies, but the actual name of the model containing assemblies is <tt>Gadget</tt>, you’d set things up this way:

class Parts &lt; ActiveRecord::Base

has_and_belongs_to_many :assemblies, :class_name =&gt; "Gadget"

end
<h6><a name="has_and_belongs_to_many-conditions"></a>4.4.2.4 <tt>:conditions</tt></h6>
The <tt>:conditions</tt> option lets you specify the conditions that the associated object must meet (in the syntax used by an SQL <tt>WHERE</tt> clause).

class Parts &lt; ActiveRecord::Base

has_and_belongs_to_many :assemblies,

:conditions =&gt; "factory = 'Seattle'"

end

You can also set conditions via a hash:

class Parts &lt; ActiveRecord::Base

has_and_belongs_to_many :assemblies,

:conditions =&gt; { :factory =&gt; 'Seattle' }

end

If you use a hash-style <tt>:conditions</tt> option, then record creation via this association will be automatically scoped using the hash. In this case, using <tt>@parts.assemblies.create</tt> or <tt>@parts.assemblies.build</tt> will create orders where the <tt>factory</tt> column has the value “Seattle”.
<h6><a name="has_and_belongs_to_many-counter_sql"></a> 4.4.2.5 <tt>:counter_sql</tt></h6>
Normally Rails automatically generates the proper SQL to count the association members. With the <tt>:counter_sql</tt> option, you can specify a complete SQL statement to count them yourself.

If you specify <tt>:finder_sql</tt> but not <tt>:counter_sql</tt>, then the counter SQL will be generated by substituting <tt>SELECT</tt><tt> </tt><tt>COUNT(*)</tt><tt> </tt><tt>FROM</tt> for the <tt>SELECT</tt><tt> </tt><tt>...</tt><tt> </tt><tt>FROM</tt> clause of your <tt>:finder_sql</tt> statement.
<h6><a name="has_and_belongs_to_many-delete_sql"></a>4.4.2.6 <tt>:delete_sql</tt></h6>
Normally Rails automatically generates the proper SQL to remove links between the associated classes. With the <tt>:delete_sql</tt> option, you can specify a complete SQL statement to delete them yourself.
<h6><a name="has_and_belongs_to_many-extend"></a>4.4.2.7 <tt>:extend</tt></h6>
The <tt>:extend</tt> option specifies a named module to extend the association proxy. Association extensions are discussed in detail <a href="http://guides.rubyonrails.org/association_basics.html#association-extensions">laterinthisguide</a>.
<h6><a name="has_and_belongs_to_many-finder_sql"></a>4.4.2.8 <tt>:finder_sql</tt></h6>
Normally Rails automatically generates the proper SQL to fetch the association members. With the <tt>:finder_sql</tt> option, you can specify a complete SQL statement to fetch them yourself. If fetching objects requires complex multi-table SQL, this may be necessary.
<h6><a name="has_and_belongs_to_many-foreign_key"></a> 4.4.2.9 <tt>:foreign_key</tt></h6>
By convention, Rails guesses that the column in the join table used to hold the foreign key pointing to this model is the name of this model with the suffix <tt>_id</tt> added. The <tt>:foreign_key</tt> option lets you set the name of the foreign key directly:

class User &lt; ActiveRecord::Base

has_and_belongs_to_many :friends, :class_name =&gt; "User",

:foreign_key =&gt; "this_user_id",

:association_foreign_key =&gt; "other_user_id"

end
<h6><a name="has_and_belongs_to_many-group"></a>4.4.2.10 <tt>:group</tt></h6>
The <tt>:group</tt> option supplies an attribute name to group the result set by, using a <tt>GROUP</tt><tt> </tt><tt>BY</tt> clause in the finder SQL.

class Parts &lt; ActiveRecord::Base

has_and_belongs_to_many :assemblies, :group =&gt; "factory"

end
<h6><a name="has_and_belongs_to_many-include"></a>4.4.2.11 <tt>:include</tt></h6>
You can use the <tt>:include</tt> option to specify second-order associations that should be eager-loaded when this association is used.
<h6><a name="has_and_belongs_to_many-insert_sql"></a>4.4.2.12 <tt>:insert_sql</tt></h6>
Normally Rails automatically generates the proper SQL to create links between the associated classes. With the <tt>:insert_sql</tt> option, you can specify a complete SQL statement to insert them yourself.
<h6><a name="has_and_belongs_to_many-join_table"></a>4.4.2.13 <tt>:join_table</tt></h6>
If the default name of the join table, based on lexical ordering, is not what you want, you can use the <tt>:join_table</tt> option to override the default.
<h6><a name="has_and_belongs_to_many-limit"></a>4.4.2.14 <tt>:limit</tt></h6>
The <tt>:limit</tt> option lets you restrict the total number of objects that will be fetched through an association.

class Parts &lt; ActiveRecord::Base

has_and_belongs_to_many :assemblies, :order =&gt; "created_at DESC",

:limit =&gt; 50

end
<h6><a name="has_and_belongs_to_many-offset"></a>4.4.2.15 <tt>:offset</tt></h6>
The <tt>:offset</tt> option lets you specify the starting offset for fetching objects via an association. For example, if you set <tt>:offset</tt><tt> </tt><tt>=&gt;</tt><tt> </tt><tt>11</tt>, it will skip the first 11 records.
<h6><a name="has_and_belongs_to_many-order"></a>4.4.2.16 <tt>:order</tt></h6>
The <tt>:order</tt> option dictates the order in which associated objects will be received (in the syntax used by an SQL <tt>ORDER</tt><tt> </tt><tt>BY</tt> clause).

class Parts &lt; ActiveRecord::Base

has_and_belongs_to_many :assemblies, :order =&gt; "assembly_name ASC"

end
<h6><a name="has_and_belongs_to_many-readonly"></a>4.4.2.17 <tt>:readonly</tt></h6>
If you set the <tt>:readonly</tt> option to <tt>true</tt>, then the associated objects will be read-only when retrieved via the association.
<h6><a name="has_and_belongs_to_many-select"></a>4.4.2.18 <tt>:select</tt></h6>
The <tt>:select</tt> option lets you override the SQL <tt>SELECT</tt> clause that is used to retrieve data about the associated objects. By default, Rails retrieves all columns.
<h6><a name="has_and_belongs_to_many-uniq"></a>4.4.2.19 <tt>:uniq</tt></h6>
Specify the <tt>:uniq</tt><tt> </tt><tt>=&gt;</tt><tt> </tt><tt>true</tt> option to remove duplicates from the collection.
<h6><a name="has_and_belongs_to_many-validate"></a>4.4.2.20 <tt>:validate</tt></h6>
If you set the <tt>:validate</tt> option to <tt>false</tt>, then associated objects will not be validated whenever you save this object. By default, this is <tt>true</tt>: associated objects will be validated when this object is saved.
<h5><a name="has_and_belongs_to_many-when_are_objects"></a> 4.4.3 When are Objects Saved?</h5>
When you assign an object to a <tt>has_and_belongs_to_many</tt> association, that object is automatically saved (in order to update the join table). If you assign multiple objects in one statement, then they are all saved.

If any of these saves fails due to validation errors, then the assignment statement returns <tt>false</tt> and the assignment itself is cancelled.

If the parent object (the one declaring the <tt>has_and_belongs_to_many</tt> association) is unsaved (that is, <tt>new_record?</tt> returns <tt>true</tt>) then the child objects are not saved when they are added. All unsaved members of the association will automatically be saved when the parent is saved.

If you want to assign an object to a <tt>has_and_belongs_to_many</tt> association without saving the object, use the <em>collection</em><tt>.build</tt> method.
<h4><a name="association-callbacks"></a>4.5 Association Callbacks</h4>
Normal callbacks hook into the life cycle of Active Record objects, allowing you to work with those objects at various points. For example, you can use a <tt>:before_save</tt> callback to cause something to happen just before an object is saved.

Association callbacks are similar to normal callbacks, but they are triggered by events in the life cycle of a collection. There are four available association callbacks:
<ul>
	<li><tt>before_add</tt></li>
	<li><tt>after_add</tt></li>
	<li><tt>before_remove</tt></li>
	<li><tt>after_remove</tt></li>
</ul>
You define association callbacks by adding options to the association declaration. For example:

class Customer &lt; ActiveRecord::Base

has_many :orders, :before_add =&gt; :check_credit_limit

&nbsp;

def check_credit_limit(order)

...

end

end

You can stack callbacks on a single event by passing them as an array:

class Customer &lt; ActiveRecord::Base

has_many :orders,

:before_add =&gt; [:check_credit_limit, :calculate_shipping_charges]

&nbsp;

def check_credit_limit(order)

...

end

&nbsp;

def calculate_shipping_charges(order)

...

end

end

If a <tt>before_add</tt> callback throws an exception, the object does not get added to the collection. Similarly, if a <tt>before_remove</tt> callback throws an exception, the object does not get removed from the collection.
<h4><a name="association-extensions"></a>4.6 Association Extensions</h4>
You’re not limited to the functionality that Rails automatically builds into association proxy objects. You can also extend these objects through anonymous modules, adding new finders, creators, or other methods. For example:

class Customer &lt; ActiveRecord::Base

has_many :orders do

def find_by_order_prefix(order_number)

find_by_region_id(order_number[0..2])

end

end

end

If you have an extension that should be shared by many associations, you can use a named extension module. For example:

module FindRecentExtension

def find_recent

where("created_at &gt; ?", 5.days.ago)

end

end

&nbsp;

class Customer &lt; ActiveRecord::Base

has_many :orders, :extend =&gt; FindRecentExtension

end

&nbsp;

class Supplier &lt; ActiveRecord::Base

has_many :deliveries, :extend =&gt; FindRecentExtension

end

To include more than one extension module in a single association, specify an array of modules:

class Customer &lt; ActiveRecord::Base

has_many :orders,

:extend =&gt; [FindRecentExtension, FindActiveExtension]

end

Extensions can refer to the internals of the association proxy using these three accessors访问器:
<ul>
	<li><tt>proxy_owner</tt> returns the object that the association is a part of.</li>
	<li><tt>proxy_reflection</tt> returns the reflection object that describes the association.</li>
	<li><tt>proxy_target</tt> returns the associated object for <tt>belongs_to</tt> or <tt>has_one</tt>, or the collection of associated objects for <tt>has_many</tt> or <tt>has_and_belongs_to_many</tt>.</li>
</ul>
&nbsp;

Now,supposewewantedtoaddaneworderforanexistingcustomer.We’dneedtodosomethinglikethis:现在假设我们想为一个存在的customer添加一个新的order。我们需要做如下事情：

</div>
<div>标签： <a href="http://jhjguxin.hwcrazy.com/tag/guide/">guide</a> <a href="http://jhjguxin.hwcrazy.com/tag/rails/">rails</a> <a href="http://jhjguxin.hwcrazy.com/tag/ruby/">ruby</a></div>
