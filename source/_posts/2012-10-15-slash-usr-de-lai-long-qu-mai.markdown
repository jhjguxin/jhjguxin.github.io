---
layout: post
title: "/usr 的来龙去脉"
date: 2011-12-28 18:21
comments: true
categories: ["网文"]
tags: ["linux", "usr"]
---
## /usr 的来龙去脉
在 linux 文件结构中，有一个很神奇的目录 —— /usr。之前一直没有怎么关注过它，反正程序都是安装在里边的，也没有什么值得追根溯源的东西。直到有一天 <a href="http://cnbeta.com/articles/160791.htm">fedora 要简化整个文件系统体系</a>，看到讨论才想到，usr 到底是什么的缩写呢，它又是怎么来的呢？

讨论中，大部分观点认为：
<ul>
	<li>usr 是 unix system resources 的缩写；</li>
	<li>usr 是 user 的缩写；</li>
	<li>usr 是 unix software resources 的缩写。</li>
</ul>
根据常识判断，是 user 缩写的可能性不大，因为和 /home 冲突了嘛。不过是 system resources 还是 software resources 的缩写还真不好说。特此查了好多东西，却发现竟然连 <a href="http://en.wikipedia.org/wiki/Filesystem_Hierarchy_Standard">wikipedia 也模棱两可</a>。

后来终于找到了 相关的文档和介绍。（<a href="http://tldp.org/LDP/Linux-Filesystem-Hierarchy/html/usr.html">via</a>，<a href="http://webcache.googleusercontent.com/search?q=cache:HBW07QkS9DsJ:tldp.org/LDP/Linux-Filesystem-Hierarchy/html/usr.html+&amp;cd=1&amp;hl=en&amp;ct=clnk">cache</a>）
<blockquote>/usr usually contains by far the largest share of data on a system. Hence, this is one of the most important directories in the system as it contains all the user binaries, their documentation, libraries, header files, etc…. X and its supporting libraries can be found here. User programs like telnet, ftp, etc…. are also placed here. In the original Unix implementations, /usr was where the home directories of the users were placed (that is to say, /usr/someone was then the directory now known as /home/someone). In current Unices, /usr is where user-land programs and data (as opposed to ’system land’ programs and data) are. <strong>The name hasn’t changed, but it’s meaning has narrowed and lengthened from “everything user related” to “user usable programs and data”. As such, some people may now refer to this directory as meaning ‘User System Resources’ and not ‘user’ as was originally intended.</strong>（via<a href="http://tldp.org/LDP/Linux-Filesystem-Hierarchy/html/usr.html">1</a>,<a href="http://en.wikipedia.org/wiki/Unix_directory_structure">2</a>）</blockquote>
/usr 是系统核心所在，包含了所有的共享文件。它是 unix 系统中最重要的目录之一，涵盖了二进制文件，各种文档，各种头文件，x，还有各种库文件；还有诸多程序，例如 ftp，telnet 等等。

曾经的 /usr 还是用户的家目录，存放着各种用户文件 —— 现在已经被 /home 取代了（例如 /usr/someone 已经改为 /home/someone）。现代的 /usr 只专门存放各种程序和数据，用户目录已经转移。虽然  /usr 名称未改，不过其含义已经从“用户目录”变成了“unix 系统资源”目录。值得注意的是，在一些 unix 系统上，仍然把 /usr/someone 当做用户家目录，如 Minix。

至此，真相大白。看来就像前一阵子的 <a href="http://linux.solidot.org/linux/11/03/31/0958237.shtml">/var/run 移到 /run</a> 一样。

真的是不看不知道，一看吓一跳呀。原来 linux 几经进化，好多目录的诞生和用途已经产生了根本的变化。历史车轮在前进，长江后浪推前浪，正所谓：学习历史，收获真知；尽心竭力，前进不止。
<h2><strong>附录：/usr 目录结构</strong></h2>
<ul>
	<li><strong>/usr/bin</strong> : 所有可执行文件，如 gcc，firefox 等（指不包含在 <strong>/sbin</strong> 和 <strong>/bin</strong> 内的）；</li>
	<li><strong>/usr/include</strong> : 各种头文件，编译文件等时需要使用；
