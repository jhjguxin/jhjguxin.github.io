---
layout: post
title: "通过mongodump和mongorestore实现Mongodb备份和恢复 --by chenzhou123520"
date: 2012-10-08 22:29
comments: true
categories: ["DB"]
tags: ["mongo", "MongoDB", "mongodump", "mongorestore", "nosql", "备份", "恢复"]
---
## 通过mongodump和mongorestore实现Mongodb备份和恢复 --by chenzhou123520
from <a href="http://chenzhou123520.iteye.com/blog/1630993">http://chenzhou123520.iteye.com/blog/1630993</a>

Mongodb自带了mongodump和mongorestore这两个工具来实现对数据的备份和恢复。

mongodump能够在Mongodb运行时进行备份，它的工作原理是对运行的Mongodb做查询，然后将所有查到的文档写入磁盘。但是存在的问题时使用mongodump产生的备份不一定是数据库的实时快照，如果我们在备份时对数据库进行了写入操作，则备份出来的文件可能不完全和Mongodb实时数据相等。另外在备份时可能会对其它客户端性能产生不利的影响。

mongodump用法如下：
<pre>[root@localhost mongodb]# ./bin/mongodump --help
Export MongoDB data to BSON files.

options:
  --help                   produce help message
  -v [ --verbose ]         be more verbose (include multiple times for more
                           verbosity e.g. -vvvvv)
  --version                print the program&#039;s version and exit
  -h [ --host ] arg        mongo host to connect to ( &lt;set name&gt;/s1,s2 for
                           sets)
  --port arg               server port. Can also use --host hostname:port
  --ipv6                   enable IPv6 support (disabled by default)
  -u [ --username ] arg    username
  -p [ --password ] arg    password
  --dbpath arg             directly access mongod database files in the given
                           path, instead of connecting to a mongod  server -
                           needs to lock the data directory, so cannot be used
                           if a mongod is currently accessing the same path
  --directoryperdb         if dbpath specified, each db is in a separate
                           directory
  --journal                enable journaling
  -d [ --db ] arg          database to use
  -c [ --collection ] arg  collection to use (some commands)
  -o [ --out ] arg (=dump) output directory or &quot;-&quot; for stdout
  -q [ --query ] arg       json query
  --oplog                  Use oplog for point-in-time snapshotting
  --repair                 try to recover a crashed database
  --forceTableScan         force a table scan (do not use $snapshot)</pre>
参数说明：

-h:指明数据库宿主机的IP

-u:指明数据库的用户名

-p:指明数据库的密码

-d:指明数据库的名字

-c:指明collection的名字

-o:指明到要导出的文件名

-q:指明导出数据的过滤条件

具体使用示例如下：
<pre>[root@localhost mongodb]# ./bin/mongodump -d test -o data/backup
connected to: 127.0.0.1
DATABASE: test	 to 	data/backup/test
	test.system.indexes to data/backup/test/system.indexes.bson
		 9 objects
	test.users to data/backup/test/users.bson
		 3 objects
	test.games to data/backup/test/games.bson
		 1 objects
	test.blog.post to data/backup/test/blog.post.bson
		 1 objects
	test.lists to data/backup/test/lists.bson
		 1 objects
	test.math to data/backup/test/math.bson
		 1 objects
	test.map to data/backup/test/map.bson
		 8 objects
	test.my_collection to data/backup/test/my_collection.bson
		 0 objects
	test.foo to data/backup/test/foo.bson
		 6 objects
	test.system.users to data/backup/test/system.users.bson
		 1 objects</pre>
mongorestore是Mongodb从备份中恢复数据的工具，它主要用来获取mongodump的输出结果，并将备份的数据插入到运行的Mongodb中。

mongorestore命令使用方法如下：
<pre>[root@localhost mongodb]# ./bin/mongorestore --help
usage: ./bin/mongorestore [options] [directory or filename to restore from]
options:
  --help                  produce help message
  -v [ --verbose ]        be more verbose (include multiple times for more
                          verbosity e.g. -vvvvv)
  --version               print the program&#039;s version and exit
  -h [ --host ] arg       mongo host to connect to ( &lt;set name&gt;/s1,s2 for sets)
  --port arg              server port. Can also use --host hostname:port
  --ipv6                  enable IPv6 support (disabled by default)
  -u [ --username ] arg   username
  -p [ --password ] arg   password
  --dbpath arg            directly access mongod database files in the given
                          path, instead of connecting to a mongod  server -
                          needs to lock the data directory, so cannot be used
                          if a mongod is currently accessing the same path
  --directoryperdb        if dbpath specified, each db is in a separate
                          directory
  --journal               enable journaling
  -d [ --db ] arg         database to use
  -c [ --collection ] arg collection to use (some commands)
  --objcheck              validate object before inserting
  --filter arg            filter to apply before inserting
  --drop                  drop each collection before import
  --oplogReplay           replay oplog for point-in-time restore
  --keepIndexVersion      don&#039;t upgrade indexes to newest version</pre>
