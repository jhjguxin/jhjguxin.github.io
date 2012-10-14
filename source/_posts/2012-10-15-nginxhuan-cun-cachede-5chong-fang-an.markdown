---
layout: post
title: "nginx缓存cache的5种方案"
date: 2011-11-30 17:54
comments: true
categories: [网文]
tags: [cache,nginx,web,website-manage]
---
## nginx缓存cache的5种方案
<div>

1. 客户端浏览器上的缓存(非Cookie, Cookie中的内容为: 键和值均为string类型的键值对)

我们可以通过在Http回应中增加特定的头部说明来指定浏览器的缓存策略; 添加头部说明的手段既可以通过页面指令声明设置, 也可以通过编程方式设置.

&nbsp;

对于图片、Javascript脚本、CSS等资源, 可以在IIS管理器中, 右击图片等资源, 选择”属性” --&gt; HttpHeaders后, 勾选Enable Content Expiration并设置时间即可. 一种值得推荐的手段是, 将需要缓存的资源分类, 如: image/dynamic/、image/static/, 这样我们可以再文件夹上, 选择属性中的HttpHeaders进行设置. 否则, 针对每一个静态资源设置HttpHeaders将是件非常痛苦的事情. 此外, 还可以采用一款名为CacheRight的工具可以提供缓存资源的统一配置.

&nbsp;

<strong>查看或设置浏览器缓存位置:</strong>  IE --&gt; Internet选项 --&gt; 常规 --&gt; 临时Internet文件 --&gt; 设置

<strong> </strong>

<strong>Html</strong><strong>文件的Head</strong><strong>中的缓存设置:</strong>

&lt;meta http-equiv="pragma" content="no-cache" /&gt;

&lt;meta http-equiv="Cache-Control" content="no-cache" /&gt;

&lt;meta http-equiv="expires" content="Wed, 26 Feb 1997 08:21:57 GMT" /&gt;

<strong>浏览器中关于Cache</strong><strong>的3</strong><strong>属性:</strong>

Cache-Control:

设置相对过期时间, max-age指明以秒为单位的缓存时间. 若对静态资源只缓存一次, 可以设置max-age的值为315360000000 (一万年).

<strong>Http</strong><strong>协议的cache-control</strong><strong>的常见取值及其组合释义:</strong>

no-cache: 数据内容不能被缓存, 每次请求都重新访问服务器, 若有max-age, 则缓存期间不访问服务器.

no-store: 不仅不能缓存, 连暂存也不可以(即: 临时文件夹中不能暂存该资源)

private(默认): 只能在浏览器中缓存, 只有在第一次请求的时候才访问服务器, 若有max-age, 则缓存期间不访问服务器.

public: 可以被任何缓存区缓存, 如: 浏览器、服务器、代理服务器等

max-age: 相对过期时间, 即以秒为单位的缓存时间.

no-cache, private: 打开新窗口时候重新访问服务器, 若设置max-age, 则缓存期间不访问服务器.

private, 正数的max-age: 后退时候不会访问服务器

no-cache, 正数的max-age: 后退时会访问服务器

点击刷新: 无论如何都会访问服务器.

Expires:

设置以分钟为单位的绝对过期时间, 优先级比Cache-Control低, 同时设置Expires和Cache-Control则后者生效.

Last-Modified:

该资源的最后修改时间, 在浏览器下一次请求资源时, 浏览器将先发送一个请求到服务器上, 并附上If-Unmodified-Since头来说明浏览器所缓存资源的最后修改时间, 如果服务器发现没有修改, 则直接返回304(Not Modified)回应信息给浏览器(内容很少), 如果服务器对比时间发现修改了, 则照常返回所请求的资源.

&nbsp;

注意:

Last-Modified属性通常和Expires或Cache-Control属性配合使用, 因为即使浏览器设置缓存, 当用户点击”刷新”按钮时, 浏览器会忽略缓存继续向服务器发送请求, 这时Last-Modified将能够很好的减小回应开销.

&nbsp;

ETag将返回给浏览器一个资源ID, 如果有了新版本则正常发送并附上新ID, 否则返回304， 但是在服务器集群情况下, 每个服务器将返回不同的ID, 因此不建议使用ETag.

&nbsp;

以上描述的客户端浏览器缓存是指存储位置在客户端浏览器, 但是对客户端浏览器缓存的实际设置工作是在服务器上的资源中完成的. 虽然刚才我们介绍了有关于客户端浏览器缓存的属性, 但是实际上对这些属性的设置工作都需要在服务器的资源中做设置. 我们有两种操作手段对浏览器缓存进行设置, 一个是通过页面指令声明来设置, 另外一个是通过编程方式来设置.

&nbsp;

浏览器缓存的设置手段:

