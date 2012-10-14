---
layout: post
title: "ubuntu11.10 双显卡笔记本 开3d特效"
date: 2011-11-09 03:04
comments: true
categories: ["网文"]
tags: ["ubuntu", "ubuntu 11.10"]
---
## ubuntu11.10 双显卡笔记本 开3d特效
我的本本是双显卡配置的，集成显卡是intel的，独立显卡是nvidia，使用系统自带的附加驱动装nvidia失败....................
<div>我也双显卡的。。。在intel集成显卡下弄好了3D桌面
ubuntu本身就能识别intel集成显卡，所以跳过显卡驱动步骤，直接安装compiz就行了</div>
<div>autoremove 所有的 nvidia包就可以开3d了</div>
<div>
如果非要安装NVIDIA驱动，</div>
<div>今天上网的时候，偶然发现了这个开源软件，刚刚更新，用于ubuntu下N卡的双显卡问题。大家可以去试试用一下。无需再禁用N卡。
<a href="https://github.com/MrMEEE/bumblebee#readme">https://github.com/MrMEEE/bumblebee#readme</a>
这个网页上有安装步骤
<a href="http://www.martin-juhl.dk/">http://www.martin-juhl.dk</a></div>
<div> </div>
<div>

ABSOLETE PROJECT:

Please READ:

<a href="http://www.martin-juhl.dk/2011/08/reassemble-of-the-bee/">http://www.martin-juhl.dk/2011/08/reassemble-of-the-bee/</a>

and

<a href="http://www.martin-juhl.dk/2011/08/ironhide-reporting-for-duty/">http://www.martin-juhl.dk/2011/08/ironhide-reporting-for-duty/</a>

&nbsp;

&nbsp;

&nbsp;

&nbsp;
IMPORTANT:

Ubuntu Users:

Bumblebee has now been packaged into a PPA @ Launchpad:

<a href="https://launchpad.net/~mj-casalogic/+archive/bumblebee/">https://launchpad.net/~mj-casalogic/+archive/bumblebee/</a>

This will probably be the most up-to-date version for Ubuntu from now on...

For people currently running the script/git version please do :

sudo bumblebee-uninstall
sudo apt-get install ppa-purge
sudo ppa-purge ppa:ubuntu-x-swat/x-updates
sudo ppa-purge ppa:xorg-edgers/ppa
sudo apt-add-repository ppa:mj-casalogic/bumblebee
sudo apt-get update
sudo apt-get install bumblebee

openSuSE Users:

Bumblebee has been ported to the openSuSE Build Service repository :

<a href="http://download.opensuse.org/repositories/home:/Ximi1970:/bumblebee/openSUSE_11.4/">http://download.opensuse.org/repositories/home:/Ximi1970:/bumblebee/openSUSE_11.4/</a>

For people currently running the script/git version please do :

sudo bumblebee-uninstall

If you have used the nVidia package option:
sudo bash NVIDIA-Linux-xxxxx-xxxx.run --uninstall

If you have used the nVidia repository (mirror) option:
rpm -e x11-video-nvidiaG02
rpm -e nvidia-computeG02
rpm -e nvidia-gfxG02-kmp
zypper rr "nVidia Graphics Drivers (local mirror)"

Install the nVidia repository and packages if you do not want to
use the nouveau driver:
zypper ar -f <a href="ftp://download.nvidia.com/opensuse/11.4">ftp://download.nvidia.com/opensuse/11.4</a> "nVidia Graphics Drivers"
zypper install nvidia-gfxG02-kmp-`uname -r | cut -f3 -d"-"`
zypper install x11-video-nvidiaG02

Installing bumblebee:

zypper ar -f <a href="http://download.opensuse.org/repositories/home:/Ximi1970:/bumblebee/openSUSE_11.4">http://download.opensuse.org/repositories/home:/Ximi1970:/bumblebee/openSUSE_11.4</a> "Bumblebee"
zypper install bumblebee

or just use Yast to add the repositories and packages.

# ----------------------------------------------------------------------------
# "Red Bull License"
#  wrote this file and is providing free support
# in any spare time. If you need extended support, you can fuel him up by
# donating a Red Bull here to get him through the nights..:
#
# <a href="http://tinyurl.com/bumblebee-project">http://tinyurl.com/bumblebee-project</a>
#
# ----------------------------------------------------------------------------

#
# ----------------------------------------------------------------------------
# "THE BEER-WARE LICENSE" (Revision 42):
#  wrote this file. As long as you retain this notice you
# can do whatever you want with this stuff. If we meet some day, and you
# think this stuff is worth it, you can buy me a beer in return Martin Juhl
# ----------------------------------------------------------------------------
#

#    This file is part of bumblebee.
#
#    bumblebee is free software: you can redistribute it and/or modify
#    it under the terms of the GNU General Public License as published by
#    the Free Software Foundation, either version 3 of the License, or
#    (at your option) any later version.
#
#    bumblebee is distributed in the hope that it will be useful,
#    but WITHOUT ANY WARRANTY; without even the implied warranty of
#    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#    GNU General Public License for more details.
#  
#    You should have received a copy of the GNU General Public License
#    along with bumblebee.  If not, see 

</div>
