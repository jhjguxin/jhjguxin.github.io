---
layout: post
title: "rails学习笔记: rake  相关命令"
date: 2012-02-15 18:23
comments: true
categories: [rails,ruby]
tags: [rails,rake]
---
## rails学习笔记: rake  相关命令
命令行 
rake db：*****
script/generate model task name:string priority:integer   
script/generate migration add_description_to_task description:string   
script/generate migration remove_description_from_task description:string 

类似的概念里有叫做“迁移 (migration)”的东西，Rails的世界里，指的是改变数据库的结构（schema）。这个通过db/migrate目录下面的 Ruby 脚本执行。

另一方面，db/seeds.rb 也向数据库插入数据。例如，在希望从开始状态准备初期管理者帐户的情况下使用。

在此之前这样的代码只在迁移脚本内描述，我想对此感觉不方便的不止我一个人。

db/seeds.rb 是像下面的例子一样的普通的 Rails 脚本：

Administrator.create(:name => 'root', :password => '')专用的 Rake 任务 db:seeds 也具备。



数据类型 
引用
# :string, :text, :integer, :float,:decimal, :datetime, :timestamp, :time, :date, 
# :binary, :boolean 

与db有关的rake任务 
 
db:charset 检索当前环境下数据库的字符设置   
db:collation 检索当前环境下数据库的校对   
db:create 用config\database.yml中的定义创建当前 RAILS_ENV 项目环境下的数据库   
db:create:all 用config\database.yml中的定义创建所有数据库   
db:drop 删除当前 RAILS_ENV项目环境中的数据库   
db:drop:all 删除所有在 config\database.yml中定义的数据库   
db:reset 从db\schema.rb中为当前环境重建数据库（先删后建）.   
db:rollback 回滚(清华出版社一本SQLSERVER书的名词[很奇怪为什么不直接用滚回])数据库到前一个版本. 指定回滚到哪一步要用 STEP=n 参数   
db:version 检索当前模式下的版本   

备份数据库
rake db:backup:create 根据database.yml的信息备份数据库
rake db:backup:destroy 默认删除一天前的备份数据
rake db:backup:rebuild 默认恢复最新的备份数据

注意：这里设置的备份目录是db的backup目录，可以修改 

添加索引 
引用

add_index :acls, ["action_id","group_id"],:unique=>true 
add_index :acls, :action_id 

drop all tables 删除全部表
rake db:migrate VERSION=0  

指定恢复/删除：
rake db:migrate:down/up VERSION = version_of_migrati

定义数字精确度 
t.integer :total_price, :precision=>8,:scale=>2,:default=>0


