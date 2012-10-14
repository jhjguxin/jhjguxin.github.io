---
layout: post
title: "蓄势待发！Rails 3 介绍"
date: 2011-11-03 14:30
comments: true
categories: [未分类]
tags: []
---
## 蓄势待发！Rails 3 介绍
在过去的两年中，Ruby on Rails 应用程序框架已经具备了一个由托管和服务提供商组成的一体式行业、一套功能广泛且令人印象深刻的开发工具，还有各种在 Ruby 用语里称为 <em>gems</em> 和 <em>plug-ins</em> 的补充库 — 可增强软件的功能。例如 Engine Yard 和 Heroku 就是两个提供虚拟的、方便的 Rails 软件托管的公司；Oink 和 Bullet 分别用来显示内存使用和性能；Clearance 和 Sunspot 则用来提供现成的身份验证和快速的索引式搜索。
<div><a name="fua"></a>
<h2>常用缩略语</h2>
<div>
<ul>
	<li><strong>CRUD</strong>：创建、读取、更新、删除</li>
	<li><strong>HTML</strong>：超文本标记语言</li>
	<li><strong>REST</strong>：具象状态传输</li>
	<li><strong>SQL</strong>：结构化查询语言</li>
</ul>
</div>
</div>
自 2007 年以来，Rails 社区也已不断壮大。全球有众多的 Rails 开发人员充满活力、团结互助，并且渴望不断地改进该软件。可以毫不夸张地说，Rails 的改进应归功于社区，因为是程序员之间不断的相互超越使得构建出的软件越来越完善。如此不断地循环，各个功能才得以从初期阶段快速发展，逐渐变的实用、功 能不断强大并完善，最终成为不可或缺的工具。在很多情况下，社区认为最基本的 gems 和 plug-ins 都会保留到 Rails 核心中。Rails 的 <em>named scopes</em>（一个查询快捷方式），可实现与 <em>nested forms</em> 相同的功能。这是一个新增的功能，可取代以前的尝试，并在相同的 HTML 表单中创建和编辑多个模型。实际上，对于 Rails 开发人员来说最困难的任务或许就是跟上变化的节奏。（幸运的是，目前有一些 Ruby 和 Ruby on Rails 的每周播客，这些播客会组织并呈现最新趋势以及分享最佳实践。）

Rails 下一个主要的发布是 Rails 版本 3，该版本继续保持工具包的快速改进。与以往相同，该软件仍然非常 “固执”，即仍然偏向于约定优于配置。Rails 的核心组件始终存在，即 RESTful 路径、关系、验证、模板和数据库抽象化。不过，这些组件的许多内部内容已经被重写或者进行了改进。最明显的并且很大程度上借用了 Merb 的理念的就是很多 Rails 的基本功能不再密切结合。例如，以前只对 Rails 应用程序可用的数据验证便捷功能现在成为独立的组件，并且可以包含在 Vanilla Ruby 代码中。如呈现部件和模板等控制器功能，现在也是相互独立的，并且可以嵌入到任一库中。

在这篇文章中，您将会了解 Rails 3 及其众多变化和附加功能，以及如何从头创建一个新的 Rails 3 应用程序。截至 2010 年 2 月中旬，Rails 3 还只是预发布的 Beta 版，核心小组正在收集补丁、反馈和文档，以准备在夏季前发布正式版本。不过当前的 Rails 3 版本足够用于构建应用程序以及了解诸多新增功能。

<a name="changes"></a>大改动、小变化

