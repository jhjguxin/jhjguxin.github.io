---
layout: post
title: "Rails 3.1 Engines – Mountable or Full? – Part 2"
date: 2012-04-09 18:40
comments: true
categories: [rails,ruby]
tags: [engine,mountable,rails]
---
## Rails 3.1 Engines – Mountable or Full? – Part 2
<div>

This is a continuation of my post <a title="http://www.astjohn.ca/blog/rails-31-engines-mountable-or-full-part-1" href="http://www.astjohn.ca/blog/rails-31-engines-mountable-or-full-part-1" target="_blank">Rails 3.1 Engines – Mountable or Full? – Part 1</a> which highlights some key features of a full engine. There are a few differences with a mountable engine, which I will try to explain below.
<h2>Mountable Engines</h2>
<h3>Engine Details</h3>
To generate a mountable engine, run <code>rails plugin new myengine --mountable</code> on the console. This will generate the engine’s basic structure.

The first difference I noted with a mountable engine is that, by default, the engine is namespaced. The engine’s starting config is:
<div>
<div id="highlighter_331397">
<div><a href="http://www.astjohn.ca/2011/08/07/rails-31-engines-mountable-or-full-part-2#">?</a></div>
<table border="0" cellspacing="0" cellpadding="0">
<tbody>
<tr>
<td>
<div>1</div>
<div>2</div>
<div>3</div>
<div>4</div>
<div>5</div>
<div>6</div>
<div>7</div></td>
<td>
<div>
<div><code>module</code> <code>MyEngine </code></div>
<div><code># my_engine/lib/my_engine/engine.rb </code></div>
<div><code> </code></div>
<div><code>  </code><code>class</code> <code>Engine &lt; Rails::Engine </code></div>
<div><code>    </code><code>isolate_namespace MyEngine </code></div>
<div><code>  </code><code>end</code></div>
<div><code>end</code></div>
</div></td>
</tr>
</tbody>
</table>
</div>
</div>
Since the engine has an isolated namespace, the controllers, models, helpers, etc. are all bundled within the module <em>MyEngine</em>. The folder structure reflects this change as well. Unlike a full engine, the mountable engine generated the typical assets that are normally associated with a Rails application, namely <em>application.js</em>, <em>application.css</em>, and <em>application_controller.rb</em>. Note the namespacing that occurs with the application controller:
<div>
<div id="highlighter_591938">
<div><a href="http://www.astjohn.ca/2011/08/07/rails-31-engines-mountable-or-full-part-2#">?</a></div>
<table border="0" cellspacing="0" cellpadding="0">
<tbody>
<tr>
<td>
<div>1</div>
<div>2</div>
<div>3</div>
<div>4</div>
<div>5</div>
<div>6</div></td>
<td>
<div>
<div><code># my_engine/app/controllers/my_engine/application_controller.rb </code></div>
<div><code> </code></div>
<div><code>module</code> <code>MyEngine </code></div>
<div><code>  </code><code>class</code> <code>ApplicationController &lt; ActionController::Base </code></div>
<div><code>  </code><code>end</code></div>
<div><code>end</code></div>
</div></td>
</tr>
</tbody>
</table>
</div>
</div>
This namespacing occurs throughout the engine. There are subtle differences in terms of routing as well. With a mountable engine, the engine’s route file looks like this:
<div>
<div id="highlighter_217802">
<div><a href="http://www.astjohn.ca/2011/08/07/rails-31-engines-mountable-or-full-part-2#">?</a></div>
<table border="0" cellspacing="0" cellpadding="0">
<tbody>
<tr>
<td>
<div>1</div>
<div>2</div>
<div>3</div>
<div>4</div>
<div>5</div></td>
<td>
<div>
<div><code># my_engine/config/routes.rb </code></div>
<div><code> </code></div>
<div><code>MyEngine::Engine.routes.draw </code><code>do</code></div>
<div><code>  </code><code># route stuff goes here </code></div>
<div><code>end</code></div>
</div></td>
</tr>
</tbody>
</table>
</div>
</div>
Remember, the full application’s routes start with <code>Rails.application.routes.draw</code>. The dummy application’s routes file was generated as:
<div>
<div id="highlighter_791594">
<div><a href="http://www.astjohn.ca/2011/08/07/rails-31-engines-mountable-or-full-part-2#">?</a></div>
<table border="0" cellspacing="0" cellpadding="0">
<tbody>
<tr>
<td>
<div>1</div>
<div>2</div>
<div>3</div>
<div>4</div>
<div>5</div>
<div>6</div></td>
<td>
<div>
<div><code># my_engine/test/dummy/config/routes.rb </code></div>
<div><code> </code></div>
<div><code>Rails.application.routes.draw </code><code>do</code></div>
<div><code> </code></div>
<div><code>  </code><code>mount MyEngine::Engine =&gt; </code><code>"/my_engine"</code></div>
<div><code>end</code></div>
</div></td>
</tr>
</tbody>
</table>
</div>
</div>
Notice that the engine is bundled under a “mounted” route at <em>/my_engine</em>. This means that all of the engine’s functionality will be located under the engine’s root location of <em>/my_engine</em> within the dummy (parent) application. This type of structure suggests that a mountable engine is best suited for situations when a developer wants the engine to behave as its own application operating in parallel with the parent application. Most of the engine’s features are isolated and independent of the parent application. To test this, I plugged the mountable engine into a test application.
<h3>Routing</h3>
I used a model within the engine called “Post”, along with the migration, controller, and helper to match (<code>rails generate scaffold post title:string body:text</code>). Now my engine’s routes file looks like this:
<div>
<div id="highlighter_669702">
<div><a href="http://www.astjohn.ca/2011/08/07/rails-31-engines-mountable-or-full-part-2#">?</a></div>
<table border="0" cellspacing="0" cellpadding="0">
<tbody>
<tr>
<td>
<div>1</div>
<div>2</div>
<div>3</div>
<div>4</div>
<div>5</div></td>
<td>
<div>
<div><code># my_engine/config/routes.rb </code></div>
<div><code> </code></div>
<div><code>MyEngine::Engine.routes.draw </code><code>do</code></div>
<div><code>  </code><code>resources </code><code>:posts</code></div>
<div><code>end</code></div>
</div></td>
</tr>
</tbody>
</table>
</div>
</div>
With a full engine, the <em>Post</em> routes were included directly into the parent application automatically. This time, using the mountable engine and running <code>rake routes</code> within the parent application, nothing happened! That’s because I did not mount the engine in a similar manner to what the dummy application in our engine is using. The parent application’s route file had to be adjusted like so:
<div>
<div id="highlighter_791424">
<div><a href="http://www.astjohn.ca/2011/08/07/rails-31-engines-mountable-or-full-part-2#">?</a></div>
<table border="0" cellspacing="0" cellpadding="0">
<tbody>
<tr>
<td>
<div>1</div>
<div>2</div>
<div>3</div>
<div>4</div>
<div>5</div></td>
<td>
<div>
<div><code># parent_app/config/routes.rb </code></div>
<div><code> </code></div>
<div><code>ParentApp::Application.routes.draw </code><code>do</code></div>
<div><code> </code><code>mount MyEngine::Engine =&gt; </code><code>"/my_engine"</code></div>
<div><code>end</code></div>
</div></td>
</tr>
</tbody>
</table>
</div>
</div>
<code>rake routes</code> now produced the following:
<div>
<div id="highlighter_402176">
<div><a href="http://www.astjohn.ca/2011/08/07/rails-31-engines-mountable-or-full-part-2#">?</a></div>
<table border="0" cellspacing="0" cellpadding="0">
<tbody>
<tr>
<td>
<div>1</div></td>
<td>
<div>
<div><code>my_engine  /my_engine {</code><code>:to</code><code>=&gt;MyEngine::Engine}</code></div>
</div></td>
</tr>
</tbody>
</table>
</div>
</div>
…and that’s it. All of the engine’s functionality is bundled into the parent application underneath the route <em>/my_engine</em>.

