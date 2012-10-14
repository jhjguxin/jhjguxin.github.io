---
layout: post
title: "理解JSON：3分钟课程"
date: 2011-12-28 18:57
comments: true
categories: [专业,网文]
tags: [json]
---
## 理解JSON：3分钟课程
如果你跟我一样(我担心你就是)，那么，到目前为止，这应该是你对JSON的经验：
<ol>
	<li>两个月前你<strong>从没</strong>听说过JSON</li>
	<li>一个月前你听说了这个词但没有留意</li>
	<li>一周前你发现这个词被提到多次，开始想，<em>没错 … 又有一些垃圾东西要学了</em></li>
	<li>今天你被心灵深处的一个闹铃闹醒，心想：<strong>这该死的json究竟是个什么东西？为什么突然间到处都是它了！</strong></li>
</ol>
于是晚上我乘坐了一辆慢腾腾的公交回到家(周五通常都是很慢)，然后给自己找了一大堆关于JSON资料。所以我可以文雅的带你进入JSON的大门。

这就开始了 …
<h3>这几个字母是什么意思？</h3>
<strong>J</strong>ava<strong>S</strong>cript <strong>O</strong>bject <strong>N</strong>otation.

[一个滑稽的名字。它应该被称作<strong>L</strong>ightweight <strong>E</strong>cmascript <strong>O</strong>bject <strong>N</strong>otation, 或简称 'LEON'。 <img src="http://www.linuxeden.com/upimg/allimg/110526/0S53B127-0.gif" alt=";-)" /> ]
<h3>它是个什么东西？</h3>
JSON是一种传递对象的语法，对象可以是name/value对，数组和其他对象。

下面是一小段JSON代码：
<pre>点击收起{"skillz": {
	"web":[
		{"name": "html",
		 "years": "5"
		},
		{"name": "css",
		 "years": "3"
		}],
	"database":[
		{"name": "sql",
		 "years": "7"
		}]
}}</pre>
你看懂了吧？那么当你再看到它时就知道它是JSON了。主要部分：
<h3>花括弧，方括弧，冒号和逗号</h3>
<ol>
	<li>花括弧表示一个“容器”</li>
	<li>方括号装载数组</li>
	<li>名称和值用冒号隔开</li>
	<li>数组元素通过逗号隔开</li>
</ol>
<h3>把它想成“得了厌食症的XML”</h3>
(如果你跟我一样老，可以把它想成有层次关系的’.INI’文件)

(如果你是个自以为是的Lisp小丑，可以把它想成”S-expressions”，自以为是吧)
<h3>JSON很像XML，因为：</h3>
<ol>
	<li>他们都“自我描述”，这意味着值都是可列举的，是“人类可读”的</li>
	<li>都是有层级的。(例如你可以在值里再存放值)</li>
	<li>都能被多种的编程语言解析和使用</li>
	<li>都能使用AJAX方法来传递(例如httpWebRequest)</li>
</ol>
<h3>JSON跟XML不一样，因为：</h3>
<ol>
	<li>XML里在元素的开始和结尾处有尖括号和标签名：JSON使用花括号，而且只在数据的开始和结束时使用。</li>
	<li>JSON更简练，毫无疑问更适合人类书写，也许也能让我们更快速的阅读。</li>
	<li>JSON可以在JavaScript里简单的传递到eval()方法里使用</li>
	<li>JSON里有数组{每个元素没有自己的名称}</li>
	<li>在XML里你可以对一个元素使用任意想要的名称，在JSON里你不能使用Javascript里的保留字</li>
</ol>
<h3>可是为什么？它有什么好的？</h3>
当你写ajax之类的东西时，如果你使用JSON，你就勉去了手工拼写XML。更迅速。

同样，当你写ajax之类的东西时，怎样最简单？XML方式还是JSON方式：
<div>
<h3>XML方式：</h3>
<ol>
	<li>取回一个XML文件</li>
	<li>循环它，从中提取值</li>
	<li>处理这些值，等</li>
</ol>
<h3>对比</h3>
<h3>JSON方式：</h3>
<ol>
	<li>取回JSON字符串。</li>
	<li>‘eval’ JSON数据</li>
