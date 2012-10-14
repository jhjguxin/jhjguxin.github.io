---
layout: post
title: "Rails Form helpers"
date: 2011-12-21 23:22
comments: true
categories: ["rails", "ruby"]
tags: ["Form", "helpers", "rails"]
---
## Rails Form helpers
<h2>Rails Form helpers</h2>
Forms in web applications are an essential interface for user input. However, form markup can quickly become tedious to write and maintain because of form control naming and their numerous attributes. Rails deals away with these complexities by providing view helpers for generating form markup. However, since they have different use-cases, developers are required to know all the differences between similar helper methods before putting them to use.

Forms<span style="font-family: DejaVu Sans;">在</span>web<span style="font-family: DejaVu Sans;">应用程序中是一个必不可少的提供用户输入的</span>interface<span style="font-family: DejaVu Sans;">（接口）。然而，形式标记的编写和维护很快就变得十分乏味是因为表单控件的命名和它们的许多属性。</span>Rails<span style="font-family: DejaVu Sans;">处理这些复杂的（事物）通过提供</span>view helpers<span style="font-family: DejaVu Sans;">来创建</span>form markup<span style="font-family: DejaVu Sans;">。然而，自从有了不同的用户需求，开发人员需要知道所有的</span>similar helper <span style="font-family: DejaVu Sans;">方法间的的不同在使用它们之前。</span>

In this guide you will:<span style="font-family: DejaVu Sans;">在这个</span>guide<span style="font-family: DejaVu Sans;">中你可以了解到：</span>
<ul>
	<li>Create search forms and similar kind of generic forms not representing any specific model in your application<span style="font-family: DejaVu Sans;">在你的应用程序中，创建</span>search forms<span style="font-family: DejaVu Sans;">和生成类似的</span>forms<span style="font-family: DejaVu Sans;">它们不代表任何指定的</span>model</li>
	<li>Make model-centric forms for creation and editing of specific database records<span style="font-family: DejaVu Sans;">制造</span>model-centric forms<span style="font-family: DejaVu Sans;">来创建和编辑指定的数据库记录</span></li>
	<li>Generate select boxes from multiple types of data <span style="font-family: DejaVu Sans;">从多种数据生成</span>select boxes</li>
	<li>Understand the date and time helpers Rails provides <span style="font-family: DejaVu Sans;">明白</span>Rails<span style="font-family: DejaVu Sans;">提供的</span>date<span style="font-family: DejaVu Sans;">和</span>time helpers</li>
	<li>Learn what makes a file upload form different <span style="font-family: DejaVu Sans;">学习什么使得一个文件</span>upload form<span style="font-family: DejaVu Sans;">变得不同</span></li>
	<li>Learn some cases of building forms to external resources <span style="font-family: DejaVu Sans;">学习某些情况下为</span>external resources<span style="font-family: DejaVu Sans;">（外部资源）构建</span>forms</li>
	<li>Find out where to look for complex forms <span style="font-family: DejaVu Sans;">找出在哪里查找复杂的</span>forms</li>
</ul>
This guide is not intended to be a complete documentation of available form helpers and their arguments. Please visit <a href="http://api.rubyonrails.org/"><span style="color: #000080;"><span style="text-decoration: underline;">the</span></span><span style="color: #000080;"><span style="text-decoration: underline;">Rails</span></span><span style="color: #000080;"><span style="text-decoration: underline;">API</span></span><span style="color: #000080;"><span style="text-decoration: underline;">documentation</span></span></a> for a complete reference.

<span style="font-family: DejaVu Sans;">本教程不大算成为一个包含可用的</span>form helpers<span style="font-family: DejaVu Sans;">和它们的参数的完整的文档。请访问</span><a href="http://api.rubyonrails.org/"><span style="color: #000080;"><span style="text-decoration: underline;">the</span></span><span style="color: #000080;"><span style="text-decoration: underline;">Rails</span></span><span style="color: #000080;"><span style="text-decoration: underline;">API</span></span><span style="color: #000080;"><span style="text-decoration: underline;">documentation</span></span></a><span style="font-family: DejaVu Sans;">得到完整的参考。</span>
<h3><a name="dealing-with-basic-forms"></a>1 Dealing with Basic Forms</h3>
The most basic form helper is <tt>form_tag</tt>.<span style="font-family: DejaVu Sans;">最基本的</span>form helper<span style="font-family: DejaVu Sans;">是</span>form_tag<span style="font-family: DejaVu Sans;">。</span>

&lt;%= form_tag do %&gt;

Form contents

&lt;% end %&gt;

When called without arguments like this, it creates a <tt>&lt;form&gt;</tt> tag which, when submitted, will POST to the current page. For instance, assuming the current page is <tt>/home/index</tt>, the generated HTML will look like this (some line breaks added for readability):

<span style="font-family: DejaVu Sans;">当像这样无参调用时，它创建一个</span>&lt;form&gt;<span style="font-family: DejaVu Sans;">标签，当提交这个表单时，会提交到当前页面。作为实例，假设当前页面是</span><tt>/home/index</tt><span style="font-family: DejaVu Sans;"><tt>，创建的</tt></span><tt>HTML</tt><span style="font-family: DejaVu Sans;"><tt>将会像这样（有一些换行为了增加可读性）：</tt></span>

&lt;form accept-charset="UTF-8" action="/home/index" method="post"&gt;

&lt;div style="margin:0;padding:0"&gt;

&lt;input name="utf8" type="hidden" value="&amp;#x2713;" /&gt;

&lt;input name="authenticity_token" type="hidden" value="f755bb0ed134b76c432144748a6d4b7a7ddf2b71" /&gt;

&lt;/div&gt;

Form contents

&lt;/form&gt;

Now, you’ll notice that the HTML contains something extra: a <tt>div</tt> element with two hidden input elements inside. This div is important, because the form cannot be successfully submitted without it. The first input element with name <tt>utf8</tt> enforces browsers to properly respect your form’s character encoding and is generated for all forms whether their actions are “GET” or “POST”. The second input element with name <tt>authenticity_token</tt> is a security feature of Rails called <strong>cross-site</strong><strong> </strong><strong>request</strong><strong> </strong><strong>forgery</strong><strong> </strong><strong>protection</strong>, and form helpers generate it for every non-GET form (provided that this security feature is enabled). You can read more about this in the <a href="http://guides.rubyonrails.org/security.html#_cross_site_reference_forgery_csrf"><span style="color: #000080;"><span style="text-decoration: underline;">Security</span></span><span style="color: #000080;"><span style="text-decoration: underline;">Guide</span></span></a>.

<span style="font-family: DejaVu Sans;">现在，你将会注意到</span>HTML<span style="font-family: DejaVu Sans;">包含一些额外的东西：一个</span>div<span style="font-family: DejaVu Sans;">元素和在里边的两个隐藏的</span>input<span style="font-family: DejaVu Sans;">元素。这个</span>div<span style="font-family: DejaVu Sans;">很重要，因为如果没有它</span>form<span style="font-family: DejaVu Sans;">不能够成功的被提交。第一个</span>input<span style="font-family: DejaVu Sans;">元素有</span>name utf8<span style="font-family: DejaVu Sans;">会强制浏览器合适的遵循你的</span>form's<span style="font-family: DejaVu Sans;">的字符编码并且无论是它创建的所有</span>forms<span style="font-family: DejaVu Sans;">还是它们的</span>actions<span style="font-family: DejaVu Sans;">（<span style="font-family: Liberation Serif,Times New Roman,serif;">“</span></span>GET” or “POST”<span style="font-family: DejaVu Sans;">）。第二个</span>input<span style="font-family: DejaVu Sans;">元素使用</span>name <tt>authenticity_token</tt><span style="font-family: DejaVu Sans;"><tt>它是一个</tt></span><tt>Rails</tt><span style="font-family: DejaVu Sans;"><tt>的安全特性调用</tt><tt></tt></span><strong>cross-site</strong><strong> </strong><strong>request</strong><strong> </strong><strong>forgery</strong><strong> </strong><strong>protection<span style="font-family: DejaVu Sans;">（站间请求保护）</span></strong><span style="font-family: DejaVu Sans;"><strong>，并且</strong></span><strong>form</strong><strong> </strong><strong>helpers<span style="font-family: DejaVu Sans;">为每个</span></strong><strong>non-GET</strong><strong> </strong><strong>form</strong><strong> </strong><strong>(<span style="font-family: DejaVu Sans;">确保这个安全特性是有效的</span></strong><strong>)</strong><strong> </strong><span style="font-family: DejaVu Sans;"><strong>创建它。你可以阅读关于他的更多信息在</strong><strong></strong></span><a href="http://guides.rubyonrails.org/security.html#_cross_site_reference_forgery_csrf"><span style="color: #000080;"><span style="text-decoration: underline;">Security</span></span><span style="color: #000080;"><span style="text-decoration: underline;">Guide</span></span></a><span style="font-family: DejaVu Sans;"><strong>中。</strong></span>

Throughout this guide, the <tt>div</tt> with the hidden input elements will be excluded<span style="font-family: DejaVu Sans;">排除</span>from code samples for brevity<span style="font-family: DejaVu Sans;">短暂</span>.<span style="font-family: DejaVu Sans;">通过这个教程，</span>div<span style="font-family: DejaVu Sans;">里面的两个隐藏的</span>input<span style="font-family: DejaVu Sans;">元素将会从</span>samples code<span style="font-family: DejaVu Sans;">暂时排除。</span>
<h4><a name="a-generic-search-form"></a>1.1 A Generic Search Form<span style="font-family: WenQuanYi Micro Hei;">通用搜索表单</span></h4>
One of the most basic forms you see on the web is a search form. This form contains:

<span style="font-family: DejaVu Sans;">搜索表单是你在</span>web<span style="font-family: DejaVu Sans;">上最常见的基本表单之一。这个表单包含：</span>
<ol>
	<li>a form element with “GET” method,</li>
	<li>a label for the input,</li>
	<li>a text input element, and</li>
	<li>a submit element.</li>
</ol>
To create this form you will use <tt>form_tag</tt>, <tt>label_tag</tt>, <tt>text_field_tag</tt>, and <tt>submit_tag</tt>, respectively. Like this:

<span style="font-family: DejaVu Sans;">要创建这个表单你将会分别使用</span>form_tag,label_tag,text_field_tag,and submit_tag<span style="font-family: DejaVu Sans;">。</span>

&lt;%= form_tag("/search", :method =&gt; "get") do %&gt;

&lt;%= label_tag(:q, "Search for:") %&gt;

&lt;%= text_field_tag(:q) %&gt;

&lt;%= submit_tag("Search") %&gt;

&lt;% end %&gt;

This will generate the following HTML:<span style="font-family: DejaVu Sans;">这将会生成随后的</span>HTML<span style="font-family: DejaVu Sans;">：</span>

&lt;form accept-charset="UTF-8" action="/search" method="get"&gt;

&lt;label for="q"&gt;Search for:&lt;/label&gt;

&lt;input id="q" name="q" type="text" /&gt;#label <span style="font-family: DejaVu Sans;">和</span>input<span style="font-family: DejaVu Sans;">的</span>for<span style="font-family: DejaVu Sans;">和</span>id<span style="font-family: DejaVu Sans;">的值的统一是为了将它们关联起来选中</span>label<span style="font-family: DejaVu Sans;">则</span>input<span style="font-family: DejaVu Sans;">则被激活</span>

&lt;input name="commit" type="submit" value="Search" /&gt;

&lt;/form&gt;

For every form input, an ID attribute is generated from its name (“q” in the example). These IDs can be very useful for CSS styling or manipulation of form controls with JavaScript.

<span style="font-family: DejaVu Sans;">对于每个</span>form input<span style="font-family: DejaVu Sans;">，</span>ID<span style="font-family: DejaVu Sans;">属性被从它的</span>name<span style="font-family: DejaVu Sans;">生成（本例中是</span>q<span style="font-family: DejaVu Sans;">）。这些</span>IDs<span style="font-family: DejaVu Sans;">在</span>CSS styling<span style="font-family: DejaVu Sans;">中非常有用或者使用</span>JavaScript<span style="font-family: DejaVu Sans;">操作</span>form controls<span style="font-family: DejaVu Sans;">。</span>

Besides <tt>text_field_tag</tt> and <tt>submit_tag</tt>, there is a similar helper for <em>every</em> form control in HTML.<span style="font-family: DejaVu Sans;">下面的</span><tt>text_field_tag</tt> and <tt>submit_tag</tt><span style="font-family: DejaVu Sans;"><tt>，它们是每个</tt></span><tt>form</tt><tt> </tt><tt>control</tt><span style="font-family: DejaVu Sans;"><tt>在</tt></span><tt>HTML</tt><span style="font-family: DejaVu Sans;"><tt>中的</tt></span><tt>similar</tt><tt> </tt><tt>helper</tt><span style="font-family: DejaVu Sans;"><tt>。</tt></span>

Always use “GET” as the method for search forms. This allows users to bookmark a specific search and get back to it. More generally Rails encourages you to use the right HTTP verb for an action.

<span style="font-family: DejaVu Sans;">通常对</span>search forms<span style="font-family: DejaVu Sans;">使用<span style="font-family: Liberation Serif,Times New Roman,serif;">“</span></span>GET”<span style="font-family: DejaVu Sans;">方法。这允许用户将一个指定的搜索（的</span>url<span style="font-family: DejaVu Sans;">添加）书签并（通过这个书签）取回查询结果。更常规的方法</span>Rails<span style="font-family: DejaVu Sans;">鼓励你对于一个</span>HTTP <span style="font-family: DejaVu Sans;">动作使用正确的</span>verb(<span style="font-family: DejaVu Sans;">动词</span>)<span style="font-family: DejaVu Sans;">。</span>
<h4><a name="multiple-hashes-in-form-helper-calls"></a> 1.2 Multiple Hashes in Form Helper Calls</h4>
The <tt>form_tag</tt> helper accepts 2 arguments: the path for the action and an options hash. This hash specifies the method of form submission and HTML options such as the form element’s class.

<tt>form_tag</tt><tt> </tt><tt>helper</tt><span style="font-family: DejaVu Sans;"><tt>接收两个参数：</tt></span><tt>path</tt><span style="font-family: DejaVu Sans;"><tt>的值为动作的路径以及一个</tt></span><tt>options</tt><span style="font-family: DejaVu Sans;"><tt>的</tt></span><tt>hash</tt><span style="font-family: DejaVu Sans;"><tt>字典。</tt></span>

<span style="font-family: DejaVu Sans;"><tt>这个</tt></span><tt>hash</tt><span style="font-family: DejaVu Sans;"><tt>字典指定提交</tt></span><tt>form</tt><span style="font-family: DejaVu Sans;"><tt>的方法和（一些）</tt></span><tt>HTML</tt><span style="font-family: DejaVu Sans;"><tt>选项如</tt></span><tt>form</tt><span style="font-family: DejaVu Sans;"><tt>元素的</tt></span><tt>class</tt><span style="font-family: DejaVu Sans;"><tt>属性。</tt></span>

As with the <tt>link_to</tt> helper, the path argument doesn’t have to be given a string; it can be a hash of URL parameters recognizable by Rails’ routing mechanism, which will turn the hash into a valid URL. However, since both arguments to <tt>form_tag</tt> are hashes, you can easily run into a problem if you would like to specify both. For instance, let’s say you write this:

<span style="font-family: DejaVu Sans;">如同</span>link_to helper<span style="font-family: DejaVu Sans;">，</span>path<span style="font-family: DejaVu Sans;">参数不是必须是被提供给一个</span>string<span style="font-family: DejaVu Sans;">；它可以是被</span>Rails<span style="font-family: DejaVu Sans;">的</span>routing mechanism<span style="font-family: DejaVu Sans;">组织的一个</span>URL<span style="font-family: DejaVu Sans;">参数的</span>hash<span style="font-family: DejaVu Sans;">字典，他将转接</span>hash<span style="font-family: DejaVu Sans;">（键）到一个有效的</span>URL<span style="font-family: DejaVu Sans;">。然而，</span>

<span style="font-family: DejaVu Sans;">既然两个参数</span><tt>form_tag</tt><span style="font-family: DejaVu Sans;"><tt>都是</tt></span><tt>hash</tt><span style="font-family: DejaVu Sans;"><tt>字典形式，你可以容易的陷入一个问题如果你想指定他们两个。下面的实例，让告诉你写下如下代码：</tt></span>

form_tag(:controller =&gt; "people", :action =&gt; "search", :method =&gt; "get", :class =&gt; "nifty_form")

# =&gt; '&lt;form accept-charset="UTF-8" action="/people/search?method=get&amp;class=nifty_form" method="post"&gt;'

Here, <tt>method</tt> and <tt>class</tt> are appended to the query string of the generated URL because you even though you mean to write two hashes, you really only specified one. So you need to tell Ruby which is which by delimiting the first hash (or both) with curly brackets. This will generate the HTML you expect:

<span style="font-family: DejaVu Sans;">这里，</span>method<span style="font-family: DejaVu Sans;">和</span>class<span style="font-family: DejaVu Sans;">被添加到生成的</span>UIR<span style="font-family: DejaVu Sans;">的</span>query<span style="font-family: DejaVu Sans;">字符串中是因为即使你曾经意图写的两个</span>hash<span style="font-family: DejaVu Sans;">字段，你实际上只指定了一个。因此你需要告诉</span>Ruby<span style="font-family: DejaVu Sans;">其中的那一个被限制为第一个</span>hash<span style="font-family: DejaVu Sans;">（或者两个都）使用大括号。这是生成的</span>HTML<span style="font-family: DejaVu Sans;">你期望的：</span>

form_tag({:controller =&gt; "people", :action =&gt; "search"}, :method =&gt; "get", :class =&gt; "nifty_form")

# =&gt; '&lt;form accept-charset="UTF-8" action="/people/search" method="get"&gt;'
<h4><a name="helpers-for-generating-form-elements"></a> 1.3 Helpers for Generating Form Elements</h4>
Rails provides a series of helpers for generating form elements such as checkboxes, text fields, and radio buttons. These basic helpers, with names ending in “_tag” (such as <tt>text_field_tag</tt> and <tt>check_box_tag</tt>), generate just a single <tt>&lt;input&gt;</tt> element. The first parameter to these is always the name of the input. When the form is submitted, the name will be passed along with the form data, and will make its way to the <tt>params</tt> hash in the controller with the value entered by the user for that field. For example, if the form contains <tt>&lt;%=</tt><tt> </tt><tt>text_field_tag(:query)</tt><tt> </tt><tt>%&gt;</tt>, then you would be able to get the value of this field in the controller with <tt>params[:query]</tt>.

