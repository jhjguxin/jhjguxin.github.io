---
layout: post
title: "Ruby on Rails 3.1 Release Notes"
date: 2011-12-30 19:12
comments: true
categories: [rails,ruby]
tags: [gem,git,guide,jquery,learning,rails,release,ruby]
---
## Ruby on Rails 3.1 Release Notes
<h2>Ruby on Rails 3.1 Release Notes</h2>
Highlights in Rails 3.1:

Rails<span style="font-family: DejaVu Sans;">中的亮点：</span>
<ul>
	<li>Streaming <span style="font-family: DejaVu Sans;"><span style="font-family: Liberation Serif,Times New Roman,serif;">流</span></span></li>
	<li>Reversible Migrations <span style="font-family: DejaVu Sans;"><span style="font-family: Liberation Serif,Times New Roman,serif;">可逆（数据）迁移</span></span></li>
	<li>Assets Pipeline Assets<span style="font-family: DejaVu Sans;">管道</span></li>
	<li>jQuery as the default JavaScript library <span style="font-family: DejaVu Sans;"><span style="font-family: Liberation Serif,Times New Roman,serif;">以</span></span>jQuery<span style="font-family: DejaVu Sans;"><span style="font-family: Liberation Serif,Times New Roman,serif;">作为默认的 </span></span>JavaScript library</li>
</ul>
This release notes cover the major changes, but don’t include every little bug fix and change. If you want to see everything, check out the <a href="https://github.com/rails/rails/commits/master"><span style="color: #000080;"><span style="text-decoration: underline;">list</span></span><span style="color: #000080;"><span style="text-decoration: underline;">of</span></span><span style="color: #000080;"><span style="text-decoration: underline;">commits</span></span></a> in the main Rails repository on GitHub.

<span style="font-family: DejaVu Sans;">这次发行</span>notes<span style="font-family: DejaVu Sans;">涵盖了主要的</span>changes<span style="font-family: DejaVu Sans;">，但是没有包含每个很</span>little<span style="font-family: DejaVu Sans;">的</span>bug<span style="font-family: DejaVu Sans;">修复和</span>chage<span style="font-family: DejaVu Sans;">。如果你希望看到所有的事情，检查</span>Rails <span style="font-family: DejaVu Sans;">的</span>GitHub<span style="font-family: DejaVu Sans;">主代码仓库中的</span><a href="https://github.com/rails/rails/commits/master"><span style="color: #000080;"><span style="text-decoration: underline;">list</span></span><span style="color: #000080;"><span style="text-decoration: underline;">of</span></span><span style="color: #000080;"><span style="text-decoration: underline;">commits</span></span></a><span style="font-family: DejaVu Sans;">。</span>
<h3><a name="upgrading-to-rails-3-1"></a>1 Upgrading to Rails 3.1<span style="font-family: WenQuanYi Micro Hei;">升级到</span>Rails 3.1</h3>
If you’re upgrading an existing application, it’s a great idea to have good test coverage before going in. You should also first upgrade to Rails 3 in case you haven’t and make sure your application still runs as expected before attempting to update to Rails 3.1. Then take heed of the following changes:

<span style="font-family: DejaVu Sans;">如果你打算升级一个存在的应用程序，在开始进入升级的时候有一个很好的测试覆盖是一个好主意。你还应该首先升级到</span>Rails 3<span style="font-family: DejaVu Sans;">以防止你并没有确保你的应用程序在企图升级到</span>Rails 3.1<span style="font-family: DejaVu Sans;">之前能够预计到升级后仍然能够运行。然后留意随后（介绍）的</span>changes<span style="font-family: DejaVu Sans;">：</span>
<h4><a name="rails-3-1-requires-at-least-ruby-1-8-7"></a> 1.1 Rails 3.1 requires at least Ruby 1.8.7</h4>
Rails 3.1 requires Ruby 1.8.7 or higher. Support for all of the previous Ruby versions has been dropped officially and you should upgrade as early as possible. Rails 3.1 is also compatible with Ruby 1.9.2.

Rails 3.1<span style="font-family: DejaVu Sans;">需要至少</span>Ruby 1.8.7<span style="font-family: DejaVu Sans;">或者更高。曾经支持的所有的早先的</span>Ruby<span style="font-family: DejaVu Sans;">版本被正式取消，你需要尽快升级。</span>Rails 3.1<span style="font-family: DejaVu Sans;">同时也与</span>Ruby 1.9.2<span style="font-family: DejaVu Sans;">兼容。</span>

Note that Ruby 1.8.7 p248 and p249 have marshaling bugs that crash Rails. Ruby Enterprise Edition have these fixed since release 1.8.7-2010.02 though. On the 1.9 front, Ruby 1.9.1 is not usable because it outright segfaults, so if you want to use 1.9.x jump on 1.9.2 for smooth sailing.

<span style="font-family: DejaVu Sans;">注意</span>Ruby 1.8.7 p248<span style="font-family: DejaVu Sans;">和</span>p249<span style="font-family: DejaVu Sans;">有</span>marshaling bugs<span style="font-family: DejaVu Sans;">其与</span>Rails<span style="font-family: DejaVu Sans;">冲突。</span>Ruby<span style="font-family: DejaVu Sans;">企业版自</span>1.8.7-2010.02 <span style="font-family: DejaVu Sans;">发行版已经修复了这些</span>bug<span style="font-family: DejaVu Sans;">。在以</span>1.9<span style="font-family: DejaVu Sans;">开头的</span>ruby<span style="font-family: DejaVu Sans;">，</span>Ruby 1.9.1<span style="font-family: DejaVu Sans;">是不可用的因为</span>it outright segfaults<span style="font-family: DejaVu Sans;">，因此如果你想使用</span>1.9.x<span style="font-family: DejaVu Sans;">可以平稳的跳至</span>1.9.2
<h3><a name="creating-a-rails-3-1-application"></a>2 Creating a Rails 3.1 application</h3>
# You should have the 'rails' rubygem installed

