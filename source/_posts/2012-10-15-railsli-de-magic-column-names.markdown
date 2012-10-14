---
layout: post
title: "Rails里的Magic Column Names"
date: 2012-08-27 00:37
comments: true
categories: [rails]
tags: [column,Names,rails]
---
## Rails里的Magic Column Names
Active Record有一些富有“魔力”的列名:

<strong>created_at， created_on， updated_at， updated_on</strong>
在create或者update一行时Rails对_at形式的列用timestamp自动更新，对_on形式的列用date自动更新

<strong>lock_version</strong>
如果一个表有lock_version这个列，则Rails会跟踪一行的版本号并执行乐观锁

<strong>type</strong>
单表继承时跟踪一行的type

<strong>id</strong>
表的默认主键名

<strong>xxx_id</strong>
对以复数形式的xxx命名的表的引用的默认外键名

<strong>xxx_count</strong>
对子表xxx维护一个计数器cache

<strong>position</strong>
acts_as_list时用来表示一个list中该行的position

<strong>parent_id</strong>
acts_as_tree时用来表示该行的parent的id
