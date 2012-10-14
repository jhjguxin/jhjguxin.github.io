---
layout: post
title: "python ruby geek by django社区and ruby-china"
date: 2012-03-20 13:48
comments: true
categories: ["python", "rails", "ruby"]
tags: ["python", "rails", "ruby", "ruby-china"]
---
## python ruby geek by django社区and ruby-china
<p style="text-align: left;">by ruby-china 由 <a href="http://ruby-china.org/users/gaicitadie" data-name="盖茨他爹">gaicitadie</a> 在 <a href="http://ruby-china.org/topics/node27">瞎扯淡</a> 节点</p>

<div>
<p style="text-align: left;">统计一个字符串在另一个字符串中出现的次数，python只需要一个count方法：</p>

<div>
<pre>&gt;&gt;&gt; '11ab1111ab111ac11111'.count('ab') 2</pre>
huacnlee 1楼, 于24小时前回复 irb&gt; '11ab1111ab111ac11111'.scan("ab").count
2
ywencn 2楼, 于24小时前回复 1.9.2p290 :001 &gt;  '11ab1111ab111ac11111'.count('ab')
 =&gt; 5
楼主想表达什么？

ywencn 3楼, 于24小时前回复 哎呀。。。怎么python和ruby的count还不一样，哈哈

huacnlee 4楼, 于24小时前回复 Ruby 的 "".count 统计的是后面所有的字符

dreamrise 5楼, 于24小时前回复 貌似_who还写过一个python与ruby转换的程序？

gaicitadie 6楼, 于23小时前回复 奥运奖牌榜：
国家 金牌数 银牌数 铜牌数
china 37 26 11
usa 30 22 50
russia 30 33 20

中国习惯上先按金牌数排名，金牌数一样的按银牌数再排，如果银牌数再一样就按铜牌数排：

&gt;&gt;&gt; sorted([('china',37,26,11), ('usa',30,22,50), ('russia',30,33,20)], key=lambda x:(-x[1],-x[2],-x[3]))
[('china', 37, 26, 11), ('russia', 30, 33, 20), ('usa', 30, 22, 50)]
美国习惯上金牌银牌铜牌都是奖牌，所以按奖牌总数排序：

&gt;&gt;&gt; sorted([('china',37,26,11), ('usa',30,22,50), ('russia',30,33,20)], key=lambda x:-(x[1]+x[2]+x[3]))
[('usa', 30, 22, 50), ('russia', 30, 33, 20), ('china', 37, 26, 11)]
python的排序达到了类似SQL查询的能力，只需要告诉它排序的条件就可以了，python为数据而生

gaicitadie 7楼, 于23小时前回复 上面的例子是python模拟SQL的order by功能，下面的例子用python模拟SQL的where条件查询

统计金牌数超过35的国家：

&gt;&gt;&gt; [x for x in [('china',37,26,11), ('usa',30,22,50), ('russia',30,33,20)] if x[1]&gt;35]
[('china', 37, 26, 11)]
统计奖牌总数超过100的国家：

&gt;&gt;&gt; [x for x in [('china',37,26,11), ('usa',30,22,50), ('russia',30,33,20)] if x[1]+x[2]+x[3]&gt;100]
[('usa', 30, 22, 50)]
huyong36 8楼, 于23小时前回复 @gaicitadie ruby是

[['china',37,26,11], ['usa',30,22,50], ['russia',30,33,20]].select{|x| x[1] &gt; 35}
[['china',37,26,11], ['usa',30,22,50], ['russia',30,33,20]].select{|x| x[1] + x[2] + x[3] &gt; 100}
quakewang 9楼, 于23小时前回复 #6楼 @gaicitadie
order by 的ruby代码

[['china',37,26,11], ['usa',30,22,50], ['russia',30,33,20]].sort_by{|m| [-m[1], -m[2], -m[3]]}
[['china',37,26,11], ['usa',30,22,50], ['russia',30,33,20]].sort_by{|m| -(m[1] + m[2] + m[3])]}
skandhas 10楼, 于23小时前回复 从楼主的例子直接翻译到Ruby
1 中国习惯上先按金牌数排名，金牌数一样的按银牌数再排，如果银牌数再一样就按铜牌数排：

[['china',37,26,11], ['usa',30,22,50], ['russia',30,33,20]].sort_by{|x| [-x[1],-x[2],-x[3]]}
2 美国习惯上金牌银牌铜牌都是奖牌，所以按奖牌总数排序：

[['china',37,26,11], ['usa',30,22,50], ['russia',30,33,20]].sort_by{|x| -(x[1]+x[2]+x[3])}
3 统计金牌数超过35的国家：

[['china',37,26,11], ['usa',30,22,50], ['russia',30,33,20]].select{|x| x[1] &gt;35}
4 统计奖牌总数超过100的国家：

[['china',37,26,11], ['usa',30,22,50], ['russia',30,33,20]].select{|x| x[1]+x[2]+x[3] &gt; 100}
这两个语言都挺类似，我觉得ruby的select更直观。

另 楼主这个帖子想表达什么？没看出什么来。如果说只通过sorted就说明python是为数据而生的话，那ruby不也是吗。哈哈

daqing 11楼, 于23小时前回复 我来写个Ruby版本的。

第一个，奖牌排序:

data = [[:china, 27, 26, 11], [:usa, 20, 22, 50], [:russia, 30, 33, 20]]

data.sort_by { |x| [-x[1], -x[2], -x[3]] } # 中国排序方法，按金/银/铜牌数
data.sort_by { |x| -(x[1] + x[2] + x[3]) } # 美国排序方法，按奖牌总数
第二个，奖牌统计:

data.select { |x| x[1] &gt; 35 } # 金牌数超过35的国家
data.select { |x| x[1] + x[2] + x[3] &gt; 100 } # 奖牌总数超过100的国家
哪个更简洁，一目了然了吧。

daqing 12楼, 于23小时前回复 原来大家都在回复。。等我写出来才发现。

daqing 13楼, 于23小时前回复 #10楼 @skandhas 看了你的方法，才想到，select是更直接的做法。collect方法会包含nil值。

reus 14楼, 于23小时前回复 Why I Hate Advocacy
<a href="http://www.perl.com/pub/2000/12/advocacy.html">http://www.perl.com/pub/2000/12/advocacy.html</a>

gaicitadie 15楼, 于23小时前回复 总统选举投票，初步唱票记录：

['Jim', 'bush', 'Jim', 'Jim', 'Jim', 'bush', 'obama']
根据唱票记录统计每人的票数并按从多到少排序

&gt;&gt;&gt; l = ['Jim', 'bush', 'Jim', 'Jim', 'Jim', 'bush', 'obama']
&gt;&gt;&gt; sorted(set([(i, l.count(i)) for i in l]), key=lambda x:-x[1])
[('Jim', 4), ('bush', 2), ('obama', 1)]
clearJiang 16楼, 于23小时前回复 #15楼 @gaicitadie 不如直接用collections.Counter

gaicitadie 17楼, 于23小时前回复 #16楼 @clearJiang 低版本没有collections

daqing 18楼, 于23小时前回复 总统选举投票

l = ['Jim', 'bush', 'Jim', 'Jim', 'Jim', 'bush', 'obama']
l.uniq.collect { |x| [x, l.count(x)] }
=&gt; [["Jim", 4], ["bush", 2], ["obama", 1]]
skandhas 19楼, 于22小时前回复 #15楼 @gaicitadie
根据唱票记录统计每人的票数并按从多到少排序:

l = ['Jim', 'bush', 'Jim', 'Jim', 'Jim', 'bush', 'obama']
l.group_by{|i| i}.map{|k,v| [k,v.length] }
quakewang 20楼, 于22小时前回复 python要和ruby比 文件、字符操作或者数组、Hash操作的便利性绝对完败，要砸场还不如在性能上一棍子打死ruby。

bony 21楼, 于22小时前回复 这样的帖子应该多一点。长知识。@skandhas cool.

quakewang 22楼, 于22小时前回复 #15楼 @gaicitadie

['Jim', 'bush', 'Jim', 'Jim', 'Jim', 'bush', 'obama'].inject(Hash.new(0)) {|h, e| h[e] += 1; h}.sort_by{|e| -e[1]}
daqing 23楼, 于22小时前回复 说实话，Python的lambda匿名函数，跟Ruby的Block相比，从书写上就败了。