Rails<span style="font-family: DejaVu Sans;">提供一系列的</span>helpers<span style="font-family: DejaVu Sans;">来创建</span>form<span style="font-family: DejaVu Sans;">元素例如</span>checkboxes<span style="font-family: DejaVu Sans;">，</span>text fields<span style="font-family: DejaVu Sans;">以及</span>radio buttons<span style="font-family: DejaVu Sans;">。这些基本的</span>helpers<span style="font-family: DejaVu Sans;">，使用<span style="font-family: Liberation Serif,Times New Roman,serif;">“</span></span>_tag”<span style="font-family: DejaVu Sans;">结尾（例如</span><tt>text_field_tag</tt> and <tt>check_box_tag</tt><span style="font-family: DejaVu Sans;">），创建一个单独的</span>&lt;input&gt;<span style="font-family: DejaVu Sans;">元素。其第一个参数通常是</span>input<span style="font-family: DejaVu Sans;">的</span>name<span style="font-family: DejaVu Sans;">。当这个</span>form<span style="font-family: DejaVu Sans;">被提交的时候，名称也将会和</span>form data<span style="font-family: DejaVu Sans;">一起（提交），并且将会以它的方式将它和用户输入到</span>field<span style="font-family: DejaVu Sans;">中的值传递到</span>controller<span style="font-family: DejaVu Sans;">中的</span>params hash<span style="font-family: DejaVu Sans;">中。例如，如果</span>form<span style="font-family: DejaVu Sans;">包含</span><tt>&lt;%=</tt><tt> </tt><tt>text_field_tag(:query)</tt><tt> </tt><tt>%&gt;</tt><span style="font-family: DejaVu Sans;"><tt>，然后你可以在</tt></span><tt>controller</tt><span style="font-family: DejaVu Sans;"><tt>使用</tt><tt></tt></span><tt>params[:query]</tt><span style="font-family: DejaVu Sans;"><tt>获取这个</tt></span><tt>field</tt><span style="font-family: DejaVu Sans;"><tt>中的值。</tt></span>

When naming inputs, Rails uses certain conventions that make it possible to submit parameters with non-scalar values such as arrays or hashes, which will also be accessible in <tt>params</tt>. You can read more about them in <a href="http://guides.rubyonrails.org/form_helpers.html#understanding-parameter-naming-conventions"><span style="color: #000080;"><span style="text-decoration: underline;">chapter</span></span><span style="color: #000080;"><span style="text-decoration: underline;">7</span></span><span style="color: #000080;"><span style="text-decoration: underline;">of</span></span><span style="color: #000080;"><span style="text-decoration: underline;">this</span></span><span style="color: #000080;"><span style="text-decoration: underline;">guide</span></span></a>. For details on the precise usage of these helpers, please refer to the <a href="http://api.rubyonrails.org/classes/ActionView/Helpers/FormTagHelper.html"><span style="color: #000080;"><span style="text-decoration: underline;">API</span></span><span style="color: #000080;"><span style="text-decoration: underline;">documentation</span></span></a>.

<span style="font-family: DejaVu Sans;">当命名了</span>inputs<span style="font-family: DejaVu Sans;">，</span>Rails<span style="font-family: DejaVu Sans;">使用某些公约使得提交</span>parameters<span style="font-family: DejaVu Sans;">和</span>non-scalar<span style="font-family: DejaVu Sans;">（非标量）的值例如</span>arrays<span style="font-family: DejaVu Sans;">或者</span>hashes<span style="font-family: DejaVu Sans;">成为了可能，其也可以通过使用</span><tt>params</tt><span style="font-family: DejaVu Sans;"><tt>来访问。你可以阅读</tt><tt></tt></span><a href="http://guides.rubyonrails.org/form_helpers.html#understanding-parameter-naming-conventions"><span style="color: #000080;"><span style="text-decoration: underline;">chapter</span></span><span style="color: #000080;"><span style="text-decoration: underline;">7</span></span><span style="color: #000080;"><span style="text-decoration: underline;">of</span></span><span style="color: #000080;"><span style="text-decoration: underline;">this</span></span><span style="color: #000080;"><span style="text-decoration: underline;">guide</span></span></a><span style="font-family: DejaVu Sans;"><tt>来了解更多的信息。要知道这些</tt></span><tt>helpers</tt><span style="font-family: DejaVu Sans;"><tt>的精确用法的描述，请参阅</tt><tt></tt></span><a href="http://api.rubyonrails.org/classes/ActionView/Helpers/FormTagHelper.html"><span style="color: #000080;"><span style="text-decoration: underline;">API</span></span><span style="color: #000080;"><span style="text-decoration: underline;">documentation</span></span></a><span style="font-family: DejaVu Sans;"><tt>。</tt></span>
<h5><a name="checkboxes"></a>1.3.1 Checkboxes<span style="font-family: WenQuanYi Micro Hei;">复选框</span></h5>
Checkboxes are form controls that give the user a set of options they can enable or disable:

Checkboxes<span style="font-family: DejaVu Sans;">是</span>form<span style="font-family: DejaVu Sans;">控件它提供给用户一个设置选项这个选项可以选中和取消选中：</span>

&lt;%= check_box_tag(:pet_dog) %&gt;

&lt;%= label_tag(:pet_dog, "I own a dog") %&gt;

&lt;%= check_box_tag(:pet_cat) %&gt;

&lt;%= label_tag(:pet_cat, "I own a cat") %&gt;

This generates the following:<span style="font-family: DejaVu Sans;">这将生成随后的代码：</span>

&lt;input id="pet_dog" name="pet_dog" type="checkbox" value="1" /&gt;

&lt;label for="pet_dog"&gt;I own a dog&lt;/label&gt;

&lt;input id="pet_cat" name="pet_cat" type="checkbox" value="1" /&gt;

&lt;label for="pet_cat"&gt;I own a cat&lt;/label&gt;

The first parameter to <tt>check_box_tag</tt>, of course, is the name of the input. The second parameter, naturally, is the value of the input. This value will be included in the form data (and be present in <tt>params</tt>) when the checkbox is checked.

<tt>check_box_tag</tt><span style="font-family: DejaVu Sans;"><tt>的第一个参数，当然是</tt></span><tt>input</tt><span style="font-family: DejaVu Sans;"><tt>的</tt></span><tt>name</tt><span style="font-family: DejaVu Sans;"><tt>。第二个参数，自然地，是</tt></span><tt>input</tt><span style="font-family: DejaVu Sans;"><tt>输入的值。这个</tt></span><tt>value</tt><span style="font-family: DejaVu Sans;"><tt>将会包含在</tt></span><tt>form</tt><tt> </tt><tt>data</tt><span style="font-family: DejaVu Sans;"><tt>中（并且使用</tt></span><tt>params</tt><span style="font-family: DejaVu Sans;"><tt>表示）当</tt></span><tt>checkbox</tt><span style="font-family: DejaVu Sans;"><tt>被选中。</tt></span>
<h5><a name="radio-buttons"></a>1.3.2 Radio Buttons<span style="font-family: WenQuanYi Micro Hei;">单选按钮</span></h5>
Radio buttons, while similar to checkboxes, are controls that specify a set of options in which they are mutually exclusive (i.e., the user can only pick one):

<span style="font-family: DejaVu Sans;">单选框，它和复选框很类似，它是一种控件指定一些设置选项这些选项之间是相互排斥的（</span>i.e., <span style="font-family: DejaVu Sans;">用户仅仅只能选择一个）：</span>

&lt;%= radio_button_tag(:age, "child") %&gt;

&lt;%= label_tag(:age_child, "I am younger than 21") %&gt;

&lt;%= radio_button_tag(:age, "adult") %&gt;

&lt;%= label_tag(:age_adult, "I'm over 21") %&gt;

Output:<span style="font-family: DejaVu Sans;">输出：</span>

&lt;input id="age_child" name="age" type="radio" value="child" /&gt;

&lt;label for="age_child"&gt;I am younger than 21&lt;/label&gt;

&lt;input id="age_adult" name="age" type="radio" value="adult" /&gt;

&lt;label for="age_adult"&gt;I'm over 21&lt;/label&gt;

As with <tt>check_box_tag</tt>, the second parameter to <tt>radio_button_tag</tt> is the value of the input. Because these two radio buttons share the same name (age) the user will only be able to select one, and <tt>params[:age]</tt> will contain either “child” or “adult”.

<span style="font-family: DejaVu Sans;">正如</span><tt>check_box_tag</tt><span style="font-family: DejaVu Sans;"><tt>，</tt><tt></tt></span><tt>radio_button_tag</tt><span style="font-family: DejaVu Sans;"><tt>的第二个参数是</tt></span><tt>input</tt><span style="font-family: DejaVu Sans;"><tt>的</tt></span><tt>value</tt><span style="font-family: DejaVu Sans;"><tt>。因为这两个</tt></span><tt>radio</tt><tt> </tt><tt>buttons</tt><span style="font-family: DejaVu Sans;"><tt>分享相同的</tt></span><tt>name</tt><span style="font-family: DejaVu Sans;"><tt>（</tt></span><tt>age</tt><span style="font-family: DejaVu Sans;"><tt>）用户仅仅能够选择一个，并且</tt></span><tt>params[:age]</tt><span style="font-family: DejaVu Sans;"><tt>将会包含或者</tt><tt><span style="font-family: Liberation Serif,Times New Roman,serif;">“</span></tt></span><tt>child</tt><tt>”</tt><span style="font-family: DejaVu Sans;"><tt>或者</tt><tt><span style="font-family: Liberation Serif,Times New Roman,serif;">“</span></tt></span><tt>adult</tt><tt>”</tt><span style="font-family: DejaVu Sans;"><tt>。</tt></span>

Always use labels for checkbox and radio buttons. They associate text with a specific option and make it easier for users to click the inputs by expanding<span style="font-family: DejaVu Sans;">扩大</span>the clickable region.

<span style="font-family: DejaVu Sans;">经常把</span>checkbox<span style="font-family: DejaVu Sans;">或</span>radio button<span style="font-family: DejaVu Sans;">和</span>labels<span style="font-family: DejaVu Sans;">标签一起使用。他们<strong>将文字</strong></span><strong>text</strong><span style="font-family: DejaVu Sans;"><strong>和一个特定的选项管理起来并且通过扩大可点击区域使得用户能够更加容易点击。</strong></span>
<h4><a name="other-helpers-of-interest"></a>1.4 Other Helpers of Interest<span style="font-family: WenQuanYi Micro Hei;">其他有趣的</span>Helpers</h4>
Other form controls worth mentioning are textareas, password fields, hidden fields, search fields, telephone fields, URL fields and email fields:

<span style="font-family: DejaVu Sans;">其他值得一提的</span>form<span style="font-family: DejaVu Sans;">控件是</span>textareas<span style="font-family: DejaVu Sans;">，</span>password<span style="font-family: DejaVu Sans;">，</span>fields<span style="font-family: DejaVu Sans;">，</span>hidden fields<span style="font-family: DejaVu Sans;">，</span>search fields<span style="font-family: DejaVu Sans;">，</span>telephone fields<span style="font-family: DejaVu Sans;">，</span>URL fields<span style="font-family: DejaVu Sans;">和</span>email fields<span style="font-family: DejaVu Sans;">：</span>

other helpers of interest&lt;br /&gt;

&lt;%= label_tag(:message, "content") %&gt;

&lt;%= text_area_tag(:message, "Hi, nice site", :size =&gt; "24x6") %&gt;&lt;br /&gt;

&lt;%= label_tag(:password, "password") %&gt;

&lt;%= password_field_tag(:password) %&gt;&lt;br /&gt;

&nbsp;

&lt;%= hidden_field_tag(:parent_id, "5") %&gt;&lt;br /&gt;

&lt;%= label_tag(:user_name, "search:") %&gt;

&lt;%= search_field(:user, :name) %&gt;&lt;br /&gt;

&lt;%= label_tag(:user_phone, "phone") %&gt;

&lt;%= telephone_field(:user, :phone) %&gt;&lt;br /&gt;

&lt;%= label_tag(:user_homepage, "homepage") %&gt;

&lt;%= url_field(:user, :homepage) %&gt;&lt;br /&gt;

&lt;%= label_tag(:user_address, "address") %&gt;

&lt;%= email_field(:user, :address) %&gt;&lt;br /&gt;

Output:<span style="font-family: DejaVu Sans;">输出：</span>

&lt;label for="message"&gt;content&lt;/label&gt;

&lt;textarea cols="24" id="message" name="message" rows="6"&gt;Hi, nice site&lt;/textarea&gt;&lt;br /&gt;

&lt;label for="password"&gt;password&lt;/label&gt;

&lt;input id="password" name="password" type="password" /&gt;&lt;br /&gt;

&nbsp;

&lt;input id="parent_id" name="parent_id" type="hidden" value="5" /&gt;&lt;br /&gt;

&lt;label for="user_name"&gt;search:&lt;/label&gt;

&lt;input id="user_name" name="user[name]" size="30" type="search" /&gt;&lt;br /&gt;

&lt;label for="user_phone"&gt;phone&lt;/label&gt;

&lt;input id="user_phone" name="user[phone]" size="30" type="tel" /&gt;&lt;br /&gt;

&lt;label for="user_homepage"&gt;homepage&lt;/label&gt;

&lt;input id="user_homepage" name="user[homepage]" size="30" type="url" /&gt;&lt;br /&gt;

&lt;label for="user_address"&gt;address&lt;/label&gt;

&lt;input id="user_address" name="user[address]" size="30" type="email" /&gt;&lt;br /

Hidden inputs are not shown to the user but instead hold data like any textual input. Values inside them can be changed with JavaScript.

Hidden inputs<span style="font-family: DejaVu Sans;">不显示给用户但是它可以</span>hold<span style="font-family: DejaVu Sans;">任何文本形式数据的输入。</span>Hidden<span style="font-family: DejaVu Sans;">里面的值可以用</span>JavaScript<span style="font-family: DejaVu Sans;">改变。</span>

The search, telephone, URL, and email inputs are HTML5 controls. If you require your app to have a consistent experience in older browsers, you will need an HTML5 polyfill (provided by CSS and/or JavaScript). There is definitely <a href="https://github.com/Modernizr/Modernizr/wiki/HTML5-Cross-Browser-Polyfills"><span style="color: #000080;"><span style="text-decoration: underline;">no</span></span><span style="color: #000080;"><span style="text-decoration: underline;">shortage</span></span><span style="color: #000080;"><span style="text-decoration: underline;">of</span></span><span style="color: #000080;"><span style="text-decoration: underline;">solutions</span></span><span style="color: #000080;"><span style="text-decoration: underline;">for</span></span><span style="color: #000080;"><span style="text-decoration: underline;">this</span></span></a>, although a couple of popular tools at the moment are <span style="color: #000080;"><span style="text-decoration: underline;"><a href="http://www.modernizr.com/">Modernizr</a></span></span> and <span style="color: #000080;"><span style="text-decoration: underline;"><a href="http://yepnopejs.com/">yepnope</a></span></span>, which provide a simple way to add functionality based on the presence of detected HTML5 features.

search, telephone, URL, <span style="font-family: DejaVu Sans;">和</span>email inputs<span style="font-family: DejaVu Sans;">是</span>HTML5<span style="font-family: DejaVu Sans;">控件。如果你需要你的</span>app<span style="font-family: DejaVu Sans;">在旧的浏览器上面拥有兼容的体验，你将需要一个</span>HTML5 polyfill<span style="font-family: DejaVu Sans;">（</span>provided by CSS and/or JavaScript<span style="font-family: DejaVu Sans;">）。这里肯定</span><a href="https://github.com/Modernizr/Modernizr/wiki/HTML5-Cross-Browser-Polyfills"><span style="color: #000080;"><span style="text-decoration: underline;">no</span></span><span style="color: #000080;"><span style="text-decoration: underline;">shortage</span></span><span style="color: #000080;"><span style="text-decoration: underline;">of</span></span><span style="color: #000080;"><span style="text-decoration: underline;">solutions</span></span><span style="color: #000080;"><span style="text-decoration: underline;">for</span></span><span style="color: #000080;"><span style="text-decoration: underline;">this</span></span></a><span style="font-family: DejaVu Sans;">（没有针对此类问题一致的解决方法），即使现在有了一组广受欢迎的工具是</span><span style="color: #000080;"><span style="text-decoration: underline;"><a href="http://www.modernizr.com/">Modernizr</a></span></span> and <span style="color: #000080;"><span style="text-decoration: underline;"><a href="http://yepnopejs.com/">yepnope</a></span></span><span style="font-family: DejaVu Sans;">，他们提供了一个简单的方法来添加检测</span>HTML5<span style="font-family: DejaVu Sans;">特性功能是否存在。</span>

&nbsp;

If you’re using password input fields (for any purpose), you might want to configure your application to prevent those parameters from being logged. You can learn about this in the <a href="http://guides.rubyonrails.org/security.html#logging"><span style="color: #000080;"><span style="text-decoration: underline;">Security</span></span><span style="color: #000080;"><span style="text-decoration: underline;">Guide</span></span></a>.

<span style="font-family: DejaVu Sans;">如果你正在使用</span>password input fields<span style="font-family: DejaVu Sans;">（无论何种原因），你可能想配置你的应用程序以防止记录这些参数。你可以从</span><a href="http://guides.rubyonrails.org/security.html#logging"><span style="color: #000080;"><span style="text-decoration: underline;">Security</span></span><span style="color: #000080;"><span style="text-decoration: underline;">Guide</span></span></a><span style="font-family: DejaVu Sans;">中了解这些信息。</span>
<h3><a name="dealing-with-model-objects"></a>2 Dealing with Model Objects</h3>
<h4><a name="model-object-helpers"></a>2.1 Model Object Helpers</h4>
A particularly common task for a form is editing or creating a model object. While the <tt>*_tag</tt> helpers can certainly be used for this task they are somewhat verbose as for each tag you would have to ensure the correct parameter name is used and set the default value of the input appropriately. Rails provides helpers tailored to this task. These helpers lack the _tag suffix, for example <tt>text_field</tt>, <tt>text_area</tt>.

form<span style="font-family: DejaVu Sans;">的一个格外普遍的任务是编辑或创建一个</span>model<span style="font-family: DejaVu Sans;">对象。然而，无疑</span><tt>*_tag</tt><tt> </tt><tt>helpers</tt><span style="font-family: DejaVu Sans;"><tt>能够在这个任务中使用，他们有点繁琐，为每一个标签，你就必须确保使用中的参数名称的正确使用，并设置适当的输入的默认值。</tt></span><tt>Rails</tt><span style="font-family: DejaVu Sans;"><tt>为这个任务量身定制了</tt></span><tt>helpers</tt><span style="font-family: DejaVu Sans;"><tt>。这些</tt></span><tt>helpers</tt><span style="font-family: DejaVu Sans;"><tt>缺少</tt></span><tt>_tag</tt><tt> </tt><span style="font-family: DejaVu Sans;"><tt>后缀，例如</tt></span><tt>text_field,text_area.</tt>

