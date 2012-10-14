---
layout: post
title: "python hashlib md5"
date: 2012-04-12 17:53
comments: true
categories: ["python"]
tags: ["hashlib", "md5", "python"]
---
## python hashlib md5
<blockquote>#-*- coding:utf-8 -*-
from hashlib import md5
content = 12
content_str = str(content)
ciphertext = md5(content_str).hexdigest() #加密
print ciphertext

#from hashlib import md5
#ciphertext_str=raw_input() #写入要解密的密文,如827ccb0eea8a706c4c34a16891f84e7b
#MD5是不可逆的密码加密，可以说除了暴力破解外无法还原，但同样的输入加密出来的结果是一致的，因此要比较输入是否正确，只要比较一下加密后的结果即可，而Python中可以使用hashlib进行MD5加密，具体方法如下

for i in xrange(100000):
ciphertext_tmp = md5(str(i)).hexdigest()
if ciphertext_tmp == ciphertext:
print 'the password is %d' % i
break</blockquote>
python的base64加密解密及md5加密
<blockquote>import hashlib

a = "a test string"
print hashlib.md5(a).hexdigest()
print hashlib.sha1(a).hexdigest()
print hashlib.sha224(a).hexdigest()
print hashlib.sha256(a).hexdigest()
print hashlib.sha384(a).hexdigest()
print hashlib.sha512(a).hexdigest()

import base64
str='haha'
encoded = base64.b64encode(str)
decoded = base64.b64decode(encoded)</blockquote>
&nbsp;

&nbsp;
