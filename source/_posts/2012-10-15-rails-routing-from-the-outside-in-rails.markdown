---
layout: post
title: "Rails Routing from the Outside In Rails"
date: 2011-12-29 00:23
comments: true
categories: [rails,ruby]
tags: [guide,http,rails,route,ruby,translate]
---
## Rails Routing from the Outside In Rails
<h2>Rails Routing from the Outside In Rails<span style="font-family: WenQuanYi Micro Hei;">来自外部的</span>Routing</h2>
This guide covers the user-facing features of Rails routing. By referring to this guide, you will be able to:

<span style="font-family: DejaVu Sans;">这个</span>guide<span style="font-family: DejaVu Sans;">涵盖了面向用户的</span>Rails<span style="font-family: DejaVu Sans;">路由特性。通过参考这个</span>guide<span style="font-family: DejaVu Sans;">，你将能够：</span>

Understand the code in <tt>routes.rb</tt>

<span style="font-family: DejaVu Sans;">明白在</span><tt>routes.rb</tt><span style="font-family: DejaVu Sans;"><tt>中的代码</tt></span>
<ul>
	<li>Construct your own routes, using either the preferred resourceful style or the <tt>match</tt> method</li>
</ul>
<span style="font-family: DejaVu Sans;">构建属于你的</span>routes<span style="font-family: DejaVu Sans;">，要么首选使用</span>resourceful style<span style="font-family: DejaVu Sans;">要么使用</span>match<span style="font-family: DejaVu Sans;">方法</span>
<ul>
	<li>Identify what parameters to expect an action to receive</li>
</ul>
<span style="font-family: DejaVu Sans;">确定什么样的参数</span>expect<span style="font-family: DejaVu Sans;">（预期）一个</span>action<span style="font-family: DejaVu Sans;">来接收（</span>url<span style="font-family: DejaVu Sans;">）</span>
<ul>
	<li>Automatically create paths and URLs using route helpers</li>
</ul>
<span style="font-family: DejaVu Sans;">自动的创建路径和</span>URLs<span style="font-family: DejaVu Sans;">使用</span>route helpers
<ul>
	<li>Use advanced techniques such as constraints and Rack endpoints</li>
</ul>
<span style="font-family: DejaVu Sans;">使用高级的技术比如公约和</span>Rack endpoints
<h3><a name="the-purpose-of-the-rails-router"></a>1 The Purpose of the Rails Router</h3>
The Rails router recognizes URLs and dispatches them to a controller’s action. It can also generate paths and URLs, avoiding the need to hardcode strings in your views.

Rails router<span style="font-family: DejaVu Sans;">组织</span>URLs<span style="font-family: DejaVu Sans;">和</span>dispatches(<span style="font-family: DejaVu Sans;">调度</span>)<span style="font-family: DejaVu Sans;">到一个</span>controller<span style="font-family: DejaVu Sans;">的</span>action<span style="font-family: DejaVu Sans;">中。它也可以创建</span>paths<span style="font-family: DejaVu Sans;">和</span>URLs<span style="font-family: DejaVu Sans;">，避免需要</span>hardcode string<span style="font-family: DejaVu Sans;">到你的视图中。</span>
<h4><a name="connecting-urls-to-code"></a>1.1 Connecting URLs to Code<span style="font-family: WenQuanYi Micro Hei;">连接</span>URLs<span style="font-family: WenQuanYi Micro Hei;">到</span>Code</h4>
When your Rails application receives an incoming request

<span style="font-family: DejaVu Sans;">当你的</span>Rails<span style="font-family: DejaVu Sans;">应用程序收到一个传入请求（</span>incoming requests (<span style="font-family: DejaVu Sans;">传入请求</span>)<span style="font-family: DejaVu Sans;">正传递给用户的网站内容。）</span>

GET /patients/17

it asks the router to match it to a controller action. If the first matching route is

<span style="font-family: DejaVu Sans;">它请求</span>router<span style="font-family: DejaVu Sans;">匹配</span>URLs<span style="font-family: DejaVu Sans;">到一个</span>controller action<span style="font-family: DejaVu Sans;">。如果第一个匹配的</span>route<span style="font-family: DejaVu Sans;">是</span>

match "/patients/:id" =&gt; "patients#show"

the request is dispatched to the <tt>patients</tt> controller’s <tt>show</tt> action with <tt>{</tt><tt> </tt><tt>:id</tt><tt> </tt><tt>=&gt;</tt><tt> “</tt><tt>17</tt><tt>” </tt><tt>}</tt> in <tt>params</tt>.

<span style="font-family: DejaVu Sans;">这个请求被调度给</span>patients controller<span style="font-family: DejaVu Sans;">的</span>show action<span style="font-family: DejaVu Sans;">以及</span><tt>{</tt><tt> </tt><tt>:id</tt><tt> </tt><tt>=&gt;</tt><tt> “</tt><tt>17</tt><tt>” </tt><tt>}</tt><span style="font-family: DejaVu Sans;"><tt>在</tt></span><tt>params</tt><span style="font-family: DejaVu Sans;"><tt>字典中。</tt></span>
<h4><a name="generating-paths-and-urls-from-code"></a> 1.2 Generating Paths and URLs from Code<span style="font-family: WenQuanYi Micro Hei;">从</span>Code<span style="font-family: WenQuanYi Micro Hei;">创建</span>Paths<span style="font-family: WenQuanYi Micro Hei;">和</span>URLs</h4>
You can also generate paths and URLs. If your application contains this code:

<span style="font-family: DejaVu Sans;">你可以创建</span>paths<span style="font-family: DejaVu Sans;">和</span>URLs<span style="font-family: DejaVu Sans;">。如果你的应用程序中包含这样的代码：</span>

@patient = Patient.find(17)

&lt;%= link_to "Patient Record", patient_path(@patient) %&gt;

The router will generate the path <tt>/patients/17</tt>. This reduces the brittleness of your view and makes your code easier to understand. Note that the id does not need to be specified in the route helper.

Router<span style="font-family: DejaVu Sans;">将会创建</span>path <tt>/patients/17</tt><span style="font-family: DejaVu Sans;"><tt>。这样减少了你的视图的脆性并且使得你的代码更加容易明白。</tt></span>
<h3><a name="resource-routing-the-rails-default"></a>2 Resource Routing: the Rails Default</h3>
Resource routing allows you to quickly declare all of the common routes for a given resourceful controller. Instead of declaring separate routes for your <tt>index</tt>, <tt>show</tt>, <tt>new</tt>, <tt>edit</tt>, <tt>create</tt>, <tt>update</tt> and <tt>destroy</tt> actions, a resourceful route declares them in a single line of code.

Resource routing<span style="font-family: DejaVu Sans;">让你快速的为一个提供的</span>resourceful<span style="font-family: DejaVu Sans;">的</span>controller<span style="font-family: DejaVu Sans;">声明所有的常用</span>routes<span style="font-family: DejaVu Sans;">。替代你去声明单个的</span><tt>index</tt>, <tt>show</tt>, <tt>new</tt>, <tt>edit</tt>, <tt>create</tt>, <tt>update</tt> and <tt>destroy</tt> actions<span style="font-family: DejaVu Sans;">的</span>routes<span style="font-family: DejaVu Sans;">，一个</span>resourceful route<span style="font-family: DejaVu Sans;">声明它们在一个单行代码中。</span>

When your Rails application receives an incoming request for

<span style="font-family: DejaVu Sans;">当你的</span>Rails<span style="font-family: DejaVu Sans;">应用程序收到一个这样的传入请求</span>

DELETE /photos/17

it asks the router to map it to a controller action. If the first matching route is

<span style="font-family: DejaVu Sans;">它请求</span>router<span style="font-family: DejaVu Sans;">匹配</span>URLs<span style="font-family: DejaVu Sans;">到一个</span>controller action<span style="font-family: DejaVu Sans;">。如果第一个匹配的</span>route<span style="font-family: DejaVu Sans;">是</span>

resources :photos

Rails would dispatch that request to the <tt>destroy</tt> method on the <tt>photos</tt> controller with <tt>{</tt><tt> </tt><tt>:id</tt><tt> </tt><tt>=&gt;</tt><tt> “</tt><tt>17</tt><tt>” </tt><tt>}</tt> in <tt>params</tt>.

Rails<span style="font-family: DejaVu Sans;">将会把这个请求调度给</span><tt>photos</tt> controller<span style="font-family: DejaVu Sans;">的</span><tt>destroy</tt> action<span style="font-family: DejaVu Sans;">以及</span><tt>{</tt><tt> </tt><tt>:id</tt><tt> </tt><tt>=&gt;</tt><tt> “</tt><tt>17</tt><tt>” </tt><tt>}</tt><span style="font-family: DejaVu Sans;"><tt>在</tt></span><tt>params</tt><span style="font-family: DejaVu Sans;"><tt>字典中</tt></span>
<h4><a name="crud-verbs-and-actions"></a>2.2 CRUD, Verbs, and Actions</h4>
CRUD<span style="font-family: DejaVu Sans;">是指在做计算处理时的增加</span>(Create)<span style="font-family: DejaVu Sans;">、查询</span>(Retrieve)<span style="font-family: DejaVu Sans;">（重新得到数据）、更新</span>(Update)<span style="font-family: DejaVu Sans;">和删除</span>(Delete)<span style="font-family: DejaVu Sans;">几个单词的首字母简写。主要被用在描述软件系统中数据库或者持久层的基本操作功能。</span>

HTTP Verb HTTP<span style="font-family: DejaVu Sans;">动作</span>

In Rails, a resourceful route provides a mapping between HTTP verbs and URLs to controller actions. By convention, each action also maps to particular CRUD operations in a database. A single entry in the routing file, such as

<span style="font-family: DejaVu Sans;">在</span>Rails<span style="font-family: DejaVu Sans;">中，一个</span>resourceful route<span style="font-family: DejaVu Sans;">提供一个在</span>HTTP verbs<span style="font-family: DejaVu Sans;">和</span>URLs<span style="font-family: DejaVu Sans;">之间的映射到</span>controller actions<span style="font-family: DejaVu Sans;">。根据公约，每个</span>action<span style="font-family: DejaVu Sans;">都应该映射到数据库的</span>CRUD<span style="font-family: DejaVu Sans;">操作的一部分。一个单独的条目在</span>routing<span style="font-family: DejaVu Sans;">文件中，像这样</span>

resources :photos

creates seven different routes in your application, all mapping to the <tt>Photos</tt> controller:

<span style="font-family: DejaVu Sans;">创建七个不同的</span>routes<span style="font-family: DejaVu Sans;">在你的应用程序中，所有的这些</span>routes<span style="font-family: DejaVu Sans;">映射到</span>Photos controller<span style="font-family: DejaVu Sans;">：</span>

&nbsp;
<table width="573" cellspacing="0" cellpadding="2"><colgroup><col width="89" /> <col width="102" /> <col width="54" /> <col width="311" /> </colgroup>
<tbody>
<tr>
<th width="89">HTTP Verb</th>
<th width="102">Path</th>
<th width="54">action</th>
<th width="311">used for</th>
</tr>
<tr>
<td width="89">GET</td>
<td width="102">/photos</td>
<td width="54">index</td>
<td width="311">display a list of all photos</td>
</tr>
<tr>
<td width="89">GET</td>
<td width="102">/photos/new</td>
<td width="54">new</td>
<td width="311">return an HTML form for creating a new photo</td>
</tr>
<tr>
<td width="89">POST</td>
<td width="102">/photos</td>
<td width="54">create</td>
<td width="311">create a new photo</td>
</tr>
<tr>
<td width="89">GET</td>
<td width="102">/photos/:id</td>
<td width="54">show</td>
<td width="311">display a specific photo</td>
</tr>
<tr>
<td width="89">GET</td>
<td width="102">/photos/:id/edit</td>
<td width="54">edit</td>
<td width="311">return an HTML form for editing a photo</td>
</tr>
<tr>
<td width="89">PUT</td>
<td width="102">/photos/:id</td>
<td width="54">update</td>
<td width="311">update a specific photo</td>
</tr>
<tr>
<td width="89">DELETE</td>
<td width="102">/photos/:id</td>
<td width="54">destroy</td>
<td width="311">delete a specific photo</td>
</tr>
</tbody>
</table>
Rails routes are matched in the order they are specified, so if you have a <tt>resources</tt><tt> </tt><tt>:photos</tt> above a <tt>get</tt><tt> </tt><tt>'photos/poll'</tt> the <tt>show</tt> action’s route for the <tt>resources</tt> line will be matched before the <tt>get</tt> line. To fix this, move the <tt>get</tt> line <strong>above</strong> the <tt>resources</tt> line so that it is matched first.

<strong>Rails</strong><strong> </strong><strong>routes</strong><span style="font-family: DejaVu Sans;"><strong>在它们指定的顺序中匹配，因此如果你有一个</strong></span><tt><strong>resources</strong></tt><tt><strong> </strong></tt><tt><strong>:photos</strong></tt><span style="font-family: DejaVu Sans;"><tt><strong>在</strong></tt></span><tt><strong>get</strong></tt><tt><strong> </strong></tt><tt><strong>'photos/poll'</strong></tt><span style="font-family: DejaVu Sans;"><tt><strong>的上面，</strong></tt></span><tt><strong>resources</strong></tt><tt><strong> </strong></tt><tt><strong>line</strong></tt><span style="font-family: DejaVu Sans;"><tt><strong>的</strong></tt></span><tt><strong>show</strong></tt><tt><strong> </strong></tt><tt><strong>action</strong></tt><span style="font-family: DejaVu Sans;"><tt><strong>的</strong></tt></span><tt><strong>route</strong></tt><span style="font-family: DejaVu Sans;"><tt><strong>将会在</strong></tt></span><tt><strong>get</strong></tt><tt><strong> </strong></tt><tt><strong>line</strong></tt><span style="font-family: DejaVu Sans;"><tt><strong>之前先被匹配。要修复这些，移动</strong></tt></span><tt><strong>get</strong></tt><tt><strong> </strong></tt><tt><strong>line</strong></tt><span style="font-family: DejaVu Sans;"><tt><strong>在</strong></tt></span><tt><strong>resources</strong></tt><tt><strong> </strong></tt><tt><strong>line</strong></tt><span style="font-family: DejaVu Sans;"><tt><strong>上面以确保</strong></tt></span><tt><strong>get</strong></tt><tt><strong> </strong></tt><tt><strong>line</strong></tt><span style="font-family: DejaVu Sans;"><tt><strong>被首先匹配。</strong></tt></span>
<h4><a name="paths-and-urls"></a>2.3 Paths and URLs</h4>
Creating a resourceful route will also expose a number of helpers to the controllers in your application. In the case of <tt>resources</tt><tt> </tt><tt>:photos</tt>:

