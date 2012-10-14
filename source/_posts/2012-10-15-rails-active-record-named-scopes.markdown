---
layout: post
title: "Rails Active Record Named Scopes"
date: 2012-10-06 18:56
comments: true
categories: ["rails", "ruby"]
tags: ["active record", "rails", "Scopes"]
---
## Rails Active Record Named Scopes
<a href="http://api.rubyonrails.org/classes/ActiveRecord/Scoping.html">Active Record Named Scopes</a>

<a href="http://api.rubyonrails.org/classes/ActiveRecord/Scoping/ClassMethods.html">Instance Public methods</a>

<code>with_scope(scope = {}, action = :merge, &amp;block)</code> <code>with_scope</code> lets you apply options to inner block incrementally. It takes a hash and the keys must be <code>:find</code> or <code>:create</code>. <code>:find</code> parameter is Relation while <code>:create</code> parameters are an attributes hash.
<div>
<pre>class Article &lt; ActiveRecord::Base
  def self.create_with_scope
    with_scope(:find =&gt; where(:blog_id =&gt; 1), :create =&gt; { :blog_id =&gt; 1 }) do
      find(1) # =&gt; SELECT * from articles WHERE blog_id = 1 AND id = 1
      a = create(1)
      a.blog_id # =&gt; 1
    end
  end
end</pre>
</div>
In nested scopings, all previous parameters are overwritten by the innermost rule, with the exception of where, includes, and joins operations in Relation, which are merged.

joins operations are uniqued so multiple scopes can join in the same table without table aliasing problems. If you need to join multiple tables, but still want one of the tables to be uniqued, use the array of strings format for your joins.
<div>
<pre>class Article &lt; ActiveRecord::Base
  def self.find_with_scope
    with_scope(:find =&gt; where(:blog_id =&gt; 1).limit(1), :create =&gt; { :blog_id =&gt; 1 }) do
      with_scope(:find =&gt; limit(10)) do
        all # =&gt; SELECT * from articles WHERE blog_id = 1 LIMIT 10
      end
      with_scope(:find =&gt; where(:author_id =&gt; 3)) do
        all # =&gt; SELECT * from articles WHERE blog_id = 1 AND author_id = 3 LIMIT 1
      end
    end
  end
end</pre>
</div>
<strong>You can ignore any previous scopings</strong> by using the <code>with_exclusive_scope</code> method.
<div>
<pre>class Article &lt; ActiveRecord::Base
  def self.find_with_exclusive_scope
    with_scope(:find =&gt; where(:blog_id =&gt; 1).limit(1)) do
      with_exclusive_scope(:find =&gt; limit(10)) do
        all # =&gt; SELECT * from articles LIMIT 10
      end
    end
  end
end</pre>
</div>
<strong>Note:</strong> the <code>:find</code> scope also has effect on update and deletion methods, like update_all and delete_all.

<a href="http://api.rubyonrails.org/classes/ActiveRecord/Scoping/Default/ClassMethods.html">default_scope</a>

<code>default_scope(scope = {})</code> Use this macro in your model to set a default scope for all operations on the model.
<div>
<pre>class Article &lt; ActiveRecord::Base
  default_scope where(:published =&gt; true)
end

Article.all # =&gt; SELECT * FROM articles WHERE published = true</pre>
</div>
The <code>default_scope</code> is also applied while creating/building a record. It is not applied while updating a record.
<div>
<pre>Article.new.published    # =&gt; true
Article.create.published # =&gt; true</pre>
</div>
You can also use <code>default_scope</code> with a block, in order to have it lazily evaluated:
<div>
<pre>class Article &lt; ActiveRecord::Base
  default_scope { where(:published_at =&gt; Time.now - 1.week) }
end</pre>
</div>
(You can also pass any object which responds to call to the <code>default_scope</code> macro, and it will be called when building the default scope.)

