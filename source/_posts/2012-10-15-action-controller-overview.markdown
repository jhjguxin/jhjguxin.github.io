---
layout: post
title: "Action Controller Overview"
date: 2011-12-27 00:24
comments: true
categories: [rails,ruby]
tags: [controller,filter,guide,rails,ruby]
---
## Action Controller Overview
<h3>Controllers</h3>
<dl><dt>Action Controller Overview</dt><dd>This guide covers how controllers work and how they fit into the request cycle in your application. It includes sessions, filters, and cookies, data streaming, and dealing with exceptions raised by a request, among other topics.</dd><dt>Rails Routing from the Outside In</dt><dd>This guide covers the user-facing features of Rails routing. If you want to understand how to use routing in your own Rails applications, start here.</dd></dl>
<h2>Action Controller Overview</h2>
In this guide you will learn how controllers work and how they fit into the request cycle in your application. After reading this guide, you will be able to:

<span style="font-family: DejaVu Sans;">在这个</span>gudie<span style="font-family: DejaVu Sans;">中你将会学习到</span>controllers<span style="font-family: DejaVu Sans;">是怎样工作的以及它们在你的应用程序中是怎用配合完成</span>request cycle<span style="font-family: DejaVu Sans;">。</span>
<ul>
	<li>Follow the flow of a request through a controller</li>
</ul>
<span style="font-family: DejaVu Sans;">跟随</span>requset<span style="font-family: DejaVu Sans;">流向一个</span>controller
<ul>
	<li>Understand why and how to store data in the session or cookies</li>
</ul>
<span style="font-family: DejaVu Sans;">明白在会话和</span>cookies<span style="font-family: DejaVu Sans;">中为什么以及怎样存储</span>data
<ul>
	<li>Work with filters to execute code during request processing</li>
</ul>
<span style="font-family: DejaVu Sans;">使用</span>filters<span style="font-family: DejaVu Sans;">来工作在</span>request<span style="font-family: DejaVu Sans;">过程中执行</span>code
<ul>
	<li>Use Action Controller’s built-in HTTP authentication</li>
</ul>
<span style="font-family: DejaVu Sans;">使用</span>Action Controller<span style="font-family: DejaVu Sans;">的内置的</span>HTTP<span style="font-family: DejaVu Sans;">认证</span>
<ul>
	<li>Stream data directly to the user’s browser</li>
</ul>
Stream data<span style="font-family: DejaVu Sans;">直接（到）用户的浏览器</span>
<ul>
	<li>Filter sensitive parameters so they do not appear in the application’s log</li>
</ul>
<span style="font-family: DejaVu Sans;">过滤敏感参数使得它们不会在应用程序的</span>log<span style="font-family: DejaVu Sans;">中出现</span>
<ul>
	<li>Deal with exceptions that may be raised during request processing</li>
</ul>
<span style="font-family: DejaVu Sans;">处理可能在</span>request<span style="font-family: DejaVu Sans;">进程之间抛出的意外</span>
<h3><a name="what-does-a-controller-do"></a> 1 What Does a Controller Do?</h3>
Action Controller is the C in MVC. After routing has determined which controller to use for a request, your controller is responsible for making sense of the request and producing the appropriate output. Luckily, Action Controller does most of the groundwork for you and uses smart conventions to make this as straightforward as possible.
Action Controller<span style="font-family: DejaVu Sans;">是</span>MVC<span style="font-family: DejaVu Sans;">中的</span>C<span style="font-family: DejaVu Sans;">。在</span>routing<span style="font-family: DejaVu Sans;">已经决定了对于一个</span>request<span style="font-family: DejaVu Sans;">使用哪个</span>controller<span style="font-family: DejaVu Sans;">，你的</span>controller<span style="font-family: DejaVu Sans;">负责请求的实际意图并且产生合适的输出。幸运的是，</span>Action Controller<span style="font-family: DejaVu Sans;">为了做了大多数的基础工作并且使用智能方便的（方式）使得</span>C<span style="font-family: DejaVu Sans;">能够尽可能的直接干脆。</span>

For most conventional RESTful applications, the controller will receive the request (this is invisible to you as the developer), fetch or save data from a model and use a view to create HTML output. If your controller needs to do things a little differently, that’s not a problem, this is just the most common way for a controller to work.

<span style="font-family: DejaVu Sans;">对于大多数的传统的</span>RESTful<span style="font-family: DejaVu Sans;">应用程序，</span>controller<span style="font-family: DejaVu Sans;">将会收到请求（这对于开发者你来说是无形的），从一个</span>model<span style="font-family: DejaVu Sans;">刷新或者</span>savee<span style="font-family: DejaVu Sans;">数据或者使用一个视图来创建</span>HTML<span style="font-family: DejaVu Sans;">输出。如果你的</span>controller<span style="font-family: DejaVu Sans;">需要做些略微不同的事情，这不是问题，这仅仅是</span>controller<span style="font-family: DejaVu Sans;">在工作中大多数通常的方式。</span>

A controller can thus be thought of as a middle man between models and views. It makes the model data available to the view so it can display that data to the user, and it saves or updates data from the user to the model.

<span style="font-family: DejaVu Sans;">一个</span>controller<span style="font-family: DejaVu Sans;">能够这样，作为在</span>models<span style="font-family: DejaVu Sans;">和</span>views<span style="font-family: DejaVu Sans;">之间的中间人。它使得</span>model<span style="font-family: DejaVu Sans;">数据可以用户</span>view<span style="font-family: DejaVu Sans;">因此它可以显示这些数据给用户，同时它从用户保存或者更新数据到</span>model<span style="font-family: DejaVu Sans;">。</span>

For more details on the routing process, see <span style="color: #000080;"><span style="text-decoration: underline;"><a href="http://guides.rubyonrails.org/routing.html">Rails</a></span></span><span style="color: #000080;"><span style="text-decoration: underline;"><a href="http://guides.rubyonrails.org/routing.html">Routing</a></span></span><span style="color: #000080;"><span style="text-decoration: underline;"><a href="http://guides.rubyonrails.org/routing.html">from</a></span></span><span style="color: #000080;"><span style="text-decoration: underline;"><a href="http://guides.rubyonrails.org/routing.html">the</a></span></span><span style="color: #000080;"><span style="text-decoration: underline;"><a href="http://guides.rubyonrails.org/routing.html">Outside</a></span></span><span style="color: #000080;"><span style="text-decoration: underline;"><a href="http://guides.rubyonrails.org/routing.html">In</a></span></span>.
<h3><a name="methods-and-actions"></a>2 Methods and Actions</h3>
A controller is a Ruby class which inherits from <tt>ApplicationController</tt> and has methods just like any other class. When your application receives a request, the routing will determine which controller and action to run, then Rails creates an instance of that controller and runs the method with the same name as the action.

<span style="font-family: DejaVu Sans;">一个</span>controller<span style="font-family: DejaVu Sans;">是一个</span>Ruby<span style="font-family: DejaVu Sans;">类它继承至</span><tt>ApplicationController</tt><span style="font-family: DejaVu Sans;"><tt>同时像其他类一样它也有方法。当你的应用程序收到一个</tt></span><tt>request</tt><span style="font-family: DejaVu Sans;"><tt>，</tt></span><tt>routing</tt><span style="font-family: DejaVu Sans;"><tt>将会决定那个</tt></span><tt>controller</tt><span style="font-family: DejaVu Sans;"><tt>和</tt></span><tt>action</tt><span style="font-family: DejaVu Sans;"><tt>会运行，然后</tt></span><tt>Rails</tt><span style="font-family: DejaVu Sans;"><tt>创建一个</tt></span><tt>controller</tt><span style="font-family: DejaVu Sans;"><tt>的实例同时运行与</tt></span><tt>action</tt><span style="font-family: DejaVu Sans;"><tt>名字相同的方法。</tt></span>

class ClientsController &lt; ApplicationController

def new

end

end

As an example, if a user goes to <tt>/clients/new</tt> in your application to add a new client, Rails will create an instance of <tt>ClientsController</tt> and run the <tt>new</tt> method. Note that the empty method from the example above could work just fine because Rails will by default render the <tt>new.html.erb</tt> view unless the action says otherwise. The <tt>new</tt> method could make available to the view a <tt>@client</tt> instance variable by creating a new <tt>Client</tt>:

<span style="font-family: DejaVu Sans;">正如一个例子，如果一个</span>user<span style="font-family: DejaVu Sans;">导航至</span><tt>/clients/new</tt> <span style="font-family: DejaVu Sans;">在你的应用程序中添加一个</span>new client<span style="font-family: DejaVu Sans;">，</span>Rails<span style="font-family: DejaVu Sans;">将会创建一个</span><tt>ClientsController</tt><span style="font-family: DejaVu Sans;"><tt>的实例并且运行</tt></span><tt>new</tt><span style="font-family: DejaVu Sans;"><tt>方法。注意例子中空的方法完全可以工作因为</tt></span><tt>Rails</tt><span style="font-family: DejaVu Sans;"><tt>将会默认</tt></span><tt>render</tt><span style="font-family: DejaVu Sans;"><tt>名称为</tt><tt></tt></span><tt>new.html.erb</tt><span style="font-family: DejaVu Sans;"><tt>的视图除非</tt></span><tt>action</tt><span style="font-family: DejaVu Sans;"><tt>指定了另外的。</tt></span><tt>new</tt><span style="font-family: DejaVu Sans;"><tt>方法通过创建一个新的</tt></span><tt>Client</tt><span style="font-family: DejaVu Sans;"><tt>将使得可以查看</tt></span><tt>@client</tt><span style="font-family: DejaVu Sans;"><tt>实例变量。</tt></span>

def new

@client = Client.new

end

The <span style="color: #000080;"><span style="text-decoration: underline;"><a href="http://guides.rubyonrails.org/layouts_and_rendering.html">Layouts</a></span></span><span style="color: #000080;"><span style="text-decoration: underline;"><a href="http://guides.rubyonrails.org/layouts_and_rendering.html">&amp;</a></span></span><span style="color: #000080;"><span style="text-decoration: underline;"><a href="http://guides.rubyonrails.org/layouts_and_rendering.html">Rendering</a></span></span><span style="color: #000080;"><span style="text-decoration: underline;"><a href="http://guides.rubyonrails.org/layouts_and_rendering.html">Guide</a></span></span> explains this in more detail.

<tt>ApplicationController</tt> inherits from <tt>ActionController::Base</tt>, which defines a number of helpful methods. This guide will cover some of these, but if you’re curious to see what’s in there, you can see all of them in the API documentation or in the source itself.

<tt>ApplicationController</tt><span style="font-family: DejaVu Sans;"><tt>继承至</tt><tt></tt></span><tt>ActionController::Base</tt><span style="font-family: DejaVu Sans;"><tt>，器定义了很多</tt></span><tt>helpful</tt><span style="font-family: DejaVu Sans;"><tt>方法。这个教材将会涵盖这些，但是如果你好奇与其中有些什么，你可以在</tt></span><tt>API</tt><span style="font-family: DejaVu Sans;"><tt>文档中或者他的源代码中看到所有的方法。</tt></span>

Only public methods are callable as actions. It is a best practice to lower the visibility of methods which are not intended to be actions, like auxiliary methods or filters.

<span style="font-family: DejaVu Sans;">对于</span>action<span style="font-family: DejaVu Sans;">只有公共的方法才是可调用的。它是低敏感度方法的最好实践，而这些对</span>actions<span style="font-family: DejaVu Sans;">没有义务，像辅助方法或者过滤器。</span>
<h3><a name="parameters"></a>3 Parameters</h3>
You will probably want to access data sent in by the user or other parameters in your controller actions. There are two kinds of parameters possible in a web application. The first are parameters that are sent as part of the URL, called query string parameters. The query string is everything after “?” in the URL. The second type of parameter is usually referred to as POST data. This information usually comes from an HTML form which has been filled in by the user. It’s called POST data because it can only be sent as part of an HTTP POST request. Rails does not make any distinction between query string parameters and POST parameters, and both are available in the <tt>params</tt> hash in your controller:

<span style="font-family: DejaVu Sans;">在你的</span>controller action<span style="font-family: DejaVu Sans;">中你可能想访问用户或者其他参数发送的数据。一个</span>web<span style="font-family: DejaVu Sans;">应用程序中这里可能有两种参数。第一种是作为</span>URL<span style="font-family: DejaVu Sans;">一部分发送的参数，叫做</span>query string parameters<span style="font-family: DejaVu Sans;">（字符串查询参数）。查询字符串是在</span>URL<span style="font-family: DejaVu Sans;">的<span style="font-family: Liberation Serif,Times New Roman,serif;">”</span></span>?”<span style="font-family: DejaVu Sans;">后面的所有字符。第二种类型的参数通常被简称为</span>POST data<span style="font-family: DejaVu Sans;">。这类信息通常来至于一个被用户填写的</span>HTML<span style="font-family: DejaVu Sans;">表单。它被称为</span>POST data<span style="font-family: DejaVu Sans;">因为它仅能通过</span>HTTP POST <span style="font-family: DejaVu Sans;">请求的一部分发送。</span>Rails<span style="font-family: DejaVu Sans;">在字符串查询参数和</span>POST data<span style="font-family: DejaVu Sans;">参数之间不做任何区分，它们在你的</span>controller<span style="font-family: DejaVu Sans;">的</span>params<span style="font-family: DejaVu Sans;">字典中都是可用的。</span>

