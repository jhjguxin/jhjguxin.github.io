---
layout: post
title: "晒晒我们的开源项目 ITEYE开源代码"
date: 2012-09-27 08:34
comments: true
categories: [rails,ruby,web,专业,工具控]
tags: [iteye,opensources]
---
## 晒晒我们的开源项目 ITEYE开源代码
我们的研发团队是一支mini型研发团队，目前共有研发人员13人。由于网站产品维护的历史原因，这13人的研发团队分为4支小组，分别是：Ruby研发小组5人；PHP研发小组4人；.net研发小组2人，Java搜索小组2人。

别看我们研发人员这么少，但是我们研发人员战斗力很强，我们维护和开发着十多条产品线。在我们开发自身产品的过程中，也积累了一些比较通用的组件，一些对大家来说有用的工具。因此从今年下半年开始，我们陆续将一些组件和工具开源出来，哪怕这些项目的质量并不是那么高，也希望能够给社区带来一点点自己的贡献。

以下简要介绍一下我们已经开源的项目，今后我们还会努力开源更多的东西和大家交流和分享：

1、Ansj中文分词 - 开源的高准确率Java中文分词器

项目Github地址：<a href="https://github.com/ansjsun/ansj_seg" target="_blank">https://github.com/ansjsun/ansj_seg</a>
这是基于大名鼎鼎中科院的Ictclas中文分词算法编写的Java实现版本，比常用的开源mmseg4j的分词准确率高。目前我们自己站内的搜索将逐渐从mmseg4j算法替换成Ansj中文分词算法。

2、ServiceFramework - 开源的羽量级Java Web服务框架

项目Github地址：<a href="https://github.com/allwefantasy/ServiceFramework" target="_blank">https://github.com/allwefantasy/ServiceFramework</a>
我们基于Java的开源搜索框架lucene编写了网站的分布式搜索和Tag文章分类服务。因为需要向前端的Web应用程序提供搜索和Tag服务接口API，所以我们编写了这个羽量级的Java框架软件。它的优点就是羽量级，自身集成了Jetty服务器，MVC，IoC和ORM，让你只需要编写非常少的代码，就可以快速将你的业务逻辑组件以Web API的方式提供服务。

3、ExportBlog - 开源的通用博客导出工具

项目Github地址：<a href="https://github.com/sqzhuyi/ExportBlog" target="_blank">https://github.com/sqzhuyi/ExportBlog</a>
这是一个基于.net Winforms编写的通用博客导出工具，支持导出网站包括：CSDN、ITEYE、博客园、新浪、搜狐、和讯、ChinaUnix、网易、51CTO、开源中国、百度空间、QQ空间等等。导出格式支持CHM、PDF、HTML、TXT和EPUB 5种格式文档。详细介绍：<a href="http://blog.csdn.net/sq_zhuyi/article/details/7924776" target="_blank">http://blog.csdn.net/sq_zhuyi/article/details/7924776</a>

4、Secode_level_cache - 开源的Rails对象缓存插件

项目Github地址：<a href="https://github.com/csdn-dev/second_level_cache" target="_blank">https://github.com/csdn-dev/second_level_cache</a>
Rails的ActiveRecord自身没有带强大的对象缓存功能，这是AR的一个重大的遗憾。早在2008年开始，我们就借鉴了Java强大的ORM框架Hibernate的二级对象缓存编写了这个Rails的AR对象缓存插件，并且一直作为JavaEye网站缓存优化的秘密武器来使用，取得了非常理想的效果。
现在我们将这个插件从Rails2.x的版本升级到了3.x版本，并且抽取成了一个通用插件，开始应用于新的Rails3.2的项目之上。有志于AR对象缓存优化的ruby程序员不容错过。

5、limiter － 网站反爬虫和DOS攻击的利器

项目Github地址：<a href="https://github.com/csdn-dev/limiter" target="_blank">https://github.com/csdn-dev/limiter</a>
早年的JavaEye网站曾经深受DOS攻击和爬虫海量抓取造成的负载过高的困扰，我曾经和这个问题进行了为期几年不懈的斗争，并且在总结几年斗争经验后写了一篇总结性博客文章：<a href="http://robbin.iteye.com/blog/451014" target="_blank">互联网网站的反爬虫策略浅析</a> 。当时我基于这个反爬虫策略编写了JavaEye网站的智能防火墙插件，取得了良好的效果。
现在我们将这个插件从JavaEye的源代码中剥离出来，抽取成一个通用的rackware，便于应用于普通的Rails3.x的项目当中。