$ rails new myapp

$ cd myapp
<h4><a name="vendoring-gems"></a>2.1 Vendoring Gems</h4>
Rails now uses a <tt>Gemfile</tt> in the application root to determine the gems you require for your application to start. This <tt>Gemfile</tt> is processed by the <span style="color: #000080;"><span style="text-decoration: underline;"><a href="https://github.com/carlhuda/bundler">Bundler</a></span></span> gem, which then installs all your dependencies. It can even install all the dependencies locally to your application so that it doesn’t depend on the system gems.

Rails<span style="font-family: DejaVu Sans;">现在使用一个位于应用程序根目录的</span>Gemfile<span style="font-family: DejaVu Sans;">文件来决定使你开始你的应用程序的</span>require<span style="font-family: DejaVu Sans;">。这个</span>Gemfile<span style="font-family: DejaVu Sans;">文件被</span>Bundler gem<span style="font-family: DejaVu Sans;">加工生成，它会随后安装你所有的依赖。它甚至可以以你的应用程序为</span>locally<span style="font-family: DejaVu Sans;">安装依赖，使得你的应用程序不用依赖系统</span>gems<span style="font-family: DejaVu Sans;">。</span>

&nbsp;
<table width="665" cellspacing="0" cellpadding="2"><colgroup><col width="74" /> <col width="583" /> </colgroup>
<tbody>
<tr>
<td width="74">vendor/</td>
<td width="583">A place for all third-party code. In a typical Rails application, this includes Ruby Gems, the Rails source code (if you install it into your project) and plugins containing additional prepackaged functionality.<span style="font-family: DejaVu Sans;">放置第三方代码的地方。在一个典型的</span>Rails<span style="font-family: DejaVu Sans;">应用程序中，这里包含</span>Ruby Gems<span style="font-family: DejaVu Sans;">，</span>Rails<span style="font-family: DejaVu Sans;">源代码（如果你把</span>Rails<span style="font-family: DejaVu Sans;">安装到你的项目中）还包含一些预先包装好的额外的插件</span></td>
</tr>
</tbody>
</table>
More information: – <a href="http://gembundler.com/"><span style="color: #000080;"><span style="text-decoration: underline;">bundler</span></span><span style="color: #000080;"><span style="text-decoration: underline;">homepage</span></span></a>
<h4><a name="living-on-the-edge"></a>2.2 Living on the Edge</h4>
<tt>Bundler</tt> and <tt>Gemfile</tt> makes freezing your Rails application easy as pie with the new dedicated <tt>bundle</tt> command. If you want to bundle straight from the Git repository, you can pass the <tt>--edge</tt> flag:

Bundler<span style="font-family: DejaVu Sans;">和</span>Gemfile<span style="font-family: DejaVu Sans;">通过新的专用</span>bundle <span style="font-family: DejaVu Sans;">命令来冻结你的应用程序就像吃馅饼一样简单。如果你想直接从</span>Git<span style="font-family: DejaVu Sans;">仓库</span>bundle<span style="font-family: DejaVu Sans;">，你可以通过<span style="font-family: Liberation Serif,Times New Roman,serif;">—</span></span>edge flag<span style="font-family: DejaVu Sans;">：</span>

$ rails new myapp --edge

If you have a local checkout of the Rails repository and want to generate an application using that, you can pass the <tt>--dev</tt> flag:

<span style="font-family: DejaVu Sans;">如果你有一个从</span>Rails<span style="font-family: DejaVu Sans;">源代码仓库</span>checkout<span style="font-family: DejaVu Sans;">的本地</span>Rails<span style="font-family: DejaVu Sans;">并且你想生成一个应用程序使用（上面的方法）你可以通过<span style="font-family: Liberation Serif,Times New Roman,serif;">—</span></span>dev <span style="font-family: DejaVu Sans;">标志：</span>

$ ruby /path/to/rails/bin/rails new myapp --dev
<h3><a name="rails-architectural-changes"></a>3 Rails Architectural<span style="font-family: WenQuanYi Micro Hei;">建筑的</span>Changes</h3>
<h4><a name="assets-pipeline"></a>3.1 Assets Pipeline</h4>
The major change in Rails 3.1 is the Assets Pipeline. It makes CSS and JavaScript first-class code citizens and enables proper organization, including use in plugins and engines.

<span style="font-family: DejaVu Sans;">在</span>Rails 3.1<span style="font-family: DejaVu Sans;">中主要的更改就是</span>Assets Pipeline<span style="font-family: DejaVu Sans;">（管道）。它使得</span>CSS<span style="font-family: DejaVu Sans;">和</span>JavaScript <span style="font-family: DejaVu Sans;">一流的代码公民可以合适的组织他们，包含使用</span>pluginis<span style="font-family: DejaVu Sans;">和</span>engines<span style="font-family: DejaVu Sans;">。</span>