class ClientsController &lt; ActionController::Base

# This action uses query string parameters because it gets run

# by an HTTP GET request, but this does not make any difference

# to the way in which the parameters are accessed. The URL for

# this action would look like this in order to list activated

# clients: /clients?status=activated

def index

if params[:status] == "activated"

@clients = Client.activated

else

@clients = Client.unactivated

end

end

&nbsp;

# This action uses POST parameters. They are most likely coming

# from an HTML form which the user has submitted. The URL for

# this RESTful request will be "/clients", and the data will be

# sent as part of the request body.

def create

@client = Client.new(params[:client])

if @client.save

redirect_to @client

else

# This line overrides the default rendering behavior, which

# would have been to render the "create" view.

render :action =&gt; "new"

end

end

end
<h4><a name="hash-and-array-parameters"></a>3.1 Hash and Array Parameters</h4>
The <tt>params</tt> hash is not limited to one-dimensional keys and values. It can contain arrays and (nested) hashes. To send an array of values, append an empty pair of square brackets “[]” to the key name:

params hash<span style="font-family: DejaVu Sans;">字典不限于一维的关键字和值。它能够包含数组和（嵌套）字典。要发送一个数组值，添加一个空的<span style="font-family: Liberation Serif,Times New Roman,serif;">”</span></span>[]”<span style="font-family: DejaVu Sans;">给</span>key name<span style="font-family: DejaVu Sans;">：</span>
<pre>GET /clients?ids[]=1&amp;ids[]=2&amp;ids[]=3</pre>
<strong>The</strong><strong> </strong><strong>actual</strong><strong> </strong><strong>URL</strong><strong> </strong><strong>in</strong><strong> </strong><strong>this</strong><strong> </strong><strong>example</strong><strong> </strong><strong>will</strong><strong> </strong><strong>be</strong><strong> </strong><strong>encoded</strong><strong> </strong><strong>as</strong><strong> “</strong><strong>/clients?ids%5b%5d=1&amp;ids%5b%5d=2&amp;ids%5b%5d=3</strong><strong>” </strong><strong>as</strong><strong> “</strong><strong>[</strong><strong>” </strong><strong>and</strong><strong> “</strong><strong>]</strong><strong>” </strong><strong>are</strong><strong> </strong><strong>not</strong><strong> </strong><strong>allowed</strong><strong> </strong><strong>in</strong><strong> </strong><strong>URLs.</strong><strong> </strong>Most of the time you don’t have to worry about this because the browser will take care of it for you, and Rails will decode it back when it receives it, but if you ever find yourself having to send those requests to the server manually you have to keep this in mind.<span style="font-family: DejaVu Sans;">但是如果你发现你自己不得不手动的发送这些请求到服务器你必须注意。</span>

The value of <tt>params[:ids]</tt> will now be <tt>["1",</tt><tt> </tt><tt>"2",</tt><tt> </tt><tt>"3"]</tt>. <strong>Note</strong><strong> </strong><strong>that</strong><strong> </strong><strong>parameter</strong><strong> </strong><strong>values</strong><strong> </strong><strong>are</strong><strong> </strong><strong>always</strong><strong> </strong><strong>strings;</strong><strong> </strong>Rails makes no attempt to guess or cast the type.

To send a hash you include the key name inside the brackets:

&lt;form accept-charset="UTF-8" action="/clients" method="post"&gt;

&lt;input type="text" name="client[name]" value="Acme" /&gt;

&lt;input type="text" name="client[phone]" value="12345" /&gt;

&lt;input type="text" name="client[address][postcode]" value="12345" /&gt;

&lt;input type="text" name="client[address][city]" value="Carrot City" /&gt;

&lt;/form&gt;

When this form is submitted, the <strong>value</strong><strong> </strong><strong>of</strong><strong> </strong><tt><strong>params[:client]</strong></tt> will be <tt>{"name"</tt><tt> </tt><tt>=&gt;</tt><tt> “</tt><tt>Acme</tt><tt>”</tt><tt>,</tt><tt> “</tt><tt>phone</tt><tt>” </tt><tt>=&gt;</tt><tt> “</tt><tt>12345</tt><tt>”</tt><tt>,</tt><tt> “</tt><tt>address</tt><tt>” </tt><tt>=&gt;</tt><tt> </tt><tt>{"postcode"</tt><tt> </tt><tt>=&gt;</tt><tt> “</tt><tt>12345</tt><tt>”</tt><tt>,</tt><tt> “</tt><tt>city</tt><tt>” </tt><tt>=&gt;</tt><tt> “</tt><tt>Carrot</tt><tt> </tt><tt>City</tt><tt>”</tt><tt>}}</tt>. Note the nested hash in <tt>params[:client][:address]</tt>.

Note that the <tt>params</tt> hash is actually an instance of <tt>HashWithIndifferentAccess</tt> from Active Support, which acts like a hash that lets you use symbols and strings interchangeably<span style="font-family: DejaVu Sans;">互换</span>as keys.
<h4><a name="json-xml-parameters"></a>3.2 JSON/XML parameters</h4>
If you’re writing a web service application, you might find yourself more comfortable on accepting parameters in JSON or XML format. Rails will automatically convert your parameters into <tt>params</tt> hash, which you’ll be able to access like you would normally do with form data.

<span style="font-family: DejaVu Sans;">如果你打算写一个</span>web<span style="font-family: DejaVu Sans;">服务程序，你可能会发现使用</span>JSON<span style="font-family: DejaVu Sans;">或者</span>XML<span style="font-family: DejaVu Sans;">格式接收参数会更加舒服。</span>Rails<span style="font-family: DejaVu Sans;">将会自动的转换你的参数到</span>params hash<span style="font-family: DejaVu Sans;">字典中，其中你将可以像正常表单数据那样接收数据。</span>

So for example, if you are sending this JSON parameter:
<pre>{ "company": { "name": "acme", "address": "123 Carrot Street" } }</pre>
You’ll get <tt>params[:company]</tt> as <tt>{</tt><tt> </tt><tt>:name</tt><tt> </tt><tt>=&gt;</tt><tt> “</tt><tt>acme</tt><tt>”</tt><tt>,</tt><tt> “</tt><tt>address</tt><tt>” </tt><tt>=&gt;</tt><tt> “</tt><tt>123</tt><tt> </tt><tt>Carrot</tt><tt> </tt><tt>Street</tt><tt>” </tt><tt>}</tt>.

Also, if you’ve turned on <tt>config.wrap_parameters</tt> in your initializer or calling <tt>wrap_parameters</tt> in your controller, you can safely omit the root element in the JSON/XML parameter. The parameters will be cloned and wrapped in the key according to your controller’s name by default. So the above parameter can be written as:

<span style="font-family: DejaVu Sans;">同样，如果你已经打开</span><tt>config.wrap_parameters</tt><span style="font-family: DejaVu Sans;"><tt>在你的</tt></span><tt>controller</tt><span style="font-family: DejaVu Sans;"><tt>中初始化或者调用</tt><tt></tt></span><tt>wrap_parameters</tt><span style="font-family: DejaVu Sans;"><tt>，在</tt></span><tt>JSON/XML</tt><span style="font-family: DejaVu Sans;"><tt>参数中你可以安全的忽略</tt></span><tt>root</tt><tt> </tt><tt>element</tt><span style="font-family: DejaVu Sans;"><tt>。参数将会克隆和包装在</tt></span><tt>key</tt><span style="font-family: DejaVu Sans;"><tt>默认会依照你的</tt></span><tt>controller</tt><span style="font-family: DejaVu Sans;"><tt>的</tt></span><tt>name</tt><span style="font-family: DejaVu Sans;"><tt>。因此完整的参数可以这样写：</tt></span>
<pre><tt>{</tt><tt> </tt><tt>"name":</tt><tt> </tt><tt>"acme",</tt><tt> </tt><tt>"address":</tt><tt> </tt><tt>"123</tt><tt> </tt><tt>Carrot</tt><tt> </tt><tt>Street"</tt><tt> </tt><tt>}</tt></pre>
<tt>And</tt><tt> </tt><tt>assume</tt><span style="font-family: DejaVu Sans;"><tt>假设</tt><tt></tt></span><tt>that</tt><tt> </tt><tt>you</tt><tt>’</tt><tt>re</tt><tt> </tt><tt>sending</tt><tt> </tt><tt>the</tt><tt> </tt><tt>data</tt><tt> </tt><tt>to</tt><tt> </tt><tt>CompaniesController,</tt><tt> </tt><tt>it</tt><tt> </tt><tt>would</tt><tt> </tt><tt>then</tt><tt> </tt><tt>be</tt><tt> </tt><tt>wrapped</tt><tt> </tt><tt>in</tt><tt> </tt><tt>:company</tt><tt> </tt><tt>key</tt><tt> </tt><tt>like</tt><tt> </tt><tt>this:</tt>

{ :name =&gt; "acme", :address =&gt; "123 Carrot Street", :company =&gt; { :name =&gt; "acme", :address =&gt; "123 Carrot Street" }}

You can customize the name of the key or specific parameters you want to wrap by consulting the <span style="color: #000080;"><span style="text-decoration: underline;"><a href="http://api.rubyonrails.org/classes/ActionController/ParamsWrapper.html">API</a></span></span><span style="color: #000080;"><span style="text-decoration: underline;"><a href="http://api.rubyonrails.org/classes/ActionController/ParamsWrapper.html">documentation</a></span></span>
<h4><a name="routing-parameters"></a>3.3 Routing Parameters</h4>
The <tt>params</tt> hash will always contain the <tt>:controller</tt> and <tt>:action</tt> keys, but you should use the methods <tt>controller_name</tt> and <tt>action_name</tt> instead to access these values. Any other parameters defined by the routing, such as <tt>:id</tt> will also be available. As an example, consider a listing of clients where the list can show either active or inactive clients. We can add a route which captures the <tt>:status</tt> parameter in a “pretty” URL:

params hash<span style="font-family: DejaVu Sans;">字典总会包含关键字</span><tt>:controller</tt> and <tt>:action</tt><span style="font-family: DejaVu Sans;"><tt>，但是你应该使用方法</tt><tt></tt></span><tt>controller_name</tt><tt> </tt><tt>and</tt><tt> </tt><tt>action_name</tt><span style="font-family: DejaVu Sans;"><tt>作为替代访问这些值。也有一些其他的值被</tt></span><tt>routing</tt><span style="font-family: DejaVu Sans;"><tt>定义，例如</tt></span><tt>:id</tt><span style="font-family: DejaVu Sans;"><tt>也是可以的。例如，思考一个</tt></span><tt>clients</tt><span style="font-family: DejaVu Sans;"><tt>的列表能够显示</tt></span><tt>active</tt><span style="font-family: DejaVu Sans;"><tt>或者</tt></span><tt>inactive</tt><tt> </tt><tt>client</tt><span style="font-family: DejaVu Sans;"><tt>。我们可以添加一个</tt></span><tt>route</tt><span style="font-family: DejaVu Sans;"><tt>它会捕获在</tt><tt></tt></span><tt>a</tt><tt> “</tt><tt>pretty</tt><tt>” </tt><tt>URL</tt><span style="font-family: DejaVu Sans;"><tt>（一个漂亮的</tt></span><tt>URL</tt><span style="font-family: DejaVu Sans;"><tt>）中的</tt></span><tt>:status</tt><span style="font-family: DejaVu Sans;"><tt>参数：</tt></span>

match '/clients/:status' =&gt; 'clients#index', :foo =&gt; "bar"

In this case, when a user opens the URL <tt>/clients/active</tt>, <tt>params[:status]</tt> will be set to “active”. When this route is used, <tt>params[:foo]</tt> will also be set to “bar” <strong>just</strong><strong> </strong><strong>like</strong><strong> </strong><strong>it</strong><strong> </strong><strong>was</strong><strong> </strong><strong>passed</strong><strong> </strong><strong>in</strong><strong> </strong><strong>the</strong><strong> </strong><strong>query</strong><strong> </strong><strong>string.</strong><strong> </strong>In the same way <tt>params[:action]</tt> will contain “index”.
<h4><a name="default_url_options"></a>3.4 <tt>default_url_options</tt></h4>
You can set global default parameters that will be used <strong>when</strong><strong> </strong><strong>generating</strong><strong> </strong><strong>URLs</strong><strong> </strong><strong>with</strong><strong> </strong><tt><strong>default_url_options</strong></tt>. To do this, define a method with that name in your controller:

class ApplicationController &lt; ActionController::Base

# The options parameter is the hash passed in to 'url_for'

def default_url_options(options)

{:locale =&gt; I18n.locale}

end

end