For these helpers the first argument is the name of an instance variable and the second is the name of a method (usually an attribute) to call on that object. Rails will set the value of the input control to the return value of that method for the object and set an appropriate input name. If your controller has defined <tt>@person</tt> and that person’s name is Henry then a form containing:

<span style="font-family: DejaVu Sans;">对于这些</span>helpers<span style="font-family: DejaVu Sans;">第一个参数是实例变量的</span>name<span style="font-family: DejaVu Sans;">，第二个是方法的名称（通常是一个属性）来调用那个对象。</span>Rails<span style="font-family: DejaVu Sans;">将（传输）</span>input <span style="font-family: DejaVu Sans;">控件的值给该对象的方法的返回值，并设置一个适当的输入名称。如果你的控件</span>name<span style="font-family: DejaVu Sans;">已经被定义为</span><tt>@person</tt><span style="font-family: DejaVu Sans;"><tt>并且</tt><tt></tt></span><tt>person</tt><tt>’</tt><tt>s</tt><tt> </tt><tt>name</tt><tt> </tt><tt>is</tt><tt> </tt><tt>Henry</tt><span style="font-family: DejaVu Sans;"><tt>那么这个</tt></span><tt>form</tt><span style="font-family: DejaVu Sans;"><tt>包含：</tt></span>

<tt>&lt;%=</tt><tt> </tt><tt>text_field(:person,</tt><tt> </tt><tt>:name)</tt><tt> </tt><tt>%&gt;</tt>

will produce output similar to

&lt;input id="person_name" name="person[name]" type="text" value="Henry"/&gt;

Upon form submission the value entered by the user will be stored in <tt>params[:person][:name]</tt>. The <tt>params[:person]</tt> hash is suitable for passing to <tt>Person.new</tt> or, if <tt>@person</tt> is an instance of Person, <tt>@person.update_attributes</tt>. While the name of an attribute is the most common second parameter to these helpers this is not compulsory. In the example above, as long as person objects have a <tt>name</tt> and a <tt>name=</tt> method Rails will be happy.

<span style="font-family: DejaVu Sans;">在用户输入后，并由</span>form<span style="font-family: DejaVu Sans;">提交的值将会被存储在</span><tt>params[:person][:name]</tt><span style="font-family: DejaVu Sans;"><tt>中。</tt></span><tt>params[:person]</tt><span style="font-family: DejaVu Sans;"><tt>相当于</tt><tt></tt></span><tt>Person.new</tt><span style="font-family: DejaVu Sans;"><tt>，如果</tt></span><tt>@person</tt><span style="font-family: DejaVu Sans;"><tt>是一个</tt></span><tt>Person</tt><span style="font-family: DejaVu Sans;"><tt>的实例，则相当于</tt><tt></tt></span><tt>@person.update_attributes</tt><span style="font-family: DejaVu Sans;"><tt>。虽然这些</tt></span><tt>helpers</tt><span style="font-family: DejaVu Sans;"><tt>的属性名称最常见的是第二个参数，但这不是强制性的。在例子中，只要</tt></span><tt>Person</tt><span style="font-family: DejaVu Sans;"><tt>对象有一个名称和一个</tt></span><tt>name=method</tt><span style="font-family: DejaVu Sans;"><tt>那么</tt></span><tt>Rails</tt><span style="font-family: DejaVu Sans;"><tt>会很乐意。</tt></span>

You must pass the name of an instance variable, i.e. <tt>:person</tt> or <tt>"person"</tt>, not an actual instance of your model object.<span style="font-family: DejaVu Sans;">你必须提供一个实例变量的名称，</span>i.e. <tt>:person</tt> or <tt>"person"</tt><span style="font-family: DejaVu Sans;"><tt>，不是一个你</tt></span><tt>model</tt><span style="font-family: DejaVu Sans;"><tt>对象中实际的实例。</tt></span>

<strong>Rails</strong><strong> </strong><strong>provides</strong><strong> </strong><strong>helpers</strong><strong> </strong><strong>for</strong><strong> </strong><strong>displaying</strong><strong> </strong><strong>the</strong><strong> </strong><strong>validation</strong><strong> </strong><strong>errors</strong><strong> </strong><strong>associated</strong><strong> </strong><strong>with</strong><strong> </strong><strong>a</strong><strong> </strong><strong>model</strong><strong> </strong><strong>object.</strong><strong> </strong><strong>These</strong><strong> </strong><strong>are</strong><strong> </strong><strong>covered</strong><strong> </strong><strong>in</strong><strong> </strong><strong>detail</strong><strong> </strong><strong>by</strong><strong> </strong><strong>the</strong><strong> </strong><a href="http://guides.rubyonrails.org/active_record_validations_callbacks.html#displaying-validation-errors-in-the-view"><span style="color: #000080;"><span style="text-decoration: underline;"><strong>Active</strong></span></span><span style="color: #000080;"><span style="text-decoration: underline;"><strong>Record</strong></span></span><span style="color: #000080;"><span style="text-decoration: underline;"><strong>Validations</strong></span></span><span style="color: #000080;"><span style="text-decoration: underline;"><strong>and</strong></span></span><span style="color: #000080;"><span style="text-decoration: underline;"><strong>Callbacks</strong></span></span></a><strong> </strong><strong>guide.</strong>
<h4><a name="binding-a-form-to-an-object"></a>2.2 Binding a Form to an Object<span style="font-family: WenQuanYi Micro Hei;">将</span>form<span style="font-family: WenQuanYi Micro Hei;">和</span>Object<span style="font-family: WenQuanYi Micro Hei;">绑定</span></h4>
While this is an increase in comfort it is far from perfect. If Person has many attributes to edit then we would be repeating the name of the edited object many times. What we want to do is somehow bind a form to a model object, which is exactly what <tt>form_for</tt> does.

<span style="font-family: DejaVu Sans;">虽然添加的这些功能让我们（在使用中）感到舒适但离完美远远不够。如果</span>Person<span style="font-family: DejaVu Sans;">拥有多个属性需要编辑然后我们将会重复被编辑</span>object<span style="font-family: DejaVu Sans;">的</span>name<span style="font-family: DejaVu Sans;">很多次。我们想要（</span>Rails<span style="font-family: DejaVu Sans;">）做的是以某种方式将</span>model object<span style="font-family: DejaVu Sans;">和</span>form<span style="font-family: DejaVu Sans;">绑定，这也恰好是</span><tt>form_for</tt><span style="font-family: DejaVu Sans;"><tt>要做的。</tt></span>

Assume we have a controller for dealing with articles <tt>app/controllers/articles_controller.rb</tt>:

<span style="font-family: DejaVu Sans;"><tt>假设我们有一个</tt></span><tt>controller(app/controllers/articles_controller.rb)</tt><span style="font-family: DejaVu Sans;"><tt>来处理</tt></span><tt>articles:</tt>

def new

@article = Article.new

end

The corresponding view <tt>app/views/articles/new.html.erb</tt> using <tt>form_for</tt> looks like this:

&lt;%= form_for @article, :url =&gt; { :action =&gt; "create" }, :html =&gt; {:class =&gt; "nifty_form"} do |f| %&gt;

&lt;%= f.text_field :title %&gt;

&lt;%= f.text_area :body, :size =&gt; "60x12" %&gt;

&lt;%= f.submit "Create" %&gt;

&lt;% end %&gt;

There are a few things to note here:<span style="font-family: DejaVu Sans;">这里对其做的事情备注如下：</span>
<ol>
	<li><tt>@article</tt> is the actual object being edited. <tt>@article</tt><span style="font-family: DejaVu Sans;"><tt>是实际上被编辑的</tt></span><tt>object</tt></li>
	<li>There is a single hash of options. Routing options are passed in the <tt>:url</tt> hash, HTML options are passed in the <tt>:html</tt> hash. <span style="font-family: DejaVu Sans;">这里是一个单个</span>hash<span style="font-family: DejaVu Sans;">字典的选项。</span>Routing<span style="font-family: DejaVu Sans;">选项通过</span>:url hash<span style="font-family: DejaVu Sans;">键对提供，</span>HTML<span style="font-family: DejaVu Sans;">选项通过</span>:html hash<span style="font-family: DejaVu Sans;">键对提供</span></li>
	<li>The <tt>form_for</tt> method yields a <strong>form</strong><strong> </strong><strong>builder</strong> object (the <tt>f</tt> variable).</li>
	<li>Methods to create form controls are called <strong>on</strong> the form builder object <tt>f</tt><span style="font-family: DejaVu Sans;"><tt>创建</tt></span><tt>form</tt><span style="font-family: DejaVu Sans;"><tt>控件的方法是通过调用</tt></span><tt>object</tt><tt> </tt><tt>f</tt><span style="font-family: DejaVu Sans;"><tt>的</tt></span><tt>form</tt><tt> </tt><tt>builder</tt></li>
</ol>
The resulting HTML is:

&lt;form accept-charset="UTF-8" action="/articles/create" method="post" class="nifty_form"&gt;

&lt;input id="article_title" name="article[title]" size="30" type="text" /&gt;

&lt;textarea id="article_body" name="article[body]" cols="60" rows="12"&gt;&lt;/textarea&gt;

&lt;input name="commit" type="submit" value="Create" /&gt;

&lt;/form&gt;

The name passed to <tt>form_for</tt> controls the key used in <tt>params</tt> to access the form’s values. Here the name is <tt>article</tt> and so all the inputs have names of the form <tt>article[</tt><em>attribute_name</em><tt>]</tt>. Accordingly, in the <tt>create</tt> action <tt>params[:article]</tt> will be a hash with keys <tt>:title</tt> and <tt>:body</tt>. You can read more about the significance of input names in the parameter_names section.

<span style="font-family: DejaVu Sans;">通过</span><tt>form_for</tt><span style="font-family: DejaVu Sans;"><tt>控件的</tt></span><tt>name</tt><span style="font-family: DejaVu Sans;"><tt>以及</tt></span><tt>parmas</tt><span style="font-family: DejaVu Sans;"><tt>使用的关键字来接收</tt></span><tt>form</tt><span style="font-family: DejaVu Sans;"><tt>的值。这里的</tt></span><tt>name</tt><span style="font-family: DejaVu Sans;"><tt>是</tt></span><tt>article</tt><span style="font-family: DejaVu Sans;"><tt>并且</tt></span><tt>form</tt><span style="font-family: DejaVu Sans;"><tt>所有的</tt></span><tt>inputs</tt><span style="font-family: DejaVu Sans;"><tt>的</tt></span><tt>name</tt><span style="font-family: DejaVu Sans;"><tt>都是</tt><tt></tt></span><tt>article[</tt><em>attribute_name</em><tt>]</tt><span style="font-family: DejaVu Sans;"><tt>。因此，在</tt></span><tt>create</tt><tt> </tt><tt>action</tt><span style="font-family: DejaVu Sans;"><tt>中</tt><tt></tt></span><tt>params[:article]</tt><span style="font-family: DejaVu Sans;"><tt>将会有关键字</tt></span><tt>:title</tt><tt> </tt><tt>and</tt><tt> </tt><tt>:body</tt><span style="font-family: DejaVu Sans;"><tt>的</tt></span><tt>hash</tt><span style="font-family: DejaVu Sans;"><tt><strong>键值</strong></tt><tt>。你可以阅读更多的</tt></span><tt>input</tt><tt> </tt><tt>name</tt><span style="font-family: DejaVu Sans;"><tt>的含义在</tt><tt></tt></span><tt>parameter_names</tt><span style="font-family: DejaVu Sans;"><tt>章节。</tt></span>

The helper methods called on the form builder are identical<span style="font-family: DejaVu Sans;">相同一致</span>to the model object helpers except that it is not necessary to specify which object is being edited since this is already managed by the form builder.

<span style="font-family: DejaVu Sans;">这个调用</span>form builder<span style="font-family: DejaVu Sans;">的</span>helper<span style="font-family: DejaVu Sans;">方法除了不需要指定那个</span>object<span style="font-family: DejaVu Sans;">被编辑既然这已经交给</span>form builder<span style="font-family: DejaVu Sans;">管理，其他部分与</span>model object helpers<span style="font-family: DejaVu Sans;">一致。</span>

You can create a similar binding without actually creating <tt>&lt;form&gt;</tt> tags with the <tt>fields_for</tt> helper. This is useful for editing additional model objects with the same form. For example if you had a Person model with an associated ContactDetail model you could create a form for creating both like so:

<span style="font-family: DejaVu Sans;">你可以创建一个类似的</span>tags<span style="font-family: DejaVu Sans;">组合却没有真正的使用</span>fields_for helper<span style="font-family: DejaVu Sans;">创建</span>&lt;form&gt; tags<span style="font-family: DejaVu Sans;">。这在使用相同的</span>form<span style="font-family: DejaVu Sans;">编辑额外的对象的时候非常有用。例如如果你有一个</span>Person model<span style="font-family: DejaVu Sans;">以及相关联的</span>ContactDetail model<span style="font-family: DejaVu Sans;">你可以创建一个</span>form<span style="font-family: DejaVu Sans;">来创建他们两个如下：</span>

&lt;%= form_for @person, :url =&gt; { :action =&gt; "create" } do |person_form| %&gt;

&lt;%= person_form.text_field :name %&gt;

&lt;%= fields_for @person.contact_detail do |contact_details_form| %&gt;

&lt;%= contact_details_form.text_field :phone_number %&gt;

&lt;% end %&gt;

&lt;% end %&gt;

which produces the following output:

&lt;form accept-charset="UTF-8" action="/people/create" id="new_person" method="post"&gt;

&lt;input id="person_name" name="person[name]" size="30" type="text" /&gt;

&lt;input id="contact_detail_phone_number" name="contact_detail[phone_number]" size="30" type="text" /&gt;

&lt;/form&gt;

The object yielded by <tt>fields_for</tt> is a form builder like the one yielded by <tt>form_for</tt> (in fact <tt>form_for</tt> calls <tt>fields_for</tt> internally<span style="font-family: DejaVu Sans;">（在内部调用</span><tt>fields_for</tt><span style="font-family: DejaVu Sans;">）</span>).
<h4><a name="relying-on-record-identification"></a>2.3 Relying on Record Identification<span style="font-family: WenQuanYi Micro Hei;">依托于记录的识别</span></h4>
The Article model is directly available to users of the application, so — following the best practices for developing with Rails — you should declare it <strong>a</strong><strong> </strong><strong>resource</strong>:

Article<span style="font-family: DejaVu Sans;">模型是应用程序用户直接可用的，因此<span style="font-family: Liberation Serif,Times New Roman,serif;">——</span>遵循</span>Rails<span style="font-family: DejaVu Sans;">开发最好的实践<span style="font-family: Liberation Serif,Times New Roman,serif;">——</span>你应该声明它为一个</span><strong>resource</strong>:

resources :articles

Declaring a resource has a number of side-effects<span style="font-family: DejaVu Sans;">（官网上是</span>side-affects<span style="font-family: DejaVu Sans;">错别字？）</span>. See <a href="http://guides.rubyonrails.org/routing.html#resource-routing-the-rails-default"><span style="color: #000080;"><span style="text-decoration: underline;">Rails</span></span><span style="color: #000080;"><span style="text-decoration: underline;">Routing</span></span><span style="color: #000080;"><span style="text-decoration: underline;">From</span></span><span style="color: #000080;"><span style="text-decoration: underline;">the</span></span><span style="color: #000080;"><span style="text-decoration: underline;">Outside</span></span><span style="color: #000080;"><span style="text-decoration: underline;">In</span></span></a> for more information on setting up and using resources.

<span style="font-family: DejaVu Sans;">声明一个</span>resource<span style="font-family: DejaVu Sans;">会有一系列的副作用。查看</span><a href="http://guides.rubyonrails.org/routing.html#resource-routing-the-rails-default"><span style="color: #000080;"><span style="text-decoration: underline;">Rails</span></span><span style="color: #000080;"><span style="text-decoration: underline;">Routing</span></span><span style="color: #000080;"><span style="text-decoration: underline;">From</span></span><span style="color: #000080;"><span style="text-decoration: underline;">the</span></span><span style="color: #000080;"><span style="text-decoration: underline;">Outside</span></span><span style="color: #000080;"><span style="text-decoration: underline;">In</span></span></a><span style="font-family: DejaVu Sans;">来获取在设定和使用</span>resource<span style="font-family: DejaVu Sans;">的更多信息。</span>

When dealing with RESTful resources, calls to <tt>form_for</tt> can get significantly easier if you rely on <strong>record</strong><strong> </strong><strong>identification</strong>. In short, you can just pass the model instance and have Rails figure out model name and the rest:

<span style="font-family: DejaVu Sans;">当在处理</span>RESTful resources<span style="font-family: DejaVu Sans;">的时候，调用</span><tt>form_for</tt><span style="font-family: DejaVu Sans;"><tt>会明显简单的多如果你</tt></span><tt>rely</tt><tt> </tt><tt>on</tt><tt> </tt><strong>record</strong><strong> </strong><strong>identification</strong><span style="font-family: DejaVu Sans;"><tt>。简而言之，你可以仅仅通过</tt></span><tt>model</tt><span style="font-family: DejaVu Sans;"><tt>实例和</tt></span><tt>Rails</tt><span style="font-family: DejaVu Sans;"><tt>来</tt></span><tt>figure</tt><tt> </tt><tt>out</tt><span style="font-family: DejaVu Sans;"><tt>（谋取）</tt></span><tt>model</tt><tt> </tt><tt>name</tt><span style="font-family: DejaVu Sans;"><tt>或者重设它：</tt></span>

<tt>##</tt><tt> </tt><tt>Creating</tt><tt> </tt><tt>a</tt><tt> </tt><tt>new</tt><tt> </tt><tt>article</tt>

<tt>#</tt><tt> </tt><tt>long-style:</tt>

<tt>form_for(@article,</tt><tt> </tt><tt>:url</tt><tt> </tt><tt>=&gt;</tt><tt> </tt><tt>articles_path)</tt>

<tt>#</tt><tt> </tt><tt>same</tt><tt> </tt><tt>thing,</tt><tt> </tt><tt>short-style</tt><tt> </tt><tt>(record</tt><tt> </tt><tt>identification</tt><tt> </tt><tt>gets</tt><tt> </tt><tt>used):</tt>

<tt>form_for(@article)</tt>

&nbsp;

<tt>##</tt><tt> </tt><tt>Editing</tt><tt> </tt><tt>an</tt><tt> </tt><tt>existing</tt><tt> </tt><tt>article</tt>

<tt>#</tt><tt> </tt><tt>long-style:</tt>

