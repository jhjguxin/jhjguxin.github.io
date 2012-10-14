---
layout: post
title: "A Practical Guide to Use Spine.JS in Real World App."
date: 2012-08-21 13:13
comments: true
categories: [web]
tags: [guide,Spine.JS]
---
## A Practical Guide to Use Spine.JS in Real World App.
To give users the best possible fluid experience, we designed <a href="http://pragmatic.ly/">Pragmatic.ly</a> and complied with the <a title="Single Page Application" href="http://en.wikipedia.org/wiki/Single-page_application" target="_blank">single page application</a> standard. We believe that could make users focus on building product rather than spending time on project management itself. A wide range of technology solutions are available to make a single page application. Current trends suggest moving core application from server to client side and keeping server load at minimum for better performance by pure data APIs. <a href="http://pragmatic.ly/">Pragmatic.ly</a> took on the challange to cater to this need by developing server side in Rails, Spine.js at client side.

<strong>Why Spine.JS</strong>

There are many different JavaScript MVC frameworks such as <a title="Backbone.js" href="http://backbonejs.org/" target="_blank">Backbone.js</a>, <a title="Spine.js" href="http://spinejs.com/" target="_blank">Spine.js</a>, <a title="Knockout.js" href="http://knockoutjs.com/" target="_blank">Knockout.js</a>,<a title="Ember.js" href="http://emberjs.com/" target="_blank">Ember.js</a>, etc. There are too many choices and when I started Pragmatic.ly, I was struggling with the problem of which one I should pick up. Instead of wasting time on choosing I did a quick review by comparing the documents and then decided to choose Spine.js to start with. With months of development so far, I'm glad that Spine.js works pretty well and below are the great benefits I have found in using Spine.js.
<ul>
	<li><em>Simple and lightweight</em>. It's easy to dive into the core and extend as you need to.</li>
	<li><em>MVC pattern at its core</em>. It's very similar to the Rails counterparts. So I'm very comfortable with it from the first day.</li>
	<li><em>Rails integration</em>. It can't be easier to use Rails as the backend data API in Spine.js app. And the <a title="Spine Rails Gem" href="https://github.com/maccman/spine-rails" target="_blank">spine-rails</a> gem is another great addition.</li>
	<li><em><a title="Asynchronous User Interface" href="http://alexmaccaw.com/posts/async_ui" target="_blank">Asynchronous UI</a></em>. Ideally UIs never block and it will automatically update the data in backend. This brings the fast and very responsive user interface.</li>
</ul>
If you want to get a brief review among different frameworks, check out this <a title="Top 10 JavaScript MVC Frameworks Reviewed" href="http://codebrief.com/2012/01/the-top-10-javascript-mvc-frameworks-reviewed/">article</a> written by Gordon L. Hemption.

<strong>How we use Spine.js in Pragmatic.ly</strong>

We use spine-rails to generate the Spine.app structure, very similar to Rails app structure.