These options will be used as a starting-point when generating URLs, so it’s possible they’ll be overridden by <tt>url_for</tt>. Because this method is defined in the controller, you can define it on <tt>ApplicationController</tt> so it would be used for all URL generation, or you could define it on only one controller for all URLs generated there.
<h3><a name="session"></a>4 Session<span style="font-family: WenQuanYi Micro Hei;">会话</span></h3>
Your application has a session for each user in which you can store small amounts of data that will be persisted between requests. <strong>The</strong><strong> </strong><strong>session</strong><strong> </strong><strong>is</strong><strong> </strong><strong>only</strong><strong> </strong><strong>available</strong><strong> </strong><strong>in</strong><strong> </strong><strong>the</strong><strong> </strong><strong>controller</strong><strong> </strong><strong>and</strong><strong> </strong><strong>the</strong><strong> </strong><strong>view</strong><strong> </strong><strong>and</strong><strong> </strong><strong>can</strong><strong> </strong><strong>use</strong><strong> </strong><strong>one</strong><strong> </strong><strong>of</strong><strong> </strong><strong>a</strong><strong> </strong><strong>number</strong><strong> </strong><strong>of</strong><strong> </strong><strong>different</strong><strong> </strong><strong>storage</strong><strong> </strong><strong>mechanisms</strong>:

<span style="font-family: DejaVu Sans;">你的应用程序对每一位用户都有一个会话通过它你可以存储少量的数据这会将</span>request<span style="font-family: DejaVu Sans;">区分开来。</span>
<ul>
	<li>CookieStore – Stores everything on the client.</li>
	<li>DRbStore – Stores the data on a DRb server.</li>
	<li>MemCacheStore – Stores the data in a memcache.</li>
	<li>ActiveRecordStore – Stores the data in a database using Active Record.</li>
</ul>
All session stores use a cookie to store a unique ID for each session (you must use a cookie, Rails will not allow you to pass the session ID in the URL as this is less secure).

<span style="font-family: DejaVu Sans;">每个会话使用一个</span>cookie<span style="font-family: DejaVu Sans;">存储并且每个会话都有一个独特的</span>ID<span style="font-family: DejaVu Sans;">（你必须使用一个</span>cookie<span style="font-family: DejaVu Sans;">，</span>Rails<span style="font-family: DejaVu Sans;">不允许你在</span>URL<span style="font-family: DejaVu Sans;">中传送会话</span>ID<span style="font-family: DejaVu Sans;">因为这样不安全）。</span>

For most stores this ID is used to look up the session data on the server, e.g. in a database table. There is one exception, and that is the default and recommended session store – the CookieStore – which stores all session data in the cookie itself (the ID is still available to you if you need it). This has the advantage of being very lightweight and it requires zero setup in a new application in order to use the session. The cookie data is cryptographically signed to make it tamper-proof, but it is not encrypted, so anyone with access to it can read its contents but not edit it (Rails will not accept it if it has been edited).

<a name="result_box"></a><span style="font-family: DejaVu Sans;">大多数（时候）存储这个</span>ID<span style="font-family: DejaVu Sans;">是用来在</span>server<span style="font-family: DejaVu Sans;">上面查找</span>session data<span style="font-family: DejaVu Sans;">，例如，存放在一个数据库</span>table<span style="font-family: DejaVu Sans;">中。这里有一个例外，并且这是默认以及推荐的</span>session<span style="font-family: DejaVu Sans;">存储</span>-CookieStore-<span style="font-family: DejaVu Sans;">它存储所有的</span>session<span style="font-family: DejaVu Sans;">数据在它的</span>cookie<span style="font-family: DejaVu Sans;">中（如果你需要</span>ID<span style="font-family: DejaVu Sans;">同样是可用的）。这里的优势是十分轻量级并且在一个新应用程序中使用</span>session<span style="font-family: DejaVu Sans;">是零安装。</span>cookie<span style="font-family: DejaVu Sans;">数据以加密签名的方式以防篡改，但是它没有将内容译成迷文，因此任何人访问它都可以阅读它的内容但是不能编辑它（</span>Rails<span style="font-family: DejaVu Sans;">将不会接受被编辑过的</span>cookie<span style="font-family: DejaVu Sans;">）。</span>

<strong>The</strong><strong> </strong><strong>CookieStore</strong><strong> </strong><strong>can</strong><strong> </strong><strong>store</strong><strong> </strong><strong>around</strong><strong> </strong><strong>4kB</strong><strong> </strong><strong>of</strong><strong> </strong><strong>data</strong><strong> — </strong><strong>much</strong><strong> </strong><strong>less</strong><strong> </strong><strong>than</strong><strong> </strong><strong>the</strong><strong> </strong><strong>others</strong><strong> — </strong><strong>but</strong><strong> </strong><strong>this</strong><strong> </strong><strong>is</strong><strong> </strong><strong>usually</strong><strong> </strong><strong>enough.</strong><strong> </strong>Storing large amounts of data in the session is discouraged no matter which session store your application uses. You should especially avoid storing complex objects (anything other than basic Ruby objects, the most common example being model instances) in the session, as the server might not be able to reassemble them between requests, which will result in an error.

CookieStore<span style="font-family: DejaVu Sans;">能够存储大约</span>4KB<span style="font-family: DejaVu Sans;">的数据<span style="font-family: Liberation Serif,Times New Roman,serif;">——</span>远少于其他<span style="font-family: Liberation Serif,Times New Roman,serif;">——</span>但是这通常足够。在你应用程序使用的</span>session<span style="font-family: DejaVu Sans;">中，存储大量的数据是无比泄气的。你应该尤其避免存储复杂的对象（任何其他的</span>Ruby<span style="font-family: DejaVu Sans;">基本对象，最普遍的例子是</span>model<span style="font-family: DejaVu Sans;">实例）在</span>session<span style="font-family: DejaVu Sans;">，因为</span>server<span style="font-family: DejaVu Sans;">可能不能在不同的请求间重组它们，结果它将得到错误。</span>

Read more about session storage in the <span style="color: #000080;"><span style="text-decoration: underline;"><a href="http://guides.rubyonrails.org/security.html">Security</a></span></span><span style="color: #000080;"><span style="text-decoration: underline;"><a href="http://guides.rubyonrails.org/security.html">Guide</a></span></span>.

If you need a different session storage mechanism, you can change it in the <tt>config/initializers/session_store.rb</tt> file:

<span style="font-family: DejaVu Sans;">如果你需要一个不同的</span>session<span style="font-family: DejaVu Sans;">存储机制，你可以在这里更改</span><tt>config/initializers/session_store.rb</tt><span style="font-family: DejaVu Sans;"><tt>：</tt></span>

# Use the database for sessions instead of the cookie-based default,

# which shouldn't be used to store highly confidential information

# (create the session table with "script/rails g session_migration")

# YourApp::Application.config.session_store :active_record_store

Rails sets up a session key (the name of the cookie) when signing the session data. These can also be changed in <tt>config/initializers/session_store.rb</tt>:

Rails<span style="font-family: DejaVu Sans;">当注册</span>session data<span style="font-family: DejaVu Sans;">的时候会设置一个</span>session key(cookie<span style="font-family: DejaVu Sans;">的名字</span>)<span style="font-family: DejaVu Sans;">。也可以在这里修改</span><tt>config/initializers/session_store.rb</tt><span style="font-family: DejaVu Sans;"><tt>：</tt></span>

# Be sure to restart your server when you modify this file.

&nbsp;

YourApp::Application.config.session_store :cookie_store, :key =&gt; '_your_app_session'

You can also pass a <tt>:domain</tt> key and specify the domain name for the cookie:

<span style="font-family: DejaVu Sans;">你也可以通过一个</span>:domain<span style="font-family: DejaVu Sans;">关键字指定</span>cookie<span style="font-family: DejaVu Sans;">的域名：</span>

# Be sure to restart your server when you modify this file.

&nbsp;

YourApp::Application.config.session_store :cookie_store, :key =&gt; '_your_app_session', :domain =&gt; ".example.com"

Rails sets up (for the CookieStore) a secret key<span style="font-family: DejaVu Sans;">密钥</span>used for signing the session data. This can be changed in <tt>config/initializers/secret_token.rb</tt>

# Be sure to restart your server when you modify this file.

&nbsp;

# Your secret key for verifying the integrity of signed cookies.

# If you change this key, all old signed cookies will become invalid!

# Make sure the secret is at least 30 characters and all random,

# no regular words or you'll be exposed to dictionary attacks.

YourApp::Application.config.secret_token = '49d3f3de9ed86c74b94ad6bd0...'

Changing the secret when using the <tt>CookieStore</tt> will invalidate<span style="font-family: DejaVu Sans;">废除</span>all existing sessions.

<span style="font-family: DejaVu Sans;">当使用</span>CookieStore<span style="font-family: DejaVu Sans;">的时候改变密钥将会废除所有存在的</span>sessions<span style="font-family: DejaVu Sans;">。</span>
<h4><a name="accessing-the-session"></a>4.1 Accessing the Session</h4>
In your controller you can access the session through the <tt>session</tt> instance method.

<span style="font-family: DejaVu Sans;">在你的</span>controller<span style="font-family: DejaVu Sans;">你可以访问</span>session<span style="font-family: DejaVu Sans;">通过</span>session<span style="font-family: DejaVu Sans;">实例方法。</span>

<strong>Sessions</strong><strong> </strong><strong>are</strong><strong> </strong><strong>lazily</strong><strong> </strong><strong>loaded.</strong><strong> </strong><strong>If</strong><strong> </strong><strong>you</strong><strong> </strong><strong>don</strong><strong>’</strong><strong>t</strong><strong> </strong><strong>access</strong><strong> </strong><strong>sessions</strong><strong> </strong><strong>in</strong><strong> </strong><strong>your</strong><strong> </strong><strong>action</strong><strong>’</strong><strong>s</strong><strong> </strong><strong>code,</strong><strong> </strong><strong>they</strong><strong> </strong><strong>will</strong><strong> </strong><strong>not</strong><strong> </strong><strong>be</strong><strong> </strong><strong>loaded.</strong> Hence<span style="font-family: DejaVu Sans;">因此</span>you will never need to disable sessions, just not accessing them will do the job.

Session values are stored using key/value pairs like a hash:

session<span style="font-family: DejaVu Sans;">的值使用</span>key/value<span style="font-family: DejaVu Sans;">对存储就像一个</span>hash<span style="font-family: DejaVu Sans;">字典：</span>

class ApplicationController &lt; ActionController::Base

&nbsp;

private

&nbsp;

# Finds the User with the ID stored in the session with the key

# :current_user_id This is a common way to handle user login in

# a Rails application; logging in sets the session value and

# logging out removes it.

def current_user

@_current_user ||= session[:current_user_id] &amp;&amp;

User.find_by_id(session[:current_user_id])

end

end

To store something in the session, just assign it to the key like a hash:

<span style="font-family: DejaVu Sans;">要存储一些信息在</span>session<span style="font-family: DejaVu Sans;">中，仅仅需要将其指派给</span>key<span style="font-family: DejaVu Sans;">就像一个</span>hash<span style="font-family: DejaVu Sans;">字典一样：</span>

class LoginsController &lt; ApplicationController

# "Create" a login, aka "log the user in"

def create

if user = User.authenticate(params[:username], params[:password])

# Save the user ID in the session so it can be used in

# subsequent requests

session[:current_user_id] = user.id

redirect_to root_url

end

end

end

To remove something from the session, assign that key to be <tt>nil</tt>:

<span style="font-family: DejaVu Sans;">从</span>session<span style="font-family: DejaVu Sans;">从移除一些信息，分派那个</span>key<span style="font-family: DejaVu Sans;">为</span>nil<span style="font-family: DejaVu Sans;">：</span>

class LoginsController &lt; ApplicationController

# "Delete" a login, aka "log the user out"

def destroy

# Remove the user id from the session

@_current_user = session[:current_user_id] = nil

redirect_to root_url

end

end

To reset the entire session, use <tt> </tt><tt>reset_session</tt>.<span style="font-family: DejaVu Sans;">从值整个</span>session<span style="font-family: DejaVu Sans;">，使用</span><tt>reset_session</tt><span style="font-family: DejaVu Sans;"><tt>。</tt></span>
<h4><a name="the-flash"></a>4.2 The Flash</h4>
The flash is a special part of the session which is cleared with each request. This means that values stored there will only be available in the next request, which is useful for storing error messages etc. It is accessed in much the same way as the session, like a hash. Let’s use the act of logging out as an example. The controller can send a message which will be displayed to the user on the next request:

flash<span style="font-family: DejaVu Sans;">在</span>session<span style="font-family: DejaVu Sans;">中是一个特殊的部分它它清楚于每个（下一次）请求。这里的意思是存储的值仅仅在下一个请求中是可用的，这在存储错误信息等是非常有用的。它的访问方式与</span>session<span style="font-family: DejaVu Sans;">的访问方式有着很大的相同之处，就像（访问）一个</span>hash<span style="font-family: DejaVu Sans;">字典那样。让我们使用登出动作作为一个例子。</span>controller<span style="font-family: DejaVu Sans;">会发送一个消息这个消息在下一个请求的时候将会显示给用户：</span>

class LoginsController &lt; ApplicationController

def destroy

session[:current_user_id] = nil

flash[:notice] = "You have successfully logged out"

redirect_to root_url

end

end

Note it is also possible to assign a flash message as part of the redirection.

redirect_to root_url, :notice =&gt; "You have successfully logged out"

