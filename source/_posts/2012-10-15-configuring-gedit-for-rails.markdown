---
layout: post
title: "Configuring Gedit for Rails"
date: 2012-06-07 10:34
comments: true
categories: [rails,ruby]
tags: [configuring,gedit,rails,ruby]
---
## Configuring Gedit for Rails
I haven’t kept my feelings about IDEs hidden, I’m a big believer in using text editors instead.

I know, I should earn my chops and become a Vim guy, and some day I hope to sit down and make that conversion, but for now it’s all about Gedit for me. With a few plugins and a little TLC gedit can be a lighter version of the more powerful, more intensive ide.

The first thing we’re going to install gMate, an addon designed to make Gedit run like TextMate
<blockquote>sudo add-apt-repository ppa:ubuntu-on-rails/ppa

sudo apt-get update</blockquote>
<blockquote>sudo apt-get install gedit-gmate</blockquote>
Additionally we’re going to install the standard plugins package
<blockquote>sudo apt-get install gedit-plugins</blockquote>
Now lets fire up Gedit and turn on our preferences.

To get to our plugins go to Edit &gt; Preferences &gt; Plugins.

We’re going to enable the following options:
<ul>
	<li>Snippets</li>
	<li>Code Comment</li>
	<li>Embedded Terminal</li>
	<li>Find in Files</li>
	<li>Rails Extract Partial</li>
	<li>Rails File Loader</li>
	<li>Session Saver (Optional)</li>
	<li>Smart Indent (Optional)</li>
	<li>Tab Switch (Optional)</li>
	<li>TextMate Style AutoCompletion</li>
</ul>
This is going to enable a lot of different functionality, and while this is the setup I use, it may be more than you need.

Now if you’re in a ruby file and you type def, tabbing over will add the end and place you straight on the method name, control+tab will switch between documents, and syntax highlighting will work correctly in html.erb files.

Also, going to view &gt; bottom pane will display a terminal window that I find convenient for running irb.

While these instructions will enable a lot of different useful environments, and the target of this post was rails, I do have to sadly add that Google Go, which I cover quite often, does not, to my knowledge, have a plugin for Gedit currently.