The assets pipeline is powered by <span style="color: #000080;"><span style="text-decoration: underline;"><a href="https://github.com/sstephenson/sprockets">Sprockets</a></span></span> and is covered in the <a href="http://guides.rubyonrails.org/asset_pipeline.html"><span style="color: #000080;"><span style="text-decoration: underline;">Asset</span></span><span style="color: #000080;"><span style="text-decoration: underline;">Pipeline</span></span></a> guide.
<h4><a name="http-streaming"></a>3.2 HTTP Streaming</h4>
HTTP Streaming is another change that is new in Rails 3.1. This lets the browser download your stylesheets and JavaScript files while the server is still generating the response. This requires Ruby 1.9.2, is opt-in and requires support from the web server as well, but the popular combo of nginx and unicorn is ready to take advantage of it.

HTTP Streaming<span style="font-family: DejaVu Sans;">是</span>Rails 3.1<span style="font-family: DejaVu Sans;">另一更改。这使得浏览器下载你的</span>stylesheets<span style="font-family: DejaVu Sans;">和</span>JavaSript<span style="font-family: DejaVu Sans;">文件即使服务器仍然在响应。这需要</span>Ruby 1.9.2<span style="font-family: DejaVu Sans;">，它是需要从服务器中选择以及服务器同样支持</span>HTTP Streaming<span style="font-family: DejaVu Sans;">，但是受欢迎的</span>nginx<span style="font-family: DejaVu Sans;">和</span>unicom<span style="font-family: DejaVu Sans;">组织已经准备</span>advantage HTTP Streaming<span style="font-family: DejaVu Sans;">。</span>
<h4><a name="default-js-library-is-now-jquery"></a>3.3 Default JS library is now jQuery</h4>
jQuery is the default JavaScript library that ships with Rails 3.1. But if you use Prototype, it’s simple to switch.

Jquey<span style="font-family: DejaVu Sans;">是默认的</span>JavaScript library<span style="font-family: DejaVu Sans;">搭载在</span>Rrails 3.1.<span style="font-family: DejaVu Sans;">但是如果你使用</span>Prototype<span style="font-family: DejaVu Sans;">，它更改很简单。</span>

$ rails new myapp -j prototype
<h4><a name="identity-map"></a>3.4 Identity Map <span style="font-family: WenQuanYi Micro Hei;">身份</span>map</h4>
Active Record has an Identity Map in Rails 3.1. An identity map keeps previously instantiated records and returns the object associated with the record if accessed again. The identity map is created on a per-request basis and is flushed at request completion.

Rails 3.1<span style="font-family: DejaVu Sans;">的</span>Active Record<span style="font-family: DejaVu Sans;">有一个</span>Indentity Map<span style="font-family: DejaVu Sans;">。一个</span>identity map<span style="font-family: DejaVu Sans;">保留先前的实例化的记录并且如果再次访问返回记录的对象的关系。</span>Indentity map<span style="font-family: DejaVu Sans;">是基于每个请求创建的并且在请求完成刷新。</span>

Rails 3.1 comes with the identity map turned off by default.

Rails 3.1<span style="font-family: DejaVu Sans;">默认</span>Identity map<span style="font-family: DejaVu Sans;">是关闭的。</span>
<h3><a name="railties"></a>4 Railties</h3>
<ul>
	<li><a name="railties1"></a>jQuery is the new default JavaScript library.</li>
</ul>
Jquey<span style="font-family: DejaVu Sans;">是新的默认的</span>JavaScript library<span style="font-family: DejaVu Sans;">。</span>
<ul>
	<li>jQuery and Prototype are no longer vendored and is provided from now on by the jquery-rails and prototype-rails gems.</li>
</ul>
jQuey<span style="font-family: DejaVu Sans;">和</span>Prototype<span style="font-family: DejaVu Sans;">不再</span>vendored<span style="font-family: DejaVu Sans;">并且从现在开始提供的是</span>jquery-rails and prototype-rails gems<span style="font-family: DejaVu Sans;">。</span>
<ul>
	<li>The application generator accepts an option <tt>-j</tt> which can be an arbitrary string. If passed “foo”, the gem “foo-rails” is added to the <tt>Gemfile</tt>, and the application JavaScript manifest requires “foo” and “foo_ujs”. Currently only “prototype-rails” and “jquery-rails” exist and provide those files via the asset pipeline.</li>
</ul>
<span style="font-family: DejaVu Sans;">应用程序创建器接受一个选项</span>-j<span style="font-family: DejaVu Sans;">其可以是任意字符串。如果传递<span style="font-family: Liberation Serif,Times New Roman,serif;">“</span></span>foo”<span style="font-family: DejaVu Sans;">，</span>gem “foo-rails”<span style="font-family: DejaVu Sans;">就被添加到</span>Gemfile<span style="font-family: DejaVu Sans;">，并且应用程序的</span>JavaScript manifest requires “foo” and “foo_ujs”<span style="font-family: DejaVu Sans;">。当前只有<span style="font-family: Liberation Serif,Times New Roman,serif;"> “</span></span>prototype-rails” and “jquery-rails”<span style="font-family: DejaVu Sans;">存在并且通过</span>asset pipeline<span style="font-family: DejaVu Sans;">提供这些文件。</span>
<ul>
	<li>Generating an application or a plugin runs <tt>bundle</tt><tt> </tt><tt>install</tt> unless <tt>--skip-gemfile</tt> or <tt>--skip-bundle</tt> is specified.</li>