The <tt>destroy</tt> action redirects to the application’s <tt>root_url</tt>, where the message will be displayed. Note that it’s entirely up to the next action to decide what, if anything, it will do with what the previous action put in the flash. It’s conventional to display eventual errors or notices from the flash in the application’s layout:

<tt>destroy</tt><span style="font-family: DejaVu Sans;"><tt>动作重定向到应用程序的</tt></span><tt>root_url,</tt><span style="font-family: DejaVu Sans;"><tt>在这里消息（刚添加的）将会被显示。注意：它完全取决于</tt></span><tt>next</tt><tt> </tt><tt>action</tt><span style="font-family: DejaVu Sans;"><tt>来决定做什么，如果有（</tt></span><tt>next</tt><tt> </tt><tt>action</tt><span style="font-family: DejaVu Sans;"><tt>），它将会完成</tt></span><tt>previous</tt><tt> </tt><tt>action</tt><span style="font-family: DejaVu Sans;"><tt>放入</tt></span><tt>flash</tt><span style="font-family: DejaVu Sans;"><tt>中的信息。</tt></span>

&lt;html&gt;

&lt;!-- &lt;head/&gt; --&gt;

&lt;body&gt;

&lt;% if flash[:notice] %&gt;

&lt;p&gt;&lt;%= flash[:notice] %&gt;&lt;/p&gt;

&lt;% end %&gt;

&lt;% if flash[:error] %&gt;

&lt;p&gt;&lt;%= flash[:error] %&gt;&lt;/p&gt;

&lt;% end %&gt;

&lt;!-- more content --&gt;

&lt;/body&gt;

&lt;/html&gt;

This way, if an action sets an error or a notice message, the layout will display it automatically<span style="font-family: DejaVu Sans;">。</span>

<span style="font-family: DejaVu Sans;">通过这种方式，如果</span>action<span style="font-family: DejaVu Sans;">设定一条</span>error<span style="font-family: DejaVu Sans;">或者通知消息，</span>laout<span style="font-family: DejaVu Sans;">将会自动的显示它。</span>

If you want a flash value to be carried over to another request, use the <tt>keep</tt> method:

<span style="font-family: DejaVu Sans;">如果你想一个</span>flash<span style="font-family: DejaVu Sans;">值转接到另一个</span>request<span style="font-family: DejaVu Sans;">，使用</span>keep<span style="font-family: DejaVu Sans;">方法：</span>

class MainController &lt; ApplicationController

# Let's say this action corresponds to root_url, but you want

# all requests here to be redirected to UsersController#index.

# If an action sets the flash and redirects here, the values

# would normally be lost when another redirect happens, but you

# can use 'keep' to make it persist for another request.

def index

# Will persist all flash values.

flash.keep

&nbsp;

# You can also use a key to keep only some kind of value.

# flash.keep(:notice)

redirect_to users_url

end

end
<h5><a name="flash-now"></a>4.2.1 <tt>flash.now</tt></h5>
By default, adding values to the flash will make them available to the next request, but sometimes you may want to access those values in the same request. For example, if the <tt>create</tt> action fails to save a resource and you render the <tt>new</tt> template directly, that’s not going to result in a new request, but you may still want to display a message using the flash. To do this, you can use <tt>flash.now</tt> in the same way you use the normal <tt>flash</tt>:

<span style="font-family: DejaVu Sans;">默认情况，添加到</span>flash<span style="font-family: DejaVu Sans;">中的值在</span>next request<span style="font-family: DejaVu Sans;">中是可用的，但是有时你可以想在同样的</span>request<span style="font-family: DejaVu Sans;">中访问这些值。例如，如果</span><tt>create</tt><tt> </tt><tt>action</tt><span style="font-family: DejaVu Sans;"><tt>保存</tt></span><tt>resource</tt><span style="font-family: DejaVu Sans;"><tt>失败并且你直接</tt></span><tt>render</tt><tt> </tt><tt>new</tt><tt> </tt><tt>template</tt><span style="font-family: DejaVu Sans;"><tt>，这样在一个</tt></span><tt>new</tt><span style="font-family: DejaVu Sans;"><tt>的</tt></span><tt>request</tt><span style="font-family: DejaVu Sans;"><tt>中没有得到</tt></span><tt>result</tt><span style="font-family: DejaVu Sans;"><tt>，但是你仍然希望使用</tt></span><tt>flash</tt><span style="font-family: DejaVu Sans;"><tt>显示消息。这样做，你可以就像使用</tt></span><tt>flash</tt><span style="font-family: DejaVu Sans;"><tt>那样使用</tt><tt></tt></span><tt>flash.now</tt><span style="font-family: DejaVu Sans;"><tt>：</tt></span>

class ClientsController &lt; ApplicationController

def create

@client = Client.new(params[:client])

if @client.save

# ...

else

flash.now[:error] = "Could not save client"

render :action =&gt; "new"

end

end

end
<h3><a name="cookies"></a>5 Cookies</h3>
Your application can store small amounts of data on the client — called cookies — that will be persisted across requests and even sessions. Rails provides easy access to cookies via the <tt>cookies</tt> method, which — much like the <tt>session</tt> — works like a hash:

<span style="font-family: DejaVu Sans;">你的应用程序可以存储少量</span>data<span style="font-family: DejaVu Sans;">在</span>client<span style="font-family: DejaVu Sans;">上<span style="font-family: Liberation Serif,Times New Roman,serif;">——</span>它被称之为</span>cookies——<span style="font-family: DejaVu Sans;">它会保持访问的请求以及曾经</span>sessions<span style="font-family: DejaVu Sans;">。</span>Rails<span style="font-family: DejaVu Sans;">提供简单的方式来访问</span>cookies<span style="font-family: DejaVu Sans;">通过</span>cookies<span style="font-family: DejaVu Sans;">方法，就像</span>session——<span style="font-family: DejaVu Sans;">一</span>hash<span style="font-family: DejaVu Sans;">字典那样工作（存储</span>data<span style="font-family: DejaVu Sans;">）：</span>

class CommentsController &lt; ApplicationController

def new

# Auto-fill the commenter's name if it has been stored in a cookie

@comment = Comment.new(:name =&gt; cookies[:commenter_name])

end

&nbsp;

def create

@comment = Comment.new(params[:comment])

if @comment.save

flash[:notice] = "Thanks for your comment!"

if params[:remember_name]#:remember_name<span style="font-family: DejaVu Sans;">这里相当于用户的的反馈是否记住</span>name

# Remember the commenter's name.

cookies[:commenter_name] = @comment.name

else

# Delete cookie for the commenter's name cookie, if any.

cookies.delete(:commenter_name)

end

redirect_to @comment.article

else

render :action =&gt; "new"

end

end

end

Note that while for session values you set the key to <tt>nil</tt>, to delete a cookie value you should use <tt>cookies.delete(:key)</tt>.
<h3><a name="rendering-xml-and-json-data"></a>6 Rendering xml and json data</h3>
ActionController makes it extremely easy to render <tt>xml</tt> or <tt>json</tt> data. If you generate a controller using scaffold then your controller would look something like this.

ActionController<span style="font-family: DejaVu Sans;">使得</span>render xml<span style="font-family: DejaVu Sans;">或者</span>json<span style="font-family: DejaVu Sans;">数据相当简单。如果你使用</span>scaffold<span style="font-family: DejaVu Sans;">创建一个</span>controller<span style="font-family: DejaVu Sans;">那么你的</span>controller<span style="font-family: DejaVu Sans;">看起来将会像这样：</span>

class UsersController &lt; ApplicationController

def index

@users = User.all

respond_to do |format|

format.html # index.html.erb

format.xml { render :xml =&gt; @users}

format.json { render :json =&gt; @users}

end

end

end

Notice that in the above case code is <tt>render</tt><tt> </tt><tt>:xml</tt><tt> </tt><tt>=&gt;</tt><tt> </tt><tt>@users</tt> and not <tt>render</tt><tt> </tt><tt>:xml</tt><tt> </tt><tt>=&gt;</tt><tt> </tt><tt>@users.to_xml</tt>. That is because if the input is not string then rails automatically invokes <tt>to_xml</tt> .

<span style="font-family: DejaVu Sans;">注意在</span>render<span style="font-family: DejaVu Sans;">中的完整示例代码是</span><tt>render</tt><tt> </tt><tt>:xml</tt><tt> </tt><tt>=&gt;</tt><tt> </tt><tt>@users</tt><span style="font-family: DejaVu Sans;"><tt>并不是</tt><tt></tt></span><tt>render</tt><tt> </tt><tt>:xml</tt><tt> </tt><tt>=&gt;</tt><tt> </tt><tt>@users.to_xml</tt><span style="font-family: DejaVu Sans;"><tt>，那是因为如果输入的不是</tt></span><tt>string</tt><span style="font-family: DejaVu Sans;"><tt>那么</tt></span><tt>rails</tt><span style="font-family: DejaVu Sans;"><tt>自动调用</tt></span><tt>to_xml</tt><span style="font-family: DejaVu Sans;"><tt>。</tt></span>
<h3><a name="filters"></a>7 Filters<span style="font-family: WenQuanYi Micro Hei;">过滤器</span></h3>
Filters are methods that are run before, after or “around” a controller action.

Filters<span style="font-family: DejaVu Sans;">是一个方法它运行在</span>controller action<span style="font-family: DejaVu Sans;">之前或者伴随着</span>controller action<span style="font-family: DejaVu Sans;">。</span>

Filters are inherited, so if you set a filter on <tt>ApplicationController</tt>, it will be run on every controller in your application.

Filters<span style="font-family: DejaVu Sans;">是可继承的，因此如果你在</span><tt>ApplicationController</tt><tt> </tt><span style="font-family: DejaVu Sans;">设置了一个</span>filter<span style="font-family: DejaVu Sans;">，他将会在你的应用程序的每个</span>controller<span style="font-family: DejaVu Sans;">中运行。</span>

Before filters may halt the request cycle. A common before filter is one which requires that a user is logged in for an action to be run. You can define the filter method this way:

<span style="font-family: DejaVu Sans;">在</span>filters<span style="font-family: DejaVu Sans;">之前可能会停止</span>request<span style="font-family: DejaVu Sans;">周期。一个通常情况在</span>filter<span style="font-family: DejaVu Sans;">之前的是用户</span>logged in<span style="font-family: DejaVu Sans;">的</span>requires<span style="font-family: DejaVu Sans;">使之对应的</span>action<span style="font-family: DejaVu Sans;">被运行。你可以这样定义</span>filter<span style="font-family: DejaVu Sans;">方法：</span>

class ApplicationController &lt; ActionController::Base

before_filter :require_login

&nbsp;

private

&nbsp;

def require_login

unless logged_in?

flash[:error] = "You must be logged in to access this section"

redirect_to new_login_url # halts request cycle

end

end

&nbsp;

# The logged_in? method simply returns true if the user is logged

# in and false otherwise. It does this by "booleanizing" the

# current_user method we created previously using a double ! operator.

# Note that this is not common in Ruby and is discouraged unless you

# really mean to convert something into true or false.

def logged_in?

!!current_user

end

end

The method simply stores an error message in the flash and redirects to the login form if the user is not logged in. If a before filter renders or redirects, the action will not run. If there are additional filters scheduled to run after that filter they are also cancelled.

<span style="font-family: DejaVu Sans;">这个方法简单的存储一个错误消息在</span>flash<span style="font-family: DejaVu Sans;">中并且重定向到</span>login<span style="font-family: DejaVu Sans;">表单如果用户没有登录。如果是一个在</span>filter<span style="font-family: DejaVu Sans;">之前的</span>renderes<span style="font-family: DejaVu Sans;">或者重定向，这个</span>action<span style="font-family: DejaVu Sans;">将不会运行。如果这里有额外附加的</span>filters<span style="font-family: DejaVu Sans;">计划运行并且在这个</span>filter<span style="font-family: DejaVu Sans;">之后，它们也将取消（执行）。</span>

In this example the filter is added to <tt><strong>ApplicationController</strong></tt> and thus all controllers in the application inherit it. This will make everything in the application <span style="color: #800000;">require</span><span style="color: #800000;">the</span><span style="color: #800000;">user</span><span style="color: #800000;">to</span><span style="color: #800000;">be</span><span style="color: #800000;">logged</span><span style="color: #800000;">in</span><span style="color: #800000;">in</span><span style="color: #800000;">order</span><span style="color: #800000;">to</span><span style="color: #800000;">use</span><span style="color: #800000;">it</span>. For obvious reasons (the user wouldn’t be able to log in in the first place!), not all controllers or actions should require this. You can prevent this filter from running before particular actions with <tt>skip_before_filter</tt>:

<span style="font-family: DejaVu Sans;">明显的原因（在第一次登录的时候不能登录），并不是所有的</span>controllers<span style="font-family: DejaVu Sans;">或者</span>actions<span style="font-family: DejaVu Sans;">需要登录，你可以使用</span><tt>skip_before_filter</tt><tt> </tt><span style="font-family: DejaVu Sans;">在部分</span>action<span style="font-family: DejaVu Sans;">运行之前阻止这个</span>filter<span style="font-family: DejaVu Sans;">：</span>

class LoginsController &lt; ApplicationController

skip_before_filter :require_login, :only =&gt; [:new, :create]

end

