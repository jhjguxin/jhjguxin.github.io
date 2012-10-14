---
layout: post
title: "折腾rails3"
date: 2011-11-03 13:45
comments: true
categories: ["专业"]
tags: ["fast", "gem", "rails", "ruby"]
---
## 折腾rails3
///////////gem install 报错或是太慢,gem install 本地安装/////////////////////////

或是gem install 太慢 或是无法联接 timeout

这时可以通过本地安装的方式安装gem

首先进入gem官网<a href="http://rubygems.org/">http://rubygems.org/</a>

然后搜索找到你要安装的gem，下载下来

应该是像rails-3.0.gem的文件

然后执行gem install -l rails-3.0.gem

-l参数意思是直接执行从本地安装

如果该gem没有依赖包，则直接就安装成功了

如果有依赖包，则会抱错提示缺少依赖的gem

然后只要再去下载该包，gem install -l xxx.gem

按照这个步骤安装虽然操作不方便，但是非常快。

如果要新装一台机器的话，只需把所有依赖包放到一个文件夹里，依次安装所有包，那会非常节省时间的，而且不一定需要联网的。

/////////////////////////安装不了rails3////////////////////////////

当出现以上错误时，有几种原因，网速过慢、gem服务器太慢、被墙了。
解决方案有几种，一种是自己一个一个下载gem包，本地安装，不过太麻烦。
另一种是修改源地址：
先查看一下当前源地址
<pre>gem env
gem sources list</pre>
一般默认是：http://rubygems.org/
增加几个源路径：
<pre>sudo gem sources -a http://gems.rubyforge.org
sudo gem sources -a http://gems.github.com</pre>
问题应该解决了。关于gem sources的用法可以看帮助:gem help sources

//////////////////////////////////////加速gem///////////////////

下载gem-fast， 来加速你的Gem安装！（还有附赠下载进度条显示噢）

terminal中输入： gem install gem-fast

如果遇到问题， 想回退到之前的下载模式， 只需：gem uninstall gem-fast即可

一切如你所愿！

项目地址： http://github.com/dazuiba/gem-fast

Bug Track:  http://github.com/dazuiba/gem-fast/issues
<ol>
	<li>jhjguxin@jhjguxin-Aspire-4750:~$ sudo apt-get install curl</li>
	<li>Reading package lists... Done</li>
	<li>Building dependency tree</li>
	<li>Reading state information... Done</li>
	<li>The following NEW packages will be installed:</li>
	<li>  curl</li>
	<li>0 upgraded, 1 newly installed, 0 to remove and 1 not upgraded.</li>
	<li>Need to get 134 kB of archives.</li>
	<li>After this operation, 389 kB of additional disk space will be used.</li>
	<li>Get:1 http://mirrors.sohu.com/ubuntu/ oneiric/main curl i386 7.21.6-3ubuntu3 [134 kB]</li>
	<li>Fetched 134 kB in 1s (132 kB/s)</li>
	<li>Selecting previously deselected package curl.</li>
	<li>(Reading database ... 182147 files and directories currently installed.)</li>
	<li>Unpacking curl (from .../curl_7.21.6-3ubuntu3_i386.deb) ...</li>
	<li>Processing triggers for man-db ...</li>
	<li>Setting up curl (7.21.6-3ubuntu3) ...</li>
	<li>j</li>
	<li>jhjguxin@jhjguxin-Aspire-4750:~$ sudo gem install gem-fast</li>
	<li>Fetching: gem-fast-0.0.6.3.gem (100%)</li>
	<li>========================================================================</li>
	<li>  Thanks for installing Gem-Fast!</li>
	<li>  Gem-Fast will use curl to make your gem install faster!</li>
	<li>  Try it now use:  gem install rails</li>
	<li>========================================================================</li>
	<li>Successfully installed gem-fast-0.0.6.3</li>
	<li>1 gem installed</li>
	<li>Installing ri documentation for gem-fast-0.0.6.3...</li>
	<li>Installing RDoc documentation for gem-fast-0.0.6.3...</li>
	<li>jhjguxin@jhjguxin-Aspire-4750:~$ sudo gem install rails</li>
	<li>Downloading http://rubygems.org/latest_specs.4.8.gz</li>
	<li>##############################                                            42.2%</li>
</ol>
///////////结果呢 各种爬墙 各种 折腾都没能在线安装好 rails3 最后实在不行 本地安装咯 31个gem包//////////////////////

我的ubuntu11.10 在<a href="http://rubygems.org/">http://rubygems.org/</a> 上面下载了如下的包（放在一个文件中），实际上还是根据实际的依赖提示来

actionmailer-3.1.1.gem    i18n-0.6.0.gem         rails-3.1.1.gem
actionpack-3.1.1.gem      json-1.6.1.gem         railties-3.1.1.gem
activemodel-3.1.1.gem     mail-2.3.0.gem         rake-0.9.2.2.gem
activerecord-3.1.1.gem    mime-types-1.17.2.gem  rdoc-3.11.gem
activeresource-3.1.1.gem  multi_json-1.0.3.gem   sprockets-2.0.3.gem
activesupport-3.1.1.gem   polyglot-0.3.3.gem     thor-0.14.6.gem
arel-2.2.1.gem            rack-1.3.5.gem         tilt-1.3.3.gem
builder-3.0.0.gem         rack-cache-1.1.gem     treetop-1.4.10.gem
bundler-1.0.21.gem        rack-mount-0.8.3.gem   tzinfo-0.3.30.gem
erubis-2.7.0.gem          rack-ssl-1.3.2.gem
hike-1.2.1.gem            rack-test-0.6.1.gem