Rails 3 中变动的数量太多，无法在此全部列出。要阅读带有补充资料的完整列表，请查询 Rails 3 发布通知（请参阅 <a href="http://www.ibm.com/developerworks/cn/web/wa-introrails3/index.html?ca=drs-#resources">参考资料</a> 中的链接）。此处，仅介绍一些很可能会影响到开发人员的一些变动：
<ul>
	<li><strong>一条命令可以控制所有事件。</strong>有了 Rails 3，无需在每一个应用程序中使用整套脚本（script/server、script/generate 以及其他），使用一条命令即可取代其功能，该命令恰如其分地被命名为 <code>rails</code>。例如，在以前需要键入 <code>./script/console</code> 的地方，您现在只需键入 <code>rails console</code>。<code>rails</code> 命令还可以像以前一样生成新的应用程序。其运行方式依据其是否在现有的 Rails 应用程序中启动而有所不同。</li>
	<li><strong>可为依赖性提供具体的解决方案。</strong>协调和解决 gem 依赖性是个棘手的问题。与可用 gems 的集合一样，gem 的修订也是随系统的不同而有所变化。因为具有这样的多样化，所以很难广泛地部署或共享一个 Rails 应用程序。Rails 3 引入了 Bundler，这是一个专门用于管理依赖性的实用程序（因此无需再使用 <code>config.gem</code>）。您可以在应用程序根目录内一个名为 <em>Gemfile</em> 的目录中声明依赖性。Bundler 将下载和存储所有指定的 gem。您甚至可以在应用程序中 “打包” gem ，以便阻止从外部存储库下载。</li>
	<li><strong>不带查询语句的查询功能。</strong>一直以来，Rails 已经可以充分运用特定于领域的语言 (DSL) — 考虑一下 <code>has_one</code> 或 <code>validates_numericality_of</code> — 有一个明显的例外：数据库查询。可以确定地说，Rails 的动态搜寻器便捷、易用，但混合使用选项哈希值如 <code>:conditions</code>、<code>:order</code> 和 <code>:limit</code> 非常常见，因为都是 <code>find_by_sql</code> 语句。Rails 3 合并了 <em>relational algebra</em>，这是专门设计用于表示查询的 DSL。基本命令包括 <code>project</code>（用于选择列）、<code>where</code>（用于表示条件）、<code>join</code>（用于指定关系）、<code>take</code> 和 <code>skip</code>（分别用于限定和抵消），以及 <code>group</code>（用于聚集）等其他属性。</li>
	<li><strong>用于模糊样板代码的控制器。</strong>Rails 控制器的核心操作 —<code>new</code>、<code>create</code>、<code>edit</code> 和 <code>update</code> — 通常不变，尤其是当控制器大部分用于 CRUD 操作时。事实上，控制器生成器的输出 <code>./script/generate controller</code> 一般不需要进一步的修改就可以满足需要。考虑到这些相似性，Rails 3 引入了 <code>Responder</code> 来进一步简化代码。例如下面是 <code>create</code>操作全部所需的几行代码：
<table width="50%" border="0" cellspacing="0" cellpadding="0">
<tbody>
<tr>
<td>
<pre>  class PostsController
    respond_to :html, :xml

    def create
      @post = Post.create(params[:post])
      respond_with(@post)
    end
  end</pre>
</td>
</tr>
</tbody>
</table>
在该代码片段中，如果 <code>@post</code> 保存成功，<code>respond_with(@post)</code> 将发送到 <code>show</code> 以显示新的记录，而假设对象的验证失败，则发送到 <code>new</code>。</li>
</ul>
这仅仅是一个小样本。您可以在下一章节找到这些新功能的示例以及更多内容，例如从头构建 Rails 3 应用程序。

&nbsp;

<a name="app"></a>首次构建 Rails 3 应用程序

要运行 Rails 3，您的系统必须安装有 Ruby 1.8.7 版或 Ruby 1.9.2 版，或者该编程语言的较新版本及其附加库和解释程序。您的机器上最好同时安装有 Git 软件版本控制系统，因为 Rails 3 和许多其他重要的 Rails 项目都是在 Git 中进行维护的。您的系统还需要数据库引擎，例如 SQLite（版本 3）、MySQL 或者 PostgreSQL。开发 Rails 应用程序时，Web 服务器不是必须的，但它通常是生产部署的一部分。

要创建 Rails 3 应用程序，您必须拥有 Rails 3 预发布 gem 和所有其相关产品。这时，您只需通过运行几条命令（请参阅 <a href="http://www.ibm.com/developerworks/cn/web/wa-introrails3/index.html?ca=drs-#list1">清单 1</a>）即可安装所需的组件。（在您继续进行之前请查看 Rails 3 文档，因为根据版本的不同具体的操作会有所不同。）
<a name="list1"></a><strong>清单 1. Rails 3 预发布 gem 和相关产品</strong>
<table width="65%" border="0" cellspacing="0" cellpadding="0">
<tbody>
<tr>
<td>
<pre>				
$ gem install rails3b
Due to a rubygems bug, you must uninstall all older versions of bundler for 0.9 to work
Successfully installed mime-types-1.16
Successfully installed mail-2.1.2
Successfully installed text-hyphen-1.0.0
Successfully installed text-format-1.0.0
Successfully installed memcache-client-1.7.8
Successfully installed rack-1.1.0
Successfully installed rack-mount-0.4.7
Successfully installed abstract-1.0.0
Successfully installed erubis-2.6.5
Successfully installed i18n-0.3.3
Successfully installed tzinfo-0.3.16
Successfully installed bundler-0.9.5
Successfully installed thor-0.13.1
Successfully installed rails3b-3.0.1
14 gems installed

