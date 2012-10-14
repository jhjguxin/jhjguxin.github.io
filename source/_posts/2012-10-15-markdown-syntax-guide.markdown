---
layout: post
title: "Markdown Syntax Guide"
date: 2011-11-22 18:13
comments: true
categories: [网文]
tags: [guide,markdown,syntax]
---
## Markdown Syntax Guide
Markdown Syntax Guide
The Allura code uses markdown syntax everywhere to allow you to create rich
text markup, and extends markdown in several ways to allow for quick linking
to other artifacts in your project.

Markdown was created to be easy to read, easy to write, and still readable in plain text format.

Links 
Reference Links 
Artifact Links 
Text 
Blockquotes 
Preformatted Text 
Lists 
Tables 
Headers 
Horizontal Rules 
Images 
Escapes 
More Headers 
Code Highlighting 
Includes 
Neighborhood Notifications 
Download Button 
Project Screenshots 
Thanks 
Links
Most URLs will automatically be turned into links. To be explicit, just write it like this:

<http://someurl>

<somebbob@example.com>

Output:

http://someurl

somebbob@example.com

To use text for the link, write it:

[like this](http://someurl)Output:

like this

You can add a *title* (which shows up under the cursor):

[like this](http://someurl "this title shows up when you hover")Output:

like this

Reference Links
You can also put the [link URL][1] below the current paragraph
like [this][2].

   [1]: http://url
   [2]: http://another.url "A funky title"
Output:

You can also put the link URL below the current paragraph like this.

Here the text "link URL" gets linked to "http://url", and the lines showing "[1]: http://url" won't show anything.

Or you can use a [shortcut][] reference, which links the text "shortcut" to the link named "[shortcut]" on the next paragraph.

Or you can use a [shortcut][] reference, which links the text
"shortcut" to the link named "[shortcut]" on the next paragraph.

[shortcut]: http://goes/with/the/link/name/textOutput:

Or you can use a shortcut reference, which links the text "shortcut" to the link named "shortcut" on the next paragraph.

Artifact Links
Any existing forge resource can be linked with surrounding square brackets ie [MyPage] or [#123].

Links to resources in other tools can be explicitly referenced by adding a tool identifier prefix to the link. So for instance `[developerwiki:MyPage]` can refer to a wiki page in a `developerwiki` instance. You can also link to tickets with `[tickets:#123]` assuming there's a 123 ticket in a Tracker instance mounted at `tickets`. The same is true for forums, or any of the other tools you have installed. You can even link to tickets in a subproject with `[subproject.tickets:#123]`.

[MyPage]
[developerwiki:MyPage]
[#123]
[tickets:#123]
No example output is available for this one because it only works on real artifacts. Try it in your project!

Text
Use * or _ to emphasize things:

*this is in italic*  and _so is this_

**this is in bold**  and __so is this__

***this is bold and italic***  and ___so is this___
Output:

this is in italic and so is this

this is in bold and so is this

this is bold and italic and so is this

You can strike through text using HTML like this:

<s>this is strike through text</s>
Output:

this is strike through text

Just write paragraphs like in a text file and they will display how
you would expect.  A blank line separates paragraphs.

So this is a new paragraph. But any text on adjacent lines
will all end up
in the same paragraph.
Output:

Just write paragraphs like in a text file and they will display how
you would expect. A blank line separates paragraphs.

So this is a new paragraph. But any text on adjacent lines
will all end up
in the same paragraph.

Blockquotes
Use the > character in front of a line, just like in email

> Use it if you're quoting a person, a song or whatever.

> You can use *italic* or lists inside them also.
And just like with other paragraphs,
all of these lines are still
part of the blockquote, even without the > character in front.

To end the blockquote, just put a blank line before the following
paragraph.
Output:

Use it if you're quoting a person, a song or whatever.

You can use italic or lists inside them also. And just like with other paragraphs, all of these lines are still part of the blockquote, even without the > character in front.

To end the blockquote, just put a blank line before the following
paragraph.

Preformatted Text
If you want some text to show up exactly as you write it, without Markdown doing anything to it, just indent every line by at least 4 spaces (or 1 tab).

    This line won't *have any markdown* formatting applied.
    I can even write <b>HTML</b> and it will show up as text.
    This is great for showing program source code, or HTML or even
    Markdown. <b>this won't show up as HTML</b> but
    exactly <i>as you see it in this text file</i>.

As a shortcut you can use backquotes to do the same thing while
inside a normal pargraph.  `This won't be *italic* or **bold**
at all.`
Output:

This line won't *have any markdown* formatting applied.
I can even write <b>HTML</b> and it will show up as text.
This is great for showing program source code, or HTML or even
Markdown. <b>this won't show up as HTML</b> but
exactly <i>as you see it in this text file</i>.
As a shortcut you can use backquotes to do the same thing while
inside a normal pargraph. This won't be *italic* or **bold**
at all.

Lists
* an asterisk starts an unordered list
* and this is another item in the list
+ or you can also use the + character
- or the - character

To start an ordered list, write this:

1. this starts a list *with* numbers
+  this will show as number "2"
*  this will show as number "3."
9. any number, +, -, or * will keep the list going.
    * just indent by 4 spaces (or tab) to make a sub-list
        1. keep indenting for more sub lists
    * here i'm back to the second level
Output:

an asterisk starts an unordered list 
and this is another item in the list 
or you can also use the + character 
or the - character 
To start an ordered list, write this:

this starts a list with numbers 
this will show as number "2" 
this will show as number "3." 
any number, +, -, or * will keep the list going. 
just indent by 4 spaces (or tab) to make a sub-list
keep indenting for more sub lists 
here i'm back to the second level 
Tables
You can create tables using pipes and dashes like this:

  First Header  | Second Header
  ------------- | -------------
  Content Cell  | Content Cell
  Content Cell  | Content Cell
Output:

First Header Second Header 
Content Cell Content Cell 
Content Cell Content Cell 

You can use markdown syntax within table cells for formatting:

  First Header   | Second Header
  -------------  | -------------
  *Content Cell* | Content Cell
  Content Cell   | Content Cell
Output:

First Header Second Header 
Content Cell Content Cell 
Content Cell Content Cell 

You can also create tables using HTML code.

Headers
Just put 1 or more dashes or equals signs (--- or ===) below the title.

This is a huge header
==================

this is a smaller header
------------------
Output:

This is a huge header
this is a smaller header
Horizontal Rule
Just put three or more *'s or -'s on a line:

----------------
Output:


--------------------------------------------------------------------------------

Or, you can use single spaces between then, like this:

* * *
Output:


--------------------------------------------------------------------------------

or

- - - - - - -
Output:


--------------------------------------------------------------------------------

Make sure you have a blank line above the dashes, though, or else:

you will get a header
---
Output:

you will get a header
Images
To include an image, just put a "!" in front of a text link:

![alternate text](https://sourceforge.net/images/icon_linux.gif)
Output:



The "alternate text" will show up if the browser can't load the image.

You can also use a title if you want, like this:

![tiny arrow](https://sourceforge.net/images/icon_linux.gif "tiny arrow")
Output:



To reference an attached image, just use the img macro. You can add more attributes:

[[img src=attached-image.jpg alt=foobar]]
Output:



Escapes
What if you want to just show asterisks, not italics?

* this shows up in italics: *a happy day*
* this shows the asterisks: \*a happy day\*
Output:

this shows up in italics: a happy day 
this shows the asterisks: *a happy day* 
The backslashes will disappear and leave the asterisks.

You can do the same with any of the characters that have a special meaning
for Markdown.

HTML tags may need to be escaped. <b> will be interpreted as a bold tag. Entity codes will be used. <foobar> isn't allowed and will be dropped, so you probably want to escape it:

<b>this will be bold</b>
you should escape &lt;unknown&gt; tags
&lt; special entities work
&amp;lt; if you want to escape it
Output:

this will be bold
you should escape <unknown> tags
< special entities work
&lt; if you want to escape it

Individual ampersands (&) and less-than signs (<) are fine, they will be shown as expected.

More Headers
More ways of doing headers:

# this is a huge header #
## this is a smaller header ##
### this is even smaller ###
#### more small ####
##### even smaller #####
###### smallest still: `<h6>` header
Output:

this is a huge header
this is a smaller header
this is even smaller
more small
even smaller
smallest still: <h6> header
You can use up to 6 # characters at the beginning of the line.

Code Highlighting
The Code highlighting used in the newforge is based on (http://www.freewisdom.org/projects/python-markdown/CodeHilite). It follows the same syntax as regular Markdown code blocks, except that there are two ways to tell the highlighter what language to use for the code block.

If the first line of the codeblock contains a shebang, the language is derived from that and line numbers are used.

    #!/usr/bin/python
    # Code goes here ...
Output:

1
2 #!/usr/bin/python
# Code goes here ...
 

If the first line contains a shebang, but the shebang line does not contain a path (a single / or even a space) or If the first line begins with three or more colons, the text following the colons identifies the language. In both cases, the first line is removed from the code block before processing.

    :::python
    # Code goes here ...
Output:

# Code goes here ...
You can also designate a code block by surrounding it with lines of tildes. The type of code highlighting to apply will be inferred based on the code within, or you can specify like above.

~~~~~~
<a href="#">My code</a>
~~~~~~
Output:

<a href="#">My code</a>
Includes
You can embed another wiki page directly:

[[include ref=SamplePage]]
No example output is available for this one because it only works on real wiki pages. Try it in your wiki!

Neighborhood Notifications
You can list updates from all projects in a neighborhood by tool type. Max_number (default is 5) and sort (default is pubdate) are optional:

[[neighborhood_feeds tool_name=Wiki max_number=10 sort=pubdate]]
Neighborhood Blog Posts
You can view blog posts from all projects in a neighborhood. Max_number (default is 5) and sort (default is timestamp) are optional:

[[neighborhood_blog_posts max_number=10 sort=timestamp]]
Project Blog Posts
You can view blog posts from all blogs in a project. Max_number (default is 5), mount point (leave empty to view posts from all blog tools in a project), and sort (default is timestamp) are optional:

[[project_blog_posts max_number=10 sort=timestamp mount_point=news]]
Download Button
You can display a download button that links to the best download available for the active project. Please note that if you use this macro and there is no download associated with your project, the button will not appear.

[[download_button]]
Project Screenshots
You can show all the screenshots for the current project as thumbnails that are linked to the full-size image.

[[project_screenshots]]
Thanks
Thanks to John Gruber and Aaron Swartz for creating Markdown.

This page is based on some examples from Greg Schueler, greg@vario.us

