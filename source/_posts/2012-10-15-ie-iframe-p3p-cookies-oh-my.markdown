---
layout: post
title: "IE, iframe, P3P, Cookies, oh my"
date: 2012-09-13 22:53
comments: true
categories: [rails,ruby,web]
tags: [Cookies,IE,iframe,P3P]
---
## IE, iframe, P3P, Cookies, oh my
测试新浪微游戏接口时，发现一个问题：当使用IE浏览器的时候，rails的session无法保存。之前在自己开发服务器上测试时，验证过IE和Firefox都能正常使用session的，觉得很是奇怪。

通 过抓包发现，正常情况下，服务器端在响应客户端访问请求后，在返回的http头中会有Set-Cookies这样的参数，同时在接下来的客户端的http 请求头中，会加上Cookie这样的参数；上述不能正常保存session情况下的抓包分析发现，客户端的http请求头中浏览器没有设置Cookie参 数。

解决方法一：修改IE的默认Cookie设置，设置IE隐私设置中的高级隐私设置，勾选“总是允许回话Cookie”，这样session的值就能正常保存了。不过这样肯定不是最好的解决办法，对大多数用户来说，这样做不合理。

解决方法二：参考方法来自： <a href="http://www.sympact.net/2008/07/rails-and-ifram.html" target="_blank">http://www.sympact.net/2008/07/rails-and-ifram.html</a> ，文中描述了具体原因，是因为IFrame中打开的链接和主页面的链接不在同一个域，所以IE默认会认为是不可信任的，则不允许使用Cookie。解决办 法正如文中所示，在controller中的before_filter中增加一个方法，此方法中设置响应的http相应头中增加P3P参数，问题即可解 决。
大致代码如下：
<pre class="brush: rails; gutter: true"></pre>
<div id="LC1">[rails IE, IFRAME, P3P, COOKIES](<a href="https://gist.github.com/3719568">https://gist.github.com/3719568</a>)</div>
<div id="LC10">
<pre class="brush: rails; gutter: true">#userful gem [rack-p3p](https://github.com/hoopla/rack-p3p)
# encoding: utf-8
class ApplicationController &lt; ActionController::Base
  protect_from_forgery
  before_filter :set_p3p
  def set_p3p
    headers[&#039;P3P&#039;] = &quot;policyref=\&quot;/w3c/p3p.xml\&quot;, CP=\&quot;ALL DSP COR CURa ADMa DEVa TAIa OUR BUS IND UNI COM NAV INT\&quot;&quot;
  end
end</pre>
</div>
<div id="LC10"></div>
I was just banging my head against the wall trying to figure out why internet explorer wasn’t remembering my user’s sessions. Turns out it’s something that has bitten me in the past.

IE doesn’t allow you to set cookies when your site is in an iframe unless your site has set P3P headers. Also, ordering matters – the P3P header must be set *before* the cookie is set.

If you’re using ruby, this gem works pretty well: <a href="https://github.com/hoopla/rack-p3p">https://github.com/hoopla/rack-p3p</a>

Further reading: <a href="http://stackoverflow.com/questions/389456/cookie-blocked-not-saved-in-iframe-in-internet-explorer">http://stackoverflow.com/questions/389456/cookie-blocked-not-saved-in-iframe-in-internet-explorer</a>

All the articles I read about setting headers, etags, etc were all really old. Hopefully, if you’re using rails you found this article. Just install the gem and add the line from the README to your application.rb – no monkey patching. Good luck.
<h2>rails IE frame ActionController::InvalidAuthenticityToken</h2>
Same problem here with a rails application launched in an iframe I get:

"the change you wanted was rejected"

In log:

ActionController::InvalidAuthenticityToken<wbr></wbr>

Seems that the problem occur in IE when you are developing in an iframe situation where the master page is at a different domain than the inner page. (es: iframed Facebook applications)

This is because IE's default "medium" privacy setting has an issue with cookies in that situation.

A possible solution is to set a P3P header (try to google: p3p iframe internet explorer) Example, in application_controller.rb:
<pre>&lt;code&gt;before_filter  &lt;wbr&gt;:set_p3p

def set_p3p
 &lt;wbr&gt; response.headers[&quot;P3P&quot;]=&#039;CP=&quot;CAO PSA OUR&quot;&#039;
end&lt;/wbr&gt;&lt;/wbr&gt;&lt;/code&gt;</pre>
&nbsp;
<h1 id="subject_tpc">php版站内应用在ie浏览器下获取到session值(失效)[已解决]</h1>
<div>
<div id="read_tpc">php版站内应用在ie浏览器下获取到session值(失效)
首页授权证后保存的session在其它页面获取不到。例如：
在站内应用的iframe下：
a.php
&lt;?php
session_start();
$_SESSION["user"]="abc";
echo $_SESSION["user"];
?&gt;
&lt;a href="b.php"&gt;b.php&lt;/a&gt;

b.php
&lt;?php
session_start();
echo $_SESSION["user"];
?&gt;

运行a.php后正常显示abc，跳转到b.php显示为空。

这问题纠缠了我很久了，不继地调试，直到今晚终于找到答案了：
原来这也属于是跨域访问的问题。

以下是解决方案：
<strong>“用P3P header解决iframe跨域访问cookie/session”的问题</strong>
理论很简单,而且模式也和大多请求返回状态的SSO差不多.但是有几个地方是要注意一下的.
1.页面里的COOKIE不能是浏览器进程的COOKIE(包括验证票和不设置超时时间的COOKIE),否则跨域会取不到.这点做跨域COOKIE的人比较少提到.不过实际上留意下几家大学做的方案,有细微的提到他们的验证模块里的COOKIE是有设置超时时间的.
2.当利用IFRAME时,记得要在相应的动态页的页头添加一下P3P的信息,否则IE会自觉的把IFRAME框里的COOKIE给阻止掉,产生问题.本身不保存自然就取不到了.这个其实是FRAMESET和COOKIE的问题,用FRAME或者IFRAME都会遇到.
3.测试时输出TRACE,会减少很多测试的工作量.
只需要设置 P3P HTTP Header，在隐含 iframe 里面跨域设置 cookie 就可以成功。他们所用的内容是：
P3P: CP='CURa ADMa DEVa PSAo PSDo OUR BUS UNI PUR INT DEM STA PRE COM NAV OTC NOI DSP COR'

ASP直接在头部加了头部申明，测试有效。
&lt;%Response.AddHeader "P3P", "CP=CAO PSA OUR"%&gt;

php的话，我没去试，应该是如下写法：
header('P3P: CP=CAO PSA OUR');

ASP.NET的话
通过在代码上加Response.AddHeader("P3P", "CP=CAO PSA OUR")或者在Window服务中将ASP.NET State Service 启动。
JSP:response.setHeader("P3P","CP=CAO PSA OUR")

如何在静态页面加头信息 P3P: CP="CAO PSA OUR 来解决框架与cookie的问题?
IIS站点管理器允许你给所有输出的内容都加上任意HTTP Header，你只要在Custom Header里面加上P3P: CP="CAO PSA OUR"
就ok了

</div>
</div>
