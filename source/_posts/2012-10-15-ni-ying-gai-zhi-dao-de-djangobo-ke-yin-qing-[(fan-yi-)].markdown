---
layout: post
title: "你应该知道的django博客引擎【翻译】"
date: 2011-10-25 09:56
comments: true
categories: [django]
tags: [blog,django,engine]
---
## 你应该知道的django博客引擎【翻译】
<div>

这段时间一直在学python和django，准备写个小小的blog巩固下自己学到的东西，看到了GAE上的一些程序，大部分都是纯python的，想找一些基于django的，还真是难。无意中搜索到一篇文章，就翻译一下，渣技术，实在不行，就去看en文的吧。

<a title="原文地址" href="http://blog.montylounge.com/2010/02/10/eleven-django-blog-engines-you-should-know/" target="_blank">en文地址</a>

Michael Trier在两年以前就写了一篇叫“基于django的blog引擎在哪儿？”。James Bennett随后也跟着写了一篇名叫“哪儿才有django的blog应用”，他论述了为什么最终没有Django blog engine（也就是基于django的博客引擎）。最近Daniel Greenfeld写了一篇“向哥展示你们的开源Django blog吧”，它里面，他定义了这个Django blog项目所需要的各项要求。自从读了那篇文章以后，我就开始一直写现在的这篇文章。

下面我挑选了一些我相信你应该会注意的blog引擎，并且根据它们最近的更新日期排列。如果这些blog engine的作者描述了他们的blog，那么我就直接引用作者们的描述，如果没有，那哥就总结一下我对该项目的一些了解。如果你有自己开发的blog引擎并且值得哥注意的，那么就在下面留言吧，记得加上姓名和地址。

<a href="http://byteflow.su/">Byteflow</a>博客程序并没有被包含在下面，这是因为这个项目在我写这片博客之前就已经关闭了下载的地址（= =！）。
<h3>Biblion</h3>
标语：eldarion.com 的blog程序一般适用于企业或者项目级别的引用。

源码地址：<a href="http://github.com/eldarion/biblion">http://github.com/eldarion/biblion</a>

最后更新：2010年2月9号

在线的demo：<a href="http://eldarion.com/blog/">http://eldarion.com/blog/</a>

描述：Bilion是eldarion.com的一个已经被提取和开源的blog程序，这个blog目前的定位是，它能够被应用于类似的eldarion.com和pinaxproject.com这样的网站或者博客项目。一旦我们完成Bilion的功能，那么我们就用它去代替内部的Pinax博客程序。

特点：

1.多渠道支持（比如：技术对业务）      #这句真没看懂啥意思

2.使用Creole作为标记格式

3.Atom feeds            #求翻译帝现身

4.在博客发布前预览其效果

5.可以选择同步推特
<h3>Django-article</h3>
标语：牛X的基于django开发的博客引擎

源码：<a href="http://bitbucket.org/codekoala/django-articles/">http://bitbucket.org/codekoala/django-articles/</a>

最后更新：2010年2月8号

现在demo：<a href="http://codekoala.com/">codekoala.com</a>

描述：作者是Josh VanderLinden，牛X的基于django开发的博客引擎。

显著特点：

1.标签系统

2.在django的后台中自动完成标签功能

3.支持草稿（就是现预存，以后再发布）

4.文章到期设定     #这是啥设定啊，还翻译有毛病

5.可以使用文本或者HTML或者使用Markdown或者ReStructured Text或者Textile markup来写文章。                  #这里面有几个属于不是很懂

6.支持相关文章显示

7.支持后续文章（就是上一篇下一篇）

8.支持Disqus评论系统               #想知道<a title="Disqus是啥" href="http://lucifr.com/2008/05/19/disqus-turn-your-blog-comment-system-to-a-forum/" target="_blank">Disqu</a>s是啥，请猛击。

9.文章分页存档

10.支持多语言（国际化个锤子）

11.支持为每篇文章添加个单独的链接，并且检测该链接。  #连wordpress的url设定差不多。- -，我猜的。

12.字数统计             #这个功能到底有个啥锤子用啊

13.支持最新文章的RRS Feeds

14.支持最新的文章标签的RRS Feeds

娘的，真累，而且翻译得不好，以后有时间再翻译翻译吧，真蛋疼。

</div>
