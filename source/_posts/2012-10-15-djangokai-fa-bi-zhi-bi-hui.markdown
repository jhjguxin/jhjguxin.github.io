---
layout: post
title: "Django开发必知必会"
date: 2011-12-15 21:27
comments: true
categories: [django,python]
tags: [developer,django,nodes,python]
---
## Django开发必知必会
<div id="cnblogs_post_body">
<h1>Django开发必知必会</h1>
<div id="id1">
<h1>版权说明</h1>
由于最近发现很多转载笔者的文章而没有说明作者和出处,所以特别在些声明.

本博客所有内容采用 Creative Commons Licenses 许可使用. 引用本内容时，请保留 <strong>朱涛</strong>, <strong>出处</strong> ，并且 <strong>非商业</strong> .

</div>
<div id="id2">
<h1>摘要</h1>
Django 作为 python 社区中最流利的web框架,它所强调的就是 <strong>快速开发</strong>, <strong>复用</strong>, <strong>可读</strong>. 本文主要介绍使用 Django 来开发所需要了解的知识,其中也包含了一些指导性的原则以及笔者的一些经验之谈.
<div id="contents">

Contents
<ul>
	<li>版权说明</li>
	<li>摘要</li>
	<li>基本知识
<ul>
	<li>熟悉python和django</li>
	<li>其它的相关技术</li>
</ul>
</li>
	<li>可用的资源</li>
	<li>高级知识
<ul>
	<li>使用virtualenv+pip来构建独立的开发环境</li>
	<li>使用fabric进行部署</li>
</ul>
</li>
	<li>推荐的开发流程</li>
	<li>结论</li>
	<li>参考资料</li>
</ul>
</div>
</div>
<div id="id3">
<h1>基本知识</h1>
<div id="python-django">
<h2>熟悉python和django</h2>
Django 是基于 python 的,所以在开发前需要熟悉相关的技术.

python 推荐几本比较好的书,包括:
<ol>
	<li>learning python</li>
	<li>python cookbook</li>
</ol>
熟读 Django 的 官方文档 和相关的书籍，这些都是必须。比较好的书籍有：
<ol>
	<li>Django Book</li>
	<li>Pro Django</li>
	<li>Practical Django Projects</li>
</ol>
更多参考 django相关资源.

</div>
<div id="id4">
<h2>其它的相关技术</h2>
作为web开发的程序员,还需要了解其它的相关技术,包括:
<ul>
	<li>html</li>
	<li>css</li>
	<li>javascript ( jquery 等)</li>
	<li>ajax</li>
	<li>网络知识和标准,如 http 协议, TCP/IP网络架构等.</li>
</ul>
</div>
</div>
<div id="id5">
<h1>可用的资源</h1>
掌握了上面提到的基本知识外,我们对 python, Django 及web开发的相关技术有了一定的熟悉,也对 python 和 Django 的 哲学也有一定的了解,如 <em>Don't Repeat Yourself</em>,<em>Keep It Simple, Stupid</em>, <em>Don't Reinvent Wheels</em> 等.

所以,在开始一个项目之前我们需要了解已有哪些可用的资源.

而在可用的资源中,最需要跟踪的一个项目就是 pinax ，它提供了站点所必须的一些常用功能，而 所采用的方式便是提供一些 <strong>可复用的app</strong>, 使得我们很容易集成到我们的环境中， 或者基于 pinax 二次开发。

除此之外，还需要了解一些特定领域的相关资源，如：
<ul>
	<li>商店 satchmo</li>
	<li>地理 GeoDjango</li>
	<li>OpenId django-openid</li>
	<li>等等</li>
</ul>
在获得特定领域的相关资源后，会大大地提高开发的效率，从而降低成本。

</div>
<div id="id6">
<h1>高级知识</h1>
掌握上面提到的技术,这时就基本上是一个合格的 Django 程序员了,但是除此之外,还需要了解一些高级的知识.
<div id="virtualenv-pip">
<h2>使用virtualenv+pip来构建独立的开发环境</h2>
virtualenv 用 于建立一个独立的（与其它module)的虚拟环境，从而使得不同的虚拟环境下的 程序可以依赖于不同版本的module,例如某个django project是基于0.96的，而另外的project是基于 1.1的，所以就必须有不同的虚拟环境。 了解更多参考： pip and virtualenv

使用 pip 来 <strong>复制</strong> 已有的依赖。 pip 是用来取代 easy_install 的，除此而外， 我们还可以很方便地使用 pip 来 <strong>复制</strong> 我们当前的工作环境。例如，我们建立一个<em>requirements.txt</em> 文件 来记录我们当前工作环境中的相关依赖程序，然后输入 <cite>pip install -r /path/to/requirements.txt</cite>, 那么相应的 依赖软件会自动安装。前提是你的系统已经安装了 pip.

除此而外，当你需要部署一个django项目时，可以使用 wsgi 很方便地进行部署，具体参考 virtualenv and wsgi.

</div>
<div id="fabric">
<h2>使用fabric进行部署</h2>
参考 Deploying Python Web Applications

另外,我们还可以使用 python 的强大功能,来实现例如配置文件的路径自适应, 利用调试状态来设定特定的属性等.

</div>
</div>
<div id="id7">
<h1>推荐的开发流程</h1>
可使用下面的开发流程来进行 Django 的开发(假设是从新开始一个项目的)：
<ol>
	<li>使用 virtualenv 建立相应的独立环境</li>
	<li>使用 easy_install 和 pip 安装相应的依赖模块</li>
	<li>多人开发时可将当前的所有模块 <strong>复制</strong> 给同事( <cite>pip</cite> 有 <em>feeze</em> 命令来输出当前环境下的所有依赖模块及版本,以保证所有的开发人员使用相同的代码库)</li>
	<li>为服务器也建立相应的独立环境,并使用 fabric 进行自动化部署.</li>
	<li>最后,使用 wsgi 和web服务器来发布产品</li>
</ol>
</div>
<div id="id8">
<h1>结论</h1>
利用 Django 的 <strong>复用</strong>, <strong>快速开发</strong> 等特性来进行Web开发, 其实是有一定的规律可循的, 除了上面介绍的一些开发知识(技巧)外,如果在开发中你发现某个过程很繁琐,你这时候就要考虑去调研 是否已经存在相关的解决方案.而不要一味地,耗时地去完成.

</div>
<div id="id9">
<h1>参考资料</h1>
<ol>
	<li>Notes on using pip and virtualenv with Django</li>
	<li>啄木鸟社区</li>
	<li>django相关资源</li>
</ol>
</div>
</div>
