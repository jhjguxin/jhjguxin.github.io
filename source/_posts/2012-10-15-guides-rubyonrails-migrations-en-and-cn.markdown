---
layout: post
title: "guides rubyonrails Migrations (EN and CN)"
date: 2011-11-21 02:48
comments: true
categories: ["rails"]
tags: ["rails", "ruby", "translate", "经验"]
---
## guides rubyonrails Migrations (EN and CN)
<h2>Migrations</h2>
Migrations are a convenient way for you to alter<span style="font-family: DejaVu Sans;">移动</span>your database in a structured and organized manner.Migrations<span style="font-family: DejaVu Sans;">是一种很便捷的方法让你能够以一种结构化的和有组织的方式来迁移你的数据库。</span>You could edit fragments of SQL by hand but you would then be responsible for telling other developers that they need to go and run them.<span style="font-family: DejaVu Sans;">你可以手动编辑</span>SQL<span style="font-family: DejaVu Sans;">片段，而且你有责任把这些告诉其他的开发人员，因为他们需要开发和使用它们。</span>You’d also have to keep track of which changes need to be run against the production machines next time you deploy.<span style="font-family: DejaVu Sans;">你也可以跟踪对你部署的代码在接下来的</span>production<span style="font-family: DejaVu Sans;">机器（将会）发生的变化。</span>

Active Record tracks which migrations have already been run so all you have to do is update your source and run <tt>rake</tt><tt> </tt><tt>db:migrate</tt>.Active Record<span style="font-family: DejaVu Sans;">跟踪并迁移你已经运行过的（代码和数据），而你只需要在更新了你的源代码的时候执行</span><tt>rake</tt><tt> </tt><tt>db:migrate</tt><span style="font-family: DejaVu Sans;"><tt>。</tt></span>Active Record will work out which migrations should be run.Active Recor<span style="font-family: DejaVu Sans;">将会计算出那些迁移需要被执行。</span>It will also update your <tt>db/schema.rb</tt> file to match the structure of your database.<span style="font-family: DejaVu Sans;">它还会更新你的</span><tt>db/schema.rb</tt><span style="font-family: DejaVu Sans;"><tt>文件使其于你的数据库结构相匹配。</tt></span>

<tt>Migrations</tt><tt> </tt><tt>also</tt><tt> </tt><tt>allow</tt><tt> </tt><tt>you</tt><tt> </tt><tt>to</tt><tt> </tt><tt>describe</tt><tt> </tt><tt>these</tt><tt> </tt><tt>transformations</tt><tt> </tt><tt>using</tt><tt> </tt><tt>Ruby.Migrations</tt><span style="font-family: DejaVu Sans;"><tt>同样允许你使用</tt></span><tt>Ruby</tt><span style="font-family: DejaVu Sans;"><tt>来描述这些转换。</tt><tt></tt></span><tt>The</tt><tt> </tt><tt>great</tt><tt> </tt><tt>thing</tt><tt> </tt><tt>about</tt><tt> </tt><tt>this</tt><tt> </tt><tt>is</tt><tt> </tt><tt>that</tt><tt> </tt><tt>(like</tt><tt> </tt><tt>most</tt><tt> </tt><tt>of</tt><tt> </tt><tt>Active</tt><tt> </tt><tt>Record</tt><tt>’</tt><tt>s</tt><tt> </tt><tt>functionality)</tt><tt> </tt><tt>it</tt><tt> </tt><tt>is</tt><tt> </tt><tt>database</tt><tt> </tt><tt>independent:</tt><tt> </tt><tt>you</tt><tt> </tt><tt>don</tt><tt>’</tt><tt>t</tt><tt> </tt><tt>need</tt><tt> </tt><tt>to</tt><tt> </tt><tt>worry</tt><tt> </tt><tt>about</tt><tt> </tt><tt>the</tt><tt> </tt><tt>precise</tt><tt> </tt><tt>syntax</tt><tt> </tt><tt>of</tt><tt> </tt><tt>CREATE</tt><tt> </tt><tt>TABLE</tt><tt> </tt><tt>any</tt><tt> </tt><tt>more</tt><tt> </tt><tt>than</tt><tt> </tt><tt>you</tt><tt> </tt><tt>worry</tt><tt> </tt><tt>about</tt><tt> </tt><tt>variations</tt><tt> </tt><tt>on</tt><tt> </tt><tt>SELECT</tt><tt> </tt><tt>*</tt><tt> </tt><tt>(you</tt><tt> </tt><tt>can</tt><tt> </tt><tt>drop</tt><tt> </tt><tt>down</tt><tt> </tt><tt>to</tt><tt> </tt><tt>raw</tt><tt> </tt><tt>SQL</tt><tt> </tt><tt>for</tt><tt> </tt><tt>database</tt><tt> </tt><tt>specific</tt><tt> </tt><tt>features).</tt><span style="font-family: DejaVu Sans;"><tt>值得高兴的事情是（就像大多数的</tt></span><tt>Active</tt><tt> </tt><tt>Record's</tt><span style="font-family: DejaVu Sans;"><tt>工厂）它是与数据独立的：你再也不需要担心准确的语法来</tt><tt></tt></span><tt>CREATE</tt><tt> </tt><tt>TABLE</tt><span style="font-family: DejaVu Sans;"><tt>也不需要担心</tt></span><tt>SELECT</tt><tt> </tt><tt>*</tt><span style="font-family: DejaVu Sans;"><tt>的变化。</tt><tt></tt></span><tt>For</tt><tt> </tt><tt>example</tt><tt> </tt><tt>you</tt><tt> </tt><tt>could</tt><tt> </tt><tt>use</tt><tt> </tt><tt>SQLite3</tt><tt> </tt><tt>in</tt><tt> </tt><tt>development,</tt><tt> </tt><tt>but</tt><tt> </tt><tt>MySQL</tt><tt> </tt><tt>in</tt><tt> </tt><tt>production.</tt><span style="font-family: DejaVu Sans;"><tt>例如你可以使用</tt></span><tt>SQLite3</tt><span style="font-family: DejaVu Sans;"><tt>开发，但是在发布的产品中使用</tt></span><tt>MySQL</tt><span style="font-family: DejaVu Sans;"><tt>。</tt></span>

<tt>You</tt><tt>’</tt><tt>ll</tt><tt> </tt><tt>learn</tt><tt> </tt><tt>all</tt><tt> </tt><tt>about</tt><tt> </tt><tt>migrations</tt><tt> </tt><tt>including:</tt><span style="font-family: DejaVu Sans;"><tt>下面你将了解到的</tt></span><tt>migrations</tt><span style="font-family: DejaVu Sans;"><tt>包括：</tt></span>
<ul>
	<li>The generators you can use to create them <span style="font-family: DejaVu Sans;">你可以使用</span>generators<span style="font-family: DejaVu Sans;">来创建他们（数据库表单）</span></li>
	<li>The methods Active Record provides to manipulate<span style="font-family: DejaVu Sans;">操纵</span>your database Active Record<span style="font-family: DejaVu Sans;">提供方法来操纵你的数据库</span></li>
	<li>The Rake tasks that manipulate them <span style="font-family: DejaVu Sans;">使用</span>Rake<span style="font-family: DejaVu Sans;">命令操作这些（迁移）</span></li>
	<li>How they relate to <tt>schema.rb</tt> <span style="font-family: DejaVu Sans;">它们是如何映射到</span>schema.rb</li>
</ul>
<h3><a name="anatomy-of-a-migration"></a><tt>1</tt><tt> </tt><tt>Anatomy</tt><tt> </tt><tt>of</tt><tt> </tt><tt>a</tt><tt> </tt><tt>Migration</tt></h3>
<tt>Before</tt><tt> </tt><tt>we</tt><tt> </tt><tt>dive</tt><tt> </tt><tt>into</tt><tt> </tt><tt>the</tt><tt> </tt><tt>details</tt><tt> </tt><tt>of</tt><tt> </tt><tt>a</tt><tt> </tt><tt>migration,</tt><tt> </tt><tt>here</tt><tt> </tt><tt>are</tt><tt> </tt><tt>a</tt><tt> </tt><tt>few</tt><tt> </tt><tt>examples</tt><tt> </tt><tt>of</tt><tt> </tt><tt>the</tt><tt> </tt><tt>sorts</tt><tt> </tt><tt>of</tt><tt> </tt><tt>things</tt><tt> </tt><tt>you</tt><tt> </tt><tt>can</tt><tt> </tt><tt>do:</tt><span style="font-family: DejaVu Sans;"><tt>在深入</tt></span><tt>migration</tt><span style="font-family: DejaVu Sans;"><tt>的详细介绍之前，下面有一系列的例子你可以尝试一下：</tt></span>

<code>class</code><tt> </tt><code>CreateProducts</code><code> </code><code>&lt;</code><code> </code><code>ActiveRecord::Migration</code>

<code> </code><code>def</code> <code>up</code>

<code> </code><code>create_table</code><code> </code><code>:products</code> <code>do</code> <code>|t|</code>

<code> </code><code>t.string</code><code> </code><code>:name</code>

<code> </code><code>t.text</code><code> </code><code>:description</code>

&nbsp;

<code> </code><code>t.timestamps</code>

<code> </code><code>end</code>

<code> </code><code>end</code>

&nbsp;

<code> </code><code>def</code> <code>down</code>

<code> </code><code>drop_table</code><code> </code><code>:products</code>

<code> </code><code>end</code>

<code>end</code>

<tt>This</tt><tt> </tt><tt>migration</tt><tt> </tt><tt>adds</tt><tt> </tt><tt>a</tt><tt> </tt><tt>table</tt><tt> </tt><tt>called</tt><tt> </tt><tt>products</tt><tt> </tt><tt>with</tt><tt> </tt><tt>a</tt><tt> </tt><tt>string</tt><tt> </tt><tt>column</tt><tt> </tt><tt>called</tt><tt> </tt><tt>name</tt><tt> </tt><tt>and</tt><tt> </tt><tt>a</tt><tt> </tt><tt>text</tt><tt> </tt><tt>column</tt><tt> </tt><tt>called</tt><tt> </tt><tt>description.</tt><span style="font-family: DejaVu Sans;"><tt>这次</tt><tt></tt></span><tt>migration</tt><span style="font-family: DejaVu Sans;"><tt>添加了一个名叫</tt></span><tt>products</tt><span style="font-family: DejaVu Sans;"><tt>的表它有一个叫</tt></span><tt>name</tt><span style="font-family: DejaVu Sans;"><tt>的字符串的列和一个叫</tt></span><tt>description</tt><span style="font-family: DejaVu Sans;"><tt>的文本框的列。</tt><tt></tt></span><tt>A</tt><tt> </tt><tt>primary</tt><tt> </tt><tt>key</tt><tt> </tt><tt>column</tt><tt> </tt><tt>called</tt><tt> </tt><tt>id</tt><tt> </tt><tt>will</tt><tt> </tt><tt>also</tt><tt> </tt><tt>be</tt><tt> </tt><tt>added,</tt><tt> </tt><tt>however</tt><tt> </tt><tt>since</tt><tt> </tt><tt>this</tt><tt> </tt><tt>is</tt><tt> </tt><tt>the</tt><tt> </tt><tt>default</tt><tt> </tt><tt>we</tt><tt> </tt><tt>do</tt><tt> </tt><tt>not</tt><tt> </tt><tt>need</tt><tt> </tt><tt>to</tt><tt> </tt><tt>ask</tt><tt> </tt><tt>for</tt><tt> </tt><tt>this.</tt><span style="font-family: DejaVu Sans;"><tt>一个名叫</tt></span><tt>id</tt><span style="font-family: DejaVu Sans;"><tt>的主键列也被添加，然而因为这是默认操作的不需要我们刻意添加。</tt><tt></tt></span><tt>The</tt><tt> </tt><tt>timestamp</tt><tt> </tt><tt>columns</tt><tt> </tt><tt>created_at</tt><tt> </tt><tt>and</tt><tt> </tt><tt>updated_at</tt><tt> </tt><tt>which</tt><tt> </tt><tt>Active</tt><tt> </tt><tt>Record</tt><tt> </tt><tt>populates</tt><tt> </tt><tt>automatically</tt><tt> </tt><tt>will</tt><tt> </tt><tt>also</tt><tt> </tt><tt>be</tt><tt> </tt><tt>added.</tt><span style="font-family: DejaVu Sans;"><tt>还添加了</tt><tt></tt></span><tt>timestamp</tt><span style="font-family: DejaVu Sans;"><tt>字段，</tt></span><code>products</code><span style="font-family: DejaVu Sans;"><code>表单</code><tt>会在</tt><tt></tt></span><tt>created_at</tt><span style="font-family: DejaVu Sans;"><tt>和</tt></span><tt>updated_at</tt><span style="font-family: DejaVu Sans;"><tt>的时候通过</tt></span><tt>Active</tt><tt> </tt><tt>Record</tt><span style="font-family: DejaVu Sans;"><tt>自动填充</tt><tt></tt></span><tt>timestamp</tt><span style="font-family: DejaVu Sans;"><tt>字段。</tt><tt></tt></span><tt>Reversing</tt><tt> </tt><tt>this</tt><tt> </tt><tt>migration</tt><tt> </tt><tt>is</tt><tt> </tt><tt>as</tt><tt> </tt><tt>simple</tt><tt> </tt><tt>as</tt><tt> </tt><tt>dropping</tt><tt> </tt><tt>the</tt><tt> </tt><tt>table.</tt><span style="font-family: DejaVu Sans;"><tt>撤销这次</tt></span><tt>migration</tt><span style="font-family: DejaVu Sans;"><tt>就像</tt><tt></tt></span><tt>dropping</tt><span style="font-family: DejaVu Sans;"><tt>这个表。</tt></span>

&nbsp;

Migrations are not limited to changing the schema.Migrations<span style="font-family: DejaVu Sans;">不限制更改</span>schema<span style="font-family: DejaVu Sans;">。</span>You can also use them to fix bad data in the database or populate new fields:<span style="font-family: DejaVu Sans;">你可以使用（</span>schema<span style="font-family: DejaVu Sans;">）它们来修复坏的数据或者添加新的字段：</span>

<code>class</code> <code>AddReceiveNewsletterToUsers</code><code> </code><code>&lt;</code><code> </code><code>ActiveRecord::Migration</code>

<code> </code><code>def</code> <code>up</code>

<code> </code><code>change_table</code><code> </code><code>:users</code> <code>do</code> <code>|t|</code>

<code> </code><code>t.boolean</code><code> </code><code>:receive_newsletter,</code><code> </code><code>:default</code> <code>=&gt;</code><code> </code><code>false</code>

<code> </code><code>end</code>

<code> </code><code>User.update_all</code><code> </code><code>["receive_newsletter</code><code> </code><code>=</code><code> </code><code>?",</code><code> </code><code>true]</code>

<code> </code><code>end</code>

&nbsp;

<code> </code><code>def</code> <code>down</code>

<code> </code><code>remove_column</code><code> </code><code>:users,</code><code> </code><code>:receive_newsletter</code>

<code> </code><code>end</code>

<code>end</code>

Some <span style="color: #000080;"><span style="text-decoration: underline;"><a href="http://guides.rubyonrails.org/migrations.html#using-models-in-your-migrations">caveats</a></span></span> apply to using models in your migrations.<span style="font-family: DejaVu Sans;">一些在</span>model<span style="font-family: DejaVu Sans;">的</span>migrations<span style="font-family: DejaVu Sans;">中的<span style="color: #000080;"><span style="text-decoration: underline;"><a href="http://guides.rubyonrails.org/migrations.html#using-models-in-your-migrations" target="_blank">注意事项</a></span></span>。</span>

This migration adds a <tt>receive_newsletter</tt> column to the <tt>users</tt> table.<span style="font-family: DejaVu Sans;">（上面）这个</span>migration<span style="font-family: DejaVu Sans;">添加一个</span><tt>receive_newsletter</tt><span style="font-family: DejaVu Sans;"><tt>字段到</tt></span><tt>user</tt><span style="font-family: DejaVu Sans;"><tt>表。</tt></span>We want it to default to <tt>false</tt> for new users, but existing users are considered to have already opted in, so we use the User model to set the flag to <tt>true</tt> for existing users.<span style="font-family: DejaVu Sans;">我们希望对于新用户默认设置</span><tt>receive_newsletter</tt><span style="font-family: DejaVu Sans;"><tt>字段为</tt></span><tt>fasle</tt><span style="font-family: DejaVu Sans;"><tt>，但是存在的用户被认为已经有（自己的）选择，因此我们通过在</tt></span><tt>User</tt><tt> </tt><tt>model</tt><span style="font-family: DejaVu Sans;"><tt>中存在的用户设置为</tt></span><tt>True</tt><span style="font-family: DejaVu Sans;"><tt>的标识（来保留以后信息）。</tt></span>

Rails 3.1 makes migrations smarter by providing a new <tt>change</tt> method.Rails3.1<span style="font-family: DejaVu Sans;">通过提供一个新的</span>change<span style="font-family: DejaVu Sans;">方法，使得</span>migrations<span style="font-family: DejaVu Sans;">更加智能化。</span>This method is preferred<span style="font-family: DejaVu Sans;">首选</span>for writing constructive migrations (adding columns or tables).<span style="font-family: DejaVu Sans;">这个方法是用来做（数据库）结构迁移（添加或删除字段）的首选。</span>The migration knows how to migrate your database and reverse it when the migration is rolled back without the need to write a separate <tt>down</tt> method.migration<span style="font-family: DejaVu Sans;">知道怎样迁移你的数据库以及不需要单独的编写</span>down<span style="font-family: DejaVu Sans;">方法来处理回滚是的</span>migration<span style="font-family: DejaVu Sans;">。</span>

<code>class</code> <code>CreateProducts</code><code> </code><code>&lt;</code><code> </code><code>ActiveRecord::Migration</code>

<code> </code><code>def</code> <code>change</code>

<code> </code><code>create_table</code><code> </code><code>:products</code> <code>do</code> <code>|t|</code>

<code> </code><code>t.string</code><code> </code><code>:name</code>

<code> </code><code>t.text</code><code> </code><code>:description</code>

&nbsp;

<code> </code><code>t.timestamps</code>

<code> </code><code>end</code>

<code> </code><code>end</code>

