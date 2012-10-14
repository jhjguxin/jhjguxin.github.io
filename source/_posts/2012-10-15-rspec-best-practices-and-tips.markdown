---
layout: post
title: "RSpec best practices and tips"
date: 2012-02-26 16:30
comments: true
categories: ["rails", "ruby"]
tags: ["practices", "rails", "RSpec", "ruby", "tips"]
---
## RSpec best practices and tips
After a year using RSpec, I’m happy to share “(My) RSpec Best Practices and Tips”. Let’s make your specs easier to maintain, less verbose, more structured and covering more cases!
<h2>Use shortcuts <em>specify {}</em>, <em>it {}</em> and <em>subject {}</em></h2>
You think RSpec is verbose? In case your code doesn’t need any description, use a <em>specify block</em>!
<div>
<div id="highlighter_569165">
<table border="0" cellspacing="0" cellpadding="0">
<tbody>
<tr>
<td>
<div>
<div><code>it </code><code>"should be valid"</code> <code>do</code></div>
<div><code></code><code>@user</code><code>.should be_valid </code></div>
<div><code>end</code></div>
</div></td>
</tr>
</tbody>
</table>
</div>
</div>
can be replaced with
<div>
<div id="highlighter_540926">
<table border="0" cellspacing="0" cellpadding="0">
<tbody>
<tr>
<td>
<div>
<div><code>specify { </code><code>@user</code><code>.should be_valid }</code></div>
</div></td>
</tr>
</tbody>
</table>
</div>
</div>
RSpec will generate a nice description text for you when running this expectation. Even better, you can use the <em>it block</em>!
<div>
<div id="highlighter_397260">
<table border="0" cellspacing="0" cellpadding="0">
<tbody>
<tr>
<td>
<div>
<div><code>describe User </code><code>do</code></div>
<div><code></code><code>it { should validate_presence_of </code><code>:name</code> <code>} </code></div>
<div><code></code><code>it { should have_one </code><code>:address</code> <code>} </code></div>
<div><code>end</code></div>
</div></td>
</tr>
</tbody>
</table>
</div>
</div>
In case the subject is the not the class described, just set it with the <em>subject</em> method:
<div>
<div id="highlighter_634030">
<table border="0" cellspacing="0" cellpadding="0">
<tbody>
<tr>
<td>
<div>
<div><code>subject { </code><code>@user</code><code>.address } </code></div>
<div><code>it { should be_valid }</code></div>
</div></td>
</tr>
</tbody>
</table>
</div>
</div>
<h2>Start context with ‘when’/'with’ and methods description with ‘#’</h2>
Have you ever get a failed test with an incomprehensible error message like:
<div>
<div id="highlighter_833360">
<table border="0" cellspacing="0" cellpadding="0">
<tbody>
<tr>
<td>
<div>
<div><code>User non confirmed confirm email wrong token should not be valid</code></div>
</div></td>
</tr>
</tbody>
</table>
</div>
</div>
Start your <em>contexts</em> with <em>when</em> and get nice messages like:
<div>
<div id="highlighter_259278">
<table border="0" cellspacing="0" cellpadding="0">
<tbody>
<tr>
<td>
<div>
<div><code>User when non confirmed when #confirm_email with wrong token should not be valid</code></div>
</div></td>
</tr>
</tbody>
</table>
</div>
</div>
<h2>Use RSpec matchers to get meaningful messages</h2>
In case of failure
<div>
<div id="highlighter_723593">
<table border="0" cellspacing="0" cellpadding="0">
<tbody>
<tr>
<td>
<div>
<div><code>specify { user.valid?.should == </code><code>true</code> <code>}</code></div>
</div></td>
</tr>
</tbody>
</table>
</div>
</div>
displays:
<div>
<div id="highlighter_873437">
<table border="0" cellspacing="0" cellpadding="0">
<tbody>
<tr>
<td>
<div>
<div><code>'User should == true' FAILED </code></div>
<div><code></code><code>expected: true, </code></div>
<div><code></code><code>got: false (using ==)</code></div>
</div></td>
</tr>
</tbody>
</table>
</div>
</div>
While
<div>
<div id="highlighter_57131">
<table border="0" cellspacing="0" cellpadding="0">
<tbody>
<tr>
<td>
<div>
<div><code>specify { user.should be_valid }</code></div>
</div></td>
</tr>
</tbody>
</table>
</div>
</div>
displays:
<div>
<div id="highlighter_813731">
<table border="0" cellspacing="0" cellpadding="0">
<tbody>
<tr>
<td>
<div>
<div><code>'User should be valid' FAILED </code></div>
<div><code></code><code>expected valid? to return true, got false</code></div>
</div></td>
</tr>
</tbody>
</table>
</div>
</div>
Nice eh?
<h2>Only one expectation per <em>it block</em></h2>
I often see specs where it blocks contain several expectations. This makes your tests harder to read and maintain.