Now, the <tt>LoginsController</tt>’s <tt>new</tt> and <tt>create</tt> actions will work as before without requiring the user to be logged in. The <tt>:only</tt> option is used to only skip this filter for these actions, and there is also an <tt>:except</tt> option which works the other way. These options can be used when adding filters too, so you can add a filter which only runs for selected actions in the first place.

<span style="font-family: DejaVu Sans;">现在，</span><tt>LoginsController</tt><span style="font-family: DejaVu Sans;"><tt>的</tt></span><tt>new</tt><span style="font-family: DejaVu Sans;"><tt>和</tt></span><tt>create</tt><tt> </tt><tt>action</tt><span style="font-family: DejaVu Sans;"><tt>工作之前不再需要用户已经登录站点来。</tt></span><tt>:only</tt><span style="font-family: DejaVu Sans;"><tt>选项使用于仅仅在这些</tt></span><tt>action</tt><span style="font-family: DejaVu Sans;"><tt>中略过</tt></span><tt>filter</tt><span style="font-family: DejaVu Sans;"><tt>，同样这里也有</tt></span><tt>:except</tt><span style="font-family: DejaVu Sans;"><tt>选项一相反的方式工作。这些选项也可以在添加</tt></span><tt>filters</tt><span style="font-family: DejaVu Sans;"><tt>的时候使用，因此你可以添加一个</tt></span><tt>filter</tt><span style="font-family: DejaVu Sans;"><tt>其仅仅在选择的</tt></span><tt>action</tt><span style="font-family: DejaVu Sans;"><tt>第一次运行的时候执行（忽略）。</tt></span>
<h4><a name="after-filters-and-around-filters"></a>7.1 After Filters and Around Filters</h4>
In addition to before filters, you can also run filters after an action has been executed, or both before and after.

<span style="font-family: DejaVu Sans;">除了在</span>filters<span style="font-family: DejaVu Sans;">之前，你也可以在</span>action<span style="font-family: DejaVu Sans;">被执行之后运行</span>filters<span style="font-family: DejaVu Sans;">，或者在之前和过后都执行。</span>

After filters are similar to before filters, but because the action has already been run they have access to the response data that’s about to be sent to the client. Obviously, after filters cannot stop the action from running.

After filters<span style="font-family: DejaVu Sans;">（执行</span>action<span style="font-family: DejaVu Sans;">）和</span>before filters<span style="font-family: DejaVu Sans;">类似，但是因为</span>action<span style="font-family: DejaVu Sans;">已经被运行，这些</span>filter<span style="font-family: DejaVu Sans;">会访问</span>response data<span style="font-family: DejaVu Sans;">并且，</span>response data<span style="font-family: DejaVu Sans;">会全部发送给</span>client<span style="font-family: DejaVu Sans;">。明显的，</span>after filters<span style="font-family: DejaVu Sans;">不能够停止</span>action<span style="font-family: DejaVu Sans;">的运行。</span>

Around filters are responsible for running their associated actions by yielding, similar to how Rack middlewares work.

Around filters<span style="font-family: DejaVu Sans;">能够通过</span>yielding<span style="font-family: DejaVu Sans;">运行（</span>Around filters<span style="font-family: DejaVu Sans;">执行的</span>action<span style="font-family: DejaVu Sans;">的）关联的</span>action<span style="font-family: DejaVu Sans;">，类似于</span>Rack middlewares<span style="font-family: DejaVu Sans;">工作方式。</span>

For example, in a website where changes have an approval workflow an administrator could be able to preview them easily, just apply them within a transaction:

<span style="font-family: DejaVu Sans;">例如，在一个</span>website<span style="font-family: DejaVu Sans;">更改操作有一个批准工作流程，管理员可以很容易预览这些内容，仅仅在一个</span>transaction<span style="font-family: DejaVu Sans;">中就可以实现这个功能的应用：</span>

class ChangesController &lt; ActionController::Base

around_filter :wrap_in_transaction, :only =&gt; :show

&nbsp;

private

&nbsp;

def wrap_in_transaction

ActiveRecord::Base.transaction do

begin

yield

ensure

raise ActiveRecord::Rollback

end

end

end

end

Note that an around filter wraps also rendering. In particular, if in the example above the view itself reads from the database via a scope or whatever, it will do so within the transaction and thus present the data to preview.

<span style="font-family: DejaVu Sans;">注意</span>around filter<span style="font-family: DejaVu Sans;">同样也会</span>render<span style="font-family: DejaVu Sans;">。特别的是，如果在上述例子中，</span>view<span style="font-family: DejaVu Sans;">自己通过一个</span>scpoe<span style="font-family: DejaVu Sans;">或者其他从数据库中读取（数据），他将会在</span>transaction<span style="font-family: DejaVu Sans;">中实现</span>approval workflow<span style="font-family: DejaVu Sans;">并且将当前数据预览呈现。</span>

They can choose not to yield and build the response themselves, in which case the action is not run.

<span style="font-family: DejaVu Sans;">他们（</span>admin<span style="font-family: DejaVu Sans;">）可以选择不</span>yield<span style="font-family: DejaVu Sans;">并且建立他们自己的</span>response<span style="font-family: DejaVu Sans;">，这样（更改的）</span>action<span style="font-family: DejaVu Sans;">将不会运行。</span>
<h4><a name="other-ways-to-use-filters"></a>7.2 Other Ways to Use Filters <span style="font-family: WenQuanYi Micro Hei;">过滤器的其他使用方式</span></h4>
While the most common way to use filters is by creating private methods and using *_filter to add them, there are two other ways to do the same thing.

<span style="font-family: DejaVu Sans;">即使通常使用过滤器的方式是创建私有的方法并且使用</span>*_filter<span style="font-family: DejaVu Sans;">（</span>around_filter :wrap_in_transaction, :only =&gt; :show<span style="font-family: DejaVu Sans;">）来添加他们，这里有两种其他的方法来做同样的事情。</span>

The first is to use a block directly with the *_filter methods. The block receives the controller as an argument, and the <tt>require_login</tt> filter from above could be rewritten to use a block:

<span style="font-family: DejaVu Sans;">第一种方法是使用一个</span>*_filter methods<span style="font-family: DejaVu Sans;">的</span>block<span style="font-family: DejaVu Sans;">（块）。这个</span>block<span style="font-family: DejaVu Sans;">接收</span>controller<span style="font-family: DejaVu Sans;">为一个参数，，并且从</span>above<span style="font-family: DejaVu Sans;">（上下文中的上文）</span>could be rewritten to use a block<span style="font-family: DejaVu Sans;">：</span><strong>#</strong><span style="font-family: DejaVu Sans;"><strong>这个例子中也是第一次登录无法完成，没有忽略登录</strong></span><strong>action</strong><span style="font-family: DejaVu Sans;"><strong>。</strong></span>

class ApplicationController &lt; ActionController::Base

before_filter do |controller|

redirect_to new_login_url unless controller.send(:logged_in?)

end

end

Note that the filter in this case uses <tt>send</tt> because the <tt>logged_in?</tt> method is private and the filter is not run in the scope of the controller. This is not the recommended way to implement this particular filter, but in more simple cases it might be useful.

<span style="font-family: DejaVu Sans;">注意这个例子中的</span>filter<span style="font-family: DejaVu Sans;">使用的是</span>send<span style="font-family: DejaVu Sans;">因为</span><tt>logged_in?</tt><span style="font-family: DejaVu Sans;"><tt>方法是私有的并且</tt></span><tt>filter</tt><span style="font-family: DejaVu Sans;"><tt>并不在</tt></span><tt>controller</tt><span style="font-family: DejaVu Sans;"><tt>的范围内运行。这里并不是实施这个特别的</tt></span><tt>filter</tt><span style="font-family: DejaVu Sans;"><tt>的推荐的方式，但是在很多简单的情况下这可能会有用。</tt></span>

<tt>The</tt><tt> </tt><tt>second</tt><tt> </tt><tt>way</tt><tt> </tt><tt>is</tt><tt> </tt><tt>to</tt><tt> </tt><tt>use</tt><tt> </tt><tt>a</tt><tt> </tt><tt>class</tt><tt> </tt><tt>(actually,</tt><tt> </tt><tt>any</tt><tt> </tt><tt>object</tt><tt> </tt><tt>that</tt><tt> </tt><tt>responds</tt><tt> </tt><tt>to</tt><tt> </tt><tt>the</tt><tt> </tt><tt>right</tt><tt> </tt><tt>methods</tt><tt> </tt><tt>will</tt><tt> </tt><tt>do)</tt><tt> </tt><tt>to</tt><tt> </tt><tt>handle</tt><tt> </tt><tt>the</tt><tt> </tt><tt>filtering.</tt><tt> </tt><tt>This</tt><tt> </tt><tt>is</tt><tt> </tt><tt>useful</tt><tt> </tt><tt>in</tt><tt> </tt><tt>cases</tt><tt> </tt><tt>that</tt><tt> </tt><tt>are</tt><tt> </tt><tt>more</tt><tt> </tt><tt>complex</tt><tt> </tt><tt>and</tt><tt> </tt><tt>can</tt><tt> </tt><tt>not</tt><tt> </tt><tt>be</tt><tt> </tt><tt>implemented</tt><tt> </tt><tt>in</tt><tt> </tt><tt>a</tt><tt> </tt><tt>readable</tt><tt> </tt><tt>and</tt><tt> </tt><tt>reusable</tt><tt> </tt><tt>way</tt><tt> </tt><tt>using</tt><tt> </tt><tt>the</tt><tt> </tt><tt>two</tt><tt> </tt><tt>other</tt><tt> </tt><tt>methods.</tt><tt> </tt><tt>As</tt><tt> </tt><tt>an</tt><tt> </tt><tt>example,</tt><tt> </tt><tt>you</tt><tt> </tt><tt>could</tt><tt> </tt><tt>rewrite</tt><tt> </tt><tt>the</tt><tt> </tt><tt>login</tt><tt> </tt><tt>filter</tt><tt> </tt><tt>again</tt><tt> </tt><tt>to</tt><tt> </tt><tt>use</tt><tt> </tt><tt>a</tt><tt> </tt><tt>class:</tt>

<span style="font-family: DejaVu Sans;">第二种方式是使用一个</span>class<span style="font-family: DejaVu Sans;">（实际上，<tt>响应正确方法的任何对象都是可以的</tt>）来处理</span>filtering<span style="font-family: DejaVu Sans;">。这在非常复杂的情况下，在只读不能</span><tt>implemented</tt><span style="font-family: DejaVu Sans;">，重复使用两种其他方法是非常有用的。在例子中，你可以使用一个</span>class<span style="font-family: DejaVu Sans;">来再次重写</span>login filter<span style="font-family: DejaVu Sans;">：</span>

class ApplicationController &lt; ActionController::Base

before_filter LoginFilter

end

&nbsp;

class LoginFilter

def self.filter(controller)

unless controller.send(:logged_in?)

controller.flash[:error] = "You must be logged in"

controller.redirect_to controller.new_login_url

end

end

end

Again, this is not an ideal example for this filter, because it’s not run in the scope of the controller but gets the controller passed as an argument. The filter class has a class method <tt>filter</tt> which gets run before or after the action, depending on if it’s a before or after filter. Classes used as around filters can also use the same <tt>filter</tt> method, which will get run in the same way. The method must <tt>yield</tt> to execute the action. Alternatively, it can have both a <tt>before</tt> and an <tt>after</tt> method that are run before and after the action.

<span style="font-family: DejaVu Sans;">同样的，对于这种</span>filter<span style="font-family: DejaVu Sans;">这不是一个（好）主意，因为它在</span>controller<span style="font-family: DejaVu Sans;">的范围中不会运行但是获取</span>controller<span style="font-family: DejaVu Sans;">为一个参数。</span>filter <span style="font-family: DejaVu Sans;">类有一个类方法</span>filter<span style="font-family: DejaVu Sans;">，它在</span>before<span style="font-family: DejaVu Sans;">或者</span>after action<span style="font-family: DejaVu Sans;">运行，这依赖于它是一个</span>before<span style="font-family: DejaVu Sans;">还是</span>after filter<span style="font-family: DejaVu Sans;">。使用</span>around filters<span style="font-family: DejaVu Sans;">的类同样也可以使用</span>filter <span style="font-family: DejaVu Sans;">方法，其也会以相同的方式运行。（</span>filter<span style="font-family: DejaVu Sans;">）方法必须</span>yield to <span style="font-family: DejaVu Sans;">执行的</span>action<span style="font-family: DejaVu Sans;">。另外，它也可以同时有</span>before<span style="font-family: DejaVu Sans;">和</span>after<span style="font-family: DejaVu Sans;">方法在</span>before <span style="font-family: DejaVu Sans;">和</span>after action<span style="font-family: DejaVu Sans;">中运行。</span>
<h3><a name="request-forgery-protection"></a>8 Request Forgery Protection<span style="font-family: WenQuanYi Micro Hei;">伪造请求保护</span></h3>
Cross-site request forgery is a type of attack in which a site tricks a user into making requests on another site, possibly adding, modifying or deleting data on that site without the user’s knowledge or permission.