第一: 通过页面指令声明来设置HTTP的缓存

页面指令&lt;%@ OutputCache Location=”Any” Duration=”10” VaryByParam=”ProductId” VaryByHeader=”Accept-Language”%&gt;中的Location用来设置缓存的位置, 该属性常见的值为:

Any(默认): 输出缓存可以位于任何地点, 对应于HttpCacheability.Public. 如: 客户端浏览器、代理服务器或服务器本身.

Client: 只能位于发出请求的客户端浏览器, 对应于HttpCacheability.Private.

Downstream: 输出缓存可以位于除服务器本身的其他任何地方, 如: 客户端浏览器、代理服务器.

Server: 输出缓存位于Web服务器本身, 对应于HttpCacheability.Server

ServerAndClient: 输出缓存只能位于服务器本身或客户端浏览器, 对应于HttpCacheability.Private和HttpCacheability.Server

None: 禁用输出缓存, 对应于HttpCacheability.NoCache.

VaryByParam属性: 根据请求参数的不同而缓存不同的版本. 多个值用分号(;)分隔, *号表示为任意参数或参数组合缓存不同版本, “none”表示只缓存一个版本.

VaryByHeader属性: 根据请求头来缓存不同的版本, 如同一页面的不同语言版本.

VaryByCustom属性: 根据自定义参数来缓存不同的版本, 如: VaryByCunstom=”browser”是系统已实现的, 根据浏览器名称和版本号缓存不同的版本. 也可以, 根据自定义参数来缓存, 如: VaryByCustom=”happy”, 此时系统不知道如何解释happy, 因此需要在Global.asax或IHttpModule实现类中重写GetVaryByCustomString()方法, 来完成处理逻辑.

VaryByControl属性: 根据用户控件中的服务器控件ID来缓存不同版本.

更高级的方式, 是通过配置文件来设置HTTP的缓存.

页面指令为&lt;%@ OutputCache CacheProfile=”cacheconfig”%&gt;, 其中cacheconfig是配置文件中的缓存配置节中CacheProfile的名称.
<div>View Code
<div id="cnblogs_code_open_c6451953-d048-4c1a-aa1d-39b4e297c264">
<div>&lt;system.web&gt;
&lt;caching&gt;
&lt;outputCacheSettings&gt;
&lt;outputCacheProfiles&gt;
&lt;add name="cacheconfig" duration="10" varyByParam="none"/&gt;
&lt;/outputCacheProfiles&gt;
&lt;/outputCacheSettings&gt;
&lt;/caching&gt;
&lt;/system.web&gt;</div>
<div>
<h1>nginx缓存cache的5种方案</h1>
1、传统缓存之一（404）

这个办法是把nginx的404错误定向到后端，然后用proxy_store把后端返回的页面保存。

配置：

location / {
root /home/html/;#主目录
expires 1d;#网页的过期时间
error_page 404 =200 /fetch$request_uri;#404定向到/fetch目录下
}

location /fetch/ {#404定向到这里
internal;#指明这个目录不能在外部直接访问到
expires 1d;#网页的过期时间
alias /home/html/;#虚拟目录文件系统地址要和locaion /一致，proxy_store会将文件保存到这目录下
proxy_pass ;#后端upstream地址，/fetch同时是一个代理
proxy_set_header Accept-Encoding '';#让后端不要返回压缩（gzip或deflate）的内容，保存压缩后的内容会引发乱子。
proxy_store on;#指定nginx将代理返回的文件保存
proxy_temp_path /home/tmp;#临时目录，这个目录要和/home/html在同一个硬盘分区内
}

使用的时候还有要注意是nginx要有权限往/home/tmp和/home/html下有写入文件的权限，在linux下nginx一般会配置成nobody用户运行，这样这两个目录就要chown nobody，设成nobody用户专用，当然也可以chmod 777，不过所有有经验的系统管理员都会建议不要随便使用777。

2、传统缓存之二（!-e）

原理和404跳转基本一致，但更简洁一些：

location / {
root /home/html/;
proxy_store on;
proxy_set_header Accept-Encoding '';
proxy_temp_path /home/tmp;
if ( !-f $request_filename )
{
        proxy_pass ;
}
}

可以看到这个配置比404节约了不少代码，它是用!-f来判断请求的文件在文件系统上存不存在，不存在就proxy_pass到后端，返回同样是用proxy_store保存。

两种传统缓存都有着基本一样的优点和缺点：