<code>end</code>
<h4><a name="migrations-are-classes"></a>1.1 Migrations are Classes Migrations<span style="font-family: WenQuanYi Micro Hei;">是一个类</span></h4>
A migration is a subclass of <tt>ActiveRecord::Migration</tt> that implements two methods: <tt>up</tt> (perform the required transformations) and <tt>down</tt> (revert them).<span style="font-family: DejaVu Sans;">一个</span>migration<span style="font-family: DejaVu Sans;">类是</span><tt>ActiveRecord::Migration</tt><span style="font-family: DejaVu Sans;">的子类，它实现了两个方法：</span>up<span style="font-family: DejaVu Sans;">（执行所请求的转换）和</span>down<span style="font-family: DejaVu Sans;">（撤销所做的更改）。</span>

Active Record provides methods that perform common data definition tasks in a database independent way (you’ll read about them in detail later):Active Record<span style="font-family: DejaVu Sans;">提供了了在数据库中执行常见数据定义的方法（你将会在后面看到详细的介绍）。</span>
<ul>
	<li><tt>create_table</tt></li>
	<li><tt>change_table</tt></li>
	<li><tt>drop_table</tt></li>
	<li><tt>add_column</tt></li>
	<li><tt>change_column</tt></li>
	<li><tt>rename_column</tt></li>
	<li><tt>remove_column</tt></li>
	<li><tt>add_index</tt></li>
	<li><tt>remove_index</tt></li>
</ul>
If you need to perform tasks specific to your database (for example create a <a href="http://guides.rubyonrails.org/migrations.html#active-record-and-referential-integrity"><span style="color: #000080;"><span style="text-decoration: underline;">foreign</span></span><span style="color: #000080;"><span style="text-decoration: underline;">key</span></span></a> constraint<span style="font-family: DejaVu Sans;">约束</span>) then the <tt>execute</tt> function allows you to execute arbitrary SQL.<span style="font-family: DejaVu Sans;">如果你在你的数据库中需要处理特殊的任务（例如创建一个</span>foreign key<span style="font-family: DejaVu Sans;">约束）那么</span>execute<span style="font-family: DejaVu Sans;">功能允许你执行任意的</span>SQL<span style="font-family: DejaVu Sans;">（语句）。</span>A migration is just a regular Ruby class so you’re not limited to these functions. migration<span style="font-family: DejaVu Sans;">仅仅是一个</span>Ruby<span style="font-family: DejaVu Sans;">类，因此你不必仅仅局限于现有的这些功能。</span>For example after adding a column you could write code to set the value of that column for existing records (if necessary using your models).<span style="font-family: DejaVu Sans;">例如在添加了一个字段之后你可以添加代码来设置这个字段在存在记录中的值（如果在你的</span>model<span style="font-family: DejaVu Sans;">中需要）。</span>

On databases that support transactions<span style="font-family: DejaVu Sans;">处理办理</span>with statements that change the schema (such as PostgreSQL or SQLite3), migrations are wrapped in a transaction.<span style="font-family: DejaVu Sans;">当数据库支持通过声明来改变数据库的结构（例如</span>PostgreSQL<span style="font-family: DejaVu Sans;">和</span>SQLite3<span style="font-family: DejaVu Sans;">），会在包含在</span>migration<span style="font-family: DejaVu Sans;">处理中（直接改变数据库的结构）。</span>If the database does not support this (for example MySQL) then when a migration fails the parts of it that succeeded will not be rolled back. <span style="font-family: DejaVu Sans;">如果数据库不支持这样的功能（比如</span>MySQL<span style="font-family: DejaVu Sans;">）然后</span>migration<span style="font-family: DejaVu Sans;">会有部分失败<span style="font-family: Liberation Serif,Times New Roman,serif;">——</span>成功添加的（数据）将不会回滚。</span>You will have to unpick the changes that were made by hand.<span style="font-family: DejaVu Sans;">你必须手动的分开这些改变。</span>
<h4><a name="what-s-in-a-name"></a>1.2 What’s in a Name <span style="font-family: WenQuanYi Micro Hei;">（数据库文件）名称中的信息</span></h4>
Migrations are stored in files in <tt>db/migrate</tt>, one for each migration class.Mgirations<span style="font-family: DejaVu Sans;">以单个文件的形式被存放在文件夹</span><tt>db/migrate</tt><span style="font-family: DejaVu Sans;"><tt>中</tt>。</span>The name of the file is of the form <tt>YYYYMMDDHHMMSS_create_products.rb</tt>, that is to say a UTC timestamp<span style="font-family: DejaVu Sans;">时间戳</span>identifying<span style="font-family: DejaVu Sans;">确定</span>the migration followed by an underscore<span style="font-family: DejaVu Sans;">下划线</span>followed by the name of the migration.<span style="font-family: DejaVu Sans;">（</span>migration<span style="font-family: DejaVu Sans;">）文件是以</span>form<span style="font-family: DejaVu Sans;">命名的，还看见了一个在</span>migration<span style="font-family: DejaVu Sans;">完成之时的时间戳接着是下划线接着是</span>migration<span style="font-family: DejaVu Sans;">的名字。</span>The name of the migration class (CamelCased version) should match the latter part of the file name. migraiton<span style="font-family: DejaVu Sans;">类（使用驼峰命名法）的名字应该和</span>migration<span style="font-family: DejaVu Sans;">文件的名称的最后部分相匹配。</span>For example <tt>20080906120000_create_products.rb</tt> should define <tt>CreateProducts</tt> and <tt>20080906120001_add_details_to_products.rb</tt> should define <tt>AddDetailsToProducts</tt>. If you do feel the need to change the file name then you <em>have</em><em> </em><em>to</em> update the name of the class inside or Rails will complain about a missing class.<span style="font-family: DejaVu Sans;">如果你觉得需要改变</span>migration<span style="font-family: DejaVu Sans;">文件的名字你必须同样修改文件里边</span>migration<span style="font-family: DejaVu Sans;">类的名字，不然</span>Rails<span style="font-family: DejaVu Sans;">会找不到</span>migration<span style="font-family: DejaVu Sans;">类。</span>

Internally Rails only uses the migration’s number (the timestamp) to identify them.<span style="font-family: DejaVu Sans;">在</span>Rails<span style="font-family: DejaVu Sans;">内部只使用</span>migration<span style="font-family: DejaVu Sans;">编号（时间戳）来确定他们。</span>Prior to Rails 2.1 the migration number started at 1 and was incremented each time a migration was generated.<span style="font-family: DejaVu Sans;">在</span>Rails2.1<span style="font-family: DejaVu Sans;">之前</span>migration<span style="font-family: DejaVu Sans;">编号从</span>1<span style="font-family: DejaVu Sans;">开始然后在每次</span>migration<span style="font-family: DejaVu Sans;">被创建过后增加。</span>With multiple developers it was easy for these to clash requiring you to rollback migrations and renumber them.<span style="font-family: DejaVu Sans;">随着开发人员的增多这样会使的很容易产生冲突这就需要你回滚</span>migrations<span style="font-family: DejaVu Sans;">和重新编号他们。</span>developers With Rails 2.1 this is largely avoided by using the creation time of the migration to identify them.Rails2.1<span style="font-family: DejaVu Sans;">的开发人员通过</span>migraiton<span style="font-family: DejaVu Sans;">文件的创建时间指明每个文件在很大程度上避免了冲突（的发生）。</span>You can revert to the old numbering scheme by adding the following line to <tt>config/application.rb</tt>.<span style="font-family: DejaVu Sans;">你可以还原带旧的版本通过在</span><tt>config/application.rb</tt><span style="font-family: DejaVu Sans;"><tt>文件中添加如下行：</tt></span>

<code>config.active_record.timestamped_migrations</code><code> </code><code>=</code><code> </code><code>false</code>

<tt>The</tt><tt> </tt><tt>combination</tt><span style="font-family: DejaVu Sans;"><tt>组合</tt><tt></tt></span><tt>of</tt><tt> </tt><tt>timestamps</tt><tt> </tt><tt>and</tt><tt> </tt><tt>recording</tt><tt> </tt><tt>which</tt><tt> </tt><tt>migrations</tt><tt> </tt><tt>have</tt><tt> </tt><tt>been</tt><tt> </tt><tt>run</tt><tt> </tt><tt>allows</tt><tt> </tt><tt>Rails</tt><tt> </tt><tt>to</tt><tt> </tt><tt>handle</tt><tt> </tt><tt>common</tt><tt> </tt><tt>situations</tt><tt> </tt><tt>that</tt><tt> </tt><tt>occur</tt><tt> </tt><tt>with</tt><tt> </tt><tt>multiple</tt><tt> </tt><tt>developers.</tt><span style="font-family: DejaVu Sans;"><tt>时间戳和</tt></span><tt>migrations</tt><span style="font-family: DejaVu Sans;"><tt>的名字的组合使得</tt></span><tt>Rails</tt><span style="font-family: DejaVu Sans;"><tt>可以处理多个开发人员的普遍情况。</tt></span>

<tt>For</tt><tt> </tt><tt>example</tt><tt> </tt><tt>Alice</tt><tt> </tt><tt>adds</tt><tt> </tt><tt>migrations</tt><tt> </tt><tt>20080906120000</tt><tt> </tt><tt>and</tt><tt> </tt><tt>20080906123000</tt><tt> </tt><tt>and</tt><tt> </tt><tt>Bob</tt><tt> </tt><tt>adds</tt><tt> </tt><tt>20080906124500</tt><tt> </tt><tt>and</tt><tt> </tt><tt>runs</tt><tt> </tt><tt>it.</tt><span style="font-family: DejaVu Sans;"><tt>比如</tt></span><tt>Alice</tt><tt> </tt><span style="font-family: DejaVu Sans;"><tt>添加了</tt></span><tt>migration</tt><tt> </tt><tt>20080906120000</tt><tt> </tt><tt>and</tt><tt> </tt><tt>20080906123000</tt><span style="font-family: DejaVu Sans;"><tt>以及</tt></span><tt>Bob</tt><span style="font-family: DejaVu Sans;"><tt>添加并运行了</tt><tt></tt></span><tt>20080906124500</tt><span style="font-family: DejaVu Sans;"><tt>。</tt><tt></tt></span><tt>Alice</tt><tt> </tt><tt>finishes</tt><tt> </tt><tt>her</tt><tt> </tt><tt>changes</tt><tt> </tt><tt>and</tt><tt> </tt><tt>checks</tt><tt> </tt><tt>in</tt><tt> </tt><tt>her</tt><tt> </tt><tt>migrations</tt><tt> </tt><tt>and</tt><tt> </tt><tt>Bob</tt><tt> </tt><tt>pulls</tt><tt> </tt><tt>down</tt><tt> </tt><tt>the</tt><tt> </tt><tt>latest</tt><tt> </tt><tt>changes.</tt><tt> </tt><tt>Alice</tt><span style="font-family: DejaVu Sans;"><tt>完成了他的更改并提交在他的</tt></span><tt>migrationss</tt><span style="font-family: DejaVu Sans;"><tt>中，并且</tt></span><tt>Bob</tt><tt> </tt><tt>pull</tt><tt> </tt><tt>down</tt><span style="font-family: DejaVu Sans;"><tt>了最新的更改。</tt><tt></tt></span><tt>Rails</tt><tt> </tt><tt>knows</tt><tt> </tt><tt>that</tt><tt> </tt><tt>it</tt><tt> </tt><tt>has</tt><tt> </tt><tt>not</tt><tt> </tt><tt>run</tt><tt> </tt><tt>Alice</tt><tt>’</tt><tt>s</tt><tt> </tt><tt>two</tt><tt> </tt><tt>migrations</tt><tt> </tt><tt>so</tt><tt> </tt><tt>rake</tt><tt> </tt><tt>db:migrate</tt><tt> </tt><tt>would</tt><tt> </tt><tt>run</tt><tt> </tt><tt>them</tt><tt> </tt><tt>(even</tt><tt> </tt><tt>though</tt><tt> </tt><tt>Bob</tt><tt>’</tt><tt>s</tt><tt> </tt><tt>migration</tt><tt> </tt><tt>with</tt><tt> </tt><tt>a</tt><tt> </tt><tt>later</tt><tt> </tt><tt>timestamp</tt><tt> </tt><tt>has</tt><tt> </tt><tt>been</tt><tt> </tt><tt>run),</tt><tt> </tt><tt>and</tt><tt> </tt><tt>similarly</tt><tt> </tt><tt>migrating</tt><tt> </tt><tt>down</tt><tt> </tt><tt>would</tt><tt> </tt><tt>not</tt><tt> </tt><tt>run</tt><tt> </tt><tt>their</tt><tt> </tt><tt>down</tt><tt> </tt><tt>methods.</tt>

<tt>Of</tt><tt> </tt><tt>course</tt><tt> </tt><tt>this</tt><tt> </tt><tt>is</tt><tt> </tt><tt>no</tt><tt> </tt><tt>substitution</tt><tt> </tt><tt>for</tt><tt> </tt><tt>communication</tt><tt> </tt><tt>within</tt><tt> </tt><tt>the</tt><tt> </tt><tt>team.</tt><span style="font-family: DejaVu Sans;"><tt>当然这些在团队交流中是不可避免的。</tt><tt></tt></span><tt>For</tt><tt> </tt><tt>example,</tt><tt> </tt><tt>if</tt><tt> </tt><tt>Alice</tt><tt>’</tt><tt>s</tt><tt> </tt><tt>migration</tt><tt> </tt><tt>removed</tt><tt> </tt><tt>a</tt><tt> </tt><tt>table</tt><tt> </tt><tt>that</tt><tt> </tt><tt>Bob</tt><tt>’</tt><tt>s</tt><tt> </tt><tt>migration</tt><tt> </tt><tt>assumed</tt><tt> </tt><tt>to</tt><tt> </tt><tt>exist,</tt><tt> </tt><tt>then</tt><tt> </tt><tt>trouble</tt><tt> </tt><tt>would</tt><tt> </tt><tt>certainly</tt><tt> </tt><tt>strike.</tt><span style="font-family: DejaVu Sans;"><tt>例如如果</tt></span><tt>Alice</tt><span style="font-family: DejaVu Sans;"><tt>在</tt></span><tt>migration</tt><span style="font-family: DejaVu Sans;"><tt>中移除了一个表但是</tt></span><tt>Bob's</tt><span style="font-family: DejaVu Sans;"><tt>的</tt></span><tt>migraion</tt><span style="font-family: DejaVu Sans;"><tt>假设它还在，那么麻烦就来了。</tt></span>
<h4><a name="changing-migrations"></a><tt>1.3</tt><tt> </tt><tt>Changing</tt><tt> </tt><tt>Migrations</tt></h4>
<tt>Occasionally</tt><tt> </tt><tt>you</tt><tt> </tt><tt>will</tt><tt> </tt><tt>make</tt><tt> </tt><tt>a</tt><tt> </tt><tt>mistake</tt><tt> </tt><tt>when</tt><tt> </tt><tt>writing</tt><tt> </tt><tt>a</tt><tt> </tt><tt>migration.</tt><span style="font-family: DejaVu Sans;"><tt>偶尔你在写入一个</tt></span><tt>migration</tt><span style="font-family: DejaVu Sans;"><tt>的时候犯个错误。</tt><tt></tt></span><tt>If</tt><tt> </tt><tt>you</tt><tt> </tt><tt>have</tt><tt> </tt><tt>already</tt><tt> </tt><tt>run</tt><tt> </tt><tt>the</tt><tt> </tt><tt>migration</tt><tt> </tt><tt>then</tt><tt> </tt><tt>you</tt><tt> </tt><tt>cannot</tt><tt> </tt><tt>just</tt><tt> </tt><tt>edit</tt><tt> </tt><tt>the</tt><tt> </tt><tt>migration</tt><tt> </tt><tt>and</tt><tt> </tt><tt>run</tt><tt> </tt><tt>the</tt><tt> </tt><tt>migration</tt><tt> </tt><tt>again:</tt><tt> </tt><tt>Rails</tt><tt> </tt><tt>thinks</tt><tt> </tt><tt>it</tt><tt> </tt><tt>has</tt><tt> </tt><tt>already</tt><tt> </tt><tt>run</tt><tt> </tt><tt>the</tt><tt> </tt><tt>migration</tt><tt> </tt><tt>and</tt><tt> </tt><tt>so</tt><tt> </tt><tt>will</tt><tt> </tt><tt>do</tt><tt> </tt><tt>nothing</tt><tt> </tt><tt>when</tt><tt> </tt><tt>you</tt><tt> </tt><tt>run</tt><tt> </tt><tt>rake</tt><tt> </tt><tt>db:migrate.</tt><span style="font-family: DejaVu Sans;"><tt>如果你已经运行了</tt></span><tt>migration</tt><span style="font-family: DejaVu Sans;"><tt>接着你不可能再去编辑和运行这个（错误的）</tt></span><tt>migraion</tt><span style="font-family: DejaVu Sans;"><tt>：</tt></span><tt>Rails</tt><span style="font-family: DejaVu Sans;"><tt>认为（你已经）运行了</tt></span><tt>migration</tt><span style="font-family: DejaVu Sans;"><tt>因此在你运</tt></span><tt>rake</tt><tt> </tt><tt>db:migrate</tt><span style="font-family: DejaVu Sans;"><tt>的时候不会做任何改变。</tt><tt></tt></span><tt>You</tt><tt> </tt><tt>must</tt><tt> </tt><tt>rollback</tt><tt> </tt><tt>the</tt><tt> </tt><tt>migration</tt><tt> </tt><tt>(for</tt><tt> </tt><tt>example</tt><tt> </tt><tt>with</tt><tt> </tt><tt>rake</tt><tt> </tt><tt>db:rollback),</tt><tt> </tt><tt>edit</tt><tt> </tt><tt>your</tt><tt> </tt><tt>migration</tt><tt> </tt><tt>and</tt><tt> </tt><tt>then</tt><tt> </tt><tt>run</tt><tt> </tt><tt>rake</tt><tt> </tt><tt>db:migrate</tt><tt> </tt><tt>to</tt><tt> </tt><tt>run</tt><tt> </tt><tt>the</tt><tt> </tt><tt>corrected</tt><tt> </tt><tt>version.</tt><span style="font-family: DejaVu Sans;"><tt>你必须回滚</tt></span><tt>migation</tt><span style="font-family: DejaVu Sans;"><tt>（例如</tt></span><tt>rake</tt><tt> </tt><tt>db:rollback</tt><span style="font-family: DejaVu Sans;"><tt>），编辑修改你的</tt></span><tt>migraion</tt><span style="font-family: DejaVu Sans;"><tt>然后运行正确的版本</tt><tt></tt></span><tt>rake</tt><tt> </tt><tt>db:migrate</tt><span style="font-family: DejaVu Sans;"><tt>。</tt></span>