</ul>
<span style="font-family: DejaVu Sans;">生成一个应用程序或者一个</span>plugin<span style="font-family: DejaVu Sans;">运行</span>bundle install<span style="font-family: DejaVu Sans;">除非</span>--skip-gemfile<span style="font-family: DejaVu Sans;">或者</span>--skip-bundle<span style="font-family: DejaVu Sans;">被指定</span>
<ul>
	<li>The controller and resource generators will now automatically produce asset stubs (this can be turned off with <tt>--skip-assets</tt>). These stubs will use CoffeeScript and Sass, if those libraries are available.</li>
</ul>
Controller<span style="font-family: DejaVu Sans;">和</span>resource<span style="font-family: DejaVu Sans;">创建器将会自动的产生</span>asset stubs(this can be turned off with <tt>--skip-assets</tt>)<span style="font-family: DejaVu Sans;">。这些</span>stub<span style="font-family: DejaVu Sans;">将会使用</span>CoffeeScript and Sass<span style="font-family: DejaVu Sans;">，如果这些</span>libraries<span style="font-family: DejaVu Sans;">是可用的。</span>
<ul>
	<li>Scaffold and app generators use the Ruby 1.9 style hash when running on Ruby 1.9. To generate old style hash, <tt>--old-style-hash</tt> can be passed.</li>
</ul>
<ul>
	<li>Scaffold controller generator creates format block for JSON instead of XML.</li>
</ul>
<ul>
	<li>Active Record logging is directed to STDOUT and shown inline in the console.</li>
</ul>
<ul>
	<li>Added <tt>config.force_ssl</tt> configuration which loads <tt>Rack::SSL</tt> middleware and force all requests to be under HTTPS protocol.</li>
</ul>
<ul>
	<li>Added <tt>rails</tt><tt> </tt><tt>plugin</tt><tt> </tt><tt>new</tt> command which generates a Rails plugin with gemspec, tests and a dummy application for testing.</li>
</ul>
<ul>
	<li>Added <tt>Rack::Etag</tt> and <tt>Rack::ConditionalGet</tt> to the default middleware stack.</li>
</ul>
<ul>
	<li>Added <tt>Rack::Cache</tt> to the default middleware stack.</li>
</ul>
<ul>
	<li>Engines received a major update – You can mount them at any path, enable assets, run generators etc.</li>
</ul>
<h3><a name="action-pack"></a>5 Action Pack</h3>
<h4><a name="action-controller"></a>5.1 Action Controller</h4>
<ul>
	<li>A warning is given out if the CSRF token authenticity cannot be verified.</li>
</ul>
<ul>
	<li>Specify <tt>force_ssl</tt> in a controller to force the browser to transfer data via HTTPS protocol on that particular controller. To limit to specific actions, <tt>:only</tt> or <tt>:except</tt> can be used.</li>
</ul>
<ul>
	<li>Sensitive query string parameters specified in <tt>config.filter_parameters</tt> will now be filtered out from the request paths in the log.</li>
</ul>
<ul>
	<li>URL parameters which return <tt>nil</tt> for <tt>to_param</tt> are now removed from the query string.</li>
</ul>
<ul>
	<li>Added <tt>ActionController::ParamsWrapper</tt> to wrap parameters into a nested hash, and will be turned on for JSON request in new applications by default. This can be customized in <tt>config/initializers/wrap_parameters.rb</tt>.</li>
</ul>
<ul>
	<li>Added <tt>config.action_controller.include_all_helpers</tt>. By default <tt>helper</tt><tt> </tt><tt>:all</tt> is done in <tt>ActionController::Base</tt>, which includes all the helpers by default. Setting <tt>include_all_helpers</tt> to <tt>false</tt> will result in including only application_helper and the helper corresponding to controller (like foo_helper for foo_controller).</li>
</ul>
<ul>
	<li><tt>url_for</tt> and named url helpers now accept <tt>:subdomain</tt> and <tt>:domain</tt> as options.</li>
</ul>
<ul>
	<li>Added <tt>Base.http_basic_authenticate_with</tt> to do simple http basic authentication with a single class method call.</li>
</ul>
class PostsController &lt; ApplicationController

USER_NAME, PASSWORD = "dhh", "secret"

&nbsp;

before_filter :authenticate, :except =&gt; [ :index ]

&nbsp;

def index

render :text =&gt; "Everyone can see me!"

end

&nbsp;

def edit

render :text =&gt; "I'm only accessible if you know the password"

end

&nbsp;

private

def authenticate

authenticate_or_request_with_http_basic do |user_name, password|

user_name == USER_NAME &amp;&amp; password == PASSWORD

end

end

end

..can now be written as

class PostsController &lt; ApplicationController

http_basic_authenticate_with :name =&gt; "dhh", :password =&gt; "secret", :except =&gt; :index

&nbsp;

def index

render :text =&gt; "Everyone can see me!"

end

&nbsp;

def edit

render :text =&gt; "I'm only accessible if you know the password"

end

end

Added streaming support, you can enable it with:

class PostsController &lt; ActionController::Base

stream

end

You can restrict<span style="font-family: DejaVu Sans;">限制</span>it to some actions by using <tt>:only</tt> or <tt>:except</tt>. Please read the docs at <span style="color: #000080;"><span style="text-decoration: underline;"><a href="http://api.rubyonrails.org/classes/ActionController/Streaming.html">ActionController::Streaming</a></span></span> for more information.
<ul>
	<li>The redirect route method now also accepts a hash of options which will only change the parts of the url in question, or an object which responds to call, allowing for redirects to be reused.</li>
