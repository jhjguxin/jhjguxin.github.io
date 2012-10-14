---
layout: post
title: "Ruby on Rails – Programming Best Practices"
date: 2012-05-04 13:44
comments: true
categories: [rails]
tags: [Practices，DRY]
---
## Ruby on Rails – Programming Best Practices
<strong>Don't Repeat Yourself</strong>

I'm sure most of you have heard of the <a href="http://en.wikipedia.org/wiki/Don%27t_repeat_yourself">DRY principle</a>. It is something Rails has taken to heart, and I'm very glad it has. By not repeating yourself you can freely change something in one area of the program without worrying if you need to make the same change in another area. Not only that, but keeping the code DRY usually leads to better design.

Sometimes it is difficult to find duplication in your code. If you find yourself making a similar change in multiple places, you should first remove this duplication so you only need to make the change <strong>in one place</strong>.

This principle should not only be followed in code, but in your database and other areas as well. If you are repeating logic or data in the database, consider changing the design so it is not repeated.

That said, there are times when repeated data is good. For example, if you are building a cart system, the price for the items in the cart should be stored in a separate field than the price for the product. This allows you to change the price of the product without effecting all previous orders.

&nbsp;

<strong>Stick to the Conventions</strong>

Another extremely important practice taken up by the Rails community: stick to the conventions. From naming variables to structuring files, there are conventions on how to do these things in Rails. If you are unsure of the conventions, check out a Rails book or tutorial - most of them stick to the conventions.

The advantages of sticking to conventions are almost too numerous to count. In fact, it deserves <a href="http://railsforum.com/viewtopic.php?id=1042">its own article</a>.

&nbsp;

<strong>Optimize Later</strong>

Performance is a major concern for many people switching to Rails, and rightly so. It is true that Rails is generally slower than other web frameworks. However, it is very scalable, so do not worry about it at the beginning. If you are a large corporation that needs to handle thousands of requests per second, then you may have something to be concerned about, but for the majority of us performance does not need to be considered until near the completion of the application.

Any optimization done early requires guessing. Instead you should wait until you know where the bottlenecks are. Optimizing usually requires extra/complex code, and you should keep the code as clean and simple as possible. Therefore, only optimize where necessary. Also, any performance testing should be done in the <strong>production</strong> environment, as this adds some optimizations which are usually turned off in the <strong>development</strong> environment.

Above all else, don't let fear of poor performance inhibit you from making good design decisions! There are usually good ways to optimize while still keeping the good design, but these ways are hard to see unless you have a good design already in place. In short, don't worry about performance while designing.

&nbsp;

<strong>Humans First</strong>

Code for humans first, computers second. In other words, make the code as readable as you can. No, I'm not talking about cluttering it with comments. Most code should be understandable <strong>without comments</strong>.

How do you make the code more readable without comments? Rename variables, move code into classes/methods, etc. Try to give variables and methods concise, yet descriptive names. Do not abbreviate the names unless the abbreviation is very common.

&nbsp;

<strong>Test Driven Development</strong>

You've heard it said: "Rails makes testing easy, so you don't have any excuses not to do it.". Well, in my opinion, testing is never easy - it is just <strong>easier</strong> in Rails.

Seriously, if you have not tried <a href="http://en.wikipedia.org/wiki/Test_driven_development">test driven development</a>, give it a go. Automated tests are a godsend! I find myself rarely going to the web browser anymore to test things out. I just know it works because all of the tests pass. I wouldn't dare code a mildly complex application without testing anymore. It will take some time to get used to testing, but the benefits are far worth it.

&nbsp;

<strong>Refactoring</strong>

This is my favorite best practice, and for good reason. Refactoring ties all of the things in this list together. Simply put, if you want to become a better programming, learn <a href="http://en.wikipedia.org/wiki/Refactoring">Refactoring</a>. Normally the first time you write a piece of code, it is messy. Whatever you do, <strong>don't leave the messy code as is</strong>. Even if it works correctly, it will be a headache to maintain. You should take some time to clean up the code, make it readable, and improve the design.

Make it beautiful.

<em>Last edited by ryanb (2006-10-31 00:13:39)</em>

The original <a href="http://www.amazon.com/Refactoring-Improving-Design-Existing-Code/dp/0201485672/">Refactoring</a> book is definitely recommended reading. There is also <a href="http://www.amazon.com/exec/obidos/ASIN/0321293533">Refactoring Databases</a>.
