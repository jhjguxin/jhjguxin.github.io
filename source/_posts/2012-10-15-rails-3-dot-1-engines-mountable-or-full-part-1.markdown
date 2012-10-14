---
layout: post
title: "Rails 3.1 Engines – Mountable or Full? – Part 1"
date: 2012-04-09 18:39
comments: true
categories: ["rails", "ruby"]
tags: ["engine", "mountable", "rails"]
---
## Rails 3.1 Engines – Mountable or Full? – Part 1
<div>

I decided to create my <a href="https://www.github.com/astjohn/cornerstone" target="_blank">first rails engine</a> about a week or so ago.  I figured this was a great way to learn Rails 3.1 and the new engine generator; however, I quickly ran into a problem.  Do I want a mountable or full engine?  <a title="http://stackoverflow.com/questions/6118905/rails-3-1-engine-vs-mountable-app" href="http://stackoverflow.com/questions/6118905/rails-3-1-engine-vs-mountable-app" target="_blank">What’s the difference anyway?</a>  At the time, a quick google search showed that not many people really knew. The Rails <a href="https://github.com/rails/rails/blob/master/railties/lib/rails/engine.rb">code comments</a> are great, but after reading them, I was still a bit confused.  For those of you out there in the same boat, here’s my attempt at highlighting some of the differences.
<h2>Full Engines</h2>
<h3>Engine Details</h3>
To generate a full engine, run <code>rails plugin new myengine --full</code> on the console. This will generate the engine’s basic structure.

The first thing I noticed was that the typical assets associated with a normal Rails application were not generated; <em>application.js</em> and <em>application.css</em> were not created. In fact, the application controller was completely omitted, alluding that perhaps a full engine is feared toward supplementing a parent application only. As far as routing goes, the engine’s route looked like this:
<div>
<div id="highlighter_57643">
<div><a href="http://www.astjohn.ca/2011/08/06/rails-31-engines-mountable-or-full-part-1/#">?</a></div>
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
<div><code># my_engine/config/routes.rb </code></div>
<div><code> </code></div>
<div><code>Rails.application.routes.draw </code><code>do</code></div>
<div><code>end</code></div>
</div></td>
</tr>
</tbody>
</table>
</div>
</div>
… and the dummy application’s routes file looked like this:
<div>
<div id="highlighter_162083">
<div><a href="http://www.astjohn.ca/2011/08/06/rails-31-engines-mountable-or-full-part-1/#">?</a></div>
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
<div><code># my_engine/test/dummy/config/routes.rb </code></div>
<div><code> </code></div>
<div><code>Dummy::Application.routes.draw </code></div>
<div><code>  </code><code># route stuff </code></div>
<div><code>end</code></div>
</div></td>
</tr>
</tbody>
</table>
</div>
</div>
Another item that was missing from the basic application structure was the database folder. For engine configuration, a full engine is not namespaced, so the <em>engine.rb</em> file was essentially blank.
<div>
<div id="highlighter_367735">
<div><a href="http://www.astjohn.ca/2011/08/06/rails-31-engines-mountable-or-full-part-1/#">?</a></div>
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
<div><code># my_engine/lib/my_engine/engine.rb </code></div>
<div><code> </code></div>
<div><code>module</code> <code>MyEngine </code></div>
<div><code>  </code><code>class</code> <code>Engine &lt; Rails::Engine </code></div>
<div><code>  </code><code>end</code></div>
<div><code>end</code></div>
</div></td>
</tr>
</tbody>
</table>
</div>
</div>
Now, the <a title="https://github.com/rails/rails/blob/master/railties/lib/rails/engine.rb" href="https://github.com/rails/rails/blob/master/railties/lib/rails/engine.rb" target="_blank">rails comments</a> state that engines allow you to add a “subset of functionality to an existing Rails application.” Since the full engine is missing an application controller, it seems that its purpose is to plug into an existing application without namespacing to add functionality to the parent application. To test this theory, I generated a new application and referenced my engine in the parent application’s Gemfile.
<h3>Routing</h3>
Since the engine is not namespaced, the engine’s routes are incorporated into the parent application’s routes directly. To test this, I created a model within the engine called “Post”, along with the migration, controller, and helper to match. To create the migration, I also had to build the <em>my_engine/db/migrate/</em> folder, which was not created when I generated the engine. Running <code>rake routes</code> within the parent application resulted in the following:
<div>
<div id="highlighter_215592">
<div><a href="http://www.astjohn.ca/2011/08/06/rails-31-engines-mountable-or-full-part-1/#">?</a></div>
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
<div><code>    </code><code>posts </code><code>GET</code>    <code>/posts(.</code><code>:format</code><code>)          {</code><code>:action</code><code>=&gt;</code><code>"index"</code><code>, </code><code>:controller</code><code>=&gt;</code><code>"posts"</code><code>} </code></div>
<div><code>          </code><code>POST</code>   <code>/posts(.</code><code>:format</code><code>)          {</code><code>:action</code><code>=&gt;</code><code>"create"</code><code>, </code><code>:controller</code><code>=&gt;</code><code>"posts"</code><code>} </code></div>
<div><code> </code><code>new_post </code><code>GET</code>    <code>/posts/</code><code>new</code><code>(.</code><code>:format</code><code>)      {</code><code>:action</code><code>=&gt;</code><code>"new"</code><code>, </code><code>:controller</code><code>=&gt;</code><code>"posts"</code><code>} </code></div>
<div><code>edit_post </code><code>GET</code>    <code>/posts/</code><code>:id</code><code>/edit(.</code><code>:format</code><code>) {</code><code>:action</code><code>=&gt;</code><code>"edit"</code><code>, </code><code>:controller</code><code>=&gt;</code><code>"posts"</code><code>} </code></div>
<div><code>     </code><code>post </code><code>GET</code>    <code>/posts/</code><code>:id</code><code>(.</code><code>:format</code><code>)      {</code><code>:action</code><code>=&gt;</code><code>"show"</code><code>, </code><code>:controller</code><code>=&gt;</code><code>"posts"</code><code>} </code></div>
<div><code>          </code><code>PUT</code>    <code>/posts/</code><code>:id</code><code>(.</code><code>:format</code><code>)      {</code><code>:action</code><code>=&gt;</code><code>"update"</code><code>, </code><code>:controller</code><code>=&gt;</code><code>"posts"</code><code>} </code></div>
<div><code>          </code><code>DELETE</code> <code>/posts/</code><code>:id</code><code>(.</code><code>:format</code><code>)      {</code><code>:action</code><code>=&gt;</code><code>"destroy"</code><code>, </code><code>:controller</code><code>=&gt;</code><code>"posts"</code><code>}</code></div>
</div></td>
</tr>
</tbody>
</table>
</div>
</div>
As you can see, the Post routes from the engine were included directly into the parent application.