gaicitadie 24楼, 于22小时前回复 随机设置验证码的4个字符(不包括图片处理部分)

&gt;&gt;&gt; import random
&gt;&gt;&gt; s = 'ABCDEFGHIJKLMNPRSTUVWXYZ'
&gt;&gt;&gt; ''.join(random.sample((s),4))
'EXSG'
&gt;&gt;&gt; ''.join(random.sample((s),4))
'TGYN'
&gt;&gt;&gt; ''.join(random.sample((s),4))
'MEYP'
&gt;&gt;&gt; ''.join(random.sample((s),4))
'TGIF'
&gt;&gt;&gt; ''.join(random.sample((s),4))
'JDWF'
quakewang 25楼, 于22小时前回复 #24楼 @gaicitadie

('A'..'Z').to_a.sample(4).join
reus 26楼, 于22小时前回复 #15楼 @gaicitadie 你这个算法是O(n ^ 2)的，应该用reduce

def stat(acc, x):
  acc.setdefault(x, 0)
  acc[x] += 1
  return acc
sorted(reduce(stat,
  ['Jim', 'bush', 'Jim', 'Jim', 'Jim', 'bush', 'obama'], {}).iteritems(),
    key = lambda x: -x[1])
huyong36 27楼, 于22小时前回复 @skandhas cool,加上个排序。

gaicitadie 28楼, 于22小时前回复 #26楼 @reus reduce不如列表解析快，虽然list.count会重复统计

skandhas 29楼, 于22小时前回复 #27楼 @huyong36
对，是忘了排序

l = ['Jim', 'bush', 'Jim', 'Jim', 'Jim', 'bush', 'obama']
l.group_by{|i| i}.map{|k,v| [k,v.length] }.sort_by{|name,count| -count }
huacnlee 30楼, 于22小时前回复 风格不同而已，用起来都是一样方便。这个就是让我喜欢 Python 和 Ruby 的原因之一。

reus 31楼, 于22小时前回复 #28楼 @gaicitadie
就是慢在count调用上，for i in l遍历数组，且每个元素又再count遍历一次，O(n ^ 2)
reduce只需要遍历一次，O(n)
不信可以测试下

huyong36 32楼, 于22小时前回复 这帖应该是捧场帖,我喜欢这样的学习。

raecoo 33楼, 于22小时前回复 受用

hysios 34楼, 于21小时前回复 •字符串查找
# python
&gt;&gt;&gt; '11ab1111ab111ac11111'.count('ab')
2
# Ruby
ruby-1.9.2-p290 &gt;   '11ab111123ab111ac11111'.count 'ab', 'b'
2
hysios 35楼, 于21小时前回复 •奖牌排序
# python
&gt;&gt;&gt; sorted([('china',37,26,11), ('usa',30,22,50), ('russia',30,33,20)], key=lambda x:(-x[1],-x[2],-x[3]))
[('china', 37, 26, 11), ('russia', 30, 33, 20), ('usa', 30, 22, 50)]
# ruby
ruby-1.9.2-p290 &gt; [['china',37,26,11], ['usa',30,22,50],['russia',30,33,20]].sort_by {|name,j,y,t| [-j,-y,-t] }
 =&gt; [["china", 37, 26, 11], ["russia", 30, 33, 20], ["usa", 30, 22, 50]]
hysios 36楼, 于21小时前回复 •奖牌统计
# python
&gt;&gt;&gt; sorted([('china',37,26,11), ('usa',30,22,50), ('russia',30,33,20)], key=lambda x:-(x[1]+x[2]+x[3]))
[('usa', 30, 22, 50), ('russia', 30, 33, 20), ('china', 37, 26, 11)]
# ruby
ruby-1.9.2-p290 &gt; [['china',37,26,11], ['usa',30,22,50],['russia',30,33,20]].sort_by {|name,j,y,t| [-j + -y + -t] }
 =&gt; [["usa", 30, 22, 50], ["russia", 30, 33, 20], ["china", 37, 26, 11]]
kfll 37楼, 于21小时前回复 捧场..
js:

'11ab1111ab111ac11111'.match(/ab/g).length;
'11ab1111ab111ac11111'.split('ab').length - 1;
中式排名：

[[37, 26, 11], [30, 22, 50], [30, 33, 20]].sort().reverse();
hysios 38楼, 于21小时前回复 总统选举投票，初步唱票记录：

# ruby
&gt;&gt;&gt; l = ['Jim', 'bush', 'Jim', 'Jim', 'Jim', 'bush', 'obama']
&gt;&gt;&gt; sorted(set([(i, l.count(i)) for i in l]), key=lambda x:-x[1])
[('Jim', 4), ('bush', 2), ('obama', 1)]
# ruby
ruby-1.9.2-p290 &gt;  ['bush','Jim', 'bush', 'Jim', 'Jim', 'Jim', 'bush', 'obama'].each_with_object({}) {|name,s| s[name] = s.fetch(name,0) + 1 }.sort
 =&gt; [["Jim", 4], ["bush", 3], ["obama", 1]]
huyong36 39楼, 于21小时前回复 #34楼 @hysios

'11ab111123ab111ac11111'.count 'ab', 'b'
这样不对吧...这样只是找出来字符串里出现b的次数。

irb(main):106:0&gt; '11ab111123ab111ac11111b'.count 'ab', 'b'
=&gt; 3
hysios 40楼, 于21小时前回复 @huyong36 thx count是没办法实现的, 别的方法也不错

huyong36 41楼, 于20小时前回复 #40楼 @hysios 恩,请教

irb(main):115:0&gt; '11ab111123ab111c11111'.count  'a'
=&gt; 2
irb(main):114:0&gt; '11ab111123ab111c11111'.count  'ab'
=&gt; 4
字符可以统计,为什么字符串不能。。

jhjguxin 42楼, 于20小时前回复 @huyong36
count([other_str]+) → fixnum click to toggle source
Each other_str parameter defines a set of characters to count. The intersection of these sets defines the characters to count in str. Any other_str that starts with a caret (^) is negated. The sequence c1–c2 means all characters between c1 and c2.

Guest 43楼, 于20小时前回复 gaicitadie = [['china',37,26,11], ['usa',30,22,50], ['russia',30,33,20]].tap do |man|
  def man.make_self(&amp;process); process.call self; end
  def man.become_egghead
    `python -c "print( sorted([('china',37,26,11), ('usa',30,22,50), ('russia',30,33,20)], key=lambda x:(-x[1],-x[2],-x[3])) )"`
  end
  def man.glow_up
    dont_be_shy = true
    unless self.respond_to? :more_elegant, dont_be_shy
      def self.more_elegant
        self.sort_by { |country, glods, silvers, bronzes| [-glods,-silvers,-bronzes] }
      end
    end
    if self.respond_to? :become_egghead
      class &lt;&lt; self; remove_method :become_egghead; end
    end
    self
  end
end
gaicitadie.make_self &amp;:become_egghead
gaicitadie.glow_up.make_self &amp;:more_elegant
geekontheway 44楼, 于20小时前回复 #41楼 @huyong36 ruby的count 统计的是字符的数量 所以'11ab111123ab111c11111'.count 'ab'等同于'11ab111123ab111c11111'.count 'a' + '11ab111123ab111c11111'.count 'b'

jhjguxin 45楼, 于20小时前回复 简而言之就是 取每一个字符的count的交集

huyong36 46楼, 于20小时前回复 @geekontheway @jhjguxin 3Q...

hysios 47楼, 于20小时前回复 #41楼 @huyong36 count 是统计所有的字符,并不会把参数当成字符串处理

FenRagwort 48楼, 于17小时前回复 合并两个字典/哈希，重复的项目，两个值相加

hash1.merge(hash2) {|dupkey,val1,val2| val1 + val2 }
楼主来个Python的写法？

hhuai 49楼, 于16小时前回复 method_missing, 楼主来个？？

gaicitadie 50楼, 于14小时前回复 #48楼 @FenRagwort ，这个暂时只想到了普通方法

for k,v in hash2.items():
    if k in hash1:
        hash1[k] += v
    else:
        hash1.setdefault(k,v)