<span style="font-family: DejaVu Sans;">跨站伪造请求是一种典型的攻击方式，在这种攻击方式中，一个网站诱骗用户发送请求到另一个网站，可能在这个站点中添加，修改或者删除数据并没有用户的信息或者权限。</span>

The first step to avoid this is to make sure all “destructive” actions (create, update and destroy) can only be accessed with non-GET requests. If you’re following RESTful conventions you’re already doing this. However, a malicious site can still send a non-GET request to your site quite easily, and that’s where the request forgery protection comes in. As the name says, it protects from forged requests.

<span style="font-family: DejaVu Sans;">避免这样的事情发生的第一步是确保所有的<span style="font-family: Liberation Serif,Times New Roman,serif;"> “</span></span>destructive”<span style="font-family: DejaVu Sans;">（破坏性）</span>actions(create, update and destroy)<span style="font-family: DejaVu Sans;">只能接受</span>non-GET<span style="font-family: DejaVu Sans;">请求。如果你遵循</span>RESTful<span style="font-family: DejaVu Sans;">公约你已经这样做了。然而，一个恶意的网站仍然可以轻易的发送一个</span>non-GET<span style="font-family: DejaVu Sans;">请求到你的站点，到这里就该伪造请求保护（</span>request forgery protection<span style="font-family: DejaVu Sans;">）出场了。正如名字所说，它防护伪造请求（对你站点的攻击）。</span>

If you generate a form like this:<span style="font-family: DejaVu Sans;">如果你像下面这样生成表单：</span>

&lt;%= form_for @user do |f| %&gt;

&lt;%= f.text_field :username %&gt;

&lt;%= f.text_field :password %&gt;

&lt;% end %&gt;

You will see how the token gets added as a hidden field:

<span style="font-family: DejaVu Sans;">你将会看到令牌是怎样作为一个</span>hidden field<span style="font-family: DejaVu Sans;">添加：</span>

&lt;form accept-charset="UTF-8" action="/users/1" method="post"&gt;

&lt;input type="hidden"

value="67250ab105eb5ad10851c00a5621854a23af5489"

name="authenticity_token"/&gt;

&lt;!-- fields --&gt;

&lt;/form&gt;

Rails adds this token to every form that’s generated using the <a href="http://guides.rubyonrails.org/form_helpers.html"><span style="color: #000080;"><span style="text-decoration: underline;">form</span></span><span style="color: #000080;"><span style="text-decoration: underline;">helpers</span></span></a>, so most of the time you don’t have to worry about it. If you’re writing a form manually or need to add the token for another reason, it’s available through the method <tt>form_authenticity_token</tt>:

Rails<span style="font-family: DejaVu Sans;">为每个使用</span>form helpers<span style="font-family: DejaVu Sans;">生成的</span>form<span style="font-family: DejaVu Sans;">添加这样的令牌。因此大多数时间你不需要担心这样的问题。如果你打算手动编写一个</span>form<span style="font-family: DejaVu Sans;">或者因为其他的原因需要添加令牌，这也是可以的通过</span><tt>form_authenticity_token</tt><span style="font-family: DejaVu Sans;"><tt>方法来实现：</tt></span>

<tt>form_authenticity_token</tt><span style="font-family: DejaVu Sans;"><tt>生成一个有效的认证令牌。这在</tt></span><tt>Rails</tt><span style="font-family: DejaVu Sans;"><tt>不会自动添加的地方非常有用，比如在定制</tt></span><tt>Ajax</tt><span style="font-family: DejaVu Sans;"><tt>调用的时候。</tt></span>

The <a href="http://guides.rubyonrails.org/security.html"><span style="color: #000080;"><span style="text-decoration: underline;">Security</span></span><span style="color: #000080;"><span style="text-decoration: underline;">Guide</span></span></a> has more about this and a lot of other security-related issues that you should be aware of when developing a web application.

<a href="http://guides.rubyonrails.org/security.html"><span style="color: #000080;"><span style="text-decoration: underline;">Security</span></span><span style="color: #000080;"><span style="text-decoration: underline;">Guide</span></span></a> <span style="font-family: DejaVu Sans;">有更多的关于这些以及许多其他安全相关的问题（的解决方法）你在开发一个</span>web application<span style="font-family: DejaVu Sans;">的时候应该保持清醒。</span>
<h3>9 The Request and Response Objects</h3>
In every controller there are two accessor methods pointing to the request and the response objects associated with the request cycle that is currently in execution. The <tt>request</tt> method contains an instance of <tt>AbstractRequest</tt> and the <tt>response</tt> method returns a response object representing what is going to be sent back to the client.

<span style="font-family: DejaVu Sans;">在每个</span>controller<span style="font-family: DejaVu Sans;">有两个指向与目前正在执行的请求周期相关的</span>request <span style="font-family: DejaVu Sans;">和</span>response <span style="font-family: DejaVu Sans;">对象的访问方法。</span>request<span style="font-family: DejaVu Sans;">方法包含一个</span><tt>AbstractRequest</tt><span style="font-family: DejaVu Sans;"><tt>的实例以及</tt><tt></tt></span><tt>response</tt><span style="font-family: DejaVu Sans;"><tt>方法返回一个</tt></span><tt>response</tt><span style="font-family: DejaVu Sans;"><tt>对象表示什么打算发送回</tt></span><tt>client</tt><span style="font-family: DejaVu Sans;"><tt>。</tt></span>
<h4><a name="the-request-object"></a>9.1 The <tt>request</tt> Object</h4>
The request object contains a lot of useful information about the request coming in from the client. To get a full list of the available methods, refer to the <a href="http://api.rubyonrails.org/classes/ActionDispatch/Request.html"><span style="color: #000080;"><span style="text-decoration: underline;">API</span></span><span style="color: #000080;"><span style="text-decoration: underline;">documentation</span></span></a>. Among the properties that you can access on this object are:

request<span style="font-family: DejaVu Sans;">对象包含很多来自发出请求的</span>client<span style="font-family: DejaVu Sans;">的有用信息。要得到可用方法的完整列表，参考</span><a href="http://api.rubyonrails.org/classes/ActionDispatch/Request.html"><span style="color: #000080;"><span style="text-decoration: underline;">API</span></span><span style="color: #000080;"><span style="text-decoration: underline;">documentation</span></span></a><span style="font-family: DejaVu Sans;">。其中你可以在这个对象中访问的属性有：</span>

&nbsp;
<table width="665" cellspacing="0" cellpadding="2"><colgroup><col width="194" /> <col width="463" /> </colgroup>
<tbody>
<tr>
<th width="194">Property of <tt>request</tt></th>
<th width="463">Purpose</th>
</tr>
<tr>
<td width="194">host</td>
<td width="463">The hostname used for this request.</td>
</tr>
<tr>
<td width="194">domain(n=2)</td>
<td width="463">The hostname’s first <tt>n</tt> segments, starting from the right (the TLD).</td>
</tr>
<tr>
<td width="194">format</td>
<td width="463">The content type requested by the client.</td>
</tr>
<tr>
<td width="194">method</td>
<td width="463">The HTTP method used for the request.</td>
</tr>
<tr>
<td width="194">get?, post?, put?, delete?, head?</td>
<td width="463">Returns true if the HTTP method is GET/POST/PUT/DELETE/HEAD.</td>
</tr>
<tr>
<td width="194">headers</td>
<td width="463">Returns a hash containing the headers associated with the request.</td>
</tr>
<tr>
<td width="194">port</td>
<td width="463">The port number (integer) used for the request.</td>
</tr>
<tr>
<td width="194">protocol</td>
<td width="463">Returns a string containing the protocol used plus “://”, for example “http://”.</td>
</tr>
<tr>
<td width="194">query_string</td>
<td width="463">The query string part of the URL, i.e., everything after “?”.</td>
</tr>
<tr>
<td width="194">remote_ip</td>
<td width="463">The IP address of the client.</td>
</tr>
<tr>
<td width="194">url</td>
<td width="463">The entire URL used for the request.</td>
</tr>
</tbody>
</table>
&nbsp;
<h5><a name="path_parameters-query_parameters-and-req"></a> 9.1.1 <tt>path_parameters</tt>, <tt>query_parameters</tt>, and <tt>request_parameters</tt></h5>
Rails collects all of the parameters sent along with the request in the <tt>params</tt> hash, whether they are sent as part of the query string or the post body. The request object has three accessors that give you access to these parameters depending on where they came from. The <tt>query_parameters</tt> hash contains parameters that were sent as part of the query string while the <tt>request_parameters</tt> hash contains parameters sent as part of the post body. The <tt>path_parameters</tt> hash contains parameters that were recognized by the routing as being part of the path leading to this particular controller and action.

Rails<span style="font-family: DejaVu Sans;">收集所有的</span>parameters<span style="font-family: DejaVu Sans;">于</span>params hash<span style="font-family: DejaVu Sans;">字典中于</span>request<span style="font-family: DejaVu Sans;">一起发送，无论是作为</span>query <span style="font-family: DejaVu Sans;">字符串的一部分发送还是在</span>post body<span style="font-family: DejaVu Sans;">中发送。</span>request<span style="font-family: DejaVu Sans;">有三个访问器提供给你访问这些参数这依赖于它来自哪里。</span><tt>query_parameters</tt><tt> </tt><tt>hash</tt><span style="font-family: DejaVu Sans;"><tt>字典包含作为查询字符串的一部分发送的参数，而</tt><tt></tt></span><tt>request_parameters</tt><span style="font-family: DejaVu Sans;"><tt>包含作为</tt></span><tt>post</tt><tt> </tt><tt>body</tt><span style="font-family: DejaVu Sans;"><tt>的一个部分发送的参数。</tt><tt></tt></span><tt>path_parameters</tt><tt> </tt><tt>hash</tt><span style="font-family: DejaVu Sans;"><tt>字典包含被</tt></span><tt>routing</tt><span style="font-family: DejaVu Sans;"><tt>组织作为指向特殊的</tt></span><tt>controller</tt><span style="font-family: DejaVu Sans;"><tt>和</tt></span><tt>action</tt><span style="font-family: DejaVu Sans;"><tt>的参数。</tt></span>
<h4><a name="the-response-object"></a>9.2 The <tt>response</tt> Object</h4>
The response object is not usually used directly, but is during the execution of the action and rendering of the data that is being sent back to the user, but sometimes – like in an after filter – it can be useful to access the response directly. Some of these accessor methods also have setters, allowing you to change their values.

response object<span style="font-family: DejaVu Sans;">通常并不直接使用，但是它在</span>action<span style="font-family: DejaVu Sans;">的执行与</span>rendering<span style="font-family: DejaVu Sans;">的数据被发送回给用户期间建立，但是有的时候——像在一个</span>after filter——<span style="font-family: DejaVu Sans;">它在直接访问</span>response<span style="font-family: DejaVu Sans;">（</span>object<span style="font-family: DejaVu Sans;">）会非常有用。这些访问器中的一些</span>methods<span style="font-family: DejaVu Sans;">也有</span>setters<span style="font-family: DejaVu Sans;">，允许你改变它们的值。</span>

&nbsp;
<table width="665" cellspacing="0" cellpadding="2"><colgroup><col width="146" /> <col width="511" /> </colgroup>
<tbody>
<tr>
<th width="146">Property of <tt>response</tt></th>
<th width="511">Purpose</th>
</tr>
<tr>
<td width="146">body</td>
<td width="511">This is the string of data being sent back to the client. This is most often HTML.</td>
</tr>
<tr>
<td width="146">status</td>
<td width="511">The HTTP status code for the response, like 200 for a successful request or 404 for file not found.</td>
</tr>
<tr>
<td width="146">location</td>
<td width="511">The URL the client is being redirected to, if any.</td>
</tr>
<tr>
<td width="146">content_type</td>
<td width="511">The content type of the response.</td>
</tr>
<tr>
<td width="146">charset</td>
<td width="511">The character set being used for the response. Default is “utf-8”.</td>
</tr>
<tr>
<td width="146">headers</td>
<td width="511">Headers used for the response.</td>
</tr>
</tbody>
</table>
&nbsp;
<h5><a name="setting-custom-headers"></a>9.2.1 Setting Custom Headers</h5>
If you want to set custom headers for a response then <tt>response.headers</tt> is the place to do it. The headers attribute is a hash which maps header names to their values, <strong>and Rails will set some of them automatically.</strong> If you want to add or change a header, just assign it to <tt>response.headers</tt> this way:

response.headers["Content-Type"] = "application/pdf"
<h3><a name="http-authentications"></a>10 HTTP Authentications</h3>
Rails comes with two built-in HTTP authentication mechanisms:
<ul>
	<li>Basic Authentication</li>
	<li>Digest Authentication</li>
</ul>
<h4><a name="http-basic-authentication"></a>10.1 HTTP Basic Authentication</h4>
HTTP basic authentication is an authentication scheme that is supported by the majority of browsers and other HTTP clients. As an example, consider an administration section which will only be available by entering a username and a password into the browser’s HTTP basic dialog window. Using the built-in authentication is quite easy and only requires you to use one method, <tt>http_basic_authenticate_with</tt>.

