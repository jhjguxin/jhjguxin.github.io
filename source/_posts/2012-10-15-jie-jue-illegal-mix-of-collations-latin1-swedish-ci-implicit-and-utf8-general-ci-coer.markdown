---
layout: post
title: "解决Illegal mix of collations (latin1_swedish_ci,IMPLICIT) and (utf8_general_ci,COER"
date: 2012-06-13 10:56
comments: true
categories: [linux]
tags: [encode,errors,mysql]
---
## 解决Illegal mix of collations (latin1_swedish_ci,IMPLICIT) and (utf8_general_ci,COER
部署完项目，测试一下，诶，数据出来了 没有多大问题（暗舒一口气）。继续测吧，一点新建完了，报错了，看看什么错误

一看完了 java.sql.SQLException: Illegal mix of collations (latin1_swedish_ci,IMPLICIT)

and (utf8_general_ci,COERCIBLE) for operation '=' 是这个错误 ，什么原因呢，第一次遇到。

头大了。去查文档说是：结果集中有两种字符集。 我晕了 ，怎么会这样呢，看看表结构，一种啊。 继续查吧。
<table width="620" border="0" cellspacing="1" cellpadding="1" align="center">
<tbody>
<tr>
<td bgcolor="#FFE7CE" width="464" height="27"> 代码如下</td>
<td align="center" bgcolor="#FFE7CE" width="109">复制代码</td>
</tr>
<tr>
<td id="copy7096" colspan="2" valign="top" bgcolor="#FFFFFF" height="auto">SHOW VARIABLES LIKE 'character_set_%'; 查看一下 显示+--------------------------+----------------------------+

| Variable_name | Value |

+--------------------------+----------------------------+

| character_set_client | utf8|

| character_set_connection | utf8|

| character_set_database | latin1 |

| character_set_results | utf8|

| character_set_server | latin1 |

| character_set_system | utf8 |

| character_sets_dir | /home/jh/<a href="http://www.111cn.net/list-110/" target="_blank">mysql</a>/share/mysql/charsets |</td>
</tr>
</tbody>
</table>
+--------------------------+----------------------------+

再用 SHOW VARIABLES LIKE 'collation_%'; 查看一下 显示
<table width="620" border="0" cellspacing="1" cellpadding="1" align="center">
<tbody>
<tr>
<td bgcolor="#FFE7CE" width="464" height="27"> 代码如下</td>
<td align="center" bgcolor="#FFE7CE" width="109">复制代码</td>
</tr>
<tr>
<td id="copy1112" colspan="2" valign="top" bgcolor="#FFFFFF" height="auto">+----------------------+-------------------+| Variable_name | Value |

+----------------------+-------------------+

| collation_connection | utf8_swedish_ci |

| collation_database | latin1_swedish_ci |

| collation_server | latin1_swedish_ci |

+----------------------+-------------------+</td>
</tr>
</tbody>
</table>
原来如此啊 哈哈 知道错在哪里 剩下的就好办了

<strong>解决方法：</strong>

依次执行：
<table width="620" border="0" cellspacing="1" cellpadding="1" align="center">
<tbody>
<tr>
<td bgcolor="#FFE7CE" width="464" height="27"> 代码如下</td>
<td align="center" bgcolor="#FFE7CE" width="109">复制代码</td>
</tr>
<tr>
<td id="copy2457" colspan="2" valign="top" bgcolor="#FFFFFF" height="auto">set character_set_database =utf8;

&nbsp;

set character_set_results =utf8;

&nbsp;

set character_set_server =utf8;

&nbsp;

set character_set_system =utf8; --此处utf-8也可以

&nbsp;

然后执行：

&nbsp;

SET collation_server = utf8_general_ci

&nbsp;

&nbsp;

SET collation_database = utf8_general_ci</td>
</tr>
</tbody>
</table>
执行完之后，请检查mysql下每个<a href="http://www.111cn.net/database/database.html" target="_blank">数据库</a>，表，字段是否都是utf8，不是则改过来，这样子就不会出现

&nbsp;

最笨的方法是重装一下数据库。（一般不要用这种方法呀）

最终解决方法：

1.1 如果是windows版本的mysql，那么在安装的时候，系统就会提示用哪种编码。

如果安装的时候设置错误了，修改mysql安装目录下的my.ini文件：
<table width="620" border="0" cellspacing="1" cellpadding="1" align="center">
<tbody>
<tr>
<td bgcolor="#FFE7CE" width="464" height="27"> 代码如下</td>
<td align="center" bgcolor="#FFE7CE" width="109">复制代码</td>
</tr>
<tr>
<td id="copy1531" colspan="2" valign="top" bgcolor="#FFFFFF" height="auto">[mysql]default-character-set=utf8

...

# The default character set that will be used when a new schema or table is

# created and no character set is defined

default-character-set=utf8</td>
</tr>
</tbody>
</table>
配置好后，重启mysql。

1.2 如果是linux版本的mysql

&nbsp;

修改mysql的配置文件,使数据库与服务器操作系统的字符集设置一致。

vi /etc/my.cnf 设置(如果没有发现这个文件，就新建1个)
<table width="620" border="0" cellspacing="1" cellpadding="1" align="center">
<tbody>
<tr>
<td bgcolor="#FFE7CE" width="464" height="27"> 代码如下</td>
<td align="center" bgcolor="#FFE7CE" width="109">复制代码</td>
</tr>
<tr>
<td id="copy7728" colspan="2" valign="top" bgcolor="#FFFFFF" height="auto">[mysqld]datadir=/var/lib/mysql

