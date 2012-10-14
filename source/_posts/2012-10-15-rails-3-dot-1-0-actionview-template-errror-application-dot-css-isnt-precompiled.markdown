---
layout: post
title: "rails 3.1.0 ActionView::Template::Errror (application.css isn't precompiled)"
date: 2012-02-23 16:30
comments: true
categories: ["rails", "ruby"]
tags: ["assets", "precompiled", "rails", "ruby"]
---
## rails 3.1.0 ActionView::Template::Errror (application.css isn't precompiled)
I made a basic rails app with a simple pages controller with an index function and when I load the page I get:

ActionView::Template::Error (application.css isn't precompiled):
app/views/layouts/application.html.erb:5:in `_app_views_layouts_application_html

By default Rails assumes that you have your files precompiled in the production environment, if you want use live compiling (compile your assets during runtime) in production you must set the config.assets.compile to true.

 Demo

# config/environments/production.rb
...
config.assets.compile = true
...
You can use this option to fallback to Sprockets when you are using precompiled assets but there are any missing precompiled files.

If config.assets.compile option is set to false and there are missing precompiled files you will get an "AssetNoPrecompiledError" indicating the name of the missing file.

<strong>You will get better performance in production if you set config.assets.compile to false in production.rb and precompile your assets. You can precompile with this rake task:</strong>

bundle exec rake assets:precompile