<span style="font-family: DejaVu Sans;">基于</span>HTTP<span style="font-family: DejaVu Sans;">的认证是一个认证结构它被主流的浏览器以及其他的</span>HTTP clients<span style="font-family: DejaVu Sans;">支持。作为一个例子，思考一个管理员</span>section<span style="font-family: DejaVu Sans;">它仅仅可以输入</span>username<span style="font-family: DejaVu Sans;">和</span>password<span style="font-family: DejaVu Sans;">到浏览器的基于</span>HTTP<span style="font-family: DejaVu Sans;">对话框窗口。使用内建的认证是十分简单的仅仅需要你使用一个方法，</span><tt>http_basic_authenticate_with</tt><span style="font-family: DejaVu Sans;"><tt>。</tt></span>

class AdminController &lt; ApplicationController

http_basic_authenticate_with :name =&gt; "humbaba", :password =&gt; "5baa61e4"

end

With this in place, you can create namespaced controllers that inherit from <tt>AdminController</tt>. The filter will thus be run for all actions in those controllers, protecting them with HTTP basic authentication.

<span style="font-family: DejaVu Sans;">通过将这段代码，你可以创建继承至</span><tt>AdminController</tt><span style="font-family: DejaVu Sans;"><tt>的</tt></span>namespaced controller<span style="font-family: DejaVu Sans;">。过滤器将自动对这些</span>controllers<span style="font-family: DejaVu Sans;">中的所有的</span>action<span style="font-family: DejaVu Sans;">运行这样的（认证），使用基于</span>HTTP<span style="font-family: DejaVu Sans;">的认证来保护它们。</span>

########in demo######

class PostsController &lt; ApplicationController

http_basic_authenticate_with :name =&gt; "test", :password =&gt; "123456", :except =&gt; :index

end
<h4><a name="http-digest-authentication"></a>10.2 HTTP Digest Authentication</h4>
HTTP digest authentication is superior to the basic authentication as it does not require the client to send an unencrypted password over the network (though HTTP basic authentication is safe over HTTPS). Using digest authentication with Rails is quite easy and only requires using one method, <tt>authenticate_or_request_with_http_digest</tt>.

HTTP <span style="font-family: DejaVu Sans;">精简认证优于基础认证因为它不需要</span>client<span style="font-family: DejaVu Sans;">发送一个未加密的穿过网络（即使</span>HTTP<span style="font-family: DejaVu Sans;">基础的认证比</span>HTTPS<span style="font-family: DejaVu Sans;">更安全）。在</span>Rails<span style="font-family: DejaVu Sans;">中使用 </span>digest authentication<span style="font-family: DejaVu Sans;">相当容易并且仅仅需要使用一个方法，</span><tt>authenticate_or_request_with_http_digest</tt><span style="font-family: DejaVu Sans;">。</span>

class AdminController &lt; ApplicationController

USERS = { "lifo" =&gt; "world" }

&nbsp;

before_filter :authenticate

&nbsp;

private

&nbsp;

def authenticate

authenticate_or_request_with_http_digest do |username|

USERS[username]

end

end

end

As seen in the example above, the <tt>authenticate_or_request_with_http_digest</tt> block takes only one argument – the username. And the block returns the password. Returning <tt>false</tt> or <tt>nil</tt> from the <tt>authenticate_or_request_with_http_digest</tt> will cause authentication failure.

<span style="font-family: DejaVu Sans;">正如上面看到例子， </span><tt>authenticate_or_request_with_http_digest</tt><span style="font-family: DejaVu Sans;"><tt>代码块仅仅获取一个参数——</tt></span><tt>username</tt><span style="font-family: DejaVu Sans;"><tt>。并且</tt></span><tt>block</tt><span style="font-family: DejaVu Sans;"><tt>（</tt></span><tt>do...end</tt><span style="font-family: DejaVu Sans;"><tt>之间的</tt></span><tt>block</tt><span style="font-family: DejaVu Sans;"><tt>）返回</tt></span><tt>password</tt><span style="font-family: DejaVu Sans;"><tt>。从 </tt></span><tt>authenticate_or_request_with_http_digest</tt><span style="font-family: DejaVu Sans;"><tt>返回</tt></span><tt>false</tt><span style="font-family: DejaVu Sans;"><tt>或者</tt></span><tt>nil</tt><span style="font-family: DejaVu Sans;"><tt>将会导致认证失败。</tt></span>
<h3><a name="streaming-and-file-downloads"></a>11 Streaming and File Downloads</h3>
Sometimes you may want to send a file to the user instead of rendering an HTML page. All controllers in Rails have the <tt>send_data</tt> and the <tt>send_file</tt> methods, which will both stream data to the client. <tt>send_file</tt> is a convenience method that lets you provide the name of a file on the disk and it will stream the contents of that file for you.

<span style="font-family: DejaVu Sans;">有时你可能希望发送一个文件给用户代替</span>rendering<span style="font-family: DejaVu Sans;">一个</span>HTML<span style="font-family: DejaVu Sans;">页面。</span>Rails<span style="font-family: DejaVu Sans;">中的所有</span>controllers<span style="font-family: DejaVu Sans;">都有</span>send_data<span style="font-family: DejaVu Sans;">和</span>send_file<span style="font-family: DejaVu Sans;">方法，它们都将会（将文件）以流数据形式发送给</span>client<span style="font-family: DejaVu Sans;">。</span>send_file<span style="font-family: DejaVu Sans;">是一个方便的方法它让你提供在</span>disk<span style="font-family: DejaVu Sans;">上的一个文件的</span>name<span style="font-family: DejaVu Sans;">并且它将会把那个文件的内容以</span>stream<span style="font-family: DejaVu Sans;">的形式发送给你。</span>

To stream data to the client, use <tt>send_data</tt>:

require "prawn"

class ClientsController &lt; ApplicationController

# Generates a PDF document with information on the client and

# returns it. The user will get the PDF as a file download.

def download_pdf

client = Client.find(params[:id])

send_data generate_pdf(client),

:filename =&gt; "#{client.name}.pdf",

:type =&gt; "application/pdf"

end

&nbsp;

private

&nbsp;

def generate_pdf(client)

Prawn::Document.new do

text client.name, :align =&gt; :center

text "Address: #{client.address}"

text "Email: #{client.email}"

end.render

end

end

The <tt>download_pdf</tt> action in the example above will call a private method which actually generates the PDF document and returns it as a string. This string will then be streamed to the client as a file download and a filename will be suggested to the user. Sometimes when streaming files to the user, you may not want them to download the file. Take images, for example, which can be embedded into HTML pages. To tell the browser a file is not meant to be downloaded, you can set the <tt>:disposition</tt> option to “inline”. The opposite and default value for this option is “attachment”.

<span style="font-family: DejaVu Sans;">上面例子中的 </span><tt>download_pdf action</tt><span style="font-family: DejaVu Sans;"><tt>将会</tt></span><tt>call</tt><span style="font-family: DejaVu Sans;"><tt>一个私有的方法这个方法实际上创建</tt></span><tt>PDF</tt><span style="font-family: DejaVu Sans;"><tt>文档并且将其作为一个</tt></span><tt>string</tt><span style="font-family: DejaVu Sans;"><tt>形式返回。这个</tt></span><tt>string</tt><span style="font-family: DejaVu Sans;"><tt>将会随后以</tt></span><tt>stream</tt><span style="font-family: DejaVu Sans;"><tt>的形式到</tt></span><tt>client</tt><span style="font-family: DejaVu Sans;"><tt>作为一个文件下载并且一个文件名将会建议给用户。提到图形，例如，它可以被嵌入</tt></span><tt>HTML</tt><span style="font-family: DejaVu Sans;"><tt>页面。</tt><tt><strong>要告诉浏览器一个文件不是（用来）被下载的，你可以设置</strong></tt></span><tt><strong>:disposition</strong></tt><span style="font-family: DejaVu Sans;"><tt><strong>选项为</strong></tt></span><tt><strong>'inline'</strong></tt><span style="font-family: DejaVu Sans;"><tt><strong>。这个选项相反的和默认的值是”</strong></tt></span><tt><strong>attachment”</strong></tt><span style="font-family: DejaVu Sans;"><tt><strong>。</strong></tt></span>
<h4><a name="sending-files"></a>11.1 Sending Files</h4>
If you want to send a file that already exists on disk, use the <tt>send_file</tt> method.

<span style="font-family: DejaVu Sans;">如果你想发送一个已经在硬盘中存在的文件，使用</span>send_file<span style="font-family: DejaVu Sans;">方法。</span>

class ClientsController &lt; ApplicationController

# Stream a file that has already been generated and stored on disk.

def download_pdf

client = Client.find(params[:id])

send_file("#{Rails.root}/files/clients/#{client.id}.pdf",

:filename =&gt; "#{client.name}.pdf",

:type =&gt; "application/pdf")

end

end

This will read and stream the file 4kB at the time, avoiding loading the entire file into memory at once. You can turn off streaming with the <tt>:stream</tt> option or adjust the block size with the <tt>:buffer_size</tt> option.

<span style="font-family: DejaVu Sans;">这将会</span>read<span style="font-family: DejaVu Sans;">和</span>stream<span style="font-family: DejaVu Sans;">文件一次</span>4kB<span style="font-family: DejaVu Sans;">，避免一次将整个文件导入内存。你可以用</span>:stream<span style="font-family: DejaVu Sans;">选项关闭流传送使或者设置适当的</span>block size<span style="font-family: DejaVu Sans;">通过</span>:buffer_size<span style="font-family: DejaVu Sans;">选项。</span>

Be careful when using data coming from the client (params, cookies, etc.) to locate the file on disk, as this is a security risk that might allow someone to gain access to files they are not meant to see.

<a name="result_box1"></a> <span style="font-family: DejaVu Sans;">在使用来自</span>client<span style="font-family: DejaVu Sans;">的数据的时候要小心（</span>params,cookies,etc.<span style="font-family: DejaVu Sans;">）到（服务器）本地硬盘中的文件，因为这是一个安全风险，可能会允许有人获得并不意味着他们看到的文件。</span>

&nbsp;

It is not recommended that you stream static files through Rails if you can instead keep them in a public folder on your web server. It is much more efficient to let the user download the file directly using Apache or another web server, keeping the request from unnecessarily going through the whole Rails stack. Although if you do need the request to go through Rails for some reason, you can set the <tt>:x_sendfile</tt> option to true, and Rails will let the web server handle sending the file to the user, freeing up the Rails process to do other things. Note that your web server needs to support the <tt>X-Sendfile</tt> header for this to work.

<a name="result_box2"></a> <span style="font-family: DejaVu Sans;">并不推荐你</span>stream<span style="font-family: DejaVu Sans;">静态文件通过</span>Rails<span style="font-family: DejaVu Sans;">如果作为替代你可以存放他们在你的服务器的一个公共的文件夹中。直接使用</span>Apache<span style="font-family: DejaVu Sans;">或者其他</span>web<span style="font-family: DejaVu Sans;">服务器让用户下载这些文件更加有效，避免不必要的</span>request<span style="font-family: DejaVu Sans;">通过整体的</span>Rails<span style="font-family: DejaVu Sans;">堆栈。即使如果因为某些原因你需要</span>request<span style="font-family: DejaVu Sans;">通过</span>Rails<span style="font-family: DejaVu Sans;">，你可以设置</span><tt>:x_sendfile</tt> option to true<span style="font-family: DejaVu Sans;">，</span>Rails<span style="font-family: DejaVu Sans;">将会让</span>web server handle<span style="font-family: DejaVu Sans;">发送这些文件给用户，释放</span>Rails<span style="font-family: DejaVu Sans;">进程去做其他的事情。注意你的</span>web server<span style="font-family: DejaVu Sans;">需要支持 </span><tt>X-Sendfile</tt> header<span style="font-family: DejaVu Sans;">来做这个工作。</span>
<h4><a name="restful-downloads"></a>11.2 RESTful Downloads</h4>
While <tt>send_data</tt> works just fine, if you are creating a RESTful application having separate actions for file downloads is usually not necessary. In REST terminology, the PDF file from the example above can be considered just another representation of the client resource. Rails provides an easy and quite sleek way of doing “RESTful downloads”. Here’s how you can rewrite the example so that the PDF download is a part of the <tt>show</tt> action, without any streaming:

<span style="font-family: DejaVu Sans;">当</span>send_data<span style="font-family: DejaVu Sans;">工作良好，如果你正在创建的一个</span>RESTful<span style="font-family: DejaVu Sans;">应用程序有单独的</span>actions<span style="font-family: DejaVu Sans;">来做</span>file<span style="font-family: DejaVu Sans;">下载通常是不需要的。在</span>REST<span style="font-family: DejaVu Sans;">术语中，来自例子中的</span>PDF<span style="font-family: DejaVu Sans;">文件完全可以被认为仅仅另一种</span>client<span style="font-family: DejaVu Sans;">资源的代表。</span>Rails<span style="font-family: DejaVu Sans;">提供一个容易和相当光滑的方式“</span>RESTful downloads”<span style="font-family: DejaVu Sans;">来做这些。这里重写例子以便于</span>PDF<span style="font-family: DejaVu Sans;">下载是</span>show action<span style="font-family: DejaVu Sans;">的一部分，没有任何的</span>streaming<span style="font-family: DejaVu Sans;">：</span>

class ClientsController &lt; ApplicationController

