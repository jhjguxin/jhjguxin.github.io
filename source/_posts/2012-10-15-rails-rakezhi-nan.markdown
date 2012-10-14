---
layout: post
title: "Rails Rake指南"
date: 2012-02-13 13:47
comments: true
categories: [rails,ruby]
tags: [rails,rake]
---
## Rails Rake指南
这是Rails Envy网站的一篇Rake指南，你可以在这里找到原文。

作为RoR开发者，你对Rake一定不会陌生，你可能用它来完成你的单元测试，也可能是迁移数据库，但是你真正理解这些Rake任务到底是怎么运作的吗？你有尝试过创建你自己的Rake任务吗？

在这篇文章中，我们将会介绍Rake的由来，以及如何在Rails中使用它，通过这篇文章的学习，你将掌握如何使用Rake创建你自己的任务。

为什么要有Rake

要理解Rake，我们首先得来了解一下Rake的历史悠远的祖先：Make。因此我们需要暂且回到解释型语言产生之前的久远年代，在那个时代，所有代码都需 要被编译，然后才能够被执行，所以当你从Internet下载到一个相当庞大的程序后，一般来说，除了源代码，程序包中还会包含一个类似 “install_me.sh”的Shell脚本，它会负责帮你完成源代码的编译，并生成最终的可执行文件。

这看起来很完美，不是吗？对用户来说可能如此，但对于开发者来说，这却是个相当粗笨的方法，因为即使你只是修改了一个文件中的一小段代码，”install_me.sh”也必须将所有的源代码都重新编译一遍，才能生成最终的可执行文件。

因此，针对这个问题，Bell实验室的Stuart Feldman创造了Make：

Make可以识别自上次编译之后那些文件发生了改变，从而在下次编译时只对这些发生改变的文件进行编译，而忽略那些没有变化的文件，从而大大降低了程序的编译时间。 
Make同时支持依赖关系追踪，也就是你可以告诉编译器，文件A依赖于文件B，因此当文件B发生改变后，文件A也会被重新编译，并且如果编译文件A时，文件B还没有被编译，那么Make会告诉编译器应该先编译文件B。 
Make 实际上是一个跟ls和dir差不多的可执行文件，只不过你需要提供一个Makefile文件给它作为输入，Makefile中对每个需要编译的文件及它们 的依赖关系进行定义，Makefile的语法类似于Shell脚本，但又有些不同，这里我们不需要关心Makefile的语法。

随着Make的语言中立性，任何语言的程序都可以使用它来作为构建（build）系统，事实上，在Rake产生之前，许多Ruby项目也是采用Make作为构建系统的。

你可能会奇怪：“Ruby程序并不需要被编译，为何还要使用Make呢？”，是的，Ruby的确不需要编译，事实上，Ruby程序员使用Make是出于以下两个原因：

创 建任务，对于大型程序来说，编译完成并不意味着可以了事，往往你需要编写一大堆的脚本来控制它的运行，或者查看它的运行状态等等，这种情况下，你就可以创 建一个Makefile来管理所有这些任务，然后你就可以使用诸如“make stupid”，“make clever”来分别运行糊涂和聪明任务了。 
依 赖关系追踪，当你开始写一个库的时候，你可能会发现，越来越的的任务存在重复，比如”migrate“和”shema: dump“就都需要连接数据库，这时你就可以抽象出一个”connect_to_db”任务，并设置”migrate”和”shema: dump”任务都依赖于”connect_to_db”，这样当你单独运行”migrate”或者”shema:dump”任务时， “connect_to_db”任务都会被首先调用，如果你同时运行这两个任务，那么”connect_to_db”任务只会被执行一次。 
Rake是怎么来的？

很多年以前，当 Jim Weirich还在为一个Java项目工作时，他最初的选择也是Makefile，但是很快他意识到：要是能够在Makefile中嵌入Ruby代码，那会是多么的方便呀，于是，Rake就这么产生了。

Rake支持任务创建，任务依赖关系追踪，以及文件编译时间识别。最后一个功能对Ruby程序员应该用不到，但如果你同时还是一个C程序员，那么你可以尝试使用Rake来替代Make。

Rake如何工作

让我们通过一个例子来说明吧，假设我今天很郁闷，想要借酒消愁，这个过程涉及以下几个任务：

买酒 
买下酒菜 
搞掂它们 
假设使用Rake来管理这3个任务，那么我首先需要创建一个Rakefile文件：

task :purchaseAlcohol do
  puts "来瓶五粮液"