<tt>In</tt><tt> </tt><tt>general</tt><tt> </tt><tt>editing</tt><tt> </tt><tt>existing</tt><tt> </tt><tt>migrations</tt><tt> </tt><tt>is</tt><tt> </tt><tt>not</tt><tt> </tt><tt>a</tt><tt> </tt><tt>good</tt><tt> </tt><tt>idea:</tt><tt> </tt><tt>you</tt><tt> </tt><tt>will</tt><tt> </tt><tt>be</tt><tt> </tt><tt>creating</tt><tt> </tt><tt>extra</tt><tt> </tt><tt>work</tt><tt> </tt><tt>for</tt><tt> </tt><tt>yourself</tt><tt> </tt><tt>and</tt><tt> </tt><tt>your</tt><tt> </tt><tt>co-workers</tt><tt> </tt><tt>and</tt><tt> </tt><tt>cause</tt><tt> </tt><tt>major</tt><tt> </tt><tt>headaches</tt><tt> </tt><tt>if</tt><tt> </tt><tt>the</tt><tt> </tt><tt>existing</tt><tt> </tt><tt>version</tt><tt> </tt><tt>of</tt><tt> </tt><tt>the</tt><tt> </tt><tt>migration</tt><tt> </tt><tt>has</tt><tt> </tt><tt>already</tt><tt> </tt><tt>been</tt><tt> </tt><tt>run</tt><tt> </tt><tt>on</tt><tt> </tt><tt>production</tt><tt> </tt><tt>machines.</tt><span style="font-family: DejaVu Sans;"><tt>在一般情况下，编辑存在的</tt></span><tt>migrations</tt><span style="font-family: DejaVu Sans;"><tt>不是一个好主意：因为这样你会给你自己或者你的合作成员产生额外的工作，头疼的原因是如果存在的</tt></span><tt>migration</tt><span style="font-family: DejaVu Sans;"><tt>已经在</tt></span><tt>production</tt><span style="font-family: DejaVu Sans;"><tt>机器中运行。</tt><tt></tt></span><tt>Instead</tt><tt> </tt><tt>you</tt><tt> </tt><tt>should</tt><tt> </tt><tt>write</tt><tt> </tt><tt>a</tt><tt> </tt><tt>new</tt><tt> </tt><tt>migration</tt><tt> </tt><tt>that</tt><tt> </tt><tt>performs</tt><tt> </tt><tt>the</tt><tt> </tt><tt>changes</tt><tt> </tt><tt>you</tt><tt> </tt><tt>require.</tt><span style="font-family: DejaVu Sans;"><tt>作为替代你应该编写一个新的</tt></span><tt>migration</tt><span style="font-family: DejaVu Sans;"><tt>来执行你需要的更改。</tt><tt></tt></span><tt>Editing</tt><tt> </tt><tt>a</tt><tt> </tt><tt>freshly</tt><tt> </tt><tt>generated</tt><tt> </tt><tt>migration</tt><tt> </tt><tt>that</tt><tt> </tt><tt>has</tt><tt> </tt><tt>not</tt><tt> </tt><tt>yet</tt><tt> </tt><tt>been</tt><tt> </tt><tt>committed</tt><tt> </tt><tt>to</tt><tt> </tt><tt>source</tt><tt> </tt><tt>control</tt><tt> </tt><tt>(or</tt><tt> </tt><tt>more</tt><tt> </tt><tt>generally</tt><tt> </tt><tt>which</tt><tt> </tt><tt>has</tt><tt> </tt><tt>not</tt><tt> </tt><tt>been</tt><tt> </tt><tt>propagated</tt><tt> </tt><tt>beyond</tt><tt> </tt><tt>your</tt><tt> </tt><tt>development</tt><tt> </tt><tt>machine)</tt><tt> </tt><tt>is</tt><tt> </tt><tt>relatively</tt><tt> </tt><tt>harmless.</tt><span style="font-family: DejaVu Sans;"><tt>编辑一个刚生成的还没有提交到软代码控制</tt></span><tt>migration</tt><span style="font-family: DejaVu Sans;"><tt>（或者更一般的情况还没有传播出你的开发机器）相对危害较轻。</tt></span>
<h4><a name="supported-types"></a>1.4 Supported Types<span style="font-family: WenQuanYi Micro Hei;">支持的类型</span></h4>
Active Record supports the following types:Active Record<span style="font-family: DejaVu Sans;">支持如下类型：</span>
<ul>
	<li><tt>:primary_key</tt></li>
	<li><tt>:string</tt></li>
	<li><tt>:text</tt></li>
	<li><tt>:integer</tt></li>
	<li><tt>:float</tt></li>
	<li><tt>:decimal</tt> 10<span style="font-family: DejaVu Sans;">进制</span></li>
	<li><tt>:datetime</tt></li>
	<li><tt>:timestamp</tt></li>
	<li><tt>:time</tt></li>
	<li><tt>:date</tt></li>
	<li><tt>:binary</tt></li>
	<li><tt>:boolean</tt></li>
</ul>
These will be mapped onto an appropriate underlying<span style="font-family: DejaVu Sans;">底层</span>database type, for example with MySQL <tt>:string</tt> is mapped to <tt>VARCHAR(255)</tt>.<span style="font-family: DejaVu Sans;">这些将会被映射为合适底层数据库的类型，例如使用</span>MySQL :string<span style="font-family: DejaVu Sans;">类型将会映射成</span><tt>VARCHAR(255)</tt><span style="font-family: DejaVu Sans;"><tt>。</tt></span>You can create columns of types not supported by Active Record when using the non-sexy syntax, for example<span style="font-family: DejaVu Sans;">你可以在创建</span>Active Record<span style="font-family: DejaVu Sans;">不支持的字段，使用</span>non-sexy<span style="font-family: DejaVu Sans;">语法，例如</span>

<code>create_table</code><code> </code><code>:products</code> <code>do</code> <code>|t|</code>

<code> </code><code>t.column</code><code> </code><code>:name,</code><code> </code><code>'polygon',</code><code> </code><code>:null</code> <code>=&gt;</code><code> </code><code>false</code>

<code>end</code>

This may however hinder<span style="font-family: DejaVu Sans;">阻碍</span>portability<span style="font-family: DejaVu Sans;">移植</span>to other databases.<span style="font-family: DejaVu Sans;">不过这可能会阻碍移植到其它数据库。</span>
<h3><a name="creating-a-migration"></a>2 Creating a Migration<span style="font-family: WenQuanYi Micro Hei;">新建一个</span>Migrateion</h3>
<h4><a name="creating-a-model"></a>2.1 Creating a Model<span style="font-family: WenQuanYi Micro Hei;">新建一个</span>Model</h4>
The model and scaffold generators will create migrations appropriate for adding a new model.model<span style="font-family: DejaVu Sans;">和</span>generators<span style="font-family: DejaVu Sans;">创建器会为添加的新的</span>model<span style="font-family: DejaVu Sans;">创建合适的</span>migrations<span style="font-family: DejaVu Sans;">。</span>This migration will already contain instructions for creating the relevant<span style="font-family: DejaVu Sans;">有关</span>table.<span style="font-family: DejaVu Sans;">这个</span>migration<span style="font-family: DejaVu Sans;">已经包含在有关创建的的表的说明中。</span>If you tell Rails what columns you want then statements<span style="font-family: DejaVu Sans;">声明</span>for adding those will also be created. For example, running<span style="font-family: DejaVu Sans;">如果你告诉</span>Rails<span style="font-family: DejaVu Sans;">将你随后声明的字段添加到创建</span>migrations<span style="font-family: DejaVu Sans;">中，例如，运行</span>

<code>$</code><code> </code><code>rails</code><code> </code><code>generate</code><code> </code><code>model</code><code> </code><code>Product</code><code> </code><code>name:string</code><code> </code><code>description:text</code>

<code>will</code><code> </code><code>create</code><code> </code><code>a</code><code> </code><code>migration</code><code> </code><code>that</code><code> </code><code>looks</code><code> </code><code>like</code><code> </code><code>this</code><code> </code><span style="font-family: DejaVu Sans;"><code>（</code></span><code>rails</code><span style="font-family: DejaVu Sans;"><code>）将会新建一个像这样的</code></span><code>migraion</code><span style="font-family: DejaVu Sans;"><code>：</code></span>

<code>class</code><code> </code><code>CreateProducts</code><code> </code><code>&lt;</code><code> </code><code>ActiveRecord::Migration</code>

<code> </code><code>def</code> <code>change</code>

<code> </code><code>create_table</code><code> </code><code>:products</code> <code>do</code> <code>|t|</code>

<code> </code><code>t.string</code><code> </code><code>:name</code>

<code> </code><code>t.text</code><code> </code><code>:description</code>

&nbsp;

<code> </code><code>t.timestamps</code>

<code> </code><code>end</code>

<code> </code><code>end</code>

<code>end</code>

<code>You</code><code> </code><code>can</code><code> </code><code>append</code><code> </code><code>as</code><code> </code><code>many</code><code> </code><code>column</code><code> </code><code>name/type</code><code> </code><code>pairs</code><code> </code><code>as</code><code> </code><code>you</code><code> </code><code>want.</code><span style="font-family: DejaVu Sans;"><code>你可以随意增加字段或者类型对。</code><code></code></span><code>By</code><code> </code><code>default</code><code> </code><tt>t.timestamps</tt><code> </code><code>(which</code><code> </code><code>creates</code><code> </code><code>the</code><code> </code><tt>updated_at</tt><code> </code><code>and</code><code> </code><tt>created_at</tt><code> </code><code>columns</code><code> </code><code>that</code><code> </code><code>are</code><code> </code><code>automatically</code><code> </code><code>populated</code><code> </code><code>by</code><code> </code><code>Active</code><code> </code><code>Record)</code><code> </code><code>will</code><code> </code><code>be</code><code> </code><code>added</code><code> </code><code>for</code><code> </code><code>you.</code><span style="font-family: DejaVu Sans;"><code>默认的</code><code></code></span><code>t.timestamps</code><span style="font-family: DejaVu Sans;"><code>（</code></span><code>Active</code><code> </code><code>Record</code><code> </code><span style="font-family: DejaVu Sans;"><code>会自动生成</code></span><tt>updated_at</tt><span style="font-family: DejaVu Sans;"><code>和</code></span><tt>created_at</tt><span style="font-family: DejaVu Sans;"><tt>字段</tt><code>）会子添加在你的表中。</code></span>
<h4><a name="creating-a-standalone-migration"></a>2.2 Creating a Standalone Migration<span style="font-family: WenQuanYi Micro Hei;">新建一个独立的</span>Migration</h4>
If you are creating migrations for other purposes (for example to add a column to an existing table) then you can use the migration generator:<span style="font-family: DejaVu Sans;">如果你正在因为其他的目的新建</span>migrations<span style="font-family: DejaVu Sans;">（例如添加一个字段到一个存在的表）你可以使用</span>migration<span style="font-family: DejaVu Sans;">创建器：</span>

<code>$</code><code> </code><code>rails</code><code> </code><code>generate</code><code> </code><code>migration</code><code> </code><code>AddPartNumberToProducts</code>

This will create an empty but appropriately named migration:<span style="font-family: DejaVu Sans;">这里会新建一个空的但是合适的</span>migration<span style="font-family: DejaVu Sans;">：</span>

<code>class</code> <code>AddPartNumberToProducts</code><code> </code><code>&lt;</code><code> </code><code>ActiveRecord::Migration</code>

<code> </code><code>def</code> <code>change</code>

<code> </code><code>end</code>

<code>end</code>

If the migration name is of the form “AddXXXToYYY” or “RemoveXXXFromYYY” and is followed by a list of column names and types then a migration containing the appropriate <tt>add_column</tt> and <tt>remove_column</tt> statements will be created.<span style="font-family: DejaVu Sans;">如果</span>migration<span style="font-family: DejaVu Sans;">命名为<span style="font-family: Liberation Serif,Times New Roman,serif;">“</span></span>AddXXXToYYY”<span style="font-family: DejaVu Sans;">或<span style="font-family: Liberation Serif,Times New Roman,serif;"> “</span></span>RemoveXXXFromYYY”<span style="font-family: DejaVu Sans;">格式并且后跟有一些字段名称或类型，那么一个</span>migration<span style="font-family: DejaVu Sans;">包含合适的</span><tt>add_column</tt><span style="font-family: DejaVu Sans;">和</span><tt>remove_column</tt><span style="font-family: DejaVu Sans;"><tt>将会被新建。</tt></span>

<code>$</code><code> </code><code>rails</code><code> </code><code>generate</code><code> </code><code>migration</code><code> </code><code>AddPartNumberToProducts</code><code> </code><code>part_number:string</code>

<code>ps</code><span style="font-family: DejaVu Sans;"><code>：如果已经创建了一个</code></span><code>AddPartNumberToProducts</code><span style="font-family: DejaVu Sans;"><code>那么运行</code></span><code>rails</code><code> </code><code>generate</code><code> </code><code>migration</code><code> </code><code>AddPartNumberToProducts</code><code> </code><code>part_number:string</code><code> </code><code>-f</code><span style="font-family: DejaVu Sans;"><code>进行覆盖新建</code></span>

<code>will</code><code> </code><code>generate</code><span style="font-family: DejaVu Sans;"><code>将会生成：</code></span>

<code>class</code><code> </code><code>AddPartNumberToProducts</code><code> </code><code>&lt;</code><code> </code><code>ActiveRecord::Migration</code>

<code> </code><code>def</code> <code>change</code>

<code> </code><code>add_column</code><code> </code><code>:products,</code><code> </code><code>:part_number,</code><code> </code><code>:string</code>

<code> </code><code>end</code>

<code>end</code>

<code>Similarly,</code><span style="font-family: DejaVu Sans;"><code>同样，</code></span>

<code>$</code><code> </code><code>rails</code><code> </code><code>generate</code><code> </code><code>migration</code><code> </code><code>RemovePartNumberFromProducts</code><code> </code><code>part_number:string</code>

<code>generates</code><span style="font-family: DejaVu Sans;"><code>生成</code></span>

<code>class</code><code> </code><code>RemovePartNumberFromProducts</code><code> </code><code>&lt;</code><code> </code><code>ActiveRecord::Migration</code>

<code> </code><code>def</code> <code>up</code>

<code> </code><code>remove_column</code><code> </code><code>:products,</code><code> </code><code>:part_number</code>

<code> </code><code>end</code>

&nbsp;

<code> </code><code>def</code> <code>down</code>

<code> </code><code>add_column</code><code> </code><code>:products,</code><code> </code><code>:part_number,</code><code> </code><code>:string</code>

<code> </code><code>end</code>

<code>end</code>

<code>You</code><code> </code><code>are</code><code> </code><code>not</code><code> </code><code>limited</code><code> </code><code>to</code><code> </code><code>one</code><code> </code><code>magically</code><span style="font-family: DejaVu Sans;"><code>神奇</code><code></code></span><code>generated</code><code> </code><code>column,</code><code> </code><code>for</code><code> </code><code>example</code><span style="font-family: DejaVu Sans;"><code>你不限制于一次只输入一个字段，例如</code></span>

<code>$</code><code> </code><code>rails</code><code> </code><code>generate</code><code> </code><code>migration</code><code> </code><code>AddDetailsToProducts</code><code> </code><code>part_number:string</code><code> </code><code>price:decimal</code>

<code>generates</code><span style="font-family: DejaVu Sans;"><code>生成</code></span>

<code>class</code><code> </code><code>AddDetailsToProducts</code><code> </code><code>&lt;</code><code> </code><code>ActiveRecord::Migration</code>

<code> </code><code>def</code> <code>change</code>

<code> </code><code>add_column</code><code> </code><code>:products,</code><code> </code><code>:part_number,</code><code> </code><code>:string</code>

<code> </code><code>add_column</code><code> </code><code>:products,</code><code> </code><code>:price,</code><code> </code><code>:decimal</code>

<code> </code><code>end</code>

<code>end</code>

<code>As</code><code> </code><code>always,</code><code> </code><code>what</code><code> </code><code>has</code><code> </code><code>been</code><code> </code><code>generated</code><code> </code><code>for</code><code> </code><code>you</code><code> </code><code>is</code><code> </code><code>just</code><code> </code><code>a</code><code> </code><code>starting</code><code> </code><code>point.</code><code> </code><code>You</code><code> </code><code>can</code><code> </code><code>add</code><code> </code><code>or</code><code> </code><code>remove</code><code> </code><code>from</code><code> </code><code>it</code><code> </code><code>as</code><code> </code><code>you</code><code> </code><code>see</code><code> </code><code>fit.</code><span style="font-family: DejaVu Sans;"><code>一如往常，使用</code></span><code>migration</code><span style="font-family: DejaVu Sans;"><code>创建器生成的</code></span><code>migration</code><span style="font-family: DejaVu Sans;"><code>只是一个起点，你可以添加或删除其中的字段直到你满意为止。</code></span>

&nbsp;

<code>The</code><code> </code><code>generated</code><code> </code><code>migration</code><code> </code><code>file</code><code> </code><code>for</code><code> </code><code>destructive</code><code> </code><code>migrations</code><code> </code><code>will</code><code> </code><code>still</code><code> </code><code>be</code><code> </code><code>old-style</code><code> </code><code>using</code><code> </code><code>the</code><code> </code><tt>up</tt><code> </code><code>and</code><code> </code><tt>down</tt><code> </code><code>methods.</code><span style="font-family: DejaVu Sans;"><code>在创建的</code></span><code>migration</code><span style="font-family: DejaVu Sans;"><code>文件中对</code></span><code>migrations</code><span style="font-family: DejaVu Sans;"><code>进行破坏性的操作仍然使用老式的</code></span><code>up</code><span style="font-family: DejaVu Sans;"><code>和</code></span><code>down</code><span style="font-family: DejaVu Sans;"><code>方法。</code><code></code></span><code>This</code><code> </code><code>is</code><code> </code><code>because</code><code> </code><code>Rails</code><code> </code><code>doesn</code><code>’</code><code>t</code><code> </code><code>know</code><code> </code><code>the</code><code> </code><code>original</code><code> </code><code>data</code><code> </code><code>types</code><code> </code><code>defined</code><code> </code><code>when</code><code> </code><code>you</code><code> </code><code>made</code><code> </code><code>the</code><code> </code><code>original</code><code> </code><code>changes.</code><span style="font-family: DejaVu Sans;"><code>这是因为当你对初始</code></span><code>migration</code><span style="font-family: DejaVu Sans;"><code>做了更改，</code></span><code>Rails</code><span style="font-family: DejaVu Sans;"><code>不知道原始的数据类型定义。</code></span>

