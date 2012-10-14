---
layout: post
title: "python中的编码问题"
date: 2011-12-07 13:37
comments: true
categories: ["python"]
tags: ["python"]
---
## python中的编码问题
这里简单的说一下。（下面内容基本上时从《Python.Core.Programming.2ed》上摘的）
Unicode是计算机可以支持这个星球上的多种语言的秘密武器，在Unicode之前，用的都是ASCII，ASCII吗非常简单，每个英文字符都用7位二进制数的方式存储在计算机内，其范围是32到126.它的实现原理这里也不说了。
但是ASCII码只能表示95个可打印的字符，后来把ASCII扩展到了8位，这样就能表示223个字符了，虽然这个来表示欧美字母语言已经足够了，但是对于像中文等语系来说就太少了。于是Unicode码诞生了。
Unicode通过使用一个或者多个字节来表示一个字符，这样就突破了ASCII的限制，这样，Unicode可以表示超过90000个字符了。
 
Python 与Unicode
 
为了让Unicode和ASCII码值的字符串看起来尽可能的相像，Python的字符串从原来的简单数据类型改变成了真正的对象，ASCII字符串成了ＳｔｒｉｎｇＴｙｐｅ，而Ｕｎｉｃｏｄｅ字符串成了UnicodeType类型，他们的行为非常相近。String模块里面都有相应的处理函数。String模块已经停止了更新，只保留了对ＡＳＸＩＩ码的支持，string模块已经不推荐使用，在任何要跟Ｕｎｉｃｏｄｅ兼容的代码里都不要再用该模块，Python保留该模块仅仅为了向后兼容。
Python里面默认所有字面上的字符串都用ASCII编码，可以通过在字符串前面加一个‘ｕ’前缀的方式声明Ｕｎｉｃｏｄｅ字符串，这个‘ｕ’前缀告诉Python后面的字符串要编成Ｕｎｉｃｏｄｅ字符串。
 
&gt;&gt;&gt; "Hello World" #ASCII string
'Hello World'
&gt;&gt;&gt; u"Hello World" #Unicode string
u'Hello World'
 
内建的str()函数和chr（）函数不能处理Unicode，它们只能处理常规ASCII编码的字符串，如果一个Unicode字符串作为参数传给了str（）函数，它会首先被转换成ASCII码字符串然后交给str（）函数。
 
Codecs
 
Codec是把Coder/DECoder得首字母组合，它定义了文本跟二进制的转换方式，跟ASCII那种用一个字节把字符转换成数字的方式不同，Unicode用的是多字节，这导致了Unicode支持多种不同的编码方式，比如说codec支持的四种耳熟能详的编码方式是：ASCII，ISO8859—1/Latin-1，UTF-8,和UTF-16
最著名的是UTF-8编码，它也用一个字节来编码ASCII字符，这让那些必须同时处理ASCII码和Unicode码文本的程序员的工作变得非常轻松，因为ASCII字符的UTF-8编码和ASCII编码完全相同。
UTF-8编码可以用1到4个字节来表示其他语言的字符，这给那些需要直接处理Unicode数据的程序员带来了麻烦，因为他们没有办法按照固定长度逐一读出各个字符，幸运的是我们不需要掌握直接读取Unicode数据的方法，Python已经替我们完成了相关细节，我们无需为处理多字节字符的复杂问题而担心。
UTF-16也是一种变长编码，但是它不常用。
 
编码解码
 
Unicode支持多种编码格式，这为程序员带来了额外的负担，每当你向一个文件写入字符串的时候，你必须定义一个编码用于把对应的Unicode内容转换成你定义的格式，Python通过Unicode字符串的encode()函数解决了这个问题，该函数接受字符串中的字符为参数，输出你指定的编码格式的内容。
所以，每次我们写一个Unicode字符串到磁盘上我们都要用指定的编码器给他“编码“一下，相应地，当我们从这个文件读取数据时，我们必须”解码”该文件，使之成为Unicode字符串对象。
简单的例子：
<div><code>#!/usr/bin/env python
# -*- coding: UTF-8 -*-
import chardet
#chardet.detect(u'啊啊算法')
def u(s, encoding):
if isinstance(s, unicode):#用来判断是否为unicode
return s
else:
try:
return unicode(s, encoding)# 不是的话就转成unicode
except IOError:
print('error\n')</code>#s=r'\u6df1\u5733\u71c3\u6c14\u4e2d\u7b7e\u7387'
#zh = reduce(lambda x,y: x + unichr(int(y, 16)), s.split(r"\u"))
#print zh
def jiema(getstring):
fstr=r""
list_str=getstring.split(r'\u')
for single in list_str:
if single != '':
fstr+=unichr(int(single,16))
print fstrif __name__=='__main__':
coding=['utf','ascii','gb2312','gbk']
a='\u8bf7\u91cd\u65b0\u767b\u5f55'#这里没有加u得到的 就是ascii码
#if chardet.detect(u'啊啊算法')
if chardet.detect(a)['encoding']=='ascii':
print "beging to call jiema ...."
jiema(a)
else:
print "beging to zhuanma"
for code in coding:
print code
print u(a,code)
print """Python里面默认所有字面上的字符串都用ASCII编码，可以通过在字符串前面加一个‘ｕ’前缀的方式声明Ｕｎｉｃｏｄｅ字符串，这个‘ｕ’前缀告诉Python后面的字符串要编成Ｕｎｉｃｏｄｅ字符串。"""
print """ASCII 是一种字符集,包括大小写的英文字母、数字、控制字符等，它用一个字节表示，范围是 0-127Unicode分为UTF-8和UTF-16。UTF-8变长度的，最多 6 个字节，小于 127 的字符用一个字节表示，与 ASCII 字符集的结果一样，ASCII 编码下的英语文本不需要修改就可以当作 UTF-8 编码进行处理。"""
<div>标签： <a href="http://jhjguxin.hwcrazy.com/tag/python/">python</a></div>
</div>