zw963 51楼, 于12小时前回复 #19楼 @skandhas

的确酷, 不说说实在的. group_by用来做这个, 真是有点大才小用了.

reus 52楼, 于12小时前回复 #49楼 @hhuai

class Foo:
  def __getattr__(self, name):
    def _foo(*arg, **kwargs):
      return self.method_missing(name, *arg, **kwargs)
    return _foo

  def method_missing(self, name, *args, **kwargs):
    print name, args, kwargs

a = Foo()
a.foo('bar', baz = 'baz')

&nbsp;

huacnlee 1楼, 于24小时前回复 irb&gt; '11ab1111ab111ac11111'.scan("ab").count
2
ywencn 2楼, 于24小时前回复 1.9.2p290 :001 &gt;  '11ab1111ab111ac11111'.count('ab')
 =&gt; 5
楼主想表达什么？

ywencn 3楼, 于24小时前回复 哎呀。。。怎么python和ruby的count还不一样，哈哈

huacnlee 4楼, 于24小时前回复 Ruby 的 "".count 统计的是后面所有的字符

dreamrise 5楼, 于24小时前回复 貌似_who还写过一个python与ruby转换的程序？

gaicitadie 6楼, 于23小时前回复 奥运奖牌榜：
国家 金牌数 银牌数 铜牌数
china 37 26 11
usa 30 22 50
russia 30 33 20

中国习惯上先按金牌数排名，金牌数一样的按银牌数再排，如果银牌数再一样就按铜牌数排：

&gt;&gt;&gt; sorted([('china',37,26,11), ('usa',30,22,50), ('russia',30,33,20)], key=lambda x:(-x[1],-x[2],-x[3]))
[('china', 37, 26, 11), ('russia', 30, 33, 20), ('usa', 30, 22, 50)]
美国习惯上金牌银牌铜牌都是奖牌，所以按奖牌总数排序：

&gt;&gt;&gt; sorted([('china',37,26,11), ('usa',30,22,50), ('russia',30,33,20)], key=lambda x:-(x[1]+x[2]+x[3]))
[('usa', 30, 22, 50), ('russia', 30, 33, 20), ('china', 37, 26, 11)]
python的排序达到了类似SQL查询的能力，只需要告诉它排序的条件就可以了，python为数据而生

gaicitadie 7楼, 于23小时前回复 上面的例子是python模拟SQL的order by功能，下面的例子用python模拟SQL的where条件查询

统计金牌数超过35的国家：

&gt;&gt;&gt; [x for x in [('china',37,26,11), ('usa',30,22,50), ('russia',30,33,20)] if x[1]&gt;35]
[('china', 37, 26, 11)]
统计奖牌总数超过100的国家：

&gt;&gt;&gt; [x for x in [('china',37,26,11), ('usa',30,22,50), ('russia',30,33,20)] if x[1]+x[2]+x[3]&gt;100]
[('usa', 30, 22, 50)]
huyong36 8楼, 于23小时前回复 @gaicitadie ruby是

[['china',37,26,11], ['usa',30,22,50], ['russia',30,33,20]].select{|x| x[1] &gt; 35}
[['china',37,26,11], ['usa',30,22,50], ['russia',30,33,20]].select{|x| x[1] + x[2] + x[3] &gt; 100}
quakewang 9楼, 于23小时前回复 #6楼 @gaicitadie
order by 的ruby代码

[['china',37,26,11], ['usa',30,22,50], ['russia',30,33,20]].sort_by{|m| [-m[1], -m[2], -m[3]]}
[['china',37,26,11], ['usa',30,22,50], ['russia',30,33,20]].sort_by{|m| -(m[1] + m[2] + m[3])]}
skandhas 10楼, 于23小时前回复 从楼主的例子直接翻译到Ruby
1 中国习惯上先按金牌数排名，金牌数一样的按银牌数再排，如果银牌数再一样就按铜牌数排：

[['china',37,26,11], ['usa',30,22,50], ['russia',30,33,20]].sort_by{|x| [-x[1],-x[2],-x[3]]}
2 美国习惯上金牌银牌铜牌都是奖牌，所以按奖牌总数排序：

[['china',37,26,11], ['usa',30,22,50], ['russia',30,33,20]].sort_by{|x| -(x[1]+x[2]+x[3])}
3 统计金牌数超过35的国家：

[['china',37,26,11], ['usa',30,22,50], ['russia',30,33,20]].select{|x| x[1] &gt;35}
4 统计奖牌总数超过100的国家：

[['china',37,26,11], ['usa',30,22,50], ['russia',30,33,20]].select{|x| x[1]+x[2]+x[3] &gt; 100}
这两个语言都挺类似，我觉得ruby的select更直观。

另 楼主这个帖子想表达什么？没看出什么来。如果说只通过sorted就说明python是为数据而生的话，那ruby不也是吗。哈哈

daqing 11楼, 于23小时前回复 我来写个Ruby版本的。

第一个，奖牌排序:

data = [[:china, 27, 26, 11], [:usa, 20, 22, 50], [:russia, 30, 33, 20]]

data.sort_by { |x| [-x[1], -x[2], -x[3]] } # 中国排序方法，按金/银/铜牌数
data.sort_by { |x| -(x[1] + x[2] + x[3]) } # 美国排序方法，按奖牌总数
第二个，奖牌统计:

data.select { |x| x[1] &gt; 35 } # 金牌数超过35的国家
data.select { |x| x[1] + x[2] + x[3] &gt; 100 } # 奖牌总数超过100的国家
哪个更简洁，一目了然了吧。

daqing 12楼, 于23小时前回复 原来大家都在回复。。等我写出来才发现。

daqing 13楼, 于23小时前回复 #10楼 @skandhas 看了你的方法，才想到，select是更直接的做法。collect方法会包含nil值。

reus 14楼, 于23小时前回复 Why I Hate Advocacy
<a href="http://www.perl.com/pub/2000/12/advocacy.html">http://www.perl.com/pub/2000/12/advocacy.html</a>

gaicitadie 15楼, 于23小时前回复 总统选举投票，初步唱票记录：

['Jim', 'bush', 'Jim', 'Jim', 'Jim', 'bush', 'obama']
根据唱票记录统计每人的票数并按从多到少排序

&gt;&gt;&gt; l = ['Jim', 'bush', 'Jim', 'Jim', 'Jim', 'bush', 'obama']
&gt;&gt;&gt; sorted(set([(i, l.count(i)) for i in l]), key=lambda x:-x[1])
[('Jim', 4), ('bush', 2), ('obama', 1)]
clearJiang 16楼, 于23小时前回复 #15楼 @gaicitadie 不如直接用collections.Counter

gaicitadie 17楼, 于23小时前回复 #16楼 @clearJiang 低版本没有collections

daqing 18楼, 于23小时前回复 总统选举投票

l = ['Jim', 'bush', 'Jim', 'Jim', 'Jim', 'bush', 'obama']
l.uniq.collect { |x| [x, l.count(x)] }
=&gt; [["Jim", 4], ["bush", 2], ["obama", 1]]
skandhas 19楼, 于22小时前回复 #15楼 @gaicitadie
根据唱票记录统计每人的票数并按从多到少排序:

l = ['Jim', 'bush', 'Jim', 'Jim', 'Jim', 'bush', 'obama']
l.group_by{|i| i}.map{|k,v| [k,v.length] }
quakewang 20楼, 于22小时前回复 python要和ruby比 文件、字符操作或者数组、Hash操作的便利性绝对完败，要砸场还不如在性能上一棍子打死ruby。

bony 21楼, 于22小时前回复 这样的帖子应该多一点。长知识。@skandhas cool.

quakewang 22楼, 于22小时前回复 #15楼 @gaicitadie

['Jim', 'bush', 'Jim', 'Jim', 'Jim', 'bush', 'obama'].inject(Hash.new(0)) {|h, e| h[e] += 1; h}.sort_by{|e| -e[1]}
daqing 23楼, 于22小时前回复 说实话，Python的lambda匿名函数，跟Ruby的Block相比，从书写上就败了。

gaicitadie 24楼, 于22小时前回复 随机设置验证码的4个字符(不包括图片处理部分)