socket=/var/lib/mysql/mysql.sock

default-character-set=utf8</td>
</tr>
</tbody>
</table>
(增加的关键一句,使得数据库缺省以utf8存储)

当然，修改后，要重启数据库。（这样设置后对新建的数据库表才起作用）

&nbsp;
<table width="620" border="0" cellspacing="1" cellpadding="1" align="center">
<tbody>
<tr>
<td bgcolor="#FFE7CE" width="464" height="27"> 代码如下</td>
<td align="center" bgcolor="#FFE7CE" width="109">复制代码</td>
</tr>
<tr>
<td id="copy8374" colspan="2" valign="top" bgcolor="#FFFFFF" height="auto">用SHOW VARIABLES LIKE 'character_set_%';命令查看到如下内容：+--------------------------+-----------------------------------------------------------------------+

| Variable_name | Value |

+--------------------------+-----------------------------------------------------------------------+

| character_set_client | utf8|

| character_set_connection | utf8|

| |character_set_database |utf8 |

| character_set_filesystem | binary |

| character_set_results | utf8|

| character_set_server | utf8 |

| character_set_system | utf8 |

| character_sets_dir | /home/jh/mysql/share/mysql/charsets |

+--------------------------+-----------------------------------------------------------------------+</td>
</tr>
</tbody>
</table>
发现关键项目已经用了utf8，但这样还不够，还要保证客户端也是用utf8的字符集来操作的。

登录的时候，要用以下命令：mysql --default-character-set=utf8 -u root -p

再次用SHOW VARIABLES LIKE 'character_set_%';命令查看，结果变成了：
<table width="620" border="0" cellspacing="1" cellpadding="1" align="center">
<tbody>
<tr>
<td bgcolor="#FFE7CE" width="464" height="27"> 代码如下</td>
<td align="center" bgcolor="#FFE7CE" width="109">复制代码</td>
</tr>
<tr>
<td id="copy4025" colspan="2" valign="top" bgcolor="#FFFFFF" height="auto">+--------------------------+-----------------------------------------------------------------------+| Variable_name | Value |

+--------------------------+-----------------------------------------------------------------------+

| character_set_client | utf8 |

| character_set_connection | utf8 |

| character_set_database | utf8 |

| character_set_filesystem | binary |

| character_set_results | utf8 |

| character_set_server | utf8 |

| character_set_system | utf8 |

| character_sets_dir | /home/jh/mysql/share/mysql/charsets/ |</td>
</tr>
</tbody>
</table>
+--------------------------+-----------------------------------------------------------------------+

这样才能保证客户端所发命令都是基于utf8格式的，比如说建立数据库和表，默认就会以utf8编码，而无须再次指定。（再次说一句对新建的数据库和表起作用）。

另外：

第三种方法：网上看到的，先记录一下。

1.如果安装mysql的编码已不能更改,很多朋友是购买虚拟主机建立网站,无权更改MYSQL的安装编码,这一关我们可以跳过,因为只要后面的步聚正确,一样能解决乱码问题
2.修改数据库编码，如果是数据库编码不正确: 可以在<a href="http://www.111cn.net/phper/php.html" target="_blank">php</a>myadmin 执行如下命令: ALTER DATABASE `test` DEFAULT CHARACTER SET utf8 COLLATE utf8_bin
以上命令就是将test数据库的编码设为utf8
3.修改表的编码：
<table width="620" border="0" cellspacing="1" cellpadding="1" align="center">
<tbody>
<tr>
<td bgcolor="#FFE7CE" width="464" height="27"> 代码如下</td>
<td align="center" bgcolor="#FFE7CE" width="109">复制代码</td>
</tr>
<tr>
<td id="copy1726" colspan="2" valign="top" bgcolor="#FFFFFF" height="auto">ALTER TABLE `category` DEFAULT CHARACTER SET utf8 COLLATE utf8_bin</td>
</tr>
</tbody>
</table>
以上命令就是将一个表category的编码改为utf8
4.修改字段的编码：
<table width="620" border="0" cellspacing="1" cellpadding="1" align="center">
<tbody>
<tr>
<td bgcolor="#FFE7CE" width="464" height="27"> 代码如下</td>
<td align="center" bgcolor="#FFE7CE" width="109">复制代码</td>
</tr>
<tr>
<td id="copy2640" colspan="2" valign="top" bgcolor="#FFFFFF" height="auto">
<pre>mysql&gt; use askjane_development;
Database changed
mysql&gt; alter database mydb character set utf8;
ERROR 1 (HY000): Can't create/write to file './mydb/db.opt' (Errcode: 2)
mysql&gt; ALTER TABLE tags CONVERT TO CHARACTER SET utf8 COLLATE utf8_general_ci;Query OK, 2 rows affected (0.35 sec)</pre>
</td>
</tr>
</tbody>
</table>
以上命令就是将test表中 dd的字段编码改为utf8
5.如果是这种情况容易解决，只需检查下页面，修改源文件的charset即可
, //这个正确就无问题了
6.这种情况也是修改页面charset即可.

&nbsp;
