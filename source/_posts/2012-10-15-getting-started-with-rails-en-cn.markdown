---
layout: post
title: "Getting Started with Rails-(EN-CN)"
date: 2011-11-10 03:05
comments: true
categories: ["rails"]
tags: ["book", "rails", "ubuntu 11.10", "web", "经验"]
---
## Getting Started with Rails-(EN-CN)
<h2>Getting Started with Rails</h2>
This guide covers getting up and running with Ruby on Rails. After reading it, you should be familiar with:<span style="font-family: DejaVu Sans;">本指导手册覆盖了入门和运行</span>ruby on rails<span style="font-family: DejaVu Sans;">，通过阅读本指导，你会了解到：</span>
<ul>
	<li>Installing Rails, creating a new Rails application, and connecting your application to a database</li>
	<li>The general layout#<span style="font-family: DejaVu Sans;">布局</span>of a Rails application <span style="font-family: DejaVu Sans;">应用程序的一般布局</span></li>
	<li>The basic principles of MVC (Model, View Controller) and RESTful design MVC<span style="font-family: DejaVu Sans;">的基本原则和</span>RESTful<span style="font-family: DejaVu Sans;">设计（理念）</span></li>
	<li>How to quickly generate the starting pieces of a Rails application <span style="font-family: DejaVu Sans;">如何快捷的开始一个</span>Rails<span style="font-family: DejaVu Sans;">应用</span></li>
</ul>
<span style="color: #800000;"><em>This</em></span><span style="color: #800000;"><em>Guide</em></span><span style="color: #800000;"><em>is</em></span><span style="color: #800000;"><em>based</em></span><span style="color: #800000;"><em>on</em></span><span style="color: #800000;"><em>Rails</em></span><span style="color: #800000;"><em>3.1.</em></span><span style="color: #800000;"><em>Some</em></span><span style="color: #800000;"><em>of</em></span><span style="color: #800000;"><em>the</em></span><span style="color: #800000;"><em>code</em></span><span style="color: #800000;"><em>shown</em></span><span style="color: #800000;"><em>here</em></span><span style="color: #800000;"><em>will</em></span><span style="color: #800000;"><em>not</em></span><span style="color: #800000;"><em>work</em></span><span style="color: #800000;"><em>in</em></span><span style="color: #800000;"><em>earlier</em></span><span style="color: #800000;"><em>versions</em></span><span style="color: #800000;"><em>of</em></span><span style="color: #800000;"><em>Rails.</em><span style="font-family: DejaVu Sans;"><em>这个指导手册适用与</em></span></span><span style="color: #800000;"><em>Rails3.1</em><span style="font-family: DejaVu Sans;"><em>，有些代码在</em></span></span><span style="color: #800000;"><em>Rails</em><span style="font-family: DejaVu Sans;"><em>早期版本可能会不工作。</em></span></span>
<h3><a name="guide-assumptions"></a>1 Guide Assumptions<span style="font-family: WenQuanYi Micro Hei;">假设</span></h3>
<h3><a name="guide-assumptions1"></a>1 Guide Assumptions</h3>
This guide is designed for beginners who want to get started with a Rails application from scratch#<span style="font-family: DejaVu Sans;">刻痕</span>. It does not assume#<span style="font-family: DejaVu Sans;">假设</span>that you have any prior#<span style="font-family: DejaVu Sans;">预先</span>experience with Rails. However, to get the most out of it, you need to have some prerequisites installed:<span style="font-family: DejaVu Sans;">本指导设计给那些想大概的了解</span>Rails<span style="font-family: DejaVu Sans;">应用创建的初学者。这里假设你对</span>Rails<span style="font-family: DejaVu Sans;">没有任何预先的了解。不管怎样要得到（本手册的）知识，你需要预先安装：</span>
<ul>
	<li>The <span style="color: #000080;"><span style="text-decoration: underline;"><a href="http://www.ruby-lang.org/en/downloads">Ruby</a></span></span> language version 1.8.7 or higher</li>
</ul>
<em><strong>Note</strong></em><em> </em><em>that</em><em> </em><em>Ruby</em><em> </em><em>1.8.7</em><em> </em><em>p248</em><em> </em><em>and</em><em> </em><em>p249</em><em> </em><em>have</em><em> </em><em>marshaling#</em><span style="font-family: DejaVu Sans;"><em>封送处理</em></span><em>bugs</em><em> </em><em>that</em><em> </em><em>crash#</em><span style="font-family: DejaVu Sans;"><em>意外崩溃</em><em>紧急</em></span><em>Rails</em><em> </em><em>3.0.</em><em> </em><em>Ruby</em><em> </em><em>Enterprise</em><em> </em><em>Edition</em><em> </em><em>have</em><em> </em><em>these</em><em> </em><em>fixed</em><em> </em><em>since</em><em> </em><em>release</em><em> </em><em>1.8.7-2010.02</em><em> </em><em>though.</em><em> </em><em>Ruby</em><em> </em><em>1.8.7</em><em> </em><em>p248</em><em> </em><em>and</em><em> </em><em>p249</em><span style="font-family: DejaVu Sans;"><em>在</em><em>发行版</em></span><em>1.8.7-2010.02</em><em> </em><span style="font-family: DejaVu Sans;"><em>已经得到解决。</em></span><em>On</em><em> </em><em>the</em><em> </em><em>1.9</em><em> </em><em>front,</em><em> </em><em>Ruby</em><em> </em><em>1.9.1</em><em> </em><em>is</em><em> </em><em>not</em><em> </em><em>usable</em><em> </em><em>because</em><em> </em><em>it</em><em> </em><em>outright</em><em> </em><em>segfaults</em><em> </em><em>on</em><em> </em><em>Rails</em><em> </em><em>3.0,</em><em> </em><em>so</em><em> </em><em>if</em><em> </em><em>you</em><em> </em><em>want</em><em> </em><em>to</em><em> </em><em>use</em><em> </em><em>Rails</em><em> </em><em>3</em><em> </em><em>with</em><em> </em><em>1.9.x</em><em> </em><em>jump</em><em> </em><em>on</em><em> </em><em>1.9.2</em><em> </em><em>for</em><em> </em><em>smooth</em><em> </em><em>sailing.</em>
<ul>
	<li>The <span style="color: #000080;"><span style="text-decoration: underline;"><a href="http://rubyforge.org/frs/?group_id=126">RubyGems</a></span></span>packaging system
<ul>
	<li>If you want to learn more about RubyGems, please read the <a href="http://docs.rubygems.org/read/book/1"><span style="color: #000080;"><span style="text-decoration: underline;">RubyGems</span></span><span style="color: #000080;"><span style="text-decoration: underline;">User</span></span><span style="color: #000080;"><span style="text-decoration: underline;">Guide</span></span></a> <span style="font-family: DejaVu Sans;">如果你想了解更多关于</span>RubyGems<span style="font-family: DejaVu Sans;">，请阅读</span><a href="http://docs.rubygems.org/read/book/1"><span style="color: #000080;"><span style="text-decoration: underline;">RubyGems</span></span><span style="color: #000080;"><span style="text-decoration: underline;">User</span></span><span style="color: #000080;"><span style="text-decoration: underline;">Guide</span></span></a></li>
</ul>
</li>
	<li>A working installation of the <a href="http://www.sqlite.org/"><span style="color: #000080;"><span style="text-decoration: underline;">SQLite3</span></span><span style="color: #000080;"><span style="text-decoration: underline;">Database</span></span></a></li>
</ul>
Rails is a web application framework running on the Ruby programming language. If you have no prior experience with Ruby, you will find a very steep#<span style="font-family: DejaVu Sans;">陡</span>learning curve diving straight into Rails. There are some good free resources on the internet for learning Ruby, including: Rails<span style="font-family: DejaVu Sans;">是一个基于</span>Ruby<span style="font-family: DejaVu Sans;">程序语言的</span>web<span style="font-family: DejaVu Sans;">程序框架。如果你没有预先的学习</span>ruby<span style="font-family: DejaVu Sans;">，你会发现直接的入门</span>Rails<span style="font-family: DejaVu Sans;">学习很有跨度。这里有一些学习</span>ruby<span style="font-family: DejaVu Sans;">的免费互联网资源。</span>
<ul>
	<li><a href="http://www.humblelittlerubybook.com/"><span style="color: #000080;"><span style="text-decoration: underline;">Mr.</span></span><span style="color: #000080;"><span style="text-decoration: underline;">Neighborly</span></span><span style="color: #000080;"><span style="text-decoration: underline;">’</span></span><span style="color: #000080;"><span style="text-decoration: underline;">s</span></span><span style="color: #000080;"><span style="text-decoration: underline;">Humble</span></span><span style="color: #000080;"><span style="text-decoration: underline;">Little</span></span><span style="color: #000080;"><span style="text-decoration: underline;">Ruby</span></span><span style="color: #000080;"><span style="text-decoration: underline;">Book</span></span></a></li>
	<li><a href="http://www.ruby-doc.org/docs/ProgrammingRuby/"><span style="color: #000080;"><span style="text-decoration: underline;">Programming</span></span><span style="color: #000080;"><span style="text-decoration: underline;">Ruby</span></span></a></li>
	<li><a href="http://mislav.uniqpath.com/poignant-guide/"><span style="color: #000080;"><span style="text-decoration: underline;">Why</span></span><span style="color: #000080;"><span style="text-decoration: underline;">’</span></span><span style="color: #000080;"><span style="text-decoration: underline;">s</span></span><span style="color: #000080;"><span style="text-decoration: underline;">(Poignant)</span></span><span style="color: #000080;"><span style="text-decoration: underline;">Guide</span></span><span style="color: #000080;"><span style="text-decoration: underline;">to</span></span><span style="color: #000080;"><span style="text-decoration: underline;">Ruby</span></span></a></li>
</ul>
<h3><a name="what-is-rails"></a>2 What is Rails?<span style="font-family: WenQuanYi Micro Hei;">什么</span>Rails</h3>
Rails is a web application development framework written in the Ruby language. It is <strong>designed</strong><strong> </strong><strong>to</strong> make programming web applications easier by making assumptions#<span style="font-family: DejaVu Sans;">完成</span>about what every developer needs to get started. It allows you to write less code while accomplishing more than many other languages and frameworks. Experienced#<span style="font-family: DejaVu Sans;">经验丰富的</span>Rails developers also report that it makes web application development more fun.Rails<span style="font-family: DejaVu Sans;">是一个使用</span>Ruby<span style="font-family: DejaVu Sans;">语言编写的的</span>web<span style="font-family: DejaVu Sans;">框架应用程序。其设计目的是为了让每个着手开始编写</span>web<span style="font-family: DejaVu Sans;">应用程序的开发人员更加容易的完成工作。它允许你写最少的代码完成超过其他任何语言和框架所完成的工作。经验丰富的</span>Rails<span style="font-family: DejaVu Sans;">开发人员还告诉我们通过</span>Rails<span style="font-family: DejaVu Sans;">使设计</span>web<span style="font-family: DejaVu Sans;">应用程序更快乐。</span>

Rails is opinionated#<span style="font-family: DejaVu Sans;">自以为是</span>software. It makes the assumption that there is a “best” way to do things, and it’s designed to encourage#<span style="font-family: DejaVu Sans;">鼓励</span>that way – and in some cases to discourage alternatives<span style="font-family: DejaVu Sans;">替代品</span>. If you learn “The Rails Way” you’ll probably discover a tremendous increase in productivity. If you persist in bringing old habits#<span style="font-family: DejaVu Sans;">习惯</span>from other languages to your Rails development, and trying to use patterns<span style="font-family: DejaVu Sans;">模式</span>you learned elsewhere, you may have a less happy experience.Rails<span style="font-family: DejaVu Sans;">是一个自以为是的软件。它使得我们以最好的方式去做事情，它还鼓励<span style="font-family: Liberation Serif,Times New Roman,serif;">——</span></span>and in some cases to discourage alternatives<span style="font-family: DejaVu Sans;">，如果你学习<span style="font-family: Liberation Serif,Times New Roman,serif;">“</span></span>Rails<span style="font-family: DejaVu Sans;">方式<span style="font-family: Liberation Serif,Times New Roman,serif;">”</span>你将会适时的发现生产力的巨大增长。如果你固守在来自其他语言的旧的习惯去进行你的</span>Rails<span style="font-family: DejaVu Sans;">开发，以以它地方学来的模式尝试</span>Rails<span style="font-family: DejaVu Sans;">，那么你将会得到很少的快乐的经历。</span>

<strong>The</strong><strong> </strong><strong>Rails</strong><strong> </strong><strong>philosophy</strong><span style="font-family: DejaVu Sans;"><strong>理念</strong></span><strong>includes</strong><strong> </strong><strong>several</strong><strong> </strong><strong>guiding</strong><strong> </strong><strong>principles:Rails</strong><span style="font-family: DejaVu Sans;"><strong>理念包含几个指导原则</strong></span>
<ul>
	<li><strong>DRY</strong><strong> – “</strong><strong>Don</strong><strong>’</strong><strong>t</strong><strong> </strong><strong>Repeat</strong><strong> </strong><strong>Yourself</strong><strong>”</strong> – suggests that writing the same code over and over again is a bad thing. <span style="font-family: DejaVu Sans;">不要自己重复<span style="font-family: Liberation Serif,Times New Roman,serif;">——</span>建议一次又一次编写同样的代码是一件坏事请。</span></li>
	<li>Convention#<span style="font-family: DejaVu Sans;">约定</span>Over Configuration(<span style="font-family: DejaVu Sans;">约定优于配置</span>) – means that Rails makes assumptions about what you want to do and how you’re going to do it<span style="font-family: DejaVu Sans;">想做怎么做</span>, rather than requiring you to specify every little thing through endless configuration files. <span style="font-family: DejaVu Sans;">约定优于配置<span style="font-family: Liberation Serif,Times New Roman,serif;">——</span>意思是</span>Rails<span style="font-family: DejaVu Sans;">对于你想做什么以及你想怎么做，你刻意的做很少的事情比编写无尽的配置文件更好</span></li>
	<li>REST is the best pattern<span style="font-family: DejaVu Sans;">模式</span>for web applications – organizing your application around resources#<span style="font-family: DejaVu Sans;">资源</span>and standard HTTP verbs#<span style="font-family: DejaVu Sans;">动词</span>is the fastest way to go. REST<span style="font-family: DejaVu Sans;">是开发</span>web<span style="font-family: DejaVu Sans;">应用程序的最好模式<span style="font-family: Liberation Serif,Times New Roman,serif;">——</span>环绕</span>resources<span style="font-family: DejaVu Sans;">和标准的</span>HTTP<span style="font-family: DejaVu Sans;">动作组织你的应用程序</span></li>
</ul>
<h4><a name="the-mvc-architecture"></a>2.1 The MVC Architecture#MVC<span style="font-family: WenQuanYi Micro Hei;">架构</span></h4>
At the core of Rails is the Model, View, Controller architecture, usually just called MVC. MVC benefits include:Model<span style="font-family: DejaVu Sans;">，</span>View<span style="font-family: DejaVu Sans;">，</span>Controller<span style="font-family: DejaVu Sans;">架构是</span>Rails<span style="font-family: DejaVu Sans;">的核心，通常称之为</span>MVC<span style="font-family: DejaVu Sans;">。</span>
<ul>
	<li>Isolation<span style="font-family: DejaVu Sans;">分离</span>of business logic<span style="font-family: DejaVu Sans;">逻辑</span>from the user interface <span style="font-family: DejaVu Sans;">界面</span>#<span style="font-family: DejaVu Sans;">从用户界面的业务逻辑的分离</span></li>
	<li>Ease of keeping code DRY# <strong>“</strong><strong>Don</strong><strong>’</strong><strong>t</strong><strong> </strong><strong>Repeat</strong><strong> </strong><strong>Yourself</strong><strong>”</strong></li>
	<li>Making it clear where different types of code belong for easier maintenance #<span style="font-family: DejaVu Sans;">维护明确代码的不同之处使之跟容易维护</span></li>
</ul>
<h5><a name="models"></a>2.1.1 Models</h5>
A model represents<span style="font-family: DejaVu Sans;">代表</span>the information (data) of the application and the rules to manipulate that data.<span style="font-family: DejaVu Sans;">模型代表了应用程序的信息（数据）和操纵这些数据的规则。</span>In the case of Rails, models are primarily used for managing the rules of interaction with a corresponding#<span style="font-family: DejaVu Sans;">相应的</span>database table. In most cases, each table in your database will correspond to one model in your application. The bulk of your application’s business logic will be concentrated in the models.<span style="font-family: DejaVu Sans;">在</span>Rails<span style="font-family: DejaVu Sans;">中，</span>models<span style="font-family: DejaVu Sans;">主要用于管理数据表和相应的规则的互动。在大多数情况，在你数据库中的每个表都会和你的应用程序互动。你应用程序的逻辑业务将会集中放置在</span>models<span style="font-family: DejaVu Sans;">中。</span>
<h5><a name="views"></a>2.1.2 Views</h5>
Views represent the user interface of your application. In Rails, views are often HTML files with embedded Ruby code that perform<span style="font-family: DejaVu Sans;">执行</span>tasks related solely to the presentation#<span style="font-family: DejaVu Sans;">演示</span>of the data. Views handle the job of providing data to the web browser or other tool that is used to make requests from your application.View<span style="font-family: DejaVu Sans;">代表了应用程序的用户界面。在</span>Rails<span style="font-family: DejaVu Sans;">中，</span>Views<span style="font-family: DejaVu Sans;">通常是嵌入了执行演示数据任务的</span>Ruby<span style="font-family: DejaVu Sans;">代码的</span>HTML<span style="font-family: DejaVu Sans;">文件。</span>Views<span style="font-family: DejaVu Sans;">完成了给</span>web<span style="font-family: DejaVu Sans;">浏览器或者其他工具用于提出来自你的程序的请求提供数据。</span>
<h5><a name="controllers"></a>2.1.3 Controllers</h5>
Controllers provide the “glue” between models and views. In Rails, controllers are responsible for processing the incoming requests from the web browser, interrogating the models for data, and passing that data on to the views for presentation.Controllers<span style="font-family: DejaVu Sans;">提供了</span>models<span style="font-family: DejaVu Sans;">和视图间的粘合。在</span>Rails<span style="font-family: DejaVu Sans;">中，</span>controllers<span style="font-family: DejaVu Sans;">相应来自</span>web<span style="font-family: DejaVu Sans;">浏览器请求的进程，向</span>models<span style="font-family: DejaVu Sans;">询问数据以及传递数据给</span>views<span style="font-family: DejaVu Sans;">用于演示。</span>
<h4><a name="the-components-of-rails"></a>2.2 The Components of Rails Rials<span style="font-family: WenQuanYi Micro Hei;">的组件</span></h4>
Rails ships as many individual components.Rails<span style="font-family: DejaVu Sans;">关联着许多独立的组件。</span>Each of these components are briefly explained below. <span style="font-family: DejaVu Sans;">对这些组建在下面给出简要的解释。</span>If you are new to Rails, as you read this section, don’t get hung up on the details of each component, as they will be explained in further detail later. <span style="font-family: DejaVu Sans;">如果你是</span>Rails<span style="font-family: DejaVu Sans;">的新人，当你阅读到这个部分，不要抛弃任何一个组件的描述，而且他们还会做进一步解释。</span>For instance, we will bring up Rack applications, but you don’t need to know anything about them to continue with this guide.<span style="font-family: DejaVu Sans;">例如，我们将会构造应用骨架，但是在这里，你不需要知道关于他们的更进一步的任何知识。</span>
<ul>
	<li>Action Pack<span style="font-family: DejaVu Sans;">动作行为组</span>
<ul>
	<li>Action Controller <span style="font-family: DejaVu Sans;">行为控制</span></li>
	<li>Action Dispatch <span style="font-family: DejaVu Sans;">行为传输</span></li>
	<li>Action View <span style="font-family: DejaVu Sans;">行为视图</span></li>
</ul>
</li>
	<li>Action Mailer <span style="font-family: DejaVu Sans;">行为信封</span></li>
	<li>Active Model</li>
	<li>Active Record</li>
	<li>Active Resource</li>
	<li>Active Support</li>
	<li>Railties</li>
</ul>
<h5><a name="action-pack"></a>2.2.1 Action Pack</h5>
Action Pack is a single gem that contains Action Controller, Action View and Action Dispatch. The “VC” part of “MVC”.Action Pack<span style="font-family: DejaVu Sans;">是一个单独的包它包含了</span>Action Controller, Action View and Action Dispatch<span style="font-family: DejaVu Sans;">传输调度。是</span>MVC<span style="font-family: DejaVu Sans;">的</span>VC<span style="font-family: DejaVu Sans;">部分</span>
<h6><a name="action-controller"></a>2.2.1.1 Action Controller</h6>
Action Controller is the component that manages the controllers in a Rails application.The Action Controller framework processes incoming requests to a Rails application, extracts parameters, and dispatches them to the intended action. Services provided by Action Controller include session management, template rendering, and redirect management. Action Controller<span style="font-family: DejaVu Sans;">是在</span>Rails<span style="font-family: DejaVu Sans;">中管理控制的组件。</span>The Action Controller<span style="font-family: DejaVu Sans;">框架进程收到</span>Rails<span style="font-family: DejaVu Sans;">应用程序的请求，提取参数，以及调度他们到具有相应义务的动作。这些服务是由</span>Action Controller<span style="font-family: DejaVu Sans;">包含了会话管理部分，模板渲染（翻译），重定向部分。</span>
<h6><a name="action-view"></a>2.2.1.2 Action View</h6>
Action View manages the views of your Rails application. It can create both HTML and XML output by default. Action View manages rendering templates, including nested and partial templates, and includes built-in AJAX support. View templates are covered in more detail in another guide called <a href="http://guides.rubyonrails.org/layouts_and_rendering.html"><span style="color: #000080;"><span style="text-decoration: underline;">Layouts</span></span><span style="color: #000080;"><span style="text-decoration: underline;">and</span></span><span style="color: #000080;"><span style="text-decoration: underline;">Rendering</span></span></a>.Action View<span style="font-family: DejaVu Sans;">管理你的</span>Rails<span style="font-family: DejaVu Sans;">应用程序的视图。它可以以创建</span>HTML<span style="font-family: DejaVu Sans;">和</span>XML<span style="font-family: DejaVu Sans;">作为默认输出。</span>Action View<span style="font-family: DejaVu Sans;">管理模板渲染，包含嵌套和组装模板，还包含了内置的</span>AJAX<span style="font-family: DejaVu Sans;">支持。</span>
<h6><a name="action-dispatch"></a>2.2.1.3 Action Dispatch</h6>
Action Dispatch handles routing of web requests and dispatches them as you want, either to your application or any other Rack application. Rack applications are a more advanced topic and are covered in a separate guide called <a href="http://guides.rubyonrails.org/rails_on_rack.html"><span style="color: #000080;"><span style="text-decoration: underline;">Rails</span></span><span style="color: #000080;"><span style="text-decoration: underline;">on</span></span><span style="color: #000080;"><span style="text-decoration: underline;">Rack</span></span></a>.<span style="font-family: DejaVu Sans;">行为调度处理了你的和其他部分的应用程序的路由<span style="font-family: Liberation Serif,Times New Roman,serif;">——</span>这些</span>web<span style="font-family: DejaVu Sans;">请求以及一些你所想要的调度，</span>
<h5><a name="action-mailer"></a>2.2.2 Action Mailer</h5>
Action Mailer is a framework for building e-mail services. You can use Action Mailer to receive and process incoming email and send simple plain text or complex multipart emails based on flexible templates.Action Mailer<span style="font-family: DejaVu Sans;">是一个营造</span>E-mail<span style="font-family: DejaVu Sans;">服务的框架。你可以使用</span>Action Mailer<span style="font-family: DejaVu Sans;">去发送、接收</span>emial<span style="font-family: DejaVu Sans;">以及发送一些简单的计划文本或者基于灵活模板的复杂的多重的电子邮件。</span>
<h5><a name="active-model"></a>2.2.3 Active Model</h5>
Active Model provides a defined interface between the Action Pack gem services and Object Relationship Mapping gems such as Active Record. Active Model allows Rails to utilize other ORM frameworks in place of Active Record if your application needs this.Active Model<span style="font-family: DejaVu Sans;">提供了</span>Action Pack gem<span style="font-family: DejaVu Sans;">服务和</span>Object Relationship Mapping gems<span style="font-family: DejaVu Sans;">之间的接口定义，比如</span>Active<span style="font-family: DejaVu Sans;">记录。</span>Active Model<span style="font-family: DejaVu Sans;">允许</span>Rails<span style="font-family: DejaVu Sans;">在</span>Active Record<span style="font-family: DejaVu Sans;">部分去采用其他</span>ORM<span style="font-family: DejaVu Sans;">框架如果你的应用程序需要。</span>
<h5><a name="active-record"></a>2.2.4 Active Record</h5>
Active Record is the base for the models in a Rails application. It provides database independence, basic CRUD functionality, advanced finding capabilities, and the ability to relate models to one another, among other services.Active Record<span style="font-family: DejaVu Sans;">是一个</span>Rails<span style="font-family: DejaVu Sans;">应用程序的</span>models<span style="font-family: DejaVu Sans;">根本。它提供独立的数据库，基于</span>CRUD<span style="font-family: DejaVu Sans;">功能，先进（高级）的查找能力，和与另一个</span>models<span style="font-family: DejaVu Sans;">关联的能力，几乎所有其他服务。</span>
<h5><a name="active-resource"></a>2.2.5 Active Resource</h5>
Active Resource provides a framework for managing the connection between business objects and RESTful web services. It implements a way to map web-based resources to local objects with CRUD semantics.Active Resource<span style="font-family: DejaVu Sans;">提供一个管理目标业务和</span>RESTful web<span style="font-family: DejaVu Sans;">服务之间连接的框架。它实现了使用</span>CRUD<span style="font-family: DejaVu Sans;">语义测绘</span>web-base <span style="font-family: DejaVu Sans;">资源到本地目标。</span>
<h5><a name="active-support"></a>2.2.6 Active Support</h5>
Active Support is an extensive collection of utility classes and standard Ruby library extensions that are used in Rails, both by the core code and by your applications.Active Support<span style="font-family: DejaVu Sans;">是一个广泛收集实用工具类和标准的</span>Ruby<span style="font-family: DejaVu Sans;">库的扩展，它们由的核心代码和您的应用程序（决定）。</span>
<h5><a name="railties"></a>2.2.7 Railties</h5>
Railties is the core Rails code that builds new Rails applications and glues the various frameworks and plugins together in any Rails application.Railties<span style="font-family: DejaVu Sans;">是在</span>Rails<span style="font-family: DejaVu Sans;">代码中创建新</span>Rails<span style="font-family: DejaVu Sans;">应用和在任何</span>Rails<span style="font-family: DejaVu Sans;">应用中粘和各种插件在一起的核心。</span>
<h4><a name="rest"></a>2.3 REST</h4>
Rest stands for Representational State Transfer and is the foundation of the RESTful architecture.Rest<span style="font-family: DejaVu Sans;">作为具有代表性的状态传输是</span>RESTful<span style="font-family: DejaVu Sans;">架构的基础。</span>This is generally considered to be Roy Fielding’s doctoral thesis<span style="font-family: DejaVu Sans;">博士论文</span>, <a href="http://www.ics.uci.edu/%7Efielding/pubs/dissertation/top.htm"><span style="color: #000080;"><span style="text-decoration: underline;">Architectural</span></span><span style="color: #000080;"><span style="text-decoration: underline;">Styles</span></span><span style="color: #000080;"><span style="text-decoration: underline;">and</span></span><span style="color: #000080;"><span style="text-decoration: underline;">the</span></span><span style="color: #000080;"><span style="text-decoration: underline;">Design</span></span><span style="color: #000080;"><span style="text-decoration: underline;">of</span></span><span style="color: #000080;"><span style="text-decoration: underline;">Network-based</span></span><span style="color: #000080;"><span style="text-decoration: underline;">Software</span></span><span style="color: #000080;"><span style="text-decoration: underline;">Architectures</span></span></a>. While you can read through the thesis, REST in terms of Rails boils down to two main principles:<span style="font-family: DejaVu Sans;">当你阅读这篇论文</span>REST<span style="font-family: DejaVu Sans;">在</span>Rails<span style="font-family: DejaVu Sans;">归纳为主要亮点原则：</span>
<ul>
	<li>Using resource identifiers such as URLs to represent resources.<span style="font-family: DejaVu Sans;">使用资源标识符比如</span>URLs<span style="font-family: DejaVu Sans;">去表现资源</span></li>
	<li>Transferring representations of the state of that resource between system components.<span style="font-family: DejaVu Sans;">转移（传送）在系统组件之间代表资源的状态</span></li>
</ul>
For example, the following HTTP request:

<tt>DELETE</tt><tt> </tt><tt>/photos/17</tt>

would be understood to refer to a photo resource with the ID of 17, and to indicate a desired action – deleting that resource. <span style="font-family: DejaVu Sans;">（系统）将会明白参照</span>ID<span style="font-family: DejaVu Sans;">为</span>14<span style="font-family: DejaVu Sans;">的</span>phone<span style="font-family: DejaVu Sans;">资源，注明删除该资源。</span>REST is a natural style for the architecture of web applications, and Rails hooks into this shielding<span style="font-family: DejaVu Sans;">屏蔽</span>you from many of the RESTful complexities and browser quirks.REST<span style="font-family: DejaVu Sans;">自然风格去架构</span>web<span style="font-family: DejaVu Sans;">应用程序，通过组件这样的钩子，使你避免了许多复杂的</span>RESTful<span style="font-family: DejaVu Sans;">和浏览器之间的差异。</span>

If you’d like more details on REST as an architectural#<span style="font-family: DejaVu Sans;">架构风格</span>style, these resources are more approachable<span style="font-family: DejaVu Sans;">平易近人</span>than Fielding’s thesis:
<ul>
	<li><a href="http://www.infoq.com/articles/rest-introduction"><span style="color: #000080;"><span style="text-decoration: underline;">A</span></span><span style="color: #000080;"><span style="text-decoration: underline;">Brief</span></span><span style="color: #000080;"><span style="text-decoration: underline;">Introduction</span></span><span style="color: #000080;"><span style="text-decoration: underline;">to</span></span><span style="color: #000080;"><span style="text-decoration: underline;">REST</span></span></a> by Stefan Tilkov</li>
	<li><a href="http://bitworking.org/news/373/An-Introduction-to-REST"><span style="color: #000080;"><span style="text-decoration: underline;">An</span></span><span style="color: #000080;"><span style="text-decoration: underline;">Introduction</span></span><span style="color: #000080;"><span style="text-decoration: underline;">to</span></span><span style="color: #000080;"><span style="text-decoration: underline;">REST</span></span></a> (video tutorial) by Joe Gregorio</li>
	<li><a href="http://en.wikipedia.org/wiki/Representational_State_Transfer"><span style="color: #000080;"><span style="text-decoration: underline;">Representational</span></span><span style="color: #000080;"><span style="text-decoration: underline;">State</span></span><span style="color: #000080;"><span style="text-decoration: underline;">Transfer</span></span></a> article in Wikipedia</li>
	<li><a href="http://www.infoq.com/articles/webber-rest-workflow"><span style="color: #000080;"><span style="text-decoration: underline;">How</span></span><span style="color: #000080;"><span style="text-decoration: underline;">to</span></span><span style="color: #000080;"><span style="text-decoration: underline;">GET</span></span><span style="color: #000080;"><span style="text-decoration: underline;">a</span></span><span style="color: #000080;"><span style="text-decoration: underline;">Cup</span></span><span style="color: #000080;"><span style="text-decoration: underline;">of</span></span><span style="color: #000080;"><span style="text-decoration: underline;">Coffee</span></span></a> by Jim Webber, Savas Parastatidis &amp; Ian Robinson</li>
</ul>
<h3><a name="creating-a-new-rails-project"></a>3 Creating a New Rails Project</h3>
If you follow this guide, you’ll create a Rails project called <tt>blog</tt>, a (very) simple weblog.<span style="font-family: DejaVu Sans;">如果你跟随这个指导，你将会创建一个叫做</span>blog<span style="font-family: DejaVu Sans;">的</span>Rails<span style="font-family: DejaVu Sans;">项目<span style="font-family: Liberation Serif,Times New Roman,serif;">——</span>一个非常简单的网络博客。</span>Before you can start building the application, you need to make sure that you have Rails itself installed.<span style="font-family: DejaVu Sans;">当你准备开始构建这个项目之前你需要确保</span>Rails<span style="font-family: DejaVu Sans;">已经完全安装。</span>
<h4><a name="installing-rails"></a>3.1 Installing Rails<span style="font-family: WenQuanYi Micro Hei;">安装</span>Rails</h4>
In most cases, the easiest way to install Rails is to take advantage of RubyGems:<span style="font-family: DejaVu Sans;">在大多数情况下，最安装</span>Rails<span style="font-family: DejaVu Sans;">简单的方式是通过方便的</span>RubyGems

<code>Usually</code><code> </code><code>run</code><code> </code><code>this</code><code> </code><code>as</code><code> </code><code>the</code><code> </code><code>root</code><code> </code><code>user:</code>

<code>#</code><code> </code><code>gem</code><code> </code><code>install</code><code> </code><code>rails#</code><span style="font-family: DejaVu Sans;"><code>一般这样安装的</code></span><code>rails</code><span style="font-family: DejaVu Sans;"><code>都是最新的</code></span><code>release</code><span style="font-family: DejaVu Sans;"><code>版本</code></span>

<code>If</code><code> </code><code>you</code><code>’</code><code>re</code><code> </code><code>working</code><code> </code><code>on</code><code> </code><code>Windows,</code><code> </code><code>you</code><code> </code><code>can</code><code> </code><code>quickly</code><code> </code><code>install</code><code> </code><code>Ruby</code><code> </code><code>and</code><code> </code><code>Rails</code><code> </code><code>with</code><code> </code><a href="http://railsinstaller.org/"><span style="color: #000080;"><span style="text-decoration: underline;">Rails</span></span><span style="color: #000080;"><span style="text-decoration: underline;">Installer</span></span></a><code>.</code><span style="font-family: DejaVu Sans;"><code>如果你的工作环境是</code></span><code>Windows</code><span style="font-family: DejaVu Sans;"><code>，你可以通过</code></span><code>Rails</code><code> </code><code>Installer</code><span style="font-family: DejaVu Sans;"><code>快速的安装</code></span><code>Rails</code><span style="font-family: DejaVu Sans;"><code>。</code></span>

<code>/////////////////////////////</code>

<code>###gem</code><code> </code><code>help</code><code> </code><code>commands</code>

<code>➜ </code><code>~</code><code> </code><code>gem</code><code> </code><code>install</code><code> </code><code>rails&amp;&amp;sudo</code><code> </code><code>gem</code><code> </code><code>install</code><code> </code><code>rails</code>

<code>ERROR:</code><code> </code><code>Could</code><code> </code><code>not</code><code> </code><code>find</code><code> </code><code>a</code><code> </code><code>valid</code><code> </code><code>gem</code><code> </code><code>'rails'</code><code> </code><code>(&gt;=</code><code> </code><code>0)</code><code> </code><code>in</code><code> </code><code>any</code><code> </code><code>repository</code>

<code>ERROR:</code><code> </code><code>While</code><code> </code><code>executing</code><code> </code><code>gem</code><code> </code><code>...</code><code> </code><code>(Gem::RemoteFetcher::FetchError)</code>