After running <code>rake my_engine:install:migrations</code> and <code>rake db:migrate</code> in the parent application, I was ready to test how the engine’s controllers and helpers would integrate. [note: running migrations from an isolated engine will prefix your database tables with the engine name]. As with the full engine, I established a simple view template:
<div>
<div id="highlighter_339249">
<div><a href="http://www.astjohn.ca/2011/08/07/rails-31-engines-mountable-or-full-part-2#">?</a></div>
<table border="0" cellspacing="0" cellpadding="0">
<tbody>
<tr>
<td>
<div>1</div>
<div>2</div>
<div>3</div></td>
<td>
<div>
<div><code># my_engine/app/views/my_engine/posts/index.html.erb </code></div>
<div><code> </code></div>
<div><code>&lt;p&gt;Hi There!&lt;/p&gt;</code></div>
</div></td>
</tr>
</tbody>
</table>
</div>
</div>
Of course, navigating to <em>/my_engine/posts</em> in the parent application showed an almost blank page with the words “Hi There!” The controller actions and views from the engine were incorporated into the parent application, but only under the namespaced route <em>/my_engine</em>.

Next, I tested if the view could be overridden by the parent application. I created a new view template for the <em>Post</em> index action within the parent application that looked like this:
<div>
<div id="highlighter_91729">
<div><a href="http://www.astjohn.ca/2011/08/07/rails-31-engines-mountable-or-full-part-2#">?</a></div>
<table border="0" cellspacing="0" cellpadding="0">
<tbody>
<tr>
<td>
<div>1</div>
<div>2</div>
<div>3</div></td>
<td>
<div>
<div><code># parent_app/app/views/posts/index.html.erb </code></div>
<div><code> </code></div>
<div><code>&lt;p&gt;Good Bye!&lt;/p&gt;</code></div>
</div></td>
</tr>
</tbody>
</table>
</div>
</div>
No change and of course not! Our engine is namespaced, remember? Instead, I moved the template to <code>parent_app/app/views/my_engine/posts/index.html.erb</code>. Now visiting <em>/my_engine/posts</em> in the parent application showed “Good Bye!” That’s better. Next I decided to test out the engine’s helpers. I added a method to the Post helper inside the engine.
<div>
<div id="highlighter_125857">
<div><a href="http://www.astjohn.ca/2011/08/07/rails-31-engines-mountable-or-full-part-2#">?</a></div>
<table border="0" cellspacing="0" cellpadding="0">
<tbody>
<tr>
<td>
<div>1</div>
<div>2</div>
<div>3</div>
<div>4</div>
<div>5</div>
<div>6</div>
<div>7</div>
<div>8</div>
<div>9</div></td>
<td>
<div>
<div><code># my_engine/app/helpers/my_engine/posts_helper.rb </code></div>
<div><code> </code></div>
<div><code>module</code> <code>MyEngine </code></div>
<div><code>  </code><code>module</code> <code>PostsHelper </code></div>
<div><code>    </code><code>def</code> <code>test </code></div>
<div><code>      </code><code>raw(</code><code>"&lt;p&gt;hello world&lt;/p&gt;"</code><code>) </code></div>
<div><code>    </code><code>end</code></div>
<div><code>  </code><code>end</code></div>
<div><code>end</code></div>
</div></td>
</tr>
</tbody>
</table>
</div>
</div>
I then changed the parent application’s view template to use the helper.
<div>
<div id="highlighter_710583">
<div><a href="http://www.astjohn.ca/2011/08/07/rails-31-engines-mountable-or-full-part-2#">?</a></div>
<table border="0" cellspacing="0" cellpadding="0">
<tbody>
<tr>
<td>
<div>1</div>
<div>2</div>
<div>3</div>
<div>4</div></td>
<td>
<div>
<div><code># parent_app/app/views/posts/index.html.erb </code></div>
<div><code> </code></div>
<div><code>&lt;p&gt;Good Bye!&lt;/p&gt; </code></div>
<div><code>&lt;%= test %&gt;</code></div>
</div></td>
</tr>
</tbody>
</table>
</div>
</div>
Visiting the page resulted in the words “Good Bye!” and “hello world.” Therefore, the engine’s helper methods were directly exposed to the parent application, allowing the parent to use them.

To be honest, I did not expect this to work. There is a section in the <a href="https://github.com/rails/rails/blob/master/railties/lib/rails/engine.rb" target="_blank">Rails comments</a> about sharing an isolated engine’s helpers with the parent application by using <code>helper MyEngine::Engine.helpers</code> in the application controller of the parent. It states that in doing so “[the parent application] will include all of the helpers from engine’s directory.” Perhaps this is a bug in the release candidates of Rails 3.1? Maybe my interpretation of the instructions is way off? I’m not sure. If this does change by the time you use it, and you can’t access the engine’s helpers, I suggest trying the method described.
<h3>Summary</h3>
It seems as though mountable engines are best suited as complete applications in themselves which run along side a parent application. The engine routes, controllers, models, helpers, etc. are namespaced and bundled into the mounted route within the parent application, thus avoiding namespace conflicts. If I’m way off in my assessment or there are other things which I have missed, drop me a line and I’ll add them!

</div>
&nbsp;
