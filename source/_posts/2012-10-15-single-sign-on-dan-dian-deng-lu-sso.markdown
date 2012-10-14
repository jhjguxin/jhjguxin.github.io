---
layout: post
title: "Single sign-on 单点登录 sso"
date: 2012-09-26 08:35
comments: true
categories: ["ruby", "web"]
tags: ["oauth2", "sso"]
---
## Single sign-on 单点登录 sso
from wiki

<strong>Single sign-on</strong> (<strong>SSO</strong>) is a property of <a title="Access control" href="http://en.wikipedia.org/wiki/Access_control">access control</a> of multiple related, but independent <a title="Software" href="http://en.wikipedia.org/wiki/Software">software</a> systems. With this property a user <a title="Login" href="http://en.wikipedia.org/wiki/Login">logs in</a> once and gains access to all systems without being prompted to log in again at each of them. Conversely, <strong>Single sign-off</strong> is the property whereby a single action of signing out terminates access to multiple software systems.

As different applications and resources support different <a title="Authentication" href="http://en.wikipedia.org/wiki/Authentication">authentication</a> mechanisms, single sign-on has to internally translate to and store different credentials compared to what is used for initial authentication.

from baike

单点登录（Single Sign On），简称为 SSO，是目前比较流行的企业业务整合的解决方案之一。SSO的定义是在多个应用系统中，用户只需要登录一次就可以访问所有相互信任的应用系统。
<div></div>
企业应用集成（EAI, Enterprise Application Integration）。企业应用集成可以在不同层面上进行：例如在数据存储层面上的“数据大集中”，在传输层面上的“通用数据交换平台”，在应用层面上的“业务流程整合”，和用户界面上的“通用企业门户”等等。事实上，还有一个层面上的集成变得越来越重要，那就是“身份认证”的整合，也就是“单点登录”。

现在普遍使用 oauth 来实现 多个系统的授权 认证

<a href="https://github.com/songkick/oauth2-provider">https://github.com/songkick/oauth2-provider</a>