&nbsp;
<h3><a name="writing-a-migration"></a>3 Writing a Migration</h3>
Once you have created your migration using one of the generators it’s time to get to work!<span style="font-family: DejaVu Sans;">一旦你已经使用一种创建器创建了你的</span>migration<span style="font-family: DejaVu Sans;">，现在是时候开始工作了。</span>
<h4><a name="creating-a-table"></a>3.1 Creating a Table<span style="font-family: WenQuanYi Micro Hei;">创建一个表</span></h4>
Migration method <tt>create_table</tt> will be one of your workhorses. A typical use would be Migration<span style="font-family: DejaVu Sans;">方法</span><tt>create_table</tt><span style="font-family: DejaVu Sans;"><tt>将会是一个你的驮马。下面是他的典型形式</tt></span>

<code>create_table</code><code> </code><code>:products</code> <code>do</code> <code>|t|</code>

<code> </code><code>t.string</code><code> </code><code>:name</code>

<code>end</code>

which creates a <tt>products</tt> table with a column called <tt>name</tt> (and as discussed below, an implicit <tt>id</tt> column).<span style="font-family: DejaVu Sans;">上面的代码会创建一个</span>products<span style="font-family: DejaVu Sans;">表，其中包含了一个</span>name<span style="font-family: DejaVu Sans;">字段（和下面讨论的一样，一个隐藏的</span>id<span style="font-family: DejaVu Sans;">字段）</span>

The object yielded to the block allows you to create columns on the table.<span style="font-family: DejaVu Sans;">这个</span>migration<span style="font-family: DejaVu Sans;">类产生代码块让你创建表中的字段。</span>There are two ways of doing this: The first (traditional) form looks like<span style="font-family: DejaVu Sans;">有两种方法创建字段：首先（传统的）方式看起来像这样</span>

<code>create_table</code><code> </code><code>:products</code> <code>do</code> <code>|t|</code>

<code> </code><code>t.column</code><code> </code><code>:name,</code><code> </code><code>:string,</code><code> </code><code>:null</code> <code>=&gt;</code><code> </code><code>false</code>

<code>end</code>

the second form, the so called “sexy” migration, drops the somewhat redundant <tt>column</tt> method.<span style="font-family: DejaVu Sans;">第二种方式，也称为<span style="font-family: Liberation Serif,Times New Roman,serif;">“</span></span>sexy” migration<span style="font-family: DejaVu Sans;">，丢掉了有些冗余的</span>column<span style="font-family: DejaVu Sans;">方法。</span>Instead, the <tt>string</tt>, <tt>integer</tt>, etc. methods create a column of that type.<span style="font-family: DejaVu Sans;">作为替代，如</span>string,interger<span style="font-family: DejaVu Sans;">等等方法创建相应类型的字段。</span>Subsequent parameters are the same.<span style="font-family: DejaVu Sans;">其后的参赛也在同一个字段中。</span>

<code>create_table</code><code> </code><code>:products</code> <code>do</code> <code>|t|</code>

<code> </code><code>t.string</code><code> </code><code>:name,</code><code> </code><code>:null</code> <code>=&gt;</code><code> </code><code>false</code>

<code>end</code>

<code>HABTM,</code><code> </code><code>hasAndBelongsToMany</code><code> </code><span style="font-family: DejaVu Sans;"><code>这是</code></span><code>Active</code><code> </code><code>Recored</code><span style="font-family: DejaVu Sans;"><code>功能里面比较</code><code><span style="font-family: Liberation Serif,Times New Roman,serif;">“</span></code><code>复杂</code><code><span style="font-family: Liberation Serif,Times New Roman,serif;">”</span></code><code>的一个东西。简单的来说，就是你有一个帖子，你给这个帖子定义了多个</code></span><code>tag</code><span style="font-family: DejaVu Sans;"><code>，</code><code></code><code>但是实际上</code></span><code>tag</code><span style="font-family: DejaVu Sans;"><code>也是独立的，一个</code></span><code>tag</code><span style="font-family: DejaVu Sans;"><code>会包含很多个不同的帖子。</code></span>

<code>By</code><code> </code><code>default</code><code> </code><tt>create_table</tt><code> </code><code>will</code><code> </code><code>create</code><code> </code><code>a</code><code> </code><code>primary</code><code> </code><code>key</code><code> </code><code>called</code><code> </code><tt>id</tt><code>.</code><span style="font-family: DejaVu Sans;"><code>通过默认的</code><code></code></span><tt>create_table</tt><span style="font-family: DejaVu Sans;"><tt>将会创建一个叫做</tt></span><tt>id</tt><span style="font-family: DejaVu Sans;"><tt>的主键。</tt><code></code></span><code>You</code><code> </code><code>can</code><code> </code><code>change</code><code> </code><code>the</code><code> </code><code>name</code><code> </code><code>of</code><code> </code><code>the</code><code> </code><code>primary</code><code> </code><code>key</code><code> </code><code>with</code><code> </code><code>the</code><code> </code><tt>:primary_key</tt><code> </code><code>option</code><code> </code><code>(don</code><code>’</code><code>t</code><code> </code><code>forget</code><code> </code><code>to</code><code> </code><code>update</code><code> </code><code>the</code><code> </code><code>corresponding</code><span style="font-family: DejaVu Sans;"><code>相应的</code><code></code></span><code>model)</code><code> </code><code>or</code><code> </code><code>if</code><code> </code><code>you</code><code> </code><code>don</code><code>’</code><code>t</code><code> </code><code>want</code><code> </code><code>a</code><code> </code><code>primary</code><code> </code><code>key</code><code> </code><code>at</code><code> </code><code>all</code><code> </code><code>(for</code><code> </code><code>example</code><code> </code><code>for</code><code> </code><code>a</code><code> </code><code>HABTM</code><code> </code><code>join</code><code> </code><code>table)</code><code> </code><code>you</code><code> </code><code>can</code><code> </code><code>pass</code><code> </code><tt>:id</tt><tt> </tt><tt>=&gt;</tt><tt> </tt><tt>false</tt><code>.</code><span style="font-family: DejaVu Sans;"><code>你可以更改主键的名字通过使用</code></span><tt>:primary_key</tt><span style="font-family: DejaVu Sans;"><tt>选项（不要忘记更新其相应的</tt></span><tt>model</tt><span style="font-family: DejaVu Sans;"><tt>）或者你根本不想要主键（例如添加一个</tt></span><tt>HABTM</tt><span style="font-family: DejaVu Sans;"><tt>关系到表中）你可以通过</tt></span><tt>:id</tt><tt> </tt><tt>=&gt;</tt><tt> </tt><tt>false</tt><span style="font-family: DejaVu Sans;"><tt>。</tt><code></code></span><code>If</code><code> </code><code>you</code><code> </code><code>need</code><code> </code><code>to</code><code> </code><code>pass</code><code> </code><code>database</code><code> </code><code>specific</code><code> </code><code>options</code><code> </code><code>you</code><code> </code><code>can</code><code> </code><code>place</code><code> </code><code>an</code><code> </code><code>SQL</code><code> </code><code>fragment</code><code> </code><code>in</code><code> </code><code>the</code><code> </code><tt>:options</tt><code> </code><code>option.</code><code> </code><code>For</code><code> </code><code>example</code><span style="font-family: DejaVu Sans;"><code>如果你需要数据库的特殊选项你可以放置一个</code></span><code>SQL</code><span style="font-family: DejaVu Sans;"><code>片段在</code></span><tt>:options</tt><span style="font-family: DejaVu Sans;"><tt>选项中。例如</tt></span>

<code>create_table</code><code> </code><code>:products,</code><code> </code><code>:options</code> <code>=&gt;</code><code> </code><code>"ENGINE=BLACKHOLE"</code> <code>do</code> <code>|t|</code>

<code> </code><code>t.string</code><code> </code><code>:name,</code><code> </code><code>:null</code> <code>=&gt;</code><code> </code><code>false</code>

<code>end</code>

will append <tt>ENGINE=BLACKHOLE</tt> to the SQL statement used to create the table (when using MySQL the default is <tt>ENGINE=InnoDB</tt>).<span style="font-family: DejaVu Sans;">将会添加</span><tt>ENGINE=BLACKHOLE</tt><span style="font-family: DejaVu Sans;"><tt>到</tt></span><tt>SQL</tt><span style="font-family: DejaVu Sans;"><tt>声明中用于创建表单（当使用</tt></span><tt>MySQL</tt><span style="font-family: DejaVu Sans;"><tt>默认的（</tt></span><tt>ENGINE</tt><span style="font-family: DejaVu Sans;"><tt>）是</tt></span><tt>InnoDB</tt><span style="font-family: DejaVu Sans;"><tt>）。</tt></span>
<h4><a name="changing-tables"></a><tt>3.2</tt><tt> </tt><tt>Changing</tt><tt> </tt><tt>Tables</tt><span style="font-family: WenQuanYi Micro Hei;"><tt>更改表单</tt></span></h4>
A close cousin of <tt>create_table</tt> is <tt>change_table</tt>, used for changing existing tables. <tt>create_table</tt><span style="font-family: DejaVu Sans;"><tt>的一个近亲是</tt><tt></tt></span><tt>change_table</tt><span style="font-family: DejaVu Sans;"><tt>，用于更改存在的表单。</tt></span>It is used in a similar fashion to <tt>create_table</tt> but the object yielded to the block knows more tricks.<span style="font-family: DejaVu Sans;">它使用的是与</span><tt>create_table</tt><span style="font-family: DejaVu Sans;"><tt>类似的方法，但是其类产生的块能够知道更多的技巧。（如移除字段，重命名字段）</tt></span>For example<span style="font-family: DejaVu Sans;">例如</span>

<code>change_table</code><code> </code><code>:products</code> <code>do</code> <code>|t|</code>

<code> </code><code>t.remove</code><code> </code><code>:description,</code><code> </code><code>:name</code>

<code> </code><code>t.string</code><code> </code><code>:part_number</code>

<code> </code><code>t.index</code><code> </code><code>:part_number</code>

<code> </code><code>t.rename</code><code> </code><code>:upccode,</code><code> </code><code>:upc_code</code>

<code>end</code>

removes the <tt>description</tt> and <tt>name</tt> columns, creates a <tt>part_number</tt> column and adds an index on it. Finally it renames the <tt>upccode</tt> column.<span style="font-family: DejaVu Sans;">移除</span><tt>description</tt><span style="font-family: DejaVu Sans;"><tt>字段和</tt></span><tt>name</tt><span style="font-family: DejaVu Sans;"><tt>字段，创建一个</tt><tt></tt></span><tt>part_number</tt><span style="font-family: DejaVu Sans;"><tt>字段并且添加一个</tt></span><tt>index</tt><span style="font-family: DejaVu Sans;"><tt>（索引）给</tt><tt></tt></span><tt>part_number</tt><span style="font-family: DejaVu Sans;"><tt>。最后它重命名了</tt></span><code>:upccode</code><span style="font-family: DejaVu Sans;"><code>。</code></span>This is the same as doing<span style="font-family: DejaVu Sans;">下面的代码也可以达到同样的效果</span>

<code>remove_column</code><code> </code><code>:products,</code><code> </code><code>:description</code>

<code>remove_column</code><code> </code><code>:products,</code><code> </code><code>:name</code>

<code>add_column</code><code> </code><code>:products,</code><code> </code><code>:part_number,</code><code> </code><code>:string</code>

<code>add_index</code><code> </code><code>:products,</code><code> </code><code>:part_number</code>

<code>rename_column</code><code> </code><code>:products,</code><code> </code><code>:upccode,</code><code> </code><code>:upc_code</code>

&nbsp;

<tt>You</tt><tt> </tt><tt>don</tt><tt>’</tt><tt>t</tt><tt> </tt><tt>have</tt><tt> </tt><tt>to</tt><tt> </tt><tt>keep</tt><tt> </tt><tt>repeating</tt><tt> </tt><tt>the</tt><tt> </tt><tt>table</tt><tt> </tt><tt>name</tt><tt> </tt><tt>and</tt><tt> </tt><tt>it</tt><tt> </tt><tt>groups</tt><tt> </tt><tt>all</tt><tt> </tt><tt>the</tt><tt> </tt><tt>statements</tt><tt> </tt><tt>related</tt><tt> </tt><tt>to</tt><tt> </tt><tt>modifying</tt><tt> </tt><tt>one</tt><tt> </tt><tt>particular</tt><tt> </tt><tt>table.</tt><span style="font-family: DejaVu Sans;"><tt>你不必重复表单名称和组相关的所有声明，（而</tt><tt>只需要重复）修改表的一部分。</tt><tt></tt></span><tt>The</tt><tt> </tt><tt>individual</tt><span style="font-family: DejaVu Sans;"><tt>个别</tt><tt></tt></span><tt>transformation</tt><span style="font-family: DejaVu Sans;"><tt>转换</tt><tt></tt></span><tt>names</tt><tt> </tt><tt>are</tt><tt> </tt><tt>also</tt><tt> </tt><tt>shorter,</tt><tt> </tt><tt>for</tt><tt> </tt><tt>example</tt><tt> </tt><tt>remove_column</tt><tt> </tt><tt>becomes</tt><tt> </tt><tt>just</tt><tt> </tt><tt>remove</tt><tt> </tt><tt>and</tt><tt> </tt><tt>add_index</tt><tt> </tt><tt>becomes</tt><tt> </tt><tt>just</tt><tt> </tt><tt>index.</tt><span style="font-family: DejaVu Sans;"><tt>个别的转换方法的名称也更加简短了，例如</tt><tt></tt></span><tt>remove_column</tt><span style="font-family: DejaVu Sans;"><tt>变成</tt></span><tt>remove</tt><span style="font-family: DejaVu Sans;"><tt>，</tt><tt></tt></span><tt>add_index</tt><span style="font-family: DejaVu Sans;"><tt>变成</tt></span><tt>index</tt><span style="font-family: DejaVu Sans;"><tt>。</tt></span><tt>##</tt><span style="font-family: DejaVu Sans;"><tt>这里是说的新旧两种方法比较</tt></span>
<h4><a name="special-helpers"></a><tt>3.3</tt><tt> </tt><tt>Special</tt><tt> </tt><tt>Helpers</tt><span style="font-family: WenQuanYi Micro Hei;"><tt>个别的</tt></span><tt>Helpers</tt></h4>
<a name="result_box"></a><tt>Active</tt><tt> </tt><tt>Record</tt><tt> </tt><tt>provides</tt><tt> </tt><tt>some</tt><tt> </tt><tt>shortcuts</tt><tt> </tt><tt>for</tt><tt> </tt><tt>common</tt><tt> </tt><tt>functionality.Active</tt><tt> </tt><tt>Record</tt><span style="font-family: DejaVu Sans;"><tt>提供了一些一般功能的快捷操作。</tt><tt></tt></span><tt>It</tt><tt> </tt><tt>is</tt><tt> </tt><tt>for</tt><tt> </tt><tt>example</tt><tt> </tt><tt>very</tt><tt> </tt><tt>common</tt><tt> </tt><tt>to</tt><tt> </tt><tt>add</tt><tt> </tt><tt>both</tt><tt> </tt><tt>the</tt><tt> </tt><tt>created_at</tt><tt> </tt><tt>and</tt><tt> </tt><tt>updated_at</tt><tt> </tt><tt>columns</tt><tt> </tt><tt>and</tt><tt> </tt><tt>so</tt><tt> </tt><tt>there</tt><tt> </tt><tt>is</tt><tt> </tt><tt>a</tt><tt> </tt><tt>method</tt><tt> </tt><tt>that</tt><tt> </tt><tt>does</tt><tt> </tt><tt>exactly</tt><tt> </tt><tt>that:</tt><span style="font-family: DejaVu Sans;"><tt>例如很常见的通过</tt></span><tt>created_at</tt><span style="font-family: DejaVu Sans;"><tt>和</tt></span><tt>updated_at</tt><span style="font-family: DejaVu Sans;"><tt>添加</tt><tt>字段等等</tt><tt>，这里是一个方法的简要例子</tt></span>

<code>create_table</code><code> </code><code>:products</code><tt> </tt><code>do</code><tt> </tt><code>|t|</code>

<code> </code><code>t.timestamps</code>

<code>end</code>

<tt>will</tt><tt> </tt><tt>create</tt><tt> </tt><tt>a</tt><tt> </tt><tt>new</tt><tt> </tt><tt>products</tt><tt> </tt><tt>table</tt><tt> </tt><tt>with</tt><tt> </tt><tt>those</tt><tt> </tt><tt>two</tt><tt> </tt><tt>columns</tt><tt> </tt><tt>(plus</tt><tt> </tt><tt>the</tt><tt> </tt><tt>id</tt><tt> </tt><tt>column)</tt><tt> </tt><tt>whereas.</tt><span style="font-family: DejaVu Sans;"><tt>将会新建一个</tt></span><tt>products</tt><span style="font-family: DejaVu Sans;"><tt>表单，有两个字段（加上</tt></span><tt>id</tt><span style="font-family: DejaVu Sans;"><tt>字段）。</tt></span>

<code>change_table</code><code> </code><code>:products</code><tt> </tt><code>do</code><tt> </tt><code>|t|</code>

<code> </code><code>t.timestamps</code>

<code>end</code>

<tt>adds</tt><tt> </tt><tt>those</tt><tt> </tt><tt>columns</tt><tt> </tt><tt>to</tt><tt> </tt><tt>an</tt><tt> </tt><tt>existing</tt><tt> </tt><tt>table.</tt><span style="font-family: DejaVu Sans;"><tt>添加一些字段到存在的表中。</tt></span>