然后：：：

<a href="mailto:jhjguxin@jhjguxin-virtual-machine:~/Downloads/rails$">jhjguxin@jhjguxin-virtual-machine:~/Downloads/rails$</a> sudo gem install rails-3.1.1.gem
Building native extensions.  This could take a while...
Depending on your version of ruby, you may need to install ruby rdoc/ri data:

&lt;= 1.8.6 : unsupported
 = 1.8.7 : gem install rdoc-data; rdoc-data --install
 = 1.9.1 : gem install rdoc-data; rdoc-data --install
&gt;= 1.9.2 : nothing to do! Yay!
Successfully installed multi_json-1.0.3
Successfully installed activesupport-3.1.1
Successfully installed builder-3.0.0
Successfully installed i18n-0.6.0
Successfully installed activemodel-3.1.1
Successfully installed rack-1.3.5
Successfully installed rack-cache-1.1
Successfully installed rack-test-0.6.1
Successfully installed rack-mount-0.8.3
Successfully installed hike-1.2.1
Successfully installed tilt-1.3.3
Successfully installed sprockets-2.0.3
Successfully installed erubis-2.7.0
Successfully installed actionpack-3.1.1
Successfully installed arel-2.2.1
Successfully installed tzinfo-0.3.30
Successfully installed activerecord-3.1.1
Successfully installed activeresource-3.1.1
Successfully installed mime-types-1.17.2
Successfully installed polyglot-0.3.3
Successfully installed treetop-1.4.10
Successfully installed mail-2.3.0
Successfully installed actionmailer-3.1.1
Successfully installed rake-0.9.2.2
Successfully installed thor-0.14.6
Successfully installed rack-ssl-1.3.2
Successfully installed json-1.6.1
Successfully installed rdoc-3.11
Successfully installed railties-3.1.1
Successfully installed bundler-1.0.21
Successfully installed rails-3.1.1
31 gems installed
Installing ri documentation for multi_json-1.0.3...
Installing ri documentation for activesupport-3.1.1...
Installing ri documentation for builder-3.0.0...
Installing ri documentation for i18n-0.6.0...
Installing ri documentation for activemodel-3.1.1...
Installing ri documentation for rack-1.3.5...
Installing ri documentation for rack-cache-1.1...
Installing ri documentation for rack-test-0.6.1...
Installing ri documentation for rack-mount-0.8.3...
Installing ri documentation for hike-1.2.1...
Installing ri documentation for tilt-1.3.3...
Installing ri documentation for sprockets-2.0.3...
Installing ri documentation for erubis-2.7.0...
Installing ri documentation for actionpack-3.1.1...
Installing ri documentation for arel-2.2.1...
Installing ri documentation for tzinfo-0.3.30...
Installing ri documentation for activerecord-3.1.1...
Installing ri documentation for activeresource-3.1.1...
Installing ri documentation for mime-types-1.17.2...
Installing ri documentation for polyglot-0.3.3...
Installing ri documentation for treetop-1.4.10...
Installing ri documentation for mail-2.3.0...
Installing ri documentation for actionmailer-3.1.1...
Installing ri documentation for rake-0.9.2.2...
Installing ri documentation for thor-0.14.6...
Installing ri documentation for rack-ssl-1.3.2...
Installing ri documentation for json-1.6.1...
Installing ri documentation for rdoc-3.11...
Installing ri documentation for railties-3.1.1...
Installing ri documentation for bundler-1.0.21...
Installing ri documentation for rails-3.1.1...
Installing RDoc documentation for multi_json-1.0.3...
Installing RDoc documentation for activesupport-3.1.1...
Installing RDoc documentation for builder-3.0.0...
Installing RDoc documentation for i18n-0.6.0...
Installing RDoc documentation for activemodel-3.1.1...
Installing RDoc documentation for rack-1.3.5...
Installing RDoc documentation for rack-cache-1.1...
Installing RDoc documentation for rack-test-0.6.1...
Installing RDoc documentation for rack-mount-0.8.3...
Installing RDoc documentation for hike-1.2.1...
Installing RDoc documentation for tilt-1.3.3...
Installing RDoc documentation for sprockets-2.0.3...
Installing RDoc documentation for erubis-2.7.0...
Installing RDoc documentation for actionpack-3.1.1...
Installing RDoc documentation for arel-2.2.1...
Installing RDoc documentation for tzinfo-0.3.30...
Installing RDoc documentation for activerecord-3.1.1...
Installing RDoc documentation for activeresource-3.1.1...
Installing RDoc documentation for mime-types-1.17.2...
Installing RDoc documentation for polyglot-0.3.3...
Installing RDoc documentation for treetop-1.4.10...
Installing RDoc documentation for mail-2.3.0...
Installing RDoc documentation for actionmailer-3.1.1...
Installing RDoc documentation for rake-0.9.2.2...
Installing RDoc documentation for thor-0.14.6...
Installing RDoc documentation for rack-ssl-1.3.2...
Installing RDoc documentation for json-1.6.1...
Installing RDoc documentation for rdoc-3.11...
Installing RDoc documentation for railties-3.1.1...
Installing RDoc documentation for bundler-1.0.21...
Installing RDoc documentation for rails-3.1.1...
jhjguxin@jhjguxin-virtual-machine:~/Downloads/rails$ rails -v
Rails 3.1.1