$ gem install arel --pre
Successfully installed activesupport-3.0.0.beta
Successfully installed arel-0.2.pre
2 gems installed

$ gem install rails --pre
Successfully installed activemodel-3.0.0.beta
Successfully installed actionpack-3.0.0.beta
Successfully installed activerecord-3.0.0.beta
Successfully installed activeresource-3.0.0.beta
Successfully installed actionmailer-3.0.0.beta
Successfully installed railties-3.0.0.beta
Successfully installed rails-3.0.0.beta
7 gems installed</pre>
</td>
</tr>
</tbody>
</table>
&nbsp;

下一步是生成应用程序 — 在 <a href="http://www.ibm.com/developerworks/cn/web/wa-introrails3/index.html?ca=drs-#list2">清单 2</a> 中显示了一个小 wiki。该应用程序创建并管理文章。每一篇文章都有一个标题和一些散文，通过从现有页面的正文创建一个指向新文章的引用，您即可创建一篇新的文章。引用可以是任一驼峰式大小写单词，例如 <em>TheSolarSystem</em> 或者 <em>TheOscars</em>。

<strong>注意：</strong>可通过下面的 <a href="http://www.ibm.com/developerworks/cn/web/wa-introrails3/index.html?ca=drs-#download">下载</a> 表格获取该 wiki 应用程序的源代码。
<a name="list2"></a><strong>清单 2. Wiki Rails 应用程序</strong>
<table width="65%" border="0" cellspacing="0" cellpadding="0">
<tbody>
<tr>
<td>
<pre>				
$ rails wiki</pre>
</td>
</tr>
</tbody>
</table>
&nbsp;

如果您运行了 <code>ls -lR</code> 来查看应用程序的内容，将会显示一些新文件：
<ul>
	<li><em>Gemfile</em>，即前面曾提到的 gem 清单。该文件必须至少包含两行：一行指向 Rails 3 beta gem 的源，另一行则绑定 Rails 3 beta gem 本身。您或许还需要第三行（至少）以连接数据库：
<table width="50%" border="0" cellspacing="0" cellpadding="0">
<tbody>
<tr>
<td>
<pre>source 'http://gemcutter.org'
gem "rails", "3.0.0.beta"
gem "sqlite3-ruby", :require =&gt; "sqlite3"</pre>
</td>
</tr>
</tbody>
</table>
</li>
	<li><em>config/application.rb</em>，它包含 config/environment.rb 中以前提供的很多选项。虽然后者仍然保留，但很大程度上已不再使用该文件。config/application.rb 的一个显著的附加功能是 <em>generators block</em>：
<table width="50%" border="0" cellspacing="0" cellpadding="0">
<tbody>
<tr>
<td>
<pre>config.generators do |g|
  g.orm             :active_record
  g.template_engine :erb
  g.test_framework  :test_unit, :fixture =&gt; true
end</pre>
</td>
</tr>
</tbody>
</table>
您的 Rails 3 应用程序可以使用一些兼容的对象关系映射器 (ORM)、模板引擎和测试框架。生成器块会指定应用程序的首选项，并根据您的模型、视图等调用适当的生成器。</li>
	<li><em>db/seeds.rb</em>，该文件对于 Rails 3 来说并不是新增的，但却有必要着重介绍一下，因为它是最近不久刚增加的功能（在 Rails 2.3.4 版引入的）。如果您的应用程序需要初始数据以正常运行，例如一个管理用户、价格代码或静态页面，那么您可以在 db/seeds.rb 中创建这些数据并运行任务 <code>rake db:seed</code>。在 Seed 文件之前，不存在初始化的惯例，许多开发人员把代码放入迁移中，这样容易混淆创建数据库和填充数据库之间的不同之处。</li>
	<li><em>config.ru</em>，存在于每个 Rails 3 应用程序的根目录下，即所谓的 <em>rackup</em> 文件，也就是基于 Rack 的应用程序的配置文件。Rails 3 是一个 Rack 应用程序，并且与任一支持 Rack 的 Web 服务器相兼容。总的来说，除非您想要添加其他 Rack 组件，否则请不要更改 config.ru 文件。</li>
