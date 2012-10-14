---
layout: post
title: "Sharing A Devise User Session Across Subdomains With Rails 3"
date: 2012-09-15 16:21
comments: true
categories: ["rails", "ruby", "web"]
tags: ["devise", "rails", "Session", "Subdomains"]
---
## Sharing A Devise User Session Across Subdomains With Rails 3
<pre>to andersen
  仔细测了一下 Askjane::Application.config.session_store :active_record_store, key: &#039;_askjane_session&#039;, :domain =&gt; &quot;.bbtang.com&quot;在 server上
  是ok的（效果上也是能共享bbtang.com 和www.bbtang.com的会话的只要端口一致）就是不知道在本地如何因为本地一般不会设置host绑定域名(经测试答案是不能的)，如何（所以需要:all这个设置项）
to 客服 和 jojo
 提一点 你们一些 首页源码的时候 不要把 域名加上去  注意 尼玛 端口不一致 也是不能share 会话的
 简而言之 你们写一些html静态源码的时候除非不在 bbtang.com的 项目上 没有必要加 域名的 这会加大 大家的成本（如果说端口不一致就会导致会话丢失，如果没有做多域名兼容也会导致会话丢失能免则免）
over</pre>
<pre></pre>
<pre>Francis.J(864248765) 13:57:28
https://github.com/rails/rails/issues/2483
Francis.J(864248765) 13:57:55
尼玛 rails 大爷又 踩雷了
Francis.J(864248765) 13:59:42
https://github.com/rails/rails/issues/2483
Francis.J(864248765) 14:02:27
https://github.com/rails/rails/pull/7316
Francis.J(864248765) 14:08:37
然后 我们看看 究竟用 :cookie_store + :domain =&gt; :all
还是  :active_record_store + &quot;.bbtang.com&quot; (这里垮子域名估计不会很合适)
还是 升一下 rails  用  :active_record_store + :domain =&gt; :all</pre>
Recently I’ve been working on a Rails application that supports subdomains. I’m using Devise for user authentication and need the user to choose a subdomain to use upon registration.

Similar to the 37signals applications, I want a single sign-on to be persistent across subdomains. Since I didn’t have a clue where to begin with subdomains, I followed <a href="https://github.com/fortuity/rails3-subdomain-devise/wiki/Tutorial-%28Walkthrough%29">this tutorial</a> on my new Rails 3.1 beta 1 application. This tutorial worked like a charm and I omitted the friendly_id and tweaked a few things to my liking.

The gist of it is simple. Create a User model like you would normally do with Devise. You add a Subdomain model that is linked to the Users (in my case I only wanted a single subdomain per user). Configuring the routes is pretty simple as you can simply create a constraint that will match the root and fire it off to the right action and let the rest fall through.

The trick comes into sharing the session between domains. Browsers, of course, will separate out the cookies and store them by separated out by subdomain. What you want to do is edit your config/initializers/session_store.rb file to look like this
<div>
<table>
<tbody>
<tr>
<td>
<pre>APPNAMEGOESHERE::Application.config.session_store :cookie_store, :key =&gt; &#039;_tourlyapp_session&#039;, :domain =&gt; &quot;lvh.me&quot;</pre>
</td>
</tr>
</tbody>
</table>
</div>
The trick here is the <code>:domain</code> option. What this does is sets the level of the TLD (top level domain) and tells Rails how long the domain is. The part you want to watch out for here is that if you set <code>:domain =&gt; :all</code> like is recommend in some places, it simply won’t work unless you’re using localhost. <code>:all</code> defaults to a TLD length of 1, which means if you’re testing with Pow (myapp.dev) it won’t work either because that is a TLD of length 2.

You might get weird things like halfway Devise sessions sharing, but only allowing you to create and destroy the session on the root domain. Using <code>:all</code> works great if you’re using localhost, but when I started using lvh.me:3000 for testing I had those problems (lvh.me stands for local vhost me and is a domain that simply points to localhost which makes for zero-config subdomain development. It’s super handy.).

The best option might be to comment out this line and put it into your individual environment configurations. This way you can keep things configured easily as the <code>:all</code> option. Once you’ve got your domain string added everything should work like a charm.

<strong>BONUS PROTIP: </strong>The normal route variables you see used end with _path. These don’t include the domain and therefore ignore the :subdomain option you pass into them. <code>url_for</code>, on the other hand, does support subdomains so you should get into the habit of using root_url instead of root_path and so on.