<span style="font-family: DejaVu Sans;">在你的应用程序中创建一个</span>resourceful<span style="font-family: DejaVu Sans;">的</span>route<span style="font-family: DejaVu Sans;">也将会摆出一系列的</span>controllers<span style="font-family: DejaVu Sans;">的</span>helpers<span style="font-family: DejaVu Sans;">，在这里的情况中</span><tt>resources</tt><tt> </tt><tt>:photos</tt><span style="font-family: DejaVu Sans;"><tt>如下：</tt></span>
<ul>
	<li><tt>photos_path</tt> returns <tt>/photos</tt></li>
	<li><tt>new_photo_path</tt> returns <tt>/photos/new</tt></li>
	<li><tt>edit_photo_path(:id)</tt> returns <tt>/photos/:id/edit</tt> (for instance, <tt>edit_photo_path(10)</tt> returns <tt>/photos/10/edit</tt>)</li>
	<li><tt>photo_path(:id)</tt> returns <tt>/photos/:id</tt> (for instance, <tt>photo_path(10)</tt> returns <tt>/photos/10</tt>)</li>
</ul>
Each of these helpers has a corresponding <tt>_url</tt> helper (such as <tt>photos_url</tt>) which returns the same path prefixed with the current host, port and path prefix.

<span style="font-family: DejaVu Sans;">这里的每个</span>helpers<span style="font-family: DejaVu Sans;">都有一个相应的</span>_url helper<span style="font-family: DejaVu Sans;">（例如</span><tt>photos_url</tt><span style="font-family: DejaVu Sans;"><tt>，</tt></span><tt>edit_photo_url(1)</tt><span style="font-family: DejaVu Sans;">）</span>

<span style="font-family: DejaVu Sans;">其将会返回相同的路径后缀以及当前主机，端口和路径后缀。</span>

####the code in my demo#####

#@tmp=post_url(1)

#@tmp=posts_url

#@tmp=edit_post_url(:id)

@tmp=new_post_url

Because the router uses the HTTP verb and URL to match inbound requests, four URLs map to seven different actions.

<span style="font-family: DejaVu Sans;">因为</span>router<span style="font-family: DejaVu Sans;">使用</span>HTTP verb<span style="font-family: DejaVu Sans;">和</span>URL<span style="font-family: DejaVu Sans;">来匹配入站请求，四种</span>URLs<span style="font-family: DejaVu Sans;">映射到七种不同的</span>actions<span style="font-family: DejaVu Sans;">中。</span>
<h4><a name="defining-multiple-resources-at-the-same-"></a> 2.4 Defining Multiple Resources at the Same Time<span style="font-family: WenQuanYi Micro Hei;">在同一时间定义多个</span>Resource</h4>
If you need to create routes for more than one resource, you can save a bit of typing by defining them all with a single call to <tt>resources</tt>:

<span style="font-family: DejaVu Sans;">如果你需要为超过一个</span>resource<span style="font-family: DejaVu Sans;">创建</span>routes<span style="font-family: DejaVu Sans;">，你可以保存它们到一组中通过调用单个</span>resources<span style="font-family: DejaVu Sans;">来定义所有的</span>resource<span style="font-family: DejaVu Sans;">：</span>

resources :photos, :books, :videos

This works exactly the same as

<span style="font-family: DejaVu Sans;">这里工作类似于：</span>

resources :photos

resources :books

resources :videos
<h4><a name="singular-resources"></a>2.5 Singular Resources <span style="font-family: WenQuanYi Micro Hei;">单数</span>Resources</h4>
Sometimes, you have a resource that clients always look up without referencing an ID. For example, you would like <tt>/profile</tt> to always show the profile of the currently logged in user. In this case, you can use a singular resource to map <tt>/profile</tt> (rather than <tt>/profile/:id</tt>) to the <tt>show</tt> action.

<span style="font-family: DejaVu Sans;">有时候，你有一个</span>resource<span style="font-family: DejaVu Sans;">，</span>clients<span style="font-family: DejaVu Sans;">通常查找它们并不引用一个</span>ID<span style="font-family: DejaVu Sans;">。例如，你将会希望</span><tt>/profile</tt><span style="font-family: DejaVu Sans;"><tt>来总是显示当前的登录的用户的</tt></span><tt>profile</tt><span style="font-family: DejaVu Sans;"><tt>。在这种情况中，你可以使用一个单数的</tt></span><tt>resource</tt><span style="font-family: DejaVu Sans;"><tt>来映射</tt></span><tt>/profile</tt><tt> </tt><tt>(rather</tt><tt> </tt><tt>than</tt><tt> </tt><tt>/profile/:id)</tt><span style="font-family: DejaVu Sans;"><tt>到</tt></span><tt>show</tt><tt> </tt><tt>ation</tt><span style="font-family: DejaVu Sans;"><tt>。</tt></span>

match "profile" =&gt; "users#show"

This resourceful route<span style="font-family: DejaVu Sans;">这里是</span>resourceful route

resource :geocoder

creates six different routes in your application, all mapping to the <tt>Geocoders</tt> controller:

<span style="font-family: DejaVu Sans;">在你的应用程序中创建六种不同的</span>routes<span style="font-family: DejaVu Sans;">，所有的</span>routes<span style="font-family: DejaVu Sans;">映射到</span><tt>Geocoders</tt><span style="font-family: DejaVu Sans;"><tt>的</tt></span><tt>cotroller</tt><span style="font-family: DejaVu Sans;"><tt>：</tt></span>

&nbsp;
<table width="575" cellspacing="0" cellpadding="2"><colgroup><col width="89" /> <col width="101" /> <col width="54" /> <col width="315" /> </colgroup>
<tbody>
<tr>
<th width="89">HTTP Verb</th>
<th width="101">Path</th>
<th width="54">action</th>
<th width="315">used for</th>
</tr>
<tr>
<td width="89">GET</td>
<td width="101">/geocoder/new</td>
<td width="54">new</td>
<td width="315">return an HTML form for creating the geocoder</td>
</tr>
<tr>
<td width="89">POST</td>
<td width="101">/geocoder</td>
<td width="54">create</td>
<td width="315">create the new geocoder</td>
</tr>
<tr>
<td width="89">GET</td>
<td width="101">/geocoder</td>
<td width="54">show</td>
<td width="315">display the one and only geocoder resource</td>
</tr>
<tr>
<td width="89">GET</td>
<td width="101">/geocoder/edit</td>
<td width="54">edit</td>
<td width="315">return an HTML form for editing the geocoder</td>
</tr>
<tr>
<td width="89">PUT</td>
<td width="101">/geocoder</td>
<td width="54">update</td>
<td width="315">update the one and only geocoder resource</td>
</tr>
<tr>
<td width="89">DELETE</td>
<td width="101">/geocoder</td>
<td width="54">destroy</td>
<td width="315">delete the geocoder resource</td>
</tr>
</tbody>
</table>
Because you might want to use the same controller for a singular route (/account) and a plural route (/accounts/45), singular resources map to plural controllers.

<span style="font-family: DejaVu Sans;"><tt>因为你可能希望对单数</tt></span><tt>route(/account)</tt><span style="font-family: DejaVu Sans;"><tt>和复数</tt></span><tt>route(/accounts/45)</tt><span style="font-family: DejaVu Sans;"><tt>使用相同的</tt></span><tt>controller</tt><span style="font-family: DejaVu Sans;"><tt>，单数</tt></span><tt>resources</tt><span style="font-family: DejaVu Sans;"><tt>映射到复数</tt></span><tt>controllers</tt><span style="font-family: DejaVu Sans;"><tt>。</tt></span>

<tt>A</tt><tt> </tt><tt>singular</tt><tt> </tt><tt>resourceful</tt><tt> </tt><tt>route</tt><tt> </tt><tt>generates</tt><tt> </tt><tt>these</tt><tt> </tt><tt>helpers:</tt>

<span style="font-family: DejaVu Sans;"><tt>一个单数</tt></span><tt>resourceful</tt><tt> </tt><tt>route</tt><span style="font-family: DejaVu Sans;"><tt>创建这些</tt></span><tt>helpers</tt><span style="font-family: DejaVu Sans;"><tt>：</tt></span>
<ul>
	<li><tt>new_geocoder_path</tt> returns <tt>/geocoder/new</tt></li>
	<li><tt>edit_geocoder_path</tt> returns <tt>/geocoder/edit</tt></li>
	<li><tt>geocoder_path</tt> returns <tt>/geocoder</tt></li>
</ul>
<tt>As</tt><tt> </tt><tt>with</tt><tt> </tt><tt>plural</tt><tt> </tt><tt>resources,</tt><tt> </tt><tt>the</tt><tt> </tt><tt>same</tt><tt> </tt><tt>helpers</tt><tt> </tt><tt>ending</tt><tt> </tt><tt>in</tt><tt> </tt><tt>_url</tt><tt> </tt><tt>will</tt><tt> </tt><tt>also</tt><tt> </tt><tt>include</tt><tt> </tt><tt>the</tt><tt> </tt><tt>host,</tt><tt> </tt><tt>port</tt><tt> </tt><tt>and</tt><tt> </tt><tt>path</tt><tt> </tt><tt>prefix.</tt>

<span style="font-family: DejaVu Sans;"><tt>就像</tt></span><tt>plural</tt><tt> </tt><tt>resources</tt><span style="font-family: DejaVu Sans;"><tt>，相同的以</tt></span><tt>_url</tt><span style="font-family: DejaVu Sans;"><tt>结尾的</tt></span><tt>helpers</tt><span style="font-family: DejaVu Sans;"><tt>同样包含，</tt></span><tt>host</tt><span style="font-family: DejaVu Sans;"><tt>，</tt></span><tt>port</tt><span style="font-family: DejaVu Sans;"><tt>和路径后缀。</tt></span>
<h4><a name="controller-namespaces-and-routing"></a><tt>2.6</tt><tt> </tt><tt>Controller</tt><tt> </tt><tt>Namespaces</tt><tt> </tt><tt>and</tt><tt> </tt><tt>Routing</tt></h4>
You may wish to organize groups of controllers under a namespace. Most commonly, you might group a number of administrative controllers under an <tt>Admin::</tt> namespace. You would place these controllers under the <tt>app/controllers/admin</tt> directory, and you can group them together in your router:

<span style="font-family: DejaVu Sans;"><tt>你可能希望通过</tt></span><tt>namespace</tt><span style="font-family: DejaVu Sans;"><tt>分组组织</tt></span><tt>controllers</tt><span style="font-family: DejaVu Sans;"><tt>。通常大多数情况，你可以分组一系列的</tt><tt></tt></span><tt>administrative</tt><tt> </tt><tt>controllers</tt><span style="font-family: DejaVu Sans;"><tt>到一个</tt></span><tt>Admin::</tt><span style="font-family: DejaVu Sans;"><tt>名称空间下面。你将会放置这些</tt></span><tt>controllers</tt><span style="font-family: DejaVu Sans;"><tt>在</tt><tt></tt></span><tt>app/controllers/admin</tt><span style="font-family: DejaVu Sans;"><tt>目录中，并且你可以在你的</tt></span><tt>router</tt><span style="font-family: DejaVu Sans;"><tt>中分组他们在一起</tt></span>

<tt>namespace</tt><tt> </tt><tt>:admin</tt><tt> </tt><tt>do</tt>

<tt> </tt><tt>resources</tt><tt> </tt><tt>:posts,</tt><tt> </tt><tt>:comments</tt>

<tt>end</tt>

<tt>This</tt><tt> </tt><tt>will</tt><tt> </tt><tt>create</tt><tt> </tt><tt>a</tt><tt> </tt><tt>number</tt><tt> </tt><tt>of</tt><tt> </tt><tt>routes</tt><tt> </tt><tt>for</tt><tt> </tt><tt>each</tt><tt> </tt><tt>of</tt><tt> </tt><tt>the</tt><tt> </tt><tt>posts</tt><tt> </tt><tt>and</tt><tt> </tt><tt>comments</tt><tt> </tt><tt>controller.</tt><tt> </tt><tt>For</tt><tt> </tt><tt>Admin::PostsController,</tt><tt> </tt><tt>Rails</tt><tt> </tt><tt>will</tt><tt> </tt><tt>create:</tt>

<span style="font-family: DejaVu Sans;"><tt>这将会对于每一个</tt></span><tt>posts</tt><span style="font-family: DejaVu Sans;"><tt>和</tt></span><tt>comments</tt><tt> </tt><tt>controller</tt><span style="font-family: DejaVu Sans;"><tt>创建若干的</tt></span><tt>routes</tt><span style="font-family: DejaVu Sans;"><tt>。对于</tt><tt></tt></span><tt>Admin::PostsController</tt><span style="font-family: DejaVu Sans;"><tt>，</tt></span><tt>Rails</tt><span style="font-family: DejaVu Sans;"><tt>将会创建：</tt></span>