缺点1：不支持带参数的动态链接，比如read.php?id=1，因为nginx只保存文件名，所以这个链接只在文件系统下保存为read.php，这样用户访问read.php?id=2时会返回不正确的结果。同时不支持这种形式的首页和二级目录，因为nginx非常老实，会将这样的请求照链接写入文件系统，而这个链接显然是一个目录，所以保存失败。这些情况都需要写rewrite才能正确保存。
缺点2：nginx内部没有缓存过期和清理的任何机制，这些缓存的文件会永久性地保存在机器上，如果要缓存的东西非常多，那就会撑暴整个硬盘空间。为此可以使用一个shell脚本定期清理，同时可以撰写php等动态程序来做实时更新。
缺点3：只能缓存200状态码，因此后端返回301/302/404等状态码都不会缓存，假如恰好有一个访问量很大的伪静态链接被删除，那就会不停穿透导致后端承载不小压力。
缺点4：nginx不会自动选择内存或硬盘作为存储介质，一切由配置决定，当然在当前的操作系统里都会有操作系统级的文件缓存机制，所以存在硬盘上也不需要过分担心大并发读取造成的io性能问题。

nginx传统缓存的缺点也是它和squid等缓存软件的不同之特色，所以也可看作其优点。在生产应用中它常常用作和squid的搭档，squid对于带?的链接往往无法阻挡，而nginx能将其访问拦住，例如：?和在squid上会被当做两个链接，所以会造成两次穿透；而nginx只会保存一次，无论链接变成还是，均不能透过nginx缓存，从而有效地保护了后端主机。

nginx会非常老实地将链接形式保存到文件系统中，这样对于一个链接，可以很方便地查阅它在缓存机器上的缓存状态和内容，也可以很方便地和别的文件管理器如rsync等配合使用，它完完全全就是一个文件系统结构。

这两种传统缓存都可以在linux下将文件保存到/dev/shm里，一般我也是这么做的，这样可以利用系统内存来做缓存，利用内存的话，清理过期内容速度就会快得多。使用/dev/shm/时除了要把tmp目录也指向到/dev/shm这个分区外，如果有大量小文件和目录，还要修改一下这个内存分区的inode数量和最大容量：

mount -o size=2500M -o nr_inodes=480000 -o noatime,nodiratime -o remount /dev/shm

上面的命令在一台有3G内存的机器上使用，因为/dev/shm默认最大内存是系统内存的一半就是1500M，这条命令将其调大成2500M，同时shm系统inode数量默认情况下可能是不够用的，但有趣的是它可以随意调节，这里调节为480000保守了点，但也基本够用了。

3、基于memcached的缓存

nginx对memcached有所支持，但是功能并不是特别之强，性能上还是非常之优秀。

location /mem/ {
    if ( $uri ~ "^/mem/([0-9A-Za-z_]*)$" )
    {
     set $memcached_key "$1";
     memcached_pass     192.168.1.2:11211;
    }
    expires 70;
}

这个配置会将指明到memcached的abc这个key去取数据。

nginx目前没有写入memcached的任何机制，所以要往memcached里写入数据得用后台的动态语言完成，可以利用404定向到后端去写入数据。

4、基于第三方插件ncache

ncache是新浪兄弟开发的一个不错的项目，它利用nginx和memcached实现了一部分类似squid缓存的功能，我并没有使用这个插件的经验，可以参考：

&nbsp;

5、nginx新开发的proxy_cache功能

从nginx-0.7.44版开始，nginx支持了类似squid较为正规的cache功能，目前还处于开发阶段，支持相当有限，这个缓存是把链接用md5编码hash后保存，所以它可以支持任意链接，同时也支持404/301/302这样的非200状态。

配置：

首先配置一个cache空间：

proxy_cache_path /path/to/cache levels=1:2 keys_zone=NAME:10m inactive=5m max_size=2m clean_time=1m;

#注意这个配置是在server标签外，levels指定该缓存空间有两层hash目录，第一层目录是1个字母，第二层为2个字母，保存的文件名就会类似/path/to/cache/c/29/b7f54b2df7773722d382f4809d65029c；keys_zone为这个空间起个名字，10m指空间大小为10MB；inactive的5m指缓存默认时长5分钟；max_size的2m是指单个文件超过2m的就不缓存；clean_time指定一分钟清理一次缓存。

location / {
    proxy_pass ;

    proxy_cache NAME;#使用NAME这个keys_zone

    proxy_cache_valid 200 302 1h;#200和302状态码保存1小时
    proxy_cache_valid 301 1d;#301状态码保存一天
    proxy_cache_valid any 1m;#其它的保存一分钟
}

ps：支持cache的0.7.44到0.7.51这几个版本的稳定性均有问题，访问有些链接会出现错误，所以这几个版本最好不要在生产环境中使用。nginx-0.7下目前所知较为稳定的版本是0.7.39。稳定版0.6.36版也是近期更新，如果在配置里没有使用到0.7的一些新标签新功能，也可以使用0.6.36版。

</div>
</div>
</div>
</div>
