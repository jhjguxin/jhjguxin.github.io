---
layout: post
title: "Helper Antipatterns"
date: 2012-03-19 10:44
comments: true
categories: [rails,ruby]
tags: [helpers,rails,ruby,templates]
---
## Helper Antipatterns
<h2>Helper AntiPatterns</h2>
Helper （輔助方法）的存在目的是用來輔助整理 View 中內嵌的複雜 Ruby 程式碼。設計得當的 Helper 可以加速專案的開發，以及增進程式的可讀性。然而，設計不好的 Helper 卻可能造成嚴重的反效果。

以下列舉常見的幾種糟糕的 Helper 設計模式：
<h3>1. 矯往過正：用 Helper 作 partial 該做的事</h3>
開發者以為 partial 效率是低下的，刻意不使用 partial，而改用 Helper 完成所有的動作：將需要重複使用的 HTML 通通寫成了 Ruby code，串接成 HTML：
def show_index_block(block_name, post, is_show_game)

block_title = content_tag(:h3, block_name)
section_header = content_tag(:div, block_title, :class =&gt; "section-header")

game_name = is_show_game ? "【 #{post.games.first.name} 】" : ""
title = content_tag(:h4, link_to("#{game_name} #{post.title}", post_path(post)))
image = content_tag(:div, render_post_image(post), :class =&gt; "thumbnail")
content = content_tag(:p, truncate( post.content, :length =&gt; 100))
section_content = content_tag(:div, "#{title}#{image}#{content}", :class =&gt; "section-content")

section_footer = content_tag(:div, link_to("閱讀全文", post_path(post)), :class =&gt; "section-footer")

return content_tag(:div, "#{section_header}#{section_content}#{section_footer}" , :class =&gt; "article-teaser")
end
 Helper 的作用只是協助整理 HTML 中的邏輯程式碼。若有大片 HTML 需要重複使用，應當需要利用 partial 機制進行 HTML 的重複利用。這樣的寫法，非但效率低下（可以用 HTML 產生，卻使用 Ruby 呼叫 Tag Helper，且製造大量 Ruby Object），且嚴重降低程式的可讀性，其他維護者將難以對這樣的 DOM 進行後續的維護翻修。

&nbsp;

 
2. 容易混淆：在 Helper 裡面穿插 HTML tag

這也是另外一個矯枉過正的例子，不過方向剛好相反：「因為覺得使用 Ruby code 產生 HTML tag 可能浪費效能，而直接插入 HTML 在 Helper 裡面與 Ruby Code 混雜。」也造成了專案維護上的困難：因為 Ruby 中的字串是使用雙引號"，而 HTML 也是使用雙引號"，，所以就必須特別加入 \" 跳脫，否則就可能造成 syntax error。
錯誤
def post_tags_tag(post, opts = {})
# ....
<span style="background-color: #ff9632;">raw tags.collect</span> { |tag| "#{tag}" }.join(", ")
end
大量的 " 混雜在程式碼裡面，嚴重造成程式的可閱讀性，而且發生 syntax error 時難以 debug。
def post_tags_tag(post, opts = {})
# ....
<span>raw tags.collect</span> { |tag| "#{tag}" }.join(", ")
end
即便換成 ' 單引號，狀況並沒有好上多少。
def post_tags_tag(post, opts = {})
# ...
<span>raw tags.collect</span> { |tag| link_to(tag,posts_path(:tag =&gt; tag)) }.join(", ")
end
正確的作法應該是妥善使用 Rails 內建的 Helper，使 Helper 裡面維持著都是 Ruby code 的狀態，並且具有高可讀性。

3. 強耦合：把 CSS 應該做的事綁在 Ruby Helper 上。

錯誤
def red_alert(message)
return content_tag(:span,message, :style =&gt; "font-color: red;")
end

def green_notice(message)
return content_tag(:span,message, :style =&gt; "font-color: green;")
end
開發者不熟悉 unobtrusive 的設計手法，直接就把 design 就綁上了 Ruby Helper。將來設計上若需要變更時，難以修改或擴充。
正確
def stickies(message, message_type)
content_tag(:span,message, :class =&gt; message_type.to_sym)
end

<span class="alert">Please Login!! </span>
樣式應該由 CSS 決定，使用 CSS class 控制，而非強行綁在 Helper 上。
4. 重複發明輪子

Rails 已內建許多實用 Helper，開發者卻以較糟的方式重造輪子。在此舉幾個比較經典的案例：

cycle
如何設計 table 的雙色列效果？

&lt;% count = 0 &gt; &lt;table&gt; &lt;% @items.each do |item| %&gt; &lt;% if count % 2 == 0 %&gt; &lt;% css_class = "even "%&gt; &lt;% else %&gt; &lt;% css_class = "odd" %&gt; &lt;% end %&gt; &lt;tr class="&lt;%= css_class %&gt;"&gt; &lt;td&gt;item&lt;/td&gt; &lt;/tr&gt; &lt;% count += 1%&gt; &lt;% end %&gt; &lt;/table&gt;

