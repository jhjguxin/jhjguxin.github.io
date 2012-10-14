---
layout: post
title: "Ruby on Rails 4.0 Release Notes"
date: 2012-10-06 19:46
comments: true
categories: [rails]
tags: [Rails 4.0]
---
## Ruby on Rails 4.0 Release Notes
<h1>sources:</h1>
<a href="https://github.com/rails/rails/blob/master/guides/source/4_0_release_notes.md">https://github.com/rails/rails/blob/master/guides/source/4_0_release_notes.md</a>

<a href="http://edgeguides.rubyonrails.org/4_0_release_notes.html">http://edgeguides.rubyonrails.org/4_0_release_notes.html</a>
<h1>Ruby on Rails 4.0 Release Notes</h1>
Highlights in Rails 4.0: (WIP)
<ul>
	<li>Ruby 1.9.3 only</li>
	<li>Strong Parameters</li>
	<li>Queue API</li>
	<li>Caching Improvements</li>
</ul>
These release notes cover the major changes, but do not include each bug-fix and changes. If you want to see everything, check out the <a href="https://github.com/rails/rails/commits/master">list of commits</a> in the main Rails repository on GitHub.

<hr />

<h2><a name="upgrading-to-rails-40" href="https://github.com/rails/rails/blob/master/guides/source/4_0_release_notes.md#upgrading-to-rails-40"></a>Upgrading to Rails 4.0</h2>
TODO. This is a WIP guide.

If you're upgrading an existing application, it's a great idea to have good test coverage before going in. You should also first upgrade to Rails 3.2 in case you haven't and make sure your application still runs as expected before attempting an update to Rails 4.0. Then take heed of the following changes:
<h3><a name="rails-40-requires-at-least-ruby-193" href="https://github.com/rails/rails/blob/master/guides/source/4_0_release_notes.md#rails-40-requires-at-least-ruby-193"></a>Rails 4.0 requires at least Ruby 1.9.3</h3>
Rails 4.0 requires Ruby 1.9.3 or higher. Support for all of the previous Ruby versions has been dropped officially and you should upgrade as early as possible.
<h3><a name="what-to-update-in-your-apps" href="https://github.com/rails/rails/blob/master/guides/source/4_0_release_notes.md#what-to-update-in-your-apps"></a>What to update in your apps</h3>
<ul>
	<li>Update your Gemfile to depend on
<ul>
	<li><code>rails = 4.0.0</code></li>
	<li><code>sass-rails ~&gt; 3.2.3</code></li>
	<li><code>coffee-rails ~&gt; 3.2.1</code></li>
	<li><code>uglifier &gt;= 1.0.3</code></li>