</ul>
<h4><a name="action-dispatch"></a>5.2 Action Dispatch</h4>
<ul>
	<li><tt>config.action_dispatch.x_sendfile_header</tt> now defaults to <tt>nil</tt> and <tt>config/environments/production.rb</tt> doesn’t set any particular value for it. This allows servers to set it through <tt>X-Sendfile-Type</tt>.</li>
</ul>
<ul>
	<li><tt>ActionDispatch::MiddlewareStack</tt> now uses composition<span style="font-family: DejaVu Sans;">组成</span>over inheritance and is no longer an array.</li>
</ul>
<ul>
	<li>Added <tt>ActionDispatch::Request.ignore_accept_header</tt> to ignore accept headers.</li>
</ul>
<ul>
	<li>Added <tt>Rack::Cache</tt> to the default stack.</li>
</ul>
<ul>
	<li>Moved etag responsibility from <tt>ActionDispatch::Response</tt> to the middleware stack.</li>
</ul>
<ul>
	<li>Rely on <tt>Rack::Session</tt> stores API for more compatibility across the Ruby world. This is backwards incompatible since <tt>Rack::Session</tt> expects <tt>#get_session</tt> to accept four arguments and requires <tt>#destroy_session</tt> instead of simply <tt>#destroy</tt>.</li>
</ul>
<ul>
	<li>Template lookup now searches further up in the inheritance chain.</li>
</ul>
<h4><a name="action-view"></a>5.3 Action View</h4>
<ul>
	<li>Added an <tt>:authenticity_token</tt> option to <tt>form_tag</tt> for custom handling or to omit the token by passing <tt>:authenticity_token</tt><tt> </tt><tt>=&gt;</tt><tt> </tt><tt>false</tt>.</li>
</ul>
<ul>
	<li>Created <tt>ActionView::Renderer</tt> and specified an API for <tt>ActionView::Context</tt>.</li>
</ul>
<ul>
	<li>In place <tt>SafeBuffer</tt> mutation is prohibited<span style="font-family: DejaVu Sans;">禁止</span>in Rails 3.1.</li>
</ul>
<ul>
	<li>Added HTML5 <tt>button_tag</tt> helper.</li>
</ul>
<ul>
	<li><tt>file_field</tt> automatically adds <tt>:multipart</tt><tt> </tt><tt>=&gt;</tt><tt> </tt><tt>true</tt> to the enclosing form.</li>
</ul>
<ul>
	<li>Added a convenience idiom to generate HTML5 data-* attributes in tag helpers from a <tt>:data</tt> hash of options:</li>
</ul>
tag("div", :data =&gt; {:name =&gt; 'Stephen', :city_state =&gt; %w(Chicago IL)})

# =&gt; &lt;div data-name="Stephen" data-city-state="[&amp;quot;Chicago&amp;quot;,&amp;quot;IL&amp;quot;]" /&gt;

Keys are dasherized. Values are JSON-encoded, except for strings and symbols.
<ul>
	<li><tt>csrf_meta_tag</tt> is renamed to <tt>csrf_meta_tags</tt> and aliases <tt>csrf_meta_tag</tt> for backwards compatibility.</li>
</ul>
<ul>
	<li>The old template handler API is deprecated and the new API simply requires a template handler to respond to call.</li>
</ul>
<ul>
	<li>rhtml and rxml are finally removed as template handlers.</li>
</ul>
<ul>
	<li><tt>config.action_view.cache_template_loading</tt> is brought back which allows to decide whether templates should be cached or not.</li>
</ul>
<ul>
	<li>The submit form helper does not generate an id “object_name_id” anymore.</li>
</ul>
<ul>
	<li>Allows <tt>FormHelper#form_for</tt> to specify the <tt>:method</tt> as a direct option instead of through the <tt>:html</tt> hash. <tt>form_for(@post,</tt><tt> </tt><tt>remote:</tt><tt> </tt><tt>true,</tt><tt> </tt><tt>method:</tt><tt> </tt><tt>:delete)</tt> instead of <tt>form_for(@post,</tt><tt> </tt><tt>remote:</tt><tt> </tt><tt>true,</tt><tt> </tt><tt>html:</tt><tt> </tt><tt>{</tt><tt> </tt><tt>method:</tt><tt> </tt><tt>:delete</tt><tt> </tt><tt>})</tt>.</li>
</ul>
<ul>
	<li>Provided <tt>JavaScriptHelper#j()</tt> as an alias for <tt>JavaScriptHelper#escape_javascript()</tt>. This supersedes the <tt>Object#j()</tt> method that the JSON gem adds within templates using the JavaScriptHelper.</li>
</ul>
<ul>
	<li>Allows AM/PM format in datetime selectors.</li>
</ul>
<ul>
	<li><tt>auto_link</tt> has been removed from Rails and extracted into the <a href="https://github.com/tenderlove/rails_autolink"><span style="color: #000080;"><span style="text-decoration: underline;">rails_autolink</span></span><span style="color: #000080;"><span style="text-decoration: underline;">gem</span></span></a></li>
</ul>
<h3><a name="active-record"></a>6 Active Record</h3>
<ul>
	<li>Added a class method <tt>pluralize_table_names</tt> to singularize/pluralize<span style="font-family: DejaVu Sans;">复数</span>table names of individual models. Previously this could only be set globally for all models through <tt>ActiveRecord::Base.pluralize_table_names</tt>.</li>