&nbsp;
<table width="473" cellspacing="0" cellpadding="2"><colgroup><col width="89" /> <col width="136" /> <col width="54" /> <col width="178" /> </colgroup>
<tbody>
<tr>
<th width="89">HTTP Verb</th>
<th width="136">Path</th>
<th width="54">action</th>
<th width="178">named helper</th>
</tr>
<tr>
<td width="89">GET</td>
<td width="136">/admin/posts</td>
<td width="54">index</td>
<td width="178">admin_posts_path</td>
</tr>
<tr>
<td width="89">GET</td>
<td width="136">/admin/posts/new</td>
<td width="54">new</td>
<td width="178">new_admin_post_path</td>
</tr>
<tr>
<td width="89">POST</td>
<td width="136">/admin/posts</td>
<td width="54">create</td>
<td width="178">admin_posts_path</td>
</tr>
<tr>
<td width="89">GET</td>
<td width="136">/admin/posts/:id</td>
<td width="54">show</td>
<td width="178">admin_post_path(:id)</td>
</tr>
<tr>
<td width="89">GET</td>
<td width="136">/admin/posts/:id/edit</td>
<td width="54">edit</td>
<td width="178">edit_admin_post_path(:id)</td>
</tr>
<tr>
<td width="89">PUT</td>
<td width="136">/admin/posts/:id</td>
<td width="54">update</td>
<td width="178">admin_post_path(:id)</td>
</tr>
<tr>
<td width="89">DELETE</td>
<td width="136">/admin/posts/:id</td>
<td width="54">destroy</td>
<td width="178">admin_post_path(:id)</td>
</tr>
</tbody>
</table>
If you want to route /posts (without the prefix /admin) to Admin::PostsController, you could use

<span style="font-family: DejaVu Sans;"><tt>如果你想</tt></span><tt>Admin::PostsController</tt><span style="font-family: DejaVu Sans;"><tt>的</tt></span><tt>route</tt><tt> </tt><tt>/posts(without</tt><tt> </tt><tt>the</tt><tt> </tt><tt>prefix</tt><tt> </tt><tt>/admin)</tt><span style="font-family: DejaVu Sans;"><tt>，你可以使用</tt></span>

<tt>#</tt><span style="font-family: DejaVu Sans;"><tt>从</tt></span><tt>admin</tt><span style="font-family: DejaVu Sans;"><tt>中取出，重新声明为独立的</tt></span><tt>resources</tt>

<tt>scope</tt><tt> </tt><tt>:module</tt><tt> </tt><tt>=&gt;</tt><tt> </tt><tt>"admin"</tt><tt> </tt><tt>do</tt>

<tt> </tt><tt>resources</tt><tt> </tt><tt>:posts,</tt><tt> </tt><tt>:comments</tt>

<tt>end</tt>

<tt>or,</tt><tt> </tt><tt>for</tt><tt> </tt><tt>a</tt><tt> </tt><tt>single</tt><tt> </tt><tt>case</tt>

<tt>resources</tt><tt> </tt><tt>:posts,</tt><tt> </tt><tt>:module</tt><tt> </tt><tt>=&gt;</tt><tt> </tt><tt>"admin"</tt>

<tt>If</tt><tt> </tt><tt>you</tt><tt> </tt><tt>want</tt><tt> </tt><tt>to</tt><tt> </tt><tt>route</tt><tt> </tt><tt>/admin/posts</tt><tt> </tt><tt>to</tt><tt> </tt><tt>PostsController</tt><tt> </tt><tt>(without</tt><tt> </tt><tt>the</tt><tt> </tt><tt>Admin::</tt><tt> </tt><tt>module</tt><tt> </tt><tt>prefix),</tt><tt> </tt><tt>you</tt><tt> </tt><tt>could</tt><tt> </tt><tt>use</tt>

scope "/admin" do

resources :posts, :comments

end

<tt>or,</tt><tt> </tt><tt>for</tt><tt> </tt><tt>a</tt><tt> </tt><tt>single</tt><tt> </tt><tt>case</tt>

<tt>resources</tt><tt> </tt><tt>:posts,</tt><tt> </tt><tt>:path</tt><tt> </tt><tt>=&gt;</tt><tt> </tt><tt>"/admin/posts"</tt>

<tt>In</tt><tt> </tt><tt>each</tt><tt> </tt><tt>of</tt><tt> </tt><tt>these</tt><tt> </tt><tt>cases,</tt><tt> </tt><tt>the</tt><tt> </tt><tt>named</tt><tt> </tt><tt>routes</tt><tt> </tt><tt>remain</tt><tt> </tt><tt>the</tt><tt> </tt><tt>same</tt><tt> </tt><tt>as</tt><tt> </tt><tt>if</tt><tt> </tt><tt>you</tt><tt> </tt><tt>did</tt><tt> </tt><tt>not</tt><tt> </tt><tt>use</tt><tt> </tt><tt>scope.</tt><tt> </tt><tt>In</tt><tt> </tt><tt>the</tt><tt> </tt><tt>last</tt><tt> </tt><tt>case,</tt><tt> </tt><tt>the</tt><tt> </tt><tt>following</tt><tt> </tt><tt>paths</tt><tt> </tt><tt>map</tt><tt> </tt><tt>to</tt><tt> </tt><tt>PostsController:</tt>

<span style="font-family: DejaVu Sans;"><tt>在每个这样的情况中，</tt></span><tt>named</tt><tt> </tt><tt>routes</tt><span style="font-family: DejaVu Sans;"><tt>保持不变，如果你没有使用范围。在最后，随后的</tt></span><tt>paths</tt><span style="font-family: DejaVu Sans;"><tt>映射到</tt><tt></tt></span><tt>PostsController</tt><span style="font-family: DejaVu Sans;"><tt>：</tt></span>

&nbsp;
<table width="417" cellspacing="0" cellpadding="2"><colgroup><col width="89" /> <col width="132" /> <col width="54" /> <col width="126" /> </colgroup>
<tbody>
<tr>
<th width="89">HTTP Verb</th>
<th width="132">Path</th>
<th width="54">action</th>
<th width="126">named helper</th>
</tr>
<tr>
<td width="89">GET</td>
<td width="132">/admin/posts</td>
<td width="54">index</td>
<td width="126">posts_path</td>
</tr>
<tr>
<td width="89">GET</td>
<td width="132">/admin/posts/new</td>
<td width="54">new</td>
<td width="126">new_post_path</td>
</tr>
<tr>
<td width="89">POST</td>
<td width="132">/admin/posts</td>
<td width="54">create</td>
<td width="126">posts_path</td>
</tr>
<tr>
<td width="89">GET</td>
<td width="132">/admin/posts/:id</td>
<td width="54">show</td>
<td width="126">post_path(:id)</td>
</tr>
<tr>
<td width="89">GET</td>
<td width="132">/admin/posts/:id/edit</td>
<td width="54">edit</td>
<td width="126">edit_post_path(:id)</td>
</tr>
<tr>
<td width="89">PUT</td>
<td width="132">/admin/posts/:id</td>
<td width="54">update</td>
<td width="126">post_path(:id)</td>
</tr>
<tr>
<td width="89">DELETE</td>
<td width="132">/admin/posts/:id</td>
<td width="54">destroy</td>
<td width="126">post_path(:id)</td>
</tr>
</tbody>
</table>
<h4><a name="nested-resources"></a>2.7 Nested Resources<span style="font-family: WenQuanYi Micro Hei;"><tt>嵌套</tt></span><tt>Resource</tt></h4>
It’s common to have resources that are logically children of other resources. For example, suppose your application includes these models:

<span style="font-family: DejaVu Sans;"><tt>在通常情况中有</tt></span><tt>resources</tt><span style="font-family: DejaVu Sans;"><tt>是其他的</tt></span><tt>resources</tt><span style="font-family: DejaVu Sans;"><tt>逻辑上的</tt></span><tt>children</tt><span style="font-family: DejaVu Sans;"><tt>。例如，假设你的应用程序包含这些</tt></span><tt>models</tt><span style="font-family: DejaVu Sans;"><tt>：</tt></span>

<tt>class</tt><tt> </tt><tt>Magazine</tt><tt> </tt><tt>&lt;</tt><tt> </tt><tt>ActiveRecord::Base</tt>

<tt> </tt><tt>has_many</tt><tt> </tt><tt>:ads</tt>

<tt>end</tt>

&nbsp;

<tt>class</tt><tt> </tt><tt>Ad</tt><tt> </tt><tt>&lt;</tt><tt> </tt><tt>ActiveRecord::Base</tt>

<tt> </tt><tt>belongs_to</tt><tt> </tt><tt>:magazine</tt>

<tt>end</tt>

<tt>Nested</tt><tt> </tt><tt>routes</tt><tt> </tt><tt>allow</tt><tt> </tt><tt>you</tt><tt> </tt><tt>to</tt><tt> </tt><tt>capture</tt><tt> </tt><tt>this</tt><tt> </tt><tt>relationship</tt><tt> </tt><tt>in</tt><tt> </tt><tt>your</tt><tt> </tt><tt>routing.</tt><tt> </tt><tt>In</tt><tt> </tt><tt>this</tt><tt> </tt><tt>case,</tt><tt> </tt><tt>you</tt><tt> </tt><tt>could</tt><tt> </tt><tt>include</tt><tt> </tt><tt>this</tt><tt> </tt><tt>route</tt><tt> </tt><tt>declaration:</tt>

<span style="font-family: DejaVu Sans;"><tt>嵌套</tt></span><tt>routes</tt><span style="font-family: DejaVu Sans;"><tt>允许你捕捉这些关系在你的</tt></span><tt>routing</tt><span style="font-family: DejaVu Sans;"><tt>中。在这里的情况中，你可包含这样的声明：</tt></span>

<tt>resources</tt><tt> </tt><tt>:magazines</tt><tt> </tt><tt>do</tt>

<tt> </tt><tt>resources</tt><tt> </tt><tt>:ads</tt>

<tt>end</tt>

<tt>In</tt><tt> </tt><tt>addition</tt><tt> </tt><tt>to</tt><tt> </tt><tt>the</tt><tt> </tt><tt>routes</tt><tt> </tt><tt>for</tt><tt> </tt><tt>magazines,</tt><tt> </tt><tt>this</tt><tt> </tt><tt>declaration</tt><tt> </tt><tt>will</tt><tt> </tt><tt>also</tt><tt> </tt><tt>route</tt><tt> </tt><tt>ads</tt><tt> </tt><tt>to</tt><tt> </tt><tt>an</tt><tt> </tt><tt>AdsController.</tt><tt> </tt><tt>The</tt><tt> </tt><tt>ad</tt><tt> </tt><tt>URLs</tt><tt> </tt><tt>require</tt><tt> </tt><tt>a</tt><tt> </tt><tt>magazine:</tt>

<span style="font-family: DejaVu Sans;"><tt>除了</tt><tt></tt></span><tt>magazines</tt><span style="font-family: DejaVu Sans;"><tt>的</tt></span><tt>routes</tt><span style="font-family: DejaVu Sans;"><tt>，这里也同样声明</tt></span><tt>route</tt><tt> </tt><tt>ads</tt><span style="font-family: DejaVu Sans;"><tt>到</tt><tt></tt></span><tt>AdsController</tt><span style="font-family: DejaVu Sans;"><tt>。</tt></span><tt>ad</tt><span style="font-family: DejaVu Sans;"><tt>的</tt></span><tt>URLs</tt><span style="font-family: DejaVu Sans;"><tt>需要一个</tt><tt></tt></span><tt>magazine</tt><span style="font-family: DejaVu Sans;"><tt>（对象）：</tt></span>

&nbsp;
<table width="665" cellspacing="0" cellpadding="2"><colgroup><col width="82" /> <col width="144" /> <col width="53" /> <col width="371" /> </colgroup>
<tbody>
<tr>
<th width="82">HTTP Verb</th>
<th width="144">Path</th>
<th width="53">action</th>
<th width="371">used for</th>
</tr>
<tr>
<td width="82">GET</td>
<td width="144">/magazines/:id/ads</td>
<td width="53">index</td>
<td width="371">display a list of all ads for a specific magazine</td>
</tr>
<tr>
<td width="82">GET</td>
<td width="144">/magazines/:id/ads/new</td>
<td width="53">new</td>
<td width="371">return an HTML form for creating a new ad belonging to a specific magazine</td>
</tr>
<tr>
<td width="82">POST</td>
<td width="144">/magazines/:id/ads</td>
<td width="53">create</td>
<td width="371">create a new ad belonging to a specific magazine</td>
</tr>
<tr>
<td width="82">GET</td>
<td width="144">/magazines/:id/ads/:id</td>
<td width="53">show</td>
<td width="371">display a specific ad belonging to a specific magazine</td>
</tr>
<tr>
<td width="82">GET</td>
<td width="144">/magazines/:id/ads/:id/edit</td>
<td width="53">edit</td>
<td width="371">return an HTML form for editing an ad belonging to a specific magazine</td>
</tr>
<tr>
<td width="82">PUT</td>
<td width="144">/magazines/:id/ads/:id</td>
<td width="53">update</td>
<td width="371">update a specific ad belonging to a specific magazine</td>
</tr>
<tr>
<td width="82">DELETE</td>
<td width="144">/magazines/:id/ads/:id</td>
<td width="53">destroy</td>
<td width="371">delete a specific ad belonging to a specific magazine</td>
</tr>
</tbody>
</table>
This will also create routing helpers such as magazine_ads_url and edit_magazine_ad_path. These helpers take an instance of Magazine as the first parameter (magazine_ads_url(@magazine)).

<span style="font-family: DejaVu Sans;"><tt>这里也将会创建</tt></span><tt>routing</tt><tt> </tt><tt>helpers</tt><span style="font-family: DejaVu Sans;"><tt>例如</tt><tt></tt></span><tt>magazine_ads_url</tt><span style="font-family: DejaVu Sans;"><tt>和</tt><tt></tt></span><tt>edit_magazine_ad_path</tt><span style="font-family: DejaVu Sans;"><tt>。这些</tt></span><tt>helpers</tt><span style="font-family: DejaVu Sans;"><tt>获取一个</tt><tt></tt></span><tt>Magazine</tt><span style="font-family: DejaVu Sans;"><tt>的实例作为第一个参数（</tt></span><tt>magazine_ads_url(@magazine)</tt><span style="font-family: DejaVu Sans;"><tt>）。</tt></span>
<h5><a name="limits-to-nesting"></a><tt>2.7.1</tt><tt> </tt><tt>Limits</tt><tt> </tt><tt>to</tt><tt> </tt><tt>Nesting</tt><span style="font-family: WenQuanYi Micro Hei;"><tt>嵌套的局限</tt></span></h5>
You can nest resources within other nested resources if you like. For example:

<span style="font-family: DejaVu Sans;"><tt>你可以嵌套</tt></span><tt>resources</tt><span style="font-family: DejaVu Sans;"><tt>在其他嵌套</tt></span><tt>resources</tt><span style="font-family: DejaVu Sans;"><tt>中如果你喜欢。例如：</tt></span>

<tt>resources</tt><tt> </tt><tt>:publishers</tt><tt> </tt><tt>do</tt>

<tt> </tt><tt>resources</tt><tt> </tt><tt>:magazines</tt><tt> </tt><tt>do</tt>

<tt> </tt><tt>resources</tt><tt> </tt><tt>:photos</tt>

<tt> </tt><tt>end</tt>

<tt>end</tt>

<tt>Deeply-nested</tt><tt> </tt><tt>resources</tt><tt> </tt><tt>quickly</tt><tt> </tt><tt>become</tt><tt> </tt><tt>cumbersome.</tt><tt> </tt><tt>In</tt><tt> </tt><tt>this</tt><tt> </tt><tt>case,</tt><tt> </tt><tt>for</tt><tt> </tt><tt>example,</tt><tt> </tt><tt>the</tt><tt> </tt><tt>application</tt><tt> </tt><tt>would</tt><tt> </tt><tt>recognize</tt><tt> </tt><tt>paths</tt><tt> </tt><tt>such</tt><tt> </tt><tt>as</tt>

<span style="font-family: DejaVu Sans;"><tt>深层的嵌套</tt></span><tt>resources</tt><span style="font-family: DejaVu Sans;"><tt>相当的累赘。在这样的情况下，例如，应用程序将会这样组织路径</tt></span>
<pre><tt>/publishers/1/magazines/2/photos/3</tt></pre>
<tt>The</tt><tt> </tt><tt>corresponding</tt><tt> </tt><tt>route</tt><tt> </tt><tt>helper</tt><tt> </tt><tt>would</tt><tt> </tt><tt>be</tt><tt> </tt><tt>publisher_magazine_photo_url,</tt><tt> </tt><tt>requiring</tt><tt> </tt><tt>you</tt><tt> </tt><tt>to</tt><tt> </tt><tt>specify</tt><tt> </tt><tt>objects</tt><tt> </tt><tt>at</tt><tt> </tt><tt>all</tt><tt> </tt><tt>three</tt><tt> </tt><tt>levels.</tt><tt> </tt><tt>Indeed,</tt><tt> </tt><tt>this</tt><tt> </tt><tt>situation</tt><tt> </tt><tt>is</tt><tt> </tt><tt>confusing</tt><tt> </tt><tt>enough</tt><tt> </tt><tt>that</tt><tt> </tt><tt>a</tt><tt> </tt><tt>popular</tt><tt> </tt><span style="color: #000080;"><span style="text-decoration: underline;"><a href="http://weblog.jamisbuck.org/2007/2/5/nesting-resources">article</a></span></span><tt> </tt><tt>by</tt><tt> </tt><tt>Jamis</tt><tt> </tt><tt>Buck</tt><tt> </tt><tt>proposes</tt><tt> </tt><tt>a</tt><tt> </tt><tt>rule</tt><tt> </tt><tt>of</tt><tt> </tt><tt>thumb</tt><tt> </tt><tt>for</tt><tt> </tt><tt>good</tt><tt> </tt><tt>Rails</tt><tt> </tt><tt>design:</tt>

<span style="font-family: DejaVu Sans;"><tt>相应的</tt></span><tt>route</tt><tt> </tt><tt>helper</tt><span style="font-family: DejaVu Sans;"><tt>将会是</tt><tt></tt></span><tt>publisher_magazine_photo_url</tt><span style="font-family: DejaVu Sans;"><tt>这需要你指定三个级别的所有对象。事实上，这种情况下太混乱了一篇受欢迎的文章来自</tt></span><tt>Jamis</tt><tt> </tt><tt>Buck</tt><span style="font-family: DejaVu Sans;"><tt>，关于一个设计良好的</tt></span><tt>Rails</tt><span style="font-family: DejaVu Sans;"><tt>的经验法则：</tt></span>

<em><strong>Resources</strong></em><em><strong> </strong></em><em><strong>should</strong></em><em><strong> </strong></em><em><strong>never</strong></em><em><strong> </strong></em><em><strong>be</strong></em><em><strong> </strong></em><em><strong>nested</strong></em><em><strong> </strong></em><em><strong>more</strong></em><em><strong> </strong></em><em><strong>than</strong></em><em><strong> </strong></em><em><strong>1</strong></em><em><strong> </strong></em><em><strong>level</strong></em><em><strong> </strong></em><em><strong>deep.</strong></em>
<h4><a name="creating-paths-and-urls-from-objects"></a> <tt>2.8</tt><tt> </tt><tt>Creating</tt><tt> </tt><tt>Paths</tt><tt> </tt><tt>and</tt><tt> </tt><tt>URLs</tt><tt> </tt><tt>From</tt><tt> </tt><tt>Objects</tt></h4>
In addition to using the routing helpers, Rails can also create paths and URLs from an array of parameters. For example, suppose you have this set of routes:

<span style="font-family: DejaVu Sans;">除了使用</span>routing helpers<span style="font-family: DejaVu Sans;">，</span>Rails<span style="font-family: DejaVu Sans;">也可以从一个</span>parameters<span style="font-family: DejaVu Sans;">数组创建</span>paths<span style="font-family: DejaVu Sans;">和</span>URLs<span style="font-family: DejaVu Sans;">。例如，假设你有这样的组</span>routes<span style="font-family: DejaVu Sans;">：</span>

resources :magazines do

resources :ads

end

When using <tt> </tt><tt>magazine_ad_path</tt>, you can pass in instances of <tt> </tt><tt>Magazine</tt><tt> </tt><tt>and</tt><tt> </tt><tt>Ad</tt> instead of the numeric IDs.

<span style="font-family: DejaVu Sans;">在使用</span><tt>magazine_ad_path</tt><span style="font-family: DejaVu Sans;"><tt>的时候，你可以传递</tt><tt></tt></span><tt>Magazine</tt><tt> </tt><tt>and</tt><tt> </tt><tt>Ad</tt><span style="font-family: DejaVu Sans;"><tt>的实例替代数字</tt></span><tt>IDs</tt><span style="font-family: DejaVu Sans;"><tt>。</tt></span>

&lt;%= link_to "Ad details", magazine_ad_path(@magazine, @ad) %&gt;

You can also use <tt>url_for</tt> with a set of objects, and Rails will automatically determine which route you want:

<span style="font-family: DejaVu Sans;">你同样也可以使用</span><tt>url_for</tt><span style="font-family: DejaVu Sans;"><tt>和一组对象，那么</tt></span><tt>Rails</tt><span style="font-family: DejaVu Sans;"><tt>将会自动的决定那个</tt></span><tt>route</tt><span style="font-family: DejaVu Sans;"><tt>是你希望的：</tt></span>

&lt;%= link_to "Ad details", url_for([@magazine, @ad]) %&gt;

In this case, Rails will see that <tt>@magazine</tt> is a <tt> </tt><tt>Magazine</tt> and <tt>@ad</tt> is an <tt>Ad</tt> and will therefore use the <tt>magazine_ad_path</tt> helper. In helpers like <tt>link_to</tt>, you can specify just the object in place of the full <tt>url_for</tt> call:

<span style="font-family: DejaVu Sans;">在这里，</span>Rails<span style="font-family: DejaVu Sans;">将会明白</span><tt>@magazine</tt><span style="font-family: DejaVu Sans;"><tt>是</tt><tt></tt></span><tt>Magazine</tt><span style="font-family: DejaVu Sans;"><tt>并且</tt></span><tt>@ad</tt><span style="font-family: DejaVu Sans;"><tt>是</tt></span><tt>Ad</tt><span style="font-family: DejaVu Sans;"><tt>于此将会因此使用</tt><tt></tt></span><tt>magazine_ad_path</tt><tt> </tt><tt>helper</tt><span style="font-family: DejaVu Sans;"><tt>。在就像</tt></span><tt>link_to</tt><span style="font-family: DejaVu Sans;"><tt>的</tt></span><tt>helpers</tt><span style="font-family: DejaVu Sans;"><tt>中，你可以指定仅仅对象在</tt></span><tt>url_for</tt><span style="font-family: DejaVu Sans;"><tt>调用中：</tt></span>

&lt;%= link_to "Ad details", [@magazine, @ad] %&gt;

If you wanted to link to just a magazine, you could leave out the <tt>Array</tt>:

<span style="font-family: DejaVu Sans;">如果你想仅仅</span>link<span style="font-family: DejaVu Sans;">到一个</span>magazine<span style="font-family: DejaVu Sans;">，你可以省去数组：</span>

&lt;%= link_to "Magazine details", @magazine %&gt;

This allows you to treat instances of your models as URLs, and is a key advantage to using the resourceful style.

<a name="adding-more-restful-actions"></a><span style="font-family: DejaVu Sans;">这让你处理</span>models<span style="font-family: DejaVu Sans;">的实例为</span>URLs<span style="font-family: DejaVu Sans;">，并且这也是使用</span>resourceful style<span style="font-family: DejaVu Sans;">的关键优势。</span>
<h4><a name="adding-more-restful-actions1"></a>2.9 Adding More RESTful Actions<span style="font-family: WenQuanYi Micro Hei;">添加更多的</span>RESTful Action</h4>
You are not limited to the seven routes that RESTful routing creates by default. If you like, you may add additional routes that apply to the collection or individual members of the collection.

<span style="font-family: DejaVu Sans;">你并不限制于</span>RESTful routing<span style="font-family: DejaVu Sans;">默认创建的七个</span>routes<span style="font-family: DejaVu Sans;">。如果你喜欢，你可以添加额外的</span>routes<span style="font-family: DejaVu Sans;">用于多个或者个别的</span>collection<span style="font-family: DejaVu Sans;">。</span>
<h5><a name="adding-member-routes"></a>2.9.1 Adding Member Routes</h5>
To add a member route, just add a <tt>member</tt> block into the resource block:

<span style="font-family: DejaVu Sans;">添加一个</span>member route<span style="font-family: DejaVu Sans;">，仅仅添加一个</span>member<span style="font-family: DejaVu Sans;">的</span>block<span style="font-family: DejaVu Sans;">到</span>resource block<span style="font-family: DejaVu Sans;">中：</span>

resources :photos do

member do

get 'preview'

end

end

This will recognize <tt>/photos/1/preview</tt> with GET, and route to the <tt>preview</tt> action of <tt>PhotosController</tt>. It will also create the <tt>preview_photo_url</tt> and <tt>preview_photo_path</tt> helpers.

Within the block of member routes, each route name specifies the HTTP verb that it will recognize. You can use <tt>get</tt>, <tt>put</tt>, <tt>post</tt>, or <tt>delete</tt> here. If you don’t have multiple <tt>member</tt> routes, you can also pass <tt>:on</tt> to a route, eliminating the block:

<span style="font-family: DejaVu Sans;">在</span>member<span style="font-family: DejaVu Sans;">的</span>routes<span style="font-family: DejaVu Sans;">中，每个</span>route<span style="font-family: DejaVu Sans;">名字指定</span>HTTP verb<span style="font-family: DejaVu Sans;">这是将会组织的。在这里你可以使用</span><tt>get</tt>, <tt>put</tt>, <tt>post</tt>, or <tt>delete</tt><span style="font-family: DejaVu Sans;"><tt>。如果你没有多个</tt></span><tt>member</tt><tt> </tt><tt>routes</tt><span style="font-family: DejaVu Sans;"><tt>，你同样也可以传递</tt></span><tt>:on</tt><span style="font-family: DejaVu Sans;"><tt>到一个</tt></span><tt>route</tt><span style="font-family: DejaVu Sans;"><tt>，消除</tt></span><tt>block</tt><span style="font-family: DejaVu Sans;"><tt>：</tt></span>

resources :photos do

get 'preview', :on =&gt; :member

end
<h5><a name="adding-collection-routes"></a>2.9.2 Adding Collection Routes</h5>
To add a route to the collection:

<span style="font-family: DejaVu Sans;">添加一个</span>route<span style="font-family: DejaVu Sans;">到</span>collection<span style="font-family: DejaVu Sans;">：</span>

resources :photos do

collection do

get 'search'

end

end

This will enable Rails to recognize paths such as <tt>/photos/search</tt> with GET, and route to the <tt>search</tt> action of <tt>PhotosController</tt>. It will also create the <tt>search_photos_url</tt> and <tt>search_photos_path</tt> route helpers.

<span style="font-family: DejaVu Sans;">这将使</span>Rails<span style="font-family: DejaVu Sans;">能够像这样</span><tt>/photos/search</tt> with GET<span style="font-family: DejaVu Sans;">组织路径，并且</span>route<span style="font-family: DejaVu Sans;">到</span><tt>PhotosController</tt><span style="font-family: DejaVu Sans;"><tt>的</tt></span><tt>search</tt><tt> </tt><tt>action</tt><span style="font-family: DejaVu Sans;"><tt>。它将同样创建</tt><tt></tt></span><tt>search_photos_url</tt><span style="font-family: DejaVu Sans;"><tt>和</tt><tt></tt></span><tt>search_photos_path</tt><tt> </tt><tt>route</tt><tt> </tt><tt>helpers</tt><span style="font-family: DejaVu Sans;"><tt>。</tt></span>

Just as with member routes, you can pass <tt>:on</tt> to a route:

<span style="font-family: DejaVu Sans;">仅仅对于</span>member routes<span style="font-family: DejaVu Sans;">，你可以传递</span>:on<span style="font-family: DejaVu Sans;">给一个</span>route<span style="font-family: DejaVu Sans;">：</span>

resources :photos do

get 'search', :on =&gt; :collection

end
<h5><a name="a-note-of-caution"></a>2.9.3 A Note of Caution<span style="font-family: WenQuanYi Micro Hei;">一个慎重的提醒</span></h5>
If you find yourself adding many extra actions to a resourceful route, it’s time to stop and ask yourself whether you’re disguising the presence of another resource.

<span style="font-family: DejaVu Sans;">如果你发现你自己添加很多额外的</span>action<span style="font-family: DejaVu Sans;">到一个</span>resourceful<span style="font-family: DejaVu Sans;">的</span>route<span style="font-family: DejaVu Sans;">，是时候停下来并问你自己</span>

<a name="result_box"></a><span style="font-family: DejaVu Sans;">是否你在伪造另一个</span>resource<span style="font-family: DejaVu Sans;">。</span>
<h3><a name="non-resourceful-routes"></a>3 Non-Resourceful Routes<span style="font-family: WenQuanYi Micro Hei;">非</span>- Resourceful Routes</h3>
In addition to resource routing, Rails has powerful support for routing arbitrary URLs to actions. Here, you don’t get groups of routes automatically generated by resourceful routing. Instead, you set up each route within your application separately.

<span style="font-family: DejaVu Sans;">除了</span>resource routing<span style="font-family: DejaVu Sans;">，</span>Rails<span style="font-family: DejaVu Sans;">对任意的</span>URLs<span style="font-family: DejaVu Sans;">到</span>actions<span style="font-family: DejaVu Sans;">有强力的支持。这里，你没有得到被</span>resourceful routing<span style="font-family: DejaVu Sans;">自动创建的</span>groups of routes<span style="font-family: DejaVu Sans;">。作为替代，在你的应用程序中分别设置每个</span>route<span style="font-family: DejaVu Sans;">。</span>

While you should usually use resourceful routing, there are still many places where the simpler routing is more appropriate. There’s no need to try to shoehorn every last piece of your application into a resourceful framework if that’s not a good fit.

<span style="font-family: DejaVu Sans;">即使你应该通常使用</span>resourceful routing<span style="font-family: DejaVu Sans;">，这里仍然有很多地方简单的</span>routing<span style="font-family: DejaVu Sans;">更加适合。这里不需要尝试将你的应用程序最后写成一个</span>resourceful framework<span style="font-family: DejaVu Sans;">如果这样并不合适。</span>

In particular, simple routing makes it very easy to map legacy URLs to new Rails actions.

<a name="result_box1"></a><span style="font-family: DejaVu Sans;">特别是，简单的路</span>routing<span style="font-family: DejaVu Sans;">，使得它很容易映射（传入的）现有的</span>URL<span style="font-family: DejaVu Sans;">映射到新的</span>Rails action<span style="font-family: DejaVu Sans;">。</span>
<h4><a name="bound-parameters"></a>3.1 Bound Parameters<span style="font-family: WenQuanYi Micro Hei;">绑定参数</span></h4>
When you set up a regular route, you supply a series of symbols that Rails maps to parts of an incoming HTTP request. Two of these symbols are special: <tt>:controller</tt> maps to the name of a controller in your application, and <tt>:action</tt> maps to the name of an action within that controller. For example, consider one of the default Rails routes:

<span style="font-family: DejaVu Sans;">当你设定一个正则</span>route<span style="font-family: DejaVu Sans;">，你供应一系列的字符，其将通过</span>Rails<span style="font-family: DejaVu Sans;">映射到传入</span>HTTP<span style="font-family: DejaVu Sans;">请求的一部分。这些字符的两部分分别是：</span><tt>:controller</tt><span style="font-family: DejaVu Sans;"><tt>映射到你应用程序中的一个</tt></span><tt>controller</tt><span style="font-family: DejaVu Sans;"><tt>，并且</tt></span><tt>:action</tt><span style="font-family: DejaVu Sans;"><tt>映射到在指定的</tt></span><tt>controller</tt><span style="font-family: DejaVu Sans;"><tt>中的一个</tt></span><tt>action</tt><span style="font-family: DejaVu Sans;"><tt>。例如思考一个默认的</tt></span><tt>Rails</tt><tt> </tt><tt>routes</tt><span style="font-family: DejaVu Sans;"><tt>：</tt></span>

match ':controller(/:action(/:id))'

If an incoming request of <tt>/photos/show/1</tt> is processed by this route (because it hasn’t matched any previous route in the file), then the result will be to invoke the <tt>show</tt> action of the <tt> </tt><tt>PhotosController</tt>, and to make the final parameter <tt>"1"</tt> available as <tt>params[:id]</tt>. This route will also route the incoming request of <tt>/photos</tt> to <tt>PhotosController#index</tt>, since <tt>:action</tt> and <tt>:id</tt> are optional parameters, denoted by parentheses.

<span style="font-family: DejaVu Sans;">如果传入请求</span><tt>/photos/show/1</tt><tt> </tt><tt>is</tt><tt> </tt><tt>processed</tt><tt> </tt><tt>by</tt><tt> </tt><tt>this</tt><tt> </tt><tt>route</tt><tt> </tt><span style="font-family: DejaVu Sans;"><tt>（因为它并没有被先前的</tt></span><tt>route</tt><span style="font-family: DejaVu Sans;"><tt>文件中任何的</tt></span><tt>route</tt><span style="font-family: DejaVu Sans;"><tt>匹配成功），接着这个结果将会调用</tt><tt></tt></span><tt>PhotosController</tt><span style="font-family: DejaVu Sans;"><tt>的</tt></span><tt>show</tt><tt> </tt><tt>action</tt><span style="font-family: DejaVu Sans;"><tt>，并且使得最后的参数</tt><tt><span style="font-family: Liberation Serif,Times New Roman,serif;">”</span></tt></span><tt>1</tt><tt>”</tt><span style="font-family: DejaVu Sans;"><tt>可用于</tt></span><tt>params[:id]</tt><span style="font-family: DejaVu Sans;"><tt>。这个</tt></span><tt>route</tt><span style="font-family: DejaVu Sans;"><tt>也还会</tt></span><tt>route</tt><span style="font-family: DejaVu Sans;"><tt>传入请求</tt></span><tt>/photos</tt><span style="font-family: DejaVu Sans;"><tt>到</tt></span><tt>PhotosController#index</tt><span style="font-family: DejaVu Sans;"><tt>，因为</tt></span><tt>:action</tt><span style="font-family: DejaVu Sans;"><tt>和</tt></span><tt>:id</tt><span style="font-family: DejaVu Sans;"><tt>是被括号包起来的可选参数。</tt></span>
<h4><a name="dynamic-segments"></a>3.2 Dynamic Segments<span style="font-family: WenQuanYi Micro Hei;">动态分割</span></h4>
You can set up as many dynamic segments within a regular route as you like. Anything other than <tt>:controller</tt> or <tt>:action</tt> will be available to the action as part of <tt>params</tt>. If you set up this route:

<span style="font-family: DejaVu Sans;">你可以设置你希望的数目的</span>dynamic segments<span style="font-family: DejaVu Sans;">在一个正则</span>route<span style="font-family: DejaVu Sans;">中。超过</span><tt>:controller</tt> or <tt>:action</tt><span style="font-family: DejaVu Sans;"><tt>的其他部分（是可用的）在</tt></span><tt>action</tt><span style="font-family: DejaVu Sans;"><tt>作为</tt></span><tt>params</tt><span style="font-family: DejaVu Sans;"><tt>第一部分。如果你设定这样的</tt></span><tt>route</tt><span style="font-family: DejaVu Sans;"><tt>：</tt></span>

<tt>match</tt><tt> </tt><tt>':controller/:action/:id/:user_id'</tt>

An incoming path of <tt>/photos/show/1/2</tt> will be dispatched to the <tt>show</tt> action of the <tt>PhotosController</tt>. <tt>params[:id]</tt> will be <tt>"1"</tt>, and <tt>params[:user_id]</tt> will be <tt>"2"</tt>.

<span style="font-family: DejaVu Sans;">一个传入路径</span><tt>/photos/show/1/2</tt><span style="font-family: DejaVu Sans;"><tt>将会被调度给</tt></span><tt>PhotosController</tt><span style="font-family: DejaVu Sans;"><tt>的</tt></span><tt>show</tt><tt> </tt><tt>action</tt><span style="font-family: DejaVu Sans;"><tt>。</tt></span><tt>params[:id]</tt><tt> </tt><tt>will</tt><tt> </tt><tt>be</tt><tt> </tt><tt>"1",</tt><tt> </tt><tt>and</tt><tt> </tt><tt>params[:user_id]</tt><tt> </tt><tt>will</tt><tt> </tt><tt>be</tt><tt> </tt><tt>"2".</tt>

You can’t use <tt>namespace</tt> or <tt>:module</tt> with a <tt>:controller</tt> path segment. If you need to do this then use a constraint on :controller that matches the namespace you require. e.g:

<span style="font-family: DejaVu Sans;">你不能对一个</span><tt>:controller</tt><span style="font-family: DejaVu Sans;"><tt>路径</tt></span><tt>segment</tt><span style="font-family: DejaVu Sans;"><tt>使用</tt></span><tt>namespace</tt><span style="font-family: DejaVu Sans;"><tt>或者</tt></span><tt>:module</tt><span style="font-family: DejaVu Sans;"><tt>。如果你需要这么做那么使用对</tt><tt></tt></span><tt>:controller</tt><span style="font-family: DejaVu Sans;"><tt>一个限制使其匹配你请求的</tt></span><tt>namespace</tt><span style="font-family: DejaVu Sans;"><tt>。例如：</tt></span>

<tt>match</tt><tt> </tt><tt>':controller(/:action(/:id))',</tt><tt> </tt><tt>:controller</tt><tt> </tt><tt>=&gt;</tt><tt> </tt><tt>/admin\/[^\/]+/</tt>

&nbsp;

By default dynamic segments don’t accept dots – this is because the dot is used as a separator for formatted routes. If you need to use a dot within a dynamic segment add a constraint which overrides this – for example <tt>:id</tt> =&gt; /[^\/]+/ allows anything except a slash.

<span style="font-family: DejaVu Sans;">默认的动态分割不接受</span>dots<span style="font-family: DejaVu Sans;">（</span>.<span style="font-family: DejaVu Sans;">）<span style="font-family: Liberation Serif,Times New Roman,serif;">——</span>这是因为</span>dot<span style="font-family: DejaVu Sans;">被作为格式化</span>routes<span style="font-family: DejaVu Sans;">的一个分割。如果你需要在一个</span>dynamic segment<span style="font-family: DejaVu Sans;">中使用</span>dot<span style="font-family: DejaVu Sans;">，添加一个限制来重写它<span style="font-family: Liberation Serif,Times New Roman,serif;">——</span>例如</span><tt>:id</tt> =&gt; /[^\/]+/<span style="font-family: DejaVu Sans;">允许除了斜线之外的任何字符。</span>
<h4><a name="static-segments"></a>3.3 Static Segments</h4>
You can specify static segments when creating a route:

match ':controller/:action/:id/with_user/:user_id'

This route would respond to paths such as <tt>/photos/show/1/with_user/2</tt>. In this case, <tt>params</tt> would be <tt>{</tt><tt> </tt><tt>:controller</tt><tt> </tt><tt>=&gt;</tt><tt> “</tt><tt>photos</tt><tt>”</tt><tt>,</tt><tt> </tt><tt>:action</tt><tt> </tt><tt>=&gt;</tt><tt> “</tt><tt>show</tt><tt>”</tt><tt>,</tt><tt> </tt><tt>:id</tt><tt> </tt><tt>=&gt;</tt><tt> “</tt><tt>1</tt><tt>”</tt><tt>,</tt><tt> </tt><tt>:user_id</tt><tt> </tt><tt>=&gt;</tt><tt> “</tt><tt>2</tt><tt>” </tt><tt>}</tt>.
<h4><a name="the-query-string"></a>3.4 The Query String<span style="font-family: WenQuanYi Micro Hei;">查询字符串</span></h4>
The <tt>params</tt> will also include any parameters from the query string. For example, with this route:

params<span style="font-family: DejaVu Sans;">将也会包含来自查询字符串的任何参数。例如，使用这个</span>route<span style="font-family: DejaVu Sans;">：</span>

match ':controller/:action/:id'

An incoming path of <tt>/photos/show/1?user_id=2</tt> will be dispatched to the <tt>show</tt> action of the <tt>Photos</tt> controller. <tt>params</tt> will be <tt>{</tt><tt> </tt><tt>:controller</tt><tt> </tt><tt>=&gt;</tt><tt> “</tt><tt>photos</tt><tt>”</tt><tt>,</tt><tt> </tt><tt>:action</tt><tt> </tt><tt>=&gt;</tt><tt> “</tt><tt>show</tt><tt>”</tt><tt>,</tt><tt> </tt><tt>:id</tt><tt> </tt><tt>=&gt;</tt><tt> “</tt><tt>1</tt><tt>”</tt><tt>,</tt><tt> </tt><tt>:user_id</tt><tt> </tt><tt>=&gt;</tt><tt> “</tt><tt>2</tt><tt>” </tt><tt>}</tt>.

