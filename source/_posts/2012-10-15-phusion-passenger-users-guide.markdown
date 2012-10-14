---
layout: post
title: "Phusion Passenger users guide"
date: 2012-01-09 14:26
comments: true
categories: ["rails", "ruby"]
tags: ["apache", "passenger", "phusion", "rails", "ruby", "server", "web"]
---
## Phusion Passenger users guide
<div>

Phusion Passenger is an Apache module, which makes deploying Ruby and Ruby on Rails applications on Apache a breeze. It follows the usual Ruby on Rails conventions, such as "Don’t-Repeat-Yourself" and ease of setup, while at the same time providing enough flexibility.

</div>
<div>

This users guide will teach you:

</div>
<div>
<ul>
	<li>How to install Phusion Passenger.</li>
	<li>How to configure Phusion Passenger.</li>
	<li>How to deploy a Ruby on Rails application.</li>
	<li>How to deploy a <a href="http://rack.rubyforge.org/">Rack</a>-based Ruby application.</li>
	<li>How to solve common problems.</li>
</ul>
</div>
<div>

This guide assumes that the reader is somewhat familiar with Apache and with using the commandline.

</div>
<div>
<h2 id="_support_information">1. Support information</h2>
<div>
<div>
<h3 id="_supported_operating_systems">1.1. Supported operating systems</h3>
<div>

Phusion Passenger works on any POSIX-compliant operating system. In other words: practically any operating system on earth, except Microsoft Windows.

</div>
<div>

Phusion Passenger is confirmed on a large number of operating systems and Linux distributions, including, but not limited to, Ubuntu, Debian, CentOS/Fedora/RHEL, Gentoo, Mac OS X, FreeBSD and Solaris. Both 32-bit and 64-bit platforms are supported.

</div>
<div>

The only POSIX-compliant operating system on which Phusion Passenger for Apache is known not to work at this time, is OpenBSD. Please use Phusion Passenger for Nginx instead.

</div>
<div>

Please <a href="http://code.google.com/p/phusion-passenger/issues/list">report a bug</a> or <a href="http://groups.google.com/group/phusion-passenger">join our discussion forum</a> if it doesn’t work on your POSIX-compliant operating system.

</div>
</div>
<div>
<h3 id="_where_to_get_support">1.2. Where to get support</h3>
<div>
<ul>
	<li><a href="http://code.google.com/p/phusion-passenger/issues/list">Issue tracker</a> - report bugs here.</li>
	<li><a href="http://groups.google.com/group/phusion-passenger">Discussion forum</a> - post a message here if you’re experiencing problems.</li>
</ul>
</div>
</div>
</div>
</div>
<div>
<h2 id="_installing_upgrading_and_uninstalling_phusion_passenger">2. Installing, upgrading and uninstalling Phusion Passenger</h2>
<div>
<div>
<h3 id="_generic_installation_instructions">2.1. Generic installation instructions</h3>
<div>
<h4 id="install_passenger">2.1.1. Overview of installation methods</h4>
<div>

There are three ways to install Phusion Passenger:

</div>
<div>
<ol>
	<li>By installing the Phusion Passenger gem, as instructed on the <a href="http://www.modrails.com/install.html">“Install” page on the Phusion Passenger website</a>.</li>
	<li>By downloading the source tarball from the Phusion Passenger website (<em>passenger-x.x.x.tar.gz</em>).</li>
	<li>By installing a native Linux package (e.g. Debian package).</li>
</ol>
</div>
<div>

The following sections will explain each installation method. Please read the section for the installation method that you prefer. In our opinion, installing the gem or the native package is easiest. For these two installation methods, Phusion Passenger provides an easy-to-use installer.

</div>
</div>
<div>
<h4 id="_preparation_gem_and_source_tarball_only">2.1.2. Preparation (gem and source tarball only)</h4>
<div>

If you want to install Phusion Passenger via the gem or the source tarball, then some preparations might be required. You can skip this subsection if you’re installing Phusion Passenger via a native Linux package, because no compilation is necessary.

</div>
<div>
<h5 id="_switching_to_a_root_command_prompt">Switching to a root command prompt</h5>
<div>

Before installing, you will probably need to switch to the root user first. When you install Phusion Passenger via a gem or a source tarball, some Phusion Passenger files have to be compiled, which requires write access to the directory in which the Phusion Passenger files are located. On Unix systems, the root user is the user who has write access to the entire system. So unless you know that your normal user account has write access to the Phusion Passenger directory, you should switch to root before installing Phusion Passenger.

</div>
<div>

You can switch to root by typing the following command:

</div>
<div>
<div>
<pre>sudo -s</pre>
</div>
</div>
<div>

This will open a command prompt as the root user, from which you can proceed with installing Phusion Passenger.

</div>
<div>

If your system does not have <em>sudo</em> installed, please type the following command instead, which should do the same thing:

</div>
<div>
<div>
<pre>su</pre>
</div>
</div>
</div>
<div>
<h5 id="specifying_correct_apache_install">Specifying the correct Apache installation</h5>
<div>

The Phusion Passenger installer will attempt to automatically detect Apache, and compile Phusion Passenger against that Apache version. It does this by looking for the apxs or apxs2 command in the PATH environment variable. Apxs is an integral part of any Apache installation.

</div>
<div>

However, some systems have multiple Apache installations. This is likely the case on MacOS X: the OS ships with Apache, but users tend to install another Apache version seperately, e.g. via MacPorts. If your system has multiple Apache installations, then you will need to tell the Phusion Passenger installer which one to use. It is very important that you specify the correct Apache installation, because if you load Phusion Passenger in an Apache installation that it wasn’t compiled against, then it will likely crash.

</div>
<div>

On yet other systems, Apache is installed in a non-standard location, preventing the Phusion Passenger installer from detecting Apache. This is most likely the case on systems on which Apache was installed by hand from source, i.e. as opposed to installed through the system’s native package manager. If this is the case, then you will also have to tell the installer where it can find Apache.

</div>
<div>

To do so, set the APXS2 environment variable to the full path of the correct apxs or apxs2 command. Suppose that you want to use the Apache installation in <em>/opt/apache2</em>. Then, assuming that the corresponding apxs program’s path is <em>/opt/apache2/bin/apxs</em>, type:

</div>
<div>
<div>
<pre>export APXS2=/opt/apache2/bin/apxs</pre>
</div>
</div>
<div>
<table>
<tbody>
<tr>
<td><img src="http://www.modrails.com/documentation/images/icons/note.png" alt="Note" /></td>
<td>On some systems, the apxs program might be called apxs2, and it might be located in the sbin folder instead of the bin folder.</td>
</tr>
</tbody>
</table>
</div>
<div>
<table>
<tbody>
<tr>
<td><img src="http://www.modrails.com/documentation/images/icons/note.png" alt="Note" /></td>
<td>
<div>Environment variables and <em>sudo</em></div>
By default, the <em>sudo</em> command will erase any environment variables that it doesn’t recognize, prior to executing the given command. So if you set APXS2 as a normal user, then run sudo passenger-install-apache2-module (which is the command for the Phusion Passenger installer), then the installer will not receive the environment variable value that you set. To solve this problem, please become root prior to setting any environment variables, as described in the previous subsection.</td>
</tr>
</tbody>
</table>
</div>
</div>
<div>
<h5 id="specifying_ruby_installation">Specifying the correct Ruby installation</h5>
<div>

If your system has multiple Ruby installations — which is likely the case on MacOS X, or if you’ve also installed <a href="http://www.rubyenterpriseedition.com/">Ruby Enterprise Edition</a>  — then you will need to tell the operating system which Ruby installation to use, prior to running the Phusion Passenger installer. If you only have one Ruby installation (the case on most Linux systems), then you can skip this section because Phusion Passenger will automatically detect it.

</div>
<div>

To specify a Ruby installation, prepend your Ruby installation’s bin directory to the PATH environment variable. For example, if you have the following Ruby installations:

</div>
<div>
<ul>
	<li>/usr/bin/ruby</li>
	<li>/opt/myruby/bin/ruby</li>
</ul>
</div>
<div>

and you want to use the latter, then type:

</div>
<div>
<div>
<pre>export PATH=/opt/myruby/bin:$PATH</pre>
</div>
</div>
</div>
</div>
<div>
<h4 id="_installing_via_the_gem">2.1.3. Installing via the gem</h4>
<div>

Please install the gem and then run the Phusion Passenger installer, by typing the following commands:

</div>
<div>
<div>
<pre>gem install passenger-x.x.x.gem
passenger-install-apache2-module</pre>
</div>
</div>
<div>

Please follow the instructions given by the installer.

</div>
</div>
<div>
<h4 id="_installing_via_the_source_tarball">2.1.4. Installing via the source tarball</h4>
<div>

Extract the tarball to whatever location you prefer. <strong>The Phusion Passenger files are to reside in that location permanently.</strong> For example, if you would like Phusion Passenger to reside in /opt/passenger-x.x.x:

</div>
<div>
<div>
<pre>cd /opt
tar xzvf ~/YourDownloadsFolder/passenger-x.x.x.tar.gz</pre>
</div>
</div>
<div>

Next, run the included installer:

</div>
<div>
<div>
<pre>/opt/passenger-x.x.x/bin/passenger-install-apache2-module</pre>
</div>
</div>
<div>

Please follow the instructions given by the installer.

</div>
<div>
<table>
<tbody>
<tr>
<td><img src="http://www.modrails.com/documentation/images/icons/important.png" alt="Important" /></td>
<td>Please do not remove the <em>passenger-x.x.x</em> folder after installation. Furthermore, the <em>passenger-x.x.x</em> folder must be accessible by Apache.</td>
</tr>
</tbody>
</table>
</div>
</div>
<div>
<h4 id="_installing_via_a_native_linux_package">2.1.5. Installing via a native Linux package</h4>
<div>

John Leach from Brightbox has kindly provided an Ubuntu Hardy package for Phusion Passenger. The package is available from the <a href="http://apt.brightbox.net/">Brightbox repository</a>.

</div>
<div>

Please install the native Linux package, e.g.:

</div>
<div>
<div>
<pre>sudo sh -c 'echo "deb http://apt.brightbox.net hardy main" &gt; /etc/apt/sources.list.d/brightbox.list'
sudo sh -c 'wget -q -O - http://apt.brightbox.net/release.asc | apt-key add -'
sudo apt-get update
sudo apt-get install libapache2-mod-passenger</pre>
</div>
</div>
</div>
<div>
<h4 id="_what_does_the_installer_do">2.1.6. What does the installer do?</h4>
<div>

Although we call it an “installer”, it doesn’t actually install anything. The installer checks whether all required dependencies are installed, compiles Phusion Passenger for you, and tells you how to modify the Apache configuration file, but it doesn’t copy any files around.

</div>
<div>

passenger-install-apache2-module is actually just a user-friendly frontend around the command rake apache2, which performs the actual compilation of Phusion Passenger.

</div>
</div>
</div>
<div>
<h3 id="_operating_system_specific_instructions_and_information">2.2. Operating system-specific instructions and information</h3>
<div>
<h4 id="_macos_x">2.2.1. MacOS X</h4>
<div>

Ben Ruebenstein has written an excellent <a href="http://benr75.com/articles/2008/04/12/setup-mod_rails-phusion-mac-os-x-leopard">tutorial on installing Phusion Passenger on OS X</a>.

</div>
</div>
<div>
<h4 id="_ubuntu_linux">2.2.2. Ubuntu Linux</h4>
<div>

Ben Hughes has written an <a href="http://www.railsgarden.com/2008/04/12/configurating-passenger-mod_rails-on-slicehost-with-ubuntu-710/">article on installing Phusion Passenger on Ubuntu</a>.

</div>
</div>
<div>
<h4 id="_opensolaris">2.2.3. OpenSolaris</h4>
<div>

J Aaron Farr has written a <a href="http://cubiclemuses.com/cm/articles/2009/04/09/rails-passenger-open-solaris-ec2/">guide</a> about setting up Ruby on Rails and Phusion Passenger on OpenSolaris and EC2.

</div>
</div>
</div>
<div>
<h3 id="_upgrading_or_downgrading_phusion_passenger">2.3. Upgrading or downgrading Phusion Passenger</h3>
<div>
<h4 id="_via_a_gem_or_a_source_tarball">2.3.1. Via a gem or a source tarball</h4>
<div>

To upgrade or downgrade Phusion Passenger via the gem or the source tarball, install the newer or older version as you normally would; that is, install the gem or unpack the tarball, and run passenger-install-apache2-module. Eventually passenger-install-apache2-module will tell you to copy &amp; paste some settings into the Apache configuration file; something that looks along the lines of:

</div>
<div>
<div>
<pre>LoadModule passenger_module ...
PassengerRoot ...
PassengerRuby ...</pre>
</div>
</div>
<div>

Because you already had Phusion Passenger installed, you already had similar settings in your Apache configuration file, just with different values. <strong>Replace</strong> the old settings with the new ones that the installer outputs. It is important that the old settings are removed, otherwise Phusion Passenger may malfunction.

</div>
<div>

When you’re done, restart Apache.

</div>
</div>
<div>
<h4 id="_via_a_native_linux_package">2.3.2. Via a native Linux package</h4>
<div>

There are no special instructions required to upgrade or downgrade Phusion Passenger via a native Linux package.

</div>
</div>
</div>
<div>
<h3 id="_unloading_disabling_phusion_passenger_from_apache_without_uninstalling_it">2.4. Unloading (disabling) Phusion Passenger from Apache without uninstalling it</h3>
<div>

You can temporarily unload (disable) Phusion Passenger from Apache, without uninstalling the Phusion Passenger files, so that Apache behaves as if Phusion Passenger was never installed in the first place. This might be useful to you if, for example, you seem to be experiencing a problem caused by Phusion Passenger, but you want to make sure whether that’s actually the case, without having to through the hassle of uninstalling Phusion Passenger completely. When disabled, Phusion Passenger will not occupy any memory or CPU or otherwise interfere with Apache.

</div>
<div>

To unload Phusion Passenger from Apache, edit your Apache configuration file(s) and comment out:

</div>
<div>
<ul>
	<li>all Phusion Passenger configuration directives.</li>
	<li>the <em>LoadModule passenger_module</em> directive.</li>
</ul>
</div>
<div>

For example, if your configuration file looks like this…

</div>
<div>
<div>
<pre>Listen *:80
NameVirtualHosts *:80
....

LoadModule passenger_module /somewhere/passenger-x.x.x/ext/apache2/mod_passenger.so

PassengerRuby /usr/bin/ruby
PassengerRoot /somewhere/passenger/x.x.x
PassengerMaxPoolSize 10

&lt;VirtualHost *:80&gt;
    ServerName www.foo.com
    DocumentRoot /webapps/foo/public
    RailsBaseURI /rails
&lt;/VirtualHost&gt;</pre>
</div>
</div>
<div>

…then comment out the relevant directives, so that it looks like this:

</div>
<div>
<div>
<pre>Listen *:80
NameVirtualHosts *:80
....

# LoadModule passenger_module /somewhere/passenger-x.x.x/ext/apache2/mod_passenger.so

# PassengerRuby /usr/bin/ruby
# PassengerRoot /somewhere/passenger/x.x.x
# PassengerMaxPoolSize 10

&lt;VirtualHost *:80&gt;
    ServerName www.foo.com
    DocumentRoot /webapps/foo/public
    # RailsBaseURI /rails
&lt;/VirtualHost&gt;</pre>
</div>
</div>
<div>

After you’ve done this, save the file and restart Apache.

</div>
</div>
<div>
<h3 id="_uninstalling_phusion_passenger">2.5. Uninstalling Phusion Passenger</h3>
<div>

To uninstall Phusion Passenger, please first remove all Phusion Passenger configuration directives from your Apache configuration file(s). After you’ve done this, you need to remove the Phusion Passenger files.

</div>
<div>
<ul>
	<li>If you installed Phusion Passenger via a gem, then type gem uninstall passenger. You might have to run this as root.</li>
	<li>If you installed Phusion Passenger via a source tarball, then remove the directory in which you placed the extracted Phusion Passenger files. This directory is the same as the one pointed to the by <em>PassengerRoot</em> configuration directive.</li>
	<li>If you installed Phusion Passenger via a Debian package, then remove type sudo apt-get remove libapache2-mod-passenger.</li>
</ul>
</div>
</div>
</div>
</div>
<div>
<h2 id="_deploying_a_ruby_on_rails_1_x_or_2_x_but_not_rails_gt_3_x_application">3. Deploying a Ruby on Rails 1.x or 2.x (but NOT Rails &gt;= 3.x) application</h2>
<div>
<div>

