---
layout: post
title: "3 招实用Asset Pipeline 加速 --by xdite"
date: 2012-07-10 09:24
comments: true
categories: ["rails", "ruby"]
tags: ["asset", "pipline", "rails"]
---
## 3 招实用Asset Pipeline 加速 --by xdite
Asset Pipeline 最让人诟病的就是deploy 时花费速度过久。 在<a href="http://translate.googleusercontent.com/translate_c?hl=zh-CN&amp;prev=/search%3Fq%3D3-way-to-speedup-asset-pipeline/%26hl%3Dzh-CN%26newwindow%3D1%26safe%3Dstrict%26prmd%3Dimvns&amp;rurl=translate.google.com.hk&amp;sl=zh-TW&amp;u=http://www.meetup.com/Ruby-Taiwan-Group/&amp;usg=ALkJrhjELOiQOaWuvMEzLA44bw1JAEHk4Q">社群聚会</a>时发现大家都对这个主题非常不熟。 所以把最近累积了的这方面技巧整理出来分享给大家。
<h2>1. Capistrano deployment speedup</h2>
<h3>使用capistrano 内建task 执行assets:precompie</h3>
capistrano内建了<code>'deploy/assets'</code>这个task。 只要在<code>Capfile</code>里面

&nbsp;

<figure><figcaption>Capfile</figcaption>
<div>
<table>
<tbody>
<tr>
<td>
<pre>  1</pre>
</td>
<td>
<pre> <code>load 'deploy/assets'</code></pre>
</td>
</tr>
</tbody>
</table>
</div>
</figure>

&nbsp;

deploy 就会自动执行assets precompile 的动作。 由<a href="https://github.com/capistrano/capistrano/blob/master/lib/capistrano/recipes/deploy/assets.rb">原始档</a>可以看到这个task实际执行的是

<code>"cd /home/apps/APP_NAME/releases/20120708184757 &amp;&amp; bundle exec rake RAILS_ENV=production RAILS_GROUPS=assets assets:precompile"</code>

而执行的时机是

<code>after 'deploy:update_code', 'deploy:assets:precompile'</code>

许多开发者不知道有这一个task 可以用。 手动写task 去compile，造成了两个问题:
<ol>
	<li>时机执行错误。 Compile 时机错误会造成站上出现空白css。</li>
	<li>执行compile 机器负担太重。 如果是手写的task 通常会是load 整个production 的环境去compile。与只load assets 这个group 所吃的系统资源「有可能」差得非常多。</li>
