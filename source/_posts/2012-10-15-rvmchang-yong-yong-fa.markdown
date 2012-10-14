---
layout: post
title: "rvm常用用法"
date: 2012-01-31 16:43
comments: true
categories: [rails,ruby]
tags: [rails,ruby,rvm]
---
## rvm常用用法
<strong>jhjguxin@jhjguxin-virtual-machine:~$ su<span>d</span>o gpassw<span>d</span> -a root rvm</strong>
<strong>A<span>d</span><span>d</span>ing user root to group rvm</strong>
<strong>jhjguxin@jhjguxin-virtual-machine:~$ su<span>d</span>o gpassw<span>d</span> -a jhjguxin rvm</strong>
<strong>A<span>d</span><span>d</span>ing user jhjguxin to group rvm</strong>
<strong>jhjguxin@jhjguxin-virtual-machine:~$ su<span>d</span>o gpassw<span>d</span> -a www-<span>d</span>ata rvm</strong>
<strong>A<span>d</span><span>d</span>ing user www-<span>d</span>ata to group rvm</strong>

<strong>这个是重点如果没有添加group的话则 install 会不成功</strong>
The installer no longer auto-a<span>d</span><span>d</span>s root or users to the rvm group. A<span>d</span>mins must <span>d</span>o this.
Also, please note that group memberships are ONLY evaluate<span>d</span> at login time.
This means that users must log out then back in be<span>f</span>ore group membership takes e<span>f</span><span><span>f</span>e</span>ct!

* I<span>f</span> you have any questions, issues an<span>d</span>/or i<span>de</span>as <span>f</span>or improvement please
<span>f</span>ork the project an<span>d</span> issue a pull request.

* I<span>f</span> you wish to <span>d</span>isable the project .rvmrc <span>f</span>ile <span>f</span>unctionality, set
rvm_project_rvmrc=0 in either /etc/rvmrc or ~/.rvmrc.
then log out an<span>d</span> back in.

* You _must_ rea<span>d</span> 'rvm requirements' <span>f</span>or a<span>d</span><span>d</span>itional OS speci<span>f</span>ic requirements <span>f</span>or
various rubies, an<span>d</span> native-extension gems. Expect <span>f</span>ailures until those are met!

* <span>F</span>or screen users, please <span>d</span>o not <span>f</span>orget to rea<span>d</span> https://rvm.beginrescueen<span>d</span>.com/work<span>f</span>low/screen/.
You will nee<span>d</span> to a<span>d</span><span>d</span> 'shell -/bin/bash' to your $HOME/.screenrc to properly loa<span>d</span> RVM.

* rvm_trust_rvmrcs has been change<span>d</span> to rvm_trust_rvmrcs_<span>f</span>lag <span>f</span>or consistency

* Project rvmrc <span>f</span>iles are now checke<span>d</span> <span>f</span>or trust whenever they change, as
promise<span>d</span> by the note <span>d</span>isplaye<span>d</span> <span>d</span>uring the review process

* Ruby package <span>de</span>pen<span>de</span>ncy list <span>f</span>or your OS is given by:
rvm requirements

* I<span>f</span> you encounter any issues with a ruby 'X' your best bet is to:
rvm get hea<span>d</span> &amp;&amp; rvm reinstall X

* I<span>f</span> you see the <span>f</span>ollowing error message: Unknown alias name: '<span style="background-color: #ffd700;">def</span>ault'
re-set your <span style="background-color: #ffd700;">def</span>ault ruby, this is <span>d</span>ue to a change in how <span style="background-color: #ffd700;">def</span>ault works.

* a<span>f</span>ter_use an<span>d</span> a<span>f</span>ter_c<span>d</span> hook now supports multiple <span>f</span>iles with a<span>f</span>ter_*_*
the custom hooks can be easily turne<span>d</span> on/o<span>f</span><span>f</span> by:
chmo<span>d</span> +x $rvm_path/hooks/a<span>f</span>ter_c<span>d</span>_[hook_name]
chmo<span>d</span> -x $rvm_path/hooks/a<span>f</span>ter_use_[hook_name]