</ul>
class User &lt; ActiveRecord::Base

self.pluralize_table_names = false

end
<ul>
	<li>Added block setting of attributes to singular associations. The block will get called after the instance is initialized</li>
</ul>
class User &lt; ActiveRecord::Base

has_one :account

end

&nbsp;

user.build_account{ |a| a.credit_limit =&gt; 100.0 }
<ul>
	<li><strong>Added</strong><strong> </strong><tt><strong>ActiveRecord::Base.attribute_names</strong></tt><strong> </strong><strong>to</strong><strong> </strong><strong>return</strong><strong> </strong><strong>a</strong><strong> </strong><strong>list</strong><strong> </strong><strong>of</strong><strong> </strong><strong>attribute</strong><strong> </strong><strong>names.</strong><strong> </strong><strong>This</strong><strong> </strong><strong>will</strong><strong> </strong><strong>return</strong><strong> </strong><strong>an</strong><strong> </strong><strong>empty</strong><strong> </strong><strong>array</strong><strong> </strong><strong>if</strong><strong> </strong><strong>the</strong><strong> </strong><strong>model</strong><strong> </strong><strong>is</strong><strong> </strong><strong>abstract</strong><strong> </strong><strong>or</strong><strong> </strong><strong>the</strong><strong> </strong><strong>table</strong><strong> </strong><strong>does</strong><strong> </strong><strong>not</strong><strong> </strong><strong>exist.</strong><strong> </strong></li>
</ul>
<ul>
	<li>CSV Fixtures are deprecated and support will be removed in Rails 3.2.0.</li>
</ul>
<ul>
	<li><tt>ActiveRecord#new</tt>, <tt>ActiveRecord#create</tt> and <tt>ActiveRecord#update_attributes</tt> all accept a second hash as an option that allows you to specify which role to consider when assigning attributes. This is built on top of Active Model’s new mass assignment capabilities:</li>
</ul>
class Post &lt; ActiveRecord::Base

attr_accessible :title

attr_accessible :title, :published_at, :as =&gt; :admin

end

&nbsp;

Post.new(params[:post], :as =&gt; :admin)
<ul>
	<li><tt>default_scope</tt> can now take a block, lambda, or any other object which responds to call for lazy evaluation.</li>
</ul>
<ul>
	<li>Default scopes are now evaluated at the latest possible moment, to avoid problems where scopes would be created which would implicitly contain the default scope, which would then be impossible to get rid of via Model.unscoped.</li>
</ul>
<ul>
	<li>PostgreSQL adapter only supports PostgreSQL version 8.2 and higher.</li>
</ul>
<ul>
	<li><tt>ConnectionManagement</tt> middleware is changed to clean up the connection pool after the rack body has been flushed.</li>
</ul>
<ul>
	<li>Added an <tt>update_column</tt> method on Active Record. This new method updates a given attribute on an object, skipping validations and callbacks. It is recommended to use <tt>update_attribute</tt> unless you are sure you do not want to execute any callback, including the modification of the <tt>updated_at</tt> column. It should not be called on new records.</li>
</ul>
<ul>
	<li>Associations with a <tt>:through</tt> option can now use any association as the through or source association, including other associations which have a <tt>:through</tt> option and <tt>has_and_belongs_to_many</tt> associations.</li>
</ul>
<ul>
	<li>The configuration for the current database connection is now accessible via <tt>ActiveRecord::Base.connection_config</tt>.</li>
</ul>
<ul>
	<li>limits and offsets are removed from COUNT queries unless both are supplied.</li>
</ul>
People.limit(1).count # =&gt; 'SELECT COUNT(*) FROM people'

People.offset(1).count # =&gt; 'SELECT COUNT(*) FROM people'

People.limit(1).offset(1).count # =&gt; 'SELECT COUNT(*) FROM people LIMIT 1 OFFSET 1'
<ul>
	<li><tt>ActiveRecord::Associations::AssociationProxy</tt> has been split. There is now an <tt>Association</tt> class (and subclasses) which are responsible for operating on associations, and then a separate, thin wrapper called <tt>CollectionProxy</tt>, which proxies collection associations. This prevents namespace pollution, separates concerns, and will allow further refactorings.</li>
</ul>
<ul>
	<li>Singular associations (<tt>has_one</tt>, <tt>belongs_to</tt>) no longer have a proxy and simply returns the associated record or <tt>nil</tt>. This means that you should not use undocumented methods such as <tt>bob.mother.create</tt> – use <tt>bob.create_mother</tt> instead.</li>
</ul>
<ul>
	<li>Support the <tt>:dependent</tt> option on <tt>has_many</tt><tt> </tt><tt>:through</tt> associations. For historical and practical reasons, <tt>:delete_all</tt> is the default deletion strategy employed by <tt>association.delete(*records)</tt>, despite the fact that the default strategy is <tt>:nullify</tt> for regular has_many. Also, this only works at all if the source reflection is a belongs_to. For other situations, you should directly modify the through association.</li>
</ul>
<ul>
	<li>The behavior of <tt>association.destroy</tt> for <tt>has_and_belongs_to_many</tt> and <tt>has_many</tt><tt> </tt><tt>:through</tt> is changed. From now on, ‘destroy’ or ‘delete’ on an association will be taken to mean ‘get rid of the link’, not (necessarily) ‘get rid of the associated records’.</li>