<tt>form_for(@article,</tt><tt> </tt><tt>:url</tt><tt> </tt><tt>=&gt;</tt><tt> </tt><tt>article_path(@article),</tt><tt> </tt><tt>:html</tt><tt> </tt><tt>=&gt;</tt><tt> </tt><tt>{</tt><tt> </tt><tt>:method</tt><tt> </tt><tt>=&gt;</tt><tt> </tt><tt>"put"</tt><tt> </tt><tt>})</tt>

<tt>#</tt><tt> </tt><tt>short-style:</tt>

<tt>form_for(@article)</tt>

<tt>Notice</tt><tt> </tt><tt>how</tt><tt> </tt><tt>the</tt><tt> </tt><tt>short-style</tt><tt> </tt><tt>form_for</tt><tt> </tt><tt>invocation</tt><tt> </tt><tt>is</tt><tt> </tt><tt>conveniently</tt><tt> </tt><tt>the</tt><tt> </tt><tt>same,</tt><tt> </tt><tt>regardless</tt><tt> </tt><tt>of</tt><tt> </tt><tt>the</tt><tt> </tt><tt>record</tt><tt> </tt><tt>being</tt><tt> </tt><tt>new</tt><tt> </tt><tt>or</tt><tt> </tt><tt>existing.</tt><tt> </tt><tt>Record</tt><tt> </tt><tt>identification</tt><tt> </tt><tt>is</tt><tt> </tt><tt>smart</tt><tt> </tt><tt>enough</tt><tt> </tt><tt>to</tt><tt> </tt><tt>figure</tt><tt> </tt><tt>out</tt><tt> </tt><tt>if</tt><tt> </tt><tt>the</tt><tt> </tt><tt>record</tt><tt> </tt><tt>is</tt><tt> </tt><tt>new</tt><tt> </tt><tt>by</tt><tt> </tt><tt>asking</tt><tt> </tt><tt>record.new_record?.</tt><tt> </tt><tt>It</tt><tt> </tt><tt>also</tt><tt> </tt><tt>selects</tt><tt> </tt><tt>the</tt><tt> </tt><tt>correct</tt><tt> </tt><tt>path</tt><tt> </tt><tt>to</tt><tt> </tt><tt>submit</tt><tt> </tt><tt>to</tt><tt> </tt><tt>and</tt><tt> </tt><tt>the</tt><tt> </tt><tt>name</tt><tt> </tt><tt>based</tt><tt> </tt><tt>on</tt><tt> </tt><tt>the</tt><tt> </tt><tt>class</tt><tt> </tt><tt>of</tt><tt> </tt><tt>the</tt><tt> </tt><tt>object.</tt>

<span style="font-family: DejaVu Sans;"><tt>注意</tt></span><tt>short-style</tt><span style="font-family: DejaVu Sans;"><tt>的</tt></span><tt>form_for</tt><span style="font-family: DejaVu Sans;"><tt>的调用相对如此的方便，无论这个记录是刚开始还是已经存在了。</tt><tt></tt></span><tt>Record</tt><tt> </tt><tt>identification</tt><span style="font-family: DejaVu Sans;"><tt>能够智能识别如果记录是否是</tt></span><tt>new</tt><span style="font-family: DejaVu Sans;"><tt>通过询问</tt></span><tt>record.new_record?</tt><span style="font-family: DejaVu Sans;"><tt>。它也选择正确的提交路径并且它的</tt></span><tt>name</tt><span style="font-family: DejaVu Sans;"><tt>基于</tt></span><tt>object</tt><span style="font-family: DejaVu Sans;"><tt>的</tt></span><tt>class</tt><span style="font-family: DejaVu Sans;"><tt>。</tt></span>

<tt>Rails</tt><tt> </tt><tt>will</tt><tt> </tt><tt>also</tt><tt> </tt><tt>automatically</tt><tt> </tt><tt>set</tt><tt> </tt><tt>the</tt><tt> </tt><tt>class</tt><tt> </tt><tt>and</tt><tt> </tt><tt>id</tt><tt> </tt><tt>of</tt><tt> </tt><tt>the</tt><tt> </tt><tt>form</tt><tt> </tt><tt>appropriately:</tt><tt> </tt><tt>a</tt><tt> </tt><tt>form</tt><tt> </tt><tt>creating</tt><tt> </tt><tt>an</tt><tt> </tt><tt>article</tt><tt> </tt><tt>would</tt><tt> </tt><tt>have</tt><tt> </tt><tt>id</tt><tt> </tt><tt>and</tt><tt> </tt><tt>class</tt><tt> </tt><tt>new_article.</tt><tt> </tt><tt>If</tt><tt> </tt><tt>you</tt><tt> </tt><tt>were</tt><tt> </tt><tt>editing</tt><tt> </tt><tt>the</tt><tt> </tt><tt>article</tt><tt> </tt><tt>with</tt><tt> </tt><tt>id</tt><tt> </tt><tt>23,</tt><tt> </tt><tt>the</tt><tt> </tt><tt>class</tt><tt> </tt><tt>would</tt><tt> </tt><tt>be</tt><tt> </tt><tt>set</tt><tt> </tt><tt>to</tt><tt> </tt><tt>edit_article</tt><tt> </tt><tt>and</tt><tt> </tt><tt>the</tt><tt> </tt><tt>id</tt><tt> </tt><tt>to</tt><tt> </tt><tt>edit_article_23.</tt><tt> </tt><tt>These</tt><tt> </tt><tt>attributes</tt><tt> </tt><tt>will</tt><tt> </tt><tt>be</tt><tt> </tt><tt>omitted</tt><span style="font-family: DejaVu Sans;"><tt>省略</tt><tt></tt></span><tt>for</tt><tt> </tt><tt>brevity</tt><tt> </tt><tt>in</tt><tt> </tt><tt>the</tt><tt> </tt><tt>rest</tt><tt> </tt><tt>of</tt><tt> </tt><tt>this</tt><tt> </tt><tt>guide.</tt>

<tt>Rails</tt><span style="font-family: DejaVu Sans;"><tt>也会适当的自动的设置</tt></span><tt>form</tt><span style="font-family: DejaVu Sans;"><tt>（元素）的</tt></span><tt>class</tt><span style="font-family: DejaVu Sans;"><tt>和</tt></span><tt>id</tt><span style="font-family: DejaVu Sans;"><tt>：一个（用于）创建一个</tt></span><tt>article</tt><span style="font-family: DejaVu Sans;"><tt>的</tt></span><tt>fom</tt><span style="font-family: DejaVu Sans;"><tt>将会拥有</tt></span><tt>id</tt><span style="font-family: DejaVu Sans;"><tt>和</tt></span><tt>classnew_article</tt><span style="font-family: DejaVu Sans;"><tt>。如果你在正编辑</tt></span><tt>id</tt><span style="font-family: DejaVu Sans;"><tt>为</tt></span><tt>23</tt><span style="font-family: DejaVu Sans;"><tt>的</tt></span><tt>article</tt><span style="font-family: DejaVu Sans;"><tt>，它的</tt></span><tt>class</tt><span style="font-family: DejaVu Sans;"><tt>属性将会被设置为</tt></span><tt>edit_article</tt><span style="font-family: DejaVu Sans;"><tt>并且</tt></span><tt>id</tt><span style="font-family: DejaVu Sans;"><tt>为</tt></span><tt>edit_article_23</tt><span style="font-family: DejaVu Sans;"><tt>。为了教程的简洁，这些属性将会被部分忽略。</tt></span>

When you’re using STI (single-table inheritance) with your models, you can’t rely on record identification on a subclass if only their parent class is declared a resource. You will have to specify the model name, :url, and :method explicitly.

当你正在你的model中使用STI（single-table inheritance），你不能在一个子类中使用 rely on record identification除非他的父类被声明为一个resource。（那么）你将不得不准确的指定model name，:url,:method。
<h5><a name="dealing-with-namespaces"></a><tt>2.3.1</tt><tt> </tt><tt>Dealing</tt><tt> </tt><tt>with</tt><tt> </tt><tt>Namespaces</tt><span style="font-family: WenQuanYi Micro Hei;"><tt>使用名称空间处理（业务）</tt></span></h5>
If you have created namespaced routes, <tt>form_for</tt> has a nifty shorthand for that too. If your application has an admin namespace then

<span style="font-family: DejaVu Sans;"><tt>如果你已经创建一个</tt></span><tt>namespaced</tt><tt> </tt><tt>routes</tt><span style="font-family: DejaVu Sans;"><tt>，</tt></span><tt>form_for</tt><span style="font-family: DejaVu Sans;"><tt>拥有一个可爱的快捷操作来做这些。如果你的应用程序拥有一个</tt></span><tt>admin</tt><tt> </tt><tt>namespace</tt><span style="font-family: DejaVu Sans;"><tt>然后</tt></span>

<tt>form_for</tt><tt> </tt><tt>[:admin,</tt><tt> </tt><tt>@article]</tt>

<tt>will</tt><tt> </tt><tt>create</tt><tt> </tt><tt>a</tt><tt> </tt><tt>form</tt><tt> </tt><tt>that</tt><tt> </tt><tt>submits</tt><tt> </tt><tt>to</tt><tt> </tt><tt>the</tt><tt> </tt><tt>articles</tt><tt> </tt><tt>controller</tt><tt> </tt><tt>inside</tt><tt> </tt><tt>the</tt><tt> </tt><tt>admin</tt><tt> </tt><tt>namespace</tt><tt> </tt><tt>(submitting</tt><tt> </tt><tt>to</tt><tt> </tt><tt>admin_article_path(@article)</tt><tt> </tt><tt>in</tt><tt> </tt><tt>the</tt><tt> </tt><tt>case</tt><tt> </tt><tt>of</tt><tt> </tt><tt>an</tt><tt> </tt><tt>update).</tt><tt> </tt><tt>If</tt><tt> </tt><tt>you</tt><tt> </tt><tt>have</tt><tt> </tt><tt>several</tt><tt> </tt><tt>levels</tt><tt> </tt><tt>of</tt><tt> </tt><tt>namespacing</tt><tt> </tt><tt>then</tt><tt> </tt><tt>the</tt><tt> </tt><tt>syntax</tt><tt> </tt><tt>is</tt><tt> </tt><tt>similar:</tt>

<span style="font-family: DejaVu Sans;"><tt>将会创建一个</tt></span><tt>form</tt><span style="font-family: DejaVu Sans;"><tt>它会提交（信息）到在</tt></span><tt>admin</tt><tt> </tt><tt>namespace</tt><span style="font-family: DejaVu Sans;"><tt>（比如在</tt></span><tt>update</tt><span style="font-family: DejaVu Sans;"><tt>情况下会提交到</tt><tt></tt></span><tt>admin_article_path(@article)</tt><span style="font-family: DejaVu Sans;"><tt>）中的</tt></span><tt>articles</tt><tt> </tt><tt>controller</tt><span style="font-family: DejaVu Sans;"><tt>。如果你有一系列等级的</tt></span><tt>name</tt><tt> </tt><tt>spacing</tt><span style="font-family: DejaVu Sans;"><tt>然后将会有语法智能（处理他们）：</tt></span>

<tt>form_for</tt><tt> </tt><tt>[:admin,</tt><tt> </tt><tt>:management,</tt><tt> </tt><tt>@article]</tt>

<tt>For</tt><tt> </tt><tt>more</tt><tt> </tt><tt>information</tt><tt> </tt><tt>on</tt><tt> </tt><tt>Rails</tt><tt>’ </tt><tt>routing</tt><tt> </tt><tt>system</tt><tt> </tt><tt>and</tt><tt> </tt><tt>the</tt><tt> </tt><tt>associated</tt><tt> </tt><tt>conventions,</tt><tt> </tt><tt>please</tt><tt> </tt><tt>see</tt><tt> </tt><tt>the</tt><tt> </tt><a href="http://guides.rubyonrails.org/routing.html"><span style="color: #000080;"><span style="text-decoration: underline;">routing</span></span><span style="color: #000080;"><span style="text-decoration: underline;">guide</span></span></a><tt>.</tt>

<span style="font-family: DejaVu Sans;"><tt>得到更多的关于</tt></span><tt>Rails</tt><span style="font-family: DejaVu Sans;"><tt>的</tt></span><tt>routing</tt><span style="font-family: DejaVu Sans;"><tt>和关联约定，请阅读</tt><tt></tt></span><a href="http://guides.rubyonrails.org/routing.html"><span style="color: #000080;"><span style="text-decoration: underline;">routing</span></span><span style="color: #000080;"><span style="text-decoration: underline;">guide</span></span></a><span style="font-family: DejaVu Sans;"><tt>。</tt></span>
<h4><a name="how-do-forms-with-put-or-delete-methods-"></a> 2.4 How do forms with PUT or DELETE methods work?<span style="font-family: WenQuanYi Micro Hei;">表单的</span>PUT<span style="font-family: WenQuanYi Micro Hei;">或者</span>DELETE<span style="font-family: WenQuanYi Micro Hei;">方法是如何工作的</span></h4>
The Rails framework encourages RESTful design of your applications, which means you’ll be making a lot of “PUT” and “DELETE” requests (besides “GET” and “POST”). However, most browsers <em>don</em><em>’</em><em>t</em><em> </em><em>support</em> methods other than “GET” and “POST” when it comes to submitting forms.

Rails<span style="font-family: DejaVu Sans;">框架鼓励在你的应用程序中使用</span>RESTful<span style="font-family: DejaVu Sans;">风格设计，意思是你将会产生许多<span style="font-family: Liberation Serif,Times New Roman,serif;">“</span></span>PUT”<span style="font-family: DejaVu Sans;">和<span style="font-family: Liberation Serif,Times New Roman,serif;">“</span></span>DELETE”<span style="font-family: DejaVu Sans;">请求（在<span style="font-family: Liberation Serif,Times New Roman,serif;">“</span></span>GET”AND“POST”<span style="font-family: DejaVu Sans;">之后）。然而，大多数的浏览器在提交表单的时候并不支持超过<span style="font-family: Liberation Serif,Times New Roman,serif;">”</span></span>GET”AND”POST”<span style="font-family: DejaVu Sans;">之外的方法。</span>

Rails works around this issue by emulating<span style="font-family: DejaVu Sans;">模拟</span>other methods over POST with a hidden input named <tt>"_method"</tt>, which is set to reflect the desired method:

Rails<span style="font-family: DejaVu Sans;">围绕这个问题通过在</span>POST<span style="font-family: DejaVu Sans;">之外添加一个隐藏的（命名为</span><tt>"_method"</tt><span style="font-family: DejaVu Sans;">）</span>input<span style="font-family: DejaVu Sans;">标签来模拟其他的方法，这个</span>input<span style="font-family: DejaVu Sans;">标签被用来呈现所需的方法：</span>

form_tag(search_path, :method =&gt; "put")

output:

&lt;form accept-charset="UTF-8" action="/search" method="post"&gt;

&lt;div style="margin:0;padding:0"&gt;

&lt;input name="_method" type="hidden" value="put" /&gt;

&lt;input name="utf8" type="hidden" value="&amp;#x2713;" /&gt;

&lt;input name="authenticity_token" type="hidden" value="f755bb0ed134b76c432144748a6d4b7a7ddf2b71" /&gt;

&lt;/div&gt;

...

When parsing POSTed data, Rails will take into account the special <tt>_method</tt> parameter and acts as if the HTTP method was the one specified inside it (“PUT” in this example).

<span style="font-family: DejaVu Sans;">当解析</span>POSTed<span style="font-family: DejaVu Sans;">数据的时候，</span>Rails<span style="font-family: DejaVu Sans;">将会出进入指定的</span><tt>_method</tt><span style="font-family: DejaVu Sans;"><tt>参数并且如果有一个</tt></span><tt>HTTP</tt><span style="font-family: DejaVu Sans;"><tt>方法在里面被指定了（本例中是</tt><tt><span style="font-family: Liberation Serif,Times New Roman,serif;">”</span></tt></span><tt>PUT</tt><tt>”</tt><span style="font-family: DejaVu Sans;"><tt>）。</tt></span>
<h3><a name="making-select-boxes-with-ease"></a>3 Making Select Boxes with Ease<span style="font-family: WenQuanYi Micro Hei;">使用容易（的方式）来生成</span>Select Boxes</h3>
Select boxes in HTML require a significant<span style="font-family: DejaVu Sans;">（明显）</span>amount of markup (one <tt>OPTION</tt> element for each option to choose from), therefore it makes the most sense for them to be dynamically generated.

Select boxes<span style="font-family: DejaVu Sans;">在</span>HTML<span style="font-family: DejaVu Sans;">需要标明</span>markup<span style="font-family: DejaVu Sans;">的数量</span>(<span style="font-family: DejaVu Sans;">一个</span>OPTION<span style="font-family: DejaVu Sans;">元素对应需要选择的每一个选项</span>)<span style="font-family: DejaVu Sans;">，因此对于他们的动态生成这是有意义的。</span>

Here is what the markup might look like:<span style="font-family: DejaVu Sans;">这里是</span>markup<span style="font-family: DejaVu Sans;">可能的样子：</span>

&lt;select name="city_id" id="city_id"&gt;

&lt;option value="1"&gt;Lisbon&lt;/option&gt;

&lt;option value="2"&gt;Madrid&lt;/option&gt;

...

&lt;option value="12"&gt;Berlin&lt;/option&gt;

&lt;/select&gt;

Here you have a list of cities whose names are presented to the user. Internally the application only wants to handle their IDs so they are used as the options’ value attribute. Let’s see how Rails can help out here.

<span style="font-family: DejaVu Sans;">这里你有一个城市的列表这个列表的名字被呈现给用户。在应用程序的内部只希望处理它们的</span>IDs<span style="font-family: DejaVu Sans;">因此它们通过</span>option‘s<span style="font-family: DejaVu Sans;">的</span>value<span style="font-family: DejaVu Sans;">属性来使用。让我们看看</span>Rails<span style="font-family: DejaVu Sans;">是如何帮助输出这里的代码的。</span>
<h4><a name="the-select-and-option-tags"></a>3.1 The Select and Option Tags Select<span style="font-family: WenQuanYi Micro Hei;">和</span>Option<span style="font-family: WenQuanYi Micro Hei;">标签</span></h4>
The most generic helper is <tt>select_tag</tt>, which — as the name implies — simply generates the <tt>SELECT</tt> tag that encapsulates an options string:

<span style="font-family: DejaVu Sans;">最常见的生成器</span>helper<span style="font-family: DejaVu Sans;">是</span><tt>select_tag</tt><span style="font-family: DejaVu Sans;"><tt>，它</tt><tt><span style="font-family: Liberation Serif,Times New Roman,serif;">——</span></tt><tt>就像名字的意思</tt><tt><span style="font-family: Liberation Serif,Times New Roman,serif;">——</span></tt><tt>简单的生成</tt></span><tt>SELECT</tt><span style="font-family: DejaVu Sans;"><tt>标签在其中封装一个选项字符串：</tt></span>