&nbsp;
<div id="gist-3370365">
<div>
<div>
<div>
<div id="LC1">├── app</div>
<div id="LC2">│   ├── controllers</div>
<div id="LC3">│   │   ├── center</div>
<div id="LC4">│   │   │   ├── filter_controller.js.coffee</div>
<div id="LC5">│   │   │   └── tickets_controller.js.coffee</div>
<div id="LC6">│   │   ├── center_content_controller.coffee</div>
<div id="LC7">│   │   ├── comments_controller.js.coffee</div>
<div id="LC8">│   │   ├── header</div>
<div id="LC9">│   │   │   └── project_nav_controller.js.coffee</div>
<div id="LC10">│   │   ├── header_controller.coffee</div>
<div id="LC11">│   │   ├── iterations_controller.coffee</div>
<div id="LC12">│   │   ├── left_sidebar_controller.coffee</div>
<div id="LC13">│   │   ├── projects_controller.coffee</div>
<div id="LC14">│   │   ├── right_sidebar_controller.coffee</div>
<div id="LC15">│   │   ├── sidebars</div>
<div id="LC16">│   │   │   ├── left_iteration.js.coffee</div>
<div id="LC17">│   │   │   ├── left_people.js.coffee</div>
<div id="LC18">│   │   │   ├── right_activities.js.coffee</div>
<div id="LC19">│   │   │   └── right_detail_section.js.coffee</div>
<div id="LC20">│   │   ├── tickets_controller.coffee</div>
<div id="LC21">│   │   └── users_controller.js.coffee</div>
<div id="LC22">│   ├── index.js.coffee</div>
<div id="LC23">│   ├── lib</div>
<div id="LC24">│   │   ├── constants.js.coffee</div>
<div id="LC25">│   │   ├── eco-helpers.js</div>
<div id="LC26">│   │   └── view.js.coffee</div>
<div id="LC27">│   ├── models</div>
<div id="LC28">│   │   ├── comment.js.coffee</div>
<div id="LC29">│   │   ├── iteration.js.coffee</div>
<div id="LC30">│   │   ├── project.js.coffee</div>
<div id="LC31">│   │   ├── ticket.js.coffee</div>
<div id="LC32">│   │   └── user.js.coffee</div>
<div id="LC33">│   └── views</div>
<div id="LC34">│   ├── comments</div>
<div id="LC35">│   │   ├── audit.jst.eco</div>
<div id="LC36">│   │   ├── form.jst.eco</div>
<div id="LC37">│   │   └── plain.jst.eco</div>
<div id="LC38">│   ├── iterations</div>
<div id="LC39">│   │   ├── section.jst.eco</div>
<div id="LC40">│   │   └── show.jst.eco</div>
<div id="LC41">│   ├── projects</div>
<div id="LC42">│   │   ├── edit.jst.eco</div>
<div id="LC43">│   │   ├── form.jst.eco</div>
<div id="LC44">│   │   ├── new.jst.eco</div>
<div id="LC45">│   │   └── switch.jst.eco</div>
<div id="LC46">│   ├── tickets</div>
<div id="LC47">│   │   ├── section.jst.eco</div>
<div id="LC48">│   │   ├── show.jst.eco</div>
<div id="LC49">│   │   └── toolbar.jst.eco</div>
<div id="LC50">│   └── users</div>
<div id="LC51">│   ├── people.jst.eco</div>
<div id="LC52">│   └── show.jst.eco</div>
<div id="LC53">├── application.js</div>
<div id="LC54">├── bootstrap.js.coffee</div>
<div id="LC55">└── dashboard.js.coffee</div>
</div>
</div>
<div><a href="https://gist.github.com/raw/3370365/f5a2684f50f33afbe69eeff4cd6747f907e97141/Pragmatic.ly%20JS%20Structure">view raw</a><a href="https://gist.github.com/3370365#file_pragmatic.ly js structure">Pragmatic.ly JS Structure</a><a href="https://gist.github.com/3370365">This Gist</a> brought to you by <a href="http://github.com/">GitHub</a>.</div>
</div>
</div>
&nbsp;

So basically it's controllers, models and views.

<strong>Controllers</strong>

There are two kinds of Controllers in Pragmatic.ly. In Spine, Controllers are considered the glue of an application, adding and responding to DOM events, rendering templates and ensuring that views and models are kept in sync. For example,