</ol>
</div>
<h3>它是面向对象的吗？</h3>
No，严格的说，不是。

就像是VB6里的面向对象一样。它提供了很好的封装机制，你可以使用它把数据和方法分离出来，但它不提供任何的继承，多型，接口，或其它类似的面向对象的东西

很显然，它是使javascript变得更易于维护，分析和复用的方向上前进了一步。

<a href="http://www.thomasfrank.se/" target="_blank">Thomas Frank</a>写了一个<a title="classyJSON" href="http://www.thomasfrank.se/classy_json.html" target="_blank">灵巧的javascript库</a>，叫做<em>classyJSON</em>，它在JSON代码上增加了继承和定义范围等特征。
<h3>它只是用在客户端吗？</h3>
是，也不是。在服务器端你可以容易的把对象序列化成JSON或反之。对于<code>.net</code>，程序员可以使用类似<a href="http://www.newtonsoft.com/products/json/" target="_blank">Json.net</a>的类库使这些操作自动化(我估计是使用反射机制)，或你使用自己的程序来做这些事，可能会更快些。
<h3>3分钟将近结束….</h3>
就我所知，JSON是由一个叫做<a href="http://www.crockford.com/" target="_blank">Douglas Crockford</a>的家伙发明的。如果你喜欢的话，可以看一下<a href="http://www.crockford.com/" target="_blank">他的网站</a>，他非常的有趣。
<div>
<h3>现在去读一下懂JSON的人写的东西</h3>
(从<a href="http://del.icio.us/help/json" target="_blank">Delicious using JSON</a>上搜刮来的！)
<ul>
	<li><a href="http://homepages.nildram.co.uk/%7E9jack9/base2/speedtest/" target="_blank">DOM Query Speed Test</a></li>
	<li><a href="http://24ways.org/advent/dont-be-eval" target="_blank">24 ways: Don’t be eval()</a></li>
	<li><a href="http://www.aqee.net/2011/05/26/understanding-json-the-3-minute-lesson/" target="_blank">Understanding JSON: the 3 minute lesson</a></li>
	<li><a href="http://www.hanselman.com/blog/SerializingObjectsAsJavaScriptUsingAtlasJSONNETAndAjaxPro.aspx" target="_blank">Serializing Objects as JavaScript using Atlas, JSON.NET and AjaxPro</a></li>
	<li><a href="http://en.wikipedia.org/wiki/JSON" target="_blank">JSON – Wikipedia, the free encyclopedia</a></li>
	<li><a href="http://www.ajaxprojects.com/ajax/tutorialdetails.php?itemid=11" target="_blank">Introduction to JSON</a></li>
	<li><a href="http://www.xml.com/pub/a/2005/12/21/json-dynamic-script-tag.html" target="_blank">XML.com: JSON and the Dynamic Script Tag: Easy, XML-less Web Services for JavaScript</a></li>
	<li><a href="http://www.thomasfrank.se/classy_json.html" target="_blank">Classy JSON</a></li>
	<li><a href="http://simpletutorials.com/w3/index.php?pagename=Simple%20AJAX%20%28PHP%29%20tutorial" target="_blank">ajax json tutoral</a></li>
	<li><a href="http://www.thomasfrank.se/xml_to_json.html" target="_blank">XML to JSON – a converter</a></li>
</ul>
</div>
<h3>这就是全部。</h3>
我在几分钟的时间里只能整理出这些东西——所有我说的有些东西可能完全是错的。如果是这样，请留言告诉我，告诉我我有多傻。我会很高兴的纠正任何一个错误。祝你好运！

(边注：如果你把 { 和 } 替换成”&lt;” 和 “/&gt;”，把”:” 换成 “/”… 你会得到一个非常像<a href="http://secretgeek.net/gaXml.asp" target="_blank">gaXml</a>的东西。有趣的世界。

(边注2：<a href="http://en.wikipedia.org/wiki/Jason" target="_blank">Jason</a> 和 <a href="http://en.wikipedia.org/wiki/Ajax_%28mythology%29" target="_blank">Ajax</a> 都是希腊神话中的英雄。预告：另外一些即将出现的技术垃圾包括：Heracles, Perseus, Deucalion, Theseus
and Bellerophon。)
