---
layout: post
title: "python hashlib module"
date: 2012-04-12 17:46
comments: true
categories: [未分类]
tags: []
---
## python hashlib module
<blockquote>#-*- coding:utf-8 -*-
from hashlib import md5
content = 12
content_str = str(content)
ciphertext = md5(content_str).hexdigest() #加密
print ciphertext 

#from hashlib import md5
#ciphertext_str=raw_input() #写入要解密的密文,如827ccb0eea8a706c4c34a16891f84e7b
#MD5是不可逆的密码加密，可以说除了暴力破解外无法还原，但同样的输入加密出来的结果是一致的，因此要比较输入是否正确，只要比较一下加密后的结果即可，而Python中可以使用hA</blockquote>
