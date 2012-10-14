---
layout: post
title: "安装GitLab"
date: 2012-04-17 10:22
comments: true
categories: [Project Manage,专业]
tags: [gitlab,install,setting]
---
## 安装GitLab
一、准备工作
根据GitLab的官方文档要求，安装GitLab需要以下软件：
ruby 1.9.2
sqlite
ubuntu/debian
pygments lib – sudo pip install pygments
gitolite
因此在安装GitLab之前需要做一些准备工作。
1、设置安装环境（安装一些必要软件）
sudo apt-get update
sudo apt-get dist-upgrade -y
sudo apt-get install git-core openssh-server sendmail curl gcc libxml2-dev libxslt-dev sqlite3 libsqlite3-dev libcurl4-openssl-dev libreadline-dev libc6-dev libssl-dev libmysql++-dev make build-essential zlib1g-dev python-setuptools
*安装VMWare Tools（这是在虚拟机环境下需要安装的，如果不是的可忽略）
sudo apt-get update -y
sudo apt-get dist-upgrade -y
sudo apt-get install dkms build-essential gcc linux-headers-$(uname -r) -y
sudo mkdir -p /media/cdrom
sudo mount /dev/cdrom /media/cdrom
cp /media/cdrom/VM* /tmp
sudo umount /media/cdrom
cd /tmp
tar -xzvf VMware*.gz
cd vmware-tools-distrib/
sudo ./vmware-install.pl -d
sudo apt-get autoremove -y
sudo shutdown -r now
上面关于虚拟机的部分是摘抄官网的，因为没环境测试，所以也只是原样照搬了。:)
2、设置专门的帐号
接下来我们需要创建一个专门的gitlabhq用户帐号来运行程序，这个帐户需要设置密码，因为需要将它加入到admin组来运行sudo：
sudo useradd -s /bin/bash -m -G admin gitlabhq
sudo passwd gitlabhq
现在使用gitlabhq用户帐号登录机器：
ssh gitlabhq@localhost
3、配置git全局变量并生成SSH密钥
git config –global user.email “admin@local.host”
git config –global user.name “GitLabHQ Admin User”
由于gitlabhq用户稍后要使用SSH密钥访问稍后创建git用户帐号，执行git命令，所以需要生成gitlabhq用户的SSH密钥：
ssh-keygen -t rsa
注意：在出现提示询问文件保存位置时直接回车，在要求输入和确认passphrase时也按回车。
4、安装Ruby 1.9.2、RubyGem和Rails
Ubuntu 11.10中的Ruby包，其版本是1.8的，所以需要安装包ruby1.9.2。由于在Ubuntu 11.10中的Ruby1.9.1包中ruby版本实际上是Ruby1.9.2，之所以包名为Ruby1.9.1是因为该版本为1.9.1的“库兼容版本”，所以可以直接安装包Ruby1.9.1即可，然后更新rubygem并安装rails。
sudo apt-get install ruby1.9.1-full
sudo update-alternatives –config ruby
sudo update-alternatives –config gem
sudo gem install rails
注意两点：1)、02-03行命令是在安装了其他ruby版本包时使用；2)、如果在安装rails时出现“RubyGems will revert to legacy indexes degrading performance.”之类的错误时，修改~/.gemrc文件后重试（有时要试多次才进行安装，一般来说都会3－6次之间，下面的bundle命令也是如此，不知道是不是伟大的墙在起作用，看你的运气了！）：
vi ~/.gemrc
—
:backtrace: false
:benchmark: false
:bulk_threshold: 1000
:sources:
- http://gems.rubyforge.org/
- http://gems.github.com/
- http://gems.rubyonrails.org/
:update_sources: true
:verbose: true
5、安装和设置Gitolite
Gitolite 是一款 Perl 语言开发的 Git 服务管理工具，通过公钥对用户进行认证，并能够通过配置文件对写操作进行基于分支和路径的的精细授权，它是采用 SSH 协议并且使用 SSH 公钥认证的。Gitolite开始于 2009年8月，其作者当时是受到了 Gitosis 的启发，开发了这款功能更为强大和易于安装的软件。对于Gitolite的命名，作者原意是 Gitosis 和 lite 的组合，不过因为 Gitolite 的功能越来越强大，已经超越了 Gitosis，因此作者笑称 Gitolite 可以看作是 Github-lite —— 轻量级的 Github。
安装Gitolite也十分简单，首先添加git用户帐号并将其加入git组：
sudo adduser \
–system \
–shell /bin/sh \
–gecos ‘git version control’ \
–group \
–disabled-password \
–home /home/git \
git
sudo usermod -a -G git `eval whoami`
然后将生成的gitlabhq用户的公钥拷到git用户目录中：
sudo cp ~/.ssh/id_rsa.pub /home/git/rails.pub
接下来以git用户的名义将gitolite源文件下载的git用户家目录中：
sudo -u git -H git clone git://github.com/gitlabhq/gitolite ~git/gitolite
再以git用户的名义安装gitolite
sudo -u git -H /home/git/gitolite/src/gl-system-install
在这里该命令会提示关于目录的警告信息，不用理会。直接运行下列命令：
sudo -u git -H sh -c “PATH=/home/git/bin:$PATH; gl-setup ~/rails.pub”
在这里将会出现vim文本编辑器的编辑界面，请将其中的REPO_UMASK=0077改为REPO_UMASK=0007，然后保存退出（退出编辑状态ESC，然后使用:x）。关于如何在vim中编辑这里就不做说明了，我偷个懒，反正有谷歌和百度。:)
最后设置库目录的权限：
sudo chmod -R g+rwX ~git/repositories/
sudo chown -R git:git ~git/repositories/
OK，设置完了之后，重新进入一次gitlabhq用户，以使gitlabhq用户生效：
exit
ssh gitlabhq@localhost
二、安装和设置GitLab
1、安装GitLab
cd ~
git clone git://github.com/gitlabhq/gitlabhq.git ~/gitlabhq
cd gitlabhq
sudo easy_install pygments
sudo gem install bundler
sudo gem install linecache19 — –with-ruby-include=/usr/include/ruby-1.9.1/ruby/
bundle install –without development test
注意：linecache19的安装是必须要指定with-ruby-include参数的，否则将会在后面的bundle install中出错！
2、设置数据库
bundle exec rake db:setup RAILS_ENV=production
bundle exec rake db:seed_fu RAILS_ENV=production
注意：运行01行的rake db:setup语句时，如果出现“unititialized constant Rake::DSL”，则需要在GitLab根目录中的Rakefile文件中添加以下语句（参见http://stackoverflow.com /questions/6268518/uninitialized-constant-rakedsl-in-ruby-gem）来解决，如未出现上述出错信息，可忽略：
require ‘rake/dsl_definition’
require ‘rake’
3、配置GitLab
编辑GitLab的配置程序：
vi ~gitlabhq/gitlabhq/config/gitlab.yml
将下列内容
git_host:
system: gitolite
admin_uri: git@localhost:gitolite-admin
base_path: /home/git/repositories/
host: gitlab
git_user: git
# port: 22
修改为：
git_host:
system: gitolite
admin_uri: git@localhost:gitolite-admin
base_path: /home/git/repositories/
host: gitlabhq.your.domain
git_user: git
# port: 22
其中03和05行中的gitlabhq.your.domain是服务器的域名。
启动服务
cd ~gitlabhq/gitlabhq
bundle exec rails s -e production
三、测试服务
如果一切OK的话，就可以在浏览器上输入：http://server.ip:3000/ 来测试该服务了，使用以下信息登录：
Email: admin@local.host
Password: 5iveL!fe
接下来您可以在admin中创建一个新的用户，注意该用户在创建时要花费一段时间，请耐心等待。在该用户生成成功后，您需要按照前面的方法在客户机上生成该用户的密钥（Windows下可以使用Git for Windows中的Git Bash来代替）：
ssh-keygen -t rsa -C “your_email@youremail.com”
然后用新用户登录，点击GitLab中My profile&gt;Keys&gt;Add new按钮，将生成的SSH公钥贴到弹出对话框的Key中，Title可随便填，我一般是使用用户_机器名这种格式，然后点击Save按钮。
在保存用户公钥之后，就可测试是否可以通过公钥来访问服务器上的git用户，执行git命令：
ssh -T git@gitlabhq.your.domain
其中，gitlabhq.your.domain是服务器的域名。如果出现”Agent admitted failure to sign using the key”错误，并提示输入git用户密码，那么请在客户机上使用以下命令将用户私钥加进来 （根据个人的密匙命名不同更改 id_rsa）：
ssh-add ~/.ssh/id_rsa
ssh -T git@gitlabhq.your.domain
hello your_email_youremail_com_1324608633, this is gitolite v2.2-11-g8c4d1aa running on git 1.7.5.4 the gitolite config gives you the following access: @R_ @W_ testing
再次访问git，如出现类似02行信息时，则表明设置成功。
四、安裝和配置 Nginx和Passenger
1、卸载Apache2
sudo apt-get autoremove apache2*
sudo dpkg –purge apache2*
2、安装Nginx和Passenger模块
sudo gem install passenger
sudo passenger-install-ngnix-module
注意：02行语句会检查编译Ngnix和Passenger模块所需要的工具，然后询问你是否有Ngnix的源码，如果没有的话，就选1，会自动下载，如果有的话，就选2，并告之源码所在位置。在这里选择1。
3、创建运行Nginx服务的用户
sudo adduser –system –no-create-home –disabled-login –disabled-password –group nginx
4、将Nginx设置开机启动脚本
wget -O init-deb.sh http://library.linode.com/assets/660-init-deb.sh
sudo mv init-deb.sh /etc/init.d/nginx
sudo chmod +x /etc/init.d/nginx
sudo /usr/sbin/update-rc.d -f nginx defaults
5、将Nginx设置为GitLab的服务器
sudo vi /opt/nginx/conf/nginx.conf

user gitlabhq staff;
# —
server {
listen 80;
server_name gitlabhq.your.domain;
root /home/gitlabhq/gitlabhq/public;
passenger_enabled on;
}
# —
其中，07行的gitlab.yourdomain.com要改为你的域名。
6、启动Nginx
sudo /etc/init.d/nginx start
五、测试服务
在浏览器中输入http://gitlab.yourdomain.com/来测试GitLab能是否正常工作。如果一切正常的话，就可以打完收功了！