</ul>
</li>
</ul>
TODO: Update the versions above.
<ul>
	<li>Rails 4.0 removes <code>vendor/plugins</code> completely. You have to replace these plugins by extracting them as gems and adding them in your Gemfile. If you choose not to make them gems, you can move them into, say, <code>lib/my_plugin/*</code> and add an appropriate initializer in <code>config/initializers/my_plugin.rb</code>.</li>
</ul>
TODO: Configuration changes in environment files
<h2><a name="creating-a-rails-40-application" href="https://github.com/rails/rails/blob/master/guides/source/4_0_release_notes.md#creating-a-rails-40-application"></a>Creating a Rails 4.0 application</h2>
<pre>&lt;code&gt; You should have the &#039;rails&#039; rubygem installed $ rails new myapp $ cd myapp &lt;/code&gt;</pre>
<h3><a name="vendoring-gems" href="https://github.com/rails/rails/blob/master/guides/source/4_0_release_notes.md#vendoring-gems"></a>Vendoring Gems</h3>
Rails now uses a <code>Gemfile</code> in the application root to determine the gems you require for your application to start. This <code>Gemfile</code> is processed by the <a href="https://github.com/carlhuda/bundler">Bundler</a> gem, which then installs all your dependencies. It can even install all the dependencies locally to your application so that it doesn't depend on the system gems.

More information: <a href="http://gembundler.com/">Bundler homepage</a>
<h3><a name="living-on-the-edge" href="https://github.com/rails/rails/blob/master/guides/source/4_0_release_notes.md#living-on-the-edge"></a>Living on the Edge</h3>
<code>Bundler</code> and <code>Gemfile</code> makes freezing your Rails application easy as pie with the new dedicated <code>bundle</code> command. If you want to bundle straight from the Git repository, you can pass the <code>--edge</code> flag:
<pre>&lt;code&gt;$ rails new myapp --edge &lt;/code&gt;</pre>
If you have a local checkout of the Rails repository and want to generate an application using that, you can pass the <code>--dev</code> flag:
<pre>&lt;code&gt;$ ruby /path/to/rails/railties/bin/rails new myapp --dev &lt;/code&gt;</pre>
<h2><a name="major-features" href="https://github.com/rails/rails/blob/master/guides/source/4_0_release_notes.md#major-features"></a>Major Features</h2>
<h2><a name="documentation" href="https://github.com/rails/rails/blob/master/guides/source/4_0_release_notes.md#documentation"></a>Documentation</h2>
<ul>
	<li>Guides are rewritten in GitHub Flavored Markdown.</li>
</ul>
<h2><a name="railties" href="https://github.com/rails/rails/blob/master/guides/source/4_0_release_notes.md#railties"></a>Railties</h2>
<ul>
	<li>Allow scaffold/model/migration generators to accept a <code>polymorphic</code> modifier for <code>references</code>/<code>belongs_to</code>, for instance
<pre>&lt;code&gt;rails g model Product supplier:references{polymorphic} &lt;/code&gt;</pre>
will generate the model with <code>belongs_to :supplier, polymorphic: true</code> association and appropriate migration.</li>
	<li>Set <code>config.active_record.migration_error</code> to <code>:page_load</code> for development.</li>
	<li>Add runner to <code>Rails::Railtie</code> as a hook called just after runner starts.</li>
	<li>Add <code>/rails/info/routes</code> path which displays the same information as <code>rake routes</code>.</li>
	<li>Improved <code>rake routes</code> output for redirects.</li>
	<li>Load all environments available in <code>config.paths["config/environments"]</code>.</li>
	<li>Add <code>config.queue_consumer</code> to allow the default consumer to be configurable.</li>
	<li>Add <code>Rails.queue</code> as an interface with a default implementation that consumes jobs in a separate thread.</li>
	<li>Remove <code>Rack::SSL</code> in favour of <code>ActionDispatch::SSL</code>.</li>
	<li>Allow to set class that will be used to run as a console, other than IRB, with <code>Rails.application.config.console=</code>. It's best to add it to console block.
<div>
<pre># it can be added to config/application.rb
console do
  # this block is called only when running console,
  # so we can safely require pry here
  require &quot;pry&quot;
  config.console = Pry
end</pre>
</div></li>
	<li>Add a convenience method <code>hide!</code> to Rails generators to hide the current generator namespace from showing when running<code>rails generate</code>.</li>
	<li>Scaffold now uses <code>content_tag_for</code> in <code>index.html.erb</code>.</li>
	<li><code>Rails::Plugin</code> is removed. Instead of adding plugins to <code>vendor/plugins</code>, use gems or bundler with path or git dependencies.</li>
</ul>
<h3><a name="deprecations" href="https://github.com/rails/rails/blob/master/guides/source/4_0_release_notes.md#deprecations"></a>Deprecations</h3>
<h2><a name="action-mailer" href="https://github.com/rails/rails/blob/master/guides/source/4_0_release_notes.md#action-mailer"></a>Action Mailer</h2>
<ul>
	<li>Allow to set default Action Mailer options via <code>config.action_mailer.default_options=</code>.</li>
	<li>Raise an <code>ActionView::MissingTemplate</code> exception when no implicit template could be found.</li>
	<li>Asynchronously send messages via the Rails Queue.</li>
	<li>Delivery Options (such as SMTP Settings) can now be set dynamically per mailer action.Delivery options are set via <tt>:delivery_method_options</tt> key on mail.
<div>
<pre>def welcome_mailer(user,company)
  delivery_options = { user_name: company.smtp_user, password: company.smtp_password, address: company.smtp_host }
  mail(to: user.email, subject: &quot;Welcome!&quot;, delivery_method_options: delivery_options)
end</pre>
</div></li>
</ul>
<h2><a name="action-pack" href="https://github.com/rails/rails/blob/master/guides/source/4_0_release_notes.md#action-pack"></a>Action Pack</h2>
<h3><a name="action-controller" href="https://github.com/rails/rails/blob/master/guides/source/4_0_release_notes.md#action-controller"></a>Action Controller</h3>
<ul>
	<li>Add <code>ActionController::Flash.add_flash_types</code> method to allow people to register their own flash types. e.g.:
<div>
<pre>class ApplicationController
  add_flash_types :error, :warning
end</pre>
</div>
If you add the above code, you can use <code>&lt;%= error %&gt;</code> in an erb, and <code>redirect_to /foo, :error =&gt; 'message'</code> in a controller.</li>
	<li>Remove Active Model dependency from Action Pack.</li>
	<li>Support unicode characters in routes. Route will be automatically escaped, so instead of manually escaping:
<div>
<pre>get Rack::Utils.escape(&#039;こんにちは&#039;) =&gt; &#039;home#index&#039;</pre>
</div>
You just have to write the unicode route:
<div>
<pre>get &#039;こんにちは&#039; =&gt; &#039;home#index&#039;</pre>
</div></li>
	<li>Return proper format on exceptions.</li>
	<li>Extracted redirect logic from <code>ActionController::ForceSSL::ClassMethods.force_ssl</code> into<code>ActionController::ForceSSL#force_ssl_redirect</code>.</li>
	<li>URL path parameters with invalid encoding now raise <code>ActionController::BadRequest</code>.</li>
	<li>Malformed query and request parameter hashes now raise <code>ActionController::BadRequest</code>.</li>
	<li><code>respond_to</code> and <code>respond_with</code> now raise <code>ActionController::UnknownFormat</code> instead of directly returning head 406. The exception is rescued and converted to 406 in the exception handling middleware.</li>
	<li>JSONP now uses <code>application/javascript</code> instead of <code>application/json</code> as the MIME type.</li>
	<li>Session arguments passed to process calls in functional tests are now merged into the existing session, whereas previously they would replace the existing session. This change may break some existing tests if they are asserting the exact contents of the session but should not break existing tests that only assert individual keys.</li>
	<li>Forms of persisted records use always PATCH (via the <code>_method</code> hack).</li>
	<li>For resources, both PATCH and PUT are routed to the <code>update</code> action.</li>
	<li>Don't ignore <code>force_ssl</code> in development. This is a change of behavior - use an <code>:if</code> condition to recreate the old behavior.
<div>
<pre>class AccountsController &lt; ApplicationController
  force_ssl :if =&gt; :ssl_configured?

  def ssl_configured?
    !Rails.env.development?
  end
end</pre>
</div></li>
</ul>
<h4><a name="deprecations-1" href="https://github.com/rails/rails/blob/master/guides/source/4_0_release_notes.md#deprecations-1"></a>Deprecations</h4>
<ul>
	<li>Deprecated <code>ActionController::Integration</code> in favour of <code>ActionDispatch::Integration</code>.</li>
	<li>Deprecated <code>ActionController::IntegrationTest</code> in favour of <code>ActionDispatch::IntegrationTest</code>.</li>
	<li>Deprecated <code>ActionController::PerformanceTest</code> in favour of <code>ActionDispatch::PerformanceTest</code>.</li>
	<li>Deprecated <code>ActionController::AbstractRequest</code> in favour of <code>ActionDispatch::Request</code>.</li>
	<li>Deprecated <code>ActionController::Request</code> in favour of <code>ActionDispatch::Request</code>.</li>
	<li>Deprecated <code>ActionController::AbstractResponse</code> in favour of <code>ActionDispatch::Response</code>.</li>
	<li>Deprecated <code>ActionController::Response</code> in favour of <code>ActionDispatch::Response</code>.</li>
	<li>Deprecated <code>ActionController::Routing</code> in favour of <code>ActionDispatch::Routing</code>.</li>
</ul>
<h3><a name="action-dispatch" href="https://github.com/rails/rails/blob/master/guides/source/4_0_release_notes.md#action-dispatch"></a>Action Dispatch</h3>
<ul>
	<li>Add Routing Concerns to declare common routes that can be reused inside others resources and routes.Code before:
<div>
<pre>resources :messages do
  resources :comments
end

resources :posts do
  resources :comments
  resources :images, only: :index
end</pre>
</div>
Code after:
<div>
<pre>concern :commentable do
  resources :comments
end

concern :image_attachable do
  resources :images, only: :index
end

resources :messages, concerns: :commentable

resources :posts, concerns: [:commentable, :image_attachable]</pre>
</div></li>
	<li>Show routes in exception page while debugging a <code>RoutingError</code> in development.</li>
	<li>Include <code>mounted_helpers</code> (helpers for accessing mounted engines) in <code>ActionDispatch::IntegrationTest</code> by default.</li>
	<li>Added <code>ActionDispatch::SSL</code> middleware that when included force all the requests to be under HTTPS protocol.</li>
	<li>Copy literal route constraints to defaults so that url generation know about them. The copied constraints are <code>:protocol</code>,<code>:subdomain</code>, <code>:domain</code>, <code>:host</code> and <code>:port</code>.</li>
	<li>Allows <code>assert_redirected_to</code> to match against a regular expression.</li>
	<li>Adds a backtrace to the routing error page in development.</li>
	<li><code>assert_generates</code>, <code>assert_recognizes</code>, and <code>assert_routing</code> all raise <code>Assertion</code> instead of <code>RoutingError</code>.</li>
	<li>Allows the route helper root to take a string argument. For example, <code>root 'pages#main'</code> as a shortcut for<code>root to: 'pages#main'</code>.</li>
	<li>Adds support for the PATCH verb: Request objects respond to <code>patch?</code>. Routes now have a new <code>patch</code> method, and understand <code>:patch</code> in the existing places where a verb is configured, like <code>:via</code>. Functional tests have a new method <code>patch</code>and integration tests have a new method <code>patch_via_redirect</code>. If <code>:patch</code> is the default verb for updates, edits are tunneled as<code>PATCH</code> rather than as <code>PUT</code> and routing acts accordingly.</li>
	<li>Integration tests support the OPTIONS method.</li>
	<li><code>expires_in</code> accepts a <code>must_revalidate</code> flag. If true, "must-revalidate" is added to the <code>Cache-Control</code> header.</li>
	<li>Default responder will now always use your overridden block in <code>respond_with</code> to render your response.</li>
	<li>Turn off verbose mode of <code>rack-cache</code>, we still have <code>X-Rack-Cache</code> to check that info.</li>
</ul>
<h4><a name="deprecations-2" href="https://github.com/rails/rails/blob/master/guides/source/4_0_release_notes.md#deprecations-2"></a>Deprecations</h4>
<h3><a name="action-view" href="https://github.com/rails/rails/blob/master/guides/source/4_0_release_notes.md#action-view"></a>Action View</h3>
<ul>
	<li>Remove Active Model dependency from Action Pack.</li>
	<li>Allow to use <code>mounted_helpers</code> (helpers for accessing mounted engines) in <code>ActionView::TestCase</code>.</li>
	<li>Make current object and counter (when it applies) variables accessible when rendering templates with <code>:object</code> or<code>:collection</code>.</li>
	<li>Allow to lazy load <code>default_form_builder</code> by passing a string instead of a constant.</li>
	<li>Add index method to <code>FormBuilder</code> class.</li>
	<li>Adds support for layouts when rendering a partial with a given collection.</li>
	<li>Remove <code>:disable_with</code> in favor of <code>data-disable-with</code> option from <code>submit_tag</code>, <code>button_tag</code> and <code>button_to</code> helpers.</li>
	<li>Remove <code>:mouseover</code> option from <code>image_tag</code> helper.</li>
	<li>Templates without a handler extension now raises a deprecation warning but still defaults to <code>ERb</code>. In future releases, it will simply return the template content.</li>
	<li>Add a <code>divider</code> option to <code>grouped_options_for_select</code> to generate a separator optgroup automatically, and deprecate prompt as third argument, in favor of using an options hash.</li>
	<li>Add <code>time_field</code> and <code>time_field_tag</code> helpers which render an <code>input[type="time"]</code> tag.</li>
	<li>Removed old <code>text_helper</code> apis for <code>highlight</code>, <code>excerpt</code> and <code>word_wrap</code>.</li>
	<li>Remove the leading \n added by textarea on <code>assert_select</code>.</li>
	<li>Changed default value for <code>config.action_view.embed_authenticity_token_in_remote_forms</code> to false. This change breaks remote forms that need to work also without JavaScript, so if you need such behavior, you can either set it to true or explicitly pass <code>:authenticity_token =&gt; true</code> in form options.</li>
	<li>Make possible to use a block in <code>button_to</code> helper if button text is hard to fit into the name parameter:
<div>
<pre>&lt;%= button_to [:make_happy, @user] do %&gt;
  Make happy &lt;strong&gt;&lt;%= @user.name %&gt;&lt;/strong&gt;
&lt;% end %&gt;
# =&gt; &quot;&lt;form method=&quot;post&quot; action=&quot;/users/1/make_happy&quot;n&quot; style=&quot;margin: 0px; padding: 0px; border: 0px; &quot;&gt;button_to&quot;&gt;
#      &lt;div&gt;
#        &lt;button type=&quot;submit&quot;&gt;
#          Make happy &lt;strong&gt;Name&lt;/strong&gt;
#        &lt;/button&gt;
#      &lt;/div&gt;
#    &lt;/form&gt;&quot;</pre>
</div></li>
	<li>Replace <code>include_seconds</code> boolean argument with <code>:include_seconds =&gt; true</code> option in <code>distance_of_time_in_words</code> and<code>time_ago_in_words</code> signature.</li>
	<li>Remove <code>button_to_function</code> and <code>link_to_function</code> helpers.</li>
	<li><code>truncate</code> now always returns an escaped HTML-safe string. The option <code>:escape</code> can be used as <code>false</code> to not escape the result.</li>
	<li><code>truncate</code> now accepts a block to show extra content when the text is truncated.</li>
	<li>Add <code>week_field</code>, <code>week_field_tag</code>, <code>month_field</code>, <code>month_field_tag</code>, <code>datetime_local_field</code>,<code>datetime_local_field_tag</code>, <code>datetime_field</code> and <code>datetime_field_tag</code> helpers.</li>
	<li>Add <code>color_field</code> and <code>color_field_tag</code> helpers.</li>
	<li>Add <code>include_hidden</code> option to select tag. With <code>:include_hidden =&gt; false</code> select with multiple attribute doesn't generate hidden input with blank value.</li>
	<li>Removed default size option from the <code>text_field</code>, <code>search_field</code>, <code>telephone_field</code>, <code>url_field</code>, <code>email_field</code> helpers.</li>
	<li>Removed default cols and rows options from the <code>text_area</code> helper.</li>
	<li>Adds <code>image_url</code>, <code>javascript_url</code>, <code>stylesheet_url</code>, <code>audio_url</code>, <code>video_url</code>, and <code>font_url</code> to assets tag helper. These URL helpers will return the full path to your assets. This is useful when you are going to reference this asset from external host.</li>
	<li>Allow <code>value_method</code> and <code>text_method</code> arguments from <code>collection_select</code> and <code>options_from_collection_for_select</code> to receive an object that responds to <code>:call</code> such as a proc, to evaluate the option in the current element context. This works the same way with <code>collection_radio_buttons</code> and <code>collection_check_boxes</code>.</li>
	<li>Add <code>date_field</code> and <code>date_field_tag</code> helpers which render an <code>input[type="date"]</code> tag.</li>
	<li>Add <code>collection_check_boxes</code> form helper, similar to <code>collection_select</code>:
<div>
<pre>collection_check_boxes :post, :author_ids, Author.all, :id, :name
# Outputs something like:
&lt;input id=&quot;post_author_ids_1&quot; name=&quot;post[author_ids][]&quot; type=&quot;checkbox&quot; value=&quot;1&quot; /&gt;
&lt;label for=&quot;post_author_ids_1&quot;&gt;D. Heinemeier Hansson&lt;/label&gt;
&lt;input id=&quot;post_author_ids_2&quot; name=&quot;post[author_ids][]&quot; type=&quot;checkbox&quot; value=&quot;2&quot; /&gt;
&lt;label for=&quot;post_author_ids_2&quot;&gt;D. Thomas&lt;/label&gt;
&lt;input name=&quot;post[author_ids][]&quot; type=&quot;hidden&quot; value=&quot;&quot; /&gt;</pre>
</div>
The label/check_box pairs can be customized with a block.</li>
	<li>Add <code>collection_radio_buttons</code> form helper, similar to <code>collection_select</code>:
<div>
<pre>collection_radio_buttons :post, :author_id, Author.all, :id, :name
# Outputs something like:
&lt;input id=&quot;post_author_id_1&quot; name=&quot;post[author_id]&quot; type=&quot;radio&quot; value=&quot;1&quot; /&gt;
&lt;label for=&quot;post_author_id_1&quot;&gt;D. Heinemeier Hansson&lt;/label&gt;
&lt;input id=&quot;post_author_id_2&quot; name=&quot;post[author_id]&quot; type=&quot;radio&quot; value=&quot;2&quot; /&gt;
&lt;label for=&quot;post_author_id_2&quot;&gt;D. Thomas&lt;/label&gt;</pre>
</div>
The label/radio_button pairs can be customized with a block.</li>
	<li><code>check_box</code> with an HTML5 attribute <code>:form</code> will now replicate the <code>:form</code> attribute to the hidden field as well.</li>
	<li>label form helper accepts <code>:for =&gt; nil</code> to not generate the attribute.</li>
	<li>Add <code>:format</code> option to <code>number_to_percentage</code>.</li>
	<li>Add <code>config.action_view.logger</code> to configure logger for <code>Action View</code>.</li>
	<li><code>check_box</code> helper with <code>:disabled =&gt; true</code> will generate a <code>disabled</code> hidden field to conform with the HTML convention where disabled fields are not submitted with the form. This is a behavior change, previously the hidden tag had a value of the disabled checkbox.</li>
	<li><code>favicon_link_tag</code> helper will now use the favicon in <code>app/assets</code> by default.</li>
	<li><code>ActionView::Helpers::TextHelper#highlight</code> now defaults to the HTML5 <code>mark</code> element.</li>
</ul>
<h4><a name="deprecations-3" href="https://github.com/rails/rails/blob/master/guides/source/4_0_release_notes.md#deprecations-3"></a>Deprecations</h4>
<h3><a name="sprockets" href="https://github.com/rails/rails/blob/master/guides/source/4_0_release_notes.md#sprockets"></a>Sprockets</h3>
Moved into a separate gem <code>sprockets-rails</code>.
<h2><a name="active-record" href="https://github.com/rails/rails/blob/master/guides/source/4_0_release_notes.md#active-record"></a>Active Record</h2>
<ul>
	<li>Add <code>add_reference</code> and <code>remove_reference</code> schema statements. Aliases, <code>add_belongs_to</code> and <code>remove_belongs_to</code> are acceptable. References are reversible.
<div>
<pre># Create a user_id column
add_reference(:products, :user)

# Create a supplier_id, supplier_type columns and appropriate index
add_reference(:products, :supplier, polymorphic: true, index: true)

# Remove polymorphic reference
remove_reference(:products, :supplier, polymorphic: true)</pre>
</div></li>
	<li>Add <code>:default</code> and <code>:null</code> options to <code>column_exists?</code>.
<div>
<pre>column_exists?(:testings, :taggable_id, :integer, null: false)
column_exists?(:testings, :taggable_type, :string, default: &#039;Photo&#039;)</pre>
</div></li>
	<li><code>ActiveRecord::Relation#inspect</code> now makes it clear that you are dealing with a <code>Relation</code> object rather than an array:
<div>
<pre>User.where(:age =&gt; 30).inspect
# =&gt; &lt;ActiveRecord::Relation [#&lt;User ...&gt;, #&lt;User ...&gt;]&gt;

User.where(:age =&gt; 30).to_a.inspect
# =&gt; [#&lt;User ...&gt;, #&lt;User ...&gt;]</pre>
</div>
if more than 10 items are returned by the relation, inspect will only show the first 10 followed by ellipsis.</li>
	<li>Add <code>:collation</code> and <code>:ctype</code> support to PostgreSQL. These are available for PostgreSQL 8.4 or later.
<div>
<pre>development:
  adapter: postgresql
  host: localhost
  database: rails_development
  username: foo
  password: bar
  encoding: UTF8
  collation: ja_JP.UTF8
  ctype: ja_JP.UTF8</pre>
</div></li>
	<li><code>FinderMethods#exists?</code> now returns <code>false</code> with the <code>false</code> argument.</li>
	<li>Added support for specifying the precision of a timestamp in the postgresql adapter. So, instead of having to incorrectly specify the precision using the <code>:limit</code> option, you may use <code>:precision</code>, as intended. For example, in a migration:
<div>
<pre>def change
  create_table :foobars do |t|
    t.timestamps :precision =&gt; 0
  end
end</pre>
</div></li>
	<li>Allow <code>ActiveRecord::Relation#pluck</code> to accept multiple columns. Returns an array of arrays containing the typecasted values:
<div>
<pre>Person.pluck(:id, :name)
# SELECT people.id, people.name FROM people
# =&gt; [[1, &#039;David&#039;], [2, &#039;Jeremy&#039;], [3, &#039;Jose&#039;]]</pre>
</div></li>
	<li>Improve the derivation of HABTM join table name to take account of nesting. It now takes the table names of the two models, sorts them lexically and then joins them, stripping any common prefix from the second table name. Some examples:
<pre>&lt;code&gt;Top level models (Category &amp;lt;=&amp;gt; Product) Old: categories_products New: categories_products Top level models with a global table_name_prefix (Category &amp;lt;=&amp;gt; Product) Old: site_categories_products New: site_categories_products Nested models in a module without a table_name_prefix method (Admin::Category &amp;lt;=&amp;gt; Admin::Product) Old: categories_products New: categories_products Nested models in a module with a table_name_prefix method (Admin::Category &amp;lt;=&amp;gt; Admin::Product) Old: categories_products New: admin_categories_products Nested models in a parent model (Catalog::Category &amp;lt;=&amp;gt; Catalog::Product) Old: categories_products New: catalog_categories_products Nested models in different parent models (Catalog::Category &amp;lt;=&amp;gt; Content::Page) Old: categories_pages New: catalog_categories_content_pages &lt;/code&gt;</pre>
</li>
	<li>Move HABTM validity checks to <code>ActiveRecord::Reflection</code>. One side effect of this is to move when the exceptions are raised from the point of declaration to when the association is built. This is consistant with other association validity checks.</li>
	<li>Added <code>stored_attributes</code> hash which contains the attributes stored using <code>ActiveRecord::Store</code>. This allows you to retrieve the list of attributes you've defined.
<div>
<pre>class User &lt; ActiveRecord::Base
  store :settings, accessors: [:color, :homepage]
end

User.stored_attributes[:settings] # [:color, :homepage]</pre>
</div></li>
	<li>PostgreSQL default log level is now 'warning', to bypass the noisy notice messages. You can change the log level using the<code>min_messages</code> option available in your <code>config/database.yml</code>.</li>
	<li>Add uuid datatype support to PostgreSQL adapter.</li>
	<li>Added <code>ActiveRecord::Migration.check_pending!</code> that raises an error if migrations are pending.</li>
	<li>Added <code>#destroy!</code> which acts like <code>#destroy</code> but will raise an <code>ActiveRecord::RecordNotDestroyed</code> exception instead of returning <code>false</code>.</li>
	<li>Allow blocks for count with <code>ActiveRecord::Relation</code>, to work similar as <code>Array#count</code>:<code>Person.where("age &gt; 26").count { |person| person.gender == 'female' }</code></li>
	<li>Added support to <code>CollectionAssociation#delete</code> for passing fixnum or string values as record ids. This finds the records responding to the ids and deletes them.
<div>
<pre>class Person &lt; ActiveRecord::Base
  has_many :pets
end

person.pets.delete(&quot;1&quot;)  # =&gt; [#&lt;Pet id: 1&gt;]
person.pets.delete(2, 3) # =&gt; [#&lt;Pet id: 2&gt;, #&lt;Pet id: 3&gt;]</pre>
</div></li>
	<li>It's not possible anymore to destroy a model marked as read only.</li>
	<li>Added ability to <code>ActiveRecord::Relation#from</code> to accept other <code>ActiveRecord::Relation</code> objects.</li>
	<li>Added custom coders support for <code>ActiveRecord::Store</code>. Now you can set your custom coder like this:
<div>
<pre>store :settings, accessors: [ :color, :homepage ], coder: JSON</pre>
</div></li>
	<li><code>mysql</code> and <code>mysql2</code> connections will set <code>SQL_MODE=STRICT_ALL_TABLES</code> by default to avoid silent data loss. This can be disabled by specifying <code>strict: false</code> in <code>config/database.yml</code>.</li>
	<li>Added default order to <code>ActiveRecord::Base#first</code> to assure consistent results among different database engines. Introduced<code>ActiveRecord::Base#take</code> as a replacement to the old behavior.</li>
	<li>Added an <code>:index</code> option to automatically create indexes for <code>references</code> and <code>belongs_to</code> statements in migrations. This can be either a boolean or a hash that is identical to options available to the <code>add_index</code> method:
<div>
<pre>create_table :messages do |t|
  t.references :person, :index =&gt; true
end</pre>
</div>
Is the same as:
<div>
<pre>create_table :messages do |t|
  t.references :person
end
add_index :messages, :person_id</pre>
</div>
Generators have also been updated to use the new syntax.</li>
	<li>Added bang methods for mutating <code>ActiveRecord::Relation</code> objects. For example, while <code>foo.where(:bar)</code> will return a new object leaving foo unchanged, <code>foo.where!(:bar)</code> will mutate the foo object.</li>
	<li>Added <code>#find_by</code> and <code>#find_by!</code> to mirror the functionality provided by dynamic finders in a way that allows dynamic input more easily:
<div>
<pre>Post.find_by name: &#039;Spartacus&#039;, rating: 4
Post.find_by &quot;published_at &lt; ?&quot;, 2.weeks.ago
Post.find_by! name: &#039;Spartacus&#039;</pre>
</div></li>
	<li>Added <code>ActiveRecord::Base#slice</code> to return a hash of the given methods with their names as keys and returned values as values.</li>
	<li>Remove IdentityMap - IdentityMap has never graduated to be an "enabled-by-default" feature, due to some inconsistencies with associations, as described in this <a href="https://github.com/rails/rails/commit/302c912bf6bcd0fa200d964ec2dc4a44abe328a6">commit</a>. Hence the removal from the codebase, until such issues are fixed.</li>
	<li>Added a feature to dump/load internal state of <code>SchemaCache</code> instance because we want to boot more quickly when we have many models.
<div>
<pre># execute rake task.
RAILS_ENV=production bundle exec rake db:schema:cache:dump
=&gt; generate db/schema_cache.dump

# add config.use_schema_cache_dump = true in config/production.rb. BTW, true is default.

# boot rails.
RAILS_ENV=production bundle exec rails server
=&gt; use db/schema_cache.dump

# If you remove clear dumped cache, execute rake task.
RAILS_ENV=production bundle exec rake db:schema:cache:clear
=&gt; remove db/schema_cache.dump</pre>
</div></li>
	<li>Added support for partial indices to <code>PostgreSQL</code> adapter.</li>
	<li>The <code>add_index</code> method now supports a <code>where</code> option that receives a string with the partial index criteria.</li>
	<li>Added the <code>ActiveRecord::NullRelation</code> class implementing the null object pattern for the Relation class.</li>
	<li>Implemented <code>ActiveRecord::Relation#none</code> method which returns a chainable relation with zero records (an instance of the<code>NullRelation</code> class). Any subsequent condition chained to the returned relation will continue generating an empty relation and will not fire any query to the database.</li>
	<li>Added <code>create_join_table</code> migration helper to create HABTM join tables.
<div>
<pre>create_join_table :products, :categories
# =&gt;
# create_table :categories_products, :id =&gt; false do |td|
#   td.integer :product_id, :null =&gt; false
#   td.integer :category_id, :null =&gt; false
# end</pre>
</div></li>
	<li>The primary key is always initialized in the <code>@attributes</code> hash to nil (unless another value has been specified).</li>
	<li>In previous releases, the following would generate a single query with an OUTER JOIN comments, rather than two separate queries:
<div>
<pre>Post.includes(:comments).where(&quot;comments.name = &#039;foo&#039;&quot;)</pre>
</div>
This behaviour relies on matching SQL string, which is an inherently flawed idea unless we write an SQL parser, which we do not wish to do. Therefore, it is now deprecated.

To avoid deprecation warnings and for future compatibility, you must explicitly state which tables you reference, when using SQL snippets:
<div>
<pre>Post.includes(:comments).where(&quot;comments.name = &#039;foo&#039;&quot;).references(:comments)</pre>
</div>
Note that you do not need to explicitly specify references in the following cases, as they can be automatically inferred:
<div>
<pre>Post.where(comments: { name: &#039;foo&#039; })
Post.where(&#039;comments.name&#039; =&gt; &#039;foo&#039;)
Post.order(&#039;comments.name&#039;)</pre>
</div>
You also do not need to worry about this unless you are doing eager loading. Basically, don't worry unless you see a deprecation warning or (in future releases) an SQL error due to a missing JOIN.</li>
	<li>Support for the <code>schema_info</code> table has been dropped. Please switch to <code>schema_migrations</code>.</li>
	<li>Connections <em>must</em> be closed at the end of a thread. If not, your connection pool can fill and an exception will be raised.</li>
	<li>Added the <code>ActiveRecord::Model</code> module which can be included in a class as an alternative to inheriting from<code>ActiveRecord::Base</code>:
<div>
<pre>class Post
  include ActiveRecord::Model
end</pre>
</div></li>
	<li>PostgreSQL hstore records can be created.</li>
	<li>PostgreSQL hstore types are automatically deserialized from the database.</li>
	<li>Added <code>#update_columns</code> method which updates the attributes from the passed-in hash without calling save, hence skipping validations and callbacks. <code>ActiveRecordError</code> will be raised when called on new objects or when at least one of the attributes is marked as read only.
<div>
<pre>post.attributes # =&gt; {&quot;id&quot;=&gt;2, &quot;title&quot;=&gt;&quot;My title&quot;, &quot;body&quot;=&gt;&quot;My content&quot;, &quot;author&quot;=&gt;&quot;Peter&quot;}
post.update_columns({title: &#039;New title&#039;, author: &#039;Sebastian&#039;}) # =&gt; true
post.attributes # =&gt; {&quot;id&quot;=&gt;2, &quot;title&quot;=&gt;&quot;New title&quot;, &quot;body&quot;=&gt;&quot;My content&quot;, &quot;author&quot;=&gt;&quot;Sebastian&quot;}</pre>
</div></li>
</ul>
<h3><a name="deprecations-4" href="https://github.com/rails/rails/blob/master/guides/source/4_0_release_notes.md#deprecations-4"></a>Deprecations</h3>
<ul>
	<li>Deprecated most of the 'dynamic finder' methods. All dynamic methods except for <code>find_by_...</code> and <code>find_by_...!</code> are deprecated. Here's how you can rewrite the code:
<div>
<pre>find_all_by_... can be rewritten using where(...)
find_last_by_... can be rewritten using where(...).last
scoped_by_... can be rewritten using where(...)
find_or_initialize_by_... can be rewritten using where(...).first_or_initialize
find_or_create_by_... can be rewritten using where(...).first_or_create
find_or_create_by_...! can be rewritten using where(...).first_or_create!</pre>
</div>
The implementation of the deprecated dynamic finders has been moved to the <code>active_record_deprecated_finders</code> gem.</li>
	<li>Deprecated the old-style hash based finder API. This means that methods which previously accepted "finder options" no longer do. For example this:
<div>
<pre>Post.find(:all, :conditions =&gt; { :comments_count =&gt; 10 }, :limit =&gt; 5)</pre>
</div>
should be rewritten in the new style which has existed since Rails 3:
<div>
<pre>Post.where(comments_count: 10).limit(5)</pre>
</div>
Note that as an interim step, it is possible to rewrite the above as:
<div>
<pre>Post.scoped(:where =&gt; { :comments_count =&gt; 10 }, :limit =&gt; 5)</pre>
</div>
This could save you a lot of work if there is a lot of old-style finder usage in your application.

Calling <code>Post.scoped(options)</code> is a shortcut for <code>Post.scoped.merge(options)</code>. <code>Relation#merge</code> now accepts a hash of options, but they must be identical to the names of the equivalent finder method. These are mostly identical to the old-style finder option names, except in the following cases:
<pre>&lt;code&gt;:conditions becomes :where :include becomes :includes :extend becomes :extending &lt;/code&gt;</pre>
The code to implement the deprecated features has been moved out to the <code>active_record_deprecated_finders</code> gem. This gem is a dependency of Active Record in Rails 4.0. It will no longer be a dependency from Rails 4.1, but if your app relies on the deprecated features then you can add it to your own Gemfile. It will be maintained by the Rails core team until Rails 5.0 is released.</li>
	<li>Deprecate eager-evaluated scopes.Don't use this:
<div>
<pre>scope :red, where(color: &#039;red&#039;)
default_scope where(color: &#039;red&#039;)</pre>
</div>
Use this:
<div>
<pre>scope :red, -&gt; { where(color: &#039;red&#039;) }
default_scope { where(color: &#039;red&#039;) }</pre>
</div>
The former has numerous issues. It is a common newbie gotcha to do the following:
<div>
<pre>scope :recent, where(published_at: Time.now - 2.weeks)</pre>
</div>
Or a more subtle variant:
<div>
<pre>scope :recent, -&gt; { where(published_at: Time.now - 2.weeks) }
scope :recent_red, recent.where(color: &#039;red&#039;)</pre>
</div>
Eager scopes are also very complex to implement within Active Record, and there are still bugs. For example, the following does not do what you expect:
<div>
<pre>scope :remove_conditions, except(:where)
where(...).remove_conditions # =&gt; still has conditions</pre>
</div></li>
	<li>Added deprecation for the <code>:dependent =&gt; :restrict</code> association option.</li>
	<li>Up until now <code>has_many</code> and <code>has_one, :dependent =&gt; :restrict</code> option raised a <code>DeleteRestrictionError</code> at the time of destroying the object. Instead, it will add an error on the model.</li>
	<li>To fix this warning, make sure your code isn't relying on a <code>DeleteRestrictionError</code> and then add<code>config.active_record.dependent_restrict_raises = false</code> to your application config.</li>
	<li>New rails application would be generated with the <code>config.active_record.dependent_restrict_raises = false</code> in the application config.</li>
	<li>The migration generator now creates a join table with (commented) indexes every time the migration name contains the word "join_table".</li>
	<li><code>ActiveRecord::SessionStore</code> is removed from Rails 4.0 and is now a separate <a href="https://github.com/rails/activerecord-session_store">gem</a>.</li>
</ul>
<h2><a name="active-model" href="https://github.com/rails/rails/blob/master/guides/source/4_0_release_notes.md#active-model"></a>Active Model</h2>
<ul>
	<li>Changed <code>AM::Serializers::JSON.include_root_in_json</code> default value to false. Now, AM Serializers and AR objects have the same default behaviour.
<div>
<pre>class User &lt; ActiveRecord::Base; end

class Person
  include ActiveModel::Model
  include ActiveModel::AttributeMethods
  include ActiveModel::Serializers::JSON

  attr_accessor :name, :age

  def attributes
    instance_values
  end
end

user.as_json
=&gt; {&quot;id&quot;=&gt;1, &quot;name&quot;=&gt;&quot;Konata Izumi&quot;, &quot;age&quot;=&gt;16, &quot;awesome&quot;=&gt;true}
# root is not included

person.as_json
=&gt; {&quot;name&quot;=&gt;&quot;Francesco&quot;, &quot;age&quot;=&gt;22}
# root is not included</pre>
</div></li>
	<li>Passing false hash values to <code>validates</code> will no longer enable the corresponding validators.</li>
	<li><code>ConfirmationValidator</code> error messages will attach to <code>:#{attribute}_confirmation</code> instead of <code>attribute</code>.</li>
	<li>Added <code>ActiveModel::Model</code>, a mixin to make Ruby objects work with Action Pack out of the box.</li>
	<li><code>ActiveModel::Errors#to_json</code> supports a new parameter <code>:full_messages</code>.</li>
	<li>Trims down the API by removing <code>valid?</code> and <code>errors.full_messages</code>.</li>
</ul>
<h3><a name="deprecations-5" href="https://github.com/rails/rails/blob/master/guides/source/4_0_release_notes.md#deprecations-5"></a>Deprecations</h3>
<h2><a name="active-resource" href="https://github.com/rails/rails/blob/master/guides/source/4_0_release_notes.md#active-resource"></a>Active Resource</h2>
<ul>
	<li>Active Resource is removed from Rails 4.0 and is now a separate <a href="https://github.com/rails/activeresource">gem</a>.</li>
</ul>
<h2><a name="active-support" href="https://github.com/rails/rails/blob/master/guides/source/4_0_release_notes.md#active-support"></a>Active Support</h2>
<ul>
	<li>Add default values to all <code>ActiveSupport::NumberHelper</code> methods, to avoid errors with empty locales or missing values.</li>
	<li><code>Time#change</code> now works with time values with offsets other than UTC or the local time zone.</li>
	<li>Add <code>Time#prev_quarter</code> and <code>Time#next_quarter</code> short-hands for <code>months_ago(3)</code> and <code>months_since(3)</code>.</li>
	<li>Remove obsolete and unused <code>require_association</code> method from dependencies.</li>
	<li>Add <code>:instance_accessor</code> option for <code>config_accessor</code>.
<div>
<pre>class User
  include ActiveSupport::Configurable
  config_accessor :allowed_access, instance_accessor: false
end

User.new.allowed_access = true # =&gt; NoMethodError
User.new.allowed_access        # =&gt; NoMethodError</pre>
</div></li>
	<li><code>ActionView::Helpers::NumberHelper</code> methods have been moved to <code>ActiveSupport::NumberHelper</code> and are now available via<code>Numeric#to_s</code>.</li>
	<li><code>Numeric#to_s</code> now accepts the formatting options :phone, :currency, :percentage, :delimited, :rounded, :human, and :human_size.</li>
	<li>Add <code>Hash#transform_keys</code>, <code>Hash#transform_keys!</code>, <code>Hash#deep_transform_keys</code> and <code>Hash#deep_transform_keys!</code>.</li>
	<li>Changed xml type datetime to dateTime (with upper case letter T).</li>
	<li>Add <code>:instance_accessor</code> option for <code>class_attribute</code>.</li>
	<li><code>constantize</code> now looks in the ancestor chain.</li>
	<li>Add <code>Hash#deep_stringify_keys</code> and <code>Hash#deep_stringify_keys!</code> to convert all keys from a <code>Hash</code> instance into strings.</li>
	<li>Add <code>Hash#deep_symbolize_keys</code> and <code>Hash#deep_symbolize_keys!</code> to convert all keys from a <code>Hash</code> instance into symbols.</li>
	<li><code>Object#try</code> can't call private methods.</li>
	<li>AS::Callbacks#run_callbacks remove key argument.</li>
	<li><code>deep_dup</code> works more expectedly now and duplicates also values in <code>Hash</code> instances and elements in <code>Array</code> instances.</li>
	<li>Inflector no longer applies ice -&gt; ouse to words like slice, police.</li>
	<li>Add <code>ActiveSupport::Deprecations.behavior = :silence</code> to completely ignore Rails runtime deprecations.</li>
	<li>Make <code>Module#delegate</code> stop using send - can no longer delegate to private methods.</li>
	<li>AS::Callbacks deprecate :rescuable option.</li>
	<li>Adds <code>Integer#ordinal</code> to get the ordinal suffix string of an integer.</li>
	<li>AS::Callbacks :per_key option is no longer supported.</li>
	<li>AS::Callbacks#define_callbacks add :skip_after_callbacks_if_terminated option.</li>
	<li>Add html_escape_once to ERB::Util, and delegate escape_once tag helper to it.</li>
	<li>Remove <code>ActiveSupport::TestCase#pending</code> method, use <code>skip</code> instead.</li>
	<li>Deletes the compatibility method <code>Module#method_names</code>, use <code>Module#methods</code> from now on (which returns symbols).</li>
	<li>Deletes the compatibility method <code>Module#instance_method_names</code>, use <code>Module#instance_methods</code> from now on (which returns symbols).</li>
	<li>Unicode database updated to 6.1.0.</li>
	<li>Adds <code>encode_big_decimal_as_string</code> option to force JSON serialization of BigDecimals as numeric instead of wrapping them in strings for safety.</li>
</ul>
<h3><a name="deprecations-6" href="https://github.com/rails/rails/blob/master/guides/source/4_0_release_notes.md#deprecations-6"></a>Deprecations</h3>
<ul>
	<li><code>ActiveSupport::Callbacks</code>: deprecate usage of filter object with <code>#before</code> and <code>#after</code> methods as <code>around</code> callback.</li>
	<li><code>BufferedLogger</code> is deprecated. Use <code>ActiveSupport::Logger</code> or the <code>logger</code> from Ruby stdlib.</li>
	<li>Deprecates the compatibility method <code>Module#local_constant_names</code> and use <code>Module#local_constants</code> instead (which returns symbols).</li>
</ul>
<h2><a name="credits" href="https://github.com/rails/rails/blob/master/guides/source/4_0_release_notes.md#credits"></a>Credits</h2>
See the <a href="http://contributors.rubyonrails.org/">full list of contributors to Rails</a> for the many people who spent many hours making Rails, the stable and robust framework it is. Kudos to all of them.