&gt;&gt;&gt; import random
&gt;&gt;&gt; s = 'ABCDEFGHIJKLMNPRSTUVWXYZ'
&gt;&gt;&gt; ''.join(random.sample((s),4))
'EXSG'
&gt;&gt;&gt; ''.join(random.sample((s),4))
'TGYN'
&gt;&gt;&gt; ''.join(random.sample((s),4))
'MEYP'
&gt;&gt;&gt; ''.join(random.sample((s),4))
'TGIF'
&gt;&gt;&gt; ''.join(random.sample((s),4))
'JDWF'
quakewang 25楼, 于22小时前回复 #24楼 @gaicitadie

('A'..'Z').to_a.sample(4).join
reus 26楼, 于22小时前回复 #15楼 @gaicitadie 你这个算法是O(n ^ 2)的，应该用reduce

def stat(acc, x):
  acc.setdefault(x, 0)
  acc[x] += 1
  return acc
sorted(reduce(stat,
  ['Jim', 'bush', 'Jim', 'Jim', 'Jim', 'bush', 'obama'], {}).iteritems(),
    key = lambda x: -x[1])
huyong36 27楼, 于22小时前回复 @skandhas cool,加上个排序。

gaicitadie 28楼, 于22小时前回复 #26楼 @reus reduce不如列表解析快，虽然list.count会重复统计

skandhas 29楼, 于22小时前回复 #27楼 @huyong36
对，是忘了排序

l = ['Jim', 'bush', 'Jim', 'Jim', 'Jim', 'bush', 'obama']
l.group_by{|i| i}.map{|k,v| [k,v.length] }.sort_by{|name,count| -count }
huacnlee 30楼, 于22小时前回复 风格不同而已，用起来都是一样方便。这个就是让我喜欢 Python 和 Ruby 的原因之一。

reus 31楼, 于22小时前回复 #28楼 @gaicitadie
就是慢在count调用上，for i in l遍历数组，且每个元素又再count遍历一次，O(n ^ 2)
reduce只需要遍历一次，O(n)
不信可以测试下

huyong36 32楼, 于22小时前回复 这帖应该是捧场帖,我喜欢这样的学习。

raecoo 33楼, 于22小时前回复 受用

hysios 34楼, 于21小时前回复 •字符串查找
# python
&gt;&gt;&gt; '11ab1111ab111ac11111'.count('ab')
2
# Ruby
ruby-1.9.2-p290 &gt;   '11ab111123ab111ac11111'.count 'ab', 'b'
2
hysios 35楼, 于21小时前回复 •奖牌排序
# python
&gt;&gt;&gt; sorted([('china',37,26,11), ('usa',30,22,50), ('russia',30,33,20)], key=lambda x:(-x[1],-x[2],-x[3]))
[('china', 37, 26, 11), ('russia', 30, 33, 20), ('usa', 30, 22, 50)]
# ruby
ruby-1.9.2-p290 &gt; [['china',37,26,11], ['usa',30,22,50],['russia',30,33,20]].sort_by {|name,j,y,t| [-j,-y,-t] }
 =&gt; [["china", 37, 26, 11], ["russia", 30, 33, 20], ["usa", 30, 22, 50]]
hysios 36楼, 于21小时前回复 •奖牌统计
# python
&gt;&gt;&gt; sorted([('china',37,26,11), ('usa',30,22,50), ('russia',30,33,20)], key=lambda x:-(x[1]+x[2]+x[3]))
[('usa', 30, 22, 50), ('russia', 30, 33, 20), ('china', 37, 26, 11)]
# ruby
ruby-1.9.2-p290 &gt; [['china',37,26,11], ['usa',30,22,50],['russia',30,33,20]].sort_by {|name,j,y,t| [-j + -y + -t] }
 =&gt; [["usa", 30, 22, 50], ["russia", 30, 33, 20], ["china", 37, 26, 11]]
kfll 37楼, 于21小时前回复 捧场..
js:

'11ab1111ab111ac11111'.match(/ab/g).length;
'11ab1111ab111ac11111'.split('ab').length - 1;
中式排名：

[[37, 26, 11], [30, 22, 50], [30, 33, 20]].sort().reverse();
hysios 38楼, 于21小时前回复 总统选举投票，初步唱票记录：

# ruby
&gt;&gt;&gt; l = ['Jim', 'bush', 'Jim', 'Jim', 'Jim', 'bush', 'obama']
&gt;&gt;&gt; sorted(set([(i, l.count(i)) for i in l]), key=lambda x:-x[1])
[('Jim', 4), ('bush', 2), ('obama', 1)]
# ruby
ruby-1.9.2-p290 &gt;  ['bush','Jim', 'bush', 'Jim', 'Jim', 'Jim', 'bush', 'obama'].each_with_object({}) {|name,s| s[name] = s.fetch(name,0) + 1 }.sort
 =&gt; [["Jim", 4], ["bush", 3], ["obama", 1]]
huyong36 39楼, 于21小时前回复 #34楼 @hysios

'11ab111123ab111ac11111'.count 'ab', 'b'
这样不对吧...这样只是找出来字符串里出现b的次数。

irb(main):106:0&gt; '11ab111123ab111ac11111b'.count 'ab', 'b'
=&gt; 3
hysios 40楼, 于21小时前回复 @huyong36 thx count是没办法实现的, 别的方法也不错

huyong36 41楼, 于20小时前回复 #40楼 @hysios 恩,请教

irb(main):115:0&gt; '11ab111123ab111c11111'.count  'a'
=&gt; 2
irb(main):114:0&gt; '11ab111123ab111c11111'.count  'ab'
=&gt; 4
字符可以统计,为什么字符串不能。。

jhjguxin 42楼, 于20小时前回复 @huyong36
count([other_str]+) → fixnum click to toggle source
Each other_str parameter defines a set of characters to count. The intersection of these sets defines the characters to count in str. Any other_str that starts with a caret (^) is negated. The sequence c1–c2 means all characters between c1 and c2.

Guest 43楼, 于20小时前回复 gaicitadie = [['china',37,26,11], ['usa',30,22,50], ['russia',30,33,20]].tap do |man|
  def man.make_self(&amp;process); process.call self; end
  def man.become_egghead
    `python -c "print( sorted([('china',37,26,11), ('usa',30,22,50), ('russia',30,33,20)], key=lambda x:(-x[1],-x[2],-x[3])) )"`
  end
  def man.glow_up
    dont_be_shy = true
    unless self.respond_to? :more_elegant, dont_be_shy
      def self.more_elegant
        self.sort_by { |country, glods, silvers, bronzes| [-glods,-silvers,-bronzes] }
      end
    end
    if self.respond_to? :become_egghead
      class &lt;&lt; self; remove_method :become_egghead; end
    end
    self
  end
end
gaicitadie.make_self &amp;:become_egghead
gaicitadie.glow_up.make_self &amp;:more_elegant
geekontheway 44楼, 于20小时前回复 #41楼 @huyong36 ruby的count 统计的是字符的数量 所以'11ab111123ab111c11111'.count 'ab'等同于'11ab111123ab111c11111'.count 'a' + '11ab111123ab111c11111'.count 'b'

jhjguxin 45楼, 于20小时前回复 简而言之就是 取每一个字符的count的交集

huyong36 46楼, 于20小时前回复 @geekontheway @jhjguxin 3Q...

hysios 47楼, 于20小时前回复 #41楼 @huyong36 count 是统计所有的字符,并不会把参数当成字符串处理

FenRagwort 48楼, 于17小时前回复 合并两个字典/哈希，重复的项目，两个值相加

hash1.merge(hash2) {|dupkey,val1,val2| val1 + val2 }
楼主来个Python的写法？

hhuai 49楼, 于16小时前回复 method_missing, 楼主来个？？

gaicitadie 50楼, 于14小时前回复 #48楼 @FenRagwort ，这个暂时只想到了普通方法

for k,v in hash2.items():
    if k in hash1:
        hash1[k] += v
    else:
        hash1.setdefault(k,v)
zw963 51楼, 于12小时前回复 #19楼 @skandhas

的确酷, 不说说实在的. group_by用来做这个, 真是有点大才小用了.

reus 52楼, 于12小时前回复 #49楼 @hhuai

