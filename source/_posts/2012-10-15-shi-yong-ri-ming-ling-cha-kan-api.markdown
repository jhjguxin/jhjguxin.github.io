---
layout: post
title: "使用 ri 命令查看 API"
date: 2012-01-18 12:02
comments: true
categories: ["未分类"]
tags: ["doc", "rails", "ruby"]
---
## 使用 ri 命令查看 API
<div>

经常去 APIDOCK.COM 查询标准 API，今天访问时忽然变得很慢，忽然想起 Ruby 有自己的 Rdoc，是不是能自己生成一个本地的文档呢。

隐约记得有两种方法查看本地文档，一个是使用 ri 命令，一个是用 Rdoc 生成 Html 格式的文件在浏览器中查询。ri 文档基于 Rdoc 来生成。我更喜欢使用命令行格式的，不过直接 ri 了一下，只有几个 gem 的文档，没有 Ruby 核心和标准库的。我用的是 rvm，rvm 安装 rubies 后并不会自动生成 rdoc，还需要手动生成。
<h2>删除 gem 文档</h2>
因为 <code>ri method</code> 会列出所有包含 method 的 gem，为了不让输出显得凌乱，需要把默认的 gem 的 doc 全部去掉，这些 gem 很多只是为了解决依赖自动下载的并不常用，也不需要。先贴一下 gem 环境
<div>
<div id="highlighter_16375">
<table border="0" cellspacing="0" cellpadding="0">
<tbody>
<tr>
<td>
<div>
<div><code>abc@abc-desktop:~$ gem </code><code>env</code></div>
<div><code>RubyGems Environment: </code></div>
<div><code>  </code><code>- RUBYGEMS VERSION: 1.6.2 </code></div>
<div><code>  </code><code>- RUBY VERSION: 1.9.2 (2011-02-18 patchlevel 180) [i686-linux] </code></div>
<div><code>  </code><code>- INSTALLATION DIRECTORY: </code><code>/home/abc/</code><code>.rvm</code><code>/gems/ruby-1</code><code>.9.2-p180 </code></div>
<div><code>  </code><code>- RUBY EXECUTABLE: </code><code>/home/abc/</code><code>.rvm</code><code>/rubies/ruby-1</code><code>.9.2-p180</code><code>/bin/ruby</code></div>
<div><code>  </code><code>- EXECUTABLE DIRECTORY: </code><code>/home/abc/</code><code>.rvm</code><code>/gems/ruby-1</code><code>.9.2-p180</code><code>/bin</code></div>
<div><code>  </code><code>- RUBYGEMS PLATFORMS: </code></div>
<div><code>    </code><code>- ruby </code></div>
<div><code>    </code><code>- x86-linux </code></div>
<div><code>  </code><code>- GEM PATHS: </code></div>
<div><code>     </code><code>- </code><code>/home/abc/</code><code>.rvm</code><code>/gems/ruby-1</code><code>.9.2-p180 </code></div>
<div><code>     </code><code>- </code><code>/home/abc/</code><code>.rvm</code><code>/gems/ruby-1</code><code>.9.2-p180@global </code></div>
<div><code>  </code><code>- GEM CONFIGURATION: </code></div>
<div><code>     </code><code>- :update_sources =&gt; </code><code>true</code></div>
<div><code>     </code><code>- :verbose =&gt; </code><code>true</code></div>
<div><code>     </code><code>- :benchmark =&gt; </code><code>false</code></div>
<div><code>     </code><code>- :backtrace =&gt; </code><code>false</code></div>
<div><code>     </code><code>- :bulk_threshold =&gt; 1000 </code></div>
<div><code>  </code><code>- REMOTE SOURCES: </code></div>
<div><code>     </code><code>- http:</code><code>//rubygems</code><code>.org/</code></div>
</div></td>
</tr>
</tbody>
</table>
</div>
</div>
进入 GEM PATHS 即 ~/.rvm/gems/ruby-1.9.2-p180/doc 中执行 <code>rm -rf</code> 删除掉所有文档。

gem 安装时选择 <code>gem install <em>gemname</em> --no-ri --no-rdoc</code> 可以避免生成文档，如果不想每次麻烦输入，执行 <code>echo 'install: --no-rdoc --no-ri' &gt; ~/.gemrc</code> 新建并写入配置文件即可。

rvm 的 gem 默认会从 ~/.vimrc 以及 $ruby_path/etc/gemrc 下读取配置文件。后者可以通过 IRB 中执行 <code>Gem::ConfigFile::SYSTEM_WIDE_CONFIG_FILE</code> 查看。
<h2>安装 Rdoc/ri 文档</h2>
删除 gem 文档后，使用 <code>rvm doc generate</code> 生成当前版本 Ruby 的文档，涵盖核心类和标准库。生成的 Html 文档会存放在 /.rvm/docs 下。

命令 ri 的使用示例：
<div>
<div id="highlighter_187585">
<table border="0" cellspacing="0" cellpadding="0">
<tbody>
<tr>
<td>
<div>
<div><code>ri Array</code><code>#sort </code></div>
<div><code>ri IO.readlines </code></div>
<div><code>ri String </code></div>
<div><code>ri gsub </code></div>
<div><code>ri File::</code><code>dirname</code></div>
</div></td>
</tr>
</tbody>
</table>
</div>
</div>
还可以加入一些常用的 gem 的文档，比如 nokogiri，<code>gem rdoc nokogiri -v 1.5.0</code>
<div>标签： <a href="http://jhjguxin.hwcrazy.com/tag/doc/">doc</a> <a href="http://jhjguxin.hwcrazy.com/tag/rails/">rails</a> <a href="http://jhjguxin.hwcrazy.com/tag/ruby/">ruby</a></div>
</div>