</ul>
还有一些其他新文件；不过大多数看上去与 Rails 版本 2.3 相似。config/routes.rb 文件的功能与以往相同，只不过更加简化、更具有 Ruby 的特色。您将很快会看到一个示例。

生成应用程序并编辑 Gemfile 以声明依赖性之后，下一步就是收集应用程序所需的 gem。这是由新的实用程序 <code>bundle</code>（请参阅 <a href="http://www.ibm.com/developerworks/cn/web/wa-introrails3/index.html?ca=drs-#list3">清单 3</a>）来完成的工作。
<a name="list3"></a><strong>清单 3. 收集所需的 gem</strong>
<table width="65%" border="0" cellspacing="0" cellpadding="0">
<tbody>
<tr>
<td>
<pre>				
$ bundle
installFetching source index from http://gemcutter.org
Resolving dependencies
Installing abstract (1.0.0) from system gems
Installing actionmailer (3.0.0.beta) from system gems
Installing actionpack (3.0.0.beta) from system gems
Installing activemodel (3.0.0.beta) from system gems
Installing activerecord (3.0.0.beta) from system gems
Installing activeresource (3.0.0.beta) from system gems
Installing activesupport (3.0.0.beta) from system gems
Installing arel (0.2.1) from rubygems repository at http://gemcutter.org
Installing builder (2.1.2) from system gems
Installing bundler (0.9.7) from rubygems repository at http://gemcutter.org
Installing erubis (2.6.5) from system gems
Installing i18n (0.3.3) from system gems
Installing mail (2.1.2) from system gems
Installing memcache-client (1.7.8) from system gems
Installing mime-types (1.16) from system gems
Installing rack (1.1.0) from system gems
Installing rack-mount (0.4.7) from system gems
Installing rack-test (0.5.3) from system gems
Installing rails (3.0.0.beta) from system gems
Installing railties (3.0.0.beta) from system gems
Installing rake (0.8.7) from system gems
Installing sqlite3-ruby (1.2.5) from rubygems repository at
    http://gemcutter.org with native extensions
Installing text-format (1.0.0) from system gems
Installing text-hyphen (1.0.0) from system gems
Installing thor (0.13.3) from rubygems repository at http://gemcutter.org
Installing tzinfo (0.3.16) from system gems
Your bundle is complete!</pre>
</td>
</tr>
</tbody>
</table>
&nbsp;

该 <code>bundle</code> 实用程序，简称 <em>Bundler</em>，可用于下载和安装所有在 Gemfile 中指定的 gem 以及任何这些 gems 的依赖项（请参阅 <a href="http://www.ibm.com/developerworks/cn/web/wa-introrails3/index.html?ca=drs-#list4">清单 4</a>）。该 <code>bundle</code> 实用程序还可以将所有依赖项复制到您的应用程序中，使得您的代码库自给自足。具体来说，如果您运行 <code>bundle pack</code>，Bundler 会将所有 gem 的资料复制到 vendor/cache。
<a name="list4"></a><strong>清单 4. 运行 bundle 实用程序</strong>
<table width="65%" border="0" cellspacing="0" cellpadding="0">
<tbody>
<tr>
<td>
<pre>				
$ bundle pack
Copying .gem files into vendor/cache
  * bundler-0.9.7.gem
  * thor-0.13.3.gem
  * abstract-1.0.0.gem
  * mime-types-1.16.gem
  * text-hyphen-1.0.0.gem
  * rack-mount-0.4.7.gem
  * rake-0.8.7.gem
  * text-format-1.0.0.gem
  * tzinfo-0.3.16.gem
  * rack-test-0.5.3.gem
  * builder-2.1.2.gem
  * erubis-2.6.5.gem
  * memcache-client-1.7.8.gem
  * rack-1.1.0.gem
  * sqlite3-ruby-1.2.5.gem
  * i18n-0.3.3.gem
  * activesupport-3.0.0.beta.gem
  * arel-0.2.1.gem
  * mail-2.1.2.gem
  * activemodel-3.0.0.beta.gem
  * activerecord-3.0.0.beta.gem
  * actionpack-3.0.0.beta.gem
  * railties-3.0.0.beta.gem
  * actionmailer-3.0.0.beta.gem
  * activeresource-3.0.0.beta.gem
  * rails-3.0.0.beta.gem