<tt>&lt;%=</tt><tt> </tt><tt>select_tag(:city_id,</tt><tt> </tt><tt>'&lt;option</tt><tt> </tt><tt>value="1"&gt;Lisbon&lt;/option&gt;...')</tt><tt> </tt><tt>%&gt;</tt>

This is a start, but it doesn’t dynamically create the option tags. You can generate option tags with the <tt>options_for_select</tt> helper:

<span style="font-family: DejaVu Sans;">这是开始，但是它不会动态创建</span>option<span style="font-family: DejaVu Sans;">标签。你可以在</span><tt>options_for_select</tt><tt> </tt><tt>helper</tt><span style="font-family: DejaVu Sans;"><tt>中</tt>创建</span>option<span style="font-family: DejaVu Sans;">标签：</span>

&lt;%= options_for_select([['Lisbon', 1], ['Madrid', 2], ...]) %&gt;

&nbsp;

output:

&nbsp;

&lt;option value="1"&gt;Lisbon&lt;/option&gt;

&lt;option value="2"&gt;Madrid&lt;/option&gt;

...

The first argument to <tt>options_for_select</tt> is a nested array where each element has two elements: option text (city name) and option value (city id). The option value is what will be submitted to your controller. Often this will be the id of a corresponding database object but this does not have to be the case.

<tt>options_for_select</tt><span style="font-family: DejaVu Sans;"><tt>的第一个参数是一个嵌套数组它的的每一个元素有两个元素：</tt></span><tt>option</tt><tt> </tt><tt>text</tt><span style="font-family: DejaVu Sans;"><tt>（</tt></span><tt>city</tt><tt> </tt><tt>name</tt><span style="font-family: DejaVu Sans;"><tt>）和</tt></span><tt>option</tt><tt> </tt><tt>value</tt><span style="font-family: DejaVu Sans;"><tt>（</tt></span><tt>city</tt><tt> </tt><tt>id</tt><span style="font-family: DejaVu Sans;"><tt>）。这里的</tt></span><tt>option</tt><tt> </tt><tt>value</tt><span style="font-family: DejaVu Sans;"><tt>将会被提交到你的</tt></span><tt>controller</tt><span style="font-family: DejaVu Sans;"><tt>中。通常这里会有</tt></span><tt>id</tt><span style="font-family: DejaVu Sans;"><tt>和其相应的数据库对象但是并不完全是这样。</tt></span>

<tt>Knowing</tt><tt> </tt><tt>this,</tt><tt> </tt><tt>you</tt><tt> </tt><tt>can</tt><tt> </tt><tt>combine</tt><tt> </tt><tt>select_tag</tt><tt> </tt><tt>and</tt><tt> </tt><tt>options_for_select</tt><tt> </tt><tt>to</tt><tt> </tt><tt>achieve</tt><tt> </tt><tt>the</tt><tt> </tt><tt>desired,</tt><tt> </tt><tt>complete</tt><tt> </tt><tt>markup:</tt>

<span style="font-family: DejaVu Sans;">知道这些，你可结合</span><tt>select_tag</tt><span style="font-family: DejaVu Sans;"><tt>和</tt></span><tt>options_for_select</tt><span style="font-family: DejaVu Sans;"><tt>到达预期的（目标），完成</tt></span><tt>markup</tt><span style="font-family: DejaVu Sans;"><tt>：</tt></span>

<tt>&lt;%=</tt><tt> </tt><tt>select_tag(:city_id,</tt><tt> </tt><tt>options_for_select(...))</tt><tt> </tt><tt>%&gt;</tt>

<tt>options_for_select</tt> allows you to pre-select an option by passing its value.

<tt>options_for_select</tt><span style="font-family: DejaVu Sans;"><tt>允许你预选择一个选项通过它的值。</tt></span>

<tt>&lt;%=</tt><tt> </tt><tt>options_for_select([['Lisbon',</tt><tt> </tt><tt>1],</tt><tt> </tt><tt>['Madrid',</tt><tt> </tt><tt>2],</tt><tt> </tt><tt>...],</tt><tt> </tt><tt>2)</tt><tt> </tt><tt>%&gt;</tt>

&nbsp;

<tt>output:</tt>

&nbsp;

<tt>&lt;option</tt><tt> </tt><tt>value="1"&gt;Lisbon&lt;/option&gt;</tt>

<tt>&lt;option</tt><tt> </tt><tt>value="2"</tt><tt> </tt><tt>selected="selected"&gt;Madrid&lt;/option&gt;</tt>

<tt>...</tt>

bellow is my code in templates<span style="font-family: DejaVu Sans;">：</span>

&lt;!--it not work--&gt;

&nbsp;

&lt;%= select_tag(:city_id, '&lt;option value="1"&gt;Lisbon&lt;/option&gt;&lt;option value="2"&gt;Madrid&lt;/option&gt;') %&gt;

&nbsp;

&lt;%= options_for_select([['Lisbon', 1], ['Madrid', 2] ], 2)%&gt;

&nbsp;

&nbsp;

&nbsp;

combine select_tag and options_for_select combine select_tag and options_for_select:&lt;br /&gt;

&nbsp;

&lt;%= select_tag(:city_id, options_for_select([['Lisbon', 1], ['Madrid', 2] ], 2)) %&gt;

&nbsp;

Whenever Rails sees that the internal value of an option being generated matches this value, it will add the <tt>selected</tt> attribute to that option.

<span style="font-family: DejaVu Sans;">无论何时</span>Rails<span style="font-family: DejaVu Sans;">发现开始创建的</span>option tag<span style="font-family: DejaVu Sans;">的值匹配</span>option<span style="font-family: DejaVu Sans;">内部的值（设定的默认选中的值），</span>

<span style="font-family: DejaVu Sans;">，将会添加</span>selected<span style="font-family: DejaVu Sans;">属性到这个选项。</span>

The second argument to <tt>options_for_select</tt> must be exactly equal to the desired internal value. In particular if the value is the integer 2 you cannot pass “2” to <tt>options_for_select</tt> — you must pass 2. Be aware of values extracted from the <tt>params</tt> hash as they are all strings.

<tt>options_for_select</tt><span style="font-family: DejaVu Sans;"><tt>的第二个参数必须准确等于预期的内部的值。特别是如果这个值是整数</tt></span><tt>2</tt><span style="font-family: DejaVu Sans;"><tt>你不能传送</tt><tt><span style="font-family: Liberation Serif,Times New Roman,serif;">“</span></tt></span><tt>2</tt><tt>”</tt><span style="font-family: DejaVu Sans;"><tt>给</tt><tt></tt></span><tt>options_for_select</tt><tt>——</tt><span style="font-family: DejaVu Sans;"><tt>你必须传送</tt></span><tt>2</tt><span style="font-family: DejaVu Sans;"><tt>。在这个值来自</tt></span><tt>params</tt><tt> </tt><tt>hash</tt><span style="font-family: DejaVu Sans;"><tt>的时候你必须保持清醒因为它们全都是</tt></span><tt>strings</tt><span style="font-family: DejaVu Sans;"><tt>。</tt></span>
<h4><a name="select-boxes-for-dealing-with-models"></a> <tt>3.2</tt><tt> </tt><tt>Select</tt><tt> </tt><tt>Boxes</tt><tt> </tt><tt>for</tt><tt> </tt><tt>Dealing</tt><tt> </tt><tt>with</tt><tt> </tt><tt>Models</tt><span style="font-family: WenQuanYi Micro Hei;"><tt>使用</tt></span><tt>Select</tt><tt> </tt><tt>Boxes</tt><span style="font-family: WenQuanYi Micro Hei;"><tt>来处理</tt></span><tt>Models#</tt><span style="font-family: WenQuanYi Micro Hei;"><tt>外键的</tt></span><tt>select</tt><tt> </tt><tt>boxes</tt></h4>
In most cases form controls will be tied to a specific database model and as you might expect Rails provides helpers tailored for that purpose. Consistent with other form helpers, when dealing with models you drop the <tt>_tag</tt> suffix from <tt>select_tag</tt>:

<span style="font-family: DejaVu Sans;"><tt>在大多数情况中</tt></span><tt>form</tt><tt> </tt><tt>controls</tt><span style="font-family: DejaVu Sans;"><tt>将会被捆绑到一个指定的数据库</tt></span><tt>model</tt><span style="font-family: DejaVu Sans;"><tt>并且正如你可能期望</tt></span><tt>Rails</tt><span style="font-family: DejaVu Sans;"><tt>为捆绑的这个</tt></span><tt>models</tt><span style="font-family: DejaVu Sans;"><tt>提供量身定制的</tt></span><tt>helpers</tt><span style="font-family: DejaVu Sans;"><tt>。与其他</tt></span><tt>form</tt><tt> </tt><tt>helpers</tt><span style="font-family: DejaVu Sans;"><tt>一致的，当在处理</tt></span><tt>models</tt><span style="font-family: DejaVu Sans;"><tt>的时候你从</tt></span><tt>select_tag</tt><tt> </tt><span style="font-family: DejaVu Sans;"><tt>抛弃</tt></span><tt>_tag</tt><span style="font-family: DejaVu Sans;"><tt>后缀。</tt></span>

# controller:

@person = Person.new(:city_id =&gt; 2)

# view:

&lt;%= select(:person, :city_id, [['Lisbon', 1], ['Madrid', 2], ...]) %&gt;

Notice that the third parameter, the options array, is the same kind of argument you pass to <tt>options_for_select</tt>. One advantage here is that you don’t have to worry about pre-selecting the correct city if the user already has one — Rails will do this for you by reading from the <tt>@person.city_id</tt> attribute.

<span style="font-family: DejaVu Sans;">注意上面的第三个参数，这个选项数组，是相同的类型的参数你提供给</span><tt>options_for_select</tt><span style="font-family: DejaVu Sans;"><tt>（注意其中的省略号，它是省略了一些选项没有写出但是实际中不能这样写哦有就全部给出）。这里的一个优势就是你不用必须担心预选择正确的城市如果用户已经有一个</tt><tt><span style="font-family: Liberation Serif,Times New Roman,serif;">——</span></tt></span><tt>Rails</tt><span style="font-family: DejaVu Sans;"><tt>将会通过读取</tt></span><tt>@person.city_id</tt><span style="font-family: DejaVu Sans;"><tt>属性替你这些事情。</tt></span>

<tt>As</tt><tt> </tt><tt>with</tt><tt> </tt><tt>other</tt><tt> </tt><tt>helpers,</tt><tt> </tt><tt>if</tt><tt> </tt><tt>you</tt><tt> </tt><tt>were</tt><tt> </tt><tt>to</tt><tt> </tt><tt>use</tt><tt> </tt><tt>the</tt><tt> </tt><tt>select</tt><tt> </tt><tt>helper</tt><tt> </tt><tt>on</tt><tt> </tt><tt>a</tt><tt> </tt><tt>form</tt><tt> </tt><tt>builder</tt><tt> </tt><tt>scoped</tt><tt> </tt><tt>to</tt><tt> </tt><tt>the</tt><tt> </tt><tt>@person</tt><tt> </tt><tt>object,</tt><tt> </tt><tt>the</tt><tt> </tt><tt>syntax</tt><tt> </tt><tt>would</tt><tt> </tt><tt>be:</tt>

<span style="font-family: DejaVu Sans;">如同其他</span>helpers<span style="font-family: DejaVu Sans;">，如果你打算在一个作用域为</span><tt>@person</tt><span style="font-family: DejaVu Sans;"><tt>对象的</tt></span>form builder<span style="font-family: DejaVu Sans;">使用</span>select helper<span style="font-family: DejaVu Sans;">，语句将会是：</span>

# select on a form builder

&lt;%= f.select(:city_id, ...) %&gt;