</ol>
<h3>如果没有变更到assets 时，就不compile</h3>
请把这里面的内容贴到你的deploy.rb 档里面
<div>
<div id="gist-3072362">
<div>
<div>
<div>
<table>
<tbody>
<tr>
<td>
<pre>1
2
3
4
5
6
7
8
9
10
11
12
13
14
15
16
17
18
19
20
21
22
23
24
25
26
27
28
29
30</pre>
</td>
<td>
<div id="LC1"># -*- encoding : utf-8 -*-</div>
<div id="LC3">set :assets_dependencies, %w(app/assets lib/assets vendor/assets Gemfile.lock config/routes.rb)</div>
<div id="LC5">namespace :deploy do</div>
<div id="LC6">  namespace :assets do</div>
<div id="LC8">    desc &lt;&lt;-DESC</div>
<div id="LC9">      Run the asset precompilation rake task. You can specify the full path \</div>
<div id="LC10">      to the rake executable by setting the rake variable. You can also \</div>
<div id="LC11">      specify additional environment variables to pass to rake via the \</div>
<div id="LC12">      asset_env variable. The defaults are:</div>
<div id="LC14">        set :rake, "rake"</div>
<div id="LC15">        set :rails_env, "production"</div>
<div id="LC16">        set :asset_env, "RAILS_GROUPS=assets"</div>
<div id="LC17">        set :assets_dependencies, fetch(:assets_dependencies) + %w(config/locales/js)</div>
<div id="LC18">    DESC</div>
<div id="LC19">    task :precompile, :roles =&gt; :web, :except =&gt; { :no_release =&gt; true } do</div>
<div id="LC20">      from = source.next_revision(current_revision)</div>
<div id="LC21">      if capture("cd #{latest_release} &amp;&amp; #{source.local.log(from)} #{assets_dependencies.join ' '} | wc -l").to_i &gt; 0</div>
<div id="LC22">        run %Q{cd #{latest_release} &amp;&amp; #{rake} RAILS_ENV=#{rails_env} #{asset_env} assets:precompile}</div>
<div id="LC23">      else</div>
<div id="LC24">        logger.info "Skipping asset pre-compilation because there were no asset changes"</div>
<div id="LC25">      end</div>
<div id="LC26">    end</div>
<div id="LC28">  end</div>
<div id="LC29">end</div></td>
</tr>
</tbody>
</table>
</div>
</div>
<div><a href="https://gist.github.com/raw/3072362/20d3c52d670af910096d4e9c41eca0b2675b0ca6/gistfile1.txt">view raw</a><a href="https://gist.github.com/3072362#file_gistfile1.txt">gistfile1.txt</a><a href="https://gist.github.com/3072362">This Gist</a> brought to you by <a href="http://github.com/">GitHub</a>.</div>
</div>
</div>
</div>
这是在Railsconf 2012的<a href="https://speakerdeck.com/u/czarneckid/p/railsconf-2012-stack-smashing-cornflower-blue">Stack Smashing</a>上学到的一招。

如果你的assets 档案没有变动的话，只要执行copy 上一版本的assets 就好了。 这段task 会侦测
<ul>
	<li>app/assets</li>
	<li>lib/assets</li>
	<li>vendor/assets</li>
	<li>Gemfile.lock</li>
	<li>confir/routes.rb</li>
</ul>
是否有变动。 基本上已经含了所有可能assets 会变动的可能性。 有变动才会重新compile。

整体上会加速<strong>非常非常的多</strong> 。
<h2>2. use @import carefully</h2>
<h3>避免使用@import “compass”; 这种写法</h3>
<a href="http://translate.googleusercontent.com/translate_c?hl=zh-CN&amp;prev=/search%3Fq%3D3-way-to-speedup-asset-pipeline/%26hl%3Dzh-CN%26newwindow%3D1%26safe%3Dstrict%26prmd%3Dimvns&amp;rurl=translate.google.com.hk&amp;sl=zh-TW&amp;u=http://compass-style.org/&amp;usg=ALkJrhhOJafMffZNoGN_mrKZd66K8IgcBA">compass</a>是大家很爱用的SCSS framework。 大家写gradiant 或者css spriate 很常直接开下去。

但是你知道

&nbsp;

<figure><figcaption></figcaption>
<div>
<table>
<tbody>
<tr>
<td>
<pre>  1</pre>
</td>
<td>
<pre> <code>@import "compass" ;</code></pre>
</td>
</tr>
</tbody>
</table>
</div>
</figure>

&nbsp;

和

&nbsp;

<figure><figcaption></figcaption>
<div>
<table>
<tbody>
<tr>
<td>
<pre>  1</pre>
</td>
<td>
<pre> <code>@import "compass/typography/links/link-colors" ;</code></pre>
</td>
</tr>
</tbody>
</table>
</div>
</figure>

&nbsp;

这两种写法。

前者compile 的速度可能比后者慢到9 倍以上吗？

会这么慢的原因，是因为compass本身即是<a href="https://github.com/chriseppstein/compass/blob/stable/frameworks/compass/stylesheets/_compass.scss">懒人包</a> ， <code>@import "compass";</code>会把
<ul>
	<li>“compass/utilities”;</li>
	<li>“compass/typography”;</li>
	<li>“compass/css3”;</li>
</ul>
下面的东西<strong>通通</strong>都挂起来（还跑directory recursive）。

所以自然慢到爆炸。 如果要用什么helper，请直接挂它单支的CSS 就好了，不要整包都挂上来。

全挂其慢无比是正常的。
<h3>避免使用partial</h3>
我知道partial 是SCSS 整理术的大绝招。 但是若非必要，也尽量避免一直单档一路@import 到底。

&nbsp;

<figure><figcaption>common.css.scss</figcaption>
<div>
<table>
<tbody>
<tr>
<td>
<pre>  1
 2
 3</pre>
</td>
<td>
<pre> <code>@import "reset" ; @import "base" ; @import "product" ;</code></pre>
</td>
</tr>
</tbody>
</table>
</div>
</figure><figure><figcaption>common.css.scss</figcaption>
<div>
<table>
<tbody>
<tr>
<td>
<pre>  1
 2
 3</pre>
</td>
<td>
<pre> <code>//= require "reset" //= require "base" //= require "product"</code></pre>
</td>
</tr>
</tbody>
</table>
</div>
</figure>

&nbsp;

这两个在asset pipeline 输出结果是一样的。 但后者会比前者快。

如果真的需要用到非得使用partial 的技巧（如需读变数用require 读​​不到，@import 才读得到）再使用即可，因为只要一牵涉到directory recursive compile 就会慢…
<h2>3. don't require .scss &amp; .coffee for no reason</h2>
<h3>避免使用require_tree</h3>
使用generator 产生controller 时，rails 会自动帮忙产生
<ul>
	<li>product.css.scss</li>
	<li>product.js.coffee</li>
</ul>
然后application.css 与application.js 会利用

&nbsp;

<figure><figcaption>application.css</figcaption>
<div>
<table>
<tbody>
<tr>
<td>
<pre>  1</pre>
</td>
<td>
<pre> <code>//= require_tree</code></pre>
</td>
</tr>
</tbody>
</table>
</div>
</figure>

&nbsp;

这种技巧来把这些档案挂上去。

但是你知道吗？ 就算这些档案里面只写了这几行注解：

&nbsp;

<figure><figcaption></figcaption>
<div>
<table>
<tbody>
<tr>
<td>
<pre>  1
 2
 3</pre>
</td>
<td>
<pre> <code># Place all the behaviors and hooks related to the matching controller here. # All this logic will automatically be available in application.js. # You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/</code></pre>
</td>
</tr>
</tbody>
</table>
</div>
</figure>

&nbsp;

而且实际执行结果也等于空输出。 compile 一支大概也要250ms。 你可以想想，多compile 10 支，就是2.5 秒了。 难怪超耗时。
<h3>可以使用.js 或.css 解决的不要用.scss 与.coffee 当结尾</h3>
&nbsp;

<figure><figcaption></figcaption>
<div>
<table>
<tbody>
<tr>
<td>
<pre>  1
 2
 3
 4
 5</pre>
</td>
<td>
<pre> <code>Compiled jquery-ui-1.8.16.custom.css (0ms) (pid 19108) Compiled jquery.ui.1.8.16.ie.css (0ms) (pid 19108) Compiled jquery.js (5ms) (pid 19108) Compiled jquery_ujs.js (0ms) (pid 19108) Compiled custom.css (14ms) (pid 19108)</code></pre>
</td>
</tr>
</tbody>
</table>
</div>
</figure>

&nbsp;

其中custom.css 的档名是custom.css.scss

这样应该知道为什么不要乱用scss 当档名了吧？
<h2>小结</h2>
为了方便大家调整，我把具体加速assets precompile 过程的步骤罗列在下面。
<h4>1. 换掉deploy.rb 的assets precompile tasks</h4>
<h4>2. 观察logs/product.log。</h4>
<ol>
	<li>找出慢的assets。</li>
	<li>拿掉直接使用import “comppass”; 的SCSS，改用功能针对性写法。</li>
	<li>不需要使用@import 写法的改用require</li>
	<li>拿掉require_tree，改用//=require 一行一行挂上去</li>
	<li>删掉空的scss 与coffeescript</li>
	<li>单纯只是CSS 的不要自作聪明帮忙加上.scss 档名。</li>
</ol>
====

如果有什么问题，欢迎各位在底下留言讨论。

也欢迎大家有空来<a href="http://translate.googleusercontent.com/translate_c?hl=zh-CN&amp;prev=/search%3Fq%3D3-way-to-speedup-asset-pipeline/%26hl%3Dzh-CN%26newwindow%3D1%26safe%3Dstrict%26prmd%3Dimvns&amp;rurl=translate.google.com.hk&amp;sl=zh-TW&amp;u=http://www.meetup.com/Ruby-Taiwan-Group/&amp;usg=ALkJrhjELOiQOaWuvMEzLA44bw1JAEHk4Q">Rails Tuesday</a>坐坐。 我很乐意帮大家解答问题。

PS如果你是要问<a href="http://translate.googleusercontent.com/translate_c?hl=zh-CN&amp;prev=/search%3Fq%3D3-way-to-speedup-asset-pipeline/%26hl%3Dzh-CN%26newwindow%3D1%26safe%3Dstrict%26prmd%3Dimvns&amp;rurl=translate.google.com.hk&amp;sl=zh-TW&amp;u=http://rails-101.logdown.com/&amp;usg=ALkJrhi9o1R7dFefWuKlx-RM98hTzl6FIA">Rails 101</a>书上的问题，请找小蟹。
