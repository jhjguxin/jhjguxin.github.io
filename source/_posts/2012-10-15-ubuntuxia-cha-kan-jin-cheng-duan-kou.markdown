---
layout: post
title: "ubuntu下查看进程端口 "
date: 2012-02-16 15:08
comments: true
categories: ["未分类"]
tags: ["port", "ubuntu"]
---
## ubuntu下查看进程端口 
# 查看所有打开的端口及服务名（注意这里显示的服务名只是标准端口对应的服务名，可能并不准确）

nmap localhost

# 查看哪些进程打开了指定端口port（对于守护进程必须以root用户执行才能查看到）

lsof -i:port             +sudo比较好

# 查看哪些进程打开了指定端口port，最后一列是进程ID（此方法对于守护进程作用不大）

netstat -nap|grep port

# 查看端口号对应的系统服务名称

cat /etc/services

# 启动｜停止｜重启系统服务

sudo /etc/init.d/service start|stop|restart

 

常见端口详细说明 

服务及对应端口　　　 　　　　　　服务及对应端口　　　 
Echo（7）　　　　　　　　　　　　　　　　　FTP（21） 
Ssh（22）　　　　　　　　　　　　　　　　　Telnet（23） 
SMTP（25）　　　　　　　　　　　　　　　　 DNS（53） 
HTTP（80）　　　　　　　　　　　　　　　　 MTA-X.400 over TCP/IP（102） 
pop3（110）　　　　　　　　　　　　　　　　NETBIOS Name Service（137、 
138、139） 
IMAP v2（143）　　　　　　　　　　　　　　 SNMP（161） 
LDAP、ILS（389）　　　　　　　　　　　　　 Https（443） 
IMAP(993)                                SQL(1433) 
NetMeeting T.120(1503)                   NetMeeting(1720) 
NetMeeting Audio Call Control(1731)      超级终端(3389)  
QQ客户端(4000)                            pcAnywere(5631) 
RealAudio(6970)                           Sygate (7323) 
OICQ(8000)                               Wingate(8010) 
代理端口(8080) 
1、端口：7 
服务：Echo 
说明：能看到许多人搜索Fraggle放大器时，发送到X.X.X.0和X.X.X.255的信息。 
2、端口：21 
服务：FTP 
说明：FTP服务器所开放的端口，用于上传、下载。最常见的攻击者用于寻找打开anonymous的FTP服务器的方法。这些服务器带有可读写的目录。木马Doly Trojan、Fore、Invisible FTP、WebEx、WinCrash和Blade Runner所开放的端口。 
3、端口：22 
服务：Ssh 
说明：PcAnywhere建立的TCP和这一端口的连接可能是为了寻找ssh。这一服务有许多弱点，如果配置成特定的模式，许多使用RSAREF库的版本就会有不少的漏洞 
存在。 
4、端口：23 
服务：Telnet 
说明：远程登录，入侵者在搜索远程登录UNIX的服务。大多数情况下扫描这一端口是为了找到机器运行的操作系统。还有使用其他技术，入侵者也会找到密码。木马Tiny Telnet Server就开放这个端口。 
5、端口：25 
服务：SMTP 
说明：SMTP服务器所开放的端口，用于发送邮件。入侵者寻找SMTP服务器是为了传递他们的SPAM。入侵者的帐户被关闭，他们需要连接到高带宽的E-MAIL服务器上，将简单的信息传递到不同的地址。木马Antigen、Email Password Sender、Haebu Coceda、Shtrilitz Stealth、WinPC、WinSpy都开放这个端口。 
6、端口：53 
服务：Domain Name Server（DNS）
说明：DNS服务器所开放的端口，入侵者可能是试图进行区域传递（TCP），欺骗DNS（UDP）或隐藏其他的通信。因此防火墙常常过滤或记录此端口。 
7、端口：80 
服务：HTTP 
说明：用于网页浏览。木马Executor开放此端口。 
8、端口：102 
服务：Message transfer agent(MTA)-X.400 over TCP/IP 
说明：消息传输代理。 
9、端口：110 
服务：pop3
说明：POP3(Post Office Protocol 3)服务器开放此端口，用于接收邮件，客户端访问服务器端的邮件服务。POP3服务有许多公认的弱点。关于用户名和密码交换缓冲区溢出的弱点至少有20个，这意味着入侵者可以在真正登陆前进入系统。成功登陆后还有其他缓冲区溢出错误。
10、端口：137、138、139 
服务：NETBIOS Name Service 
说明：其中137、138是UDP端口，当通过网上邻居传输文件时用这个端口。而139端口：通过这个端口进入的连接试图获得NetBIOS/SMB服务。这个协议被用于windows文件和打印机共享和SAMBA。还有WINS Regisrtation也用它。 
11、端口：143 
服务：Interim Mail Access Protocol v2 
说明：和POP3的安全问题一样，许多IMAP服务器存在有缓冲区溢出漏洞。记住： 
一种LINUX蠕虫（admv0rm）会通过这个端口繁殖，因此许多这个端口的扫描来自不知情的已经被感染的用户。当REDHAT在他们的LINUX发布版本中默认允许IMAP后，这些漏洞变的很流行。这一端口还被用于IMAP2，但并不流行。 
12、端口：161 
服务：SNMP 
说明：SNMP允许远程管理设备。所有配置和运行信息的储存在数据库中，通过SNMP可获得这些信息。许多管理员的错误配置将被暴露在Internet。Cackers将试图使用默认的密码public、private访问系统。他们可能会试验所有可能的组合。
SNMP包可能会被错误的指向用户的网络。 
13、端口：389 
服务：LDAP、ILS 
说明：轻型目录访问协议和NetMeeting Internet Locator Server共用这一端口 。 
14、端口：443 
服务：Https 
说明：网页浏览端口，能提供加密和通过安全端口传输的另一种HTTP。 
15、端口：993 
服务：IMAP 
说明：SSL（Secure Sockets layer） 
16、端口：1433 
服务：SQL 
说明：Microsoft的SQL服务开放的端口。 
17、端口：1503 
服务：NetMeeting T.120 
说明：NetMeeting T.120 
18、端口：1720 
服务：NetMeeting 
说明：NetMeeting H.233 call Setup。 
19、端口：1731 
服务：NetMeeting Audio Call Control 
说明：NetMeeting音频调用控制。 
20、端口：3389 
服务：超级终端
说明：WINDOWS 2000终端开放此端口。 
21、端口：4000 
服务：QQ客户端
说明：腾讯QQ客户端开放此端口。 
22、端口：5631
服务：pcAnywere 
说明：有时会看到很多这个端口的扫描，这依赖于用户所在的位置。当用户打开pcAnywere时，它会自动扫描局域网C类网以寻找可能的代理（这里的代理是指agent而不是proxy）。入侵者也会寻找开放这种服务的计算机。，所以应该查看这种扫描的源地址。一些搜寻pcAnywere的扫描包常含端口22的UDP数据包。 
23、端口：6970 
服务：RealAudio 
说明：RealAudio客户将从服务器的6970-7170的UDP端口接收音频数据流。这是由TCP-7070端口外向控制连接设置的。 
24、端口：7323 
服务：[NULL] 
说明：Sygate服务器端。 
25、端口：8000 
服务：OICQ 
说明：腾讯QQ服务器端开放此端口。 
26、端口：8010 
服务：Wingate 
说明：Wingate代理开放此端口。 
27、端口：8080
服务：代理端口
说明：WWW代理开放此端口