After running <code>rake my_engine:install:migrations</code> and <code>rake db:migrate</code> in the parent application, I was ready to test how the engine’s controllers and helpers would integrate. In my engine, I had a simple view template:
<div>
<div id="highlighter_606207">
<div><a href="http://www.astjohn.ca/2011/08/06/rails-31-engines-mountable-or-full-part-1/#">?</a></div>
<table border="0" cellspacing="0" cellpadding="0">
<tbody>
<tr>
<td>
<div>1</div>
<div>2</div>
<div>3</div></td>
<td>
<div>
<div><code># my_engine/app/views/posts/index.html.erb </code></div>
<div><code> </code></div>
<div><code>&lt;p&gt;Hi There!&lt;/p&gt;</code></div>
</div></td>
</tr>
</tbody>
</table>
</div>
</div>
Of course, navigating to <em>/posts</em> in the parent application showed an almost blank page with the words “Hi There!” The controller actions and views from the engine were incorporated into the parent application.

One helpful feature of engines is the fact that their controller methods and views can be overridden simply by placing similar files within the parent application. For example, I created a new view template for the Post index action within the parent application that looked like this:
<div>
<div id="highlighter_860835">
<div><a href="http://www.astjohn.ca/2011/08/06/rails-31-engines-mountable-or-full-part-1/#">?</a></div>
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
Now visiting <em>/posts</em> in the parent application shows “Good Bye!” That’s great, but what about the engine’s helpers? I tested that functionality by adding a method to the Post helper back inside the engine.
<div>
<div id="highlighter_870319">
<div><a href="http://www.astjohn.ca/2011/08/06/rails-31-engines-mountable-or-full-part-1/#">?</a></div>
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
<div><code># my_engine/app/helpers/posts_helper.rb </code></div>
<div><code> </code></div>
<div><code>module</code> <code>PostsHelper </code></div>
<div><code> </code></div>
<div><code>  </code><code>def</code> <code>test </code></div>
<div><code>    </code><code>raw(</code><code>"&lt;p&gt;hello world&lt;/p&gt;"</code><code>) </code></div>
<div><code>  </code><code>end</code></div>
<div><code> </code></div>
<div><code>end</code></div>
</div></td>
</tr>
</tbody>
</table>
</div>
</div>
I then changed the parent application’s view template to use the helper.
<div>
<div id="highlighter_258772">
<div><a href="http://www.astjohn.ca/2011/08/06/rails-31-engines-mountable-or-full-part-1/#">?</a></div>
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
This time, visiting the page again in the parent application resulted in the words “Good Bye!” and “hello world.” Therefore, the engine’s helper methods were directly exposed to the parent application, allowing the parent to use them.
<h3>Summary</h3>
In summary, it seems as though full engines are best suited to augment a parent application. The engine routes, controllers, models, helpers, etc. are exposed to the parent application which allows for easy access, but could result in namespace conflicts.

It looks like this post is getting a bit lengthy so I’ll stop it here and talk about mountable engines soon.

</div>
&nbsp;
