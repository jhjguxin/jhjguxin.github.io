---
layout: post
title: "在Heroku上部署（托管）你的Rails应用"
date: 2012-02-01 14:56
comments: true
categories: [rails]
tags: [develop,git,heroku,rails]
---
## 在Heroku上部署（托管）你的Rails应用
Heroku 是Ruby on Rails的托管提供商，提供运行Ruby on Rails应用的整套环境。和传统的托管商相比，他并不仅仅是提供一个服务器给你，而且提供有趣的工具和接口来帮助你更加容易的工作，使你从繁重的安装、配置、管理和保证服务器安全中解脱出来。
Heroku是用git来管理项目的，另外还要用到ssh来登录，这两个工具在Linux环境下的安装方法如下：
git安装

ssh安装

当然要使用Heroku，你就要到其 官方网 注册一个账号；
以上工作完成后，并可进行如下操作，将你的Rails应用托管到Heroku：

以来内容转自： http://hi.baidu.com/haifreeidea/blog/item/e09279c53b7d06c338db49c9.html

①、＄ gem install heroku

②、先要生成一个公钥，使用命令:
$ ssh-keygen -t rsa
Generating public/private rsa key pair.
Enter file in which to save the key (/home/user/.ssh/id_rsa):
Enter passphrase (empty for no passphrase):
Enter same passphrase again:
Your identification has been saved in /home/user/.ssh/id_rsa.
Your public key has been saved in /home/user/.ssh/id_rsa.pub.
The key fingerprint is:
a6:88:0a:bb:74:70:c6:e0:d5:49:65:e3:04:d5:6c:3e user@workstation.local

把公钥加入到Heroku
$ heroku keys:add
Uploading ssh public key /home/user/.ssh/id_rsa.pub

如果想删除公钥，可以用命令：
$ heroku keys:remove user@workstation.local

查看公钥，用命令：
$ heroku keys

③、现在就可以创建一个项目了(预先要安装好rails)。
$ rails myapp            (如果是已有的应用，这一步可以跳过)

$ cd myapp
$ git init
$ git add .
$ git commit -m "my first commit"
Created initial commit 5df2d09: my first commit
44 files changed, 8393 insertions(+), 0 deletions(-)
create mode 100644 README
create mode 100644 Rakefile
create mode 100644 app/controllers/application.rb
...
<h2>In heroku how to control the ruby version</h2>
Usage: heroku stack

show the list of available stacks

--all  # include deprecated stacks

Additional commands, type "heroku help COMMAND" for more details:

stack:migrate STACK  # prepare migration of this app to a new stack

use heroku create --stack to creat the stack

heroku create --stack bamboo-ree-1.8.7

&nbsp;

④、把这个项目创建到Heroku上。
＄ heroku create myapp
Enter your Heroku credentials.
Email: user@example.com
Password:
Uploading ssh public key /home/user/.ssh/id_rsa.pub
（当第一次运行heroku命令时，要求输入Email，password，这个是你在Heroku注册的Email和密码，以便创建~/.heroku/credentials文件，这个文件记录了你输入的用户名和密码，以后就不再需要输入了。）

⑤、接下来运行：
$ git push heroku master
Counting objects: 65, done.
Compressing objects: 100% (58/58), done.
Writing objects: 100% (65/65), 80.54 KiB, done.
Total 65 (delta 14), reused 0 (delta 0)

-----&gt; Heroku receiving push
-----&gt; Rails app detected
Compiled slug size is 0.1MB
-----&gt; Launching....... done
App deployed to Heroku

To git@heroku.com:vivid-mountain-91.git
* [new branch]      master -&gt; master

⑥、再做一个数据库迁移：
$ heroku rake db:migrate

现在就可以像平常使用Rails一样编写程序了。

更新代码可以用：
$ git push heroku

The rake db:reset task is not supported. Heroku apps do not have permission to drop and create databases. Use the heroku pg:reset command instead.

将本地数据更新到Heroku网站上:
$ heroku db:push
（这个命令会使用taps，如果没有安装，请先安装。）

要打开网页浏览，就可以用
$ heroku open

<strong>Permission denied (publickey) when deploying heroku code. fatal: The remote end hung up unexpectedly</strong>

jhjguxin@jhjguxin-virtual-machine:~/heroku_enki$ git push heroku master
Permission denied (publickey).
fatal: The remote end hung up unexpectedly
jhjguxin@jhjguxin-virtual-machine:~/heroku_enki$ heroku keys:add ~/.ssh/id_rsa.pub
Uploading ssh public key /home/jhjguxin/.ssh/id_rsa.pub
jhjguxin@jhjguxin-virtual-machine:~/heroku_enki$ git push heroku masterCounting objects: 460, done.
Delta compression using up to 2 threads.
Compressing objects: 100% (418/418), done.
Writing objects: 100% (460/460), 447.32 KiB | 141 KiB/s, done.
Total 460 (delta 55), reused 0 (delta 0)

about db

To ease deployment of typical Rails applications, Heroku automatically generates a new database.yml file on deployment. This auto-generated database.yml file configures your RACK_ENV environment to your selected postgres db. This enables you to simply push a Rails app up to Heroku and have it automatically connect to your database.

I had the same problem, and although I did not solve the problem, I found a workaround.

Instead of using:

heroku run rake db:migrate

You can use:

heroku run:detached rake db:migrate

This runs the command in the background, writing the output to the log. When it is finished you can view the log for the result.

自己生成的git地址不好看，最好在<strong>本地</strong>改
<div id="">
<ol start="1">
	<li>heroku rename newname</li>
</ol>
</div>
帐号下改完要
<ol start="1">
	<li>$ git remote rm heroku</li>
	<li>$ git remote add heroku git@heroku.com:newname.git</li>
</ol>
