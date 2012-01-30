---
layout: post
title: "git branch"
date: 2012-01-30 14:13
comments: true
categories: 
---

##理解分支
git在创建分支的时候，实际上是从整个提交历史里的某个起点开始（该起点被记录为分支的祖先，标识分支的起始位置），创建提交历史树的枝干。 

由于git每次提交的时候均会记录当次提交的校检和，配合将数据打包存储，记录当前仓库相对于前一版本的变化。所以git的分支，实际上只是一串包含对象校检和（SHA-1）的文件。通过这个校检和，得出分支在提交历史树上的走向。 

git里创建删除分支变得非常简单。这一点不像svn那样每创建一个分支就需要整个目录拷贝一份。在git上非常推荐频繁使用分支。 

甚至可以一个issue(bug)一个分支，解决完切回主分支合并；没解决完就让分支继续走，主分支继续正常任务。 

###基本操作
1. 创建和销毁
2. 分支列表： 

```
$: git branch
* master
  prepub
  product
```
### 创建分支： 

    $: git branch prepub

### 切换已有分支： 

    $: git checkout prepub
    Switched to branch 'prepub'

### 创建并切换分支： 

```
$: git checkout -b issue1234
Switched to branch 'issue1234'
```
### 删除分支： 

```
$: git branch -d issue1234
Deleted branch issue1234 (was b904c07).
```

### 合并和冲突

合并前要先切回 要并入 的分支。 

以下表示issue1234分支合并入master分支 

```
$: git checkout master
$: git merge issue1234
Merge made by recursive.
 README |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)
```
冲突的时候，git会报出哪些文件冲突，这时候需要手动解决完冲突方可提交。 

```
$: git merge issue1234
Auto-merging index.html
CONFLICT (content): Merge conflict in index.html
Automatic merge failed; fix conflicts and then commit the result.
```
通过git status查看冲突文件。 

```
$: git status
index.html: needs merge
# On branch master
# Changed but not updated:
#   (use "git add <file>..." to update what will be committed)
#   (use "git checkout -- <file>..." to discard changes in working directory)
#
#	unmerged:   index.html
#
```
打开index.html，git会在冲突位置做上标示。 

```
<<<<<<< HEAD:index.html
<div id="footer">contact : email.support@github.com</div>
=======
<div id="footer">
  please contact us at support@github.com
</div>
>>>>>>> iss53:index.html
```

解决完冲突，这时候需要手动标识该冲突已经解决，类似svn的resolved。 

```
$: git add index.html
$: git status
# On branch master
# Changed but not updated:
#   (use "git add <file>..." to update what will be committed)
#   (use "git checkout -- <file>..." to discard changes in working directory)
#
#	modified:   index.html
#
```
这时候就可以提交了。
 
```
$: git commit -m "合并issue1234"
[master e3ece67] 合并issue1234
 1 files changed, 1 insertions(+), 0 deletions(-)
```

### 管理多个分支

前面提到，git非常推荐频繁使用分支，在大量分支的情况下，我们需要对分支做好管理（曾经一次上线，开了13个分支 = =） 

通过-v可以看到最后一次提交日志。 

```
$: git branch -v
* master          b904c07 把丘迟的产品搜改动合并一下
  p4popt          8b93380 p4p加上refpid，开发给出来的配置是 P4P_refpid
  prepub          a6cc66b P4P解析参数少一次替换，顺便解决\!失效的问题
  product         301ae4e rankbar图片换成data uri
```

通过--merged和--no-merged来查看分支是否已经合并完成。 

```
$: git branch --merged
* master
  p4popt
$: git branch --no-merged
  prepub
  product
```

未合并的分支，在删除时会提示分支未合并。 

```
$: git branch -d product
warning: deleting branch 'product' that has been merged to
         'refs/remotes/s/product', but it is not yet merged to HEAD.
Deleted branch product (was 301ae4e).
```

### 分支管理流程

一般情况下，分支可以划分为长分支和短分支两种。 