If you are using <tt>select</tt> (or similar helpers such as <tt>collection_select</tt>, <tt>select_tag</tt>) to set a <tt>belongs_to</tt> association you <strong>must</strong><strong> </strong><strong>pass</strong><strong> </strong><strong>the</strong><strong> </strong><strong>name</strong><strong> </strong><strong>of</strong><strong> </strong><strong>the</strong><strong> </strong><span style="color: #800000;"><strong>foreign</strong></span><span style="color: #800000;"><strong>key</strong></span> (in the example above <tt>city_id</tt>), not the name of association itself. If you specify <tt>city</tt> instead of <tt>city_id</tt> Active Record will raise an error along the lines of <tt>ActiveRecord::AssociationTypeMismatch:</tt><tt> </tt><tt>City(#17815740)</tt><tt> </tt><tt>expected,</tt><tt> </tt><tt>got</tt><tt> </tt><tt>String(#1138750)</tt><tt> </tt>when you pass the <tt>params</tt> hash to <tt>Person.new</tt> or <tt>update_attributes</tt>. Another way of looking at this is that form helpers only edit attributes. You should also be aware of the potential<span style="font-family: DejaVu Sans;">潜在</span>security ramifications<span style="font-family: DejaVu Sans;">后果</span>of allowing users to edit foreign keys directly. You may wish to consider the use of <tt>attr_protected</tt> and <tt>attr_accessible</tt>. For further details on this, see the <a href="http://guides.rubyonrails.org/security.html#_mass_assignment"><span style="color: #000080;"><span style="text-decoration: underline;">Ruby</span></span><span style="color: #000080;"><span style="text-decoration: underline;">On</span></span><span style="color: #000080;"><span style="text-decoration: underline;">Rails</span></span><span style="color: #000080;"><span style="text-decoration: underline;">Security</span></span><span style="color: #000080;"><span style="text-decoration: underline;">Guide</span></span></a>.

you <strong>must</strong><strong> </strong><strong>pass</strong><strong> </strong><strong>the</strong><strong> </strong><strong>name</strong><strong> </strong><strong>of</strong><strong> </strong><strong>the</strong><strong> </strong><span style="color: #800000;"><strong>foreign</strong></span><span style="color: #800000;"><strong>key</strong></span> (in the example above <tt>city_id</tt>), not the name of association itself. <span style="font-family: DejaVu Sans;">你可以考虑使用</span><tt>attr_protected</tt> and <tt>attr_accessible</tt>.
<h4><a name="option-tags-from-a-collection-of-arbitra"></a> 3.3 Option Tags from a Collection of Arbitrary Objects <span style="font-family: WenQuanYi Micro Hei;">任意集合对象的</span>Option <span style="font-family: WenQuanYi Micro Hei;">标签</span></h4>
Generating options tags with <tt>options_for_select</tt> requires that you create an array containing the text and value for each option. But what if you had a City model (perhaps an Active Record one) and you wanted to generate option tags from a collection of those objects? One solution would be to make a nested array by iterating over them:

<span style="font-family: DejaVu Sans;">通常情况下</span><tt>options_for_select</tt><span style="font-family: DejaVu Sans;"><tt>的</tt></span><tt>option</tt><span style="font-family: DejaVu Sans;"><tt>标签需要你创建一个包含</tt></span><tt>text</tt><span style="font-family: DejaVu Sans;"><tt>和每个选项的的值的数组。但是如果你有一个</tt></span><tt>City</tt><tt> </tt><tt>model</tt><span style="font-family: DejaVu Sans;"><tt>（可能是</tt></span><tt>Active</tt><tt> </tt><tt>Record</tt><span style="font-family: DejaVu Sans;"><tt>中的一个）同时你想生成这些对象集合的选项？一个解决办法是产生一个迭代所有对象的嵌套数组：</tt></span>

<tt>&lt;%</tt><tt> </tt><tt>cities_array</tt><tt> </tt><tt>=</tt><tt> </tt><tt>City.all.map</tt><tt> </tt><tt>{</tt><tt> </tt><tt>|city|</tt><tt> </tt><tt>[city.name,</tt><tt> </tt><tt>city.id]</tt><tt> </tt><tt>}</tt><tt> </tt><tt>%&gt;</tt>

<tt>&lt;%=</tt><tt> </tt><tt>options_for_select(cities_array)</tt><tt> </tt><tt>%&gt;</tt>

This is a perfectly Pairs passed to <tt>options_for_select</tt> should have the name first and the id second, however with <tt>options_from_collection_for_select</tt> the first argument is the value method and the second the text method.valid solution, but Rails provides a less verbose alternative: <tt>options_from_collection_for_select</tt>. This helper expects a collection of arbitrary objects and two additional arguments: the names of the methods to read the option <strong>value</strong> and <strong>text</strong> from, respectively<span style="font-family: DejaVu Sans;">分别</span>:

<span style="font-family: DejaVu Sans;">这是一个完美有效的解决方法，但是</span>Rail<span style="font-family: DejaVu Sans;">提供一个更少累赘替代上面的方法：</span><tt>options_from_collection_for_select</tt>. <span style="font-family: DejaVu Sans;">这个</span>helper<span style="font-family: DejaVu Sans;">预订一个任意对象的集合和两个额外的参数：方法的</span>name<span style="font-family: DejaVu Sans;">来分别读取</span>option<span style="font-family: DejaVu Sans;">的</span>value<span style="font-family: DejaVu Sans;">和</span>text<span style="font-family: DejaVu Sans;">：</span>

&lt;%= options_from_collection_for_select(City.all, :id, :name) %&gt;

As the name implies, this only generates option tags. To generate a working select box you would need to use it in conjunction with <tt>select_tag</tt>, just as you would with <tt>options_for_select</tt>. When working with model objects, just as <tt>select</tt> combines <tt>select_tag</tt> and <tt>options_for_select</tt>, <tt>collection_select</tt> combines <tt>select_tag</tt> with <tt>options_from_collection_for_select</tt>.

<span style="font-family: DejaVu Sans;">正如其名，它仅仅生成</span>option tags<span style="font-family: DejaVu Sans;">。要生成一个能够工作的</span>select box<span style="font-family: DejaVu Sans;">你还需将其关联到</span><tt>select_tag</tt><span style="font-family: DejaVu Sans;"><tt>，就像你处理</tt><tt></tt></span><tt>options_for_select</tt><span style="font-family: DejaVu Sans;"><tt>一样的。当在</tt></span><tt>model</tt><span style="font-family: DejaVu Sans;"><tt>对象中工作的时候，就像</tt></span><tt>select</tt><span style="font-family: DejaVu Sans;"><tt>联合</tt><tt></tt></span><tt>select_tag</tt><span style="font-family: DejaVu Sans;"><tt>与</tt></span><tt>options_for_select</tt><span style="font-family: DejaVu Sans;"><tt>的情行，</tt><tt></tt></span><tt>collection_select</tt><span style="font-family: DejaVu Sans;"><tt>联合</tt></span><tt>select_tag</tt><span style="font-family: DejaVu Sans;"><tt>与</tt></span><tt>options_from_collection_for_select.</tt><tt><strong>#</strong></tt><span style="font-family: DejaVu Sans;"><tt><strong>这里好像说的是外键的</strong></tt></span><tt><strong>select</strong></tt><tt><strong> </strong></tt><tt><strong>boxes</strong></tt>

&lt;%= collection_select(:person, :city_id, City.all, :id, :name) %&gt;

To recap, <tt>options_from_collection_for_select</tt> is to <tt>collection_select</tt> what <tt>options_for_select</tt> is to <tt>select</tt>.

<span style="font-family: DejaVu Sans;">概括一下，</span><tt>options_from_collection_for_select</tt><span style="font-family: DejaVu Sans;"><tt>对于</tt><tt></tt></span><tt>collection_select</tt><span style="font-family: DejaVu Sans;"><tt>正如</tt><tt></tt></span><tt>options_for_select</tt><span style="font-family: DejaVu Sans;"><tt>对于</tt></span><tt>select</tt><span style="font-family: DejaVu Sans;"><tt>。</tt></span>

Pairs passed to <tt>options_for_select</tt> should have the<strong> </strong><strong>name</strong><strong> </strong><strong>first</strong><strong> </strong><strong>and</strong><strong> </strong><strong>the</strong><strong> </strong><strong>id</strong><strong> </strong><strong>second</strong>, however with <tt>options_from_collection_for_select</tt> the first argument is the value method and the second the text method.
<h4><a name="time-zone-and-country-select"></a>3.4 Time Zone and Country Select<span style="font-family: WenQuanYi Micro Hei;">时区和国家选择</span></h4>
To leverage time zone support in Rails, you have to ask your users what time zone they are in. Doing so would require generating select options from a list of pre-defined TimeZone objects using <tt>collection_select</tt>, but you can simply use the <tt>time_zone_select</tt> helper that already wraps this:

<span style="font-family: DejaVu Sans;">在</span>Rails<span style="font-family: DejaVu Sans;">利用时区支持，你必须询问你的用户他们处在什么时区。要这样做将在使用</span><tt>collection_select</tt><span style="font-family: DejaVu Sans;"><tt>的时候</tt></span>require<span style="font-family: DejaVu Sans;">来自预先定义列表中的一个</span>TimeZome <span style="font-family: DejaVu Sans;">对象的创建</span>select<span style="font-family: DejaVu Sans;">选项，但是你可以简单的使用</span><tt>time_zone_select</tt><tt> </tt><tt>helper</tt><span style="font-family: DejaVu Sans;"><tt>它已经包含了这些：</tt></span>

<tt>&lt;%=</tt><tt> </tt><tt>time_zone_select(:person,</tt><tt> </tt><tt>:time_zone)</tt><tt> </tt><tt>%&gt;</tt>

<tt>There</tt><tt> </tt><tt>is</tt><tt> </tt><tt>also</tt><tt> </tt><tt>time_zone_options_for_select</tt><tt> </tt><tt>helper</tt><tt> </tt><tt>for</tt><tt> </tt><tt>a</tt><tt> </tt><tt>more</tt><tt> </tt><tt>manual</tt><tt> </tt><tt>(therefore</tt><tt> </tt><tt>more</tt><tt> </tt><tt>customizable)</tt><tt> </tt><tt>way</tt><tt> </tt><tt>of</tt><tt> </tt><tt>doing</tt><tt> </tt><tt>this.</tt><tt> </tt><tt>Read</tt><tt> </tt><tt>the</tt><tt> </tt><tt>API</tt><tt> </tt><tt>documentation</tt><tt> </tt><tt>to</tt><tt> </tt><tt>learn</tt><tt> </tt><tt>about</tt><tt> </tt><tt>the</tt><tt> </tt><tt>possible</tt><tt> </tt><tt>arguments</tt><tt> </tt><tt>for</tt><tt> </tt><tt>these</tt><tt> </tt><tt>two</tt><tt> </tt><tt>methods.</tt>

<span style="font-family: DejaVu Sans;"><tt>这里同样也有</tt><tt></tt></span><tt>also</tt><tt> </tt><tt>time_zone_options_for_select</tt><tt> </tt><tt>helper</tt><span style="font-family: DejaVu Sans;"><tt>来手动的做这些（因此更具定制可能）。阅读</tt></span><tt>API</tt><span style="font-family: DejaVu Sans;"><tt>文档来了解这两个方法可能的参数。</tt></span>

Rails <em>used</em> to have a <tt>country_select</tt> helper for choosing countries, but this has been extracted to the <a href="https://github.com/chrislerum/country_select"><span style="color: #000080;"><span style="text-decoration: underline;">country_select</span></span><span style="color: #000080;"><span style="text-decoration: underline;">plugin</span></span></a>. When using this, be aware that the exclusion or inclusion of certain names from the list can be somewhat controversial (and was the reason this functionality was extracted from Rails).

Rails<span style="font-family: DejaVu Sans;">通常使用一个</span><tt>country_select</tt><span style="font-family: DejaVu Sans;"><tt>来选择国家，但是这是从</tt><tt></tt></span><a href="https://github.com/chrislerum/country_select"><span style="color: #000080;"><span style="text-decoration: underline;">country_select</span></span><span style="color: #000080;"><span style="text-decoration: underline;">plugin</span></span></a><span style="font-family: DejaVu Sans;"><tt>提取的。当使用这些，要知道来自</tt></span><tt>list</tt><span style="font-family: DejaVu Sans;"><tt>中排除或者列入的一些</tt></span><tt>names</tt><span style="font-family: DejaVu Sans;"><tt>可能有些争议（并且这也是这个功能从</tt></span><tt>Rails</tt><span style="font-family: DejaVu Sans;"><tt>中提取出来的原因）。</tt></span>
<h3><a name="using-date-and-time-form-helpers"></a>4 Using Date and Time Form Helpers</h3>
The date and time helpers differ from all the other form helpers in two important respects:

date and time helpers<span style="font-family: DejaVu Sans;">与其他所有的</span>form helpers<span style="font-family: DejaVu Sans;">都不相同（着重）表现在两个重要的方面：</span>
<ol>
	<li>Dates and times are not representable by a single input element. Instead you have several, one for each component (year, month, day etc.) and so there is no single value in your <tt>params</tt> hash with your date or time.</li>
</ol>
Dates and times<span style="font-family: DejaVu Sans;">不仅仅表现为单个</span>input element<span style="font-family: DejaVu Sans;">。对于每个组件中的一个（</span>year,month,day ect<span style="font-family: DejaVu Sans;">）取而代之你都有一些（</span>element<span style="font-family: DejaVu Sans;">）。因此在你的</span>params hash<span style="font-family: DejaVu Sans;">字典中没有你的</span>date or time<span style="font-family: DejaVu Sans;">的单个值。</span>
<ol start="2">
	<li>Other helpers use the <tt>_tag</tt> suffix to indicate<span style="font-family: DejaVu Sans;">说明</span>whether a helper is a barebones helper or one that operates on model objects. With dates and times, <tt>select_date</tt>, <tt>select_time</tt> and <tt>select_datetime</tt> are the barebones helpers, <tt>date_select</tt>, <tt>time_select</tt> and <tt>datetime_select</tt> are the equivalent model object helpers. <strong>#</strong><span style="font-family: DejaVu Sans;"><strong>交换了一下顺序</strong></span></li>
</ol>
<span style="font-family: DejaVu Sans;">其他</span>helpers<span style="font-family: DejaVu Sans;">使用</span><tt>_tag</tt><span style="font-family: DejaVu Sans;"><tt>后缀来说明一个</tt></span><tt>helper</tt><span style="font-family: DejaVu Sans;"><tt>是单纯的</tt></span><tt>helper</tt><span style="font-family: DejaVu Sans;"><tt>还是一个</tt></span><tt>model</tt><span style="font-family: DejaVu Sans;"><tt>对象的那样的操作。</tt></span>

Both of these families of helpers will create a series of select boxes for the different components (year, month, day etc.).

<span style="font-family: DejaVu Sans;">这些</span>helper<span style="font-family: DejaVu Sans;">的组员将会创建一系列的对应于不同的组件的</span>select boxes<span style="font-family: DejaVu Sans;">（</span>year, month, day etc.<span style="font-family: DejaVu Sans;">）。</span>
<h4><a name="barebones-helpers"></a>4.1 Barebones Helpers</h4>
The <tt>select_*</tt> family of helpers take as their first argument an instance of Date, Time or DateTime that is used as the currently selected value. You may omit this parameter, in which case the current date is used. For example

<span style="font-family: DejaVu Sans;"><tt>譬如</tt></span><tt>select_*</tt><tt> </tt><tt>helpers</tt><span style="font-family: DejaVu Sans;"><tt>成员获取</tt></span><tt>Date</tt><span style="font-family: DejaVu Sans;"><tt>实例作为它们的第一个变量，</tt></span><tt>Time</tt><tt> </tt><tt>or</tt><tt> </tt><tt>DateTime</tt><span style="font-family: DejaVu Sans;"><tt>使用的是当前选择的值。你可能忽略这个参数，在这种情况中</tt></span><tt>current</tt><tt> </tt><tt>date</tt><span style="font-family: DejaVu Sans;"><tt>会被使用。例如</tt></span>

<code>&lt;%=</code><tt> </tt><code>select_date</code><code> </code><code>Date.today,</code><code> </code><code>:prefix</code><tt> </tt><code>=&gt;</code><code> </code><code>:start_date</code><tt> </tt><code>%&gt;</code>

<tt>outputs</tt><tt> </tt><tt>(with</tt><tt> </tt><tt>actual</tt><tt> </tt><tt>option</tt><tt> </tt><tt>values</tt><tt> </tt><tt>omitted</tt><tt> </tt><tt>for</tt><tt> </tt><tt>brevity)</tt><span style="font-family: DejaVu Sans;"><tt>为了简洁省略了实际的选项值</tt></span><tt>#</tt><span style="font-family: DejaVu Sans;"><tt>省略号应该是相应的实际的日期和时间</tt></span>

&lt;select id="start_date_year" name="start_date[year]"&gt; ... &lt;/select&gt;

&lt;select id="start_date_month" name="start_date[month]"&gt; ... &lt;/select&gt;

&lt;select id="start_date_day" name="start_date[day]"&gt; ... &lt;/select&gt;

The above inputs would result in <tt>params[:start_date]</tt> being a hash with keys <tt>:year</tt>, <tt>:month</tt>, <tt>:day</tt>. To get an actual Time or Date object you would have to extract these values and pass them to the appropriate constructor, for example

<span style="font-family: DejaVu Sans;">完整的输入结果将会在</span><tt>params[:start_date]</tt><span style="font-family: DejaVu Sans;"><tt>他会是一个关键字是</tt></span><tt>:year,</tt><tt> </tt><tt>:month,</tt><tt> </tt><tt>:day</tt><span style="font-family: DejaVu Sans;"><tt>的</tt></span><tt>hash</tt><span style="font-family: DejaVu Sans;"><tt>字典。要得到一个实际的</tt></span><tt>Time</tt><tt> </tt><tt>or</tt><tt> </tt><tt>Date</tt><span style="font-family: DejaVu Sans;"><tt>对象你将不得不提取这些值并且转换他们为适合的结构，例如：</tt></span>

<tt>Date.civil(params[:start_date][:year].to_i,</tt><tt> </tt><tt>params[:start_date][:month].to_i,</tt><tt> </tt><tt>params[:start_date][:day].to_i)</tt>

The <tt>:prefix</tt> option is the key used to retrieve the hash of date components from the <tt>params</tt> hash. Here it was set to <tt>start_date</tt>, if omitted it will default to <tt>date</tt>.

<tt>:prefix</tt><span style="font-family: DejaVu Sans;"><tt>选项是用来接收来自</tt></span><tt>params</tt><tt> </tt><tt>hash</tt><span style="font-family: DejaVu Sans;"><tt>的</tt></span><tt>hash</tt><span style="font-family: DejaVu Sans;"><tt>形式的</tt></span><tt>date</tt><span style="font-family: DejaVu Sans;"><tt>组件的关键。这里它被设置为</tt><tt></tt></span><tt>start_date</tt><span style="font-family: DejaVu Sans;"><tt>，如果省略形式的话默认是</tt></span><tt>date</tt><span style="font-family: DejaVu Sans;"><tt>。</tt></span>
<h4><a name="select-model-object-helpers"></a><tt>4.2</tt><tt> </tt><tt>Model</tt><tt> </tt><tt>Object</tt><tt> </tt><tt>Helpers</tt></h4>
<tt>select_date</tt> does not work well with forms that update or create Active Record objects as Active Record expects<span style="font-family: DejaVu Sans;">预计</span>each element of the <tt>params</tt> hash to correspond to one attribute. The model object helpers for dates and times submit parameters with special names, when Active Record sees parameters with such names it knows they must be combined with the other parameters and given to a constructor appropriate to the column type. For example:

<tt>select_date</tt><span style="font-family: DejaVu Sans;"><tt>（这个是单纯的</tt></span><tt>helper</tt><span style="font-family: DejaVu Sans;"><tt>）在</tt></span><tt>update</tt><tt> </tt><tt>or</tt><tt> </tt><tt>create</tt><tt> </tt><tt>Active</tt><tt> </tt><tt>Record</tt><span style="font-family: DejaVu Sans;"><tt>对象的时候</tt>预置每个</span>params hash<span style="font-family: DejaVu Sans;">字典的</span>element<span style="font-family: DejaVu Sans;">对应到一个属性不会很好的工作。</span>Dates and times <span style="font-family: DejaVu Sans;">的</span>model object helpers<span style="font-family: DejaVu Sans;">提交参数通过指定的</span>names<span style="font-family: DejaVu Sans;">，当</span>Active Record<span style="font-family: DejaVu Sans;">发现这些参数时，它知道它们必须结合其他参数以及每一列（属性</span>year, month, day etc.<span style="font-family: DejaVu Sans;">）被给予一个合适的结构。例如：</span>

&lt;%= date_select :person, :birth_date %&gt;

outputs (with actual option values omitted for brevity)<span style="font-family: DejaVu Sans;">将实际的</span>option<span style="font-family: DejaVu Sans;">的</span>values<span style="font-family: DejaVu Sans;">忽略以精简</span>

&lt;select id="person_birth_date_1i" name="person[birth_date(1i)]"&gt; ... &lt;/select&gt;

&lt;select id="person_birth_date_2i" name="person[birth_date(2i)]"&gt; ... &lt;/select&gt;

&lt;select id="person_birth_date_3i" name="person[birth_date(3i)]"&gt; ... &lt;/select&gt;

which results in a <tt>params</tt> hash like

{:person =&gt; {'birth_date(1i)' =&gt; '2008', 'birth_date(2i)' =&gt; '11', 'birth_date(3i)' =&gt; '22'}}

When this is passed to <tt>Person.new</tt> (or <tt>update_attributes</tt>), Active Record spots that these parameters should all be used to construct the <tt>birth_date</tt> attribute and uses the suffixed information to determine in which order it should pass these parameters to functions such as <tt>Date.civil</tt>.

<span style="font-family: DejaVu Sans;">当这些信息提交给</span>Person.new<span style="font-family: DejaVu Sans;">（</span><tt>update_attributes</tt><span style="font-family: DejaVu Sans;">），</span>Active Record<span style="font-family: DejaVu Sans;">指出所有的这些参数应该使用于</span><tt>birth_date</tt><tt> </tt><tt>attribute</tt><tt> </tt><span style="font-family: DejaVu Sans;"><tt>结构并且使用后缀声明使得它能够传递这些参数给功能（方法）例如</tt><tt></tt></span><tt>Date.civil</tt><span style="font-family: DejaVu Sans;"><tt>。</tt></span>
<h4><a name="common-options"></a>4.3 Common Options</h4>
Both families of helpers use the same core set of functions to generate the individual select tags and so both accept largely the same options. In particular, by default Rails will generate year options 5 years either side of the current year. If this is not an appropriate range, the <tt>:start_year</tt> and <tt>:end_year</tt> options override this. For an exhaustive list of the available options, refer to the <a href="http://api.rubyonrails.org/classes/ActionView/Helpers/DateHelper.html"><span style="color: #000080;"><span style="text-decoration: underline;">API</span></span><span style="color: #000080;"><span style="text-decoration: underline;">documentation</span></span></a>.

helpers<span style="font-family: DejaVu Sans;">的所有成员都使用相同的</span>core set of functions<span style="font-family: DejaVu Sans;">来构建个体的</span>select <span style="font-family: DejaVu Sans;">标签因此同样能够接收大量相同的</span>options<span style="font-family: DejaVu Sans;">。以其一为例，默认情况下</span>year options<span style="font-family: DejaVu Sans;">中</span>Rails<span style="font-family: DejaVu Sans;">将会创建在当前年份的上和下</span>5<span style="font-family: DejaVu Sans;">年。如果这不是一个合适的范围，</span><tt>:start_year</tt> and <tt>:end_year</tt><span style="font-family: DejaVu Sans;"><tt>选项将会覆盖默认的范围。要得到可用选项的全面的列表，参考</tt><tt></tt></span><a href="http://api.rubyonrails.org/classes/ActionView/Helpers/DateHelper.html"><span style="color: #000080;"><span style="text-decoration: underline;">API</span></span><span style="color: #000080;"><span style="text-decoration: underline;">documentation</span></span></a><span style="font-family: DejaVu Sans;"><tt>。</tt></span>

As a rule of thumb you should be using <tt>date_select</tt> when working with model objects and <tt>select_date</tt> in other cases, such as a search form which filters results by date.

<span style="font-family: DejaVu Sans;">一个规则指引你在处理</span>model objects<span style="font-family: DejaVu Sans;">的时候使用</span>date_select<span style="font-family: DejaVu Sans;">在其他情况的时候使用</span>select_date<span style="font-family: DejaVu Sans;">，比如一个</span>search form<span style="font-family: DejaVu Sans;">它过滤日期作获取结果。</span>

In many cases the built-in date pickers are clumsy as they do not aid the user in working out the relationship between the date and the day of the week.

<span style="font-family: DejaVu Sans;">在许多情况下，内置的日期选择器是笨拙的，因为他们对计算出日期和工作日关系的用户没有援助。</span>
<h4><a name="individual-components"></a>4.4 Individual Components<span style="font-family: WenQuanYi Micro Hei;">个体组件</span></h4>
Occasionally you need to display just a single date component such as a year or a month. Rails provides a series of helpers for this, one for each component <tt>select_year</tt>, <tt>select_month</tt>, <tt>select_day</tt>, <tt>select_hour</tt>, <tt>select_minute</tt>, <tt>select_second</tt>. These helpers are fairly straightforward. By default they will generate an input field named after the time component (for example “year” for <tt>select_year</tt>, “month” for <tt>select_month</tt> etc.) although this can be overridden with the <tt>:field_name</tt> option. The <tt>:prefix</tt> option works in the same way that it does for <tt>select_date</tt> and <tt>select_time</tt> and has the same default value.

<span style="font-family: DejaVu Sans;">偶然情况下你需要仅仅显示单个日期组件如</span>year or month<span style="font-family: DejaVu Sans;">。</span>Rails<span style="font-family: DejaVu Sans;">提供一些</span>helpers<span style="font-family: DejaVu Sans;">来做这些，给每一个组件</span><tt>select_year</tt>, <tt>select_month</tt>, <tt>select_day</tt>, <tt>select_hour</tt>, <tt>select_minute</tt>, <tt>select_second</tt><span style="font-family: DejaVu Sans;">。这些</span>helpers<span style="font-family: DejaVu Sans;">相当的简单。默认情况下他们将会创建一个</span>input field<span style="font-family: DejaVu Sans;">并以时间组件命名（例如<span style="font-family: Liberation Serif,Times New Roman,serif;"> “</span></span>year” for <tt>select_year</tt>, “month” for <tt>select_month</tt> etc.<span style="font-family: DejaVu Sans;">）即使这会覆盖</span><tt>:field_name</tt><span style="font-family: DejaVu Sans;"><tt>选项。</tt></span><tt>:prefix</tt><span style="font-family: DejaVu Sans;"><tt>以一样的方式工作，对于</tt></span><tt>select_date</tt><tt> </tt><tt>and</tt><tt> </tt><tt>select_time</tt><span style="font-family: DejaVu Sans;"><tt>会设置同样的默认值。</tt></span>

<tt>&lt;%=</tt><tt> </tt><tt>select_year(2011)</tt><tt> </tt><tt>%&gt;</tt>

<tt>&lt;%=</tt><tt> </tt><tt>select_year(Time.now)</tt><tt> </tt><tt>%&gt;</tt>

will produce the same output if the current year is 2011 and the value chosen by the user can be retrieved by <tt>params[:date][:year]</tt>.
<h3><a name="uploading-files"></a>5 Uploading Files</h3>
A common task is uploading some sort of file, whether it’s a picture of a person or a CSV file containing data to process. The most important thing to remember with file uploads is that the rendered form’s encoding <strong>MUST</strong> be set to “multipart/form-data”. If you use <tt>form_for</tt>, this is done automatically. If you use <tt>form_tag</tt>, you must set it yourself, as per the following example.

The following two forms both upload a file.

<span style="font-family: DejaVu Sans;">一个常用的任务是上传一些种类的文件，无论在上传进程中的是一个个人图片还是一个包含数据</span>CSV<span style="font-family: DejaVu Sans;">文件。文件上传中重点要注意的事情是</span>rendered <span style="font-family: DejaVu Sans;">表单的编码<span style="color: #800000;"><strong>必须被设置成</strong></span>是<span style="font-family: Liberation Serif,Times New Roman,serif;">“</span></span>multipart/form-data”. <span style="font-family: DejaVu Sans;">如果你使用的</span><tt>form_for</tt><span style="font-family: DejaVu Sans;"><tt>，这将被自动完成。如果你使用</tt><tt></tt></span><tt>form_tag</tt><span style="font-family: DejaVu Sans;"><tt>，你必须自己设置它，在随后的每个例子中。后面的两个表单都是上传一个文件。</tt></span>

&nbsp;

&lt;%= form_tag({:action =&gt; :upload}, :multipart =&gt; true) do %&gt;

&lt;%= file_field_tag 'picture' %&gt;

&lt;% end %&gt;

&nbsp;

&lt;%= form_for @person do |f| %&gt;

&lt;%= f.file_field :picture %&gt;

&lt;% end %&gt;

Since Rails 3.1, forms rendered using <tt>form_for</tt> have their encoding set to <tt>multipart/form-data</tt> automatically once a <tt>file_field</tt> is used inside the block. Previous versions required you to set this explicitly.

<span style="font-family: DejaVu Sans;">从</span>Rails3.1,form<span style="font-family: DejaVu Sans;">使用</span>form_for<span style="font-family: DejaVu Sans;">来</span>render<span style="font-family: DejaVu Sans;">一旦在</span>block<span style="font-family: DejaVu Sans;">中有一个</span><tt>file_field</tt><span style="font-family: DejaVu Sans;"><tt>被使用编码自动设置为</tt><tt></tt></span><tt>multipart/form-data</tt><span style="font-family: DejaVu Sans;"><tt>。以前的版本需要你准确的设置为这样的编码。</tt></span>

Rails provides the usual pair of helpers: the barebones <tt>file_field_tag</tt> and the model oriented <tt>file_field</tt>. The only difference with other helpers is that you cannot set a default value for file inputs as this would have no meaning. As you would expect in the first case the uploaded file is in <tt>params[:picture]</tt> and in the second case in<tt> </tt><tt>params[:person][:picture]</tt>.

R<span style="font-family: DejaVu Sans;">爱丽丝提供通常配对的</span>helpers<span style="font-family: DejaVu Sans;">：单个的</span><tt>file_field_tag</tt><span style="font-family: DejaVu Sans;"><tt>和面向</tt></span><tt>model</tt><span style="font-family: DejaVu Sans;"><tt>的</tt><tt></tt></span><tt>file_field</tt><span style="font-family: DejaVu Sans;"><tt>。</tt></span>

<span style="font-family: DejaVu Sans;">这与其他的</span>helpers<span style="font-family: DejaVu Sans;">的不同是你不能为</span>file inputs<span style="font-family: DejaVu Sans;">设置一个不同的值因为这样没有意义。正如你所期望的第一种情况上传的文件在</span><tt>params[:picture]</tt><span style="font-family: DejaVu Sans;"><tt>，第二种情况在</tt><tt></tt></span><tt>params[:person][:picture]</tt><span style="font-family: DejaVu Sans;"><tt>中。</tt></span>
<h4><a name="what-gets-uploaded"></a>5.1 What Gets Uploaded</h4>
The object in the <tt>params</tt> hash is an instance of a subclass of IO. Depending on the size of the uploaded file it may in fact be a StringIO or an instance of File backed by a temporary file. In both cases the object will have an <tt>original_filename</tt> attribute containing the name the file had on the user’s computer and a <tt>content_type</tt> attribute containing the MIME type of the uploaded file. The following snippet saves the uploaded content in <tt>#{Rails.root}/public/uploads</tt> under the same name as the original file (assuming the form was the one in the previous example).

<span style="font-family: DejaVu Sans;">在</span>params hash<span style="font-family: DejaVu Sans;">中的对象是</span>IO<span style="font-family: DejaVu Sans;">子类的一个实例。取决于上传文件的大小它可能实际上是一个</span>StringIO<span style="font-family: DejaVu Sans;">或者临时文件的备份文件。在这两个情况中对象将会有一个</span><tt>original_filename</tt><span style="font-family: DejaVu Sans;"><tt>属性包含文件在用户电脑上的名字以及一个</tt><tt></tt></span><tt>content_type</tt><span style="font-family: DejaVu Sans;"><tt>属性包含上传文件的</tt></span><tt>MIME</tt><span style="font-family: DejaVu Sans;"><tt>形式。随后的阶段保存上传的内容在</tt></span><tt>#{Rails.root}/public/uploads</tt><span style="font-family: DejaVu Sans;"><tt>并以与原始名字相同（假设</tt></span><tt>form</tt><span style="font-family: DejaVu Sans;"><tt>是一个预先的例子则下面是其控制函数）</tt></span>

def upload

uploaded_io = params[:person][:picture]

File.open(Rails.root.join('public', 'uploads', uploaded_io.original_filename), 'w') do |file|

file.write(uploaded_io.read)

end

end

Once a file has been uploaded, there are a multitude of potential<span style="font-family: DejaVu Sans;">潜在</span>tasks, ranging from where to store the files (on disk, Amazon S3, etc) and associating them with models to resizing image files and generating thumbnails. The intricacies of this are beyond the scope of this guide, but there are several libraries designed to assist with these. Two of the better known ones are <span style="color: #000080;"><span style="text-decoration: underline;"><a href="https://github.com/jnicklas/carrierwave">CarrierWave</a></span></span> and <span style="color: #000080;"><span style="text-decoration: underline;"><a href="http://www.thoughtbot.com/projects/paperclip">Paperclip</a></span></span>.

<span style="font-family: DejaVu Sans;">一旦一个文件被上传，这里有多个潜在的任务，响应在哪里存放文件</span>(on disk, Amazon S3, etc) <span style="font-family: DejaVu Sans;">并且关联它们至</span>models<span style="font-family: DejaVu Sans;">为重设大小的图片文件同时创建缩略图。这里的复杂远超这个</span>guide<span style="font-family: DejaVu Sans;">的范围，但是这里有一些库被设计来分派这些。有两个较好的库</span>ones are <span style="color: #000080;"><span style="text-decoration: underline;"><a href="https://github.com/jnicklas/carrierwave">CarrierWave</a></span></span> and <span style="color: #000080;"><span style="text-decoration: underline;"><a href="http://www.thoughtbot.com/projects/paperclip">Paperclip</a></span></span><span style="font-family: DejaVu Sans;">。</span>

<span style="color: #800000;"><strong>If</strong></span><span style="color: #800000;"><strong>the</strong></span><span style="color: #800000;"><strong>user</strong></span><span style="color: #800000;"><strong>has</strong></span><span style="color: #800000;"><strong>not</strong></span><span style="color: #800000;"><strong>selected</strong></span><span style="color: #800000;"><strong>a</strong></span><span style="color: #800000;"><strong>file</strong></span><span style="color: #800000;"><strong>the</strong></span><span style="color: #800000;"><strong>corresponding</strong></span><span style="color: #800000;"><strong>parameter</strong></span><span style="color: #800000;"><strong>will</strong></span><span style="color: #800000;"><strong>be</strong></span><span style="color: #800000;"><strong>an</strong></span><span style="color: #800000;"><strong>empty</strong></span><span style="color: #800000;"><strong>string.</strong></span>
<h4><a name="dealing-with-ajax"></a>5.2 Dealing with Ajax<span style="font-family: WenQuanYi Micro Hei;">处理</span>Ajax</h4>
Unlike other forms making an asynchronous file upload form is not as simple as providing <tt>form_for</tt> with <tt>:remote</tt><tt> </tt><tt>=&gt;</tt><tt> </tt><tt>true</tt>. With an Ajax form the serialization is done by JavaScript running inside the browser and since JavaScript cannot read files from your hard drive the file cannot be uploaded. The most common workaround is to use an invisible iframe that serves as the target for the form submission.

<span style="font-family: DejaVu Sans;">与其他</span>forms<span style="font-family: DejaVu Sans;">不同制作一个异步文件上传表单不能简单的提供</span><tt>form_for</tt> with <tt>:remote</tt><tt> </tt><tt>=&gt;</tt><tt> </tt><tt>true</tt>.<span style="font-family: DejaVu Sans;">一个</span>Ajax<span style="font-family: DejaVu Sans;">表单这个序列被在浏览器内部运行的</span>JavaScript<span style="font-family: DejaVu Sans;">完成同时因为</span>JavaScript<span style="font-family: DejaVu Sans;">不能从你的硬盘中读取文件这个文件就不能上传。最常见的解决方法是使用一种无形的</span>iframe<span style="font-family: DejaVu Sans;">服务于目标</span>forms<span style="font-family: DejaVu Sans;">的提交。</span>
<h3><a name="customizing-form-builders"></a>6 Customizing Form Builders</h3>
As mentioned previously the object yielded by <tt>form_for</tt> and <tt>fields_for</tt> is an instance of FormBuilder (or a subclass thereof). Form builders encapsulate the notion of displaying form elements for a single object. While you can of course write helpers for your forms in the usual way you can also subclass FormBuilder and add the helpers there. For example

<span style="font-family: DejaVu Sans;">正如开始提到的<tt></tt></span><tt>object</tt><tt> </tt><tt>yielded</tt><tt> </tt><tt>by</tt><tt> </tt><tt>form_for</tt><span style="font-family: DejaVu Sans;"><tt>以及是</tt></span><tt>FormBuilder</tt><span style="font-family: DejaVu Sans;"><tt>的实例（或者其中的子类的实例）。</tt></span><tt>Form</tt><tt> </tt><tt>builders</tt><span style="font-family: DejaVu Sans;"><tt>封装表单元素的显示</tt></span><tt>notion</tt><span style="font-family: DejaVu Sans;"><tt>为一个单独的对象。然而你当然你也可以为你的</tt></span><tt>form</tt><span style="font-family: DejaVu Sans;"><tt>编写</tt></span><tt>helpers</tt><span style="font-family: DejaVu Sans;"><tt>通常的方式你可以通过（编写）</tt></span><tt>FormBuilder</tt><span style="font-family: DejaVu Sans;"><tt>的子类并且在这里添加</tt></span><tt>helpers</tt><span style="font-family: DejaVu Sans;"><tt>。例如：</tt></span>

<tt>&lt;%=</tt><tt> </tt><tt>form_for</tt><tt> </tt><tt>@person</tt><tt> </tt><tt>do</tt><tt> </tt><tt>|f|</tt><tt> </tt><tt>%&gt;</tt>

<tt> </tt><tt>&lt;%=</tt><tt> </tt><tt>text_field_with_label</tt><tt> </tt><tt>f,</tt><tt> </tt><tt>:first_name</tt><tt> </tt><tt>%&gt;</tt>

<tt>&lt;%</tt><tt> </tt><tt>end</tt><tt> </tt><tt>%&gt;</tt>

<span style="font-family: DejaVu Sans;"><tt>可以替换为：</tt></span>

<tt>&lt;%=</tt><tt> </tt><tt>form_for</tt><tt> </tt><tt>@person,</tt><tt> </tt><tt>:builder</tt><tt> </tt><tt>=&gt;</tt><tt> </tt><tt>LabellingFormBuilder</tt><tt> </tt><tt>do</tt><tt> </tt><tt>|f|</tt><tt> </tt><tt>%&gt;</tt>

<tt> </tt><tt>&lt;%=</tt><tt> </tt><tt>f.text_field</tt><tt> </tt><tt>:first_name</tt><tt> </tt><tt>%&gt;</tt>

<tt>&lt;%</tt><tt> </tt><tt>end</tt><tt> </tt><tt>%&gt;</tt>

by defining a LabellingFormBuilder class similar to the following:

<span style="font-family: DejaVu Sans;">通过定义一个</span>LabellingFormBuilder<span style="font-family: DejaVu Sans;">类与接下来的类似：</span>

class LabellingFormBuilder &lt; ActionView::Helpers::FormBuilder

def text_field(attribute, options={})

label(attribute) + super

end

end

If you reuse this frequently you could define a <tt>labeled_form_for</tt> helper that automatically applies the <tt>:builder</tt><tt> </tt><tt>=&gt;</tt><tt> </tt><tt>LabellingFormBuilder</tt> option.

<span style="font-family: DejaVu Sans;">如果你拒绝这样频繁的操作你可以定义一个</span><tt>labeled_form_for</tt><span style="font-family: DejaVu Sans;"><tt>它会自动的应用</tt></span><tt>:builder</tt><tt> </tt><tt>=&gt;</tt><tt> </tt><tt>LabellingFormBuilder</tt><span style="font-family: DejaVu Sans;"><tt>选项。</tt></span>

<tt>The</tt><tt> </tt><tt>form</tt><tt> </tt><tt>builder</tt><tt> </tt><tt>used</tt><tt> </tt><tt>also</tt><tt> </tt><tt>determines</tt><tt> </tt><tt>what</tt><tt> </tt><tt>happens</tt><tt> </tt><tt>when</tt><tt> </tt><tt>you</tt><tt> </tt><tt>do</tt>

form builer<span style="font-family: DejaVu Sans;">的使用也决定了在你操作的时候将会发生什么</span>

&lt;%= render :partial =&gt; f %&gt;

If <tt>f</tt> is an instance of FormBuilder then this will render the <tt>form</tt> partial, setting the partial’s object to the form builder. If the form builder is of class LabellingFormBuilder then the <tt>labelling_form</tt> partial would be rendered instead.

<span style="font-family: DejaVu Sans;">如果</span>f<span style="font-family: DejaVu Sans;">是</span>FormBuilder<span style="font-family: DejaVu Sans;">的一个实例那么这里将会局部的</span>render<span style="font-family: DejaVu Sans;">表单，为</span>form buider<span style="font-family: DejaVu Sans;">设置</span>partial’s<span style="font-family: DejaVu Sans;">对象。如果</span>form builder<span style="font-family: DejaVu Sans;">是</span>LabellingFormBuilder<span style="font-family: DejaVu Sans;">那么在</span>render<span style="font-family: DejaVu Sans;">中</span><tt>labelling_form</tt><span style="font-family: DejaVu Sans;"><tt>将会替代</tt></span><tt>f</tt><span style="font-family: DejaVu Sans;"><tt>。</tt></span>
<h3><a name="understanding-parameter-naming-conventio"></a> 7 Understanding Parameter Naming Conventions<span style="font-family: WenQuanYi Micro Hei;">明白参数公约</span></h3>
As you’ve seen in the previous sections, values from forms can be at the top level of the <tt>params</tt> hash or nested in another hash. For example in a standard <tt>create</tt> action for a Person model, <tt>params[:model]</tt> would usually be a hash of all the attributes for the person to create. The <tt>params</tt> hash can also contain arrays, arrays of hashes and so on.

<span style="font-family: DejaVu Sans;">正如你在（本节</span>guide<span style="font-family: DejaVu Sans;">）前面部分看到的，来至</span>forms<span style="font-family: DejaVu Sans;">的值将会在顶级的</span>parmas hash<span style="font-family: DejaVu Sans;">字典内或者是嵌套在另一个</span>hash<span style="font-family: DejaVu Sans;">子典中。例如在</span>Person model<span style="font-family: DejaVu Sans;">的一个标准的</span>create action<span style="font-family: DejaVu Sans;">中，</span><tt>params[:model]</tt><span style="font-family: DejaVu Sans;"><tt>通常将会有一个含有创建的</tt></span><tt>person</tt><span style="font-family: DejaVu Sans;"><tt>的所有属性的字典。</tt></span><tt>params</tt><span style="font-family: DejaVu Sans;"><tt>字典也可以包含数组，由</tt></span><tt>hash</tt><span style="font-family: DejaVu Sans;"><tt>字典组成的数组等等。</tt></span>

Fundamentally HTML forms don’t know about any sort of structured data, all they generate is name–value pairs, where pairs are just plain strings. The arrays and hashes you see in your application are the result of some parameter naming conventions that Rails uses.

<span style="font-family: DejaVu Sans;">归根结底</span>HTML forms<span style="font-family: DejaVu Sans;">并不知道关于数据结构的任何类型，它们生成的所有仅是</span>name-value<span style="font-family: DejaVu Sans;">对，这些（</span>name-value<span style="font-family: DejaVu Sans;">）仅仅是纯</span>string<span style="font-family: DejaVu Sans;">。你在应用程序中看到的数组和</span>hash<span style="font-family: DejaVu Sans;">字典是一些在</span>Rails<span style="font-family: DejaVu Sans;">使用的参数命名公约的结果。</span>

You may find you can try out examples in this section faster by using the console to directly invoke Rails’ parameter parser. For example,

<span style="font-family: DejaVu Sans;">你会发现你可以快速的尝试这部分的例子通过使用</span>console<span style="font-family: DejaVu Sans;">来直接的调用</span>Rails's parameter <span style="font-family: DejaVu Sans;">解析器。例如，</span>

ActionController::UrlEncodedPairParser.parse_query_parameters "name=fred&amp;phone=0123456789"

# =&gt; {"name"=&gt;"fred", "phone"=&gt;"0123456789"}
<h4><a name="basic-structures"></a>7.1 Basic Structures<span style="font-family: WenQuanYi Micro Hei;">基础的</span>strcutures</h4>
The two basic structures are arrays and hashes. Hashes mirror the syntax used for accessing the value in <tt>params</tt>. For example if a form contains

<span style="font-family: DejaVu Sans;">两个根本的结构是</span>arrays<span style="font-family: DejaVu Sans;">和</span>hash<span style="font-family: DejaVu Sans;">字典。</span>Hash<span style="font-family: DejaVu Sans;">字典镜像这种语法用来访问</span>params<span style="font-family: DejaVu Sans;">的值。例如如果一个</span>form<span style="font-family: DejaVu Sans;">中包含</span>

&lt;input id="person_name" name="person[name]" type="text" value="Henry"/&gt;

the <tt>params</tt> hash will contain

{'person' =&gt; {'name' =&gt; 'Henry'}}

and <tt>params[:person][:name]</tt> will retrieve the submitted value in the controller.

<span style="font-family: DejaVu Sans;">同时</span><tt>params[:person][:name]</tt><span style="font-family: DejaVu Sans;"><tt>将会在</tt></span><tt>controller</tt><span style="font-family: DejaVu Sans;"><tt>中接收提交的</tt></span><tt>value</tt><span style="font-family: DejaVu Sans;"><tt>。</tt></span>

Hashes can be nested as many levels as required, for example

<span style="font-family: DejaVu Sans;">如果需要</span>hash<span style="font-family: DejaVu Sans;">字典可以嵌套多层，例如</span>

&lt;input id="person_address_city" name="person[address][city]" type="text" value="New York"/&gt;

will result in the <tt>params</tt> hash being<span style="font-family: DejaVu Sans;">将会在</span>params hash<span style="font-family: DejaVu Sans;">字典中返回</span>

{'person' =&gt; {'address' =&gt; {'city' =&gt; 'New York'}}}

Normally Rails ignores duplicate parameter names. If the parameter name contains an empty set of square brackets [] then they will be accumulated in an array. If you wanted people to be able to input multiple phone numbers, you could place this in the form:

<span style="font-family: DejaVu Sans;">正常情况下</span>Rails<span style="font-family: DejaVu Sans;">忽略重复参数名称。如果参数名包含一个空的</span>[]<span style="font-family: DejaVu Sans;">那么它们会在一个数组中累积。如果你想</span>people<span style="font-family: DejaVu Sans;">能够输入多个电话号码，你可以将这里放入</span>form<span style="font-family: DejaVu Sans;">中：</span>

&lt;input name="person[phone_number][]" type="text"/&gt;

&lt;input name="person[phone_number][]" type="text"/&gt;

&lt;input name="person[phone_number][]" type="text"/&gt;

<strong>This would result in </strong><tt><strong>params[:person][:phone_number]</strong></tt><strong> being an array.</strong>
<h4><a name="combining-them"></a>7.2 Combining Them<span style="font-family: WenQuanYi Micro Hei;">联合它们</span></h4>
We can mix and match these two concepts. For example, one element of a hash might be an array as in the previous example, or you can have an array of hashes. For example a form might let you create any number of addresses by repeating the following form fragment

<span style="font-family: DejaVu Sans;">我们可以总结出两个概念。例如，一个</span>element<span style="font-family: DejaVu Sans;">的</span>hash<span style="font-family: DejaVu Sans;">键值可能是作为一个先前例子的</span>hash<span style="font-family: DejaVu Sans;">键值的数组，或者你也可以有一个</span>hash<span style="font-family: DejaVu Sans;">字典的数组。例如一个</span>form<span style="font-family: DejaVu Sans;">可以让你创建任何数量的地址通过重复随后的</span>form <span style="font-family: DejaVu Sans;">片段</span>

&lt;input name="addresses[][line1]" type="text"/&gt;

&lt;input name="addresses[][line2]" type="text"/&gt;

&lt;input name="addresses[][city]" type="text"/&gt;

This would result in <tt>params[:addresses]</tt> being an array of hashes with keys <tt>line1</tt>, <tt>line2</tt> and <tt>city</tt>. Rails decides to start accumulating values in a new hash whenever it encounters an input name that already exists in the current hash.

<span style="font-family: DejaVu Sans;">这里返回的结果在</span><tt>params[:addresses]</tt><span style="font-family: DejaVu Sans;"><tt>中，是一个</tt></span><tt>hash</tt><span style="font-family: DejaVu Sans;"><tt>字典组成的数组其中</tt></span><tt>keys</tt><span style="font-family: DejaVu Sans;"><tt>是</tt></span><tt>line1,line2</tt><span style="font-family: DejaVu Sans;"><tt>和</tt></span><tt>city</tt><span style="font-family: DejaVu Sans;"><tt>。 </tt></span><tt>Rails</tt><span style="font-family: DejaVu Sans;"><tt>决定开始在一个新的</tt></span><tt>hash</tt><span style="font-family: DejaVu Sans;"><tt>中积累值不管它是不是遇到一个已经在当前的</tt></span><tt>hash</tt><span style="font-family: DejaVu Sans;"><tt>已经存在的</tt></span><tt>input name</tt><span style="font-family: DejaVu Sans;"><tt>。</tt></span>

<tt>There’s a restriction, however, while hashes can be nested arbitrarily, only one level of “arrayness” is allowed. Arrays can be usually replaced by hashes, for example instead of having an array of model objects one can have a hash of model objects keyed by their id, an array index or some other parameter.</tt>

<span style="font-family: DejaVu Sans;">这是一个限制，然而，即使</span>hashes<span style="font-family: DejaVu Sans;">能够嵌套任意层，只有一级的<tt>“</tt></span><tt>arrayness”</tt><span style="font-family: DejaVu Sans;"><tt>是被允许的。数组通常可以替换</tt></span><tt>hashes</tt><span style="font-family: DejaVu Sans;"><tt>字典，例如作为替代，一个数组的</tt></span><tt>model</tt><span style="font-family: DejaVu Sans;"><tt>对象可以键入它们的</tt></span><tt>id</tt><span style="font-family: DejaVu Sans;"><tt>，一个</tt></span><tt>array index</tt><span style="font-family: DejaVu Sans;"><tt>或者一些其他参数。</tt></span>

Array parameters do not play well with the <tt>check_box</tt> helper. According to the HTML specification unchecked checkboxes submit no value. However it is often convenient for a checkbox to always submit a value. The <tt>check_box</tt> helper fakes this by creating an auxiliary hidden input with the same name. If the checkbox is unchecked only the hidden input is submitted and if it is checked then both are submitted but the value submitted by the checkbox takes precedence. When working with array parameters this duplicate submission will confuse Rails since duplicate input names are how it decides when to start a new array element. It is preferable to either use <tt> </tt><tt>check_box_tag</tt> or to use hashes instead of arrays.

<span style="font-family: DejaVu Sans;">数组参数在</span>check_box helper<span style="font-family: DejaVu Sans;">中不能得到很好的效果。根据</span>HTML<span style="font-family: DejaVu Sans;">规范的</span>unchecked checkboxes<span style="font-family: DejaVu Sans;">提交空值。无论如何一个</span>checkbox<span style="font-family: DejaVu Sans;">提交一个值通常非常方便。</span>check_box helper <span style="font-family: DejaVu Sans;">假想这种情况来创建具有相同</span>name<span style="font-family: DejaVu Sans;">一个辅助的隐藏</span>input<span style="font-family: DejaVu Sans;">。如果</span>checkbox<span style="font-family: DejaVu Sans;">是</span>unchecked<span style="font-family: DejaVu Sans;">那么只有</span>hidden input<span style="font-family: DejaVu Sans;">被提交如果它是</span>check<span style="font-family: DejaVu Sans;">那么两个都会提交但是</span>checkbox<span style="font-family: DejaVu Sans;">优先提交</span>value.<span style="font-family: DejaVu Sans;">当（</span>Rails<span style="font-family: DejaVu Sans;">）工作到有这两个重复提交的参数数组</span>rails<span style="font-family: DejaVu Sans;">将会产生混淆，因为重复 </span>input name<span style="font-family: DejaVu Sans;">会开始一个新的数组元素。这里使用 </span><tt>check_box_tag</tt><span style="font-family: DejaVu Sans;"><tt>或者使用</tt></span><tt>hash</tt><span style="font-family: DejaVu Sans;"><tt>替代</tt></span><tt>array</tt><span style="font-family: DejaVu Sans;"><tt>都是可取的。</tt></span>
<h4><a name="using-form-helpers"></a>7.3 Using Form Helpers</h4>
The previous sections did not use the Rails form helpers at all. While you can craft the input names yourself and pass them directly to helpers such as <tt>text_field_tag</tt> Rails also provides higher level support. The two tools at your disposal here are the name parameter to <tt>form_for</tt> and <tt>fields_for</tt> and the <tt>:index</tt> option that helpers take.

<span style="font-family: DejaVu Sans;">前面的部分根本没有使用</span>Rails form helpers<span style="font-family: DejaVu Sans;">。然而你可以自己加工</span>input name<span style="font-family: DejaVu Sans;">并且直接传输他们给</span>helpers<span style="font-family: DejaVu Sans;">例如 </span><tt>text_field_tag Rails</tt><span style="font-family: DejaVu Sans;"><tt>也提供更高级别的支持。有两个工具供你差遣它们是获取</tt></span><tt>:name</tt><span style="font-family: DejaVu Sans;"><tt>的</tt></span><tt>form_for</tt><span style="font-family: DejaVu Sans;"><tt>和获取</tt></span><tt>:index</tt><span style="font-family: DejaVu Sans;"><tt>选项的</tt></span><tt>fields_for helpers</tt><span style="font-family: DejaVu Sans;"><tt>。</tt></span>

You might want to render a form with a set of edit fields for each of a person’s addresses. For example:

<span style="font-family: DejaVu Sans;">你可能想</span>render<span style="font-family: DejaVu Sans;">一个</span>person's addresses form<span style="font-family: DejaVu Sans;">并且对</span>person's each addresses<span style="font-family: DejaVu Sans;">使用一样的</span>edit fields<span style="font-family: DejaVu Sans;">。</span>

&lt;%= form_for @person do |person_form| %&gt;

&lt;%= person_form.text_field :name %&gt;

&lt;% @person.addresses.each do |address| %&gt;

&lt;%= person_form.fields_for address, :index =&gt; address do |address_form|%&gt;

&lt;%= address_form.text_field :city %&gt;

&lt;% end %&gt;

&lt;% end %&gt;

&lt;% end %&gt;

Assuming the person had two addresses, with ids 23 and 45 this would create output similar to this:

<span style="font-family: DejaVu Sans;">假设</span>person<span style="font-family: DejaVu Sans;">有两个</span>address<span style="font-family: DejaVu Sans;">。</span>id<span style="font-family: DejaVu Sans;">为</span>23<span style="font-family: DejaVu Sans;">和</span>45<span style="font-family: DejaVu Sans;">将会创建与下面类似的</span>HTML<span style="font-family: DejaVu Sans;">代码：</span>

&lt;form accept-charset="UTF-8" action="/people/1" id="edit_person_1" method="post"&gt;

&lt;input id="person_name" name="person[name]" size="30" type="text" /&gt;

&lt;input id="person_address_23_city" name="person[address][23][city]" size="30" type="text" /&gt;

&lt;input id="person_address_45_city" name="person[address][45][city]" size="30" type="text" /&gt;

&lt;/form&gt;

This will result in a <tt>params</tt> hash that looks like

{'person' =&gt; {'name' =&gt; 'Bob', 'address' =&gt; {'23' =&gt; {'city' =&gt; 'Paris'}, '45' =&gt; {'city' =&gt; 'London'}}}}

&nbsp;

Rails knows that all these inputs should be part of the person hash because you called <tt>fields_for</tt> on the first form builder. By specifying an <tt>:index</tt> option you’re telling Rails that instead of naming the inputs <tt>person[address][city]</tt> it should insert that index surrounded by [] between the address and the city. If you pass an Active Record object as we did then Rails will call <tt>to_param</tt> on it, which by default returns the database id. This is often useful as it is then easy to locate which Address record should be modified. You can pass numbers with some other significance, strings or even <tt>nil</tt> (which will result in an array parameter being created).

Rails<span style="font-family: DejaVu Sans;">知道这里所有的</span>inputs<span style="font-family: DejaVu Sans;">应该是</span>person hash<span style="font-family: DejaVu Sans;">的一部分因为你在</span>form builder<span style="font-family: DejaVu Sans;">的开始调用了 </span><tt>fields_for</tt><span style="font-family: DejaVu Sans;"><tt>。通过指定</tt></span><tt>:index</tt><span style="font-family: DejaVu Sans;"><tt>选项你告诉</tt></span><tt>Rails</tt><span style="font-family: DejaVu Sans;"><tt>替代</tt></span><tt>person[address][city] input</tt><span style="font-family: DejaVu Sans;"><tt>中的名字它将会在</tt></span><tt>address</tt><span style="font-family: DejaVu Sans;"><tt>和此帖有之间插入被</tt></span><tt>[]</tt><span style="font-family: DejaVu Sans;"><tt>包围的</tt></span><tt>index</tt><span style="font-family: DejaVu Sans;"><tt>。如果你通过的是一个</tt></span><tt>Active Record object</tt><span style="font-family: DejaVu Sans;"><tt>正如我们知道的</tt></span><tt>Rails</tt><span style="font-family: DejaVu Sans;"><tt>将会调用</tt></span><tt>_param,</tt><span style="font-family: DejaVu Sans;"><tt>它会默认返回数据库的（</tt></span><tt>city</tt><span style="font-family: DejaVu Sans;"><tt>的）</tt></span><tt>id</tt><span style="font-family: DejaVu Sans;"><tt>。这在当</tt></span><tt>Addrss</tt><span style="font-family: DejaVu Sans;"><tt>记录需要修改，的时候非常有用它能易于定位。你可以传递给其他意义的数字，字符串或者空（它将返回在创建的参数数组中）。</tt></span>

<tt>To create more intricate</tt><span style="font-family: DejaVu Sans;"><tt>复杂 </tt></span><tt>nestings, you can specify the first part of the input name (person[address] in the previous example) explicitly, for example</tt>

&lt;%= fields_for 'person[address][primary]', address, :index =&gt; address do |address_form| %&gt;

&lt;%= address_form.text_field :city %&gt;

&lt;% end %&gt;

will create inputs like

As a general rule the final input name is the concatenation of the name given to <tt>fields_for</tt>/<tt>form_for</tt>, the index value and the name of the attribute. You can also pass an <tt>:index</tt> option directly to helpers such as <tt>text_field</tt>, but it is usually less repetitive to specify this at the form builder level rather than on individual input controls.

As a shortcut you can append [] to the name and omit<span style="font-family: DejaVu Sans;">忽略 </span>the <tt>:index</tt> option. This is the same as specifying <tt>:index =&gt; address</tt> so

&lt;%= fields_for 'person[address][primary][]', address do |address_form| %&gt;

&lt;%= address_form.text_field :city %&gt;

&lt;% end %&gt;

produces exactly the same output as the previous example.
<h3><a name="forms-to-external-resources"></a>8 Forms to external resources</h3>
If you need to post some data to an external<span style="font-family: DejaVu Sans;">外部 </span>resource it is still great to build your from using rails form helpers. But sometimes you need to set an <tt>authenticity_token</tt> for this resource. You can do it by passing an <tt>:authenticity_token =&gt; 'your_external_token'</tt> parameter to the <tt>form_tag</tt> options:

&lt;%= form_tag 'http://farfar.away/form', :authenticity_token =&gt; 'external_token') do %&gt;