<span style="font-family: DejaVu Sans;">一个传入路径</span><tt>/photos/show/1?user_id=2</tt><span style="font-family: DejaVu Sans;"><tt>将会被调度给</tt><tt></tt></span><tt>Photos</tt><tt> </tt><tt>controller</tt><span style="font-family: DejaVu Sans;"><tt>的</tt></span><tt>show</tt><tt> </tt><tt>action</tt><span style="font-family: DejaVu Sans;"><tt>。</tt></span><tt>params</tt><span style="font-family: DejaVu Sans;"><tt>将会是</tt></span><tt>{</tt><tt> </tt><tt>:controller</tt><tt> </tt><tt>=&gt;</tt><tt> “</tt><tt>photos</tt><tt>”</tt><tt>,</tt><tt> </tt><tt>:action</tt><tt> </tt><tt>=&gt;</tt><tt> “</tt><tt>show</tt><tt>”</tt><tt>,</tt><tt> </tt><tt>:id</tt><tt> </tt><tt>=&gt;</tt><tt> “</tt><tt>1</tt><tt>”</tt><tt>,</tt><tt> </tt><tt>:user_id</tt><tt> </tt><tt>=&gt;</tt><tt> “</tt><tt>2</tt><tt>” </tt><tt>}</tt><span style="font-family: DejaVu Sans;"><tt>。</tt></span>
<h4><a name="defining-defaults"></a>3.5 Defining Defaults<span style="font-family: WenQuanYi Micro Hei;">默认定义</span></h4>
You do not need to explicitly use the <tt>:controller</tt> and <tt>:action</tt> symbols within a route. You can supply them as defaults:

<span style="font-family: DejaVu Sans;">你不需要准确的使用</span><tt>:controller</tt><span style="font-family: DejaVu Sans;"><tt>和</tt></span><tt>:action</tt><span style="font-family: DejaVu Sans;"><tt>字符在一个</tt></span><tt>route</tt><span style="font-family: DejaVu Sans;"><tt>中。你可以默认的提供他们：</tt></span>

match 'photos/:id' =&gt; 'photos#show'

With this route, Rails will match an incoming path of <tt>/photos/12</tt> to the <tt>show</tt> action of <tt>PhotosController</tt>.

<span style="font-family: DejaVu Sans;">通过这个</span>route<span style="font-family: DejaVu Sans;">，</span>Rails<span style="font-family: DejaVu Sans;">将会匹配一个传入路径</span><tt>/photos/12</tt><span style="font-family: DejaVu Sans;"><tt>到</tt><tt></tt></span><tt>PhotosController</tt><span style="font-family: DejaVu Sans;"><tt>的</tt></span><tt>show</tt><tt> </tt><tt>action</tt><span style="font-family: DejaVu Sans;"><tt>。</tt></span>

You can also define other defaults in a route by supplying a hash for the <tt>:defaults</tt> option. This even applies to parameters that you do not specify as dynamic segments. For example:

<span style="font-family: DejaVu Sans;"><tt>你同样也可以在</tt></span><tt>route</tt><span style="font-family: DejaVu Sans;"><tt>中定义其他的默认（设置）通过提供一个</tt></span><tt>hash</tt><span style="font-family: DejaVu Sans;"><tt>字典给</tt><tt></tt></span><tt>:defaults</tt><span style="font-family: DejaVu Sans;"><tt>选项。这甚至会应用于不需要指定参数作为动态分割。例如：</tt></span>

match 'photos/:id' =&gt; 'photos#show', :defaults =&gt; { :format =&gt; 'jpg' }

Rails would match <tt>photos/12</tt> to the <tt>show</tt> action of <tt>PhotosController</tt>, and set <tt>params[:format]</tt> to <tt>"jpg"</tt>.

Rails<span style="font-family: DejaVu Sans;">将会匹配</span><tt>photos/12</tt><span style="font-family: DejaVu Sans;"><tt>到</tt><tt></tt></span><tt>PhotosController</tt><span style="font-family: DejaVu Sans;"><tt>的</tt></span><tt>show</tt><tt> </tt><tt>action</tt><span style="font-family: DejaVu Sans;"><tt>，并且设置</tt></span><tt>params[:format]</tt><tt> </tt><tt>to</tt><tt> </tt><tt>"jpg"</tt><span style="font-family: DejaVu Sans;"><tt>。</tt></span>
<h4><a name="naming-routes"></a>3.6 Naming Routes</h4>
You can specify a name for any route using the <tt>:as</tt> option.

<span style="font-family: DejaVu Sans;">你可以指定一个</span>name<span style="font-family: DejaVu Sans;">给任何</span>route<span style="font-family: DejaVu Sans;">使用</span>:as<span style="font-family: DejaVu Sans;">选项。</span>

match 'exit' =&gt; 'sessions#destroy', :as =&gt; :logout

This will create <tt>logout_path</tt> and <tt>logout_url</tt> as named helpers in your application. Calling <tt>logout_path</tt> will return <tt>/exit</tt>

<span style="font-family: DejaVu Sans;"><tt>这里将会在应用程序中创建</tt><tt></tt></span><tt>logout_path</tt><span style="font-family: DejaVu Sans;"><tt>和</tt></span><tt>logout_url</tt><span style="font-family: DejaVu Sans;"><tt>作为（刚才）命名的</tt></span><tt>route</tt><span style="font-family: DejaVu Sans;"><tt>的</tt></span><tt>helpers</tt><span style="font-family: DejaVu Sans;"><tt>。调用</tt></span><tt>logout_path</tt><span style="font-family: DejaVu Sans;"><tt>将会返回</tt></span><tt>/exit</tt>
<h4><a name="http-verb-constraints"></a>3.7 HTTP Verb Constraints <span style="font-family: WenQuanYi Micro Hei;">限定</span>HTTP <span style="font-family: WenQuanYi Micro Hei;">动作</span></h4>
You can use the <tt>:via</tt> option to constrain the request to one or more HTTP methods:

<span style="font-family: DejaVu Sans;">你可以使用</span>:via<span style="font-family: DejaVu Sans;">选项来限定请求一个或多个（</span>HTTP<span style="font-family: DejaVu Sans;">）方法：</span>

match 'photos/show' =&gt; 'photos#show', :via =&gt; :get

There is a shorthand version of this as well:

<span style="font-family: DejaVu Sans;">这里的短操作版本同样也是可以的：</span>

get 'photos/show'

You can also permit more than one verb to a single route:

<span style="font-family: DejaVu Sans;">你也可以运行超过一个动作到一个单独的</span>route<span style="font-family: DejaVu Sans;">：</span>

match 'photos/show' =&gt; 'photos#show', :via =&gt; [:get, :post]
<h4><a name="segment-constraints"></a>3.8 Segment Constraints<span style="font-family: WenQuanYi Micro Hei;">分割限制</span></h4>
You can use the <tt>:constraints</tt> option to enforce a format for a dynamic segment:

<span style="font-family: DejaVu Sans;">你可以使用</span>:constraints<span style="font-family: DejaVu Sans;">选项来强制一个动态分割的格式：</span>

match 'photos/:id' =&gt; 'photos#show', :constraints =&gt; { :id =&gt; /[A-Z]\d{5}/ }

This route would match paths such as <tt>/photos/A12345</tt>. You can more succinctly express the same route this way:

<span style="font-family: DejaVu Sans;">这个</span>route<span style="font-family: DejaVu Sans;">将会匹配像这样的路径</span><tt>/photos/A12345</tt><span style="font-family: DejaVu Sans;"><tt>。你可以使用这样的方式来更加简洁的表达相同的</tt></span><tt>route</tt><span style="font-family: DejaVu Sans;"><tt>：</tt></span>

match 'photos/:id' =&gt; 'photos#show', :id =&gt; /[A-Z]\d{5}/

<tt>:constraints</tt> takes regular expressions with the restriction that regexp anchors can’t be used. For example, the following route will not work:

<tt>:constraints</tt><span style="font-family: DejaVu Sans;"><tt>获取的正则表达式，其限定了正则表达式的锚不能被使用。例如下面的</tt></span><tt>route</tt><span style="font-family: DejaVu Sans;"><tt>将不会工作（使用了</tt></span><tt>^</tt><span style="font-family: DejaVu Sans;"><tt>锚指定从这里开始）：</tt></span>

match '/:id' =&gt; 'posts#show', :constraints =&gt; {:id =&gt; /^\d/}

However, note that you don’t need to use anchors because all routes are anchored at the start.

<span style="font-family: DejaVu Sans;">然而，注意你不需要使用锚因为所有的</span>routes<span style="font-family: DejaVu Sans;">锚定在开始位置。</span>

For example, the following routes would allow for <tt>posts</tt> with <tt>to_param</tt> values like <tt>1-hello-world</tt> that always begin with a number and <tt>users</tt> with <tt>to_param</tt> values like <tt>david</tt> that never begin with a number to share the root namespace:

<span style="font-family: DejaVu Sans;">例如，下面的</span>route<span style="font-family: DejaVu Sans;">将会允许</span>posts<span style="font-family: DejaVu Sans;">及</span><tt>to_param</tt><span style="font-family: DejaVu Sans;"><tt>像</tt><tt></tt></span><tt>1-hello-world</tt><span style="font-family: DejaVu Sans;"><tt>的值，其总是以一个数字和</tt></span><tt>user</tt><span style="font-family: DejaVu Sans;"><tt>（</tt></span><tt>user</tt><span style="font-family: DejaVu Sans;"><tt>的</tt></span><tt>to_param</tt><span style="font-family: DejaVu Sans;"><tt>的值就像</tt></span><tt>david</tt><span style="font-family: DejaVu Sans;"><tt>）它从不以数字开始来</tt></span><tt>share</tt><span style="font-family: DejaVu Sans;"><tt>根名称空间。</tt></span>

match '/:id' =&gt; 'posts#show', :constraints =&gt; { :id =&gt; /\d.+/ }

match '/:username' =&gt; 'users#show'
<h4><a name="request-based-constraints"></a>3.9 Request-Based Constraints Request-Based<span style="font-family: WenQuanYi Micro Hei;">的限制</span></h4>
You can also constrain a route based on any method on the <span style="color: #000080;"><span style="text-decoration: underline;"><a href="http://guides.rubyonrails.org/action_controller_overview.html#the-request-object">Request</a></span></span> object that returns a <tt>String</tt>.

You specify a request-based constraint the same way that you specify a segment constraint:

<span style="font-family: DejaVu Sans;">你也可以限制一个</span>route <span style="font-family: DejaVu Sans;">基于任何方法在</span>Request<span style="font-family: DejaVu Sans;">对象时它都会返回一个</span>String<span style="font-family: DejaVu Sans;">。</span>

<span style="font-family: DejaVu Sans;">你指定一个</span>request-basedcontraint<span style="font-family: DejaVu Sans;">和你指定一个</span>segment constaint<span style="font-family: DejaVu Sans;">是一样的。</span>

match "photos", :constraints =&gt; {:subdomain =&gt; "admin"}

You can also specify constraints in a block form:

<span style="font-family: DejaVu Sans;">你也可以指定限制在一个</span>block form<span style="font-family: DejaVu Sans;">中：</span>

namespace :admin do

constraints :subdomain =&gt; "admin" do

resources :photos

end

end
<h4><a name="advanced-constraints"></a>3.10 Advanced Constraints<span style="font-family: WenQuanYi Micro Hei;">高级</span>constraints</h4>
If you have a more advanced constraint, you can provide an object that responds to <tt>matches?</tt> that Rails should use. Let’s say you wanted to route all users on a blacklist to the <tt>BlacklistController</tt>. You could do:

<span style="font-family: DejaVu Sans;">如果你有一个更高级的</span>contraint<span style="font-family: DejaVu Sans;">，你可以提供一个对象，</span>Rails<span style="font-family: DejaVu Sans;">将会使用</span>matches?<span style="font-family: DejaVu Sans;">回应这个对象。</span>

<span style="font-family: DejaVu Sans;">让我来告诉你要想</span>route<span style="font-family: DejaVu Sans;">所有的用户在一个黑名单中匹配（通过</span><tt>BlacklistController</tt><span style="font-family: DejaVu Sans;"><tt>的</tt></span><code>matches?</code><span style="font-family: DejaVu Sans;"><code>方法）。你应该：</code></span>

class BlacklistConstraint

def initialize

@ips = Blacklist.retrieve_ips

end

&nbsp;

def matches?(request)

@ips.include?(request.remote_ip)

end

end

&nbsp;

TwitterClone::Application.routes.draw do

match "*path" =&gt; "blacklist#index",

:constraints =&gt; BlacklistConstraint.new

end
<h4><a name="route-globbing"></a>3.11 Route Globbing</h4>
Route globbing is a way to specify that a particular parameter should be matched to all the remaining parts of a route. For example

Route globbing<span style="font-family: DejaVu Sans;">是一种方式来指定特定的</span>paramerter<span style="font-family: DejaVu Sans;">应该被一个</span>route<span style="font-family: DejaVu Sans;">的其余的所有部分匹配。例如</span>

match 'photos/*other' =&gt; 'photos#unknown'

This route would match <tt>photos/12</tt> or <tt>/photos/long/path/to/12</tt>, setting <tt>params[:other]</tt> to <tt>"12"</tt> or <tt>"long/path/to/12"</tt>.

<span style="font-family: DejaVu Sans;">这个</span>route<span style="font-family: DejaVu Sans;">将会匹配</span><tt>photos/12</tt><span style="font-family: DejaVu Sans;"><tt>或者</tt></span><tt>/photos/long/path/to/12</tt><span style="font-family: DejaVu Sans;"><tt>，设置</tt></span><tt>params[:other]</tt><tt> </tt><tt>to</tt><tt> </tt><tt>"12"</tt><span style="font-family: DejaVu Sans;"><tt>或</tt></span><tt>"long/path/to/12"</tt><span style="font-family: DejaVu Sans;"><tt>。</tt></span>

Wildcard segments can occur anywhere in a route. For example,

<span style="font-family: DejaVu Sans;">通配符分割可以发生在一个</span>route<span style="font-family: DejaVu Sans;">的任何地方。例如，</span>

match 'books/*section/:title' =&gt; 'books#show'

would match <tt>books/some/section/last-words-a-memoir</tt> with <tt>params[:section]</tt> equals <tt>"some/section"</tt>, and <tt>params[:title]</tt> equals <tt>"last-words-a-memoir"</tt>.