$ ls vendor/cache
abstract-1.0.0.gem		memcache-client-1.7.8.gem
actionmailer-3.0.0.beta.gem	mime-types-1.16.gem
actionpack-3.0.0.beta.gem	rack-1.1.0.gem
activemodel-3.0.0.beta.gem	rack-mount-0.4.7.gem
activerecord-3.0.0.beta.gem	rack-test-0.5.3.gem
activeresource-3.0.0.beta.gem	rails-3.0.0.beta.gem
activesupport-3.0.0.beta.gem	railties-3.0.0.beta.gem
arel-0.2.1.gem			rake-0.8.7.gem
builder-2.1.2.gem		sqlite3-ruby-1.2.5.gem
bundler-0.9.7.gem		text-format-1.0.0.gem
erubis-2.6.5.gem		text-hyphen-1.0.0.gem
i18n-0.3.3.gem			thor-0.13.3.gem
mail-2.1.2.gem			tzinfo-0.3.16.gem</pre>
</td>
</tr>
</tbody>
</table>
&nbsp;

将 vendor/cache 视为应用程序自己的 gem 存储库。您可以将代码库移动到任何地方，并可以获得您所需的 gem 软件和版本 — 无需远程存储器即可实现。例如，如果您在 <code>bundle pack</code> 之后运行 <code>bundle install</code>，gem 会从您的应用程序存储库安装到您的系统中（请参阅 <a href="http://www.ibm.com/developerworks/cn/web/wa-introrails3/index.html?ca=drs-#list5">清单 5</a>）。
<a name="list5"></a><strong>清单 5. 安装 gem</strong>
<table width="65%" border="0" cellspacing="0" cellpadding="0">
<tbody>
<tr>
<td>
<pre>				
Fetching source index from http://gemcutter.org
Resolving dependencies
Installing abstract (1.0.0) from .gem files at
  /Users/strike/projects/rails3/wiki/vendor/cache
Installing actionmailer (3.0.0.beta) from .gem files at
  /Users/strike/projects/rails3/wiki/vendor/cache
Installing actionpack (3.0.0.beta) from .gem files at
  /Users/strike/projects/rails3/wiki/vendor/cache
...
Installing thor (0.13.3) from .gem files at
  /Users/strike/projects/rails3/wiki/vendor/cache
Installing tzinfo (0.3.16) from .gem files at
  /Users/strike/projects/rails3/wiki/vendor/cache
Your bundle is complete!</pre>
</td>
</tr>
</tbody>
</table>
&nbsp;

&nbsp;

<a name="wiki"></a>使用 wiki

要创建应用程序，则需要为页面生成一个工作框架（scaffold）、创建数据库、将初始页面放到数据库并且设定所需的路径（请参阅 <a href="http://www.ibm.com/developerworks/cn/web/wa-introrails3/index.html?ca=drs-#list6">清单 6</a>）。 为了简单化，仅限在某些字段使用 wiki 页面记录：标题、标头（标题的缩略语）、正文和时间截（以用于记录页面的创建时间和最新修改时间）。标题和标头是字符串字段；散文是文本字段；时间截是日 期和时间字段。（当然，一个真正的 wiki 还会有其他字段，如最近的作者以及页面的修订历史记录。为了尽量简洁，该例子还省略了用户和会话、格式以及各种身份验证和授权。）您可以使用 <code>rails generate scaffold</code> 命令生成一个初始模型、一系列视图以及一个控制器。
<a name="list6"></a><strong>清单 6. 完整的 wiki 应用程序</strong>
<table width="65%" border="0" cellspacing="0" cellpadding="0">
<tbody>
<tr>
<td>
<pre>				
$ rails generate scaffold page title:string slug:string body:text --timestamps
      invoke  active_record
      create    db/migrate/20100221115613_create_pages.rb
      create    app/models/page.rb
      invoke    test_unit
      create      test/unit/page_test.rb
      create      test/fixtures/pages.yml
       route  resources :pages
      invoke  scaffold_controller
      create    app/controllers/pages_controller.rb
      invoke    erb
      create      app/views/pages
      create      app/views/pages/index.html.erb
      create      app/views/pages/edit.html.erb
      create      app/views/pages/show.html.erb
      create      app/views/pages/new.html.erb
      create      app/views/pages/_form.html.erb
      create      app/views/layouts/pages.html.erb
      invoke    test_unit
      create      test/functional/pages_controller_test.rb
      invoke    helper
      create      app/helpers/pages_helper.rb
      invoke      test_unit
      create        test/unit/helpers/pages_helper_test.rb
      invoke  stylesheets
      create    public/stylesheets/scaffold.css</pre>