class Foo:
  def __getattr__(self, name):
    def _foo(*arg, **kwargs):
      return self.method_missing(name, *arg, **kwargs)
    return _foo

  def method_missing(self, name, *args, **kwargs):
    print name, args, kwargs

a = Foo()
a.foo('bar', baz = 'baz')

&nbsp;

huacnlee 1楼, 于24小时前回复 irb&gt; '11ab1111ab111ac11111'.scan("ab").count
2
ywencn 2楼, 于24小时前回复 1.9.2p290 :001 &gt;  '11ab1111ab111ac11111'.count('ab')
 =&gt; 5
楼主想表达什么？

ywencn 3楼, 于24小时前回复 哎呀。。。怎么python和ruby的count还不一样，哈哈

huacnlee 4楼, 于24小时前回复 Ruby 的 "".count 统计的是后面所有的字符

dreamrise 5楼, 于24小时前回复 貌似_who还写过一个python与ruby转换的程序？

gaicitadie 6楼, 于23小时前回复 奥运奖牌榜：
国家 金牌数 银牌数 铜牌数
china 37 26 11
usa 30 22 50
russia 30 33 20

中国习惯上先按金牌数排名，金牌数一样的按银牌数再排，如果银牌数再一样就按铜牌数排：

&gt;&gt;&gt; sorted([('china',37,26,11), ('usa',30,22,50), ('russia',30,33,20)], key=lambda x:(-x[1],-x[2],-x[3]))
[('china', 37, 26, 11), ('russia', 30, 33, 20), ('usa', 30, 22, 50)]
美国习惯上金牌银牌铜牌都是奖牌，所以按奖牌总数排序：

&gt;&gt;&gt; sorted([('china',37,26,11), ('usa',30,22,50), ('russia',30,33,20)], key=lambda x:-(x[1]+x[2]+x[3]))
[('usa', 30, 22, 50), ('russia', 30, 33, 20), ('china', 37, 26, 11)]
python的排序达到了类似SQL查询的能力，只需要告诉它排序的条件就可以了，python为数据而生

gaicitadie 7楼, 于23小时前回复 上面的例子是python模拟SQL的order by功能，下面的例子用python模拟SQL的where条件查询

统计金牌数超过35的国家：

&gt;&gt;&gt; [x for x in [('china',37,26,11), ('usa',30,22,50), ('russia',30,33,20)] if x[1]&gt;35]
[('china', 37, 26, 11)]
统计奖牌总数超过100的国家：

&gt;&gt;&gt; [x for x in [('china',37,26,11), ('usa',30,22,50), ('russia',30,33,20)] if x[1]+x[2]+x[3]&gt;100]
[('usa', 30, 22, 50)]
huyong36 8楼, 于23小时前回复 @gaicitadie ruby是

[['china',37,26,11], ['usa',30,22,50], ['russia',30,33,20]].select{|x| x[1] &gt; 35}
[['china',37,26,11], ['usa',30,22,50], ['russia',30,33,20]].select{|x| x[1] + x[2] + x[3] &gt; 100}
quakewang 9楼, 于23小时前回复 #6楼 @gaicitadie
order by 的ruby代码

[['china',37,26,11], ['usa',30,22,50], ['russia',30,33,20]].sort_by{|m| [-m[1], -m[2], -m[3]]}
[['china',37,26,11], ['usa',30,22,50], ['russia',30,33,20]].sort_by{|m| -(m[1] + m[2] + m[3])]}
skandhas 10楼, 于23小时前回复 从楼主的例子直接翻译到Ruby
1 中国习惯上先按金牌数排名，金牌数一样的按银牌数再排，如果银牌数再一样就按铜牌数排：

[['china',37,26,11], ['usa',30,22,50], ['russia',30,33,20]].sort_by{|x| [-x[1],-x[2],-x[3]]}
2 美国习惯上金牌银牌铜牌都是奖牌，所以按奖牌总数排序：

[['china',37,26,11], ['usa',30,22,50], ['russia',30,33,20]].sort_by{|x| -(x[1]+x[2]+x[3])}
3 统计金牌数超过35的国家：

[['china',37,26,11], ['usa',30,22,50], ['russia',30,33,20]].select{|x| x[1] &gt;35}
4 统计奖牌总数超过100的国家：

[['china',37,26,11], ['usa',30,22,50], ['russia',30,33,20]].select{|x| x[1]+x[2]+x[3] &gt; 100}
这两个语言都挺类似，我觉得ruby的select更直观。

另 楼主这个帖子想表达什么？没看出什么来。如果说只通过sorted就说明python是为数据而生的话，那ruby不也是吗。哈哈

daqing 11楼, 于23小时前回复 我来写个Ruby版本的。

第一个，奖牌排序:

data = [[:china, 27, 26, 11], [:usa, 20, 22, 50], [:russia, 30, 33, 20]]

data.sort_by { |x| [-x[1], -x[2], -x[3]] } # 中国排序方法，按金/银/铜牌数
data.sort_by { |x| -(x[1] + x[2] + x[3]) } # 美国排序方法，按奖牌总数
第二个，奖牌统计:

data.select { |x| x[1] &gt; 35 } # 金牌数超过35的国家
data.select { |x| x[1] + x[2] + x[3] &gt; 100 } # 奖牌总数超过100的国家
哪个更简洁，一目了然了吧。

daqing 12楼, 于23小时前回复 原来大家都在回复。。等我写出来才发现。

daqing 13楼, 于23小时前回复 #10楼 @skandhas 看了你的方法，才想到，select是更直接的做法。collect方法会包含nil值。

reus 14楼, 于23小时前回复 Why I Hate Advocacy
<a href="http://www.perl.com/pub/2000/12/advocacy.html">http://www.perl.com/pub/2000/12/advocacy.html</a>

gaicitadie 15楼, 于23小时前回复 总统选举投票，初步唱票记录：

['Jim', 'bush', 'Jim', 'Jim', 'Jim', 'bush', 'obama']
根据唱票记录统计每人的票数并按从多到少排序

&gt;&gt;&gt; l = ['Jim', 'bush', 'Jim', 'Jim', 'Jim', 'bush', 'obama']
&gt;&gt;&gt; sorted(set([(i, l.count(i)) for i in l]), key=lambda x:-x[1])
[('Jim', 4), ('bush', 2), ('obama', 1)]
clearJiang 16楼, 于23小时前回复 #15楼 @gaicitadie 不如直接用collections.Counter

gaicitadie 17楼, 于23小时前回复 #16楼 @clearJiang 低版本没有collections

daqing 18楼, 于23小时前回复 总统选举投票

l = ['Jim', 'bush', 'Jim', 'Jim', 'Jim', 'bush', 'obama']
l.uniq.collect { |x| [x, l.count(x)] }
=&gt; [["Jim", 4], ["bush", 2], ["obama", 1]]
skandhas 19楼, 于22小时前回复 #15楼 @gaicitadie
根据唱票记录统计每人的票数并按从多到少排序:

l = ['Jim', 'bush', 'Jim', 'Jim', 'Jim', 'bush', 'obama']
l.group_by{|i| i}.map{|k,v| [k,v.length] }
quakewang 20楼, 于22小时前回复 python要和ruby比 文件、字符操作或者数组、Hash操作的便利性绝对完败，要砸场还不如在性能上一棍子打死ruby。

bony 21楼, 于22小时前回复 这样的帖子应该多一点。长知识。@skandhas cool.

quakewang 22楼, 于22小时前回复 #15楼 @gaicitadie

['Jim', 'bush', 'Jim', 'Jim', 'Jim', 'bush', 'obama'].inject(Hash.new(0)) {|h, e| h[e] += 1; h}.sort_by{|e| -e[1]}
daqing 23楼, 于22小时前回复 说实话，Python的lambda匿名函数，跟Ruby的Block相比，从书写上就败了。

gaicitadie 24楼, 于22小时前回复 随机设置验证码的4个字符(不包括图片处理部分)

&gt;&gt;&gt; import random
&gt;&gt;&gt; s = 'ABCDEFGHIJKLMNPRSTUVWXYZ'
&gt;&gt;&gt; ''.join(random.sample((s),4))
'EXSG'
&gt;&gt;&gt; ''.join(random.sample((s),4))
'TGYN'
&gt;&gt;&gt; ''.join(random.sample((s),4))
'MEYP'
&gt;&gt;&gt; ''.join(random.sample((s),4))
'TGIF'
&gt;&gt;&gt; ''.join(random.sample((s),4))
'JDWF'
quakewang 25楼, 于22小时前回复 #24楼 @gaicitadie