<code>Errno::ETIMEDOUT:</code><code> </code><code>Connection</code><code> </code><code>timed</code><code> </code><code>out</code><code> </code><code>-</code><code> </code><code>connect(2)</code><code> </code><code>(</code><span style="color: #000080;"><span style="text-decoration: underline;"><a href="http://rubygems.org/latest_specs.4.8.gz">http://rubygems.org/latest_specs.4.8.gz</a></span></span><code>)</code>

<span style="font-family: DejaVu Sans;"><code>经检查和</code></span><code>GFW</code><span style="font-family: DejaVu Sans;"><code>无关，是</code></span><code>rubygems</code><span style="font-family: DejaVu Sans;"><code>的</code></span><code>DNS</code><code> </code><span style="font-family: DejaVu Sans;"><code>调整问题</code></span>

&nbsp;

<span style="font-family: DejaVu Sans;"><code>问题解决的最好方法方法</code></span>

<code>jhjguxin@jhjguxin-virtual-machine:~/blog$</code><code> </code><code>gem</code><code> </code><code>update</code><code> </code><code>--system</code><code> </code>

&nbsp;

<code>ERROR:</code><code> </code><code>gem</code><code> </code><code>update</code><code> </code><code>--system</code><code> </code><code>is</code><code> </code><code>disabled</code><code> </code><code>on</code><code> </code><code>Debian,</code><code> </code><code>because</code><code> </code><code>it</code><code> </code><code>will</code><code> </code><code>overwrite</code><code> </code><code>the</code><code> </code><code>content</code><code> </code><code>of</code><code> </code><code>the</code><code> </code><code>rubygems</code><code> </code><code>Debian</code><code> </code><code>package,</code><code> </code><code>and</code><code> </code><code>might</code><code> </code><code>break</code><code> </code><code>your</code><code> </code><code>Debian</code><code> </code><code>system</code><code> </code><code>in</code><code> </code><code>subtle</code><code> </code><code>ways.</code><code> </code><code>The</code><code> </code><code>Debian-supported</code><code> </code><code>way</code><code> </code><code>to</code><code> </code><code>update</code><code> </code><code>rubygems</code><code> </code><code>is</code><code> </code><code>through</code><code> </code><code>apt-get,</code><code> </code><code>using</code><code> </code><code>Debian</code><code> </code><code>official</code><code> </code><code>repositories.</code>

&nbsp;

<code>If</code><code> </code><code>you</code><code> </code><code>really</code><code> </code><code>know</code><code> </code><code>what</code><code> </code><code>you</code><code> </code><code>are</code><code> </code><code>doing,</code><code> </code><code>you</code><code> </code><code>can</code><code> </code><code>still</code><code> </code><code>update</code><code> </code><code>rubygems</code><code> </code><code>by</code><code> </code><code>setting</code><code> </code><code>the</code><code> </code><code>REALLY_GEM_UPDATE_SYSTEM</code><code> </code><code>environment</code><code> </code><code>variable,</code><code> </code><code>but</code><code> </code><code>please</code><code> </code><code>remember</code><code> </code><code>that</code><code> </code><code>this</code><code> </code><code>is</code><code> </code><code>completely</code><code> </code><code>unsupported</code><code> </code><code>by</code><code> </code><code>Debian.</code>

<code>jhjguxin@jhjguxin-virtual-machine:~/blog$</code><code> </code><code>export</code><code> </code><code>REALLY_GEM_UPDATE_SYSTEM=1</code>

&nbsp;

<code>jhjguxin@jhjguxin-virtual-machine:~/blog$</code><code> </code><code>gem</code><code> </code><code>update</code><code> –</code><code>system</code>

&nbsp;

<code>###</code><span style="font-family: DejaVu Sans;"><code>正是</code></span><code>gem</code><span style="font-family: DejaVu Sans;"><code>出问题了</code><code></code><code>结果直接用</code></span><code>sudo</code><code> </code><code>apt-get</code><code> </code><code>install</code><code> </code><code>rails,</code><span style="font-family: DejaVu Sans;"><code>悲剧了</code></span><code>ubuntu</code><span style="font-family: DejaVu Sans;"><code>现在还是用的</code></span><code>rails2.3</code><span style="font-family: DejaVu Sans;"><code>的包然后导致，后面有些命令无法执行</code></span>
<h4><a name="creating-the-blog-application"></a><code>3.2</code><code> </code><code>Creating</code><code> </code><code>the</code><code> </code><code>Blog</code><code> </code><code>Application</code></h4>
The best way to use this guide is to follow each step as it happens, no code or step needed to make this example application has been left out, so you can literally follow along step by step.<span style="font-family: DejaVu Sans;">学习（使用）本指导的最好方式是跟随这里描述的每一步，不写代码或者没有例子所需的步骤会使得这个例子被冷落，你可以根据文字描述的步骤一步接着一步的操作。</span>If you need to see the completed code, you can download it from <a href="https://github.com/mikel/getting-started-code"><span style="color: #000080;"><span style="text-decoration: underline;">Getting</span></span><span style="color: #000080;"><span style="text-decoration: underline;">Started</span></span><span style="color: #000080;"><span style="text-decoration: underline;">Code</span></span></a>.<span style="font-family: DejaVu Sans;">如果你需要完整的代码你可以从这里下载</span><a href="https://github.com/mikel/getting-started-code"><span style="color: #000080;"><span style="text-decoration: underline;">Getting</span></span><span style="color: #000080;"><span style="text-decoration: underline;">Started</span></span><span style="color: #000080;"><span style="text-decoration: underline;">Code</span></span></a><span style="font-family: DejaVu Sans;">。</span>

To begin, open a terminal, navigate to a folder where you have rights to create files, and type:<span style="font-family: DejaVu Sans;">开始，打开一个</span>terminal,<span style="font-family: DejaVu Sans;">导航至一个你有权限创建文件的文件夹，并输入：</span>

<code>rails</code><code> </code><code>new</code><code> </code><code>blog#--skip-bundle]</code><code> </code><code>#</code><code> </code><code>Don't</code><code> </code><code>run</code><code> </code><code>bundle</code><code> </code><code>install</code><span style="font-family: DejaVu Sans;"><code>这样在国内就不会由于连不上</code></span><code>gem</code><span style="font-family: DejaVu Sans;"><code>即便上能够上也会很慢半天没反映</code></span>

<code>#</code><span style="font-family: DejaVu Sans;"><code>请确保你的</code></span><code>rials</code><code> </code><span style="font-family: DejaVu Sans;"><code>版本是</code></span><code>3.1</code><code> </code><span style="font-family: DejaVu Sans;"><code>不然的话这只能用下面的了</code></span>

<code><span style="color: #800000;">The</span></code><code></code><code><span style="color: #800000;">guides</span></code><code></code><code><span style="color: #800000;">for</span></code><code></code><code><span style="color: #800000;">Rails</span></code><code></code><code><span style="color: #800000;">2.3</span></code><code></code><code><span style="color: #800000;">are</span></code><code></code><code><span style="color: #800000;">still</span></code><code></code><code><span style="color: #800000;">available</span></code><code></code><code><span style="color: #800000;">at</span></code><code></code><span style="color: #000080;"><span style="text-decoration: underline;"><a href="http://guides.rubyonrails.org/v2.3.11/">http://guides.rubyonrails.org/v2.3.11/</a></span></span><code><span style="color: #800000;">.</span></code><code> </code>

<code><em>jhjguxin@jhjguxin-virtual-machine:~$</em></code><code><em> </em></code><code><em>rails</em></code><code><em> </em></code><code><em>new</em></code><code><em> </em></code><code><em>blog#</em></code><span style="font-family: DejaVu Sans;"><code><em>这里建立的文件夹名称为</em></code></span><code><em>new</em></code><span style="font-family: DejaVu Sans;"><code><em>额估计是新版本发生了或者有些地方没弄通（</em></code></span><code><em>ubuntu</em></code><code><em> </em></code><code><em>11.10</em></code><code><em> </em></code><code><em>Rails</em></code><code><em> </em></code><code><em>2.3.14</em></code><code><em> </em></code><code><em>ruby</em></code><code><em> </em></code><code><em>1.8.7</em></code><code><em> </em></code><code><em>(2011-06-30</em></code><code><em> </em></code><code><em>patchlevel</em></code><code><em> </em></code><code><em>352)</em></code><code><em> </em></code><code><em>[i686-linux]</em></code><code><em> </em></code><span style="font-family: DejaVu Sans;"><code><em>）</em></code></span>

<code><em>jhjguxin@jhjguxin-virtual-machine:~$</em></code><code><em> </em></code><code><em>rails</em></code><code><em> </em></code><code><em>blog</em></code>

<code><em>jhjguxin@jhjguxin-Aspire-4750:~$</em></code><code><em> </em></code><code><em>sudo</em></code><code><em> </em></code><code><em>gem</em></code><code><em> </em></code><code><em>install</em></code><code><em> </em></code><code><em>json</em></code><code><em> </em></code><code><em>-v</em></code><code><em> </em></code><code><em>1.6.1</em></code>

<code><em>Invalid</em></code><code><em> </em></code><code><em>gemspec</em></code><code><em> </em></code><code><em>in</em></code><code><em> </em></code><code><em>[/var/lib/gems/1.8/specifications/tilt-1.3.3.gemspec]:</em></code><code><em> </em></code><code><em>invalid</em></code><code><em> </em></code><code><em>date</em></code><code><em> </em></code><code><em>format</em></code><code><em> </em></code><code><em>in</em></code><code><em> </em></code><code><em>specification:</em></code><code><em> </em></code><code><em>"2011-08-25</em></code><code><em> </em></code><code><em>00:00:00.000000000Z"</em></code>

<code><em>Invalid</em></code><code><em> </em></code><code><em>gemspec</em></code><code><em> </em></code><code><em>in</em></code><code><em> </em></code><code><em>[/var/lib/gems/1.8/specifications/json-1.6.1.gemspec]:</em></code><code><em> </em></code><code><em>invalid</em></code><code><em> </em></code><code><em>date</em></code><code><em> </em></code><code><em>format</em></code><code><em> </em></code><code><em>in</em></code><code><em> </em></code><code><em>specification:</em></code><code><em> </em></code><code><em>"2011-09-18</em></code><code><em> </em></code><code><em>00:00:00.000000000Z"</em></code>

<code><em>Invalid</em></code><code><em> </em></code><code><em>gemspec</em></code><code><em> </em></code><code><em>in</em></code><code><em> </em></code><code><em>[/var/lib/gems/1.8/specifications/tilt-1.3.3.gemspec]:</em></code><code><em> </em></code><code><em>invalid</em></code><code><em> </em></code><code><em>date</em></code><code><em> </em></code><code><em>format</em></code><code><em> </em></code><code><em>in</em></code><code><em> </em></code><code><em>specification:</em></code><code><em> </em></code><code><em>"2011-08-25</em></code><code><em> </em></code><code><em>00:00:00.000000000Z"</em></code>

<code><em>Invalid</em></code><code><em> </em></code><code><em>gemspec</em></code><code><em> </em></code><code><em>in</em></code><code><em> </em></code><code><em>[/var/lib/gems/1.8/specifications/json-1.6.1.gemspec]:</em></code><code><em> </em></code><code><em>invalid</em></code><code><em> </em></code><code><em>date</em></code><code><em> </em></code><code><em>format</em></code><code><em> </em></code><code><em>in</em></code><code><em> </em></code><code><em>specification:</em></code><code><em> </em></code><code><em>"2011-09-18</em></code><code><em> </em></code><code><em>00:00:00.000000000Z"</em></code>

<span style="font-family: DejaVu Sans;"><code><em>出现这个问题的时候我</em></code><code><em>是改</em></code><code><span style="color: #000000;"><span style="font-size: small;"><em>成</em></span></span></code><code></code></span><code><span style="color: #000000;"><span style="font-size: small;"><em>s.date</em></span></span></code><code></code><code><span style="color: #000000;"><span style="font-size: small;"><em>=</em></span></span></code><code></code><code><span style="color: #000000;"><span style="font-size: small;"><em>%</em></span></span></code><code><span style="color: #000000;"><span style="font-size: small;"><em>q{2011-09-18}</em></span></span></code>

<span style="font-family: DejaVu Sans;"><code><span style="color: #000000;"><span style="font-size: small;"><em>在</em></span></span></code></span><code><span style="color: #000000;"><span style="font-size: small;"><em>rails</em></span></span></code><code></code><code><span style="color: #000000;"><span style="font-size: small;"><em>3.1</em></span></span></code><span style="font-family: DejaVu Sans;"><code><span style="color: #000000;"><span style="font-size: small;"><em>中由于要创建</em></span></span></code></span><code><span style="color: #000000;"><span style="font-size: small;"><em>bundler</em></span></span></code><code></code><span style="font-family: DejaVu Sans;"><code><span style="color: #000000;"><span style="font-size: small;"><em>信息（</em></span></span></code></span><code><span style="color: #000000;"><span style="font-size: small;"><em>Gemfile</em></span></span></code><span style="font-family: DejaVu Sans;"><code><span style="color: #000000;"><span style="font-size: small;"><em>文件）会提示你安装</em></span></span></code></span><code><span style="color: #000000;"><span style="font-size: small;"><em>sqlite3</em></span></span></code><span style="font-family: DejaVu Sans;"><code><span style="color: #000000;"><span style="font-size: small;"><em>等数据库信息，估计也就是你应用程序所用到的一些必须的</em></span></span></code></span><code><span style="color: #000000;"><span style="font-size: small;"><em>modules</em></span></span></code><span style="font-family: DejaVu Sans;"><code><span style="color: #000000;"><span style="font-size: small;"><em>。</em></span></span></code></span>

<span style="font-family: DejaVu Sans;"><code><span style="color: #000000;"><span style="font-size: small;"><em>这里用的是</em></span></span></code></span><code><span style="color: #000000;"><span style="font-size: small;"><em>sqlite3</em></span></span></code><span style="font-family: DejaVu Sans;"><code><span style="color: #000000;"><span style="font-size: small;"><em>做数据库，提示的是安装的是</em></span></span></code></span><code><span style="color: #000000;"><span style="font-size: small;"><em>sqlite3.</em></span></span></code>

<code><span style="color: #000000;"><span style="font-size: small;"><em>sudo</em></span></span></code><code></code><code><span style="color: #000000;"><span style="font-size: small;"><em>apt-get</em></span></span></code><code></code><code><span style="color: #000000;"><span style="font-size: small;"><em>install</em></span></span></code><code></code><code><span style="color: #000000;"><span style="font-size: small;"><em>sqlite3</em></span></span></code><code></code><code><span style="color: #000000;"><span style="font-size: small;"><em>sqlite3-doc</em></span></span></code><code></code><code><span style="color: #000000;"><span style="font-size: small;"><em>libsqlite3-ruby</em></span></span></code>

<span style="font-family: DejaVu Sans;"><code><span style="color: #000000;"><span style="font-size: small;"><em>还是</em></span></span></code></span><code><span style="color: #000000;"><span style="font-size: small;"><em>ERROR:</em></span></span></code><code></code><code><span style="color: #000000;"><span style="font-size: small;"><em>Failed</em></span></span></code><code></code><code><span style="color: #000000;"><span style="font-size: small;"><em>to</em></span></span></code><code></code><code><span style="color: #000000;"><span style="font-size: small;"><em>build</em></span></span></code><code></code><code><span style="color: #000000;"><span style="font-size: small;"><em>gem</em></span></span></code><code></code><code><span style="color: #000000;"><span style="font-size: small;"><em>native</em></span></span></code><code></code><code><span style="color: #000000;"><span style="font-size: small;"><em>extension.</em></span></span></code><code></code><span style="font-family: DejaVu Sans;"><code><span style="color: #000000;"><span style="font-size: small;"><em>的话</em></span></span></code></span>

<code><span style="color: #000000;"><span style="font-size: small;"><em>sudo</em></span></span></code><code></code><code><span style="color: #000000;"><span style="font-size: small;"><em>apt-get</em></span></span></code><code></code><code><span style="color: #000000;"><span style="font-size: small;"><em>install</em></span></span></code><code></code><code><span style="color: #000000;"><span style="font-size: small;"><em>libxslt1-dev</em></span></span></code><code></code><code><span style="color: #000000;"><span style="font-size: small;"><em>libxml2-dev</em></span></span></code><code></code><code><span style="color: #000000;"><span style="font-size: small;"><em>libxslt-ruby</em></span></span></code><code></code><code><span style="color: #000000;"><span style="font-size: small;"><em>libxslt1.1</em></span></span></code><code></code><code><span style="color: #000000;"><span style="font-size: small;"><em>libxsltc-java-gcj</em></span></span></code><code></code><code><span style="color: #000000;"><span style="font-size: small;"><em>libxslt-ruby</em></span></span></code>

<code></code><code><span style="color: #000000;"><span style="font-size: small;"><em>libxslt1-dbg</em></span></span></code><code></code><code><span style="color: #000000;"><span style="font-size: small;"><em>libxsltc-java</em></span></span></code><code></code><code><span style="color: #000000;"><span style="font-size: small;"><em>ibxslthl-java</em></span></span></code><code></code><code><span style="color: #000000;"><span style="font-size: small;"><em>libxslt-ruby1.8</em></span></span></code>

<code><span style="color: #000000;"><span style="font-size: small;"><em>sudo</em></span></span></code><code></code><code><span style="color: #000000;"><span style="font-size: small;"><em>apt-get</em></span></span></code><code></code><code><span style="color: #000000;"><span style="font-size: small;"><em>install</em></span></span></code><code></code><code><span style="color: #000000;"><span style="font-size: small;"><em>libsqlite3-ruby</em></span></span></code><code></code><code><span style="color: #000000;"><span style="font-size: small;"><em>libsqlite3-dev</em></span></span></code>

<code><span style="color: #000000;"><span style="font-size: small;"><em>sudo</em></span></span></code><code></code><code><span style="color: #000000;"><span style="font-size: small;"><em>gem</em></span></span></code><code></code><code><span style="color: #000000;"><span style="font-size: small;"><em>install</em></span></span></code><code></code><code><span style="color: #000000;"><span style="font-size: small;"><em>therubyracer</em></span></span></code>

<code><span style="color: #000000;"><span style="font-size: small;"><em>####</em></span></span></code><span style="font-family: DejaVu Sans;"><code><span style="color: #000000;"><span style="font-size: small;"><em>对于本地安装的</em></span></span></code></span><code><span style="color: #000000;"><span style="font-size: small;"><em>rails</em></span></span></code><span style="font-family: DejaVu Sans;"><code><span style="color: #000000;"><span style="font-size: small;"><em>（就是爬不出去墙的）</em></span></span></code></span><code><span style="color: #000000;"><span style="font-size: small;"><em>sudo</em></span></span></code><code></code><code><span style="color: #000000;"><span style="font-size: small;"><em>gem</em></span></span></code><code></code><code><span style="color: #000000;"><span style="font-size: small;"><em>install</em></span></span></code><code></code><code><span style="color: #000000;"><span style="font-size: small;"><em>sqlite3-1.3.4.gem</em></span></span></code>

<span style="font-family: DejaVu Sans;"><code><span style="color: #000000;"><span style="font-size: small;"><em>成功了！</em></span></span></code></span>

<code><span style="color: #000000;"><span style="font-size: small;"><em>Your</em></span></span></code><code></code><code><span style="color: #000000;"><span style="font-size: small;"><em>bundle</em></span></span></code><code></code><code><span style="color: #000000;"><span style="font-size: small;"><em>is</em></span></span></code><code></code><code><span style="color: #000000;"><span style="font-size: small;"><em>complete!</em></span></span></code><code></code><code><span style="color: #000000;"><span style="font-size: small;"><em>Use</em></span></span></code><code></code><code><span style="color: #000000;"><span style="font-size: small;"><em>`bundle</em></span></span></code><code></code><code><span style="color: #000000;"><span style="font-size: small;"><em>show</em></span></span></code><code></code><code><span style="color: #000000;"><span style="font-size: small;"><em>[gemname]`</em></span></span></code><code></code><code><span style="color: #000000;"><span style="font-size: small;"><em>to</em></span></span></code><code></code><code><span style="color: #000000;"><span style="font-size: small;"><em>see</em></span></span></code><code></code><code><span style="color: #000000;"><span style="font-size: small;"><em>where</em></span></span></code><code></code><code><span style="color: #000000;"><span style="font-size: small;"><em>a</em></span></span></code><code></code><code><span style="color: #000000;"><span style="font-size: small;"><em>bundled</em></span></span></code><code></code><code><span style="color: #000000;"><span style="font-size: small;"><em>gem</em></span></span></code><code></code><code><span style="color: #000000;"><span style="font-size: small;"><em>is</em></span></span></code><code></code><code><span style="color: #000000;"><span style="font-size: small;"><em>installed.</em></span></span></code>

<code>This</code><code> </code><code>will</code><code> </code><code>create</code><code> </code><code>a</code><code> </code><code>Rails</code><code> </code><code>application</code><code> </code><code>called</code><code> </code><code>Blog</code><code> </code><code>in</code><code> </code><code>a</code><code> </code><code>directory</code><code> </code><code>called</code><code> </code><code>blog.</code><span style="font-family: DejaVu Sans;"><code>这里将创建一个名叫</code></span><code>Blog</code><span style="font-family: DejaVu Sans;"><code>的</code></span><code>Rails</code><span style="font-family: DejaVu Sans;"><code>应用程序在名称为</code></span><code>blog</code><span style="font-family: DejaVu Sans;"><code>的目录中。</code></span>

<code>You</code><code> </code><code>can</code><code> </code><code>see</code><code> </code><code>all</code><code> </code><code>of</code><code> </code><code>the</code><code> </code><code>switches</code><code> </code><code>that</code><code> </code><code>the</code><code> </code><code>Rails</code><code> </code><code>application</code><code> </code><code>builder</code><code> </code><code>accepts</code><code> </code><code>by</code><code> </code><code>running</code><code> </code><tt>rails</tt><tt> </tt><tt>new</tt><tt> </tt><tt>-h</tt><code>.</code><span style="font-family: DejaVu Sans;"><code>你可以通过运行</code></span><code>rails</code><code> </code><code>new</code><code> </code><code>-h</code><span style="font-family: DejaVu Sans;"><code>，查看</code></span><code>rails</code><span style="font-family: DejaVu Sans;"><code>应用程序创建器的所有命令（开关）。</code></span>

<code>After</code><code> </code><code>you</code><code> </code><code>create</code><code> </code><code>the</code><code> </code><code>blog</code><code> </code><code>application,</code><code> </code><code>switch</code><code> </code><code>to</code><code> </code><code>its</code><code> </code><code>folder</code><code> </code><code>to</code><code> </code><code>continue</code><code> </code><code>work</code><code> </code><code>directly</code><code> </code><code>in</code><code> </code><code>that</code><code> </code><code>application:</code><span style="font-family: DejaVu Sans;"><code>当你创建了这个</code></span><code>blog</code><span style="font-family: DejaVu Sans;"><code>程序，跳转到它所在的文件夹中（直接对这个程序编辑）</code></span><code>.</code>

<code>$cd</code><code> </code><code>blog</code>

<code>In</code><code> </code><code>any</code><code> </code><code>case,</code><code> </code><code>Rails</code><code> </code><code>will</code><code> </code><code>create</code><code> </code><code>a</code><code> </code><code>folder</code><code> </code><code>in</code><code> </code><code>your</code><code> </code><code>working</code><code> </code><code>directory</code><code> </code><code>called</code><code> </code><tt>blog</tt><code>.</code><code> </code><span style="font-family: DejaVu Sans;"><code>在任何情况下，</code></span><code>Rails</code><span style="font-family: DejaVu Sans;"><code>将会创建一个名为</code></span><code>blog</code><span style="font-family: DejaVu Sans;"><code>的文件夹在你的工作目录中。</code></span><code>Open</code><code> </code><code>up</code><code> </code><code>that</code><code> </code><code>folder</code><code> </code><code>and</code><code> </code><code>explore</code><code> </code><code>its</code><code> </code><code>contents.</code><span style="font-family: DejaVu Sans;"><code>打开这个文件夹浏览其中的内容。</code><code></code></span><code>Most</code><code> </code><code>of</code><code> </code><code>the</code><code> </code><code>work</code><code> </code><code>in</code><code> </code><code>this</code><code> </code><code>tutorial</code><code> </code><code>will</code><code> </code><code>happen</code><code> </code><code>in</code><code> </code><code>the</code><code> </code><tt>app/</tt><code> </code><code>folder,</code><code> </code><code>but</code><code> </code><code>here</code><code>’</code><code>s</code><code> </code><code>a</code><code> </code><code>basic</code><code> </code><code>rundown#</code><span style="font-family: DejaVu Sans;"><code>概述</code><code></code></span><code>on</code><code> </code><code>the</code><code> </code><code>function</code><code> </code><code>of</code><code> </code><code>each</code><code> </code><code>folder</code><code> </code><code>that</code><code> </code><code>Rails</code><code> </code><code>creates</code><code> </code><code>in</code><code> </code><code>a</code><code> </code><code>new</code><code> </code><code>application</code><code> </code><code>by</code><code> </code><code>default:</code><span style="font-family: DejaVu Sans;"><code>在这个体验中的大多数的工作都是在</code></span><code>app/</code><span style="font-family: DejaVu Sans;"><code>这个文件夹中完成的，这里对</code></span><code>Rails</code><span style="font-family: DejaVu Sans;"><code>创建的新应用中的每一个文件夹的功能做出了一个概述：</code></span>
<table width="665" cellspacing="0" cellpadding="2"><colgroup> <col width="74" /> <col width="583" /> </colgroup>
<tbody>
<tr>
<th width="74">File/Folder</th>
<th width="583">Purpose#<span style="font-family: DejaVu Sans;">目的</span></th>
</tr>
<tr>
<td width="74">Gemfile</td>
<td width="583">This file allows you to specify what gem dependencies are needed for your Rails application. See section on Bundler, below.<span style="font-family: DejaVu Sans;">这个文件让你可以（添加）你的</span>Rails<span style="font-family: DejaVu Sans;">所需要的特殊的</span>gem<span style="font-family: DejaVu Sans;">依赖关系。</span></td>
</tr>
<tr>
<td width="74">README</td>
<td width="583">This is a brief instruction manual#<span style="font-family: DejaVu Sans;">手册</span>for your application. You should edit this file to tell others what your application does, how to set it up, and so on.<span style="font-family: DejaVu Sans;">这是一个简单的说明手册。你需要编辑这个文件告诉其他人你的应用程序可以做什么，怎么安装等等。</span></td>
</tr>
<tr>
<td width="74">Rakefile</td>
<td width="583">This file locates and loads tasks that can be run from the command line. The task definitions are defined throughout the components of Rails. Rather than changing Rakefile, you should add your own tasks by adding files to the lib/tasks directory of your application.<span style="font-family: DejaVu Sans;">这个文件定位和载入能够在命令行中运行的任务。这个应该是域吧（任务定义）贯穿整个</span>Rials<span style="font-family: DejaVu Sans;">的组件定义。除了修改</span>Rakefile<span style="font-family: DejaVu Sans;">，你还需要添加你自己的任务的文件到你的应用程序的</span>lib/tasks<span style="font-family: DejaVu Sans;">目录。</span></td>
</tr>
<tr>
<td width="74">app/</td>
<td width="583">Contains the controllers, models, views and assets for your application. You’ll focus on this folder for the remainder of this guide.<span style="font-family: DejaVu Sans;">包含</span>controllers, models, views<span style="font-family: DejaVu Sans;">和你应用程序的</span>assets<span style="font-family: DejaVu Sans;">（资源），再接下面的手册中你主要的注意力应该放在这里。</span></td>
</tr>
<tr>
<td width="74">config/</td>
<td width="583">Configure your application’s runtime rules, routes, database, and more.<span style="font-family: DejaVu Sans;">配置你的应用程序的运行的规则，（</span>url<span style="font-family: DejaVu Sans;">）路由，数据库和其他。</span></td>
</tr>
<tr>
<td width="74">config.ru</td>
<td width="583">Rack configuration for Rack based servers used to start the application.<span style="font-family: DejaVu Sans;">基于</span>Rack<span style="font-family: DejaVu Sans;">服务器使用这个应用程序的</span>Rack<span style="font-family: DejaVu Sans;">配置</span></td>
</tr>
<tr>
<td width="74">db/</td>
<td width="583">Shows your current database schema, as well as the database migrations. You’ll learn about migrations shortly.<span style="font-family: DejaVu Sans;">显示你当前的数据表，同样也显示数据迁移。你将会简单的了解关于（数据）迁移。</span></td>
</tr>
<tr>
<td width="74">doc/</td>
<td width="583">In-depth documentation for your application.<span style="font-family: DejaVu Sans;">应用程序的（深入）全面的文档。</span></td>
</tr>
<tr>
<td width="74">lib/</td>
<td width="583">Extended modules for your application (not covered in this guide).<span style="font-family: DejaVu Sans;">应用程序用到的扩展库（本手册没有涉及）</span></td>
</tr>
<tr>
<td width="74">log/</td>
<td width="583">Application log files.<span style="font-family: DejaVu Sans;">应用程序的日志文件</span></td>
</tr>
<tr>
<td width="74">public/</td>
<td width="583">The only folder seen to the world as-is. Contains the static files and compiled assets.<span style="font-family: DejaVu Sans;">这是外部可见的唯一文件夹。包含静态文件和编译资源。</span></td>
</tr>
<tr>
<td width="74">script/</td>
<td width="583">Contains the rails script that starts your app and can contain other scripts you use to deploy#<span style="font-family: DejaVu Sans;">部署配置</span>or run your application.<span style="font-family: DejaVu Sans;">包含运行你的</span>app<span style="font-family: DejaVu Sans;">的</span>rails<span style="font-family: DejaVu Sans;">脚本，或者其他用来配置或运行你的应用程序的</span>scripts<span style="font-family: DejaVu Sans;">。</span></td>
</tr>
<tr>
<td width="74">test/</td>
<td width="583">Unit tests, fixtures, and other test apparatus. These are covered in <a href="http://guides.rubyonrails.org/testing.html"><span style="color: #000080;"><span style="text-decoration: underline;">Testing</span></span><span style="color: #000080;"><span style="text-decoration: underline;">Rails</span></span><span style="color: #000080;"><span style="text-decoration: underline;">Applications</span></span></a><span style="font-family: DejaVu Sans;">单元测试，</span>fixtures<span style="font-family: DejaVu Sans;">，或者其他</span>test<span style="font-family: DejaVu Sans;">工具。他们在</span><a href="http://guides.rubyonrails.org/testing.html"><span style="color: #000080;"><span style="text-decoration: underline;">Testing</span></span><span style="color: #000080;"><span style="text-decoration: underline;">Rails</span></span><span style="color: #000080;"><span style="text-decoration: underline;">Applications</span></span></a><span style="font-family: DejaVu Sans;">里面有完整的讲述。</span></td>
</tr>
<tr>
<td width="74">tmp/</td>
<td width="583">Temporary files<span style="font-family: DejaVu Sans;">模板文件</span></td>
</tr>
<tr>
<td width="74">vendor/</td>
<td width="583">A place for all third-party code. In a typical Rails application, this includes Ruby Gems, the Rails source code (if you install it into your project) and plugins containing additional prepackaged functionality.<span style="font-family: DejaVu Sans;">放置第三方代码的地方。在一个典型的</span>Rails<span style="font-family: DejaVu Sans;">应用程序中，这里包含</span>Ruby Gems<span style="font-family: DejaVu Sans;">，</span>Rails<span style="font-family: DejaVu Sans;">源代码（如果你把</span>Rails<span style="font-family: DejaVu Sans;">安装到你的项目中）还包含一些预先包装好的额外的插件</span></td>
</tr>
</tbody>
</table>
<h4><a name="configuring-a-database"></a><code>3.3</code><code> </code><code>Configuring</code><code> </code><code>a</code><code> </code><code>Database</code><span style="font-family: WenQuanYi Micro Hei;"><code>配置数据库</code></span></h4>
Just about every Rails application will interact with a database.<span style="font-family: DejaVu Sans;">基本上每个</span>Rails<span style="font-family: DejaVu Sans;">应用程序都会和一个数据库互动。</span>The database to use is specified in a configuration file, <tt>config/database.yml</tt>.<span style="font-family: DejaVu Sans;">使用的数据库在</span>config/database.yml<span style="font-family: DejaVu Sans;">的配置文件中指定的。</span>If you open this file in a new Rails application, you’ll see a default database configuration using SQLite3. The file contains sections for three different environments in which Rails can run by default:<span style="font-family: DejaVu Sans;">如果你在一个新的</span>Rails<span style="font-family: DejaVu Sans;">应用程序中打开这个文件，你将会看到一个默认的数据库配置使用的是</span>SQLite3.<span style="font-family: DejaVu Sans;">这个文件包含</span>Rails<span style="font-family: DejaVu Sans;">可以默认运行的三个不同的环境会话。</span>
<ul>
	<li>The <tt>development</tt> environment is used on your development computer as you interact manually with the application. <span style="font-family: DejaVu Sans;">开发环境使用在开发计算机上，让你和你的应用程序手动交互</span></li>
	<li>The <tt>test</tt> environment is used to run automated tests. <span style="font-family: DejaVu Sans;">测试环境用于运行自动测试</span></li>
	<li>The <tt>production</tt> environment is used when you deploy your application for the world to use.<span style="font-family: DejaVu Sans;">产品环境在你向外发布过后使用</span></li>
</ul>
<h5><a name="configuring-an-sqlite3-database"></a>3.3.1 Configuring an SQLite3 Database</h5>
Rails comes with built-in support for <span style="color: #000080;"><span style="text-decoration: underline;"><a href="http://www.sqlite.org/">SQLite3</a></span></span>, which is a lightweight serverless database application.Rails<span style="font-family: DejaVu Sans;">内置并支持</span>SQLite3<span style="font-family: DejaVu Sans;">，</span>SQLite3<span style="font-family: DejaVu Sans;">是一个轻量级的数据库服务器。</span>While a busy production environment may overload SQLite, it works well for development and testing.<span style="font-family: DejaVu Sans;">但是一个繁忙的产品环境可能会导致</span>SQLite<span style="font-family: DejaVu Sans;">超载，</span>SQLite3<span style="font-family: DejaVu Sans;">更适合在开发或测试中使用。</span>Rails defaults to using an SQLite database when creating a new project, but you can always change it later.Rails<span style="font-family: DejaVu Sans;">在创建一个新项目的时候默认使用一个</span>SQLite<span style="font-family: DejaVu Sans;">数据库，但是你可以在之后随时更改。</span>

Here’s the section of the default configuration file (<tt>config/database.yml</tt>) with connection information for the development environment:<span style="font-family: DejaVu Sans;">这是在开发环境中配置连接信息的默认配置文件的节选：</span>

<code>development:</code>

<code> </code><code>adapter:</code><code> </code><code>sqlite3</code>

<code> </code><code>database:</code><code> </code><code>db/development.sqlite3</code>

<code> </code><code>pool:</code><code> </code><code>5</code>

<code> </code><code>timeout:</code><code> </code><code>5000</code>

In this guide we are using an SQLite3 database for data storage, because it is a zero configuration database that just works. <span style="font-family: DejaVu Sans;">在这个手册中使用一个</span>SQLite3<span style="font-family: DejaVu Sans;">数据库存存储数据，因为它不需要我们再去配置就能工作。</span>Rails also supports MySQL and PostgreSQL “out of the box”, and has plugins for many database systems.Rails<span style="font-family: DejaVu Sans;">同样支持</span>MySQL<span style="font-family: DejaVu Sans;">和</span>PostgreSQL <span style="font-family: DejaVu Sans;">，它还有许多支持其他数据库系统的插件</span>If you are using a database in a production environment Rails most likely has an adapter for it.<span style="font-family: DejaVu Sans;">如果你在产品环境中使用数据库对</span>Rails<span style="font-family: DejaVu Sans;">来说仅仅是添加一个适配器而已。</span>
<h5><a name="configuring-a-mysql-database"></a>3.3.2 Configuring a MySQL Database<span style="font-family: WenQuanYi Micro Hei;">配置一个</span>MySQL<span style="font-family: WenQuanYi Micro Hei;">数据库</span></h5>
If you choose to use MySQL instead of the shipped SQLite3 database, your <tt>config/database.yml</tt> will look a little different.<span style="font-family: DejaVu Sans;">如果你选择</span>MySQL<span style="font-family: DejaVu Sans;">代替</span>SQLite3<span style="font-family: DejaVu Sans;">数据库，你的配置文件会有一点不同。</span>Here’s the development section:<span style="font-family: DejaVu Sans;">这是开发环境下（的配置）：</span>

<code>development:</code>

<code> </code><code>adapter:</code><code> </code><code>mysql2</code>

<code> </code><code>encoding:</code><code> </code><code>utf8</code>

<code> </code><code>database:</code><code> </code><code>blog_development</code>

<code> </code><code>pool:</code><code> </code><code>5</code>

<code> </code><code>username:</code><code> </code><code>root</code>

<code> </code><code>password:</code>

<code> </code><code>socket:</code><code> </code><code>/tmp/mysql.sock</code>

If your development computer’s MySQL installation includes a root user with an empty password, this configuration should work for you. <span style="font-family: DejaVu Sans;">如果你的开发计算机中安装的</span>MySQL<span style="font-family: DejaVu Sans;">包含一个</span>root<span style="font-family: DejaVu Sans;">用户和空的密码，这个配置文件就可以工作。</span>Otherwise, change the username and password in the <tt>development</tt> section as appropriate.<span style="font-family: DejaVu Sans;">否则，修改合适的开发环境中使用的用户名和密码。</span>
<h5><a name="configuring-a-postgresql-database"></a>3.3.3 Configuring a PostgreSQL Database<span style="font-family: WenQuanYi Micro Hei;">配置一个</span>PostgreSQL<span style="font-family: WenQuanYi Micro Hei;">数据库</span></h5>
If you choose to use PostgreSQL, your <tt>config/database.yml</tt> will be customized to use PostgreSQL databases:

<code>development:</code>

<code> </code><code>adapter:</code><code> </code><code>postgresql</code>

<code> </code><code>encoding:</code><code> </code><code>unicode</code>

<code> </code><code>database:</code><code> </code><code>blog_development</code>

<code> </code><code>pool:</code><code> </code><code>5</code>

<code> </code><code>username:</code><code> </code><code>blog</code>

<code> </code><code>password:</code>
<h5><a name="configuring-an-sqlite3-database-for-jrub"></a> 3.3.4 Configuring an SQLite3 Database for JRuby Platform<span style="font-family: WenQuanYi Micro Hei;">配置在</span>JRuby<span style="font-family: WenQuanYi Micro Hei;">平台中使用的</span>SQLite3<span style="font-family: WenQuanYi Micro Hei;">数据库</span></h5>
If you choose to use SQLite3 and using JRuby, your <tt>config/database.yml</tt> will look a little different. Here’s the development section:

<code>development:</code>

<code> </code><code>adapter:</code><code> </code><code>jdbcsqlite3</code>

<code> </code><code>database:</code><code> </code><code>db/development.sqlite3</code>
<h5><a name="configuring-a-mysql-database-for-jruby-p"></a> 3.3.5 Configuring a MySQL Database for JRuby Platform<span style="font-family: WenQuanYi Micro Hei;">配置在</span>JRuby<span style="font-family: WenQuanYi Micro Hei;">平台中使用的</span>MySQL<span style="font-family: WenQuanYi Micro Hei;">数据库</span></h5>
If you choose to use MySQL and using JRuby, your <tt>config/database.yml</tt> will look a little different. Here’s the development section:

<code>development:</code>

<code> </code><code>adapter:</code><code> </code><code>jdbcmysql</code>

<code> </code><code>database:</code><code> </code><code>blog_development</code>

<code> </code><code>username:</code><code> </code><code>root</code>

<code> </code><code>password:</code>
<h5><a name="configuring-a-postgresql-database-for-jr"></a> 3.3.6 Configuring a PostgreSQL Database for JRuby Platform<span style="font-family: WenQuanYi Micro Hei;">配置在</span>JRuby<span style="font-family: WenQuanYi Micro Hei;">平台中使用的</span>PostgreSQL<span style="font-family: WenQuanYi Micro Hei;">数据库</span></h5>
Finally if you choose to use PostgreSQL and using JRuby, your <tt>config/database.yml</tt> will look a little different. Here’s the development section:

<code>development:</code>

<code> </code><code>adapter:</code><code> </code><code>jdbcpostgresql</code>

<code> </code><code>encoding:</code><code> </code><code>unicode</code>

<code> </code><code>database:</code><code> </code><code>blog_development</code>

<code> </code><code>username:</code><code> </code><code>blog</code>

<code> </code><code>password:</code>

Change the username and password in the <tt>development</tt> section as appropriate.<span style="font-family: DejaVu Sans;">修改在开发会话中使用的合适的用户名和密码</span>

You don’t have to update the database configurations manually. <span style="font-family: DejaVu Sans;">你不是必须手动的配置数据库</span>If you look at the options of the application generator, you will see that one of the options is named <tt>—</tt><tt>database</tt>. <span style="font-family: DejaVu Sans;">如果你查看应用程序产生器，你将会发现一个选项（</span>-d, --database=name Preconfigure for selected database (options: mysql/oracle/postgresql/sqlite2/sqlite3/frontbase/ibm_db).<span style="font-family: DejaVu Sans;">）</span>

This option allows you to choose an adapter from a list of the most used relational databases. You can even run the generator repeatedly: <tt>cd</tt><tt> </tt><tt>..</tt><tt> </tt><tt>&amp;&amp;</tt><tt> </tt><tt>rails</tt><tt> </tt><tt>blog</tt><tt> </tt><tt>--database=mysql</tt>When you confirm<span style="font-family: DejaVu Sans;">确认</span>the overwriting of the <tt>config/database.yml</tt> file, your application will be configured for MySQL instead of SQLite.
<h4><a name="creating-the-database"></a>3.4 Creating the Database<span style="font-family: WenQuanYi Micro Hei;">创建数据库</span></h4>
Now that you have your database configured,it’s time to have Rails create an empty database for you. <span style="font-family: DejaVu Sans;">现在你已经有了你的数据库配置文件了，是时候创建一个空的数据库了。</span>You can do this by running a rake command:

<code>$</code><code> </code><code>rake</code><code> </code><code>db:create</code><code> #</code><span style="font-family: DejaVu Sans;"><code><span style="font-family: Liberation Serif,Times New Roman,serif;">确保你的系统中已经有一个</span></code></span><code>JavaScript runtime.</code><code>#</code><span style="font-family: DejaVu Sans;"><code>可能还需要执行</code></span><code>sudo</code><code> </code><code><span style="font-family: monospace;">gem</span></code><code></code><code><span style="font-family: monospace;">install</span></code><code></code><code><span style="font-family: monospace;">therubyracer</span></code><code></code><code><span style="font-family: monospace;">&amp;&amp;</span></code><code>sudo</code><code> </code><code>gem</code><code> </code><code>install</code><code> </code><code>execjs</code>

jhjguxin@jhjguxin-virtual-machine:~/blog$ rake db:create

rake aborted!

Could not find a JavaScript runtime. See https://github.com/sstephenson/execjs for a list of available runtimes.

<code>one</code><code> </code><code>way:</code>

<span style="font-family: DejaVu Sans;"><code>并且</code></span><code>In</code><code> </code><code>your</code><code> </code><code>Gemfile</code>
<pre>write this

gem 'execjs'

gem 'therubyracer'

and then run

bundle install</pre>
<code> #</code><span style="font-family: DejaVu Sans;"><code>在</code></span><code>ubuntu</code><span style="font-family: DejaVu Sans;"><code>环境中安装</code></span><code>sqlite3</code><span style="font-family: DejaVu Sans;"><code>库</code></span><code><span style="color: #000000;"><span style="font-size: small;"><em><span style="text-decoration: underline;"><strong>sudo</strong></span></em></span></span></code><code></code><code><span style="color: #000000;"><span style="font-size: small;"><em><span style="text-decoration: underline;"><strong>apt-get</strong></span></em></span></span></code><code></code><code><span style="color: #000000;"><span style="font-size: small;"><em><span style="text-decoration: underline;"><strong>install</strong></span></em></span></span></code><code></code><code><span style="color: #000000;"><span style="font-size: small;"><em><span style="text-decoration: underline;"><strong>libsqlite3-ruby</strong></span></em></span></span></code><code></code><code><span style="color: #000000;"><span style="font-size: small;"><em><span style="text-decoration: underline;"><strong>libsqlite3-dev</strong></span></em></span></span></code><code> </code><span style="font-family: DejaVu Sans;"><code>也尝试过使用</code></span><code>gem</code><code> </code><code>install</code><code> </code><code>sqlite3-ruby</code><span style="font-family: DejaVu Sans;"><code>但是网上说是</code></span><code>gem</code><code> </code><code>nds</code><span style="font-family: DejaVu Sans;"><code>有问题</code><code></code><code>安装</code></span><code>ruby</code><span style="font-family: DejaVu Sans;"><code>的</code></span><code> mysql</code><span style="font-family: DejaVu Sans;"><code>库</code></span><code><span style="text-decoration: underline;"><strong>sudo</strong></span></code><code></code><code><span style="text-decoration: underline;"><strong>apt-get</strong></span></code><code></code><code><span style="text-decoration: underline;"><strong>install</strong></span></code><code></code><code><span style="text-decoration: underline;"><strong>libmysql-ruby</strong></span></code>

another way:

<span style="font-family: DejaVu Sans;"><span style="color: #800000;">参照上面的网址：我找了一个</span></span><span style="color: #800000;">ubuntu<span style="font-family: DejaVu Sans;">里面有的</span></span><span style="color: #800000;">Node.js</span><span style="font-family: DejaVu Sans;"><span style="color: #800000;">就可以不用那个</span></span><span style="color: #800000;">therubyracer<span style="font-family: DejaVu Sans;">了</span></span>

jhjguxin@jhjguxin-virtual-machine:~/blog$ rake db:create

This will create your development and test SQLite3 databases inside the <tt>db/</tt> folder.<span style="font-family: DejaVu Sans;">将会在</span>db/<span style="font-family: DejaVu Sans;">文件夹中创建你的开发环境的数据库文件</span>development.sqlite3

Rake is a general-purpose command-runner that Rails uses for many things. You can see the list of available rake commands in your application by running <tt>rake</tt><tt> </tt><tt>-T</tt>.Rake<span style="font-family: DejaVu Sans;">是一个通用的命令行可以帮助</span>Rails<span style="font-family: DejaVu Sans;">用户完成很多事情。你可以通过运行</span><tt>rake</tt><tt> </tt><tt>-T</tt><tt> </tt><span style="font-family: DejaVu Sans;">查看可用的</span>rake<span style="font-family: DejaVu Sans;">命令</span>

ruby script/server#<span style="font-family: DejaVu Sans;">或者</span>script/server
<h3><a name="hello-rails"></a>4 Hello, Rails!</h3>
One of the traditional places to start with a new language is by getting some text up on screen quickly. To do this, you need to get your Rails application server running.<span style="font-family: DejaVu Sans;">传统的方式之一，开始使用一种新的（命令）语法并得到快速掠过的文字。要得到这样的结果你需要使你的</span>Rails<span style="font-family: DejaVu Sans;">程序运行。</span>

<code>$</code><code> </code><code>rails</code><code> </code><code>server</code><code> </code><code>#-----rails2.3.1</code><code> </code>$ ruby script/server#

This will fire up an instance of the WEBrick web server by default (Rails can also use several other web servers). <span style="font-family: DejaVu Sans;">这里默认将开启一个</span>WEBrick<span style="font-family: DejaVu Sans;">服务器的的实例（</span>Rails<span style="font-family: DejaVu Sans;">也可能使用一些其他的</span>web<span style="font-family: DejaVu Sans;">服务器）。</span>To see your application in action, open a browser window and navigate to <span style="color: #000080;"><span style="text-decoration: underline;"><a href="http://localhost:3000/">http://localhost:3000</a></span></span>. You should see Rails’ default information page:<span style="font-family: DejaVu Sans;">查看你的应用程序的行为，打开一个浏览器并且导航到</span>127.0.0.0<span style="font-family: DejaVu Sans;">：</span>3000<span style="font-family: DejaVu Sans;">你将会看到一个</span>Rails<span style="font-family: DejaVu Sans;">默认的信息页面。</span>

To stop the web server, hit Ctrl+C in the terminal window where it’s running. In development mode, Rails does not generally require you to stop the server; changes you make in files will be automatically picked up by the server.<span style="font-family: DejaVu Sans;">要终止</span>web<span style="font-family: DejaVu Sans;">服务，在命令运行的终端中按下</span>Ctrl+C<span style="font-family: DejaVu Sans;">。在开发环境模式中，</span>Rails<span style="font-family: DejaVu Sans;">一般不需要你停止服务；你所做的更改将自动的编译进需要的文件中并且重启服务。</span>

The “Welcome Aboard#<span style="font-family: DejaVu Sans;">船<span style="font-family: Liberation Serif,Times New Roman,serif;">” </span></span>page is the <em>smoke</em><em> </em><em>test</em> for a new Rails application: it makes sure that you have your software configured correctly enough to serve a page.<span style="font-family: DejaVu Sans;">这个欢迎界面体现了一个新的</span>Rails<span style="font-family: DejaVu Sans;">应用程序创建成功（通过了</span>Rails<span style="font-family: DejaVu Sans;">的自检）。</span>You can also click on the <em>About</em><em> </em><em>your</em><em> </em><em>application</em><em>’</em><em>s</em><em> </em><em>environment</em> link to see a summary of your application’s environment.<span style="font-family: DejaVu Sans;">你可以点击<span style="font-family: Liberation Serif,Times New Roman,serif;">‘ </span></span><em>About</em><em> </em><em>your</em><em> </em><em>application</em><em>’</em><em>s</em><em> </em><em>environment</em>’<span style="font-family: DejaVu Sans;">查看你的应用程序运行环境摘要信息。</span>
<h4><a name="say-hello-rails"></a>4.2 Say “Hello”, Rails</h4>
To get Rails saying “Hello”, you need to create at minimum a controller and a view.<span style="font-family: DejaVu Sans;">要使</span>Rails<span style="font-family: DejaVu Sans;">说出（显示）<span style="font-family: Liberation Serif,Times New Roman,serif;">“</span>你好<span style="font-family: Liberation Serif,Times New Roman,serif;">”</span>，你还需要创建一个最小的</span>a controller and a view<span style="font-family: DejaVu Sans;">。</span>Fortunately, you can do that in a single command. Enter this command in your terminal:<span style="font-family: DejaVu Sans;">幸运的是，你可以完成这些通过一行命令。在终端中输入：</span>
<code>rails</code><code> </code><code>generate</code><code> </code><code>controller</code><code> </code><code>home</code><code> </code><code>index</code><code> </code>##rails2.3.1 <code><span style="color: #000000;"><span style="font-size: small;">script/generate</span></span></code><code></code><code><span style="color: #000000;"><span style="font-size: small;">controller</span></span></code><code></code><code><span style="color: #000000;"><span style="font-size: small;">home</span></span></code><code></code><code><span style="color: #000000;"><span style="font-size: small;">index##</span></span></code>

If you get a command not found error when running this command, you need to explicitly pass Rails <tt>rails</tt> commands to Ruby: <tt><em>ruby</em></tt><tt><em> </em></tt><tt><em>\path\to\your\application\script\rails</em></tt><tt><em> </em></tt><tt><em>generate</em></tt><tt><em> </em></tt><tt><em>controller</em></tt><tt><em> </em></tt><tt><em>home</em></tt><tt><em> </em></tt><tt><em>index</em></tt><em>.</em><span style="font-family: DejaVu Sans;"><em>如果你在输入这个命令的时候出现没有这个命令错误，你需要明确的使用</em></span><em>ruby</em><span style="font-family: DejaVu Sans;"><em>来执行</em></span><em>Rails</em><span style="font-family: DejaVu Sans;"><em>命令。</em><span style="color: #800000;"><em>这里就没有</em></span></span><span style="color: #800000;"><em>rails</em><span style="font-family: DejaVu Sans;"><em>这个文件</em></span><span style="color: #800000;"><em>应该是</em></span></span><span style="color: #800000;"><em>ruby</em></span><span style="color: #800000;"><em>script/generate</em></span><span style="color: #800000;"><em>controller</em></span><span style="color: #800000;"><em>home</em></span><span style="color: #800000;"><em>index</em></span>

Rails will create several files for you, including <tt>app/views/home/index.html.erb</tt>. Rails<span style="font-family: DejaVu Sans;">将会为你创建一些文件，包含<span style="font-family: Liberation Serif,Times New Roman,serif;">‘</span></span><tt>app/views/home/index.html.erb</tt>’<span style="font-family: DejaVu Sans;">。</span>This is the template that will be used to display the results of the <tt>index</tt> action (method) in the <tt>home</tt> controller.<span style="font-family: DejaVu Sans;">这个模板会用来显示在</span><tt>home</tt> controller<span style="font-family: DejaVu Sans;">中的</span><tt>index</tt> action (method)<span style="font-family: DejaVu Sans;">的结果。</span>Open this file in your text editor and edit it to contain a single line of code:<span style="font-family: DejaVu Sans;">在文本编辑器中打开这个文件并输入：</span>

<code>&lt;h1&gt;Hello,</code><code> </code><code>Rails!&lt;/h1&gt;</code><code> </code>
<h4><a name="setting-the-application-home-page"></a>4.3 Setting the Application Home Page</h4>
Now that we have made the controller and view, we need to tell Rails when we want “Hello Rails” to show up. <span style="font-family: DejaVu Sans;">现在我们已经创建了</span>controller <span style="font-family: DejaVu Sans;">和</span>view<span style="font-family: DejaVu Sans;">，我们还需要告诉</span>Rails<span style="font-family: DejaVu Sans;">我们想在什么时候显示出来。</span>In our case, we want it to show up when we navigate to the root URL of our site, <span style="color: #000080;"><span style="text-decoration: underline;"><a href="http://localhost:3000/">http://localhost:3000</a></span></span>, instead of the “Welcome Aboard” smoke test.<span style="font-family: DejaVu Sans;">在本例中，我们想让它在我们导航至站点</span>url<span style="font-family: DejaVu Sans;">根目录的时候替代<span style="font-family: Liberation Serif,Times New Roman,serif;">“</span></span>Welcome Aboard”<span style="font-family: DejaVu Sans;">显示。</span>

The first step to doing this is to delete the default page from your application:<span style="font-family: DejaVu Sans;">首先移除应用程序中的默认页面。</span>

<code>rm</code><code> </code><code>public/index.html</code>

We need to do this as Rails will deliver#<span style="font-family: DejaVu Sans;">提供，传输</span>any static file in the <tt>public</tt> directory in preference#<span style="font-family: DejaVu Sans;">偏好优先</span>to any dynamic#<span style="font-family: DejaVu Sans;">动态</span>content we generate from the controllers.<span style="font-family: DejaVu Sans;">我们必须这样做因为，</span>Rails<span style="font-family: DejaVu Sans;">将会传送任何在</span>public<span style="font-family: DejaVu Sans;">的静态文件优先于我们在</span>controllers<span style="font-family: DejaVu Sans;">生成的动态（显示）内容。</span>

Now, you have to tell Rails where your actual home page is located.Open the file <tt>config/routes.rb</tt> in your editor. This is your application’s <em>routing</em><em> </em><em>file</em> which holds entries in a special DSL (domain-specific language) that tells Rails how to connect incoming requests to controllers and actions. This file contains many sample routes on commented lines, and one of them actually shows you how to connect the root of your site to a specific controller and action. Find the line beginning with <tt>root</tt><tt> </tt><tt>:to</tt>, uncomment it and change it like the following:<span style="font-family: DejaVu Sans;">现在你还必须告诉</span>Rails <span style="font-family: DejaVu Sans;">你实际上的主页在哪里。在文本编辑器中打开</span><tt>config/routes.rb</tt> <span style="font-family: DejaVu Sans;">。这是你应用程序的路由文件，它采用</span>DSL<span style="font-family: DejaVu Sans;">语言囊括了告诉</span>Rails<span style="font-family: DejaVu Sans;">怎样连接请求信息到</span>controllers and actions.<span style="font-family: DejaVu Sans;">的所有条目。</span>

<span style="font-family: DejaVu Sans;">这个文件包含许多简单的路由命令，其中一条实际上是用于告诉我们怎样连接你站点根目录到一个指定的</span>controller and acti<span style="font-family: DejaVu Sans;">。找到以</span>root :to<span style="font-family: DejaVu Sans;">开头的那一行，注释掉它改成如下内容：</span>

<code>Blog::Application.routes.draw</code><code> </code><code>do</code>

&nbsp;

<code> </code><code>get</code><code> </code><code>"home/index"</code>

&nbsp;

<code> </code><code>root</code><code> </code><code>:to</code><code> </code><code>=&gt;</code><code> </code><code>"home#index"</code>

<code>//////////////////this</code><code> </code><code>depend</code><code> </code><code>on</code><code> </code><code>rails</code><code> </code><code>2.3.1/////////</code>

<code>Blog::Application.routes.draw</code><code> </code><code>do</code>

&nbsp;

<code> </code><code>#...</code>

<code> </code><code>#</code><code> </code><code>You</code><code> </code><code>can</code><code> </code><code>have</code><code> </code><code>the</code><code> </code><code>root</code><code> </code><code>of</code><code> </code><code>your</code><code> </code><code>site</code><code> </code><code>routed</code><code> </code><code>with</code><code> </code><code>"root"</code>

<code> </code><code>#</code><code> </code><code>just</code><code> </code><code>remember</code><code> </code><code>to</code><code> </code><code>delete</code><code> </code><code>public/index.html.</code>

<code> </code><code>map.root</code><code> </code><code>:controller</code><code> </code><code>=&gt;</code><code> </code><code>"home"</code><code> </code>

<code>or</code>

<code> </code><code>map.root</code><code> </code><code>:controller</code><code> </code><code>=&gt;</code><code> </code><code>"home",:action</code><code> </code><code>=&gt;</code><code> </code><code>'index'</code>

<code> </code><code>##root</code><code> </code><code>:to</code> <code>=&gt;</code><code> </code><code>"home#index"</code>

The <tt>root</tt><tt> </tt><tt>:to</tt><tt> </tt><tt>=&gt;</tt><tt> </tt><tt>"home#index"</tt> tells Rails to map the root action to the home controller’s index action.

<span style="color: #800000;">ps</span><span style="color: #800000;">-ef|grep</span><span style="color: #800000;">webrick</span>

<span style="color: #800000;">kill</span><span style="color: #800000;">-9</span><span style="font-family: DejaVu Sans;"><span style="color: #800000;">上面得到的</span></span><span style="color: #800000;">id</span><span style="font-family: DejaVu Sans;"><span style="color: #800000;">强制结束</span></span><span style="color: #800000;">WEBrick<span style="font-family: DejaVu Sans;">服务</span></span>

Now if you navigate to <span style="color: #000080;"><span style="text-decoration: underline;"><a href="http://localhost:3000/">http://localhost:3000</a></span></span> in your browser, you’ll see <tt>Hello,</tt><tt> </tt><tt>Rails!</tt>.<span style="font-family: DejaVu Sans;">现在你在浏览器中导航至</span><span style="color: #000080;"><span style="text-decoration: underline;"><a href="http://localhost:3000/">http://localhost:3000</a></span></span> <span style="font-family: DejaVu Sans;">，你将会看到<span style="font-family: Liberation Serif,Times New Roman,serif;">“</span></span><tt>Hello,</tt><tt> </tt><tt>Rails!</tt>”.

For more information about routing, refer to <a href="http://guides.rubyonrails.org/routing.html"><span style="color: #000080;"><span style="text-decoration: underline;">Rails</span></span><span style="color: #000080;"><span style="text-decoration: underline;">Routing</span></span><span style="color: #000080;"><span style="text-decoration: underline;">from</span></span><span style="color: #000080;"><span style="text-decoration: underline;">the</span></span><span style="color: #000080;"><span style="text-decoration: underline;">Outside</span></span><span style="color: #000080;"><span style="text-decoration: underline;">In</span></span></a>.<span style="font-family: DejaVu Sans;">更多的信息请参见</span><a href="http://guides.rubyonrails.org/routing.html"><span style="color: #000080;"><span style="text-decoration: underline;">Rails</span></span><span style="color: #000080;"><span style="text-decoration: underline;">Routing</span></span><span style="color: #000080;"><span style="text-decoration: underline;">from</span></span><span style="color: #000080;"><span style="text-decoration: underline;">the</span></span><span style="color: #000080;"><span style="text-decoration: underline;">Outside</span></span><span style="color: #000080;"><span style="text-decoration: underline;">In</span></span></a><span style="font-family: DejaVu Sans;">。</span>
<h3><a name="getting-up-and-running-quickly-with-scaf"></a> 5 Getting Up and Running Quickly with Scaffolding<span style="font-family: WenQuanYi Micro Hei;">使用</span>Scaffolding<span style="font-family: WenQuanYi Micro Hei;">快速创建并运行</span></h3>
Rails <em>scaffolding</em> is a quick way to generate some of the major pieces of an application. Rails <em>scaffolding<span style="font-family: DejaVu Sans;">是一个快速的方法产生应用程序的一些主要的部分。</span></em>If you want to create the models, views, and controllers for a new resource in a single operation, scaffolding is the tool for the job.<span style="font-family: DejaVu Sans;">如果你想使用一种简单的操作为新资源创建</span>models,views<span style="font-family: DejaVu Sans;">和</span>controllers<span style="font-family: DejaVu Sans;">，</span>Scaffolding<span style="font-family: DejaVu Sans;">是一个不错的工具。</span>
<h3><a name="creating-a-resource"></a>6 Creating a Resource<span style="font-family: WenQuanYi Micro Hei;">创建一个资源</span></h3>
In the case of the blog application, you can start by generating a scaffolded Post resource: this will represent#<span style="font-family: DejaVu Sans;">代表，表现表示</span>a single blog posting. To do this, enter this command in your terminal:<span style="font-family: DejaVu Sans;">在本示例中的</span>blog<span style="font-family: DejaVu Sans;">应用程序，你可以使用</span>scaffolded<span style="font-family: DejaVu Sans;">产生</span>post<span style="font-family: DejaVu Sans;">资源：它表现为一个简单的</span>blog posting<span style="font-family: DejaVu Sans;">。要完成这些，在终端输入如下命令：</span>

<code>$</code><code> </code><code>rails</code><code> </code><code>generate</code><code> </code><code>scaffold</code><code> </code><code>Post</code><code> </code><code>name:string</code><code> </code><code>title:string</code><code> </code><code>content:text</code>

##rails 2.3.1 script/generate scaffold Post name:string title:string content:text

The scaffold generator will build several files in your application, along with some folders, and edit <tt>config/routes.rb</tt>. Here’s a quick overview of what it creates:scaffold<span style="font-family: DejaVu Sans;">创建器将会在应用程序中的一些文件夹中生成一些文件，并且还会编辑</span><tt>config/routes.rb</tt><span style="font-family: DejaVu Sans;"><tt>。下面这些产生的文件的大概说明：</tt></span>
<table width="665" cellspacing="0" cellpadding="2"><colgroup> <col width="231" /> <col width="426" /> </colgroup>
<tbody>
<tr>
<th width="231">File</th>
<th width="426">Purpose</th>
</tr>
<tr>
<td width="231">db/migrate/20100207214725_create_posts.rb</td>
<td width="426">Migration to create the posts table in your database (your name will include a different timestamp)<span style="font-family: DejaVu Sans;">将创建的</span>posts<span style="font-family: DejaVu Sans;">表单迁移到你的数据库（会在你的命名前面加上时间）</span></td>
</tr>
<tr>
<td width="231">app/models/post.rb</td>
<td width="426">The Post model Post<span style="font-family: DejaVu Sans;">模型</span></td>
</tr>
<tr>
<td width="231">test/fixtures/posts.yml</td>
<td width="426">Dummy posts for use in testing <span style="font-family: DejaVu Sans;">模拟测试</span>post</td>
</tr>
<tr>
<td width="231">app/controllers/posts_controller.rb</td>
<td width="426">The Posts controller</td>
</tr>
<tr>
<td width="231">app/views/posts/index.html.erb</td>
<td width="426">A view to display an index of all posts <span style="font-family: DejaVu Sans;">显示所有</span>post</td>
</tr>
<tr>
<td width="231">app/views/posts/edit.html.erb</td>
<td width="426">A view to edit an existing post<span style="font-family: DejaVu Sans;">编辑</span>post</td>
</tr>
<tr>
<td width="231">app/views/posts/show.html.erb</td>
<td width="426">A view to display a single post<span style="font-family: DejaVu Sans;">显示一条</span>post</td>
</tr>
<tr>
<td width="231">app/views/posts/new.html.erb</td>
<td width="426">A view to create a new post<span style="font-family: DejaVu Sans;">创建</span>post</td>
</tr>
<tr>
<td width="231">app/views/posts/_form.html.erb</td>
<td width="426">A partial to control the overall look and feel of the form used in edit and new views<span style="font-family: DejaVu Sans;">一个用于控制编辑和创建新视图的整体视效表</span></td>
</tr>
<tr>
<td width="231">app/helpers/posts_helper.rb</td>
<td width="426">Helper functions to be used from the post views<span style="font-family: DejaVu Sans;">使用</span>post<span style="font-family: DejaVu Sans;">的帮助功能</span>views</td>
</tr>
<tr>
<td width="231">app/assets/stylesheets/scaffolds.css.scss</td>
<td width="426">Cascading style sheet#<span style="font-family: DejaVu Sans;">层叠样式</span>to make the scaffolded views look better #css<span style="font-family: DejaVu Sans;">使</span>scaffolded<span style="font-family: DejaVu Sans;">视图具有更好的效果</span></td>
</tr>
<tr>
<td width="231">app/assets/stylesheets/posts.css.scss</td>
<td width="426">Cascading style sheet for the posts controller#post controller<span style="font-family: DejaVu Sans;">的</span>css<span style="font-family: DejaVu Sans;">效果</span></td>
</tr>
<tr>
<td width="231">app/assets/javascripts/posts.js.coffee</td>
<td width="426">CoffeeScript for the posts controller</td>
</tr>
<tr>
<td width="231">test/unit/post_test.rb</td>
<td width="426">Unit testing harness#<span style="font-family: DejaVu Sans;">利用</span>for the posts model post models<span style="font-family: DejaVu Sans;">的</span>Unit<span style="font-family: DejaVu Sans;">测试</span></td>
</tr>
<tr>
<td width="231">test/functional/posts_controller_test.rb</td>
<td width="426">Functional testing harness for the posts controller post controller<span style="font-family: DejaVu Sans;">的功能测试</span></td>
</tr>
<tr>
<td width="231">test/unit/helpers/posts_helper_test.rb</td>
<td width="426">Unit testing harness for the posts helper post helper<span style="font-family: DejaVu Sans;">的</span>Uint <span style="font-family: DejaVu Sans;">测试</span></td>
</tr>
<tr>
<td width="231">config/routes.rb</td>
<td width="426">Edited to include routing information for posts <span style="font-family: DejaVu Sans;">加入</span>posts <span style="font-family: DejaVu Sans;">路由信息</span></td>
</tr>
</tbody>
</table>
<tt>While</tt><tt> </tt><tt>scaffolding</tt><tt> </tt><tt>will</tt><tt> </tt><tt>get</tt><tt> </tt><tt>you</tt><tt> </tt><tt>up</tt><tt> </tt><tt>and</tt><tt> </tt><tt>running</tt><tt> </tt><tt>quickly,</tt><tt> </tt><tt>the</tt><tt> </tt><tt>code</tt><tt> </tt><tt>it</tt><tt> </tt><tt>generates</tt><tt> </tt><tt>is</tt><tt> </tt><tt>unlikely</tt><tt> </tt><tt>to</tt><tt> </tt><tt>be</tt><tt> </tt><tt>a</tt><tt> </tt><tt>perfect</tt><tt> </tt><tt>fit</tt><tt> </tt><tt>for</tt><tt> </tt><tt>your</tt><tt> </tt><tt>application.</tt><span style="font-family: DejaVu Sans;"><tt>即便是</tt></span><tt>scaffolding</tt><span style="font-family: DejaVu Sans;"><tt>使你创建和运行非常快捷，但是产生的代码不可能完美的适合你的应用程序。</tt><tt></tt></span><tt>You</tt><tt>’</tt><tt>ll</tt><tt> </tt><tt>most</tt><tt> </tt><tt>probably</tt><tt> </tt><tt>want</tt><tt> </tt><tt>to</tt><tt> </tt><tt>customize</tt><tt> </tt><tt>the</tt><tt> </tt><tt>generated</tt><tt> </tt><tt>code.</tt><span style="font-family: DejaVu Sans;"><tt>你大多数都需要定制产生的代码。</tt><tt></tt></span><tt>Many</tt><tt> </tt><tt>experienced</tt><tt> </tt><tt>Rails</tt><tt> </tt><tt>developers</tt><tt> </tt><tt>avoid</tt><tt> </tt><tt>scaffolding</tt><tt> </tt><tt>entirely,</tt><tt> </tt><tt>preferring</tt><tt> </tt><tt>to</tt><tt> </tt><tt>write</tt><tt> </tt><tt>all</tt><tt> </tt><tt>or</tt><tt> </tt><tt>most</tt><tt> </tt><tt>of</tt><tt> </tt><tt>their</tt><tt> </tt><tt>source</tt><tt> </tt><tt>code</tt><tt> </tt><tt>from</tt><tt> </tt><tt>scratch.</tt><tt> </tt><span style="font-family: DejaVu Sans;"><tt>很多有经验的</tt></span><tt>Rails</tt><span style="font-family: DejaVu Sans;"><tt>开发人员完全不使用</tt></span><tt>scaffolding</tt><span style="font-family: DejaVu Sans;"><tt>，宁愿从头编写全部的代码。</tt></span><tt>Rails,</tt><tt> </tt><tt>however,</tt><tt> </tt><tt>makes</tt><tt> </tt><tt>it</tt><tt> </tt><tt>really</tt><tt> </tt><tt>simple</tt><tt> </tt><tt>to</tt><tt> </tt><tt>customize</tt><tt> </tt><tt>templates</tt><tt> </tt><tt>for</tt><tt> </tt><tt>generated</tt><tt> </tt><tt>models,</tt><tt> </tt><tt>controllers,</tt><tt> </tt><tt>views</tt><tt> </tt><tt>and</tt><tt> </tt><tt>other</tt><tt> </tt><tt>source</tt><tt> </tt><tt>files.Rails</tt><span style="font-family: DejaVu Sans;"><tt>，无论如何，使得为生成的</tt></span><tt>models</tt><span style="font-family: DejaVu Sans;"><tt>，</tt></span><tt>controllers</tt><span style="font-family: DejaVu Sans;"><tt>，</tt></span><tt>views</tt><span style="font-family: DejaVu Sans;"><tt>或者其他代码编定制模板非常简单。</tt><tt></tt></span><tt>You</tt><tt>’</tt><tt>ll</tt><tt> </tt><tt>find</tt><tt> </tt><tt>more</tt><tt> </tt><tt>information</tt><tt> </tt><tt>in</tt><tt> </tt><tt>the</tt><tt> </tt><a href="http://guides.rubyonrails.org/generators.html"><span style="color: #000080;"><span style="text-decoration: underline;">Creating</span></span><span style="color: #000080;"><span style="text-decoration: underline;">and</span></span><span style="color: #000080;"><span style="text-decoration: underline;">Customizing</span></span><span style="color: #000080;"><span style="text-decoration: underline;">Rails</span></span><span style="color: #000080;"><span style="text-decoration: underline;">Generators</span></span><span style="color: #000080;"><span style="text-decoration: underline;">&amp;</span></span><span style="color: #000080;"><span style="text-decoration: underline;">Templates</span></span></a><tt> </tt><tt>guide.</tt><span style="font-family: DejaVu Sans;"><tt>你可以在</tt><tt></tt></span><a href="http://guides.rubyonrails.org/generators.html"><span style="color: #000080;"><span style="text-decoration: underline;">Creating</span></span><span style="color: #000080;"><span style="text-decoration: underline;">and</span></span><span style="color: #000080;"><span style="text-decoration: underline;">Customizing</span></span><span style="color: #000080;"><span style="text-decoration: underline;">Rails</span></span><span style="color: #000080;"><span style="text-decoration: underline;">Generators</span></span><span style="color: #000080;"><span style="text-decoration: underline;">&amp;</span></span><span style="color: #000080;"><span style="text-decoration: underline;">Templates</span></span></a><span style="font-family: DejaVu Sans;"><tt>看到更多信息。</tt></span>
<h4><a name="running-a-migration"></a><tt>6.1</tt><tt> </tt><tt>Running</tt><tt> </tt><tt>a</tt><tt> </tt><tt>Migration</tt></h4>
One of the products of the <tt>rails</tt><tt> </tt><tt>generate</tt><tt> </tt><tt>scaffold</tt> command is a <em>database</em><em> </em><em>migration</em>. Migrations are Ruby classes that are designed to make it simple to create and modify database tables. Rails uses rake commands to run migrations, and it’s possible to undo a migration after it’s been applied to your database. Migration filenames include a timestamp to ensure that they’re processed#<span style="font-family: DejaVu Sans;">处理</span>in the order that they were created.script/generate scaffold<span style="font-family: DejaVu Sans;">的一个产品就是数据迁移。</span>Migrations<span style="font-family: DejaVu Sans;">是一个</span>ruby<span style="font-family: DejaVu Sans;">类被设计用来使数据库表单的创建和修改变得简单。</span>Rails<span style="font-family: DejaVu Sans;">使用</span>rake<span style="font-family: DejaVu Sans;">命令来执行迁移，它还可以撤销已经应用的修改。</span>Migration filenames include a timestamp<span style="font-family: DejaVu Sans;">确保了迁移能够完成。</span>

If you look in the <tt>db/migrate/20100207214725_create_posts.rb</tt> file (remember, yours will have a slightly different name<span style="font-family: DejaVu Sans;">记住，你得到的可能会有略微不同</span>), here’s what you’ll find:

<code>class</code><tt> </tt><code>CreatePosts</code><code> </code><code>&lt;</code><code> </code><code>ActiveRecord::Migration</code>

<code> </code><code>def</code> <code>change</code>

<code> </code><code>create_table</code><code> </code><code>:posts</code> <code>do</code> <code>|t|</code>

<code> </code><code>t.string</code><code> </code><code>:name</code>

<code> </code><code>t.string</code><code> </code><code>:title</code>

<code> </code><code>t.text</code><code> </code><code>:content</code>

&nbsp;

<code> </code><code>t.timestamps</code>

<code> </code><code>end</code>

<code> </code><code>end</code>

<code>end</code>

<tt>The</tt><tt> </tt><tt>above</tt><tt> </tt><tt>migration</tt><tt> </tt><tt>creates</tt><tt> </tt><tt>a</tt><tt> </tt><tt>method</tt><tt> </tt><tt>name</tt><tt> </tt><tt>change</tt><tt> </tt><tt>which</tt><tt> </tt><tt>will</tt><tt> </tt><tt>be</tt><tt> </tt><tt>called</tt><tt> </tt><tt>when</tt><tt> </tt><tt>you</tt><tt> </tt><tt>run</tt><tt> </tt><tt>this</tt><tt> </tt><tt>migration.</tt><span style="font-family: DejaVu Sans;"><tt>整个</tt></span><tt>migration</tt><span style="font-family: DejaVu Sans;"><tt>创建了一个名叫</tt></span><tt>change</tt><span style="font-family: DejaVu Sans;"><tt>的方法，该方法在你运行这个</tt></span><tt>migration</tt><span style="font-family: DejaVu Sans;"><tt>的时候被调用。</tt><tt></tt></span><tt>The</tt><tt> </tt><tt>action</tt><tt> </tt><tt>defined</tt><tt> </tt><tt>in</tt><tt> </tt><tt>that</tt><tt> </tt><tt>method</tt><tt> </tt><tt>is</tt><tt> </tt><tt>also</tt><tt> </tt><tt>reversible#</tt><span style="font-family: DejaVu Sans;"><tt>可逆</tt></span><tt>,</tt><tt> </tt><tt>which</tt><tt> </tt><tt>means</tt><tt> </tt><tt>Rails</tt><tt> </tt><tt>knows</tt><tt> </tt><tt>how</tt><tt> </tt><tt>to</tt><tt> </tt><tt>reverse</tt><tt> </tt><tt>the</tt><tt> </tt><tt>change</tt><tt> </tt><tt>made</tt><tt> </tt><tt>by</tt><tt> </tt><tt>this</tt><tt> </tt><tt>migration,</tt><tt> </tt><tt>in</tt><tt> </tt><tt>case</tt><tt> </tt><tt>you</tt><tt> </tt><tt>want</tt><tt> </tt><tt>to</tt><tt> </tt><tt>reverse</tt><tt> </tt><tt>it</tt><tt> </tt><tt>at</tt><tt> </tt><tt>later</tt><tt> </tt><tt>date.</tt><span style="font-family: DejaVu Sans;"><tt>这个方法中定义的行为也是可逆的，那就是说</tt></span><tt>Rails</tt><span style="font-family: DejaVu Sans;"><tt>知道怎样逆向改变这个</tt></span><tt>migration</tt><span style="font-family: DejaVu Sans;"><tt>，如果你需要恢复到上一次数据。</tt><tt></tt></span><tt>By</tt><tt> </tt><tt>default,</tt><tt> </tt><tt>when</tt><tt> </tt><tt>you</tt><tt> </tt><tt>run</tt><tt> </tt><tt>this</tt><tt> </tt><tt>migration</tt><tt> </tt><tt>it</tt><tt> </tt><tt>will</tt><tt> </tt><tt>creates</tt><tt> </tt><tt>a</tt><tt> </tt><tt>posts</tt><tt> </tt><tt>table</tt><tt> </tt><tt>with</tt><tt> </tt><tt>two</tt><tt> </tt><tt>string</tt><tt> </tt><tt>columns</tt><tt> </tt><tt>and</tt><tt> </tt><tt>a</tt><tt> </tt><tt>text</tt><tt> </tt><tt>column.</tt><tt> </tt><span style="font-family: DejaVu Sans;"><tt>默认情况下，当你运行这个</tt></span><tt>migration</tt><span style="font-family: DejaVu Sans;"><tt>，他将会创建一个包含两个字符串列和一个</tt></span><tt>text</tt><span style="font-family: DejaVu Sans;"><tt>列的表单。</tt></span><tt>It</tt><tt> </tt><tt>also</tt><tt> </tt><tt>creates</tt><tt> </tt><tt>two</tt><tt> </tt><tt>timestamp</tt><tt> </tt><tt>fields</tt><tt> </tt><tt>to</tt><tt> </tt><tt>track</tt><tt> </tt><tt>record</tt><tt> </tt><tt>creation</tt><tt> </tt><tt>and</tt><tt> </tt><tt>updating.</tt><tt> </tt><tt>More</tt><tt> </tt><tt>information</tt><tt> </tt><tt>about</tt><tt> </tt><tt>Rails</tt><tt> </tt><tt>migrations</tt><tt> </tt><tt>can</tt><tt> </tt><tt>be</tt><tt> </tt><tt>found</tt><tt> </tt><tt>in</tt><tt> </tt><tt>the</tt><tt> </tt><a href="http://guides.rubyonrails.org/migrations.html"><span style="color: #000080;"><span style="text-decoration: underline;">Rails</span></span><span style="color: #000080;"><span style="text-decoration: underline;">Database</span></span><span style="color: #000080;"><span style="text-decoration: underline;">Migrations</span></span></a><tt> </tt><tt>guide.</tt><span style="font-family: DejaVu Sans;"><tt>关于</tt></span><tt>Rails</tt><tt> </tt><tt>migration</tt><span style="font-family: DejaVu Sans;"><tt>的更多信息请阅读</tt><tt></tt></span><a href="http://guides.rubyonrails.org/migrations.html"><span style="color: #000080;"><span style="text-decoration: underline;">Rails</span></span><span style="color: #000080;"><span style="text-decoration: underline;">Database</span></span><span style="color: #000080;"><span style="text-decoration: underline;">Migrations</span></span></a><span style="font-family: DejaVu Sans;"><tt>手册。</tt></span>

<tt>At</tt><tt> </tt><tt>this</tt><tt> </tt><tt>point,</tt><tt> </tt><tt>you</tt><tt> </tt><tt>can</tt><tt> </tt><tt>use</tt><tt> </tt><tt>a</tt><tt> </tt><tt>rake</tt><tt> </tt><tt>command</tt><tt> </tt><tt>to</tt><tt> </tt><tt>run</tt><tt> </tt><tt>the</tt><tt> </tt><tt>migration:</tt><span style="font-family: DejaVu Sans;"><tt>这个时候，你可以使用</tt></span><tt>rake</tt><span style="font-family: DejaVu Sans;"><tt>命令运行</tt></span><tt>migration</tt><span style="font-family: DejaVu Sans;"><tt>了：</tt></span>

<code>rake</code><code> </code><code>db:migrate</code>

<code>Rails</code><code> </code><code>will</code><code> </code><code>execute</code><code> </code><code>this</code><code> </code><code>migration</code><code> </code><code>command</code><code> </code><code>and</code><code> </code><code>tell</code><code> </code><code>you</code><code> </code><code>it</code><code> </code><code>created</code><code> </code><code>the</code><code> </code><code>Posts</code><code> </code><code>table.Rails</code><span style="font-family: DejaVu Sans;"><code>将会执行这个</code></span><code>migration</code><span style="font-family: DejaVu Sans;"><code>命令并且通知你它创建了</code></span><code>Post</code><span style="font-family: DejaVu Sans;"><code>表单。</code></span>

<code>==</code><code> </code><code>CreatePosts:</code><code> </code><code>migrating</code><code> </code><code>====================================================</code>

<code>--</code><code> </code><code>create_table(:posts)</code>

<code> </code><code>-&gt;</code><code> </code><code>0.0030s</code>

<code>==</code><code> </code><code>CreatePosts:</code><code> </code><code>migrated</code><code> </code><code>(0.0032s)</code><code> </code><code>===========================================</code>

<code>Because</code><code> </code><code>you</code><code>’</code><code>re</code><code> </code><code>working</code><code> </code><code>in</code><code> </code><code>the</code><code> </code><code>development</code><code> </code><code>environment</code><code> </code><code>by</code><code> </code><code>default,</code><code> </code><code>this</code><code> </code><code>command</code><code> </code><code>will</code><code> </code><code>apply</code><code> </code><code>to</code><code> </code><code>the</code><code> </code><code>database</code><code> </code><code>defined</code><code> </code><code>in</code><code> </code><code>the</code><code> </code><tt>development</tt><code> </code><code>section</code><code> </code><code>of</code><code> </code><code>your</code><code> </code><tt>config/database.yml</tt><code> </code><code>file.</code><code> </code><code>If</code><code> </code><code>you</code><code> </code><code>would</code><code> </code><code>like</code><code> </code><code>to</code><code> </code><code>execute</code><code> </code><code>migrations</code><code> </code><code>in</code><code> </code><code>other</code><code> </code><code>environment,</code><code> </code><code>for</code><code> </code><code>instance</code><code> </code><code>in</code><code> </code><code>production,</code><code> </code><code>you</code><code> </code><code>must</code><code> </code><code>explicitly</code><code> </code><code>pass</code><code> </code><code>it</code><code> </code><code>when</code><code> </code><code>invoking</code><code> </code><code>the</code><code> </code><code>command:</code><code> </code><tt>rake</tt><tt> </tt><tt>db:migrate</tt><tt> </tt><tt>RAILS_ENV=production</tt><code>.</code><span style="font-family: DejaVu Sans;"><code>由于你默认工作在开发环境中，这个命令将会应用于开发环境会话的数据库位于你的</code></span><tt>config/database.yml</tt><tt> </tt><span style="font-family: DejaVu Sans;"><code>中。如果你想执行</code></span><code>migration</code><span style="font-family: DejaVu Sans;"><code>在其他环境中，比如以产品（环境）为实例，你必须明确调用的通过命令行中执行：</code></span><code>rake</code><code> </code><code>db:migrate</code><code> </code><code>RAILS_ENV=production</code><span style="font-family: DejaVu Sans;"><code>。</code></span>
<h4><a name="adding-a-link"></a><code>6.2</code><code> </code><code>Adding</code><code> </code><code>a</code><code> </code><code>Link</code><span style="font-family: WenQuanYi Micro Hei;"><code>添加要给</code></span><code>link</code><span style="font-family: WenQuanYi Micro Hei;"><code>（到</code></span><code>blog</code><span style="font-family: WenQuanYi Micro Hei;"><code>）</code></span></h4>
To hook the posts up to the home page you’ve already created, you can add a link to the home page.<span style="font-family: DejaVu Sans;">把你已经创建好的</span>post<span style="font-family: DejaVu Sans;">挂到主页上，你可以通过添加一个</span>link<span style="font-family: DejaVu Sans;">到主页。</span>Open <tt>app/views/home/index.html.erb</tt> and modify it as follows:<span style="font-family: DejaVu Sans;">打开</span><tt>app/views/home/index.html.erb</tt><span style="font-family: DejaVu Sans;"><tt>并且按照下面所示更改：</tt></span>

<code>&lt;h1&gt;Hello,</code><code> </code><code>Rails!&lt;/h1&gt;</code>

<code>&lt;%=</code><code> </code><code>link_to</code><code> </code><code>"My</code><code> </code><code>Blog",</code><code> </code><code>posts_path</code><code> </code><code>%&gt;</code>

<tt>The</tt><tt> </tt><tt>link_to</tt><tt> </tt><tt>method</tt><tt> </tt><tt>is</tt><tt> </tt><tt>one</tt><tt> </tt><tt>of</tt><tt> </tt><tt>Rails</tt><tt>’ </tt><tt>built-in</tt><tt> </tt><tt>view</tt><tt> </tt><tt>helpers.</tt><span style="font-family: DejaVu Sans;"><tt>这个链接方法是</tt></span><tt>Rails</tt><span style="font-family: DejaVu Sans;"><tt>在</tt><tt></tt></span><tt>view</tt><tt> </tt><tt>helpers</tt><tt> </tt><span style="font-family: DejaVu Sans;"><tt>的内建方法之一</tt><tt></tt><tt>。</tt></span><tt>It</tt><tt> </tt><tt>creates</tt><tt> </tt><tt>a</tt><tt> </tt><tt>hyperlink</tt><tt> </tt><tt>based</tt><tt> </tt><tt>on</tt><tt> </tt><tt>text</tt><tt> </tt><tt>to</tt><tt> </tt><tt>display</tt><tt> </tt><tt>and</tt><tt> </tt><tt>where</tt><tt> </tt><tt>to</tt><tt> </tt><tt>go</tt><tt> – </tt><tt>in</tt><tt> </tt><tt>this</tt><tt> </tt><tt>case,</tt><tt> </tt><tt>to</tt><tt> </tt><tt>the</tt><tt> </tt><tt>path</tt><tt> </tt><tt>for</tt><tt> </tt><tt>posts.</tt><span style="font-family: DejaVu Sans;"><tt>它创建一个基于文字的超级链接并显示到哪里，在这个实例中（跳转）到</tt></span><tt>posts</tt><span style="font-family: DejaVu Sans;"><tt>。</tt></span>
<h4><a name="working-with-posts-in-the-browser"></a><tt>6.3</tt><tt> </tt><tt>Working</tt><tt> </tt><tt>with</tt><tt> </tt><tt>Posts</tt><tt> </tt><tt>in</tt><tt> </tt><tt>the</tt><tt> </tt><tt>Browser</tt></h4>
Now you’re ready to start working with posts. To do that, navigate to <span style="color: #000080;"><span style="text-decoration: underline;"><a href="http://localhost:3000/">http://localhost:3000</a></span></span> and then click the “My Blog” link:<span style="font-family: DejaVu Sans;">现在你已经准备好在</span>posts<span style="font-family: DejaVu Sans;">中工作了。导航至</span><span style="color: #000080;"><span style="text-decoration: underline;"><a href="http://localhost:3000/">http://localhost:3000</a></span></span><span style="font-family: DejaVu Sans;">，并且点击<span style="font-family: Liberation Serif,Times New Roman,serif;">“</span></span>My Blog”<span style="font-family: DejaVu Sans;">链接。</span>

<code>This</code><code> </code><code>is</code><code> </code><code>the</code><code> </code><code>result</code><code> </code><code>of</code><code> </code><code>Rails</code><code> </code><code>rendering</code><code> </code><code>the</code><code> </code><tt>index</tt><code> </code><code>view</code><code> </code><code>of</code><code> </code><code>your</code><code> </code><code>posts.</code><span style="font-family: DejaVu Sans;"><code>这就是</code></span><code>Rails</code><span style="font-family: DejaVu Sans;"><code>渲染你的</code></span><code>posts</code><span style="font-family: DejaVu Sans;"><code>视图的结果。</code><code></code></span><code>There</code><code> </code><code>aren</code><code>’</code><code>t</code><code> </code><code>currently</code><code> </code><code>any</code><code> </code><code>posts</code><code> </code><code>in</code><code> </code><code>the</code><code> </code><code>database,</code><code> </code><code>but</code><code> </code><code>if</code><code> </code><code>you</code><code> </code><code>click</code><code> </code><code>the</code><code> </code><tt>New</tt><tt> </tt><tt>Post</tt><code> </code><code>link</code><code> </code><code>you</code><code> </code><code>can</code><code> </code><code>create</code><code> </code><code>one.</code><span style="font-family: DejaVu Sans;"><code>在你点击</code><code><span style="font-family: Liberation Serif,Times New Roman,serif;">“</span></code></span><code>New</code><code> </code><code>Post</code><code>”</code><span style="font-family: DejaVu Sans;"><code>链接并创建一个新的</code></span><code>post</code><span style="font-family: DejaVu Sans;"><code>之前，数据库里面是没有任何</code></span><code>post</code><span style="font-family: DejaVu Sans;"><code>的。</code><code></code></span><code>After</code><code> </code><code>that,</code><code> </code><code>you</code><code>’</code><code>ll</code><code> </code><code>find</code><code> </code><code>that</code><code> </code><code>you</code><code> </code><code>can</code><code> </code><code>edit</code><code> </code><code>posts,</code><code> </code><code>look</code><code> </code><code>at</code><code> </code><code>their</code><code> </code><code>details,</code><code> </code><code>or</code><code> </code><code>destroy</code><code> </code><code>them.</code><code> </code><span style="font-family: DejaVu Sans;"><code>随后你可以编辑，查看详细内容，或者删除他们。</code></span><code>All</code><code> </code><code>of</code><code> </code><code>the</code><code> </code><code>logic</code><code> </code><code>and</code><code> </code><code>HTML</code><code> </code><code>to</code><code> </code><code>handle</code><code> </code><code>this</code><code> </code><code>was</code><code> </code><code>built</code><code> </code><code>by</code><code> </code><code>the</code><code> </code><code>single</code><code> </code><tt>rails</tt><tt> </tt><tt>generate</tt><tt> </tt><tt>scaffold</tt><code> </code><code>command.post</code><span style="font-family: DejaVu Sans;"><code>的所有的</code></span><code>logic</code><span style="font-family: DejaVu Sans;"><code>和</code></span><code>HTML</code><span style="font-family: DejaVu Sans;"><code>都是通过</code></span><tt><em>rails</em></tt><tt><em> </em></tt><tt><em>generate</em></tt><tt><em> </em></tt><tt><em>scaffold</em></tt><tt><em> </em></tt><span style="font-family: DejaVu Sans;"><code>生成的。</code></span>

<code>In</code><code> </code><code>development</code><code> </code><code>mode</code><code> </code><code>(which</code><code> </code><code>is</code><code> </code><code>what</code><code> </code><code>you</code><code>’</code><code>re</code><code> </code><code>working</code><code> </code><code>in</code><code> </code><code>by</code><code> </code><code>default),</code><code> </code><code>Rails</code><code> </code><code>reloads</code><code> </code><code>your</code><code> </code><code>application</code><code> </code><code>with</code><code> </code><code>every</code><code> </code><code>browser</code><code> </code><code>request,</code><code> </code><code>so</code><code> </code><code>there</code><code>’</code><code>s</code><code> </code><code>no</code><code> </code><code>need</code><code> </code><code>to</code><code> </code><code>stop</code><code> </code><code>and</code><code> </code><code>restart</code><code> </code><code>the</code><code> </code><code>web</code><code> </code><code>server.</code><span style="font-family: DejaVu Sans;"><code>在开发模式中（你的默认工作模式），</code></span><code>Rails</code><span style="font-family: DejaVu Sans;"><code>会在每个浏览器请求的时候重新载入你的应用程序，因此你不需要停止或者重启</code></span><code>web</code><span style="font-family: DejaVu Sans;"><code>服务。</code></span>

<code>Congratulations,</code><code> </code><code>you</code><code>’</code><code>re</code><code> </code><code>riding</code><code> </code><code>the</code><code> </code><code>rails!</code><code> </code><code>Now</code><code> </code><code>it</code><code>’</code><code>s</code><code> </code><code>time</code><code> </code><code>to</code><code> </code><code>see</code><code> </code><code>how</code><code> </code><code>it</code><code> </code><code>all</code><code> </code><code>works.</code><span style="font-family: DejaVu Sans;"><code>恭喜，你已经驯服了</code></span><code>rails</code><span style="font-family: DejaVu Sans;"><code>！现在是时候去看看它的所有工作了。</code></span>
<h4><a name="the-model"></a><code>6.4</code><code> </code><code>The</code><code> </code><code>Model</code></h4>
The model file, <tt>app/models/post.rb</tt> is about as simple as it can get:

<code>class</code><code> </code><code>Post</code><code> </code><code>&lt;</code><code> </code><code>ActiveRecord::Base</code>

<code>end</code>

<code>There</code><code> </code><code>isn</code><code>’</code><code>t</code><code> </code><code>much</code><code> </code><code>to</code><code> </code><code>this</code><code> </code><code>file</code><code> – </code><code>but</code><code> </code><code>note</code><code> </code><code>that</code><code> </code><code>the</code><code> </code><tt>Post</tt><code> </code><code>class</code><code> </code><code>inherits</code><code> </code><code>from</code><code> </code><tt>ActiveRecord::Base</tt><code>.</code><span style="font-family: DejaVu Sans;"><code>这里有可能不一致</code><code><span style="font-family: Liberation Serif,Times New Roman,serif;">——</span></code><code>但是切记</code></span><code>Post</code><span style="font-family: DejaVu Sans;"><code>类继承于</code><code></code></span><tt>ActiveRecord::Base</tt><span style="font-family: DejaVu Sans;"><tt>。</tt><code></code></span><code>Active</code><code> </code><code>Record</code><code> </code><code>supplies</code><code> </code><code>a</code><code> </code><code>great</code><code> </code><code>deal</code><code> </code><code>of</code><code> </code><code>functionality</code><code> </code><code>to</code><code> </code><code>your</code><code> </code><code>Rails</code><code> </code><code>models</code><code> </code><code>for</code><code> </code><code>free,</code><code> </code><code>including</code><code> </code><code>basic</code><code> </code><code>database</code><code> </code><code>CRUD</code><code> </code><code>(Create,</code><code> </code><code>Read,</code><code> </code><code>Update,</code><code> </code><code>Destroy)</code><code> </code><code>operations,</code><code> </code><code>data</code><code> </code><code>validation,</code><code> </code><code>as</code><code> </code><code>well</code><code> </code><code>as</code><code> </code><code>sophisticated#</code><span style="font-family: DejaVu Sans;"><code>复杂</code><code></code></span><code>search</code><code> </code><code>support</code><code> </code><code>and</code><code> </code><code>the</code><code> </code><code>ability</code><code> </code><code>to</code><code> </code><code>relate</code><code> </code><code>multiple</code><code> </code><code>models</code><code> </code><code>to</code><code> </code><code>one</code><code> </code><code>another.</code><code> </code><code>Active</code><code> </code><code>Record</code><span style="font-family: DejaVu Sans;"><code>免费为你的</code></span><code>models</code><span style="font-family: DejaVu Sans;"><code>提供了强大的功能，包括基本数据库的</code></span><code>CRUD</code><span style="font-family: DejaVu Sans;"><code>（创建，读取，更新，删除）操作，数据验证，以及复杂的的查询与其它数据表单多关联的字段的支持能力。</code></span>
<h4><a name="adding-some-validation"></a><code>6.5</code><code> </code><code>Adding</code><code> </code><code>Some</code><code> </code><code>Validation</code><span style="font-family: WenQuanYi Micro Hei;"><code>添加一些验证</code></span></h4>
Rails includes methods to help you validate the data that you send to models. Rails<span style="font-family: DejaVu Sans;">包含一些帮助你验证发送到</span>models<span style="font-family: DejaVu Sans;">的数据的方法。</span>Open the <tt>app/models/post.rb</tt> file and edit it:<span style="font-family: DejaVu Sans;">打开</span><tt>app/models/post.rb</tt><span style="font-family: DejaVu Sans;"><tt>并编辑：</tt></span>

class Post &lt; ActiveRecord::Base

validates :name, :presence =&gt; true

validates :title, :presence =&gt; true,

:length =&gt; { :minimum =&gt; 5 }

end

These changes will ensure that all posts have a name and a title, and that the title is at least five characters long. <span style="font-family: DejaVu Sans;">这些更改会确保所有的</span>post<span style="font-family: DejaVu Sans;">都有一个</span>name<span style="font-family: DejaVu Sans;">和</span>titile<span style="font-family: DejaVu Sans;">并且</span>title<span style="font-family: DejaVu Sans;">长度至少五个字符。</span>Rails can validate a variety of<span style="font-family: DejaVu Sans;">各种，很多</span>conditions#<span style="font-family: DejaVu Sans;">名词（字段）</span>in a model, including the presence or uniqueness<span style="font-family: DejaVu Sans;">独特</span>of columns, their format, and the existence of associated<span style="font-family: DejaVu Sans;">相关</span>objects. Rails<span style="font-family: DejaVu Sans;">可以验证很多种字段，比如字段能否为空和独特性，字段的格式，以及字段的关联。</span>
<h4><a name="using-the-console"></a>6.6 Using the Console</h4>
To see your validations in action, you can use the console.<span style="font-family: DejaVu Sans;">要想在</span>action<span style="font-family: DejaVu Sans;">里面查看你的验证你可以使用</span>console<span style="font-family: DejaVu Sans;">。</span>The console is a command-line tool that lets you execute#<span style="font-family: DejaVu Sans;">执行运行</span>Ruby code in the context of your application:console<span style="font-family: DejaVu Sans;">是一个可以让你在你的应用程序的上下文中执行</span>Ruby<span style="font-family: DejaVu Sans;">代码的命令行工具：</span>

<code>$</code><code> </code><code>rails</code><code> </code><code>console</code>

<code>The</code><code> </code><code>default</code><code> </code><code>console</code><code> </code><code>will</code><code> </code><code>make</code><code> </code><code>changes</code><code> </code><code>to</code><code> </code><code>your</code><code> </code><code>database.</code><span style="font-family: DejaVu Sans;"><code>默认的</code></span><code>console</code><span style="font-family: DejaVu Sans;"><code>将会改变你的数据库。</code><code></code></span><code>You</code><code> </code><code>can</code><code> </code><code>instead</code><code> </code><code>open</code><code> </code><code>a</code><code> </code><code>console</code><code> </code><code>that</code><code> </code><code>will</code><code> </code><code>roll</code><code> </code><code>back</code><code> </code><code>any</code><code> </code><code>changes</code><code> </code><code>you</code><code> </code><code>make</code><code> </code><code>by</code><code> </code><code>using</code><code> </code>rails console --sandbox<code>.</code><span style="font-family: DejaVu Sans;"><code>你可以通过运行</code></span><code>rails</code><code> </code><code>console</code><code> –</code><code>sandbox</code><code> </code><code>or</code><code> </code><code>rails</code><code> </code><code>console</code><code> </code><code>-s,</code><span style="font-family: DejaVu Sans;"><code>这样你可以回滚你的任何操作。</code></span>

jhjguxin@jhjguxin-Aspire-4750:~/blog$ rails console -s

Loading development environment in sandbox (Rails 3.1.1)

Any modifications you make will be rolled back on exit

irb(main):001:0&gt; p=Post.new(:content=&gt;"A new post to test console")

=&gt; #&lt;Post id: nil, name: nil, title: nil, content: "A new post to test console", created_at: nil, updated_at: nil&gt;

irb(main):002:0&gt; p.save

(0.2ms) SAVEPOINT active_record_1

(0.1ms) ROLLBACK TO SAVEPOINT active_record_1

=&gt; false

irb(main):003:0&gt; p.errors

=&gt; #&lt;ActiveModel::Errors:0xb6765d48 @base=#&lt;Post id: nil, name: nil, title: nil, content: "A new post to test console", created_at: nil, updated_at: nil&gt;, @messages=#&lt;OrderedHash {:title=&gt;["is too short (minimum is 5 characters)", "can't be blank"], :name=&gt;["can't be blank"]}&gt;&gt;

This code shows creating a new <tt>Post</tt> instance, attempting to save it and getting <tt>false</tt> for a return value (indicating that the save failed), and inspecting the <tt>errors</tt> of the post.<span style="font-family: DejaVu Sans;">这段代码演示了创建一个</span>Post<span style="font-family: DejaVu Sans;">实例，并企图保存到数据库并得到一个失败的返回值（说明保存失败的原因），检查</span>post<span style="font-family: DejaVu Sans;">的错误信息。</span>

When you’re finished, type <tt>exit</tt> and hit <tt>return</tt> to exit the console.<span style="font-family: DejaVu Sans;">当你操作完成，输入</span>exit<span style="font-family: DejaVu Sans;">并回车退出</span>console<span style="font-family: DejaVu Sans;">。</span>

Unlike the development web server, the console does not automatically load your code afresh for each line.<span style="font-family: DejaVu Sans;">不像开发环境的</span>web<span style="font-family: DejaVu Sans;">服务器</span>console<span style="font-family: DejaVu Sans;">不会自动导入你每行输入的新的代码。</span>If you make changes to your models while the console is open, type <tt>reload!</tt> at the console prompt to load them.<span style="font-family: DejaVu Sans;">如果你改变了你的</span>moels<span style="font-family: DejaVu Sans;">并且</span>console<span style="font-family: DejaVu Sans;">是打开的，输入</span>reload!<span style="font-family: DejaVu Sans;">那么</span>console<span style="font-family: DejaVu Sans;">会立即导入他们。</span>

jhjguxin@jhjguxin-Aspire-4750:~/blog$ rails console

Loading development environment (Rails 3.1.1)

irb(main):001:0&gt; p=Post.new(:title=&gt;"test console",:name=&gt;"jhjguxin",:content=&gt;"A new post to test console")

=&gt; #&lt;Post id: nil, name: "jhjguxin", title: "test console", content: "A new post to test console", created_at: nil, updated_at: nil&gt;

irb(main):002:0&gt; p.save

SQL (13.4ms) INSERT INTO "posts" ("content", "created_at", "name", "title", "updated_at") VALUES (?, ?, ?, ?, ?) [["content", "A new post to test console"], ["created_at", Sat, 05 Nov 2011 15:55:17 UTC +00:00], ["name", "jhjguxin"], ["title", "test console"], ["updated_at", Sat, 05 Nov 2011 15:55:17 UTC +00:00]]

=&gt; true

irb(main):003:0&gt; reload!

Reloading...

=&gt; true

#########<span style="font-family: DejaVu Sans;">如果是</span>rails console --sandbox could not reload! Successfully.
<h4><a name="listing-all-posts"></a>6.7 Listing All Posts</h4>
The easiest place to start looking at functionality is with the code that lists all posts. <span style="font-family: DejaVu Sans;">寻找所有功能的地方是使用代码列出所有的</span>post<span style="font-family: DejaVu Sans;">。</span>Open the file <tt>app/controllers/posts_controller.rb</tt> and look at the <tt>index</tt> action:<span style="font-family: DejaVu Sans;">打开文件</span><tt>app/controllers/posts_controller.rb</tt><span style="font-family: DejaVu Sans;"><tt>，并且查看</tt></span><tt>index</tt><tt> </tt><tt>action</tt><span style="font-family: DejaVu Sans;"><tt>：</tt></span>

<code>def</code> <code>index</code>

<code> </code><code>@posts</code> <code>=</code><code> </code><code>Post.all</code>

&nbsp;

<code> </code><code>respond_to</code><code> </code><code>do</code> <code>|format|</code>

<code> </code><code>format.html</code><code> </code><code>#</code><code> </code><code>index.html.erb</code>

<code> </code><code>format.json</code><code> </code><code>{</code><code> </code><code>render</code><code> </code><code>:json</code> <code>=&gt;</code><code> </code><code>@posts</code> <code>}</code>

<code> </code><code>end</code>

<code>end</code>

<tt>Post.all</tt> calls the <tt>Post</tt> model to return all of the posts currently in the database. Post.all<span style="font-family: DejaVu Sans;">调用</span>Post model<span style="font-family: DejaVu Sans;">并返回当前在数据库中的所有</span>post<span style="font-family: DejaVu Sans;">。</span>The result of this call is an array of posts that we store in an instance variable called <tt>@posts</tt>.<span style="font-family: DejaVu Sans;">本次调用的结果是一个</span>post<span style="font-family: DejaVu Sans;">的数组，并且我们将这个数组存储在一个叫做</span>@posts<span style="font-family: DejaVu Sans;">的实例变量中。</span>

For more information on finding records with Active Record, see <a href="http://guides.rubyonrails.org/active_record_querying.html"><span style="color: #000080;"><span style="text-decoration: underline;">Active</span></span><span style="color: #000080;"><span style="text-decoration: underline;">Record</span></span><span style="color: #000080;"><span style="text-decoration: underline;">Query</span></span><span style="color: #000080;"><span style="text-decoration: underline;">Interface</span></span></a>.<span style="font-family: DejaVu Sans;">查找有关</span>Active Record<span style="font-family: DejaVu Sans;">更多的信息，可以查看</span><a href="http://guides.rubyonrails.org/active_record_querying.html"><span style="color: #000080;"><span style="text-decoration: underline;">Active</span></span><span style="color: #000080;"><span style="text-decoration: underline;">Record</span></span><span style="color: #000080;"><span style="text-decoration: underline;">Query</span></span><span style="color: #000080;"><span style="text-decoration: underline;">Interface</span></span></a><span style="font-family: DejaVu Sans;">相关记录。</span>

The <tt>respond_to</tt> block handles both HTML and JSON calls to this action.<span style="font-family: DejaVu Sans;">这个</span>respond_to<span style="font-family: DejaVu Sans;">块处理了这个动作的</span>HTML<span style="font-family: DejaVu Sans;">和</span>JSON<span style="font-family: DejaVu Sans;">请求。</span>If you browse to <span style="color: #000080;"><span style="text-decoration: underline;"><a href="http://localhost:3000/posts.json">http://localhost:3000/posts.json</a></span></span>, you’ll see a JSON containing all of the posts.<span style="font-family: DejaVu Sans;">如果你浏览</span><span style="color: #000080;"><span style="text-decoration: underline;"><a href="http://localhost:3000/posts.json">http://localhost:3000/posts.json</a></span></span><span style="font-family: DejaVu Sans;">，你将会看到一个</span>JSON<span style="font-family: DejaVu Sans;">包含着所有的</span>post<span style="font-family: DejaVu Sans;">。</span>The HTML format looks for a view in <tt>app/views/posts/</tt> with a name that corresponds to the action name. <span style="font-family: DejaVu Sans;">这个</span>HTML<span style="font-family: DejaVu Sans;">格式在</span><tt>app/views/posts/</tt><span style="font-family: DejaVu Sans;"><tt>的</tt></span>view<span style="font-family: DejaVu Sans;">中查找相对应的动作名称。</span>Rails makes all of the instance variables from the action available to the view.Rails<span style="font-family: DejaVu Sans;">使来自</span>action<span style="font-family: DejaVu Sans;">的所有的实例变量对应到（可用）</span>view<span style="font-family: DejaVu Sans;">。</span>Here’s <tt>app/views/posts/index.html.erb</tt>:

<code>&lt;h1&gt;Listing</code><code> </code><code>posts&lt;/h1&gt;</code>

&nbsp;

<code>&lt;table&gt;</code>

<code> </code><code>&lt;tr&gt;</code>

<code> </code><code>&lt;th&gt;Name&lt;/th&gt;</code>

<code> </code><code>&lt;th&gt;Title&lt;/th&gt;</code>

<code> </code><code>&lt;th&gt;Content&lt;/th&gt;</code>

<code> </code><code>&lt;th&gt;&lt;/th&gt;</code>

<code> </code><code>&lt;th&gt;&lt;/th&gt;</code>

<code> </code><code>&lt;th&gt;&lt;/th&gt;</code>

<code> </code><code>&lt;/tr&gt;</code>

&nbsp;

<code>&lt;%</code> <code>@posts.each</code> <code>do</code> <code>|post|</code><code> </code><code>%&gt;</code>

<code> </code><code>&lt;tr&gt;</code>

<code> </code><code>&lt;td&gt;&lt;%=</code> <code>post.name</code><code> </code><code>%&gt;&lt;/td&gt;</code>

<code> </code><code>&lt;td&gt;&lt;%=</code> <code>post.title</code><code> </code><code>%&gt;&lt;/td&gt;</code>

<code> </code><code>&lt;td&gt;&lt;%=</code> <code>post.content</code><code> </code><code>%&gt;&lt;/td&gt;</code>

<code> </code><code>&lt;td&gt;&lt;%=</code> <code>link_to</code><code> </code><code>'Show',</code><code> </code><code>post</code><code> </code><code>%&gt;&lt;/td&gt;</code>

<code> </code><code>&lt;td&gt;&lt;%=</code> <code>link_to</code><code> </code><code>'Edit',</code><code> </code><code>edit_post_path(post)</code><code> </code><code>%&gt;&lt;/td&gt;</code>

<code> </code><code>&lt;td&gt;&lt;%=</code> <code>link_to</code><code> </code><code>'Destroy',</code><code> </code><code>post,</code><code> </code><code>:confirm</code> <code>=&gt;</code><code> </code><code>'Are</code><code> </code><code>you</code><code> </code><code>sure?',</code><code> </code><code>:method</code> <code>=&gt;</code><code> </code><code>:delete</code> <code>%&gt;&lt;/td&gt;</code>

<code> </code><code>&lt;/tr&gt;</code>

<code>&lt;%</code> <code>end</code> <code>%&gt;</code>

<code>&lt;/table&gt;</code>

&nbsp;

<code>&lt;br</code> <code>/&gt;</code>

&nbsp;

<code>&lt;%=</code> <code>link_to</code><code> </code><code>'New</code><code> </code><code>post',</code><code> </code><code>new_post_path</code><code> </code><code>%&gt;</code>

This view iterates#<span style="font-family: DejaVu Sans;">迭代</span>over the contents of the <tt>@posts</tt> array to display content and links.<span style="font-family: DejaVu Sans;">这个</span>view<span style="font-family: DejaVu Sans;">迭代</span>@posts<span style="font-family: DejaVu Sans;">数组所有的内容并显示相关的内容和链接。</span>A few things to note in the view:<span style="font-family: DejaVu Sans;">关于视图</span>note<span style="font-family: DejaVu Sans;">一些信息：</span>
<ul>
	<li><tt>link_to</tt> builds a hyperlink to a particular destination link_to<span style="font-family: DejaVu Sans;">创建一个超链接到一个地方</span></li>
	<li><tt>edit_post_path</tt> and <tt>new_post_path</tt> are helpers that Rails provides as part of RESTful routing.<tt>edit_post_path</tt> and <tt>new_post_path</tt><span style="font-family: DejaVu Sans;"><tt>是</tt></span><tt>Rails</tt><span style="font-family: DejaVu Sans;"><tt>提供的</tt></span>RESTful<span style="font-family: DejaVu Sans;">路由向导。</span>You’ll see a variety of these helpers for the different actions that the controller includes. <span style="font-family: DejaVu Sans;">不同的具有</span>controller<span style="font-family: DejaVu Sans;">的</span>actions<span style="font-family: DejaVu Sans;">中你将会看到一系列的这样的向导。</span></li>
</ul>
In previous versions of Rails, you had to use <tt>&lt;%=h</tt><tt> </tt><tt>post.name</tt><tt> </tt><tt>%&gt;</tt> so that any HTML would be escaped before being inserted into the page.<span style="font-family: DejaVu Sans;">在以前的版本的</span>Rails<span style="font-family: DejaVu Sans;">中，你必须使用</span>&lt;%=h post.name %&gt; <span style="font-family: DejaVu Sans;">以避免一些</span>HTML<span style="font-family: DejaVu Sans;">可能会转义在插入到页面之前。</span>In Rails 3.0, this is now the default.<span style="font-family: DejaVu Sans;">在</span>Rails 3.0<span style="font-family: DejaVu Sans;">，作为默认。</span>To get unescaped HTML, you now use &lt;%= raw post.name %&gt;.<span style="font-family: DejaVu Sans;">得到一个非转义的</span>HTML<span style="font-family: DejaVu Sans;">，你现在使用</span>&lt;%=raw post.name%&gt;.

For more details on the rendering process, see <a href="http://guides.rubyonrails.org/layouts_and_rendering.html"><span style="color: #000080;"><span style="text-decoration: underline;">Layouts</span></span><span style="color: #000080;"><span style="text-decoration: underline;">and</span></span><span style="color: #000080;"><span style="text-decoration: underline;">Rendering</span></span><span style="color: #000080;"><span style="text-decoration: underline;">in</span></span><span style="color: #000080;"><span style="text-decoration: underline;">Rails</span></span></a>.<span style="font-family: DejaVu Sans;">了解更过关于渲染处理流程，阅读</span><a href="http://guides.rubyonrails.org/layouts_and_rendering.html"><span style="color: #000080;"><span style="text-decoration: underline;">Layouts</span></span><span style="color: #000080;"><span style="text-decoration: underline;">and</span></span><span style="color: #000080;"><span style="text-decoration: underline;">Rendering</span></span><span style="color: #000080;"><span style="text-decoration: underline;">in</span></span><span style="color: #000080;"><span style="text-decoration: underline;">Rails</span></span></a>.
<h4><a name="customizing-the-layout"></a>6.8 Customizing the Layout<span style="font-family: WenQuanYi Micro Hei;">定制布局</span></h4>
The view is only part of the story of how HTML is displayed in your web browser.view<span style="font-family: DejaVu Sans;">仅仅告诉</span>HTML<span style="font-family: DejaVu Sans;">要显示什么（内容）在你的</span>web<span style="font-family: DejaVu Sans;">浏览器里面。</span>Rails also has the concept of <tt>layouts</tt>, which are containers for views.Rails<span style="font-family: DejaVu Sans;">也有关于布局的概念（定义），那就是（布局）是对</span>viewi<span style="font-family: DejaVu Sans;">的包装。</span>When Rails renders a view to the browser, it does so by putting the view’s HTML into a layout’s HTML.<span style="font-family: DejaVu Sans;">当</span>Rails<span style="font-family: DejaVu Sans;">渲染一个</span>view<span style="font-family: DejaVu Sans;">到浏览器，它通常是（这样做）把</span>view<span style="font-family: DejaVu Sans;">的</span>HTML<span style="font-family: DejaVu Sans;">放进布局的</span>HTML<span style="font-family: DejaVu Sans;">中。</span>In previous versions of Rails, the <tt>rails</tt><tt> </tt><tt>generate</tt><tt> </tt><tt>scaffold</tt> command would automatically create a controller specific layout, like <tt>app/views/layouts/posts.html.erb</tt>, for the posts controller. <span style="font-family: DejaVu Sans;">在以前的版本中，</span><tt>rails</tt><tt> </tt><tt>generate</tt><tt> </tt><tt>scaffold</tt><tt> </tt><span style="font-family: DejaVu Sans;"><tt>命令将会自动创建</tt></span><tt>controller</tt><span style="font-family: DejaVu Sans;"><tt>对应指定的布局。</tt></span>However this has been changed in Rails 3.0. An application specific <tt>layout</tt> is used for all the controllers and can be found in <tt>app/views/layouts/application.html.erb</tt>. <span style="font-family: DejaVu Sans;">然而在</span>rails3.0<span style="font-family: DejaVu Sans;">中有所不同了。一个应用程序指定的布局适用于所有的</span>controllers<span style="font-family: DejaVu Sans;">，可以在</span><tt>app/views/layouts/application.html.erb</tt><tt> </tt><span style="font-family: DejaVu Sans;"><tt>中找到</tt></span><tt>(</tt><span style="font-family: DejaVu Sans;"><tt>这就好像是</tt></span><tt>django</tt><span style="font-family: DejaVu Sans;"><tt>的</tt></span><tt>base.html)</tt><span style="font-family: DejaVu Sans;"><tt>。</tt></span>Open this layout in your editor and modify the <tt>body</tt> tag:<span style="font-family: DejaVu Sans;">打开这个</span>layout<span style="font-family: DejaVu Sans;">在你的编辑器中并且修改</span>body<span style="font-family: DejaVu Sans;">标签：</span>

&lt;!DOCTYPE html&gt;

&lt;html&gt;

&lt;head&gt;

&lt;title&gt;Blog&lt;/title&gt;

&lt;%= stylesheet_link_tag "application" %&gt;

&lt;%= javascript_include_tag "application" %&gt;

&lt;%= csrf_meta_tags %&gt;

&lt;/head&gt;

&lt;body style="background: #EEEEEE;"&gt;

&nbsp;

&lt;%= yield %&gt;

&nbsp;

&lt;/body&gt;

&lt;/html&gt;

Now when you refresh the <tt>/posts</tt> page, you’ll see a gray background to the page. This same gray background will be used throughout all the views for posts.<span style="font-family: DejaVu Sans;">现在你刷新</span><tt>/posts</tt><span style="font-family: DejaVu Sans;"><tt>页面，你将会看到一个灰色的页面背景。并且相同的灰色背景将会使用在</tt></span><tt>posts</tt><span style="font-family: DejaVu Sans;"><tt>的所有视图中。</tt></span>
<h4><a name="creating-new-posts"></a><tt>6.9</tt><tt> </tt><tt>Creating</tt><tt> </tt><tt>New</tt><tt> </tt><tt>Posts</tt></h4>
Creating a new post involves two actions. The first is the <tt>new</tt> action, which instantiates an empty <tt>Post</tt> object:<span style="font-family: DejaVu Sans;">创建一个</span>new post <span style="font-family: DejaVu Sans;">包含两个</span>actions<span style="font-family: DejaVu Sans;">。首先是</span>new action<span style="font-family: DejaVu Sans;">，它会实例化一个空的</span>Post<span style="font-family: DejaVu Sans;">对象：</span>

<code>def</code> <code>new</code>

<code> </code><code>@post</code> <code>=</code><code> </code><code>Post.new</code>

&nbsp;

<code> </code><code>respond_to</code><code> </code><code>do</code> <code>|format|</code>

<code> </code><code>format.html</code><code> </code><code>#</code><code> </code><code>new.html.erb</code>

<code> </code><code>format.json</code><code> </code><code>{</code><code> </code><code>render</code><code> </code><code>:json</code> <code>=&gt;</code><code> </code><code>@post</code> <code>}</code>

<code> </code><code>end</code>

<code>end</code>

The <tt>new.html.erb</tt> view displays this empty Post to the user: <span style="font-family: DejaVu Sans;">这个</span>new.html.erb<span style="font-family: DejaVu Sans;">视图显示这个空的</span>post<span style="font-family: DejaVu Sans;">给用户：</span>

<code>&lt;h1&gt;New</code><code> </code><code>post&lt;/h1&gt;</code>

&nbsp;

<code>&lt;%=</code> <code>render</code><code> </code><code>'form'</code> <code>%&gt;</code>

&nbsp;

<code>&lt;%=</code> <code>link_to</code><code> </code><code>'Back',</code><code> </code><code>posts_path</code><code> </code><code>%&gt;</code>

The <tt>&lt;%=</tt><tt> </tt><tt>render</tt><tt> </tt><tt>'form'</tt><tt> </tt><tt>%&gt;</tt> line is our first introduction to <em>partials</em> in Rails.<tt>&lt;%=</tt><tt> </tt><tt>render</tt><tt> </tt><tt>'form'</tt><tt> </tt><tt>%&gt;</tt><span style="font-family: DejaVu Sans;"><tt>是我们第一个介绍的</tt></span><tt>Rails</tt><span style="font-family: DejaVu Sans;"><tt>的</tt></span><tt>partials</tt><span style="font-family: DejaVu Sans;"><tt>。</tt></span>A partial is a snippet of HTML and Ruby code that can be reused in multiple locations.<span style="font-family: DejaVu Sans;">一个</span>partial<span style="font-family: DejaVu Sans;">是一个</span>HTML<span style="font-family: DejaVu Sans;">代码片段和</span>Ruby<span style="font-family: DejaVu Sans;">代码的组合可以在多目标对象中重用。（类似于</span>django<span style="font-family: DejaVu Sans;">的</span>include 'other.html'<span style="font-family: DejaVu Sans;">）</span>In this case, the form used to make a new post, is basically identical to a form used to edit a post, both have text fields for the name and title and a text area for the content with a button to make a new post or update the existing post.<span style="font-family: DejaVu Sans;">在本例中，</span>form<span style="font-family: DejaVu Sans;">用于创建</span>new post<span style="font-family: DejaVu Sans;">，它相当于一个用于编辑一个</span>post<span style="font-family: DejaVu Sans;">的表单，这个表单有一个</span>name text fields <span style="font-family: DejaVu Sans;">和</span>title text fields <span style="font-family: DejaVu Sans;">以及一个</span>content<span style="font-family: DejaVu Sans;">的</span>text area<span style="font-family: DejaVu Sans;">还有一个用于添加一个新的</span>post<span style="font-family: DejaVu Sans;">或者更新已经存在的</span>post<span style="font-family: DejaVu Sans;">的按钮。</span>

If you take a look at <tt>views/posts/_form.html.erb</tt> file, you will see the following:<span style="font-family: DejaVu Sans;">如果你看一下</span><tt>views/posts/_form.html.erb</tt><span style="font-family: DejaVu Sans;"><tt>这个文件，你将会发现下面的内容：</tt></span>

&lt;%= form_for(@post) do |f| %&gt;

&lt;% if @post.errors.any? %&gt;

&lt;div id="error_explanation"&gt;

&lt;h2&gt;&lt;%= pluralize(@post.errors.count, "error") %&gt; prohibited this post from being saved:&lt;/h2&gt;

&lt;ul&gt;

&lt;% @post.errors.full_messages.each do |msg| %&gt;

&lt;li&gt;&lt;%= msg %&gt;&lt;/li&gt;

&lt;% end %&gt;

&lt;/ul&gt;

&lt;/div&gt;

&lt;% end %&gt;

&lt;div&gt;

&lt;%= f.label :name %&gt;&lt;br /&gt;

&lt;%= f.text_field :name %&gt;

&lt;/div&gt;

&lt;div&gt;

&lt;%= f.label :title %&gt;&lt;br /&gt;

&lt;%= f.text_field :title %&gt;

&lt;/div&gt;

&lt;div&gt;

&lt;%= f.label :content %&gt;&lt;br /&gt;

&lt;%= f.text_area :content %&gt;

&lt;/div&gt;

&lt;div&gt;

&lt;%= f.submit %&gt;

&lt;/div

&lt;% end %&gt;

<tt>This</tt><tt> </tt><tt>partial</tt><tt> </tt><tt>receives</tt><tt> </tt><tt>all</tt><tt> </tt><tt>the</tt><tt> </tt><tt>instance</tt><tt> </tt><tt>variables</tt><tt> </tt><tt>defined</tt><tt> </tt><tt>in</tt><tt> </tt><tt>the</tt><tt> </tt><tt>calling</tt><tt> </tt><tt>view</tt><tt> </tt><tt>file,</tt><tt> </tt><tt>so</tt><tt> </tt><tt>in</tt><tt> </tt><tt>this</tt><tt> </tt><tt>case,</tt><tt> </tt><tt>the</tt><tt> </tt><tt>controller</tt><tt> </tt><tt>assigned</tt><tt> </tt><tt>the</tt><tt> </tt><tt>new</tt><tt> </tt><tt>Post</tt><tt> </tt><tt>object</tt><tt> </tt><tt>to</tt><tt> </tt><tt>@post</tt><tt> </tt><tt>and</tt><tt> </tt><tt>so,</tt><tt> </tt><tt>this</tt><tt> </tt><tt>is</tt><tt> </tt><tt>available</tt><tt> </tt><tt>in</tt><tt> </tt><tt>both</tt><tt> </tt><tt>the</tt><tt> </tt><tt>view</tt><tt> </tt><tt>and</tt><tt> </tt><tt>partial</tt><tt> </tt><tt>as</tt><tt> </tt><tt>@post.</tt><span style="font-family: DejaVu Sans;"><tt>这个</tt></span><tt>partial</tt><span style="font-family: DejaVu Sans;"><tt>接收在</tt></span><tt>view</tt><span style="font-family: DejaVu Sans;"><tt>文件中定义的所有的实例变量，因此在本例中，</tt></span><tt>controller</tt><span style="font-family: DejaVu Sans;"><tt>申请新的</tt></span><tt>Post</tt><span style="font-family: DejaVu Sans;"><tt>对象给</tt></span><tt>@post</tt><span style="font-family: DejaVu Sans;"><tt>，</tt></span><tt>@post</tt><span style="font-family: DejaVu Sans;"><tt>在</tt></span><tt>viewi</tt><span style="font-family: DejaVu Sans;"><tt>和</tt></span><tt>partial</tt><span style="font-family: DejaVu Sans;"><tt>都是可用的。</tt></span>

<tt>For</tt><tt> </tt><tt>more</tt><tt> </tt><tt>information</tt><tt> </tt><tt>on</tt><tt> </tt><tt>partials,</tt><tt> </tt><tt>refer</tt><tt> </tt><tt>to</tt><tt> </tt><tt>the</tt><tt> </tt><a href="http://guides.rubyonrails.org/layouts_and_rendering.html#using-partials"><span style="color: #000080;"><span style="text-decoration: underline;">Layouts</span></span><span style="color: #000080;"><span style="text-decoration: underline;">and</span></span><span style="color: #000080;"><span style="text-decoration: underline;">Rendering</span></span><span style="color: #000080;"><span style="text-decoration: underline;">in</span></span><span style="color: #000080;"><span style="text-decoration: underline;">Rails</span></span></a><tt> </tt><tt>guide.</tt><span style="font-family: DejaVu Sans;"><tt>有关</tt></span><tt>partials</tt><span style="font-family: DejaVu Sans;"><tt>的更多信息，参考</tt><tt></tt></span><a href="http://guides.rubyonrails.org/layouts_and_rendering.html#using-partials"><span style="color: #000080;"><span style="text-decoration: underline;">Layouts</span></span><span style="color: #000080;"><span style="text-decoration: underline;">and</span></span><span style="color: #000080;"><span style="text-decoration: underline;">Rendering</span></span><span style="color: #000080;"><span style="text-decoration: underline;">in</span></span><span style="color: #000080;"><span style="text-decoration: underline;">Rails</span></span></a><span style="font-family: DejaVu Sans;"><tt>指导。</tt></span>

<tt>The</tt><tt> </tt><tt>form_for</tt><tt> </tt><tt>block</tt><tt> </tt><tt>is</tt><tt> </tt><tt>used</tt><tt> </tt><tt>to</tt><tt> </tt><tt>create</tt><tt> </tt><tt>an</tt><tt> </tt><tt>HTML</tt><tt> </tt><tt>form.form_for</tt><span style="font-family: DejaVu Sans;"><tt>代码块用于创建一个</tt></span><tt>HTML</tt><span style="font-family: DejaVu Sans;"><tt>表单。</tt><tt></tt></span><tt>Within</tt><tt> </tt><tt>this</tt><tt> </tt><tt>block,</tt><tt> </tt><tt>you</tt><tt> </tt><tt>have</tt><tt> </tt><tt>access</tt><tt> </tt><tt>to</tt><tt> </tt><tt>methods</tt><tt> </tt><tt>to</tt><tt> </tt><tt>build</tt><tt> </tt><tt>various</tt><tt> </tt><tt>controls</tt><tt> </tt><tt>on</tt><tt> </tt><tt>the</tt><tt> </tt><tt>form.</tt><tt> </tt><span style="font-family: DejaVu Sans;"><tt>在这个代码块中你可以在访问方法的基础上在表单上创建各种控制。</tt></span><tt>For</tt><tt> </tt><tt>example,</tt><tt> </tt><tt>f.text_field</tt><tt> </tt><tt>:name</tt><tt> </tt><tt>tells</tt><tt> </tt><tt>Rails</tt><tt> </tt><tt>to</tt><tt> </tt><tt>create</tt><tt> </tt><tt>a</tt><tt> </tt><tt>text</tt><tt> </tt><tt>input</tt><tt> </tt><tt>on</tt><tt> </tt><tt>the</tt><tt> </tt><tt>form,</tt><tt> </tt><tt>and</tt><tt> </tt><tt>to</tt><tt> </tt><tt>hook</tt><tt> </tt><tt>it</tt><tt> </tt><tt>up</tt><tt> </tt><tt>to</tt><tt> </tt><tt>the</tt><tt> </tt><tt>name</tt><tt> </tt><tt>attribute</tt><tt> </tt><tt>of</tt><tt> </tt><tt>the</tt><tt> </tt><tt>instance</tt><tt> </tt><tt>being</tt><tt> </tt><tt>displayed.</tt><span style="font-family: DejaVu Sans;"><tt>比如，</tt></span><tt>f.test_field</tt><tt> </tt><tt>:name</tt><tt> </tt><span style="font-family: DejaVu Sans;"><tt>告诉</tt></span><tt>Rails</tt><span style="font-family: DejaVu Sans;"><tt>在表单中创建一个</tt></span><tt>text</tt><tt> </tt><tt>input</tt><span style="font-family: DejaVu Sans;"><tt>。</tt><tt></tt></span><tt>You</tt><tt> </tt><tt>can</tt><tt> </tt><tt>only</tt><tt> </tt><tt>use</tt><tt> </tt><tt>these</tt><tt> </tt><tt>methods</tt><tt> </tt><tt>with</tt><tt> </tt><tt>attributes</tt><tt> </tt><tt>of</tt><tt> </tt><tt>the</tt><tt> </tt><tt>model</tt><tt> </tt><tt>that</tt><tt> </tt><tt>the</tt><tt> </tt><tt>form</tt><tt> </tt><tt>is</tt><tt> </tt><tt>based</tt><tt> </tt><tt>on</tt><tt> </tt><tt>(in</tt><tt> </tt><tt>this</tt><tt> </tt><tt>case</tt><tt> </tt><tt>name,</tt><tt> </tt><tt>title,</tt><tt> </tt><tt>and</tt><tt> </tt><tt>content).form</tt><span style="font-family: DejaVu Sans;"><tt>使用的方法基于</tt></span><tt>model</tt><span style="font-family: DejaVu Sans;"><tt>的相对应的字段属性（类型如</tt></span><tt>text_field</tt><tt> </tt><tt>or</tt><tt> </tt><tt>text_area</tt><span style="font-family: DejaVu Sans;"><tt>）（例如本例中的</tt></span><tt>name,title,content</tt><span style="font-family: DejaVu Sans;"><tt>）。</tt><tt></tt></span><tt>Rails</tt><tt> </tt><tt>uses</tt><tt> </tt><tt>form_for</tt><tt> </tt><tt>in</tt><tt> </tt><tt>preference</tt><span style="font-family: DejaVu Sans;"><tt>偏好优先</tt><tt></tt></span><tt>to</tt><tt> </tt><tt>having</tt><tt> </tt><tt>you</tt><tt> </tt><tt>write</tt><tt> </tt><tt>raw</tt><tt> </tt><tt>HTML</tt><tt> </tt><tt>because</tt><tt> </tt><tt>the</tt><tt> </tt><tt>code</tt><tt> </tt><tt>is</tt><tt> </tt><tt>more</tt><tt> </tt><tt>succinct#</tt><span style="font-family: DejaVu Sans;"><tt>简洁</tt></span><tt>,</tt><tt> </tt><tt>and</tt><tt> </tt><tt>because</tt><tt> </tt><tt>it</tt><tt> </tt><tt>explicitly</tt><span style="font-family: DejaVu Sans;"><tt>明确</tt><tt></tt></span><tt>ties</tt><span style="font-family: DejaVu Sans;"><tt>关系</tt><tt></tt></span><tt>the</tt><tt> </tt><tt>form</tt><tt> </tt><tt>to</tt><tt> </tt><tt>a</tt><tt> </tt><tt>particular</tt><tt> </tt><tt>model</tt><tt> </tt><tt>instance.Rails</tt><span style="font-family: DejaVu Sans;"><tt>使用（偏向于使用）</tt></span><tt>form_for</tt><span style="font-family: DejaVu Sans;"><tt>列出你要输入的</tt></span><tt>HTML</tt><span style="font-family: DejaVu Sans;"><tt>行因为这样代码更加简洁，并却这样使得</tt></span><tt>form</tt><span style="font-family: DejaVu Sans;"><tt>和</tt></span><tt>particular</tt><tt> </tt><tt>model</tt><span style="font-family: DejaVu Sans;"><tt>实例关系更加明显。</tt></span>

<tt>The</tt><tt> </tt><tt>form_for</tt><tt> </tt><tt>block</tt><tt> </tt><tt>is</tt><tt> </tt><tt>also</tt><tt> </tt><tt>smart</tt><tt> </tt><tt>enough</tt><tt> </tt><tt>to</tt><tt> </tt><tt>work</tt><tt> </tt><tt>out</tt><tt> </tt><tt>if</tt><tt> </tt><tt>you</tt><tt> </tt><tt>are</tt><tt> </tt><tt>doing</tt><tt> </tt><tt>a</tt><tt> </tt><em>New</em><em> </em><em>Post</em><tt> </tt><tt>or</tt><tt> </tt><tt>an</tt><tt> </tt><em>Edit</em><em> </em><em>Post</em><tt> </tt><tt>action,</tt><tt> </tt><tt>and</tt><tt> </tt><tt>will</tt><tt> </tt><tt>set</tt><tt> </tt><tt>the</tt><tt> </tt><tt>form</tt><tt> </tt><tt>action</tt><tt> </tt><tt>tags</tt><tt> </tt><tt>and</tt><tt> </tt><tt>submit</tt><tt> </tt><tt>button</tt><tt> </tt><tt>names</tt><tt> </tt><tt>appropriately</tt><tt> </tt><tt>in</tt><tt> </tt><tt>the</tt><tt> </tt><tt>HTML</tt><tt> </tt><tt>output.form_for</tt><span style="font-family: DejaVu Sans;"><tt>代码块同样也足够你定制你的</tt></span><tt>New</tt><tt> </tt><tt>Post</tt><span style="font-family: DejaVu Sans;"><tt>和</tt></span><tt>Edit</tt><tt> </tt><tt>Post</tt><tt> </tt><tt>action,</tt><span style="font-family: DejaVu Sans;"><tt>并且将会设置</tt></span><tt>form</tt><tt> </tt><tt>action</tt><span style="font-family: DejaVu Sans;"><tt>标签和在</tt></span><tt>HTML</tt><span style="font-family: DejaVu Sans;"><tt>输出中显示的提交按钮名称。</tt></span>

<tt>If</tt><tt> </tt><tt>you</tt><tt> </tt><tt>need</tt><tt> </tt><tt>to</tt><tt> </tt><tt>create</tt><tt> </tt><tt>an</tt><tt> </tt><tt>HTML</tt><tt> </tt><tt>form</tt><tt> </tt><tt>that</tt><tt> </tt><tt>displays</tt><tt> </tt><tt>arbitrary#</tt><span style="font-family: DejaVu Sans;"><tt>任意</tt><tt></tt></span><tt>fields,</tt><tt> </tt><tt>not</tt><tt> </tt><tt>tied</tt><tt> </tt><tt>to</tt><tt> </tt><tt>a</tt><tt> </tt><tt>model,</tt><tt> </tt><tt>you</tt><tt> </tt><tt>should</tt><tt> </tt><tt>use</tt><tt> </tt><tt>the</tt><tt> </tt><tt>form_tag</tt><tt> </tt><tt>method,</tt><tt> </tt><tt>which</tt><tt> </tt><tt>provides</tt><tt> </tt><tt>shortcuts</tt><tt> </tt><tt>for</tt><tt> </tt><tt>building</tt><tt> </tt><tt>forms</tt><tt> </tt><tt>that</tt><tt> </tt><tt>are</tt><tt> </tt><tt>not</tt><tt> </tt><tt>necessarily</tt><tt> </tt><tt>tied</tt><tt> </tt><tt>to</tt><tt> </tt><tt>a</tt><tt> </tt><tt>model</tt><tt> </tt><tt>instance.</tt><span style="font-family: DejaVu Sans;"><tt>如果你需要创建一个</tt></span><tt>HTML</tt><span style="font-family: DejaVu Sans;"><tt>表单显示任意的域，而不绑定到</tt></span><tt>model</tt><span style="font-family: DejaVu Sans;"><tt>字段中，你应该使用</tt></span><tt>form_tag</tt><span style="font-family: DejaVu Sans;"><tt>方法，它快捷的保证了建立</tt></span><tt>forms</tt><span style="font-family: DejaVu Sans;"><tt>不必在绑定到一个</tt></span><tt>model</tt><span style="font-family: DejaVu Sans;"><tt>实例。</tt></span>

<tt>When</tt><tt> </tt><tt>the</tt><tt> </tt><tt>user</tt><tt> </tt><tt>clicks</tt><tt> </tt><tt>the</tt><tt> </tt><tt>Create</tt><tt> </tt><tt>Post</tt><tt> </tt><tt>button</tt><tt> </tt><tt>on</tt><tt> </tt><tt>this</tt><tt> </tt><tt>form,</tt><tt> </tt><tt>the</tt><tt> </tt><tt>browser</tt><tt> </tt><tt>will</tt><tt> </tt><tt>send</tt><tt> </tt><tt>information</tt><tt> </tt><tt>back</tt><tt> </tt><tt>to</tt><tt> </tt><tt>the</tt><tt> </tt><tt>create</tt><tt> </tt><tt>method</tt><tt> </tt><tt>of</tt><tt> </tt><tt>the</tt><tt> </tt><tt>controller</tt><tt> </tt><tt>(Rails</tt><tt> </tt><tt>knows</tt><tt> </tt><tt>to</tt><tt> </tt><tt>call</tt><tt> </tt><tt>the</tt><tt> </tt><tt>create</tt><tt> </tt><tt>method</tt><tt> </tt><tt>because</tt><tt> </tt><tt>the</tt><tt> </tt><tt>form</tt><tt> </tt><tt>is</tt><tt> </tt><tt>sent</tt><tt> </tt><tt>with</tt><tt> </tt><tt>an</tt><tt> </tt><tt>HTTP</tt><tt> </tt><tt>POST</tt><tt> </tt><tt>request;</tt><tt> </tt><tt>that</tt><tt>’</tt><tt>s</tt><tt> </tt><tt>one</tt><tt> </tt><tt>of</tt><tt> </tt><tt>the</tt><tt> </tt><tt>conventions</tt><tt> </tt><tt>that</tt><tt> </tt><tt>I</tt><tt> </tt><tt>mentioned</tt><tt> </tt><tt>earlier):</tt><span style="font-family: DejaVu Sans;"><tt>当用户点击这张表单上面的创建</tt></span><tt>Post</tt><span style="font-family: DejaVu Sans;"><tt>按钮，浏览器将会发送信息</tt><tt><span style="font-family: Liberation Serif,Times New Roman,serif;">——</span></tt></span><tt>controller</tt><span style="font-family: DejaVu Sans;"><tt>的方法回服务器（</tt></span><tt>Rails</tt><span style="font-family: DejaVu Sans;"><tt>知道调用</tt></span><tt>create</tt><span style="font-family: DejaVu Sans;"><tt>方法，因为</tt></span><tt>form</tt><span style="font-family: DejaVu Sans;"><tt>是以</tt></span><tt>HTTP</tt><tt> </tt><tt>POST</tt><span style="font-family: DejaVu Sans;"><tt>请求发送，这是我随后提到的一种协议之一）</tt></span>

<tt> </tt><tt>def</tt><tt> </tt><tt>create</tt>

<tt> </tt><tt>@post</tt><tt> </tt><tt>=</tt><tt> </tt><tt>Post.new(params[:post])</tt>

<tt> </tt><tt>respond_to</tt><tt> </tt><tt>do</tt><tt> </tt><tt>|format|</tt>

<tt> </tt><tt>if</tt><tt> </tt><tt>@post.save</tt>

<tt> </tt><tt>format.html</tt><tt> </tt><tt>{</tt><tt> </tt><tt>redirect_to</tt><tt> </tt><tt>@post,</tt><tt> </tt><tt>:notice</tt><tt> </tt><tt>=&gt;</tt><tt> </tt><tt>'Post</tt><tt> </tt><tt>was</tt><tt> </tt><tt>successfully</tt><tt> </tt><tt>created.'</tt><tt> </tt><tt>}</tt>

<tt> </tt><tt>format.json</tt><tt> </tt><tt>{</tt><tt> </tt><tt>render</tt><tt> </tt><tt>:json</tt><tt> </tt><tt>=&gt;</tt><tt> </tt><tt>@post,</tt><tt> </tt><tt>:status</tt><tt> </tt><tt>=&gt;</tt><tt> </tt><tt>:created,</tt><tt> </tt><tt>:location</tt><tt> </tt><tt>=&gt;</tt><tt> </tt><tt>@post</tt><tt> </tt><tt>}</tt>

<tt> </tt><tt>else</tt>

<tt> </tt><tt>format.html</tt><tt> </tt><tt>{</tt><tt> </tt><tt>render</tt><tt> </tt><tt>:action</tt><tt> </tt><tt>=&gt;</tt><tt> </tt><tt>"new"</tt><tt> </tt><tt>}</tt>

<tt> </tt><tt>format.json</tt><tt> </tt><tt>{</tt><tt> </tt><tt>render</tt><tt> </tt><tt>:json</tt><tt> </tt><tt>=&gt;</tt><tt> </tt><tt>@post.errors,</tt><tt> </tt><tt>:status</tt><tt> </tt><tt>=&gt;</tt><tt> </tt><tt>:unprocessable_entity</tt><tt> </tt><tt>}</tt>

<tt> </tt><tt>end</tt>

<tt> </tt><tt>end</tt>

<tt> </tt><tt>end</tt>

The <tt>create</tt> action instantiates a new Post object from the data supplied by the user on the form, which Rails makes available in the <tt>params</tt> hash.create action<span style="font-family: DejaVu Sans;">实例化一个新的</span>Post<span style="font-family: DejaVu Sans;">对象，这个对象给</span>form<span style="font-family: DejaVu Sans;">提供数据支持。</span>After successfully saving the new post, <tt>create</tt> returns the appropriate format that the user has requested (HTML in our case).<span style="font-family: DejaVu Sans;">当成功的保存了新</span>post<span style="font-family: DejaVu Sans;">，</span>create<span style="font-family: DejaVu Sans;">返回用户请求的适当的格式（在本例中是</span>HTML<span style="font-family: DejaVu Sans;">）。</span>It then redirects the user to the resulting post <tt>show</tt> action and sets a notice to the user that the Post was successfully created.<span style="font-family: DejaVu Sans;">然后重定向用户页面到结果显示的</span>post show action<span style="font-family: DejaVu Sans;">页面并且给出提示</span>Post<span style="font-family: DejaVu Sans;">成功的创建了。</span>

If the post was not successfully saved, due to a validation error, then the controller returns the user back to the <tt>new</tt> action with any error messages so that the user has the chance to fix the error and try again.<span style="font-family: DejaVu Sans;">如果</span>post<span style="font-family: DejaVu Sans;">没有保存成功，是因为（数据）验证错误，然后</span>controller<span style="font-family: DejaVu Sans;">控制用户页面回到</span>new action<span style="font-family: DejaVu Sans;">（包含验证错误新息）给用户。</span>

The “Post was successfully created.” message is stored inside of the Rails <tt>flash</tt> hash, (usually just called <em>the</em><em> </em><em>flash</em>) so that messages can be carried#<span style="font-family: DejaVu Sans;">载</span>over to another action, providing the user with useful information on the status of their request. “Post was successfully created.” <span style="font-family: DejaVu Sans;">这条消息被存储在</span>Rails<span style="font-family: DejaVu Sans;">的</span>flash<span style="font-family: DejaVu Sans;">的</span>hash<span style="font-family: DejaVu Sans;">表中，（通常之叫它</span>flash<span style="font-family: DejaVu Sans;">）因此消息可以转载到另一个</span>action<span style="font-family: DejaVu Sans;">，在请求状态中提供有用的信息给用户。</span>In the case of <tt>create</tt>, the user never actually sees any page rendered during the Post creation process, because it immediately redirects to the new Post as soon Rails saves the record.<span style="font-family: DejaVu Sans;">在这个新建例子（数据验证失败）中，用户实际上从来不看任何在页面创建进程中的渲染页面，因为它立刻重定向页面到</span>new Post<span style="font-family: DejaVu Sans;">当</span>Rails<span style="font-family: DejaVu Sans;">保存了这个记录。</span>The Flash carries over a message to the next action, so that when the user is redirected back to the <tt>show</tt> action, they are presented with a message saying “Post was successfully created.”Flash<span style="font-family: DejaVu Sans;">装载消息到接下来的</span>action<span style="font-family: DejaVu Sans;">，因此当用户被重定向到了</span>show action<span style="font-family: DejaVu Sans;">，他们立刻收到了一条消息<span style="font-family: Liberation Serif,Times New Roman,serif;">“</span></span>Post was successfully created.”<span style="font-family: DejaVu Sans;">。</span>
<h4><a name="showing-an-individual-post"></a>6.10 Showing an Individual Post<span style="font-family: WenQuanYi Micro Hei;">显示一条单个的</span>Post</h4>
When you click the <tt>show</tt> link for a post on the index page, it will bring you to a URL like <span style="color: #000080;"><span style="text-decoration: underline;"><a href="http://localhost:3000/posts/1">http://localhost:3000/posts/1</a></span></span>. <span style="font-family: DejaVu Sans;">当你在</span>posts <span style="font-family: DejaVu Sans;">的主页面点击一个</span>post<span style="font-family: DejaVu Sans;">的</span>show<span style="font-family: DejaVu Sans;">这个超链接，他将会产生一个</span>url <span style="color: #000080;"><span style="text-decoration: underline;"><a href="http://localhost:3000/posts/1">http://localhost:3000/posts/1</a></span></span><span style="font-family: DejaVu Sans;"><tt>。</tt></span>Rails interprets<span style="font-family: DejaVu Sans;">解释</span>this as a call to the <tt>show</tt> action for the resource, and passes in <tt>1</tt> as the <tt>:id</tt> parameter.Rails<span style="font-family: DejaVu Sans;">解释这是一个到</span>show action<span style="font-family: DejaVu Sans;">的</span>resource <span style="font-family: DejaVu Sans;">调用。</span>Here’s the <tt>show</tt> action:<span style="font-family: DejaVu Sans;">这里是</span>show action<span style="font-family: DejaVu Sans;">：</span>

def show

@post = Post.find(params[:id])

respond_to do |format|

format.html # show.html.erb

format.json { render :json =&gt; @post }

end

end

The <tt>show</tt> action uses <tt>Post.find</tt> to search for a single record in the database by its id value.<span style="font-family: DejaVu Sans;">这里的</span>show action<span style="font-family: DejaVu Sans;">使用</span>Post.find<span style="font-family: DejaVu Sans;">通过对应记录的</span>id<span style="font-family: DejaVu Sans;">来查找单个记录。</span>After finding the record, Rails displays it by using <tt>show.html.erb</tt>:<span style="font-family: DejaVu Sans;">当找到记录，</span>Rails<span style="font-family: DejaVu Sans;">使用</span>show.html.erb<span style="font-family: DejaVu Sans;">来显示它：</span>

&lt;p id="notice"&gt;&lt;%= notice %&gt;&lt;/p&gt;

&lt;p&gt;

&lt;b&gt;Name:&lt;/b&gt;

&lt;%= @post.name %&gt;

&lt;/p&gt;

&lt;p&gt;

&lt;b&gt;Title:&lt;/b&gt;

&lt;%= @post.title %&gt;

&lt;/p&gt;

&lt;p&gt;

&lt;b&gt;Content:&lt;/b&gt;

&lt;%= @post.content %&gt;

&lt;/p&gt;

&lt;%= link_to 'Edit', edit_post_path(@post) %&gt; |

&lt;%= link_to 'Back', posts_path %&gt;
<h4><a name="editing-posts"></a>6.11 Editing Posts<span style="font-family: WenQuanYi Micro Hei;">编辑</span>Posts</h4>
Like creating a new post, editing a post is a two-part process.<span style="font-family: DejaVu Sans;">类似创建一个新的</span>post<span style="font-family: DejaVu Sans;">，编辑一个</span>post<span style="font-family: DejaVu Sans;">也（分为）两部分。</span>The first step is a request to <tt>edit_post_path(@post)</tt> with a particular post. This calls the <tt>edit</tt> action in the controller:<span style="font-family: DejaVu Sans;">首先是到</span><tt>edit_post_path(@post)</tt><span style="font-family: DejaVu Sans;"><tt>请求一个特定的</tt></span><tt>post</tt><span style="font-family: DejaVu Sans;"><tt>。这里是调用的在</tt></span><tt>controller</tt><span style="font-family: DejaVu Sans;"><tt>中的</tt></span><tt>edit</tt><tt> </tt><tt>action</tt><span style="font-family: DejaVu Sans;"><tt>：</tt></span>

<code>def</code><tt> </tt><code>edit</code>

<code> </code><code>@post</code> <code>=</code><code> </code><code>Post.find(params[:id])</code>

<code>end</code>

After finding the requested post, Rails uses the <tt>edit.html.erb</tt> view to display it:<span style="font-family: DejaVu Sans;">在找到了请求的</span>post<span style="font-family: DejaVu Sans;">，</span>Rails<span style="font-family: DejaVu Sans;">使用</span><tt>edit.html.erb</tt><span style="font-family: DejaVu Sans;"><tt>试图来显示它：</tt></span>

<code>&lt;h1&gt;Editing</code><code> </code><code>post&lt;/h1&gt;</code>

&nbsp;

<code>&lt;%=</code> <code>render</code><code> </code><code>'form'</code> <code>%&gt;</code>

&nbsp;

<code>&lt;%=</code> <code>link_to</code><code> </code><code>'Show',</code><code> </code><code>@post</code> <code>%&gt;</code> <code>|</code>

<code>&lt;%=</code> <code>link_to</code><code> </code><code>'Back',</code><code> </code><code>posts_path</code><code> </code><code>%&gt;</code>

<tt>Again,</tt><tt> </tt><tt>as</tt><tt> </tt><tt>with</tt><tt> </tt><tt>the</tt><tt> </tt><tt>new</tt><tt> </tt><tt>action,</tt><tt> </tt><tt>the</tt><tt> </tt><tt>edit</tt><tt> </tt><tt>action</tt><tt> </tt><tt>is</tt><tt> </tt><tt>using</tt><tt> </tt><tt>the</tt><tt> </tt><tt>form</tt><tt> </tt><tt>partial,</tt><tt> </tt><tt>this</tt><tt> </tt><tt>time</tt><tt> </tt><tt>however,</tt><tt> </tt><tt>the</tt><tt> </tt><tt>form</tt><tt> </tt><tt>will</tt><tt> </tt><tt>do</tt><tt> </tt><tt>a</tt><tt> </tt><tt>PUT</tt><tt> </tt><tt>action</tt><tt> </tt><tt>to</tt><tt> </tt><tt>the</tt><tt> </tt><tt>PostsController</tt><tt> </tt><tt>and</tt><tt> </tt><tt>the</tt><tt> </tt><tt>submit</tt><tt> </tt><tt>button</tt><tt> </tt><tt>will</tt><tt> </tt><tt>display</tt><tt> “</tt><tt>Update</tt><tt> </tt><tt>Post</tt><tt>”</tt><span style="font-family: DejaVu Sans;"><tt>再一次的，就像</tt></span><tt>new</tt><tt> </tt><tt>action</tt><span style="font-family: DejaVu Sans;"><tt>，</tt></span><tt>edit</tt><tt> </tt><tt>action</tt><span style="font-family: DejaVu Sans;"><tt>也使用</tt></span><tt>form</tt><span style="font-family: DejaVu Sans;"><tt>部分，这次有所不同，</tt></span><tt>form</tt><span style="font-family: DejaVu Sans;"><tt>将会提交一个</tt></span><tt>PUT</tt><tt> </tt><tt>action</tt><span style="font-family: DejaVu Sans;"><tt>到</tt></span><tt>PostsController</tt><span style="font-family: DejaVu Sans;"><tt>并且提交按钮将会显示</tt><tt><span style="font-family: Liberation Serif,Times New Roman,serif;">“</span></tt></span><tt>Update</tt><tt> </tt><tt>Post</tt><tt>”</tt>

<tt>Submitting</tt><tt> </tt><tt>the</tt><tt> </tt><tt>form</tt><tt> </tt><tt>created</tt><tt> </tt><tt>by</tt><tt> </tt><tt>this</tt><tt> </tt><tt>view</tt><tt> </tt><tt>will</tt><tt> </tt><tt>invoke</tt><span style="font-family: DejaVu Sans;"><tt>调用</tt><tt></tt></span><tt>the</tt><tt> </tt><tt>update</tt><tt> </tt><tt>action</tt><tt> </tt><tt>within</tt><tt> </tt><tt>the</tt><tt> </tt><tt>controller:</tt><span style="font-family: DejaVu Sans;"><tt>提交的</tt></span><tt>form</tt><span style="font-family: DejaVu Sans;"><tt>由上面这个视图创建的并且还会调用</tt></span><tt>controller</tt><span style="font-family: DejaVu Sans;"><tt>中的</tt></span><tt>update</tt><tt> </tt><tt>action</tt><span style="font-family: DejaVu Sans;"><tt>：</tt></span>

<tt> </tt><tt>def</tt><tt> </tt><tt>update</tt>

<tt> </tt><tt>@post</tt><tt> </tt><tt>=</tt><tt> </tt><tt>Post.find(params[:id])</tt>

<tt> </tt><tt>respond_to</tt><tt> </tt><tt>do</tt><tt> </tt><tt>|format|</tt>

<tt> </tt><tt>if</tt><tt> </tt><tt>@post.update_attributes(params[:post])</tt>

<tt> </tt><tt>format.html</tt><tt> </tt><tt>{</tt><tt> </tt><tt>redirect_to</tt><tt> </tt><tt>@post,</tt><tt> </tt><tt>:notice</tt><tt> </tt><tt>=&gt;</tt><tt> </tt><tt>'Post</tt><tt> </tt><tt>was</tt><tt> </tt><tt>successfully</tt><tt> </tt><tt>updated.'</tt><tt> </tt><tt>}</tt>

<tt> </tt><tt>format.json</tt><tt> </tt><tt>{</tt><tt> </tt><tt>head</tt><tt> </tt><tt>:ok</tt><tt> </tt><tt>}</tt>

<tt> </tt><tt>else</tt>

<tt> </tt><tt>format.html</tt><tt> </tt><tt>{</tt><tt> </tt><tt>render</tt><tt> </tt><tt>:action</tt><tt> </tt><tt>=&gt;</tt><tt> </tt><tt>"edit"</tt><tt> </tt><tt>}</tt>

<tt> </tt><tt>format.json</tt><tt> </tt><tt>{</tt><tt> </tt><tt>render</tt><tt> </tt><tt>:json</tt><tt> </tt><tt>=&gt;</tt><tt> </tt><tt>@post.errors,</tt><tt> </tt><tt>:status</tt><tt> </tt><tt>=&gt;</tt><tt> </tt><tt>:unprocessable_entity</tt><tt> </tt><tt>}</tt>

<tt> </tt><tt>end</tt>

<tt> </tt><tt>end</tt>

<tt> </tt><tt>end</tt>

<tt>In</tt><tt> </tt><tt>the</tt><tt> </tt><tt>update</tt><tt> </tt><tt>action,</tt><tt> </tt><tt>Rails</tt><tt> </tt><tt>first</tt><tt> </tt><tt>uses</tt><tt> </tt><tt>the</tt><tt> </tt><tt>:id</tt><tt> </tt><tt>parameter</tt><tt> </tt><tt>passed</tt><tt> </tt><tt>back</tt><tt> </tt><tt>from</tt><tt> </tt><tt>the</tt><tt> </tt><tt>edit</tt><tt> </tt><tt>view</tt><tt> </tt><tt>to</tt><tt> </tt><tt>locate</tt><tt> </tt><tt>the</tt><tt> </tt><tt>database</tt><tt> </tt><tt>record</tt><tt> </tt><tt>that</tt><tt>’</tt><tt>s</tt><tt> </tt><tt>being</tt><tt> </tt><tt>edited.</tt><span style="font-family: DejaVu Sans;"><tt>在</tt></span><tt>update</tt><tt> </tt><tt>action</tt><span style="font-family: DejaVu Sans;"><tt>中，</tt></span><tt>Rails</tt><span style="font-family: DejaVu Sans;"><tt>首先使用</tt></span><tt>:id</tt><span style="font-family: DejaVu Sans;"><tt>参数从</tt></span><tt>edit</tt><tt> </tt><tt>view</tt><span style="font-family: DejaVu Sans;"><tt>（传值到）数据库记录下刚才编辑的内容。</tt><tt></tt></span><tt>The</tt><tt> </tt><tt>update_attributes#</tt><span style="font-family: DejaVu Sans;"><tt>更新</tt></span><tt>model</tt><span style="font-family: DejaVu Sans;"><tt>的属性</tt><tt></tt></span><tt>call</tt><tt> </tt><tt>then</tt><tt> </tt><tt>takes</tt><tt> </tt><tt>the</tt><tt> </tt><tt>rest</tt><tt> </tt><tt>of</tt><tt> </tt><tt>the</tt><tt> </tt><tt>parameters</tt><tt> </tt><tt>from</tt><tt> </tt><tt>the</tt><tt> </tt><tt>request</tt><tt> </tt><tt>and</tt><tt> </tt><tt>applies</tt><tt> </tt><tt>them</tt><tt> </tt><tt>to</tt><tt> </tt><tt>this</tt><tt> </tt><tt>record.</tt><tt> </tt><tt>update_attributes</tt><span style="font-family: DejaVu Sans;"><tt>在应用一些（更多）参数的来自</tt></span><tt>request</tt><span style="font-family: DejaVu Sans;"><tt>的数据到</tt></span><tt>recode</tt><span style="font-family: DejaVu Sans;"><tt>时被调用。</tt><tt></tt></span><tt>If</tt><tt> </tt><tt>all</tt><tt> </tt><tt>goes</tt><tt> </tt><tt>well,</tt><tt> </tt><tt>the</tt><tt> </tt><tt>user</tt><tt> </tt><tt>is</tt><tt> </tt><tt>redirected</tt><tt> </tt><tt>to</tt><tt> </tt><tt>the</tt><tt> </tt><tt>post</tt><tt>’</tt><tt>s</tt><tt> </tt><tt>show</tt><tt> </tt><tt>view.</tt><tt> </tt><span style="font-family: DejaVu Sans;"><tt>如果一切成功，用户会被重定向到</tt></span><tt>post</tt><span style="font-family: DejaVu Sans;"><tt>的</tt></span><tt>show</tt><span style="font-family: DejaVu Sans;"><tt>视图。</tt></span><tt>If</tt><tt> </tt><tt>there</tt><tt> </tt><tt>are</tt><tt> </tt><tt>any</tt><tt> </tt><tt>problems,</tt><tt> </tt><tt>it</tt><tt>’</tt><tt>s</tt><tt> </tt><tt>back</tt><tt> </tt><tt>to</tt><tt> </tt><tt>the</tt><tt> </tt><tt>edit</tt><tt> </tt><tt>view</tt><tt> </tt><tt>to</tt><tt> </tt><tt>correct</tt><tt> </tt><tt>them.</tt><span style="font-family: DejaVu Sans;"><tt>如果期间发生了任何错误，它将回到</tt></span><tt>edit</tt><span style="font-family: DejaVu Sans;"><tt>视图并（要求）改正他们。</tt></span>
<h4><a name="destroying-a-post1"></a><tt>6.12</tt><tt> </tt><tt>Destroying</tt><tt> </tt><tt>a</tt><tt> </tt><tt>Post</tt><tt> </tt><span style="font-family: WenQuanYi Micro Hei;"><tt>摧毁一个</tt></span><tt>post</tt></h4>
Finally, clicking one of the <tt>destroy</tt> links sends the associated id to the <tt>destroy</tt> action:<span style="font-family: DejaVu Sans;">最后，点击一个</span>destroy<span style="font-family: DejaVu Sans;">链接发送相关的</span>id<span style="font-family: DejaVu Sans;">到</span>destroy<span style="font-family: DejaVu Sans;">动作：</span>

<code>def</code> <code>destroy</code>

<code> </code><code>@post</code> <code>=</code><code> </code><code>Post.find(params[:id])</code>

<code> </code><code>@post.destroy</code>

&nbsp;

<code> </code><code>respond_to</code><code> </code><code>do</code> <code>|format|</code>

<code> </code><code>format.html</code><code> </code><code>{</code><code> </code><code>redirect_to</code><code> </code><code>posts_url</code><code> </code><code>}</code>

<code> </code><code>format.json</code><code> </code><code>{</code><code> </code><code>head</code><code> </code><code>:ok</code> <code>}</code>

<code> </code><code>end</code>

<code>end</code>

The <tt>destroy</tt> method of an Active Record model instance removes the corresponding record from the database.<span style="font-family: DejaVu Sans;">这个</span>destroy<span style="font-family: DejaVu Sans;">是</span>Active Recordmodel<span style="font-family: DejaVu Sans;">的实例（功能是）从数据库中移除相应的记录。</span>After that’s done, there isn’t any record to display, so Rails redirects the user’s browser to the index view for the model.<span style="font-family: DejaVu Sans;">当这个（操作）完成，这里没有任何记录显示，因此</span>Rails<span style="font-family: DejaVu Sans;">重定向用户的浏览器到</span>model<span style="font-family: DejaVu Sans;">的主页视图。</span>
<h3><a name="adding-a-second-model"></a>7 Adding a Second Model<span style="font-family: WenQuanYi Micro Hei;">添加第二个</span>Model<span style="font-family: WenQuanYi Micro Hei;">（</span>comment<span style="font-family: WenQuanYi Micro Hei;">）</span></h3>
Now that you’ve seen how a model built with scaffolding looks like, it’s time to add a second model to the application.<span style="font-family: DejaVu Sans;">你已经知道了通过</span>scaffolding<span style="font-family: DejaVu Sans;">生成的</span>model<span style="font-family: DejaVu Sans;">看起来是怎样的。</span>The second model will handle comments on blog posts.<span style="font-family: DejaVu Sans;">第二个</span>model<span style="font-family: DejaVu Sans;">用来处理</span>blog post<span style="font-family: DejaVu Sans;">的评论。</span>
<h4><a name="generating-a-model"></a>7.1 Generating a Model<span style="font-family: WenQuanYi Micro Hei;">构造一个</span>model</h4>
Models in Rails use a singular name, and their corresponding database tables use a plural name. Rails <span style="font-family: DejaVu Sans;">中的</span>Models<span style="font-family: DejaVu Sans;">使用一个单数名称，同时它们相关的数据库表使用一个复数名称。</span>For the model to hold comments, the convention is to use the name Comment.<span style="font-family: DejaVu Sans;">对于评论在</span>models<span style="font-family: DejaVu Sans;">中的代名词，习惯上使用的的是</span>Comment<span style="font-family: DejaVu Sans;">。</span>Even if you don’t want to use the entire apparatus set up by scaffolding, most Rails developers still use generators to make things like models and controllers.<span style="font-family: DejaVu Sans;">即使你不想完完全全的使用</span>scaffolding<span style="font-family: DejaVu Sans;">，大多数的</span>Rails<span style="font-family: DejaVu Sans;">仍然使用生成器来做这些事情比如</span>models<span style="font-family: DejaVu Sans;">和</span>controllers<span style="font-family: DejaVu Sans;">。</span>To create the new model, run this command in your terminal:<span style="font-family: DejaVu Sans;">要创建一个新的</span>model<span style="font-family: DejaVu Sans;">，在终端中运行下面这条命令：</span>

<code>rails</code><code> </code><code>generate</code><code> </code><code>model</code><code> </code><code>Comment</code><code> </code><code>commenter:string</code><code> </code><code>body:text</code><code> </code><code>post:references</code><code> </code><code>#references</code><span style="font-family: DejaVu Sans;"><code>引用</code></span>

This command will generate four files:<span style="font-family: DejaVu Sans;">这条命令将会生成四个文件：</span>
<ul>
	<li><tt>app/models/comment.rb</tt> – The model <span style="font-family: DejaVu Sans;">模型</span></li>
	<li><tt>db/migrate/20111108080402_create_comments.rb</tt> – The migration <span style="font-family: DejaVu Sans;">数据迁移</span></li>
	<li><tt>test/unit/comment_test.rb</tt> <span style="color: #800000;">and</span><tt>test/fixtures/comments.yml</tt> – The test harness. <span style="font-family: DejaVu Sans;">测试工具</span></li>
</ul>
First, take a look at <tt>comment.rb</tt>:<span style="font-family: DejaVu Sans;">首先，看一看</span>comment.rb:

<code>class</code> <code>Comment</code><code> </code><code>&lt;</code><code> </code><code>ActiveRecord::Base</code>

<code> </code><code>belongs_to</code><code> </code><code>:post</code>

<code>end</code>

This is very similar to the <tt>post.rb</tt> model that you saw earlier.<span style="font-family: DejaVu Sans;">这和你刚刚看到</span>post.rb<span style="font-family: DejaVu Sans;">很近似。</span>The difference is the line <tt>belongs_to</tt><tt> </tt><tt>:post</tt>, which sets up an Active Record <em>association</em>. <span style="font-family: DejaVu Sans;">不同的是这行</span><tt>belongs_to</tt><tt> </tt><tt>:post</tt><span style="font-family: DejaVu Sans;"><tt>，他会安装一个</tt><tt></tt></span><tt>Active</tt><tt> </tt><tt>Record</tt><tt> </tt><em>association<span style="font-family: DejaVu Sans;">。</span></em>You’ll learn a little about associations in the next section of this guide.<span style="font-family: DejaVu Sans;">你将会在接下来的</span>guide<span style="font-family: DejaVu Sans;">学习一点有关</span>associations<span style="font-family: DejaVu Sans;">的内容。</span>

In addition to the model, Rails has also made a migration to create the corresponding database table:<span style="font-family: DejaVu Sans;">除了模型，</span>Rails<span style="font-family: DejaVu Sans;">同样也产生了一个</span>migration<span style="font-family: DejaVu Sans;">来创建相应的数据库表单：</span>

class CreateComments &lt; ActiveRecord::Migration

def change

create_table :comments do |t|

t.string :commenter

t.text :body

t.references :post

t.timestamps

end

add_index :comments, :post_id

end

end

The <tt>t.references</tt> line sets up a foreign key column for the association between the two models.<span style="font-family: DejaVu Sans;">对于</span><tt>t.references</tt><span style="font-family: DejaVu Sans;"><tt>这行，会在两个</tt></span><tt>models</tt><span style="font-family: DejaVu Sans;"><tt>之间生成一个外键列从而形成一个关系（组合）。</tt></span>And the <tt>add_index</tt> line sets up an index for this association column. Go ahead and run the migration:<span style="font-family: DejaVu Sans;">而且<tt></tt></span><tt>add_index</tt> line<span style="font-family: DejaVu Sans;">生成一个首页关联到这个关系行：</span>

<code>$</code><code> </code><code>rake</code><code> </code><code>db:migrate</code>

Rails is smart enough to only execute the migrations that have not already been run against the current database, so in this case you will just see:Rails<span style="font-family: DejaVu Sans;">能够智能的只针对对没有被运行过的表单，执行</span>migrations<span style="font-family: DejaVu Sans;">生成当前的数据库，因此这里你只会看到：</span>
<h4><a name="associating-models"></a>7.2 Associating Models<span style="font-family: WenQuanYi Micro Hei;">关联</span>models</h4>
Active Record associations let you easily declare the relationship between two models. In the case of comments and posts, you could write out the relationships this way:Active Record associations<span style="font-family: DejaVu Sans;">让你很容易的申明两个</span>models<span style="font-family: DejaVu Sans;">之间的关系。在本例中的</span>comments<span style="font-family: DejaVu Sans;">和</span>posts<span style="font-family: DejaVu Sans;">，你可以写出这样描述关系：</span>
<ul>
	<li>Each comment belongs to one post <span style="font-family: DejaVu Sans;">一条</span>comment<span style="font-family: DejaVu Sans;">对应于一个</span>post</li>
	<li>One post can have many comments <span style="font-family: DejaVu Sans;">一个</span>post<span style="font-family: DejaVu Sans;">可以对应于多个</span>comments</li>
</ul>
In fact, this is very close to the syntax that Rails uses to declare this association.<span style="font-family: DejaVu Sans;">实际上，这也很接近</span>Rails<span style="font-family: DejaVu Sans;">申明的</span>association <span style="font-family: DejaVu Sans;">的语法。</span>You’ve already seen the line of code inside the Comment model that makes each comment belong to a Post:<span style="font-family: DejaVu Sans;">你已经看到了在</span>Comment model<span style="font-family: DejaVu Sans;">中的使每个</span>comment<span style="font-family: DejaVu Sans;">对应于一个</span>post<span style="font-family: DejaVu Sans;">的代码。</span>

You’ll need to edit the <tt>post.rb</tt> file to add the other side of the association:<span style="font-family: DejaVu Sans;">你将会需要编辑</span>post.rb<span style="font-family: DejaVu Sans;">文件来添加其他</span>association <span style="font-family: DejaVu Sans;">盟友。</span>

<code>class</code> <code>Post</code><code> </code><code>&lt;</code><code> </code><code>ActiveRecord::Base</code>

<code> </code><code>validates</code><code> </code><code>:name,</code><code> </code><code>:presence</code> <code>=&gt;</code><code> </code><code>true</code>

<code> </code><code>validates</code><code> </code><code>:title,</code><code> </code><code>:presence</code> <code>=&gt;</code><code> </code><code>true,</code>

<code> </code><code>:length</code> <code>=&gt;</code><code> </code><code>{</code><code> </code><code>:minimum</code> <code>=&gt;</code><code> </code><code>5</code> <code>}</code>

&nbsp;

<code> </code><code>has_many</code><code> </code><code>:comments</code>

<code>end</code>

These two declarations enable a good bit of automatic behavior. For example, if you have an instance variable <tt>@post</tt> containing a post, you can retrieve all the comments belonging to that post <strong>as</strong><strong> </strong><strong>the</strong><strong> </strong><strong>array</strong> <tt>@post.comments</tt>.

For more information on Active Record associations, see the <a href="http://guides.rubyonrails.org/association_basics.html"><span style="color: #000080;"><span style="text-decoration: underline;">Active</span></span><span style="color: #000080;"><span style="text-decoration: underline;">Record</span></span><span style="color: #000080;"><span style="text-decoration: underline;">Associations</span></span></a> guide.
<h4><a name="adding-a-route-for-comments"></a>7.3 Adding a Route for Comments<span style="font-family: WenQuanYi Micro Hei;">给</span>Comments<span style="font-family: WenQuanYi Micro Hei;">添加路由</span></h4>
As with the <tt>home</tt> controller, we will need to add a route so that Rails knows where we would like to navigate to see <tt>comments</tt>.<span style="font-family: DejaVu Sans;">作为</span>home controller<span style="font-family: DejaVu Sans;">，我们将还需要添加一个路由让</span>Rails<span style="font-family: DejaVu Sans;">知道我们导航到哪里可以看到评论。</span>Open up the <tt>config/routes.rb</tt> file again, you will see an entry that was added automatically for <tt>posts</tt> near the top by the scaffold generator, resources :posts, edit it as follows:<span style="font-family: DejaVu Sans;">再次打开</span><tt>config/routes.rb</tt><span style="font-family: DejaVu Sans;"><tt>文件，你将会看到</tt></span><tt>scaffold</tt><span style="font-family: DejaVu Sans;"><tt>创建器在顶部为</tt></span><tt>posts</tt><span style="font-family: DejaVu Sans;"><tt>自动添加的入口，</tt><tt></tt></span>resources :posts<span style="font-family: DejaVu Sans;">，把它改成如下：</span>

resources :posts do

resources :comments

end

This creates <tt>comments</tt> as a <em>nested</em><em> </em><em>resource</em> within <tt>posts</tt>.<span style="font-family: DejaVu Sans;">这里把</span>comments<span style="font-family: DejaVu Sans;">作为一个嵌套资源放在</span>posts<span style="font-family: DejaVu Sans;">中。</span>This is another part of capturing the hierarchical relationship that exists between posts and comments.<span style="font-family: DejaVu Sans;">这是在存在的</span>posts<span style="font-family: DejaVu Sans;">和</span>comments<span style="font-family: DejaVu Sans;">的分层关系的表现。</span>

For more information on routing, see the <a href="http://guides.rubyonrails.org/routing.html"><span style="color: #000080;"><span style="text-decoration: underline;">Rails</span></span><span style="color: #000080;"><span style="text-decoration: underline;">Routing</span></span><span style="color: #000080;"><span style="text-decoration: underline;">from</span></span><span style="color: #000080;"><span style="text-decoration: underline;">the</span></span><span style="color: #000080;"><span style="text-decoration: underline;">Outside</span></span><span style="color: #000080;"><span style="text-decoration: underline;">In</span></span></a> guide.<span style="font-family: DejaVu Sans;">关于</span>routing<span style="font-family: DejaVu Sans;">的更多的信息，查看</span><a href="http://guides.rubyonrails.org/routing.html"><span style="color: #000080;"><span style="text-decoration: underline;">Rails</span></span><span style="color: #000080;"><span style="text-decoration: underline;">Routing</span></span><span style="color: #000080;"><span style="text-decoration: underline;">from</span></span><span style="color: #000080;"><span style="text-decoration: underline;">the</span></span><span style="color: #000080;"><span style="text-decoration: underline;">Outside</span></span><span style="color: #000080;"><span style="text-decoration: underline;">In</span></span></a> guide<span style="font-family: DejaVu Sans;">。</span>
<h4><a name="generating-a-controller"></a>7.4 Generating a Controller<span style="font-family: WenQuanYi Micro Hei;">构造一个</span>Controller</h4>
With the model in hand, you can turn your attention to creating a matching controller.model<span style="font-family: DejaVu Sans;">已经到手了，你可以把你的注意力放到创建一个匹配的</span>controller<span style="font-family: DejaVu Sans;">上了。</span>Again, there’s a generator for this:<span style="font-family: DejaVu Sans;">类似的，像这样构造：</span>

<code>$</code><code> </code><code>rails</code><code> </code><code>generate</code><code> </code><code>controller</code><code> </code><code>Comments</code>

This creates six files and one empty directory:<span style="font-family: DejaVu Sans;">这里新建了</span>6<span style="font-family: DejaVu Sans;">个文件和一个空目录。</span>
<ul>
	<li><tt>app/controllers/comments_controller.rb</tt> – The controller</li>
	<li><tt>app/helpers/comments_helper.rb</tt> – A view helper file</li>
	<li><tt>test/functional/comments_controller_test.rb</tt> – The functional tests for the controller</li>
	<li><tt>test/unit/helpers/comments_helper_test.rb</tt> – The unit tests for the helper</li>
	<li><tt>app/views/comments/</tt> – Views of the controller are stored here</li>
	<li><tt>app/assets/stylesheets/comment.css.scss</tt> – Cascading style sheet for the controller</li>
	<li><tt>app/assets/javascripts/comment.js.coffee</tt> – CoffeeScript for the controller</li>
</ul>
Like with any blog, our readers will create their comments directly after reading the post, and once they have added their comment, will be sent back to the post show page to see their comment now listed.<span style="font-family: DejaVu Sans;">就像大多数</span>blog<span style="font-family: DejaVu Sans;">，我们的读者将会直接发表他们的评论在他们阅读</span>post<span style="font-family: DejaVu Sans;">的时候，并且一旦他们添加评论成功，将会回到</span>postshow<span style="font-family: DejaVu Sans;">页面去查看他们刚刚列出的评论。</span>Due to this, our <tt>CommentsController</tt> is there to provide a method to create comments and delete SPAM comments when they arrive.<span style="font-family: DejaVu Sans;">正因为这样</span>(<span style="font-family: DejaVu Sans;">的考虑</span>)<span style="font-family: DejaVu Sans;">，我们的</span><tt>CommentsController</tt><span style="font-family: DejaVu Sans;"><tt>如下，它提供一个方法来创建</tt></span><tt>comments</tt><span style="font-family: DejaVu Sans;"><tt>和删除垃圾评论。</tt></span>

&lt;p&gt;&lt;%= notice %&gt;&lt;/p&gt;

&nbsp;

&lt;p&gt;

&lt;b&gt;Name:&lt;/b&gt;

&lt;%= @post.name %&gt;

&lt;/p&gt;

&nbsp;

&lt;p&gt;

&lt;b&gt;Title:&lt;/b&gt;

&lt;%= @post.title %&gt;

&lt;/p&gt;

&nbsp;

&lt;p&gt;

&lt;b&gt;Content:&lt;/b&gt;

&lt;%= @post.content %&gt;

&lt;/p&gt;

&nbsp;

&lt;h2&gt;Add a comment:&lt;/h2&gt;

&lt;%= form_for([@post, @post.comments.build]) do |f| %&gt;

&lt;div&gt;

&lt;%= f.label :commenter %&gt;&lt;br /&gt;

&lt;%= f.text_field :commenter %&gt;

&lt;/div&gt;

&lt;div&gt;

&lt;%= f.label :body %&gt;&lt;br /&gt;

&lt;%= f.text_area :body %&gt;

&lt;/div&gt;

&lt;div&gt;

&lt;%= f.submit %&gt;

&lt;/div&gt;

&lt;% end %&gt;

&nbsp;

&lt;%= link_to 'Edit Post', edit_post_path(@post) %&gt; |

&lt;%= link_to 'Back to Posts', posts_path %&gt; |

This adds a form on the Post show page that creates a new comment, which will call the <tt>CommentsController</tt> <tt>create</tt> action, so let’s wire that up:<span style="font-family: DejaVu Sans;">这里添加一个</span>forms<span style="font-family: DejaVu Sans;">在</span>Post show<span style="font-family: DejaVu Sans;">页面用来创建一个新的评论，它将会调用</span><tt>CommentsController</tt><span style="font-family: DejaVu Sans;"><tt>的</tt></span><tt>creat</tt><tt> </tt><tt>action</tt><span style="font-family: DejaVu Sans;"><tt>，因此让我们补充上下面的内容：</tt></span>

<code>class</code><tt> </tt><code>CommentsController</code><code> </code><code>&lt;</code><code> </code><code>ApplicationController</code>

<code> </code><code>def</code> <code>create</code>

<code> </code><code>@post</code> <code>=</code><code> </code><code>Post.find(params[:post_id])</code>

<code> </code><code>@comment</code> <code>=</code><code> </code><code>@post.comments.create(params[:comment])</code>

<code> </code><code>redirect_to</code><code> </code><code>post_path(@post)</code>

<code> </code><code>end</code>

<code>end</code>

You’ll see a bit more complexity here than you did in the controller for posts.<span style="font-family: DejaVu Sans;">这里你看到的会比你在</span>controller<span style="font-family: DejaVu Sans;">中为</span>posts<span style="font-family: DejaVu Sans;">做的要复杂点。</span>That’s a side-effect of the nesting that you’ve set up; each request for a comment has to keep track#<span style="font-family: DejaVu Sans;">踪迹</span>of the post to which the comment is attached, thus the initial find action to the Post model to get the post in question.<span style="font-family: DejaVu Sans;">那就是你刚刚你刚补充的副作用的根源；每个面向</span>comment<span style="font-family: DejaVu Sans;">的请求都保持了它所依附的</span>post<span style="font-family: DejaVu Sans;">的踪迹，因此这样初始化</span>find action<span style="font-family: DejaVu Sans;">的时候匹配相应的</span>post model<span style="font-family: DejaVu Sans;">（时）得到了答案。</span>

In addition, the code takes advantage of some of the methods available for an association.<span style="font-family: DejaVu Sans;">此外，上面的代码带来的好处就是使得一些对于</span>association<span style="font-family: DejaVu Sans;">的方法可用。</span>We use the <tt>create</tt> method on <tt>@post.comments</tt> to create and save the comment.<span style="font-family: DejaVu Sans;">我们使用</span><tt>@post.comments</tt><span style="font-family: DejaVu Sans;"><tt>中的</tt></span>create<span style="font-family: DejaVu Sans;">方法来新建和保存</span>comment<span style="font-family: DejaVu Sans;">。</span>This will automatically link the comment so that it belongs to that particular post.<span style="font-family: DejaVu Sans;">这里将会自动连接到</span>link<span style="font-family: DejaVu Sans;">使得</span>comment<span style="font-family: DejaVu Sans;">依附于指定的</span>post<span style="font-family: DejaVu Sans;">。</span>

Once we have made the new comment, we send the user back to the original post using the <tt>post_path(@post)</tt> helper.<span style="font-family: DejaVu Sans;">一旦我们评论过后，我们使用</span>post_path(@post)<span style="font-family: DejaVu Sans;">助手导引用户到先前的</span>post<span style="font-family: DejaVu Sans;">。</span>As we have already seen, this calls the <tt>show</tt> action of the <tt>PostsController</tt> which in turn renders the <tt>show.html.erb</tt> template. <span style="font-family: DejaVu Sans;">正如我们已经看到的，这里调用</span>PostsController<span style="font-family: DejaVu Sans;">的</span>show action<span style="font-family: DejaVu Sans;">它将反过来渲染</span><tt>show.html.erb</tt><tt> </tt><span style="font-family: DejaVu Sans;"><tt>模板。</tt></span>This is where we want the comment to show, so let’s add that to the <tt>app/views/posts/show.html.erb</tt>.<span style="font-family: DejaVu Sans;">这里也是我们想让</span>comment<span style="font-family: DejaVu Sans;">显示的地方，因此让我们添加（那些代码）到</span><tt>app/views/posts/show.html.erb</tt><span style="font-family: DejaVu Sans;"><tt>。</tt></span>

&lt;p&gt;&lt;%= notice %&gt;&lt;/p&gt;

&nbsp;

&lt;p&gt;

&lt;b&gt;Name:&lt;/b&gt;

&lt;%= @post.name %&gt;

&lt;/p&gt;

&nbsp;

&lt;p&gt;

&lt;b&gt;Title:&lt;/b&gt;

&lt;%= @post.title %&gt;

&lt;/p&gt;

&nbsp;

&lt;p&gt;

&lt;b&gt;Content:&lt;/b&gt;

&lt;%= @post.content %&gt;

&lt;/p&gt;

&nbsp;

&lt;h2&gt;Comments&lt;/h2&gt;

&lt;% @post.comments.each do |comment| %&gt;

&lt;p&gt;

&lt;b&gt;Commenter:&lt;/b&gt;

&lt;%= comment.commenter %&gt;

&lt;/p&gt;

&nbsp;

&lt;p&gt;

&lt;b&gt;Comment:&lt;/b&gt;

&lt;%= comment.body %&gt;

&lt;/p&gt;

&lt;% end %&gt;

&nbsp;

&lt;h2&gt;Add a comment:&lt;/h2&gt;

&lt;%= form_for([@post, @post.comments.build]) do |f| %&gt;

&lt;div&gt;

&lt;%= f.label :commenter %&gt;&lt;br /&gt;

&lt;%= f.text_field :commenter %&gt;

&lt;/div&gt;

&lt;div&gt;

&lt;%= f.label :body %&gt;&lt;br /&gt;

&lt;%= f.text_area :body %&gt;

&lt;/div&gt;

&lt;div&gt;

&lt;%= f.submit %&gt;

&lt;/div&gt;

&lt;% end %&gt;

&nbsp;

&lt;br /&gt;

&nbsp;

&lt;%= link_to 'Edit Post', edit_post_path(@post) %&gt; |

&lt;%= link_to 'Back to Posts', posts_path %&gt; |

Now you can add posts and comments to your blog and have them show up in the right places.<span style="font-family: DejaVu Sans;">现在你可以添加</span>posts<span style="font-family: DejaVu Sans;">和</span>comments<span style="font-family: DejaVu Sans;">到你的</span>blog<span style="font-family: DejaVu Sans;">同时随后他们会在相应的地方显示出来。</span>
<h3><a name="refactoring"></a>8 Refactoring<span style="font-family: WenQuanYi Micro Hei;">重构</span></h3>
Now that we have Posts and Comments working, if we take a look at the <tt>app/views/posts/show.html.erb</tt> template, it’s getting long and awkward. <span style="font-family: DejaVu Sans;"><span style="font-family: Liberation Serif,Times New Roman,serif;">现在我们已经有</span></span>Posts<span style="font-family: DejaVu Sans;"><span style="font-family: Liberation Serif,Times New Roman,serif;">和</span></span>Comments<span style="font-family: DejaVu Sans;"><span style="font-family: Liberation Serif,Times New Roman,serif;">开始工作了，如果我们注意一下</span></span><tt>app/views/posts/show.html.erb</tt> <span style="font-family: DejaVu Sans;"><span style="font-family: Liberation Serif,Times New Roman,serif;">模板，发现它变得太长而且很别扭。</span></span>We can use partials to clean this up.<span style="font-family: DejaVu Sans;">我们可以使用</span>partials<span style="font-family: DejaVu Sans;">来整理它。</span>
<h4><a name="rendering-partial-collections"></a>8.1 Rendering Partial<span style="font-family: WenQuanYi Micro Hei;">（局部）</span>Collections</h4>
First we will make a comment partial to extract showing all the comments for the post. <span style="font-family: DejaVu Sans;">首先我们会创建一个</span>comment partial<span style="font-family: DejaVu Sans;">来专门显示</span>post<span style="font-family: DejaVu Sans;">的所有的</span>comments<span style="font-family: DejaVu Sans;">。</span>Create the file <tt>app/views/comments/_comment.html.erb</tt> and put the following into it:<span style="font-family: DejaVu Sans;">创建</span><tt>app/views/comments/_comment.html.erb</tt><span style="font-family: DejaVu Sans;"><tt>文件并输入下面的代码：</tt></span>

<code>&lt;p&gt;</code>

<code> </code><code>&lt;b&gt;Commenter:&lt;/b&gt;</code>

<code> </code><code>&lt;%=</code> <code>comment.commenter</code><code> </code><code>%&gt;</code>

<code>&lt;/p&gt;</code>

&nbsp;

<code>&lt;p&gt;</code>

<code> </code><code>&lt;b&gt;Comment:&lt;/b&gt;</code>

<code> </code><code>&lt;%=</code> <code>comment.body</code><code> </code><code>%&gt;</code>

<code>&lt;/p&gt;</code>

<tt>Then</tt><tt> </tt><tt>in</tt><tt> </tt><tt>the</tt><tt> </tt><tt>app/views/posts/show.html.erb</tt><tt> </tt><tt>you</tt><tt> </tt><tt>can</tt><tt> </tt><tt>change</tt><tt> </tt><tt>it</tt><tt> </tt><tt>to</tt><tt> </tt><tt>look</tt><tt> </tt><tt>like</tt><tt> </tt><tt>the</tt><tt> </tt><tt>following:</tt><span style="font-family: DejaVu Sans;"><tt>然后在</tt><tt></tt></span><tt>app/views/posts/show.html.erb</tt><span style="font-family: DejaVu Sans;"><tt>你可以相应的这样更改：</tt></span>

<code>&lt;p</code><tt> </tt><code>class="notice"&gt;&lt;%=</code><tt> </tt><code>notice</code><code> </code><code>%&gt;&lt;/p&gt;</code>

&nbsp;

<code>&lt;p&gt;</code>

<code> </code><code>&lt;b&gt;Name:&lt;/b&gt;</code>

<code> </code><code>&lt;%=</code> <code>@post.name</code><code> </code><code>%&gt;</code>

<code>&lt;/p&gt;</code>

&nbsp;

<code>&lt;p&gt;</code>

<code> </code><code>&lt;b&gt;Title:&lt;/b&gt;</code>

<code> </code><code>&lt;%=</code> <code>@post.title</code><code> </code><code>%&gt;</code>

<code>&lt;/p&gt;</code>

&nbsp;

<code>&lt;p&gt;</code>

<code> </code><code>&lt;b&gt;Content:&lt;/b&gt;</code>

<code> </code><code>&lt;%=</code> <code>@post.content</code><code> </code><code>%&gt;</code>

<code>&lt;/p&gt;</code>

&nbsp;

<code>&lt;h2&gt;Comments&lt;/h2&gt;</code>

<code>&lt;%=</code> <code>render</code><code> </code><code>@post.comments</code><code> </code><code>%&gt;</code>

&nbsp;

<code>&lt;h2&gt;Add</code><code> </code><code>a</code><code> </code><code>comment:&lt;/h2&gt;</code>

<code>&lt;%=</code> <code>form_for([@post,</code><code> </code><code>@post.comments.build])</code><code> </code><code>do</code> <code>|f|</code><code> </code><code>%&gt;</code>

<code> </code><code>&lt;div</code> <code>class="field"&gt;</code>

<code> </code><code>&lt;%=</code> <code>f.label</code><code> </code><code>:commenter</code> <code>%&gt;&lt;br</code> <code>/&gt;</code>

<code> </code><code>&lt;%=</code> <code>f.text_field</code><code> </code><code>:commenter</code> <code>%&gt;</code>

<code> </code><code>&lt;/div&gt;</code>

<code> </code><code>&lt;div</code> <code>class="field"&gt;</code>

<code> </code><code>&lt;%=</code> <code>f.label</code><code> </code><code>:body</code> <code>%&gt;&lt;br</code> <code>/&gt;</code>

<code> </code><code>&lt;%=</code> <code>f.text_area</code><code> </code><code>:body</code> <code>%&gt;</code>

<code> </code><code>&lt;/div&gt;</code>

<code> </code><code>&lt;div</code> <code>class="actions"&gt;</code>

<code> </code><code>&lt;%=</code> <code>f.submit</code><code> </code><code>%&gt;</code>

<code> </code><code>&lt;/div&gt;</code>

<code>&lt;%</code> <code>end</code> <code>%&gt;</code>

&nbsp;

<code>&lt;br</code> <code>/&gt;</code>

&nbsp;

<code>&lt;%=</code> <code>link_to</code><code> </code><code>'Edit</code><code> </code><code>Post',</code><code> </code><code>edit_post_path(@post)</code><code> </code><code>%&gt;</code> <code>|</code>

<code>&lt;%=</code> <code>link_to</code><code> </code><code>'Back</code><code> </code><code>to</code><code> </code><code>Posts',</code><code> </code><code>posts_path</code><code> </code><code>%&gt;</code> <code>|</code>

<tt>This</tt><tt> </tt><tt>will</tt><tt> </tt><tt>now</tt><tt> </tt><tt>render</tt><tt> </tt><tt>the</tt><tt> </tt><tt>partial</tt><tt> </tt><tt>in</tt><tt> </tt><tt>app/views/comments/_comment.html.erb</tt><tt> </tt><tt>once</tt><tt> </tt><tt>for</tt><tt> </tt><tt>each</tt><tt> </tt><tt>comment</tt><tt> </tt><tt>that</tt><tt> </tt><tt>is</tt><tt> </tt><tt>in</tt><tt> </tt><tt>the</tt><tt> </tt><tt>@post.comments</tt><tt> </tt><tt>collection.</tt><span style="font-family: DejaVu Sans;"><tt>这里会对</tt></span><tt>@post.comments</tt><span style="font-family: DejaVu Sans;"><tt>的每一个</tt></span><tt>comment</tt><span style="font-family: DejaVu Sans;"><tt>渲染</tt><tt></tt></span><tt>app/views/comments/_comment.html.erb</tt><span style="font-family: DejaVu Sans;"><tt>模板。</tt><tt></tt></span><tt>As</tt><tt> </tt><tt>the</tt><tt> </tt><tt>render</tt><tt> </tt><tt>method</tt><tt> </tt><tt>iterates</tt><tt> </tt><tt>over</tt><tt> </tt><tt>the</tt><tt> </tt><tt>@post.comments</tt><tt> </tt><tt>collection,</tt><tt> </tt><tt>it</tt><tt> </tt><tt>assigns</tt><tt> </tt><tt>each</tt><tt> </tt><tt>comment</tt><tt> </tt><tt>to</tt><tt> </tt><tt>a</tt><tt> </tt><tt>local</tt><tt> </tt><tt>variable</tt><tt> </tt><tt>named</tt><tt> </tt><tt>the</tt><tt> </tt><tt>same</tt><tt> </tt><tt>as</tt><tt> </tt><tt>the</tt><tt> </tt><tt>partial,</tt><tt> </tt><tt>in</tt><tt> </tt><tt>this</tt><tt> </tt><tt>case</tt><tt> </tt><tt>comment</tt><tt> </tt><tt>which</tt><tt> </tt><tt>is</tt><tt> </tt><tt>then</tt><tt> </tt><tt>available</tt><tt> </tt><tt>in</tt><tt> </tt><tt>the</tt><tt> </tt><tt>partial</tt><tt> </tt><tt>for</tt><tt> </tt><tt>us</tt><tt> </tt><tt>to</tt><tt> </tt><tt>show.</tt><span style="font-family: DejaVu Sans;"><tt>当渲染方法迭代</tt></span><tt>@post.comments</tt><span style="font-family: DejaVu Sans;"><tt>收集器的时候，它声明每个</tt></span><tt>comment</tt><span style="font-family: DejaVu Sans;"><tt>为本地变量命名和</tt></span><tt>partial</tt><span style="font-family: DejaVu Sans;"><tt>相同（这里为</tt></span><tt>comment</tt><span style="font-family: DejaVu Sans;"><tt>），通过这样在</tt></span><tt>partial</tt><span style="font-family: DejaVu Sans;"><tt>中的</tt></span><tt>comment</tt><span style="font-family: DejaVu Sans;"><tt>就可以显示给我们的用户了。</tt></span>
<h4><a name="rendering-a-partial-form"></a><tt>8.2</tt><tt> </tt><tt>Rendering</tt><tt> </tt><tt>a</tt><tt> </tt><tt>Partial</tt><tt> </tt><tt>Form</tt></h4>
<tt>Let</tt><tt>’</tt><tt>s</tt><tt> </tt><tt>also</tt><tt> </tt><tt>move</tt><tt> </tt><tt>that</tt><tt> </tt><tt>new</tt><tt> </tt><tt>comment</tt><tt> </tt><tt>section</tt><tt> </tt><tt>out</tt><tt> </tt><tt>to</tt><tt> </tt><tt>its</tt><tt> </tt><tt>own</tt><tt> </tt><tt>partial.</tt><span style="font-family: DejaVu Sans;"><tt>同样让我们移动</tt></span><tt>new</tt><tt> </tt><tt>comment</tt><span style="font-family: DejaVu Sans;"><tt>部分到它自己的地方吧。</tt><tt></tt></span><tt>Again,</tt><tt> </tt><tt>you</tt><tt> </tt><tt>create</tt><tt> </tt><tt>a</tt><tt> </tt><tt>file</tt><tt> </tt><tt>app/views/comments/_form.html.erb</tt><tt> </tt><tt>and</tt><tt> </tt><tt>in</tt><tt> </tt><tt>it</tt><tt> </tt><tt>you</tt><tt> </tt><tt>put:</tt><span style="font-family: DejaVu Sans;"><tt>类似的，创建一个文件</tt><tt></tt></span><tt>app/views/comments/_form.html.erb</tt><span style="font-family: DejaVu Sans;"><tt>并且在里面放入下面代码：</tt></span>

<code>&lt;%=</code><tt> </tt><code>form_for([@post,</code><code> </code><code>@post.comments.build])</code><code> </code><code>do</code><tt> </tt><code>|f|</code><code> </code><code>%&gt;</code>

<code> </code><code>&lt;div</code> <code>class="field"&gt;</code>

<code> </code><code>&lt;%=</code> <code>f.label</code><code> </code><code>:commenter</code> <code>%&gt;&lt;br</code> <code>/&gt;</code>

<code> </code><code>&lt;%=</code> <code>f.text_field</code><code> </code><code>:commenter</code> <code>%&gt;</code>

<code> </code><code>&lt;/div&gt;</code>

<code> </code><code>&lt;div</code> <code>class="field"&gt;</code>

<code> </code><code>&lt;%=</code> <code>f.label</code><code> </code><code>:body</code> <code>%&gt;&lt;br</code> <code>/&gt;</code>

<code> </code><code>&lt;%=</code> <code>f.text_area</code><code> </code><code>:body</code> <code>%&gt;</code>

<code> </code><code>&lt;/div&gt;</code>

<code> </code><code>&lt;div</code> <code>class="actions"&gt;</code>

<code> </code><code>&lt;%=</code> <code>f.submit</code><code> </code><code>%&gt;</code>

<code> </code><code>&lt;/div&gt;</code>

<code>&lt;%</code> <code>end</code> <code>%&gt;</code>

<tt>Then</tt><tt> </tt><tt>you</tt><tt> </tt><tt>make</tt><tt> </tt><tt>the</tt><tt> </tt><tt>app/views/posts/show.html.erb</tt><tt> </tt><tt>look</tt><tt> </tt><tt>like</tt><tt> </tt><tt>the</tt><tt> </tt><tt>following:</tt><span style="font-family: DejaVu Sans;"><tt>接着你这样修改</tt><tt></tt></span><tt>app/views/posts/show.html.erb</tt><span style="font-family: DejaVu Sans;"><tt>文件：</tt></span>

<code>&lt;p</code><tt> </tt><code>class="notice"&gt;&lt;%=</code><tt> </tt><code>notice</code><code> </code><code>%&gt;&lt;/p&gt;</code>

&nbsp;

<code>&lt;p&gt;</code>

<code> </code><code>&lt;b&gt;Name:&lt;/b&gt;</code>

<code> </code><code>&lt;%=</code> <code>@post.name</code><code> </code><code>%&gt;</code>

<code>&lt;/p&gt;</code>

&nbsp;

<code>&lt;p&gt;</code>

<code> </code><code>&lt;b&gt;Title:&lt;/b&gt;</code>

<code> </code><code>&lt;%=</code> <code>@post.title</code><code> </code><code>%&gt;</code>

<code>&lt;/p&gt;</code>

&nbsp;

<code>&lt;p&gt;</code>

<code> </code><code>&lt;b&gt;Content:&lt;/b&gt;</code>

<code> </code><code>&lt;%=</code> <code>@post.content</code><code> </code><code>%&gt;</code>

<code>&lt;/p&gt;</code>

&nbsp;

<code>&lt;h2&gt;Comments&lt;/h2&gt;</code>

<code>&lt;%=</code> <code>render</code><code> </code><code>@post.comments</code><code> </code><code>%&gt;</code>

&nbsp;

<code>&lt;h2&gt;Add</code><code> </code><code>a</code><code> </code><code>comment:&lt;/h2&gt;</code>

<code>&lt;%=</code> <code>render</code><code> </code><code>"comments/form"</code> <code>%&gt;</code>

&nbsp;

<code>&lt;br</code> <code>/&gt;</code>

&nbsp;

<code>&lt;%=</code> <code>link_to</code><code> </code><code>'Edit</code><code> </code><code>Post',</code><code> </code><code>edit_post_path(@post)</code><code> </code><code>%&gt;</code> <code>|</code>

<code>&lt;%=</code> <code>link_to</code><code> </code><code>'Back</code><code> </code><code>to</code><code> </code><code>Posts',</code><code> </code><code>posts_path</code><code> </code><code>%&gt;</code> <code>|</code>

<tt>The</tt><tt> </tt><tt>second</tt><tt> </tt><tt>render</tt><tt> </tt><tt>just</tt><tt> </tt><tt>defines</tt><tt> </tt><tt>the</tt><tt> </tt><tt>partial</tt><tt> </tt><tt>template</tt><tt> </tt><tt>we</tt><tt> </tt><tt>want</tt><tt> </tt><tt>to</tt><tt> </tt><tt>render,</tt><tt> </tt><tt>comments/form,</tt><tt> </tt><tt>Rails</tt><tt> </tt><tt>is</tt><tt> </tt><tt>smart</tt><tt> </tt><tt>enough</tt><tt> </tt><tt>to</tt><tt> </tt><tt>spot</tt><tt> </tt><tt>the</tt><tt> </tt><tt>forward</tt><tt> </tt><tt>slash</tt><tt> </tt><tt>in</tt><tt> </tt><tt>that</tt><tt> </tt><tt>string</tt><tt> </tt><tt>and</tt><tt> </tt><tt>realize</tt><tt> </tt><tt>that</tt><tt> </tt><tt>you</tt><tt> </tt><tt>want</tt><tt> </tt><tt>to</tt><tt> </tt><tt>render</tt><tt> </tt><tt>the</tt><tt> </tt><tt>_form.html.erb</tt><tt> </tt><tt>file</tt><tt> </tt><tt>in</tt><tt> </tt><tt>the</tt><tt> </tt><tt>app/views/comments</tt><tt> </tt><tt>directory.</tt><span style="font-family: DejaVu Sans;"><tt>第二个</tt></span><tt>render</tt><span style="font-family: DejaVu Sans;"><tt>仅仅定义了一个我们想渲染的</tt></span><tt>partial</tt><tt> </tt><tt>template</tt><tt> </tt><tt>comments/form</tt><span style="font-family: DejaVu Sans;"><tt>，</tt></span><tt>Rails</tt><span style="font-family: DejaVu Sans;"><tt>可以智能的识别字符串代表的含义，并且知道你是想</tt></span><tt>render</tt><tt> </tt><tt>_form.html.erb</tt><span style="font-family: DejaVu Sans;"><tt>模板。</tt></span>

The <tt>@post</tt> object is available to any partials rendered in the view because we defined it as an instance variable.@post<span style="font-family: DejaVu Sans;">可以在任何的视图中</span>partials rendered<span style="font-family: DejaVu Sans;">，因为我们把它定义成的实例变量。</span>
<h3><a name="deleting-comments"></a><tt>9</tt><tt> </tt><tt>Deleting</tt><tt> </tt><tt>Comments</tt></h3>
Another important feature on a blog is being able to delete SPAM comments.<span style="font-family: DejaVu Sans;">另一个重要的功能就是可以删除垃圾评论。</span>To do this, we need to implement a link of some sort in the view and a <tt>DELETE</tt> action in the <tt>CommentsController</tt>.<span style="font-family: DejaVu Sans;">要达到这样的效果，我们需要在</span>view<span style="font-family: DejaVu Sans;">中实现某种链接和在</span>CommentsController<span style="font-family: DejaVu Sans;">中的</span>DELETE<span style="font-family: DejaVu Sans;">动作。</span>

<tt>So</tt><tt> </tt><tt>first,</tt><tt> </tt><tt>let</tt><tt>’</tt><tt>s</tt><tt> </tt><tt>add</tt><tt> </tt><tt>the</tt><tt> </tt><tt>delete</tt><tt> </tt><tt>link</tt><tt> </tt><tt>in</tt><tt> </tt><tt>the</tt><tt> </tt><tt>app/views/comments/_comment.html.erb</tt><tt> </tt><tt>partial:</tt><span style="font-family: DejaVu Sans;"><tt>首先，在</tt></span><tt>app/views/comments/_comment.html.erb</tt><tt> </tt><tt>partial</tt><span style="font-family: DejaVu Sans;"><tt>中添加</tt></span><tt>delete</tt><tt> </tt><tt>link</tt><span style="font-family: DejaVu Sans;"><tt>：</tt></span>

<code>&lt;p&gt;</code>

<code> </code><code>&lt;b&gt;Commenter:&lt;/b&gt;</code>

<code> </code><code>&lt;%=</code> <code>comment.commenter</code><code> </code><code>%&gt;</code>

<code>&lt;/p&gt;</code>

&nbsp;

<code>&lt;p&gt;</code>

<code> </code><code>&lt;b&gt;Comment:&lt;/b&gt;</code>

<code> </code><code>&lt;%=</code> <code>comment.body</code><code> </code><code>%&gt;</code>

<code>&lt;/p&gt;</code>

&nbsp;

<code>&lt;p&gt;</code>

<code> </code><code>&lt;%=</code> <code>link_to</code><code> </code><code>'Destroy</code><code> </code><code>Comment',</code><code> </code><code>[comment.post,</code><code> </code><code>comment],</code>

<code> </code><code>:confirm</code> <code>=&gt;</code><code> </code><code>'Are</code><code> </code><code>you</code><code> </code><code>sure?',</code>

<code> </code><code>:method</code> <code>=&gt;</code><code> </code><code>:delete</code> <code>%&gt;</code>

<code>&lt;/p&gt;</code>

Clicking this new “Destroy Comment” link will fire off a <tt>DELETE</tt><tt> </tt><tt>/posts/:id/comments/:id</tt> to our <tt>CommentsController</tt>, which can then use this to find the comment we want to delete, so let’s add a destroy action to our controller:<span style="font-family: DejaVu Sans;">点击<span style="font-family: Liberation Serif,Times New Roman,serif;">“</span></span>Destroy Comment”<span style="font-family: DejaVu Sans;">，</span>link<span style="font-family: DejaVu Sans;">将会发送</span><tt>DELETE</tt><tt> </tt><tt>/posts/:id/comments/:id</tt><span style="font-family: DejaVu Sans;"><tt>到我们的</tt></span><tt>CommentsController</tt><span style="font-family: DejaVu Sans;"><tt>，</tt></span><tt>CommentsController</tt><span style="font-family: DejaVu Sans;"><tt>将会利用刚刚收到的（消息）找到我们想删除哪条评论，因此让我们接着添加一个</tt></span><tt>destroy</tt><tt> </tt><tt>action</tt><span style="font-family: DejaVu Sans;"><tt>到我们的</tt></span><tt>controller</tt><span style="font-family: DejaVu Sans;"><tt>：</tt></span>

<code>class</code><tt> </tt><code>CommentsController</code><code> </code><code>&lt;</code><code> </code><code>ApplicationController</code>

&nbsp;

<code> </code><code>def</code> <code>create</code>

<code> </code><code>@post</code> <code>=</code><code> </code><code>Post.find(params[:post_id])</code>

<code> </code><code>@comment</code> <code>=</code><code> </code><code>@post.comments.create(params[:comment])</code>

<code> </code><code>redirect_to</code><code> </code><code>post_path(@post)</code>

<code> </code><code>end</code>

&nbsp;

<code> </code><code>def</code> <code>destroy</code>

<code> </code><code>@post</code> <code>=</code><code> </code><code>Post.find(params[:post_id])</code>

<code> </code><code>@comment</code> <code>=</code><code> </code><code>@post.comments.find(params[:id])</code>

<code> </code><code>@comment.destroy</code>

<code> </code><code>redirect_to</code><code> </code><code>post_path(@post)</code>

<code> </code><code>end</code>

&nbsp;

<code>end</code>

<tt>The</tt><tt> </tt><tt>destroy</tt><tt> </tt><tt>action</tt><tt> </tt><tt>will</tt><tt> </tt><tt>find</tt><tt> </tt><tt>the</tt><tt> </tt><tt>post</tt><tt> </tt><tt>we</tt><tt> </tt><tt>are</tt><tt> </tt><tt>looking</tt><tt> </tt><tt>at,</tt><tt> </tt><tt>locate</tt><tt> </tt><tt>the</tt><tt> </tt><tt>comment</tt><tt> </tt><tt>within</tt><tt> </tt><tt>the</tt><tt> </tt><tt>@post.comments</tt><tt> </tt><tt>collection,</tt><tt> </tt><tt>and</tt><tt> </tt><tt>then</tt><tt> </tt><tt>remove</tt><tt> </tt><tt>it</tt><tt> </tt><tt>from</tt><tt> </tt><tt>the</tt><tt> </tt><tt>database</tt><tt> </tt><tt>and</tt><tt> </tt><tt>send</tt><tt> </tt><tt>us</tt><tt> </tt><tt>back</tt><tt> </tt><tt>to</tt><tt> </tt><tt>the</tt><tt> </tt><tt>show</tt><tt> </tt><tt>action</tt><tt> </tt><tt>for</tt><tt> </tt><tt>the</tt><tt> </tt><tt>post.destroy</tt><tt> </tt><tt>action</tt><span style="font-family: DejaVu Sans;"><tt>将会找到那个我们正在阅读的</tt></span><tt>post</tt><span style="font-family: DejaVu Sans;"><tt>，并且定位</tt></span><tt>comment</tt><span style="font-family: DejaVu Sans;"><tt>在</tt></span><tt>@post.comments</tt><span style="font-family: DejaVu Sans;"><tt>收集器，然后从数据库</tt></span><tt>remove</tt><span style="font-family: DejaVu Sans;"><tt>它，最后传回到</tt></span><tt>post</tt><span style="font-family: DejaVu Sans;"><tt>的</tt></span><tt>show</tt><tt> </tt><tt>action</tt><span style="font-family: DejaVu Sans;"><tt>。</tt></span>
<h4><a name="deleting-associated-objects"></a><tt>9.1</tt><tt> </tt><tt>Deleting</tt><tt> </tt><tt>Associated</tt><tt> </tt><tt>Objects</tt><span style="font-family: WenQuanYi Micro Hei;"><tt>删除关联对象</tt></span></h4>
<a name="deleting-associated-objects1"></a>If you delete a post then its associated comments will also need to be deleted. <span style="font-family: DejaVu Sans;">如果你删除一个了</span>post<span style="font-family: DejaVu Sans;">，那么与之相关联的</span>comments<span style="font-family: DejaVu Sans;">也需要被删除。</span>Otherwise they would simply occupy space in the database.<span style="font-family: DejaVu Sans;">否则他们将会只是在数据库中占用空间（别无它用）。</span>Rails allows you to use the <tt>dependent</tt> option of an association to achieve this. Modify the Post model, <tt>app/models/post.rb</tt>, as follows:Rails<span style="font-family: DejaVu Sans;">允许你通过关系的依赖选项完成（上述功能）。修改</span>Post model<span style="font-family: DejaVu Sans;">。</span>

<code>class</code> <code>Post</code><code> </code><code>&lt;</code><code> </code><code>ActiveRecord::Base</code>

<code> </code><code>validates</code><code> </code><code>:name,</code><code> </code><code>:presence</code> <code>=&gt;</code><code> </code><code>true</code>

<code> </code><code>validates</code><code> </code><code>:title,</code><code> </code><code>:presence</code> <code>=&gt;</code><code> </code><code>true,</code>

<code> </code><code>:length</code> <code>=&gt;</code><code> </code><code>{</code><code> </code><code>:minimum</code> <code>=&gt;</code><code> </code><code>5</code> <code>}</code>

<code> </code><code>has_many</code><code> </code><code>:comments,</code><code> </code><code>:dependent</code> <code>=&gt;</code><code> </code><code>:destroy</code>

<code>end</code>
<h3><a name="security"></a>10 Security</h3>
If you were to publish your blog online, anybody would be able to add, edit and delete posts or delete comments.<span style="font-family: DejaVu Sans;">如果你就这样</span>publish<span style="font-family: DejaVu Sans;">你的</span>blog<span style="font-family: DejaVu Sans;">在互联网，任何人都可以添加，编辑和删除</span>post<span style="font-family: DejaVu Sans;">或者删除</span>comments<span style="font-family: DejaVu Sans;">。</span>

Rails provides a very simple HTTP authentication system that will work nicely in this situation.Rails<span style="font-family: DejaVu Sans;">提供了一个非常简单的</span>HTTP<span style="font-family: DejaVu Sans;">认证系统在这样的情况下会非常适合。</span>

In the <tt>PostsController</tt> we need to have a way to block access to the various actions if the person is not authenticated, here we can use the Rails <tt>http_basic_authenticate_with</tt> method, allowing access to the requested action if that method allows it.<span style="font-family: DejaVu Sans;">在</span><tt>PostsController</tt><span style="font-family: DejaVu Sans;"><tt>中我们需要一个方法来阻止没有通过认证的用户的操作，这里我们可以使用</tt></span><tt>Rails</tt><span style="font-family: DejaVu Sans;"><tt>的</tt><tt></tt></span><tt>http_basic_authenticate_with</tt><span style="font-family: DejaVu Sans;"><tt>这个方法，准许方法允许的请求的</tt></span><tt>action</tt><span style="font-family: DejaVu Sans;"><tt>。</tt></span>

To use the authentication system, we specify it at the top of our <tt>PostsController</tt>, in this case, we want the user to be authenticated on every action, except for <tt>index</tt> and <tt>show</tt>, so we write that:<span style="font-family: DejaVu Sans;">要是用这个认证系统，我们需要在</span><tt>PostsController</tt><tt> </tt><span style="font-family: DejaVu Sans;"><tt>的顶部</tt>在指定（即引用）它，这样我们希望用户在进行每个</span>action<span style="font-family: DejaVu Sans;">的时候都是通过授权的，除了</span>index<span style="font-family: DejaVu Sans;">和</span>show<span style="font-family: DejaVu Sans;">，因此我们这样写：</span>

<code>class</code> <code>PostsController</code><code> </code><code>&lt;</code><code> </code><code>ApplicationController</code>

&nbsp;

<code> </code><code>http_basic_authenticate_with</code><code> </code><code>:name</code> <code>=&gt;</code><code> </code><code>"dhh",</code><code> </code><code>:password</code> <code>=&gt;</code><code> </code><code>"secret",</code><code> </code><code>:except</code> <code>=&gt;</code><code> </code><code>:index</code>

&nbsp;

<code> </code><code>#</code><code> </code><code>GET</code><code> </code><code>/posts</code>

<code> </code><code>#</code><code> </code><code>GET</code><code> </code><code>/posts.json</code>

<code> </code><code>def</code> <code>index</code>

<code> </code><code>@posts</code> <code>=</code><code> </code><code>Post.all</code>

We also only want to allow authenticated users to delete comments, so in the <tt>CommentsController</tt> we write:<span style="font-family: DejaVu Sans;">我们同样希望只有授权用户能够删除评论，因此在</span><tt>CommentsController</tt><span style="font-family: DejaVu Sans;"><tt>这样写：</tt></span>

<code>class</code><tt> </tt><code>CommentsController</code><code> </code><code>&lt;</code><code> </code><code>ApplicationController</code>

&nbsp;

<code> </code><code>http_basic_authenticate_with</code><code> </code><code>:name</code> <code>=&gt;</code><code> </code><code>"dhh",</code><code> </code><code>:password</code> <code>=&gt;</code><code> </code><code>"secret",</code><code> </code><code>:only</code> <code>=&gt;</code><code> </code><code>:destroy</code>

&nbsp;

<code> </code><code>def</code> <code>create</code>

<code> </code><code>@post</code> <code>=</code><code> </code><code>Post.find(params[:post_id])</code>

<tt>Now</tt><tt> </tt><tt>if</tt><tt> </tt><tt>you</tt><tt> </tt><tt>try</tt><tt> </tt><tt>to</tt><tt> </tt><tt>create</tt><tt> </tt><tt>a</tt><tt> </tt><tt>new</tt><tt> </tt><tt>post,</tt><tt> </tt><tt>you</tt><tt> </tt><tt>will</tt><tt> </tt><tt>be</tt><tt> </tt><tt>greeted</tt><tt> </tt><tt>with</tt><tt> </tt><tt>a</tt><tt> </tt><tt>basic</tt><tt> </tt><tt>HTTP</tt><tt> </tt><tt>Authentication</tt><tt> </tt><tt>challenge.</tt><span style="font-family: DejaVu Sans;"><tt>现在如果你尝试创建一个新的</tt></span><tt>post</tt><span style="font-family: DejaVu Sans;"><tt>，你将会迎来一个基于</tt></span><tt>HTTP</tt><span style="font-family: DejaVu Sans;"><tt>认证的挑战。</tt></span>
<h3><a name="building-a-multi-model-form"></a>11 Building a Multi-Model Form<span style="font-family: WenQuanYi Micro Hei;">构建一个多模型表单</span></h3>
Another feature of your average blog is the ability to tag posts. To implement this feature your application needs to interact with more than one model on a single form. Rails offers support for nested forms.<span style="font-family: DejaVu Sans;">另一个功能你的平衡的</span>blog<span style="font-family: DejaVu Sans;">是能够给</span>posts<span style="font-family: DejaVu Sans;">添加</span>tag<span style="font-family: DejaVu Sans;">。要想在你的程序中实现这个功能需要在一个</span>form<span style="font-family: DejaVu Sans;">中与超过一个</span>model<span style="font-family: DejaVu Sans;">互动。</span>Rails<span style="font-family: DejaVu Sans;">提供了嵌套</span>forms<span style="font-family: DejaVu Sans;">。</span>

To demonstrate this, we will add support for giving each post multiple tags, right in the form where you create the post. First, create a new model to hold the tags:<span style="font-family: DejaVu Sans;">为了演示这个（功能），你将会在你创建</span>post<span style="font-family: DejaVu Sans;">的</span>form<span style="font-family: DejaVu Sans;">中添加</span>post<span style="font-family: DejaVu Sans;">的多</span>tag<span style="font-family: DejaVu Sans;">支持。首先创建一个</span>new model<span style="font-family: DejaVu Sans;">来存放</span>tags<span style="font-family: DejaVu Sans;">：</span>

<code>$</code><code> </code><code>rails</code><code> </code><code>generate</code><code> </code><code>model</code><code> </code><code>tag</code><code> </code><code>name:string</code><code> </code><code>post:references</code>

Again, run the migration to create the database table:<span style="font-family: DejaVu Sans;">再次运行</span>migration<span style="font-family: DejaVu Sans;">来创建数据库表单：</span>

<code>$</code><code> </code><code>rake</code><code> </code><code>db:migrate</code>

Next, edit the <tt>post.rb</tt> file to create the other side of the association, and to tell Rails (via the <tt>accepts_nested_attributes_for</tt> macro) that you intend to edit tags via posts:<span style="font-family: DejaVu Sans;">接下来：编辑</span>post.rb<span style="font-family: DejaVu Sans;">文件来创建来创建另一个成员，并且告诉</span>Rails<span style="font-family: DejaVu Sans;">（通过</span>the <tt>accepts_nested_attributes_for</tt> <span style="font-family: DejaVu Sans;">宏）你打算通过</span>posts form<span style="font-family: DejaVu Sans;">来编辑</span>tags<span style="font-family: DejaVu Sans;">。</span>

class Post &lt; ActiveRecord::Base

validates :name, :presence =&gt; true

validates :title, :presence =&gt; true

validates :content,:presence =&gt; true,

:length =&gt; { :minimum =&gt; 5 }

&nbsp;

has_many :comments, :dependent =&gt; :destroy

has_many :tags

&nbsp;

accepts_nested_attributes_for :tags, :allow_destroy =&gt; :true,

:reject_if =&gt; proc { |attrs| attrs.all? { |k, v| v.blank? } }

end

<tt>The</tt><tt> </tt><tt>:allow_destroy</tt><tt> </tt><tt>option</tt><tt> </tt><tt>on</tt><tt> </tt><tt>the</tt><tt> </tt><tt>nested</tt><tt> </tt><tt>attribute</tt><tt> </tt><tt>declaration</tt><tt> </tt><tt>tells</tt><tt> </tt><tt>Rails</tt><tt> </tt><tt>to</tt><tt> </tt><tt>display</tt><tt> </tt><tt>a</tt><tt> “</tt><tt>remove</tt><tt>” </tt><tt>checkbox</tt><tt> </tt><tt>on</tt><tt> </tt><tt>the</tt><tt> </tt><tt>view</tt><tt> </tt><tt>that</tt><tt> </tt><tt>you</tt><tt>’</tt><tt>ll</tt><tt> </tt><tt>build</tt><tt> </tt><tt>shortly.</tt><span style="font-family: DejaVu Sans;"><tt>对于</tt></span><tt>:allow_destroy</tt><span style="font-family: DejaVu Sans;"><tt>嵌套属性的声明是告诉</tt></span><tt>Rails</tt><span style="font-family: DejaVu Sans;"><tt>显示一个</tt><tt><span style="font-family: Liberation Serif,Times New Roman,serif;">“</span></tt></span><tt>remove</tt><tt>”</tt><span style="font-family: DejaVu Sans;"><tt>复选框在视图中那样你可以快速创建（</tt></span><tt>tags</tt><span style="font-family: DejaVu Sans;"><tt>）。</tt><tt></tt></span><tt>The</tt><tt> </tt><tt>:reject_if</tt><tt> </tt><tt>option</tt><tt> </tt><tt>prevents</tt><tt> </tt><tt>saving</tt><tt> </tt><tt>new</tt><tt> </tt><tt>tags</tt><tt> </tt><tt>that</tt><tt> </tt><tt>do</tt><tt> </tt><tt>not</tt><tt> </tt><tt>have</tt><tt> </tt><tt>any</tt><tt> </tt><tt>attributes</tt><tt> </tt><tt>filled</tt><tt> </tt><tt>in.</tt><span style="font-family: DejaVu Sans;"><tt>对于</tt></span><tt>:reject_if</tt><span style="font-family: DejaVu Sans;"><tt>保证不保存没有任何内容的</tt></span><tt>tags</tt><span style="font-family: DejaVu Sans;"><tt>。</tt></span>

<tt>We</tt><tt> </tt><tt>will</tt><tt> </tt><tt>modify</tt><tt> </tt><tt>views/posts/_form.html.erb</tt><tt> </tt><tt>to</tt><tt> </tt><tt>render</tt><tt> </tt><tt>a</tt><tt> </tt><tt>partial</tt><tt> </tt><tt>to</tt><tt> </tt><tt>make</tt><tt> </tt><tt>a</tt><tt> </tt><tt>tag:</tt><span style="font-family: DejaVu Sans;"><tt>我们将要修改</tt><tt></tt></span><tt>views/posts/_form.html.erb</tt><span style="font-family: DejaVu Sans;"><tt>来</tt></span><tt>render</tt><span style="font-family: DejaVu Sans;"><tt>（</tt></span><tt>form</tt><span style="font-family: DejaVu Sans;"><tt>的）一部分来创建</tt></span><tt>tag</tt><span style="font-family: DejaVu Sans;"><tt>：</tt></span>

<tt>&lt;%</tt><tt> </tt><tt>@post.tags.build</tt><tt> </tt><tt>%&gt;</tt>

<tt>&lt;%=</tt><tt> </tt><tt>form_for(@post)</tt><tt> </tt><tt>do</tt><tt> </tt><tt>|post_form|</tt><tt> </tt><tt>%&gt;</tt>

<tt> </tt><tt>&lt;%</tt><tt> </tt><tt>if</tt><tt> </tt><tt>@post.errors.any?</tt><tt> </tt><tt>%&gt;</tt>

<tt> </tt><tt>&lt;div</tt><tt> </tt><tt>id="errorExplanation"&gt;</tt>

<tt> </tt><tt>&lt;h2&gt;&lt;%=</tt><tt> </tt><tt>pluralize(@post.errors.count,</tt><tt> </tt><tt>"error")</tt><tt> </tt><tt>%&gt;</tt><tt> </tt><tt>prohibited</tt><tt> </tt><tt>this</tt><tt> </tt><tt>post</tt><tt> </tt><tt>from</tt><tt> </tt><tt>being</tt><tt> </tt><tt>saved:&lt;/h2&gt;</tt>

<tt> </tt><tt>&lt;ul&gt;</tt>

<tt> </tt><tt>&lt;%</tt><tt> </tt><tt>@post.errors.full_messages.each</tt><tt> </tt><tt>do</tt><tt> </tt><tt>|msg|</tt><tt> </tt><tt>%&gt;</tt>

<tt> </tt><tt>&lt;li&gt;&lt;%=</tt><tt> </tt><tt>msg</tt><tt> </tt><tt>%&gt;&lt;/li&gt;</tt>

<tt> </tt><tt>&lt;%</tt><tt> </tt><tt>end</tt><tt> </tt><tt>%&gt;</tt>

<tt> </tt><tt>&lt;/ul&gt;</tt>

<tt> </tt><tt>&lt;/div&gt;</tt>

<tt> </tt><tt>&lt;%</tt><tt> </tt><tt>end</tt><tt> </tt><tt>%&gt;</tt>

&nbsp;

<tt> </tt><tt>&lt;div</tt><tt> </tt><tt>class="field"&gt;</tt>

<tt> </tt><tt>&lt;%=</tt><tt> </tt><tt>post_form.label</tt><tt> </tt><tt>:name</tt><tt> </tt><tt>%&gt;&lt;br</tt><tt> </tt><tt>/&gt;</tt>

<tt> </tt><tt>&lt;%=</tt><tt> </tt><tt>post_form.text_field</tt><tt> </tt><tt>:name</tt><tt> </tt><tt>%&gt;</tt>

<tt> </tt><tt>&lt;/div&gt;</tt>

<tt> </tt><tt>&lt;div</tt><tt> </tt><tt>class="field"&gt;</tt>

<tt> </tt><tt>&lt;%=</tt><tt> </tt><tt>post_form.label</tt><tt> </tt><tt>:title</tt><tt> </tt><tt>%&gt;&lt;br</tt><tt> </tt><tt>/&gt;</tt>

<tt> </tt><tt>&lt;%=</tt><tt> </tt><tt>post_form.text_field</tt><tt> </tt><tt>:title</tt><tt> </tt><tt>%&gt;</tt>

<tt> </tt><tt>&lt;/div&gt;</tt>

<tt> </tt><tt>&lt;div</tt><tt> </tt><tt>class="field"&gt;</tt>

<tt> </tt><tt>&lt;%=</tt><tt> </tt><tt>post_form.label</tt><tt> </tt><tt>:content</tt><tt> </tt><tt>%&gt;&lt;br</tt><tt> </tt><tt>/&gt;</tt>

<tt> </tt><tt>&lt;%=</tt><tt> </tt><tt>post_form.text_area</tt><tt> </tt><tt>:content</tt><tt> </tt><tt>%&gt;</tt>

<tt> </tt><tt>&lt;/div&gt;</tt>

<tt> </tt><tt>&lt;h2&gt;Tags&lt;/h2&gt;</tt>

<tt> </tt><tt>&lt;%=</tt><tt> </tt><tt>render</tt><tt> </tt><tt>:partial</tt><tt> </tt><tt>=&gt;</tt><tt> </tt><tt>'tags/form',</tt>

<tt> </tt><tt>:locals</tt><tt> </tt><tt>=&gt;</tt><tt> </tt><tt>{:form</tt><tt> </tt><tt>=&gt;</tt><tt> </tt><tt>post_form}</tt><tt> </tt><tt>%&gt;</tt>

<tt> </tt><tt>&lt;div</tt><tt> </tt><tt>class="actions"&gt;</tt>

<tt> </tt><tt>&lt;%=</tt><tt> </tt><tt>post_form.submit</tt><tt> </tt><tt>%&gt;</tt>

<tt> </tt><tt>&lt;/div&gt;</tt>

<tt>&lt;%</tt><tt> </tt><tt>end</tt><tt> </tt><tt>%&gt;</tt>

<tt>Note</tt><tt> </tt><tt>that</tt><tt> </tt><tt>we</tt><tt> </tt><tt>have</tt><tt> </tt><tt>changed</tt><tt> </tt><tt>the</tt><tt> </tt><tt>f</tt><tt> </tt><tt>in</tt><tt> </tt><tt>form_for(@post)</tt><tt> </tt><tt>do</tt><tt> </tt><tt>|f|</tt><tt> </tt><tt>to</tt><tt> </tt><tt>post_form</tt><tt> </tt><tt>to</tt><tt> </tt><tt>make</tt><tt> </tt><tt>it</tt><tt> </tt><tt>easier</tt><tt> </tt><tt>to</tt><tt> </tt><tt>understand</tt><tt> </tt><tt>what</tt><tt> </tt><tt>is</tt><tt> </tt><tt>going</tt><tt> </tt><tt>on.</tt><span style="font-family: DejaVu Sans;"><tt>注意：我们已经更改</tt></span><code>form_for(@post)</code><code> </code><code>do</code><code> </code><code>|f|</code><span style="font-family: DejaVu Sans;"><tt>为</tt></span><code>form_for(@post)</code><code> </code><code>do</code><tt> </tt><code>|post_form|</code><span style="font-family: DejaVu Sans;"><code>这样会更加容易明白是怎么回事。</code></span>

<code>This</code><code> </code><code>example</code><code> </code><code>shows</code><code> </code><code>another</code><code> </code><code>option</code><code> </code><code>of</code><code> </code><code>the</code><code> </code><code>render</code><code> </code><code>helper,</code><code> </code><code>being</code><code> </code><code>able</code><code> </code><code>to</code><code> </code><code>pass</code><code> </code><code>in</code><code> </code><code>local</code><code> </code><code>variables,</code><code> </code><code>in</code><code> </code><code>this</code><code> </code><code>case,</code><code> </code><code>we</code><code> </code><code>want</code><code> </code><code>the</code><code> </code><code>local</code><code> </code><code>variable</code><code> </code><tt>form</tt><code> </code><code>in</code><code> </code><code>the</code><code> </code><code>partial</code><code> </code><code>to</code><code> </code><code>refer</code><code> </code><code>to</code><code> </code><code>the</code><code> </code><tt>post_form</tt><code> </code><code>object.</code><span style="font-family: DejaVu Sans;"><code>这个例子在</code></span><code>render</code><code> </code><code>helper</code><span style="font-family: DejaVu Sans;"><code>中使用另个方式（使用</code></span><code>f</code><span style="font-family: DejaVu Sans;"><code>），是为了说明我们希望的是在</code></span><code>form</code><span style="font-family: DejaVu Sans;"><code>中使用局部变量指向的</code></span><code>post_form</code><span style="font-family: DejaVu Sans;"><code>对象。</code></span>

<tt>We</tt><tt> </tt><tt>also</tt><tt> </tt><tt>add</tt><tt> </tt><tt>a</tt><tt> </tt><tt>@post.tags.build</tt><tt> </tt><tt>at</tt><tt> </tt><tt>the</tt><tt> </tt><tt>top</tt><tt> </tt><tt>of</tt><tt> </tt><tt>this</tt><tt> </tt><tt>form.</tt><tt> </tt><tt>This</tt><tt> </tt><tt>is</tt><tt> </tt><tt>to</tt><tt> </tt><tt>make</tt><tt> </tt><tt>sure</tt><tt> </tt><tt>there</tt><tt> </tt><tt>is</tt><tt> </tt><tt>a</tt><tt> </tt><tt>new</tt><tt> </tt><tt>tag</tt><tt> </tt><tt>ready</tt><tt> </tt><tt>to</tt><tt> </tt><tt>have</tt><tt> </tt><tt>its</tt><tt> </tt><tt>name</tt><tt> </tt><tt>filled</tt><tt> </tt><tt>in</tt><tt> </tt><tt>by</tt><tt> </tt><tt>the</tt><tt> </tt><tt>user.</tt><tt> </tt><tt>If</tt><tt> </tt><tt>you</tt><tt> </tt><tt>do</tt><tt> </tt><tt>not</tt><tt> </tt><tt>build</tt><tt> </tt><tt>the</tt><tt> </tt><tt>new</tt><tt> </tt><tt>tag,</tt><tt> </tt><tt>then</tt><tt> </tt><tt>the</tt><tt> </tt><tt>form</tt><tt> </tt><tt>will</tt><tt> </tt><tt>not</tt><tt> </tt><tt>appear</tt><tt> </tt><tt>as</tt><tt> </tt><tt>there</tt><tt> </tt><tt>is</tt><tt> </tt><tt>no</tt><tt> </tt><tt>new</tt><tt> </tt><tt>Tag</tt><tt> </tt><tt>object</tt><tt> </tt><tt>ready</tt><tt> </tt><tt>to</tt><tt> </tt><tt>create.</tt><span style="font-family: DejaVu Sans;"><tt>我们还在</tt></span><tt>form</tt><span style="font-family: DejaVu Sans;"><tt>的顶部添加</tt></span><tt>@post.tags.build</tt><span style="font-family: DejaVu Sans;"><tt>。这里是为了确保每个新的</tt></span><tt>tag</tt><span style="font-family: DejaVu Sans;"><tt>都被用户填上了</tt></span><tt>name</tt><span style="font-family: DejaVu Sans;"><tt>。如果你不创建新</tt></span><tt>tag</tt><span style="font-family: DejaVu Sans;"><tt>，</tt></span><tt>form</tt><span style="font-family: DejaVu Sans;"><tt>将不会显示它。</tt></span>

<tt>Now</tt><tt> </tt><tt>create</tt><tt> </tt><tt>the</tt><tt> </tt><tt>folder</tt><tt> </tt><tt>app/views/tags</tt><tt> </tt><tt>and</tt><tt> </tt><tt>make</tt><tt> </tt><tt>a</tt><tt> </tt><tt>file</tt><tt> </tt><tt>in</tt><tt> </tt><tt>there</tt><tt> </tt><tt>called</tt><tt> </tt><tt>_form.html.erb</tt><tt> </tt><tt>which</tt><tt> </tt><tt>contains</tt><tt> </tt><tt>the</tt><tt> </tt><tt>form</tt><tt> </tt><tt>for</tt><tt> </tt><tt>the</tt><tt> </tt><tt>tag:</tt><span style="font-family: DejaVu Sans;"><tt>现在创建一个</tt><tt></tt></span><tt>app/views/tags</tt><span style="font-family: DejaVu Sans;"><tt>文件夹并且在里面新建一个</tt></span><tt>_form.html.erb</tt><span style="font-family: DejaVu Sans;"><tt>包含以下内容：</tt></span>

<code>&lt;%=</code><tt> </tt><code>form.fields_for</code><code> </code><code>:tags</code><tt> </tt><code>do</code><tt> </tt><code>|tag_form|</code><code> </code><code>%&gt;</code>

<code> </code><code>&lt;div</code> <code>class="field"&gt;</code>

<code> </code><code>&lt;%=</code> <code>tag_form.label</code><code> </code><code>:name,</code><code> </code><code>'Tag:'</code> <code>%&gt;</code>

<code> </code><code>&lt;%=</code> <code>tag_form.text_field</code><code> </code><code>:name</code> <code>%&gt;</code>

<code> </code><code>&lt;/div&gt;</code>

<code> </code><code>&lt;%</code> <code>unless</code> <code>tag_form.object.nil?</code><code> </code><code>||</code><code> </code><code>tag_form.object.new_record?</code><code> </code><code>%&gt;</code>

<code> </code><code>&lt;div</code> <code>class="field"&gt;</code>

<code> </code><code>&lt;%=</code> <code>tag_form.label</code><code> </code><code>:_destroy,</code><code> </code><code>'Remove:'</code> <code>%&gt;</code>

<code> </code><code>&lt;%=</code> <code>tag_form.check_box</code><code> </code><code>:_destroy</code><code> </code><code>%&gt;</code>

<code> </code><code>&lt;/div&gt;</code>

<code> </code><code>&lt;%</code> <code>end</code> <code>%&gt;</code>

<code>&lt;%</code> <code>end</code> <code>%&gt;</code>

<tt>Finally,</tt><tt> </tt><tt>we</tt><tt> </tt><tt>will</tt><tt> </tt><tt>edit</tt><tt> </tt><tt>the</tt><tt> </tt><tt>app/views/posts/show.html.erb</tt><tt> </tt><tt>template</tt><tt> </tt><tt>to</tt><tt> </tt><tt>show</tt><tt> </tt><tt>our</tt><tt> </tt><tt>tags.</tt><span style="font-family: DejaVu Sans;"><tt>最后编辑</tt></span><tt>app/views/posts/show.html.erb</tt><span style="font-family: DejaVu Sans;"><tt>模板显示我们的</tt></span><tt>tags</tt><span style="font-family: DejaVu Sans;"><tt>：</tt></span>

<code>&lt;p</code><tt> </tt><code>class="notice"&gt;&lt;%=</code><tt> </tt><code>notice</code><code> </code><code>%&gt;&lt;/p&gt;</code>

&nbsp;

<code>&lt;p&gt;</code>

<code> </code><code>&lt;b&gt;Name:&lt;/b&gt;</code>

<code> </code><code>&lt;%=</code> <code>@post.name</code><code> </code><code>%&gt;</code>

<code>&lt;/p&gt;</code>

&nbsp;

<code>&lt;p&gt;</code>

<code> </code><code>&lt;b&gt;Title:&lt;/b&gt;</code>

<code> </code><code>&lt;%=</code> <code>@post.title</code><code> </code><code>%&gt;</code>

<code>&lt;/p&gt;</code>

&nbsp;

<code>&lt;p&gt;</code>

<code> </code><code>&lt;b&gt;Content:&lt;/b&gt;</code>

<code> </code><code>&lt;%=</code> <code>@post.content</code><code> </code><code>%&gt;</code>

<code>&lt;/p&gt;</code>

&nbsp;

<code>&lt;p&gt;</code>

<code> </code><code>&lt;b&gt;Tags:&lt;/b&gt;</code>

<code> </code><code>&lt;%=</code> <code>@post.tags.map</code><code> </code><code>{</code><code> </code><code>|t|</code><code> </code><code>t.name</code><code> </code><code>}.join(",</code><code> </code><code>")</code><code> </code><code>%&gt;</code>

<code>&lt;/p&gt;</code>

&nbsp;

<code>&lt;h2&gt;Comments&lt;/h2&gt;</code>

<code>&lt;%=</code> <code>render</code><code> </code><code>@post.comments</code><code> </code><code>%&gt;</code>

&nbsp;

<code>&lt;h2&gt;Add</code><code> </code><code>a</code><code> </code><code>comment:&lt;/h2&gt;</code>

<code>&lt;%=</code> <code>render</code><code> </code><code>"comments/form"</code> <code>%&gt;</code>

&nbsp;

&nbsp;

<code>&lt;%=</code> <code>link_to</code><code> </code><code>'Edit</code><code> </code><code>Post',</code><code> </code><code>edit_post_path(@post)</code><code> </code><code>%&gt;</code> <code>|</code>

<code>&lt;%=</code> <code>link_to</code><code> </code><code>'Back</code><code> </code><code>to</code><code> </code><code>Posts',</code><code> </code><code>posts_path</code><code> </code><code>%&gt;</code> <code>|</code>

<tt>With</tt><tt> </tt><tt>these</tt><tt> </tt><tt>changes</tt><tt> </tt><tt>in</tt><tt> </tt><tt>place,</tt><tt> </tt><tt>you</tt><tt>’</tt><tt>ll</tt><tt> </tt><tt>find</tt><tt> </tt><tt>that</tt><tt> </tt><tt>you</tt><tt> </tt><tt>can</tt><tt> </tt><tt>edit</tt><tt> </tt><tt>a</tt><tt> </tt><tt>post</tt><tt> </tt><tt>and</tt><tt> </tt><tt>its</tt><tt> </tt><tt>tags</tt><tt> </tt><tt>directly</tt><tt> </tt><tt>on</tt><tt> </tt><tt>the</tt><tt> </tt><tt>same</tt><tt> </tt><tt>view.</tt><span style="font-family: DejaVu Sans;"><tt>通过这写修改，你会发现你可以直接在</tt></span><tt>post</tt><tt> </tt><tt>form</tt><span style="font-family: DejaVu Sans;"><tt>中编辑</tt></span><tt>tags</tt><span style="font-family: DejaVu Sans;"><tt>。</tt></span>

However, that method call <tt>@post.tags.map</tt><tt> </tt><tt>{</tt><tt> </tt><tt>|t|</tt><tt> </tt><tt>t.name</tt><tt> </tt><tt>}.join(",</tt><tt> </tt><tt>")</tt> is awkward, we could handle this by making a helper method.<span style="font-family: DejaVu Sans;">另外，</span><tt>@post.tags.map</tt><tt> </tt><tt>{</tt><tt> </tt><tt>|t|</tt><tt> </tt><tt>t.name</tt><tt> </tt><tt>}.join(",</tt><tt> </tt><tt>")</tt><span style="font-family: DejaVu Sans;"><tt>这个方法很别扭，我们可以通过编写一个</tt></span><tt>helper</tt><tt> </tt><tt>method</tt><span style="font-family: DejaVu Sans;"><tt>。</tt></span>

<tt>###</tt><span style="font-family: DejaVu Sans;"><tt>上面都还只能一次创建一个</tt></span><tt>tag</tt><span style="font-family: DejaVu Sans;"><tt>在</tt></span><tt>post</tt><tt> </tt><tt>form</tt>
<h3><a name="view-helpers"></a><tt>12</tt><tt> </tt><tt>View</tt><tt> </tt><tt>Helpers</tt></h3>
<tt>View</tt><tt> </tt><tt>Helpers</tt><tt> </tt><tt>live</tt><tt> </tt><tt>in</tt><tt> </tt><tt>app/helpers</tt><tt> </tt><tt>and</tt><tt> </tt><tt>provide</tt><tt> </tt><tt>small</tt><tt> </tt><tt>snippets</tt><tt> </tt><tt>of</tt><tt> </tt><tt>reusable</tt><tt> </tt><tt>code</tt><tt> </tt><tt>for</tt><tt> </tt><tt>views.View</tt><tt> </tt><tt>Helpers</tt><span style="font-family: DejaVu Sans;"><tt>放置在</tt></span><tt>app/helpers</tt><span style="font-family: DejaVu Sans;"><tt>，它提供了可重用的小代码片段给</tt></span><tt>view</tt><span style="font-family: DejaVu Sans;"><tt>。</tt><tt></tt></span><tt>In</tt><tt> </tt><tt>our</tt><tt> </tt><tt>case,</tt><tt> </tt><tt>we</tt><tt> </tt><tt>want</tt><tt> </tt><tt>a</tt><tt> </tt><tt>method</tt><tt> </tt><tt>that</tt><tt> </tt><tt>strings</tt><tt> </tt><tt>a</tt><tt> </tt><tt>bunch</tt><tt> </tt><tt>of</tt><tt> </tt><tt>objects</tt><tt> </tt><tt>together</tt><tt> </tt><tt>using</tt><tt> </tt><tt>their</tt><tt> </tt><tt>name</tt><tt> </tt><tt>attribute</tt><tt> </tt><tt>and</tt><tt> </tt><tt>joining</tt><tt> </tt><tt>them</tt><tt> </tt><tt>with</tt><tt> </tt><tt>a</tt><tt> </tt><tt>comma.</tt><span style="font-family: DejaVu Sans;"><tt>在本例，我们想要一个方法把（</tt></span><tt>tag</tt><span style="font-family: DejaVu Sans;"><tt>）放在一起（一个字符串中），并且使用逗号分割。</tt><tt></tt></span><tt>As</tt><tt> </tt><tt>this</tt><tt> </tt><tt>is</tt><tt> </tt><tt>for</tt><tt> </tt><tt>the</tt><tt> </tt><tt>Post</tt><tt> </tt><tt>show</tt><tt> </tt><tt>template,</tt><tt> </tt><tt>we</tt><tt> </tt><tt>put</tt><tt> </tt><tt>it</tt><tt> </tt><tt>in</tt><tt> </tt><tt>the</tt><tt> </tt><tt>PostsHelper.</tt><span style="font-family: DejaVu Sans;"><tt>要想这样在</tt></span><tt>Post</tt><tt> </tt><tt>show</tt><span style="font-family: DejaVu Sans;"><tt>模板，我们在</tt></span><tt>PostHelper</tt><span style="font-family: DejaVu Sans;"><tt>中写入：</tt></span>

<tt>Now</tt><tt> </tt><tt>you</tt><tt> </tt><tt>can</tt><tt> </tt><tt>edit</tt><tt> </tt><tt>the</tt><tt> </tt><tt>view</tt><tt> </tt><tt>in</tt><tt> </tt><tt>app/views/posts/show.html.erb</tt><tt> </tt><tt>to</tt><tt> </tt><tt>look</tt><tt> </tt><tt>like</tt><tt> </tt><tt>this:</tt><span style="font-family: DejaVu Sans;"><tt>现在你可以在</tt><tt></tt></span><tt>app/views/posts/show.html.erb</tt><span style="font-family: DejaVu Sans;"><tt>中更改：</tt></span>

<code>&lt;p</code><tt> </tt><code>class="notice"&gt;&lt;%=</code><tt> </tt><code>notice</code><code> </code><code>%&gt;&lt;/p&gt;</code>

&nbsp;

<code>&lt;p&gt;</code>

<code> </code><code>&lt;b&gt;Name:&lt;/b&gt;</code>

<code> </code><code>&lt;%=</code> <code>@post.name</code><code> </code><code>%&gt;</code>

<code>&lt;/p&gt;</code>

&nbsp;

<code>&lt;p&gt;</code>

<code> </code><code>&lt;b&gt;Title:&lt;/b&gt;</code>

<code> </code><code>&lt;%=</code> <code>@post.title</code><code> </code><code>%&gt;</code>

<code>&lt;/p&gt;</code>

&nbsp;

<code>&lt;p&gt;</code>

<code> </code><code>&lt;b&gt;Content:&lt;/b&gt;</code>

<code> </code><code>&lt;%=</code> <code>@post.content</code><code> </code><code>%&gt;</code>

<code>&lt;/p&gt;</code>

&nbsp;

<code>&lt;p&gt;</code>

<code> </code><code>&lt;b&gt;Tags:&lt;/b&gt;</code>

<code> </code><code>&lt;%=</code> <code>join_tags(@post)</code><code> </code><code>%&gt;</code>

<code>&lt;/p&gt;</code>

&nbsp;

<code>&lt;h2&gt;Comments&lt;/h2&gt;</code>

<code>&lt;%=</code> <code>render</code><code> </code><code>@post.comments</code><code> </code><code>%&gt;</code>

&nbsp;

<code>&lt;h2&gt;Add</code><code> </code><code>a</code><code> </code><code>comment:&lt;/h2&gt;</code>

<code>&lt;%=</code> <code>render</code><code> </code><code>"comments/form"</code> <code>%&gt;</code>

&nbsp;

&nbsp;

<code>&lt;%=</code> <code>link_to</code><code> </code><code>'Edit</code><code> </code><code>Post',</code><code> </code><code>edit_post_path(@post)</code><code> </code><code>%&gt;</code> <code>|</code>

<code>&lt;%=</code> <code>link_to</code><code> </code><code>'Back</code><code> </code><code>to</code><code> </code><code>Posts',</code><code> </code><code>posts_path</code><code> </code><code>%&gt;</code> <code>|</code>
<h3><a name="what-s-next"></a>13 What’s Next?<span style="font-family: WenQuanYi Micro Hei;">接下来做什么呢？</span></h3>
Now that you’ve seen your first Rails application, you should feel free to update it and experiment on your own. But you don’t have to do everything without help.<span style="font-family: DejaVu Sans;">现在你已经看到了你的第一个</span>Rails<span style="font-family: DejaVu Sans;">应用程序，你应该可以很轻松的继续更新它或者试验一下你的想法。</span>As you need assistance getting up and running with Rails, feel free to consult these support resources:<span style="font-family: DejaVu Sans;">当你在更新和运行</span>Rails<span style="font-family: DejaVu Sans;">的时候需要援助，咨询下面推荐的资源会让你感到轻松：</span>
<ul>
	<li>The <a href="http://guides.rubyonrails.org/index.html"><span style="color: #000080;"><span style="text-decoration: underline;">Ruby</span></span><span style="color: #000080;"><span style="text-decoration: underline;">on</span></span><span style="color: #000080;"><span style="text-decoration: underline;">Rails</span></span><span style="color: #000080;"><span style="text-decoration: underline;">guides</span></span></a></li>
	<li>The <a href="http://railstutorial.org/book"><span style="color: #000080;"><span style="text-decoration: underline;">Ruby</span></span><span style="color: #000080;"><span style="text-decoration: underline;">on</span></span><span style="color: #000080;"><span style="text-decoration: underline;">Rails</span></span><span style="color: #000080;"><span style="text-decoration: underline;">Tutorial</span></span></a></li>
	<li>The <a href="http://groups.google.com/group/rubyonrails-talk"><span style="color: #000080;"><span style="text-decoration: underline;">Ruby</span></span><span style="color: #000080;"><span style="text-decoration: underline;">on</span></span><span style="color: #000080;"><span style="text-decoration: underline;">Rails</span></span><span style="color: #000080;"><span style="text-decoration: underline;">mailing</span></span><span style="color: #000080;"><span style="text-decoration: underline;">list</span></span></a></li>
	<li>The <span style="color: #000080;"><span style="text-decoration: underline;"><a href="irc://irc.freenode.net/#rubyonrails">#rubyonrails</a></span></span> channel on irc.freenode.net</li>
	<li>The <a href="http://wiki.rubyonrails.org/"><span style="color: #000080;"><span style="text-decoration: underline;">Rails</span></span><span style="color: #000080;"><span style="text-decoration: underline;">Wiki</span></span></a></li>
</ul>
Rails also comes with built-in help that you can generate using the rake command-line utility:Rails<span style="font-family: DejaVu Sans;">同样也带有内置的帮助你可以使用</span>rake<span style="font-family: DejaVu Sans;">命令实用工具在你的应用程序中创建帮助文档：</span>
<ul>
	<li>Running <tt><strong>rake</strong></tt><tt><strong> </strong></tt><tt><strong>doc:guides</strong></tt> will put a full copy of the Rails Guides in the <tt>doc/guides</tt> folder of your application. Open <tt>doc/guides/index.html</tt> in your web browser to explore the Guides. <span style="font-family: DejaVu Sans;">运行</span><tt><strong>rake</strong></tt><tt><strong> </strong></tt><tt><strong>doc:guides</strong></tt><span style="font-family: DejaVu Sans;"><tt>将会输出所有</tt></span><tt>Rails</tt><tt> </tt><tt>Guides</tt><span style="font-family: DejaVu Sans;"><tt>的文档到你的应用程序中的</tt></span><tt>doc/guides</tt><span style="font-family: DejaVu Sans;"><tt>中。在你的浏览器中打开</tt></span><tt>/guides/index.html</tt><span style="font-family: DejaVu Sans;"><tt>浏览</tt></span><tt>Guides</tt><span style="font-family: DejaVu Sans;"><tt>。</tt></span></li>
	<li>Running <tt>rake</tt><tt> </tt><tt>doc:rails</tt> will put a full copy of the API documentation for Rails in the <tt>doc/api</tt> folder of your application. Open <tt>doc/api/index.html</tt> in your web browser to explore the API documentation. <span style="font-family: DejaVu Sans;"><span style="font-family: Liberation Serif,Times New Roman,serif;">运行 </span></span><tt>rake</tt><tt> </tt><tt>doc:rails</tt><span style="font-family: DejaVu Sans;"><tt>将会</tt><tt>输出所有</tt></span><tt>Rails</tt><tt> API </tt><span style="font-family: DejaVu Sans;"><tt>的文档到你的应用程序中的</tt></span><tt>doc/api</tt><span style="font-family: DejaVu Sans;"><tt>中。</tt></span></li>
</ul>
#<span style="font-family: DejaVu Sans;">因为</span>redcloth<span style="font-family: DejaVu Sans;">的问题文档支持有点故障，虽然找到了一种解决方法但是不够完美以待官方或者来人修复。</span>
<h3><a name="configuration-gotchas"></a><a name="result_box"></a> 14 Configuration Gotchas<span style="font-family: WenQuanYi Micro Hei;">配置陷阱</span></h3>
The easiest way to work with Rails is to store all external data as UTF-8.Rails<span style="font-family: DejaVu Sans;">使用</span>Rails<span style="font-family: DejaVu Sans;">最简单的工作方式是存储所有的外部数据为</span>UTF-8<span style="font-family: DejaVu Sans;">编码。</span>If you don’t, Ruby libraries and Rails will often be able to convert your native data into UTF-8, but this doesn’t always work reliably, so you’re better off ensuring that all external data is UTF-8.<span style="font-family: DejaVu Sans;">如果不那样做，</span>Ruby libraries<span style="font-family: DejaVu Sans;">和</span>Rails<span style="font-family: DejaVu Sans;">通才会转换你的自然数据成</span>UTF-8<span style="font-family: DejaVu Sans;">编码，但是这样不是很可靠，因此你最好保证所有的外部数据是</span>UTF-8<span style="font-family: DejaVu Sans;">编码。</span>

If you have made a mistake in this area, the most common symptom is a black diamond with a question mark inside appearing in the browser. <span style="font-family: DejaVu Sans;">如果你在这里犯了错误，一般的症状就是在浏览器中出现钻石符号（可能是</span>^<span style="font-family: DejaVu Sans;">）变成了问号。</span>Another common symptom is characters like “Ã¼” appearing instead of “ü”. <span style="font-family: DejaVu Sans;">另一个普遍症状是<span style="font-family: Liberation Serif,Times New Roman,serif;">“</span></span>ü”<span style="font-family: DejaVu Sans;">变成了<span style="font-family: Liberation Serif,Times New Roman,serif;"> “</span></span>Ã¼”<span style="font-family: DejaVu Sans;">。</span>Rails takes a number of internal<span style="font-family: DejaVu Sans;">内部</span>steps to mitigate<span style="font-family: DejaVu Sans;">减轻</span>common causes of these problems that can be automatically detected<span style="font-family: DejaVu Sans;">检测</span>and corrected. However, if you have external data that is not stored as UTF-8, it can occasionally<span style="font-family: DejaVu Sans;">偶尔</span>result in these kinds of issues that cannot be automatically detected by Rails and corrected<span style="font-family: DejaVu Sans;">更正</span>.

Two very common sources of data that are not UTF-8:<span style="font-family: DejaVu Sans;">两种非常普遍的不是</span>UTF-8 <span style="font-family: DejaVu Sans;">编码的源数据：</span>
<ul>
	<li>Your text editor: Most text editors (such as Textmate), default to saving files as UTF-8. If your text editor does not, this can result in special characters that you enter in your templates (such as é) to appear as a diamond with a question mark inside in the browser. This also applies to your I18N translation files. Most editors that do not already default to UTF-8 (such as some versions of Dreamweaver) offer a way to change the default to UTF-8. Do so.</li>
	<li>Your database. Rails defaults to converting data from your database into UTF-8 at the boundary. However, if your database is not using UTF-8 internally, it may not be able to store all characters that your users enter. For instance, if your database is using Latin-1 internally, and your user enters a Russian, Hebrew, or Japanese character, the data will be lost forever once it enters the database. If possible, use UTF-8 as the internal storage of your database.</li>
</ul>