<ul>
	<li><strong>/usr/include/’package-name’</strong> : 程序特定的头文件；</li>
</ul>
</li>
	<li><strong>/usr/lib</strong> : 所以可执行文件所需要的库文件；</li>
	<li><strong>/usr/local </strong>: /usr 通常只包含系统发行时自带的程序，而 /usr/local 则是本地系统管理员用来自由添加程序的目录；</li>
	<li><strong>/usr/X11R6</strong> : x 系统的二进制文件，库文件，文档，字体等。它不等同于 /usr 的作用，只有 x 才能调用这些库文件等，其他程序不读取或者使用。因为 linux 没有原生图形界面，而且 linux 大部分情况下是 for server 的，所以图形界面没有意义；其中 X11R6 代表 version 11 release 6；
<ul>
	<li><strong>/usr/X11R6/bin</strong> : x 的二进制文件，包含运行 x 的必须文件；</li>
	<li><strong>/usr/X11R6/include</strong> : x 相关的头文件；</li>
	<li><strong>/usr/X11R6/lib</strong> : x 库文件；</li>
	<li><strong>/usr/X11R6/lib/modules</strong> : x 的模块，启动时加载。缺少 video4linux, DRI and GLX 和 输入输出设备 模块，将工作不正常；</li>
	<li><strong>/usr/X11R6/lib/X11/fonts</strong> : x font server 的字体文件；</li>
</ul>
</li>
	<li><strong>/usr/doc</strong> : 文档。实际是<strong> /usr/share/doc </strong>的软链接；</li>
	<li><strong>/usr/etc</strong> : 一个极少用到的配置文件存放地；</li>
	<li><strong>/usr/games</strong> : 曾经包含游戏等文件，现在很少用到；</li>
	<li><strong>/usr/info</strong> : 系统相关信息，是 <strong>/usr/share/info </strong>的软链接；</li>
	<li><strong>/usr/man</strong> : man 手册，已经移至 <strong>/usr/share/man</strong>；</li>
	<li><strong>/usr/sbin</strong> : 类似 /sbin，root 可以执行。但此目录不包含在环境变量 $PATH 中，它包含的程序类似于 chroot, useradd, in.tftpd and pppconfig；</li>
	<li><strong>/usr/share</strong> : 它包含了各种程序间的共享文件，如字体，图标，文档等。（/usr/local 对应的目录是  /usr/loca/share）;
<ul>
	<li><strong>/usr/share/doc</strong> : 类似应用程序的 man 手册。它包含程序的说明文件，默认配置文件等；</li>
	<li><strong>/usr/share/info</strong> : 不常用，已经被 man 代替；</li>
	<li><strong>/usr/share/man</strong> : app 的 manual；</li>
	<li><strong>/usr/share/icons</strong> : 应用程序的图标等文件，分为 png，svg 等多种格式；</li>
	<li><strong>/usr/share/fonts</strong> : 字体文件，系统范围内可使用，~/.fonts 仅当前用户可用；</li>
</ul>
</li>
	<li><strong>/usr/src</strong> : linux 内核的源码和说明文档等；
<ul>
	<li><strong>/usr/src/linux</strong> : linux 源代码；</li>
	<li><strong>/usr/src/linux/.config</strong> : 内核编译过程产生的文件；通常由命令 ‘make config’ ， ‘make menuconfig’ 或 ‘make xconfig’ 执行后产生；</li>
	<li><strong>/usr/src/linux/.depend, /usr/src/linux/.hdepend</strong> : ‘make dep’ 检测编译依赖时需要的文件，由 /usr/src/linux/.config 产生；</li>
	<li><strong>/usr/src/linux/COPYING</strong> : GNU license；</li>
	<li><strong>/usr/src/linux/Makefile</strong> : 编译内核所需的 Makefile；</li>
	<li><strong>/usr/src/linux/Rules.make</strong> : 当有多个 Makefile 时，根据它的规则执行 make；</li>
</ul>
</li>
	<li><strong>/usr/tmp</strong> : 已经被众多发行版抛弃的临时文件夹。</li>
</ul>