</ul>
<ul>
	<li>Previously, <tt>has_and_belongs_to_many.destroy(*records)</tt> would destroy the records themselves. It would not delete any records in the join table. Now, it deletes the records in the join table.</li>
</ul>
<ul>
	<li>Previously, <tt>has_many_through.destroy(*records)</tt> would destroy the records themselves, and the records in the join table. [Note: This has not always been the case; previous version of Rails only deleted the records themselves.] Now, it destroys only the records in the join table.</li>
</ul>
<ul>
	<li>Note that this change is backwards-incompatible to an extent, but there is unfortunately no way to ‘deprecate’ it before changing it. The change is being made in order to have consistency as to the meaning of ‘destroy’ or ‘delete’ across the different types of associations. If you wish to destroy the records themselves, you can do <tt>records.association.each(&amp;:destroy)</tt>.</li>
</ul>
<ul>
	<li>Add <tt>:bulk</tt><tt> </tt><tt>=&gt;</tt><tt> </tt><tt>true</tt> option to <tt>change_table</tt> to make all the schema changes defined in a block using a single ALTER statement.</li>
</ul>
change_table(:users, :bulk =&gt; true) do |t|

t.string :company_name

t.change :birthdate, :datetime

end
<ul>
	<li>Removed support for accessing attributes on a <tt>has_and_belongs_to_many</tt> join table. <tt>has_many</tt><tt> </tt><tt>:through</tt> needs to be used.</li>
</ul>
<ul>
	<li>Added a <tt>create_association!</tt> method for <tt>has_one</tt> and <tt>belongs_to</tt> associations.</li>
</ul>
<ul>
	<li>Migrations are now reversible<span style="font-family: DejaVu Sans;">可逆</span>, meaning that Rails will figure out how to reverse your migrations. To use reversible migrations, just define the <tt>change</tt> method.</li>
</ul>
class MyMigration &lt; ActiveRecord::Migration

def change

create_table(:horses) do

t.column :content, :text

t.column :remind_at, :datetime

end

end

end
<ul>
	<li>Some things cannot be automatically reversed for you. If you know how to reverse those things, you should define <tt>up</tt> and <tt>down</tt> in your migration. If you define something in change that cannot be reversed, an <tt>IrreversibleMigration</tt> exception will be raised when going down.</li>
</ul>
<ul>
	<li>Migrations now use instance methods rather than class methods:</li>
</ul>
class FooMigration &lt; ActiveRecord::Migration

def up # Not self.up

...

end

end
<ul>
	<li>Migration files generated from model and constructive migration generators (for example, add_name_to_users) use the <strong>reversible</strong><strong> </strong><strong>migration</strong><strong>’</strong><strong>s</strong><strong> </strong><tt>change</tt> method instead of the ordinary <tt>up</tt> and <tt>down</tt> methods.</li>
</ul>
<ul>
	<li>Removed support for interpolating<span style="font-family: DejaVu Sans;">插值</span>string SQL conditions on associations. Instead, a proc should be used.</li>
</ul>
has_many :things, :conditions =&gt; 'foo = #{bar}' # before

has_many :things, :conditions =&gt; proc { "foo = #{bar}" } # after

&nbsp;

Inside the proc, <tt>self</tt> is the object which is the owner of the association, unless you are eager loading the association, in which case <tt>self</tt> is the class which the association is within.

You can have any “normal” conditions inside the proc, so the following will work too:

has_many :things, :conditions =&gt; proc { ["foo = ?", bar] }

&nbsp;
<ul>
	<li>Previously <tt>:insert_sql</tt> and <tt>:delete_sql</tt> on <tt>has_and_belongs_to_many</tt> association allowed you to call ‘record’ to get the record being inserted or deleted. This is now passed as an argument to the proc.</li>
</ul>
<ul>
	<li>Added <tt>ActiveRecord::Base#has_secure_password</tt> (via <tt>ActiveModel::SecurePassword</tt>) to encapsulate dead-simple password usage with BCrypt encryption and salting.</li>
</ul>
# Schema: User(name:string, password_digest:string, password_salt:string)

class User &lt; ActiveRecord::Base

has_secure_password

end

&nbsp;
<ul>
	<li>When a model is generated <tt>add_index</tt> is added by default for <tt>belongs_to</tt> or <tt>references</tt> columns.</li>
</ul>
<ul>
	<li>Setting the id of a <tt>belongs_to</tt> object will update the reference to the object.</li>
</ul>
<ul>
	<li><tt>ActiveRecord::Base#dup</tt> and <tt>ActiveRecord::Base#clone</tt> semantics<span style="font-family: DejaVu Sans;">语义</span>have changed to closer match normal Ruby dup and clone semantics.</li>
</ul>
<ul>
	<li>Calling <tt>ActiveRecord::Base#clone</tt> will result in a shallow copy of the record, including copying the frozen state. No callbacks will be called.</li>
</ul>
<ul>
	<li>Calling <tt>ActiveRecord::Base#dup</tt> will duplicate the record, including calling after initialize hooks. Frozen state will not be copied, and all associations will be cleared. A duped record will return <tt>true</tt> for <tt>new_record?</tt>, have a <tt>nil</tt> id field, and is saveable.</li>
</ul>
<ul>
	<li>The query cache now works with prepared statements. No changes in the applications are required.</li>
