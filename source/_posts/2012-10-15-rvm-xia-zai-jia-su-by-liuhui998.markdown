---
layout: post
title: "RVM 下载 加速 -by liuhui998"
date: 2012-05-14 15:37
comments: true
categories: ["专业"]
tags: ["rvm", "speed"]
---
## RVM 下载 加速 -by liuhui998
今天晚上有点时间，我就折腾了一下 rails。

按照这个<a title="教程" href="http://ruby-china.org/wiki/install_ruby_guide">教程</a>，我一步步的进行安装。

正如我之前听说的 <a title="rvm" href="https://rvm.beginrescueend.com/rvm/install/">rvm</a> 下载 ruby 的速度只有不到5KB/s 速度。

在 google 了二圈后，我发现国内外好像没有人解决这个问题。

于是我发扬geek精神，开始打起了 rvm 源代码的主意：

1） rvm 是从 ruby-lang.org 这个站点下载 ruby 的源代码
rvm 慢的主要是因为 ruby-lang.org 这个网站下载速度慢

2） 如果找到 ruby-lang.org 的更快的镜像网站，并修改 rvm 里面的配置
这个问题也就解决了

于是找到一个叫 <a title="UK Mirror Service " href="http://www.mirrorservice.org/">UK Mirror Service</a> 的网站，它提供了 ruby-lang.org 镜像服务：

<a title="http://www.mirrorservice.org/sites/ftp.ruby-lang.org/" href="http://www.mirrorservice.org/sites/ftp.ruby-lang.org/">http://www.mirrorservice.org/sites/ftp.ruby-lang.org/</a>

我测试了一下，平均速度最慢也超过 30KB/s

好的镜像找到了，那么下一步就是在哪里修改 ruby 下载地址。
<div><figure>
<div>
<table>
<tbody>
<tr>
<td></td>
<td>
<pre><code>cd $rvm_path grep -nR "ruby-lang.org" ./</code></pre>
</td>
</tr>
</tbody>
</table>
</div>
</figure></div>
&nbsp;

发现地址是写在 $rvm_path/config/db 文件里

找到这一段：
<div><figure>
<div>
<table>
<tbody>
<tr>
<td></td>
<td>
<pre><code>ruby_1.0_url=http://ftp.ruby-lang.org/pub/ruby/1.0 ruby_1.2_url=http://ftp.ruby-lang.org/pub/ruby/1.2 ruby_1.3_url=http://ftp.ruby-lang.org/pub/ruby/1.3 ruby_1.4_url=http://ftp.ruby-lang.org/pub/ruby/1.4 ruby_1.5_url=http://ftp.ruby-lang.org/pub/ruby/1.5 ruby_1.6_url=http://ftp.ruby-lang.org/pub/ruby/1.6 ruby_1.7_url=http://ftp.ruby-lang.org/pub/ruby/1.7 ruby_1.8_url=http://ftp.ruby-lang.org/pub/ruby/1.8 ruby_1.9_url=http://ftp.ruby-lang.org/pub/ruby/1.9 ruby_2.0_url=http://ftp.ruby-lang.org/pub/ruby/2.0</code></pre>
</td>
</tr>
</tbody>
</table>
</div>
</figure></div>
&nbsp;

改成
<div><figure>
<div>
<table>
<tbody>
<tr>
<td></td>
<td>
<pre><code>ruby_1.0_url=http://www.mirrorservice.org/sites/ftp.ruby-lang.org/pub/ruby/1.0 ruby_1.2_url=http://www.mirrorservice.org/sites/ftp.ruby-lang.org/pub/ruby/1.2 ruby_1.3_url=http://www.mirrorservice.org/sites/ftp.ruby-lang.org/pub/ruby/1.3 ruby_1.4_url=http://www.mirrorservice.org/sites/ftp.ruby-lang.org/pub/ruby/1.4 ruby_1.5_url=http://www.mirrorservice.org/sites/ftp.ruby-lang.org/pub/ruby/1.5 ruby_1.6_url=http://www.mirrorservice.org/sites/ftp.ruby-lang.org/pub/ruby/1.6 ruby_1.7_url=http://www.mirrorservice.org/sites/ftp.ruby-lang.org/pub/ruby/1.7 ruby_1.8_url=http://www.mirrorservice.org/sites/ftp.ruby-lang.org/pub/ruby/1.8 ruby_1.9_url=http://www.mirrorservice.org/sites/ftp.ruby-lang.org/pub/ruby/1.9 ruby_2.0_url=http://www.mirrorservice.org/sites/ftp.ruby-lang.org/pub/ruby/2.0</code></pre>
</td>
</tr>
</tbody>
</table>
</div>
</figure></div>
&nbsp;

我已把这个修攺提交到我们仓库里 <a title="http://github.com/liuhui998/rvm" href="http://github.com/liuhui998/rvm">http://github.com/liuhui998/rvm</a>
可以直接点击下载我改好后的 <a title="db 文件" href="https://raw.github.com/liuhui998/rvm/0f0be9a1316d607a9956415110bef8ea9b8a6726/config/db">文件</a>

大家改好 $rvm_path/config/db 文件后，最好能重启终端程序后再执行 rvm install 命令
这样新的 mirror 就会起效。

经过测试，改进后的 rvm， 在家中4M 以太网的速度可以达到200KB/s.

其本上解决了 rvm 下载 ruby 慢的问题。