&nbsp;

<tt>The</tt><tt> </tt><tt>other</tt><tt> </tt><tt>helper</tt><tt> </tt><tt>is</tt><tt> </tt><tt>called</tt><tt> </tt><tt>references</tt><tt> </tt><tt>(also</tt><tt> </tt><tt>available</tt><tt> </tt><tt>as</tt><tt> </tt><tt>belongs_to).</tt><tt> </tt><tt>In</tt><tt> </tt><tt>its</tt><tt> </tt><tt>simplest</tt><tt> </tt><tt>form</tt><tt> </tt><tt>it</tt><tt> </tt><tt>just</tt><tt> </tt><tt>adds</tt><tt> </tt><tt>some</tt><tt> </tt><tt>readability</tt><span style="font-family: DejaVu Sans;"><tt>另一个</tt></span><tt>helper</tt><span style="font-family: DejaVu Sans;"><tt>被称为</tt><tt></tt></span><tt>references</tt><span style="font-family: DejaVu Sans;"><tt>（也可用</tt></span><tt>belongs_to</tt><span style="font-family: DejaVu Sans;"><tt>）。在其最简单的形式，它仅仅增加一些可读性。</tt></span>

<code>create_table</code><code> </code><code>:products</code><tt> </tt><code>do</code><tt> </tt><code>|t|</code>

<code> </code><code>t.references</code><code> </code><code>:category</code>

<code>end</code>

<tt>will</tt><tt> </tt><tt>create</tt><tt> </tt><tt>a</tt><tt> </tt><tt>category_id</tt><tt> </tt><tt>column</tt><tt> </tt><tt>of</tt><tt> </tt><tt>the</tt><tt> </tt><tt>appropriate</tt><tt> </tt><tt>type.</tt><span style="font-family: DejaVu Sans;"><tt>将会创建一个适当形式的</tt></span><tt>category_id</tt><span style="font-family: DejaVu Sans;"><tt>字段。</tt><tt></tt></span><tt>Note</tt><tt> </tt><tt>that</tt><tt> </tt><tt>you</tt><tt> </tt><tt>pass</tt><tt> </tt><tt>the</tt><tt> </tt><tt>model</tt><tt> </tt><tt>name,</tt><tt> </tt><tt>not</tt><tt> </tt><tt>the</tt><tt> </tt><tt>column</tt><tt> </tt><tt>name.</tt><tt> </tt><tt>Active</tt><tt> </tt><tt>Record</tt><tt> </tt><tt>adds</tt><tt> </tt><tt>the</tt><tt> </tt><tt>_id</tt><tt> </tt><tt>for</tt><tt> </tt><tt>you.</tt><tt> </tt><span style="font-family: DejaVu Sans;"><tt>注意那是你关联的</tt></span><tt>model</tt><span style="font-family: DejaVu Sans;"><tt>名称，不是字段名称。</tt></span><tt>Active</tt><tt> </tt><tt>Record</tt><span style="font-family: DejaVu Sans;"><tt>会给你添加</tt></span><tt>_id</tt><span style="font-family: DejaVu Sans;"><tt>。</tt><tt></tt></span><tt>If</tt><tt> </tt><tt>you</tt><tt> </tt><tt>have</tt><tt> </tt><tt>polymorphic</tt><span style="font-family: DejaVu Sans;"><tt>多态性</tt><tt></tt></span><tt>belongs_to</tt><tt> </tt><tt>associations</tt><tt> </tt><tt>then</tt><tt> </tt><tt>references</tt><tt> </tt><tt>will</tt><tt> </tt><tt>add</tt><tt> </tt><tt>both</tt><tt> </tt><tt>of</tt><tt> </tt><tt>the</tt><tt> </tt><tt>columns</tt><tt> </tt><tt>required:</tt>

<code>create_table</code><code> </code><code>:products</code><tt> </tt><code>do</code><tt> </tt><code>|t|</code>

<code> </code><code>t.references</code><code> </code><code>:attachment,</code><code> </code><code>:polymorphic</code> <code>=&gt;</code><code> </code><code>{:default</code> <code>=&gt;</code><code> </code><code>'Photo'}</code>

<code>end</code>

<tt>will</tt><tt> </tt><tt>add</tt><tt> </tt><tt>an</tt><tt> </tt><tt>attachment_id</tt><tt> </tt><tt>column</tt><tt> </tt><tt>and</tt><tt> </tt><tt>a</tt><tt> </tt><tt>string</tt><tt> </tt><tt>attachment_type</tt><tt> </tt><tt>column</tt><tt> </tt><tt>with</tt><tt> </tt><tt>a</tt><tt> </tt><tt>default</tt><tt> </tt><tt>value</tt><tt> </tt><tt>of</tt><tt> ‘</tt><tt>Photo</tt><tt>’</tt><tt>.</tt><span style="font-family: DejaVu Sans;"><tt>将会添加一个</tt></span><tt>attachment_id</tt><tt> </tt><span style="font-family: DejaVu Sans;"><tt>和一个</tt><tt></tt><tt>默认值是</tt><tt><span style="font-family: Liberation Serif,Times New Roman,serif;">‘</span></tt></span><tt>Photo</tt><tt>’</tt><span style="font-family: DejaVu Sans;"><tt>的字符串</tt></span><tt>attachment_type</tt><span style="font-family: DejaVu Sans;"><tt>字段。</tt></span>

<tt>The</tt><tt> </tt><tt>references</tt><tt> </tt><tt>helper</tt><tt> </tt><tt>does</tt><tt> </tt><tt>not</tt><tt> </tt><tt>actually</tt><tt> </tt><tt>create</tt><tt> </tt><tt>foreign</tt><tt> </tt><tt>key</tt><tt> </tt><tt>constraints</tt><tt> </tt><tt>for</tt><tt> </tt><tt>you.</tt><tt> </tt><tt>You</tt><tt> </tt><tt>will</tt><tt> </tt><tt>need</tt><tt> </tt><tt>to</tt><tt> </tt><tt>use</tt><tt> </tt><tt>execute</tt><tt> </tt><tt>for</tt><tt> </tt><tt>that</tt><tt> </tt><tt>or</tt><tt> </tt><tt>a</tt><tt> </tt><tt>plugin</tt><tt> </tt><tt>that</tt><tt> </tt><tt>adds</tt><tt> </tt><a href="http://guides.rubyonrails.org/migrations.html#active-record-and-referential-integrity"><span style="color: #000080;"><span style="text-decoration: underline;">foreign</span></span><span style="color: #000080;"><span style="text-decoration: underline;">key</span></span><span style="color: #000080;"><span style="text-decoration: underline;">support</span></span></a><tt>.references</tt><tt> </tt><tt>helper</tt><span style="font-family: DejaVu Sans;"><tt>没有真正创建外键约束给你。你需要使用</tt></span><tt>execute</tt><span style="font-family: DejaVu Sans;"><tt>或者一个</tt></span><tt>plugin</tt><span style="font-family: DejaVu Sans;"><tt>来添加外键支持。</tt></span>

<tt>If</tt><tt> </tt><tt>the</tt><tt> </tt><tt>helpers</tt><tt> </tt><tt>provided</tt><tt> </tt><tt>by</tt><tt> </tt><tt>Active</tt><tt> </tt><tt>Record</tt><tt> </tt><tt>aren</tt><tt>’</tt><tt>t</tt><tt> </tt><tt>enough</tt><tt> </tt><tt>you</tt><tt> </tt><tt>can</tt><tt> </tt><tt>use</tt><tt> </tt><tt>the</tt><tt> </tt><tt>execute</tt><tt> </tt><tt>function</tt><tt> </tt><tt>to</tt><tt> </tt><tt>execute</tt><tt> </tt><tt>arbitrary</tt><tt> </tt><tt>SQL.</tt><span style="font-family: DejaVu Sans;"><tt>如果</tt><tt></tt></span><tt>Active</tt><tt> </tt><tt>Record</tt><span style="font-family: DejaVu Sans;"><tt>提供的</tt></span><tt>helper</tt><span style="font-family: DejaVu Sans;"><tt>不足以满足，你可以使用</tt><tt></tt></span><tt>execute</tt><span style="font-family: DejaVu Sans;"><tt>功能来执行任意</tt></span><tt>SQL</tt><span style="font-family: DejaVu Sans;"><tt>。</tt></span>

<tt>For</tt><tt> </tt><tt>more</tt><tt> </tt><tt>details</tt><tt> </tt><tt>and</tt><tt> </tt><tt>examples</tt><tt> </tt><tt>of</tt><tt> </tt><tt>individual</tt><span style="font-family: DejaVu Sans;"><tt>个别</tt><tt></tt></span><tt>methods</tt><tt> </tt><tt>check</tt><tt> </tt><tt>the</tt><tt> </tt><tt>API</tt><tt> </tt><tt>documentation,</tt><tt> </tt><tt>in</tt><tt> </tt><tt>particular</tt><tt> </tt><tt>the</tt><tt> </tt><tt>documentation</tt><tt> </tt><tt>for</tt><tt> </tt><span style="color: #000080;"><span style="text-decoration: underline;"><a href="http://api.rubyonrails.org/classes/ActiveRecord/ConnectionAdapters/SchemaStatements.html">ActiveRecord::ConnectionAdapters::SchemaStatements</a></span></span><tt> </tt><tt>(which</tt><tt> </tt><tt>provides</tt><tt> </tt><tt>the</tt><tt> </tt><tt>methods</tt><tt> </tt><tt>available</tt><tt> </tt><tt>in</tt><tt> </tt><tt>the</tt><tt> </tt><tt>up</tt><tt> </tt><tt>and</tt><tt> </tt><tt>down</tt><tt> </tt><tt>methods),</tt><tt> </tt><span style="color: #000080;"><span style="text-decoration: underline;"><a href="http://api.rubyonrails.org/classes/ActiveRecord/ConnectionAdapters/TableDefinition.html">ActiveRecord::ConnectionAdapters::TableDefinition</a></span></span><tt> </tt><tt>(which</tt><tt> </tt><tt>provides</tt><tt> </tt><tt>the</tt><tt> </tt><tt>methods</tt><tt> </tt><tt>available</tt><tt> </tt><tt>on</tt><tt> </tt><tt>the</tt><tt> </tt><tt>object</tt><tt> </tt><tt>yielded</tt><tt> </tt><tt>by</tt><tt> </tt><tt>create_table)</tt><tt> </tt><tt>and</tt><tt> </tt><span style="color: #000080;"><span style="text-decoration: underline;"><a href="http://api.rubyonrails.org/classes/ActiveRecord/ConnectionAdapters/Table.html">ActiveRecord::ConnectionAdapters::Table</a></span></span><tt> </tt><tt>(which</tt><tt> </tt><tt>provides</tt><tt> </tt><tt>the</tt><tt> </tt><tt>methods</tt><tt> </tt><tt>available</tt><tt> </tt><tt>on</tt><tt> </tt><tt>the</tt><tt> </tt><tt>object</tt><tt> </tt><tt>yielded</tt><tt> </tt><tt>by</tt><tt> </tt><tt>change_table).</tt>
<h4><a name="writing-your-change-method"></a><tt>3.4</tt><tt> </tt><tt>Writing</tt><tt> </tt><tt>Your</tt><tt> </tt><tt>change</tt><tt> </tt><tt>Method</tt></h4>
The <tt>change</tt> method removes the need to write both <tt>up</tt> and <tt>down</tt> methods in those cases that Rails know how to revert the changes automatically. <tt>change(migration</tt><span style="font-family: DejaVu Sans;"><tt>类方法</tt></span><tt>)</tt><span style="font-family: DejaVu Sans;"><tt>删除需要写进</tt></span><tt>up</tt><span style="font-family: DejaVu Sans;"><tt>和</tt></span><tt>down</tt><span style="font-family: DejaVu Sans;"><tt>的方法，那样</tt></span><tt>Rails</tt><span style="font-family: DejaVu Sans;"><tt>知道怎样自动撤销更改。</tt></span>Currently, the <tt>change</tt> method supports only these migration definitions:<span style="font-family: DejaVu Sans;">目前，</span>change<span style="font-family: DejaVu Sans;">方法支持如下的</span>migration<span style="font-family: DejaVu Sans;">定义：</span>
<ul>
	<li><tt>add_column</tt></li>
	<li><tt>add_index</tt></li>
	<li><tt>add_timestamps</tt></li>
	<li><tt>create_table</tt></li>
	<li><tt>remove_timestamps</tt></li>
	<li><tt>rename_column</tt></li>
	<li><tt>rename_index</tt></li>
	<li><tt>rename_table</tt></li>
</ul>
If you’re going to use other methods, you’ll have to write the <tt>up</tt> and <tt>down</tt> methods normally.<span style="font-family: DejaVu Sans;">如果你打算使用其他方法，你可以常规的写</span>up<span style="font-family: DejaVu Sans;">和</span>down<span style="font-family: DejaVu Sans;">方法。</span>
<h4><a name="writing-your-down-method"></a>3.5 Writing Your <tt>down</tt> Method</h4>
The <tt>down</tt> method of your migration should revert the transformations done by the <tt>up</tt> method.<span style="font-family: DejaVu Sans;">迁移的</span>down<span style="font-family: DejaVu Sans;">方法应该撤销</span>up<span style="font-family: DejaVu Sans;">方法做的转换。</span>In other words the database schema<span style="font-family: DejaVu Sans;">架构</span>should be unchanged if you do an <tt>up</tt> followed by a <tt>down</tt>.<span style="font-family: DejaVu Sans;">换句话说数据库架构应该没有改变，如果你在</span>up<span style="font-family: DejaVu Sans;">方法过后又执行</span>down<span style="font-family: DejaVu Sans;">方法。</span>For example if you create a table in the <tt>up</tt> method you should drop it in the <tt>down</tt> method. It is wise to do things in precisely the reverse order to in the <tt>up</tt> method.<span style="font-family: DejaVu Sans;">例如如果你创建使用</span>up<span style="font-family: DejaVu Sans;">方法一个表你应该在</span>down<span style="font-family: DejaVu Sans;">方法中去除它。</span>For example

<code>class</code> <code>ExampleMigration</code><code> </code><code>&lt;</code><code> </code><code>ActiveRecord::Migration</code>

&nbsp;

<code> </code><code>def</code> <code>up</code>

<code> </code><code>create_table</code><code> </code><code>:products</code> <code>do</code> <code>|t|</code>

<code> </code><code>t.references</code><code> </code><code>:category</code>

<code> </code><code>end</code>

<code> </code><code>#add</code><code> </code><code>a</code><code> </code><code>foreign</code><code> </code><code>key</code>

<code> </code><code>execute</code><code> </code><code>&lt;&lt;-SQL</code>

<code> </code><code>ALTER</code> <code>TABLE</code> <code>products</code>

<code> </code><code>ADD</code> <code>CONSTRAINT</code> <code>fk_products_categories</code>

<code> </code><code>FOREIGN</code> <code>KEY</code> <code>(category_id)</code>

<code> </code><code>REFERENCES</code> <code>categories(id)</code>

<code> </code><code>SQL</code>

&nbsp;

<code> </code><code>add_column</code><code> </code><code>:users,</code><code> </code><code>:home_page_url,</code><code> </code><code>:string</code>

&nbsp;

<code> </code><code>rename_column</code><code> </code><code>:users,</code><code> </code><code>:email,</code><code> </code><code>:email_address</code>

<code> </code><code>end</code>

&nbsp;

<code> </code><code>def</code> <code>down</code>

<code> </code><code>rename_column</code><code> </code><code>:users,</code><code> </code><code>:email_address,</code><code> </code><code>:email</code>

<code> </code><code>remove_column</code><code> </code><code>:users,</code><code> </code><code>:home_page_url</code>

<code> </code><code>execute</code><code> </code><code>"ALTER</code><code> </code><code>TABLE</code><code> </code><code>products</code><code> </code><code>DROP</code><code> </code><code>FOREIGN</code><code> </code><code>KEY</code><code> </code><code>fk_products_categories"</code>

<code> </code><code>drop_table</code><code> </code><code>:products</code>

<code> </code><code>end</code>

<code>end</code>

Sometimes your migration will do something which is just plain irreversible<span style="font-family: DejaVu Sans;">不可逆转的</span>, for example it might destroy some data.<span style="font-family: DejaVu Sans;">有时候你的</span>migration<span style="font-family: DejaVu Sans;">将会做一些不可逆转的事情。例如它可能会删除一些数据。</span>In cases like those when you can’t reverse the migration you can raise <tt>ActiveRecord::IrreversibleMigration</tt> from your <tt>down</tt> method.<span style="font-family: DejaVu Sans;">在这样的情况中你不能撤销</span>migration<span style="font-family: DejaVu Sans;">你可以在你的</span>down<span style="font-family: DejaVu Sans;">方法中</span>raise <tt>ActiveRecord::IrreversibleMigration</tt><span style="font-family: DejaVu Sans;"><tt>。</tt></span>If someone tries to revert your migration an error message will be displayed saying that it can’t be done.<span style="font-family: DejaVu Sans;">如果有人尝试撤销你的</span>migration<span style="font-family: DejaVu Sans;">那么一个错误消息将会被显示<span style="font-family: Liberation Serif,Times New Roman,serif;">“</span></span>it can’t be done”<span style="font-family: DejaVu Sans;">。</span>
<h3><a name="running-migrations"></a>4 Running Migrations</h3>
Rails provides a set of rake tasks to work with migrations which boils down to running certain sets of migrations. Rails<span style="font-family: DejaVu Sans;">提供给</span>migrations<span style="font-family: DejaVu Sans;">一组</span>rake<span style="font-family: DejaVu Sans;">任务，它大致归纳于运行若干的</span>migrations<span style="font-family: DejaVu Sans;">。</span>The very first migration related rake task you use will probably be <tt>db:migrate</tt>.<span style="font-family: DejaVu Sans;">你使用的非常靠前的</span>migration<span style="font-family: DejaVu Sans;">相应于</span>rake<span style="font-family: DejaVu Sans;">的任务恰好是</span><tt>db:migrate</tt><span style="font-family: DejaVu Sans;"><tt>。</tt></span>In its most basic form it just runs the <tt>up</tt> method for all the migrations that have not yet been run.<span style="font-family: DejaVu Sans;">其中它是最基本的形式，它仅仅运行</span>migrations <span style="font-family: DejaVu Sans;">还没被运行的</span>up<span style="font-family: DejaVu Sans;">方法。</span>If there are no such migrations it exits.<span style="font-family: DejaVu Sans;">如果没有这样的迁移它将会退出。</span>