('A'..'Z').to_a.sample(4).join
reus 26楼, 于22小时前回复 #15楼 @gaicitadie 你这个算法是O(n ^ 2)的，应该用reduce

def stat(acc, x):
  acc.setdefault(x, 0)
  acc[x] += 1
  return acc
sorted(reduce(stat,
  ['Jim', 'bush', 'Jim', 'Jim', 'Jim', 'bush', 'obama'], {}).iteritems(),
    key = lambda x: -x[1])
huyong36 27楼, 于22小时前回复 @skandhas cool,加上个排序。

gaicitadie 28楼, 于22小时前回复 #26楼 @reus reduce不如列表解析快，虽然list.count会重复统计

skandhas 29楼, 于22小时前回复 #27楼 @huyong36
对，是忘了排序

l = ['Jim', 'bush', 'Jim', 'Jim', 'Jim', 'bush', 'obama']
l.group_by{|i| i}.map{|k,v| [k,v.length] }.sort_by{|name,count| -count }
huacnlee 30楼, 于22小时前回复 风格不同而已，用起来都是一样方便。这个就是让我喜欢 Python 和 Ruby 的原因之一。

reus 31楼, 于22小时前回复 #28楼 @gaicitadie
就是慢在count调用上，for i in l遍历数组，且每个元素又再count遍历一次，O(n ^ 2)
reduce只需要遍历一次，O(n)
不信可以测试下

huyong36 32楼, 于22小时前回复 这帖应该是捧场帖,我喜欢这样的学习。

raecoo 33楼, 于22小时前回复 受用

hysios 34楼, 于21小时前回复 •字符串查找
# python
&gt;&gt;&gt; '11ab1111ab111ac11111'.count('ab')
2
# Ruby
ruby-1.9.2-p290 &gt;   '11ab111123ab111ac11111'.count 'ab', 'b'
2
hysios 35楼, 于21小时前回复 •奖牌排序
# python
&gt;&gt;&gt; sorted([('china',37,26,11), ('usa',30,22,50), ('russia',30,33,20)], key=lambda x:(-x[1],-x[2],-x[3]))
[('china', 37, 26, 11), ('russia', 30, 33, 20), ('usa', 30, 22, 50)]
# ruby
ruby-1.9.2-p290 &gt; [['china',37,26,11], ['usa',30,22,50],['russia',30,33,20]].sort_by {|name,j,y,t| [-j,-y,-t] }
 =&gt; [["china", 37, 26, 11], ["russia", 30, 33, 20], ["usa", 30, 22, 50]]
hysios 36楼, 于21小时前回复 •奖牌统计
# python
&gt;&gt;&gt; sorted([('china',37,26,11), ('usa',30,22,50), ('russia',30,33,20)], key=lambda x:-(x[1]+x[2]+x[3]))
[('usa', 30, 22, 50), ('russia', 30, 33, 20), ('china', 37, 26, 11)]
# ruby
ruby-1.9.2-p290 &gt; [['china',37,26,11], ['usa',30,22,50],['russia',30,33,20]].sort_by {|name,j,y,t| [-j + -y + -t] }
 =&gt; [["usa", 30, 22, 50], ["russia", 30, 33, 20], ["china", 37, 26, 11]]
kfll 37楼, 于21小时前回复 捧场..
js:

'11ab1111ab111ac11111'.match(/ab/g).length;
'11ab1111ab111ac11111'.split('ab').length - 1;
中式排名：

[[37, 26, 11], [30, 22, 50], [30, 33, 20]].sort().reverse();
hysios 38楼, 于21小时前回复 总统选举投票，初步唱票记录：

# ruby
&gt;&gt;&gt; l = ['Jim', 'bush', 'Jim', 'Jim', 'Jim', 'bush', 'obama']
&gt;&gt;&gt; sorted(set([(i, l.count(i)) for i in l]), key=lambda x:-x[1])
[('Jim', 4), ('bush', 2), ('obama', 1)]
# ruby
ruby-1.9.2-p290 &gt;  ['bush','Jim', 'bush', 'Jim', 'Jim', 'Jim', 'bush', 'obama'].each_with_object({}) {|name,s| s[name] = s.fetch(name,0) + 1 }.sort
 =&gt; [["Jim", 4], ["bush", 3], ["obama", 1]]
huyong36 39楼, 于21小时前回复 #34楼 @hysios

'11ab111123ab111ac11111'.count 'ab', 'b'
这样不对吧...这样只是找出来字符串里出现b的次数。

irb(main):106:0&gt; '11ab111123ab111ac11111b'.count 'ab', 'b'
=&gt; 3
hysios 40楼, 于21小时前回复 @huyong36 thx count是没办法实现的, 别的方法也不错

huyong36 41楼, 于20小时前回复 #40楼 @hysios 恩,请教

irb(main):115:0&gt; '11ab111123ab111c11111'.count  'a'
=&gt; 2
irb(main):114:0&gt; '11ab111123ab111c11111'.count  'ab'
=&gt; 4
字符可以统计,为什么字符串不能。。

jhjguxin 42楼, 于20小时前回复 @huyong36
count([other_str]+) → fixnum click to toggle source
Each other_str parameter defines a set of characters to count. The intersection of these sets defines the characters to count in str. Any other_str that starts with a caret (^) is negated. The sequence c1–c2 means all characters between c1 and c2.

Guest 43楼, 于20小时前回复 gaicitadie = [['china',37,26,11], ['usa',30,22,50], ['russia',30,33,20]].tap do |man|
  def man.make_self(&amp;process); process.call self; end
  def man.become_egghead
    `python -c "print( sorted([('china',37,26,11), ('usa',30,22,50), ('russia',30,33,20)], key=lambda x:(-x[1],-x[2],-x[3])) )"`
  end
  def man.glow_up
    dont_be_shy = true
    unless self.respond_to? :more_elegant, dont_be_shy
      def self.more_elegant
        self.sort_by { |country, glods, silvers, bronzes| [-glods,-silvers,-bronzes] }
      end
    end
    if self.respond_to? :become_egghead
      class &lt;&lt; self; remove_method :become_egghead; end
    end
    self
  end
end
gaicitadie.make_self &amp;:become_egghead
gaicitadie.glow_up.make_self &amp;:more_elegant
geekontheway 44楼, 于20小时前回复 #41楼 @huyong36 ruby的count 统计的是字符的数量 所以'11ab111123ab111c11111'.count 'ab'等同于'11ab111123ab111c11111'.count 'a' + '11ab111123ab111c11111'.count 'b'

jhjguxin 45楼, 于20小时前回复 简而言之就是 取每一个字符的count的交集

huyong36 46楼, 于20小时前回复 @geekontheway @jhjguxin 3Q...

hysios 47楼, 于20小时前回复 #41楼 @huyong36 count 是统计所有的字符,并不会把参数当成字符串处理

FenRagwort 48楼, 于17小时前回复 合并两个字典/哈希，重复的项目，两个值相加

hash1.merge(hash2) {|dupkey,val1,val2| val1 + val2 }
楼主来个Python的写法？

hhuai 49楼, 于16小时前回复 method_missing, 楼主来个？？

gaicitadie 50楼, 于14小时前回复 #48楼 @FenRagwort ，这个暂时只想到了普通方法

for k,v in hash2.items():
    if k in hash1:
        hash1[k] += v
    else:
        hash1.setdefault(k,v)
zw963 51楼, 于12小时前回复 #19楼 @skandhas

的确酷, 不说说实在的. group_by用来做这个, 真是有点大才小用了.

reus 52楼, 于12小时前回复 #49楼 @hhuai

class Foo:
  def __getattr__(self, name):
    def _foo(*arg, **kwargs):
      return self.method_missing(name, *arg, **kwargs)
    return _foo

  def method_missing(self, name, *args, **kwargs):
    print name, args, kwargs

a = Foo()
a.foo('bar', baz = 'baz')

&nbsp;