end
task :mixDrink do
  puts "上盘花生米"
end
task :getSmashed do
  puts "老板, 啥时学的分身术, 很强嘛?"
end

然后我就可以从Rakefile文件所在的目录来完成这些任务了：


$ rake purchaseAlcohol
来瓶五粮液
$ rake mixDrink
上盘花生米
$ rake getSmashed
老板, 啥时学的分身术, 很强嘛?

很简单吧！但是有些问题，我可不想还没喝酒吃东西就看到老板的分身，这会被人当作精神不正常。

如何组织任务的依赖关系

很简单：

task :purchaseAlcohol do
  puts "来瓶五粮液"
end
task :mixDrink => :purchaseAlcohol do
  puts "上盘花生米"
end
task :getSmashed => :mixDrink do
  puts "老板, 啥时学的分身术, 很强嘛?"
end

搞掂，现在再试试：

$ rake purchaseAlcohol
来瓶五粮液
$ rake mixDrink
来瓶五粮液
上盘花生米
$ rake getSmashed
来瓶五粮液
上盘花生米
老板, 啥时学的分身术, 很强嘛?

就像你看到的，现在我想要醉必须得先喝点酒吃点花生才行，不过一个人喝酒总归有些无聊，所以我想喊些哥们一起来喝，但是我又懒得跟他们解释为啥突然喊他们来喝酒（本人平时比较吝啬），我想到一个偷懒的办法，给他们看文档，但是究竟该怎么为我的Rake任务生成文档呢？

为Rake任务生成文档
再简单不过了：

desc "工作郁闷，想喝点酒"
task :purchaseAlcohol do
  puts "来瓶五粮液"
end
desc "得有点下酒菜"
task :mixDrink => :purchaseAlcohol do
  puts "来盘花生米"
end
desc "开喝，不醉不归"
task :getSmashed => :mixDrink do
  puts "老板, 啥时学的分身术, 很强嘛?"
end

就像你看到的，我的每个任务都有了一个desc字段，现在我和我的朋友们就可以通过rake -T或者rake –task来查看每个任务的文档了：

$ rake --tasks
rake getSmashed # 开喝，不醉不归
rake mixDrink # 得有点下酒菜
rake purchaseAlcohol # 工作郁闷，想喝点酒

Rake命名空间

一旦养成了工作郁闷就喝酒的好习惯之后，你很快就会发现，自己成了个酒鬼，因此你不得不写一大堆Rake任务来集结你的狐朋狗友们，这时你就会发现命名空间的重要性：

namespace :alcoholic do
  desc "工作郁闷，想喝点酒"
  task :purchaseAlcohol do
    puts "来瓶五粮液"
  end
  desc "得有点下酒菜"
  task :mixDrink => :purchaseAlcohol do
    puts "来盘花生米"
  end
  desc "开喝，不醉不归"
  task :getSmashed => :mixDrink do
    puts "老板, 啥时学的分身术, 很强嘛?"
  end
end
namespace :girlfriend do
  desc "那个，喝点红酒吧"
  task :purchaseAlcohol do
    puts "来瓶干红"
  end
end

命名空间允许你将你的任务进行分类，你可以在一个Rakefile内创建多个命名空间，现在输入rake –tasks你会得到如下输出：

rake alcoholic:getSmashed # 开喝，不醉不归
rake alcoholic:mixDrink # 得有点下酒菜
rake alcoholic:purchaseAlcohol # 工作郁闷，想喝点酒
rake girlfriend:purchaseAlcohol # 那个，喝点红酒吧

有用的任务

上面都是扯淡，毕竟人生除了喝酒还有更重要的事情等着我们去做，下面，我们来干点正经事，假设我们需要完成这样一个任务，给定一组目录，如果不存在，就创建它们，我创建的Rake任务如下：

desc "Create blank directories if they don't already exist"
task(:create_directories) do
  # The folders I need to create
  shared_folders = ["icons","images","groups"]
    for folder in shared_folders
    # Check to see if it exists
    if File.exists?(folder)
      puts "#{folder} exists"
    else
      puts "#{folder} doesn't exist so we're creating"
      Dir.mkdir "#{folder}"
    end
  end
end

默认情况下，Rake具有所有File Utils包的功能，当然你也可以通过引用其他库来做任何你想做的事情，那么下一个问题就是：我应该如何在Rails中使用Rake呢？

在Rails中使用Rake

每个Rails应用本身都在带有许多预定义的Rake任务，你可以通过在你的Rails应用的根目录下执行rake –tasks来查看可用的rake任务，别以后了，现在就试试吧，我等你！