Form contents

&lt;% end %&gt;

Sometimes when you submit data to an external resource, like payment gateway, fields you can use in your form are limited by an external API. So you may want not to generate an <tt>authenticity_token</tt> hidden field at all. For doing this just pass <tt>false</tt> to the <tt>:authenticity_token</tt> option:

&lt;%= form_tag 'http://farfar.away/form', :authenticity_token =&gt; false) do %&gt;

Form contents

&lt;% end %&gt;

The same technique is available for the <tt>form_for</tt> too:

&lt;%= form_for @invoice, :url =&gt; external_url, :authenticity_token =&gt; 'external_token' do |f|

Form contents

&lt;% end %&gt;

Or if you don’t want to render an <tt>authenticity_token</tt> field:

&lt;%= form_for @invoice, :url =&gt; external_url, :authenticity_token =&gt; false do |f|

Form contents

&lt;% end %&gt;
<h3><a name="building-complex-forms"></a>9 Building Complex Forms</h3>
Many apps grow beyond simple forms editing a single object. For example when creating a Person you might want to allow the user to (on the same form) create multiple address records (home, work, etc.). When later editing that person the user should be able to add, remove or amend addresses as necessary. While this guide has shown you all the pieces necessary to handle this, Rails does not yet have a standard end-to-end way of accomplishing this, but many have come up with viable approaches. These include:
<ul>
	<li>As of Rails 2.3, Rails includes <a href="http://guides.rubyonrails.org/2_3_release_notes.html#nested-attributes">Nested Attributes</a> and <a href="http://guides.rubyonrails.org/2_3_release_notes.html#nested-object-forms">Nested Object Forms</a></li>
	<li>Ryan Bates’ series of Railscasts on <a href="http://railscasts.com/episodes/75">complex forms</a></li>
	<li>Handle Multiple Models in One Form from <a href="http://media.pragprog.com/titles/fr_arr/multiple_models_one_form.pdf">Advanced Rails Recipes</a></li>
	<li>Eloy Duran’s <a href="https://github.com/alloy/complex-form-examples/">complex-forms-examples</a> application</li>
	<li>Lance Ivy’s <a href="https://github.com/cainlevy/nested_assignment/tree/master">nested_assignment</a> plugin and <a href="https://github.com/cainlevy/complex-form-examples/tree/cainlevy">sample application</a></li>
	<li>James Golick’s <a href="https://github.com/jamesgolick/attribute_fu">attribute_fu</a> plugin</li>
</ul>
&nbsp;