========================================================================================================================================================
rake db:abort_if_pending_migrations  # Raises an error if there are pending migrations
rake db:charset                      # Retrieves the charset for the current environment's database
rake db:collation                    # Retrieves the collation for the current environment's database
rake db:create                       # Create the database defined in config/database.yml for the current RAILS_ENV
rake db:create:all                   # Create all the local databases defined in config/database.yml
rake db:drop                         # Drops the database for the current RAILS_ENV
rake db:drop:all                     # Drops all the local databases defined in config/database.yml
rake db:fixtures:identify            # Search for a fixture given a LABEL or ID.
rake db:fixtures:load                # Load fixtures into the current environment's database.
rake db:migrate                      # Migrate the database through scripts in db/migrate.
rake db:migrate:down                 # Runs the "down" for a given migration VERSION.
rake db:migrate:redo                 # Rollbacks the database one migration and re migrate up.
rake db:migrate:reset                # Resets your database using your migrations for the current environment
rake db:migrate:up                   # Runs the "up" for a given migration VERSION.
rake db:reset                        # Drops and recreates the database from db/schema.rb for the current environment.
rake db:rollback                     # Rolls the schema back to the previous version.
rake db:schema:dump                  # Create a db/schema.rb file that can be portably used against any DB supported by AR
rake db:schema:load                  # Load a schema.rb file into the database
rake db:sessions:clear               # Clear the sessions table
rake db:sessions:create              # Creates a sessions migration for use with CGI::Session::ActiveRecordStore
rake db:structure:dump               # Dump the database structure to a SQL file
rake db:test:clone                   # Recreate the test database from the current environment's database schema
rake db:test:clone_structure         # Recreate the test databases from the development structure
rake db:test:load                    # Recreate the test database from the current schema.rb
rake db:test:prepare                 # Check for pending migrations and load the test schema
rake db:test:purge                   # Empty the test database
rake db:version                      # Retrieves the current schema version number
rake doc:app                         # Build the app HTML Files
rake doc:clobber_app                 # Remove rdoc products
rake doc:clobber_plugins             # Remove plugin documentation
rake doc:clobber_rails               # Remove rdoc products
rake doc:guides                      # Generate Rails guides
rake doc:plugins                     # Generate documentation for all installed plugins
rake doc:rails                       # Build the rails HTML Files
rake doc:reapp                       # Force a rebuild of the RDOC files
rake doc:rerails                     # Force a rebuild of the RDOC files
rake gems                            # List the gems that this rails application depends on
rake gems:build                      # Build any native extensions for unpacked gems
rake gems:install                    # Installs all required gems for this application.
rake gems:refresh_specs              # Regenerate gem specifications in correct format.
rake gems:unpack                     # Unpacks the specified gem into vendor/gems.
rake gems:unpack:dependencies        # Unpacks the specified gems and its dependencies into vendor/gems
rake log:clear                       # Truncates all *.log files in log/ to zero bytes
rake notes                           # Enumerate all annotations
rake notes:custom                    # Enumerate a custom annotation, specify with ANNOTATION=WTFHAX
rake notes:fixme                     # Enumerate all FIXME annotations
rake notes:optimize                  # Enumerate all OPTIMIZE annotations
rake notes:todo                      # Enumerate all TODO annotations
rake rails:freeze:edge               # Lock to latest Edge Rails, for a specific release use RELEASE=1.2.0
rake rails:freeze:gems               # Lock this application to the current gems (by unpacking them into vendor/rails)
rake rails:unfreeze                  # Unlock this application from freeze of gems or edge and return to a fluid use of system gems
rake rails:update                    # Update both configs, scripts and public/javascripts from Rails
rake rails:update:configs            # Update config/boot.rb from your current rails install
rake rails:update:javascripts        # Update your javascripts from your current rails install
rake rails:update:scripts            # Add new scripts to the application script/ directory
rake routes                          # Print out all defined routes in match order, with names.
rake secret                          # Generate a crytographically secure secret key.
rake stats                           # Report code statistics (KLOCs, etc) from the application
rake test                            # Run all unit, functional and integration tests
rake test:benchmark                  # Run tests for benchmarkdb:test:prepare / Benchmark the performance tests
rake test:functionals                # Run tests for functionalsdb:test:prepare / Run the functional tests in test/functional
rake test:integration                # Run tests for integrationdb:test:prepare / Run the integration tests in test/integration
rake test:plugins                    # Run tests for pluginsenvironment / Run the plugin tests in vendor/plugins/*/**/test (or specify with PLUGIN=name)
rake test:profile                    # Run tests for profiledb:test:prepare / Profile the performance tests
rake test:recent                     # Run tests for recentdb:test:prepare / Test recent changes
rake test:uncommitted                # Run tests for uncommitteddb:test:prepare / Test changes since last checkin (only Subversion and Git)
rake test:units                      # Run tests for unitsdb:test:prepare / Run the unit tests in test/unit
rake time:zones:all                  # Displays names of all time zones recognized by the Rails TimeZone class, grouped by offset.
rake time:zones:local                # Displays names of time zones recognized by the Rails TimeZone class with the same offset as the system local time
rake time:zones:us                   # Displays names of US time zones recognized by the Rails TimeZone class, grouped by offset.
rake tmp:cache:clear                 # Clears all files and directories in tmp/cache
rake tmp:clear                       # Clear session, cache, and socket files from tmp/
rake tmp:create                      # Creates tmp directories for sessions, cache, and sockets
rake tmp:pids:clear                  # Clears all files in tmp/pids
rake tmp:sessions:clear              # Clears all files in tmp/sessions
rake tmp:sockets:clear               # Clears all files in tmp/sockets