If you use multiple <code>default_scope</code> declarations in your model then they will be merged together:
<div>
<pre>class Article &lt; ActiveRecord::Base
  default_scope where(:published =&gt; true)
  default_scope where(:rating =&gt; &#039;G&#039;)
end

Article.all # =&gt; SELECT * FROM articles WHERE published = true AND rating = &#039;G&#039;</pre>
</div>
This is also the case with inheritance and module includes where the parent or module defines a <code>default_scope</code> and the child or including class defines a second one.

If you need to do more complex things with a default scope, you can alternatively define it as a class method:
<div>
<pre>class Article &lt; ActiveRecord::Base
  def self.default_scope
    # Should return a scope, you can call &#039;super&#039; here etc.
  end
end</pre>
</div>
<a href="http://api.rubyonrails.org/classes/ActiveRecord/Scoping/Named/ClassMethods.html">activerecord/lib/active_record/scoping/named.rb</a>

<code>scope(name, scope_options = {})</code> Adds a class method for retrieving and querying objects. A scope represents a narrowing of a database query, such as <code>where(:color =&gt; :red).select('shirts.*').includes(:washing_instructions)</code>.
<div>
<pre>class Shirt &lt; ActiveRecord::Base
  scope :red, where(:color =&gt; &#039;red&#039;)
  scope :dry_clean_only, joins(:washing_instructions).where(&#039;washing_instructions.dry_clean_only = ?&#039;, true)
end</pre>
</div>
The above calls to scope define class methods <code>Shirt.red</code> and <code>Shirt.dry_clean_only</code>. <code>Shirt.red</code>, in effect, represents the query <code>Shirt.where(:color =&gt; 'red')</code>.

Note that this is simply ‘syntactic sugar’ for defining an actual class method:
<div>
<pre>class Shirt &lt; ActiveRecord::Base
  def self.red
    where(:color =&gt; &#039;red&#039;)
  end
end</pre>
</div>
Unlike <code>Shirt.find(...)</code>, however, the object returned by <code>Shirt.red</code> is not an Array; it resembles the association object constructed by a has_many declaration. For instance, you can invoke <code>Shirt.red.first</code>, <code>Shirt.red.count</code>,<code>Shirt.red.where(:size =&gt; 'small')</code>. Also, just as with the association objects, named scopes act like an Array, implementing Enumerable; <code>Shirt.red.each(&amp;block)</code>, <code>Shirt.red.first</code>, and <code>Shirt.red.inject(memo, &amp;block)</code> all behave as if<code>Shirt.red</code> really was an Array.

These named scopes are composable. For instance, <code>Shirt.red.dry_clean_only</code> will produce all shirts that are both red and dry clean only. Nested finds and calculations also work with these compositions: <code>Shirt.red.dry_clean_only.count</code> returns the number of garments for which these criteria obtain. Similarly with <code>Shirt.red.dry_clean_only.average(:thread_count)</code>.

All scopes are available as class methods on the <code>ActiveRecord::Base</code> descendant upon which the scopes were defined. But they are also available to has_many associations. If,
<div>
<pre>class Person &lt; ActiveRecord::Base
  has_many :shirts
end</pre>
</div>
then <code>elton.shirts.red.dry_clean_only</code> will return all of Elton’s red, dry clean only shirts.

Named scopes can also be procedural:
<div>
<pre>class Shirt &lt; ActiveRecord::Base
  scope :colored, lambda { |color| where(:color =&gt; color) }
end</pre>
</div>
In this example, <code>Shirt.colored('puce')</code> finds all puce shirts.

On Ruby 1.9 you can use the ‘stabby lambda’ syntax:
<div>
<pre>scope :colored, -&gt;(color) { where(:color =&gt; color) }</pre>
</div>
Note that scopes defined with scope will be evaluated when they are defined, rather than when they are used. For example, the following would be incorrect:
<div>
<pre>class Post &lt; ActiveRecord::Base
  scope :recent, where(&#039;published_at &gt;= ?&#039;, Time.current - 1.week)
end</pre>
</div>
<strong>The example above would be ‘frozen’ to the <code>Time.current</code> value when the Post class was defined</strong>, and so the resultant SQL query would always be the same. The correct way to do this would be via a lambda, which will re-evaluate the scope each time it is called:
<div>
<pre>class Post &lt; ActiveRecord::Base
  scope :recent, lambda { where(&#039;published_at &gt;= ?&#039;, Time.current - 1.week) }
end</pre>
</div>
Named scopes can also have extensions, just as with has_many declarations:
<div>
<pre>class Shirt &lt; ActiveRecord::Base
  scope :red, where(:color =&gt; &#039;red&#039;) do
    def dom_id
      &#039;red_shirts&#039;
    end
  end
end</pre>
</div>
Scopes can also be used while creating/building a record.
<div>
<pre>class Article &lt; ActiveRecord::Base
  scope :published, where(:published =&gt; true)
end

Article.published.new.published    # =&gt; true
Article.published.create.published # =&gt; true</pre>
</div>
Class methods on your model are automatically available on scopes. Assuming the following setup:
<div>
<pre>class Article &lt; ActiveRecord::Base
  scope :published, where(:published =&gt; true)
  scope :featured, where(:featured =&gt; true)

  def self.latest_article
    order(&#039;published_at desc&#039;).first
  end

  def self.titles
    map(&amp;:title)
  end

end</pre>
</div>
We are able to call the methods like this:
<div>
<pre>Article.published.featured.latest_article
Article.featured.titles</pre>
</div>
<code>scoped(options = nil)</code> Returns an anonymous scope.
<div>
<pre>posts = Post.scoped
posts.size # Fires &quot;select count(*) from  posts&quot; and returns the count
posts.each {|p| puts p.name } # Fires &quot;select * from posts&quot; and loads post objects

fruits = Fruit.scoped
fruits = fruits.where(:color =&gt; &#039;red&#039;) if options[:red_only]
fruits = fruits.limit(10) if limited?</pre>
</div>
Anonymous scopes tend to be useful when procedurally generating complex queries, where passing intermediate values (scopes) around as first-class objects is convenient.

<strong>You can define a scope that applies to all finders using <code>ActiveRecord::Base.default_scope</code></strong>.