</td>
</tr>
</tbody>
</table>
&nbsp;

如果您想知道 <code>./script/generate</code> 命令有何变化，回忆一下，该命令已经被全能的 <code>rails</code> 命令包含了。

运行 <code>rake db:create db:migrate</code> 以创建数据库：
<table width="65%" border="0" cellspacing="0" cellpadding="0">
<tbody>
<tr>
<td>
<pre>$ rake db:create db:migrate
==  CreatePages: migrating ====================================================
-- create_table(:pages)
   -&gt; 0.0010s
==  CreatePages: migrated (0.0011s) ===========================================</pre>
</td>
</tr>
</tbody>
</table>
&nbsp;

该 Wiki 现已存在，但却是空的。添加一个初始页面作为所有其他页面的基准。编辑文件 db/seeds.rb，并编写代码以创建一个新的页面，如 <a href="http://www.ibm.com/developerworks/cn/web/wa-introrails3/index.html?ca=drs-#list7">清单 7</a> 中所示。
<a name="list7"></a><strong>清单 7. wiki 基准页面</strong>
<table width="65%" border="0" cellspacing="0" cellpadding="0">
<tbody>
<tr>
<td>
<pre>				
Page.create(
  :title    =&gt; 'The Marx Brothers Wiki',
  :slug     =&gt; 'Home',
  :body     =&gt; 'An encyclopedic guide to the Marx Brothers.')</pre>
</td>
</tr>
</tbody>
</table>
&nbsp;

运行 <code>rake db:seed</code> 以执行代码。您可以通过使用 <code>rails console</code> 快速浏览以验证页面，如 <a href="http://www.ibm.com/developerworks/cn/web/wa-introrails3/index.html?ca=drs-#list8">清单 8</a> 中所示。
<a name="list8"></a><strong>清单 8. 验证基准页面</strong>
<table width="65%" border="0" cellspacing="0" cellpadding="0">
<tbody>
<tr>
<td>
<pre>				
$ rake db:seed
(in /Users/strike/projects/rails3/wiki)

$ rails console
Loading development environment (Rails 3.0.0.beta)
irb(main):001:0&gt; Page.all
=&gt; [#&lt;Page id: 1, title: "The Marx Brothers Wiki", slug: "Home",
    body: "An encyclopedic guide to the Marx Brothers.",
    created_at: "2010-02-21 12:24:43", updated_at: "2010-02-21 12:24:43"&gt;]</pre>
</td>
</tr>
</tbody>
</table>
&nbsp;

在继续运行编码之前，请先设定路径。需要两条路径：一条默认的路径用来查找主页面，而另外一条路径则通过标头来查找页面。<a href="http://www.ibm.com/developerworks/cn/web/wa-introrails3/index.html?ca=drs-#list9">清单 9</a> 显示了最终版的 config/routes.rb 文件。
<a name="list9"></a><strong>清单 9. config/routes.rb（最终版）</strong>
<table width="65%" border="0" cellspacing="0" cellpadding="0">
<tbody>
<tr>
<td>
<pre>				
Wiki::Application.routes.draw do |map|
  resources :pages
  root :to =&gt; "pages#show"
end</pre>
</td>
</tr>
</tbody>
</table>
&nbsp;

