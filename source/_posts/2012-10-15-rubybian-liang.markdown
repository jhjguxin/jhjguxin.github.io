---
layout: post
title: "ruby变量"
date: 2012-03-21 16:51
comments: true
categories: ["ruby"]
tags: ["ruby，变量"]
---
## ruby变量
变量，实例变量，类变量，甚至还有"常量"其实都只是对象引用。它们引用对象，但是它们并不是对象本身。因此，它们可以被动态地改变，甚至引用另一种不同类型的对象。

　　因为这一灵活性，所以必须在Ruby中进行一些约定以帮助每个人都知道某个变量正为代码所使用。其实，你已经看到了其中之一（@符号，它意味着这是一个实例变量）。其它的变量，方法和类命名约定列于下表1中。

　　· 局部变量和方法参数以一个小写字母开头。
　　· 方法名字以一个小写字母开头。
　　· 全局变量以一个$开头。
　　· 实例变量以一个@开头。
　　· 类变量以两个@开头。
　　· 常数以一个大写字母开头(它们经常被指定全部大写)。
　　· 类和模块名以一个大写字母开头。
<table width="90%" border="1" cellspacing="0" cellpadding="0" align="center">
<tbody>
<tr>
<td>局部变量</td>
<td>全局变量</td>
<td>实例变量</td>
<td>类变量</td>
<td>常数</td>
<td>类名</td>
<td>方法名</td>
</tr>
<tr>
<td>aVar</td>
<td>$Var</td>
<td>@var</td>
<td>@@var</td>
<td>VAR</td>
<td>MyClass</td>
<td>myMethod</td>
</tr>
<tr>
<td>name</td>
<td>$debug</td>
<td>@lastName</td>
<td>@@interest</td>
<td>PI</td>
<td>Rectangle</td>
<td>area</td>
</tr>
</tbody>
</table>
　　　　　　　　表1.这个表包含了在Ruby编码约定下的相关示例