</ul>
<h3><a name="active-model"></a>7 Active Model</h3>
<ul>
	<li><tt>attr_accessible</tt> accepts an option <tt>:as</tt> to specify a role.</li>
</ul>
<ul>
	<li><tt>InclusionValidator</tt>, <tt>ExclusionValidator</tt>, and <tt>FormatValidator</tt> now accepts an option which can be a proc, a lambda, or anything that respond to <tt>call</tt>. This option will be called with the current record as an argument and returns an object which respond to <tt>include?</tt> for <tt>InclusionValidator</tt> and <tt>ExclusionValidator</tt>, and returns a regular expression object for <tt>FormatValidator</tt>.</li>
</ul>
<ul>
	<li>Added <tt>ActiveModel::SecurePassword</tt> to encapsulate dead-simple password usage with BCrypt encryption and salting.</li>
</ul>
<ul>
	<li><tt>ActiveModel::AttributeMethods</tt> allows attributes to be defined on demand.</li>
</ul>
<ul>
	<li>Added support for selectively enabling and disabling observers.</li>
</ul>
<ul>
	<li>Alternate <tt>I18n</tt> namespace lookup is no longer supported.</li>
</ul>
<h3><a name="active-resource"></a>8 Active Resource</h3>
<ul>
	<li><strong>The</strong><strong> </strong><strong>default</strong><strong> </strong><strong>format</strong><strong> </strong><strong>has</strong><strong> </strong><strong>been</strong><strong> </strong><strong>changed</strong><strong> </strong><strong>to</strong><strong> </strong><strong>JSON</strong><strong> </strong><strong>for</strong><strong> </strong><strong>all</strong><strong> </strong><strong>requests</strong>. If you want to continue to use XML you will need to set <tt>self.format</tt><tt> </tt><tt>=</tt><tt> </tt><tt>:xml</tt> in the class. For example,</li>
</ul>
class User &lt; ActiveResource::Base

self.format = :xml

end
<h3><a name="active-support"></a>9 Active Support</h3>
<ul>
	<li><tt>ActiveSupport::Dependencies</tt> now raises <tt>NameError</tt> if it finds an existing constant in <tt>load_missing_constant</tt>.</li>
</ul>
<ul>
	<li>Added a new reporting method <tt>Kernel#quietly</tt> which silences both <tt>STDOUT</tt> and <tt>STDERR</tt>.</li>
</ul>
<ul>
	<li>Added <tt>String#inquiry</tt> as a convenience method for turning a String into a <tt>StringInquirer</tt> object.</li>
</ul>
<ul>
	<li>Added <tt>Object#in?</tt> to test if an object is included in another object.</li>
</ul>
<ul>
	<li><tt>LocalCache</tt> strategy is now a real middleware class and no longer an anonymous class.</li>
</ul>
<ul>
	<li><tt>ActiveSupport::Dependencies::ClassCache</tt> class has been introduced for holding references to reloadable classes.</li>
</ul>
<ul>
	<li><tt>ActiveSupport::Dependencies::Reference</tt> has been refactored to take direct advantage of the new <tt>ClassCache</tt>.</li>
</ul>
<ul>
	<li>Backports <tt>Range#cover?</tt> as an alias for <tt>Range#include?</tt> in Ruby 1.8.</li>
</ul>
<ul>
	<li>Added <tt>weeks_ago</tt> and <tt>prev_week</tt> to Date/DateTime/Time.</li>
</ul>
<ul>
	<li>Added <tt>before_remove_const</tt> callback to <tt>ActiveSupport::Dependencies.remove_unloadable_constants!</tt>.</li>
</ul>
Deprecations:
<ul>
	<li><tt>ActiveSupport::SecureRandom</tt> is deprecated in favor of <tt>SecureRandom</tt> from the Ruby standard library.</li>
</ul>
<h3><a name="credits"></a>10 Credits</h3>
See the <a href="http://contributors.rubyonrails.org/"><span style="color: #000080;"><span style="text-decoration: underline;">full</span></span><span style="color: #000080;"><span style="text-decoration: underline;">list</span></span><span style="color: #000080;"><span style="text-decoration: underline;">of</span></span><span style="color: #000080;"><span style="text-decoration: underline;">contributors</span></span><span style="color: #000080;"><span style="text-decoration: underline;">to</span></span><span style="color: #000080;"><span style="text-decoration: underline;">Rails</span></span></a> for the many people who spent many hours making Rails, the stable and robust framework it is. Kudos to all of them.

Rails 3.1 Release Notes were compiled by <a href="https://github.com/vijaydev"><span style="color: #000080;"><span style="text-decoration: underline;">Vijay</span></span><span style="color: #000080;"><span style="text-decoration: underline;">Dev</span></span></a>.

标签： <a href="http://jhjguxin.hwcrazy.com/tag/gem/">gem</a> <a href="http://jhjguxin.hwcrazy.com/tag/git/">git</a> <a href="http://jhjguxin.hwcrazy.com/tag/guide/">guide</a> <a href="http://jhjguxin.hwcrazy.com/tag/jquery/">jquery</a> <a href="http://jhjguxin.hwcrazy.com/tag/learning/">learning</a> <a href="http://jhjguxin.hwcrazy.com/tag/rails/">rails</a> <a href="http://jhjguxin.hwcrazy.com/tag/release/">release</a> <a href="http://jhjguxin.hwcrazy.com/tag/ruby/">ruby</a>
