---
layout: post
title: "ubuntu 下利用ndiswrapper安装无线网卡驱动"
date: 2012-03-31 21:49
comments: true
categories: [ubuntu]
tags: [driver,ndisgtk,wifi]
---
## ubuntu 下利用ndiswrapper安装无线网卡驱动
<div>

首先 安装 ndiswrapper
ubuntu下也就是 ndisgtk   (用于安装无线网卡驱动)

sudo apt-get install ndisgtk

安装好了之后，找到你的无线网卡在windows下的驱动文件(含有.inf的目录)（可以从网上下载也可以从驱动盘中获得），将该目录中的文件拷到主目录的新建文件夹中，
执行 sudo ndiswrapper -i yourname.inf     //yourname是你驱动inf的文件名称
安装以后会在  /etc/ndiswrapper/  下面建立一个相应的目录youname，

到该目录下(cd /etc/ndiswrapper)执行  sudo ndiswrapper -l   //查看驱动安装ok了没 显示driver installed

写入配置文件：
sudo ndiswrapper -m           (让ndiswrapper在启动时自动加载,
无线网卡会在系统启动初始化hotplug subsysytem时装载(这时卡上的电源灯才会亮) )

modprobe ndiswrapper        （让linux加载ndiswrapper module）

这样就可以配置无线网卡了，在SSID中输入无线路由名，在“无线安全性”中选择“WPA及WPA2个人”，然后输入密码即可。

配置好后重启下无线网络即连接成功。

终端中的步骤：

sudo apt-get install ndisgtk

# sudo ndiswrapper -i net8192u.inf

cd /etc/ndiswrapper/

sudo ndiswrapper -l

sudo ndiswrapper -m

sudo ndiswrapper -mi   \\保证重启之后不再设置

sudo modprobe ndiswrapper

最后设置无线网络连接。

</div>