在 <a href="http://www.ibm.com/developerworks/cn/web/wa-introrails3/index.html?ca=drs-#list6">清单 6</a> 中，<code>rails generate scaffold page</code> 这一行命令可自动在第二行创建路径，这是 REST 式的。您必须在第三行手动添加路径。用于指定站点路径的默认 “根目录” 的语法是 Rails 3 中的新增功能。第三行定义的是，“将路径 ‘/’ 映射到页面控制器的 ‘show’ 方法”。<code>show</code> 方法的代码将在数据库中查找主页面并显示出来。

添加新的根目录路径后，需要删除 public/index.html 文件以避免产生冲突：
<table width="65%" border="0" cellspacing="0" cellpadding="0">
<tbody>
<tr>
<td>
<pre>$ rm public/index.html</pre>
</td>
</tr>
</tbody>
</table>
&nbsp;

现在，让我们来关注页面控制器。Rails 3 中的控制器代码可以极其简单。<a href="http://www.ibm.com/developerworks/cn/web/wa-introrails3/index.html?ca=drs-#list10">清单 10</a> 通过单一的 <code>show</code> 方法，显示了控制器的初始实现。
<a name="list10"></a><strong>清单 10. Rails 3 控制器</strong>
<table width="65%" border="0" cellspacing="0" cellpadding="0">
<tbody>
<tr>
<td>
<pre>				
class PagesController &lt; ApplicationController
  respond_to :html

  def show
    @page = Page.where( :slug =&gt; ( params[:id] || 'Home' ) ).first
    respond_with( @page )
  end
end</pre>
</td>
</tr>
</tbody>
</table>
&nbsp;

正如您所看到的，通常在 Rails 2 控制器中提供的所有模板都不见了。<code>respond_to</code> 列出了控制器所支持的格式；此处，它仅会对 HTML 的请求做出反应。<code>respond_with</code> 是逻辑快捷方式，用于决定控制器应如何继续处理。

查询的语法也是大有不同。查询是 Rails 3 关系代数的一个示例。您可能会想知道为什么需要有 <code>first</code> 后缀。<code>where</code> 和其他表达查询的操作数并不会真正引起查询语句被执行。相反地，查询站点一直闲置，直到真正需要数据时才启动。这就是<em>延迟加载</em>，即尽可能长的延迟查询语句的执行。<code>first</code> 命令将触发数据库中的实际查询。

如果您现在运行应用程序，您会看到与 <a href="http://www.ibm.com/developerworks/cn/web/wa-introrails3/index.html?ca=drs-#fig1">图 1</a> 相似的情况。
<a name="fig1"></a><strong>图 1. Rails 3 wiki 应用程序</strong>
<img src="http://www.ibm.com/developerworks/cn/web/wa-introrails3/fig1.jpg" alt="该屏幕截图显示带有以下文本的页面：“标题：”Marx Brothers wiki；“标头：”主页；“正文：” Marx Brothers 的百科全书指南。底部显示有 “编辑” 和 “后一页” 的按钮。" width="400" height="235" />

现在，您可以向控制器中添加更多的代码。<a href="http://www.ibm.com/developerworks/cn/web/wa-introrails3/index.html?ca=drs-#list11">清单 11</a> 显示了完整的控制器。
<a name="list11"></a><strong>清单 11. 完整的 Rails 3 控制器</strong>
<table width="65%" border="0" cellspacing="0" cellpadding="0">
<tbody>
<tr>
<td>
<pre>				
class PagesController &lt; ApplicationController
  respond_to :html
  before_filter :get_page, :except =&gt; [ :create ]

  def create
    respond_with( @page = Page.create( params[ :page ] ) )
  end

  def edit
  end

  def index
    render :action =&gt; :show
  end

  def show
    @page ||= Page.new( :slug =&gt; params[ :id ] )

    if @page.new_record?
      render :action =&gt; :new
    else
      respond_with( @page )
    end
  end

  def update
    @page.update_attributes( params[ :page ] )
    respond_with( @page )
  end

  private

    def get_page
      @page = Page.where( :slug =&gt; ( params[:id] || 'Home' ) ).first ||
        Page.where( :id =&gt; params[:id] ).first
    end
end</pre>
</td>
</tr>
</tbody>
</table>
&nbsp;