<span style="font-family: DejaVu Sans;">将会匹配</span><tt>books/some/section/last-words-a-memoir</tt><span style="font-family: DejaVu Sans;"><tt>为</tt></span><tt>params[:section]</tt><span style="font-family: DejaVu Sans;"><tt>等于</tt></span><tt>"some/section"</tt><span style="font-family: DejaVu Sans;"><tt>，以及</tt></span><tt>params[:title]</tt><span style="font-family: DejaVu Sans;"><tt>相当于</tt></span><tt>"last-words-a-memoir"</tt><span style="font-family: DejaVu Sans;"><tt>。</tt></span>

Technically a route can have even more than one wildcard segment. The matcher assigns segments to parameters in an intuitive way. For example,

<span style="font-family: DejaVu Sans;">从技术上讲一个</span>route<span style="font-family: DejaVu Sans;">可以有甚至超过一个通配符的分割。</span>matcher<span style="font-family: DejaVu Sans;">分配</span>segments<span style="font-family: DejaVu Sans;">到参数是一个直观的方式。例如，</span>

match '*a/foo/*b' =&gt; 'test#index' # <tt>*a</tt><span style="font-family: DejaVu Sans;"><tt>这一部分通配为</tt></span><tt>a</tt>

would match <tt>zoo/woo/foo/bar/baz</tt> with <tt>params[:a]</tt> equals <tt>"zoo/woo"</tt>, and <tt>params[:b]</tt> equals <tt>"bar/baz"</tt>.

Starting from Rails 3.1, wildcard routes will always match the optional format segment by default. For example if you have this route:

<code>match</code><code> </code><code>'*pages'</code> <code>=&gt;</code><code> </code><code>'pages#show'</code>

<code>By</code><code> </code><code>requesting</code><code> </code><tt>"/foo/bar.json"</tt><code>,</code><code> </code><code>your</code><code> </code><tt>params[:pages]</tt><code> </code><code>will</code><code> </code><code>be</code><code> </code><code>equals</code><code> </code><code>to</code><code> </code><tt>"foo/bar"</tt><code> </code><code>with</code><code> </code><code>the</code><code> </code><code>request</code><code> </code><code>format</code><code> </code><code>of</code><code> </code><code>JSON.</code><code> </code><code>If</code><code> </code><code>you</code><code> </code><code>want</code><code> </code><code>the</code><code> </code><code>old</code><code> </code><code>3.0.x</code><code> </code><code>behavior</code><code> </code><code>back,</code><code> </code><code>you</code><code> </code><code>could</code><code> </code><code>supply</code><code> </code><tt>:format</tt><tt> </tt><tt>=&gt;</tt><tt> </tt><tt>false</tt><code> </code><code>like</code><code> </code><code>this:</code>

<code>match</code><code> </code><code>'*pages'</code><code> </code><code>=&gt;</code><code> </code><code>'pages#show',</code><code> </code><code>:format</code><code> </code><code>=&gt;</code><code> </code><code>false</code>

<code>If</code><code> </code><code>you</code><code> </code><code>want</code><code> </code><code>to</code><code> </code><code>make</code><code> </code><code>the</code><code> </code><code>format</code><code> </code><code>segment</code><code> </code><code>mandatory,</code><code> </code><code>so</code><code> </code><code>it</code><code> </code><code>cannot</code><code> </code><code>be</code><code> </code><code>omitted,</code><code> </code><code>you</code><code> </code><code>can</code><code> </code><code>supply</code><code> </code><tt>:format</tt><tt> </tt><tt>=&gt;</tt><tt> </tt><tt>true</tt><code> </code><code>like</code><code> </code><code>this:</code>

<code>match</code><code> </code><code>'*pages'</code><code> </code><code>=&gt;</code><code> </code><code>'pages#show',</code><code> </code><code>:format</code><code> </code><code>=&gt;</code><code> </code><code>true</code>
<h4><a name="redirection"></a><code>3.12</code><code> </code><code>Redirection</code></h4>
You can redirect any path to another path using the <tt>redirect</tt> helper in your router:

<span style="font-family: DejaVu Sans;"><code>你可以重定向任何</code></span><code>path</code><span style="font-family: DejaVu Sans;"><code>到另一个</code></span><code>path</code><span style="font-family: DejaVu Sans;"><code>使用</code></span><code>redirect</code><code> </code><code>helper</code><span style="font-family: DejaVu Sans;"><code>在你的</code></span><code>router</code><span style="font-family: DejaVu Sans;"><code>：</code></span>

match "/stories" =&gt; redirect("/posts")

You can also reuse dynamic segments from the match in the path to redirect to:

match "/stories/:name" =&gt; redirect("/posts/%{name}")

You can also provide a block to redirect, which receives the params and (optionally) the request object:

match "/stories/:name" =&gt; redirect {|params| "/posts/#{params[:name].pluralize}" }

match "/stories" =&gt; redirect {|p, req| "/posts/#{req.subdomain}" }

