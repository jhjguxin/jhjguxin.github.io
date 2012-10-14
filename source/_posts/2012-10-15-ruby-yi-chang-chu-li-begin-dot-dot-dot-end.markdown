---
layout: post
title: "Ruby 异常处理 begin ...end"
date: 2012-02-09 14:24
comments: true
categories: ["rails", "ruby"]
tags: ["Exceptions", "rails", "ruby"]
---
## Ruby 异常处理 begin ...end
在java中，异常的捕捉是在try ... catch当中进行，而ruby则是在begin ... end代码块中进行异常的捕捉，在该代码块中使用rescue关键字进行捕捉异常类型，注意哦，这个是关键字，而不是方法。
Ruby代码
begin
   ......                                #可能出现异常的代码   
rescue   errorType1             #要捕捉的异常类型   
   ......                                #处理异常的代码   
rescue   errorType2             #要捕捉的异常类型   
   ......                                #处理异常的代码   
end
以上代码就是一个大概的捕捉异常的例子，在begin和end代码块中通过rescue进行异常类型的捕捉然后进行适当的处理，可是如果抛出的异常类型并没有显示的捕捉如何处理呢？那就是在最后使用else，如下：
Ruby代码
begin
   ......                                #可能出现异常的代码   
rescue   errorType1             #要捕捉的异常类型   
   ......                                #处理异常的代码   
rescue   errorType2             #要捕捉的异常类型   
   ......                                #处理异常的代码   
else
   ......                                #如果以上代码类型都没有捕捉到，则运行该段代码   
end

这时又有一个问题，如果我想获取异常信息又该如何做呢？请看下面的代码：
Ruby代码
begin
   raise ArgumentError, "Bad data"
rescue => err   
   puts err   
end
通 过rescue => variable的方式，就可以将异常保存为一个variable了。又解决了一个问题，还有什么问题呢？啊，对了，在java的使用当中，比如使用 Connection进行数据库连接后，最后一定要进行资源的清理，都是在finally块当中进行的，可是在ruby中又如何进行这些资源的清理呢？看 看下面的代码：
Ruby代码
begin
   raise ArgumentError, "Bad data"
rescue => err   
   puts err   
ensure
   ...                        #执行清理工作   
end

<pre>
module GitHelper
  def list_user_repos(user="jhjguxin", options={})
    skip_fork = options[:skip_fork] || false
    sort_by = options[:sort_by] || "created_at"
    github = Github.new
    begin 
      repos=github.repos.list_repos :user => user
    #rescue   errorType1             #要捕捉的异常类型
    #......                                #处理异常的代码 
    rescue => err   
      puts err
      return repos=[]
    ensure #这里的代码在总是被执行，可以做一些清理工作
      puts "process finished ..."
    end
    if skip_fork
      repos.each do |r|
        repos.delete(r) if r.fork==true
        #breakpoint
      end

    else
      repos
    end
  end
end
</pre>



 
