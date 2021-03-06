---
layout: post
title: "你可能错过的 Rails 技巧 --Posted by bigcircle"
date: 2012-09-07 23:29
comments: true
categories: [rails,ruby,web]
tags: [rails.ruby,tips]
---
## 你可能错过的 Rails 技巧 --Posted by bigcircle
记得前段时间 RailsConf2012 之后看过一个不错的pdf，<a href="https://speakerdeck.com/u/jeg2/p/10-things-you-didnt-know-rails-could-do">10 things you didn’t know rails could do</a>

说是10个，但是给出了42个实例，这几天抽空又回味了下，料很多，写的很好，顺便总结学习下

Pass 掉第一个 <a href="http://fridayhug.com/">fridayhug</a>，我们是开心拥抱每一天

&nbsp;
<pre class="brush: rails; gutter: true">%w(action_controller/railtie coderay markaby).map &amp;method(:require)

run TheSmallestRailsApp ||= Class.new(Rails::Application) {
  config.secret_token = routes.append {
    root to: proc {
      [200, {&quot;Content-Type&quot; =&gt; &quot;text/html&quot;}, [Markaby::Builder.new.html {
        title @title = &quot;The Smallest Rails App&quot;
        h3 &quot;I am #@title!&quot;
        p &quot;Here is my source code:&quot;
        div { CodeRay.scan_file(__FILE__).div(line_numbers: :table) }
        p { a &quot;Make me smaller&quot;, href: &quot;//goo.gl/YdRpy&quot; }
      }]]
    }
  }.to_s
  initialize!
}</pre>
2 - 提醒功能 TODO
<pre>class UsersController &lt; ApplicationController
  # TODO:  Make it possible to create new users.
end

class User &lt; ActiveRecord::Base
  # FIXME: Should token really  be accessible?
  attr_accessible :bil, :email, :name, :token
end</pre>
执行 rake notes

&nbsp;
<pre>app/controllers/users_controller.rb:
  * [ 2] [TODO] Make it possible to create new users.

app/models/user.rb:
  * [ 2] [FIXME] Should token really be accessible?

app/views/articles/index.html.erb:
  * [ 1] [OPTIMIZE] Paginate this listing.</pre>
查看单独的 TODO / FIXME / OPTIMIZE
<pre>rake notes:todo

app/controllers/users_controller.rb:
  * [ 2] Make it possible to create new users.</pre>
可以自定义提醒名称
<pre>class Article &lt; ActiveRecord::Base
  belongs_to :user
  attr_accessible :body, :subject
  # JEG2: Add that code from your blog here.
end</pre>
不过需要敲一长串，可以alias个快捷键
<pre>rake notes:custom ANNOTATION=JEG2

app/models/article.rb:
  * [ 4]Add that code from your blog here.</pre>
3 - 沙箱模式执行 rails c
<pre>rails c --sandbox</pre>
沙箱模式会有回滚事务机制，对数据库的操作在退出之前都会自动回滚到之前未修改的数据

4 - 在 rails c 控制台中使用 rails helper 方法
<pre>$ rails c
Loading development environment (Rails 3.2.3)
&gt;&gt; helper.number_to_currency(100)
=&gt; &quot;$100.00&quot;
&gt;&gt; helper.time_ago_in_words(3.days.ago)
=&gt; &quot;3 days&quot;</pre>
5 - 开发模式用 thin 代替 webrick
<pre>group :development do
  gem &#039;thin&#039;
end

rails s thin / thin start</pre>
6 - 允许自定义配置
<pre> - lib/custom/railtie.rb

 module Custom
   class Railtie &lt; Rails::Railtie
     config.custom = ActiveSupport::OrderedOptions.new
   end
 end

 - config/application.rb

 require_relative &quot;../lib/custom/railtie&quot;

 module Blog
   class Application &lt; Rails::Application
     # ...
     config.custom.setting = 42
   end
 end</pre>
7 - keep funny

作者给出了个介绍 ruby 以及一些相关 blog的网站 <a href="http://www.rubydramas.com/">rubydramas</a>，搞笑的是这个网站右上角标明
<pre>Powered by PHP</pre>
用 <a href="http://isitrails.com/">isitrails.com</a> 检查了下，果然不是用 rails 做的，这个应该是作者分享 ppt 过程中的一个小插曲吧

8 -理解简写的迁移文件
<pre>rails g resources user name:string email:string token:string bio:text</pre>
字段会被默认为 string 属性，查看了下 <a href="https://github.com/rails/rails/blob/master/railties/lib/rails/generators/generated_attribute.rb#LC55">源码</a>，果然有初始化定义
<pre>rails g resources user name email token:string{6} bio:text</pre>
会生成用样的 migration 文件
<pre>class CreateUsers &lt; ActiveRecord::Migration   def change     create_table :users do |t|       t.string :name       t.string :email       t.string :token, :limit =&gt; 6
      t.text :bio
      t.timestamps
    end
  end
end</pre>
9 - 给 migration 添加索引
<pre>rails g resource user name:index email:uniq token:string{6} bio:text</pre>
会生成 name 和 email 的索引，同时限定 email 唯一
<pre>class CreateUsers &lt; ActiveRecord::Migration   def change     create_table :users do |t|       t.string :name       t.string :email       t.string :token, :limit =&gt; 6
      t.text :bio
      t.timestamps
    end

    add_index :users, :name
    add_index :users, :email, :unique =&gt; true
  end
end</pre>
10 - 添加关联关系
<pre>rails g resource article user:references subject body:text</pre>
会自动关联生成对应的 belongs_to 和 外键，并添加索引
<pre>class CreateArticles &lt; ActiveRecord::Migration
  def change
    create_table :articles do |t|
      t.references :user
      t.string :subject
      t.text :body
      t.timestamps
    end
    add_index :articles, :user_id
  end
end</pre>
<pre>class Article &lt; ActiveRecord::Base
  belongs_to :user
  attr_accessible :body, :subject
end</pre>
11 - 显示数据迁移记录
<pre>rake db:migrate:status</pre>
会输出 migration 的状态，这在解决迁移版本冲突的时候很有用
<pre>database: db/development.sqlite3

 status   Migration ID    Migration Name
 ---------------------------------------
   up     20120414155612  Create users
   up     20120414160528  Create articles
  down    20120414161355  Create comments</pre>
12 - 导入 csv 文件

csv 文件内容如下
<pre>Name,Email
James,james@example.com
Dana,dana@example.com
Summer,summer@example.com</pre>
创建 rake 任务导入 users 表
<pre>require &#039;csv&#039;
namespace :users do
  desc &quot;Import users from a CSV file&quot;
  task :import =&gt; :environment do
    path = ENV.fetch(&quot;CSV_FILE&quot;) {
      File.join(File.dirname(__FILE__), *%w[.. .. db data users.csv])
    }
    CSV.foreach(path, headers: true, header_converters: :symbol) do |row|
      User.create(row.to_hash)
    end
  end
end</pre>
13 - 数据库中储存 csv
<pre>class Article &lt;  ActiveRecord::Base
  require &#039;csv&#039;
  module CSVSerializer
    module_function
    def load(field); field.to_s.parse_csv; end
    def dump(object); Array(object).to_csv; end
  end
  serialize :categories, CSVSerializer

  attr_accessible :body, :subject, :categories
end</pre>
serialize 用于在文本字段储存序列化的值，如序列，Hash，Array等，例如
<pre>user = User.create(:preferences =&gt; { &quot;background&quot; =&gt; &quot;black&quot;, &quot;display&quot; =&gt; large })
User.find(user.id).preferences # =&gt; { &quot;background&quot; =&gt; &quot;black&quot;, &quot;display&quot; =&gt; large }</pre>
这个例子中将 CSVSerializer to_csv序列化之后储存在 categories 这个文本类型字段中

14 - 用 pluck 查询
<pre>$ rails c
loading development environment(Rails 3.2.3)

&gt;&gt; User.select(:email).map(&amp;:email)
  User Load(0.1ms) SELECT email FROM &quot;users&quot;
=&gt; [&quot;james@example.com&quot;, &quot;dana@example.com&quot;, &quot;summer@example.com&quot;]
&gt;&gt; User.pluck(:email)
   (0.2ms) SELECT email FROM &quot;users&quot;
=&gt; [&quot;james@example.com&quot;, &quot;dana@example.com&quot;, &quot;summer@example.com&quot;]
&gt;&gt; User.uniq.pluck(:email)
   (0.2ms) SELECT DISTINCT email FROM &quot;users&quot;
=&gt; [&quot;james@example.com&quot;, &quot;dana@example.com&quot;, &quot;summer@example.com&quot;]</pre>
pluck 的实现方式其实也是 select 之后再 map
<pre>def pluck(column_name)
  column_name = column_name.to_s
  klass.connection.select_all(select(column_name).arel).map! do |attributes|
    klass.type_cast_attribute(attributes.keys.first, klass.initialize_attributes(attributes))
  end
end</pre>
15 - 使用 group count

创建 article 关联 model event
<pre>rails g resource event article:belongs_to triggle</pre>
创建3条 edit 记录和10条 view 记录。 Event.count 标明有13条记录，
group(:triggle).count 表示统计 triggle group 之后的数量，也可以用 count(:group =&gt; :trigger)

$ rails c
<pre>&amp;gt;&amp;gt; article = Article.last
=&amp;gt; #&lt;article id:1=&quot;&quot;&gt;&amp;gt;&amp;gt; {edit:3, view:10}.each do |trigger, count| ?&amp;gt; count.times do ?&amp;gt; Event.new(trigger: trigger).tap{ |e| e.article= article; e.save! } ?&amp;gt; end =&amp;gt; {:edit =&amp;gt; 3, :view =&amp;gt; 10} &amp;gt;&amp;gt; Event.count =&amp;gt; 13 &amp;gt;&amp;gt; Event.group(:trigger).count =&amp;gt; {&quot;edit&quot; =&amp;gt; 3, &quot;view&quot; =&amp;gt; 10}&lt;/article&gt;</pre>
16 - 覆盖关联关系
<pre>class Car &lt; ActiveRecord::Base
  belongs_to :owner
  belongs_to :previous_owner, class_name: &quot;Owner&quot;

  def owner=(new_owner)
    self.previous_owner = owner
    super
  end
end</pre>
car更改 owner 时，如果有了 new_owner，就把原 owner 赋给 previous_owner，注意要加上 super

17 - 构造示例数据
<pre>$ rails c
Loading development environment (Rails 3.2.3)
&gt;&gt; User.find(1)
=&gt; #
￼￼￼￼￼&gt;&gt; jeg2 = User.instantiate(&quot;id&quot; =&gt; 1, &quot;email&quot; =&gt; &quot;
￼￼￼￼=&gt; #
&gt;&gt; jeg2.name = &quot;James Edward Gray II&quot;
￼￼￼￼=&gt; &quot;James Edward Gray II&quot;
&gt;&gt; jeg2.save!
=&gt; true
&gt;&gt; User.find(1)
￼￼￼￼￼￼james@example.com&quot;, ...&gt;</pre>
伪造一条记录，并不是数据库中的真实数据，也不会把原有数据覆盖

18 - PostgreSQL 中使用无限制的 string

去掉适配器中对 string 长度的限制，这个应该是 PostgreSQL 数据库的特性
<pre>module PsqlApp
  class Application &lt; Rails::Application
    # Switch to limitless strings
    initializer &quot;postgresql.no_default_string_limit&quot; do
      ActiveSupport.on_load(:active_record) do
        adapter = ActiveRecord::ConnectionAdapters::PostgreSQLAdapter
        adapter::NATIVE_DATABASE_TYPES[:string].delete(:limit)
      end
    end
 end
end</pre>
创建 user 表，bio 字符串
<pre>rails g resource user bio</pre>
<pre>$ rails c
Loading development environment (Rails 3.2.3)
&gt;&gt; very_long_bio = &quot;X&quot; * 10_000; :set
=&gt; :set
&gt;&gt; User.create!(bio: very_long_bio)
=&gt; #
&gt;&gt; User.last.bio.size
=&gt; 10000</pre>
19 - PostgreSQL 中使用全文搜
<pre>rails g resource article subject body:text</pre>
更改迁移文件，添加索引和 articles_search_update 触发器
<pre>class CreateArticles &lt; ActiveRecord::Migration
  def change
    create_table :articles do |t|
      t.string :subject
      t.text   :body
      t.column :search, &quot;tsvector&quot;
      t.timestamps
    end
    execute &lt;</pre>
Model 中添加 search 方法
<pre>class Article &lt; ActiveRecord::Base
  attr_accessible :body, :subject
  def self.search(query)
    sql = sanitize_sql_array([&quot;plainto_tsquery(&#039;english&#039;, ?)&quot;, query])
    where(
      &quot;search @@ #{sql}&quot;
    ).order(
      &quot;ts_rank_cd(search, #{sql}) DESC&quot;
    )
  end
end</pre>
PostgreSQL 数据库没用过，这段看例子吧
<pre>$ rails c
Loading development environment (Rails 3.2.3)
&amp;gt;&amp;gt; Article.create!(subject: &quot;Full Text Search&quot;)
=&amp;gt; #&lt;article id:=&quot;&quot; 1=&quot;&quot;&gt;&amp;gt;&amp;gt; Article.create!(body: &quot;A stemmed search.&quot;) =&amp;gt; #&lt;article id:=&quot;&quot; 2=&quot;&quot;&gt;&amp;gt;&amp;gt; Article.create!(body: &quot;You won&#039;t find me!&quot;) =&amp;gt; #&lt;article id:=&quot;&quot; 3=&quot;&quot;&gt;&amp;gt;&amp;gt; Article.search(&quot;search&quot;).map { |a| a.subject || a.body } =&amp;gt; [&quot;Full Text Search&quot;, &quot;A stemmed search.&quot;] &amp;gt;&amp;gt; Article.search(&quot;stemming&quot;).map { |a| a.subject || a.body } =&amp;gt; [&quot;A stemmed search.&quot;]&lt;/article&gt;&lt;/article&gt;&lt;/article&gt;</pre>
21 - 每个用户使用不同的数据库
<pre>- user_database.rb

def connect_to_user_database(name)
  config = ActiveRecord::Base.configurations[&quot;development&quot;].merge(&quot;database&quot; =&gt; &quot;db/#{name}.sqlite3&quot;)
  ActiveRecord::Base.establish_connection(config)
end</pre>
创建 rake 任务：新增用户数据库和创建
<pre>require &quot;user_database&quot;

namespace :db do
  desc &quot;Add a new user database&quot;
  task :add =&gt; %w[environment load_config] do
    name = ENV.fetch(&quot;DB_NAME&quot;) { fail &quot;DB_NAME is required&quot; }
    connect_to_user_database(name)
    ActiveRecord::Base.connection
  end

  namespace :migrate do
    desc &quot;Migrate all user databases&quot;
    task :all =&gt; %w[environment load_config] do
      ActiveRecord::Migration.verbose = ENV.fetch(&quot;VERBOSE&quot;, &quot;true&quot;) == &quot;true&quot;
      Dir.glob(&quot;db/*.sqlite3&quot;) do |file|
        next if file == &quot;db/test.sqlite3&quot;
        connect_to_user_database(File.basename(file, &quot;.sqlite3&quot;))
        ActiveRecord::Migrator.migrate(
          ActiveRecord::Migrator.migrations_paths,
          ENV[&quot;VERSION&quot;] &amp;&amp; ENV[&quot;VERSION&quot;].to_i
        ) do |migration|
          ENV[&quot;SCOPE&quot;].blank? || (ENV[&quot;SCOPE&quot;] == migration.scope)
        end
      end
    end
  end
end</pre>
执行几个rake 任务创建不同的数据库
<pre>$ rails g resource user name
$ rake db:add DB_NAME=ruby_rogues
$ rake db:add DB_NAME=grays
$ rake db:migrate:all
==  CreateUsers: migrating ==================================
-- create_table(:users)
   -&gt; 0.0008s
==  CreateUsers: migrated (0.0008s) =========================
==  CreateUsers: migrating ==================================
-- create_table(:users)
   -&gt; 0.0007s
==  CreateUsers: migrated (0.0008s) =========================</pre>
创建几条记录，为不同的数据库创建不同的数据
<pre>$ rails c
&gt;&gt; connect_to_user_database(&quot;ruby_rogues&quot;)
=&gt; #
&gt;&gt; User.create!(name: &quot;Chuck&quot;)
=&gt; #
&gt;&gt; User.create!(name: &quot;Josh&quot;)
=&gt; #
&gt;&gt; User.create!(name: &quot;Avdi&quot;)
=&gt; #
...
&gt;&gt; connect_to_user_database(&quot;grays&quot;)
=&gt; #
&gt;&gt; User.create!(name: &quot;James&quot;)
=&gt; #
&gt;&gt; User.create!(name: &quot;Dana&quot;)
=&gt; #
&gt;&gt; User.create!(name: &quot;Summer&quot;)
=&gt; #</pre>
ApplicationController 里面添加 before_filter 根据登陆的二级域名判断连接哪个数据库
<pre>class ApplicationController &lt; ActionController::Base
  protect_from_forgery
  before_filter :connect_to_database
private
  def connect_to_database
    connect_to_user_database(request.subdomains.first)
  end
end</pre>
中场休息时，去找了下 RailsConf 2012 的视频看了看，刚好看到关于 <a href="http://confreaks.com/videos/889-railsconf2012-ten-things-you-didn-t-know-rails-could-do">这篇</a> 的介绍，片子还挺长，41分钟，演讲者长相和声音都很不符合大家对 Rails 的认知，大家有兴趣的可以去听听

21 - 自动写文件
<pre>class Comment &lt; ActiveRecord::Base
  # ...
  Q_DIR = (Rails.root + &quot;comment_queue&quot;).tap(&amp;:mkpath)
  after_save :queue_comment
  def queue_comment
    File.atomic_write(Q_DIR + &quot;#{id}.txt&quot;) do |f|
      f.puts &quot;Article: #{article.subject}&quot;
      f.puts &quot;User:    #{user.name}&quot;
      f.puts body
    end
  end
end</pre>
找了下 Api 是 Rails 对 Ruby 基础类的扩展

22 - 合并嵌套 Hash
<pre>$ rails c
Loading development environment (Rails 3.2.3)
&gt;&gt; {nested: {one: 1}}.merge(nested: {two: 2})
=&gt; {:nested=&gt;{:two=&gt;2}}
&gt;&gt; {nested: {one: 1}}.deep_merge(nested: {two: 2})
=&gt; {:nested=&gt;{:one=&gt;1, :two=&gt;2}}</pre>
主要是用到了 deep_merge 合并相同的 key

23 - Hash except
<pre>$ rails c
Loading development environment (Rails 3.2.3)
&gt;&gt; params = {controller: &quot;home&quot;, action: &quot;index&quot;, from: &quot;Google&quot;}
=&gt; {:controller=&gt;&quot;home&quot;, :action=&gt;&quot;index&quot;, :from=&gt;&quot;Google&quot;}
&gt;&gt; params.except(:controller, :action)
=&gt; {:from=&gt;&quot;Google&quot;}</pre>
这个方法经常会用到，可能用的人也很多

24 - add defaults to Hash
<pre>$ rails c
Loading development environment (Rails 3.2.3)
&gt;&gt; {required: true}.merge(optional: true)
=&gt; {:required=&gt;true, :optional=&gt;true}
&gt;&gt; {required: true}.reverse_merge(optional: true)
=&gt; {:optional=&gt;true, :required=&gt;true}
&gt;&gt; {required: true, optional: false}.merge(optional: true)
=&gt; {:required=&gt;true, :optional=&gt;true}
&gt;&gt; {required: true, optional: false}.reverse_merge(optional: true)
=&gt; {:optional=&gt;false, :required=&gt;true}</pre>
这几个都是对 Hash 类的增强，merge 会替换原有相同 key 的值，但 reverse_merge 不会

从源码就可以看出，会事先 copy 一份 default hash
<pre>def reverse_merge(other_hash)
  super
  self.class.new_from_hash_copying_default(other_hash)
end</pre>
25 - String.value? 方法

看下面的几个例子

$ rails c
Loading development environment (Rails 3.2.3)
&gt;&gt; env = Rails.env
=&gt; "development"
&gt;&gt; env.development?
=&gt; true
&gt;&gt; env.test?
=&gt; false
&gt;&gt; "magic".inquiry.magic?
=&gt; true
&gt;&gt; article = Article.first
=&gt; #

<article id:="" 1="" status:="" draft="">&gt;&gt; article.draft?
=&gt; true
&gt;&gt; article.published?
=&gt; false</article>&nbsp;

env, “magic” 可以直接使用 value? 的方法，这个扩展是 String#inquiry 方法
<pre>def inquiry
  ActiveSupport::StringInquirer.new(self)
end

# 用method_missing 实现
def method_missing(method_name, *arguments)
  if method_name.to_s[-1,1] == &quot;?&quot;
    self == method_name.to_s[0..-2]
  else
    super
  end
end</pre>
类型的一个例子，同样用到了 inquiry 方法
<pre>class Article &lt; ActiveRecord::Base
  # ...
  STATUSES = %w[Draft Published]
  validates_inclusion_of :status, in: STATUSES
  def method_missing(method, *args, &amp;block)
    if method =~ /\A#{STATUSES.map(&amp;:downcase).join(&quot;|&quot;)}\?\z/
      status.downcase.inquiry.send(method)
    else
      super
    end
  end
end</pre>
&nbsp;
<h6 id="section-1">26 - 让你成为杂志的封面 （暖场之用）</h6>
搞笑哥拿出了 DHH 当选 Linux journal 杂志封面的图片，会场也是哄堂大笑 ^.^

<img src="http://www.rubyinside.com/wp-content/uploads/2006/05/dhh.png" alt="" />

27 - 隐藏注释
<pre>
&lt;h1&gt;Home Page&lt;/h1&gt;

# 生成的 html&lt;!-- HTML comments stay in the rendered content --&gt; 

&lt;h1&gt;Home Page&lt;/h1&gt;
</pre>


这个一下没看懂。。试了下项目里面的代码，原来是隐藏的意思。。 28 - 理解更短的 erb 语法

<pre># ...
module Blog
  class Application &lt; Rails::Application

    # Broken:  config.action_view.erb_trim_mode = &#039;%&#039;
    ActionView::Template::Handlers::ERB.erb_implementation =
      Class.new(ActionView::Template::Handlers::Erubis) do
        include ::Erubis::PercentLineEnhancer
      end
    ￼￼￼￼end
  end
end</pre>
接着在 view 页面替换用 % 表示原来，有点像 slim
<pre>% if current_user.try(:admin?)

% end</pre>
29 - 用 block 避免视图层赋值
<blockquote>
<pre></pre>
<pre>&lt;table&gt;
  &lt;% @cart.products.each do |product| %&gt;
    &lt;tr&gt;
      &lt;td&gt;&lt;%= product.name %&gt;&lt;/td&gt;
      &lt;td&gt;&lt;%= number_to_currency product.price %&gt;&lt;/td&gt;
    &lt;/tr&gt;
  &lt;% end %&gt;
  &lt;tr&gt;
    &lt;td&gt;Subtotal&lt;/td&gt;
    &lt;td&gt;&lt;%= number_to_currency @cart.total %&gt;&lt;/td&gt;
  &lt;/tr&gt;
  &lt;tr&gt;
    &lt;td&gt;Tax&lt;/td&gt;
    &lt;td&gt;&lt;%= number_to_currency(tax = calculate_tax(@cart.total)) %&gt;&lt;/td&gt;
  &lt;/tr&gt;
  &lt;tr&gt;
    &lt;td&gt;Total&lt;/td&gt;
    &lt;td&gt;&lt;%= number_to_currency(@cart.total + tax) %&gt;&lt;/td&gt;
  &lt;/tr&gt;
&lt;/table&gt;</pre>
</blockquote>
<code>
tax = calculate_tax(@cart.total)</code> 会先被赋值再被下面引用 用 block 重构下，把逻辑代码放到 helper 里面
<pre>module CartHelper
  def calculate_tax(total, user = current_user)
    tax = TaxTable.for(user).calculate(total)
    if block_given?
      yield tax
    else
      tax
    end
  end
end</pre>
<blockquote>
<pre>&lt;table&gt;
  &lt;% @cart.products.each do |product| %&gt;
    &lt;tr&gt;
      &lt;td&gt;&lt;%= product.name %&gt;&lt;/td&gt;
      &lt;td&gt;&lt;%= number_to_currency product.price %&gt;&lt;/td&gt;
    &lt;/tr&gt;
  &lt;% end %&gt;
  &lt;tr&gt;
    &lt;td&gt;Subtotal&lt;/td&gt;
    &lt;td&gt;&lt;%= number_to_currency @cart.total %&gt;&lt;/td&gt;
  &lt;/tr&gt;
  &lt;% calculate_tax @cart.total do |tax| %&gt;
    &lt;tr&gt;
      &lt;td&gt;Tax&lt;/td&gt;
      &lt;td&gt;&lt;%= number_to_currency tax %&gt;&lt;/td&gt;
    &lt;/tr&gt;
    &lt;tr&gt;
      &lt;td&gt;Total&lt;/td&gt;
      &lt;td&gt;&lt;%= number_to_currency(@cart.total + tax) %&gt;&lt;/td&gt;
    &lt;/tr&gt;
  &lt;% end %&gt;
&lt;/table&gt;</pre>
<pre></pre>

&nbsp;
</blockquote>

30 - 同时生成多个标签 

<blockquote>
<pre>&lt;h1&gt;Articles&lt;/h1&gt;
  &lt;% @articles.each do |article| %&gt;
    &lt;%= content_tag_for(:div, article) do %&gt;
    &lt;h2&gt;&lt;%= article.subject %&gt;&lt;/h2&gt;
  &lt;% end %&gt;
&lt;% end %&gt;</pre>
<pre>&lt;%= content_tag_for(:div, @articles) do |article| %&gt;
  &lt;h2&gt;&lt;%= article.subject %&gt;&lt;/h2&gt;
&lt;% end %&gt;</pre>
<pre></pre>

&nbsp;
</blockquote>

&nbsp;

<h1></h1>

content_tag_for 具体用法可以参考 <a href="http://api.rubyonrails.org/classes/ActionView/Helpers/RecordTagHelper.html#method-i-content_tag_for">Api</a>，意思比较明白 <a href="http://edgeapi.rubyonrails.org/classes/ActiveModel/Conversion.html#method-i-to_partial_path">to_partial_path</a> 是 ActiveModel 內建的实例方法，返回一个和可识别关联对象路径的字符串，原文是这么说的，目前还没看明白这么用的目的在哪 

<h2>这篇 <a href="http://blog.plataformatec.com.br/2012/01/my-five-favorite-hidden-features-in-rails-3-2/">blog</a> 介绍了4个最喜欢的 Rails3.2 隐藏特性，</h2>

&nbsp;

<h6 id="inspire-theme-songs-about-your-work-">这4条都在这个系列中，作者可能也是从这学来的吧</h6>

31 - Render Any Object

<pre>class Event &lt; ActiveRecord::Base
  # ...
  def to_partial_path
    &quot;events/#{trigger}&quot;  # events/edit or events/view
  end
end</pre>
<a href="http://edgeapi.rubyonrails.org/classes/ActiveModel/Conversion.html#method-i-to_partial_path">to_partial_path</a> 是 ActiveModel 內建的实例方法，返回一个和可识别关联对象路径的字符串，原文是这么说的，目前还没看明白这么用的目的在哪

&nbsp;
<pre>Returns a string identifying the path associated with the object.
ActionPack uses this to find a suitable partial to represent the object.</pre>
32 - 生成 group option
<pre> %w[One Two Three],
  &quot;Group B&quot; =&gt; %w[One Two Three]
) ) %&gt;</pre>
这个其实就是用到了 grouped_options_for_select ，我在前面的 博文 提到过这几个 select 的用法

33 -定制你自己喜欢的 form 表单
<pre>class LabeledFieldsWithErrors &lt; ActionView::Helpers::FormBuilder
  def errors_for(attribute)
    if (errors = object.errors[attribute]).any?
      @template.content_tag(:span, errors.to_sentence, class: &quot;error&quot;)
    end
  end
  def method_missing(method, *args, &amp;block)
    if %r{ \A (?labeled_)?
              (?\w+?)
              (?_with_errors)? \z }x =~ method and
       respond_to?(wrapped) and [labeled, with_errors].any?(&amp;:present?)
      attribute, tags = args.first, [ ]
      tags           &lt;&lt; label(attribute) if labeled.present?
      tags           &lt;&lt; send(wrapped, *args, &amp;block)
      tags           &lt;&lt; errors_for(attribute) if with_errors.present?
      tags.join(&quot; &quot;).html_safe
    else
      super
    end
  end
end</pre>
定义了几个不想去看懂的 method_missing 方法。。 修改 application.rb，添加配置
<pre>class Application &lt; Rails::Application
  # ...
  require &quot;labeled_fields_with_errors&quot;
  config.action_view.default_form_builder = LabeledFieldsWithErrors
  config.action_view.field_error_proc     = -&gt;(field, _) { field }
end</pre>
创建 form 表单可以这样书写
<blockquote>
<pre></pre>
<pre>&lt;%= form_for @article do |f| %&gt;
  &lt;p&gt;&lt;%= f.text_field
  &lt;p&gt;&lt;%= f.labeled_text_field
  &lt;p&gt;&lt;%= f.text_field_with_errors
  &lt;p&gt;&lt;%= f.labeled_text_field_with_errors :subject %&gt;&lt;/p&gt;
  &lt;%= f.submit %&gt;
&lt;% end %&gt;</pre>
</blockquote>
生成如下的 html 页面
<blockquote>
<pre>&lt;p&gt;&lt;input id=&quot;article_subject&quot; name=&quot;article[subject]&quot; size=&quot;30&quot; type=&quot;text&quot; value=&quot;&quot; /&gt;&lt;/p&gt;
&lt;p&gt;&lt;label for=&quot;article_subject&quot;&gt;Subject&lt;/label&gt;
   &lt;input id=&quot;article_subject&quot; name=&quot;article[subject]&quot; size=&quot;30&quot; type=&quot;text&quot; value=&quot;&quot; /&gt;&lt;/p&gt;
&lt;p&gt;&lt;input id=&quot;article_subject&quot; name=&quot;article[subject]&quot; size=&quot;30&quot; type=&quot;text&quot; value=&quot;&quot; /&gt;
   &lt;span class=&quot;error&quot;&gt;can&#039;t be blank&lt;/span&gt;&lt;/p&gt;
&lt;p&gt;&lt;label for=&quot;article_subject&quot;&gt;Subject&lt;/label&gt;
   &lt;input id=&quot;article_subject&quot; name=&quot;article[subject]&quot; size=&quot;30&quot; type=&quot;text&quot; value=&quot;&quot; /&gt;
   &lt;span class=&quot;error&quot;&gt;can&#039;t be blank&lt;/span&gt;&lt;/p&gt;
&lt;!-- ... --&gt;</pre>
</blockquote>
不是很喜欢这种方式，反而把简单的html搞复杂了，让后来维护的人增加额外的学习成本     不是很喜欢这种方式，反而把简单的html搞复杂了，让后来维护的人增加额外的学习成本
<h6 id="inspire-theme-songs-about-your-work-">34 - Inspire theme songs about your work (再次暖场时刻)</h6>
2011年 Farmhouse Conf 上主持人 Ron Evans 专门用口琴演奏了为大神 Tenderlove 写的歌 - <a href="http://www.confreaks.com/videos/529-farmhouseconf-ruby-hero-tenderlove">Ruby Hero Tenderlove! </a>，听了半天不知道唱的啥。。 想找下有没有美女 Rubist, 看了下貌似没有，都是大妈，这位 <a href="http://www.confreaks.com/videos/534-farmhouseconf-meghann-millard">Meghann Millard</a> 尚可远观，大姐装束妖娆，手握纸条，蚊蝇环绕，不时微笑，长的真有点像 gossip girl 里面的 Jenny Humphrey
<h6 id="section">35 - 灵活的异常操作</h6>
修改 application.rb 定义
<pre>class Application &lt; Rails::Application
# ...
  config.exceptions_app = routes
end</pre>
每次有异常时路由都会被调用，你可以用下面的方法简单 render 404 页面
<pre>match &quot;/404&quot;, :to =&gt; &quot;errors#not_found&quot;</pre>
这个例子也在开头提到的那篇博文里面，感兴趣可以去自己研究下

36 - 给 Sinatra 添加路由
<pre>- Gemfile

source &#039;https://rubygems.org&#039;
# ...
gem &quot;resque&quot;, require: &quot;resque/server&quot;

module AdminValidator

  def matches?(request)
    if (id = request.env[&quot;rack.session&quot;][&quot;user_id&quot;])
      current_user = User.find_by_id(id)
      current_user.try(:admin?)
    else
      false
    end
  end
end</pre>
挂载 Resque::Server 至 /admin/resqu
<pre>Blog::Application.routes.draw do
  # ...
  require &quot;admin_validator&quot;
  constraints AdminValidator do
    mount Resque::Server, at: &quot;/admin/resque&quot;
  end
end</pre>
这个也没有试验，不清楚具体用法，sinatra 平时也基本不用

37 - 导出CSV流
<pre>class ArticlesController &lt; ApplicationController
  def index
    respond_to do |format|
      format.html do
        @articles = Article.all
      end
      format.csv do
        headers[&quot;Content-Disposition&quot;] = %Q{attachment; filename=&quot;articles.csv&quot;}
        self.response_body = Enumerator.new do |response|
          csv  = CSV.new(response, row_sep: &quot;\n&quot;)
          csv &lt;&lt; %w[Subject Created Status]
          Article.find_each do |article|
            csv &lt;&lt; [ article.subject,
                     article.created_at.to_s(:long),
                     article.status ]
        ￼￼	end
        end
      end
    end
  end
# ...
end

导出 csv 是很常用的功能，很多时候报表都需要，这个还是比较实用的

38 - do some work in the background

给 articles 添加文本类型 stats 字段</pre>
<pre>rails g migration add_stats_to_articles stats:text</pre>
添加一个计算 stats 方法 和 一个 after_create 方法，在创建一条记录后，会把 calculate_stats 添加到 Queue 队列，当队列中有任务时，后台创建一个线程执行该 job
<pre>class Article &lt; ActiveRecord::Base
  # ...
  serialize :stats
  def calculate_stats
    words = Hash.new(0)
    body.to_s.scan(/\S+/) { |word| words[word] += 1 }
    sleep 10  # simulate a lot of work
    self.stats = {words: words}
  end

  require &quot;thread&quot;
  def self.queue; @queue ||= Queue.new end
  def self.thread
    @thread ||= Thread.new do
      while job = queue.pop
        job.call
      end
    end
  end
  thread  # start the Thread

  after_create :add_stats
  def add_stats
    self.class.queue &lt;&lt; -&gt; { calculate_stats; save }
  end
end</pre>
添加一条记录，10秒后会自动给该记录 stats 字段添加 words Hash
<pre>$ rails c
Loading development environment (Rails 3.2.3)
&gt;&gt; Article.create!(subject: &quot;Stats&quot;, body: &quot;Lorem ipsum...&quot;);
Time.now.strftime(&quot;%H:%M:%S&quot;)
=&gt; &quot;15:24:10&quot;
&gt;&gt; [Article.last.stats, Time.now.strftime(&quot;%H:%M:%S&quot;)]
=&gt; [nil, &quot;15:24:13&quot;]
&gt;&gt; [Article.last.stats, Time.now.strftime(&quot;%H:%M:%S&quot;)]
=&gt;[{:words=&gt;{&quot;Lorem&quot;=&gt;1, &quot;ipsum&quot;=&gt;1, ...}, &quot;15:24:26&quot;]</pre>
39 - 用 Rails 生成静态站点

修改 config/environment/development.rb
<pre>Static::Application.configure do
  # ...
  # Show full error reports and disable caching
  config.consider_all_requests_local       = true
  config.action_controller.perform_caching = !!ENV[&quot;GENERATING_SITE&quot;]
  # ...
  # Don&#039;t fallback to assets pipeline if a precompiled asset is missed
  config.assets.compile = !ENV[&quot;GENERATING_SITE&quot;]
  # Generate digests for assets URLs
  config.assets.digest = !!ENV[&quot;GENERATING_SITE&quot;]
  # ...
end

class ApplicationController &lt; ActionController::Base
  protect_from_forgery
  if ENV[&quot;GENERATING_SITE&quot;]
    after_filter do |c|
      c.cache_page(nil, nil, Zlib::BEST_COMPRESSION)
    end
  end
end</pre>
修改 rake static:generate 任务
<pre>require &quot;open-uri&quot;
namespace :static do
  desc &quot;Generate a static copy of the site&quot;
  task :generate =&gt; %w[environment assets:precompile] do
    site = ENV.fetch(&quot;RSYNC_SITE_TO&quot;) { fail &quot;Must set RSYNC_SITE_TO&quot; }
    server = spawn( {&quot;GENERATING_SITE&quot; =&gt; &quot;true&quot;},
                    &quot;bundle exec rails s thin -p 3001&quot; )
    sleep 10  # FIXME: start when the server is up

    # FIXME: improve the following super crude spider
    paths = %w[/]
    files = [ ]
    while path = paths.shift
      files &lt;&lt; File.join(&quot;public&quot;, path.sub(%r{/\z}, &quot;/index&quot;) + &quot;.html&quot;)
      File.unlink(files.last) if File.exist? files.last
      files &lt;&lt; files.last + &quot;.gz&quot;
      File.unlink(files.last) if File.exist? files.last
      page = open(&quot;http://localhost:3001#{path}&quot;) { |url| url.read }
      page.scan(/]+href=&quot;([^&quot;]+)&quot;/) do |link|
        paths &lt;&lt; link.first
      end
    end

    system(&quot;rsync -a public #{site}&quot;)

    Process.kill(&quot;INT&quot;, server)
    Process.wait(server)
    system(&quot;bundle exec rake assets:clean&quot;)
    files.each do |file|
      File.unlink(file)
    end
  end
end</pre>
生成到某个地方，去查看吧
<pre>rake static:generate RSYNC_SITE_TO=/Users/james/Desktop</pre>
后面几个都不感兴趣，没有测试，说好的42个，瞎扯了3个pass掉了，实在是吐血了

Over.

&nbsp;