Note that running the <tt> </tt><tt>db:migrate</tt> also invokes the <tt>db:schema:dump</tt> task, which will update your db/schema.rb file to match the structure of your database.<span style="font-family: DejaVu Sans;">注意运行</span><tt>db:migrate</tt><span style="font-family: DejaVu Sans;"><tt>也调用了</tt><tt></tt></span><tt>db:schema:dump</tt><span style="font-family: DejaVu Sans;"><tt>任务，它将会更新你的</tt><tt></tt></span><tt>db/schema.rb</tt><span style="font-family: DejaVu Sans;"><tt>来和你的数据库匹配。</tt></span>

<tt>If</tt><tt> </tt><tt>you</tt><tt> </tt><tt>specify</tt><tt> </tt><tt>a</tt><tt> </tt><tt>target</tt><tt> </tt><tt>version,</tt><tt> </tt><tt>Active</tt><tt> </tt><tt>Record</tt><tt> </tt><tt>will</tt><tt> </tt><tt>run</tt><tt> </tt><tt>the</tt><tt> </tt><tt>required</tt><tt> </tt><tt>migrations</tt><tt> </tt><tt>(up</tt><tt> </tt><tt>or</tt><tt> </tt><tt>down)</tt><tt> </tt><tt>until</tt><tt> </tt><tt>it</tt><tt> </tt><tt>has</tt><tt> </tt><tt>reached</tt><tt> </tt><tt>the</tt><tt> </tt><tt>specified</tt><tt> </tt><tt>version.</tt><span style="font-family: DejaVu Sans;"><tt>如果你特别（指定了）一个目标版本，</tt><tt></tt></span><tt>Active</tt><tt> </tt><tt>Record</tt><span style="font-family: DejaVu Sans;"><tt>将会运行所请求的</tt></span><tt>migrations</tt><span style="font-family: DejaVu Sans;"><tt>（</tt></span><tt>up</tt><span style="font-family: DejaVu Sans;"><tt>或</tt></span><tt>down</tt><span style="font-family: DejaVu Sans;"><tt>）直到它已经达成了（与）指定版本（的匹配）。</tt><tt></tt></span><tt>The</tt><tt> </tt><tt>version</tt><tt> </tt><tt>is</tt><tt> </tt><tt>the</tt><tt> </tt><tt>numerical</tt><tt> </tt><tt>prefix</tt><tt> </tt><tt>on</tt><tt> </tt><tt>the</tt><tt> </tt><tt>migration</tt><tt>’</tt><tt>s</tt><tt> </tt><tt>filename.</tt><span style="font-family: DejaVu Sans;"><tt>版本号是</tt></span><tt>migration</tt><tt>‘</tt><tt>s</tt><span style="font-family: DejaVu Sans;"><tt>文件的数字前缀。</tt><tt></tt></span><tt>For</tt><tt> </tt><tt>example</tt><tt> </tt><tt>to</tt><tt> </tt><tt>migrate</tt><tt> </tt><tt>to</tt><tt> </tt><tt>version</tt><tt> </tt><tt>20080906120000</tt><tt> </tt><tt>run</tt><span style="font-family: DejaVu Sans;"><tt>例如迁移到</tt></span><tt>20080906120000</tt><span style="font-family: DejaVu Sans;"><tt>版本</tt></span>

<code>$</code><code> </code><code>rake</code><code> </code><code>db:migrate</code><code> </code><code>VERSION=20080906120000</code>

<code>If</code><code> </code><code>this</code><code> </code><code>is</code><code> </code><code>greater</code><code> </code><code>than</code><code> </code><code>the</code><code> </code><code>current</code><code> </code><code>version</code><code> </code><code>(i.e.</code><code> </code><code>it</code><code> </code><code>is</code><code> </code><code>migrating</code><code> </code><code>upwards)</code><code> </code><code>this</code><code> </code><code>will</code><code> </code><code>run</code><code> </code><code>the</code><code> </code><tt>up</tt><code> </code><code>method</code><code> </code><code>on</code><code> </code><code>all</code><code> </code><code>migrations</code><code> </code><code>up</code><code> </code><code>to</code><code> </code><code>and</code><code> </code><code>including</code><code> </code><code>20080906120000,</code><code> </code><code>if</code><code> </code><code>migrating</code><code> </code><code>downwards</code><code> </code><code>this</code><code> </code><code>will</code><code> </code><code>run</code><code> </code><code>the</code><code> </code><tt>down</tt><code> </code><code>method</code><code> </code><code>on</code><code> </code><code>all</code><code> </code><code>the</code><code> </code><code>migrations</code><code> </code><code>down</code><code> </code><code>to,</code><code> </code><code>but</code><code> </code><code>not</code><code> </code><code>including,</code><code> </code><code>20080906120000.</code><span style="font-family: DejaVu Sans;"><code>如果执行的版本比当前版本更优（新）</code></span><code>(i.e.</code><code> </code><code>it</code><code> </code><code>is</code><code> </code><code>migrating</code><code> </code><code>upwards)</code><span style="font-family: DejaVu Sans;"><code>这将会执行包含</code></span><code>20080906120000</code><span style="font-family: DejaVu Sans;"><code>的所有版本的</code></span><code>migrations</code><code> </code><code>up</code><span style="font-family: DejaVu Sans;"><code>方法，反之则执行不包括</code></span><code>20080906120000</code><span style="font-family: DejaVu Sans;"><code>的版本之外的所有版本的</code></span><code>migrations</code><code> </code><code>down</code><span style="font-family: DejaVu Sans;"><code>方法。</code></span>
<h4><a name="rolling-back1"></a><code>4.1</code><code> </code><code>Rolling</code><code> </code><code>Back</code></h4>
A common task is to rollback the last migration, for example if you made a mistake in it and wish to correct it.<span style="font-family: DejaVu Sans;">一个常用的任务来回滚最新的</span>migration<span style="font-family: DejaVu Sans;">，例如如果你在其中犯了一个错误希望</span>Rails<span style="font-family: DejaVu Sans;">能够改正它。</span>Rather than tracking down the version number associated with the previous migration you can run

<code>$</code><code> </code><code>rake</code><code> </code><span style="color: #000080;"><span style="text-decoration: underline;"><a href="db:rollback">db:rollback</a></span></span>

<code>This</code><code> </code><code>will</code><code> </code><code>run</code><code> </code><code>the</code><code> </code><tt>down</tt><code> </code><code>method</code><code> </code><code>from</code><code> </code><code>the</code><code> </code><code>latest</code><code> </code><code>migration.</code><span style="font-family: DejaVu Sans;"><code>这将会对最新的</code></span><code>migration</code><span style="font-family: DejaVu Sans;"><code>执行</code></span><code>down</code><span style="font-family: DejaVu Sans;"><code>方法。</code><code></code></span><code>If</code><code> </code><code>you</code><code> </code><code>need</code><code> </code><code>to</code><code> </code><code>undo</code><code> </code><code>several</code><code> </code><code>migrations</code><code> </code><code>you</code><code> </code><code>can</code><code> </code><code>provide</code><code> </code><code>a</code><code> </code><tt>STEP</tt><code> </code><code>parameter:</code><span style="font-family: DejaVu Sans;"><code>如果你需要撤销一系列的</code></span><code>migrations</code><span style="font-family: DejaVu Sans;"><code>你可以提供一个</code></span><code>STEP</code><code> </code><span style="font-family: DejaVu Sans;"><code>参数：</code></span>

<code>$</code><code> </code><code>rake</code><code> </code><code>db:rollback</code><code> </code><code>STEP=3</code>

<code>will</code><code> </code><code>run</code><code> </code><code>the</code><code> </code><tt>down</tt><code> </code><code>method</code><code> </code><code>from</code><code> </code><code>the</code><code> </code><code>last</code><code> </code><code>3</code><code> </code><code>migrations.</code><span style="font-family: DejaVu Sans;"><code>将会对最近的</code></span><code>3</code><span style="font-family: DejaVu Sans;"><code>次迁移执行</code></span><code>down</code><span style="font-family: DejaVu Sans;"><code>方法。</code></span>

<a name="rolling-back"></a>The rake <tt>db:migrate:redo</tt> task is a shortcut for doing a rollback and then migrating back up again. rake <tt>db:migrate:redo</tt><span style="font-family: DejaVu Sans;"><tt>任务是一个回滚后再次返回的快捷操作。</tt></span>As with the <tt>db:rollback</tt> task you can use the <tt>STEP</tt> parameter if you need to go more than one version back, for example<span style="font-family: DejaVu Sans;">通过</span>db<span style="font-family: DejaVu Sans;">：</span>rollback <span style="font-family: DejaVu Sans;">任务你可以使用</span>STEP<span style="font-family: DejaVu Sans;">参数如果你需要撤销超过一个版本，例如</span>

<code>$</code><code> </code><code>rake</code><code> </code><code>db:migrate:redo</code><code> </code><code>STEP=3</code>

<code>Neither</code><code> </code><code>of</code><code> </code><code>these</code><code> </code><code>Rake</code><code> </code><code>tasks</code><code> </code><code>do</code><code> </code><code>anything</code><code> </code><code>you</code><code> </code><code>could</code><code> </code><code>not</code><code> </code><code>do</code><code> </code><code>with</code><code> </code><tt>db:migrate</tt><code>,</code><code> </code><code>they</code><code> </code><code>are</code><code> </code><code>simply</code><code> </code><code>more</code><code> </code><code>convenient</code><span style="font-family: DejaVu Sans;"><code>方便</code><code></code></span><code>since</code><code> </code><code>you</code><code> </code><code>do</code><code> </code><code>not</code><code> </code><code>need</code><code> </code><code>to</code><code> </code><code>explicitly</code><code> </code><code>specify</code><code> </code><code>the</code><code> </code><code>version</code><code> </code><code>to</code><code> </code><code>migrate</code><code> </code><code>to.</code><span style="font-family: DejaVu Sans;"><code>（通过）上两次</code></span><code>rake</code><span style="font-family: DejaVu Sans;"><code>任务，你没有对</code></span><code>db:migrate</code><span style="font-family: DejaVu Sans;"><code>任何事情，如果你不需要指定明确的版本来迁移这样做都非常方便。</code></span>

Lastly, the <tt>db:reset</tt> task will drop the database, recreate it and load the current schema into it.<span style="font-family: DejaVu Sans;">最后，</span>

<tt>db:reset</tt><span style="font-family: DejaVu Sans;"><tt>任务将会</tt></span><tt>drop</tt><span style="font-family: DejaVu Sans;"><tt>数据库，重建它并且在其中导入正确的架构。</tt></span>

<code> This</code><code> </code><code>is</code><code> </code><code>not</code><code> </code><code>the</code><code> </code><code>same</code><code> </code><code>as</code><code> </code><code>running</code><code> </code><code>all</code><code> </code><code>the</code><code> </code><code>migrations</code><code> – </code><code>see</code><code> </code><code>the</code><code> </code><code>section</code><code> </code><code>on</code><code> </code><span style="color: #000080;"><span style="text-decoration: underline;"><a href="http://guides.rubyonrails.org/migrations.html#schema-dumping-and-you">schema.rb</a></span></span><code>.</code><span style="font-family: DejaVu Sans;"><code>这和运行所有的</code></span><code>migrations</code><span style="font-family: DejaVu Sans;"><code>不一样</code><code><span style="font-family: Liberation Serif,Times New Roman,serif;">——</span></code><code>阅读</code><code></code></span><span style="color: #000080;"><span style="text-decoration: underline;"><a href="http://guides.rubyonrails.org/migrations.html#schema-dumping-and-you">schema.rb</a></span></span><span style="font-family: DejaVu Sans;"><code>章节。</code></span>
<h4><a name="being-specific"></a><code>4.2</code><code> </code><code>Being</code><code> </code><code>Specific</code><span style="font-family: WenQuanYi Micro Hei;"><code>开始指定的</code></span></h4>
If you need to run a specific migration up or down the <tt>db:migrate:up</tt> and <tt>db:migrate:down</tt> tasks will do that. <span style="font-family: DejaVu Sans;">如果你需要对一个指定的版本</span>migration<span style="font-family: DejaVu Sans;">执行</span>up<span style="font-family: DejaVu Sans;">或</span>down<span style="font-family: DejaVu Sans;">，那么</span><tt>db:migrate:up</tt> and <tt>db:migrate:down</tt><span style="font-family: DejaVu Sans;"><tt>任务会满足你。</tt></span>Just specify the appropriate version and the corresponding migration will have its <tt>up</tt> or <tt>down</tt> method invoked, for example<span style="font-family: DejaVu Sans;">指定适当的版本那么相应的</span>migration<span style="font-family: DejaVu Sans;">就会调用它的</span>up<span style="font-family: DejaVu Sans;">或</span>down<span style="font-family: DejaVu Sans;">方法，例如</span>

<code>$</code><code> </code><code>rake</code><code> </code><code>db:migrate:up</code><code> </code><code>VERSION=20080906120000</code>

<code>will</code><code> </code><code>run</code><code> </code><code>the</code><code> </code><tt>up</tt><code> </code><code>method</code><code> </code><code>from</code><code> </code><code>the</code><code> </code><code>20080906120000</code><code> </code><code>migration.</code><span style="font-family: DejaVu Sans;"><code>将会执行来自</code><code></code></span><code>20080906120000</code><span style="font-family: DejaVu Sans;"><code>版本的</code></span><code>migration</code><span style="font-family: DejaVu Sans;"><code>的</code></span><code>up</code><span style="font-family: DejaVu Sans;"><code>方法。</code><code></code></span><code>These</code><code> </code><code>tasks</code><code> </code><code>check</code><code> </code><code>whether</code><code> </code><code>the</code><code> </code><code>migration</code><code> </code><code>has</code><code> </code><code>already</code><code> </code><code>run,</code><code> </code><code>so</code><code> </code><code>for</code><code> </code><code>example</code><code> </code><tt>db:migrate:up</tt><tt> </tt><tt>VERSION=20080906120000</tt><code> </code><code>will</code><code> </code><code>do</code><code> </code><code>nothing</code><code> </code><code>if</code><code> </code><code>Active</code><code> </code><code>Record</code><code> </code><code>believes</code><code> </code><code>that</code><code> </code><code>20080906120000</code><code> </code><code>has</code><code> </code><code>already</code><code> </code><code>been</code><code> </code><code>run.</code><span style="font-family: DejaVu Sans;"><code>这个任务会检查</code></span><code>migration</code><span style="font-family: DejaVu Sans;"><code>是否已经运行，如果</code><code></code></span><code>Active</code><code> </code><code>Record</code><span style="font-family: DejaVu Sans;"><code>认为已经被运行过了</code><code></code></span><tt>db:migrate:up</tt><tt> </tt><tt>VERSION=20080906120000</tt><span style="font-family: DejaVu Sans;"><tt>将不会做任何事情。</tt></span>
<h4><a name="being-talkative"></a>4.3 Being Talkative<span style="font-family: WenQuanYi Micro Hei;">开始唠叨</span></h4>
By default migrations tell you exactly what they’re doing and how long it took.<span style="font-family: DejaVu Sans;">通过默认的</span>migrations<span style="font-family: DejaVu Sans;">会明确地告诉你他们做了什么以及花费了多长时间。</span>A migration creating a table and adding an index might produce output like this<span style="font-family: DejaVu Sans;">一次迁移创建一个表并且添加一个</span>index<span style="font-family: DejaVu Sans;">可能会产生这样的输出</span>

<code>20080906170109</code><code> </code><code>CreateProducts:</code><code> </code><code>migrating</code>

<code>--</code><code> </code><code>create_table(:products)</code>

<code> </code><code>-&gt;</code><code> </code><code>0.0021s</code>

<code>--</code><code> </code><code>add_index(:products,</code><code> </code><code>:name)</code>

<code> </code><code>-&gt;</code><code> </code><code>0.0026s</code>

<code>20080906170109</code><code> </code><code>CreateProducts:</code><code> </code><code>migrated</code><code> </code><code>(0.0059s)</code>

Several methods are provided that allow you to control all this:<span style="font-family: DejaVu Sans;">一些方法（被证明）允许你像下面这样控制</span>
<ul>
	<li><tt>suppress_messages</tt> takes a block as an argument and suppresses<span style="font-family: DejaVu Sans;">抑制</span>any output generated by the block. <tt>suppress_messages</tt><span style="font-family: DejaVu Sans;">获取一个</span>block<span style="font-family: DejaVu Sans;">作为一个参数并且抑制常规输出到</span>block</li>
	<li><tt>say</tt> takes a message argument and outputs it as is. A second boolean argument can be passed to specify whether to indent<span style="font-family: DejaVu Sans;">缩进</span>or not. <tt>say</tt><span style="font-family: DejaVu Sans;"><tt>获取一个</tt></span><tt>message</tt><span style="font-family: DejaVu Sans;"><tt>参数并且输出它。第二个布尔参数可以指定是否缩进</tt></span></li>
	<li><tt>say_with_time</tt> outputs text along with how long it took to run its block. If the block returns an integer it assumes it is the number of rows affected. say_with_time<span style="font-family: DejaVu Sans;"><tt>在文字旁边输出运行这个代码块花费了多少时间。如果</tt></span><tt>block</tt><span style="font-family: DejaVu Sans;"><tt>返回一个整数它假设这是受影响的代码行。</tt></span></li>
</ul>
For example, this migration<span style="font-family: DejaVu Sans;">例如，这个</span>migration

<code>class</code> <code>CreateProducts</code><code> </code><code>&lt;</code><code> </code><code>ActiveRecord::Migration</code>

<code> </code><code>def</code> <code>change</code>

<code> </code><code>suppress_messages</code><code> </code><code>do</code>

<code> </code><code>create_table</code><code> </code><code>:products</code> <code>do</code> <code>|t|</code>

<code> </code><code>t.string</code><code> </code><code>:name</code>

<code> </code><code>t.text</code><code> </code><code>:description</code>

<code> </code><code>t.timestamps</code>

<code> </code><code>end</code>

<code> </code><code>end</code>

