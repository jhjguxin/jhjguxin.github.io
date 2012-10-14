---
layout: post
title: "Git Submodule 的認識與正確使用！"
date: 2012-04-19 18:36
comments: true
categories: [Project Manage,专业]
tags: [git,Submodule]
---
## Git Submodule 的認識與正確使用！
<div>

已經用了 git submodule 好一陣子了，今天看到了 <a href="http://johnleach.co.uk/words/323/git-submodules-in-n-easy-steps" target="_blank">Git submodules in N easy steps</a> 才覺得比較搞懂一些之前碰到的問題。趁機來整理、釐清之前常碰到的小問題吧~~
<h2>什麼是 Git Submodule</h2>
剛剛從 SVN 或 CVS 等 Client-Server 架構的版本控制系統切換到 Git 時，可能會有這個想法：「<em>能不能只取得一部分的程式碼、而非整個 Repository？</em>」因為在 SVN/CVS 可以針對 Repository 中的某個目錄 checkout，不需要是整個 Repository、甚至還可以用 SVN Externals 達到不同角色 （視覺、前端、後端）checkout 不同 File Layout（之前在無名小站時，超喜歡 svn:externals 的概念）。

但 Git 是分散式的版本控制系統，每個人都是一個完整的 Repository，沒辦法像 SVN/CVS 指定到某個資料夾。例如你要取得 YUI 3 的 Git，只能 git clone https://github.com/yui/yui3.git、而不能指定到底下的目錄。

SVN/CVS 你可以用目錄區隔大小專案、都在同一個大的 Repository。而 Git 的想法必須修正為<em>每個小專案就是一個 Repository</em>、或<em>不同團隊開發是一個 Repository</em>、甚至<em>功能獨立也可以是一個 Repository</em>。若說 SVN 是包容百川、<em>Git 就是各自獨立的小河流</em>。

但<em>軟體開發團隊不太容易如此單純</em>，有時需要給外包開發、有時需要分工、有時需要用 Open Source，<em>光用以上的切分方式是沒辦法達成所有需求的</em>、還是得將各自獨立的小河流連接起來。例如我先前在 WebRebuild 與 COSCUP 分享的 JavaScript Platform，為了分享把原始碼放了一份到 Github : <a href="http://github.com/josephj/javascript-platform-yui" target="_blank">http://github.com/josephj/javascript-platform-yui</a>，但我的工作及部落格都有使用的需求，該怎麼做呢？如果每次都得 git clone 再 copy 檔案到兩個地方、這樣手工做真的是個很遜的解決方案。好在有 Git Submodule 可以幫忙解決!

簡單來說，Git Submodule 可以<em>輕易地將別人的 git 掛入到你目前 git 的任何位置</em>。
<h2>新增一個 Git Submodule</h2>
例如我有目前本機有一個 josephj.git、在 /home/josephj/www 下，而我需要將 javascript platform 放到 /home/josephj/www/static/ 可以用以下幾行快速達成。
<ul>
	<li>切換到我的 repository 目錄：
<code>$ cd /home/josephj/www</code></li>
	<li>使用 <em>git submodule add [repository 位置] [欲放置的位置]</em> 增加一個新的 submodule：
<code>$ git submodule add git@github.com:josephj/javascript-platform-yui.git static/platform</code>需要注意 [欲放置的位置] 不能以 / 結尾（會造成修改不生效）、也不能已經是現有的路徑喔（不能順利 Clone）。</li>
	<li>按下去就會看到以下結果：
<pre><code>$ git submodule add git://github.com/josephj/javascript-platform-yui.git static/platform Initialized empty Git repository in /home/josephj/www/static/platform/.git/ remote: Counting objects: 31, done. remote: Compressing objects: 100% (31/31), done. remote: Total 31 (delta 14), reused 0 (delta 0) Receiving objects: 100% (31/31), 6.06 KiB, done. Resolving deltas: 100% (14/14), done. </code></pre>
這時在 /home/josephj/www/ 會產生一個 <em>.gitmodules</em> 記錄你的 Submodule 資訊。該 git 的<em>相關檔案也都會在此時被拉下來</em>。</li>
	<li>用 git status 看一下：