要创建新的Rake任务，你只需打开你的Rails应用的lib/tasks目录，并将你的Rakefile命名为”somethins.rake”即可，它会自动被主Rakefile引用，然后你就可以在主目录下调用你的rake任务了，让我们继续上面那个例子：

utils.rake

namespace :utils do
  desc "Create blank directories if they don't already exist"
 task(:create_directories) do
  # The folders I need to create
  shared_folders = ["icons","images","groups"]
  for folder in shared_folders
   # Check to see if it exists
   if File.exists?("#{RAILS_ROOT}/public/#{folder}")
    puts "#{RAILS_ROOT}/public/#{folder} exists"
   else
    puts "#{RAILS_ROOT}/public/#{folder} doesn't exist so we're creating"
    Dir.mkdir "#{RAILS_ROOT}/public/#{folder}"
   end
  end
 end
end

再次执行rake –tasks，你会看到如下结果

......
rake tmp:pids:clear # Clears all files in tmp/pids
rake tmp:sessions:clear # Clears all files in tmp/sessions
rake tmp:sockets:clear # Clears all files in tmp/sockets
rake utils:create_directories # Create blank directories if they
don't already exist

从Rake任务中可以访问rails model吗？

是的，当然可以，这是我使用Rake最主要的用途：运行一些需要手动执行的任务，或者是需要脱离Rails定期运行的任务，下面是一个简单的例子：

namespace :utils do
  desc "Finds soon to expire subscriptions and emails users"
  task(:send_expire_soon_emails => :environment) do
    # Find users to email
    for user in User.members_soon_to_expire
      puts "Emailing #{user.name}"
      UserNotifier.deliver_expire_soon_notification(user)
    end
  end
end

实在是很简单，你只需要在你的任务之前执行”=> :environment“就可以了。

如果需要在开发模式执行这个任务，直接敲”rake utils:send_expire_soon_emails”就可以了，如果是产品模式，敲”rake RAILS_ENV=production utils:send_expire_soon_emails”，现在如果我想让这个任务每天晚上运行一次，那么，我只需要在cronjob文件中加入下面这行就可以了：

0 0 * * * cd /var/www/apps/rails_app/ && /usr/local/bin/rake RAILS_ENV=production utils:send_expire_soon_emails

还有更多的例子吗？


<pre>
<code>namespace :sunspot do
  namespace :solr do
    desc 'Start the Solr instance'
    task :start => :environment do
      case RUBY_PLATFORM
      when /w(in)?32$/, /java$/
        abort("This command is not supported on #{RUBY_PLATFORM}. " +
              "Use rake sunspot:solr:run to run Solr in the foreground.")
      end

      if defined?(Sunspot::Rails::Server)
        Sunspot::Rails::Server.new.start
      else
        Sunspot::Solr::Server.new.start
      end

      puts "Successfully started Solr ..."
    end

    desc 'Run the Solr instance in the foreground'
    task :run => :environment do
      if defined?(Sunspot::Rails::Server)
        Sunspot::Rails::Server.new.run
      else
        Sunspot::Solr::Server.new.run
      end
    end

    desc 'Stop the Solr instance'
    task :stop => :environment do
      case RUBY_PLATFORM
      when /w(in)?32$/, /java$/
        abort("This command is not supported on #{RUBY_PLATFORM}. " +
              "Use rake sunspot:solr:run to run Solr in the foreground.")
      end

      if defined?(Sunspot::Rails::Server)
        Sunspot::Rails::Server.new.stop
      else
        Sunspot::Solr::Server.new.stop
      end

      puts "Successfully stopped Solr ..."
    end

    # for backwards compatibility
    task :reindex => :"sunspot:reindex"
  end
end</code>
</pre>


不用担心，只要你有时间，并且愿意看，例子大把：

These brand new rake tasks in Edge Rails create and reset your databases for you. Neato! 
Craig Ambrose wrote a Rake task to do database backups, which you can use. 
Adam Greene put together a set of Rake tasks that allow you to backup all your data to Amazon S3 
Jay Fields made a good point when he talked about testing rake tasks 
Err the blog talks about a new way of setting the RAILS_ENV and teaches how to use rake to boot you into a Mysql shell (be sure to read the comments if you browse this one). 
Last, but not least, there’s the Rake Bookshelf Books and Martin Fowler’s Using the Rake Build Language tutorial . Both of these are pretty thorough, but also a little dated 