<code> </code><code>say</code><code> </code><code>"Created</code><code> </code><code>a</code><code> </code><code>table"</code>

<code> </code><code>suppress_messages</code><code> </code><code>{add_index</code><code> </code><code>:products,</code><code> </code><code>:name}</code>

<code> </code><code>say</code><code> </code><code>"and</code><code> </code><code>an</code><code> </code><code>index!",</code><code> </code><code>true</code>

<code> </code><code>say_with_time</code><code> </code><code>'Waiting</code><code> </code><code>for</code><code> </code><code>a</code><code> </code><code>while'</code> <code>do</code>

<code> </code><code>sleep</code><code> </code><code>10</code>

<code> </code><code>250</code>

<code> </code><code>end</code>

<code> </code><code>end</code>

<code>end</code>

generates the following output<span style="font-family: DejaVu Sans;">一般情况会得到如下输出</span>

== CreateProducts: migrating =================================================

-- Created a table

-&gt; and an index!

-- Waiting for a while

-&gt; 10.0108s

-&gt; 250 rows

== CreateProducts: migrated (10.0171s) =======================================

If you just want Active Record to shut up then running <tt>rake</tt><tt> </tt><tt>db:migrate</tt><tt> </tt><tt>VERBOSE=false</tt> will suppress<span style="font-family: DejaVu Sans;">抑制</span>all output.<span style="font-family: DejaVu Sans;">如果你希望让所有</span>Active Record<span style="font-family: DejaVu Sans;">闭嘴，那么运行</span><tt>rake</tt><tt> </tt><tt>db:migrate</tt><tt> </tt><tt>VERBOSE=false</tt><span style="font-family: DejaVu Sans;"><tt>会抑制所有的输出。</tt></span>
<h3><a name="using-models-in-your-migrations"></a>5 Using Models in Your Migrations<span style="font-family: WenQuanYi Micro Hei;">在你的</span>migration<span style="font-family: WenQuanYi Micro Hei;">中使用</span>Moldels</h3>
When creating or updating data in a migration it is often tempting to use one of your models<span style="font-family: DejaVu Sans;">新建或更新一个</span>migration<span style="font-family: DejaVu Sans;">的数据它通常会使你的</span>models<span style="font-family: DejaVu Sans;">更有诱惑力。</span>After all they exist to provide easy access to the underlying<span style="font-family: DejaVu Sans;">底层</span>data.<span style="font-family: DejaVu Sans;">毕竟他们的存在提供了对底层数据的访问。</span>This can be done, but some caution<span style="font-family: DejaVu Sans;">注意</span>should be observed<span style="font-family: DejaVu Sans;">观察</span>.<span style="font-family: DejaVu Sans;">这是可行的，但是有些地方需要注意。</span>

For example, problems occur when the model uses database columns which are (1) not currently in the database and (2) will be created by this or a subsequent migration.<span style="font-family: DejaVu Sans;">例如，问题焦点当</span>models<span style="font-family: DejaVu Sans;">使用数据库字段，但是</span>migration<span style="font-family: DejaVu Sans;">（</span>1<span style="font-family: DejaVu Sans;">）在数据库中没有这个字段而</span>migration<span style="font-family: DejaVu Sans;">（</span>2<span style="font-family: DejaVu Sans;">）将会被它本身的</span>migration<span style="font-family: DejaVu Sans;">文件或者随后的</span>migration<span style="font-family: DejaVu Sans;">创建。</span>

Consider this example, where Alice and Bob are working on the same code base which contains a <tt>Product</tt> model:<span style="font-family: DejaVu Sans;">思考这个例子，</span>Alice<span style="font-family: DejaVu Sans;">和</span>Bob<span style="font-family: DejaVu Sans;">工作在同样的代码中，其主要包含一个</span>Product<span style="font-family: DejaVu Sans;">模型：</span>

Bob goes on vacation. Bob<span style="font-family: DejaVu Sans;">在休假</span>

Alice creates a migration for the <tt>products</tt> table which adds a new column and initializes it. She also adds a validation to the Product model for the new column. Alice<span style="font-family: DejaVu Sans;">创建一个</span>products<span style="font-family: DejaVu Sans;">表单的</span>migration<span style="font-family: DejaVu Sans;">，其添加一个新的字段并初始化它。她也添加一个关于新字段的验证到</span>Product<span style="font-family: DejaVu Sans;">模型。</span>

rails generate migration AddFlagToProduct flag:int#<span style="font-family: DejaVu Sans;">然后再添加一部分这样通过创建器的话</span>model<span style="font-family: DejaVu Sans;">文件也一起创建了</span>

<code>#</code><code> </code><code>db/migrate/20100513121110_add_flag_to_product.rb</code>

&nbsp;

<code>class</code> <code>AddFlagToProduct</code><code> </code><code>&lt;</code><code> </code><code>ActiveRecord::Migration</code>

<code> </code><code>def</code> <code>change</code>

<code> </code><code>add_column</code><code> </code><code>:products,</code><code> </code><code>:flag,</code><code> </code><code>:int</code>

<code> </code><code>Product.all.each</code> <code>{</code><code> </code><code>|f|</code><code> </code><code>f.update_attributes!(:flag</code> <code>=&gt;</code><code> </code><code>'false')</code><code> </code><code>}#</code><span style="font-family: DejaVu Sans;"><code>初始化置为</code></span><code>false</code>

<code> </code><code>end</code>

<code>end</code>

&nbsp;

<code>#</code><code> </code><code>app/model/product.rb</code>

&nbsp;

<code>class</code> <code>Product</code><code> </code><code>&lt;</code><code> </code><code>ActiveRecord::Base</code>

<code> </code><code>validates</code><code> </code><code>:flag,</code><code> </code><code>:presence</code> <code>=&gt;</code><code> </code><code>true</code>

<code>end</code>

<code>Alice</code><code> </code><code>adds</code><code> </code><code>a</code><code> </code><code>second</code><code> </code><code>migration</code><code> </code><code>which</code><code> </code><code>adds</code><code> </code><code>and</code><code> </code><code>initializes</code><code> </code><code>another</code><code> </code><code>column</code><code> </code><code>to</code><code> </code><code>the</code><code> </code><tt>products</tt><code> </code><code>table</code><code> </code><code>and</code><code> </code><code>also</code><code> </code><code>adds</code><code> </code><code>a</code><code> </code><code>validation</code><code> </code><code>to</code><code> </code><code>the</code><code> </code><code>Product</code><code> </code><code>model</code><code> </code><code>for</code><code> </code><code>the</code><code> </code><code>new</code><code> </code><code>column.Alice</code><span style="font-family: DejaVu Sans;"><code>添加第二个</code></span><code>migration</code><span style="font-family: DejaVu Sans;"><code>，在这个</code></span><code>migration</code><span style="font-family: DejaVu Sans;"><code>中给</code></span><code>Products</code><span style="font-family: DejaVu Sans;"><code>表单添加并初始化了另一个字段，而且为</code></span><code>Product</code><code> </code><code>model</code><span style="font-family: DejaVu Sans;"><code>的新字段添加并初始化了验证。</code></span>

<code>#</code><code> </code><code>db/migrate/20100515121110_add_fuzz_to_product.rb</code>

&nbsp;

<code>class</code> <code>AddFuzzToProduct</code><code> </code><code>&lt;</code><code> </code><code>ActiveRecord::Migration</code>

<code> </code><code>def</code> <code>change</code>

<code> </code><code>add_column</code><code> </code><code>:products,</code><code> </code><code>:fuzz,</code><code> </code><code>:string</code>

<code> </code><code>Product.all.each</code> <code>{</code><code> </code><code>|f|</code><code> </code><code>f.update_attributes!</code><code> </code><code>:fuzz</code> <code>=&gt;</code><code> </code><code>'fuzzy'</code> <code>}</code>

<code> </code><code>end</code>

<code>end</code>

<code>#</code><code> </code><code>app/model/product.rb</code>

&nbsp;

<code>class</code> <code>Product</code><code> </code><code>&lt;</code><code> </code><code>ActiveRecord::Base</code>

<code> </code><code>validates</code><code> </code><code>:flag,</code><code> </code><code>:fuzz,</code><code> </code><code>:presence</code> <code>=&gt;</code><code> </code><code>true</code>

<code>end</code>

<code>Both</code><code> </code><code>migrations</code><code> </code><code>work</code><code> </code><code>for</code><code> </code><code>Alice.</code><span style="font-family: DejaVu Sans;"><code>两个</code></span><code>migrations</code><span style="font-family: DejaVu Sans;"><code>都是</code></span><code>Alice</code><span style="font-family: DejaVu Sans;"><code>编写的。</code></span>

<code>Bob</code><code> </code><code>comes</code><code> </code><code>back</code><code> </code><code>from</code><code> </code><code>vacation</code><span style="font-family: DejaVu Sans;"><code>假期</code><code></code></span><code>and:Bob</code><span style="font-family: DejaVu Sans;"><code>休假回来然后接着下面的工作</code></span>
<ol>
	<li><code>updates</code><code> </code><code>the</code><code> </code><code>source</code><code> – </code><code>which</code><code> </code><code>contains</code><code> </code><code>both</code><code> </code><code>migrations</code><code> </code><code>and</code><code> </code><code>the</code><code> </code><code>latests</code><code> </code><code>version</code><code> </code><code>of</code><code> </code><code>the</code><code> </code><code>Product</code><code> </code><code>model.</code><code> </code><span style="font-family: DejaVu Sans;"><code>更新源代码</code><code><span style="font-family: Liberation Serif,Times New Roman,serif;">——</span></code><code>包含</code></span><code>migrations</code><span style="font-family: DejaVu Sans;"><code>和最新版本的</code></span><code>Product</code><span style="font-family: DejaVu Sans;"><code>模型。</code></span></li>
	<li>runs outstanding migrations with <tt>rake</tt><tt> </tt><tt>db:migrate</tt>, which includes the one that updates the <tt>Product</tt> model. <span style="font-family: DejaVu Sans;">通过</span><tt>rake</tt><tt> </tt><tt>db:migrate</tt><span style="font-family: DejaVu Sans;">执行突出（最新版本的</span>migration<span style="font-family: DejaVu Sans;">）的</span>migrations<span style="font-family: DejaVu Sans;">，其中包含了更新</span>Product<span style="font-family: DejaVu Sans;">模型。</span></li>
</ol>
The migration crashes because when the model attempts<span style="font-family: DejaVu Sans;">尝试</span>to save, it tries to validate the second added column, which is not in the database when the <em>first</em> migration runs.<span style="font-family: DejaVu Sans;">数据迁移冲突因为当</span>model<span style="font-family: DejaVu Sans;">尝试保存时，它试图验证第二个添加的字段，然而它在第一次</span>migration<span style="font-family: DejaVu Sans;">运行时不在数据库中。（没有弄明白呢感觉好像两个迁移是分开的才会出现这样的错误）</span>

<code>rake</code><code> </code><code>aborted!</code>

<code>An</code><code> </code><code>error</code><code> </code><code>has</code><code> </code><code>occurred,</code><code> </code><code>this</code><code> </code><code>and</code><code> </code><code>all</code><code> </code><code>later</code><code> </code><code>migrations</code><code> </code><code>canceled:</code>

&nbsp;