<pre><code>$ git status # On branch master # Changes to be committed: # (use "git reset HEAD ..." to unstage) # # new file: .gitmodules # new file: static/platform # </code></pre>
會發現它只列出 submodule 目錄而非所有底下檔案，parent git 實際上也只會記錄 submodule 的 commit id 以供未來做比對用。這裡一個很重要的點是大家必須理解的：<em>parent git 與 submodule git 的關連性（被掛入的目錄、repository 位置）記錄在 .gitmodules 中，而版本控制則是靠 parent git 記住 submodule git 的 commit id。</em></li>
	<li>先 commit 一下：
<pre><code>$ git add .gitmodules static/platform git commit -m "Add submodule into version control";</code></pre>
</li>
	<li>但是你還必須做 init 的動作，你的 .git/config 才會有對應 submodule 的資訊。
<pre><code>$ git submodule init </code></pre>
</li>
</ul>
<h2>更新已安裝的 Submodule</h2>
當初我第一次新增一個 Submodule 後，以為未來它都會像 SVN External 一樣、在我 git pull 的時候自動更新。但實際情況是你<em>必須手動處理才能更新 Submodule</em>。
<ol>
	<li>進入該目錄 Subomdule 目錄： <code>$ cd static/platform</code></li>
	<li>向來源的 master branch 做 git pull 的動作（這裡的 git pull 不會更新你 parent git 的檔案） <code>$ git pull origin master</code></li>
	<li>若 submodule 有更新的檔案，你可以到 parent git 觀看一下情況：
<pre><code>$ cd ../../ $ git status # Not currently on any branch. # Changed but not updated: # (use "git add ..." to update what will be committed) # (use "git checkout -- ..." to discard changes in working directory) # # modified: static/platform (new commits) # no changes added to commit (use "git add" and/or "git commit -a")</code></pre>
與第一次 git submodule add 相同，submodule 更新的檔案並不會在 git status 中要求你 commit 喔！</li>
	<li>我們前面提到，submodule 的版本控制在於 submodule git 的 commit id，上面看到 static/platform 有 new commit。表示你既然把新的內容 pull 回來、應該要更新 submodule 的 commit id 到你的 git 中：
<pre><code>$ git add static/platform $ git commit -m "static/platform submodule updated"</code></pre>
如此一來，新的 submodule commit id 就被你的 repositiory 給記錄下來囉！</li>
</ol>
<h2>團隊使用 Submodule</h2>
在一個多人的軟體開發團隊中，通常還是會有 Centralized Git Repositiory，像我們公司就採用了 gitosis 的解決方案。而像上述更新 Submodule 的情形，通常只有一兩個負責架構的人來做（大多是一開始把東西掛進來的人）、<em>其他人只是單純使用者的角色，並不需要負責更新的工作</em>。
<ol>
	<li>像上面我增加了一個 Submodule，對於團隊其他人來說，他們在下一次的 git pull 會看到以下的狀況：