&nbsp;
<div id="gist-3370386">
<div>
<div>
<div>
<div id="LC1">class App.LeftIterationController extends Spine.Controller</div>
<div id="LC2">  el: '.sidebar #iterations'</div>
<div id="LC4">  elements:</div>
<div id="LC5">    'ul.list': 'list'</div>
<div id="LC7">  constructor: -&gt;</div>
<div id="LC8">    super</div>
<div id="LC9">    App.Iteration.bind 'create', @addIteration</div>
<div id="LC10">    App.Iteration.bind 'refresh', @refreshIterations</div>
<div id="LC12">  release: -&gt;</div>
<div id="LC13">    super</div>
<div id="LC14">    App.Iteration.unbind 'create', @addIteration</div>
<div id="LC15">    App.Iteration.unbind 'refresh', @refreshIterations</div>
<div id="LC17">  addIteration: (iteration) =&gt;</div>
<div id="LC18">    iteration.unbind()</div>
<div id="LC19">    view = new App.IterationItem(item: iteration)</div>
<div id="LC20">    @list.append(view.render().el)</div>
<div id="LC22">  refreshIterations: (iterations) =&gt;</div>
<div id="LC23">    @addIteration iteration for iteration in iterations</div>
</div>
</div>
<div><a href="https://gist.github.com/raw/3370386/39fe0b331aa7d524f41132056a4ff6e1da432c74/left_iteration_controller.js.coffee">view raw</a><a href="https://gist.github.com/3370386#file_left_iteration_controller.js.coffee">left_iteration_controller.js.coffee</a><a href="https://gist.github.com/3370386">This Gist</a> brought to you by<a href="http://github.com/">GitHub</a>.</div>
</div>
</div>
&nbsp;

We split the page into multiple blocks and each block is a Spine Controller. Talking the above example, LeftIterationsController is the Controller to manage the iterations list in the left sidebar.

Then what's the other kind? The answer is <em>Routes</em>! We extract the routes to the dedicated controllers now. It will setup the routes and respond to the <em>navigation</em> event. Then it will prepare the data and trigger the event to let another controller handle it to render templates. For example,

&nbsp;
<div id="gist-3370398">
<div>
<div>
<div>
<div id="LC1">class App.TicketsController extends Spine.Controller</div>
<div id="LC2">  constructor: -&gt;</div>
<div id="LC3">    super</div>
<div id="LC4">    @routes</div>
<div id="LC5">      "/tickets": @index</div>
<div id="LC6">      "/tickets/:id" : (params) -&gt;</div>
<div id="LC7">        @show(params.id)</div>
<div id="LC9">  index: -&gt;</div>
<div id="LC10">    tickets = App.Ticket.all()</div>
<div id="LC11">    App.Ticket.trigger "tickets:index", tickets</div>
<div id="LC13">  show: (id) -&gt;</div>
<div id="LC14">    ticket = App.Ticket.find(id)</div>
<div id="LC15">    $.publish 'ticket:switch', ticket</div>
</div>
</div>
<div><a href="https://gist.github.com/raw/3370398/6d475eed1c1c593ca1338cdc2681be3b1ec9dd6d/ticket_routing_controller.js.coffee">view raw</a><a href="https://gist.github.com/3370398#file_ticket_routing_controller.js.coffee">ticket_routing_controller.js.coffee</a><a href="https://gist.github.com/3370398">This Gist</a> brought to you by<a href="http://github.com/">GitHub</a>.</div>
</div>
</div>
&nbsp;

<strong>Models</strong>

Models manage data for the application. It's very similar to Rails models. I just want to mention one thing though - as we moved the logic from server side to client side, there was no need to translate 1:1 on the client side. Instead, encapsulate the data into model which is suitable for the page based on the user.

&nbsp;
<div id="gist-3370424">
<div>
<div>
<div>
<div id="LC1">class App.Project extends Spine.Model</div>
<div id="LC2">  @configure 'Project', 'id', 'name', 'description', 'owner_id', 'uid'</div>
<div id="LC3">  @extend Spine.Model.Ajax</div>
<div id="LC4">  @extend Spine.Model.Dirty</div>
<div id="LC6">  validate: -&gt;</div>
<div id="LC7">    'name required' unless @name</div>
<div id="LC9">  inviteUser: (email) -&gt;</div>
<div id="LC10">    App.Invitation.create(project_id: @id, email: email)</div>
</div>
</div>
<div><a href="https://gist.github.com/raw/3370424/e79540cdbabd4cde1b1e2c142b3a26caba6e5da4/project.js.coffee">view raw</a><a href="https://gist.github.com/3370424#file_project.js.coffee">project.js.coffee</a><a href="https://gist.github.com/3370424">This Gist</a> brought to you by <a href="http://github.com/">GitHub</a>.</div>
</div>
</div>
&nbsp;

