---
layout: post
title: "使用ruby解析纯真IP库-qqwry.dat"
date: 2012-05-20 15:40
comments: true
categories: [rails,ruby]
tags: [ip,qqwry.dat,ruby]
---
## 使用ruby解析纯真IP库-qqwry.dat
在写一个地区相关的节能时，需要用到根据IP判断地区的功能，就想着找一个能够解析IP到地址的库。找了一下资料，国内用的比较多的IP库是早年就开始流行到现在的纯真IP库（QQrwy.dat），至于用ruby来解析纯真IP库的，则没找到几个，文章是不少，不过引用的几乎都是同样的代码，那个是比较早的ruby版本了，在1.9.2下跑的话，会有问题，我小改了一下，发现还是会有些问题，于是索性自己写一个吧。

要解析纯真IP库，对于该库的数据结构是必须要了解的，不多说，网上几乎唯一的纯真数据格式的说明就是这篇了  <a href="http://lumaqq.linuxsir.org/article/qqwry_format_detail.html" target="_blank">纯真IP数据库格式解析</a>

格式并不算太复杂，主要是要注意偏移。纯真IP库的字符编码是GB2312的，而Windows下的命令行窗口也是GB2312编码，所以就不用转编码了。不过我是在linux下写的，所以默认编码用的是utf8，这也算是大势所趋么（也提供了GB编码的取得方式）。

代码如下，如果看过IP库格式的话，配上代码注释，应该是比较容易就懂的。

试了一下，查询1000次用时大概200毫秒左右
<pre>require 'iconv'

class IpSearch
	def initialize(file='qqwry.dat')
		filename = file
		@file = File.open(filename,"r")
		@index_first,@index_last  = @file.read(8).unpack('L2')
    		@index_total = (@index_last - @index_first)/7 + 1
    		@location = {}
	end

	#把IP转换为长整形
	def ip2long(ip)
	  long = 0
	  ip.split(/\./).each_with_index do |b, i|
	    long += b.to_i &lt;&lt; 8*(3-i)
	  end
	  long
	end

	#读取偏移值
	def read_offset(position)
		@file.seek position
		chars = @file.read(3).unpack('C3')
		(chars[2]&lt;&lt;16) + (chars[1]&lt;&lt;8) + chars[0]
	end

	#读取记录中的4字节作为一个long值
	def read_long(position)
		@file.seek position
		@file.read(4).unpack('L')[0]
	end

	#读取模式信息，1和2为正常，其他值异常
	#position:字符串偏移量
	def read_mode(position)
		@file.seek position #前4位为IP值
		@file.read(1).unpack('C')[0]
	end

	#根据IP在索引中查找具体位置
	def find_str_offset(ip_long)
		offset_min,offset_max = @index_first,@index_last

    		while offset_min &lt;= offset_max
      			offset_mid =  offset_min + (offset_max - offset_min) / 14*7
      			mid = read_long(offset_mid)

      			if ip_long &lt; mid
        			offset_max = offset_mid - 7
      			elsif ip_long == mid
        			return read_offset(offset_mid+4)
      			else
        			offset_min = offset_mid + 7
      			end
    		end

    		return read_offset(offset_max+4)
	end

	#读取字符串
	def read_str(position)
		@file.seek position
		str = []
		while c = @file.getc
		  break if str.size &gt; 60 #地址不会太长，防止有异常数据
		  break if c == "\0"  #地址字符串以\0结尾
		  str &lt;&lt; c
		end
		str.join ''
	end

	#根据IP查找地址
	def find_ip_location(ip)
		offset = find_str_offset(ip2long(ip))#读取具体数据在记录区的偏移
		@location = {}
		case read_mode(offset+4)
		when 1
      str_offset = read_offset(offset+4+1) #读取字符串存储位置偏移（4是IP值，1是模式）
      if read_mode(str_offset)==2 then
        country_offset = read_offset(str_offset+1)
        @location[:country] = read_str country_offset
      	@location[:area] = read_area(str_offset+4)
      else
        @location[:country] = read_str str_offset
      	@location[:area] = read_area(@file.pos)
      end

		when 2
			str_offset = read_offset(offset+4+1) #读取字符串存储位置偏移（4是IP值，1是模式）
			@location[:country] = read_str(str_offset)
			@location[:area] = read_area(offset+8)
		else
			@location[:country] = read_str(offset)
			@location[:area] = read_str(@file.pos)
		end

		@location
	end

	#读取记录中的地址信息
	def read_area(position)
		mode = read_mode(position)
		if mode==1 || mode==2
			offset = read_offset(position+1)
			return '' if offset==0
			return read_str(offset)
		else
			return read_str(position)
		end
	end

	#取得国家，UTF8编码
	def country
		Iconv.iconv('UTF-8//IGNORE','GB2312//IGNORE',@location[:country])
	end

	#取得地区，UTF8编码
	def area
		Iconv.iconv('UTF-8//IGNORE','GB2312//IGNORE',@location[:area])
	end

	#取得国家，GB2312编码
	def country_gb
		@location[:country]
	end

	#取得地区，GB2312编码
	def area_gb
		@location[:area]
	end
end

#************************以下测试代码*****************
time_start = Time.now
list = %w[66.249.71.153 202.8.15.255.2 61.157.175.233 58.19.176.201 61.178.12.170 61.191.187.113 121.14.133.169 58.222.234.230 202.198.184.136 121.12.116.58 203.191.148.55]
is = IpSearch.new
100.times do |i|
	list.each do |ip|
	  is.find_ip_location(ip)
	  #puts is.country
	  #puts is.area
	  #puts '-'*50
	end
end

puts "total time:#{Time.now-time_start}"</pre>