* I<span>f</span> your shell exits on entering <span>d</span>irectory with <span>f</span>reshly checke<span>d</span> out sources
you shoul<span>d</span> up<span>d</span>ate .rvmrc <span>f</span>ile, an<span>d</span> replace any `exit ` with `return `.

* I<span>f</span> you wish to use RVM in an interactive <span>f</span>ashion in other shells
then place the <span>f</span>ollowing line at the en<span>d</span> o<span>f</span> your shell's loa<span>d</span>ing <span>f</span>iles
(.bashrc or .bash_pro<span>f</span>ile <span>f</span>or bash an<span>d</span> .zshenv <span>f</span>or zsh),
a<span>f</span>ter all PATH/variable settings:

<strong>in my system</strong>

[-s "$<em>HOME/.rvm/scripts/rvm"</em>] source "$HOME/.rvm/scripts/rvm"  &amp;&amp; echo "add rvm sucessful …" # This loads RVM into a shell session.

* On some systems (like Ubuntu) rvmsu<span>d</span>o requires <span>f</span>ollowing changes to work properly:
http://stackover<span>f</span>low.com/questions/257616/su<span>d</span>o-changes-path-why

* To up<span>d</span>ate RVM loa<span>d</span>ing co<span>de</span> appen<span>d</span> '--auto' to 'rvm get ...'

* In case you have some ol<span>d</span> RVM <span>f</span>iles/rubies in '/usr/local/bin' or '$HOME/bin' <span><span>f</span>e</span>el <span>f</span>ree to remove them,
they were copie<span>d</span> there because o<span>f</span> bug in path <span>de</span>tection.

* ZSH 4.3.15 is buggy, be care<span>f</span>ul with it, it can break RVM, especially multiuser installations,
You shoul<span>d</span> consi<span>de</span>r <span>d</span>owngra<span>d</span>ing ZSH to 4.3.12 which has proven to work more reliable with RVM.

# RVM:  Shell scripts enabling management o<span>f</span> multiple ruby environments.
# RT<span>F</span>M: https://rvm.beginrescueen<span>d</span>.com/
# HELP: http://webchat.<span>f</span>reeno<span>de</span>.net/?channels=rvm (#rvm on irc.<span>f</span>reeno<span>de</span>.net)
# Screencast: http://screencasts.org/episo<span>de</span>s/how-to-use-rvm

# In case o<span>f</span> any issues rea<span>d</span> output o<span>f</span> 'rvm requirements' an<span>d</span>/or 'rvm notes'

Upgra<span>de</span> o<span>f</span> RVM in /usr/share/ruby-rvm/ is complete.

# jhjguxin,
#
#   Thank you <span>f</span>or using RVM!
#   I sincerely hope that RVM helps to make your li<span><span>f</span>e</span> easier an<span>d</span> more enjoyable!!!
#
# ~Wayne