<strong>Views</strong>

Views are about building and maintaining the DOM elements. Views in Spine are very simple and don't have the built-in UI binding. So most of the time you should let Controller observe the Model and get notified when the model changes, then update the view accordingly.

By doing all the view rendering client-side, you should use JavaScript templating solution to define templates for views as markup containing tempalte variables. There are a number of good candidates, such as <a title="Mustache" href="http://mustache.github.com/" target="_blank">Mustache</a>, <a title="jQuery Template" href="http://api.jquery.com/category/plugins/templates" target="_blank">jQuery.tmpl</a> and <a title="Eco" href="https://github.com/sstephenson/eco" target="_blank">Eco</a>.

I use Eco in Pragmatic.ly. The Erb-like syntax and CoffeeScript support is a big triumph. However, you should know that every eco template generates the same helpers which will increase the file size. You can use this gist to avoid the problem which will register the global helpers and inject into the Eco templates.

&nbsp;
<div id="gist-2360781">
<div>
<div>
<div>
<div id="LC1"># Put this file in lib/</div>
<div id="LC3">require 'sprockets/eco_template'</div>
<div id="LC5">class CleanEcoTemplate &lt; Sprockets::EcoTemplate</div>
<div id="LC6">  FROM = " (function() {"</div>
<div id="LC7">  TO = "}).call(__obj);"</div>
<div id="LC9">  def evaluate(scope, locals, &amp;block)</div>
<div id="LC10">    content = Eco.compile(data)</div>
<div id="LC11">    from = content.index(FROM)</div>
<div id="LC12">    to = content.rindex(TO)</div>
<div id="LC13">    content = content[from...to] + TO</div>
<div id="LC14">    &lt;&lt;-JS</div>
<div id="LC15">function(__obj) {</div>
<div id="LC16">if (!__obj) __obj = {};</div>
<div id="LC17">var __helpers = window.ecoHelpers;</div>
<div id="LC18">var __out = [];</div>
<div id="LC19">var __sanitize = __helpers.sanitize;</div>
<div id="LC20">var __capture = __helpers.captureFor(__obj, __out);</div>
<div id="LC21">var __rememberSafe = __obj.safe;</div>
<div id="LC22">var __rememberEscape = __obj.escape;</div>
<div id="LC23">__obj.safe = __helpers.safe;</div>
<div id="LC24">__obj.escape = __helpers.escape;</div>
<div id="LC25">#{content}</div>
<div id="LC26">__obj.safe = __rememberSafe;</div>
<div id="LC27">__obj.escape = __rememberEscape;</div>
<div id="LC28">return __out.join('');</div>
<div id="LC29">};</div>
<div id="LC30">JS</div>
<div id="LC31">  end</div>
<div id="LC32">end</div>
</div>
</div>
<div><a href="https://gist.github.com/raw/2360781/8b3b00534fea091b4514589460e99deb2abfe618/clean_eco_template.rb">view raw</a><a href="https://gist.github.com/2360781#file_clean_eco_template.rb">clean_eco_template.rb</a><a href="https://gist.github.com/2360781">This Gist</a> brought to you by <a href="http://github.com/">GitHub</a>.</div>
</div>
<div>
<div>
<div>
<div id="LC1"># Must include eco-helpers.js before eco files</div>
<div id="LC3">(function(global) {</div>
<div id="LC4">  var ecoHelpers = {</div>
<div id="LC5">    sanitize: function(value) {</div>
<div id="LC6">      if (value &amp;&amp; value.ecoSafe) {</div>
<div id="LC7">        return value;</div>
<div id="LC8">      } else if (typeof value !== 'undefined' &amp;&amp; value != null) {</div>
<div id="LC9">        return ecoHelpers.escape(value);</div>
<div id="LC10">      } else {</div>
<div id="LC11">        return '';</div>
<div id="LC12">      }</div>
<div id="LC13">    },</div>
<div id="LC15">    safe: function(value) {</div>
<div id="LC16">      if (value &amp;&amp; value.ecoSafe) {</div>
<div id="LC17">        return value;</div>
<div id="LC18">      } else {</div>
<div id="LC19">        if (!(typeof value !== 'undefined' &amp;&amp; value != null)) value = '';</div>
<div id="LC20">        var result = new String(value);</div>
<div id="LC21">        result.ecoSafe = true;</div>
<div id="LC22">        return result;</div>
<div id="LC23">      }</div>
<div id="LC24">    },</div>
<div id="LC26">    escape: function(value) {</div>
<div id="LC27">      return ('' + value)</div>
<div id="LC28">        .replace(/&amp;/g, '&amp;amp;')</div>
<div id="LC29">        .replace(/&lt;/g, '&amp;lt;')</div>
<div id="LC30">        .replace(/&gt;/g, '&amp;gt;')</div>
<div id="LC31">        .replace(/"/g, '&amp;quot;');</div>
<div id="LC32">    },</div>
<div id="LC34">    captureFor: function(obj, out) {</div>
<div id="LC35">      return (function(callback) {</div>
<div id="LC36">        var length = out.length;</div>
<div id="LC37">        callback.call(obj);</div>
<div id="LC38">        return ecoHelpers.safe(out.splice(length, out.length - length).join(''));</div>
<div id="LC39">      });</div>
<div id="LC40">    }</div>
<div id="LC41">  };</div>
<div id="LC43">  global.ecoHelpers = ecoHelpers;</div>
<div id="LC44">})(window);</div>
</div>
</div>
<div><a href="https://gist.github.com/raw/2360781/9aa691027d57ddd63ec7f6969481336789539248/eco-helpers.js">view raw</a><a href="https://gist.github.com/2360781#file_eco_helpers.js">eco-helpers.js</a><a href="https://gist.github.com/2360781">This Gist</a> brought to you by <a href="http://github.com/">GitHub</a>.</div>
</div>
<div>
<div>
<div>
<div id="LC1"># Put this file in config/initializers</div>
<div id="LC3">require 'clean_eco_template'</div>
<div id="LC5">Rails.application.assets.register_engine '.eco', CleanEcoTemplate</div>
</div>
</div>
<div><a href="https://gist.github.com/raw/2360781/7ccb944d8613edd073dddd34547bcdaa766eefa6/eco_template.rb">view raw</a><a href="https://gist.github.com/2360781#file_eco_template.rb">eco_template.rb</a><a href="https://gist.github.com/2360781">This Gist</a> brought to you by <a href="http://github.com/">GitHub</a>.</div>
</div>
</div>
&nbsp;

<strong>Problems</strong>

So that's how we use Spine.js to power Pragmatic.ly. It works very well but still have some limitations.
<ul>
	<li>By default, you can only monitor the whole Model change event and update the view accordingly. For example, even the username is not changed, you still have to update the views containing that data. There is a "change:field" event in Backbone.js which allow you only to update the view when that field of data changed. I like that. So I made a plugin to support that. Check the Gist out.
<div id="gist-2866558">
<div>
<div>
<div>
<div id="LC1">Spine ?= require('spine')</div>
<div id="LC3">Include =</div>
<div id="LC4">  savePrevious: -&gt;</div>
<div id="LC5">    @constructor.records[@id].previousAttributes = @attributes()</div>
<div id="LC7">Spine.Model.Dirty =</div>
<div id="LC8">  extended: -&gt;</div>
<div id="LC9">    @bind 'refresh', -&gt;</div>
<div id="LC10">      @each (record) -&gt; record.savePrevious()</div>
<div id="LC12">    @bind 'save', (record) -&gt;</div>
<div id="LC13">      if record.previousAttributes?</div>
<div id="LC14">        for key in record.constructor.attributes when key of record</div>
<div id="LC15">          if record[key] isnt record.previousAttributes[key]</div>
<div id="LC16">            record.trigger('change:'+key, record[key])</div>
<div id="LC17">      record.savePrevious()</div>
<div id="LC19">    @include Include</div>
</div>
</div>
<div><a href="https://gist.github.com/raw/2866558/515b724d2e7b4b648e5f10c9ef93782f3242c9cd/dirty.js.coffee">view raw</a><a href="https://gist.github.com/2866558#file_dirty.js.coffee">dirty.js.coffee</a><a href="https://gist.github.com/2866558">This Gist</a> brought to you by <a href="http://github.com/">GitHub</a>.</div>
</div>
<div>
<div>
<div>
<div id="LC1">So the model object can bind the event "change:#{field} to trigger event when the field value is changed.</div>
<div id="LC3">By default it's off and if need this feature, the model should extend Spine.Model.Dirty.</div>
<div id="LC5">A sample case.</div>
<div id="LC7">class User extends Spine.Model</div>
<div id="LC8">  @extend Spine.Model.Dirty</div>
<div id="LC9">end</div>
</div>
</div>
<div><a href="https://gist.github.com/raw/2866558/568e3e12fd1a160d5cedd5a476edd202622d110b/Usage:">view raw</a><a href="https://gist.github.com/2866558#file_usage:">Usage:</a><a href="https://gist.github.com/2866558">This Gist</a> brought to you by <a href="http://github.com/">GitHub</a>.</div>
</div>
</div></li>
	<li>The Ajax plugin in Spine.js plays very nice with backend REST APIs, such as Rails. For example, creating the model will trigger a "CREATE /collections" event to the server and updating the model will trigger a "PUT /collections/id" event, seemlessly. However, nested resources in Rails is very common but Spine lacks to support that. Either you have to trigger requests to top-level URL or setup the request yourself. I have done a dirty hack to support scoping. It's dirty but works.
<div id="gist-3371899">
<div>
<div>
<div>
<div id="LC1">class App.Ticket extends Spine.Model</div>
<div id="LC2">  @configure 'Ticket', "id", "project_id"</div>
<div id="LC4">  @scope: -&gt;</div>
<div id="LC5">    "projects/#{current.project_id}"</div>
<div id="LC7">  scope: -&gt;</div>
<div id="LC8">    "projects/#{@project_id}"</div>
</div>
</div>
<div><a href="https://gist.github.com/raw/3371899/ec5a4177783ce2827796895f6b7c886f6f3643a6/url_scoping.js.coffee">view raw</a><a href="https://gist.github.com/3371899#file_url_scoping.js.coffee">url_scoping.js.coffee</a><a href="https://gist.github.com/3371899">This Gist</a> brought to you by <a href="http://github.com/">GitHub</a>.</div>
</div>
</div></li>
	<li>Asynchronous UI is cool and works for 99% situations. But in a real world app you have to deal with errors like bugs or network failures. Spine doesn't have the default error handling for this situation and leave all work to you. It's fine but you should know that for that 1% situation, you have to spend lots of time to avoid the impact.</li>
</ul>
<strong>Test</strong>

I would like to cover how Test works in Pragmatic.ly in another post. To give a quick overview, we use <a title="JavaScript Behavior Test Framework" href="http://pivotal.github.com/jasmine/" target="_blank">Jasmine</a> for JS test and <a title="JavaScript Code Coverage Tool" href="http://siliconforks.com/jscoverage/" target="_blank">JSCoverage</a> for measuring code coverage. Nice pair!

&nbsp;

<strong>About Pragmatic.ly</strong>

<a title="Fast &amp; easy to use project management tool &amp; real-time collaboration" href="https://pragmatic.ly/">Pragmatic.ly</a> is a fast and easy to use project management tool featuring real time collaboration. It's an elegant project management service built for developers with love.

&nbsp;

Now that you've read so far, you should follow me <a title="yedingding's twitter" href="https://twitter.com/yedingding" target="_blank">@yedingding</a>!