huacnlee 1楼, 于24小时前回复 irb&gt; '11ab1111ab111ac11111'.scan("ab").count
2
ywencn 2楼, 于24小时前回复 1.9.2p290 :001 &gt;  '11ab1111ab111ac11111'.count('ab')
 =&gt; 5
楼主想表达什么？

ywencn 3楼, 于24小时前回复 哎呀。。。怎么python和ruby的count还不一样，哈哈

huacnlee 4楼, 于24小时前回复 Ruby 的 "".count 统计的是后面所有的字符

dreamrise 5楼, 于24小时前回复 貌似_who还写过一个python与ruby转换的程序？

gaicitadie 6楼, 于23小时前回复 奥运奖牌榜：
国家 金牌数 银牌数 铜牌数
china 37 26 11
usa 30 22 50
russia 30 33 20

中国习惯上先按金牌数排名，金牌数一样的按银牌数再排，如果银牌数再一样就按铜牌数排：

&gt;&gt;&gt; sorted([('china',37,26,11), ('usa',30,22,50), ('russia',30,33,20)], key=lambda x:(-x[1],-x[2],-x[3]))
[('china', 37, 26, 11), ('russia', 30, 33, 20), ('usa', 30, 22, 50)]
美国习惯上金牌银牌铜牌都是奖牌，所以按奖牌总数排序：

&gt;&gt;&gt; sorted([('china',37,26,11), ('usa',30,22,50), ('russia',30,33,20)], key=lambda x:-(x[1]+x[2]+x[3]))
[('usa', 30, 22, 50), ('russia', 30, 33, 20), ('china', 37, 26, 11)]
python的排序达到了类似SQL查询的能力，只需要告诉它排序的条件就可以了，python为数据而生

gaicitadie 7楼, 于23小时前回复 上面的例子是python模拟SQL的order by功能，下面的例子用python模拟SQL的where条件查询

统计金牌数超过35的国家：

&gt;&gt;&gt; [x for x in [('china',37,26,11), ('usa',30,22,50), ('russia',30,33,20)] if x[1]&gt;35]
[('china', 37, 26, 11)]
统计奖牌总数超过100的国家：

&gt;&gt;&gt; [x for x in [('china',37,26,11), ('usa',30,22,50), ('russia',30,33,20)] if x[1]+x[2]+x[3]&gt;100]
[('usa', 30, 22, 50)]
huyong36 8楼, 于23小时前回复 @gaicitadie ruby是

[['china',37,26,11], ['usa',30,22,50], ['russia',30,33,20]].select{|x| x[1] &gt; 35}
[['china',37,26,11], ['usa',30,22,50], ['russia',30,33,20]].select{|x| x[1] + x[2] + x[3] &gt; 100}
quakewang 9楼, 于23小时前回复 #6楼 @gaicitadie
order by 的ruby代码

[['china',37,26,11], ['usa',30,22,50], ['russia',30,33,20]].sort_by{|m| [-m[1], -m[2], -m[3]]}
[['china',37,26,11], ['usa',30,22,50], ['russia',30,33,20]].sort_by{|m| -(m[1] + m[2] + m[3])]}
skandhas 10楼, 于23小时前回复 从楼主的例子直接翻译到Ruby
1 中国习惯上先按金牌数排名，金牌数一样的按银牌数再排，如果银牌数再一样就按铜牌数排：

[['china',37,26,11], ['usa',30,22,50], ['russia',30,33,20]].sort_by{|x| [-x[1],-x[2],-x[3]]}
2 美国习惯上金牌银牌铜牌都是奖牌，所以按奖牌总数排序：

[['china',37,26,11], ['usa',30,22,50], ['russia',30,33,20]].sort_by{|x| -(x[1]+x[2]+x[3])}
3 统计金牌数超过35的国家：

[['china',37,26,11], ['usa',30,22,50], ['russia',30,33,20]].select{|x| x[1] &gt;35}
4 统计奖牌总数超过100的国家：

[['china',37,26,11], ['usa',30,22,50], ['russia',30,33,20]].select{|x| x[1]+x[2]+x[3] &gt; 100}
这两个语言都挺类似，我觉得ruby的select更直观。

另 楼主这个帖子想表达什么？没看出什么来。如果说只通过sorted就说明python是为数据而生的话，那ruby不也是吗。哈哈

daqing 11楼, 于23小时前回复 我来写个Ruby版本的。

第一个，奖牌排序:

data = [[:china, 27, 26, 11], [:usa, 20, 22, 50], [:russia, 30, 33, 20]]

data.sort_by { |x| [-x[1], -x[2], -x[3]] } # 中国排序方法，按金/银/铜牌数
data.sort_by { |x| -(x[1] + x[2] + x[3]) } # 美国排序方法，按奖牌总数
第二个，奖牌统计:

data.select { |x| x[1] &gt; 35 } # 金牌数超过35的国家
data.select { |x| x[1] + x[2] + x[3] &gt; 100 } # 奖牌总数超过100的国家
哪个更简洁，一目了然了吧。

daqing 12楼, 于23小时前回复 原来大家都在回复。。等我写出来才发现。

daqing 13楼, 于23小时前回复 #10楼 @skandhas 看了你的方法，才想到，select是更直接的做法。collect方法会包含nil值。

reus 14楼, 于23小时前回复 Why I Hate Advocacy
<a href="http://www.perl.com/pub/2000/12/advocacy.html">http://www.perl.com/pub/2000/12/advocacy.html</a>

gaicitadie 15楼, 于23小时前回复 总统选举投票，初步唱票记录：

['Jim', 'bush', 'Jim', 'Jim', 'Jim', 'bush', 'obama']
根据唱票记录统计每人的票数并按从多到少排序

&gt;&gt;&gt; l = ['Jim', 'bush', 'Jim', 'Jim', 'Jim', 'bush', 'obama']
&gt;&gt;&gt; sorted(set([(i, l.count(i)) for i in l]), key=lambda x:-x[1])
[('Jim', 4), ('bush', 2), ('obama', 1)]
clearJiang 16楼, 于23小时前回复 #15楼 @gaicitadie 不如直接用collections.Counter

gaicitadie 17楼, 于23小时前回复 #16楼 @clearJiang 低版本没有collections

daqing 18楼, 于23小时前回复 总统选举投票

l = ['Jim', 'bush', 'Jim', 'Jim', 'Jim', 'bush', 'obama']
l.uniq.collect { |x| [x, l.count(x)] }
=&gt; [["Jim", 4], ["bush", 2], ["obama", 1]]
skandhas 19楼, 于22小时前回复 #15楼 @gaicitadie
根据唱票记录统计每人的票数并按从多到少排序:

l = ['Jim', 'bush', 'Jim', 'Jim', 'Jim', 'bush', 'obama']
l.group_by{|i| i}.map{|k,v| [k,v.length] }
quakewang 20楼, 于22小时前回复 python要和ruby比 文件、字符操作或者数组、Hash操作的便利性绝对完败，要砸场还不如在性能上一棍子打死ruby。

bony 21楼, 于22小时前回复 这样的帖子应该多一点。长知识。@skandhas cool.

quakewang 22楼, 于22小时前回复 #15楼 @gaicitadie

['Jim', 'bush', 'Jim', 'Jim', 'Jim', 'bush', 'obama'].inject(Hash.new(0)) {|h, e| h[e] += 1; h}.sort_by{|e| -e[1]}
daqing 23楼, 于22小时前回复 说实话，Python的lambda匿名函数，跟Ruby的Block相比，从书写上就败了。

gaicitadie 24楼, 于22小时前回复 随机设置验证码的4个字符(不包括图片处理部分)

&gt;&gt;&gt; import random
&gt;&gt;&gt; s = 'ABCDEFGHIJKLMNPRSTUVWXYZ'
&gt;&gt;&gt; ''.join(random.sample((s),4))
'EXSG'
&gt;&gt;&gt; ''.join(random.sample((s),4))
'TGYN'
&gt;&gt;&gt; ''.join(random.sample((s),4))
'MEYP'
&gt;&gt;&gt; ''.join(random.sample((s),4))
'TGIF'
&gt;&gt;&gt; ''.join(random.sample((s),4))
'JDWF'
quakewang 25楼, 于22小时前回复 #24楼 @gaicitadie