在该控制器中，<code>index</code> 方法仅仅反映没有页面标示符的 <code>show</code> 操作，从而呈现主页面。<code>show</code> 会显示一个页面，并提供一个 ID 或标头（所有操作的查询都集中在 <code>get_page</code> 中，从而进一步减少了代码的数量）；如果某个页面不存在，则会准备一个新的页面以供进行编辑。

<code>Page</code> 模型仅仅可以验证所有显示的字段：
<table width="65%" border="0" cellspacing="0" cellpadding="0">
<tbody>
<tr>
<td>
<pre>class Page &gt; ActiveRecord::Base
  validates_presence_of :body, :slug, :title
end</pre>
</td>
</tr>
</tbody>
</table>
&nbsp;

将驼峰式大小写引用转换为指向其他页面的链接，这一工作是在 <code>Page</code> 模型的视图中进行的。由 app/helpers/pages_helper.rb 中的 helper 函数来完成这一工作，从而保持视图的最小化（请参阅 <a href="http://www.ibm.com/developerworks/cn/web/wa-introrails3/index.html?ca=drs-#list12">清单 12</a>）。
<a name="list12"></a><strong>清单 12. 驼峰式大小写转换 helper 函数</strong>
<table width="65%" border="0" cellspacing="0" cellpadding="0">
<tbody>
<tr>
<td>
<pre>				
module PagesHelper
  def wikify( page )
    return '' if page.body.blank?
    page.body.gsub( /^([A-Z][[:alnum:]]*([A-Z][[:alnum:]]*)+)/ ) do |match|
      link_to( $1, :action =&gt; :show, :id =&gt; $1 )
    end
  end
end</pre>
</td>
</tr>
</tbody>
</table>
&nbsp;

该视图是典型的视图，如 <a href="http://www.ibm.com/developerworks/cn/web/wa-introrails3/index.html?ca=drs-#list13">清单 13</a> 中所示。
<a name="list13"></a><strong>清单 13. 典型视图</strong>
<table width="65%" border="0" cellspacing="0" cellpadding="0">
<tbody>
<tr>
<td>
<pre>				
&lt;p&gt;
  &lt;b&gt;Title:&lt;/b&gt;
  &lt;%= @page.title %&gt;
&lt;/p&gt;

&lt;p&gt;
  &lt;b&gt;Body:&lt;/b&gt;
  &lt;%= raw wikify( @page ) %&gt;
&lt;/p&gt;

&lt;%= link_to 'Edit', edit_page_path(@page) %&gt; |
&lt;%= link_to 'Back', pages_path %&gt;</pre>
</td>
</tr>
</tbody>
</table>
&nbsp;

<code>raw</code> 操作数是 Rails 3 中新增的功能。与以前版本的 Rails 不同，默认情况下所有的字符串都可以（去掉了 HTML）安全发送。如果要通过 HTML 发送一个字符串，则必须使用 <code>raw</code>。

&nbsp;

<a name="switching"></a>切换 Rails

除了此处所介绍的功能改进和便捷性，Rails 3 还提供了比以前版本更佳的性能，尤其是在呈现部件方面。您还可以创建您专有的验证器类，并充分利用更为流畅的标准验证。例如，由 Jeremy McAnally 编写以下验证，一次需要四行单独的代码：
<table width="65%" border="0" cellspacing="0" cellpadding="0">
<tbody>
<tr>
<td>
<pre>validates :login, :presence =&gt; true, :length =&gt; {:minimum =&gt; 4},
  :uniqueness =&gt; true, :format =&gt; { :with =&gt; /[A-Za-z0-9]+/ }</pre>
</td>
</tr>
</tbody>
</table>
&nbsp;

Rails 的官方教程 “Rails 指南” 目前正在更新为 Rails 3 版。您也可以在 Jeremy McAnally、Yehuda Katz、Gregg Pollack 和其他社区领导者们的博客中找到更详细的说明以及更便捷的解决方案（请参阅 <a href="http://www.ibm.com/developerworks/cn/web/wa-introrails3/index.html?ca=drs-#resources">参考资料</a>）。一些受大众欢迎的书籍也正在进行修订，其中包括十分创新的《应用 Rails 进行敏捷 Web 开发》（请参阅 <a href="http://www.ibm.com/developerworks/cn/web/wa-introrails3/index.html?ca=drs-#resources">参考资料</a>）。
