---
layout: post
title: "Simple CRUD with MongoDB "
date: 2012-07-27 12:34
comments: true
categories: [DB,ruby]
tags: [CRUD,MongoDB]
---
## Simple CRUD with MongoDB 
When I meet a new technology, I like to experience it "just as it comes". I'm happy at the command line and I like to type actual commands and see man pages before I use any wrappers or helper tools. So when I met <a href="http://www.mongodb.org/">MongoDB</a> for the first time, I did exactly that. This post shows those first steps of creating a database, and inserting, reading, deleting and updating data.

<em>Before we begin, you should install mongo. This is painless and for me, on ubuntu, <code>sudo aptitude install mongodb</code> did the trick.</em>
<h3>Some Terminology</h3>
Here are some translations from the RDBMS equivalent wording:
<ul>
	<li>"database" is still "database"</li>
	<li>"table" becomes "collection"</li>
	<li>"row" becomes "record"</li>
	<li>try to forget the word "column", we don't have those</li>
</ul>
<h3>Let's Begin</h3>
<strong>Creating a Database</strong>

You don't really create a database with mongo, you just kind of start using it. Once you put something in there, it exists. I'm going to name my new database <code>pets</code>.
<pre>use pets</pre>
<strong>Adding Data</strong>

To do anything in mongo, you start your command with <code>db</code> which refers to the database you're using. The different parts of the command are separated by dots. To insert data you use a command like <code>db.[collection].save()</code> and feed in the data to save. The format of the data is JSON-esque - I read JSON but I don't really write it, however I found it became familiar pretty quickly. To insert some data, you can do:
<pre>&gt; db.animals.save({'animal':'cat', 'name':'fluffy', 'type':'long-haired', 'owner':'Anna'});
&gt; db.animals.save({'animal':'dog', 'type':'spaniel', 'name':'toffee', 'colour':'toffee', 'owner':'Ben'});
&gt; db.animals.save({'owner':'Ben', 'animal':'cat', 'name':'ginger', 'collar':true});</pre>
<strong>Fetching Data</strong>

Did anything happen? We can check, using <code>db.[collection].find()</code> - this will give us everything in the collection, a bit like <code>select * from [table]</code> does in SQL.
<pre>&gt; db.animals.find();
{ "_id" : ObjectId("4ebb8fd68f7aaffc5d287383"), "animal" : "cat", "name" : "fluffy", "type" : "long-haired", "owner" : "Anna" }
{ "_id" : ObjectId("4ebb90048f7aaffc5d287384"), "animal" : "dog", "type" : "spaniel", "name" : "toffee", "colour" : "toffee", "owner" : "Ben" }
{ "_id" : ObjectId("4ebb90768f7aaffc5d287385"), "owner" : "Ben", "animal" : "cat", "name" : "ginger", "collar" : true }</pre>
We definitely have data! We can also filter this down, the equivalent of adding a "where" clause, for example, let's only see cats:
<pre>&gt; db.animals.find({'animal':'cat'});
{ "_id" : ObjectId("4ebb8fd68f7aaffc5d287383"), "animal" : "cat", "name" : "fluffy", "type" : "long-haired", "owner" : "Anna" }
{ "_id" : ObjectId("4ebb90768f7aaffc5d287385"), "owner" : "Ben", "animal" : "cat", "name" : "ginger", "collar" : true }</pre>
You can add multiple constraints here, how about cats belonging to Ben?
<pre>&gt; db.animals.find({'animal':'cat', 'owner':'Ben'});
{ "_id" : ObjectId("4ebb90768f7aaffc5d287385"), "owner" : "Ben", "animal" : "cat", "name" : "ginger", "collar" : true }</pre>
If any of the records don't have the field you're searching on, they won't appear in the results. We're not tied to a rigid structure of columns so you can just throw in whichever data seems useful at the time, and search on whatever is there. We can also search on whether we have the field at all, for example, animals where we know what colour they are:
<pre>&gt; db.animals.find({colour: {$exists: true}});
{ "_id" : ObjectId("4ebb90048f7aaffc5d287384"), "animal" : "dog", "type" : "spaniel", "name" : "toffee", "colour" : "toffee", "owner" : "Ben" }</pre>
<strong>Updating Data</strong>

This confused me for a long time, as mongo does have an <code>update()</code> function, which you can use to update one or many records in a particular way. What I found I really wanted though was to use the <code>save()</code> method again, because if the record has an identifier that exists, mongo will update it, otherwise it will insert it as we saw above. So we can just grab a record and change it, then save it:
<pre>&gt; db.animals.find({'animal':'dog'});
{ "_id" : ObjectId("4ebb90048f7aaffc5d287384"), "animal" : "dog", "type" : "spaniel", "name" : "toffee", "colour" : "toffee", "owner" : "Ben" }
db.animals.save({ "_id" : ObjectId("4ebb90048f7aaffc5d287384"), "animal" : "dog", "breed" : "spaniel", "name" : "toffee", "colour" : "toffee", "owner" : "Ben" });</pre>
I realised that calling a spaniel a "type" of dog would be better expressed as being a "breed", so I simply changed that record and mongo updated it for me. The <code>update() </code>statement is better for working on sets of records - for example if we decide Ben should be using his Sunday name:
<pre>&gt; db.animals.update({'owner':'Ben'}, {$set: {'owner':'Benjamin'}}, false, true);</pre>
There's a lot going on here, so let's look at the pieces step-by-step. The <a href="http://www.mongodb.org/display/DOCS/Updating">documentation</a> describes the update function as:
<pre>db.collection.update( criteria, objNew, upsert, multi )</pre>
The first part, the <em>criteria</em> is the same as we would use for the <code>find()</code> method. The next argument is what we're changing. I'm just setting one field to a given value, so I used the <code>$set</code> modifier (modifiers are an art in themselves, this post is rambling on already so I'll write about those another day if you're interested). The next argument is the <em>upsert</em>, which is whether to insert a new record if we didn't find any matches - I want to update existing records, not insert anything, so I set this to false. Finally the <em>multi</em> flag tells mongo to update ALL the records it can find that match the<em>criteria</em>, if this is false it will stop after one (lazy thing!).

<strong>Deleting Data</strong>

If you've come this far then I'm impressed, and deleting is the easy part so we're almost there! Exactly like the <code>find()</code>and <code>update()</code> commands, we just supply a criteria to the <code>remove()</code> command. This could be either one of the fields, as we used already, or the object ID itself, like this:
<pre>&gt; db.animals.remove({_id: ObjectId("4ebb90768f7aaffc5d287385")});</pre>
As with all things mongo, you won't get any feedback about whether it worked, since most of the time we're using this on systems so fast there isn't time for niceties, but if you try to <code>find()</code> this record now, you won't be able to.
<h3>MongoDB</h3>
There's so much that's exciting about mongo, the sheer size and speed of this data store, the support for map reduce, the sharding support ... I could go on. However you still need to be able to have a quick word with your database and check what data it has, maybe tweak something, and I hope that these mongo examples will serve as a quick reference for anyone who needs them, including me of course! I like databases, APIs and command line, so working with mongo is kind of magical for me, are you working with it? I'd love to hear how others are getting on and what other tips I need to know, so leave a comment and share, please!