<pre><code>$ git status # On branch develop # Changed but not updated: # (use "git add ..." to update what will be committed) # (use "git checkout -- ..." to discard changes in working directory) # # modified: static/platform (new commits) # no changes added to commit (use "git add" and/or "git commit -a")</code></pre>
這表示其他人也會拿到 .gitmodules 的設定，但他必須使用 git submodule init 將新的 Submodule 註冊到自己的 .git/config、未來才能使用。
<pre><code>$ git submodule init Submodule 'static/platform' (http://github.com/josephj/javascript-platform-yui.git) registered for path 'static/platform'</code></pre>
</li>
	<li>接著其他人使用 git submodule update 把該 Submodule 的內容全部拉下來！
<pre><code>$ git submodule update Cloning into static/platform... remote: Counting objects: 34, done. remote: Compressing objects: 100% (34/34), done. remote: Total 34 (delta 15), reused 0 (delta 0) Unpacking objects: 100% (34/34), done. Submodule path 'static/platform': checked out '117c5b3c5a195deac2e53aa118b78ef3f01ae371' </code></pre>
</li>
</ol>
<h3>使用時機</h3>
簡單整理一下：
<ul>
	<li><em>git submodule init</em>: 在 .gitmodules 第一次被其他人建立或有新增內容的時候，用 git submodule init <em>更新你的 .git/config、設定目錄與增加 submodule 的 remote URL</em>。</li>
	<li><em>git submodule update</em>: 在 init 完有新的 submodule commit id 後就可以做了，會把所有相關檔案拉下來。若其他人更新 submodule 造成你拿到新的 commit id 時，你可以直接用 git submodule update 做更新即可、不需要做任何 add 或 commit 的動作！</li>
</ul>
可以想見，其他成員使用 git submodule update 的情況會遠比 git submodule init 多很多。
<h2>修改 Submodule 的內容</h2>
有時自己也是 Submodule 的 Owner，碰到要改 Code 時，要我切回原本的此 Git 開發位置有點麻煩... 不如就<em>直接改被當成 Submodule 掛進來的原始碼吧</em>！
<ol>
	<li>到 submodule 目錄去做些修改：
<pre><code>$ cd static/platform $ vim README # 做些修改 </code></pre>
</li>
	<li>接著就是常見的 git add , git commit, git push
<pre><code>$ git add README $ git commit -m "Add comments" $ git push </code></pre>
</li>
	<li>push 完回到根目錄git status 看一下！會看到
<pre><code>$ git status # On branch master # Changed but not updated: # (use "git add ..." to update what will be committed) # (use "git checkout -- ..." to discard changes in working directory) # # modified: static/platform # no changes added to commit (use "git add" and/or "git commit -a")</code></pre>
</li>
	<li>這裡也需要再做一次 Commit 喔！
<pre><code>$ git add static/platform $ git commit -m 'Submodule updated' $ git push </code></pre>
</li>
</ol>
這裡有一點非常需要注意，因為 Submodule 的更新只記錄 commit id，所以<em>你必須先在 submodule 內做 commit、push 後、再到 parent git 做 push</em>，不然會出現版本錯亂的問題，別人跟你 submodule 的內容將會不一致。
<h2>如何移除 Submodule</h2>
這點也<em>非常地不直覺</em>，不是想像中 git submodule remove [欲移除的目錄] 這麼簡單...
<ol>
	<li>先砍掉目錄：
<pre><code>$ git rm --cached [欲移除的目錄] $ rm -rf [欲移除的目錄]</code></pre>
</li>
	<li>再修改 .gitmodules
<pre><code>$ vim .gitmodules</code></pre>
將相關內容移除</li>
	<li>再修改 .git/config
<pre><code>$ vim .git/config</code></pre>
將相關內容移除</li>
	<li>最後再 commit，改變整個 Repository。
<pre><code>$ git add .gitmodules $ git commit -m "Remove a submodule" </code></pre>
</li>
	<li>安全起見再做個 sync：
<pre><code>$ git submodule sync</code></pre>
</li>
</ol>
<h2>結語</h2>
我們公司目前主要將 Submodule 運用在<em>與外包公司的合作</em>上，因為彼此 <span>Engine</span>ering 團隊負責的專案項目雖不同，但<em>有部分的開發會需要在我們的結構下開目錄，我們也不希望他們改到我們的程式</em>，此時 Git Submodule 提供了非常好的分工效果：把他們開發好的東西掛進來、更新即可。另有一點很重要的是， <em>Git Submodule 內還可以將其他的 Submodule 給掛進來，形成一個巢狀式的結構</em>，彈性非常地大。我們只要抓他們的大 Git 當 Submodule，下面怎麼掛就由外包公司決定。

整篇文章看下來，會發現 <em>git submodule 的操作有許多需要注意的地方</em>，像是更新、修改、刪除都要遵循一定的程序，不然你 PUSH 回 Central Repository 時，別人 PULL 下來的 Submodule 可能並不會更新，就會產生混亂了 Orz...

暇不掩瑜，Git Submodule 還是一個強大且團隊開發上非常重要的功能，就盡量使用前先搞懂、小心使用囉 ;)

</div>
<div>

</div>