一般的想法會是使用兩種不同 CSS class : even 與 odd，著上不同的顏色。

&lt;table&gt; &lt;% @items.each_with_index do |item, count| %&gt; &lt;% if count % 2 == 0 %&gt; &lt;% css_class = "even "%&gt; &lt;% else %&gt; &lt;% css_class = "odd" %&gt; &lt;% end %&gt; &lt;tr class="&lt;%= css_class %&gt;"&gt; &lt;td&gt;item&lt;/td&gt; &lt;/tr&gt; &lt;% count += 1%&gt; &lt;% end %&gt; &lt;/table&gt;

這是一般粗心者會犯的錯誤。實際上 Ruby 的 Array 內建 each_with_index，不需另外宣告一個 count。
優

&lt;table&gt; &lt;% @items.each_with_index do |item, count| %&gt; &lt;% if count % 2 == 0 %&gt; &lt;% css_class = "even "%&gt; &lt;% else %&gt; &lt;% css_class = "odd" %&gt; &lt;% end %&gt; &lt;tr class="&lt;%= css_class %&gt;"&gt; &lt;td&gt;item&lt;/td&gt; &lt;/tr&gt; &lt;% count += 1%&gt; &lt;% end %&gt; &lt;/table&gt;

但其實還有更簡便的方法：Rails 內建了 <code>cycle</code> 這個 Helper。所以只要這樣寫就好了…

&lt;table&gt; &lt;% @items.each do |item| %&gt; &lt;trodd", "even") %&gt;"&gt; &lt;td&gt;item&lt;/td&gt; &lt;/tr&gt; &lt;% end %&gt; &lt;/table&gt;
<h4>常用你可能不知道的 Helper</h4>
限於篇幅，直接介紹幾個因為使用機率高，所以很容易被重造輪子的 Helper。開發者會寫出的相關 AntiPattern 部分就跳過了。
<ul>
	<li><a href="http://apidock.com/rails/ActionView/Helpers/TextHelper/truncate">truncate</a></li>
	<li><a href="http://apidock.com/rails/ActionView/Helpers/TextHelper/auto_link">auto_link</a></li>
	<li><a href="http://apidock.com/rails/ActionView/Helpers/RecordTagHelper/div_for">div_for</a> &amp; <a href="http://apidock.com/rails/ActionController/RecordIdentifier/dom_id">dom_id</a></li>
	<li><a href="http://apidock.com/rails/ActionView/Helpers/TextHelper/simple_format">simple_format</a></li>
</ul>
<code>#TODO: examples</code>
<h2>5. Tell, dont ask</h2>
<h2>這也是在 View 中會常出現的問題，直接違反了 Law of Demeter 原則，而造成了效能問題。十之八九某個 View 緩慢無比，最後抓出來背後幾乎都是這樣的原因。</h2>
不少開發者會設計出這樣的 helper：

 
def post_tags_tag(post, opts = {})
tags = post.tags
tags.collect { |tag| link_to(tag,posts_path(:tag =&gt; tag)) }.join(", ")
end

這種寫法會造成在 View 中，執行迴圈時，造成不必要的大量 query (n+1)，以及在 View 中製造不確定數量的大量物件。View 不僅效率低落也無法被 optimized。
def post_tags_tag(post, tags, opts = {})
tags.collect { |tag| link_to(tag,posts_path(:tag =&gt; tag)) }.join(", ")
end

def index
@posts = Post.recent.includes(:tags)
end
正確的方法是使用 Tell, dont ask 原則，主動告知會使用的物件，而非讓 Helper 去猜。並配合 ActiveRecord 的 includes 減少不必要的 query（ includes 可以製造 join query ，一次把需要的 posts 和 tags 撈出來）。

且在 controller query 有 object cache 效果，在 view 中則無。

小結

Helper 是 Rails Developer 時常在接觸的工具。但可惜的是，多數開發者卻無法將此利器使得稱手，反而造成了更多問題。在我所曾經參與的幾十個 Rails 專案中，很多設計和效能問題幾乎都是因為寫的不好的 View / Helper 中的 slow query 或伴隨產生的大量 object 所造成的 memory bloat 導致的。但參與專案的開發者並沒有那麼多的經驗，能夠抓出確切的病因，卻都將矛頭直接是 Rails 的效能問題，或者是沒打上 Cache 的關係。這樣的說法只是把問題掩蓋起來治標，而非治本。

下次若有遇到 performance issue，請先往 View 中瞧看看是不是裡面出現了問題。也許你很快就可以找到解答。

Posted by xdite Jan 12th, 2012