In all of these cases, if you don’t provide the leading host (<tt>http://www.example.com</tt>), Rails will take those details from the current request.
<h4><a name="routing-to-rack-applications"></a>3.13 Routing to Rack Applications</h4>
Instead of a String, like <tt>"posts#index"</tt>, which corresponds to the <tt>index</tt> action in the <tt>PostsController</tt>, you can specify any <a href="http://guides.rubyonrails.org/rails_on_rack.html"><span style="color: #000080;"><span style="text-decoration: underline;">Rack</span></span><span style="color: #000080;"><span style="text-decoration: underline;">application</span></span></a> as the endpoint for a matcher.

match "/application.js" =&gt; Sprockets

As long as <tt>Sprockets</tt> responds to <tt>call</tt> and returns a <tt>[status,</tt><tt> </tt><tt>headers,</tt><tt> </tt><tt>body]</tt>, the router won’t know the difference between the Rack application and an action.

For the curious, <tt>"posts#index"</tt> actually expands out to <tt>PostsController.action(:index)</tt>, which returns a valid Rack application.
<h4><a name="using-root"></a>3.14 Using <tt>root</tt></h4>
You can specify what Rails should route <tt>"/"</tt> to with the <tt>root</tt> method:

root :to =&gt; 'pages#main'

<strong>You</strong><strong> </strong><strong>should</strong><strong> </strong><strong>put</strong><strong> </strong><strong>the</strong><strong> </strong><tt><strong>root</strong></tt><strong> </strong><strong>route</strong><strong> </strong><strong>at</strong><strong> </strong><strong>the</strong><strong> </strong><strong>top</strong><strong> </strong><strong>of</strong><strong> </strong><strong>the</strong><strong> </strong><strong>file</strong>, because it is the most popular route and should be matched first. You also need to delete the <tt>public/index.html</tt> file for the root route to take effect.
<h3><a name="customizing-resourceful-routes"></a>4 Customizing Resourceful Routes</h3>
While the default routes and helpers generated by <tt>resources</tt><tt> </tt><tt>:posts</tt> will usually serve you well, you may want to customize them in some way. Rails allows you to customize virtually any generic part of the resourceful helpers.
<h4><a name="specifying-a-controller-to-use"></a>4.1 Specifying a Controller to Use</h4>
The <tt>:controller</tt> option lets you explicitly specify a controller to use for the resource. For example:

resources :photos, :controller =&gt; "images"

will recognize incoming paths beginning with <tt>/photos</tt> but route to the <tt>Images</tt> controller:
<table width="402" cellspacing="0" cellpadding="2"><colgroup><col width="89" /> <col width="102" /> <col width="54" /> <col width="140" /> </colgroup>
<tbody>
<tr>
<th width="89">HTTP Verb</th>
<th width="102">Path</th>
<th width="54">action</th>
<th width="140">named helper</th>
</tr>
<tr>
<td width="89">GET</td>
<td width="102">/photos</td>
<td width="54">index</td>
<td width="140">photos_path</td>
</tr>
<tr>
<td width="89">GET</td>
<td width="102">/photos/new</td>
<td width="54">new</td>
<td width="140">new_photo_path</td>
</tr>
<tr>
<td width="89">POST</td>
<td width="102">/photos</td>
<td width="54">create</td>
<td width="140">photos_path</td>
</tr>
<tr>
<td width="89">GET</td>
<td width="102">/photos/:id</td>
<td width="54">show</td>
<td width="140">photo_path(:id)</td>
</tr>
<tr>
<td width="89">GET</td>
<td width="102">/photos/:id/edit</td>
<td width="54">edit</td>
<td width="140">edit_photo_path(:id)</td>
</tr>
<tr>
<td width="89">PUT</td>
<td width="102">/photos/:id</td>
<td width="54">update</td>
<td width="140">photo_path(:id)</td>
</tr>
<tr>
<td width="89">DELETE</td>
<td width="102">/photos/:id</td>
<td width="54">destroy</td>
<td width="140">photo_path(:id)</td>
</tr>
</tbody>
</table>
Use <tt>photos_path</tt>, <tt>new_photo_path</tt>, etc. to generate paths for this resource.
<h4><a name="specifying-constraints"></a>4.2 Specifying Constraints</h4>
You can use the <tt>:constraints</tt> option to specify a required format on the implicit <tt>id</tt>. For example:

This declaration constraints the <tt>:id</tt> parameter to match the supplied regular expression. So, in this case, the router would no longer match <tt>/photos/1</tt> to this route. Instead, <tt>/photos/RR27</tt> would match.

You can specify a single constraint to apply to a number of routes by using the block form:

constraints(:id =&gt; /[A-Z][A-Z][0-9]+/) do

resources :photos

resources :accounts

end

Of course, you can use the more advanced constraints available in non-resourceful routes in this context.

&nbsp;

By default the <tt>:id</tt> parameter doesn’t accept dots – this is because the dot is used as a separator for formatted routes. If you need to use a dot within an <tt>:id</tt> add a constraint which overrides this – for example <tt>:id</tt> =&gt; /[^\/]+/ allows anything except a slash.
<h4><a name="overriding-the-named-helpers"></a>4.3 Overriding the Named Helpers</h4>
The <tt>:as</tt> option lets you override the normal naming for the named route helpers. For example:

resources :photos, :as =&gt; "images"

will recognize incoming paths beginning with <tt>/photos</tt> and route the requests to <tt>PhotosController</tt>, but use the value of the :as option to name the helpers.
<table width="398" cellspacing="0" cellpadding="2"><colgroup><col width="83" /> <col width="102" /> <col width="54" /> <col width="143" /> </colgroup>
<tbody>
<tr>
<th width="83">HTTP verb</th>
<th width="102">Path</th>
<th width="54">action</th>
<th width="143">named helper</th>
</tr>
<tr>
<td width="83">GET</td>
<td width="102">/photos</td>
<td width="54">index</td>
<td width="143">images_path</td>
</tr>
<tr>
<td width="83">GET</td>
<td width="102">/photos/new</td>
<td width="54">new</td>
<td width="143">new_image_path</td>
</tr>
<tr>
<td width="83">POST</td>
<td width="102">/photos</td>
<td width="54">create</td>
<td width="143">images_path</td>
</tr>
<tr>
<td width="83">GET</td>
<td width="102">/photos/:id</td>
<td width="54">show</td>
<td width="143">image_path(:id)</td>
</tr>
<tr>
<td width="83">GET</td>
<td width="102">/photos/:id/edit</td>
<td width="54">edit</td>
<td width="143">edit_image_path(:id)</td>
</tr>
<tr>
<td width="83">PUT</td>
<td width="102">/photos/:id</td>
<td width="54">update</td>
<td width="143">image_path(:id)</td>
</tr>
<tr>
<td width="83">DELETE</td>
<td width="102">/photos/:id</td>
<td width="54">destroy</td>
<td width="143">image_path(:id)</td>
</tr>
</tbody>
</table>
<h4><a name="overriding-the-new-and-edit-segments"></a> 4.4 Overriding the <tt>new</tt> and <tt>edit</tt> Segments<span style="font-family: WenQuanYi Micro Hei;">重写</span>new<span style="font-family: WenQuanYi Micro Hei;">和</span>edit Segments</h4>
The <tt>:path_names</tt> option lets you override the automatically-generated “new” and “edit” segments in paths:

resources :photos, :path_names =&gt; { :new =&gt; 'make', :edit =&gt; 'change' }

This would cause the routing to recognize paths such as

<code>/photos/make</code>

<code>/photos/1/change</code>

The actual action names aren’t changed by this option. The two paths shown would still route to the <tt>new</tt> and <tt>edit</tt> actions.

&nbsp;

If you find yourself wanting to change this option uniformly for all of your routes, you can use a scope.

scope :path_names =&gt; { :new =&gt; "make" } do

# rest of your routes

end
<h4><a name="prefixing-the-named-route-helpers"></a>4.5 Prefixing the Named Route Helpers</h4>
You can use the <tt>:as</tt> option to prefix the named route helpers that Rails generates for a route. Use this option to prevent name collisions between routes using a path scope

scope "admin" do

resources :photos, :as =&gt; "admin_photos"

end

&nbsp;

resources :photos

This will provide route helpers such as <tt>admin_photos_path</tt>, <tt>new_admin_photo_path</tt> etc.<span style="font-family: DejaVu Sans;">这将会提供比如 </span><tt>admin_photos_path</tt>, <tt>new_admin_photo_path</tt><span style="font-family: DejaVu Sans;"><tt>等这样的</tt></span><tt>route helpers</tt><span style="font-family: DejaVu Sans;"><tt>。</tt></span>

To prefix a group of route helpers, use <tt>:as</tt> with <tt>scope</tt>:

scope "admin", :as =&gt; "admin" do

resources :photos, :accounts

end

&nbsp;

resources :photos, :accounts

This will generate routes such as <tt>admin_photos_path</tt> and <tt>admin_accounts_path</tt> which map to <tt>/admin/photos</tt> and <tt>/admin/accounts</tt> respectively.

The <tt><strong>namespace</strong></tt> scope will automatically add <tt>:as</tt> as well as <tt>:module</tt> and <tt>:path</tt> prefixes.

You can prefix routes with a named parameter also:

scope ":username" do

resources :posts

end

This will provide you with URLs such as <tt>/bob/posts/1</tt> and will allow you to reference the <tt>username</tt> part of the path as <tt>params[:username]</tt> in controllers, helpers and views.
<h4><a name="restricting-the-routes-created"></a>4.6 Restricting the Routes Created<span style="font-family: WenQuanYi Micro Hei;">限制</span>routes<span style="font-family: WenQuanYi Micro Hei;">被创建</span></h4>
By default, Rails creates routes for the seven default actions (index, show, new, create, edit, update, and destroy) for every RESTful route in your application. You can use the <tt>:only</tt> and <tt>:except</tt> options to fine-tune this behavior. The <tt>:only</tt> option tells Rails to create only the specified routes:

<span style="font-family: DejaVu Sans;">默认的，</span>Rails<span style="font-family: DejaVu Sans;">按照七种默认的</span>action<span style="font-family: DejaVu Sans;">（</span>index, show, new, create, edit, update, and destroy<span style="font-family: DejaVu Sans;">）为你应用程序中的每个</span>RESTful route<span style="font-family: DejaVu Sans;">创建</span>routes<span style="font-family: DejaVu Sans;">。</span>

resources :photos, :only =&gt; [:index, :show]

Now, a <tt>GET</tt> request to <tt>/photos</tt> would succeed, but a <tt>POST</tt> request to <tt>/photos</tt> (which would ordinarily be routed to the <tt>create</tt> action) will fail.

<span style="font-family: DejaVu Sans;">现在一个</span>GET<span style="font-family: DejaVu Sans;">请求到</span><tt>/photos</tt><span style="font-family: DejaVu Sans;"><tt>将会成功，但是一个</tt></span><tt>POST</tt><span style="font-family: DejaVu Sans;"><tt>到</tt></span><tt>/photos</tt><span style="font-family: DejaVu Sans;"><tt>（其按理将会</tt></span><tt>route</tt><span style="font-family: DejaVu Sans;"><tt>到</tt></span><tt>create action</tt><span style="font-family: DejaVu Sans;"><tt>）将会失败。</tt></span>

The <tt>:except</tt> option specifies a route or list of routes that Rails should <em>not</em> create:

resources :photos, :except =&gt; :destroy

In this case, Rails will create all of the normal routes except the route for <tt>destroy</tt> (a <tt>DELETE</tt> request to <tt>/photos/:id</tt>).

If your application has many RESTful routes, using <tt>:only</tt> and <tt>:except</tt> to generate only the routes that you actually need can cut down on memory use and speed up the routing process.

<span style="font-family: DejaVu Sans;">如果你的应用程序中有很多 </span>RESTful routes<span style="font-family: DejaVu Sans;">，使用</span><tt>:only</tt> and <tt>:except</tt><span style="font-family: DejaVu Sans;"><tt>来生成仅仅你实际需要的</tt></span><tt>route</tt><span style="font-family: DejaVu Sans;"><tt>能够消减内存使用和提速</tt></span><tt>routing </tt><span style="font-family: DejaVu Sans;"><tt>进程。</tt></span>
<h4><a name="translated-paths"></a>4.7 Translated Paths<span style="font-family: WenQuanYi Micro Hei;">翻译路径</span></h4>
Using <tt>scope</tt>, we can alter path names generated by resources:

<span style="font-family: DejaVu Sans;">使用</span>scope<span style="font-family: DejaVu Sans;">，我们可以别名</span>resources<span style="font-family: DejaVu Sans;">生成的路径</span>name<span style="font-family: DejaVu Sans;">：</span>

scope(:path_names =&gt; { :new =&gt; "neu", :edit =&gt; "bearbeiten" }) do

resources :categories, :path =&gt; "kategorien"

end

<tt>Rails now creates routes to the CategoriesController.</tt>
<table width="482" cellspacing="0" cellpadding="2"><colgroup><col width="83" /> <col width="170" /> <col width="54" /> <col width="159" /> </colgroup>
<tbody>
<tr>
<th width="83">HTTP verb</th>
<th width="170">Path</th>
<th width="54">action</th>
<th width="159">named helper</th>
</tr>
<tr>
<td width="83">GET</td>
<td width="170">/kategorien</td>
<td width="54">index</td>
<td width="159">categories_path</td>
</tr>
<tr>
<td width="83">GET</td>
<td width="170">/kategorien/neu</td>
<td width="54">new</td>
<td width="159">new_category_path</td>
</tr>
<tr>
<td width="83">POST</td>
<td width="170">/kategorien</td>
<td width="54">create</td>
<td width="159">categories_path</td>
</tr>
<tr>
<td width="83">GET</td>
<td width="170">/kategorien/:id</td>
<td width="54">show</td>
<td width="159">category_path(:id)</td>
</tr>
<tr>
<td width="83">GET</td>
<td width="170">/kategorien/:id/bearbeiten</td>
<td width="54">edit</td>
<td width="159">edit_category_path(:id)</td>
</tr>
<tr>
<td width="83">PUT</td>
<td width="170">/kategorien/:id</td>
<td width="54">update</td>
<td width="159">category_path(:id)</td>
</tr>
<tr>
<td width="83">DELETE</td>
<td width="170">/kategorien/:id</td>
<td width="54">destroy</td>
<td width="159">category_path(:id)</td>
</tr>
</tbody>
</table>
<h4><a name="overriding-the-singular-form"></a><tt>4.8 Overriding the Singular Form</tt></h4>
If you want to define the singular form of a resource, you should add additional rules to the <tt>Inflector</tt>.

<span style="font-family: DejaVu Sans;"><tt>如果你想定义一个单数形式的</tt></span><tt>resource</tt><span style="font-family: DejaVu Sans;"><tt>，你应该添加补充的</tt></span><tt>rules</tt><span style="font-family: DejaVu Sans;"><tt>到</tt></span><tt>Inflector</tt><span style="font-family: DejaVu Sans;"><tt>。</tt></span>

ActiveSupport::Inflector.inflections do |inflect|

inflect.irregular 'tooth', 'teeth'

end
<h4><a name="nested-names"></a>4.9 Using <tt>:as</tt> in Nested Resources<span style="font-family: WenQuanYi Micro Hei;">在嵌套</span>resources<span style="font-family: WenQuanYi Micro Hei;">中使用</span>:as</h4>
The <tt>:as</tt> option overrides the automatically-generated name for the resource in nested route helpers. For example,

:as<span style="font-family: DejaVu Sans;">选项覆盖嵌套的</span>resource<span style="font-family: DejaVu Sans;">自动生成的</span>route<span style="font-family: DejaVu Sans;">的名字。例如：</span>

resources :magazines do

resources :ads, :as =&gt; 'periodical_ads'

end

This will create routing helpers such as <tt>magazine_periodical_ads_url</tt> and <tt>edit_magazine_periodical_ad_path</tt>.
<h3><a name="inspecting-and-testing-routes"></a>5 Inspecting and Testing Routes<span style="font-family: WenQuanYi Micro Hei;">检查和测试</span>routes</h3>
Rails offers facilities for inspecting and testing your routes.

Rails<span style="font-family: DejaVu Sans;">提供设施来检查和测试你的</span>routes<span style="font-family: DejaVu Sans;">。</span>
<h4><a name="seeing-existing-routes-with-rake"></a>5.1 Seeing Existing Routes with <tt>rake</tt><span style="font-family: WenQuanYi Micro Hei;"><tt>使用</tt></span><tt>rake</tt><span style="font-family: WenQuanYi Micro Hei;"><tt>来查看存在的</tt></span><tt>routes</tt></h4>
If you want a complete list of all of the available routes in your application, run <tt> rake routes</tt> command. This will print all of your routes, in the same order that they appear in <tt>routes.rb</tt>. For each route, you’ll see:

<span style="font-family: DejaVu Sans;">如果你需要一个你应用程序中可用的完整的</span>list<span style="font-family: DejaVu Sans;">，运行 </span><tt>rake routes</tt><span style="font-family: DejaVu Sans;"><tt>命令。这将会打印所有你的</tt></span><tt>routes</tt><span style="font-family: DejaVu Sans;"><tt>（到终端），与</tt></span><tt>routes.rb</tt><span style="font-family: DejaVu Sans;"><tt>中出现的顺序一样。对于每个</tt></span><tt>route</tt><span style="font-family: DejaVu Sans;"><tt>，你将会看到：</tt></span>
<ul>
	<li>The route name (if any)</li>
	<li>The HTTP verb used (if the route doesn’t respond to all verbs)</li>
	<li>The URL pattern to match <span style="font-family: DejaVu Sans;">匹配的</span>URL<span style="font-family: DejaVu Sans;">模式</span></li>
	<li>The routing parameters for the route</li>
</ul>
For example, here’s a small section of the <tt>rake routes</tt> output for a RESTful route:
<pre>          users GET  /users          {:controller=&gt;"users", :action=&gt;"index"}
formatted_users GET  /users.:format  {:controller=&gt;"users", :action=&gt;"index"}
                POST /users          {:controller=&gt;"users", :action=&gt;"create"}
                POST /users.:format  {:controller=&gt;"users", :action=&gt;"create"}</pre>
You may restrict the listing to the routes that map to a particular controller setting the <tt>CONTROLLER</tt> environment variable:

<span style="font-family: DejaVu Sans;">你可以限制列出的</span>routes<span style="font-family: DejaVu Sans;">映射到一个别的</span>controller<span style="font-family: DejaVu Sans;">设置 </span><tt>CONTROLLER</tt><span style="font-family: DejaVu Sans;"><tt>环境变量：</tt></span>

$ CONTROLLER=users rake routes

You’ll find that the output from <tt>rake routes</tt> is much more readable if you widen your terminal window until the output lines don’t wrap.

<span style="font-family: DejaVu Sans;">你会发现如果你扩大到你的终端不自动换行，<tt>来自</tt></span><tt>rake routes</tt><span style="font-family: DejaVu Sans;"><tt>会更具可读性。</tt></span>
<h4><a name="testing-routes"></a>5.2 Testing Routes</h4>
Routes should be included in your testing strategy<span style="font-family: DejaVu Sans;">策略 </span>(just like the rest of your application). Rails offers three <a href="http://api.rubyonrails.org/classes/ActionDispatch/Assertions/RoutingAssertions.html">built-in assertions</a> designed to make testing routes simpler:
<ul>
	<li><tt>assert_generates</tt></li>
	<li><tt>assert_recognizes</tt></li>
	<li><tt>assert_routing</tt></li>
</ul>
<h5><a name="the-assert_generates-assertion"></a>5.2.1 The <tt>assert_generates</tt> Assertion</h5>
<tt>assert_generates</tt> asserts that a particular set of options generate a particular path and can be used with default routes or custom routes.

<tt>assert_generates</tt><span style="font-family: DejaVu Sans;"><tt>断言是一个特别的设置选项生成一个特别的路径并且可以与默认的</tt></span><tt>routes</tt><span style="font-family: DejaVu Sans;"><tt>和定制的</tt></span><tt>routes</tt><span style="font-family: DejaVu Sans;"><tt>。</tt></span>

assert_generates "/photos/1", { :controller =&gt; "photos", :action =&gt; "show", :id =&gt; "1" }

assert_generates "/about", :controller =&gt; "pages", :action =&gt; "about"
<h5><a name="the-assert_recognizes-assertion"></a>5.2.2 The <tt>assert_recognizes</tt> Assertion</h5>
<tt>assert_recognizes</tt> is the inverse of <tt> </tt><tt>assert_generates</tt>. It asserts that a given path is recognized and routes it to a particular spot in your application.

<a name="result_box2"></a><tt>assert_recognizes</tt><span style="font-family: DejaVu Sans;"><tt>是 </tt></span><tt>assert_generates</tt><span style="font-family: DejaVu Sans;"><tt>的逆。它断言</tt>一个给定的</span>path<span style="font-family: DejaVu Sans;">是被承认的并</span>route<span style="font-family: DejaVu Sans;">到应用程序中的特定地点。</span>

<tt>assert_recognizes({ :controller =&gt; "photos", :action =&gt; "show", :id =&gt; "1" }, "/photos/1")</tt>

You can supply a <tt>:method</tt> argument to specify the HTTP verb:

<span style="font-family: DejaVu Sans;">你可以提供一个</span>:method<span style="font-family: DejaVu Sans;">参数来指定</span>HTTP verbe<span style="font-family: DejaVu Sans;">：</span>

assert_recognizes({ :controller =&gt; "photos", :action =&gt; "create" }, { :path =&gt; "photos", :method =&gt; :post })

assert_recognizes({ :controller =&gt; "photos", :action =&gt; "create" }, { :path =&gt; "photos", :method =&gt; :post })
<h5><a name="the-assert_routing-assertion"></a>5.2.3 The <tt>assert_routing</tt> Assertion</h5>
The assertion checks the route both ways: it tests that the path generates the options, and that the options generate the path. Thus, it combines the functions of <tt> assert_generates and </tt><tt>assert_recognizes</tt>.

<span style="font-family: DejaVu Sans;">断言 </span><tt>assert_routing</tt><span style="font-family: DejaVu Sans;"><tt>检测</tt></span><tt>route</tt><span style="font-family: DejaVu Sans;"><tt>两方面：它测试访问路径生成选项，并且测试这个选项生成的路径。这样，它联合了 </tt></span><tt>assert_generates and assert_recognizes</tt><span style="font-family: DejaVu Sans;"><tt>的功能。</tt></span>

assert_routing({ :path =&gt; "photos", :method =&gt; :post }, { :controller =&gt; "photos", :action =&gt; "create" })

标签： <a href="http://jhjguxin.hwcrazy.com/tag/guide/">guide</a> <a href="http://jhjguxin.hwcrazy.com/tag/http/">http</a> <a href="http://jhjguxin.hwcrazy.com/tag/rails/">rails</a> <a href="http://jhjguxin.hwcrazy.com/tag/route/">route</a> <a href="http://jhjguxin.hwcrazy.com/tag/ruby/">ruby</a> <a href="http://jhjguxin.hwcrazy.com/tag/translate/">translate</a>