参数说明：

-h:指明数据库宿主机的IP

-u:指明数据库的用户名

-p:指明数据库的密码

-d:指明数据库的名字

-c:指明collection的名字

-o:指明到要备份的文件名

-q:指明备份数据的过滤条件

&nbsp;

具体使用示例如下：
<pre>[root@localhost mongodb]# ./bin/mongorestore -d test --drop data/backup/test/
connected to: 127.0.0.1
Tue Aug 14 01:18:17 data/backup/test/games.bson
Tue Aug 14 01:18:17 	 going into namespace [test.games]
Tue Aug 14 01:18:17 	 dropping
1 objects found
Tue Aug 14 01:18:17 data/backup/test/foo.bson
Tue Aug 14 01:18:17 	 going into namespace [test.foo]
Tue Aug 14 01:18:17 	 dropping
6 objects found
Tue Aug 14 01:18:17 data/backup/test/blog.post.bson
Tue Aug 14 01:18:17 	 going into namespace [test.blog.post]
Tue Aug 14 01:18:17 	 dropping
1 objects found
Tue Aug 14 01:18:17 data/backup/test/lists.bson
Tue Aug 14 01:18:17 	 going into namespace [test.lists]
Tue Aug 14 01:18:17 	 dropping
1 objects found
Tue Aug 14 01:18:17 data/backup/test/map.bson
Tue Aug 14 01:18:17 	 going into namespace [test.map]
Tue Aug 14 01:18:17 	 dropping
8 objects found
Tue Aug 14 01:18:17 data/backup/test/math.bson
Tue Aug 14 01:18:17 	 going into namespace [test.math]
Tue Aug 14 01:18:17 	 dropping
1 objects found
Tue Aug 14 01:18:17 data/backup/test/system.users.bson
Tue Aug 14 01:18:17 	 going into namespace [test.system.users]
1 objects found
Tue Aug 14 01:18:17 data/backup/test/my_collection.bson
Tue Aug 14 01:18:17 	 going into namespace [test.my_collection]
Tue Aug 14 01:18:17 	 dropping
Tue Aug 14 01:18:17 file data/backup/test/my_collection.bson empty, skipping
Tue Aug 14 01:18:17 data/backup/test/users.bson
Tue Aug 14 01:18:17 	 going into namespace [test.users]
Tue Aug 14 01:18:17 	 dropping
3 objects found
Tue Aug 14 01:18:17 data/backup/test/system.indexes.bson
Tue Aug 14 01:18:17 	 going into namespace [test.system.indexes]
Tue Aug 14 01:18:17 	 dropping
Tue Aug 14 01:18:17 { key: { _id: 1 }, ns: &quot;test.users&quot;, name: &quot;_id_&quot; }
Tue Aug 14 01:18:17 { key: { _id: 1 }, ns: &quot;test.games&quot;, name: &quot;_id_&quot; }
Tue Aug 14 01:18:17 { key: { _id: 1 }, ns: &quot;test.blog.post&quot;, name: &quot;_id_&quot; }
Tue Aug 14 01:18:17 { key: { _id: 1 }, ns: &quot;test.lists&quot;, name: &quot;_id_&quot; }
Tue Aug 14 01:18:17 { key: { _id: 1 }, ns: &quot;test.math&quot;, name: &quot;_id_&quot; }
Tue Aug 14 01:18:17 { key: { _id: 1 }, ns: &quot;test.map&quot;, name: &quot;_id_&quot; }
Tue Aug 14 01:18:17 { key: { gps: &quot;2d&quot; }, ns: &quot;test.map&quot;, name: &quot;gps_&quot;, min: -180.0, max: 181.0 }
Tue Aug 14 01:18:17 { key: { _id: 1 }, ns: &quot;test.foo&quot;, name: &quot;_id_&quot; }
Tue Aug 14 01:18:17 { key: { _id: 1 }, ns: &quot;test.system.users&quot;, name: &quot;_id_&quot; }
9 objects found</pre>
&nbsp;
