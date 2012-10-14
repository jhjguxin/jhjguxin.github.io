---
layout: post
title: "Tracking Rails 3.1 and asset pipeline problems with Apache "
date: 2012-02-10 14:30
comments: true
categories: ["rails"]
tags: ["apache", "asset", "rails"]
---
## Tracking Rails 3.1 and asset pipeline problems with Apache 
ubuneu install apache module
<code>sudo apt-get install libapache2-mod-xsendfile</code>

#enki_apache_passenger.conf
<pre>
<code>
LoadModule rewrite_module /usr/lib/apache2/modules/mod_rewrite.so
LoadModule passenger_module /usr/share/ruby-rvm/gems/ruby-1.8.7-p357/gems/passenger-3.0.11/ext/apache2/mod_passenger.so
#sudo apt-get install libapache2-mod-xsendfile
LoadModule xsendfile_module /usr/lib/apache2/modules/mod_xsendfile.so
PassengerRoot /usr/share/ruby-rvm/gems/ruby-1.8.7-p357/gems/passenger-3.0.11
PassengerRuby /usr/share/ruby-rvm/rubies/ruby-1.8.7-p357/bin/ruby</code>

# PassengerMaxPoolSize 10

#ServerName www.yourhost.com
# DocumentRoot /var/www/enki/public
XSendFile On

RewriteEngine On

# AllowOverride all
# Options -MultiViews
# THIS IS REALLY IMPORTANT
XSendFilePath /var/www/enki

LoadModule headers_module /usr/lib/apache2/modules/mod_headers.so
LoadModule expires_module /usr/lib/apache2/modules/mod_expires.so

# Some browsers still send conditional-GET requests if there's a
# Last-Modified header or an ETag header even if they haven't
# reached the expiry date sent in the Expires header.
Header unset Last-Modified
Header unset ETag
# This required etag module to be enabled. Comment out
FileETag None
# RFC says only cache for 1 year
ExpiresActive On
ExpiresDefault "access plus 1 year"
</code>
</pre>


If you have a module version &lt; 0.10, add this to the virtual host config that needs to send files:
<code>
XSendFile On
XSendFileAllowAbove On
</code>
This allows any file path (not only those below your VHost root) to be sent through X-Sendfile, which is sort of bad practice. You can either live with it or compile a newer version of the module.

If you got a module version &gt;= 0.10 you can whitelist the allowed paths instead:
<code>
XSendFile On
XSendFilePath /opt/www/awesome-project
</code>

<h2>Migrating my blog over to Rails 3.1 beta<h2>

# Enable the asset pipeline
config.assets.enabled = true

config/environments/development.rb (remove or comment out the following line)
<pre>
<code>#config.action_view.debug_rjs             = true
</code>
</pre>

config/environments/production.rb (add these lines) 
<pre>
<code># Compress both stylesheets and JavaScripts
config.assets.js_compressor  = :uglifier
config.assets.css_compressor = :scss
</code>
</pre>

<pre>
<code>mkdir app/assets
git mv public/images app/assets/images
git mv public/javascripts app/assets/javascripts
git mv public/stylesheets app/assets/stylesheets
</code>
</pre>

Finally, in your production environment, don’t forget to statically generate your compiled assets with this Rake task:
<pre>
<code>RAILS_ENV=production bundle exec rake assets:precompile
</code>
</pre>
It will create files such as these:

<pre>
<code>
public/assets/application-2a8947193a591b79c885c52fbc6b01d3.css
</code>
</pre>