# The user can request to receive this resource as HTML or PDF.

def show

@client = Client.find(params[:id])

&nbsp;

respond_to do |format|

format.html

format.pdf { render :pdf =&gt; generate_pdf(@client) }

end

end

end

In order for this example to work, you have to add the PDF MIME type to Rails. This can be done by adding the following line to the file <tt>config/initializers/mime_types.rb</tt>:

<span style="font-family: DejaVu Sans;">为了是这个例子能够工作，你必须添加 </span>PDF MIME type<span style="font-family: DejaVu Sans;">到</span>Rails<span style="font-family: DejaVu Sans;">。可以添加下面的代码行到 </span><tt>config/initializers/mime_types.rb</tt><span style="font-family: DejaVu Sans;"><tt>：</tt></span>

Mime::Type.register "application/pdf", :pdf

<strong>Configuration files are not reloaded on each request,</strong> so you have to restart the server in order for their changes to take effect.

Now the user can request to get a PDF version of a client just by adding “.pdf” to the URL:

GET /clients/1.pdf
<h3><a name="parameter-filtering"></a>12 Parameter Filtering</h3>
Rails keeps a log file for each environment in the <tt>log</tt> folder. These are extremely useful when debugging what’s actually going on in your application, but in a live application you may not want every bit of information to be stored in the log file. You can filter certain request parameters from your log files by appending them to <tt>config.filter_parameters</tt> in the application configuration. These parameters will be marked [FILTERED] in the log.

Rail<span style="font-family: DejaVu Sans;">对于每个环境保留一个</span>log<span style="font-family: DejaVu Sans;">文件在</span>log<span style="font-family: DejaVu Sans;">文件夹中。这些文件相当有用，在当你调试的时候他们是在你应用程序中实际运行的记录，但是在一个</span>live<span style="font-family: DejaVu Sans;">的应用程序中你可以不希望每</span>bit<span style="font-family: DejaVu Sans;">的信息都被存储在</span>log<span style="font-family: DejaVu Sans;">文件中。你可以从你的</span>log<span style="font-family: DejaVu Sans;">文件中过滤某些</span>request parameters<span style="font-family: DejaVu Sans;">，通过添加它们到 </span><tt>config.filter_parameters</tt><span style="font-family: DejaVu Sans;"><tt>在</tt></span><tt>application configuration</tt><span style="font-family: DejaVu Sans;"><tt>。</tt></span><tt>These parameters will be marked [FILTERED] in the log.</tt>

config.filter_parameters &lt;&lt; :password
<h3><a name="rescue"></a>13 Rescue<span style="font-family: WenQuanYi Micro Hei;">挽救</span></h3>
Most likely your application is going to contain bugs or otherwise throw an exception that needs to be handled. For example, if the user follows a link to a resource that no longer exists in the database, Active Record will throw the <tt>ActiveRecord::RecordNotFound</tt> exception.

<span style="font-family: DejaVu Sans;">就像你的应用程序包含某些</span>bugs<span style="font-family: DejaVu Sans;">或者另一方面抛出一个异常需要被处理。例如，如果用户</span>follows<span style="font-family: DejaVu Sans;">一个</span>link<span style="font-family: DejaVu Sans;">到一个在数据库中并不存在的</span>resourece,Active Record<span style="font-family: DejaVu Sans;">将会抛出 </span><tt>ActiveRecord::RecordNotFound</tt><span style="font-family: DejaVu Sans;"><tt>异常。</tt></span>

Rails’ default exception handling displays a “500 Server Error” message for all exceptions. If the request was made locally, a nice traceback and some added information gets displayed so you can figure out what went wrong and deal with it. If the request was remote Rails will just display a simple “500 Server Error” message to the user, or a “404 Not Found” if there was a routing error or a record could not be found. Sometimes you might want to customize how these errors are caught and how they’re displayed to the user. There are several levels of exception handling available in a Rails application:

Rails<span style="font-family: DejaVu Sans;">的默认异常处理方式是对于所有的异常显示一个“</span>500 Server Error”<span style="font-family: DejaVu Sans;">消息。如果</span>request<span style="font-family: DejaVu Sans;">（相关的定制）在服务器被生成，一个漂亮的</span>traceback<span style="font-family: DejaVu Sans;">以及添加一些信息来显示使得你可以指出什么地方出错了并且怎样处理它。如果</span>request<span style="font-family: DejaVu Sans;">被</span>remote Rails<span style="font-family: DejaVu Sans;">将会仅仅显示一个简单的“</span>500 Server Error” <span style="font-family: DejaVu Sans;">消息给用户，或者如果这里有一个</span>routing<span style="font-family: DejaVu Sans;">错误或者一个记录不能被发现“</span>404 Not Found”<span style="font-family: DejaVu Sans;">将会发送给用户。有时你可以能希望定制这些错误怎样引起以及为什么它们被显示给用户。在</span>Rails<span style="font-family: DejaVu Sans;">应用程序中这里有一些级别的异常处理可用：</span>
<h4><a name="the-default-500-and-404-templates"></a>13.1 The Default 500 and 404 Templates</h4>
By default a production application will render either a 404 or a 500 error message. These messages are contained in static HTML files in the <tt>public</tt> folder, in <tt>404.html</tt> and <tt>500.html</tt> respectively. You can customize these files to add some extra information and layout, but remember that they are static; i.e. you can’t use RHTML or layouts in them, just plain HTML.

<span style="font-family: DejaVu Sans;">通过一个默认生成的应用程序将会</span>render<span style="font-family: DejaVu Sans;">一个</span>404<span style="font-family: DejaVu Sans;">或者</span>500<span style="font-family: DejaVu Sans;">错误消息。这些消息被包含在</span>public<span style="font-family: DejaVu Sans;">文件夹的静态</span>HTML<span style="font-family: DejaVu Sans;">文件中，分别在 </span><tt>404.html</tt> and <tt>500.html</tt><span style="font-family: DejaVu Sans;"><tt>。你可以定制这些文件来添加一些其他的信息和</tt></span><tt>layout</tt><span style="font-family: DejaVu Sans;"><tt>，但是记住他们是静态的；</tt></span><tt>i.e. you can’t use RHTML or layouts in them, </tt><span style="font-family: DejaVu Sans;"><tt>仅仅是纯</tt></span><tt>HTML</tt><span style="font-family: DejaVu Sans;"><tt>。</tt></span>
<h4><a name="rescue_from"></a>13.2 <tt>rescue_from</tt></h4>
If you want to do something a bit more elaborate when catching errors, you can use <tt>rescue_from</tt>, which handles exceptions of a certain type (or multiple types) in an entire controller and its subclasses.

<span style="font-family: DejaVu Sans;">如果你想做一些事情在</span>catching <span style="font-family: DejaVu Sans;">错误的时候做多一点的阐述，你可以使用 </span><tt>rescue_from</tt><span style="font-family: DejaVu Sans;"><tt>，其处理一种明确的异常类型（或者多种）在整个</tt></span><tt>controller</tt><span style="font-family: DejaVu Sans;"><tt>以及它的子类中。</tt></span>

When an exception occurs which is caught by a <tt>rescue_from</tt> directive, the exception object is passed to the handler. The handler can be a method or a <tt>Proc</tt> object passed to the <tt>:with</tt> option. You can also use a block directly instead of an explicit <tt>Proc</tt> object.

<span style="font-family: DejaVu Sans;">当一个异常发生其会直接引发 </span><tt>rescue_from</tt><span style="font-family: DejaVu Sans;"><tt>，这个</tt></span><tt>exception</tt><span style="font-family: DejaVu Sans;"><tt>对象被传递给</tt></span><tt>handler</tt><span style="font-family: DejaVu Sans;"><tt>。这个</tt></span><tt>handler</tt><span style="font-family: DejaVu Sans;"><tt>可以是一个方法或者一个被传递给</tt></span><tt>:with</tt><span style="font-family: DejaVu Sans;"><tt>选项的</tt></span><tt>Proc</tt><span style="font-family: DejaVu Sans;"><tt>对象。你也可以直接使用一个</tt></span><tt>block</tt><span style="font-family: DejaVu Sans;"><tt>替代准确的</tt></span><tt>Proc</tt><span style="font-family: DejaVu Sans;"><tt>对象。</tt></span>

Here’s how you can use <tt>rescue_from</tt> to intercept all <tt>ActiveRecord::RecordNotFound</tt> errors and do something with them.

<span style="font-family: DejaVu Sans;">这里是你如何使用 </span><tt>rescue_from</tt><span style="font-family: DejaVu Sans;"><tt>来截取所有的</tt></span><tt>ActiveRecord::RecordNotFound errors</tt><span style="font-family: DejaVu Sans;"><tt>并且为其做一些事情。</tt></span>

<tt>class ApplicationController &lt; ActionController::Base</tt>

<tt> </tt><tt>rescue_from ActiveRecord::RecordNotFound, :with =&gt; :record_not_found</tt>

&nbsp;

<tt> </tt><tt>private</tt>

&nbsp;

<tt> </tt><tt>def record_not_found</tt>

<tt> </tt><tt>render :text =&gt; "404 Not Found", :status =&gt; 404</tt>

<tt> </tt><tt>end</tt>

<tt>end</tt>

Of course, this example is anything but elaborate and doesn’t improve on the default exception handling at all, but once you can catch all those exceptions you’re free to do whatever you want with them. For example, you could create custom exception classes that will be thrown when a user doesn’t have access to a certain section of your application:

<span style="font-family: DejaVu Sans;">当然，这个例子的所有事情仅仅只是阐述以及没有改善默认的异常处理，但是一旦你可以</span>catch<span style="font-family: DejaVu Sans;">所有的异常你可以自由的做你想做的。例如，你可以创建定制的异常类它将在用户访问没有访问权限的应用程序的某些部分时候抛出：</span>

class ApplicationController &lt; ActionController::Base

rescue_from User::NotAuthorized, :with =&gt; :user_not_authorized

&nbsp;

private

&nbsp;

def user_not_authorized

flash[:error] = "You don't have access to this section."

redirect_to :back

end

end

&nbsp;

class ClientsController &lt; ApplicationController

# Check that the user has the right authorization to access clients.

before_filter :check_authorization

&nbsp;

# Note how the actions don't have to worry about all the auth stuff.

def edit

@client = Client.find(params[:id])

end

&nbsp;

private

&nbsp;

# If the user is not authorized, just throw the exception.

def check_authorization

raise User::NotAuthorized unless current_user.admin?

end

end

Certain exceptions are only rescuable from the <tt>ApplicationController</tt> class, as they are raised before the controller gets initialized and the action gets executed. See Pratik Naik’s <a href="http://m.onkey.org/2008/7/20/rescue-from-dispatching">article</a> on the subject for more information.
<h3><a name="force-https-protocol"></a><a name="result_box3"></a> 14 Force HTTPS protocol<span style="font-family: WenQuanYi Micro Hei;">强制</span>HTTPS<span style="font-family: WenQuanYi Micro Hei;">协议</span></h3>
Sometime you might want to force a particular controller to only be accessible via an HTTPS protocol for security reason. Since Rails 3.1 you can now use <tt>force_ssl</tt> method in your controller to enforce that:

<span style="font-family: DejaVu Sans;">有时候因为安全原因你可能希望强制特定的</span>cotroller<span style="font-family: DejaVu Sans;">仅仅在</span>HTTPS<span style="font-family: DejaVu Sans;">协议下是可访问的。从</span>Rails 3.1<span style="font-family: DejaVu Sans;">你可以在你的</span>controller<span style="font-family: DejaVu Sans;">使用 </span><tt>force_ssl</tt><span style="font-family: DejaVu Sans;"><tt>来强制执行：</tt></span>

class DinnerController

force_ssl

end

Just like the filter, you could also passing <tt>:only</tt> and <tt>:except</tt> to enforce the secure connection only to specific actions.

class DinnerController

force_ssl :only =&gt; :cheeseburger

# or

force_ssl :except =&gt; :cheeseburger

end

Please note that if you found yourself adding <tt>force_ssl</tt> to many controllers, you may found yourself wanting to force the whole application to use HTTPS instead. In that case, you can set the <tt>config.force_ssl</tt> in your environment file.

<span style="font-family: DejaVu Sans;">请注意如果你发现你自己的添加 </span><tt>force_ssl</tt><span style="font-family: DejaVu Sans;"><tt>到许多</tt></span><tt>controllers</tt><span style="font-family: DejaVu Sans;"><tt>，你可能发现你自己希望强制整个应用程序使用</tt></span><tt>HTTPS</tt><span style="font-family: DejaVu Sans;"><tt>替代。因为这样的原因，你可以在你的环境文件中设置</tt></span><tt>config.force_ssl</tt><tt> </tt><span style="font-family: DejaVu Sans;"><tt>。</tt></span>

<a href="http://jhjguxin.hwcrazy.com/tag/controller/">controller</a> <a href="http://jhjguxin.hwcrazy.com/tag/filter/">filter</a> <a href="http://jhjguxin.hwcrazy.com/tag/guide/">guide</a> <a href="http://jhjguxin.hwcrazy.com/tag/rails/">rails</a> <a href="http://jhjguxin.hwcrazy.com/tag/ruby/">ruby</a>