install <span>De</span>pen<span>de</span>ncies:(# librea<span>d</span>line6-<span>de</span>v is <span>d</span>isable)

su<span>d</span>o apt-get install buil<span>d</span>-essential openssl librea<span>d</span>line6 curl git-core zlib1g zlib1g-<span>de</span>v libssl-<span>de</span>v libyaml-<span>de</span>v libsqlite3-0 libsqlite3-<span>de</span>v sqlite3 libxml2-<span>de</span>v libxslt-<span>de</span>v autocon<span>f</span> libc6-<span>de</span>v ncurses-<span>de</span>v automake libtool bison subversion

I<span>f</span> installation an<span>d</span> con<span>f</span>iguration were success<span>f</span>ul, RVM shoul<span>d</span> now loa<span>d</span> whenever you open a new shell. This can be teste<span>d</span> by executing the <span>f</span>ollowing comman<span>d</span> which shoul<span>d</span> output <em>'rvm is a <span>f</span>unction'</em> as shown below.
<pre>user$ type rvm | hea<span>d</span> -1
rvm is a <span>f</span>unction</pre>
rvm常用用法
运行，

安装完成后，配置启动环境，修改~/.bashrc 文件，加入（我这里并不是这个文件但是只要找到就对）

# a<span>d</span><span>d</span> rvm
i<span>f</span> [[ -s "$HOME/.rvm/scripts/rvm" ]]  ; then
source "$HOME/.rvm/scripts/rvm" ;
<span>f</span>i

在新的终端里就能看到rvm是否已安装成功：

$  rvm notes

RVM安装完成后，就可以通过TA来安装管理 Ruby 了。用下面一条命令来安装Ruby 1.9.2

$  rvm install 1.9.2

*Ruby包的下载实在太慢了，这里总是中断。有个小技巧，你可以用工具下载好ruby-1.9.2-p0.tar.bz2，然后手工放到~/.rvm/archives 目录下。然后再运行这条命令，就可以直接解压安装了。

&nbsp;

把该版本的Ruby设为默认

rvm --help
获得rvm的常用用法：

rvm [<span>F</span>lags] [Options] Action [Implementation[,Implementation[,...]]
rvm最常用的Action包括：

对Ruby的操作
主要包括读取，安装，卸载，更新，读取ruby等.

读取远程可安装的Ruby版本
#获得当前可以用的ruby版本
rvm list known
安装Ruby
#安装其中的ruby1.9.2-p290
rvm install ruby-1.9.2-p290
使用
#切换到刚刚安装的ruby1.9.2-p290版本
rvm use ruby1.9.2-p290
读取
#列出当前rvm下的ruby版本
rvm list
#查询当前使用的ruby版本路径
which ruby
#获得当前ruby版本
ruby -v
输出rvm当前使用的ruby版本与gemset信息：
rvm in<span>f</span>o
在项目文件中使用RVM
在自己的项目根目录下面，创建一个.rvmrc文件，里面内容可以指定ruby版本与gemset。例如，某项目根目录下面的.rvmrc文件内容如下：

rvm ruby-1.9.2-p290@rails31
这表示，该项目使用ruby1.9.2p290这个版本的ruby，gem安装在rails31下面。然后iterm的zsh或者bash；或者TextMate中的rubymate,rakemate；以及pow等工具就可以直接调用相应ruby版本与相应gemset。

&nbsp;

使用下面命令对RVM自己进行升级
$ rvm up<span>d</span>ate

RVM 信息

通过以下几个命令查看当前RVM当前信息

$ rvm in<span>f</span>o
$ rvm in<span>f</span>o 1.9.2
Ruby的安装使用与管理
用这个命令查看有哪些RVM可用的Ruby版本

$ rvm list known
$ rvm install 1.9.2    # 安装 ruby-1.9.2
$ rvm install ree   # install Ruby Enterprise E<span>d</span>ition (REE)

安装多个版本的Ruby之后，RVM可以很方便的进行切换。使用下条命令可以设置某一版本为当前使用版本。

$ rvm  ruby-1.8.7-p160 #切换1.8.7-p160为当前使用版本
$ rvm 1.8.7-p160    #同上面命令一样rvm ruby-1.8.7-p160
$ ruby -v #查看当前Ruby版本

&nbsp;

查看当前Ruby的安装位置

$ which ruby
设置默认使用版本
将某一个版本的ruby设为默认，这样避免每次启动新的Shell都要选择所要使用的Ruby版本。

$ rvm --default use 1.8.7   #设置1.9.2为默认版本

$ rvm <span style="background-color: #ffd700;">def</span>ault      #通过<span style="background-color: #ffd700;">def</span>ault可以快速回到默认版本
$ rvm list <span style="background-color: #ffd700;">def</span>ault     #查看当前版本设置信息
$ rvm reset     #恢复系统默认设置
查看已安装的Ruby信息
列出所有已经安装的Ruby的版本信息

$ rvm list      #列出已安装的Ruby版本

$ rvm list rubies     #同上
$ rvm list <span style="background-color: #ffd700;">def</span>ault    #显示默认Ruby版本信息
$ rvm list known     #列出RVM所支持的所有Ruby版本的信息

创建别名
使用带版本号的ruby时，每次切换时都要输入很长的版本号，非常的不方便，通过使用别名功能，可以创建很简短的别名来代替长长的ruby信息。

$ rvm alias create ree<span>d</span> ree-1.8.7-p2010.01    #为ree-187的Ruby版本创建一个别名叫：ree<span>d</span>

$ rvm use ree<span>d</span>  #通过别名迅速切换
$ rvm alias <span>de</span>lete ree<span>d</span>   #删除别名
$ rvm alias list # 查看所有的别名

删除已安装版本

$ rvm remove ruby-1.9.2-p0

$ rvm uninstall ruby-1.9.2-p0
管理 Gemsets
一个gemset就是一个目录，是某一个Ruby版本的Gem使用集，通过环境变量配置，使该gemset下的gem命令导入到Shell。

一个Ruby版本初装时就默认给了一个同名的gemset，也就是说rvm ruyb-1.9.2-p0 命令在执行时，就是使用该环境变量。

创建
基于指定Ruby版本创建一个新的Gemset

$ rvm 1.9.2  #？？？
$ rvm gemset create rails3  #创建一个名为rails3的gemset
使用
指定某一个gemset作为当前环境使用。

$ rvm 1.9.2  #？？？

$ rvm gemset use rails3   #在当前Ruby下使用rails3这个gemset

$ rvm use ruby-1.9.2-p0@rails3 #或者直接使用这种命名，直接指定ruby和gemset的信息。
$ rvm use ruby-1.9.2-p0@rails3 --<span style="background-color: #ffd700;">def</span>ault   #设置默认
查看Gemsets信息

$ rvm <span style="background-color: #ffd700;">def</span>ault  #选择使用ruby版本

列出当前Ruby版本下所有gemsets的信息r

$ rvm gemset list

列出所有Ruby版本下所有gemsets的信息

$ rvm gemset list_all
显示当前所使用的gemset信息
$ rvm gemset name     #当前gemset的名称

rails3
$ rvm gem<span>d</span>ir   #所在位置
~/.rvm/gems/ruby-1.9.2-p0@rails3
删除
删除一个gemset，默认有确认操作，使用 --<span>f</span>orce 可跳过该步骤。

$ rvm gemset <span>de</span>lete rails3  #会让确认一次
$ rvm --<span>f</span>orce gemset <span>de</span>lete rails3     #直接删除，没有确定步骤
清空
可以清空一个Gemset，删除其中的所有的gems包

$ rvm gemset empty rails3
$ rvm --<span>f</span>orce gemset empty rails3   #直接删除，没有确定步骤

导出
将当前gemsets内的信息导出到一个 name.gems文件，gems文件内定义gem的名称，版本号和其信赖关系。

$ rvm gemset export rails3.gems
导入
将gems文件所指定的gems安装到当前gemset下。

$ rvm gemset rails 3
$ rvm gemset import rails3
复制
可以将一个gemset内的所有gems包都复制到另一个gemset，很快速的复制一个当前环境。

$ rvm gemset copy 1.8.7@rails3 1.9.2-hea<span>d</span>@rails3

全局 gemsets （global gemsets）

每一个ruby版本都默认创建一个全局的gemset，以ruby_version@global命名，这样基于该ruby版本下所有的gemsets都会包含全局gemset里的gem包。可以起到统一约定的作用，也避免重复创建。
默认安装的global gemset内仅有一个gem包：rake
<div>标签： <a href="http://jhjguxin.hwcrazy.com/tag/rails/">rails</a> <a href="http://jhjguxin.hwcrazy.com/tag/ruby/">ruby</a> <a href="http://jhjguxin.hwcrazy.com/tag/rvm/">rvm</a></div>
