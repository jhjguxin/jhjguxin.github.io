---
layout: post
title: "rvm on ubuntu 11.10 install ruby 1.9.2 error"
date: 2012-01-31 22:42
comments: true
categories: [ruby]
tags: [openssl,ruby,rvm]
---
## rvm on ubuntu 11.10 install ruby 1.9.2 error
<div>

When trying to install ruby 1.9.2 using rvm I got a nasty suprise:
<div>
<pre>ossl_ssl.c:110:1: error: ‘SSLv2_method’ undeclared here (not in a function)
ossl_ssl.c:111:1: error: ‘SSLv2_server_method’ undeclared here (not in a function)
ossl_ssl.c:112:1: error: ‘SSLv2_client_method’ undeclared here (not in a function)
make[1]: *** [ossl_ssl.o] Error 1
make[1]: Leaving directory `/var/cache/ruby-rvm/src/ruby-1.9.2-p180/ext/openssl'
make: *** [mkmain.sh] Error 1</pre>
</div>
<h2>The solution</h2>
<div>
<pre>sudo apt-get install ruby-rvm
# make sure we have $rvm_path
source /etc/profile
# don't use ubuntus openssl
rvm package install openssl
or
rvm pkg install openssl
rvm install 1.9.2 --with-openssl-dir=$rvm_path/usr</pre>
</div>
</div>