长分支
长期任务 
prepub：上线前合并，根据上线列表，从各个分支中集中到该分支，统一部署提测 
master：上线后合并，长期保留一个稳定可用的分支应付紧急任务 
项目 
较难解决的bug 
新特性试验田 
重构 
长分支，经常会落后其他分支一大截，需要养成习惯，适时从其他重要分支进行合并， 尤其是项目分支 。 

短分支
临时需求 
小bug 
分支可视化
git本身的log提供--gragh选项，可以提供字符界面的分支可视化视图。 

```
$: git log --graph --pretty=oneline
| *   50cc7a78b7f2704a2014afa3667f6ac5b5b47374 merging refs/remotes/origin/prepub into HEAD
| |\  
| | * 8f685bd1be3757effe32d6ff37f86bd07dd2b549 又被无情地冲掉了代码
| * | 75a17b4ad610327a9b0e1eecfc6c4bf9cade7359 修改icon
| |/  
| *   146a0990de450c854b1a7d9995e12979fff2d537 merging refs/remotes/origin/prepub into HEAD
| |\  
| | *   93b379680796eb443961bb8c59008f8ae5678be4 Merge branch 'prepub' of search.ued.taobao.net:projects/search into prepub
| | |\  
| | * | 8b93380ccfb9020bf8f8e1e8a4a553601de3c788 p4p加上refpid，开发给出来的配置是 P4P_refpid
| * | | 08201de89834f6fecb195c2b7c3546b5cafccc85 秒杀折扣浮动层样式
| | |/  
| |/|   
| * | 0f4d1df17f79c7aa3ca3d36ab848c10b78029010 修改icon
| * | ae719fc29cc550321f284323db06a294b97c1398 p4p创意优化
| |/  
| * a6d4501e1456589d30ab1a5800b651876629c8ca 修改icon
```

git还有很多GUI工具，可以提供可视化地分支走势图，比如gitk，qgit，GitX等等。 

远程分支
至今为止，前面所有提到的概念都是直接本地操作的，并不需要任何网络连接。 

而git本身是一个分布式代码管理工具(DVCS)，所以分支管理上，存在本地分支和远程分支两种概念。 

可以简单的理解，远程分支就是别人的本地分支push到服务器上的时候产生的。比如master就是一个最典型的远程分支（默认）。 

    $: git push origin master
除了master之外，我们还可以随便创建分支，然后push到服务器上去。 

```
$: git push origin prepub
Counting objects: 27, done.
Delta compression using up to 2 threads.
Compressing objects: 100% (15/15), done.
Writing objects: 100% (15/15), 7.30 KiB, done.
Total 15 (delta 10), reused 0 (delta 0)
To git@search.ued.taobao.net:projects/search.git
   1b95a57..779dbe1  prepub -> prepub
```

远程分支的标识形式为{remote/branch}，比如origin/product。 

```
$: git branch -a
  master
  p4popt
* prepub
  product
  remotes/origin/HEAD -> origin/master
  remotes/origin/master
  remotes/origin/p4popt
  remotes/origin/prepub
  remotes/origin/product
```

远程分支和本地分支需要区分，所以，在从服务器上拉取特定分支的时候，需要指定本地分支名字。 

```
$: git branch product origin/product
Branch product set up to track remote branch product from origin.
```
而1.6.2以上版本的git，可以通过--track选项，简化这一过程。这也是为什么直接执行git clone的时候，会自动创建本地master分支的原因。（实际上，pull操作相当于fetch+merge。） 

```
$: git checkout --track origin/product
Branch product set up to track remote branch refs/remotes/origin/product.
Switched to a new branch "product"
```

远程分支和本地分支是松散的结构，可以把任意远程分支合并到任意本地分支里；同样，也可以把任意本地分支push到任意远程分支上。 

```
# THIS WILL MESS UP YOUR REPO!!
$: git branch
  master
* prepub
  p4popt
  product
$: git pull origin product
$: git push origin master
```

同步本地远程分支。 


    $: git fetch origin

删除远程分支。 

    $: git push origin :p4popt
    To git@search.ued.taobao.net