So instead of that…
<div>
<div id="highlighter_927685">
<table border="0" cellspacing="0" cellpadding="0">
<tbody>
<tr>
<td>
<div>
<div><code>describe DemoMan </code><code>do</code></div>
<div><code></code><code>it </code><code>"should have expected attributes"</code> <code>do</code></div>
<div><code></code><code>demo_man = DemoMan.</code><code>new</code></div>
<div><code></code><code>demo_man.should respond_to </code><code>:name</code></div>
<div><code></code><code>demo_man.should respond_to </code><code>:gender</code></div>
<div><code></code><code>demo_man.should respond_to </code><code>:age</code></div>
<div><code></code><code>end</code></div>
<div><code>end</code></div>
</div></td>
</tr>
</tbody>
</table>
</div>
</div>
… do this:
<div>
<div id="highlighter_377829">
<table border="0" cellspacing="0" cellpadding="0">
<tbody>
<tr>
<td>
<div>
<div><code>describe DemoMan </code><code>do</code></div>
<div><code></code><code>before(</code><code>:all</code><code>) </code><code>do</code></div>
<div><code></code><code>@demo_man</code> <code>= DemoMan.</code><code>new</code></div>
<div><code></code><code>end</code></div>
<div> </div>
<div><code></code><code>subject { </code><code>@demo_man</code> <code>} </code></div>
<div> </div>
<div><code></code><code>it { should respond_to </code><code>:name</code> <code>} </code></div>
<div><code></code><code>it { should respond_to </code><code>:gender</code> <code>} </code></div>
<div><code></code><code>it { should respond_to </code><code>:age</code> <code>} </code></div>
<div><code>end</code></div>
</div></td>
</tr>
</tbody>
</table>
</div>
</div>
<h2>(Over)use describe and context</h2>
Big specs can be a joy to play with as long as they are ordered and DRY. Use nested <em>describe</em> and <em>context</em> blocks as much as you can, each level adding its own specificity in the before block.
To check your specs are well organized, run them in ‘nested’ mode (<code>spec spec/my_spec.rb -cf nested</code>).
Using <code>before(:each)</code> in each context and describe blocks will help you set up the environment without repeating yourself. It also enables you to use <em>it {}</em> blocks.
<h3>Bad:</h3>
<div>
<div id="highlighter_149816">
<table border="0" cellspacing="0" cellpadding="0">
<tbody>
<tr>
<td>
<div>
<div><code>describe User </code><code>do</code></div>
<div> </div>
<div><code></code><code>it </code><code>"should save when name is not empty"</code> <code>do</code></div>
<div><code></code><code>User.</code><code>new</code><code>(</code><code>:name</code> <code>=&gt; </code><code>'Alex'</code><code>).save.should == </code><code>true</code></div>
<div><code></code><code>end</code></div>
<div> </div>
<div><code></code><code>it </code><code>"should not save when name is empty"</code> <code>do</code></div>
<div><code></code><code>User.</code><code>new</code><code>.save.should == </code><code>false</code></div>
<div><code></code><code>end</code></div>
<div> </div>
<div><code></code><code>it </code><code>"should not be valid when name is empty"</code> <code>do</code></div>
<div><code></code><code>User.</code><code>new</code><code>.should_not be_valid </code></div>
<div><code></code><code>end</code></div>
<div> </div>
<div><code></code><code>it </code><code>"should be valid when name is not empty"</code> <code>do</code></div>
<div><code></code><code>User.</code><code>new</code><code>(</code><code>:name</code> <code>=&gt; </code><code>'Alex'</code><code>).should be_valid </code></div>
<div><code></code><code>end</code></div>
<div> </div>
<div><code></code><code>it </code><code>"should give the user a flower when gender is W"</code> <code>do</code></div>
<div><code></code><code>User.</code><code>new</code><code>(</code><code>:gender</code> <code>=&gt; </code><code>'W'</code><code>).present.should be_a Flower </code></div>
<div><code></code><code>end</code></div>
<div> </div>
<div><code></code><code>it </code><code>"should give the user a iMac when gender is M"</code> <code>do</code></div>
<div><code></code><code>User.</code><code>new</code><code>(</code><code>:gender</code> <code>=&gt; </code><code>'M'</code><code>).present.should be_an IMac </code></div>
<div><code></code><code>end</code></div>
<div><code>end</code></div>
</div></td>
</tr>
</tbody>
</table>
</div>
</div>
<h3>Good:</h3>
<div>
<div id="highlighter_852046">
<table border="0" cellspacing="0" cellpadding="0">
<tbody>
<tr>
<td>
<div>
<div><code>describe User </code><code>do</code></div>
<div><code></code><code>before { </code><code>@user</code> <code>= User.</code><code>new</code> <code>} </code></div>
<div> </div>
<div><code></code><code>subject { </code><code>@user</code> <code>} </code></div>
<div> </div>
<div><code></code><code>context </code><code>"when name empty"</code> <code>do</code></div>
<div><code></code><code>it { should </code><code>not</code> <code>be_valid } </code></div>
<div><code></code><code>specify { </code><code>@user</code><code>.save.should == </code><code>false</code> <code>} </code></div>
<div><code></code><code>end</code></div>
<div> </div>
<div><code></code><code>context </code><code>"when name not empty"</code> <code>do</code></div>
<div><code></code><code>before { </code><code>@user</code><code>.name = </code><code>'Sam'</code> <code>} </code></div>
<div> </div>
<div><code></code><code>it { should be_valid } </code></div>
<div><code></code><code>specify { </code><code>@user</code><code>.save.should == </code><code>true</code> <code>} </code></div>
<div><code></code><code>end</code></div>
<div> </div>
<div><code></code><code>describe </code><code>:present</code> <code>do</code></div>
<div><code></code><code>subject { </code><code>@user</code><code>.present } </code></div>
<div> </div>
<div><code></code><code>context </code><code>"when user is a W"</code> <code>do</code></div>
<div><code></code><code>before { </code><code>@user</code><code>.gender = </code><code>'W'</code> <code>} </code></div>
<div> </div>
<div><code></code><code>it { should be_a Flower } </code></div>
<div><code></code><code>end</code></div>
<div> </div>
<div><code></code><code>context </code><code>"when user is a M"</code> <code>do</code></div>
<div><code></code><code>before { </code><code>@user</code><code>.gender = </code><code>'M'</code> <code>} </code></div>
<div> </div>
<div><code></code><code>it { should be_an IMac } </code></div>
<div><code></code><code>end</code></div>
<div><code></code><code>end</code></div>
<div><code>end</code></div>
</div></td>
</tr>
</tbody>
</table>
</div>
</div>
<h2>Test Valid, Edge and Invalid cases</h2>
This is called <em>Boundary value analysis</em>, it’s simple and it will help you to cover the most important cases. Just split-up method’s input or object’s attributes into valid and invalid partitions and test both of them and there boundaries. A method specification might look like that:
<div>
<div id="highlighter_449964">
<table border="0" cellspacing="0" cellpadding="0">
<tbody>
<tr>
<td>
<div>
<div><code>describe </code><code>"#month_in_english(month_id)"</code> <code>do</code></div>
<div><code></code><code>context </code><code>"when valid"</code> <code>do</code></div>
<div><code></code><code>it </code><code>"should return 'January' for 1"</code> <code># lower boundary </code></div>
<div><code></code><code>it </code><code>"should return 'March' for 3"</code></div>
<div><code></code><code>it </code><code>"should return 'December' for 12"</code> <code># upper boundary </code></div>
<div><code></code><code>context </code><code>"when invalid"</code> <code>do</code></div>
<div><code></code><code>it </code><code>"should return nil for 0"</code></div>
<div><code></code><code>it </code><code>"should return nil for 13"</code></div>
<div><code></code><code>end</code></div>
<div><code>end</code></div>
</div></td>
</tr>
</tbody>
</table>
</div>
</div>
I hope this will help you improve your specs. Let me know if I missed anything! :)

You could also be interested in <a href="http://eggsonbread.com/2010/09/06/my-cucumber-best-practices-and-tips/">(My) Cucumber best practices and tips</a> or <a href="https://github.com/pcreux/rspec-set">rspec-set</a> a little gem that helps you speeding up your model specs.