<code>undefined</code><code> </code><code>method</code><code> </code><code>`fuzz'</code><code> </code><code>for</code><code> </code><code>#&lt;Product:0x000001049b14a0&gt;</code>

A fix for this is to create a local model within the migration.<span style="font-family: DejaVu Sans;">解决这个错误是在</span>migration<span style="font-family: DejaVu Sans;">创建一个本地的</span>model<span style="font-family: DejaVu Sans;">。</span>This keeps rails from running the validations, so that the migrations run to completion.<span style="font-family: DejaVu Sans;">这样在</span>rails<span style="font-family: DejaVu Sans;">运行中保持了验证，使得</span>migrations<span style="font-family: DejaVu Sans;">完成了验证。</span>

When using a faux model, it’s a good idea to call <tt>Product.reset_column_information</tt> to refresh the ActiveRecord cache for the Product model prior<span style="font-family: DejaVu Sans;">前</span>to updating data in the database.<span style="font-family: DejaVu Sans;">当使用一个人造的</span>model<span style="font-family: DejaVu Sans;">，调用</span><tt>Product.reset_column_information</tt><span style="font-family: DejaVu Sans;"><tt>来刷新在更新数据到数据库前的</tt></span><tt>Product</tt><tt> </tt><tt>model</tt><span style="font-family: DejaVu Sans;"><tt>的</tt></span><tt>ActiveRecord</tt><span style="font-family: DejaVu Sans;"><tt>缓存是一个好主意。</tt></span>

<tt>If</tt><tt> </tt><tt>Alice</tt><tt> </tt><tt>had</tt><tt> </tt><tt>done</tt><tt> </tt><tt>this</tt><tt> </tt><tt>instead,</tt><tt> </tt><tt>there</tt><tt> </tt><tt>would</tt><tt> </tt><tt>have</tt><tt> </tt><tt>been</tt><tt> </tt><tt>no</tt><tt> </tt><tt>problem:</tt><span style="font-family: DejaVu Sans;"><tt>如果</tt></span><tt>Alice</tt><span style="font-family: DejaVu Sans;"><tt>这样做了就不会有问题了</tt></span>

<code>#</code><code> </code><code>db/migrate/20100513121110_add_flag_to_product.rb</code>

&nbsp;

<code>class</code> <code>AddFlagToProduct</code><code> </code><code>&lt;</code><code> </code><code>ActiveRecord::Migration</code>

<code> </code><code>class</code> <code>Product</code><code> </code><code>&lt;</code><code> </code><code>ActiveRecord::Base</code>

<code> </code><code>end</code>

&nbsp;

<code> </code><code>def</code> <code>change</code>

<code> </code><code>add_column</code><code> </code><code>:products,</code><code> </code><code>:flag,</code><code> </code><code>:int</code>

<code> </code><code>Product.reset_column_information</code>

<code> </code><code>Product.all.each</code> <code>{</code><code> </code><code>|f|</code><code> </code><code>f.update_attributes!(:flag</code> <code>=&gt;</code><code> </code><code>false)</code><code> </code><code>}</code>

<code> </code><code>end</code>

<code>end</code>

&nbsp;

<code>class</code><tt> </tt><code>AddFuzzToProduct</code><code> </code><code>&lt;</code><code> </code><code>ActiveRecord::Migration</code>

<code> </code><code>class</code> <code>Product</code><code> </code><code>&lt;</code><code> </code><code>ActiveRecord::Base</code>

<code> </code><code>end</code>

<code> </code><code>def</code> <code>change</code>

<code> </code><code>add_column</code><code> </code><code>:products,</code><code> </code><code>:fuzz,</code><code> </code><code>:string</code>

<code> </code><code>Product.reset_column_information</code>

<code> </code><code>Product.all.each</code> <code>{</code><code> </code><code>|f|</code><code> </code><code>f.update_attributes!</code><code> </code><code>:fuzz</code> <code>=&gt;</code><code> </code><code>'fuzzy'</code> <code>}</code>

<code> </code><code>end</code>

<code>end</code>

&nbsp;
<h3><a name="schema-dumping-and-you"></a><tt>6</tt><tt> </tt><tt>Schema</tt><tt> </tt><tt>Dumping</tt><tt> </tt><tt>and</tt><tt> </tt><tt>You</tt><span style="font-family: WenQuanYi Micro Hei;"><tt>架构模式和你</tt></span></h3>
<h4><a name="what-are-schema-files-for"></a><tt>6.1</tt><tt> </tt><tt>What</tt><tt> </tt><tt>are</tt><tt> </tt><tt>Schema</tt><tt> </tt><tt>Files</tt><tt> </tt><tt>for?</tt></h4>
<tt>Migrations,</tt><tt> </tt><tt>mighty</tt><tt> </tt><tt>as</tt><tt> </tt><tt>they</tt><tt> </tt><tt>may</tt><tt> </tt><tt>be,</tt><tt> </tt><tt>are</tt><tt> </tt><tt>not</tt><tt> </tt><tt>the</tt><tt> </tt><tt>authoritative</tt><tt> </tt><tt>source</tt><tt> </tt><tt>for</tt><tt> </tt><tt>your</tt><tt> </tt><tt>database</tt><tt> </tt><tt>schema.</tt><tt> </tt><tt>Migrations</tt><span style="font-family: DejaVu Sans;"><tt>，很可能不是你的数据库</tt></span><tt>schema</tt><span style="font-family: DejaVu Sans;"><tt>的授权源。</tt><tt></tt></span><tt>That</tt><tt> </tt><tt>role</tt><tt> </tt><tt>falls</tt><tt> </tt><tt>to</tt><tt> </tt><tt>either</tt><tt> </tt><tt>db/schema.rb</tt><tt> </tt><tt>or</tt><tt> </tt><tt>an</tt><tt> </tt><tt>SQL</tt><tt> </tt><tt>file</tt><tt> </tt><tt>which</tt><tt> </tt><tt>Active</tt><tt> </tt><tt>Record</tt><tt> </tt><tt>generates</tt><tt> </tt><tt>by</tt><tt> </tt><tt>examining</tt><tt> </tt><tt>the</tt><tt> </tt><tt>database.</tt><span style="font-family: DejaVu Sans;"><tt>这一规则影响到</tt><tt></tt></span><tt>db/schema.rb</tt><span style="font-family: DejaVu Sans;"><tt>和</tt></span><tt>SQL</tt><span style="font-family: DejaVu Sans;"><tt>文件它是</tt><tt></tt></span><tt>Active</tt><tt> </tt><tt>Record</tt><span style="font-family: DejaVu Sans;"><tt>创建器通过检查数据库生成的。</tt><tt></tt></span><tt>They</tt><tt> </tt><tt>are</tt><tt> </tt><tt>not</tt><tt> </tt><tt>designed</tt><tt> </tt><tt>to</tt><tt> </tt><tt>be</tt><tt> </tt><tt>edited,</tt><tt> </tt><tt>they</tt><tt> </tt><tt>just</tt><tt> </tt><tt>represent</tt><tt> </tt><tt>the</tt><tt> </tt><tt>current</tt><tt> </tt><tt>state</tt><tt> </tt><tt>of</tt><tt> </tt><tt>the</tt><tt> </tt><tt>database.</tt><span style="font-family: DejaVu Sans;"><tt>他们的设计（原意）是不被编辑的，他们仅仅是当前数据库状态的一个表现。</tt></span>

There is no need (and it is error prone) to deploy<span style="font-family: DejaVu Sans;">部署</span>a new instance of an app by replaying the entire<span style="font-family: DejaVu Sans;">整个</span>migration history. It is much simpler and faster to just load into the database a description of the current schema.<span style="font-family: DejaVu Sans;">这里没有必要（并且是错误倾向）去通过</span>replaying<span style="font-family: DejaVu Sans;">整个</span>migration<span style="font-family: DejaVu Sans;">历史来部署一个</span>app<span style="font-family: DejaVu Sans;">的新的实例。更明智和更快捷的方式是</span>load<span style="font-family: DejaVu Sans;">数据库的描述（也就是）当前</span>schema<span style="font-family: DejaVu Sans;">。</span>

For example, this is how the test database is created: the current development database is dumped (either to <tt>db/schema.rb</tt> or <tt>db/development.sql</tt>) and then loaded into the test database.<span style="font-family: DejaVu Sans;">例如，这是测试数据库怎样被创建的：当前的开发数据库已经被转储（要么</span><tt>db/schema.rb</tt> <span style="font-family: DejaVu Sans;">要么</span><tt>db/development.sql</tt><span style="font-family: DejaVu Sans;">）然后被导入</span>test<span style="font-family: DejaVu Sans;">数据库。</span>

Schema files are also useful if you want a quick look at what attributes an Active Record object has. Schema<span style="font-family: DejaVu Sans;">文件在你希望快速的查看</span>Active Record object<span style="font-family: DejaVu Sans;">有些什么属性的时候也很有帮助。</span>This information is not in the model’s code and is frequently spread across several migrations but is all summed up in the schema file. <span style="font-family: DejaVu Sans;">这些信息不是</span>model<span style="font-family: DejaVu Sans;">中的代码并且频繁分布在多个</span>migrations<span style="font-family: DejaVu Sans;">但是是所有架构文件的总结。</span>The <span style="color: #000080;"><span style="text-decoration: underline;"><a href="http://agilewebdevelopment.com/plugins/annotate_models">annotate_models</a></span></span> plugin, which automatically adds (and updates) comments at the top of each model summarizing the schema, may also be of interest. <span style="color: #000080;"><span style="text-decoration: underline;"><a href="http://agilewebdevelopment.com/plugins/annotate_models">annotate_models</a></span></span> <span style="font-family: DejaVu Sans;">插件，它能够自动在每个</span>model<span style="font-family: DejaVu Sans;">汇总的顶部的添加（更新）</span>comments<span style="font-family: DejaVu Sans;">，可能你会有兴趣。</span>
<h4><a name="types-of-schema-dumps"></a><tt>6.2</tt><tt> </tt><tt>Types</tt><tt> </tt><tt>of</tt><tt> </tt><tt>Schema</tt><tt> </tt><tt>Dumps</tt><span style="font-family: WenQuanYi Micro Hei;"><tt>架构转储的形式</tt></span></h4>
There are two ways to dump the schema. This is set in <tt>config/application.rb</tt> by the <tt>config.active_record.schema_format</tt> setting, which may be either <tt>:sql</tt> or <tt>:ruby</tt>.<span style="font-family: DejaVu Sans;">有两种方式来转储架构。这是（相关）设置在</span><tt>config/application.rb</tt><span style="font-family: DejaVu Sans;"><tt>通过</tt><tt></tt></span><tt>config.active_record.schema_format</tt><span style="font-family: DejaVu Sans;"><tt>来设置，其形式要么是</tt></span><tt>:sql</tt><span style="font-family: DejaVu Sans;"><tt>要么是</tt></span><tt>:ruby.</tt>

<tt>If</tt><tt> </tt><tt>:ruby</tt><tt> </tt><tt>is</tt><tt> </tt><tt>selected</tt><tt> </tt><tt>then</tt><tt> </tt><tt>the</tt><tt> </tt><tt>schema</tt><tt> </tt><tt>is</tt><tt> </tt><tt>stored</tt><tt> </tt><tt>in</tt><tt> </tt><tt>db/schema.rb.</tt><tt> </tt><tt>If</tt><tt> </tt><tt>you</tt><tt> </tt><tt>look</tt><tt> </tt><tt>at</tt><tt> </tt><tt>this</tt><tt> </tt><tt>file</tt><tt> </tt><tt>you</tt><tt>’</tt><tt>ll</tt><tt> </tt><tt>find</tt><tt> </tt><tt>that</tt><tt> </tt><tt>it</tt><tt> </tt><tt>looks</tt><tt> </tt><tt>an</tt><tt> </tt><tt>awful</tt><span style="font-family: DejaVu Sans;"><tt>可怕</tt><tt></tt></span><tt>lot</tt><tt> </tt><tt>like</tt><tt> </tt><tt>one</tt><tt> </tt><tt>very</tt><tt> </tt><tt>big</tt><tt> </tt><tt>migration:</tt><span style="font-family: DejaVu Sans;"><tt>如果</tt></span><tt>:ruby</tt><span style="font-family: DejaVu Sans;"><tt>被选中那么</tt></span><tt>schema</tt><span style="font-family: DejaVu Sans;"><tt>被存储在</tt><tt></tt></span><tt>db/schema.rb</tt><span style="font-family: DejaVu Sans;"><tt>。如果你查看这个文件你将会发现它看起来就像一个很大的</tt></span><tt>migration</tt><span style="font-family: DejaVu Sans;"><tt>：</tt></span>

<code>ActiveRecord::Schema.define(:version</code><tt> </tt><code>=&gt;</code><code> </code><code>20080906171750)</code><code> </code><code>do</code>

<code> </code><code>create_table</code><code> </code><code>"authors",</code><code> </code><code>:force</code> <code>=&gt;</code><code> </code><code>true</code> <code>do</code> <code>|t|</code>

<code> </code><code>t.string</code><code> </code><code>"name"</code>

<code> </code><code>t.datetime</code><code> </code><code>"created_at"</code>

<code> </code><code>t.datetime</code><code> </code><code>"updated_at"</code>

<code> </code><code>end</code>

&nbsp;

<code> </code><code>create_table</code><code> </code><code>"products",</code><code> </code><code>:force</code> <code>=&gt;</code><code> </code><code>true</code> <code>do</code> <code>|t|</code>

<code> </code><code>t.string</code><code> </code><code>"name"</code>

<code> </code><code>t.text</code><code> </code><code>"description"</code>

<code> </code><code>t.datetime</code><code> </code><code>"created_at"</code>

<code> </code><code>t.datetime</code><code> </code><code>"updated_at"</code>

<code> </code><code>t.string</code><code> </code><code>"part_number"</code>

<code> </code><code>end</code>

<code>end</code>

<tt>In</tt><tt> </tt><tt>many</tt><tt> </tt><tt>ways</tt><tt> </tt><tt>this</tt><tt> </tt><tt>is</tt><tt> </tt><tt>exactly</tt><tt> </tt><tt>what</tt><tt> </tt><tt>it</tt><tt> </tt><tt>is.</tt><span style="font-family: DejaVu Sans;"><tt>在很多情况下它能够准确的（反应出</tt></span><tt>schema</tt><span style="font-family: DejaVu Sans;"><tt>）的信息。</tt><tt></tt></span><tt>This</tt><tt> </tt><tt>file</tt><tt> </tt><tt>is</tt><tt> </tt><tt>created</tt><tt> </tt><tt>by</tt><tt> </tt><tt>inspecting</tt><tt> </tt><tt>the</tt><tt> </tt><tt>database</tt><tt> </tt><tt>and</tt><tt> </tt><tt>expressing</tt><tt> </tt><tt>its</tt><tt> </tt><tt>structure</tt><tt> </tt><tt>using</tt><tt> </tt><tt>create_table,</tt><tt> </tt><tt>add_index,</tt><tt> </tt><tt>and</tt><tt> </tt><tt>so</tt><tt> </tt><tt>on.</tt><span style="font-family: DejaVu Sans;"><tt>这个文件被创建来检查数据库以及表达它的结构使用</tt><tt></tt></span><tt>create_table,</tt><tt> </tt><tt>add_index</tt><span style="font-family: DejaVu Sans;"><tt>等等。</tt><tt></tt></span><tt>Because</tt><tt> </tt><tt>this</tt><tt> </tt><tt>is</tt><tt> </tt><tt>database</tt><tt> </tt><tt>independent</tt><tt> </tt><tt>it</tt><tt> </tt><tt>could</tt><tt> </tt><tt>be</tt><tt> </tt><tt>loaded</tt><tt> </tt><tt>into</tt><tt> </tt><tt>any</tt><tt> </tt><tt>database</tt><tt> </tt><tt>that</tt><tt> </tt><tt>Active</tt><tt> </tt><tt>Record</tt><tt> </tt><tt>supports.</tt><span style="font-family: DejaVu Sans;"><tt>由于数据库的独立性它可以被导入到</tt><tt></tt></span><tt>Active</tt><tt> </tt><tt>Record</tt><span style="font-family: DejaVu Sans;"><tt>支持的任何数据库中。</tt><tt></tt></span><tt>This</tt><tt> </tt><tt>could</tt><tt> </tt><tt>be</tt><tt> </tt><tt>very</tt><tt> </tt><tt>useful</tt><tt> </tt><tt>if</tt><tt> </tt><tt>you</tt><tt> </tt><tt>were</tt><tt> </tt><tt>to</tt><tt> </tt><tt>distribute</tt><tt> </tt><tt>an</tt><tt> </tt><tt>application</tt><tt> </tt><tt>that</tt><tt> </tt><tt>is</tt><tt> </tt><tt>able</tt><tt> </tt><tt>to</tt><tt> </tt><tt>run</tt><tt> </tt><tt>against</tt><tt> </tt><tt>multiple</tt><tt> </tt><tt>databases.</tt><span style="font-family: DejaVu Sans;"><tt>这会非常有用如果你发行一个应用程序它可能面对多个数据库运行。</tt></span>

<a name="result_box1"></a><tt>There</tt><tt> </tt><tt>is</tt><tt> </tt><tt>however</tt><tt> </tt><tt>a</tt><tt> </tt><tt>trade-off:</tt><tt> </tt><tt>db/schema.rb</tt><tt> </tt><tt>cannot</tt><tt> </tt><tt>express</tt><tt> </tt><tt>database</tt><tt> </tt><tt>specific</tt><tt> </tt><tt>items</tt><tt> </tt><tt>such</tt><tt> </tt><tt>as</tt><tt> </tt><tt>foreign</tt><tt> </tt><tt>key</tt><tt> </tt><tt>constraints,</tt><tt> </tt><tt>triggers</tt><tt> </tt><tt>or</tt><tt> </tt><tt>stored</tt><tt> </tt><tt>procedures.</tt><span style="font-family: DejaVu Sans;">然而，有一个权衡：</span>DB/ schema.rb<span style="font-family: DejaVu Sans;">不能表达数据库的具体项目，如外键约束，触发器或存储过程。</span><tt>While</tt><tt> </tt><tt>in</tt><tt> </tt><tt>a</tt><tt> </tt><tt>migration</tt><tt> </tt><tt>you</tt><tt> </tt><tt>can</tt><tt> </tt><tt>execute</tt><tt> </tt><tt>custom</tt><tt> </tt><tt>SQL</tt><tt> </tt><tt>statements,</tt><tt> </tt><tt>the</tt><tt> </tt><tt>schema</tt><tt> </tt><tt>dumper</tt><tt> </tt><tt>cannot</tt><tt> </tt><tt>reconstitute</tt><tt> </tt><tt>those</tt><tt> </tt><tt>statements</tt><tt> </tt><tt>from</tt><tt> </tt><tt>the</tt><tt> </tt><tt>database.</tt><span style="font-family: DejaVu Sans;"><tt>虽然在一个</tt></span><tt>migration</tt><span style="font-family: DejaVu Sans;"><tt>你可以执行自定义的</tt></span><tt>SQL</tt><span style="font-family: DejaVu Sans;"><tt>表达式，</tt></span><tt>schema</tt><span style="font-family: DejaVu Sans;"><tt>储存器不能修复一些</tt></span><tt>SQL</tt><span style="font-family: DejaVu Sans;"><tt>的表达式（不能实现</tt></span><tt>migration</tt><span style="font-family: DejaVu Sans;"><tt>的</tt></span><tt>rollback</tt><span style="font-family: DejaVu Sans;"><tt>等功能）。</tt><tt></tt></span><tt>If</tt><tt> </tt><tt>you</tt><tt> </tt><tt>are</tt><tt> </tt><tt>using</tt><tt> </tt><tt>features</tt><tt> </tt><tt>like</tt><tt> </tt><tt>this</tt><tt> </tt><tt>then</tt><tt> </tt><tt>you</tt><tt> </tt><tt>should</tt><tt> </tt><tt>set</tt><tt> </tt><tt>the</tt><tt> </tt><tt>schema</tt><tt> </tt><tt>format</tt><tt> </tt><tt>to</tt><tt> </tt><tt>:sql.</tt><span style="font-family: DejaVu Sans;"><tt>如果你正在使用这样的特性接着你应该设置</tt></span><tt>schema</tt><tt> </tt><span style="font-family: DejaVu Sans;"><tt>格式为</tt></span><tt>:sql</tt><span style="font-family: DejaVu Sans;"><tt>。</tt></span>

<tt>Instead</tt><tt> </tt><tt>of</tt><tt> </tt><tt>using</tt><tt> </tt><tt>Active</tt><tt> </tt><tt>Record</tt><tt>’</tt><tt>s</tt><tt> </tt><tt>schema</tt><tt> </tt><tt>dumper</tt><tt> </tt><tt>the</tt><tt> </tt><tt>database</tt><tt>’</tt><tt>s</tt><tt> </tt><tt>structure</tt><tt> </tt><tt>will</tt><tt> </tt><tt>be</tt><tt> </tt><tt>dumped</tt><tt> </tt><tt>using</tt><tt> </tt><tt>a</tt><tt> </tt><tt>tool</tt><tt> </tt><tt>specific</tt><tt> </tt><tt>to</tt><tt> </tt><tt>that</tt><tt> </tt><tt>database</tt><tt> </tt><tt>(via</tt><tt> </tt><tt>the</tt><tt> </tt><tt>db:structure:dump</tt><tt> </tt><tt>Rake</tt><tt> </tt><tt>task)</tt><tt> </tt><tt>into</tt><tt> </tt><tt>db/#{Rails.env}_structure.sql.</tt><tt> </tt><tt>For</tt><tt> </tt><tt>example</tt><tt> </tt><tt>for</tt><tt> </tt><tt>PostgreSQL</tt><tt> </tt><tt>the</tt><tt> </tt><tt>pg_dump</tt><tt> </tt><tt>utility</tt><tt> </tt><tt>is</tt><tt> </tt><tt>used</tt><tt> </tt><tt>and</tt><tt> </tt><tt>for</tt><tt> </tt><tt>MySQL</tt><tt> </tt><tt>this</tt><tt> </tt><tt>file</tt><tt> </tt><tt>will</tt><tt> </tt><tt>contain</tt><tt> </tt><tt>the</tt><tt> </tt><tt>output</tt><tt> </tt><tt>of</tt><tt> </tt><tt>SHOW</tt><tt> </tt><tt>CREATE</tt><tt> </tt><tt>TABLE</tt><tt> </tt><tt>for</tt><tt> </tt><tt>the</tt><tt> </tt><tt>various</tt><tt> </tt><tt>tables.</tt><tt> </tt><tt>Loading</tt><tt> </tt><tt>this</tt><tt> </tt><tt>schema</tt><tt> </tt><tt>is</tt><tt> </tt><tt>simply</tt><tt> </tt><tt>a</tt><tt> </tt><tt>question</tt><tt> </tt><tt>of</tt><tt> </tt><tt>executing</tt><tt> </tt><tt>the</tt><tt> </tt><tt>SQL</tt><tt> </tt><tt>statements</tt><tt> </tt><tt>contained</tt><tt> </tt><tt>inside.</tt>

<a name="result_box2"></a>By definition this will be a perfect copy of the database’s structure but this will usually prevent loading the schema into a database other than the one used to create it.<span style="font-family: DejaVu Sans;">根据定义，这将是一个完美的复制数据库的结构，但通常会阻止加载到比其他用于创建一个数据库的架构。</span>
<h4><a name="schema-dumps-and-source-control"></a><tt>6.3</tt><tt> </tt><tt>Schema</tt><tt> </tt><tt>Dumps</tt><tt> </tt><tt>and</tt><tt> </tt><tt>Source</tt><tt> </tt><tt>Control</tt></h4>
Because schema dumps are the authoritative source for your database schema, it is strongly recommended<span style="font-family: DejaVu Sans;">建议</span>that you check them into source control.<span style="font-family: DejaVu Sans;">因为架构转储是你的数据库架构的授权源，强烈建议你检查他们到源控制。</span>
<h3><a name="active-record-and-referential-integrity"></a> 7 Active Record and Referential<span style="font-family: WenQuanYi Micro Hei;">参照</span>Integrity<span style="font-family: WenQuanYi Micro Hei;">完整</span></h3>
The Active Record way claims that intelligence belongs in your models, not in the database. As such, features such as triggers or foreign key constraints, which push some of that intelligence back into the database, are not heavily used.

Validations such as <tt>validates</tt><tt> </tt><tt>:foreign_key,</tt><tt> </tt><tt>:uniqueness</tt><tt> </tt><tt>=&gt;</tt><tt> </tt><tt>true</tt> are one way in which models can enforce data integrity. The <tt>:dependent</tt> option on associations allows models to automatically destroy child objects when the parent is destroyed. Like anything which operates at the application level these cannot guarantee referential integrity and so some people augment them with foreign key constraints.

Although Active Record does not provide any tools for working directly with such features, the <tt>execute</tt> method can be used to execute arbitrary SQL. There are also a number of plugins such as <span style="color: #000080;"><span style="text-decoration: underline;"><a href="https://github.com/harukizaemon/redhillonrails/tree/master/foreign_key_migrations/">foreign_key_migrations</a></span></span> which add foreign key support to Active Record (including support for dumping foreign keys in <tt>db/schema.rb</tt>).

&nbsp;
