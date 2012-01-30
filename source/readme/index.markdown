---
layout: page
title: "readme"
date: 2012-01-30 15:59
comments: true
sharing: true
footer: true
---
## What is Octopress?

Octopress is [Jekyll](https://github.com/mojombo/jekyll) blogging at its finest.

1. **Octopress sports a clean responsive theme** written in semantic HTML5, focused on readability and friendliness toward mobile devices.
2. **Code blogging is easy and beautiful.** Embed code (with [Solarized](http://ethanschoonover.com/solarized) styling) in your posts from gists, jsFiddle or from your filesystem.
3. **Third party integration is simple** with built-in support for Twitter, Pinboard, Delicious, GitHub Repositories, Disqus Comments and Google Analytics.
4. **It's easy to use.** A collection of rake tasks simplifies development and makes deploying a cinch.
5. **Ships with great plug-ins** some original and others from the Jekyll community &mdash; tested and improved.


## Documentation

Check out [Octopress.org](http://octopress.org/docs) for guides and documentation.


## Contributing

We love to see people contributing to Octopress, whether it's a bug report, feature suggestion or a pull request. At the moment, we try to keep the core slick and lean, focusing on basic blogging needs, so some of your suggestions might not find their way into Octopress. For those ideas, we started a [list of 3rd party plug-ins](https://github.com/imathis/octopress/wiki/3rd-party-plug-ins), where you can link your own Octopress plug-in repositories. For the future, we're thinking about ways to easier add them them into our main releases.


## License
(The MIT License)

Copyright © 2009-2011 Brandon Mathis

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the ‘Software’), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED ‘AS IS’, WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.


#### If you want to be awesome.
- Proudly display the 'Powered by Octopress' credit in the footer.
- Add your site to the Wiki so we can watch the community grow.

## Add by Francis

### Octopress Setup
You’ll need to install Git and set up your Ruby environment. **Octopress requires Ruby 1.9.2** wich you can easily install with RVM or rbenv. You can’t use both rbenv and RVM on the same system, as they are competing Ruby environment managers, so choose one.
In ubuntu,your can install in this way:
    #try to remove ruby1.8
    sudo apt-get autoremove ruby ruby1.8 ruby1.8-dev
    #install ruby1.9.1
    sudo apt-get install ruby1.9.1-dev ruby1.9.1-full ruby1.9.1-examples

### Setup Octopress
    git clone git://github.com/imathis/octopress.git octopress
    cd octopress    # If you use RVM, You'll be asked if you trust the .rvmrc file (say yes).
    ruby --version  # Should report Ruby 1.9.2

If ruby --version doesn’t say you’re using Ruby 1.9.2, you must reinstall ruby until report Ruby 1.9.2.

Next, install dependencies

    sudo gem install bundler
    bundle install

Install the default Octopress theme.
    rake install

### Deploying to Github Pages

#### With Github User/Organization pages

Use this if you want to host a blog from <code>http://username.github.com</code> (though you can also use custom domains).

Create a new Github repository and name the repository with your user name or organization name <code>username.github.com</code> or <code>organization.github.com</code>.

Github Pages for users and organizations uses the master branch like the public directory on a web server, serving up the files at your Pages url <code>http://username.github.com</code>. As a result, **you’ll want to work on the source for your blog in the source branch and commit the generated content to the master branch**. Octopress has a configuration task that helps you set all this up.

rake setup_github_pages

1. Ask you for your Github Pages repository url.type<code>git@github.com:jhjguxin/username.github.com.git</code>
2. Rename the remote pointing to imathis/octopress from ‘origin’ to ‘octopress’
3. Add your Github Pages repository as the default origin remote.
4. Switch the active branch from master to source.**(which every source file inside)**
5. Configure your blog’s url according to your repository.
6. Setup a master branch in the _deploy directory for deployment.

Next run:
    rake generate
    rake deploy

This will generate your blog, copy the generated files into _deploy/, add them to git, commit and push them up to the master branch. In a few seconds you should get an email from Github telling you that your commit has been received and will be published on your site.

**Don’t forget to commit the source** for your blog.

    git add .
    git commit -m 'your message'
    git push origin source

**Note:** With new repositories, **Github sets the default branch based on the branch you push first**, and it looks there for the generated site content. If you’re having trouble getting Github to publish your site, go to the admin panel for your repository and make sure that the master branch is the default branch.(or you can refer to **About branch**)


This will generate your blog, copy the generated files into <code>_deploy/</code>, add them to git, commit and push them up to the master branch. In a few seconds you should get an email from Github telling you that your commit has been received and will be published on your site.

#### With Github Project pages (gh-pages)

Github’s Project Pages service allows you to host a site for your existing open source project. **Github will look for a <code>gh-pages</code> branch in your project’s repository** and make the contents available at url like <code>http://username.github.com/project</code>.

Here’s now you can set up Octopress site to publish to your projects gh-pages repository:

    rake setup_github_pages

This will:

1. Ask you for the repository url for your project.
2. Rename the remote pointing to imathis/octopress from ‘origin’ to ‘octopress’
3. Configure your blog for deploying to a subdirectory.
4. Set up a gh-pages branch for your project in the _deploy directory, ready for deployment.

Next run:
    rake generate
    rake deploy

This will generate your blog, copy the generated files into _deploy/, add them to git, commit and push them up to the master branch. In a few seconds you should get an email from Github telling you that your commit has been received and will be published on your site.

Now you have a place to commit the generated content for your site, but you should also set up repository to store the source for your blog. After you set up a repository for your blog source, add it as the origin remote.

    git remote add origin (your repo url)
    # set your new origin as the default branch
    git config branch.master.remote origin

Now push your changes and you’ll be all set.

#### Custom Domains
First you’ll need to create a file named <code>CNAME</code> in the source containing your domain name.
    echo 'your-domain.com' >> source/CNAME

From Github’s Pages guide:
Next, you’ll need to visit your domain registrar or DNS host and add a record for your domain name. For a sub-domain like www.example.com you would simply create a CNAME record pointing at charlie.github.com. If you are using a top-level domain like example.com, you must use an A record pointing to 207.97.227.245. Do not use a CNAME record with a top-level domain it can have adverse side effects on other services like email. Many DNS services will let you set a CNAME on a TLD, even though you shouldn’t. Remember that it may take up to a full day for DNS changes to propagate, so be patient.

### Blogging Basics

Octopress offers some rake tasks to create post and pages preloaded with metadata and according to Jekyll’s naming conventions. It also generates a global and a category based feed for your posts (You can find them in <code>atom.xml</code> and <code>blog/categories/<category>/atom.xml</code>).

#### Blog Posts

Blog posts must be stored in the <code>source/_posts</code> directory and named according to Jekyll’s naming conventions: <code>YYYY-MM-DD-post-title.markdown</code>. The name of the file will be used as the url slug, and the date helps with file distinction and determines the sorting order for post loops.

**Octopress provides a rake task to create new blog posts with the right naming conventions, with sensible yaml metadata.**

Syntax

    rake new_post["title"]

<code>new_post</code> expects a naturally written title and strips out undesirable url characters when creating the filename. The default file extension for new posts is <code>markdown</code> but you can configure that in the <code>Rakefile</code>.

**Example**

    rake new_post["Zombie Ninjas Attack: A survivor's retrospective"]
    # Creates source/_posts/2011-07-03-zombie-ninjas-attack-a-survivors-retrospective.markdown

The filename will determine your url. With the default permalink settings the url would be something like <code>http://site.com/blog/2011/07/03/zombie-ninjas-attack-a-survivors-retrospective/index.html</code>.

Open a post in a text editor and you’ll see a block of yaml front matter which tells Jekyll how to processes posts and pages.

<pre><code>---
layout: post
title: "Zombie Ninjas Attack: A survivor's retrospective"
date: 2011-07-03 5:59
comments: true
categories:
---
</code></pre>

Here you can turn comments off and or categories to your post. If you are working on a multi-author blog, you can add <code>author: Your Name</code> to the metadata for proper attribution on a post. If you are working on a draft, you can add <code>published: false</code> to prevent it from being posted when you generate your blog.

You can add a single category or multiple categories like this.
	

# One category
    categories: Sass

# Multiple categories example 1
    categories: [CSS3, Sass, Media Queries]

# Multiple categories example 2

<code>
categories:
- CSS3
- Sass
- Media Queries
</code>

#### New Pages

You can add pages anywhere in your blog source directory and they’ll be parsed by Jekyll. The URL will correspond directly to the filepath, so <code>about.markdown</code> will become <code>site.com/about.html</code>. If you prefer the URL <code>site.com/about/</code> you’ll want to create the page as about/index.markdown. Octopress has a rake task for creating new pages easily.

    rake new_page[super-awesome]
    # creates /source/super-awesome/index.markdown
    
    rake new_page[super-awesome/page.html]
    # creates /source/super-awesome/page.html

Like with the new post task, the default file extension is <code>markdown</code> but you can configure that in the <code>Rakefile</code>. A freshly generated page might look like this.

---
layout: page
title: "Super Awesome"
date: 2011-07-03 5:59
comments: true
sharing: true
footer: true
---

The title is derived from the filename so you’ll likely want to change that. This is very similar to the post yaml except it doesn’t include categories, and you can toggle sharing and comments or remove the footer altogether. If you don’t want to show a date on your page, just remove it from the yaml.

#### Content

The page and post content will be rendered by whichever markup engine you have specified in the site configuration file. Additionally, you can use any of the [liquid template features](https://github.com/Shopify/liquid/wiki/Liquid-for-Designers) that are described in the [Jekyll docs](https://github.com/mojombo/jekyll/wiki/Template-Data).

Inserting a <code><!-- more --></code> comment into your post will prevent the post content below this mark from being displayed on the index page for the blog posts, a “Continue →” button links to the full post.

#### Generate & Preview

<pre><code>
rake generate   # Generates posts and pages into the public directory
rake watch      # Watches source/ and sass/ for changes and regenerates
rake preview    # Watches, and mounts a webserver at http://localhost:4000
</code></pre>

If you want to work on posts without publishing them, you can add a published: false to your post’s YAML header. You can preview these posts with rake preview on your local server, but they won’t get published by rake generate.

Using the rake preview server is nice, but If you’re a [POW](http://pow.cx/) user, you can set up your Octopress site like this.

    cd ~/.pow
    ln -s /path/to/octopress octopress
    cd -

Now that you’re setup with POW, you’ll just run rake watch and load up http://octopress.dev instead.

Also see [Sharing Code Snippets](http://octopress.org/docs/blogging/code) and [Blogging with Plugins](http://octopress.org/docs/blogging/plugins).

### CN guide for push to github pages

#### 發佈到 GitHub （免費）
先建立 GitHub Repository ，並使用 username.github.com 命名（如果是組織則用 organization.github.com），例如你的 GitHub 帳號是 john2011 就將 Repository 命名為 john2011.github.com，完成後會得到一組 GitHub Pages URL http://yourname.github.com/ （注意不能用 https: 必須用 http: ）。 

#### 設定 GitHub Pages 

rake setup_github_pages以上執行後會要求 read/write url for repository ：
git@github.com:yourname/yourname.github.com.git 

#### 建立及發佈 

    rake generate
    rake deploy#發佈到git等待幾分鐘時間，會收到一封信：「[sslab.github.com] Page build successful」，第一次發佈會等比較久，之後每次都會直接更新。 

#### 瀏覽 http://yourname.github.com/ 

將 source 也加入 git 

    git add .
    git commit -m 'initial source commit'
    git push origin source更新 Octopress

日後有 Octopress 新版本發佈，使用以下指令升級。 

    git pull octopress master     # Get the latest Octopress
    bundle install                # Keep gems updated
    rake update_source            # update the template's source
    rake update_style             # update the template's style常用指令

####建立新文章 
    rake new_post["how-to-install-octopress"] 常用語法

####程式碼區塊 

``` ruby
puts 1+2+3
```

### About branch
git clone默认会把远程仓库整个给clone下来
但只会在本地默认创建一个master分支
如果远程还有其他的分支，此时用git branch -a查看所有分支：

    $ git clone git@github.com:jhjguxin/jhjguxin.github.com.git
    $ git branch
    * master
    $ git branch -a
    * master
      remotes/origin/HEAD -> origin/master
      remotes/origin/master
      remotes/origin/source

能看到远程的所有的分支，如

    git checkout source#尽量checkout一次就push一次相应的分支再checkout其他的分支

可以使用checkout命令来把远程分支取到本地，并自动建立tracking

    $ git checkout -b source source
    Branch source set up to track remote branch source from origin.
    Switched to a new branch 'source'

或者使用-t参数，它默认会在本地建立一个和远程分支名字一样的分支

    $ git checkout -t source

 也可以使用fetch来做：

    $ git fetch origin source:source

 不过通过fetch命令来建立的本地分支不是一个track branch，而且成功后不会自动切换到该分支上

注意：不要在本地采用如下方法：



    $ git branch source
    $ git checkout source#checkout 远程的分支到本地那么本地未提交的commit也就没有了
    $ git pull origin source:source

因为，这样建立的branch是以master为基础建立的，再pull下来的话，会和master的内容进行合并，有可能会发生冲突…