Suppose you have a Ruby on Rails application in <em>/webapps/mycook</em>, and you own the domain <em>www.mycook.com</em>. You can either deploy your application to the virtual host’s root (i.e. the application will be accessible from the root URL, <em>http://www.mycook.com/</em>), or in a sub URI (i.e. the application will be accessible from a sub URL, such as <em>http://www.mycook.com/railsapplication</em>).

</div>
<div>
<table>
<tbody>
<tr>
<td><img src="http://www.modrails.com/documentation/images/icons/note.png" alt="Note" /></td>
<td>The default RAILS_ENV environment in which deployed Rails applications are run, is “production”. You can change this by changing the <a href="http://www.modrails.com/documentation/Users%20guide%20Apache.html#rails_env"><em>RailsEnv</em></a> configuration option.</td>
</tr>
</tbody>
</table>
</div>
<div>
<h3 id="_deploying_to_a_virtual_host_8217_s_root">3.1. Deploying to a virtual host’s root</h3>
<div>

Add a virtual host entry to your Apache configuration file. Make sure that the following conditions are met:

</div>
<div>
<ul>
	<li>The virtual host’s document root must point to your Ruby on Rails application’s <em>public</em> folder.</li>
	<li>The Apache per-directory permissions must allow access to this folder.</li>
	<li>MultiViews must be disabled for this folder.</li>
</ul>
</div>
<div>

For example:

</div>
<div>
<div>
<pre>&lt;VirtualHost *:80&gt;
    ServerName www.mycook.com
    DocumentRoot /webapps/mycook/public
    &lt;Directory /webapps/mycook/public&gt;
        Allow from all
        Options -MultiViews
    &lt;/Directory&gt;
&lt;/VirtualHost&gt;</pre>
</div>
</div>
<div>

You may also need to tweak your file/folder permissions. Make sure that the following folders are readable and executable by Apache:

</div>
<div>
<ul>
	<li>this <em>public</em> folder.</li>
	<li>the application’s <em>config</em> folder.</li>
	<li>all parent folders. That is, /webapps/mycook and /webapps must also be readable and executable by Apache.</li>
</ul>
</div>
<div>

Then restart Apache. The application has now been deployed.

</div>
</div>
<div>
<h3 id="deploying_rails_to_sub_uri">3.2. Deploying to a sub URI</h3>
<div>

Suppose that you already have a virtual host:

</div>
<div>
<div>
<pre>&lt;VirtualHost *:80&gt;
    ServerName www.phusion.nl
    DocumentRoot /websites/phusion
    &lt;Directory /websites/phusion&gt;
        Allow from all
    &lt;/Directory&gt;
&lt;/VirtualHost&gt;</pre>
</div>
</div>
<div>

And you want your Ruby on Rails application to be accessible from the URL <em>http://www.phusion.nl/rails</em>.

</div>
<div>

To do this, make a symlink in the virtual host’s document root, and have it point to your Ruby on Rails application’s <em>public</em> folder. For example:

</div>
<div>
<div>
<pre>ln -s /webapps/mycook/public /websites/phusion/rails</pre>
</div>
</div>
<div>

Next, add a <a href="http://www.modrails.com/documentation/Users%20guide%20Apache.html#RailsBaseURI">RailsBaseURI</a> option to the virtual host configuration, and also make sure that:

</div>
<div>
<ul>
	<li>The Apache per-directory permissions allow access to this folder.</li>
	<li>MultiViews is disabled for this folder.</li>
</ul>
</div>
<div>

For example:

</div>
<div>
<div>
<pre>&lt;VirtualHost *:80&gt;
    ServerName www.phusion.nl
    DocumentRoot /websites/phusion
    &lt;Directory /websites/phusion&gt;
        Allow from all
    &lt;/Directory&gt;

    RailsBaseURI /rails                   # &lt;-- These lines have
    &lt;Directory /websites/phusion/rails&gt;   # &lt;-- been added.
        Options -MultiViews               # &lt;--
    &lt;/Directory&gt;                          # &lt;--
&lt;/VirtualHost&gt;</pre>
</div>
</div>
<div>

Then restart Apache. The application has now been deployed.

</div>
<div>
<table>
<tbody>
<tr>
<td><img src="http://www.modrails.com/documentation/images/icons/note.png" alt="Note" /></td>
<td>If you’re deploying to a sub-URI then please make sure that your view templates correctly handles references to sub-URI static assets! Otherwise you may find broken links to images, CSS files, JavaScripts, etc. Please read <a href="http://www.modrails.com/documentation/Users%20guide%20Apache.html#sub_uri_deployment_uri_fix">How to fix broken images/CSS/JavaScript URIs in sub-URI deployments</a> for more information.</td>
</tr>
</tbody>
</table>
</div>
<div>
<table>
<tbody>
<tr>
<td><img src="http://www.modrails.com/documentation/images/icons/tip.png" alt="Tip" /></td>
<td>
<div>

You can deploy multiple Rails applications under a virtual host, by specifying <a href="http://www.modrails.com/documentation/Users%20guide%20Apache.html#RailsBaseURI">RailsBaseURI</a> multiple times. For example:

</div>
<div>
<div>
<pre>&lt;VirtualHost *:80&gt;
    ....
    RailsBaseURI /app1
    RailsBaseURI /app2
    RailsBaseURI /app3
&lt;/VirtualHost&gt;</pre>
</div>
</div></td>
</tr>
</tbody>
</table>
</div>
</div>
<div>
<h3 id="_redeploying_restarting_the_ruby_on_rails_application">3.3. Redeploying (restarting the Ruby on Rails application)</h3>
<div>

Deploying a new version of a Ruby on Rails application is as simple as re-uploading the application files, and restarting the application.

</div>
<div>

There are two ways to restart the application:

</div>
<div>
<ol>
	<li>By restarting Apache.</li>
	<li>By creating or modifying the file <em>tmp/restart.txt</em> in the Rails application’s <a href="http://www.modrails.com/documentation/Users%20guide%20Apache.html#application_root">root folder</a>. Phusion Passenger will automatically restart the application during the next request.</li>
</ol>
</div>
<div>

For example, to restart our example MyCook application, we type this in the command line:

</div>
<div>
<div>
<pre>touch /webapps/mycook/tmp/restart.txt</pre>
</div>
</div>
<div>

Please note that, unlike earlier versions of Phusion Passenger, <em>restart.txt</em> is not automatically deleted. Phusion Passenger checks whether the timestamp of this file has changed in order to determine whether the application should be restarted.

</div>
</div>
<div>
<h3 id="_migrations">3.4. Migrations</h3>
<div>

Phusion Passenger is not related to Ruby on Rails migrations in any way. To run migrations on your deployment server, please login to your deployment server (e.g. with <em>ssh</em>) and type rake db:migrate RAILS_ENV=production in a shell console, just like one would normally run migrations.

</div>
</div>
<div>
<h3 id="_capistrano_integration">3.5. Capistrano integration</h3>
<div>

See <a href="http://www.modrails.com/documentation/Users%20guide%20Apache.html#capistrano">Capistrano recipe</a>.

</div>
</div>
</div>
</div>
<div>
<h2 id="_deploying_a_rack_based_ruby_application_including_rails_gt_3">4. Deploying a Rack-based Ruby application (including Rails &gt;= 3)</h2>
<div>
<div>

Phusion Passenger supports arbitrary Ruby web applications that follow the <a href="http://rack.rubyforge.org/">Rack</a> interface.

</div>
<div>

Phusion Passenger assumes that Rack application directories have a certain layout. Suppose that you have a Rack application in <em>/webapps/rackapp</em>. Then that folder must contain at least three entries:

</div>
<div>
<ul>
	<li><em>config.ru</em>, a Rackup file for starting the Rack application. This file must contain the complete logic for initializing the application.</li>
	<li><em>public/</em>, a folder containing public static web assets, like images and stylesheets.</li>
	<li><em>tmp/</em>, used for <em>restart.txt</em> (our application restart mechanism). This will be explained in a following subsection.</li>
</ul>
</div>
<div>

So <em>/webapps/rackapp</em> must, at minimum, look like this:

</div>
<div>
<div>
<pre>/webapps/rackapp
  |
  +-- config.ru
  |
  +-- public/
  |
  +-- tmp/</pre>
</div>
</div>
<div>

Suppose you own the domain <em>www.rackapp.com</em>. You can either deploy your application to the virtual host’s root (i.e. the application will be accessible from the root URL, <em>http://www.rackapp.com/</em>), or in a sub URI (i.e. the application will be accessible from a sub URL, such as <em>http://www.rackapp.com/rackapp</em>).

</div>
<div>
<table>
<tbody>
<tr>
<td><img src="http://www.modrails.com/documentation/images/icons/note.png" alt="Note" /></td>
<td>The default RACK_ENV environment in which deployed Rack applications are run, is “production”. You can change this by changing the <a href="http://www.modrails.com/documentation/Users%20guide%20Apache.html#rack_env"><em>RackEnv</em></a> configuration option.</td>
</tr>
</tbody>
</table>
</div>
<div>
<h3 id="_tutorial_example_writing_and_deploying_a_hello_world_rack_application">4.1. Tutorial/example: writing and deploying a Hello World Rack application</h3>
<div>

First we create a Phusion Passenger-compliant Rack directory structure:

</div>
<div>
<div>
<pre>$ mkdir /webapps/rack_example
$ mkdir /webapps/rack_example/public
$ mkdir /webapps/rack_example/tmp</pre>
</div>
</div>
<div>

Next, we write a minimal "hello world" Rack application:

</div>
<div>
<div>
<pre>$ cd /webapps/rack_example
$ some_awesome_editor config.ru
...type in some source code...
$ cat config.ru
app = proc do |env|
    [200, { "Content-Type" =&gt; "text/html" }, ["hello &lt;b&gt;world&lt;/b&gt;"]]
end
run app</pre>
</div>
</div>
<div>

Finally, we deploy it by adding the following configuration options to the Apache configuration file:

</div>
<div>
<div>
<pre>&lt;VirtualHost *:80&gt;
    ServerName www.rackexample.com
    DocumentRoot /webapps/rack_example/public
    &lt;Directory /webapps/rack_example/public&gt;
        Allow from all
        Options -MultiViews
    &lt;/Directory&gt;
&lt;/VirtualHost&gt;</pre>
</div>
</div>
<div>

And we’re done! After an Apache restart, the above Rack application will be available under the URL <em>http://www.rackexample.com/</em>.

</div>
</div>
<div>
<h3 id="_deploying_to_a_virtual_host_8217_s_root_2">4.2. Deploying to a virtual host’s root</h3>
<div>

Add a virtual host entry to your Apache configuration file. Make sure that the following conditions are met:

</div>
<div>
<ul>
	<li>The virtual host’s document root must point to your Rack application’s <em>public</em> folder.</li>
	<li>The Apache per-directory permissions must allow access to this folder.</li>
	<li>MultiViews must be disabled for this folder.</li>
</ul>
</div>
<div>

For example:

</div>
<div>
<div>
<pre>&lt;VirtualHost *:80&gt;
    ServerName www.rackapp.com
    DocumentRoot /webapps/rackapp/public
    &lt;Directory /webapps/rackapp/public&gt;
        Allow from all
        Options -MultiViews
    &lt;/Directory&gt;
&lt;/VirtualHost&gt;</pre>
</div>
</div>
<div>

You may also need to tweak your file/folder permissions. Make sure that the following folders are readable and executable by Apache:

</div>
<div>
<ul>
	<li>this <em>public</em> folder.</li>
	<li>the application’s <em>config</em> folder.</li>
	<li>all parent folders. That is, /webapps/rackapp and /webapps must also be readable and executable by Apache.</li>
</ul>
</div>
<div>

Then restart Apache. The application has now been deployed.

</div>
</div>
<div>
<h3 id="deploying_rack_to_sub_uri">4.3. Deploying to a sub URI</h3>
<div>

Suppose that you already have a virtual host:

</div>
<div>
<div>
<pre>&lt;VirtualHost *:80&gt;
    ServerName www.phusion.nl
    DocumentRoot /websites/phusion
    &lt;Directory /websites/phusion&gt;
        Allow from all
    &lt;/Directory&gt;
&lt;/VirtualHost&gt;</pre>
</div>
</div>
<div>

And you want your Rack application to be accessible from the URL <em>http://www.phusion.nl/rack</em>.

</div>
<div>

To do this, make a symlink in the virtual host’s document root, and have it point to your Rack application’s <em>public</em> folder. For example:

</div>
<div>
<div>
<pre>ln -s /webapps/rackapp/public /websites/phusion/rack</pre>
</div>
</div>
<div>

Next, add a <a href="http://www.modrails.com/documentation/Users%20guide%20Apache.html#RackBaseURI">RackBaseURI</a> option to the virtual host configuration, and also make sure that:

</div>
<div>
<ul>
	<li>The Apache per-directory permissions allow access to this folder.</li>
	<li>MultiViews is disabled for this folder.</li>
</ul>
</div>
<div>

For example:

</div>
<div>
<div>
<pre>&lt;VirtualHost *:80&gt;
    ServerName www.phusion.nl
    DocumentRoot /websites/phusion
    &lt;Directory /websites/phusion&gt;
        Allow from all
    &lt;/Directory&gt;

    RackBaseURI /rails                    # &lt;-- These lines have
    &lt;Directory /websites/phusion/rails&gt;   # &lt;-- been added.
        Options -MultiViews               # &lt;--
    &lt;/Directory&gt;                          # &lt;--
&lt;/VirtualHost&gt;</pre>
</div>
</div>
<div>

Then restart Apache. The application has now been deployed.

</div>
<div>
<table>
<tbody>
<tr>
<td><img src="http://www.modrails.com/documentation/images/icons/tip.png" alt="Tip" /></td>
<td>
<div>

You can deploy multiple Rack applications under a virtual host, by specifying <a href="http://www.modrails.com/documentation/Users%20guide%20Apache.html#RackBaseURI">RackBaseURI</a> multiple times. For example:

</div>
<div>
<div>
<pre>&lt;VirtualHost *:80&gt;
    ....
    RackBaseURI /app1
    RackBaseURI /app2
    RackBaseURI /app3
&lt;/VirtualHost&gt;</pre>
</div>
</div></td>
</tr>
</tbody>
</table>
</div>
</div>
<div>
<h3 id="_redeploying_restarting_the_rack_application">4.4. Redeploying (restarting the Rack application)</h3>
<div>

Deploying a new version of a Rack application is as simple as re-uploading the application files, and restarting the application.

</div>
<div>

There are two ways to restart the application:

</div>
<div>
<ol>
	<li>By restarting Apache.</li>
	<li>By creating or modifying the file <em>tmp/restart.txt</em> in the Rack application’s <a href="http://www.modrails.com/documentation/Users%20guide%20Apache.html#application_root">root folder</a>. Phusion Passenger will automatically restart the application.</li>
</ol>
</div>
<div>

For example, to restart our example application, we type this in the command line:

</div>
<div>
<div>
<pre>touch /webapps/rackapp/tmp/restart.txt</pre>
</div>
</div>
</div>
<div>
<h3 id="_rackup_specifications_for_various_web_frameworks">4.5. Rackup specifications for various web frameworks</h3>
<div>

This subsection shows example <em>config.ru</em> files for various web frameworks.

</div>
<div>
<h4 id="_camping">4.5.1. Camping</h4>
<div>
<div>
<pre>require 'rubygems'
require 'rack'
require 'camping'

##### Begin Camping application
Camping.goes :Blog

...your application code here...
##### End Camping application

run Rack::Adapter::Camping.new(Blog)</pre>
</div>
</div>
<div>

For Camping versions 2.0 and up, using run Blog as the final line will do.

</div>
</div>
<div>
<h4 id="_halcyon">4.5.2. Halcyon</h4>
<div>
<div>
<pre>require 'rubygems'
require 'halcyon'
$LOAD_PATH.unshift(Halcyon.root / 'lib')
Halcyon::Runner.load_config Halcyon.root/'config'/'config.yml'
run Halcyon::Runner.new</pre>
</div>
</div>
</div>
<div>
<h4 id="_mack">4.5.3. Mack</h4>
<div>
<div>
<pre>ENV["MACK_ENV"] = ENV["RACK_ENV"]
load("Rakefile")
require 'rubygems'
require 'mack'
run Mack::Utils::Server.build_app</pre>
</div>
</div>
</div>
<div>
<h4 id="_merb">4.5.4. Merb</h4>
<div>
<div>
<pre>require 'rubygems'
require 'merb-core'

Merb::Config.setup(
  :merb_root   =&gt; ::File.expand_path(::File.dirname(__FILE__)),
  :environment =&gt; ENV['RACK_ENV']
)
Merb.environment = Merb::Config[:environment]
Merb.root = Merb::Config[:merb_root]
Merb::BootLoader.run

run Merb::Rack::Application.new</pre>
</div>
</div>
</div>
<div>
<h4 id="_ramaze">4.5.5. Ramaze</h4>
<div>
<div>
<pre>require "rubygems"
require "ramaze"
Ramaze.trait[:essentials].delete Ramaze::Adapter
require "start"
Ramaze.start!
run Ramaze::Adapter::Base</pre>
</div>
</div>
</div>
<div>
<h4 id="_sinatra">4.5.6. Sinatra</h4>
<div>
<div>
<pre>require 'rubygems'
require 'sinatra'
require 'app.rb'

run Sinatra::Application</pre>
</div>
</div>
</div>
</div>
</div>
</div>
<div>
<h2 id="_configuring_phusion_passenger">5. Configuring Phusion Passenger</h2>
<div>
<div>

After installation, Phusion Passenger does not need any further configurations. Nevertheless, the system administrator may be interested in changing Phusion Passenger’s behavior. Phusion Passenger’s Apache module supports the following configuration options:

</div>
<div>
<h3 id="_passengerroot_lt_directory_gt">5.1. PassengerRoot &lt;directory&gt;</h3>
<div>

The location to the Phusion Passenger root directory. This configuration option is essential to Phusion Passenger, and allows Phusion Passenger to locate its own data files. The correct value is given by the installer.

</div>
<div>

If you’ve moved Phusion Passenger to a different directory then you need to update this option as well. Please read <a href="http://www.modrails.com/documentation/Users%20guide%20Apache.html#moving_phusion_passenger">Moving Phusion Passenger to a different directory</a> for more information.

</div>
<div>

This required option may only occur once, in the global server configuration.

</div>
</div>
<div>
<h3 id="PassengerRuby">5.2. PassengerRuby &lt;filename&gt;</h3>
<div>

This option allows one to specify the Ruby interpreter to use.

</div>
<div>

This option may only occur once, in the global server configuration. The default is <em>ruby</em>.

</div>
</div>
<div>
<h3 id="PassengerAppRoot">5.3. PassengerAppRoot &lt;path/to/root&gt;</h3>
<div>

By default, Phusion Passenger assumes that the application’s root directory is the parent directory of the <em>public</em> directory. This option allows one to specify the application’s root independently from the DocumentRoot, which is useful if the <em>public</em> directory lives in a non-standard place.

</div>
<div>

This option may occur in the following places:

</div>
<div>
<ul>
	<li>In the global server configuration.</li>
	<li>In a virtual host configuration block.</li>
	<li>In a &lt;Directory&gt; or &lt;Location&gt; block.</li>
	<li>In <em>.htaccess</em>, if AllowOverride Options is on.</li>
</ul>
</div>
<div>

In each place, it may be specified at most once.

</div>
<div>

Example:

</div>
<div>
<div>
<pre>&lt;VirtualHost test.host&gt;
    DocumentRoot /var/rails/zena/sites/example.com/public
    PassengerAppRoot /var/rails/zena   # &lt;-- normally Phusion Passenger would
                                       #     have assumed that the application
                                       #     root is "/var/rails/zena/sites/example.com"
&lt;/VirtualHost&gt;</pre>
</div>
</div>
</div>
<div>
<h3 id="PassengerSpawnMethod">5.4. PassengerSpawnMethod &lt;string&gt;</h3>
<div>
<table>
<tbody>
<tr>
<td><img src="http://www.modrails.com/documentation/images/icons/tip.png" alt="Tip" /></td>
<td>
<div>"What spawn method should I use?"</div>
<div>

This subsection attempts to describe spawn methods, but it’s okay if you don’t (want to) understand it, as it’s mostly a technical detail. You can basically follow this rule of thumb:

</div>
<div>
<div>
<div>

If your application works on Mongrel, but not on Phusion Passenger, then set PassengerSpawnMethod to <em>conservative</em>. Otherwise, leave it at <em>smart-lv2</em> (the default).

</div>
</div>
</div>
<div>

However, we do recommend you to try to understand it. The <em>smart</em> and <em>smart-lv2</em> spawn methods bring many benefits.

</div></td>
</tr>
</tbody>
</table>
</div>
<div>

Internally, Phusion Passenger spawns multiple Ruby application processes in order to handle requests. But there are multiple ways with which processes can be spawned, each having its own set of pros and cons. Supported spawn methods are:

</div>
<div><dl><dt><em>smart</em></dt><dd>When this spawn method is used, Phusion Passenger will attempt to cache any framework code (e.g. Ruby on Rails itself) and application code for a limited period of time. Please read <a href="http://www.modrails.com/documentation/Users%20guide%20Apache.html#spawning_methods_explained">Spawning methods explained</a> for a more detailed explanation of what smart spawning exactly does.
<div>

<strong>Pros:</strong> This can significantly decrease spawn time (by as much as 90%). And, when Ruby Enterprise Edition is used, <a href="http://www.modrails.com/documentation/Users%20guide%20Apache.html#reducing_memory_usage">memory usage can be reduced by 33% on average</a>.

</div>
<div>

<strong>Cons:</strong> Some applications and libraries are not compatible with smart spawning. If that’s the case for your application, then you should use <em>conservative</em> as spawning method. Please read <a href="http://www.modrails.com/documentation/Users%20guide%20Apache.html#spawning_methods_explained">Spawning methods explained</a> for possible compatibility issues.

</div>
</dd><dt><em>smart-lv2</em></dt><dd>This spawning method is similar to <em>smart</em> but it skips the framework spawner and uses the application spawner directly. This means the framework code is not cached between multiple applications, although it is still cached within instances of the same application. Please read <a href="http://www.modrails.com/documentation/Users%20guide%20Apache.html#spawning_methods_explained">Spawning methods explained</a> for a more detailed explanation of what smart-lv2 spawning exactly does.
<div>

<strong>Pros:</strong> It is compatible with a larger number of applications when compared to the <em>smart</em> method, and still performs some caching.

</div>
<div>

<strong>Cons:</strong> It is slower than smart spawning if you have many applications which use the same framework version. It is therefore advised that shared hosts use the <em>smart</em> method instead.

</div>
</dd><dt><em>conservative</em></dt><dd>This spawning method is similar to the one used in Mongrel Cluster. It does not perform any code caching at all. Please read <a href="http://www.modrails.com/documentation/Users%20guide%20Apache.html#spawning_methods_explained">Spawning methods explained</a> for a more detailed explanation of what conservative spawning exactly does.
<div>

<strong>Pros:</strong> Conservative spawning is guaranteed to be compatible with all applications and libraries.

</div>
<div>

<strong>Cons:</strong> Much slower than smart spawning. Every spawn action will be equally slow, though no slower than the startup time of a single server in Mongrel Cluster. Conservative spawning will also render <a href="http://www.modrails.com/documentation/Users%20guide%20Apache.html#reducing_memory_usage">Ruby Enterprise Edition’s memory reduction technology</a> useless.

</div>
</dd></dl></div>
<div>

This option may occur in the following places:

</div>
<div>
<ul>
	<li>In the global server configuration.</li>
	<li>In a virtual host configuration block.</li>
</ul>
</div>
<div>

In each place, it may be specified at most once. The default value is <em>smart-lv2</em>.

</div>
</div>
<div>
<h3 id="PassengerUseGlobalQueue">5.5. PassengerUseGlobalQueue &lt;on|off&gt;</h3>
<div>

Turns the use of global queuing on or off.

</div>
<div>

This option may occur in the following places:

</div>
<div>
<ul>
	<li>In the global server configuration.</li>
	<li>In a virtual host configuration block.</li>
</ul>
</div>
<div>

In each place, it may be specified at most once. The default value is <em>on</em>.

</div>
<div>

<em>This feature is sponsored by <a href="http://www.37signals.com/">37signals</a>.</em>

</div>
<div>
<div>What does this option do?</div>
Recall that Phusion Passenger spawns multiple backend processes (e.g. multiple Ruby on Rails processes), each which processes HTTP requests serially. One of Phusion Passenger’s jobs is to forward HTTP requests to a suitable backend process. A backend process may take an arbitrary amount of time to process a specific HTTP request. If the websites are (temporarily) under high load, and the backend processes cannot process the requests fast enough, then some requests may have to be queued.

</div>
<div>

If global queuing is turned off, then Phusion Passenger will use <em>fair load balancing</em>. This means that each backend process will have its own private queue. Phusion Passenger will forward an HTTP request to the backend process that has the least amount of requests in its queue.

</div>
<div>

If global queuing is turned on, then Phusion Passenger will use a global queue that’s shared between all backend processes. If an HTTP request comes in, and all the backend processes are still busy, then Phusion Passenger will wait until at least one backend process is done, and will then forward the request to that process.

</div>
<div>
<div>When to turn on global queuing?</div>
You should turn on global queuing if one of your web applications may have long-running requests.

</div>
<div>

For example suppose that:

</div>
<div>
<ul>
	<li>global queuing is turned off.</li>
	<li>we’re currently in a state where all backend processes have 3 requests in their queue, except for a single backend process, which has 1 request in its queue.</li>
</ul>
</div>
<div>

The situation looks like this:

</div>
<div>
<div>
<pre>Backend process A:  [*     ]  (1 request in queue)
Backend process B:  [***   ]  (3 requests in queue)
Backend process C:  [***   ]  (3 requests in queue)
Backend process D:  [***   ]  (3 requests in queue)</pre>
</div>
</div>
<div>

Each process is currently serving short-running requests.

</div>
<div>

Phusion Passenger will forward the next request to backend process A. A will now have 2 items in its queue. We’ll mark this new request with an X:

</div>
<div>
<div>
<pre>Backend process A:  [*X    ]  (2 request in queue)
Backend process B:  [***   ]  (3 requests in queue)
Backend process C:  [***   ]  (3 requests in queue)
Backend process D:  [***   ]  (3 requests in queue)</pre>
</div>
</div>
<div>

Assuming that B, C and D still aren’t done with their current request, the next HTTP request - let’s call this Y - will be forwarded to backend process A as well, because it has the least number of items in its queue:

</div>
<div>
<div>
<pre>Backend process A:  [*XY   ]  (3 requests in queue)
Backend process B:  [***   ]  (3 requests in queue)
Backend process C:  [***   ]  (3 requests in queue)
Backend process D:  [***   ]  (3 requests in queue)</pre>
</div>
</div>
<div>

But if request X happens to be a long-running request that needs 60 seconds to complete, then we’ll have a problem. Y won’t be processed for at least 60 seconds. It would have been a better idea if Y was forward to processes B, C or D instead, because they only have short-living requests in their queues.

</div>
<div>

This problem will be avoided entirely if you turn global queuing on. With global queuing, all backend processes will share the same queue. The first backend process that becomes available will take from the queue, and so this “queuing-behind-long-running-request” problem will never occur.

</div>
</div>
<div>
<h3 id="_passengerenabled_lt_on_off_gt">5.6. PassengerEnabled &lt;on|off&gt;</h3>
<div>

You can set this option to <em>off</em> to completely disable Phusion Passenger for a certain location. This is useful if, for example, you want to integrate a PHP application into the same virtual host as a Rails application.

</div>
<div>

Suppose that you have a Rails application in <em>/apps/foo</em>. Suppose that you’ve dropped Wordpress — a blogging application written in PHP — in <em>/apps/foo/public/wordpress</em>. You can then configure Phusion Passenger as follows:

</div>
<div>
<div>
<pre>&lt;VirtualHost *:80&gt;
    ServerName www.foo.com
    DocumentRoot /apps/foo/public
    &lt;Directory /apps/foo/public/wordpress&gt;
        PassengerEnabled off
        AllowOverride all      # &lt;-- Makes Wordpress's .htaccess file work.
    &lt;/Directory&gt;
&lt;/VirtualHost&gt;</pre>
</div>
</div>
<div>

This way, Phusion Passenger will not interfere with Wordpress.

</div>
<div>

<em>PassengerEnabled</em> may occur in the following places:

</div>
<div>
<ul>
	<li>In the global server configuration.</li>
	<li>In a virtual host configuration block.</li>
	<li>In a &lt;Directory&gt; or &lt;Location&gt; block.</li>
	<li>In <em>.htaccess</em>.</li>
</ul>
</div>
<div>

In each place, it may be specified at most once. The default value is <em>on</em>.

</div>
</div>
<div>
<h3 id="PassengerTempDir">5.7. PassengerTempDir &lt;directory&gt;</h3>
<div>

Specifies the directory that Phusion Passenger should use for storing temporary files. This includes things such as Unix socket files, buffered file uploads (see also <a href="http://www.modrails.com/documentation/Users%20guide%20Apache.html#PassengerUploadBufferDir">PassengerUploadBufferDir</a>), etc.

</div>
<div>

This option may be specified once, in the global server configuration. The default temp directory that Phusion Passenger uses is <em>/tmp</em>.

</div>
<div>

This option is especially useful if Apache is not allowed to write to /tmp (which is the case on some systems with strict SELinux policies) or if the partition that /tmp lives on doesn’t have enough disk space.

</div>
<div>
<div>Command line tools</div>
Some Phusion Passenger command line administration tools, such as passenger-status, must know what Phusion Passenger’s temp directory is in order to function properly. You can pass the directory through the PASSENGER_TMPDIR environment variable, or the TMPDIR environment variable (the former will be used if both are specified).

</div>
<div>

For example, if you set <em>PassengerTempDir</em> to <em>/my_temp_dir</em>, then invoke passenger-status after you’ve set the PASSENGER_TMPDIR or TMPDIR environment variable, like this:

</div>
<div>
<div>
<pre>export PASSENGER_TMPDIR=/my_temp-dir
sudo -E passenger-status
# The -E option tells 'sudo' to preserve environment variables.</pre>
</div>
</div>
</div>
<div>
<h3 id="PassengerUploadBufferDir">5.8. PassengerUploadBufferDir &lt;directory&gt;</h3>
<div>

Phusion Passenger buffers large file uploads to disk in order prevent slow file uploads from blocking web applications. By default, a subdirectory in the system’s temporary files directory (or a subdirectory in the directory specified in <a href="http://www.modrails.com/documentation/Users%20guide%20Apache.html#PassengerTempDir">PassengerTempDir</a>, if set) is automatically created for storing these buffered file uploads.

</div>
<div>

This configuration directive allows you to specify a different directory for storing buffered file uploads. If you’ve specified such a directory (as opposed to using Phusion Passenger’s default) then you <strong>must</strong> ensure that this directory exists.

</div>
<div>

This configuration directive is also useful if you’re using apache2-mpm-itk. The buffered file upload directory that Phusion Passenger creates by default has very strict permissions: it can only be accessed by the Apache worker processes. However, Phusion Passenger assumes that all Apache worker processes are running as the same user. apache2-mpm-itk breaks this assumption by running multiple Apache worker processes as different users. So if you’re using apace2-mpm-itk, you should set this option to a directory that is writable by all Apache worker processes, such as <em>/tmp</em>.

</div>
<div>

You may specify <em>PassengerUploadBufferDir</em> in the following places:

</div>
<div>
<ul>
	<li>In the global server configuration.</li>
	<li>In a virtual host configuration block.</li>
	<li>In a &lt;Directory&gt; or &lt;Location&gt; block.</li>
	<li>In <em>.htaccess</em>, if AllowOverrides Options is enabled.</li>
</ul>
</div>
<div>

In each place, it may be specified at most once.

</div>
</div>
<div>
<h3 id="_passengerrestartdir_lt_directory_gt">5.9. PassengerRestartDir &lt;directory&gt;</h3>
<div>

As described in the deployment chapters of this document, Phusion Passenger checks the file <em>tmp/restart.txt</em> in the applications' <a href="http://www.modrails.com/documentation/Users%20guide%20Apache.html#application_root">root directory</a> for restarting applications. Sometimes it may be desirable for Phusion Passenger to look in a different directory instead, for example for security reasons (see below). This option allows you to customize the directory in which <em>restart.txt</em> is searched for.

</div>
<div>

You may specify <em>PassengerRestartDir</em> in the following places:

</div>
<div>
<ul>
	<li>In the global server configuration.</li>
	<li>In a virtual host configuration block.</li>
	<li>In a &lt;Directory&gt; or &lt;Location&gt; block.</li>
	<li>In <em>.htaccess</em>, if AllowOverrides Options is enabled.</li>
</ul>
</div>
<div>

In each place, it may be specified at most once.

</div>
<div>

You can either set it to an absolute directory, or to a directory relative to the <a href="http://www.modrails.com/documentation/Users%20guide%20Apache.html#application_root">application root</a>. Examples:

</div>
<div>
<div>
<pre>&lt;VirtualHost *:80&gt;
    ServerName www.foo.com
    # Phusion Passenger will check for /apps/foo/public/tmp/restart.txt
    DocumentRoot /apps/foo/public
&lt;/VirtualHost&gt;

&lt;VirtualHost *:80&gt;
    ServerName www.bar.com
    DocumentRoot /apps/bar/public
    # An absolute filename is given; Phusion Passenger will
    # check for /restart_files/bar/restart.txt
    PassengerRestartDir /restart_files/bar
&lt;/VirtualHost&gt;

&lt;VirtualHost *:80&gt;
    ServerName www.baz.com
    DocumentRoot /apps/baz/public
    # A relative filename is given; Phusion Passenger will
    # check for /apps/baz/restart_files/restart.txt
    #
    # Note that this directory is relative to the APPLICATION ROOT, *not*
    # the value of DocumentRoot!
    PassengerRestartDir restart_files
&lt;/VirtualHost&gt;</pre>
</div>
</div>
<div>
<div>What are the security reasons for wanting to customize PassengerRestartDir?</div>
Touching restart.txt will cause Phusion Passenger to restart the application. So anybody who can touch restart.txt can effectively cause a Denial-of-Service attack by touching restart.txt over and over. If your web server or one of your web applications has the permission to touch restart.txt, and one of them has a security flaw which allows an attacker to touch restart.txt, then that will allow the attacker to cause a Denial-of-Service.

</div>
<div>

You can prevent this from happening by pointing PassengerRestartDir to a directory that’s readable by Apache, but only writable by administrators.

</div>
</div>
<div>
<h3 id="PassengerBufferResponse">5.10. PassengerBufferResponse &lt;on|off&gt;</h3>
<div>

When turned on, application-generated responses are buffered in memory. By buffering responses, protection is provided against slow HTTP clients that can not read your response immediately.

</div>
<div>

For example, consider an HTTP client that’s on a dial-up modem link, and your application instance generates a 2 MB response. If response buffering is turned off then your application instance will be blocked until the entire 2 MB has been sent out to the HTTP client. This disallows your application instance to do any useful work in the mean time. By enabling response buffering, Phusion Passenger will read the application response as quickly as possible and will take care of slow clients.

</div>
<div>

However, keep in mind that enabling this option will make streaming responses impossible. Consider for example this piece of Rails code:

</div>
<div>
<div>
<pre>render :text =&gt; lambda { |response, output|
    10.times do |i|
        output.write("entry #{i}\n")
        output.flush
        sleep 1
    end
}</pre>
</div>
</div>
<div>

…or this piece of Rack code:

</div>
<div>
<div>
<pre>class Response
    def each
        10.times do |i|
            yield("entry #{i}\n")
            sleep 1
        end
    end
end

app = lambda do |env|
    [200, { "Content-Type" =&gt; "text/plain" }, Response.new]
end</pre>
</div>
</div>
<div>

When response buffering is turned on, Phusion Passenger will wait until the application is done sending the entire response before forwarding it to the client. The client will not receive anything for 10 seconds, after which it receives the entire response at once. When response buffering is turned off, it works as expected: the client receives an "entry X" message every second for 10 seconds.

</div>
<div>

This option may occur in the following places:

</div>
<div>
<ul>
	<li>In the global server configuration.</li>
	<li>In a virtual host configuration block.</li>
	<li>In a &lt;Directory&gt; or &lt;Location&gt; block.</li>
	<li>In <em>.htaccess</em>.</li>
</ul>
</div>
<div>

In each place, it may be specified at most once. The default value is <em>on</em>.

</div>
<div>
<table>
<tbody>
<tr>
<td><img src="http://www.modrails.com/documentation/images/icons/note.png" alt="Note" /></td>
<td>
<div>

The <a href="http://www.modrails.com/documentation/Users%20guide%20Apache.html#PassengerBufferResponse">PassengerBufferResponse</a> directive should be turned off if responses can be huge. Because entire responses are buffered in memory when turned on.

</div></td>
</tr>
</tbody>
</table>
</div>
</div>
<div>
<h3 id="_security_options">5.11. Security options</h3>
<div>
<h4 id="PassengerUserSwitching">5.11.1. PassengerUserSwitching &lt;on|off&gt;</h4>
<div>

Whether to enable <a href="http://www.modrails.com/documentation/Users%20guide%20Apache.html#user_switching">user switching support</a>.

</div>
<div>

This option may only occur once, in the global server configuration. The default value is <em>on</em>.

</div>
</div>
<div>
<h4 id="_passengeruser_lt_username_gt">5.11.2. PassengerUser &lt;username&gt;</h4>
<div>

If <a href="http://www.modrails.com/documentation/Users%20guide%20Apache.html#user_switching">user switching support</a> is enabled, then Phusion Passenger will by default run the web application as the owner of the file <em>config/environment.rb</em> (for Rails apps) or <em>config.ru</em> (for Rack apps). This option allows you to override that behavior and explicitly set a user to run the web application as, regardless of the ownership of <em>environment.rb</em>/<em>config.ru</em>.

</div>
<div>

This option may occur in the following places:

</div>
<div>
<ul>
	<li>In the global server configuration.</li>
	<li>In a virtual host configuration block.</li>
	<li>In a &lt;Directory&gt; or &lt;Location&gt; block.</li>
</ul>
</div>
<div>

In each place, it may be specified at most once.

</div>
</div>
<div>
<h4 id="_passengergroup_lt_group_name_gt">5.11.3. PassengerGroup &lt;group name&gt;</h4>
<div>

If <a href="http://www.modrails.com/documentation/Users%20guide%20Apache.html#user_switching">user switching support</a> is enabled, then Phusion Passenger will by default run the web application as the primary group of the owner of the file <em>config/environment.rb</em> (for Rails apps) or <em>config.ru</em> (for Rack apps). This option allows you to override that behavior and explicitly set a group to run the web application as, regardless of the ownership of <em>environment.rb</em>/<em>config.ru</em>.

</div>
<div>

<em>&lt;group name&gt;</em> may also be set to the special value <em>!STARTUP_FILE!</em>, in which case the web application’s group will be set to <em>environment.rb</em>/<em>config.ru</em>'s group.

</div>
<div>

This option may occur in the following places:

</div>
<div>
<ul>
	<li>In the global server configuration.</li>
	<li>In a virtual host configuration block.</li>
	<li>In a &lt;Directory&gt; or &lt;Location&gt; block.</li>
</ul>
</div>
<div>

In each place, it may be specified at most once.

</div>
</div>
<div>
<h4 id="PassengerDefaultUser">5.11.4. PassengerDefaultUser &lt;username&gt;</h4>
<div>

Phusion Passenger enables <a href="http://www.modrails.com/documentation/Users%20guide%20Apache.html#user_switching">user switching support</a> by default. This configuration option allows one to specify the user that applications must run as, if user switching fails or is disabled.

</div>
<div>

This option may only occur once, in the global server configuration. The default value is <em>nobody</em>.

</div>
</div>
<div>
<h4 id="PassengerDefaultGroup">5.11.5. PassengerDefaultGroup &lt;group name&gt;</h4>
<div>

Phusion Passenger enables <a href="http://www.modrails.com/documentation/Users%20guide%20Apache.html#user_switching">user switching support</a> by default. This configuration option allows one to specify the group that applications must run as, if user switching fails or is disabled.

</div>
<div>

This option may only occur once, in the global server configuration. The default value is the primary group of the user specifified by <a href="http://www.modrails.com/documentation/Users%20guide%20Apache.html#PassengerDefaultUser">PassengerDefaultUser</a>.

</div>
</div>
<div>
<h4 id="_passengerfriendlyerrorpages_lt_on_off_gt">5.11.6. PassengerFriendlyErrorPages &lt;on|off&gt;</h4>
<div>

Phusion Passenger can display friendly error pages whenever an application fails to start. This friendly error page presents the startup error message, some suggestions for solving the problem, and a backtrace. This feature is very useful during application development and useful for less experienced system administrators, but the page might reveal potentially sensitive information, depending on the application. Experienced system administrators who are using Phusion Passenger on serious production servers should consider turning this feature off.

</div>
<div>

This option may occur in the following places:

</div>
<div>
<ul>
	<li>In the global server configuration.</li>
	<li>In a virtual host configuration block.</li>
	<li>In a &lt;Directory&gt; or &lt;Location&gt; block.</li>
	<li>In <em>.htaccess</em>, if AllowOverride Options is on.</li>
</ul>
</div>
<div>

In each place, it may be specified at most once. The default value is <em>on</em>.

</div>
</div>
</div>
<div>
<h3 id="_resource_control_and_optimization_options">5.12. Resource control and optimization options</h3>
<div>
<h4 id="_passengermaxpoolsize_lt_integer_gt">5.12.1. PassengerMaxPoolSize &lt;integer&gt;</h4>
<div>

The maximum number of Ruby on Rails or Rack application instances that may be simultaneously active. A larger number results in higher memory usage, but improved ability to handle concurrent HTTP clients.

</div>
<div>

The optimal value depends on your system’s hardware and the server’s average load. You should experiment with different values. But generally speaking, the value should be at least equal to the number of CPUs (or CPU cores) that you have. If your system has 2 GB of RAM, then we recommend a value of <em>30</em>. If your system is a Virtual Private Server (VPS) and has about 256 MB RAM, and is also running other services such as MySQL, then we recommend a value of <em>2</em>.

</div>
<div>

If you find that your server is unable to handle the load on your Rails/Rack websites (i.e. running out of memory) then you should lower this value. (Though if your sites are really that popular, then you should strongly consider upgrading your hardware or getting more servers.)

</div>
<div>

This option may only occur once, in the global server configuration. The default value is <em>6</em>.

</div>
<div>
<table>
<tbody>
<tr>
<td><img src="http://www.modrails.com/documentation/images/icons/tip.png" alt="Tip" /></td>
<td>We strongly recommend you to <a href="http://www.modrails.com/documentation/Users%20guide%20Apache.html#reducing_memory_usage">use Ruby Enterprise Edition</a>. This allows you to reduce the memory usage of your Ruby on Rails applications by about 33%. And it’s not hard to install.</td>
</tr>
</tbody>
</table>
</div>
</div>
<div>
<h4 id="PassengerMinInstances">5.12.2. PassengerMinInstances &lt;integer&gt;</h4>
<div>

This specifies the minimum number of application instances that must be kept around whenever Phusion Passenger cleans up idle instances. You should set this option to a non-zero value if you want to avoid potentially long startup times after a website has been idle for an extended period.

</div>
<div>

Please note that this option does <strong>not</strong> pre-start application instances during Apache startup. It just makes sure that when the application is first accessed:

</div>
<div>
<ol>
	<li>at least the given number of instances will be spawned.</li>
	<li>the given number of processes will be kept around even when instances are being idle cleaned (see <a href="http://www.modrails.com/documentation/Users%20guide%20Apache.html#PassengerPoolIdleTime">PassengerPoolIdleTime</a>).</li>
</ol>
</div>
<div>

If you want to pre-start application instances during Apache startup, then you should use the <a href="http://www.modrails.com/documentation/Users%20guide%20Apache.html#PassengerPreStart">PassengerPreStart</a> directive, possibly in combination with <em>PassengerMinInstances</em>. This behavior might seem counter-intuitive at first sight, but <a href="http://www.modrails.com/documentation/Users%20guide%20Apache.html#PassengerPreStart">PassengerPreStart</a> explains the rationale behind it.

</div>
<div>

For example, suppose that you have the following configuration:

</div>
<div>
<div>
<pre>PassengerMaxPoolSize 15
PassengerPoolIdleTime 10

&lt;VirtualHost *:80&gt;
    ServerName foobar.com
    DocumentRoot /webapps/foobar/public
    PassengerMinInstances 3
&lt;/VirtualHost&gt;</pre>
</div>
</div>
<div>

When you start Apache, there are 0 application instances for <em>foobar.com</em>. Things will stay that way until someone visits <em>foobar.com</em>. Suppose that there is only 1 visitor. 1 application instance will be started immediately to serve the visitor, while 2 will be spawned in the background. After 10 seconds, when the idle timeout has been reached, these 3 application instances will not be cleaned up.

</div>
<div>

Now suppose that there’s a sudden spike of traffic, and 100 users visit <em>foobar.com</em> simultanously. Phusion Passenger will start 12 more application instances. After the idle timeout of 10 seconds have passed, Phusion Passenger will clean up 12 application instances, keeping 3 instances around.

</div>
<div>

The PassengerMinInstances option may occur in the following places:

</div>
<div>
<ul>
	<li>In the global server configuration.</li>
	<li>In a virtual host configuration block.</li>
	<li>In a &lt;Directory&gt; or &lt;Location&gt; block.</li>
	<li>In <em>.htaccess</em>, if AllowOverride Limits is on.</li>
</ul>
</div>
<div>

In each place, it may be specified at most once. The default value is <em>1</em>.

</div>
</div>
<div>
<h4 id="_passengermaxinstancesperapp_lt_integer_gt">5.12.3. PassengerMaxInstancesPerApp &lt;integer&gt;</h4>
<div>

The maximum number of application instances that may be simultaneously active for a single application. This helps to make sure that a single application will not occupy all available slots in the application pool.

</div>
<div>

This value must be less than <a href="http://www.modrails.com/documentation/Users%20guide%20Apache.html#PassengerMaxPoolSize">PassengerMaxPoolSize</a>. A value of 0 means that there is no limit placed on the number of instances a single application may use, i.e. only the global limit of <a href="http://www.modrails.com/documentation/Users%20guide%20Apache.html#PassengerMaxPoolSize">PassengerMaxPoolSize</a> will be enforced.

</div>
<div>

This option may only occur once, in the global server configuration. The default value is <em>0</em>.

</div>
</div>
<div>
<h4 id="PassengerPoolIdleTime">5.12.4. PassengerPoolIdleTime &lt;integer&gt;</h4>
<div>

The maximum number of seconds that an application instance may be idle. That is, if an application instance hasn’t received any traffic after the given number of seconds, then it will be shutdown in order to conserve memory.

</div>
<div>

Decreasing this value means that applications will have to be spawned more often. Since spawning is a relatively slow operation, some visitors may notice a small delay when they visit your Rails/Rack website. However, it will also free up resources used by applications more quickly.

</div>
<div>

The optimal value depends on the average time that a visitor spends on a single Rails/Rack web page. We recommend a value of 2 * x, where x is the average number of seconds that a visitor spends on a single Rails/Rack web page. But your mileage may vary.

</div>
<div>

When this value is set to <em>0</em>, application instances will not be shutdown unless it’s really necessary, i.e. when Phusion Passenger is out of worker processes for a given application and one of the inactive application instances needs to make place for another application instance. Setting the value to 0 is recommended if you’re on a non-shared host that’s only running a few applications, each which must be available at all times.

</div>
<div>

This option may only occur once, in the global server configuration. The default value is <em>300</em>.

</div>
</div>
<div>
<h4 id="PassengerMaxRequests">5.12.5. PassengerMaxRequests &lt;integer&gt;</h4>
<div>

The maximum number of requests an application instance will process. After serving that many requests, the application instance will be shut down and Phusion Passenger will restart it. A value of 0 means that there is no maximum: an application instance will thus be shut down when its idle timeout has been reached.

</div>
<div>

This option is useful if your application is leaking memory. By shutting it down after a certain number of requests, all of its memory is guaranteed to be freed by the operating system.

</div>
<div>

This option may occur in the following places:

</div>
<div>
<ul>
	<li>In the global server configuration.</li>
	<li>In a virtual host configuration block.</li>
	<li>In a &lt;Directory&gt; or &lt;Location&gt; block.</li>
	<li>In <em>.htaccess</em>, if AllowOverride Limits is on.</li>
</ul>
</div>
<div>

In each place, it may be specified at most once. The default value is <em>0</em>.

</div>
<div>
<table>
<tbody>
<tr>
<td><img src="http://www.modrails.com/documentation/images/icons/caution.png" alt="Caution" /></td>
<td>
<div>

The <a href="http://www.modrails.com/documentation/Users%20guide%20Apache.html#PassengerMaxRequests">PassengerMaxRequests</a> directive should be considered as a workaround for misbehaving applications. It is advised that you fix the problem in your application rather than relying on these directives as a measure to avoid memory leaks.

</div></td>
</tr>
</tbody>
</table>
</div>
</div>
<div>
<h4 id="_passengerstatthrottlerate_lt_integer_gt">5.12.6. PassengerStatThrottleRate &lt;integer&gt;</h4>
<div>

By default, Phusion Passenger performs several filesystem checks (or, in programmers jargon, <em>stat() calls</em>) each time a request is processed:

</div>
<div>
<ul>
	<li>It checks whether <em>config/environment.rb</em>, <em>config.ru</em> or <em>passenger_wsgi.py</em> is present, in order to autodetect Rails, Rack and WSGI applications.</li>
	<li>It checks whether <em>restart.txt</em> has changed or whether <em>always_restart.txt</em> exists, in order to determine whether the application should be restarted.</li>
</ul>
</div>
<div>

On some systems where disk I/O is expensive, e.g. systems where the harddisk is already being heavily loaded, or systems where applications are stored on NFS shares, these filesystem checks can incur a lot of overhead.

</div>
<div>

You can decrease or almost entirely eliminate this overhead by setting <em>PassengerStatThrottleRate</em>. Setting this option to a value of <em>x</em> means that the above list of filesystem checks will be performed at most once every <em>x</em> seconds. Setting it to a value of <em>0</em> means that no throttling will take place, or in other words, that the above list of filesystem checks will be performed on every request.

</div>
<div>

This option may occur in the following places:

</div>
<div>
<ul>
	<li>In the global server configuration.</li>
	<li>In a virtual host configuration block.</li>
	<li>In a &lt;Directory&gt; or &lt;Location&gt; block.</li>
	<li>In <em>.htaccess</em>, if AllowOverride Limits is on.</li>
</ul>
</div>
<div>

In each place, it may be specified at most once. The default value is <em>0</em>.

</div>
</div>
<div>
<h4 id="PassengerPreStart">5.12.7. PassengerPreStart &lt;url&gt;</h4>
<div>

By default, Phusion Passenger does not start any application instances until said web application is first accessed. The result is that the first visitor of said web application might experience a small delay as Phusion Passenger is starting the web application on demand. If that is undesirable, then this directive can be used to pre-started application instances during Apache startup.

</div>
<div>

A few things to be careful of:

</div>
<div>
<ul>
	<li>This directive accepts the <strong>URL</strong> of the web application you want to pre-start, not a on/off value! This might seem a bit weird, but read on for rationale. As for the specifics of the URL:
<div>
<ul>
	<li>The domain part of the URL must be equal to the value of the <em>ServerName</em> directive of the VirtualHost block that defines the web application.</li>
	<li>Unless the web application is deployed on port 80, the URL should contain the web application’s port number too.</li>
	<li>The path part of the URL must point to some URI that the web application handles.</li>
</ul>
</div></li>
	<li>You will probably want to combine this option with <a href="http://www.modrails.com/documentation/Users%20guide%20Apache.html#PassengerMinInstances">PassengerMinInstances</a> because application instances started with <em>PassengerPreStart</em> are subject to the usual idle timeout rules. See the example below for an explanation.</li>
</ul>
</div>
<div>

This option may occur in the following places:

</div>
<div>
<ul>
	<li>In the global server configuration.</li>
	<li>In a virtual host configuration block.</li>
</ul>
</div>
<div>

In each place, it may be specified any number of times.

</div>
<div>
<h5 id="_example_1_basic_usage">Example 1: basic usage</h5>
<div>

Suppose that you have the following web applications.

</div>
<div>
<div>
<pre>&lt;VirtualHost *:80&gt;
   ServerName foo.com
   DocumentRoot /webapps/foo/public
&lt;/VirtualHost&gt;

&lt;VirtualHost *:3500&gt;
   ServerName bar.com
   DocumentRoot /webapps/bar/public
&lt;/VirtualHost&gt;</pre>
</div>
</div>
<div>

You want both of them to be pre-started during Apache startup. The URL for foo.com is <em>http://foo.com/</em> (or, equivalently, <em>http://foo.com:80/</em>) and the URL for bar.com is <em>http://bar.com:3500/</em>. So we add two PassengerPreStart directives, like this:

</div>
<div>
<div>
<pre>&lt;VirtualHost *:80&gt;
   ServerName foo.com
   DocumentRoot /webapps/foo/public
&lt;/VirtualHost&gt;

&lt;VirtualHost *:3500&gt;
   ServerName bar.com
   DocumentRoot /webapps/bar/public
&lt;/VirtualHost&gt;

PassengerPreStart http://foo.com/           # &lt;--- added
PassengerPreStart http://bar.com:3500/      # &lt;--- added</pre>
</div>
</div>
</div>
<div>
<h5 id="_example_2_pre_starting_apps_that_are_deployed_in_sub_uris">Example 2: pre-starting apps that are deployed in sub-URIs</h5>
<div>

Suppose that you have a web application deployed in a sub-URI <em>/store</em>, like this:

</div>
<div>
<div>
<pre>&lt;VirtualHost *:80&gt;
   ServerName myblog.com
   DocumentRoot /webapps/wordpress
   RailsBaseURI /store
&lt;/VirtualHost&gt;</pre>
</div>
</div>
<div>

Then specify the domain name of its containing virtual host followed by the sub-URI, like this:

</div>
<div>
<div>
<pre>&lt;VirtualHost *:80&gt;
   ServerName myblog.com
   DocumentRoot /webapps/wordpress
   RailsBaseURI /store
&lt;/VirtualHost&gt;

PassengerPreStart http://myblog.com/store    # &lt;----- added</pre>
</div>
</div>
<div>

The sub-URI <strong>must</strong> be included; if you don’t then the directive will have no effect. The following example is wrong and won’t pre-start the store web application:

</div>
<div>
<div>
<pre>PassengerPreStart http://myblog.com/    # &lt;----- WRONG! Missing "/store" part.</pre>
</div>
</div>
</div>
<div>
<h5 id="_example_3_combining_with_passengermininstances">Example 3: combining with PassengerMinInstances</h5>
<div>

Application instances started with PassengerPreStart are also subject to the idle timeout rules as specified by <a href="http://www.modrails.com/documentation/Users%20guide%20Apache.html#PassengerPoolIdleTime">PassengerPoolIdleTime</a>! That means that by default, the pre-started application instances for foo.com are bar.com are shut down after a few minutes of inactivity. If you don’t want that to happen, then you should combine PassengerPreStart with <a href="http://www.modrails.com/documentation/Users%20guide%20Apache.html#PassengerMinInstances">PassengerMinInstances</a>, like this:

</div>
<div>
<div>
<pre>&lt;VirtualHost *:80&gt;
   ServerName foo.com
   DocumentRoot /webapps/foo/public
   PassengerMinInstances 1      # &lt;--- added
&lt;/VirtualHost&gt;

&lt;VirtualHost *:3500&gt;
   ServerName bar.com
   DocumentRoot /webapps/bar/public
   PassengerMinInstances 1      # &lt;--- added
&lt;/VirtualHost&gt;

PassengerPreStart http://foo.com/
PassengerPreStart http://bar.com:3500/</pre>
</div>
</div>
</div>
<div>
<h5 id="_so_why_a_url_why_not_just_an_on_off_flag">So why a URL? Why not just an on/off flag?</h5>
<div>

A directive that accepts a simple on/off flag is definitely more intuitive, but due technical difficulties w.r.t. the way Apache works, it’s very hard to implement it like that:

</div>
<div>
<ul>
	<li>It is very hard to obtain a full list of web applications defined in the Apache configuration file(s). In other words, it’s hard for Phusion Passenger to know which web applications are deployed on Apache until a web application is first accessed, and without such a list Phusion Passenger wouldn’t know which web applications to pre-start. It’s probably not completely impossible to obtain such a list, but this brings us to the following point;</li>
	<li>Users expect things like <em>mod_env</em> to work even in combination with Phusion Passenger. For example some people put “SetEnv PATH=….” in their virtual host block and they expect the web application to pick that environment variable up when it’s started. Information like this is stored in module-specific locations that Phusion Passenger cannot access directly. Even if the previous bullet point is solved and we can obtain a list of web applications, we cannot start the application with the correct mod_env information. mod_env is just one such example; there are probably many other Apache modules, all of which people expect to work, but we cannot answer to those expectations if PassengerPreStart is implemented as a simple on/off flag.</li>
</ul>
</div>
<div>

So as a compromise, we made it accept a URL. This is easier to implement for us and altough it looks weird, it behaves consistently w.r.t. cooperation with other Apache modules.

</div>
</div>
<div>
<h5 id="_what_does_phusion_passenger_do_with_the_url">What does Phusion Passenger do with the URL?</h5>
<div>

During Apache startup, Phusion Passenger will send a dummy HEAD request to the given URL and discard the result. In other words, Phusion Passenger simulates a web access at the given URL. However this simulated request is always sent to localhost, <strong>not</strong> to the IP that the domain resolves to. Suppose that bar.com in example 1 resolves to 209.85.227.99; Phusion Passenger will send the following HTTP request to 127.0.0.1 port 3500 (and not to 209.85.227.99 port 3500):

</div>
<div>
<div>
<pre>HEAD / HTTP/1.1
Host: bar.com
Connection: close</pre>
</div>
</div>
<div>

Similarly, for example 2, Phusion Passenger will send the following HTTP request to 127.0.0.1 port 80:

</div>
<div>
<div>
<pre>HEAD /store HTTP/1.1
Host: myblog.com
Connection: close</pre>
</div>
</div>
</div>
<div>
<h5 id="_do_i_need_to_edit_etc_hosts_and_point_the_domain_in_the_url_to_127_0_0_1">Do I need to edit /etc/hosts and point the domain in the URL to 127.0.0.1?</h5>
<div>

No. See previous subsection.

</div>
</div>
<div>
<h5 id="_my_web_application_consists_of_multiple_web_servers_what_url_do_i_need_to_specify_and_in_which_web_server_8217_s_apache_config_file">My web application consists of multiple web servers. What URL do I need to specify, and in which web server’s Apache config file?</h5>
<div>

Put the web application’s virtual host’s ServerName value and the virtual host’s port in the URL, and put PassengerPreStart on all machines that you want to pre-start the web application on. The simulated web request is always sent to 127.0.0.1, with the domain name in the URL as value for the <em>Host</em> HTTP header, so you don’t need to worry about the request ending up at a different web server in the cluster.

</div>
</div>
<div>
<h5 id="_does_passengerprestart_support_https_urls">Does PassengerPreStart support https:// URLs?</h5>
<div>

Yes. And it does not perform any certificate validation.

</div>
</div>
</div>
<div>
<h4 id="PassengerHighPerformance">5.12.8. PassengerHighPerformance &lt;on|off&gt;</h4>
<div>

By default, Phusion Passenger is compatible with mod_rewrite and most other Apache modules. However, a lot of effort is required in order to be compatible. If you turn <em>PassengerHighPerformance</em> to <em>on</em>, then Phusion Passenger will be a little faster, in return for reduced compatibility with other Apache modules.

</div>
<div>

In places where <em>PassengerHighPerformance</em> is turned on, mod_rewrite rules will likely not work. mod_autoindex (the module which displays a directory index) will also not work. Other Apache modules may or may not work, depending on what they exactly do. We recommend you to find out how other modules behave in high performance mode via testing.

</div>
<div>

This option is <strong>not</strong> an all-or-nothing global option: you can enable high performance mode for certain virtual hosts or certain URLs only. The <em>PassengerHighPerformance</em> option may occur in the following places:

</div>
<div>
<ul>
	<li>In the global server configuration.</li>
	<li>In a virtual host configuration block.</li>
	<li>In a &lt;Directory&gt; or &lt;Location&gt; block.</li>
	<li>In <em>.htaccess</em>.</li>
</ul>
</div>
<div>

In each place, it may be specified at most once. The default value is <em>off</em>, so high performance mode is disabled by default, and you have to explicitly enable it.

</div>
<div>
<div>When to enable high performance mode?</div>
If you do not use mod_rewrite or other Apache modules then it might make sense to enable high performance mode.

</div>
<div>

It’s likely that some of your applications depend on mod_rewrite or other Apache modules, while some do not. In that case you can enable high performance for only those applications that don’t use other Apache modules. For example:

</div>
<div>
<div>
<pre>&lt;VirtualHost *:80&gt;
    ServerName www.foo.com
    DocumentRoot /apps/foo/public
    .... mod_rewrite rules or options for other Apache modules here ...
&lt;/VirtualHost&gt;

&lt;VirtualHost *:80&gt;
    ServerName www.bar.com
    DocumentRoot /apps/bar/public
    PassengerHighPerformance on
&lt;/VirtualHost&gt;</pre>
</div>
</div>
<div>

In the above example, high performance mode is only enabled for www.bar.com. It is disabled for everything else.

</div>
<div>

If your application generally depends on mod_rewrite or other Apache modules, but a certain URL that’s accessed often doesn’t depend on those other modules, then you can enable high performance mode for a certain URL only. For example:

</div>
<div>
<div>
<pre>&lt;VirtualHost *:80&gt;
    ServerName www.foo.com
    DocumentRoot /apps/foo/public
    .... mod_rewrite rules or options for other Apache modules here ...

    &lt;Location /chatroom/ajax_update_poll&gt;
        PassengerHighPerformance on
    &lt;/Location&gt;
&lt;/VirtualHost&gt;</pre>
</div>
</div>
<div>

This enables high performance mode for <a href="http://www.foo.com/chatroom/ajax_update_poll">http://www.foo.com/chatroom/ajax_update_poll</a> only.

</div>
</div>
</div>
<div>
<h3 id="_compatibility_options">5.13. Compatibility options</h3>
<div>
<h4 id="PassengerResolveSymlinksInDocumentRoot">5.13.1. PassengerResolveSymlinksInDocumentRoot &lt;on|off&gt;</h4>
<div>

Configures whether Phusion Passenger should resolve symlinks in the document root. Please refer to <a href="http://www.modrails.com/documentation/Users%20guide%20Apache.html#application_detection">How Phusion Passenger detects whether a virtual host is a web application</a> for more information.

</div>
<div>

This option may occur in the following places:

</div>
<div>
<ul>
	<li>In the global server configuration.</li>
	<li>In a virtual host configuration block.</li>
	<li>In a &lt;Directory&gt; or &lt;Location&gt; block.</li>
	<li>In <em>.htaccess</em>, if AllowOverride Options is on.</li>
</ul>
</div>
<div>

In each place, it may be specified at most once. It is off by default.

</div>
</div>
<div>
<h4 id="_passengerallowencodedslashes_lt_on_off_gt">5.13.2. PassengerAllowEncodedSlashes &lt;on|off&gt;</h4>
<div>

By default, Apache doesn’t support URLs with encoded slashes (%2f), e.g. URLs like this: /users/fujikura%2fyuu. If you access such an URL then Apache will return a 404 Not Found error. This can be solved by turning on PassengerAllowEncodedSlashes as well as Apache’s <a href="http://httpd.apache.org/docs/2.0/mod/core.html#allowencodedslashes">AllowEncodedSlashes</a>.

</div>
<div>

Is it important that you turn on both AllowEncodedSlashes <strong>and</strong> PassengerAllowEncodedSlashes, otherwise this feature will not work properly.

</div>
<div>

PassengerAllowEncodedSlashes may occur in the following places:

</div>
<div>
<ul>
	<li>In the global server configuration.</li>
	<li>In a virtual host configuration block.</li>
	<li>In a &lt;Directory&gt; or &lt;Location&gt; block.</li>
	<li>In <em>.htaccess</em>, if AllowOverride Options is on.</li>
</ul>
</div>
<div>

In each place, it may be specified at most once. It is off by default.

</div>
<div>

Please note however that turning on support for encoded slashes will break support for mod_rewrite passthrough rules. Because of bugs/limitations in Apache, Phusion Passenger can support either encoded slashes or mod_rewrite passthrough rules, but not both at the same time. Luckily this option can be specified anywhere, so you can enable it only for virtual hosts or URLs that need it:

</div>
<div>
<div>
<pre>&lt;VirtualHost *:80&gt;
    ServerName www.example.com
    DocumentRoot /webapps/example/public
    AllowEncodedSlashes on
    RewriteEngine on

    # Check for maintenance file and redirect all requests
    RewriteCond %{DOCUMENT_ROOT}/system/maintenance.html -f
    RewriteCond %{SCRIPT_FILENAME} !maintenance.html
    RewriteRule ^.*$ /system/maintenance.html [L]

    # Make /about an alias for /info/about.
    RewriteRule ^/about$ /info/about [PT,L]

    &lt;Location ~ "^/users/"&gt;
        # In a location block so that it doesn't interfere with the
        # above /about mod_rewrite rule.
        PassengerAllowEncodedSlashes on
    &lt;/Location&gt;
&lt;/VirtualHost&gt;</pre>
</div>
</div>
<div>

With this, <a href="http://www.example.com/users/fujikura%2fyuu">http://www.example.com/users/fujikura%2fyuu</a> will work properly, and accessing <a href="http://www.example.com/about">http://www.example.com/about</a> will properly display the result of <a href="http://www.example.com/info/about">http://www.example.com/info/about</a>. Notice that PassengerAllowEncodedSlashes only interferes with passthrough rules, not with any other mod_rewrite rules. The rules for displaying maintenance.html will work fine even for URLs starting with "/users".

</div>
</div>
</div>
<div>
<h3 id="_logging_and_debugging_options">5.14. Logging and debugging options</h3>
<div>
<h4 id="_passengerloglevel_lt_integer_gt">5.14.1. PassengerLogLevel &lt;integer&gt;</h4>
<div>

This option allows one to specify how much information Phusion Passenger should write to the Apache error log file. A higher log level value means that more information will be logged.

</div>
<div>

Possible values are:

</div>
<div>
<ul>
	<li><em>0</em>: Show only errors and warnings.</li>
	<li><em>1</em>: Show the most important debugging information. This might be useful for system administrators who are trying to figure out the cause of a problem.</li>
	<li><em>2</em>: Show more debugging information. This is typically only useful for developers.</li>
	<li><em>3</em>: Show even more debugging information.</li>
</ul>
</div>
<div>

This option may only occur once, in the global server configuration. The default is <em>0</em>.

</div>
</div>
<div>
<h4 id="_passengerdebuglogfile_lt_filename_gt">5.14.2. PassengerDebugLogFile &lt;filename&gt;</h4>
<div>

By default Phusion Passenger debugging and error messages are written to the global web server error log. This option allows one to specify the file that debugging and error messages should be written to instead.

</div>
<div>

This option may only occur once, in the global server configuration.

</div>
</div>
</div>
<div>
<h3 id="_ruby_on_rails_specific_options">5.15. Ruby on Rails-specific options</h3>
<div>
<h4 id="_railsautodetect_lt_on_off_gt">5.15.1. RailsAutoDetect &lt;on|off&gt;</h4>
<div>

Whether Phusion Passenger should automatically detect whether a virtual host’s document root is a Ruby on Rails application. The default is <em>on</em>.

</div>
<div>

This option may occur in the global server configuration or in a virtual host configuration block.

</div>
<div>

For example, consider the following configuration:

</div>
<div>
<div>
<pre>RailsAutoDetect off
&lt;VirtualHost *:80&gt;
    ServerName www.mycook.com
    DocumentRoot /webapps/mycook/public
&lt;/VirtualHost&gt;</pre>
</div>
</div>
<div>

If one goes to <em>http://www.mycook.com/</em>, the visitor will see the contents of the <em>/webapps/mycook/public</em> folder, instead of the output of the Ruby on Rails application.

</div>
<div>

It is possible to explicitly specify that the host is a Ruby on Rails application by using the <a href="http://www.modrails.com/documentation/Users%20guide%20Apache.html#RailsBaseURI">RailsBaseURI</a> configuration option:

</div>
<div>
<div>
<pre>RailsAutoDetect off
&lt;VirtualHost *:80&gt;
    ServerName www.mycook.com
    DocumentRoot /webapps/mycook/public
    RailsBaseURI /           # This line has been added.
&lt;/VirtualHost&gt;</pre>
</div>
</div>
</div>
<div>
<h4 id="RailsBaseURI">5.15.2. RailsBaseURI &lt;uri&gt;</h4>
<div>

Used to specify that the given URI is a Rails application. See <a href="http://www.modrails.com/documentation/Users%20guide%20Apache.html#deploying_rails_to_sub_uri">Deploying Rails to a sub URI</a> for an example.

</div>
<div>

It is allowed to specify this option multiple times. Do this to deploy multiple Rails applications in different sub-URIs under the same virtual host.

</div>
<div>

This option may occur in the following places:

</div>
<div>
<ul>
	<li>In the global server configuration.</li>
	<li>In a virtual host configuration block.</li>
	<li>In a &lt;Directory&gt; or &lt;Location&gt; block.</li>
	<li>In <em>.htaccess</em>, if AllowOverride Options is on.</li>
</ul>
</div>
</div>
<div>
<h4 id="rails_env">5.15.3. RailsEnv &lt;string&gt;</h4>
<div>

This option allows one to specify the default RAILS_ENV value.

</div>
<div>

This option may occur in the following places:

</div>
<div>
<ul>
	<li>In the global server configuration.</li>
	<li>In a virtual host configuration block.</li>
	<li>In a &lt;Directory&gt; or &lt;Location&gt; block.</li>
	<li>In <em>.htaccess</em>, if AllowOverride Options is on.</li>
</ul>
</div>
<div>

In each place, it may be specified at most once. The default value is <em>production</em>.

</div>
</div>
<div>
<h4 id="_railsframeworkspawneridletime_lt_integer_gt">5.15.4. RailsFrameworkSpawnerIdleTime &lt;integer&gt;</h4>
<div>

The FrameworkSpawner server (explained in <a href="http://www.modrails.com/documentation/Users%20guide%20Apache.html#spawning_methods_explained">Spawning methods explained</a>) has an idle timeout, just like the backend processes spawned by Phusion Passenger do. That is, it will automatically shutdown if it hasn’t done anything for a given period.

</div>
<div>

This option allows you to set the FrameworkSpawner server’s idle timeout, in seconds. A value of <em>0</em> means that it should never idle timeout.

</div>
<div>

Setting a higher value will mean that the FrameworkSpawner server is kept around longer, which may slightly increase memory usage. But as long as the FrameworkSpawner server is running, the time to spawn a Ruby on Rails backend process only takes about 40% of the time that is normally needed, assuming that you’re using the <em>smart</em> <a href="http://www.modrails.com/documentation/Users%20guide%20Apache.html#PassengerSpawnMethod">spawning method</a>. So if your system has enough memory, is it recommended that you set this option to a high value or to <em>0</em>.

</div>
<div>

This option may occur in the following places:

</div>
<div>
<ul>
	<li>In the global server configuration.</li>
	<li>In a virtual host configuration block.</li>
</ul>
</div>
<div>

In each place, it may be specified at most once. The default value is <em>1800</em> (30 minutes).

</div>
</div>
<div>
<h4 id="_railsappspawneridletime_lt_integer_gt">5.15.5. RailsAppSpawnerIdleTime &lt;integer&gt;</h4>
<div>

The ApplicationSpawner server (explained in <a href="http://www.modrails.com/documentation/Users%20guide%20Apache.html#spawning_methods_explained">Spawning methods explained</a>) has an idle timeout, just like the backend processes spawned by Phusion Passenger do. That is, it will automatically shutdown if it hasn’t done anything for a given period.

</div>
<div>

This option allows you to set the ApplicationSpawner server’s idle timeout, in seconds. A value of <em>0</em> means that it should never idle timeout.

</div>
<div>

Setting a higher value will mean that the ApplicationSpawner server is kept around longer, which may slightly increase memory usage. But as long as the ApplicationSpawner server is running, the time to spawn a Ruby on Rails backend process only takes about 10% of the time that is normally needed, assuming that you’re using the <em>smart</em> or <em>smart-lv2</em> <a href="http://www.modrails.com/documentation/Users%20guide%20Apache.html#PassengerSpawnMethod">spawning method</a>. So if your system has enough memory, is it recommended that you set this option to a high value or to <em>0</em>.

</div>
<div>

This option may occur in the following places:

</div>
<div>
<ul>
	<li>In the global server configuration.</li>
	<li>In a virtual host configuration block.</li>
</ul>
</div>
<div>

In each place, it may be specified at most once. The default value is <em>600</em> (10 minutes).

</div>
</div>
</div>
<div>
<h3 id="_rack_specific_options">5.16. Rack-specific options</h3>
<div>
<h4 id="_rackautodetect_lt_on_off_gt">5.16.1. RackAutoDetect &lt;on|off&gt;</h4>
<div>

Whether Phusion Passenger should automatically detect whether a virtual host’s document root is a Rack application. The default is <em>on</em>.

</div>
<div>

This option may occur in the global server configuration or in a virtual host configuration block.

</div>
<div>

For example, consider the following configuration:

</div>
<div>
<div>
<pre>RackAutoDetect off
&lt;VirtualHost *:80&gt;
    ServerName www.rackapp.com
    DocumentRoot /webapps/my_rack_app/public
&lt;/VirtualHost&gt;</pre>
</div>
</div>
<div>

If one goes to <em>http://www.rackapp.com/</em>, the visitor will see the contents of the <em>/webapps/my_rack_app/public</em> folder, instead of the output of the Rack application.

</div>
<div>

It is possible to explicitly specify that the host is a Rack application by using the <a href="http://www.modrails.com/documentation/Users%20guide%20Apache.html#RackBaseURI">RackBaseURI</a> configuration option:

</div>
<div>
<div>
<pre>RackAutoDetect off
&lt;VirtualHost *:80&gt;
    ServerName www.rackapp.com
    DocumentRoot /webapps/my_rack_app/public
    RackBaseURI /       # This line was added
&lt;/VirtualHost&gt;</pre>
</div>
</div>
</div>
<div>
<h4 id="RackBaseURI">5.16.2. RackBaseURI &lt;uri&gt;</h4>
<div>

Used to specify that the given URI is a Rack application. See <a href="http://www.modrails.com/documentation/Users%20guide%20Apache.html#deploying_rack_to_sub_uri">Deploying Rack to a sub URI</a> for an example.

</div>
<div>

It is allowed to specify this option multiple times. Do this to deploy multiple Rack applications in different sub-URIs under the same virtual host.

</div>
<div>

This option may occur in the following places:

</div>
<div>
<ul>
	<li>In the global server configuration.</li>
	<li>In a virtual host configuration block.</li>
	<li>In a &lt;Directory&gt; or &lt;Location&gt; block.</li>
	<li>In <em>.htaccess</em>, if AllowOverride Options is on.</li>
</ul>
</div>
</div>
<div>
<h4 id="rack_env">5.16.3. RackEnv &lt;string&gt;</h4>
<div>

The given value will be accessible in Rack applications in the RACK_ENV environment variable. This allows one to define the environment in which Rack applications are run, very similar to RAILS_ENV.

</div>
<div>

This option may occur in the following places:

</div>
<div>
<ul>
	<li>In the global server configuration.</li>
	<li>In a virtual host configuration block.</li>
	<li>In a &lt;Directory&gt; or &lt;Location&gt; block.</li>
	<li>In <em>.htaccess</em>, if AllowOverride Options is on.</li>
</ul>
</div>
<div>

In each place, it may be specified at most once. The default value is <em>production</em>.

</div>
</div>
</div>
<div>
<h3 id="_deprecated_options">5.17. Deprecated options</h3>
<div>

The following options have been deprecated, but are still supported for backwards compatibility reasons.

</div>
<div>
<h4 id="_railsruby">5.17.1. RailsRuby</h4>
<div>

Deprecated in favor of <a href="http://www.modrails.com/documentation/Users%20guide%20Apache.html#PassengerRuby">PassengerRuby</a>.

</div>
</div>
<div>
<h4 id="_railsuserswitching">5.17.2. RailsUserSwitching</h4>
<div>

Deprecated in favor of <a href="http://www.modrails.com/documentation/Users%20guide%20Apache.html#PassengerUserSwitching">PassengerUserSwitching</a>.

</div>
</div>
<div>
<h4 id="_railsdefaultuser">5.17.3. RailsDefaultUser</h4>
<div>

Deprecated in favor of <a href="http://www.modrails.com/documentation/Users%20guide%20Apache.html#PassengerDefaultUser">PassengerDefaultUser</a>.

</div>
</div>
<div>
<h4 id="_railsallowmodrewrite">5.17.4. RailsAllowModRewrite</h4>
<div>

This option doesn’t do anything anymore in recent versions of Phusion Passenger.

</div>
</div>
<div>
<h4 id="_railsspawnmethod">5.17.5. RailsSpawnMethod</h4>
<div>

Deprecated in favor of <a href="http://www.modrails.com/documentation/Users%20guide%20Apache.html#PassengerSpawnMethod">PassengerSpawnMethod</a>.

</div>
</div>
</div>
</div>
</div>
<div>
<h2 id="_troubleshooting">6. Troubleshooting</h2>
<div>
<div>
<h3 id="_operating_system_specific_problems">6.1. Operating system-specific problems</h3>
<div>
<h4 id="_macos_x_the_installer_cannot_locate_mamp_8217_s_apache">6.1.1. MacOS X: The installer cannot locate MAMP’s Apache</h4>
<div>
<div>
<div>Symptoms</div>
<div>

The installer finds Apache 2 development headers at /Applications/MAMP/Library/bin/apxs. However, Apache cannot be found. The installer also outputs the following error:

</div>
<div>
<div>
<pre>cannot open /Applications/MAMP/Library/build/config_vars.mk:
No such file or directory at /Applications/MAMP/Library/bin/apxs line 218.</pre>
</div>
</div>
</div>
</div>
<div>

Your MAMP installation seems to be broken. In particular, <em>config_vars.mk</em> is missing. Please read <a href="http://forum.mamp.info/viewtopic.php?t=1866">this forum topic</a> to learn how to fix this problem.

</div>
<div>

See also <a href="http://code.google.com/p/phusion-passenger/issues/detail?id=12">this bug report</a>.

</div>
</div>
</div>
<div>
<h3 id="_problems_during_installation">6.2. Problems during installation</h3>
<div>
<h4 id="installing_ruby_dev">6.2.1. Ruby development headers aren’t installed</h4>
<div>
<div>
<div>Symptoms</div>
<div>

Installing Phusion Passenger fails because of one of the following errors:

</div>
<div>
<ul>
	<li>The Phusion Passenger installer tells you that the Ruby development headers aren’t installed.</li>
	<li>The error message “'no such file to load — mkmf”' occurs.</li>
	<li>The error message “'ruby.h: No such file or directory”' occurs.</li>
</ul>
</div>
</div>
</div>
<div>

Phusion Passenger makes use of a native extension, so the Ruby development headers must be installed. On most Linux systems, Ruby and the Ruby development headers are contained in separate packages, so having Ruby installed does not automatically imply having the development headers installed.

</div>
<div>

Here’s how you can install the development headers:

</div>
<div><dl><dt>Ubuntu/Debian</dt><dd>Please type:
<div>
<div>
<pre>sudo apt-get install ruby1.8-dev</pre>
</div>
</div>
</dd><dt>Fedora/CentOS/RHEL</dt><dd>Please type:
<div>
<div>
<pre>su -c 'yum install ruby-devel'</pre>
</div>
</div>
</dd><dt>FreeBSD</dt><dd>Please install Ruby from <em>ports</em> or with pkg_add. If that fails, please install Ruby from source.

</dd><dt>MacOS X</dt><dd>Please install Ruby from source.

</dd><dt>Other operating systems</dt><dd>Please consult your operating system’s native package database. There should be a package containing the Ruby development headers. If that fails, please install Ruby from source.

</dd></dl></div>
<div>
<table>
<tbody>
<tr>
<td><img src="http://www.modrails.com/documentation/images/icons/note.png" alt="Note" /></td>
<td>If you’ve installed a new Ruby version (i.e. your system now contains multiple Ruby installations), then you will need to tell Phusion Passenger which Ruby installation you want to use. Please read <a href="http://www.modrails.com/documentation/Users%20guide%20Apache.html#specifying_ruby_installation">Specifying the correct Ruby installation</a>.</td>
</tr>
</tbody>
</table>
</div>
</div>
<div>
<h4 id="_apache_development_headers_aren_8217_t_installed">6.2.2. Apache development headers aren’t installed</h4>
<div>
<div>
<div>Symptoms</div>
<div>

Installing Phusion Passenger fails because of one of the following errors:

</div>
<div>
<ul>
	<li>The installer says that the Apache development headers aren’t installed.</li>
	<li>The error message “'httpd.h: No such file or directory”' occurs.
<div>

(Instead of <em>httpd.h</em>, the message might also be <em>http_config.h</em> or something else similar to <em>http_*.h</em>.)

</div></li>
</ul>
</div>
</div>
</div>
<div><dl><dt>Ubuntu</dt><dd>Please type:
<div>
<div>
<pre>sudo apt-get install apache2-prefork-dev</pre>
</div>
</div>
</dd><dt>Debian</dt><dd>Please type:
<div>
<div>
<pre>sudo apt-get install apache2-dev</pre>
</div>
</div>
</dd><dt>Fedora/CentOS/RHEL</dt><dd>Please type:
<div>
<div>
<pre>su -c 'yum install httpd-devel'</pre>
</div>
</div>
</dd><dt>FreeBSD</dt><dd>Please install Apache from <em>ports</em> or with pkg_add. If that fails, please install Apache from source.

</dd><dt>MacOS X</dt><dd>Please install Apache from source.

</dd><dt>Other operating systems</dt><dd>Please consult your operating system’s native package database. There should be a package containing the Apache development headers. If that fails, please install Apache from source.

</dd></dl></div>
</div>
<div>
<h4 id="_apr_development_headers_aren_8217_t_installed">6.2.3. APR development headers aren’t installed</h4>
<div>
<div>
<div>Symptoms</div>
<div>

Installing Phusion Passenger fails because one of the following errors:

</div>
<div>
<ul>
	<li>The installer tells you that APR development headers aren’t installed.</li>
	<li>The error message “'apr_pools.h: No such file or directory”' occurs.</li>
	<li>The error message “'apr_strings.h: No such file or directory”' occurs.</li>
</ul>
</div>
</div>
</div>
<div><dl><dt>Ubuntu</dt><dd>Please type:
<div>
<div>
<pre>sudo apt-get install libapr1-dev</pre>
</div>
</div>
</dd><dt>Debian</dt><dd>Please type:
<div>
<div>
<pre>sudo apt-get install libapr1-dev</pre>
</div>
</div>
</dd><dt>Fedora/CentOS/RHEL</dt><dd>Please type:
<div>
<div>
<pre>su -c 'yum install apr-devel'</pre>
</div>
</div>
</dd><dt>Other Linux distributions</dt><dd>Please consult your distribution’s package database. There should be a package which provides APR development headers.

</dd><dt>Other operating systems</dt><dd>The APR development are bundled with Apache. If the APR headers aren’t, then it probably means that they have been removed after Apache’s been installed. Please reinstall Apache to get back the APR headers.

</dd></dl></div>
</div>
<div>
<h4 id="_phusion_passenger_is_using_the_wrong_apache_during_installation">6.2.4. Phusion Passenger is using the wrong Apache during installation</h4>
<div>

Please <a href="http://www.modrails.com/documentation/Users%20guide%20Apache.html#specifying_correct_apache_install">Specifying the correct Apache installation</a>, and re-run the Phusion Passenger installer.

</div>
</div>
<div>
<h4 id="_phusion_passenger_is_using_the_wrong_ruby_during_installation">6.2.5. Phusion Passenger is using the wrong Ruby during installation</h4>
<div>

Please <a href="http://www.modrails.com/documentation/Users%20guide%20Apache.html#specifying_ruby_installation">Specifying the correct Ruby installation</a>, and re-run the Phusion Passenger installer.

</div>
</div>
</div>
<div>
<h3 id="_problems_after_installation">6.3. Problems after installation</h3>
<div>
<table>
<tbody>
<tr>
<td><img src="http://www.modrails.com/documentation/images/icons/tip.png" alt="Tip" /></td>
<td>
<div>The golden tip: read your Apache error logs!</div>
<div>

<em>mod_passenger</em> will write all errors to the Apache error log. So if you’re experiencing post-installation problems, please look inside the Apache error logs. It will tell you what exactly went wrong.

</div></td>
</tr>
</tbody>
</table>
</div>
<div>
<h4 id="_my_rails_application_works_on_mongrel_but_not_on_phusion_passenger">6.3.1. My Rails application works on Mongrel, but not on Phusion Passenger</h4>
<div>

Please try setting <a href="http://www.modrails.com/documentation/Users%20guide%20Apache.html#PassengerSpawnMethod">PassengerSpawnMethod</a> to <em>conservative</em>.

</div>
</div>
<div>
<h4 id="_phusion_passenger_has_been_compiled_against_the_wrong_apache_installation">6.3.2. Phusion Passenger has been compiled against the wrong Apache installation</h4>
<div>
<div>
<div>Symptoms</div>
<div>

Apache crashes during startup (after being daemonized). The Apache error log says “'seg fault or similar nasty error detected in the parent process”'.

</div>
</div>
</div>
<div>

This problem is most likely to occur on MacOS X. Most OS X users have multiple Apache installations on their system.

</div>
<div>

To solve this problem, please <a href="http://www.modrails.com/documentation/Users%20guide%20Apache.html#specifying_correct_apache_install">specify the correct Apache installation</a>, and <a href="http://www.modrails.com/documentation/Users%20guide%20Apache.html#install_passenger">reinstall Phusion Passenger</a>.

</div>
</div>
<div>
<h4 id="_i_get_a_403_forbidden_error">6.3.3. I get a "403 Forbidden" error</h4>
<div>

See next subsection.

</div>
</div>
<div>
<h4 id="_static_assets_such_as_images_and_stylesheets_aren_8217_t_being_displayed">6.3.4. Static assets such as images and stylesheets aren’t being displayed</h4>
<div>

Static assets are accelerated, i.e. they are served directly by Apache and do not go through the Rails stack. There are two reasons why Apache doesn’t serve static assets correctly:

</div>
<div>
<ol>
	<li>Your Apache configuration is too strict, and does not allow HTTP clients to access static assets. This can be achieved with an Allow from all directive in the correct place. For example:
<div>
<div>
<pre>&lt;Directory "/webapps/mycook/public"&gt;
   Options FollowSymLinks
   AllowOverride None
   Order allow,deny
   Allow from all
&lt;/Directory&gt;</pre>
</div>
</div>
<div>

See also <a href="http://groups.google.com/group/phusion-passenger/browse_thread/thread/9699a639a87f85f4/b9d71a03bf2670a5">this discussion</a>.

</div></li>
	<li>The Apache process doesn’t have permission to access your Rails application’s folder. Please make sure that the Rails application’s folder, as well as all of its parent folders, have the correct permissions and/or ownerships.</li>
</ol>
</div>
</div>
<div>
<h4 id="_the_apache_error_log_says_that_the_spawn_manager_script_does_not_exist_or_that_it_does_not_have_permission_to_execute_it">6.3.5. The Apache error log says that the spawn manager script does not exist, or that it does not have permission to execute it</h4>
<div>

If you are sure that the <em>PassengerRoot</em> configuration option is set correctly, then this problem is most likely caused by the fact that you’re running Apache with SELinux. On Fedora, CentOS and RedHat Enterprise Linux, Apache is locked down by SELinux policies.

</div>
<div>

To solve this problem, you must set some permissions on the Phusion Passenger files and folders, so that Apache can access them.

</div>
<div>
<ul>
	<li>If you’ve installed Phusion Passenger via a gem, then run this command to determine Phusion Passenger’s root folder:
<div>
<div>
<pre>passenger-config --root</pre>
</div>
</div>
<div>

Next, run the following command:

</div>
<div>
<div>
<pre>chcon -R -h -t httpd_sys_content_t /path-to-passenger-root</pre>
</div>
</div>
<div>

where <em>/path-to-passenger-root</em> should be replaced with whatever passenger-config --root printed.

</div></li>
	<li>If you’ve installed Phusion Passenger via the source tarball, then run the following command:
<div>
<div>
<pre>chcon -R -h -t httpd_sys_content_t /path/to/passenger/folder</pre>
</div>
</div></li>
</ul>
</div>
<div>

Once the permissions are fixed, restart Apache.

</div>
</div>
<div>
<h4 id="_the_rails_application_reports_that_it_8217_s_unable_to_start_because_of_a_permission_error">6.3.6. The Rails application reports that it’s unable to start because of a permission error</h4>
<div>

Please check whether your Rails application’s folder has the correct permissions. By default, Rails applications are started as the owner of the file <em>config/environment.rb</em>, except if the file is owned by root. If the file is owned by root, then the Rails application will be started as <em>nobody</em> (or as the user specify by <a href="http://www.modrails.com/documentation/Users%20guide%20Apache.html#RailsDefaultUser">RailsDefaultUser</a>, if that’s specified).

</div>
<div>

Please read <a href="http://www.modrails.com/documentation/Users%20guide%20Apache.html#user_switching">User switching (security)</a> for details.

</div>
</div>
<div>
<h4 id="_my_rails_application_8217_s_log_file_is_not_being_written_to">6.3.7. My Rails application’s log file is not being written to</h4>
<div>

There are a couple things that you should be aware of:

</div>
<div>
<ul>
	<li>By default, Phusion Passenger runs Rails applications in <em>production</em> mode, so please be sure to check <em>production.log</em> instead of <em>development.log</em>. See <a href="http://www.modrails.com/documentation/Users%20guide%20Apache.html#RailsEnv">RailsEnv</a> for configuration.</li>
	<li>By default, Phusion Passenger runs Rails applications as the owner of <em>environment.rb</em>. So the log file can only be written to if that user has write permission to the log file. Please <em>chmod</em> or <em>chown</em> your log file accordingly.
<div>

See <a href="http://www.modrails.com/documentation/Users%20guide%20Apache.html#User_switching">User switching (security)</a> for details.

</div></li>
</ul>
</div>
<div>

If you’re using a RedHat-derived Linux distribution (such as Fedora or CentOS) then it is <a href="http://code.google.com/p/phusion-passenger/issues/detail?id=4">possible that SELinux is interfering</a>. RedHat’s SELinux policy only allows Apache to read/write directories that have the <em>httpd_sys_content_t</em> security context. Please run the following command to give your Rails application folder that context:

</div>
<div>
<div>
<pre>chcon -R -h -t httpd_sys_content_t /path/to/your/rails/app</pre>
</div>
</div>
</div>
<div>
<h4 id="_i_8217_ve_deployed_my_app_on_ssl_but_the_app_thinks_its_not_on_ssl">6.3.8. I’ve deployed my app on SSL, but the app thinks its not on SSL</h4>
<div>

Rails and many other frameworks infers whether it’s running on SSL through the CGI environment variable HTTPS. Apache always sets this variable when on SSL, except when SSL is incorrectly configured.

</div>
<div>

Most Apache installations already configure SSL by default on port 443 (conf/extra/httpd-ssl.conf). Some people think they can save some typing in subsequent SSL vhost blocks, and omit important options like <em>SSLEngine on</em>, like this:

</div>
<div>
<div>
<pre># httpd-ssl.conf contains something like:
# &lt;VirtualHost _default_:443&gt;
#     SSLEngine on
#     ...
# &lt;/VirtualHost&gt;
Include conf/extra/httpd-ssl.conf

&lt;VirtualHost *:443&gt;
    ServerName www.example.com
    DocumentRoot /webapps/example/public
&lt;/Virtualhost&gt;</pre>
</div>
</div>
<div>

<strong>This is wrong!</strong> In each SSL vhost block you must re-specify all the SSL options. Otherwise Apache won’t properly detect the vhost as an SSL vhost block. Here’s the corrected example:

</div>
<div>
<div>
<pre>Include conf/extra/httpd-ssl.conf

&lt;VirtualHost *:443&gt;
    ServerName www.example.com
    DocumentRoot /webapps/example/public
    SSLEngine on
    ...more SSL options here...
&lt;/Virtualhost&gt;</pre>
</div>
</div>
</div>
</div>
<div>
<h3 id="conflicting_apache_modules">6.4. Conflicting Apache modules</h3>
<div>
<h4 id="_mod_userdir">6.4.1. mod_userdir</h4>
<div>

<em>mod_userdir</em> is not compatible with Phusion Passenger at the moment.

</div>
</div>
<div>
<h4 id="_multiviews_mod_negotiation">6.4.2. MultiViews (mod_negotiation)</h4>
<div>

MultiViews is not compatible with Phusion Passenger. You should disable MultiViews for all Phusion Passenger hosts.

</div>
</div>
<div>
<h4 id="_virtualdocumentroot">6.4.3. VirtualDocumentRoot</h4>
<div>

VirtualDocumentRoot is not compatible with Phusion Passenger at the moment.

</div>
</div>
</div>
</div>
</div>
<div>
<h2 id="_analysis_and_system_maintenance">7. Analysis and system maintenance</h2>
<div>
<div>

Phusion Passenger provides a set of tools, which are useful for system analysis, maintenance and troubleshooting.

</div>
<div>
<h3 id="_inspecting_memory_usage">7.1. Inspecting memory usage</h3>
<div>

Process inspection tools such as ps and top are useful, but they <a href="http://groups.google.com/group/phusion-passenger/msg/1fd1c233456d3180">rarely show the correct memory usage</a>. The real memory usage is usually lower than what ps and top report.

</div>
<div>

There are many technical reasons why this is so, but an explanation is beyond the scope of this Users Guide. We kindly refer the interested reader to operating systems literature about <em>virtual memory</em> and <em>copy-on-write</em>.

</div>
<div>

The tool passenger-memory-stats allows one to easily analyze Phusion Passenger’s and Apache’s real memory usage. For example:

</div>
<div>
<div>
<pre>[bash@localhost root]# passenger-memory-stats
------------- Apache processes --------------.
PID    PPID  Threads  VMSize   Private  Name
---------------------------------------------.
5947   1     9        90.6 MB  0.5 MB   /usr/sbin/apache2 -k start
5948   5947  1        18.9 MB  0.7 MB   /usr/sbin/fcgi-pm -k start
6029   5947  1        42.7 MB  0.5 MB   /usr/sbin/apache2 -k start
6030   5947  1        42.7 MB  0.5 MB   /usr/sbin/apache2 -k start
6031   5947  1        42.5 MB  0.3 MB   /usr/sbin/apache2 -k start
6033   5947  1        42.5 MB  0.4 MB   /usr/sbin/apache2 -k start
6034   5947  1        50.5 MB  0.4 MB   /usr/sbin/apache2 -k start
23482  5947  1        82.6 MB  0.4 MB   /usr/sbin/apache2 -k start
### Processes: 8
### Total private dirty RSS: 3.50 MB

--------- Passenger processes ---------.
PID    Threads  VMSize   Private  Name
---------------------------------------.
6026   1        10.9 MB  4.7 MB   Passenger spawn server
23481  1        26.7 MB  3.0 MB   Passenger FrameworkSpawner: 2.0.2
23791  1        26.8 MB  2.9 MB   Passenger ApplicationSpawner: /var/www/projects/app1-foobar
23793  1        26.9 MB  17.1 MB  Rails: /var/www/projects/app1-foobar
### Processes: 4
### Total private dirty RSS: 27.76 M</pre>
</div>
</div>
<div>

The <em>Private</em> or <em>private dirty RSS</em> field shows the <strong>real</strong> memory usage of processes. Here, we see that all the Apache worker processes only take less than 1 MB memory each. This is a lot less than the 50 MB-ish memory usage as shown in the <em>VMSize</em> column (which is what a lot of people think is the real memory usage, but is actually not).

</div>
<div>
<table>
<tbody>
<tr>
<td><img src="http://www.modrails.com/documentation/images/icons/note.png" alt="Note" /></td>
<td>Private dirty RSS reporting only works on Linux. Unfortunately other operating systems don’t provide facilities for determining processes' private dirty RSS. On non-Linux systems, the Resident Set Size is reported instead.</td>
</tr>
</tbody>
</table>
</div>
</div>
<div>
<h3 id="_inspecting_phusion_passenger_8217_s_internal_status">7.2. Inspecting Phusion Passenger’s internal status</h3>
<div>

One can inspect Phusion Passenger’s internal status with the tool passenger-status. This tool must typically be run as root. For example:

</div>
<div>
<div>
<pre>[bash@localhost root]# passenger-status
----------- General information -----------
max      = 6
count    = 1
active   = 0
inactive = 1

----------- Domains -----------
/var/www/projects/app1-foobar:
  PID: 9617      Sessions: 0    Processed: 7       Uptime: 2m 23s</pre>
</div>
</div>
<div>

The <em>general information</em> section shows the following information:

</div>
<div><dl><dt>max</dt><dd>The maximum number of application instances that Phusion Passenger will spawn. This equals the value given for <a href="http://www.modrails.com/documentation/Users%20guide%20Apache.html#PassengerMaxPoolSize">PassengerMaxPoolSize</a> (Apache) or <a href="http://www.modrails.com/documentation/Users%20guide%20Apache.html#PassengerMaxPoolSize">passenger_max_pool_size</a> (Nginx).

</dd><dt>count</dt><dd>The number of application instances that are currently alive. This value is always less than or equal to <em>max</em>.

</dd><dt>active</dt><dd>The number of application instances that are currently processing requests. This value is always less than or equal to <em>count</em>.

</dd><dt>inactive</dt><dd>The number of application instances that are currently <strong>not</strong> processing requests, i.e. are idle. Idle application instances will be shutdown after a while, as can be specified with <a href="http://www.modrails.com/documentation/Users%20guide%20Apache.html#PassengerPoolIdleTime">PassengerPoolIdleTime (Apache)</a>/<a href="http://www.modrails.com/documentation/Users%20guide%20Apache.html#PassengerPoolIdleTime">passenger_pool_idle_time (Nginx)</a> (unless this value is set to 0, in which case application instances are never shut down via idle time). The value of <em>inactive</em> equals count - active.

</dd></dl></div>
<div>

The <em>domains</em> section shows, for each application directory, information about running application instances:

</div>
<div><dl><dt>Sessions</dt><dd>Shows how many HTTP client are currently in the queue of that application Instance, waiting to be processed.

</dd><dt>Processed</dt><dd>Indicates how many requests the instance has served until now. <strong>Tip:</strong> it’s possible to limit this number with the <a href="http://www.modrails.com/documentation/Users%20guide%20Apache.html#PassengerMaxRequests">PassengerMaxRequests</a> configuration directive.

</dd><dt>Uptime</dt><dd>Shows for how long the application instance has been running.

</dd></dl></div>
<div>

Since Phusion Passenger uses fair load balancing by default, the number of sessions for the application instances should be fairly close to each other. For example, this is fairly normal:

</div>
<div>
<div>
<pre>  PID: 4281      Sessions: 2      Processed: 7      Uptime: 5m 11s
  PID: 4268      Sessions: 0      Processed: 5      Uptime: 4m 52s
  PID: 4265      Sessions: 1      Processed: 6      Uptime: 5m 38s
  PID: 4275      Sessions: 1      Processed: 7      Uptime: 3m 14s</pre>
</div>
</div>
<div>

But if you see a "spike", i.e. an application instance has an unusually high number of sessions compared to the others, then there might be a problem:

</div>
<div>
<div>
<pre>  PID: 4281      Sessions: 2      Processed: 7      Uptime: 5m 11s
  PID: 17468     Sessions: 8 &lt;-+  Processed: 2      Uptime: 4m 47s
  PID: 4265      Sessions: 1   |  Processed: 6      Uptime: 5m 38s
  PID: 4275      Sessions: 1   |  Processed: 7      Uptime: 3m 14s
                               |
                               +---- "spike"</pre>
</div>
</div>
<div>

Possible reasons why spikes can occur:

</div>
<div>
<ol>
	<li>Your application is busy processing a request that takes a very long time. If this is the case, then you might want to turn <a href="http://www.modrails.com/documentation/Users%20guide%20Apache.html#PassengerUseGlobalQueue">global queuing</a> on.</li>
	<li>Your application is frozen, i.e. has stopped responding. See <a href="http://www.modrails.com/documentation/Users%20guide%20Apache.html#debugging_frozen">Debugging frozen applications</a> for tips.</li>
</ol>
</div>
</div>
<div>
<h3 id="debugging_frozen">7.3. Debugging frozen applications</h3>
<div>

If one of your application instances is frozen (stopped responding), then you can figure out where it is frozen by killing it with <em>SIGABRT</em>. This will cause the application to raise an exception, with a backtrace.

</div>
<div>

The exception (with full backtrace information) is normally logged into the Apache error log. But if your application or if its web framework has its own exception logging routines, then exceptions might be logged into the application’s log files instead. This is the case with Ruby on Rails. So if you kill a Ruby on Rails application with <em>SIGABRT</em>, please check the application’s <em>production.log</em> first (assuming that you’re running it in a <em>production</em> environment). If you don’t see a backtrace there, check the Apache error log.

</div>
<div>
<table>
<tbody>
<tr>
<td><img src="http://www.modrails.com/documentation/images/icons/note.png" alt="Note" /></td>
<td>It is safe to kill application instances, even in live environments. Phusion Passenger will restart killed application instances, as if nothing bad happened.</td>
</tr>
</tbody>
</table>
</div>
</div>
<div>
<h3 id="_accessing_individual_application_processes">7.4. Accessing individual application processes</h3>
<div>

When a request is sent to the web server, Phusion Passenger will automatically forward the request to the most suitable application process, but sometimes it is desirable to be able to directly access the individual application processes. Use cases include, but are not limited to:

</div>
<div>
<ul>
	<li>One wants to debug a memory leak or memory bloat problem that only seems to appear on certain URIs. One can send a request to a specific process to see whether that request causes the process’s memory usage to rise.</li>
	<li>The application caches data in local memory, and one wants to tell a specific application process to clear that local data.</li>
	<li>Other debugging use cases.</li>
</ul>
</div>
<div>

All individual application processes are accessible via HTTP, so you can use standard HTTP tools like <em>curl</em>. The exact addresses can be obtained with the command passenger-status --verbose. These sockets are all bound to 127.0.0.1, but the port number is dynamically assigned. As a security measure, the sockets are also protected with a process-specific random password, which you can see in the passenger-status --verbose output. This password must be sent through the “X-Passenger-Connect-Password” HTTP header.

</div>
<div>

Example:

</div>
<div>
<div>
<pre>bash# passenger-status --verbose
----------- General information -----------
max      = 6
count    = 2
active   = 0
inactive = 2
Waiting on global queue: 0

----------- Application groups -----------
/Users/hongli/Sites/rack.test:
  App root: /Users/hongli/Sites/rack.test
  * PID: 24235   Sessions: 0    Processed: 7       Uptime: 17s
      URL     : http://127.0.0.1:58122
      Password: nFfVOX1F8LjZ90HJh28Sd_htJOsgRsNne2QXKf8NIXw
  * PID: 24250   Sessions: 0    Processed: 4       Uptime: 1s
      URL     : http://127.0.0.1:57933
      Password: _RGXlQ9EGDGJKLevQ_qflUtF1KmxEo2UiRzMwIE1sBY</pre>
</div>
</div>
<div>

Here we see that the web application <em>rack.test</em> has two processes. Process 24235 is accessible via <a href="http://127.0.0.1:58122/">http://127.0.0.1:58122</a>, and process 24250 is accessible via <a href="http://127.0.0.1:57933/">http://127.0.0.1:57933</a>.

</div>
<div>

To access 24235 we must send its password, <em>nFfVOX1F8LjZ90HJh28Sd_htJOsgRsNne2QXKf8NIXw</em>, through the <em>X-Passenger-Connect-Password</em> HTTP header, like this:

</div>
<div>
<div>
<pre>bash# curl -H "X-Passenger-Connect-Password: nFfVOX1F8LjZ90HJh28Sd_htJOsgRsNne2QXKf8NIXw" http://127.0.0.1:58122/</pre>
</div>
</div>
</div>
</div>
</div>
<div>
<h2 id="_tips">8. Tips</h2>
<div>
<div>
<h3 id="user_switching">8.1. User switching (security)</h3>
<div>

There is a problem that plagues most PHP web hosts, namely the fact that all PHP applications are run in the same user context as the web server. So for example, Joe’s PHP application will be able to read Jane’s PHP application’s passwords. This is obviously undesirable on many servers.

</div>
<div>

Phusion Passenger solves this problem by implementing <em>user switching</em>. A Rails application is started as the owner of the file <em>config/environment.rb</em>, and a Rack application is started as the owner of the file <em>config.ru</em>. So if <em>/home/webapps/foo/config/environment.rb</em> is owned by <em>joe</em>, then Phusion Passenger will launch the corresponding Rails application as <em>joe</em> as well.

</div>
<div>

This behavior is the default, and you don’t need to configure anything. But there are things that you should keep in mind:

</div>
<div>
<ul>
	<li>The owner of <em>environment.rb</em>/<em>config.ru</em> must have read access to the application’s root directory, and read/write access to the application’s <em>logs</em> directory.</li>
	<li>This feature is only available if Apache is started by <em>root</em>. This is the case on most Apache installations.</li>
	<li>Under no circumstances will applications be run as <em>root</em>. If <em>environment.rb</em>/<em>config.ru</em> is owned as root or by an unknown user, then the Rails/Rack application will run as the user specified by <a href="http://www.modrails.com/documentation/Users%20guide%20Apache.html#PassengerDefaultUser">PassengerDefaultUser</a> and <a href="http://www.modrails.com/documentation/Users%20guide%20Apache.html#PassengerDefaultGroup">PassengerDefaultGroup</a>.</li>
</ul>
</div>
<div>

User switching can be disabled with the <a href="http://www.modrails.com/documentation/Users%20guide%20Apache.html#PassengerUserSwitching">PassengerUserSwitching</a> option.

</div>
</div>
<div>
<h3 id="reducing_memory_usage">8.2. Reducing memory consumption of Ruby on Rails applications by 33%</h3>
<div>

Is it possible to reduce memory consumption of your Rails applications by 33% on average, by using <a href="http://www.rubyenterpriseedition.com/">Ruby Enterprise Edition</a>. Please visit the website for details.

</div>
<div>

Note that this feature does not apply to Rack applications.

</div>
</div>
<div>
<h3 id="capistrano">8.3. Capistrano recipe</h3>
<div>

Phusion Passenger can be combined with <a href="http://capify.org/">Capistrano</a>. The following Capistrano recipe demonstrates Phusion Passenger support. It assumes that you’re using Git as version control system.

</div>
<div>
<div>
<pre>set :application, "myapp"
set :domain,      "example.com"
set :repository,  "ssh://#{domain}/path-to-your-git-repo/#{application}.git"
set :use_sudo,    false
set :deploy_to,   "/path-to-your-web-app-directory/#{application}"
set :scm,         "git"

role :app, domain
role :web, domain
role :db,  domain, :primary =&gt; true

namespace :deploy do
  task :start, :roles =&gt; :app do
    run "touch #{current_release}/tmp/restart.txt"
  end

  task :stop, :roles =&gt; :app do
    # Do nothing.
  end

  desc "Restart Application"
  task :restart, :roles =&gt; :app do
    run "touch #{current_release}/tmp/restart.txt"
  end
end</pre>
</div>
</div>
</div>
<div>
<h3 id="bundler_support">8.4. Bundler support</h3>
<div>

Phusion Passenger has automatic support for <a href="http://gembundler.com/git.html">Bundler</a>. It works as follows:

</div>
<div>
<ul>
	<li>If you have a <em>.bundle/environment.rb</em> in your application root, then Phusion Passenger will require that file before loading your application.</li>
	<li>Otherwise, if you have a <em>Gemfile</em>, then Phusion Passenger will automatically call Bundler.setup() before loading your application.</li>
</ul>
</div>
<div>

It’s possible that your application also calls Bundler.setup during loading, e.g. in <em>config.ru</em> or in <em>config/boot.rb</em>. This is the case with Rails 3, and is also the case if you modified your <em>config/boot.rb</em> according to the <a href="http://gembundler.com/rails23.html">Bundler Rails 2.3 instructions</a>. This leads to Bundler.setup being called twice, once before the application startup file is required and once during application startup. However this is harmless and doesn’t have any negative effects.

</div>
<div>

Phusion Passenger assumes that you’re using Bundler &gt;= 0.9.5. If you don’t want Phusion Passenger to run its Bundler support code, e.g. because you need to use an older version of Bundler with an incompatible API or because you use a system other than Bundler, then you can override Phusion Passenger’s Bundler support code by creating a file <em>config/setup_load_paths.rb</em>. If this file exists then it will be required before loading the application startup file. In this file you can do whatever you need to setup Bundler or a similar system.

</div>
</div>
<div>
<h3 id="moving_phusion_passenger">8.5. Moving Phusion Passenger to a different directory</h3>
<div>

It is possible to relocate the Phusion Passenger files to a different directory. It involves two steps:

</div>
<div>
<ol>
	<li>Moving the directory.</li>
	<li>Updating the “PassengerRoot” configuration option in Apache.</li>
</ol>
</div>
<div>

For example, if Phusion Passenger is located in <em>/opt/passenger/</em>, and you’d like to move it to <em>/usr/local/passenger/</em>, then do this:

</div>
<div>
<ol>
	<li>Run the following command:
<div>
<div>
<pre>mv /opt/passenger /usr/local/passenger</pre>
</div>
</div></li>
	<li>Edit your Apache configuration file, and set:
<div>
<div>
<pre>PassengerRoot /usr/local/passenger</pre>
</div>
</div></li>
</ol>
</div>
</div>
<div>
<h3 id="_installing_multiple_ruby_on_rails_versions">8.6. Installing multiple Ruby on Rails versions</h3>
<div>

Each Ruby on Rails applications that are going to be deployed may require a specific Ruby on Rails version. You can install a specific version with this command:

</div>
<div>
<div>
<pre>gem install rails -v X.X.X</pre>
</div>
</div>
<div>

where <em>X.X.X</em> is the version number of Ruby on Rails.

</div>
<div>

All of these versions will exist in parallel, and will not conflict with each other. Phusion Passenger will automatically make use of the correct version.

</div>
</div>
<div>
<h3 id="_making_the_application_restart_after_each_request">8.7. Making the application restart after each request</h3>
<div>

In some situations it might be desirable to restart the web application after each request, for example when developing a non-Rails application that doesn’t support code reloading, or when developing a web framework.

</div>
<div>

To achieve this, simply create the file <em>tmp/always_restart.txt</em> in your application’s root folder. Unlike <em>restart.txt</em>, Phusion Passenger does not check for this file’s timestamp: Phusion Passenger will always restart the application, as long as <em>always_restart.txt</em> exists.

</div>
<div>
<table>
<tbody>
<tr>
<td><img src="http://www.modrails.com/documentation/images/icons/note.png" alt="Note" /></td>
<td>If you’re just developing a Rails application then you probably don’t need this feature. If you set <em>RailsEnv development</em> in your Apache configuration, then Rails will automatically reload your application code after each request. <em>always_restart.txt</em> is only useful if you’re working on Ruby on Rails itself, or when you’re not developing a Rails application and your web framework does not support code reloading.</td>
</tr>
</tbody>
</table>
</div>
</div>
<div>
<h3 id="sub_uri_deployment_uri_fix">8.8. How to fix broken images/CSS/JavaScript URIs in sub-URI deployments</h3>
<div>

Some people experience broken images and other broken static assets when they deploy their application to a sub-URI (i.e. <em>http://mysite.com/railsapp/</em>). The reason for this usually is that you used a static URI for your image in the views. This means your <em>img</em> source probably refers to something like <em>/images/foo.jpg</em>. The leading slash means that it’s an absolute URI: you’re telling the browser to always load <em>http://mysite.com/images/foo.jpg</em> no matter what. The problem is that the image is actually at <em>http://mysite.com/railsapp/images/foo.jpg</em>. There are two ways to fix this.

</div>
<div>

The first way (not recommended) is to change your view templates to refer to <em>images/foo.jpg</em>. This is a relative URI: note the lack of a leading slash). What this does is making the path relative to the current URI. The problem is that if you use restful URIs, then your images will probably break again when you add a level to the URI. For example, when you’re at <em>http://mysite.com/railsapp</em> the browser will look for <em>http://mysite.com/railsapp/images/foo.jpg</em>. But when you’re at <em>http://mysite.com/railsapp/controller</em>. the browser will look for <em>http://mysite.com/railsapp/controller/images/foo.jpg</em>. So relative URIs usually don’t work well with layout templates.

</div>
<div>

The second and highly recommended way is to always use Rails helper methods to output tags for static assets. These helper methods automatically take care of prepending the base URI that you’ve deployed the application to. For images there is image_tag, for JavaScript there is javascript_include_tag and for CSS there is stylesheet_link_tag. In the above example you would simply remove the <em>&lt;img&gt;</em> HTML tag and replace it with inline Ruby like this:

</div>
<div>
<div>
<pre>&lt;%= image_tag("foo.jpg") %&gt;</pre>
</div>
</div>
<div>

This will generate the proper image tag to $RAILS_ROOT/public/images/foo.jpg so that your images will always work no matter what sub-URI you’ve deployed to.

</div>
<div>

These helper methods are more valuable than you may think. For example they also append a timestamp to the URI to better facilitate HTTP caching. For more information, please refer to <a href="http://api.rubyonrails.org/classes/ActionView/Helpers/AssetTagHelper.html">the Rails API docs</a>.

</div>
</div>
<div>
<h3 id="_x_sendfile_support">8.9. X-Sendfile support</h3>
<div>

Phusion Passenger does not provide X-Sendfile support by itself. Please install <a href="http://tn123.ath.cx/mod_xsendfile/">mod_xsendfile</a> for X-Sendfile support.

</div>
</div>
<div>
<h3 id="_upload_progress">8.10. Upload progress</h3>
<div>

Phusion Passenger does not provide upload progress support by itself. Please try drogus’s <a href="http://github.com/drogus/apache-upload-progress-module/tree/master"> Apache upload progress module</a> instead.

</div>
</div>
</div>
</div>
<div>
<h2 id="_under_the_hood">9. Under the hood</h2>
<div>
<div>

Phusion Passenger hides a lot of complexity for the end user (i.e. the web server system administrator), but sometimes it is desirable to know what is going on. This section describes a few things that Phusion Passenger does under the hood.

</div>
<div>
<h3 id="_static_assets_serving">9.1. Static assets serving</h3>
<div>

Phusion Passenger accelerates serving of static files. This means that, if an URI maps to a file that exists, then Phusion Passenger will let Apache serve that file directly, without hitting the web application.

</div>
<div>

Phusion Passenger does all this without the need for any mod_rewrite rules. People who are switching from an old Mongrel-based setup might have mod_rewrite rules such as these:

</div>
<div>
<div>
<pre># Check whether this request has a corresponding file; if that
# exists, let Apache serve it, otherwise forward the request to
# Mongrel.
RewriteCond %{DOCUMENT_ROOT}/%{REQUEST_FILENAME} !-f
RewriteRule ^(.*)$ balancer://mongrel%{REQUEST_URI} [P,QSA,L]</pre>
</div>
</div>
<div>

These kind of mod_rewrite rules are no longer required, and you can safely remove them.

</div>
</div>
<div>
<h3 id="_page_caching_support">9.2. Page caching support</h3>
<div>

For each HTTP request, Phusion Passenger will automatically look for a corresponding page cache file, and serve that if it exists. It does this by appending ".html" to the filename that the URI normally maps to, and checking whether that file exists. This check occurs after checking whether the original mapped filename exists (as part of static asset serving). All this is done without the need for special mod_rewrite rules.

</div>
<div>

For example, suppose that the browser requests <em>/foo/bar</em>.

</div>
<div>
<ol>
	<li>Phusion Passenger will first check whether this URI maps to a static file, i.e. whether the file <em>foo/bar</em> exists in the web application’s <em>public</em> directory. If it does then Phusion Passenger will serve this file through Apache immediately.</li>
	<li>If that doesn’t exist, then Phusion Passenger will check whether the file <em>foo/bar.html</em> exists. If it does then Phusion Passenger will serve this file through Apache immediately.</li>
	<li>If <em>foo/bar.html</em> doesn’t exist either, then Phusion Passenger will forward the request to the underlying web application.</li>
</ol>
</div>
<div>

Note that Phusion Passenger’s page caching support doesn’t work if your web application uses a non-standard page cache directory, i.e. if it doesn’t cache to the <em>public</em> directory. In that case you’ll need to use mod_rewrite to serve such page cache files.

</div>
</div>
<div>
<h3 id="application_detection">9.3. How Phusion Passenger detects whether a virtual host is a web application</h3>
<div>

After you’ve read the deployment instructions you might wonder how Phusion Passenger knows that the DocumentRoot points to a web application that Phusion Passenger is able to serve, and how it knows what kind of web application it is (e.g. Rails or Rack).

</div>
<div>

Phusion Passenger checks whether the virtual host is a Rails application by checking whether the following file exists:

</div>
<div>
<div>
<pre>dirname(DocumentRoot) + "/config/environment.rb"</pre>
</div>
</div>
<div>

If you’re not a programmer and don’t understand the above pseudo-code snippet, it means that Phusion Passenger will:

</div>
<div>
<ol>
	<li>Extract the parent directory filename from the value of the DocumentRoot directory.</li>
	<li>Append the text "/config/environment.rb" to the result, and check whether the resulting filename exists.</li>
</ol>
</div>
<div>

So suppose that your document root is <em>/webapps/foo/public</em>. Phusion Passenger will check whether the file <em>/webapps/foo/config/environment.rb</em> exists.

</div>
<div>

Note that Phusion Passenger does <strong>not</strong> resolve any symlinks in the document root path by default since version 2.2.0 — in contrast to versions earlier than 2.2.0, which do resolve symlinks. So for example, suppose that your DocumentRoot points to <em>/home/www/example.com</em>, which in turn is a symlink to <em>/webapps/example.com/public</em>. In versions earlier than 2.2.0, Phusion Passenger will check whether <em>/webapps/example.com/config/environment.rb</em> exists because it resolves all symlinks. Phusion Passenger 2.2.0 and later however will check for <em>/home/www/config/environment.rb</em>. This file of course doesn’t exist, and as a result Phusion Passenger will not activate itself for this virtual host, and you’ll most likely see an Apache mod_dirindex directory listing.

</div>
<div>

If you need the old symlink-resolving behavior for whatever reason, then you can turn on <a href="http://www.modrails.com/documentation/Users%20guide%20Apache.html#PassengerResolveSymlinksInDocumentRoot">PassengerResolveSymlinksInDocumentRoot</a>.

</div>
<div>

Another way to solve this situation is to explicitly tell Phusion Passenger what the correct application root is through the <a href="http://www.modrails.com/documentation/Users%20guide%20Apache.html#PassengerAppRoot">PassengerAppRoot</a> configuration directive.

</div>
<div>

Autodetection of Rack applications happens through the same mechanism, exception that Phusion Passenger will look for <em>config.ru</em> instead of <em>config/environment.rb</em>.

</div>
</div>
</div>
</div>
<div>
<h2 id="_appendix_a_about_this_document">10. Appendix A: About this document</h2>
<div>
<div>

The text of this document is licensed under the <a href="http://creativecommons.org/licenses/by-sa/3.0/">Creative Commons Attribution-Share Alike 3.0 Unported License</a>.

</div>
<div>

<a href="http://creativecommons.org/licenses/by-sa/3.0/"> <img src="http://www.modrails.com/documentation/images/by_sa.png" alt="images/by_sa.png" /> </a>

</div>
<div>

Phusion Passenger is brought to you by <a href="http://www.phusion.nl/">Phusion</a>.

</div>
<div>

<a href="http://www.phusion.nl/"> <img src="http://www.modrails.com/documentation/images/phusion_banner.png" alt="images/phusion_banner.png" /> </a>

</div>
<div>

Phusion Passenger is a trademark of Hongli Lai &amp; Ninh Bui.

</div>
</div>
</div>
<div>
<h2 id="_appendix_b_terminology">11. Appendix B: Terminology</h2>
<div>
<div>
<h3 id="application_root">11.1. Application root</h3>
<div>

The root directory of an application that’s served by Phusion Passenger.

</div>
<div>

In case of Ruby on Rails applications, this is the directory that contains <em>Rakefile</em>, <em>app/</em>, <em>config/</em>, <em>public/</em>, etc. In other words, the directory pointed to by RAILS_ROOT. For example, take the following directory structure:

</div>
<div>
<div>
<pre>/apps/foo/       &lt;------ This is the Rails application's application root!
   |
   +- app/
   |   |
   |   +- controllers/
   |   |
   |   +- models/
   |   |
   |   +- views/
   |
   +- config/
   |   |
   |   +- environment.rb
   |   |
   |   +- ...
   |
   +- public/
   |   |
   |   +- ...
   |
   +- ...</pre>
</div>
</div>
<div>

In case of Rack applications, this is the directory that contains <em>config.ru</em>. For example, take the following directory structure:

</div>
<div>
<div>
<pre>/apps/bar/      &lt;----- This is the Rack application's application root!
   |
   +- public/
   |    |
   |    +- ...
   |
   +- config.ru
   |
   +- ...</pre>
</div>
</div>
<div>

In case of Python (WSGI) applications, this is the directory that contains <em>passenger_wsgi.py</em>. For example, take the following directory structure:

</div>
<div>
<div>
<pre>/apps/baz/      &lt;----- This is the WSGI application's application root!
   |
   +- public/
   |    |
   |    +- ...
   |
   +- passenger_wsgi.py
   |
   +- ...</pre>
</div>
</div>
</div>
</div>
</div>
<div>
<h2 id="spawning_methods_explained">12. Appendix C: Spawning methods explained</h2>
<div>
<div>

At its core, Phusion Passenger is an HTTP proxy and process manager. It spawns Ruby on Rails/Rack/WSGI worker processes (which may also be referred to as <em>backend processes</em>), and forwards incoming HTTP request to one of the worker processes.

</div>
<div>

While this may sound simple, there’s not just one way to spawn worker processes. Let’s go over the different spawning methods. For simplicity’s sake, let’s assume that we’re only talking about Ruby on Rails applications.

</div>
<div>
<h3 id="_the_most_straightforward_and_traditional_way_conservative_spawning">12.1. The most straightforward and traditional way: conservative spawning</h3>
<div>

Phusion Passenger could create a new Ruby process, which will then load the Rails application along with the entire Rails framework. This process will then enter an request handling main loop.

</div>
<div>

This is the most straightforward way to spawn worker processes. If you’re familiar with the Mongrel application server, then this approach is exactly what mongrel_cluster performs: it creates N worker processes, each which loads a full copy of the Rails application and the Rails framework in memory. The Thin application server employs pretty much the same approach.

</div>
<div>

Note that Phusion Passenger’s version of conservative spawning differs slightly from mongrel_cluster. Mongrel_cluster creates entirely new Ruby processes. In programmers jargon, mongrel_cluster creates new Ruby processes by forking the current process and exec()-ing a new Ruby interpreter. Phusion Passenger on the other hand creates processes that reuse the already loaded Ruby interpreter. In programmers jargon, Phusion Passenger calls fork(), but not exec().

</div>
</div>
<div>
<h3 id="_the_smart_spawning_method">12.2. The smart spawning method</h3>
<div>
<table>
<tbody>
<tr>
<td><img src="http://www.modrails.com/documentation/images/icons/note.png" alt="Note" /></td>
<td>Smart spawning is supported for all Ruby applications but not for WSGI applications.</td>
</tr>
</tbody>
</table>
</div>
<div>

While conservative spawning works well, it’s not as efficient as it could be because each worker process has its own private copy of the Rails application as well as the Rails framework. This wastes memory as well as startup time.

</div>
<div>

<img src="http://www.modrails.com/documentation/images/conservative_spawning.png" alt="Worker processes and conservative spawning" />
<em>Figure: Worker processes and conservative spawning. Each worker process has its own private copy of the application code and Rails framework code.</em>

</div>
<div>

It is possible to make the different worker processes share the memory occupied by application and Rails framework code, by utilizing so-called copy-on-write semantics of the virtual memory system on modern operating systems. As a side effect, the startup time is also reduced. This is technique is exploited by Phusion Passenger’s <em>smart</em> and <em>smart-lv2</em> spawn methods.

</div>
<div>
<h4 id="_how_it_works">12.2.1. How it works</h4>
<div>

When the <em>smart-lv2</em> spawn method is being used, Phusion Passenger will first create a so-called <em>ApplicationSpawner server</em> process. This process loads the entire Rails application along with the Rails framework, by loading <em>environment.rb</em>. Then, whenever Phusion Passenger needs a new worker process, it will instruct the ApplicationSpawner server to do so. The ApplicationSpawner server will create a worker new process that reuses the already loaded Rails application/framework. Creating a worker process through an already running ApplicationSpawner server is very fast, about 10 times faster than loading the Rails application/framework from scratch. If the Ruby interpreter is copy-on-write friendly (that is, if you’re running <a href="http://www.modrails.com/documentation/Users%20guide%20Apache.html#reducing_memory_usage">Ruby Enterprise Edition</a>) then all created worker processes will share as much common memory as possible. That is, they will all share the same application and Rails framework code.

</div>
<div>

<img src="http://www.modrails.com/documentation/images/smart-lv2.png" alt="images/smart-lv2.png" />
<em>Figure: Worker processes and the smart-lv2 spawn method. All worker processes, as well as the ApplicationSpawner, share the same application code and Rails framework code.</em>

</div>
<div>

The <em>smart</em> spawn method goes even further, by caching the Rails framework in another process called the <em>FrameworkSpawner server</em>. This process only loads the Rails framework, not the application. When a FrameworkSpawner server is instructed to create a new worker process, it will create a new ApplicationSpawner to which the instruction will be delegated. All those ApplicationSpawner servers, as well as all worker processes created by those ApplicationSpawner servers, will share the same Rails framework code.

</div>
<div>

The <em>smart-lv2</em> method allows different worker processes that belong to the same application to share memory. The <em>smart</em> method allows different worker processes - that happen to use the same Rails version - to share memory, even if they don’t belong to the same application.

</div>
<div>

Notes:

</div>
<div>
<ul>
	<li>Vendored Rails frameworks cannot be shared by different applications, even if both vendored Rails frameworks are the same version. So for efficiency reasons we don’t recommend vendoring Rails.</li>
	<li>ApplicationSpawner and FrameworkSpawner servers have an idle timeout just like worker processes. If an ApplicationSpawner/FrameworkSpawner server hasn’t been instructed to do anything for a while, it will be shutdown in order to conserve memory. This idle timeout is configurable.</li>
</ul>
</div>
</div>
<div>
<h4 id="_summary_of_benefits">12.2.2. Summary of benefits</h4>
<div>

Suppose that Phusion Passenger needs a new worker process for an application that uses Rails 2.2.1.

</div>
<div>
<ul>
	<li>If the <em>smart-lv2</em> spawning method is used, and an ApplicationSpawner server for this application is already running, then worker process creation time is about 10 times faster than conservative spawning. This worker process will also share application and Rails framework code memory with the ApplicationSpawner server and the worker processes that had been spawned by this ApplicationSpawner server.</li>
	<li>If the <em>smart</em> spawning method is used, and a FrameworkSpawner server for Rails 2.2.1 is already running, but no ApplicationSpawner server for this application is running, then worker process creation time is about 2 times faster than conservative spawning. If there is an ApplicationSpawner server for this application running, then worker process creation time is about 10 times faster. This worker process will also share application and Rails framework code memory with the ApplicationSpawner and FrameworkSpawner servers.</li>
</ul>
</div>
<div>

You could compare ApplicationSpawner and FrameworkSpawner servers with stem cells, that have the ability to quickly change into more specific cells (worker process).

</div>
<div>

In practice, the smart spawning methods could mean a memory saving of about 33%, assuming that your Ruby interpreter is <a href="http://www.modrails.com/documentation/Users%20guide%20Apache.html#reducing_memory_usage">copy-on-write friendly</a>.

</div>
<div>

Of course, smart spawning is not without gotchas. But if you understand the gotchas you can easily reap the benefits of smart spawning.

</div>
</div>
</div>
<div>
<h3 id="_smart_spawning_gotcha_1_unintential_file_descriptor_sharing">12.3. Smart spawning gotcha #1: unintential file descriptor sharing</h3>
<div>

Because worker processes are created by forking from an ApplicationSpawner server, it will share all file descriptors that are opened by the ApplicationSpawner server. (This is part of the semantics of the Unix <em>fork()</em> system call. You might want to Google it if you’re not familiar with it.) A file descriptor is a handle which can be an opened file, an opened socket connection, a pipe, etc. If different worker processes write to such a file descriptor at the same time, then their write calls will be interleaved, which may potentially cause problems.

</div>
<div>

The problem commonly involves socket connections that are unintentially being shared. You can fix it by closing and reestablishing the connection when Phusion Passenger is creating a new worker process. Phusion Passenger provides the API call PhusionPassenger.on_event(:starting_worker_process) to do so. So you could insert the following code in your <em>environment.rb</em>:

</div>
<div>
<div>
<pre><tt>if defined?(PhusionPassenger)
  PhusionPassenger.on_event(:starting_worker_process) do |forked|
    if forked # We're in smart spawning mode. ...
      code to reestablish socket connections here ...
    else # We're in conservative spawning mode. We don't need to do anything.
    end
  end
end</tt></pre>
</div>
</div>
<div>

Note that Phusion Passenger automatically reestablishes the connection to the database upon creating a new worker process, which is why you normally do not encounter any database issues when using smart spawning mode.

</div>
<div>
<h4 id="_example_1_memcached_connection_sharing_harmful">12.3.1. Example 1: Memcached connection sharing (harmful)</h4>
<div>

Suppose we have a Rails application that connects to a Memcached server in <em>environment.rb</em>. This causes the ApplicationSpawner to have a socket connection (file descriptor) to the Memcached server, as shown in the following figure:

</div>
<div>
<div>
<pre>+--------------------+
| ApplicationSpawner |-----------[Memcached server]
+--------------------+</pre>
</div>
</div>
<div>

Phusion Passenger then proceeds with creating a new Rails worker process, which is to process incoming HTTP requests. The result will look like this:

</div>
<div>
<div>
<pre>+--------------------+
| ApplicationSpawner |------+----[Memcached server]
+--------------------+      |
                            |
+--------------------+      |
| Worker process 1   |-----/
+--------------------+</pre>
</div>
</div>
<div>

Since a <em>fork()</em> makes a (virtual) complete copy of a process, all its file descriptors will be copied as well. What we see here is that ApplicationSpawner and Worker process 1 both share the same connection to Memcached.

</div>
<div>

Now supposed that your site gets Slashdotted and Phusion Passenger needs to spawn another worker process. It does so by forking ApplicationSpawner. The result is now as follows:

</div>
<div>
<div>
<pre>+--------------------+
| ApplicationSpawner |------+----[Memcached server]
+--------------------+      |
                            |
+--------------------+      |
| Worker process 1   |-----/|
+--------------------+      |
                            |
+--------------------+      |
| Worker process 2   |-----/
+--------------------+</pre>
</div>
</div>
<div>

As you can see, Worker process 1 and Worker process 2 have the same Memcache connection.

</div>
<div>

Suppose that users Joe and Jane visit your website at the same time. Joe’s request is handled by Worker process 1, and Jane’s request is handled by Worker process 2. Both worker processes want to fetch something from Memcached. Suppose that in order to do that, both handlers need to send a "FETCH" command to Memcached.

</div>
<div>

But suppose that, after worker process 1 having only sent "FE", a context switch occurs, and worker process 2 starts sending a "FETCH" command to Memcached as well. If worker process 2 succeeds in sending only one bye, <em>F</em>, then Memcached will receive a command which begins with "FEF", a command that it does not recognize. In other words: the data from both handlers get interleaved. And thus Memcached is forced to handle this as an error.

</div>
<div>

This problem can be solved by reestablishing the connection to Memcached after forking:

</div>
<div>
<div>
<pre>+--------------------+
| ApplicationSpawner |------+----[Memcached server]
+--------------------+      |                   |
                            |                   |
+--------------------+      |                   |
| Worker process 1   |-----/|                   |
+--------------------+      |                   |  &lt;--- created this
                            X                   |       new
                                                |       connection
                            X &lt;-- closed this   |
+--------------------+      |     old           |
| Worker process 2   |-----/      connection    |
+--------------------+                          |
          |                                     |
          +-------------------------------------+</pre>
</div>
</div>
<div>

Worker process 2 now has its own, separate communication channel with Memcached. The code in <em>environment.rb</em> looks like this:

</div>
<div>
<div>
<pre><tt>if defined?(PhusionPassenger)
  PhusionPassenger.on_event(:starting_worker_process) do |forked|
    if forked # We're in smart spawning mode.
      reestablish_connection_to_memcached
    else # We're in conservative spawning mode. We don't need to do anything.
    end
  end
end</tt></pre>
</div>
</div>
</div>
<div>
<h4 id="_example_2_log_file_sharing_not_harmful">12.3.2. Example 2: Log file sharing (not harmful)</h4>
<div>

There are also cases in which unintential file descriptor sharing is not harmful. One such case is log file file descriptor sharing. Even if two processes write to the log file at the same time, the worst thing that can happen is that the data in the log file is interleaved.

</div>
<div>

To guarantee that the data written to the log file is never interleaved, you must synchronize write access via an inter-process synchronization mechanism, such as file locks. Reopening the log file, like you would have done in the Memcached example, doesn’t help.

</div>
</div>
</div>
<div>
<h3 id="_smart_spawning_gotcha_2_the_need_to_revive_threads">12.4. Smart spawning gotcha #2: the need to revive threads</h3>
<div>

Another part of the <em>fork()</em> system call’s semantics is the fact that threads disappear after a fork call. So if you’ve created any threads in environment.rb, then those threads will no longer be running in newly created worker process. You need to revive them when a new worker process is created. Use the :starting_worker_process event that Phusion Passenger provides, like this:

</div>
<div>
<div>
<pre><tt>if defined?(PhusionPassenger)
  PhusionPassenger.on_event(:starting_worker_process) do |forked|
    if forked # We're in smart spawning mode. ...
      code to revive threads here ...
    else # We're in conservative spawning mode. We don't need to do anything.
    end
  end
end</tt></pre>
</div>
</div>
</div>
<div>
<h3 id="_smart_spawning_gotcha_3_code_load_order">12.5. Smart spawning gotcha #3: code load order</h3>
<div>

This gotcha is only applicable to the <em>smart</em> spawn method, not the <em>smart-lv2</em> spawn method.

</div>
<div>

If your application expects the Rails framework to be not loaded during the beginning of <em>environment.rb</em>, then it can cause problems when an ApplicationSpawner is created from a FrameworkSpawner, which already has the Rails framework loaded. The most common case is when applications try to patch Rails by dropping a modified file that has the same name as Rails’s own file, in a path that comes earlier in the Ruby search path.

</div>
<div>

For example, suppose that we have an application which has a patched version of <em>active_record/base.rb</em> located in <em>RAILS_ROOT/lib/patches</em>, and <em>RAILS_ROOT/lib/patches</em> comes first in the Ruby load path. When conservative spawning is used, the patched version of <em>base.rb</em> is properly loaded. When <em>smart</em> (not <em>smart-lv2</em>) spawning is used, the original <em>base.rb</em> is used because it was already loaded, so a subsequent require "active_record/base" has no effect.

</div>
</div>
</div>
</div>
<div id="footer">
<div id="footer-text">Last updated 2011-11-24 19:06:50 CET</div>
<div>标签： <a href="http://jhjguxin.hwcrazy.com/tag/apache/">apache</a> <a href="http://jhjguxin.hwcrazy.com/tag/passenger/">passenger</a> <a href="http://jhjguxin.hwcrazy.com/tag/phusion/">phusion</a> <a href="http://jhjguxin.hwcrazy.com/tag/rails/">rails</a> <a href="http://jhjguxin.hwcrazy.com/tag/ruby/">ruby</a> <a href="http://jhjguxin.hwcrazy.com/tag/web/">web</a></div>
</div>