('A'..'Z').to_a.sample(4).join
reus 26楼, 于22小时前回复 #15楼 @gaicitadie 你这个算法是O(n ^ 2)的，应该用reduce

def stat(acc, x):
  acc.setdefault(x, 0)
  acc[x] += 1
  return acc
sorted(reduce(stat,
  ['Jim', 'bush', 'Jim', 'Jim', 'Jim', 'bush', 'obama'], {}).iteritems(),
    key = lambda x: -x[1])
huyong36 27楼, 于22小时前回复 @skandhas cool,加上个排序。

gaicitadie 28楼, 于22小时前回复 #26楼 @reus reduce不如列表解析快，虽然list.count会重复统计

skandhas 29楼, 于22小时前回复 #27楼 @huyong36
对，是忘了排序

l = ['Jim', 'bush', 'Jim', 'Jim', 'Jim', 'bush', 'obama']
l.group_by{|i| i}.map{|k,v| [k,v.length] }.sort_by{|name,count| -count }
huacnlee 30楼, 于22小时前回复 风格不同而已，用起来都是一样方便。这个就是让我喜欢 Python 和 Ruby 的原因之一。

reus 31楼, 于22小时前回复 #28楼 @gaicitadie
就是慢在count调用上，for i in l遍历数组，且每个元素又再count遍历一次，O(n ^ 2)
reduce只需要遍历一次，O(n)
不信可以测试下

huyong36 32楼, 于22小时前回复 这帖应该是捧场帖,我喜欢这样的学习。

raecoo 33楼, 于22小时前回复 受用

hysios 34楼, 于21小时前回复 •字符串查找
# python
&gt;&gt;&gt; '11ab1111ab111ac11111'.count('ab')
2
# Ruby
ruby-1.9.2-p290 &gt;   '11ab111123ab111ac11111'.count 'ab', 'b'
2
hysios 35楼, 于21小时前回复 •奖牌排序
# python
&gt;&gt;&gt; sorted([('china',37,26,11), ('usa',30,22,50), ('russia',30,33,20)], key=lambda x:(-x[1],-x[2],-x[3]))
[('china', 37, 26, 11), ('russia', 30, 33, 20), ('usa', 30, 22, 50)]
# ruby
ruby-1.9.2-p290 &gt; [['china',37,26,11], ['usa',30,22,50],['russia',30,33,20]].sort_by {|name,j,y,t| [-j,-y,-t] }
 =&gt; [["china", 37, 26, 11], ["russia", 30, 33, 20], ["usa", 30, 22, 50]]
hysios 36楼, 于21小时前回复 •奖牌统计
# python
&gt;&gt;&gt; sorted([('china',37,26,11), ('usa',30,22,50), ('russia',30,33,20)], key=lambda x:-(x[1]+x[2]+x[3]))
[('usa', 30, 22, 50), ('russia', 30, 33, 20), ('china', 37, 26, 11)]
# ruby
ruby-1.9.2-p290 &gt; [['china',37,26,11], ['usa',30,22,50],['russia',30,33,20]].sort_by {|name,j,y,t| [-j + -y + -t] }
 =&gt; [["usa", 30, 22, 50], ["russia", 30, 33, 20], ["china", 37, 26, 11]]
kfll 37楼, 于21小时前回复 捧场..
js:

'11ab1111ab111ac11111'.match(/ab/g).length;
'11ab1111ab111ac11111'.split('ab').length - 1;
中式排名：

[[37, 26, 11], [30, 22, 50], [30, 33, 20]].sort().reverse();
hysios 38楼, 于21小时前回复 总统选举投票，初步唱票记录：

# ruby
&gt;&gt;&gt; l = ['Jim', 'bush', 'Jim', 'Jim', 'Jim', 'bush', 'obama']
&gt;&gt;&gt; sorted(set([(i, l.count(i)) for i in l]), key=lambda x:-x[1])
[('Jim', 4), ('bush', 2), ('obama', 1)]
# ruby
ruby-1.9.2-p290 &gt;  ['bush','Jim', 'bush', 'Jim', 'Jim', 'Jim', 'bush', 'obama'].each_with_object({}) {|name,s| s[name] = s.fetch(name,0) + 1 }.sort
 =&gt; [["Jim", 4], ["bush", 3], ["obama", 1]]
huyong36 39楼, 于21小时前回复 #34楼 @hysios

'11ab111123ab111ac11111'.count 'ab', 'b'
这样不对吧...这样只是找出来字符串里出现b的次数。

irb(main):106:0&gt; '11ab111123ab111ac11111b'.count 'ab', 'b'
=&gt; 3
hysios 40楼, 于21小时前回复 @huyong36 thx count是没办法实现的, 别的方法也不错

huyong36 41楼, 于20小时前回复 #40楼 @hysios 恩,请教

irb(main):115:0&gt; '11ab111123ab111c11111'.count  'a'
=&gt; 2
irb(main):114:0&gt; '11ab111123ab111c11111'.count  'ab'
=&gt; 4
字符可以统计,为什么字符串不能。。

jhjguxin 42楼, 于20小时前回复 @huyong36
count([other_str]+) → fixnum click to toggle source
Each other_str parameter defines a set of characters to count. The intersection of these sets defines the characters to count in str. Any other_str that starts with a caret (^) is negated. The sequence c1–c2 means all characters between c1 and c2.

Guest 43楼, 于20小时前回复 gaicitadie = [['china',37,26,11], ['usa',30,22,50], ['russia',30,33,20]].tap do |man|
  def man.make_self(&amp;process); process.call self; end
  def man.become_egghead
    `python -c "print( sorted([('china',37,26,11), ('usa',30,22,50), ('russia',30,33,20)], key=lambda x:(-x[1],-x[2],-x[3])) )"`
  end
  def man.glow_up
    dont_be_shy = true
    unless self.respond_to? :more_elegant, dont_be_shy
      def self.more_elegant
        self.sort_by { |country, glods, silvers, bronzes| [-glods,-silvers,-bronzes] }
      end
    end
    if self.respond_to? :become_egghead
      class &lt;&lt; self; remove_method :become_egghead; end
    end
    self
  end
end
gaicitadie.make_self &amp;:become_egghead
gaicitadie.glow_up.make_self &amp;:more_elegant
geekontheway 44楼, 于20小时前回复 #41楼 @huyong36 ruby的count 统计的是字符的数量 所以'11ab111123ab111c11111'.count 'ab'等同于'11ab111123ab111c11111'.count 'a' + '11ab111123ab111c11111'.count 'b'

jhjguxin 45楼, 于20小时前回复 简而言之就是 取每一个字符的count的交集

huyong36 46楼, 于20小时前回复 @geekontheway @jhjguxin 3Q...

hysios 47楼, 于20小时前回复 #41楼 @huyong36 count 是统计所有的字符,并不会把参数当成字符串处理

FenRagwort 48楼, 于17小时前回复 合并两个字典/哈希，重复的项目，两个值相加

hash1.merge(hash2) {|dupkey,val1,val2| val1 + val2 }
楼主来个Python的写法？

hhuai 49楼, 于16小时前回复 method_missing, 楼主来个？？

gaicitadie 50楼, 于14小时前回复 #48楼 @FenRagwort ，这个暂时只想到了普通方法

for k,v in hash2.items():
    if k in hash1:
        hash1[k] += v
    else:
        hash1.setdefault(k,v)
zw963 51楼, 于12小时前回复 #19楼 @skandhas

的确酷, 不说说实在的. group_by用来做这个, 真是有点大才小用了.

reus 52楼, 于12小时前回复 #49楼 @hhuai

class Foo:
  def __getattr__(self, name):
    def _foo(*arg, **kwargs):
      return self.method_missing(name, *arg, **kwargs)
    return _foo

  def method_missing(self, name, *args, **kwargs):
    print name, args, kwargs

a = Foo()
a.foo('bar', baz = 'baz')

&nbsp;

Francis.J(864248765)  13:19:50
&gt;&gt;&gt; l=['a','a','b','b','b','c','c']

&gt;&gt;&gt; sorted(set([i for i in l]))
['a', 'b', 'c']
Francis.J(864248765)  13:20:01
这样还行
Francis.J(864248765)  13:21:15
但是感觉 没有 pop 省资源
GG(75865965)  13:26:39
cat cat source.txt |uniq

</div>
</div>
