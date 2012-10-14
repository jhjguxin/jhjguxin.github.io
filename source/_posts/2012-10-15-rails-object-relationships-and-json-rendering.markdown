---
layout: post
title: "Rails Object Relationships and JSON Rendering"
date: 2012-04-03 22:46
comments: true
categories: ["rails", "ruby"]
tags: ["JSON Rendering", "Object", "rails", "Relationships"]
---
## Rails Object Relationships and JSON Rendering
<code>class ModelA &lt; ActiveRecord::Base
  belongs_to :ModelB</code>

  ...

class ModelB &lt; ActiveRecord::Base
  has_many :ModelA

When calling the show action of the ModelA controller the returned JSON should show all ObjectAs that are children of the ObjectB of which the ObjectA in question is a child of.

By default you'll only get the JSON that represents <code>modelb</code> in your example above. But, you can tell Rails to include the other related objects as well:

<code>def export
  @export_data = ModelA.find(params[:id])
  respond_to do |format|
    format.html
    format.json { render :json =&gt; @export_data.to_json(:include =&gt; :modelb) }
  end
end
</code>

You can even tell it to exclude certain fields if you don't want to see them in the export:

<code>render :json =&gt; @export_data.to_json(:include =&gt; { :modelb =&gt; { :except =&gt; [:created_at, updated_at]}})</code>

Or, include only certain fields:

<code>
render :json =&gt; @export_data.to_json(:include =&gt; { :modelb =&gt; { :only =&gt; :name }})
</code>

And you can nest those as deeply as you need (let's say that ModelB also has_many ModelC):

<code>
render :json =&gt; @export_data.to_json(:include =&gt; { :modelb =&gt; { :include =&gt; :modelc }})</code>
