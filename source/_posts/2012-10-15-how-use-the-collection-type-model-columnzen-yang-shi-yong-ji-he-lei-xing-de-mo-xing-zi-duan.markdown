---
layout: post
title: "How use the collection type model column怎样使用集合类型的模型字段"
date: 2012-05-17 16:09
comments: true
categories: ["rails", "ruby"]
tags: ["collection", "column"]
---
## How use the collection type model column怎样使用集合类型的模型字段
For example you have bellow code in migrate folder

<code>      # 0: <20, 1: 20< <=25 , 2: 25< <=30, 3: 30< <=35, 4: 35< <=40, 5: 40<
    add_column :profiles, :agerange, :integer</code>

and then how to use it:

for model file:

<code>  # 0: <20, 1: 20< <=25 , 2: 25< <=30, 3: 30< <=35, 4: 35< <=40, 5: 40<
  A20     = 0
  A20_25  = 1
  A25_30  = 2
  A30_35  = 3
  A35_40  = 4
  A40     = 5

  AGERANGE = {
    A20        => "#{I18n.t("activerecord.attributes.profiles.agerange.A20")}",
    A20_25     => "#{I18n.t("activerecord.attributes.profiles.agerange.A20_25")}",
    A25_30     => "#{I18n.t("activerecord.attributes.profiles.agerange.A25_30")}",
    A30_35     => "#{I18n.t("activerecord.attributes.profiles.agerange.A30_35")}",
    A35_40     => "#{I18n.t("activerecord.attributes.profiles.agerange.A35_40")}",
    A40        => "#{I18n.t("activerecord.attributes.profiles.agerange.A40")}",
  }

  validates_inclusion_of :agerange, :in => AGERANGE.keys,
      :message => "{{value}} must be in #{AGERANGE.values.join ','}"

  # just a helper method for the view
  def age_range
    AGERANGE[agerange]
  end</code>
<pre>and then how use them in ‘form‘ and ’show‘ page</pre>
<pre>in form.html.erb</pre>

<code>
    <%= f.label :agerange, t("activerecord.attributes.profiles.agerange_label") %>
    <%= select_tag(:agerange, options_for_select(Profile::AGERANGE.invert)) %></code>
<pre>in show.html.erb</pre>
<pre><%= s.attribute :age_range %></pre>
