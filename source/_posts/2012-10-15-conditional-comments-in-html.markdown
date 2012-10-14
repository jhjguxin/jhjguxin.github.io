---
layout: post
title: "Conditional comments in html"
date: 2012-08-20 11:31
comments: true
categories: ["web"]
tags: ["comments", "conditional", "html"]
---
## Conditional comments in html
Conditional comments only work in IE, and are thus excellently suited to give special instructions meant only for IE. They are supported from IE 5 onwards.

Conditional comments work as follows:
<pre>&lt;!--[if IE 6]&gt;
Special instructions for IE 6 here
&lt;![endif]--&gt;</pre>
<ol>
	<li>Their basic structure is the same as an HTML comment (<code>&lt;!-- --&gt;</code>). Therefore all other browsers will see them as normal comments and will ignore them entirely.</li>
	<li>IE, though, has been programmed to recognize the special <code>&lt;!--[if IE]&gt;</code> syntax, resolves the <code>if</code> and parses the content of the conditional comment as if it were normal page content.</li>
	<li>Since conditional comments use the <strong>HTML</strong> comment structure, they can only be included in HTML files, and not in CSS files. I'd have preferred to put the special styles in the CSS file, but that's impossible. You can also put an entire new <code>&lt;link&gt;</code> tag in the conditional comment referring to an extra style sheet.</li>
</ol>
<h3 id="link1">Example</h3>
Below I added a lot of conditional comments that print out messages according to your IE version.

<strong>Note</strong> however, that if you use multiple Explorers on one computer, the conditional comments will render as if all these Explorer versions are the highest Explorer version available on your machine (usually Explorer 6.0).
<h4 id="link2">Test</h4>
Below are a few conditional comments that reveal the IE version you're using.

According to the conditional comment this is not IE
<h4 id="link3">Code</h4>
The syntax I use is:
<pre>&lt;p&gt;
&lt;!--[if IE]&gt;
According to the conditional comment this is IE&lt;br /&gt;
&lt;![endif]--&gt;
&lt;!--[if IE 6]&gt;
According to the conditional comment this is IE 6&lt;br /&gt;
&lt;![endif]--&gt;
&lt;!--[if IE 7]&gt;
According to the conditional comment this is IE 7&lt;br /&gt;
&lt;![endif]--&gt;
&lt;!--[if IE 8]&gt;
According to the conditional comment this is IE 8&lt;br /&gt;
&lt;![endif]--&gt;
&lt;!--[if IE 9]&gt;
According to the conditional comment this is IE 9&lt;br /&gt;
&lt;![endif]--&gt;
&lt;!--[if gte IE 8]&gt;
According to the conditional comment this is IE 8 or higher&lt;br /&gt;
&lt;![endif]--&gt;
&lt;!--[if lt IE 9]&gt;
According to the conditional comment this is IE lower than 9&lt;br /&gt;
&lt;![endif]--&gt;
&lt;!--[if lte IE 7]&gt;
According to the conditional comment this is IE lower or equal to 7&lt;br /&gt;
&lt;![endif]--&gt;
&lt;!--[if gt IE 6]&gt;
According to the conditional comment this is IE greater than 6&lt;br /&gt;
&lt;![endif]--&gt;
&lt;!--[if !IE]&gt; --&gt;
According to the conditional comment this is not IE&lt;br /&gt;
&lt;!-- &lt;![endif]--&gt;
&lt;/p&gt;</pre>
Note the special syntax:
<ul>
	<li><code>gt</code>: greater than</li>
	<li><code>lte</code>: less than or equal to</li>
</ul>
Also note the last one. It has a different syntax, and its contents are shown in all browsers that are not IE:
<pre>&lt;!--[if !IE]&gt; --&gt;</pre>
<h3 id="link4">CSS hack?</h3>
Are conditional comments <a href="http://www.quirksmode.org/css/csshacks.html">CSS hacks</a>? Strictly speaking, yes, since they can serve to give special style instructions to some browsers. However, they do not rely on one browser bug to solve another one, as all true CSS hacks do. Besides, they can be used for more than CSS hacks only (though that rarely happens).

Since conditional comments are not based on a browser hack but on a deliberate feature I believe they are safe to use. Sure, other browsers could implement conditional comments, too (though as yet none have done so), but they're unlikely to react to the specific query <code>&lt;!--[if IE]&gt;</code>.

I use conditional comments, though sparingly. First I see if I can find a real CSS solution to an Explorer Windows problem. If I can't, though, I don't hesitate to use them.
<h3 id="link5">Comment tag</h3>
A reader told me IE8 and below also support the (non-standard) <code>&lt;comment&gt;</code> tag.
<pre>&lt;p&gt;This is &lt;comment&gt;not&lt;/comment&gt; IE.&lt;/p&gt;</pre>
This isnotIE.

This tag might be a replacement for the <code>!IE</code> conditional comment, but only if you target IE8 and below.
